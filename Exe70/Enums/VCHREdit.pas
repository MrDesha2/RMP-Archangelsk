{
                 Модуль  VCHREdit
    Описание:
      Модуль формы редактирования элемента справочника "Виды характеристик"             

}
unit VCHREdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Mask, ToolEdit, RXDBCtrl, StdCtrls, EnumForm;

type
  TENUM_VCHRForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Code: TEdit;
    _Name: TEdit;
    Close_Buttom: TButton;
    OKButton: TButton;
    qQueryUpdate: TQuery;
    qQuery: TQuery;
    qEDIZQuery: TQuery;
    EDIZCombo: TComboEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure EDIZComboButtonClick(Sender: TObject);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_VCHRForm: TENUM_VCHRForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;

implementation

uses Main,
     Base,
     Libs;

{$R *.DFM}
//
//     Процедура закрытия формы редактирования элемента
//
procedure TENUM_VCHRForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
end;
//
//  Процедура открытия формы
//
procedure TENUM_VCHRForm.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin


  ParentID := MainForm.ParentID;

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin
        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_vchr');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);

       _Name.text  := 'Новый элемент';
       Caption     := 'Новый элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_vchr');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_EDIZ_GEN,1), :code, :name, :ed_izm)');
       EditType := 0;

       EDIZCombo.ID := -1;

    end
  else {редактирование элемента}
    if mainForm.isFolder = 3 then
     begin
       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand('SPR_VCHR', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_vchr');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.open;
       // заполнение информации по полям
       code.Text    := qQuery.fieldByName('Code').AsString;    //  Код
       _name.text   := qQuery.fieldByName('Name').AsString;    //  Наименование
       Id           := qQuery.fieldByName('ID').AsInteger;      // идентификатор

       // формирование текста запроса для обновления базы
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_vchr');
       qQueryUpdate.sql.add('set code = :code, name = :name , ed_izm = :ed_izm');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;   //режим редактирования - редактирование

       // заполнение поля "EDIZ"
       EDIZCombo.ID := qQuery.fieldByName('ED_IZM').AsInteger;

       Caption := 'Элемент: ' + _name.text;

     end;

end;

procedure TENUM_VCHRForm.OKButtonClick(Sender: TObject);
begin
  if EditType = 0 then // это добавление записи
  else
      qQueryupdate.ParamByName('ID').asinteger       := ID;

     if (ChechUniqueCode('spr_vchr', 'code', trim(Code.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;


      qQueryupdate.ParamByName('Code').value    := Code.text;
      qQueryupdate.ParamByName('Name').value    := _Name.Text;

      if  (EDIZCombo.ID > 0) then
        SetParamCombo(qQueryupdate.ParamByName('ED_IZM'), EDIZCombo)
      else
        begin
          showmessage('Не проставлена единица измерения!');
          exit;
        end;

   try
    data.RMPBase.StartTransaction;
      qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  ID := findIDbyCode('spr_vchr', trim(Code.text));
  MainForm.ID := ID;


  qquery.close;
  ModalResult := mrOK;
end;
//
//     Процедура закрытия формы редактирования элемента
//
procedure TENUM_VCHRForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
//
//  Процедура выбора элемента справочника "EDIZ"
//
procedure TENUM_VCHRForm.EDIZComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EDIZCombo);

end;
{
   При редактировании поля "Единица измерения" нажали кнопку клавы
}

procedure TENUM_VCHRForm.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EDIZCombo, key, Shift) = false then
     EDIZComboButtonClick(Sender);

end;

end.
