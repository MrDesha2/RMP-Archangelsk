{


         Модуль формы редактирования элемента справочника
          квоты организаций.
         Вызывается из формы ENUM_CST при редактировании квот.

}


unit EnumQuotaEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, StdCtrls, ToolEdit, Db, DBTables;

type
  TENUM_QUOTACST = class(TForm)
    CSTName: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    OKButton: TButton;
    Cancel_Button: TButton;
    TPEQCombo: TComboEdit;
    NSizeEdit: TMaskEdit;
    qTPEQQuery: TQuery;
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    procedure OKButtonClick(Sender: TObject);
    procedure Cancel_ButtonClick(Sender: TObject);
    procedure TPEQComboButtonClick(Sender: TObject);
    procedure TPEQComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
      constructor createN(AOwner: TComponent; _ID, _TypeEdit, _id_tpeq: integer);
//      destructor  Destroy;
  end;

var
  ENUM_QUOTACST: TENUM_QUOTACST;
   FormType: integer;
         ID: integer; // Идентификатор элемента для редактирования
    ID_TPEQ: integer; // Идентификатор типа станков
 sQueryText: string;  // текст запроса заполнения
implementation

uses
    libs, Base;

{$R *.DFM}
{
     Конструктор формы редактирования элемента справочника "Квоты отборудования"
     Вход: форма - владелец,
           ID    - ID организации,
           TypeEdit - тип редактирования: 1 - добавление, 2 - редактирование.
           ID_TPEQ : ID типа станков

}
constructor TENUM_QUOTACST.createN(AOwner: TComponent; _ID, _TypeEdit, _ID_TPEQ: integer);
begin
  inherited Create(AOwner);;


  ID := _Id;                // Идентификатор элемента для редактирования
  ID_tpeq := _ID_TPEQ;
  // если это добавление элемента
  FormType := _typeEdit;

  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into quotacst values (:id_cst, :nsize, :id_tpeq) ';
       NSizeEdit.text  := '0';

       TPEQCombo.ID    := -1;
    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin
       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand(uppercase('quotacst'), 'U', true);


       sQueryText := 'update quotacst ' +
        ' set nsize = :nsize, id_tpeq = :id_tpeq ' +
        ' where id_cst = :id_cst and id_tpeq = :id_tpeq';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from quotaCst');
       qQuery.sql.add('where ID_CST = :ID and ID_TPEQ = :TPEQ');
       qQuery.ParamByName('ID').asinteger := _Id;
       qQuery.ParamByName('TPEQ').asinteger := _ID_TPEQ;
       qQuery.open;
       // заполнение полей
       // заполнение поля "Вид характеристики"
       TPEQCombo.ID  := qQuery.fieldByName('ID_TPEQ').AsInteger;
       //
       NSizeEdit.text := qQuery.FieldByName('NSize').asstring;

    end;

end;




{
   Процедура сохранения изменений

}
procedure TENUM_QUOTACST.OKButtonClick(Sender: TObject);
begin
  qQueryUpdate.Close;
  qQueryUpdate.SQL.clear;
  qQueryUpdate.SQL.add(sQueryText);

  // если форма была для добавления
  qQueryUpdate.ParamByName('ID_CST').asinteger  := ID;
  qQueryUpdate.ParamByName('ID_TPEQ').asinteger := id_tpeq;

  if trim(NSizeEdit.text) <> '' then
    qQueryUpdate.ParamByName('NSize').value  := NSizeEdit.text
  else
    qQueryUpdate.ParamByName('NSize').value  := 0;

    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;


  ModalResult := mrOK;


end;


{
    Процедура отмены изменений

}
procedure TENUM_QUOTACST.Cancel_ButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;

end;

procedure TENUM_QUOTACST.TPEQComboButtonClick(Sender: TObject);
begin
  SelectFromTable(TPEQCombo);

end;

procedure TENUM_QUOTACST.TPEQComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( TPEQCombo, key, Shift) = false then
    TPEQComboButtonClick(Sender);

end;

end.
