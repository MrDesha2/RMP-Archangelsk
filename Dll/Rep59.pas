unit Rep59;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EnumForm4Sel, DB, DBTables, StdCtrls, ExtCtrls, ToolEdit, Mask, Math,
  rxStrUtils;

type
  TReport59Form = class(TForm)
    Label1: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    PerInRadioButton: TRadioButton;
    PerOutRadioButton: TRadioButton;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    ReviewComboBox: TComboBox;
    FeatComboBox: TComboBox;
    ChrtCombo: TComboEdit;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    OrderEdit: TEdit;
    RqstEdit: TEdit;
    RadioGroup1: TRadioGroup;
    CstRadioButton: TRadioButton;
    NmntRadioButton: TRadioButton;
    OutMemoBox: TCheckBox;
    OKButton: TButton;
    CancelButton: TButton;
    qCSTQuery: TQuery;
    qPdrQuery: TQuery;
    qChrtQuery: TQuery;
    Query: TQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ChrtComboButtonClick(Sender: TObject);
    procedure ChrtComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CstRadioButtonClick(Sender: TObject);
    procedure NmntRadioButtonClick(Sender: TObject);
    procedure OutMemoBoxClick(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure PerInRadioButtonClick(Sender: TObject);
    procedure PerOutRadioButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FeatComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
     TrOstVar : Real;
       OstVar : Integer;
       TrFVar : Real;

     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report59Form: TReport59Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport59Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport59Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport59Form.ChrtComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qChrtQuery, ChrtCombo, 'select id, code, name from spr_chrt',
                        'Справочник: Чертежи (Выбор)', 0);
end;

procedure TReport59Form.ChrtComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qChrtQuery, ChrtCombo, key, Shift, 1) = false then
    ChrtComboButtonClick(Sender);
end;

procedure TReport59Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qCSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Заказчики (Выбор)', 0);
end;

procedure TReport59Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qCSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport59Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport59Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport59Form.CstRadioButtonClick(Sender: TObject);
begin
  If CstRadioButton.Checked = True Then
  begin
     CstRadioButton.Font.Style := [fsBold];
     NmntRadioButton.Font.Style := [];
  end
   else
   begin
      CstRadioButton.Font.Style := [];
      NmntRadioButton.Font.Style := [fsBold];
   end;
end;

procedure TReport59Form.NmntRadioButtonClick(Sender: TObject);
begin
  If NmntRadioButton.Checked = True Then
  begin
     NmntRadioButton.Font.Style := [fsBold];
     CstRadioButton.Font.Style := [];
  end
   else
   begin
      NmntRadioButton.Font.Style := [];
      CstRadioButton.Font.Style := [fsBold];
   end;
end;

procedure TReport59Form.OutMemoBoxClick(Sender: TObject);
begin
  If OutMemoBox.Checked = True Then OutMemoBox.Font.Style := [fsBold]
   else OutMemoBox.Font.Style := [];
end;

procedure TReport59Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport59Form.PerInRadioButtonClick(Sender: TObject);
begin
  If PerInRadioButton.Checked = True Then
  begin
     PerInRadioButton.Font.Style  := [fsBold];
     PerOutRadioButton.Font.Style := [];
  end
   else
   begin
      PerInRadioButton.Font.Style  := [];
      PerOutRadioButton.Font.Style := [fsBold];
   end
end;

procedure TReport59Form.PerOutRadioButtonClick(Sender: TObject);
begin
  If PerOutRadioButton.Checked = True Then
  begin
     PerInRadioButton.Font.Style  := [];
     PerOutRadioButton.Font.Style := [fsBold];
  end
   else
   begin
      PerInRadioButton.Font.Style  := [fsBold];
      PerOutRadioButton.Font.Style := [];
   end
end;

procedure TReport59Form.CancelButtonClick(Sender: TObject);
begin
   close;
end;

