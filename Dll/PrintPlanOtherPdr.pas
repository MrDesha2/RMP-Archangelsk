unit PrintPlanOtherPdr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, ppDBBDE, Db,
  DBTables, StdCtrls, Mask, ToolEdit, ppCtrls, ppBands, ppPrnabl, ppCache,
  ppVar, ppModule, raCodMod;

type
  TFormPlanOtherPdr = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    PdrComboBox: TComboBox;
    DataSource: TDataSource;
    Query: TQuery;
    BDEPipeline: TppBDEPipeline;
    Report: TppReport;
    DateEdit: TDateEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    ppTitleBand1: TppTitleBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    TitleLabel1: TppLabel;
    TitleLabel2: TppLabel;
    ppHeaderBand1: TppHeaderBand;
    ppShape2: TppShape;
    ppShape14: TppShape;
    ppShape15: TppShape;
    ppShape4: TppShape;
    ppShape12: TppShape;
    ppShape13: TppShape;
    ppShape3: TppShape;
    ppShape10: TppShape;
    ppShape11: TppShape;
    ppShape9: TppShape;
    ppShape8: TppShape;
    ppShape7: TppShape;
    ppShape6: TppShape;
    ppShape5: TppShape;
    ppShape1: TppShape;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel15: TppLabel;
    ppLabel16: TppLabel;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppDetailBand1: TppDetailBand;
    OrderVariable: TppVariable;
    CstDBText: TppDBText;
    NmntDBText: TppDBText;
    ChrtDBText: TppDBText;
    EdizmDBText: TppDBText;
    KolvoFDBText: TppDBText;
    AllPTimeVariable: TppVariable;
    AllFTimeVariable: TppVariable;
    KolvoPDBText: TppDBText;
    PTimeDBText: TppDBText;
    FTimeDBText: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    raCodeModule1: TraCodeModule;
    PdrQuery: TQuery;
    ppSummaryBand1: TppSummaryBand;
    ppSystemVariable1: TppSystemVariable;
    ppLine1: TppLine;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPlanOtherPdr: TFormPlanOtherPdr;

implementation

{$R *.DFM}

procedure TFormPlanOtherPdr.Button1Click(Sender: TObject);
begin
       If DateEdit.Text = '  .  .  ' Then
       begin
          MessageDlg('Период не определен!', mtWarning , [mbYes], 0);
          Exit;
       end;

        TitleLabel1.Caption:='План отчет участка (цеха) '+Trim(PdrComboBox.Text) + ' РМП';
        TitleLabel2.Caption:='на '+DateEdit.Text+ ' г.';

        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Select a.NUMBER, b.NUMBER, c.NAME, d.NAME, ');
        Query.SQL.Add('e.CODE, m.NAME, b.NUMBER_P, b.NUMBER_F, ');
        Query.SQL.Add('Sum(f.NTIME) As Time_F, Sum(g.NTIME) As TIME_P');
        Query.SQL.Add('From DH_Rqst a, DH_Order b, Spr_Cst c, ');
        Query.SQL.Add('Spr_Nmnt d, Spr_Chrt e, Spr_Ediz m, Spr_Pdr n,');
        Query.SQL.Add('DH_Order h left join DT_Order1 g on g.ID_ORDER = h.ID, ');
        Query.SQL.Add('DH_Order k left join DT_Order2 f on f.ID_ORDER = k.ID ');
        Query.SQL.Add('Where n.NAME = :pdr and a.ID_PDR = n.ID and ');
        Query.SQL.Add('b.ID_RQST=a.ID and c.ID = a.ID_CST and ');
        Query.SQL.Add('d.ID = b.ID_NMNT and e.ID = b.ID_Chrt and ');
        Query.SQL.Add('m.ID = d.ID_EDIZ ');
        Query.SQL.Add('and (g.ID_ORDER = b.ID or f.ID_ORDER = b.ID) ');
        Query.SQL.Add('and b.DATE_IN>=:date ');
        Query.SQL.Add('Group by a.NUMBER, b.NUMBER, c.NAME, d.NAME, ');
        Query.SQL.Add('e.CODE, m.NAME, b.NUMBER_P, b.NUMBER_F');

        Query.ParamByName('pdr').AsString:=PdrComboBox.Text;
        Query.ParamByName('date').AsDate:=StrToDate(DateEdit.Text);

        Query.Open;
        If not Query.Eof Then
            Report.Print
         else
              MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);

end;

procedure TFormPlanOtherPdr.Button2Click(Sender: TObject);
begin
        FormPlanOtherPdr.Close;
end;

procedure TFormPlanOtherPdr.FormCreate(Sender: TObject);
begin
        PdrQuery.Close;
        PdrQuery.Open;
        PdrQuery.First;
        While not PdrQuery.Eof do
        begin
           PdrComboBox.Items.Add(PdrQuery.FieldByName('NAME').AsString);
           PdrQuery.Next;
        end;
end;

end.
