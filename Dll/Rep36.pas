unit Rep36;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Mask, ToolEdit, EnumForm4Sel, TeEngine, Series;

type
  TReport36Form = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    JobComboBox: TComboBox;
    OkButton: TButton;
    CloseButton: TButton;
    MainQuery: TQuery;
    VidComboBox: TComboBox;
    procedure CloseButtonClick(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Report36Form: TReport36Form;

implementation
uses PrintFrm, printlibs,
     Libs, PrintProces, PrintDgrm, GetPeriods;

{$R *.dfm}

procedure TReport36Form.CloseButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TReport36Form.OkButtonClick(Sender: TObject);
Var  Form : TPrintDiagram;
begin

        If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
        begin
           MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
           Exit;
        end;

        Form := TPrintDiagram.create(Application);
        Form.SetDgrm(TPieSeries);

        MainQuery.Close;

        //если по выполненным заказам
        If (VidComboBox.ItemIndex = 0) Then
              MainQuery.ParamByName('vid').AsInteger := 0;

        //если по незавершенке
        If (VidComboBox.ItemIndex = 1) Then
              MainQuery.ParamByName('vid').AsInteger := 1;

        //если по изготовлению и услугам или по изготовлению
        If (JobComboBox.ItemIndex = 0) Then
              MainQuery.ParamByName('job').AsInteger := 0;

        //если по изготовлению
        If (JobComboBox.ItemIndex = 1) Then
              MainQuery.ParamByName('job').AsInteger := 1;

        //если по услугам
        If (JobComboBox.ItemIndex = 2) Then
              MainQuery.ParamByName('job').AsInteger := 2;

        MainQuery.ParamByName('beg_date').AsDate := StrToDate(BegDateEdit.Text);
        MainQuery.ParamByName('end_date').AsDate := StrToDate(EndDateEdit.Text);
        MainQuery.Open;

        With Form.DBChart do
        begin
           Title.Text.Clear;
           Title.Text.Add('Учет производства с '+
                                  BegDateEdit.Text+' по '+EndDateEdit.Text+ ' ' );

           Series[0].DataSource := MainQuery;
           Series[0].XLabelsSource := 'weight';
           Series[0].YValues.ValueSource := 'NVALUE';
           Series[0].Active := True;
           Series[0].Marks.Style := smsPercent; //smsValue;
           Series[0].ColorEachPoint := True;
           Legend.TextStyle:=ltsLeftValue; //ltsPlain;
        end;

        Form.Caption := 'Учет производства';
        Form.show;
        
end;

procedure TReport36Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport36Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport36Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  VidComboBox.ItemIndex:=0;
  JobComboBox.ItemIndex:=0;
end;

end.
 