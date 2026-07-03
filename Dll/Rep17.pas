{***************************************************************
 *
 * Модуль   : Rep17
 * Описание :
 *   Форма построения отчета
 *   План-факт по выполненным работам.
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep17;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, StdCtrls, Db, ToolEdit, Mask, EnumForm4Sel;

type
  TReport17Form = class(TForm)
    PDRCombo: TComboEdit;
    Label3: TLabel;
    Label1: TLabel;
    qPDRQuery: TQuery;
    OKButton: TButton;
    CancelButton: TButton;
    MainQuery: TQuery;
    MonthComboBox: TComboBox;
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FillPeriod;
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;

  end;

var
  Report17Form: TReport17Form;



implementation

uses PrintFrm, printlibs, PrintProces, libs;


{$R *.DFM}

procedure TReport17Form.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPDRQuery, PDRCombo, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);



end;

procedure TReport17Form.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPDRQuery, PDRCombo, key, Shift, 1) = false then
    PDRComboButtonClick(Sender);


end;


{
   Выполнение запроса

}
procedure TReport17Form.CancelButtonClick(Sender: TObject);
begin
  close;
end;

procedure TReport17Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport17Form.OKButtonClick(Sender: TObject);
var
    s_1, s_2, s_3, s_4 : Real;
    Total1, Total2, Total3, Total4 : Real;
    PDR_ID : Integer;
    i : Integer;
    Form : TShowPrintForm;
  PrForm : TProcessForm;

begin
       Form    := TShowPrintForm.create(application);
       PrForm  := TProcessForm.create(application);

       If MonthComboBox.ItemIndex = -1 Then
        begin
          MessageDlg('Период не определен!', mtWarning , [mbYes], 0);
          Exit;
        end;
        // заполнение параметров
        MainQuery.Close;
{        if qPDRQuery.active then
             MainQuery.ParamByName('id').AsInteger:=qPDRQuery.FieldByName('id').asinteger
         else
         begin
              MessageDlg('Участок не определен !', mtWarning , [mbYes], 0);
              Exit;
         end;}

        MainQuery.parambyname('nmonth').AsInteger := MonthComboBox.ItemIndex;

        //Параметр = Подразделению
        if (PdrCombo.Text <> '<Object not found>') and (qPdrQuery.active)then
           MainQuery.ParamByName('ID_PDR').AsInteger := qPdrQuery.Fields[0].AsInteger
         else MainQuery.ParamByName('ID_PDR').AsInteger := 0;

        Total1 := 0;
        Total2 := 0;
        Total3 := 0;
        Total4 := 0;

        MainQuery.Open;

        i := 1;
        PrForm.Show;

        // формирование строк
        with Form.Editor.Lines do
        begin

           add('');
           add(RepeatLine(' ',71)+'Утверждаю');
           add(RepeatLine(' ',66)+'Главный механик РМП');
           add(RepeatLine(' ',65)+ GetSystemParams('Enterprise'));
           add('');
           add('');

           While not MainQuery.Eof do
           begin

              PDR_ID := MainQuery.FieldByName('MAIN_ID_PDR').AsInteger;

              s_1 := 0;
              s_2 := 0;
              s_3 := 0;
              s_4 := 0;

              add('');
              add(CentrLine('План-факт выполнения работ', 89));
              add(CentrLine('цеха (участка) '+ MainQuery.FieldByName('NAME_PDR').AsString,89));
              add(CentrLine('на ' + MonthComboBox.Text , 89));
              add(RepeatLine('=', 89));
              add('             Заказчик              |     Объем работ в руб.     |      Номенклатура ');
              add(RepeatLine(' ', 35)+'|'+RepeatLine('-', 53));
              add(RepeatLine(' ', 35)+'|    План     |    Факт      |   План    |    Факт    ');
              add(RepeatLine('=', 89));

              While (MainQuery.FieldByName('MAIN_ID_PDR').AsInteger = PDR_ID) and
                     (not MainQuery.Eof) do
              begin

                 PrForm.ProgressBar.Position:=(i)*100 div MainQuery.RecordCount;
                 add(LeftLine(MainQuery.FieldByName('NAME_CST').AsString,35)+' '+
                     RightLine(FormatFloat('0.00', MainQuery.FieldByName('PLAN_TOTAL_PRICE').AsFloat),13)+' '+
                     RightLine(FormatFloat('0.00', MainQuery.FieldByName('FAKT_TOTAL_PRICE').AsFloat),14)+' '+
                     RightLine(FormatFloat('0.000', MainQuery.FieldByName('PCOUNT').AsFloat),11)+' '+
                     RightLine(FormatFloat('0.000', MainQuery.FieldByName('FCOUNT').AsFloat),12));

                 s_1 := s_1 + MainQuery.FieldByName('PLAN_TOTAL_PRICE').AsFloat;
                 s_2 := s_2 + MainQuery.FieldByName('FAKT_TOTAL_PRICE').AsFloat;
                 s_3 := s_3 + MainQuery.FieldByName('PCOUNT').AsFloat;
                 s_4 := s_4 + MainQuery.FieldByName('FCOUNT').AsFloat;

                 MainQuery.Next;
              end;
              add(RepeatLine('-', 89));
              add(RepeatLine(' ', 30)+'Итого '+
                  RightLine(FormatFloat('0.00', s_1),13)+' '+
                  RightLine(FormatFloat('0.00', s_2),14)+' '+
                  RightLine(FormatFloat('0.000', s_3),11)+' '+
                  RightLine(FormatFloat('0.000', s_4),12));
              add('');
              add('');

              Total1 := Total1 + s_1;
              Total2 := Total2 + s_2;
              Total3 := Total3 + s_3;
              Total4 := Total4 + s_4;
           end;
           add('');
           add(RepeatLine('=', 89));
           add(RepeatLine(' ', 30)+'Всего '+
               RightLine(FormatFloat('0.00', Total1),13)+' '+
               RightLine(FormatFloat('0.00', Total2),14)+' '+
               RightLine(FormatFloat('0.000', Total3),11)+' '+
               RightLine(FormatFloat('0.000', Total4),12));

           add('');
           add('');
           add('');
           add('      Начальник РМП'
                + '_______________________ '
                + GetSystemParams('Manager'));
           add('');
           add('');
           add('');
           add('      Экономист РМП'
                 + GetSystemParams('Service')
                 + ' _______________________ '
                 + GetSystemParams('Economist'));
           add('');
           add('');
           add('');
           add('      Начальник цеха (ст. мастер)');

        end;

        PrForm.Destroy;

        Form.Caption := 'Отчет план-факт выполненных работ';
        Form.Editor.show;
        Form.show;


end;

procedure TReport17Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  FillPeriod;

end;

{
     Заполнение списка периодов

}
Procedure TReport17Form.FillPeriod;
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


end.
