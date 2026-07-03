unit Rep6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, EnumForm4Sel, Db, DBTables, Mask, ToolEdit;

type
  TReport6Form = class(TForm)
    MonthComboBox: TComboBox;
    Label4: TLabel;
    CstCombo: TComboEdit;
    Label5: TLabel;
    PdrCombo: TComboEdit;
    Label7: TLabel;
    RqstEdit: TEdit;
    Label8: TLabel;
    OrderEdit: TEdit;
    Label2: TLabel;
    CstQuery: TQuery;
    PdrQuery: TQuery;
    ChrtCombo: TComboEdit;
    Label1: TLabel;
    NMNTCombo: TComboEdit;
    Label3: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label9: TLabel;
    ChrtToNmntQuery: TQuery;
    ChrtQuery: TQuery;
    NmntToChrtQuery: TQuery;
    MainQuery: TQuery;
    qNMNTQuery: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure FillPeriod;
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChrtComboButtonClick(Sender: TObject);
    procedure ChrtComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ChrtComboEnter(Sender: TObject);
    procedure NMNTComboEnter(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report6Form: TReport6Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces;

{$R *.DFM}

Procedure TReport6Form.FillPeriod;
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


procedure TReport6Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  FillPeriod;
end;

procedure TReport6Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);
end;

procedure TReport6Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport6Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport6Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport6Form.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qNMNTQuery, NMNTCombo, 'select id, code, name from spr_nmnt',
                        'Справочник: Номенклатура (Выбор)', 0);
  //Ищу по заданной номенклатуре чертеж 
  NmntToChrtQuery.Close;
  NmntToChrtQuery.ParamByName('id').AsInteger := qNmntQuery.FieldByName('id').AsInteger;
  NmntToChrtQuery.Open;

  if (NmntToChrtQuery.FieldByName('id').isNull) and
     (NmntToChrtQuery.FieldByName('id').AsInteger <> 0) Then
  begin
     //По найденному чертежу открываю запрос ChrtQuery для его активизации и
     // в ChrtCombo.Text ставим наименование чертежа

     ChrtCombo.Text := NmntToChrtQuery.FieldByName('name').AsString;
     ChrtQuery.Close;
     ChrtQuery.ParamByName('id').AsInteger := NmntToChrtQuery.FieldByName('id').AsInteger;
     ChrtQuery.ParamByName('code').AsInteger := NmntToChrtQuery.FieldByName('code').AsInteger;
     ChrtQuery.Open;
  end
   else
   begin
      MessageDlg('У номенклатуры отсутствует чертеж!', mtWarning , [mbYes], 0);
      qNMNTQuery.Close;
      qNMNTQuery.Active := False;
      NmntToChrtQuery.Close;
      NmntToChrtQuery.Active := False;
   end;
end;

procedure TReport6Form.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qNMNTQuery, NMNTCombo, key, Shift, 1) = false then
    NMNTComboButtonClick(Sender);
end;

procedure TReport6Form.ChrtComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, ChrtQuery, ChrtCombo, 'select id, code, name from spr_chrt',
                        'Справочник: Чертежи (Выбор)', 0);

  //Ищу по заданному чертежу номенклатуру
  ChrtToNmntQuery.Close;
  ChrtToNmntQuery.ParamByName('id').AsInteger := ChrtQuery.FieldByName('id').AsInteger;
  ChrtToNmntQuery.Open;

  if (ChrtToNmntQuery.FieldByName('id').IsNull) and
     (ChrtToNmntQuery.FieldByName('id').AsInteger <> 0) Then
  begin
     //По найденной номенклатуре открываю запрос qNMNTQuery для его активизации и
     // в NMNTCombo.Text ставим наименование номенклатуры

     NMNTCombo.Text := ChrtToNmntQuery.FieldByName('name').AsString;
     qNMNTQuery.Close;
     qNMNTQuery.ParamByName('id').AsInteger := ChrtToNmntQuery.FieldByName('id').AsInteger;
     qNMNTQuery.ParamByName('code').AsInteger := ChrtToNmntQuery.FieldByName('code').AsInteger;
     qNMNTQuery.Open;
  end
   else NMNTCombo.Text := '';
end;

procedure TReport6Form.ChrtComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(ChrtQuery, ChrtCombo, key, Shift, 1) = false then
    ChrtComboButtonClick(Sender);
