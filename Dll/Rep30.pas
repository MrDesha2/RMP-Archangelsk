{***************************************************************
 *
 * Модуль   : Rep30
 * Описание : Модуль формирования диаграммы выработки по заказам
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep30;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, EnumForm4Sel, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart,
  DBChart, Series, Db, DBTables, QrTee, QuickRpt, Grids, DBGrids, Mask,
  ToolEdit;

type
  TReport30Form = class(TForm)
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
    procedure OkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  end;

var
  Report30Form: TReport30Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, PrintDgrm, GetPeriods;

{$R *.DFM}

procedure TReport30Form.CloseButtonClick(Sender: TObject);
begin
        Close
end;

procedure TReport30Form.OkButtonClick(Sender: TObject);
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
           Title.Text.Add('Выработка по участкам с '+
                                  BegDateEdit.Text+' по '+EndDateEdit.Text+ ' ' +
                                  ComboBox.Text);

           Series[0].DataSource := MainQuery;
           Series[0].XLabelsSource := 'PDR_CODE';
           Series[0].YValues.ValueSource := 'SUM_NVALUE';
           Series[0].Active := True;
           Series[0].Marks.Style := smsValue;
           Series[0].ColorEachPoint := True;
           Legend.TextStyle:=ltsPlain;
           LeftAxis.Title.Caption := 'Выработка в рублях';
           BottomAxis.Title.Caption := 'МВЗ участков';
        end;

        Form.Caption := 'Выработка по участкам';
        Form.show;
//        Report30Form.Caption := 'Выработка по участкам';

end;

procedure TReport30Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ComboBox.ItemIndex:=0;
end;

procedure TReport30Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport30Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
