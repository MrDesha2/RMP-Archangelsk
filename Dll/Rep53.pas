unit Rep53;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, DB, DBTables, EnumForm4Sel, ExtCtrls;

type
  TReport53Form = class(TForm)
    Label1: TLabel;
    Label5: TLabel;
    PdrCombo: TComboEdit;
    Label4: TLabel;
    CstCombo: TComboEdit;
    PdrQuery: TQuery;
    PrintButton: TButton;
    CloseButton: TButton;
    Label6: TLabel;
    OperCombo: TComboEdit;
    CstQuery: TQuery;
    OperQuery: TQuery;
    MainQuery: TQuery;
    MonthComboBox: TComboBox;
    Label2: TLabel;
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OperComboButtonClick(Sender: TObject);
    procedure OperComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrintButtonClick(Sender: TObject);
    procedure FillPeriod;
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report53Form: TReport53Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport53Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport53Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport53Form.CloseButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TReport53Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport53Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  FillPeriod;
end;

procedure TReport53Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CstQuery, CstCombo, 'select id, code, name from spr_cst',
                        'Справочник: Заказчики (Выбор)', 0);
end;

procedure TReport53Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CstQuery, CstCombo, key, Shift, 1) = false then
    CstComboButtonClick(Sender);
end;

procedure TReport53Form.OperComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, OperQuery, OperCombo, 'select id, code, name from spr_vop',
                        'Справочник: Опеарции (Выбор)', 0);
end;

procedure TReport53Form.OperComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(OperQuery, OperCombo, key, Shift, 1) = false then
    OperComboButtonClick(Sender);
end;

{
     Заполнение списка периодов

}
Procedure TReport53Form.FillPeriod;
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

      MonthComboBox.ItemIndex := period;

end;


procedure TReport53Form.PrintButtonClick(Sender: TObject);
Var    Form   : TShowPrintForm;
       PrForm : TProcessForm;
       i, j   : integer;
       sstr   : string;
       StrCst : string;
       StrPdr : string;
       StrOper: string;
       Tot_plan : real;
       Tot_fact : real;
       Total_plan : real;
       Total_fact : real;
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

       MainQuery.SQL.Add('Select CODE_PDR, NAME_PDR, NAME_CST, NAME_OPER, sum(PLANTIME) as PLANOPER, sum(FACTTIME) as FACTOPER');
       MainQuery.SQL.Add('From REPORT_53_PROCEDURE(:PERIOD, :ID_PDR, :ID_CST, :ID_OPER)');
       MainQuery.SQL.Add('Group By 1, 2, 3, 4');
       MainQuery.SQL.Add('Order By 2, 3, 4');

       MainQuery.ParamByName('PERIOD').AsInteger := MonthComboBox.ItemIndex;

//       ShowMessage(IntToStr(MonthComboBox.ItemIndex));

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('ID_Pdr').AsInteger := -1
        else
               MainQuery.ParamByName('ID_Pdr').AsInteger := PdrQuery.FieldByName('ID').AsInteger;

       If (CstCombo.Text = '') or (CstCombo.Text = '<Объект не найден>') or (not CstQuery.active) Then
            MainQuery.ParamByName('ID_Cst').AsInteger := -1
        else
               MainQuery.ParamByName('ID_Cst').AsInteger := CstQuery.FieldByName('ID').AsInteger;

       If (OperCombo.Text = '') or (OperCombo.Text = '<Объект не найден>') or (not OperQuery.active) Then
            MainQuery.ParamByName('ID_Oper').AsInteger := -1
        else
               MainQuery.ParamByName('ID_Oper').AsInteger := OperQuery.FieldByName('ID').AsInteger;

       MainQuery.Open;
       MainQuery.First;

       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;
          j := 0;
          StrCst  := '';
          StrPdr  := '';
          StrOper := '';
          sstr    := '';
          Tot_plan   := 0;
          Tot_fact   := 0;
          Total_plan := 0;
          Total_fact := 0;

          While not MainQuery.Eof do
          begin
             add('');
             add('');
             add(RightLine(DateToStr(date),100));
             add(RightLine(TimeToStr(time),100));
             add('');
             add(CentrLine('Отчёт по станко-часам за '+MonthComboBox.Text, 102));
             add(CentrLine('по подразделению ' + '('+MainQuery.FieldByName('CODE_PDR').AsString+') '+
                       MainQuery.FieldByName('NAME_PDR').AsString, 102));
             add('');
             add(RepeatLine('-', 102));
             add('          Заказчик          |        Операция        | Запланировано |   Выполнено   |    Процент    |');
             add('                            |                        |               |               |   выполнения  |');
             add(RepeatLine('-', 102));

             StrPdr := MainQuery.FieldByName('NAME_PDR').AsString;

             While (StrPdr = MainQuery.FieldByName('NAME_PDR').AsString) and
                    not MainQuery.Eof do
             begin

                if (StrCst <> MainQuery.FieldByName('NAME_CST').AsString) Then
                   sstr := LeftLine(MainQuery.FieldByName('NAME_CST').AsString, 28)+'|';

                StrCst := MainQuery.FieldByName('NAME_CST').AsString;

                //заполняем таблицу пока название заказчика по плану меньше названия по факту
                While (StrCst = MainQuery.FieldByName('NAME_CST').AsString) and
                          not MainQuery.Eof do
                begin

                      PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                      sstr:=sstr + LeftLine(MainQuery.FieldByName('NAME_OPER').AsString, 24)+'|'+
                                   RightLine(FormatFloat('0.000',MainQuery.FieldByName('PLANOPER').AsFloat), 15)+'|'+
                                   RightLine(FormatFloat('0.000',MainQuery.FieldByName('FACTOPER').AsFloat), 15)+'|';
                      If MainQuery.FieldByName('PLANOPER').AsFloat = 0 Then
                          sstr := sstr + RightLine('- ', 15)+'|'
                       else
                            sstr := sstr + RightLine(FormatFloat('0.00',MainQuery.FieldByName('FACTOPER').AsFloat*100/MainQuery.FieldByName('PLANOPER').AsFloat)+'%', 15)+'|';

                      add(sstr);

                      sstr := RepeatLine(' ', 28)+'|';
                      
                      Tot_plan := Tot_plan + MainQuery.FieldByName('PLANOPER').AsFloat;
                      Tot_fact := Tot_fact + MainQuery.FieldByName('FACTOPER').AsFloat;

                      MainQuery.Next;
                      i:=i+1;
                      j:=j+1;

                end;

                Total_plan := Total_plan + Tot_plan;
                Total_fact := Total_fact + Tot_fact;

                If ( j > 1 ) Then
                begin
                   add(RepeatLine('-',102));
                   add(RightLine('Итого по заказчику:', 53)+ ' '+
                       RightLine(FormatFloat('0.000',Tot_plan), 15)+ ' '+
                       RightLine(FormatFloat('0.000',Tot_fact), 15)+ ' ');
                   add(RepeatLine('-',102));
                end;

                Tot_plan := 0;
                Tot_fact := 0;
                j := 0;

             end;

                add(RepeatLine('=',102));
                add(RightLine('Всего по заказчику:', 53)+ ' '+
                    RightLine(FormatFloat('0.000',Total_plan), 15)+ ' '+
                    RightLine(FormatFloat('0.000',Total_fact), 15)+ ' ');

                Total_plan := 0;
                Total_fact := 0;

          end
       end;

       PrForm.Destroy;

       Form.Caption := 'Отчёт по станко-часам по подразделениям';
       Form.Editor.show;
       Form.show;

end;

end.