end;

procedure TReport6Form.ChrtComboEnter(Sender: TObject);
begin
        ChrtToNmntQuery.Close;
        ChrtToNmntQuery.ParamByName('id').AsInteger := ChrtQuery.FieldByName('id').AsInteger;
        ChrtToNmntQuery.Open;
        If (ChrtToNmntQuery.FieldByName('name').AsString <>'')  Then
        begin
           NMNTCombo.Text := ChrtToNmntQuery.FieldByName('name').AsString;
        end;
end;

procedure TReport6Form.NMNTComboEnter(Sender: TObject);
begin
        NmntToChrtQuery.Close;
        NmntToChrtQuery.ParamByName('id').AsInteger := qNmntQuery.FieldByName('id').AsInteger;
        NmntToChrtQuery.Open;
        If (NmntToChrtQuery.FieldByName('name').AsString <>'')  Then
        begin
           ChrtCombo.Text := NmntToChrtQuery.FieldByName('name').AsString;
        end;

end;

procedure TReport6Form.Button2Click(Sender: TObject);
begin
        Close;   
end;

procedure TReport6Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
        i,j : Integer;
       sstr1 : String;
       sstr2 : String;
  Parent_Cst : String;
        sCst : String;
      lMonth : Boolean;
     Sum_out : Real;
    Sum_plan : Real;
    Sum_fact : Real;
         Num : Integer; //Количество записей в запросе
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
       MainQuery.SQL.Add('Select *');
       MainQuery.SQL.Add('From REPORT_6_PROCEDURE(:period, :num_rqst, ');
       MainQuery.SQL.Add(':num_order, :id_cst, :id_pdr, :id_chrt)');

       MainQuery.ParamByName('period').AsInteger := MonthComboBox.ItemIndex;
       If RqstEdit.Text<>'' Then
           try
              MainQuery.ParamByName('num_rqst').AsInteger := StrToInt(RqstEdit.Text);
           except
               MessageDlg('Возможно номер заявки содержит ошибку', mtWarning, [mbOk], 0);
               Exit;
           end
        else MainQuery.ParamByName('num_rqst').AsInteger := 0;

       If OrderEdit.Text<>'' Then
           try
              MainQuery.ParamByName('num_order').AsInteger := StrToInt(OrderEdit.Text);
           except
               MessageDlg('Возможно номер заказа содержит ошибку', mtWarning, [mbOk], 0);
               Exit;
           end
        else MainQuery.ParamByName('num_order').AsInteger := 0;

       If (Not CSTQuery.Eof) and (CSTQuery.active) then          
       begin
           MainQuery.ParamByName('id_cst').AsInteger := CSTQuery.Fields[0].AsInteger;
       end
        else MainQuery.ParamByName('id_cst').AsInteger := 0;

       If (PdrCombo.Text <> '<Объект не найден>') and (PdrQuery.active) then
       begin
           MainQuery.ParamByName('id_pdr').AsInteger := PdrQuery.Fields[0].AsInteger;
       end
        else MainQuery.ParamByName('id_pdr').AsInteger := 0;

       If (ChrtCombo.Text <> '<Объект не найден>') and
          (ChrtQuery.active) and (ChrtCombo.Text <> '') then
       begin
           MainQuery.ParamByName('id_chrt').AsInteger := ChrtQuery.Fields[0].AsInteger;
       end
        else MainQuery.ParamByName('id_chrt').AsInteger := 0;

