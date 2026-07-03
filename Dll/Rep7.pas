unit Rep7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, EnumForm4Sel, Db, DBTables, Mask, ToolEdit;

type
  TReport7Form = class(TForm)
    Label1: TLabel;
    MonthComboBox: TComboBox;
    Button1: TButton;
    Button2: TButton;
    MainQuery: TQuery;
    CstCombo: TComboEdit;
    CstQuery: TQuery;
    Label2: TLabel;
    Label3: TLabel;
    procedure FillPeriod;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
    { Public declarations }
  end;

var
  Report7Form: TReport7Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces;

{$R *.DFM}

Procedure TReport7Form.FillPeriod;
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

procedure TReport7Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  FillPeriod;

end;

procedure TReport7Form.Button2Click(Sender: TObject);
begin
        Close;
end;

procedure TReport7Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       k,i : Integer;
       tmp : Integer; //подсчет количества заказчиков на последнем материале
      sstr : String;
  Cst_Name : String;
  Mat_Name : String;  //наименования группы материалов;
Parent_Name: String;  //наименование производства (родителя cst_name)  
Cst_chrt   : Real;
Cst_plan   : Real;
Cst_fakt   : Real;
Cst_weight_plan_all : Real;
Cst_weight_fakt_all : Real;
Parent_plan   : Real;
Parent_fakt   : Real;
Parent_weight_plan_all : Real;
Parent_weight_fakt_all : Real;
Total_chrt   : Real;
Total_plan   : Real;
Total_fakt   : Real;
Total_weight_plan_all : Real;
Total_weight_fakt_all : Real;
All_Total_chrt : Real;
All_Total_plan : Real;
All_Total_fakt : Real;
All_Total_weight_all_plan : Real;
All_Total_weight_all_fakt : Real;
Parent_Total : Integer;
       Total : Integer;
   All_Total : Integer;
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
       If (CstCombo.Text <> '<Объект не найден>') and (CSTQuery.active) then
       begin
          MainQuery.ParamByName('id_cst').AsInteger := CstQuery.FieldByName('ID').AsInteger;
       end
        else
        begin
           MainQuery.ParamByName('id_cst').AsInteger := 0;
        end;


       MainQuery.ParamByName('period').AsInteger := MonthComboBox.ItemIndex;
       MainQuery.Open;

       If MainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       i := 1;
       PrForm.Show;

       All_Total_chrt := 0;
       All_Total_plan := 0;
       All_Total_fakt := 0;
       All_Total_weight_all_plan := 0;
       All_Total_weight_all_fakt := 0;
       Total_chrt   := 0;
       Total_plan   := 0;
       Total_fakt   := 0;
       Total_weight_plan_all := 0;
       Total_weight_fakt_all := 0;
       All_Total:=0;
       Total:=0;
       Parent_Total  := 0;
       Parent_plan   := 0;
       Parent_fakt   := 0;
       Parent_weight_plan_all := 0;
       Parent_weight_fakt_all := 0;

