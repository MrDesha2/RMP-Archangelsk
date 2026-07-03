unit Rep34;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TeeProcs, TeEngine, Chart, DbChart, StdCtrls, Mask,
  ToolEdit, DB, DBTables, Series, EnumForm4Sel;

type
  TReport34Form = class(TForm)
    CstQuery: TQuery;
    PdrQuery: TQuery;
    MainQuery: TQuery;
    BegDateEdit: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    Label4: TLabel;
    CstCombo: TComboEdit;
    Label5: TLabel;
    PdrCombo: TComboEdit;
    CloseButton: TButton;
    OkButton: TButton;
    ComboBox: TComboBox;
    ButtonSelPer: TButton;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report34Form: TReport34Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, PrintDgrm, GetPeriods;

{$R *.dfm}

procedure TReport34Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ComboBox.ItemIndex:=0;
  ListForm := TLIST_4SELECTForm.create(self);
end;

procedure TReport34Form.OkButtonClick(Sender: TObject);
Var  Form : TPrintDiagram;
begin
        If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
        begin
           MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
           Exit;
        end;

        Form := TPrintDiagram.create(Application);
        Form.SetDgrm(TBarSeries);

        MainQuery.Close;

        If not (PDRQuery.Active) Then
        begin
           MessageDlg('Подразделение не определено', mtWarning , [mbYes], 0);
           Exit;
        end
         else
              MainQuery.ParamByName('pdr_id').AsInteger := PdrQuery.Fields[0].AsInteger;

        If not (CstQuery.Active) Then
           MainQuery.ParamByName('cst_id').AsInteger := 0
         else
             MainQuery.ParamByName('cst_id').AsInteger := CstQuery.Fields[0].AsInteger;


        //если по изготовлению и услугам или по изготовлению
        If (ComboBox.ItemIndex = 0) Then
              MainQuery.ParamByName('job').AsInteger := 0;

        //если по изготовлению
        If (ComboBox.ItemIndex = 1) Then
              MainQuery.ParamByName('job').AsInteger := 1;

        //если по услугам
        If (ComboBox.ItemIndex = 2) Then
              MainQuery.ParamByName('job').AsInteger := 2;

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
           Title.Text.Clear;
           Title.Text.Add('Выработка по заказчикам участком '+ Trim(PdrCombo.Text)+ ' с '+
                                  BegDateEdit.Text+' по '+EndDateEdit.Text+ ' ' +
                                  ComboBox.Text);

           Series[0].DataSource := MainQuery;
           Series[0].XLabelsSource := 'CST_NAME';
           Series[0].YValues.ValueSource := 'SUM_NVALUE';
           Series[0].Active := True;
           Series[0].Marks.Style := smsValue;
           Series[0].ColorEachPoint := True;
           BottomAxis.LabelsAngle := 90;
           Legend.TextStyle:=ltsPlain;
           LeftAxis.Title.Caption := 'Выработка в рублях';
           BottomAxis.Title.Caption := 'Заказчики';
        end;

        Form.Caption := 'Выработка по производствам';
        Form.show;

end;

procedure TReport34Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(LISTForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst Where isfolder <> 0',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport34Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport34Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);

end;

procedure TReport34Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);

end;

procedure TReport34Form.CloseButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TReport34Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;

end;

procedure TReport34Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
