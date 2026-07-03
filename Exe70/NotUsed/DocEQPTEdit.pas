{

        Модуль   DocNMNTEdit
        формы редактирования интрумента складских документов:
          приход инструмента,
          списание инструмента,
          заказ инструмента.



}


unit DocEQPTEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, CurrEdit, ToolEdit,  PRDocEditForm, RSDocEditForm, Db, DBTables,
  ExtCtrls, OrderEditForm;

type

  TDOC_EQPT = class(TForm)
    qEQPTQuery: TQuery;
    qEDIZQuery: TQuery;
    PanelBot: TPanel;
    OKButton: TButton;
    CloseButton: TButton;
    PanelTop: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    EQPTCombo: TComboEdit;
    EDIZCombo: TComboEdit;
    NUMBER: TCurrencyEdit;
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDIZComboButtonClick(Sender: TObject);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OKButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure OnChange(Sender: TObject);
  private
    { Private declarations }
  public
    constructor createEQPT(aOwner : tForm; anewEQPT : pEQPT);
    destructor  Destroy; override;
  end;

var
  DOC_EQPT: TDOC_EQPT;
  FormType     : integer;   // тип редактирования формы: 1 - добавление, 2 - редактирование
  EnumEdit     : TForm;     // Форма списка справочника

  WasAnyChanges: boolean;   // признак изменения формы
  FormCaption  : string;    // Заголовок формы
  EnumName     : string;    // наименование справочника
  Doc_PrForm   : TDOC_PRForm;
  Doc_RsForm   : TDOC_RSForm;

  aEQPT        : pEQPT;
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
constructor TDOC_EQPT.createEQPT(aOwner : tForm; anewEQPT : pEQPT);
begin
  inherited Create(AOwner);

  WasAnyChanges  := false;

  aEQPT := aNewEQPT;

  Number.text   := formatfloat('0.000', aEQPT^.nValue);

  EQPTCombo.ID  := aEQPT^.ID_EQPT;
  EDIZCombo.ID  := aEQPT^.ID_EDIZ;


  if aEQPT^.ID_EQPT < 0 then
   begin

       // Единица измерения устанавливается по умолчанию
       EDIZCombo.ID := Param_Form.qEDIZQuery.Fields[0].asinteger;
       EQPTCombo.ID := -1;

       WasAnyChanges := true;
       FormCaption := 'новый';
       Number.Value := 0;

   end
  else
    begin
       FormCaption := aEQPT^.Name_EQPT;

       // заполнение поля "Единица измерения"
       EDIZCombo.ID := aEQPT^.ID_EdIz;

    end;

   EnumName    := 'Инструмент документа: ';


    EQPTCombo.ID  := aEQPT^.ID_EQPT;

   FormCaption    := EQPTCombo.text;

   caption := EnumName + FormCaption;
   Doc_RSForm := nil;


end;



destructor TDOC_EQPT.Destroy;
begin
  inherited;

end;
{
      Процедуры обработки справочников


 Процедура выбора из справочника Номенклатура
}
procedure TDOC_EQPT.EQPTComboButtonClick(Sender: TObject);
begin
  EQPTCombo.color := clWindow;

  SelectFromTable(EQPTCombo);

end;
{
  При нажатии кнопки на поле "Оборудование"
}
procedure TDOC_EQPT.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EQPTCombo.color := clWindow;

  if checkIfExistCode(EQPTCombo, key, Shift) = false then
    EQPTComboButtonClick(Sender);

end;
{

    Процедура выбора из справочника "Единицы измерения"
}
procedure TDOC_EQPT.EDIZComboButtonClick(Sender: TObject);
begin
  EDIZCombo.color := clWindow;

  SelectFromTable(EDIZCombo);

end;

procedure TDOC_EQPT.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EDIZCombo.color := clWindow;

  if checkIfExistCode(EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

end;
{
   Процедура принятия изменений при нажатии на кнопку ОК
}
procedure TDOC_EQPT.OKButtonClick(Sender: TObject);
begin

       // проверка на полноту ввода данных
       if (EQPTCombo.ID = -1) then
         begin
           showmessage('Не проставлен инструмент..');
           EQPTCombo.Color := clRed;
           exit;
         end;

       if (EDIZCombo.ID = -1) then
         begin
           showmessage('Не проставлена единица измерения..');
           EDIZCombo.color := clRed;
           exit;
         end;

   aEQPT^.ID_EQPT  := EQPTCombo.ID;
   aEQPT^.Name_EQPT:= EQPTCombo.Text;
   aEQPT^.ID_EdIz  := EDIZCombo.ID;
   aEQPT^.EDIZ_NAME:= EDIZCombo.TExt;
   aEQPT^.nValue   := Number.Value;

   ModalResult := mrOK;
end;
{
   Процедура закрытия формы.
   Отказ от принятия изменений и закрытие формы
}
procedure TDOC_EQPT.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
{
  Процедура при изменении значения

}
procedure TDOC_EQPT.OnChange(Sender: TObject);
var n, pr : real;
begin
  if trim(Number.text) <> '' then
    n        := strtofloat(trim(Number.text))
  else
    n := 0;

end;

end.
