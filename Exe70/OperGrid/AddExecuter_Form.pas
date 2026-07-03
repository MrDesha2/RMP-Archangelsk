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
  //ЕСЛИ НА ПРОТИВ ЧЕЛОВЕКА НЕТ ВРЕМЕНИ, ЗНАЧИТ ОН ВЫПОЛНЯЕТ ЭТУ ОПЕРАЦИЮ,
  // НО ОТВЕДЕННОЕ ВРЕМЯ ЗАНЯТО
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

   If (qFormQuery.FieldByName('CODE_EQPT').AsString <> '') Then
   begin
      OROPForm.qEQPTQuery.Close;
      OROPForm.qEQPTQuery.ParamByName('id').asString  := qFormQuery.FieldByName('ID_EQPT').AsString;
      OROPForm.qEQPTQuery.ParamByName('code').asString  := qFormQuery.FieldByName('CODE_EQPT').AsString;
      OROPForm.qEQPTQuery.Open;
      OROPForm.EQPTCombo.Text := OROPForm.qEQPTQuery.fieldbyname('name').asstring;
      OROPForm.EQPTCombo.ID := OROPForm.qEQPTQuery.fieldbyname('ID').AsInteger;
   end
    else
    begin
      OROPForm.EQPTCombo.Text := '';
      OROPForm.EQPTCombo.ID := -1;
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

      //если выбран человек вношу изменения в label о его предыдущих работах

      OROPForm.QueryOper.Close;
      OROPForm.QueryOper.SQL.Clear;
      OROPForm.QueryOper.SQL.Add('Select a.date_beg, sum(a.ntime) as ntime');
      OROPForm.QueryOper.SQL.Add('From dt_order1 a');
      OROPForm.QueryOper.SQL.Add('where a.id_wrkr = :id_wrkr and');
      OROPForm.QueryOper.SQL.Add('a.date_beg = (Select max(b.date_beg)');
      OROPForm.QueryOper.SQL.Add('From DT_Order1 b');
      OROPForm.QueryOper.SQL.Add('Where b.id_wrkr = :id_wrkr)');
      OROPForm.QueryOper.SQL.Add('Group by a.date_beg');

      OROPForm.QueryOper.ParambyName('id_wrkr').AsInteger := OROPForm.WRKRCombo.Query.fieldbyname('ID').AsInteger;

      OROPForm.QueryOper.Open;

      If OROPForm.QueryOper.RecordCount > 0 Then
      begin
          OROPForm.ButtonOrder.Enabled := True;
          OROPForm.LabelOper.font.color := clRed;
          OROPForm.LabelOper.Caption := 'Предыдущая операция: ' +
                               OROPForm.WRKRCombo.Query.fieldbyname('NAME').AsString + '   '+
                               OROPForm.QueryOper.FieldbyName('date_beg').AsString + '  '+
                               FormatFloat('0.00',OROPForm.QueryOper.FieldbyName('ntime').AsInteger/1000) + ' час'; //'ntime').AsInteger/1000/24
      end
        else
        begin
           OROPForm.ButtonOrder.Enabled := False;
           OROPForm.LabelOper.Caption := 'Предыдущая операция:';
           OROPForm.LabelOper.font.color := clGray;
        end;


   CloseButtonClick(Nil);
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
