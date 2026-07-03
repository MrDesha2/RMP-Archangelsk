{
                  Модуль  EQCHEdit
   Описание: модуль формы редактирования элемента справочника
   "Инструмент операции чертежа".
   Форма вызывается из формы редактирования чертежа CHRTForm

}
unit EQCHEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Mask, ToolEdit, RXDBCtrl, EnumTreeForm, EnumForm,
  CurrEdit;

type
  TENUM_EQCHForm = class(TForm)
    Label3: TLabel;
    Label1: TLabel;
    qQueryUpdate: TQuery;
    qQuery: TQuery;
    qEQPTQuery: TQuery;
    Close_Buttom: TButton;
    OKButton: TButton;
    Label2: TLabel;
    qEDIZQuery: TQuery;
    EQPTCombo: TComboEdit;
    EDIZCombo: TComboEdit;
    NumberEdit: TCurrencyEdit;
    procedure OKButtonClick(Sender: TObject);
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure EDIZComboButtonClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _ID, _OwnerID: integer;
               _TableName: string; generatorname: string; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_EQCHForm: TENUM_EQCHForm;
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
constructor TENUM_EQCHForm.createN(AOwner: TComponent; _ID, _OwnerID: integer;
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
        ' values (GEN_ID(' + GeneratorName + ',1), :OwnerID, :ID_EQPT, :ID_EDIZ, :Number)';
       NumberEdit.text := '1';

       // Единица измерения проставляется по умолчанию
       EDIZCombo.ID := Param_Form.qEDIZQuery.Fields[0].asinteger;

       EQPTCombo.ID := -1;
       EDIZCombo.ID := -1;
    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin

       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand(uppercase(_tablename), 'U', true);

       sQueryText := 'update ' + _tablename +
        ' set id_eqpt = :id_eqpt, number = :number, ID_EDIZ = :ID_EDIZ '+
        ' where id = :id';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from ' + _tablename);
       qQuery.sql.add('where ID = :ID');
       qQuery.ParamByName('ID').asinteger := _Id;
       qQuery.open;
       // заполнение полей
       // заполнение поля "Материал"
       EQPTCombo.ID := qQuery.fieldByName('ID_EQPT').AsInteger;

       // заполнение поля "Материал"
       EDIZCombo.ID := qQuery.fieldByName('ID_EDIZ').AsInteger;

       // заполнение прочих полей
       NumberEdit.text   := formatfloat('0.000', qQuery.FieldByName('Number').asfloat); // количество

    end;


end;

destructor TENUM_EQCHForm.Destroy;
begin
  inherited;

end;
//
//   Процедура сохранения изменений по нажатию "ОК"
//
procedure TENUM_EQCHForm.OKButtonClick(Sender: TObject);
begin
    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

  // если форма была для добавления
  if FormType = 1 then
    qQueryUpdate.ParamByName('ownerID').asinteger := ownerID
  else
    qQueryUpdate.ParamByName('ID').asinteger := ID;

  // заполнение свойства оборудование
  if (EQPTCombo.ID > 0) then
    SetParamCombo(qQueryUpdate.ParamByName('ID_EQPT'), EQPTCombo)
  else
    begin
      MessageDlg('Инструмент не выбран...', mtError, [mbOK], 0);
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
procedure TENUM_EQCHForm.EQPTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EQPTCombo);

  // заполнение единицы измерения из номенклатуры
  if EQPTCombo.ID > 0 then
      EDIZCombo.ID := qEQPTQuery.Fieldbyname('ID_EDIZ').asinteger;

end;
{
  Процедура выбора из справочника "Единицы измерения"
}
procedure TENUM_EQCHForm.EDIZComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EDIZCombo);

end;
// Нажатие кнопки  Close
procedure TENUM_EQCHForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
{
  При нажатии кнопки на поле "Номенклатура"
}
procedure TENUM_EQCHForm.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EQPTCombo, key, Shift) = false then
    EQPTComboButtonClick(Sender)
   else
    begin
      // заполнение единицы измерения из номенклатуры
      if EQPTCombo.ID > 0 then
        EDIZCombo.ID := qEQPTQuery.Fieldbyname('ID_EDIZ').asinteger;

    end;
end;
{
  При нажатии кнопки на поле "Единица измерения"
}
procedure TENUM_EQCHForm.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

end;



end.
