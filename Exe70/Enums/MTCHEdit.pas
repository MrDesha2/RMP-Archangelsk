{
                  Модуль  MTCHEdit
   Описание: модуль формы редактирования элемента справочника
   "Материал операции чертежа".
   Форма вызывается из формы редактирования чертежа CHRTForm

}
unit MTCHEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Mask, ToolEdit, RXDBCtrl, EnumTreeForm, EnumForm,
  CurrEdit;

type
  TENUM_MTCHForm = class(TForm)
    Label3: TLabel;
    Label1: TLabel;
    qQueryUpdate: TQuery;
    qQuery: TQuery;
    qNMNTQuery: TQuery;
    Close_Buttom: TButton;
    OKButton: TButton;
    Label5: TLabel;
    Label2: TLabel;
    qEDIZQuery: TQuery;
    NMNTCombo: TComboEdit;
    EDIZCombo: TComboEdit;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    PriceEdit: TCurrencyEdit;
    Label9: TLabel;
    STRGCombo: TComboEdit;
    WeiEdit: TCurrencyEdit;
    qSTRGQuery: TQuery;
    ButtonRecalc: TButton;
    NumberEdit: TCurrencyEdit;
    HigEdit: TCurrencyEdit;
    WidEdit: TCurrencyEdit;
    LenEdit: TCurrencyEdit;
    procedure OKButtonClick(Sender: TObject);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure EDIZComboButtonClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure STRGComboButtonClick(Sender: TObject);
    procedure STRGComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonRecalcClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _ID, _OwnerID: integer;
               _TableName: string; generatorname: string; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_MTCHForm: TENUM_MTCHForm;
   FormType: integer;
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
 sQueryText: string;  // текст запроса заполнения

implementation

uses Base,
 CHRTEdit,
     Libs,
 EnumForm4Sel, ParamForm;

{$R *.DFM}
{
   Генератор формы
   Вход: компонент - владелец;
         _ID - ID записи при редактировании;
    _OwnerID - ID справочника-владельца (операции чертежа);
  _TableName - имя таблицы
generatorname- имя генератора
   _TypeEdit - тип редактирования 1 - добавление, 2 - редактирование.
}
constructor TENUM_MTCHForm.createN(AOwner: TComponent; _ID, _OwnerID: integer;
  _TableName, generatorname: string; _TypeEdit: integer);
begin
  inherited Create(AOwner);;

  ID := _Id;                // Идентификатор элемента для редактирования
  OwnerID := _ownerID;      // Идентификатор владельца
  // если это добавление элемента
  FormType := _typeEdit;

  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into ' + _tablename +
        ' values (GEN_ID(' + GeneratorName + ',1), :OwnerID, :ID_NMNT, :Number, :PRICE, :ID_EDIZ, ' +
        ' :HIGHT, :LENGHT, :WIDTH, :WEIGHT, :ID_strg)';
       NumberEdit.text := '1';
       PriceEdit.text  := '0';


       // Единица измерения проставляется по умолчанию
       EDIZCombo.ID := Param_Form.qEDIZQuery.Fields[0].asinteger;

       NMNTCombo.ID := -1;
       STRGCombo.ID  := -1;
       EDIZCombo.ID := -1;
    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin

       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand(uppercase(_tablename), 'U', true);

       sQueryText := 'update ' + _tablename +
        ' set id_NMNT = :id_NMNT, number = :number, price = :PRICE, ID_EDIZ = :ID_EDIZ, '+
        ' HIGHT = :HIGHT, LENGHT = :LENGHT, WIDTH = :WIDTH, WEIGHT = :WEIGHT, id_strg = :id_strg' +
        ' where id = :id';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from ' + _tablename);
       qQuery.sql.add('where ID = :ID');
       qQuery.ParamByName('ID').asinteger := _Id;
       qQuery.open;
       // заполнение полей
       // заполнение поля "Материал"
       NMNTCombo.ID := qQuery.fieldByName('ID_NMNT').AsInteger;
       // заполнение поля "Материал"
       EDIZCombo.ID := qQuery.fieldByName('ID_EDIZ').AsInteger;

       // заполнение прочих полей
       NumberEdit.text   := formatfloat('0.000', qQuery.FieldByName('Number').asfloat); // количество
       PriceEdit.text    := formatfloat('0.00', qQuery.FieldByName('Price').asfloat);  // цена
       // габариты
       HigEdit.text      := formatfloat('0.000', qQuery.FieldByName('Hight').asfloat);  // высота
       LenEdit.text      := formatfloat('0.000', qQuery.FieldByName('Lenght').asfloat); // длина
       WidEdit.text      := formatfloat('0.000', qQuery.FieldByName('Width').asfloat);  // ширина
       WeiEdit.text      := formatfloat('0.000', qQuery.FieldByName('Weight').asfloat); // вес

       // поле "Вид заготовки"
       STRGCombo.ID      := qQuery.fieldByName('ID_STRG').AsInteger;

    end;


end;

destructor TENUM_MTCHForm.Destroy;
begin
  inherited;