{       If (NMNTCombo.Text <> '<Объект не найден>') and
          (qNmntQuery.active) and (NMNTCombo.Text <> '')then
       begin
           MainQuery.ParamByName('id_nmnt').AsInteger := qNmntQuery.Fields[0].AsInteger;
       end
        else MainQuery.ParamByName('id_nmnt').AsInteger := Null;}

       MainQuery.Open;
       If MainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       i := 1;
       Sum_out  := 0;
       Sum_plan := 0;
       Sum_fact := 0;
       lMonth := True; //разрешение печатать номера месяцов
       Num := MainQuery.RecordCount;

       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          While (not MainQuery.Eof) do
          begin

             add('');
             add('');
             add(RepeatLine('-', 168));
             add(CentrLine('Выполнение заказов '
                +GetSystemParams('Service'),168));
             add(CentrLine('с ' + MonthComboBox.Items.Strings[MainQuery.FieldByName('NUM_MONTH').AsInteger]+
                           ' по '+ MonthComboBox.Items.Strings[MonthComboBox.ItemIndex], 168));
             add(CentrLine('Для производства ' +
                            Trim(MainQuery.FieldByName('NAME_PARENT_CST').AsString), 168));
             Parent_Cst := MainQuery.FieldByName('CODE_PARENT_CST').AsString;

             //Цикл по производству
             While (Parent_Cst = MainQuery.FieldByName('CODE_PARENT_CST').AsString) and
                   (not MainQuery.Eof) do
             begin

                PrForm.ProgressBar.Position:=(i)*100 div Num; //MainQuery.RecordCount;

                add('');
                add('');
                add(LeftLine(Trim(MainQuery.FieldByName('CODE_CST').AsString)+' '+
                             Trim(MainQuery.FieldByName('NAME_CST').AsString),60));
                add(RepeatLine('-', 168));
                sstr1:=CentrLine('Чертеж', 18);
                sstr2:='';
                sCst :=MainQuery.FieldByName('CODE_CST').AsString;
                lMonth := True; //разрешение печатать номера месяцов

                //Цикл по заказчику
                While (sCst = MainQuery.FieldByName('CODE_CST').AsString) and
                      (not MainQuery.Eof) do
                begin

                   If Length(Trim(MainQuery.FieldByName('CODE_CHRT').AsString))>2 Then
                       //только код чертежа
                       sstr2:=sstr2+LeftLine(Trim(MainQuery.FieldByName('CODE_CHRT').AsString), 18)
                    else
                        //код чертежа + наименование чертежа
                        sstr2:=sstr2+LeftLine(Trim(MainQuery.FieldByName('CODE_CHRT').AsString)+' '+
                             Trim(MainQuery.FieldByName('NAME_CST').AsString),18);

//                   ShowMessage('MainQuery.FieldByName(NUM_MONTH) = '+MainQuery.FieldByName('NUM_MONTH').AsString);
                   For j:=1 to 12 do
                   begin
                      //печатать номеров месяцов
                      If lMonth Then
                         sstr1:=sstr1+'|'+CentrLine(IntToStr(MainQuery.FieldByName('NUM_MONTH').AsInteger -
                                  TRUNC(MainQuery.FieldByName('NUM_MONTH').AsInteger/12)*12 + 1),9);

{                      If MessageDlg('NUM_MONTH = '+MainQuery.FieldByName('NUM_MONTH').AsString+ '    sstr1= '+sstr1,
                          mtConfirmation, [mbYes, mbNo], 0) = mrNo Then Exit;}

                      sstr2:=sstr2+' '+RightLine(FormatFloat('0.0', MainQuery.FieldByName('NUM_OUT').AsFloat),9);

                      Sum_out  := Sum_out  + MainQuery.FieldByName('NUM_OUT').AsFloat;

                      MainQuery.Next;
                   end;

                   //Текущий месяц
                   Sum_plan := Sum_plan + MainQuery.FieldByName('NUM_PLAN').AsFloat;
                   Sum_fact := Sum_fact + MainQuery.FieldByName('NUM_FACT').AsFloat;
                   MainQuery.Next;


                   //печатать номеров месяцов
                   If lMonth Then
                   begin
                      sstr1:=sstr1 + '|'+CentrLine('Недодел', 9) + '|'+CentrLine('Сдано', 9) + '|'+CentrLine('План', 9);
                      add(sstr1);
                      add(RepeatLine('-', 168));
                   end;

//                   If (Sum_fact>0) or (Sum_out>0) Then
//                   begin
                      sstr2:=sstr2 +' '+ RightLine(FormatFloat('0.0', Sum_fact),9) + ' ' +
                                         RightLine(FormatFloat('0.0', Sum_out),9) + ' ' +
                                         RightLine(FormatFloat('0.0', Sum_plan),9);
                      add(sstr2);
//                   end;

                   i:=i+12;
                   lMonth:=False;
                   sstr2:='';
                   Sum_out  := 0;
                   Sum_plan := 0;
                   Sum_fact := 0;
                end;
                add(RepeatLine('-', 168));
             end;
          end;
       end;
       PrForm.Destroy;

       Form.Caption := 'Выполнение деталей';
       Form.Editor.show;
       Form.show;

end;

procedure TReport6Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
