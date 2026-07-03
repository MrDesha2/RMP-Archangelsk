{
                           Модуль EnumPlanRelForm
   Описание:
     Модуль формы редактирования плановых справочников "Оборудование" для Работника
     "Операции" для работника и "Операции" для оборудования

}
unit EnumPlanRelForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, CurrEdit, Mask, ToolEdit, RXDBCtrl, DBTables, EnumForm;

type
  TENUM_PLANENUMRELForm = class(TForm)
    Close_Buttom: TButton;
    OK_Buttom: TButton;
    LabelPlan: TLabel;
    qVIDQuery: TQuery;
    VIDCombo: tMyComboEdit;
    Enum_label: TLabel;
    MainStorProc: TStoredProc;
    procedure OK_ButtomClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VIDComboButtonClick(Sender: TObject);
    procedure VIDComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private

  public
    sQueryText: string;  // текст запроса заполнения
    sPlanEnum : string;  // название справочника на русском
    EnumTableName : string; // подчиненный справочник
    sSumEnumQuery : string; // запрос подчиненного справочника
    constructor createN(AOwner: TComponent; _Id, _OwnerID, _ID_1: integer;
               _TableName, sSumEnumQuery: string; StorProc : tStoredProc);
    destructor  Destroy; override;
  end;

var
  ENUM_PLANENUMRELForm: TENUM_PLANENUMRELForm;
   FormType: integer; // тип редактирования формы: 1 - добавление, 2 - редактирование
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
    OldID  : integer; // Идентификатор операции до редактирования
 SourceName: integer;  // Признак формы, откуда вызывается данная форма: 1 - из чертежей, 2 - из оборудования
    _TypeEdit : integer;    // тип редактирования формы
   qEnumQuery : tQuery;     // запрос справочника формы

implementation

uses CHRTEdit,
         Base,
     EQPTEdit,
         Libs,
 EnumForm4Sel;

{$R *.DFM}

//
//  Процедура при открытии формы.
//  Выполняет заполнение формы
procedure TENUM_PLANENUMRELForm.FormShow(Sender: TObject);
begin
end;
//
//  Процедура сохранения изменений в форме
//  по нажатию "ОК"
procedure TENUM_PLANENUMRELForm.OK_ButtomClick(Sender: TObject);
begin
  try
    // начало транзакции
    data.RMPBase.StartTransaction;


    MainStorProc.Params[0].asinteger := ID;
    MainStorProc.Params[1].asinteger := OwnerID;

    // проверка
    if not (qVIDQuery.eof) and (qVIDQuery.Active) then
      MainStorProc.Params[2].asinteger  := qVIDQuery.fieldbyname('ID').asinteger
    else
      begin
        MessageDlg('Вид не указан...', mtError, [mbOK], 0);
        exit;
      end;


     MainStorProc.ExecProc;

      // конец транзакции
     data.RMPBase.Commit;

     if MainStorProc.ParamByName('res').asinteger < 0 then
      begin
       MessageDlg('Такая запись уже введена!', mtWarning, [mbOK], 0);
       ModalResult := mrCancel;
      end
    else
     ModalResult := mrOK;
  except
    Data.RMPBase.Rollback; {on failure, undo the changes};
    ModalResult  := mrCancel;
  raise; {raise the exception to prevent a call to CommitUpdates!}
  end;


end;

procedure TENUM_PLANENUMRELForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

destructor TENUM_PLANENUMRELForm.Destroy;
begin
  inherited;
//
end;

constructor TENUM_PLANENUMRELForm.createN(AOwner: TComponent; _Id, _OwnerID, _ID_1: integer;
  _TableName: string; sSumEnumQuery : string; StorProc : tStoredProc);


begin
  inherited Create(AOwner);    

  ID         := _Id;
  OwnerID    := _ownerID;      // Идентификатор владельца

  qVIDQuery.SQL.Text := sSumEnumQuery;

  if _ID = 0 then // добавление новой записи
    begin
       // заполнение полей
       qVIDQuery.ParamByName('CODE').asinteger:= -1;
       qVIDQuery.ParamByName('ID').asInteger  := -1;
       qVIDQuery.Open;
       OldID := -1;
    end

  else  // это редактирование элемента
    begin
       // проверка на разрешение редактирования
       OK_Buttom.Enabled := check_user_grand(uppercase(_tablename), 'U', true);

       // заполнение полей
       qVIDQuery.ParamByName('CODE').asinteger:= -1;
       qVIDQuery.ParamByName('ID').asInteger  := _ID_1;
       qVIDQuery.Open;
       OldID := _ID_1;

       VIDCombo.text := qVIDQuery.fieldByName('Name').AsString;

    end;

   MainStorProc := StorProc;

   
end;
//
//   Процедура выбора вида характеристики
//
procedure TENUM_PLANENUMRELForm.VIDComboButtonClick(Sender: TObject);
begin
  SelectFromTable(qVIDQuery, VIDCombo, EnumTableName,
                        sPlanEnum, 0);

end;
{
   При редактировании поля "Вид характеристики" нажали кнопку клавы
}
procedure TENUM_PLANENUMRELForm.VIDComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qVIDQuery, VIDCombo, key, Shift) = false then
     VIDComboButtonClick(Sender);
end;

end.
