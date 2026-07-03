unit AddExecuter_Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBTables, Grids, DBGridEh, StdCtrls, ComCtrls,
  ToolWin, OROPEditForm, Mask, ToolEdit, DateUtils;

type
  TAddExecuterForm = class(TForm)
    FormGrid: TDBGridEh;
    qFormQuery: TQuery;
    FormSource: TDataSource;
    BottomPanel: TPanel;
    CloseButton: TButton;
    EnumToolBar: TToolBar;
    NewButtom: TToolButton;
    Searchkey: TEdit;
    FindButton: TButton;
    DownButton: TToolButton;
    UpButton: TToolButton;
    CodeSearchKey: TEdit;
    ToolButton1: TToolButton;
    Button1: TButton;
    procedure FormGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CloseButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor CreateN(AOwner: TDOCT_OPERForm; _qFormQuery: TQuery; Combo : TComboEdit);
    destructor Destroy; override;
  end;

var
  AddExecuterForm: TAddExecuterForm;
  WRKRCombo : TComboEdit;
  OROPForm : TDOCT_OPERForm;

implementation

{$R *.dfm}


constructor TAddExecuterForm.CreateN(AOwner: TDOCT_OPERForm; _qFormQuery: TQuery; Combo : TComboEdit);
begin

  inherited Create(AOwner);
  OROPForm := AOwner;
  qFormQuery.Handle := _qFormQuery.Handle;
  //еякх мю опнрхб векнбейю мер бпелемх, гмювхр нм бшонкмъер щрс ноепюжхч,
  // мн нрбедеммне бпелъ гюмърн
  WRKRCombo := Combo;

end;  

destructor TAddExecuterForm.Destroy;
begin
  inherited;
end;



procedure TAddExecuterForm.FormGridDblClick(Sender: TObject);
begin
   WrkrCombo.Query.Close;
   WrkrCombo.Query.ParamByName('ID').asinteger  := qFormQuery.FieldByName('ID_WRKR').AsInteger;
   WrkrCombo.Query.ParamByName('CODE').asinteger  := qFormQuery.FieldByName('CODE_WRKR').AsInteger;
   WrkrCombo.Query.Open;
   WrkrCombo.text := WrkrCombo.Query.fieldbyname('name').asstring;
   WrkrCombo.ID   := WrkrCombo.Query.fieldbyname('ID').asinteger;

   If (qFormQuery.FieldByName('CODE_EQPT').AsInteger <> Null) Then
   begin
      OROPForm.qEQPTQuery.Close;
      OROPForm.qEQPTQuery.ParamByName('CODE').asinteger  := qFormQuery.FieldByName('CODE_EQPT').AsInteger;
      OROPForm.qEQPTQuery.Open;
      OROPForm.EQPTCombo.Text := OROPForm.qEQPTQuery.fieldbyname('name').asstring;
      OROPForm.EQPTCombo.ID := OROPForm.qEQPTQuery.fieldbyname('ID').AsInteger;
   end;

   If (qFormQuery.FieldByName('DATE_BEG').AsDateTime <> Null) Then
   begin
       OROPForm.DateBEG.Date := DateOf(qFormQuery.FieldByName('DATE_BEG').AsDateTime);
       OROPForm.TimeBEG.Time := TimeOf(qFormQuery.FieldByName('DATE_BEG').AsDateTime);
   end;

   If (qFormQuery.FieldByName('DATE_END').AsDateTime <> Null) Then
   begin
       OROPForm.DateEND.Date := DateOf(qFormQuery.FieldByName('DATE_END').AsDateTime);
       OROPForm.TimeEND.Time := TimeOf(qFormQuery.FieldByName('DATE_END').AsDateTime);
   end;
end;

procedure TAddExecuterForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TAddExecuterForm.CloseButtonClick(Sender: TObject);
begin
  release;
end;

end.
