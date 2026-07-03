{

        Модуль   DocNMNTEdit
        формы редактирования номенклатуры складских документов:
          приход готовой продукции,
          расход готовой продукции,
          поступление материалов,
          отпуск материалов.



}


unit DocNMNTEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, CurrEdit, ToolEdit,  PRDocEditForm, RSDocEditForm, Db, DBTables,
  ExtCtrls;

type

  TDOC_NMNT = class(TForm)
    qNMNTQuery: TQuery;
    qEDIZQuery: TQuery;
    qORDERQuery: TQuery;
    PanelBot: TPanel;
    OKButton: TButton;
    CloseButton: TButton;
    PanelChrt: TPanel;
    GroupBox: TGroupBox;
    Label9: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    WeiEdit: TCurrencyEdit;
    HigEdit: TCurrencyEdit;
    LenEdit: TCurrencyEdit;
    WidEdit: TCurrencyEdit;
    PanelOrd: TPanel;
    LabelOrder: TLabel;
    NumDoc: TComboEdit;
    PanelTop: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    NMNTCombo: TComboEdit;
    EDIZCombo: TComboEdit;
    NUMBER: TCurrencyEdit;
    PRICE: TCurrencyEdit;
    NSUM: TCurrencyEdit;
    RecalcButton: TButton;
    LabelPDR: TLabel;
    PDRCombo: TComboEdit;
    qPDRQuery: TQuery;
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDIZComboButtonClick(Sender: TObject);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OKButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure OnChange(Sender: TObject);
    procedure NumDocButtonClick(Sender: TObject);
    procedure NumDocExit(Sender: TObject);
    procedure RecalcButtonClick(Sender: TObject);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    constructor createNMNT(aOwner : tForm; aMaterial : pNMNT);
    destructor  Destroy; override;
  end;

var
  DOC_NMNT: TDOC_NMNT;
  FormType     : integer;   // тип редактирования формы: 1 - добавление, 2 - редактирование
  EnumEdit     : TForm;     // Форма списка справочника

  WasAnyChanges: boolean;   // признак изменения формы
  FormCaption  : string;    // Заголовок формы
  EnumName     : string;    // наименование справочника
  Doc_PrForm   : TDOC_PRForm;
  Doc_RsForm   : TDOC_RSForm;

  aNMNT        : pNMNT;
implementation


uses Base,
     Libs,
     main,
     math, 
EnumForm4Sel,
  OrderEditLibs,
 JRORDERForm, ParamForm;     // форма журнала заказов

{$R *.DFM}
{
  Генератор создания формы редактирования операций заказа из документа "Приходная накладная"
  Вход:
    компонент-владелец формы;
    тип редактирования: 1 - добавление номенклатуры,
                        2 - редактирование номенклатуры,
}
constructor TDOC_NMNT.createNMNT(aOwner : tForm; aMaterial : pNMNT);
begin
  inherited Create(AOwner);

  aNMNT := aMaterial;

  WasAnyChanges  := false;

  Number.text   := formatfloat('0.000', aNMNT^.nValue);
  Price.text    := formatfloat('0.00', aNMNT^.Price);
  NSum.text     := formatfloat('0.00', aNMNT^.nCost);
  NMNTCombo.text:= aNMNT^.Name_matr;
  EDIZCombo.text:= aNMNT^.Name_EdIz;
  PDRCombo.Text := aNMNT^.Name_PDR;

  LenEdit.text  := formatfloat('0.000', aNMNT^.nLenght);
  HigEdit.text  := formatfloat('0.000', aNMNT^.nHeight);
  WidEdit.text  := formatfloat('0.000', aNMNT^.nWidth);
  WeiEdit.text  := formatfloat('0.000', aNMNT^.nWeight);

  if aMaterial^.Name_matr = '' then
   begin

       // Единица измерения устанавливается по умолчанию
       EDIZCombo.ID := Param_Form.qEDIZQuery.Fields[0].asinteger;
       NMNTCombo.ID := -1;

       WasAnyChanges := true;
       FormCaption := 'новый';
       Number.Value := 0;
   end
  else
    begin
       FormCaption := aNMNT^.Name_matr;

       // заполнение поля "Единица измерения"
       EDIZCombo.ID := aNMNT^.ID_EdIz;

    end;

   EnumName    := 'Материал документа: ';


    NMNTCombo.ID  := aNMNT^.ID_matr;

    // номер заказа
    if aNMNT^.NumDocOrd > 0 then
      NumDoc.text    := inttostr(aNMNT^.NumDocOrd)
    else
      NumDoc.text    := '';



    // Формирование запроса для нахождения ID заказа
        with  qORDERQuery do

         if trim(NumDoc.text) <> '' then
           begin
            close;
            ParamByName('ID').asinteger := aNMNT^.ID_ORDER;
            ParamByName('Number').asinteger := aNMNT^.NumDocOrd;
            open;

           end;

     PDRCombo.ID  := aNMNT^.ID_PDR;

   EnumName       := 'Материал операции: ';
   FormCaption    := NMNTCombo.text;

   caption := EnumName + FormCaption;
   Doc_RSForm := nil;