procedure TReport59Form.OKButtonClick(Sender: TObject);
Var what : String; //параметр содержит кусок запроса содержащий информацию
                   //какую ведомость достаем
  sstr   : String;
  CstStr : String;
  NmntStr: String;
       i : Integer;
     n,k : Integer;
       m : Integer;  // Ширина отчёта
 Total_k : Integer;
Year, Month, Day: Word;
SumPlan  : Integer; //Сумма по заказчику
SumFakt  : Integer;
SumOst   : Integer;
SumTrF   : Real;
SumTrOst : Real;
SumSeb   : Real;
SumNmntPlan  : Integer; //Сумма по заказчику
SumNmntFakt  : Integer;
SumNmntOst   : Integer;
SumNmntTrF   : Real;
SumNmntTrOst : Real;
SumNmntSeb   : Real;
TotalTrF : Real;    //Итог по всем заказчикам
TotalTrOst : Real;
TotalSeb : Real;
TotalOst : Integer;
    Form : TShowPrintForm;    // форма печати
  PrForm : TProcessForm;      // форма прогрессора

begin

       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);



       TrOstVar := 0;
       OstVar   := 0;
       TrFVar   := 0;
       SumNmntPlan  := 0;
       SumNmntFakt  := 0;
       SumNmntOst   := 0;
       SumNmntTrF   := 0;
       SumNmntTrOst := 0;
       SumNmntSeb   := 0;
       SumPlan  := 0;
       SumFakt  := 0;
       SumOst   := 0;
       SumTrF   := 0;
       SumTrOst := 0;
       SumSeb   := 0;

       If CstCombo.Text = '' Then
       begin
          MessageDlg('Заказчик не определен!', mtWarning , [mbYes], 0);
          Exit;
       end;

       If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       Query.Close;
       Query.SQL.Clear;
       Query.SQL.Add('Select * From REPORT_59_PROCEDURE(:DATE_BEG, :DATE_END, ');
       Query.SQL.Add(':VID_DATE, :ID_CST, :ID_PDR, :ID_CHRT, :ID_RQST, ');
       Query.SQL.Add(':ID_ORDER, :FLAG, :SELECTION)');
