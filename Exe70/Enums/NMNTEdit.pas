unit NMNTEdit;

{

           Модуль NMNTEdit
   Описание: модуль формы работы с формой редактирования
      элемента справочника "Номенклатура"
   Вызывается из модуля EnumTreeEdit
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, ToolEdit, Db, DBTables, EnumTreeForm, RXDBCtrl,  EnumForm,
  CurrEdit;

type
  TENUM_NMNTForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Code: TEdit;
    _Name: TEdit;
    Close_Buttom: TButton;
    OKButton: TButton;
    qQueryUpdate: TQuery;
    CHRT_Name: TLabel;
    Group: TRadioGroup;
    Is_build: TRadioButton;
    Is_rep: TRadioButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label7: TLabel;
    qQuery: TQuery;
    qCHRTQuery: TQuery;
    qEQPTQuery: TQuery;
    qEDIZQuery: TQuery;
    qPlantQuery: TQuery;
    CHRTCombo: TComboEdit;
    EQPTCombo: TComboEdit;
    EDIZCombo: TComboEdit;
    PlantCombo: TComboEdit;
    Price: TCurrencyEdit;
    Label8: TLabel;
    PlotEdit: TCurrencyEdit;
    Label9: TLabel;
    Label10: TLabel;
    Min_size: TCurrencyEdit;
    Max_size: TCurrencyEdit;
    procedure Close_ButtomClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CHRTComboButtonClick(Sender: TObject);
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure EDIZComboButtonClick(Sender: TObject);
    procedure PlantComboButtonClick(Sender: TObject);
    procedure CHRTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PlantComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  ENUM_NMNTForm: TENUM_NMNTForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;
  EnumEdit : TForm;
  EnumTreeEdit: TLIST_TREEEDITForm;

implementation

uses Main,
     Base,
     Libs,
EnumForm4Sel;

{$R *.DFM}

procedure TENUM_NMNTForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
{
 Процедура нажания кнопки ОК
}
procedure TENUM_NMNTForm.OKButtonClick(Sender: TObject);
begin
  if EditType = 0 then // это добавление записи
      qQueryupdate.ParamByName('ParentID').asinteger := ParentID
  else
      qQueryupdate.ParamByName('ID').asinteger       := ID;

    // если под этим номером уже есть запись и их ID разные
   if (ChechUniqueCode('spr_nmnt', 'Code', trim(code.text),ID) > 0) then
    begin
      showmessage('Код не уникальный!');
      abort;

    end;

      qQueryupdate.ParamByName('Code').value    := Code.text;
      qQueryupdate.ParamByName('Name').value    := _Name.Text;
      // заполнение полей таблицы
        SetParamCombo(qQueryupdate.ParamByName('id_CHRT'), CHRTCombo);

        SetParamCombo(qQueryupdate.ParamByName('id_EQPT'), EQPTCombo);

      // единица измерения

      if EdizCombo.ID > 0 then
        SetParamCombo(qQueryupdate.ParamByName('id_EDIZ'), EDIZCombo)
       else
         begin
           MessageDlg('Единица измерения не указана.', mtError, [mbOK], 0);
           abort;
         end;



      // свойство завод
        SetParamCombo(qQueryupdate.ParamByName('id_plant'), PlantCombo);

      if  Price.Text <> '' then
        qQueryupdate.ParamByName('Price').asfloat := strtofloat(trim(Price.Text))
      else
        qQueryupdate.ParamByName('Price').value   := 0;

      if is_build.Checked then
        qQueryupdate.ParamByName('Vid_Nom').asinteger := 1
      else
        qQueryupdate.ParamByName('Vid_Nom').asinteger  := 0;

      qQueryupdate.ParamByName('PLOT').value := PLOTEdit.Value;

      qQueryupdate.ParamByName('Min_size').value := Min_size.Value;
      qQueryupdate.ParamByName('Max_size').value := Max_size.Value;

   try
      data.RMPBase.StartTransaction;
       qQueryupdate.ExecSQL;
      data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  ID := findIDbyCode('spr_nmnt', trim(Code.text));
  MainForm.ID := ID;

  qquery.close;
  ModalResult := mrOK;

end;

procedure TENUM_NMNTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;
{
  Процедура заполнения формы при открытии
}
procedure TENUM_NMNTForm.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin

  ParentID := MainForm.ParentID;
  // установка значений для связи данных
  ID := -1;



  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin
        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_nmnt');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);

       _Name.text := 'Новый элемент';
       Caption     := 'Справочник "Номенклатура": Новый элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_nmnt');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_NMNT_GEN,1), :parentID, 0, :code, :name,');
       qQueryUpdate.sql.add(' :id_chrt , :vid_nom, :ID_EQPT, :ID_EDIZ, :Price, :ID_PLANT, :PLOT, :min_size, :max_size)');
       EditType := 0;

       CHRTCombo.ID := -1;
       EQPTCombo.ID := -1;
       EDIZCombo.ID := -1;
       PlantCombo.ID := -1;


    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin
       Code.Text   := '';
       _Name.text  := 'Новая группа';
       Caption     := 'Справочник "Номенклатура": Новая группа';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_nmnt');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_NMNT_GEN,1), :parentID, 1, :code, :name, :id_chrt,');
       qQueryUpdate.sql.add(' :vid_nom, :ID_EQPT, :ID_EDIZ, :Price, :ID_PLANT, :PLOT, :min_size, :max_size)');
       EditType := 0;

       CHRTCombo.ID := -1;
       EQPTCombo.ID := -1;
       EDIZCombo.ID := -1;
       PlantCombo.ID := -1;


     end
   else {редактирование элемента}
    if mainForm.isFolder = 3 then
     begin
       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand('SPR_NMNT', 'U', true);


       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_nmnt');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       code.Text    := qQuery.fieldByName('Code').AsString;    //  Код
       _name.text   := qQuery.fieldByName('Name').AsString;    //  Наименование
       price.text   := qQuery.fieldByName('Price').AsString;   //  цена
       ParentID     := qQuery.fieldByName('ParentID').AsInteger;// родитель
       Id           := qQuery.fieldByName('ID').AsInteger;      // идентификатор
       PLOTEdit.Text := qQuery.fieldByName('PLOT').asstring;
       Min_size.text:= qQuery.fieldByName('Min_size').asstring;
       Max_size.text:= qQuery.fieldByName('Max_size').asstring;


       // формирование текста запроса для обновления базы
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_nmnt');
       qQueryUpdate.sql.add('set code = :code, name = :name , vid_nom = :vid_nom, id_chrt = :id_chrt,');
       qQueryUpdate.sql.add('id_eqpt = :ID_EQPT, ID_EDIZ = :ID_EDIZ, ');
       qQueryUpdate.sql.add('price =  :Price, ID_Plant = :ID_Plant, PLOT = :PLOT,');
       qQueryUpdate.sql.add('min_size = :min_size, max_size = :max_size');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;   //режим редактирования - редактирование

       // заполнение поля "Чертеж"
       CHRTCombo.ID := qQuery.fieldByName('ID_chrt').AsInteger;
       EQPTCombo.ID := qQuery.fieldByName('ID_eqpt').AsInteger;
       EDIZCombo.ID := qQuery.fieldByName('ID_ediz').AsInteger;
       PlantCombo.ID := qQuery.fieldByName('ID_PLANT').AsInteger;

       // заполнение флажка  "Вид номенклатуры"
       If qQuery.fieldByName('VID_NOM').AsInteger = 1 then
         begin
           Is_build.Checked := true;
           Is_rep.Checked := false;
         end
       else
         begin
           Is_rep.Checked := true;
           Is_build.Checked := false;
         end;

       Caption := 'Элемент: ' + _name.text;

     end;

