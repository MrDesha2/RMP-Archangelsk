{
             Модуль BrigadeEdit
   Описание:
     Модуль формы редактирования элементов справочника "Бригады".
     Молуль вызывается из модуля EnumForm.

}

unit BrigadeEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, RXDBCtrl, Db, DBTables, EnumForm;

type
  TENUM_BRIGADEForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Code: TEdit;
    _Name: TEdit;
    Close_Buttom: TButton;
    OKButton: TButton;
    qQueryUpdate: TQuery;
    Label3: TLabel;
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
  ENUM_BRIGADEForm: TENUM_BRIGADEForm;
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
procedure TENUM_BRIGADEForm.OKButtonClick(Sender: TObject);
begin
  if EditType = 0 then // это добавление записи
  else
      qQueryupdate.ParamByName('ID').asinteger       := ID;

      qQueryupdate.ParamByName('Code').value    := Code.text;
      qQueryupdate.ParamByName('Name').value    := _Name.Text;

      // проверка данных
      if  (WRKRCombo.ID > 0) then
        SetParamCombo(qQueryupdate.ParamByName('id_WRKR'), WRKRCombo)
      else
        begin
          showmessage('Не заполнено поле "Бригадир".');
          exit;
        end;

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
procedure TENUM_BRIGADEForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

//
// Процедура закрытия формы
//
procedure TENUM_BRIGADEForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  visible := false;;
end;

//
//  Процедура при открытии формы
//
procedure TENUM_BRIGADEForm.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin


  ParentID := MainForm.ParentID;

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin

        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_brigade');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);


       _Name.text  := 'Новый элемент';
       Caption     := 'Новый элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_brigade');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_BRIGADE_GEN,1), :code, :name, :id_wrkr)');
       EditType := 0;

       WRKRCombo.ID := -1;

    end
  else {редактирование элемента}
    if mainForm.isFolder = 3 then
     begin
        // проверка на разрешение редактирования
        OkButton.Enabled := check_user_grand('SPR_BRIGADE', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_brigade');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       
       // заполнение информации по полям
       code.Text    := qQuery.fieldByName('Code').AsString;    //  Код
       _name.text   := qQuery.fieldByName('Name').AsString;    //  Наименование
       Id          := qQuery.fieldByName('ID').AsInteger;      // идентификатор

       // формирование текста запроса для обновления базы
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_brigade');
       qQueryUpdate.sql.add('set code = :code, name = :name , id_wrkr = :id_wrkr');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;   //режим редактирования - редактирование

       // заполнение поля "Бригадир"
       WRKRCombo.ID := qQuery.fieldByName('ID_wrkr').AsInteger;

       Caption := 'Элемент: ' + _name.text;

     end;

end;
//
//  Процедура выбора элемента справочника "Работник"
//
procedure TENUM_BRIGADEForm.WRKRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(WRKRCombo);

end;
{
   При редактировании поля "Работники" нажали кнопку клавы
}
procedure TENUM_BRIGADEForm.WRKRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WRKRCombo, key, Shift) = false then
     WRKRComboButtonClick(Sender);

end;

end.