//       Query.SQL.Add('Group By NUMBER_RQST, NUMBER_ORDER,');
//       Query.SQL.Add('         CODE_CST, NAME_CST, CODE_CST_PARENT,');
//       Query.SQL.Add('         NAME_CST_PARENT, CODE_PDR, NAME_PDR,');
//       Query.SQL.Add('         CODE_CHRT, NAME_CHRT, SUM_NTIME, SUM_PRICE');
//       Query.SQL.Add('Order by CODE_CST_PARENT, NAME_CST, CODE_PDR, NUMBER_RQST, NUMBER_ORDER');

       If NmntRadioButton.Checked = True Then  //группировать по материалам
            Query.SQL.Add('Order by NAME_NMNT, ID_CST_PARENT, NAME_CST, NUMBER_RQST, NUMBER_ORDER')
        else
              Query.SQL.Add('Order by ID_CST_PARENT, NAME_CST, NUMBER_RQST, NUMBER_ORDER');

       Query.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       Query.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If PerInRadioButton.Checked = True Then
           Query.ParamByName('VID_DATE').AsInteger := 0
        else
            Query.ParamByName('VID_DATE').AsInteger := 1;

       If (CstCombo.Text = '') or (CstCombo.Text = '<Объект не найден>') or (not qCstQuery.active) Then
            Query.ParamByName('ID_CST').AsInteger := -1
        else
               Query.ParamByName('ID_CST').AsInteger := qCstQuery.Fields[0].AsInteger;

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not qPdrQuery.active) Then
            Query.ParamByName('ID_PDR').AsInteger := -1
        else
               Query.ParamByName('ID_PDR').AsInteger := qPdrQuery.Fields[0].AsInteger;

       If (ChrtCombo.Text = '') or (ChrtCombo.Text = '<Объект не найден>') or (not qChrtQuery.active) Then
            Query.ParamByName('ID_CHRT').AsInteger := -1
        else
               Query.ParamByName('ID_CHRT').AsInteger := qChrtQuery.Fields[0].AsInteger;

       If (Trim(RqstEdit.Text) = '') Then
           Query.ParamByName('ID_RQST').AsInteger := -1
        else
        begin
           try
              StrToInt(RqstEdit.Text)
           except
            begin
               MessageDlg('Номер заявки введён не правильно', mtWarning , [mbYes], 0);
               Exit;
            end;
           end;

           Query.ParamByName('ID_RQST').AsInteger := StrToInt(RqstEdit.Text);
        end;

       If (Trim(OrderEdit.Text) = '') Then
           Query.ParamByName('ID_ORDER').AsInteger := -1
        else
        begin
          try
            StrToInt(OrderEdit.Text)
          except
           begin
              MessageDlg('Номер заказа введён не правильно', mtWarning , [mbYes], 0);
              Exit;
           end;
          end;

          Query.ParamByName('ID_ORDER').AsInteger := StrToInt(OrderEdit.Text);
        end;


       If (ReviewComboBox.ItemIndex = 0) Then
          Query.ParamByName('FLAG').AsInteger := -1
        else
           Query.ParamByName('FLAG').AsInteger := ReviewComboBox.ItemIndex;

       If (FeatComboBox.ItemIndex = 0) Then
          Query.ParamByName('SELECTION').AsInteger := -1
        else
           Query.ParamByName('SELECTION').AsInteger := FeatComboBox.ItemIndex-1;  //счёт начинается с 0 (плановые заказы)

       Query.Open;
       Query.First;
       PrForm.Show;

       If Query.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       // формирование строк
     with Form.Editor.lines do
      begin

         clear;

         m := 214;  //183;

         // вывод шапки отчета
         add( RepeatLine('-', m));
         add( '');
         add( CentrLine('Контроль за ходом выполнения заказов',m-20)
                 + RightLine(GetSystemParams('Service'),20));
         add( CentrLine(ReviewComboBox.Text, m-20)+ RightLine(DateToStr(Date),20));
         add( CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,m-20));
         add( '');

         If FeatComboBox.itemindex >= 1 Then //если выбран признак
              add( LeftLine(FeatComboBox.Text, m));

         add( LeftLine(ReviewComboBox.Text, m));
         add( '');


         Total_k := 0;
         n := Query.RecordCount;
         i := 0;
         Form.Editor.Visible := False;
         PrForm.Show;

         NmntStr := Query.FieldByName('Name_Nmnt').AsString;

         If (NmntRadioButton.Checked = True) and (Query.FieldByName('Name_Nmnt').AsString <> '') Then
         begin
             Add(CentrLine('Материал: '+Query.FieldByName('Name_Nmnt').AsString, m));
             add('');
         end;

         //цикл по количеству заказов
         While i< n do
         begin

            If (NmntRadioButton.Checked = True) and (NmntStr <> Query.FieldByName('Name_Nmnt').AsString) Then
            begin
              If Query.FieldByName('Name_Nmnt').AsString <> '' Then
              begin
                  add('');
                  add('');
                  Add(CentrLine('Материал: '+Query.FieldByName('Name_Nmnt').AsString, m));
                  add('');
              end
               else
               begin
                   Add(RepeatLine('*', m));
                   Add(' ');
               end;

            end;

            If ((NmntStr <> Query.FieldByName('Name_Nmnt').AsString) and (NmntRadioButton.Checked = True)) or
               (CstStr <> Query.FieldByName('Name_Cst').AsString) Then
            begin
              add( 'Заказчик: '+Query.FieldByName('Name_Cst').AsString );
              add( RepeatLine('-', m));
              add( ' №  |   №заявки   |                    |                                   |Участок |Мес|Пл.|            Дата и             |            Дата и             |     Наименование      | Кол-во |Трудо- |Трудо- |Себестои-');
              add( 'п.п.|      /      |       Чертеж       |        Наименование детали        |        |яц |Мес|          исполнитель          |          исполнитель          |       следующей       |операций|емкость|емкость|  мость  ');
              add( '    |   №заказа   |                    |                                   |        |рег|   |            первой             |           последней           |        операци        |   до   | факт  |остаток|         ');
              add( '    |             |                    |                                   |        |   |   |           операции            |           операции            |                       |завершен|(часы) |(часы) |         ');
              add( RepeatLine('-', m));
              k := 1;
            end;

            NmntStr := Query.FieldByName('Name_Nmnt').AsString;
            CstStr  := Query.FieldByName('Name_Cst').AsString;

            //цикл по все заказам одного заказчика sstr
            While (Query.FieldByName('Name_Cst').AsString = CstStr) and
                  (Query.FieldByName('Name_Nmnt').AsString = NmntStr)  and
                  (not Query.Eof)do
            begin

               PrForm.ProgressBar.Position:=(i+1)*100 div n;

               sstr := '';
               sstr :=RightLine(IntToStr(k), 4)
                    + '|'
                    + RightLine(Query.FieldByName('NUMBER_RQST').AsString
                    + '/'
                    + Query.FieldByName('NUMBER_ORDER').AsString, 13)
                    + '|'
                    + LeftLine(Query.FieldByName('CODE_CHRT').AsString, 20)
                    + '|'
                    + LeftLine(ReplaceStr(Query.FieldByName('NAME_CHRT').AsString,'ОТЛ.',''), 35)
                    + '|'
                    + RightLine(Query.FieldByName('CODE_PDR').AsString, 8)
                    + '|';

               //  дата окончания и исполнитель
               DecodeDate(Query.FieldByName('DATE_IN').AsDateTime, Year, Month, Day);
               sstr := sstr
                     + CentrLine(IntToStr(Month),3)+'|';

               DecodeDate(Query.FieldByName('DATE_OUT').AsDateTime, Year, Month, Day);
               sstr := sstr
                     + CentrLine(IntToStr(Month),3)+'|';

               // дата и исполнитель первой операции
               sstr := sstr
                     + LeftLine(Query.FieldByName('OPER_DATE_BEG').AsString+ ' '
                     + Query.FieldByName('NAME_WRKR_OPER_BEG').AsString, 31)
                     + '|';

               // дата и исполнитель последней операции
               sstr := sstr
                     + LeftLine(Query.FieldByName('OPER_DATE_END').AsString+ ' '
                     + Query.FieldByName('NAME_WRKR_OPER').AsString, 31)
                     + '|'
                     + LeftLine(Query.FieldByName('NAME_OPER').AsString, 23)
                     + '|';

               If (Query.FieldByName('NUMBER_OPER_OFF').AsInteger < 0) Then
                     sstr := sstr + RightLine('-', 8) + '|'
                 else
                     sstr := sstr + RightLine(Query.FieldByName('NUMBER_OPER_OFF').AsString, 8) + '|';

               SumFakt := SumFakt
                        + Query.FieldByName('NUMBER_F').AsInteger;
               SumPlan := SumPlan
                        + Query.FieldByName('NUMBER_P').AsInteger;


               if Query.FieldByName('TIME_F').AsFloat>=0 then
               begin
                    sstr   := sstr +
                              RightLine(FormatFloat( '0.00',Query.FieldByName('TIME_F').AsFloat
                              * Query.FieldByName('NUMBER_F').AsInteger), 7)+'|';
                    SumTrF := SumTrF
                            + Query.FieldByName('TIME_F').AsFloat
                              * Query.FieldByName('NUMBER_F').AsInteger;

               end
                else
                      sstr := sstr +
                              RightLine('0',7)+'|';

               if Query.FieldByName('TIME_P').AsFloat
                    *Query.FieldByName('NUMBER_P').AsInteger -
                      Query.FieldByName('TIME_F').AsFloat
                       *Query.FieldByName('NUMBER_F').AsInteger>=0 then

                begin
                    sstr := sstr+
                            RightLine(FormatFloat( '0.00',Query.FieldByName('TIME_P').AsFloat
                             *Query.FieldByName('NUMBER_P').AsFloat
                               - Query.FieldByName('TIME_F').AsFloat
                                 * Query.FieldByName('NUMBER_F').AsFloat),7)+'|';
                    SumTrOst := SumTrOst
                              + Query.FieldByName('TIME_P').AsFloat
                               * Query.FieldByName('NUMBER_P').AsFloat
                                 - Query.FieldByName('TIME_F').AsFloat
                                   * Query.FieldByName('NUMBER_F').AsFloat;


               end
                else
                     sstr := sstr
                           + RightLine('0', 7)+'|';

               sstr := sstr + RightLine(
                  FormatFloat( '0.00',Query.FieldByName('FAKT_TOTAL_PRICE').AsFloat), 9);
               SumSeb := SumSeb + RoundTo(Query.FieldByName('FAKT_TOTAL_PRICE').AsFloat,-2);

               // прибавление информационного поля в конце строки
               if OutMemoBox.Checked then
               begin
                   if Length(trim(Query.FieldByName('INFO').AsString)) > 0 Then
                   begin
                      replacestr(replacestr(Query.FieldByName('INFO').AsString, chr(10), ''), chr(13), '');
                      sstr := sstr + '|' + leftstr(Query.FieldByName('INFO').AsString, 40);
                   end
                    else
                        sstr := sstr + RepeatLine(' ', 41);
               end
                else
                    sstr := sstr + RepeatLine(' ', 41);

               add( sstr);
               Query.Next;

               k := k + 1;
               i := i + 1;

            end;

            Total_k := Total_k + k-1;

            SumNmntPlan  := SumNmntPlan  + SumPlan;
            SumNmntFakt  := SumNmntFakt  + SumFakt;
            SumNmntOst   := SumNmntOst   + SumOst;
            SumNmntTrF   := SumNmntTrF   + SumTrF;
            SumNmntTrOst := SumNmntTrOst + SumTrOst;
            SumNmntSeb   := SumNmntSeb   + SumSeb;

            //Если группировка идет по материалу и материал не путая строка,
            //(если строка пустая подводим итог по подразделениям)
            If (NmntRadioButton.Checked = True) and (NmntStr <> '') Then
            begin
               //Если материал изменился, подводим итог
               If (NmntStr <> Query.FieldByName('Nmnt').AsString) or
                  (Query.Eof) Then
               begin
                 add( RepeatLine('-', m));
                 add( CentrLine('Итого по П/Д:', 84)+RightLine(IntToStr(SumPlan),5)+' '+
                            RightLine(IntToStr(SumFakt), 5)+' '+
                            RightLine(IntToStr(SumOst), 7)+'          '+
                            RightLine(FormatFloat( '0.00',SumTrF),7)+' '+
                            RightLine(FormatFloat( '0.00',SumTrOst),7)+' '+
                            RightLine(FormatFloat( '0.00',SumSeb),11));

                 add( RepeatLine('~', m));
                 add( CentrLine('Итого по материалу:', 84)+RightLine(IntToStr(SumNmntPlan),5)+' '+
                             RightLine(IntToStr(SumNmntFakt), 5)+' '+
                             RightLine(IntToStr(SumNmntOst), 7)+'          '+
                             RightLine(FormatFloat( '0.00',SumNmntTrF),7)+' '+
                             RightLine(FormatFloat( '0.00',SumNmntTrOst),7)+' '+
                             RightLine(FormatFloat( '0.00',SumNmntSeb),11));
                 add( '');

                 TotalTrOst := TotalTrOst + SumTrOst;
                 TotalTrF := TotalTrF + SumTrF;
                 TotalSeb := TotalSeb + SumSeb;
                 TotalOst := TotalOst + SumOst;

                 SumNmntPlan  := 0;
                 SumNmntFakt  := 0;
                 SumNmntOst   := 0;
                 SumNmntTrF   := 0;
                 SumNmntTrOst := 0;
                 SumNmntSeb   := 0;

                 SumTrF:=0;
                 SumTrOst:=0;
                 SumFakt:=0;
                 SumOst:=0;
                 SumPlan:=0;
                 SumSeb:=0;
               end
                else //Если материал не изменился, но изменился заказчик делам по нему итог
                begin
                   add( RepeatLine('-', m));
                   add( CentrLine('Итого по П/Д:', 84)+RightLine(IntToStr(SumPlan),5)+' '+
                              RightLine(IntToStr(SumFakt), 5)+' '+
                              RightLine(IntToStr(SumOst), 7)+'          '+
                              RightLine(FormatFloat( '0.00',SumTrF),7)+' '+
                              RightLine(FormatFloat( '0.00',SumTrOst),7)+' '+
                              RightLine(FormatFloat( '0.00',SumSeb),11));
                   add( '');

                   TotalTrOst := TotalTrOst + SumTrOst;
                   TotalTrF := TotalTrF + SumTrF;
                   TotalSeb := TotalSeb + SumSeb;
                   TotalOst := TotalOst + SumOst;

                   SumTrF:=0;
                   SumTrOst:=0;
                   SumFakt:=0;
                   SumOst:=0;
                   SumPlan:=0;
                   SumSeb:=0;
                end;
            end
             else
             begin

                If (CstStr <> Query.FieldByName('Name_Cst').AsString) or
                   (Query.Eof) Then
                begin
                   add( RepeatLine('-', m));
                   add( CentrLine('Итого по П/Д:', 84)+RightLine(IntToStr(SumPlan),5)+' '+
                              RightLine(IntToStr(SumFakt), 5)+' '+
                              RightLine(IntToStr(SumOst), 7)+'          '+
                              RightLine(FormatFloat( '0.00',SumTrF),7)+' '+
                              RightLine(FormatFloat( '0.00',SumTrOst),7)+' '+
                              RightLine(FormatFloat( '0.00',SumSeb),11));
                   add( '');

                   TotalTrOst := TotalTrOst + SumTrOst;
                   TotalTrF := TotalTrF + SumTrF;
                   TotalSeb := TotalSeb + SumSeb;
                   TotalOst := TotalOst + SumOst;
                   SumTrF:=0;
                   SumTrOst:=0;
                   SumFakt:=0;
                   SumOst:=0;
                   SumPlan:=0;
                   SumSeb:=0;
                end;
             end;

         end;

         add( '');
         add( '                Количество позиций: ' + IntToStr(Total_k));
         add( '');
         add( '            Итоговая себестоимость: ' + FormatFloat( '0.00', TotalSeb) + ' руб.');
         add( '');
         add( ' Итоговая фактическая трудоемкость: ' + FormatFloat( '0.00', TotalTrF) + ' час.');
         add( '');
         add( '  Итоговая остаточная трудоемкость: ' + FormatFloat( '0.00', TotalTrOst) + ' час.');
         add( '');
         add( '          Итого осталось выполнить: ' + IntToStr(TotalOst));


    end;


  PrForm.Destroy;

  Form.Caption := 'Контроль за ходом выполнения заказов';
  Form.Editor.show;
  Form.onshow;
  Form.show;
end;

procedure TReport59Form.FeatComboBoxChange(Sender: TObject);
begin
//  ShowMessage('FeatComboBox = '+IntToStr(FeatComboBox.ItemIndex));
end;

end.