end;
{
  Процедура выбора из справочника "Чертежи"
}
procedure TENUM_NMNTForm.CHRTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(CHRTCombo);

end;
{
  Процедура выбора из справочника "Оборудование"
}
procedure TENUM_NMNTForm.EQPTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EQPTCombo);

end;
{
  Процедура выбора из справочника "Единица измерения"
}
procedure TENUM_NMNTForm.EDIZComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EDIZCombo);

end;
{
  Процедура выбора из справочника "Заводы"
}
procedure TENUM_NMNTForm.PlantComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PlantCombo);

end;
{
  При нажатии кнопки на поле "Чертежи"
}
procedure TENUM_NMNTForm.CHRTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( CHRTCombo, key, Shift) = false then
    CHRTComboButtonClick(Sender);

end;
{
  При нажатии кнопки на поле "Единица измерения"
}
procedure TENUM_NMNTForm.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

end;
{
  При нажатии кнопки на поле "Оборудование"
}
procedure TENUM_NMNTForm.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EQPTCombo, key, Shift) = false then
    EQPTComboButtonClick(Sender);

end;
{
  При нажатии кнопки на поле "Заводы"
}
procedure TENUM_NMNTForm.PlantComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( PlantCombo, key, Shift) = false then
    PlantComboButtonClick(Sender);

end;

end.