end;



destructor TDOC_NMNT.Destroy;
begin
  inherited;

end;
{
      Процедуры обработки справочников


 Процедура выбора из справочника Номенклатура
}
procedure TDOC_NMNT.NMNTComboButtonClick(Sender: TObject);
begin
  NMNTCombo.color := clWindow;

  SelectFromTable(NMNTCombo);

end;
{
  При нажатии кнопки на поле "Номенклатура"
}
procedure TDOC_NMNT.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  NMNTCombo.color := clWindow;

  if checkIfExistCode(NMNTCombo, key, Shift) = false then
    NMNTComboButtonClick(Sender);

end;
{

    Процедура выбора из справочника "Единицы измерения"
}
procedure TDOC_NMNT.EDIZComboButtonClick(Sender: TObject);
begin
  EDIZCombo.color := clWindow;

  SelectFromTable(EDIZCombo);

end;

procedure TDOC_NMNT.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EDIZCombo.color := clWindow;

  if checkIfExistCode(EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

end;
{
   Процедура принятия изменений при нажатии на кнопку ОК
}
procedure TDOC_NMNT.OKButtonClick(Sender: TObject);
begin

       // проверка на полноту ввода данных
       if (NMNTCombo.ID = -1) then
         begin
           showmessage('Не проставлена номенклатура..');
           NMNTCombo.Color := clRed;
           exit;
         end;

       if (EDIZCombo.ID = -1) then
         begin
           showmessage('Не проставлена единица измерения..');
           EDIZCombo.color := clRed;
           exit;
         end;

   aNMNT^.ID_matr  := qNMNTQuery.Fields[0].asinteger;
   aNMNT^.Name_matr:= qNMNTQuery.Fields[2].AsString;
   aNMNT^.ID_EdIz  := qEdizQuery.Fields[0].asinteger;
   aNMNT^.Name_EdIz:= qEdizQuery.Fields[1].AsString;
   aNMNT^.nValue   := Number.Value;
   aNMNT^.Price    := Price.value;
   aNMNT^.nCost    := NSum.value;

   aNMNT^.nLenght  := LenEdit.Value;
   aNMNT^.nHeight  := HigEdit.Value;
   aNMNT^.nWidth   := WidEdit.Value;
   aNMNT^.nWeight  := WeiEdit.Value;


   if qORDERQuery.active then
     begin
      aNMNT^.ID_ORDER := qORDERQuery.fields[0].asinteger;
      aNMNT^.NumDocOrd:= qORDERQuery.fields[1].asinteger;
     end
    else
      begin
       aNMNT^.ID_ORDER := -1;
       aNMNT^.NumDocOrd:= -1;
      end;

    if PDRCombo.ID > 0 then
      begin
        aNMNT^.ID_PDR   := PDRCombo.ID;
        aNMNT^.Name_PDR := PDRCombo.Text;

      end
    else
      begin
       aNMNT^.ID_PDR   := -1;
       aNMNT^.Name_PDR := '';

      end;

   // При позаказном учете видны поля заказа и МВЗ
   // Одновременно они пустыми быть не могут
   if (numDoc.Visible) and (PDRCombo.Visible) then
     if (not qORDERQuery.Active) and (not qPDRQuery.Active) then
       begin
           showmessage('Для позаказного учета необходимо указать номер заказа либо МВЗ..');
           exit;
       end;

    ModalResult := mrOK;
end;
{
   Процедура закрытия формы.
   Отказ от принятия изменений и закрытие формы
}
procedure TDOC_NMNT.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
{
  Процедура при изменении значения

}
procedure TDOC_NMNT.OnChange(Sender: TObject);
var n, pr : real;
begin
  if trim(Number.text) <> '' then
    n        := strtofloat(trim(Number.text))
  else
    n := 0;


  if trim(PRICE.text) <> '' then
    pr       := strtoFloat(trim(PRICE.text))
  else
    Pr := 0;

  n         := n * pr;
  NSUM.text := FormatFloat( '0.00', n);

end;

procedure TDOC_NMNT.NumDocButtonClick(Sender: TObject);

var JR_Form    : TJR_ORDERForm;

begin

  // создание и открытие формы журнала заказов
  JR_Form := TJR_ORDERForm.Create(self);
  JR_Form.FormStyle := fsNormal;
  JR_Form.hide;

  JR_Form.FormActivate(self, 2);

  if trim(NumDoc.text) <> '' then
    data.JROrderFormQuery.locate('Number',  strtoint(NumDoc.text), [loCaseInsensitive]);

  if JR_Form.showmodal = mrOK then

    NumDoc.text := inttostr(JR_Form.numdoc);

    //inttostr(data.JROrderFormQuery.FieldByName('Number').asinteger);

  qOrderQuery.close;
  qOrderQuery.ParamByName('ID').asinteger     := JR_Form.IDRec;
  qOrderQuery.ParamByName('Number').asinteger := -1;
  qOrderQuery.open;

  JR_Form.close;

  // Восстановление признака журнала заказов
  if mainform.JR_ORDER_Form_Main <> nil then
    mainform.JR_ORDER_Form_Main.TypeEdit := 1;


end;


procedure TDOC_NMNT.NumDocExit(Sender: TObject);
begin

   // формирование запроса на поиск заказа с заданным номером
  qOrderQuery.close;
  qOrderQuery.ParamByName('ID').asinteger     := -1;

  if trim(NumDoc.text) = '' then

    exit;


  if strlen(pchar(NumDoc.text)) > 10 then exit;

  qOrderQuery.ParamByName('Number').asinteger := strToInt(trim(NumDoc.text));
  qOrderQuery.open;


   // если заказ не найден, то ошибка
   if qOrderQuery.Eof then

     begin

        showmessage('Заказ с заданным номером не существует!');
        NumDoc.text := '';
        NumDoc.SetFocus;
     end
   else
    NumDoc.text := qOrderQuery.FieldByName('Number').asstring;


end;

procedure TDOC_NMNT.RecalcButtonClick(Sender: TObject);
var qFindQuery : tQuery; // временный запрос
          fSum : real;   // сумма
          fNum : real;   // количество
          fWeight : real;// вес
        fprice : real;   // цена
begin
  if numdoc.Text <> '' then
    begin

       fSum := Get_sum_order_by_calc(aNMNT^.ID_ORDER, -1);

       qFindQuery := tQuery.create(self);
       qFindQuery.DatabaseName := data.RMPBase.DatabaseName;
       qFindQuery.sql.add('select number_f, weight from dh_order where id ='
           + inttostr(aNMNT^.ID_ORDER));
       qFindQuery.open;

       if not qFindQuery.Eof then
         begin
           fNum      := qFindQuery.Fields[0].asfloat;
           fWeight   := qFindQuery.Fields[1].asfloat;
           NSum.Text := formatfloat('0.00',fsum);


            if fNum <> 0 then
             fPrice     := fsum / fNum
           else
             fPrice     := 0;

           Price.Text :=  formatfloat('0.00',fPrice);
           Number.Text:=  formatfloat('0.00',fNum);
           WeiEdit.Value := fWeight;

         end;  
    end;
end;

procedure TDOC_NMNT.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PDRCombo);

end;

procedure TDOC_NMNT.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PDRCombo, key, Shift) = false then
    PDRComboButtonClick(Sender);

end;

end.
