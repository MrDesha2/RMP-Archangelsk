{
        Модуль   VOPEdit
  Описание:
    редактирование элемента справочника "Виды операций"
  Вызывается из модуля EnumForm

}
unit VOPEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Mask, ToolEdit, RXDBCtrl, EnumForm, CurrEdit;

type
  TENUM_VOPForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Code: TEdit;
    _Name: TEdit;
    Close_Buttom: TButton;
    OKButton: TButton;
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    Label3: TLabel;
    qTPEQQuery: TQuery;
    TPEQcombo: TComboEdit;
    Label4: TLabel;
    PDRCombo: TComboEdit;
    qPDRQuery: TQuery;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Rank_1: TCurrencyEdit;
    Rank_2: TCurrencyEdit;
    Rank_3: TCurrencyEdit;
    Rank_4: TCurrencyEdit;
    Rank_5: TCurrencyEdit;
    Rank_6: TCurrencyEdit;
    procedure OKButtonClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TPEQcomboButtonClick(Sender: TObject);
    procedure TPEQcomboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_VOPForm: TENUM_VOPForm;
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
// Процедура нажатия кнопки "ОК"
// Описание:
//   При нажатии кнопки производится транзакция в таблицу
procedure TENUM_VOPForm.OKButtonClick(Sender: TObject);

var val : real;

begin
  // заполнение параметров запроса
  if EditType = 0 then
      qQueryupdate.ParamByName('ParentID').asinteger := ParentID
  else
     qQueryUpdate.ParamByName('ID').asinteger  := ID;

    if (ChechUniqueCode('spr_vop', 'code', trim(Code.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        exit;
      end;

  // код и наименование
  qQueryupdate.ParamByName('Code').value    := Code.text;
  qQueryupdate.ParamByName('Name').value    := _Name.Text;

  // элемент "Тип оборудования"
  if  (TPEQCombo.ID > 0) then
     SetParamCombo(qQueryupdate.ParamByName('id_tpeq'), TPEQCombo)
  else
    begin

        showmessage('Не указан Тип оборудования!');
        abort;

    end;

  // элемент "MVZ"
  SetParamCombo(qQueryupdate.ParamByName('id_pdr'), PDRCombo);

  // данные по оплате
  if rank_1.text <> '' then
    val := strtofloat(rank_1.text) * 100
  else
    val := 0;
  qQueryupdate.ParamByName('rank_1').value := val;

  if rank_2.text <> '' then
    val := strtofloat(rank_2.text) * 100
  else
    val := 0;
  qQueryupdate.ParamByName('rank_2').value := val;

  if rank_3.text <> '' then
    val := strtofloat(rank_3.text) * 100
  else
    val := 0;
  qQueryupdate.ParamByName('rank_3').value := val;


  if rank_4.text <> '' then
    val := strtofloat(rank_4.text) * 100
  else
    val := 0;
  qQueryupdate.ParamByName('rank_4').value := val;

  if rank_5.text <> '' then
    val := strtofloat(rank_5.text) * 100
  else
    val := 0;
  qQueryupdate.ParamByName('rank_5').value := val;

  if rank_6.text <> '' then
    val := strtofloat(rank_6.text) * 100
  else
    val := 0;
  qQueryupdate.ParamByName('rank_6').value := val;



  // выполнение запроса
   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  ID := findIDbyCode('spr_vop', trim(Code.text));
  MainForm.ID := ID;


  qquery.close;
  ModalResult := mrOK;
end;

//
//  Процедура нажатия кнопки "Close"
//
procedure TENUM_VOPForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TENUM_VOPForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;
//
// Процедура при открытии формы
//
procedure TENUM_VOPForm.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin


  ParentID := MainForm.ParentID;
  // установка значений для связи данных

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin
        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_vop');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);


       _Name.text := 'Новый элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_vop');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_VOP_GEN,1), :parentID, 0, :code, ' +
         ' :name, :id_tpeq, :ID_PDR, :rank_1, :rank_2, :rank_3,  :rank_4,  :rank_5,  :rank_6)');
       Caption := 'Новый элемент';
       EditType := 0;

       PDRCombo.ID  := -1;
       TPEQCombo.ID := -1;

       ID := -1;

    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin

        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_vop');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);

       _Name.text  := 'Новая группа';
       Caption     := 'Новая группа';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_vop');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_PDR_GEN,1), :parentID, 1, :code, ' +
          ' :name, :id_tpeq, :ID_PDR, :rank_1, :rank_2, :rank_3,  :rank_4,  :rank_5,  :rank_6)');
       EditType := 0;

       PDRCombo.ID  := -1;
       TPEQCombo.ID := -1;

       ID := -1;
       
     end
   else {редактирование элемента}
    if mainForm.isFolder = 3 then {Добавление новой группы}
     begin
       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand('SPR_VOP', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_vop');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       code.Text   := qQuery.fieldByName('Code').AsString;
       _name.text  := qQuery.fieldByName('Name').AsString;

       // заполнение поля "TPEQ"
       TPEQCombo.ID := qQuery.fieldByName('id_tpeq').AsInteger;

       ParentID    := qQuery.fieldByName('ParentID').AsInteger;
       Id          := qQuery.fieldByName('ID').AsInteger;

       // разряды
       rank_1.text := floattostr(qQuery.fieldByName('rank_1').AsInteger / 100);
       rank_2.text := floattostr(qQuery.fieldByName('rank_2').AsInteger / 100);
       rank_3.text := floattostr(qQuery.fieldByName('rank_3').AsInteger / 100);
       rank_4.text := floattostr(qQuery.fieldByName('rank_4').AsInteger / 100);
       rank_5.text := floattostr(qQuery.fieldByName('rank_5').AsInteger / 100);
       rank_6.text := floattostr(qQuery.fieldByName('rank_6').AsInteger / 100);

       // вид МВЗ
       PDRCombo.ID  := qQuery.fieldByName('ID_PDR').AsInteger;

       // запрос для выполнения транзакции
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_vop');
       qQueryUpdate.SQL.add('set CODE = :code, NAME = :name, id_tpeq = :id_tpeq, id_pdr = :id_pdr, ');
       qQueryUpdate.SQL.add('rank_1 =:rank_1, rank_2 = :rank_2, rank_3 =:rank_3, '
        + ' rank_4 = :rank_4, rank_5 = :rank_5, rank_6 = :rank_6');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;
       Caption := 'Элемент: ' + _name.text;
     end;

end;
//
//  Процедура выбора элемента справочника "TPEQ"
//
procedure TENUM_VOPForm.TPEQcomboButtonClick(Sender: TObject);
begin
  SelectFromTable(TPEQCombo);

end;
{
   При редактировании поля "Типы станков" нажали кнопку клавы
}
procedure TENUM_VOPForm.TPEQcomboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( TPEQCombo, key, Shift) = false then
     TPEQComboButtonClick(Sender);

end;


{
   Процедура выбора значения из справочника "МВЗ"

}
procedure TENUM_VOPForm.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PDRCombo);


end;

procedure TENUM_VOPForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);


end;

end.
