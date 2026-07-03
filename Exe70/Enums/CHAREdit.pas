{
                           Модуль CHAREdit
   Описание:
     Модуль формы редактирования характеристик оборудования или чертежа.
   Форма вызывается из формы редактирования элементов справочников:
      - чертежи;
      - оборудование.

}
unit CHAREdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, CurrEdit, Mask, ToolEdit, RXDBCtrl, DBTables, EnumForm;

type
  TENUM_CHEQForm = class(TForm)
    Close_Buttom: TButton;
    OK_Buttom: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qQueryUpdate: TQuery;
    qQuery: TQuery;
    NSizeEdit: TRxCalcEdit;
    KindEdit: TEdit;
    qVIDQuery: TQuery;
    VIDCombo: TComboEdit;
    qCheckQuery: TQuery;
    procedure OK_ButtomClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VIDComboButtonClick(Sender: TObject);
    procedure VIDComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _ID, _OwnerID: integer;
               _TableName: string; generatorname: string; _TypeEdit: integer; _SourceName: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_CHEQForm: TENUM_CHEQForm;
   FormType: integer; // тип редактирования формы: 1 - добавление, 2 - редактирование
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
 sQueryText: string;  // текст запроса заполнения
 SourceName: integer;  // Признак формы, откуда вызывается данная форма: 1 - из чертежей, 2 - из оборудования

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
procedure TENUM_CHEQForm.FormShow(Sender: TObject);
begin
end;
//
//  Процедура сохранения изменений в форме
//  по нажатию "ОК"
procedure TENUM_CHEQForm.OK_ButtomClick(Sender: TObject);
begin
    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

  with qCheckQuery do
    begin
      close;
      params[0].AsInteger := VIDCombo.ID;
      params[1].AsInteger := ownerID;
      params[2].AsInteger := ID;
      open;
    end;
   if not qCheckQuery.Eof then
     begin
        MessageDlg('Характеристика уже существует.', mtWarning, [mbOK], 0);
        exit;
     end;



  // если форма была для добавления
  if FormType = 1 then
    qQueryUpdate.ParamByName('ownerID').asinteger := ownerID
  else
    qQueryUpdate.ParamByName('ID').asinteger := ID;

  // проверка
  if (VIDCombo.ID > 0) then
    SetParamCombo(qQueryUpdate.ParamByName('ID_VID'), VIDCombo)
  else
    begin
      MessageDlg('Вид не указан...', mtError, [mbOK], 0);
      exit;
    end;

  if trim(NSizeEdit.text) <> '' then
    qQueryUpdate.ParamByName('NSIZE').asfloat    := strtofloat(trim(NSizeEdit.text))
  else
    qQueryUpdate.ParamByName('NSIZE').asinteger  := 0;

  qQueryUpdate.ParamByName('kind').value       := KindEdit.text;

  try
    data.RMPBase.StartTransaction;
    qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  ModalResult := mrOK;
end;

procedure TENUM_CHEQForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

destructor TENUM_CHEQForm.Destroy;
begin
  inherited;
//
end;

constructor TENUM_CHEQForm.createN(AOwner: TComponent; _ID, _OwnerID: integer;
  _TableName: string; generatorname: string; _TypeEdit: integer; _SourceName: integer);
var
  fieldname : string;
begin
  inherited Create(AOwner);


  ID := _Id;                // Идентификатор элемента для редактирования
  OwnerID := _ownerID;      // Идентификатор владельца
  // если это добавление элемента
  FormType := _typeEdit;
  SourceName := _SourceName;

  qCheckQuery.SQL.Clear;
  qCheckQuery.SQL.add('select * from ' + _tablename + ' where id = -1');
  qCheckQuery.open;
  fieldname := qCheckQuery.FieldDefList.Strings[1];
  qCheckQuery.SQL.Clear;
  qCheckQuery.SQL.add('select id from ' + _tablename + ' where id_vid = :id_vid and ' + fieldname + ' = :OwnerID and id <> :id');


  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into ' + _tablename +
        ' values (GEN_ID(' + GeneratorName + ',1), :OwnerID, :ID_vid, :Nsize, :kind) ';
       NSizeEdit.text := '0';
       KindEdit.text  := '';
       Caption := 'Справочник "Характеристики". Новый элемент';
       VIDCombo.ID := -1;
    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin
       // проверка на разрешение редактирования
       OK_Buttom.Enabled := check_user_grand(uppercase(_tablename), 'U', true);

       sQueryText := 'update ' + _tablename +
        ' set id_vid = :id_vid, nsize = :nsize, kind = :kind ' +
        ' where id = :id';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from ' + _tablename);
       qQuery.sql.add('where ID = :ID');
       qQuery.ParamByName('ID').asinteger := _Id;
       qQuery.open;
       // заполнение полей
       VIDCombo.ID    := qQuery.fieldByName('ID_VID').AsInteger;
       NSizeEdit.text := qQuery.FieldByName('NSize').asstring;
       KindEdit.text  := qQuery.FieldByName('KIND').asstring;;

       Caption := 'Справочник "Характеристики". Элемент' + VIDCombo.Text;
    end;

end;
//
//   Процедура выбора вида характеристики
//
procedure TENUM_CHEQForm.VIDComboButtonClick(Sender: TObject);
begin
  SelectFromTable(VIDCombo);

end;
{
   При редактировании поля "Вид характеристики" нажали кнопку клавы
}
procedure TENUM_CHEQForm.VIDComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( VIDCombo, key, Shift) = false then
     VIDComboButtonClick(Sender);
end;

end.