end;
//
//   Процедура сохранения изменений по нажатию "ОК"
//
procedure TENUM_MTCHForm.OKButtonClick(Sender: TObject);
begin
    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

  // если форма была для добавления
  if FormType = 1 then
    qQueryUpdate.ParamByName('ownerID').asinteger := ownerID
  else
    qQueryUpdate.ParamByName('ID').asinteger := ID;
  // заполнение свойства номенклатура
  if (NMNTCombo.ID > 0) then
    SetParamCombo(qQueryUpdate.ParamByName('ID_NMNT'), NMNTCombo)
  else
    begin
      MessageDlg('Материал не выбран...', mtError, [mbOK], 0);
      exit;
    end;

  // заполнение свойства единица измерения
  if EDIZCombo.ID > 0 then
      SetParamCombo(qQueryUpdate.ParamByName('ID_EDIZ'), EDIZCombo)
     else
      begin
         MessageDlg('Не выбрана единица измерения', mtWarning, [mbOK], 0);
         exit;
      end;

  // количество и цена
  if trim(NumberEdit.text) <> '' then
     qQueryUpdate.ParamByName('NUMBER').asfloat  := strtofloat(NumberEdit.text)
  else
     qQueryUpdate.ParamByName('NUMBER').asinteger  := 0;

  if PriceEdit.Value <> 0 then
    qQueryUpdate.ParamByName('Price').asfloat := PriceEdit.Value//strtofloat(trim(PriceEdit.text))
   else
      qQueryUpdate.ParamByName('Price').asfloat := 0;

  // характеристики
  // длина
  if LenEdit.value > 0 then
    qQueryUpdate.ParamByName('Lenght').value  := LenEdit.value
    else
      qQueryUpdate.ParamByName('Lenght').AsFloat  := 0;

  // ширина
  if WidEdit.value > 0 then
    qQueryUpdate.ParamByName('Width').value   := WidEdit.value
    else
      qQueryUpdate.ParamByName('Width').asfloat   := 0;

  // высота
  if HigEdit.value > 0 then
    qQueryUpdate.ParamByName('Hight').value   := HigEdit.value
    else
       qQueryUpdate.ParamByName('Hight').asfloat := 0;

  // вес
  if WeiEdit.value > 0 then
    qQueryUpdate.ParamByName('Weight').value  := WeiEdit.value
    else
      qQueryUpdate.ParamByName('Weight').asfloat  := 0;
       
  // поле "Вид заготовки"
  SetParamCombo(qQueryupdate.ParamByName('id_STRG'), STRGCombo);


  // выполнение запроса
  try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
  except
    MessageDlg('Ошибка при вводе данных!', mtWarning, [mbOK], 0);
    data.RMPBase.Rollback;
  end;

  ModalResult := mrOK;
end;
{
  Процедура выбора из справочника "Номенклатура"
}
procedure TENUM_MTCHForm.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(NMNTCombo);

  // заполнение единицы измерения из номенклатуры
  if (qNMNTQuery.Active) and (not qNMNTQuery.eof) then
      EDIZCombo.ID := qNMNTQuery.Fieldbyname('ID_EDIZ').asinteger;

end;
{
  Процедура выбора из справочника "Единицы измерения"
}
procedure TENUM_MTCHForm.EDIZComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EDIZCombo);

end;
// Нажатие кнопки  Close
procedure TENUM_MTCHForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
{
  При нажатии кнопки на поле "Номенклатура"
}
procedure TENUM_MTCHForm.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( NMNTCombo, key, Shift) = false then
    NMNTComboButtonClick(Sender)
   else
    begin
      // заполнение единицы измерения из номенклатуры
      if (qNMNTQuery.Active) and (not qNMNTQuery.eof) then
        EDIZCombo.ID := qNMNTQuery.Fieldbyname('ID_EDIZ').asinteger;

    end;
end;
{
  При нажатии кнопки на поле "Единица измерения"
}
procedure TENUM_MTCHForm.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

end;

{
    Процедура выбора значения из справочника "Виды заготовок"

}

procedure TENUM_MTCHForm.STRGComboButtonClick(Sender: TObject);
begin
  SelectFromTable(STRGCombo);


end;

procedure TENUM_MTCHForm.STRGComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( STRGCombo, key, Shift) = false then
     STRGComboButtonClick(Sender);


end;
{

      Процедура пересчета стоимости планового
      материала операции чертежа в зависимости
      от выбранной номенклатуры

}
procedure TENUM_MTCHForm.ButtonRecalcClick(Sender: TObject);
var qFindQuery : tQuery;
    fprice : real;
begin

  if qNMNTQuery.Active then
    begin
       qFindQuery := tQuery.create(self);
       with qFindQuery do

         begin
           databasename := data.RMPBase.DatabaseName;
           sql.add('select price from spr_nmnt');
           sql.add('where id = ' + qNMNTQuery.Fields[0].asstring);
           open;

           if not eof then
             begin
               fprice := qFindQuery.fields[0].asfloat;
               fprice := fprice * strtofloat(trim(numberedit.text));
               Priceedit.Text := floattostr(fprice);
             end;

         end;

    end;
end;

end.
