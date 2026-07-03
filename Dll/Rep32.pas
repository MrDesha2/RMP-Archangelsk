{***************************************************************
 *
 * Модуль   : Rep32
 * Описание : Диаграмма выработки по заказам (услугам)
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep32;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, TeEngine, Series, TeeProcs, Chart, DBChart,
  ExtCtrls, EnumForm4Sel, Db, DBTables, ComCtrls;

type
  TReport32Form = class(TForm)
    MainQuery: TQuery;
    Label1: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    ComboBox: TComboBox;
    OkButton: TButton;
    CloseButton: TButton;
    Label3: TLabel;
    ButtonSelPer: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  end;

var
  Report32Form: TReport32Form;

implementation
uses PrintFrm, printlibs,
     Libs, PrintProces, PrintDgrm, GetPeriods;

{$R *.DFM}

procedure TReport32Form.CloseButtonClick(Sender: TObject);
begin
        Close;
end;

procedure TReport32Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ComboBox.ItemIndex:=0;
end;

procedure TReport32Form.OkButtonClick(Sender: TObject);
var
//     Total : Real;
     Form  : TPrintDiagram;
begin
        If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
        begin
           MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
           Exit;
        end;

        Form := TPrintDiagram.create(Application);
        Form.SetDgrm(TPieSeries);

        MainQuery.Close;

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

        With Form.DBChart do
        begin
            Title.Text.Clear;
            Title.Text.Add('Выработка по организациям с '+
                           BegDateEdit.Text+' по '+EndDateEdit.Text+ ' ' +
                           ComboBox.Text);
            Title.Text.Add('');
            Series[0].DataSource := MainQuery;
            Series[0].XLabelsSource := 'NAME_INSTR';
            Series[0].YValues.ValueSource := 'SUM_NVALUE';
            Series[0].Active := True;
            Series[0].Marks.Style := smsPercent;
            Legend.TextStyle:=ltsLeftValue;
        end;

        Form.Caption := 'Выработка по организациям';
        Form.show;
//        Report32Form.Caption := 'Выработка по организациям';

{        Total:=0;
        MainQuery.First;
        while not MainQuery.Eof do
        begin
           Total := Total + MainQuery.FieldByName('SUM_NVALUE').AsFloat;
           MainQuery.Next;
        end;

        Total_Label.Caption := 'Итого: '+IntToStr(Trunc(Total))+' руб.'+IntToStr(Trunc((Total - Trunc(Total))*100)) + ' коп.';}


end;

procedure TReport32Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport32Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
