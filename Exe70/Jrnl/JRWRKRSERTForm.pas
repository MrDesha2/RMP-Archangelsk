unit JRWRKRSERTForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, ToolWin, DB, DBTables, Grids,
  DBGrids, Menus, DBGridEh;

type
  TJR_WRKRSERTForm = class(TForm)
    ControlBar1: TControlBar;
    ToolBar2: TToolBar;
    Searchkey: TEdit;
    FindButton: TButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    Panel4: TPanel;
    Splitter2: TSplitter;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Button1: TButton;
    WrkrQuery: TQuery;
    SertQuery: TQuery;
    AccessQuery: TQuery;
    WrkrDataSource: TDataSource;
    SertDataSource: TDataSource;
    AccessDataSource: TDataSource;
    AccessDBGridEh: TDBGridEh;
    SertDBGridEh: TDBGridEh;
    WrkrDBGridEh: TDBGridEh;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure WrkrDBGridDblClick(Sender: TObject);
    procedure WrkrDataSourceDataChange(Sender: TObject; Field: TField);
    procedure SertDataSourceDataChange(Sender: TObject; Field: TField);
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FindButtonClick(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure WrkrDBGridEhTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure SertDBGridEhTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure sort_table(type_of_sort: integer; TypeGrid: integer);
    procedure WrkrDBGridEhDblClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    constructor CreateN(AOwner: TForm);
    destructor Destroy; override;
  end;

var
  JR_WRKRSERTForm: TJR_WRKRSERTForm;

implementation

uses WRKREdit,
     Libs,
     Main,
     ParamForm;

{$R *.dfm}


constructor TJR_WRKRSERTForm.createN(AOwner: TForm);
//var i : integer;
//    menuitem : tmenuitem;

begin

  inherited Create(AOwner);

  with SertQuery do
    begin

      close;
      sql.clear;
      sql.add('Select a.lineno, a.protocol_number, a.number, b.name, ');
      sql.add('a.sertificate_date, a.expare_date, a.id_Wrkr, a.lineno ');
      sql.add('From spr_workersertificate a, spr_sertificate b ');
      sql.add('Where a.id_wrkr = :id and a.id_sertificate = b.id ');
      sql.add('Order By 1 ');

    end;


  with AccessQuery do
    begin

      close;
      sql.clear;
      sql.add('Select b.name ');
      sql.add('From spr_sertificateaccess a, spr_accesstype b, spr_workersertificate c ');
      sql.add('Where a.id_wrkr = :id and ');
      sql.add('      c.lineno  = :lineno and ');
      sql.add('      a.wrkr_lineno = c.lineno and ');
      sql.add('      c.id_wrkr = a.id_wrkr and ');
      sql.add('      b.id = a.id_accesstype ');
      sql.add('Order By 1 ');

    end;


    with WrkrQuery do
    begin

      close;
      sql.clear;
      sql.add('Select * From Spr_Wrkr');
      open;

    end;

    caption   := ':Журнал аттестации персонала';

    HelpContext := 352;

    WrkrQuery.First;

    with SertQuery do
    begin

      close;
      parambyname('ID').AsInteger := WrkrQuery.FieldByName('ID').AsInteger;
      open;

    end;


  with AccessQuery do
    begin

      close;
      Parambyname('ID').AsInteger := WrkrQuery.FieldByName('ID').AsInteger;
      ParamByName('lineno').AsInteger := SertQuery.FieldByName('LineNo').AsInteger;
      open;

    end;

    // в зависимости от пожелания открываются окна
    if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

end;

destructor TJR_WRKRSERTForm.Destroy;
begin
  inherited;
end;

procedure TJR_WRKRSERTForm.WrkrDBGridDblClick(Sender: TObject);
Var
  ENUM_WRKRForm : TENUM_WRKRForm;
begin

     MainForm.ID := WrkrQuery.FieldByName('id').AsInteger;
     MainForm.IsFolder := 3;
     ENUM_WRKRForm := TENUM_WRKRForm.create(self);
     ENUM_WRKRForm.ShowModal;

end;

procedure TJR_WRKRSERTForm.WrkrDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
     SertQuery.Close;
     SertQuery.ParamByName('id').AsInteger := WrkrQuery.FieldByName('ID').AsInteger;
     SertQuery.Open
end;

procedure TJR_WRKRSERTForm.SertDataSourceDataChange(Sender: TObject;
  Field: TField);
begin
     AccessQuery.Close;
     AccessQuery.ParamByName('id').AsInteger := WrkrQuery.FieldByName('ID').AsInteger;
     AccessQuery.ParamByName('lineno').AsInteger := SertQuery.FieldByName('LineNo').AsInteger;
     AccessQuery.Open;
end;

procedure TJR_WRKRSERTForm.Button1Click(Sender: TObject);
begin
    close;
end;

procedure TJR_WRKRSERTForm.Button1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
     EscPressed := True;
     abort;
     
   end;

end;

procedure TJR_WRKRSERTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TJR_WRKRSERTForm.FindButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not WrkrQuery.eof then WrkrQuery.next;
    find(WrkrQuery, WrkrDBGrideh, Searchkey.text, 1);
end;

procedure TJR_WRKRSERTForm.ToolButton7Click(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not WrkrQuery.eof then WrkrQuery.next;
    find(WrkrQuery, WrkrDBGrideh, Searchkey.text, 1);
end;

procedure TJR_WRKRSERTForm.ToolButton8Click(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not WrkrQuery.bof then WrkrQuery.prior;
    find(WrkrQuery, WrkrDBGrideh, Searchkey.text, -1);
end;

procedure TJR_WRKRSERTForm.SearchkeyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    find(WrkrQuery, WrkrDBGridEh, Searchkey.text, 1);
end;

procedure TJR_WRKRSERTForm.WrkrDBGridEhTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  sort_table(aCol, 1);

  WrkrDBGridEh.Columns[aCol].Title.SortMarker := smDownEh;

end;


procedure TJR_WRKRSERTForm.SertDBGridEhTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  sort_table(aCol, 2);

  SertDBGridEh.Columns[aCol].Title.SortMarker := smDownEh;

end;

{

    Процедура установки сортировки таблицы

    Вход: направление сортировки


}
procedure TJR_WRKRSERTForm.sort_table(type_of_sort: integer; TypeGrid: integer);
var strord : string;
begin

       Case TypeGrid of
         1: begin
               strord := 'order by ' +
               WrkrDBGridEh.Columns.Items[type_of_sort].FieldName;

               WrkrQuery.close;
               WrkrQuery.SQL.Clear;
               WrkrQuery.sql.clear;
               WrkrQuery.sql.add('Select * From Spr_Wrkr');
               WrkrQuery.sql.add(strord);
               WrkrQuery.open;
            end;
         2: begin
               strord := 'order by ' +
               SertDBGridEh.Columns.Items[type_of_sort].FieldName;

               SertQuery.Close;
               SertQuery.sql.Clear;
               SertQuery.sql.add('Select a.protocol_number, b.name, a.sertificate_date, a.expare_date, ');
               SertQuery.sql.add('a.lineno, a.number, a.id_Wrkr ');
               SertQuery.sql.add('From spr_workersertificate a, spr_sertificate b ');
               SertQuery.sql.add('Where a.id_wrkr = :id and a.id_sertificate = b.id ');
               SertQuery.sql.add(strord);
               SertQuery.ParamByName('id').AsInteger := WrkrQuery.FieldByName('ID').AsInteger;
               SertQuery.Open;
            end;
       end;

end;


procedure TJR_WRKRSERTForm.WrkrDBGridEhDblClick(Sender: TObject);
var
  ENUM_WRKRForm : TENUM_WRKRForm;
begin

              MainForm.ID := WrkrQuery.FieldByName('id').AsInteger;
              MainForm.IsFolder := 3;
              ENUM_WRKRForm := TENUM_WRKRForm.create(self);
              ENUM_WRKRForm.ShowModal;

              SertQuery.Close;
              SertQuery.ParamByName('id').AsInteger := WrkrQuery.FieldByName('ID').AsInteger;
              SertQuery.Open;
              SertDBGridEh.Refresh;
              AccessQuery.Close;
              AccessQuery.ParamByName('id').AsInteger := WrkrQuery.FieldByName('ID').AsInteger;
              AccessQuery.ParamByName('lineno').AsInteger := SertQuery.FieldByName('LineNo').AsInteger;
              AccessQuery.Open;
              AccessDBGridEh.Refresh;

end;

procedure TJR_WRKRSERTForm.ToolButton1Click(Sender: TObject);
Var Num : Integer;
begin
  Num := WrkrQuery.FieldByName('code').AsInteger;
  WrkrQuery.Close;
  WrkrQuery.Open;
  WrkrQuery.locate('code',  Num, [loCaseInsensitive]);
end;

end.
