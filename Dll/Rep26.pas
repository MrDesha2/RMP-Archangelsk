{***************************************************************
 *
 * Модуль   : Rep26
 * Описание : Плановая Лимитно-заборная карта
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}


unit Rep26;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXDBCtrl, Mask, ToolEdit, Db, DBTables, EnumForm4Sel, ComCtrls,
  ExtCtrls, DateUtil;

type
  TReport26Form = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    PlanMainQuery: TQuery;
    PlanTableQuery: TQuery;
    PdrQuery: TQuery;
    CstQuery: TQuery;
    PlanPageControl: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    MonthComboBox: TComboBox;
    Label4: TLabel;
    PlanCstCombo: TComboEdit;
    Label5: TLabel;
    PlanPdrCombo: TComboEdit;
    PlanButtonOK: TButton;
    PlanButtonNO: TButton;
    TabSheet2: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    FactButtonOK: TButton;
    FactButtonNO: TButton;
    FactCstCombo: TComboEdit;
    FactPdrCombo: TComboEdit;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    FactMainQuery: TQuery;
    FactTableQuery: TQuery;
    Label3: TLabel;
    SumFactQuery: TQuery;
    SumPlanQuery: TQuery;
    ButtonSelPer: TButton;
    procedure PlanButtonNOClick(Sender: TObject);
    procedure PlanCstComboButtonClick(Sender: TObject);
    procedure PlanCstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PlanPdrComboButtonClick(Sender: TObject);
    procedure PlanPdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PlanButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FillPeriod;
    procedure FactCstComboButtonClick(Sender: TObject);
    procedure FactCstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FactPdrComboButtonClick(Sender: TObject);
    procedure FactPdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FactButtonOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report26Form: TReport26Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.DFM}

procedure TReport26Form.PlanButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport26Form.PlanCstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, PlanCSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport26Form.PlanCstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, PlanCSTCombo, key, Shift, 1) = false then
    PlanCSTComboButtonClick(Sender);

end;

procedure TReport26Form.PlanPdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PlanPdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport26Form.PlanPdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PlanPdrCombo, key, Shift, 1) = false then
    PlanPdrComboButtonClick(Sender);
end;

procedure TReport26Form.FactCstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, FactCSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport26Form.FactCstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, FactCSTCombo, key, Shift, 1) = false then
    FactCSTComboButtonClick(Sender);

end;

procedure TReport26Form.FactPdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, FactPdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);

end;

procedure TReport26Form.FactPdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, FactPdrCombo, key, Shift, 1) = false then
    FactPdrComboButtonClick(Sender);

end;