//       Cst_chrt   := 0;
//       Cst_plan   := 0;
//       Cst_fakt   := 0;
//       Cst_weight_plan_one := 0;
//       Cst_weight_plan_all := 0;
//       Cst_weight_fakt_one := 0;
//       Cst_weight_fakt_all := 0;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          add(RepeatLine('-', 144));
          add('');
          add('');
          add(RightLine('Утверждаю', 133));
          add(RightLine('Главный механик',136));
          add(RightLine(GetSystemParams('Enterprise'),144));
          add('');
          add(RightLine(GetSystemParams('Mechanic'),137));
          add(CentrLine('План отчет литейного цеха',144));
          add(CentrLine(MonthComboBox.Text,144));
          add('');
          add(RepeatLine('-', 144));
          add('   №Заявки  |                                        |                   |Кол-во деталей|       План        |       Факт        |   Дата   |План|');
          add('      /     |       Наименование номенклатуры        |    Код чертежа    |-------|------|-------------------|-------------------|исполнения|Год |');
          add('   №Заказа  |                                        |                   |  по   |  по  |Вес одной|Общий вес|Вес одной|Общий вес|          |Непл|');
          add('            |                                        |                   | плану | факту| детали  |         | детали  |         |          |    |');
          add(RepeatLine('-', 144));

          Mat_Name := MainQuery.FieldByName('MATERIAL_NAME').AsString;

          While not MainQuery.Eof do
          begin

             PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;
             add(Mat_Name);

             Parent_Name := MainQuery.FieldByName('PARENT_CST_NAME').AsString;
             add(' '+UpperCase(Parent_Name));

             Cst_name := MainQuery.FieldByName('CST_NAME').AsString;
             add('  '+Cst_name);

             tmp := 0;
             k := 0;
             Cst_chrt   := 0;
             Cst_plan   := 0;
             Cst_fakt   := 0;
             Cst_weight_plan_all := 0;
             Cst_weight_fakt_all := 0;

             While (Mat_Name = MainQuery.FieldByName('MATERIAL_NAME').AsString) and
                   (not MainQuery.Eof) do
             begin

                While (Parent_Name = MainQuery.FieldByName('PARENT_CST_NAME').AsString) and
                      (Mat_Name = MainQuery.FieldByName('MATERIAL_NAME').AsString) and
                      (not MainQuery.Eof)do
                begin

                     If Cst_name = MainQuery.FieldByName('CST_NAME').AsString Then
                     begin
                        Cst_plan := Cst_plan + MainQuery.FieldByName('PLAN_NUMBER').AsFloat;
                        Cst_fakt := Cst_fakt + MainQuery.FieldByName('FAKT_NUMBER').AsFloat;
                        Cst_chrt := Cst_chrt + MainQuery.FieldByName('WEIGHT_CHRT').AsFloat;
                        Cst_weight_plan_all := Cst_weight_plan_all +
                            MainQuery.FieldByName('WEIGHT_PLAN').AsFloat * MainQuery.FieldByName('PLAN_NUMBER').AsFloat;
                        Cst_weight_fakt_all := Cst_weight_fakt_all +
                            MainQuery.FieldByName('WEIGHT_FAKT').AsFloat * MainQuery.FieldByName('FAKT_NUMBER').AsFloat;
                        k:=k+1;
                        tmp:=tmp+1;
                     end
                      else
                      begin
                         add(RepeatLine('.', 144));
                         add('Итого по '+LeftLine(Cst_Name, 40) + ' поз. '+LeftLine(IntToStr(k),3)+RepeatLine(' ', 16)+
                              RightLine(FormatFloat('0.00',Cst_plan), 7)+' '+
                              RightLine(FormatFloat('0.00',Cst_fakt), 6)+' '+
//   //                         RightLine(FormatFloat('0.00',Cst_chrt), 10)+' '+
                              RepeatLine(' ', 9)+' '+
                              RightLine(FormatFloat('0.000',Cst_Weight_plan_all), 9)+' '+
                              RepeatLine(' ', 9)+' '+
                              RightLine(FormatFloat('0.000',Cst_Weight_fakt_all), 9));
                         add('');

                         Cst_plan   := 0;
                         Cst_fakt   := 0;
                         Cst_chrt   := 0;
                         Cst_weight_plan_all := 0;
                         Cst_weight_fakt_all := 0;
                         k := 0;
                         tmp:=0;

                         Cst_name := MainQuery.FieldByName('CST_NAME').AsString;
                         add('  '+Cst_name);

                         Cst_plan   := Cst_plan + MainQuery.FieldByName('PLAN_NUMBER').AsFloat;
                         Cst_fakt   := Cst_fakt + MainQuery.FieldByName('FAKT_NUMBER').AsFloat;
                         Cst_chrt   := Cst_chrt + MainQuery.FieldByName('WEIGHT_CHRT').AsFloat;
                         Cst_weight_plan_all := Cst_weight_plan_all +
                             MainQuery.FieldByName('WEIGHT_PLAN').AsFloat * MainQuery.FieldByName('PLAN_NUMBER').AsFloat;
                         Cst_weight_fakt_all := Cst_weight_fakt_all +
                             MainQuery.FieldByName('WEIGHT_FAKT').AsFloat * MainQuery.FieldByName('FAKT_NUMBER').AsFloat;

                         k:=k+1;
                      end;

                     add(RightLine(MainQuery.FieldByName('RQST_NUMBER').AsString+'/'+
                                   MainQuery.FieldByName('ORDER_NUMBER').AsString,12)+' '+
                         LeftLine(MainQuery.FieldByName('NMNT_NAME').AsString, 40)+' '+
                         LeftLine(MainQuery.FieldByName('CHRT_CODE').AsString, 19)+' '+
//   //                    LeftLine(MainQuery.FieldByName('MATERIAL_NAME').AsString, 10)+' '+
                         RightLine(FormatFloat('0.00',MainQuery.FieldByName('PLAN_NUMBER').AsFloat), 7)+' '+
                         RightLine(FormatFloat('0.00',MainQuery.FieldByName('FAKT_NUMBER').AsFloat), 6)+' '+
//   //                    RightLine(FormatFloat('0.00',MainQuery.FieldByName('WEIGHT_CHRT').AsFloat), 10)+' '+
                         RightLine(FormatFloat('0.000',MainQuery.FieldByName('WEIGHT_PLAN').AsFloat), 9)+' '+
                         RightLine(FormatFloat('0.000',MainQuery.FieldByName('WEIGHT_PLAN').AsFloat *
                                                       MainQuery.FieldByName('PLAN_NUMBER').AsFloat), 9)+' '+
                         RightLine(FormatFloat('0.000',MainQuery.FieldByName('WEIGHT_FAKT').AsFloat), 9)+' '+
                         RightLine(FormatFloat('0.000',MainQuery.FieldByName('WEIGHT_FAKT').AsFloat *
                                                       MainQuery.FieldByName('FAKT_NUMBER').AsFloat), 9)+' '+
                         CentrLine(MainQuery.FieldByName('DATE_OUT').AsString, 10)+ ' ' +
                         CentrLine(MainQuery.FieldByName('VID_ZAK').AsString, 4));

                     Parent_plan := Parent_plan + MainQuery.FieldByName('PLAN_NUMBER').AsFloat;
                     Parent_fakt := Parent_fakt + MainQuery.FieldByName('FAKT_NUMBER').AsFloat;
                     Parent_weight_plan_all := Parent_weight_plan_all +
                        MainQuery.FieldByName('WEIGHT_PLAN').AsFloat * MainQuery.FieldByName('PLAN_NUMBER').AsFloat;
                     Parent_weight_fakt_all := Parent_weight_fakt_all +
                        MainQuery.FieldByName('WEIGHT_FAKT').AsFloat * MainQuery.FieldByName('FAKT_NUMBER').AsFloat;
                     Parent_Total:=Parent_Total+1;

                     MainQuery.Next;
                     i:=i+1;
                end;

                If tmp > 1 Then  // если на последнем материале было несколько заказчиков
                begin
                       add(RepeatLine('.', 144));
                       add('Итого по '+LeftLine(Cst_Name, 40) + ' поз. '+LeftLine(IntToStr(k),3)+RepeatLine(' ', 16)+
                            RightLine(FormatFloat('0.00',Cst_plan), 7)+' '+
                            RightLine(FormatFloat('0.00',Cst_fakt), 6)+' '+
//   //                       RightLine(FormatFloat('0.00',Cst_chrt), 10)+' '+
                            RepeatLine(' ', 9)+' '+
                            RightLine(FormatFloat('0.000',Cst_Weight_plan_all), 9)+' '+
                            RepeatLine(' ', 9)+' '+
                            RightLine(FormatFloat('0.000',Cst_Weight_fakt_all), 9));
                       add('');
                end;

                Cst_plan   := 0;
                Cst_fakt   := 0;
                Cst_chrt   := 0;
                Cst_weight_plan_all := 0;
                Cst_weight_fakt_all := 0;
                tmp := 0;
                k := 0;
                
                add(RepeatLine('-', 144));
                add('Итого по '+LeftLine(Parent_Name, 40) + ' поз. '+LeftLine(IntToStr(Parent_Total),3)+RepeatLine(' ', 16)+
                     RightLine(FormatFloat('0.00',Parent_plan), 7)+' '+
                     RightLine(FormatFloat('0.00',Parent_fakt), 6)+' '+
//                  RightLine(FormatFloat('0.00',Total_chrt), 10)+' '+
                     RepeatLine(' ', 9)+' '+
                     RightLine(FormatFloat('0.000',Parent_weight_plan_all), 9)+' '+
                     RepeatLine(' ', 9)+' '+
                     RightLine(FormatFloat('0.000',Parent_weight_fakt_all), 9));
                add('');

                //Если мы не перешли на новый материал то достаем новое производство и участки
                If (Mat_Name = MainQuery.FieldByName('MATERIAL_NAME').AsString) Then
                begin

                   If (Parent_Name <> MainQuery.FieldByName('PARENT_CST_NAME').AsString) Then
                   begin
                     Parent_Name := MainQuery.FieldByName('PARENT_CST_NAME').AsString;
                     add(' '+UpperCase(Parent_Name));
                   end;
                   
                   If (Cst_name <> MainQuery.FieldByName('CST_NAME').AsString) Then
                   begin
                      Cst_name := MainQuery.FieldByName('CST_NAME').AsString;
                      add('  '+Cst_name);
                   end;
                end;
                   
                Total_plan := Total_plan + Parent_Plan;
                Total_fakt := Total_fakt + Parent_Fakt;
