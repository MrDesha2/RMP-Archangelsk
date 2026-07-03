unit ORTransportEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, CurrEdit, Mask, ToolEdit, ExtCtrls, OrderEditForm;

type
  TDOCT_TransportForm = class(TForm)
    PanelMain: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    EdizLabel: TLabel;
    EQPTCombo: TComboEdit;
    Number: TCurrencyEdit;
    EDIZCombo: TComboEdit;
    qEQPTQuery: TQuery;
    qEDIZQuery: TQuery;
    PanelButton: TPanel;
    CloseButton: TButton;
    OKButton: TButton;
    Cost: TCurrencyEdit;
    Label1: TLabel;
    NumberEdit: TMaskEdit;
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
    procedure EQPTComboButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    aOperate     : pOperation;// “ип записи операции
    constructor createN(Operation : pOperation; _TypeEdit: integer; Pos : integer);
    destructor  Destroy; override;
  end;

var
  DOCT_TransportForm: TDOCT_TransportForm;
  FormType     : integer;   // тип редактировани€ формы: 1 - добавление, 2 - редактирование
  EnumEdit     : TForm;     // ‘орма списка справочника

  WasAnyChanges: boolean;   // признак изменени€ формы
  FormCaption  : string;    // «аголовок формы
  EnumName     : string;    // наименование справочника
  aTransport   : pTransport;     // “ип записи оборудовани€
  lTransports  : tList;


implementation

uses Base,
     Libs,
EnumForm4Sel;

{$R *.dfm}

{
  √енератор создани€ формы редактировани€ операций заказа
  ¬ход:
    компонент-владелец формы;
    тип редактировани€: 1 - добавление плановой номенклатуры,
                        2 - редактирование существующей плановой номенклатуры,
                        3 - добавление фактической номенклатуры,
                        4 - редактирование существующей фактической номенклатуры,
}
constructor TDOCT_TransportForm.createN(Operation : pOperation; _TypeEdit: integer; Pos : integer);
begin
  inherited Create(application);

  // запомним в глобальных переменных формы, зачем мы сюда пришли
  FormType := _typeEdit;     // тип редактировани€ формы


  lTransports := Operation.lTransports;

  // навигаторы дл€ выбора номенклатуры
  EQPTCombo.clear;
  if (_TypeEdit = 1) or (_TypeEdit = 3) then
         begin
           new(aTransport);

           // нахождение максимального номера строки
           if lTransports <> nil then
             aTransport.lineno := lTransports.Count + 1
           else
             begin
               lTransports := tList.Create;
               aTransport.lineno := 1;
             end;

           aTransport.ID_EQPT   := 0;
           aTransport.Name_EQPT := '';
           aTransport.nValue    := 0;
           aTransport.ID_EDIZ   := 0;
           aTransport.EDIZ_NAME := '';
           aTransport.Cost      := 0;
           EQPTCombo.ID := -1;
           EDIZCombo.ID := -1;

           EnumName    := '“ранспортное средство операции: ';
           FormCaption := 'новое';

         end
   else
     // это редактирование плановых операций
     begin
          aTransport       := lTransports.Items[Pos];
          EnumName         := '“ранспортное средство операции: ';
          FormCaption      := EQPTCombo.text;

     end;


      // заполнение полей
      // заполнение пол€ "¬ид номенклатры"
      EQPTCombo.ID   := aTransport^.ID_EQPT;
      NumberEdit.text:= inttostr(aTransport^.lineno);
      NUmber.text    := formatfloat('0.00', aTransport^.nValue);
      EDIZCombo.ID   := aTransport^.ID_EDIZ;

     if (_TypeEdit = 1) or (_TypeEdit = 3) then
       wasanychanges := true
     else
       wasanychanges := false;

     caption := EnumName + FormCaption;

end;

destructor TDOCT_TransportForm.Destroy;
begin
  inherited;

end;

{
  ѕроцедура выбора из справочника "ќборудование"
}
procedure TDOCT_TransportForm.EQPTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EQPTCombo);
end;

{
    ѕроцедура нажати€ кнопки "«акрыть".
    «акрывает форму
}
procedure TDOCT_TransportForm.CloseButtonClick(Sender: TObject);
begin
 if WasAnyChanges = true then
   if MessageDlg('—охранить изменени€?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     OKButtonClick(sender);
  ModalResult := mrCancel;
end;

{
   ѕроцедура выполнени€ транзакции по изменению
   значени€ таблиц плановых и фактических материалов заказа
   по нажатию на кнопку ќ 
}
procedure TDOCT_TransportForm.OKButtonClick(Sender: TObject);
begin

    // проверка данных
    if EQPTCombo.ID < 0 then
       begin
         showmessage('Ќе проставлено транспортное средство...');
         exit;
       end;

    // установка значений в список
    aTransport^.lineno    := strtoint(trim(NumberEdit.text)); // номер по пор€дку
    aTransport^.Name_EQPT := EQPTCombo.text;                  // оборудование
    aTransport^.nValue    := Number.value;                    // количество
    aTransport^.ID_EQPT   := EQPTCombo.ID;                    // ID номенклатуры
    aTransport^.Cost      := Cost.Value;                      // ÷ена машино/часа

    aTransport^.EDIZ_NAME := EDIZCombo.Text;
    if EDIZCombo.ID > 0 then
       aTransport^.ID_EDIZ := EDIZCombo.ID
     else
       aTransport^.ID_EDIZ := 0;


    if (FormType = 1) or (FormType = 3) then
      begin
        aOperate.lTransports := lTransports;
        lTransports.add(aTransport);
      end;

    // закрываем форму редактировани€
    ModalResult := mrOK;

end;

procedure TDOCT_TransportForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 action := caFree;
end;

procedure TDOCT_TransportForm.EQPTComboChange(Sender: TObject);
var qFindQuery : tQuery;
begin
  WasChanges;
  qFindQuery := tQuery.create(self);
  // если номенклатура выбрана
  if not qEQPTQuery.eof then
    with qFindQuery do
      begin
        DatabaseName := data.RMPBase.DatabaseName;
        SQL.add('select a.id, b.cost from spr_ediz a, spr_eqpt b ');
        SQL.add('where a.id = b.id_ediz and ');
        SQL.add('      b.id = ' + qEQPTQuery.Fields[0].asstring);
        open;

        if not eof then
          begin
            EdizCombo.ID := Fields[0].asinteger;
          end;
        If FieldByName('cost').Value <> Null Then
            Cost.Text := FieldByName('cost').Value;
      end;
end;

{
  ѕроцедура показа изменений в форме
}
procedure  TDOCT_TransportForm.WasChanges;
begin
 WasAnyChanges := true;
 if EQPTCombo.text <> '' then
   FormCaption := EQPTCombo.text;

 caption := EnumName + FormCaption + ' *';
end;

{
  ѕри нажатии кнопки на поле "ќборудование"
}
procedure TDOCT_TransportForm.EQPTComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(EQPTCombo, key, Shift) = false then
    EQPTComboButtonClick(Sender);

end;

procedure TDOCT_TransportForm.EDIZComboButtonClick(Sender: TObject);
begin
  EDIZCombo.color := clWindow;

  SelectFromTable(EDIZCombo);

end;

procedure TDOCT_TransportForm.EDIZComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  EDIZCombo.color := clWindow;

  if checkIfExistCode(EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

end;


end.
