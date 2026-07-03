{***************************************************************
 *
 * Ìîäóëü   : Rep31
 * Îïèñàíèå : Äèíàìèêà âûïîëíåíèÿ çàêàçîâ ïî äàòàì
 * Àâòîğû   : Êîñèöûí Äìèòğèé, Ñîêîëîâ Âëàäèñëàâ
 * Èñòîğèÿ  : 2004
 *
 ****************************************************************}

unit Rep31;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, EnumForm4Sel, Db, DBTables, TeEngine, Series, TeeProcs, Chart,
  DBChart, StdCtrls, ExtCtrls, Mask, ToolEdit, DateUtil, TeeFunci,
   ArrowCha, BubbleCh, GanttCh; //

type
  TReport31Form = class(TForm)
    Label1: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    CloseButton: TButton;
    OkButton: TButton;
    Query: TQuery;
    Label2: TLabel;
    Label3: TLabel;
    ButtonSelPer: TButton;
    procedure OkButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  private
  public
    OldX,OldY:Longint;
    CrossHairColor:TColor;
    CrossHairStyle:TPenStyle;
    { Public declarations }
  end;
var
  Report31Form: TReport31Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, PrintDgrm, GetPeriods;

{$R *.DFM}


procedure TReport31Form.OkButtonClick(Sender: TObject);
Var  Form : TPrintDiagram;
begin
        If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
        begin
           MessageDlg('Äàòû íå îïğåäåëåíû!', mtWarning , [mbYes], 0);
           Exit;
        end;

        Form := TPrintDiagram.create(Application);
        Form.SetDgrm(TLineSeries);

        Query.Close;
        Query.SQL.Clear;

        Query.SQL.Add('Select date_end, count(date_end) ');
        Query.SQL.Add('From DT_Order2 ');
        Query.SQL.Add('Where date_end>=:beg_date and date_end<=:end_date ');
        Query.SQL.Add('Group By date_end ');

        Query.ParamByName('beg_date').AsDate := StrToDate(BegDateEdit.Text);
        Query.ParamByName('end_date').AsDate := StrToDate(EndDateEdit.Text);
        Query.Open;

        With Form.DBChart do
        begin
//           View3D:=CheckBox.Checked;
           Title.Text.Clear;
           Title.Text.Add('Äèíàìèêà âûïîëíåíèÿ îïåğàöèé ñ '+
                               BegDateEdit.Text+' ïî '+EndDateEdit.Text);
           Legend.Visible :=False;

           Form.DBChart.Series[0].Active := True;
           Form.DBChart.Series[0].DataSource := Query;
           Form.DBChart.Series[0].XLabelsSource := 'date_end';
           Form.DBChart.Series[0].YValues.ValueSource := 'count';
        end;

        Form.Caption := 'Äèíàìèêà çàïîëíåíèÿ îïåğàöèé';
        Form.show;

//        Report31Form.Caption := 'Âûğàáîòêà ïî ó÷àñòêàì';


end;

procedure TReport31Form.CloseButtonClick(Sender: TObject);
begin
        Close;
end;

procedure TReport31Form.FormCreate(Sender: TObject);
begin

  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
//  CrossHairColor:=clYellow;
//  CrossHairStyle:=psSolid;

end;

procedure TReport31Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport31Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.










