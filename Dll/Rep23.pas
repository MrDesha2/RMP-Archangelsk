{

        Потребность в материалах

}        
unit Rep23;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXDBCtrl, Mask, ToolEdit, EnumForm4Sel, Db, DBTables, DateUtil;

type
  TReport23Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ButtonOK: TButton;
    ButtonNO: TButton;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    MonthComboBox: TComboBox;
    MainQuery: TQuery;
    CstQuery: TQuery;
    PdrQuery: TQuery;
    ProcQuery: TQuery;
    procedure ButtonNOClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FillPeriod;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report23Form: TReport23Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces;

{$R *.DFM}

procedure TReport23Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport23Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
    sstr : String;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       If MonthComboBox.ItemIndex = -1 Then
       begin
          MessageDlg('Период не определен!', mtWarning , [mbYes], 0);
          Exit;
       end;

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select a.CODE, a.Name, Sum(e.NUMBER), d.Code, a.ID ');
       MainQuery.SQL.Add('From Jr_Plan b, DH_Order c, ');
       MainQuery.SQL.Add('DT_MTRP e, Spr_Cst g, Spr_Pdr h, Dh_Rqst k, ');
       MainQuery.SQL.Add('Spr_Nmnt a left join Spr_Ediz d on a.id_ediz = d.id ');
       MainQuery.SQL.Add('Where ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          MainQuery.SQL.Add('g.id = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          MainQuery.SQL.Add('h.id = ' + PdrQuery.Fields[0].asstring + ' and ');

       MainQuery.SQL.Add('b.period = :period and  ');
       MainQuery.SQL.Add('c.id = b.id_order  and  ');
       MainQuery.SQL.Add('k.id = c.id_rqst   and  ');
       MainQuery.SQL.Add('g.id = k.id_cst    and  ');
       MainQuery.SQL.Add('h.id = k.id_pdr    and  ');
       MainQuery.SQL.Add('e.id_opp = c.id    and  ');
       MainQuery.SQL.Add('a.id = e.id_nmnt        ');
       MainQuery.SQL.Add('Group by a.CODE, a.Name, d.Code, a.ID ');
       MainQuery.SQL.Add('Order by a.CODE         ');

       MainQuery.ParamByName('period').AsInteger := MonthComboBox.ItemIndex;

       MainQuery.Open;

       If MainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       i := 1;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          add(RepeatLine('-', 111));
          add('');
          add('');
          add(CentrLine('Потребность в материалах',111));
          add(CentrLine('на '+MonthComboBox.Text,111));
          add('');
          add(RepeatLine('-', 111));
          add('Номеноклатурный|                    Наменование                   | Потребность |  Ед-цы  | Наличие на складе |');
          add('    номенр     |                                                  |  по плану   |измерения|         на        |');
          add('               |                                                  |             |         |'+CentrLine(DateTimeToStr(Now),19)+'|');
          add(RepeatLine('-', 111));

          sstr:='';

          //цикл по количеству заказов
          While i-1< MainQuery.RecordCount do
          begin

              PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

              ProcQuery.Close;
              ProcQuery.SQL.Clear;
              ProcQuery.SQL.Add('Select * From ');
              ProcQuery.SQL.Add('REPORT_BALANCE_PROCEDURE(:TYPEDOC, :ID_NMNT, ');
              ProcQuery.SQL.Add(':DATEBEG, :DATEEND, :ID_WRHS, 0, 0)');
              ProcQuery.ParamByName('TYPEDOC').AsInteger:=2;
              ProcQuery.ParamByName('ID_NMNT').AsInteger:= MainQuery.FieldByName('ID').AsInteger;
              ProcQuery.ParamByName('DATEBEG').AsString := '01.01.1900';
              ProcQuery.ParamByName('DATEEND').AsString := DateToStr(Date);
              ProcQuery.ParamByName('ID_WRHS').AsInteger :=0;
              ProcQuery.Open;

              sstr:=RightLine(MainQuery.FieldByName('Code').AsString, 15)+' '+
                    LeftLine(MainQuery.FieldByName('Name').AsString, 50)+' '+
                    RightLine(MainQuery.FieldByName('Sum').AsString, 13)+' '+
                    CentrLine(MainQuery.FieldByName('Code_1').AsString, 9)+' ';
                    RightLine(ProcQuery.FieldByName('ValEnd').AsString, 19);


              MainQuery.Next;
              i:=i+1;
              add(sstr);
          end;
          add(RepeatLine('-', 111));
          add('');
          add('');
          add('');
          add('');
          add('     Технолог (Мастер) ______________________________');
       end;
       PrForm.Destroy;

       Form.Caption := 'Ведомость незавершенного производства';
       Form.Editor.show;
       Form.show;

end;

procedure TReport23Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport23Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport23Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport23Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport23Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  FillPeriod;

end;


{
     Заполнение списка периодов

}
Procedure TReport23Form.FillPeriod;
var Year, Month, Day: Word;
 nYear, nMonth, nDay: Word;     // текущая дата
    j               : integer;
    _date, now      : TDate;
    strMon, strDate : string;
    period          : integer;
begin
   MonthComboBox.Clear;
   Period := 0;
   // заполнение списка периодов
   _date := strtodate('01.01.2000');
   now  := Date; //workdateEdit.text);   // текущая дата
   DecodeDate(now, nYear, nMonth, nDay);

   for j := 0 to (nYear-2000+1)*12 do
    begin
      DecodeDate(_date, Year, Month, Day);
      case Month of
         1 : StrMon := 'Январь';
         2 : StrMon := 'Февраль';
         3 : StrMon := 'Март';
         4 : StrMon := 'Апрель';
         5 : StrMon := 'Май';
         6 : StrMon := 'Июнь';
         7 : StrMon := 'Июль';
         8 : StrMon := 'Август';
         9 : StrMon := 'Сентябрь';
         10 : StrMon := 'Октябрь';
         11 : StrMon := 'Ноябрь';
         12 : StrMon := 'Декабрь';
      end;
      if (year = nyear) and (month = nmonth) then
        Period := j;

      StrDate := StrMon + ' ' + inttostr(Year);
      MonthComboBox.Items.Add(StrDate);

      _date := incmonth(_date, 1);
    end;

//    if CurPlanPeriod.caption <> '' then
//      BoxPlanPeriod.ItemIndex := strtoint(CurPlanPeriod.caption)
//    else
      MonthComboBox.ItemIndex := period;

end;

procedure TReport23Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
