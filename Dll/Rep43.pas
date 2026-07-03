unit Rep43;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ToolEdit, DB, DBTables, Mask, EnumForm4Sel, Series,
  TeEngine, GanttCh, ExtCtrls, TeeProcs, Chart, DbChart;

type
  TReport43Form = class(TForm)
    RqstEdit: TEdit;
    Label10: TLabel;
    OrderEdit: TEdit;
    Label9: TLabel;
    Label11: TLabel;
    Label4: TLabel;
    WrkrCombo: TComboEdit;
    WrkrQuery: TQuery;
    Label1: TLabel;
    OkButton: TButton;
    CloseButton: TButton;
    Label2: TLabel;
    Label3: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    Label5: TLabel;
    MainQuery: TQuery;
    DBChart1: TDBChart;
    Series1: TGanttSeries;
    GroupBox: TGroupBox;
    PlanRadioButton: TRadioButton;
    FactRadioButton: TRadioButton;
    Series2: TGanttSeries;
    MainQuery1: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WrkrComboButtonClick(Sender: TObject);
    procedure WrkrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OkButtonClick(Sender: TObject);
    procedure RqstEditExit(Sender: TObject);
    procedure OrderEditExit(Sender: TObject);
    procedure WrkrComboExit(Sender: TObject);
    procedure PlanRadioButtonClick(Sender: TObject);
    procedure FactRadioButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report43Form: TReport43Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, PrintDgrm, GetPeriods;

{$R *.dfm}

procedure TReport43Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ListForm := TLIST_4SELECTForm.create(self);
end;

procedure TReport43Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport43Form.CloseButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TReport43Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport43Form.WrkrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WRkrQuery, WrkrCombo, 'select id, code, name from spr_Wrkr',
                        'Справочник: исполнитель (Выбор)', 0);
end;

procedure TReport43Form.WrkrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, WrkrCombo, key, Shift, 1) = false then
    WrkrComboButtonClick(Sender);
end;

procedure TReport43Form.OkButtonClick(Sender: TObject);
Var  Form : TPrintDiagram;
     sstr : String;
begin

        sstr := '';

        If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
        begin
           MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
           Exit;
        end;

        Form := TPrintDiagram.create(Application);
        Form.SetDgrm(TGanttSeries);

        MainQuery.Close;

               //Параметр = Заявке
        if (RqstEdit.Text <> '')  then
        begin
              MainQuery.ParamByName('Rqst_Number').AsInteger := StrToInt(RqstEdit.Text);
              sstr := 'по заказу '+RqstEdit.Text;
        end;

        //Параметр = Заказу
        if (OrderEdit.Text <> '')  then
        begin
              MainQuery.ParamByName('OrderEdit.Text').AsInteger := StrToInt(OrderEdit.Text);
              If (sstr = '') Then sstr := 'по заказу '+OrderEdit.Text
               else sstr := sstr + '/'+OrderEdit.Text;
        end;


        If not (WrkrQuery.Active) Then
           MainQuery.ParamByName('wrkr_id').AsInteger := 0
         else
         begin
             MainQuery.ParamByName('wrkr_id').AsInteger := WrkrQuery.Fields[0].AsInteger;
             sstr := WrkrQuery.Fields[1].AsString;
         end;

        MainQuery.ParamByName('beg_date').AsDate := StrToDate(BegDateEdit.Text);
        MainQuery.ParamByName('end_date').AsDate := StrToDate(EndDateEdit.Text);
        MainQuery.Open;

        If MainQuery.Eof Then
        begin
           MessageDlg('Выполненных заказов в данный период нет!', mtWarning , [mbYes], 0);
           Exit;
        end;
        With Form.DBChart do
        begin
{           AddSeries(TGanttSeries);
           Series[0].ser
           Title.Text.Clear;
           Title.Text.Add('График работы '+ Trim(sstr)+ ' с '+
                                  BegDateEdit.Text+' по '+EndDateEdit.Text);

           Series[0].DataSource := MainQuery;
           Series[0].DataSource. := 'BEG_DATE';
           Series[0].AddGantt   := 'END_DATE';
           Series[0].YValues.ValueSource := 'SUM_NVALUE';
           Series[0].Active := True;
           Series[0].Marks.Style := smsValue;
           Series[0].ColorEachPoint := True;
           BottomAxis.LabelsAngle := 90;
           Legend.TextStyle:=ltsPlain;  }
//           LeftAxis.Title.Caption := 'Выработка в рублях';
//           BottomAxis.Title.Caption := 'Заказчики';
        end;

        Form.Caption := 'Выработка по производствам';
        Form.show;


end;

procedure TReport43Form.RqstEditExit(Sender: TObject);
begin
  If (RqstEdit.Text <> '')  then
  begin
      WrkrQuery.Active := False;
      WrkrCombo.Text := '<Объект не найден>';
  end;
end;

procedure TReport43Form.OrderEditExit(Sender: TObject);
begin
  If (OrderEdit.Text <> '')  then
  begin
      WrkrQuery.Active := False;
      WrkrCombo.Text := '<Объект не найден>';
  end;
end;

procedure TReport43Form.WrkrComboExit(Sender: TObject);
begin
  If (WrkrQuery.Active = True) Then
  begin
      RqstEdit.Text  := '';
      OrderEdit.Text := '';
  end;
end;

procedure TReport43Form.PlanRadioButtonClick(Sender: TObject);
begin
    PlanRadioButton.Checked := True;
    PlanRadioButton.Font.Style := [fsBold];
    FactRadioButton.Checked := False;
    FactRadioButton.Font.Style := [];
end;

procedure TReport43Form.FactRadioButtonClick(Sender: TObject);
begin
    PlanRadioButton.Checked := False;
    PlanRadioButton.Font.Style := [];
    FactRadioButton.Checked := True;
    FactRadioButton.Font.Style := [fsBold];
end;

end.