//Плановая лимитно-заборная карта
procedure TReport26Form.PlanButtonOKClick(Sender: TObject);
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

       PlanMainQuery.SQL.Clear;
       PlanMainQuery.Close;

       PlanMainQuery.SQL.Add('Select a.id, a.code, a.name, e.code, e.name,   ');
       PlanMainQuery.SQL.Add('sum(d.number) as number, a.price ');
       PlanMainQuery.SQL.Add('From JR_PLAN b, DH_Order c, DT_Mtrp d, DH_Rqst f,');
       PlanMainQuery.SQL.Add('Spr_Nmnt a Left Join Spr_Ediz e on e.id = a.id_ediz');
       PlanMainQuery.SQL.Add('Where b.period = :period and ');

       //Параметр = Заказчику
       if (PlanCstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          PlanMainQuery.SQL.Add('f.ID_CST = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PlanPdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          PlanMainQuery.SQL.Add('f.ID_PDR = ' + PdrQuery.Fields[0].asstring + ' and ');

       PlanMainQuery.SQL.Add('c.id = b.id_order and ');
       PlanMainQuery.SQL.Add('d.id_opp = c.id and   ');
       PlanMainQuery.SQL.Add('a.id = d.id_nmnt and  ');
       PlanMainQuery.SQL.Add('e.id = a.id_ediz and  ');
       PlanMainQuery.SQL.Add('f.id = c.id_rqst      ');
       PlanMainQuery.SQL.Add('Group by a.id, a.code, a.name, e.code, e.name, a.price ');

       PlanMainQuery.ParamByName('period').AsInteger := MonthComboBox.ItemIndex;
       PlanMainQuery.Open;

        If PlanMainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       i := 1;
       PrForm.Show;

       Form.Editor.Visible := False;

      // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          //цикл по количеству заказов
          While i-1< PlanMainQuery.RecordCount do
          begin

            PrForm.ProgressBar.Position:=i*100 div PlanMainQuery.RecordCount;

            add(RepeatLine('-', 104));
            add('');
            add(RightLine('Типовая межотраслевая форма № М-8', 104));
            add(RightLine('Утверждена постановлением Госкомстата России', 104));
            add(RightLine('от 30.10.97 г. № 71а', 104));
            add('');
            add('');
            add(CentrLine('Лимитно-заборная карта (план) №__________',104));
            add('');
            add(LeftLine('Организация ________________________________________',104));
            add(RepeatLine('-', 104));
            add('         |           |        |         |             |             |   Корреспондирующий    | Учетная |');
            add('         |           |        |         | Отправитель | Получатель  |         счет           | единица |');
            add(RepeatLine('-', 104));
            add('  Шифр   |   Дата    |Код вида|Вид дея- | структурное | структурное |  счет,  |код аналитичес| выпуска |');
            add('документа|составления|операции|тельности|подразделение|подразделение| субсчет |  кого учета  |продукции|');
            add(RepeatLine('-', 104));
            add(' У 6002  |'+CentrLine(DateToStr(date),11)+'|        |         |             |             |         |              |         |');
            add(RepeatLine('-', 104));
            add('');
            add(RepeatLine('-', 104));
            add('                       Материальные ценности                                   |   Единица измерения   |');
            add(RepeatLine('-', 104));
            add('      наименование, сорт, размер, марка           |номенклатурный|    Шифр     | код |   наименование  |');
            add('                                                  |    номер     |хоз. операции|     |                 |');
            add(RepeatLine('-', 104));
            add(LeftLine(PlanMainQuery.FieldByName('NAME').AsString, 50)+'|'+
                RightLine(PlanMainQuery.FieldByName('CODE').AsString, 14)+'|             |'+
                CentrLine(PlanMainQuery.FieldByName('CODE_1').AsString, 5)+'|'+
                LeftLine(PlanMainQuery.FieldByName('NAME_1').AsString, 17)+'|');

            add(RepeatLine('-', 104));
            add('');
            add(RepeatLine('-', 104));
            add('        Лимит        |   Порядковый номер   | Всего отпущено  |     Цена     |   Сумма без учета НДС,  |');
            add('                     |по складской картотеке|с учетом возврата|  руб., коп.  |        руб., коп.       |');
            add(RepeatLine('-', 104));
            add('                     |                      |                 |'+
            RightLine(PlanMainQuery.FieldByName('Price').AsString, 14)+'|'+RepeatLine(' ', 25)+'|');
            add(RepeatLine('-', 104));
            add('');
            add(RepeatLine('-', 104));
            add('        Дата        |  №Заяки/№Заказа  |  Количество  |  Остаток лимита  |     Подпись заведующего     |');
            add('                    |                  |              |                  |    складом или получателя   |');
            add(RepeatLine('-', 104));

            PlanTableQuery.Close;
            PlanTableQuery.ParamByName('period').AsInteger := MonthComboBox.ItemIndex;
            PlanTableQuery.ParamByName('id').AsInteger := PlanMainQuery.FieldByName('ID').AsInteger;
            PlanTableQuery.Open;

            While not PlanTableQuery.Eof do
            begin
               sstr:=RightLine(PlanTableQuery.FieldByName('date_in').AsString, 20) + '|' +
                     RightLine(PlanTableQuery.FieldByName('NUMBER').AsString + '/' +
                               PlanTableQuery.FieldByName('NUMBER_1').AsString, 18) + '|'+
                     RightLine(PlanTableQuery.FieldByName('Number_2').AsString, 14)+ '|';
               add(sstr);
               PlanTableQuery.Next;
            end;
            add(RepeatLine('-', 104));
            add('');
            add('');
            add('');
            add('Руководитель подразделения,');
            add('установившего лимит                ______________________  ______________________  ______________________');
            add('                                         должность                подпись            расшифровка подписи ');
            add('');
            add('');
            add('Руководитель подразделения,');
            add('получившего материальные ценности  ______________________  ______________________  ______________________');
            add('                                         должность                подпись            расшифровка подписи ');
            add('');
            add('');
            add('');
            add('Заведующий складом                 ______________________  ______________________  ______________________');
            add('                                         должность                подпись            расшифровка подписи ');
            add('');
            add('');
            add('');
            add('"______"__________________________200____г.');
            add(CHR(12));
            i:=i+1;
            PlanMainQuery.Next;
          end;

       end;
       Form.Editor.Visible := True;
       PrForm.Destroy;

       Form.Caption := 'Плановая Лимитно-заборная карта';
       Form.Editor.show;
       Form.show;

end;

procedure TReport26Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  FillPeriod;

end;

{
     Заполнение списка периодов

}
Procedure TReport26Form.FillPeriod;
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

//Фактическая лимитно-заборная карта
procedure TReport26Form.FactButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       sstr : String;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       FactMainQuery.SQL.Clear;
       FactMainQuery.Close;

       FactMainQuery.SQL.Add('Select a.id, a.code, a.name, e.code, e.name,   ');
       FactMainQuery.SQL.Add('sum(d.number) as number, a.price ');
       FactMainQuery.SQL.Add('From DT_Order2 b, DH_Order c, DT_Mtrf d,  DH_Rqst f, ');
       FactMainQuery.SQL.Add('Spr_Nmnt a Left Join Spr_Ediz e on e.id = a.id_ediz');
       FactMainQuery.SQL.Add('Where b.date_end >= :begdate and ');
       FactMainQuery.SQL.Add('b.date_end <= :enddate and ');

       //Параметр = Заказчику
       if (FactCstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          FactMainQuery.SQL.Add('f.ID_CST = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (FactPdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          FactMainQuery.SQL.Add('f.ID_PDR = ' + PdrQuery.Fields[0].asstring + ' and ');

       FactMainQuery.SQL.Add('c.id = b.id_order and ');
       FactMainQuery.SQL.Add('d.id_opf = c.id and   ');
       FactMainQuery.SQL.Add('a.id = d.id_nmnt and  ');
       FactMainQuery.SQL.Add('e.id = a.id_ediz and  ');
       FactMainQuery.SQL.Add('f.id = c.id_rqst and  ');
       FactMainQuery.SQL.Add('b.lineno = d.lineno   ');
       FactMainQuery.SQL.Add('Group by a.id, a.code, a.name, e.code, e.name, a.price ');

       FactMainQuery.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
       FactMainQuery.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);

       FactMainQuery.Open;

        If FactMainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       i := 1;
       PrForm.Show;
       Form.Editor.Visible := False;

      // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          //цикл по количеству заказов
          While i-1< FactMainQuery.RecordCount do
          begin

            PrForm.ProgressBar.Position:=i*100 div FactMainQuery.RecordCount;

            add(RepeatLine('-', 104));
            add('');
            add(RightLine('Типовая межотраслевая форма № М-8', 104));
            add(RightLine('Утвержена постановлением Госкомстата России', 104));
            add(RightLine('от 30.10.97 г. № 71а', 104));
            add('');
            add('');
            add(CentrLine('Лимитно-заборная карта (факт) №__________',104));
            add('');
            add(LeftLine('Организация ________________________________________',104));
            add(RepeatLine('-', 104));
            add('         |           |        |         |             |             |   Корреспондирующий    | Учетная |');
            add('         |           |        |         | Отправитель | Получатель  |         счет           | единица |');
            add(RepeatLine('-', 104));
            add('  Шифр   |   Дата    |Код вида|Вид дея- | структурное | структурное |  счет,  |код аналитичес| выпуска |');
            add('документа|составления|операции|тельности|подразделение|подразделение| субсчет |  кого учета  |продукции|');
            add(RepeatLine('-', 104));
            add(' У 6002  |'+CentrLine(DateToStr(date),11)+'|        |         |             |             |         |              |         |');
            add(RepeatLine('-', 104));
            add('');
            add(RepeatLine('-', 104));
            add('                       Материальные ценности                                   |   Единица измерения   |');
            add(RepeatLine('-', 104));
            add('      наименование, сорт, размер, марка           |номенклатурный|    Шифр     | код |   наименование  |');
            add('                                                  |    номер     |хоз. операции|     |                 |');
            add(RepeatLine('-', 104));
            add(LeftLine(FactMainQuery.FieldByName('NAME').AsString, 50)+'|'+
                RightLine(FactMainQuery.FieldByName('CODE').AsString, 14)+'|             |'+
                CentrLine(FactMainQuery.FieldByName('CODE_1').AsString, 5)+'|'+
                LeftLine(FactMainQuery.FieldByName('NAME_1').AsString, 17)+'|');

            add(RepeatLine('-', 104));
            add('');
            add(RepeatLine('-', 104));
            add('        Лимит        |   Порядковый номер   | Всего отпущено  |     Цена     |   Сумма без учета НДС,  |');
            add('                     |по складской картотеке|с учетом возврата|  руб., коп.  |        руб., коп.       |');
            add(RepeatLine('-', 104));
            add('                     |                      |                 |'+
            RightLine(FactMainQuery.FieldByName('Price').AsString, 14)+'|'+RepeatLine(' ', 25)+'|');
            add(RepeatLine('-', 104));
            add('');
            add(RepeatLine('-', 104));
            add('        Дата        |  №Заяки/№Заказа  |  Количество  |  Остаток лимита  |     Подпись заведующего     |');
            add('                    |                  |              |                  |    складом или получателя   |');
            add(RepeatLine('-', 104));
            add('Отпущено:');

            FactTableQuery.Close;
            FactTableQuery.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
            FactTableQuery.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);
            FactTableQuery.ParamByName('id').AsInteger := FactMainQuery.FieldByName('ID').AsInteger;
            FactTableQuery.Open;

            While not FactTableQuery.Eof do
            begin
               sstr:=RightLine(FactTableQuery.FieldByName('date_in').AsString, 20) + '|' +
                     RightLine(FactTableQuery.FieldByName('NUMBER').AsString + '/' +
                               FactTableQuery.FieldByName('NUMBER_1').AsString, 18) + '|'+
                     RightLine(FactTableQuery.FieldByName('Number_2').AsString, 14)+ '|';
               add(sstr);
               FactTableQuery.Next;
            end;

            //открываю запрос показывающий возврат материалов
            SumPlanQuery.Close;
            SumPlanQuery.ParamByName('id').AsInteger := FactMainQuery.FieldByName('ID').AsInteger;
            SumPlanQuery.ParamByName('begperiod').AsInteger :=
                     (ExtractYear(StrToDate(BegDateEdit.Text)) - 2000)*12+
                      ExtractMonth(StrToDate(BegDateEdit.Text));
            SumPlanQuery.ParamByName('endperiod').AsInteger :=
                     (ExtractYear(StrToDate(EndDateEdit.Text)) - 2000)*12+
                      ExtractMonth(StrToDate(EndDateEdit.Text));
            SumPlanQuery.Open;

            SumFactQuery.Close;
            SumFactQuery.ParamByName('id').AsInteger := FactMainQuery.FieldByName('ID').AsInteger;
            SumFactQuery.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
            SumFactQuery.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);
            SumFactQuery.Open;

            If (SumPlanQuery.FieldByName('SumPlan').AsFloat -
                SumFactQuery.FieldByName('SumFact').AsFloat) > 0 Then
            begin
                 add('Возвращено:'+RightLine(DateToStr(date),9)+'|'+
                      RepeatLine(' ', 18)+'|'+
                      RightLine(FormatFloat('0.000',
                            SumPlanQuery.FieldByName('SumPlan').AsFloat -
                            SumFactQuery.FieldByName('SumFact').AsFloat), 14)+'|');
            end;


            add(RepeatLine('-', 104));
            add('');
            add('');
            add('');
            add('Руководитель подразделения,');
            add('установившего лимит                ______________________  ______________________  ______________________');
            add('                                         должность                подпись            расшифровка подписи ');
            add('');
            add('');
            add('Руководитель подразделения,');
            add('получившего материальные ценности  ______________________  ______________________  ______________________');
            add('                                         должность                подпись            расшифровка подписи ');
            add('');
            add('');
            add('');
            add('Заведующий складом                 ______________________  ______________________  ______________________');
            add('                                         должность                подпись            расшифровка подписи ');
            add('');
            add('');
            add('');
            add('"______"__________________________200____г.');
            add(CHR(12));
            i:=i+1;
            FactMainQuery.Next;
          end;

       end;
       Form.Editor.Visible := True;
       PrForm.Destroy;

       Form.Caption := 'Фактическая Лимитно-заборная карта';
       Form.Editor.show;
       Form.show;

end;

procedure TReport26Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport26Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
