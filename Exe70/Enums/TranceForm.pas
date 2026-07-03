unit TranceForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls;

type
  TTrance_Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ElemName: TLabel;
    Values: TComboBox;
    OkButton: TButton;
    CancelButton: TButton;
    FormSource: TDataSource;
    qQuery: TQuery;
    procedure CancelButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; TableName: string; ID: integer; Code: string; _name: string);
    destructor  Destroy; override;
    { Public declarations }
  end;

var
  Trance_Form: TTrance_Form;
  _tablename: string;  // имя таблицы
  enumID: integer;  // идентификатор новой родительской записи

implementation


uses Base;

{$R *.DFM}
//
//
// ID - идентификатор передаваемого элемента
constructor TTrance_Form.createN(AOwner: TComponent; TableName: string; ID: integer; Code: string; _name: string);
var i: integer;
begin
  inherited Create(AOwner);
  qQuery.close;
  qQuery.SQL.clear;
  qQuery.SQL.add('select * from ' + tablename);
  qQuery.SQL.add('where isfolder <> 0');
  qQuery.Open;

  values.Clear;
  // добавим пустой элемент, означающий нулевой уровень справочника
  values.items.AddObject('Пустой уровень', nil);

  For i:=1 To qQuery.RecordCount Do
   Begin
     values.items.AddObject(qQuery.FieldByName('Name').AsString, Pointer(qQuery.FieldByName('ID').AsInteger));
     qQuery.Next;
   end;
   values.ItemIndex := 0;
   EnumID := Id;
   _tableName := tablename;
   ElemName.Caption := '' + Code + ' ' + _name;
end;

destructor TTrance_Form.Destroy;
begin
  inherited;
end;


procedure TTrance_Form.CancelButtonClick(Sender: TObject);
begin
  close;
end;

procedure TTrance_Form.OkButtonClick(Sender: TObject);
var
  ID: integer; // идентификатор родительской записи
begin
  {}
  if values.Items.Objects[values.ItemIndex] <> nil then
    ID:=Integer(values.Items.Objects[values.ItemIndex])
  else
    ID := 0;

  qQuery.Sql.Clear;
  qQuery.sql.add('update ' + _tablename);
  qQuery.sql.add('set ParentID = :ParentID');
  qQuery.sql.add('where ID = :ID');
  qQuery.ParamByName('ID').asinteger       := enumID;
  qQuery.ParamByName('ParentID').asinteger := ID;
    data.RMPBase.StartTransaction;
     qQuery.ExecSQL;
    data.RMPBase.Commit;
  close;
end;

procedure TTrance_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
