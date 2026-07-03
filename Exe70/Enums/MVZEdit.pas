{
             Модуль  MVZEdit
   Описание:
    Модуль формы редактирования элемента справочника "МВЗ"
     они же "Подразделения".
   Форма вызывается из модуля EnumTreeEdit.


}
unit MVZEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, EnumTreeForm, Mask, ToolEdit, RXDBCtrl, EnumForm, strutils;

type
  TENUM_MVZForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Code: TEdit;
    _Name: TEdit;
    MaxTime: TEdit;
    Close_Buttom: TButton;
    OKButton: TButton;
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    Label4: TLabel;
    qVIDPDRQuery: TQuery;
    VIDPDR: TComboEdit;
    Label5: TLabel;
    ID_Stat: TComboEdit;
    qStatQuery: TQuery;
    procedure Close_ButtomClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure VIDPDRButtonClick(Sender: TObject);
    procedure VIDPDRKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ID_StatButtonClick(Sender: TObject);
    procedure ID_StatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    { Public declarations }
  end;

var
  ENUM_MVZForm: TENUM_MVZForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;

implementation
  uses base,
       Main,
       Libs,
EnumForm4Sel;
{$R *.DFM}

procedure TENUM_MVZForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

{Процедура сохранения элемента}
procedure TENUM_MVZForm.OKButtonClick(Sender: TObject);
begin
  if EditType = 0 then
    qQueryupdate.ParamByName('ParentID').asinteger := ParentID
  else
    qQueryUpdate.ParamByName('ID').value      := ID;


    if (ChechUniqueCode('spr_pdr', 'code', trim(Code.text), ID) > 0) then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;

  // заполнение параметров запроса
  qQueryupdate.ParamByName('Code').value    := Code.text;
  qQueryupdate.ParamByName('Name').value    := _Name.Text;

  if trim(MaxTime.text) <> '' then
    qQueryupdate.ParamByName('Maxtime').value:= MaxTime.text
  else
    qQueryupdate.ParamByName('Maxtime').asinteger := 0;

  // свойство завод
  SetParamCombo(qQueryupdate.ParamByName('id_VIDPDR'), VIDPDR);

  // свойство stat
  SetParamCombo(qQueryupdate.ParamByName('id_Stat'), ID_Stat);

   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  ID := findIDbyCode('spr_pdr', trim(Code.text));
  MainForm.ID := ID;


  ModalResult := mrOK;
end;

procedure TENUM_MVZForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TENUM_MVZForm.FormShow(Sender: TObject);
begin

  ParentID := MainForm.ParentID;

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin
       Code.Text   := '';
       _Name.text  := 'Новый элемент';
       Caption     := 'Новая элемент';
       MaxTime.Text:= '0';

       // нахождение максимального кода
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('select max(code) from spr_pdr');
       qQueryupdate.open;
       code.text   := leftstr(qQueryupdate.fields[0].asstring + '1', code.MaxLength);


       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_pdr');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_PDR_GEN,1), :parentID, 0, :name , :maxtime, :id_vidpdr, :code, :id_stat)');
       EditType := 0;

       VIDPDR.ID := -1;

       // заполнение поля "Статистика"
       ID_Stat.ID := -1;
    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin
       Code.Text   := '';
       _Name.text  := 'Новая группа';
       Caption     := 'Новая группа';
       MaxTime.Text:= '0';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_pdr');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_PDR_GEN,1), :parentID, 1, :name , :maxtime, :id_vidpdr, :code, :id_stat)');
       EditType := 0;

       VIDPDR.ID := -1;

       // заполнение поля "Статистика"
       ID_Stat.ID := -1;


     end
   else {редактирование элемента}
    if mainForm.isFolder = 3 then {Добавление новой группы}
     begin
       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand(uppercase('spr_pdr'), 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_pdr');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       code.Text   := qQuery.fieldByName('Code').AsString;
       _name.text  := qQuery.fieldByName('Name').AsString;
       maxtime.Text:= qQuery.fieldByName('Max_Time').AsString;
       ParentID    := qQuery.fieldByName('ParentID').AsInteger;
       Id          := qQuery.fieldByName('ID').AsInteger;

       // заполнение свойства "Вид подразделения"
       // заполнение поля "Единица измерения"
       VIDPDR.ID  := qQuery.fieldByName('ID_VIDPDR').AsInteger;

       // заполнение поля "Статистика"
       ID_Stat.ID := qQuery.fieldByName('ID_Stat').AsInteger;

       // формирование запроса для обновления
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_pdr');
       qQueryUpdate.SQL.add('set CODE = :code, NAME = :name , MAX_TIME = :maxtime, id_vidpdr = :id_VIDPDR, id_stat = :id_stat');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;
       Caption := 'Элемент: ' + _name.text;

     end;

end;
{
  Процедура выбора из справочника "Виды МВЗ"
}
procedure TENUM_MVZForm.VIDPDRButtonClick(Sender: TObject);
begin
  SelectFromTable(VIDPDR);

end;

procedure TENUM_MVZForm.VIDPDRKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(VIDPDR, key, Shift) = false then
    VIDPDRButtonClick(Sender);

end;
{
    Выбор из справочника "Статистика"

}
procedure TENUM_MVZForm.ID_StatButtonClick(Sender: TObject);
begin
  SelectFromTable(ID_Stat);


end;

procedure TENUM_MVZForm.ID_StatKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( ID_Stat, key, Shift) = false then
    ID_StatButtonClick(Sender);


end;

end.