//                Total_Chrt   := Total_Chrt + MainQuery.FieldByName('WEIGHT_CHRT').AsFloat;
                Total_weight_plan_all := Total_weight_plan_all + Parent_weight_plan_all;
                Total_weight_fakt_all := Total_weight_fakt_all + Parent_weight_fakt_all;
                Total:=Total+Parent_Total;

                Parent_Total  := 0;
                Parent_plan   := 0;
                Parent_fakt   := 0;
                Parent_weight_plan_all := 0;
                Parent_weight_fakt_all := 0;

             end;

             add(RepeatLine('*', 144));
             add('Итого по '+LeftLine(Mat_Name, 40) + ' поз. '+LeftLine(IntToStr(Total),3)+RepeatLine(' ', 16)+
                  RightLine(FormatFloat('0.00',Total_plan), 7)+' '+
                  RightLine(FormatFloat('0.00',Total_fakt), 6)+' '+
//                  RightLine(FormatFloat('0.00',Total_chrt), 10)+' '+
                  RepeatLine(' ', 9)+' '+
                  RightLine(FormatFloat('0.000',Total_weight_plan_all), 9)+' '+
                  RepeatLine(' ', 9)+' '+
                  RightLine(FormatFloat('0.000',Total_weight_fakt_all), 9));
             add('');

             Mat_Name := MainQuery.FieldByName('MATERIAL_NAME').AsString;
