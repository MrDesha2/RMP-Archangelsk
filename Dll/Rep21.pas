{

        Отчет о выполнении плана

}        
unit Rep21;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXDBCtrl, Mask, ToolEdit, EnumForm4Sel, Db, DBTables;

type
  TReport21Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ButtonOK: TButton;
    ButtonNO: TButton;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    CstQuery: TQuery;
    PdrQuery: TQuery;
    MainQuery: TQuery;
    CalcOperQuery: TQuery;
    CalcPMatrQuery: TQuery;
    ItemQuery: TQuery;
    MonthComboBox: TComboBox;
    CheckBox: TCheckBox;
    CalcFMatrQuery: TQuery;
    procedure ButtonNOClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FillPeriod;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report21Form: TReport21Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces;

{$R *.DFM}

procedure TReport21Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport21Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
        i,n : Integer;
         sstr : String;
       tmpstr : String;


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

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
       begin
          MainQuery.ParamByName('cst').AsInteger := CSTQuery.Fields[0].AsInteger;
       end
        else MainQuery.ParamByName('cst').AsInteger:=0;

       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
       begin
          MainQuery.ParamByName('pdr').AsInteger := PdrQuery.Fields[0].AsInteger;
       end
        else MainQuery.ParamByName('pdr').AsInteger:=0;

       MainQuery.ParamByName('period').AsInteger := MonthComboBox.ItemIndex;

       MainQuery.Open;

       If MainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       i := 1;
       if CheckBox.Checked Then n := 151 else n := 124;
       PrForm.Show;
       Form.Editor.Visible := False;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          add(RepeatLine('-', n));
          add('');
          add('');
          add(CentrLine('Отчет о выполнении плана',n));

          //Параметр = Подразделению
          if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active) then
               add(CentrLine('Участком '+ PdrQuery.FieldByName('NAME').AsString, n));
          //Параметр = Заказчику
          if (CstCombo.Text <> '<Object not found>') and (CstQuery.active)then
               add(CentrLine('для заказчика '+ CstQuery.FieldByName('NAME').AsString, n));


          add(CentrLine('на '+MonthComboBox.Text,n));
          add('');
          add(RepeatLine('-', n));
          sstr:='                   |    Вид     |                |Ответственное|  Начало  |Окончание|            |             |             ';
          if CheckBox.Checked Then sstr:=sstr+'|                         |';
          add(sstr);
          sstr:=' № Заявки/№ Заказа |   работ    |     Чертеж     |     МВЗ     |  работы  |  работ  | Получатель |   План СС   |   Факт СС   ';
          if CheckBox.Checked Then sstr:=sstr+'|      Статьи затрат      |';
          add(sstr);
          sstr:='                   |            |                |             |          |         |            |             |             ';
          if CheckBox.Checked Then sstr:=sstr+'|                         |';
          add(sstr);
          add(RepeatLine('-', n));

          //цикл по количеству заказов
          While i-1< MainQuery.RecordCount do
          begin

             PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

             tmpstr:=''; //tmpstr это не tmpPrice :)

             sstr:=RightLine(MainQuery.FieldByName('RQST_NUMBER').AsString + '/' +
                             MainQuery.FieldByName('ORD_NUMBER').AsString, 19)+ ' '+
                   LeftLine(MainQuery.FieldByName('CHRT_VID_CHAR').AsString,12) + ' ' +
                   LeftLine(MainQuery.FieldByName('CHRT_CODE').AsString,16) + ' ' +
                   RightLine(MainQuery.FieldByName('PDR_CODE').AsString, 13) + ' ' +
                   CentrLine(MainQuery.FieldByName('ORD_DATE_IN').AsString, 10) + ' ' +
                   CentrLine(MainQuery.FieldByName('ORD_DATE_OUT').AsString, 9) + ' ' +
                   RightLine(MainQuery.FieldByName('CST_CODE').AsString, 12) + ' ';


              //вывод материаллов
              if (CheckBox.Checked) Then
              begin
                     sStr:=sStr+RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_Mtr_Price').AsFloat),13)+' '+
                              RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_Mtr_Price').AsFloat),13)+' '+
                              LeftLine('Материалы',25);
                     add(sstr);
              end;

              //вывод заработной платы
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_Oper_Price').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_Oper_Price').AsFloat),13)+' '+
                           LeftLine('Заработная плата',25);
                     add(sStr);
              end;

              //вывод Отчисления на соцстрах
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_SOCSTR_PRICE').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_SOCSTR_PRICE').AsFloat),13)+' '+
                           LeftLine('Отчисления на соцстрах',25);
                     add(sStr);
              end;

              //вывод Общепроизводственные расходы
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_OBRASH_PRICE').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_OBRASH_PRICE').AsFloat),13)+' '+
                           LeftLine('Общепроизводственные расходы',25);
                     add(sStr);
              end;

              //вывод Цеховая себестоимость
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_CEHSEB_PRICE').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_CEHSEB_PRICE').AsFloat),13)+' '+
                           LeftLine('Цеховая себестоимость',25);
                     add(sStr);
              end;

              //вывод Общезаводские расходы
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_OBZAV_PRICE').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_OBZAV_PRICE').AsFloat),13)+' '+
                           LeftLine('Общезаводские расходы',25);
                     add(sStr);
              end;

              //вывод Производственные расходы
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_PRRASH_PRICE').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_PRRASH_PRICE').AsFloat),13)+' '+
                           LeftLine('Производственные расходы',25);
                     add(sStr);
              end;

              //вывод Плановые накопления
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_PLANNAK_PRICE').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_PLANNAK_PRICE').AsFloat),13)+' '+
                           LeftLine('Плановые накопления',25);
                     add(sStr);
              end;

              //вывод Полная себестоимость
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_ALLSEB_PRICE').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_ALLSEB_PRICE').AsFloat),13)+' '+
                           LeftLine('Полная себестоимость',25);
                     add(sStr);
              end;

              //вывод НДС
              if (CheckBox.Checked) Then
              begin
                     sStr:=RepeatLine(' ',98)+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_NDS_PRICE').AsFloat),13)+' '+
                           RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_NDS_PRICE').AsFloat),13)+' '+
                           LeftLine('НДС',25);
                     add(sStr);
              end;

              //Всего
              tmpstr:=RightLine(FormatFloat('0.00', MainQuery.FieldByName('P_PLAN_TOTAL_PRICE').AsFloat),13)+' '+
                      RightLine(FormatFloat('0.00', MainQuery.FieldByName('F_PLAN_TOTAL_PRICE').AsFloat),13);

              if CheckBox.Checked  Then
              begin
                 tmpstr:=RepeatLine(' ',98)+tmpstr+' '+LeftLine('Всего',25);
                 add(tmpstr);
                 add('');
              end
               else add(sstr+tmpstr);

              MainQuery.Next;
              i:=i+1;
          end;

       end;
       Form.Editor.Visible := True;
       PrForm.Destroy;

       Form.Caption := 'Ведомость незавершенного производства';
       Form.Editor.show;
       Form.show;

end;

procedure TReport21Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  FillPeriod;
end;

procedure TReport21Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport21Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport21Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);

end;

procedure TReport21Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

{
     Заполнение списка периодов

}
Procedure TReport21Form.FillPeriod;
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

procedure TReport21Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
