{
    Модуль ORMTREditForm материалы заказа.
    Модуль вызывается только из документа "Заказ".
    Предназначен для редактирования как плановых так и
    фактических материалов заказа.
}
unit OREQPTEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolEdit, CurrEdit, Mask, StdCtrls, ExtCtrls, Db,
  DBTables, OrderEditForm, StrUtils;

type
  TDOCT_EQPTForm = class(TForm)
    PanelMain: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    PanelButton: TPanel;
    CloseButton: TButton;
    OKButton: TButton;
    qEQPTQuery: TQuery;
    EQPTCombo: TComboEdit;
    EdizLabel: TLabel;
    Number: TCurrencyEdit;
    EDIZCombo: TComboEdit;
    qEDIZQuery: TQuery;
    NumberEdit: TMaskEdit;
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EQPTComboChange(Sender: TObject);
    procedure WasChanges;
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDIZComboButtonClick(Sender: TObject);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    aOperate     : pOperation;// Тип записи операции
    constructor createN(Operation : pOperation; _TypeEdit: integer; Pos : integer);
    destructor  Destroy; override;
  end;

var
  DOCT_EQPTForm: TDOCT_EQPTForm;
  FormType     : integer;   // тип редактирования формы: 1 - добавление, 2 - редактирование
  EnumEdit     : TForm;     // Форма списка справочника

  WasAnyChanges: boolean;   // признак изменения формы
  FormCaption  : string;    // Заголовок формы
  EnumName     : string;    // наименование справочника
  aEQPT        : pEQPT;     // Тип записи оборудования
  lEQPTs       : tList;

implementation

uses Base,
     Libs,
EnumForm4Sel;

{$R *.DFM}


{
  Генератор создания формы редактирования операций заказа
  Вход:
    компонент-владелец формы;
    тип редактирования: 1 - добавление плановой номенклатуры,
                        2 - редактирование существующей плановой номенклатуры,
                        3 - добавление фактической номенклатуры,
                        4 - редактирование существующей фактической номенклатуры,
}
constructor TDOCT_EQPTForm.createN(Operation : pOperation; _TypeEdit: integer; Pos : integer);
begin
  inherited Create(application);

  // запомним в глобальных переменных формы, зачем мы сюда пришли
  FormType := _typeEdit;     // тип редактирования формы


  lEQPTs := Operation.lEQPTs;

  // навигаторы для выбора номенклатуры
  EQPTCombo.clear;
  if (_TypeEdit = 1) or (_TypeEdit = 3) then
         begin
           new(aEQPT);

           // нахождение максимального номера строки
           if lEQPTs <> nil then
             aEQPT.lineno := lEQPTs.Count + 1
           else
             begin
               lEQPTs := tList.Create;
               aEQPT.lineno := 1;
             end;

           aEQPT.ID_EQPT   := 0;
           aEQPT.Name_EQPT := '';
           aEQPT.nValue    := 0;
           aEQPT.ID_EDIZ   := 0;
           aEQPT.EDIZ_NAME := '';
           EQPTCombo.ID := -1;
           EDIZCombo.ID := -1;

           EnumName    := 'Инструмент операции: ';
           FormCaption := 'новый';

         end
   else
     // это редактирование плановых операций
     begin
          aEQPT            := lEQPTs.Items[Pos];
          EnumName         := 'Инструмент операции: ';
          FormCaption      := EQPTCombo.text;

     end;


      // заполнение полей
      // заполнение поля "Вид номенклатры"
      EQPTCombo.ID   := aEQPT^.ID_EQPT;
      NumberEdit.text:= inttostr(aEQPT^.lineno);
      NUmber.text    := formatfloat('0.000', aEQPT^.nValue);
      EDIZCombo.ID   := aEQPT^.ID_EDIZ;

     if (_TypeEdit = 1) or (_TypeEdit = 3) then
       wasanychanges := true
     else
       wasanychanges := false;

     caption := EnumName + FormCaption;

end;

destructor TDOCT_EQPTForm.Destroy;
begin
  inherited;

end;
{
  Процедура выбора из справочника "Оборудование"
}
procedure TDOCT_EQPTForm.EQPTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EQPTCombo);

end;
{
    Процедура нажатия кнопки "Закрыть".
    Закрывает форму
}
procedure TDOCT_EQPTForm.CloseButtonClick(Sender: TObject);
begin
 if WasAnyChanges = true then
   if MessageDlg('Сохранить изменения?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     OKButtonClick(sender);
  ModalResult := mrCancel;
end;

{
   Процедура выполнения транзакции по изменению
   значения таблиц плановых и фактических материалов заказа
   по нажатию на кнопку ОК
}

procedure TDOCT_EQPTForm.OKButtonClick(Sender: TObject);
begin

    // проверка данных
    if EQPTCombo.ID < 0 then
       begin
         showmessage('Не проставлен инструмент...');
         exit;
       end;

    // установка значений в список
    aEQPT^.lineno        := strtoint(trim(NumberEdit.text)); // номер по порядку
    aEQPT^.Name_EQPT     := EQPTCombo.text;                  // оборудование
    aEQPT^.nValue        := Number.value;                    // количество
    aEQPT^.ID_EQPT       := EQPTCombo.ID;                    // ID номенклатуры

    aEQPT^.EDIZ_NAME     := EDIZCombo.Text;
    if EDIZCombo.ID > 0 then
       aEQPT^.ID_EDIZ   := EDIZCombo.ID
     else
       aEQPT^.ID_EDIZ   := 0;


    if (FormType = 1) or (FormType = 3) then
      begin
        aOperate.lEQPTs := lEQPTs;
        lEQPTs.add(aEQPT);
      end;

    // закрываем форму редактирования
    ModalResult := mrOK;


end;

procedure TDOCT_EQPTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action := caFree;
end;

procedure TDOCT_EQPTForm.EQPTComboChange(Sender: TObject);
var qFindQuery : tQuery;
begin
  WasChanges;
  qFindQuery := tQuery.create(self);
  // если номенклатура выбрана
  if not qEQPTQuery.eof then
    with qFindQuery do
      begin
        DatabaseName := data.RMPBase.DatabaseName;
        SQL.add('select a.id from spr_ediz a, spr_eqpt b ');
        SQL.add('where a.id = b.id_ediz and ');
        SQL.add('      b.id = ' + qEQPTQuery.Fields[0].asstring);
        open;

        if not eof then
          begin
            EdizCombo.ID := Fields[0].asinteger;
          end;
      end;
end;

{
  Процедура показа изменений в форме
}
procedure  TDOCT_EQPTForm.WasChanges;
begin
 WasAnyChanges := true;
 if EQPTCombo.text <> '' then
   FormCaption := EQPTCombo.text;

 caption := EnumName + FormCaption + ' *';
end;
{
  При нажатии кнопки на поле "Оборудование"
}
procedure TDOCT_EQPTForm.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EQPTCombo, key, Shift) = false then
    EQPTComboButtonClick(Sender);

end;


procedure TDOCT_EQPTForm.EDIZComboButtonClick(Sender: TObject);
begin
  EDIZCombo.color := clWindow;

  SelectFromTable(EDIZCombo);

end;

procedure TDOCT_EQPTForm.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EDIZCombo.color := clWindow;

  if checkIfExistCode(EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

end;

end.
