{
                      Модуль OPCHEdit.
  Описание:                    
  Модуль формы редактирования элемемнта справочника "Операции чертежа".
  Форма вызывается из формы редактирования элемента справочника "Чертеж".

}
unit OPCHEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RXSpin, StdCtrls, Db, DBTables, Mask, ToolEdit, RXDBCtrl, EnumTreeForm,
  CurrEdit;

type
  TENUM_OPCHForm = class(TForm)
    Label3: TLabel;
    Close_Buttom: TButton;
    OKButton: TButton;
    qQueryUpdate: TQuery;
    Label1: TLabel;
    NumberEdit: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RatingEdit: TRxSpinEdit;
    qQuery: TQuery;
    qVOPQuery: TQuery;
    VOPCombo: TComboEdit;
    PriceEdit: TCurrencyEdit;
    NTimeEdit: TCurrencyEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure VOPComboButtonClick(Sender: TObject);
    procedure VOPComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _ID, _OwnerID: integer;
               _TableName: string; generatorname: string; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_OPCHForm: TENUM_OPCHForm;
   FormType: integer;
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
 sQueryText: string;  // текст запроса заполнения

implementation

uses CHRTEdit,
         Base,
         Libs,
 EnumForm4Sel;

{$R *.DFM}

procedure TENUM_OPCHForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TENUM_OPCHForm.FormShow(Sender: TObject);
begin

end;
//
//   Процедура нажатия кнопки "ОК" - сохранения
//
procedure TENUM_OPCHForm.OKButtonClick(Sender: TObject);

var _time : real;

begin
    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

  // если форма была для добавления
  if FormType = 1 then
    qQueryUpdate.ParamByName('ownerID').asinteger := ownerID
  else
    qQueryUpdate.ParamByName('ID').asinteger := ID;


  // заполнение свойства вид оборудования
  if (VOPCombo.ID > 0) then
    SetParamCombo(qQueryUpdate.ParamByName('ID_VOP'), VOPCombo)
  else
    begin
      MessageDlg('Вид операции не выбран!', mtError, [mbOk], 0);
      abort;
    end;

  if trim(NumberEdit.text) <> '' then
     qQueryUpdate.ParamByName('NUMBER').value  := NumberEdit.text
  else
     qQueryUpdate.ParamByName('NUMBER').asinteger := 0;


  if trim(NTimeEdit.text) <> '' then
    begin
      _time := strToFloat(NTimeEdit.text);
      _time := _time * 1000;
      qQueryUpdate.ParamByName('Ntime').value   := _time;

    end
  else
    qQueryUpdate.ParamByName('Ntime').value   := 0;

  qQueryUpdate.ParamByName('Rating').value  := RatingEdit.text;

  if trim(PriceEdit.text) <> '' then
     qQueryUpdate.ParamByName('Price').asFloat := strToFloat(trim(PriceEdit.text))
  else
     qQueryUpdate.ParamByName('Price').value   := 0;

  // выполнение запроса
   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;


  ModalResult := mrOK;
end;

procedure TENUM_OPCHForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
//
//  Генератор создания формы редактирования элемента справочника "Операция чертежа"
//
constructor TENUM_OPCHForm.createN(AOwner: TComponent; _ID, _OwnerID: integer;
  _TableName, generatorname: string; _TypeEdit: integer);

var _Time : real;
    qTMPQuery : tQuery;
begin
  inherited Create(AOwner);;


  ID := _Id;                // Идентификатор элемента для редактирования
  OwnerID := _ownerID;      // Идентификатор владельца
  // если это добавление элемента
  FormType := _typeEdit;

  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into ' + _tablename +
        ' values (GEN_ID(' + GeneratorName + ',1), :OwnerID, :ID_VOP, :Number, :nTime, :Rating, :Price) ';
       NumberEdit.text := '1';
       NTimeEdit.text  := '0';
       RatingEdit.text := '1';
       PriceEdit.text  := '0';

       qTMPQuery := tQuery.Create(self);
       qTMpQuery.Databasename := 'RMP';
       qTMPQuery.sql.add('select max(number) from ' + _tableName + ' where id_chrt = ' + inttostr(_OwnerID));
       qTMPQuery.open;

       NumberEdit.text := inttostr(qTMPQuery.fields[0].asinteger + 1);
       // заполнение полей
       // заполнение поля "Вид характеристики"
       VOPCombo.ID := -1;


    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin

       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand(uppercase(_tablename), 'U', true);

       sQueryText := 'update ' + _tablename +
        ' set id_vop = :id_vop, number = :number, ntime = :ntime, ' +
        ' rating = :rating, price =  :price ' +
        ' where id = :id';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from ' + _tablename);
       qQuery.sql.add('where ID = :ID');
       qQuery.ParamByName('ID').asinteger := _Id;
       qQuery.open;
       // заполнение полей
       // заполнение поля "Вид характеристики"
       VOPCombo.ID := qQuery.fieldByName('ID_VOP').AsInteger;

       NumberEdit.text  := qQuery.FieldByName('Number').asstring;
       _time            := qQuery.FieldByName('NTime').asfloat;
       _time := _time / 1000;
       NTimeEdit.text   := floattostr(_time);
       ratingEdit.text  := qQuery.FieldByName('Rating').asstring;
       PriceEdit.text   := qQuery.FieldByName('Price').asstring;;

    end;

end;

destructor TENUM_OPCHForm.Destroy;
begin
  inherited;

end;
{
  Процедура выбора из справочника "Виды операций"
}
procedure TENUM_OPCHForm.VOPComboButtonClick(Sender: TObject);
begin
  SelectFromTable(VOPCombo);

end;
{
  При нажатии кнопки на поле "Виды операций "
}
procedure TENUM_OPCHForm.VOPComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( VOPCombo, key, Shift) = false then
    VOPComboButtonClick(Sender);

end;

end.