//             add(Mat_Name);

             All_Total_plan   := All_Total_plan + Total_plan;
             All_Total_fakt   := All_Total_fakt + Total_fakt;
             All_Total_chrt   := All_Total_chrt + Total_chrt;
             All_Total_weight_all_plan := All_Total_weight_all_plan + Total_weight_plan_all;
             All_Total_weight_all_fakt := All_Total_weight_all_fakt + Total_weight_fakt_all;
             All_Total := All_Total+Total;

             Total_plan   := 0;
             Total_fakt   := 0;
             Total_chrt   := 0;
             Total_weight_plan_all := 0;
             Total_weight_fakt_all := 0;
             Total := 0;
          end;
          add(RepeatLine('=', 144));
          add('   Всего:'+RepeatLine(' ', 40) + ' поз. '+LeftLine(IntToStr(All_Total),3)+RepeatLine(' ', 16)+
               RightLine(FormatFloat('0.00', All_Total_plan), 7)+' '+
               RightLine(FormatFloat('0.00', All_Total_fakt), 6)+' '+
//               RightLine(FormatFloat('0.00', All_Total_chrt), 10)+' '+
               RepeatLine(' ', 9)+' '+
               RightLine(FormatFloat('0.000',All_Total_weight_all_plan), 9)+' '+
               RepeatLine(' ', 9)+' '+
               RightLine(FormatFloat('0.000',All_Total_weight_all_fakt), 9));
          add('');
          add('');
          add('');
          add('   Начальник РМП'+RepeatLine(' ', 71)
            +GetSystemParams('Manager'));
          add('');
          add('');
          add('   Начальник литейного цеха'+RepeatLine(' ', 60)+'Кузнецов С.А.');
       end;
       PrForm.Destroy;

       Form.Caption := 'План по литью';
       Form.Editor.show;
       Form.show;
end;

procedure TReport7Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport7Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport7Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
