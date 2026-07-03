unit Rep61;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ToolEdit, DB, DBTables, Mask, EnumForm4Sel, rxStrUtils;

type
  TReport61Form = class(TForm)
    Label1: TLabel;
    Label8: TLabel;
    FeatComboBox: TComboBox;
    Label7: TLabel;
    ChrtCombo: TComboEdit;
    qChrtQuery: TQuery;
    Label5: TLabel;
    CstCombo: TComboEdit;
    qCSTQuery: TQuery;
    Label4: TLabel;
    PdrCombo: TComboEdit;
    qPdrQuery: TQuery;
    Label9: TLabel;
    Label11: TLabel;
    RqstEdit: TEdit;
    Label10: TLabel;
    OrderEdit: TEdit;
    Query: TQuery;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    OKButton: TButton;
    CancelButton: TButton;
    procedure ButtonSelPerClick(Sender: TObject);
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
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report61Form: TReport61Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport61Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport61Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport61Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport61Form.ChrtComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qChrtQuery, ChrtCombo, 'select id, code, name from spr_chrt',
                        'Справочник: Чертежи (Выбор)', 0);
end;

procedure TReport61Form.ChrtComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qChrtQuery, ChrtCombo, key, Shift, 1) = false then
    ChrtComboButtonClick(Sender);
end;

procedure TReport61Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qCSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Заказчики (Выбор)', 0);
end;

procedure TReport61Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qCSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport61Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport61Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport61Form.CancelButtonClick(Sender: TObject);
begin
   close;
end;

procedure TReport61Form.OKButtonClick(Sender: TObject);
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
SumTrP   : Real;    //Сумма по заказчику
SumTrF   : Real;
SumTrOst : Real;
TotalTrP : Real;    //Итог по всем заказчикам
TotalTrF : Real;    
TotalTrOst : Real;
    Form : TShowPrintForm;    // форма печати
  PrForm : TProcessForm;      // форма прогрессора
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       SumTrP   := 0;
       SumTrF   := 0;
       SumTrOst := 0;
       k := 0;


       If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       Query.Close;
       Query.SQL.Clear;
       Query.SQL.Add('Select * From REPORT_61_PROCEDURE(:DATE_BEG, :DATE_END, ');
       Query.SQL.Add(':ID_CST, :ID_PDR, :ID_CHRT, :ID_RQST, :ID_ORDER, :SELECTION)');
       Query.SQL.Add('Order by ID_CST_PARENT, NAME_CST, NUMBER_RQST, NUMBER_ORDER');

       Query.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       Query.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

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

         m := 174;

         // вывод шапки отчета
         add( RepeatLine('-', m));
         add( RightLine('Дата распечатки: '+DateToStr(Date)+', время: '+TimeToStr(Time),m));
         add( CentrLine('Невыполненные заказы запущенные в производство',m-20)
                 + RightLine(GetSystemParams('Service'),20));
         add( CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,m-20));
         add( '');

         If FeatComboBox.itemindex >= 1 Then //если выбран признак
              add( LeftLine(FeatComboBox.Text, m));

         add( '');

         Total_k := 0;
         n := Query.RecordCount;
         i := 0;
         CstStr := '';
         Form.Editor.Visible := False;
         PrForm.Show;

         //цикл по количеству заказов
         While i< n do
         begin


            If (CstStr <> Query.FieldByName('Name_Cst').AsString) Then
            begin
              add( 'Заказчик: '+Query.FieldByName('Name_Cst').AsString );
              add( RepeatLine('-', m));
              add( ' №  |   №заявки   |                    |                                   |Участок |            Дата и             |     Наименование      | Кол-во |Трудо- |Трудо- |Трудо- ');
              add( 'п.п.|      /      |       Чертеж       |        Наименование детали        |        |          исполнитель          |       следующей       |операций|емкость|емкость|емкость');
              add( '    |   №заказа   |                    |                                   |        |           последней           |        операци        |   до   | план  | факт  |остаток');
              add( '    |             |                    |                                   |        |           операции            |                       |завершен|(часы) |(часы) |(часы) ');
              add( RepeatLine('-', m));
              k := 1;
            end;

            CstStr  := Query.FieldByName('Name_Cst').AsString;

            //цикл по все заказам одного заказчика sstr
            While (Query.FieldByName('Name_Cst').AsString = CstStr) and
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

               if Query.FieldByName('TIME_P').AsFloat>=0 then
               begin
                    sstr   := sstr +
                              RightLine(FormatFloat( '0.00',Query.FieldByName('TIME_P').AsFloat
                              * Query.FieldByName('NUMBER_P').AsInteger), 7)+'|';
                    SumTrP := SumTrP
                            + Query.FieldByName('TIME_P').AsFloat
                              * Query.FieldByName('NUMBER_P').AsInteger;

               end
                else
                      sstr := sstr +
                              RightLine('0',7)+'|';

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

               add( sstr);
               Query.Next;

               k := k + 1;
               i := i + 1;

            end;

            Total_k := Total_k + k-1;

            //Если группировка идет по материалу и материал не путая строка,
            //(если строка пустая подводим итог по подразделениям)
            If (CstStr <> Query.FieldByName('Name_Cst').AsString) or
               (Query.Eof) Then
            begin
               add( RepeatLine('-', m));
               add( CentrLine('Итого по П/Д:', m-24)+
                          RightLine(FormatFloat( '0.00',SumTrP),7)+' '+
                          RightLine(FormatFloat( '0.00',SumTrF),7)+' '+
                          RightLine(FormatFloat( '0.00',SumTrOst),7));
               add( '');

               TotalTrOst := TotalTrOst + SumTrOst;
               TotalTrP := TotalTrP + SumTrP;
               TotalTrF := TotalTrF + SumTrF;
               SumTrP:=0;
               SumTrF:=0;
               SumTrOst:=0;
            end;

         end;

         add( '');
         add( '                Количество позиций: ' + IntToStr(Total_k));
         add( '');
         add( ' Итоговая плановая трудоемкость: ' + FormatFloat( '0.00', TotalTrP) + ' руб.');
         add( '');
         add( ' Итоговая фактическая трудоемкость: ' + FormatFloat( '0.00', TotalTrF) + ' час.');
         add( '');
         add( '  Итоговая остаточная трудоемкость: ' + FormatFloat( '0.00', TotalTrOst) + ' час.');
    end;


  PrForm.Destroy;

  Form.Caption := 'Невыполненные заказы запущенные в производство';
  Form.Editor.show;
  Form.onshow;
  Form.show;
end;

end.
