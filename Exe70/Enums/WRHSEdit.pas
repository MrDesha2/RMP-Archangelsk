{
             Модуль WRHSEdit
   Описание:
     Модуль формы редактирования элементов справочника "Склады".
     Молуль вызывается из модуля EnumForm.

}

unit WRHSEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, RXDBCtrl, Db, DBTables, EnumForm;

type
  TENUM_WRHSForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Code: TEdit;
    _Name: TEdit;
    Close_Buttom: TButton;
    OKButton: TButton;
    qQueryUpdate: TQuery;
    Label3: TLabel;
    Is_Intr: TCheckBox;
    qWRKRQuery: TQuery;
    WRKRCombo: TComboEdit;
    qQuery: TQuery;
    procedure OKButtonClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure WRKRComboButtonClick(Sender: TObject);
    procedure WRKRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_WRHSForm: TENUM_WRHSForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;
  EnumEdit : TForm;

implementation

uses Main,
     Base,
     Libs,
EnumForm4Sel;

{$R *.DFM}
//
//  Процедура выполнения транзакции по справочной таблице
//
procedure TENUM_WRHSForm.OKButtonClick(Sender: TObject);
begin
  if EditType =0  then // это добавление записи
   qQueryupdate.ParamByName('ParentID').asinteger := ParentID
  else
      qQueryupdate.ParamByName('ID').asinteger       := ID;



      qQueryupdate.ParamByName('Code').value    := Code.text;
      qQueryupdate.ParamByName('Name').value    := _Name.Text;

      // проверка данных
      if  (WRKRCombo.ID > 0) then
        SetParamCombo(qQueryupdate.ParamByName('id_WRKR'), WRKRCombo)
      else
        begin
          showmessage('Не заполнено поле "МОЛ".');
          exit;
        end;

      if is_intr.Checked then
        qQueryupdate.ParamByName('is_intr').asinteger := 1
      else
        qQueryupdate.ParamByName('is_intr').asinteger := 0;

      // выполнение запроса

    if (ChechUniqueCode('spr_wrhs', 'code', trim(Code.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;

   try   
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  MainForm.ID := findIDbyCode('spr_wrhs', trim(code.text));

  qquery.close;
  ModalResult := mrOK;

end;

//
//     Процедура закрытия формы редактирования элемента
//
procedure TENUM_WRHSForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

//
// Процедура закрытия формы
//
procedure TENUM_WRHSForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  visible := false;;
end;

//
//  Процедура при открытии формы
//
procedure TENUM_WRHSForm.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin


  ParentID := MainForm.ParentID;

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin

        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_wrhs');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);


       _Name.text  := 'Новый элемент';
       Caption     := 'Новый элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_wrhs');
       qQueryupdate.SQL.add('(id, parentid, isfolder, code, name, is_intr, id_wrkr)');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_WRHS_GEN,1), :parentid, 0, :code, :name, :is_intr, :id_wrkr)');
       EditType := 0;

       WRKRCombo.ID  := -1;

    end;
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin

        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_wrhs');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);


       _Name.text  := 'Новая группа';
       Caption     := 'Новая группа';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_wrhs');
       qQueryupdate.SQL.add('(id, parentid, isfolder, code, name, is_intr, id_wrkr)');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_WRHS_GEN,1), :parentid, 1, :code, :name, :is_intr, :id_wrkr)');
       EditType := 0;

       WRKRCombo.ID  := -1;

     end;


   {редактирование элемента}
   if mainForm.isFolder = 3 then
     begin
        // проверка на разрешение редактирования
        OkButton.Enabled := check_user_grand('SPR_WRHS', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_wrhs');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       
       // заполнение информации по полям
       code.Text    := qQuery.fieldByName('Code').AsString;    //  Код
       _name.text   := qQuery.fieldByName('Name').AsString;    //  Наименование
       Id          := qQuery.fieldByName('ID').AsInteger;      // идентификатор

       // формирование текста запроса для обновления базы
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_wrhs');
       qQueryUpdate.sql.add('set code = :code, name = :name , id_wrkr = :id_wrkr, is_intr = :is_intr');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;   //режим редактирования - редактирование

       // заполнение поля "МОЛ"
       WRKRCombo.ID  := qQuery.fieldByName('ID_wrkr').AsInteger;

       // заполнение флажка  "Внутренний"
       If qQuery.fieldByName('is_intr').AsInteger = 1 then
         Is_intr.Checked := true
       else
         Is_intr.Checked := false;

       Caption := 'Элемент: ' + _name.text;

     end;

end;
//
//  Процедура выбора элемента справочника "Работник"
//
procedure TENUM_WRHSForm.WRKRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(WRKRCombo);

end;
{
   При редактировании поля "Работники" нажали кнопку клавы
}
procedure TENUM_WRHSForm.WRKRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( WRKRCombo, key, Shift) = false then
     WRKRComboButtonClick(Sender);

end;

end.
