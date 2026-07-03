unit ENUMModelbox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RXSpin, ToolEdit, CurrEdit, Mask, DB, DBTables;

type
  TENUM_MODELBOX = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    INGLUTINATION: TCheckBox;
    CONGLUTINATION: TCheckBox;
    ROD_NUMBER: TCurrencyEdit;
    LENGHT: TCurrencyEdit;
    WIDTH: TCurrencyEdit;
    HEIGHT: TCurrencyEdit;
    COMPLEXITY_GROUP: TRxSpinEdit;
    REMOVEBLEPART_NUMBER: TRxSpinEdit;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    qQueryUpdate: TQuery;
    qQuery: TQuery;
    BOX_NUMBER: TCurrencyEdit;
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _ID, _OwnerID: integer;
               _TableName: string; generatorname: string; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_MODELBOX: TENUM_MODELBOX;
   FormType: integer; // Тип формы при открытии 2 - для редактирования, 1 - для добавления;
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
 sQueryText: string;  // текст запроса заполнения

implementation

uses Base,libs;

{$R *.dfm}

{ TENUM_MODELBOX }

constructor TENUM_MODELBOX.createN(AOwner: TComponent; _ID,
  _OwnerID: integer; _TableName, generatorname: string;
  _TypeEdit: integer);
begin
  inherited Create(AOwner);;


  ID := _Id;                // Идентификатор элемента для редактирования
  OwnerID := _ownerID;      // Идентификатор владельца
  // если это добавление элемента
  FormType := _typeEdit;

  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into ' + _tablename +
        '(    ID, ID_MODEL, LINENO, BOX_NUMBER, ROD_NUMBER, LENGHT, ' +
        ' WIDTH, HEIGHT, COMPLEXITY_GROUP, REMOVEBLEPART_NUMBER, '+
        ' CONGLUTINATION, INGLUTINATION) ' +
        ' values (GEN_ID(' + GeneratorName + ',1), :ID_MODEL, :LINENO, ' +
        '  :BOX_NUMBER, :ROD_NUMBER, :LENGHT, ' +
        '  :WIDTH, :HEIGHT, :COMPLEXITY_GROUP, :REMOVEBLEPART_NUMBER, :CONGLUTINATION, :INGLUTINATION)';

    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin
       // проверка на разрешение редактирования
       ButtonOK.Enabled := check_user_grand(uppercase(_tablename), 'U', true);

       sQueryText := 'update ' + _tablename +
        '  SET LINENO = :LINENO, BOX_NUMBER = :BOX_NUMBER,' +
        '  ROD_NUMBER = :ROD_NUMBER, LENGHT = :LENGHT, WIDTH = :WIDTH, HEIGHT = :HEIGHT,' +
        '  COMPLEXITY_GROUP = :COMPLEXITY_GROUP, REMOVEBLEPART_NUMBER = :REMOVEBLEPART_NUMBER, ' +
        '  CONGLUTINATION = :CONGLUTINATION, INGLUTINATION = :INGLUTINATION' +
        '  where (id = :id)';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from ' + _tablename);
       qQuery.sql.add('where ID = :ID');
       qQuery.ParamByName('ID').asinteger := _Id;
       qQuery.open;
       BOX_NUMBER.Text := qQuery.fieldbyname('BOX_NUMBER').asstring;
       ROD_NUMBER.Text := qQuery.fieldbyname('ROD_NUMBER').asstring;
       LENGHT.Text     := qQuery.fieldbyname('LENGHT').asstring;
       WIDTH.Text      := qQuery.fieldbyname('WIDTH').asstring;
       HEIGHT.Text     := qQuery.fieldbyname('HEIGHT').asstring;
       COMPLEXITY_GROUP.Text      := qQuery.fieldbyname('COMPLEXITY_GROUP').asstring;
       REMOVEBLEPART_NUMBER.Text  := qQuery.fieldbyname('REMOVEBLEPART_NUMBER').asstring;
       if qQuery.fieldbyname('INGLUTINATION').AsInteger > 0 then
        INGLUTINATION.Checked      := true
        else
          INGLUTINATION.Checked      := false;

       if qQuery.fieldbyname('CONGLUTINATION').asinteger > 0 then
        CONGLUTINATION.Checked     := true
         else
          CONGLUTINATION.Checked     := false;


    end;



end;

destructor TENUM_MODELBOX.Destroy;
begin
  inherited;
end;

procedure TENUM_MODELBOX.ButtonOKClick(Sender: TObject);
begin

 
    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

  // если форма была для добавления
  if FormType = 1 then
    qQueryUpdate.ParamByName('ID_MODEL').asinteger := ownerID
  else
    qQueryUpdate.ParamByName('ID').asinteger := ID;

    qQueryUpdate.ParamByName('LINENO').asinteger     := 0;
    qQueryUpdate.ParamByName('BOX_NUMBER').asinteger   := BOX_NUMBER.AsInteger;
    qQueryUpdate.ParamByName('ROD_NUMBER').asinteger   := ROD_NUMBER.AsInteger;
    qQueryUpdate.ParamByName('LENGHT').value           := LENGHT.Value;
    qQueryUpdate.ParamByName('WIDTH').value            := WIDTH.Value;
    qQueryUpdate.ParamByName('HEIGHT').value           := HEIGHT.Value;
    qQueryUpdate.ParamByName('COMPLEXITY_GROUP').asinteger    := COMPLEXITY_GROUP.AsInteger;
    qQueryUpdate.ParamByName('REMOVEBLEPART_NUMBER').AsInteger:= REMOVEBLEPART_NUMBER.AsInteger;

    if CONGLUTINATION.Checked then
    qQueryUpdate.ParamByName('CONGLUTINATION').asinteger := 1
     else
      qQueryUpdate.ParamByName('CONGLUTINATION').asinteger := 0;

    if INGLUTINATION.Checked then
      qQueryUpdate.ParamByName('INGLUTINATION').asinteger  := 1
      else
        qQueryUpdate.ParamByName('INGLUTINATION').asinteger  := 0;

   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

   ModalResult := mrOK;

end;

procedure TENUM_MODELBOX.ButtonCancelClick(Sender: TObject);
begin
    ModalResult := mrCancel;
end;

end.
