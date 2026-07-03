{***************************************************************
 *
 * Unit Name: Rep12
 * Purpose  : Ведомость по годовому журналу
 *       Выдает количественный и суммовой отчет по заказам
 *       выполненными заданными подразделеями
 * Author   : Соколов Владислав
 * History  :
 *
 ****************************************************************}

unit Rep12;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel, rxStrUtils, Math,
  ExtCtrls;

type
  TReport12Form = class(TForm)
    qCSTQuery: TQuery;
    qPdrQuery: TQuery;
    qMainQuery: TQuery;
    qTableQuery: TQuery;
    qMTRQuery: TQuery;
    ChrcQuery: TQuery;
    ChrtQuery: TQuery;
    MtrpQuery: TQuery;
    Query: TQuery;
    Order2Query: TQuery;
    Order1Query: TQuery;
    OrderPriceQuery: TQuery;
    Label1: TLabel;
    GroupBox1: TGroupBox;
    PerInRadioButton: TRadioButton;
    PerOutRadioButton: TRadioButton;
    Label6: TLabel;
    ReviewComboBox: TComboBox;
    FeatComboBox: TComboBox;
    Label8: TLabel;
    Label7: TLabel;
    ChrtCombo: TComboEdit;
    Label5: TLabel;
    CstCombo: TComboEdit;
    Label4: TLabel;
    PdrCombo: TComboEdit;
    Label9: TLabel;
    Label11: TLabel;
    OrderEdit: TEdit;
    Label10: TLabel;
    RqstEdit: TEdit;
    RadioGroup1: TRadioGroup;
    CstRadioButton: TRadioButton;
    NmntRadioButton: TRadioButton;
    OutMemoBox: TCheckBox;
    Button1: TButton;
    OKButton: TButton;
    CancelButton: TButton;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    procedure OKButtonClick(Sender: TObject);
    procedure CSTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CSTComboButtonClick(Sender: TObject);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure ChrtComboButtonClick(Sender: TObject);
    procedure ChrtComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure OutMemoBoxClick(Sender: TObject);
    procedure NmntRadioButtonClick(Sender: TObject);
    procedure CstRadioButtonClick(Sender: TObject);
    procedure ButtonSelPerOutClick(Sender: TObject);
    procedure PerInRadioButtonClick(Sender: TObject);
    procedure PerOutRadioButtonClick(Sender: TObject);
  private
    { Private declarations }
  public

     TrOstVar : Real;
       OstVar : Integer;
       TrFVar : Real;

     LISTForm : TLIST_4SELECTForm;

  end;

var
  Report12Form: TReport12Form;

implementation


uses PrintFrm,
    printlibs,
         Libs,
  PrintProces,
   GetPeriods;

{$R *.DFM}

{

         Процедура формирования печатной формы документа


}
procedure TReport12Form.OKButtonClick(Sender: TObject);
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

       //Параметр what отвечает за признак готовности заказа
       If ReviewComboBox.itemindex = 0 Then
            what:='';
       If ReviewComboBox.itemindex = 1 Then
            what:='b.PR_EXEC = 3 and ';
       If ReviewComboBox.itemindex = 2 Then
            what:='b.PR_EXEC = 2 and ';
       If ReviewComboBox.itemindex = 3 Then
            what:='b.PR_EXEC = 1 and ';


       // формирование строк
     with Form.Editor.lines do
      begin

         clear;

         m := 140;

         // вывод шапки отчета
         add( RepeatLine('-', m));
         add( '');
         add( CentrLine('Ведомость по годовому журналу',m-20)
                 + RightLine(GetSystemParams('Service'),20));
         add( CentrLine(ReviewComboBox.Text, m-20)+ RightLine(DateToStr(Date),20));
         add( CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,m-20));
         add( '');

         If FeatComboBox.itemindex >= 1 Then //если выбран признак
              add( LeftLine(FeatComboBox.Text, m));

 //      if qCSTQuery.active then

           add( LeftLine(ReviewComboBox.Text, m));
//       else
 //        add( LeftLine('По всем', 132));


         add( '');

       Query.Close;

       Query.SQL.Clear;
       Query.SQL.Add('Select a.NUMBER, b.NUMBER, c.CODE, c.NAME, e.CODE, m.NAME, ');
       Query.SQL.Add('b.NUMBER_P, b.NUMBER_F, m.CODE, b.DATE_IN, b.ID, b.date_out, ');
       Query.SQL.Add('b.info, m.parentid,');

       If ReviewComboBox.itemindex = 3 Then
       begin
         Query.SQL.Add('(Select f.name                   ');
         Query.SQL.Add(' From DT_MTRP d, SPR_NMNT f      ');
         Query.SQL.Add(' Where d.id_opp = b.id and       ');
         Query.SQL.Add('       d.lineno = 1    and       ');
         Query.SQL.Add('       d.lineopp = 1   and       ');
         Query.SQL.Add('       f.id = d.id_nmnt) As Nmnt ');
       end
        else
        begin
           Query.SQL.Add('(Select f.name                   ');
           Query.SQL.Add(' From DT_MTRF d, SPR_NMNT f      ');
           Query.SQL.Add(' Where d.id_opf = b.id and       ');
           Query.SQL.Add('       d.lineno = 1    and       ');
           Query.SQL.Add('       d.lineopf = 1   and       ');
           Query.SQL.Add('       f.id = d.id_nmnt) As Nmnt ');
        end;

       Query.SQL.Add('From DH_Rqst a, DH_Order b, Spr_Chrt c, ');
       Query.SQL.Add('Spr_Pdr e, Spr_Cst  m ');
       Query.SQL.Add('Where ');

       If FeatComboBox.itemindex = 1 Then
            Query.SQL.Add('b.WEIGHT_F = 0 and ');
       If FeatComboBox.itemindex = 2 Then
            Query.SQL.Add('b.WEIGHT_F = 1 and ');
       If FeatComboBox.itemindex = 3 Then
            Query.SQL.Add('b.WEIGHT_F = 2 and ');

       //Параметр = Чертежу
       if (not ChrtQuery.eof) and (ChrtQuery.active) then
          Query.SQL.Add('c.id = ' + ChrtQuery.Fields[0].asstring + ' and ');

       //Параметр = Заказчику
       if (not qCSTQuery.eof) and (qCSTQuery.active) then
          Query.SQL.Add('m.id = ' + qCSTQuery.Fields[0].asstring + ' and ');

       //Параметр = Подразделению
       if (not qPdrQuery.eof) and (qPdrQuery.active) then
          Query.SQL.Add('e.id = ' + qPdrQuery.Fields[0].asstring + ' and ');

       //Параметр = Заявке
       if (RqstEdit.Text <> '')  then
             Query.SQL.Add('a.number = ' + Trim(RqstEdit.Text)+ ' and ');

       //Параметр = Заказу
       if (OrderEdit.Text <> '')  then
             Query.SQL.Add('b.number = ' + Trim(OrderEdit.Text)+ ' and ');

       Query.SQL.Add('a.ID_CST = m.ID and b.ID_RQST = a.ID ');
       Query.SQL.Add('and '+ what +' c.ID = b.ID_CHRT and ');
       Query.SQL.Add('e.ID = b.ID_PDR and ');

       If PerInRadioButton.Checked = True Then
          Query.SQL.Add('b.DATE_IN>=:begdate and b.DATE_IN<=:enddate')
        else
           Query.SQL.Add('b.DATE_OUT>=:begdate and b.DATE_OUT<=:enddate');

       If NmntRadioButton.Checked = True Then  //группировать по материалам
            Query.SQL.Add('Order by 15, 14, 6, 1, 2')
        else
              Query.SQL.Add('Order by 14, 6, 1, 2');


       Query.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
       Query.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);

       Query.Open;
       If Query.Eof Then
       begin
            MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
            Exit;
       end;

         Total_k := 0;
         n := Query.RecordCount;
         i := 0;
         Form.Editor.Visible := False;
         PrForm.Show;

         NmntStr := Query.FieldByName('Nmnt').AsString;

         If (NmntRadioButton.Checked = True) and (Query.FieldByName('Nmnt').AsString <> '') Then
         begin
             Add(CentrLine('Материал: '+Query.FieldByName('Nmnt').AsString, m));
             add('');
         end;

         //цикл по количеству заказов
         While i< n do
         begin

            If (NmntRadioButton.Checked = True) and (NmntStr <> Query.FieldByName('Nmnt').AsString) Then
            begin
              If Query.FieldByName('Nmnt').AsString <> '' Then
              begin
                  add('');
                  add('');
                  Add(CentrLine('Материал: '+Query.FieldByName('Nmnt').AsString, m));
                  add('');
              end
               else
               begin
                   Add(RepeatLine('*', m));
                   Add(' ');
               end;

//              NmntStr := Query.FieldByName('Nmnt').AsString;
            end;
//             else NmntStr := Query.FieldByName('Nmnt').AsString;

            If ((NmntStr <> Query.FieldByName('Nmnt').AsString) and (NmntRadioButton.Checked = True)) or
               (CstStr <> Query.FieldByName('NAME_1').AsString) Then
            begin
              add( 'Заказчик: '+Query.FieldByName('NAME_1').AsString );
              add( RepeatLine('-', m));
              add( ' №  |   №заявки   |                    |                                   |Мес|Пл.|  Кол-во   |Остаток|Участок |Трудо- |Трудо- |Себестои-');
              add( 'п.п.|      /      |       Чертеж       |        Наименование детали        |яц |Мес|           |       |        |емкость|емкость|  мость  ');
              add( '    |   №заказа   |                    |                                   |рег|   |-----------|       |        | факт  |остаток|         ');
              add( '    |             |                    |                                   |   |   | по  |  по |       |        |(часы) |(часы) |         ');
              add( '    |             |                    |                                   |   |   |плану|факту|       |        |       |       |         ');
              add( RepeatLine('-', m));
              k := 1;
            end;

            NmntStr := Query.FieldByName('Nmnt').AsString;
            CstStr  := Query.FieldByName('NAME_1').AsString;
{            ShowMessage('Query = ' + Query.FieldByName('NAME_1').AsString + '     CstStr='+CstStr+
                        'Query = ' + Query.FieldByName('Nmnt').AsString + '    NmntStr='+ NmntStr);}

            //цикл по все заказам одного заказчика sstr
            While (Query.FieldByName('NAME_1').AsString = CstStr) and
                  (Query.FieldByName('Nmnt').AsString = NmntStr)  and
                  (not Query.Eof)do
            begin

               PrForm.ProgressBar.Position:=(i+1)*100 div n;

               Order1Query.Close;
               Order1Query.ParamByName('id').AsInteger:=Query.FieldByName('ID').AsInteger;
               Order1Query.Open;

               Order2Query.Close;
               Order2Query.ParamByName('id').AsInteger:=Query.FieldByName('ID').AsInteger;
               Order2Query.Open;

               sstr := '';
               sstr :=RightLine(IntToStr(k), 4)
                    + '|'
                    + RightLine(Query.FieldByName('NUMBER').AsString
                    + '/'
                    + Query.FieldByName('NUMBER_1').AsString, 13)
                    + '|'
                    + LeftLine(Query.FieldByName('CODE').AsString, 20)
                    + '|'
                    + LeftLine(ReplaceStr(Query.FieldByName('NAME').AsString,'ОТЛ.',''), 35)
                    + '|';
               //  месяц окончания (регистрации)
               DecodeDate(Query.FieldByName('DATE_IN').AsDateTime, Year, Month, Day);
               sstr := sstr
                     + CentrLine(IntToStr(Month),3)+'|';

               DecodeDate(Query.FieldByName('DATE_OUT').AsDateTime, Year, Month, Day);
               sstr := sstr
                     + CentrLine(IntToStr(Month),3)+'|';


               sstr := sstr
                     + RightLine(Query.FieldByName('NUMBER_P').AsString, 5)
                     + '|'
                     + RightLine(Query.FieldByName('NUMBER_F').AsString, 5)
                     + '|';
               SumFakt := SumFakt
                        + Query.FieldByName('NUMBER_F').AsInteger;
               SumPlan := SumPlan
                        + Query.FieldByName('NUMBER_P').AsInteger;

               if Query.FieldByName('NUMBER_P').AsInteger
                   - Query.FieldByName('NUMBER_F').AsInteger >= 0 Then
                begin
                    sstr := sstr
                          + RightLine(IntToStr(Query.FieldByName('NUMBER_P').AsInteger
                            - Query.FieldByName('NUMBER_F').AsInteger),7)
                          + '|';
                    SumOst := SumOst
                            + Query.FieldByName('NUMBER_P').AsInteger
                              -Query.FieldByName('NUMBER_F').AsInteger;

               end
                else
                    sstr := sstr
                          + RightLine('0',7)
                          + '|';

               sstr := sstr
                     + RightLine(Query.FieldByName('CODE_1').AsString, 8)
                     + '|';

               if Order2Query.FieldByName('TIME_F').AsFloat>=0 then
               begin
                    sstr   := sstr +
                              RightLine(FormatFloat( '0.00',Order2Query.FieldByName('TIME_F').AsFloat
                              * Query.FieldByName('NUMBER_F').AsInteger), 7)+'|';
                    SumTrF := SumTrF
                            + Order2Query.FieldByName('TIME_F').AsFloat
                              * Query.FieldByName('NUMBER_F').AsInteger;

               end
                else
                      sstr := sstr +
                              RightLine('0',7)+'|';

               if Order1Query.FieldByName('TIME_P').AsFloat
                    *Query.FieldByName('NUMBER_P').AsInteger -
                      Order2Query.FieldByName('TIME_F').AsFloat
                       *Query.FieldByName('NUMBER_F').AsInteger>=0 then

                begin
                    sstr := sstr+
                            RightLine(FormatFloat( '0.00',Order1Query.FieldByName('TIME_P').AsFloat
                             *Query.FieldByName('NUMBER_P').AsFloat
                               - Order2Query.FieldByName('TIME_F').AsFloat
                                 * Query.FieldByName('NUMBER_F').AsFloat),7)+'|';
                    SumTrOst := SumTrOst
                              + Order1Query.FieldByName('TIME_P').AsFloat
                               * Query.FieldByName('NUMBER_P').AsFloat
                                 - Order2Query.FieldByName('TIME_F').AsFloat
                                   * Query.FieldByName('NUMBER_F').AsFloat;


               end
                else
                     sstr := sstr
                           + RightLine('0', 7)+'|';

               //Себестоимость заказа
               OrderPriceQuery.Close;
               OrderPriceQuery.ParamByName('ID_ORDER').AsInteger := Query.FieldByName('ID').AsInteger;
               OrderPriceQuery.Open;

               sstr := sstr + RightLine(
                  FormatFloat( '0.00',OrderPriceQuery.FieldByName('FAKT_TOTAL_PRICE').AsFloat), 11);
               SumSeb := SumSeb + RoundTo(OrderPriceQuery.FieldByName('FAKT_TOTAL_PRICE').AsFloat,-2);

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

                If (CstStr <> Query.FieldByName('NAME_1').AsString) or
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

  Form.Caption := 'Отчет по годовому журналу';
  Form.Editor.show;
  Form.onshow;
  Form.show;

end;



//    Процедуры выбора значения поля из справочника
//

procedure TReport12Form.CSTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qCSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Заказчики (Выбор)', 0);

end;


procedure TReport12Form.CSTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qCSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport12Form.FormCreate(Sender: TObject);
begin

  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ReviewComboBox.itemindex := 0;
  FeatComboBox.itemindex := 0;

end;

procedure TReport12Form.CancelButtonClick(Sender: TObject);
begin
   close;

end;


procedure TReport12Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);

end;

procedure TReport12Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);

end;

procedure TReport12Form.Button1Click(Sender: TObject);
var Form :  TShowPrintForm;
  PrForm : TProcessForm;      // форма прогрессора
//    tablestr: string;
     sizestr: string;
       i : integer;
    what : String; //параметр содержит кусок запроса содержащий информацию
                   //какую ведомость достаем
begin
       Form   := TShowPrintForm.create(Application);
       PrForm := TProcessForm.create(Application);

       //Параметр what отвечает за признак готовности заказа
       If ReviewComboBox.itemindex = 0 Then
            what:='';
       If ReviewComboBox.itemindex = 1 Then
            what:='b.PR_EXEC = 3 and ';
       If ReviewComboBox.itemindex = 2 Then
            what:='b.PR_EXEC = 2 and ';
       If ReviewComboBox.itemindex = 3 Then
            what:='b.PR_EXEC = 1 and ';

       Query.Close;
       Query.SQL.Clear;
       Query.SQL.Add('Select a.NUMBER, b.NUMBER, c.CODE, c.NAME, e.CODE, m.NAME, ');
       Query.SQL.Add('b.NUMBER_P, b.NUMBER_F, m.CODE, b.DATE_IN, b.ID');
       Query.SQL.Add('From DH_Rqst a, Spr_Chrt c, ');
       Query.SQL.Add('Spr_Pdr e, Spr_Cst  m, ');
       Query.SQL.Add('DH_Order b left join spr_nmnt d on d.ID = b.ID_NMNT');
       Query.SQL.Add('Where ');

       If FeatComboBox.itemindex = 1 Then
            Query.SQL.Add('b.WEIGHT_F = 0 and ');
       If FeatComboBox.itemindex = 2 Then
            Query.SQL.Add('b.WEIGHT_F = 1 and ');
       If FeatComboBox.itemindex = 3 Then
            Query.SQL.Add('b.WEIGHT_F = 2 and ');

       //Параметр = Чертежу
       if (ChrtCombo.Text <> '<Object not found>') and (ChrtQuery.active) then
          Query.SQL.Add('c.id = ' + ChrtQuery.Fields[0].asstring + ' and ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (qCSTQuery.active) then
          Query.SQL.Add('m.id = ' + qCSTQuery.Fields[0].asstring + ' and ');

       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (qPdrQuery.active) then
          Query.SQL.Add('e.id = ' + qPdrQuery.Fields[0].asstring + ' and ');

       //Параметр = Заявке
       if (RqstEdit.Text <> '')  then
             Query.SQL.Add('a.number = ' + Trim(RqstEdit.Text)+ ' and ');

       //Параметр = Заказу
       if (OrderEdit.Text <> '')  then
             Query.SQL.Add('b.number = ' + Trim(OrderEdit.Text)+ ' and ');

       Query.SQL.Add('a.ID_CST = m.ID and b.ID_RQST = a.ID ');
       Query.SQL.Add('and '+ what +' c.ID = b.ID_CHRT and ');
       Query.SQL.Add('e.ID = b.ID_PDR and ');
       Query.SQL.Add('b.DATE_IN>=:begdate and b.DATE_IN<=:enddate');
       Query.SQL.Add('Order by 9, 1, 2');

       Query.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
       Query.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);

       Query.Open;
       If Query.Eof Then
       begin
            MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
            Exit;
       end;

       i := 0;
       Form.Editor.Visible := False;
       PrForm.Show;

       //цикл по количеству заказов
       While i< Query.RecordCount do
       begin

          PrForm.ProgressBar.Position:=(i+1)*100 div Query.RecordCount;
//          ShowMessage(Query.FieldByName('ID').AsString);

          // основной запрос
          with qMainquery do
          begin
            close;
            parambyname('iddoc').asinteger := Query.FieldByName('ID').AsInteger;
            open;
            if eof then
              showmessage('Не полностью заполнены реквизиты документа!')
          end;

          // запрос по материалам
          with qMTRQuery do
          begin
            close;
            parambyname('iddoc').asinteger := Query.FieldByName('ID').AsInteger;
            open;
          end;

          //  запрос по затратам
          with qTableQuery do
          begin
            close;
            parambyname('iddoc').asinteger := Query.FieldByName('ID').AsInteger;
            open;
          end;

          //  запрос по размерам детали
          with ChrcQuery do
          begin
            close;
            parambyname('id').asinteger := Query.FieldByName('ID').AsInteger;
            open;
          end;

          //  запрос по размерам заготовки
          with MtrpQuery do
          begin
             close;
             parambyname('id').asinteger := Query.FieldByName('ID').AsInteger;
             open;
          end;


          //формирование строки размеров
          sizestr:='';
          While not ChrcQuery.Eof do
          begin
            If ChrcQuery.FieldByName('NSIZE').AsFloat <> 0 Then
                sizestr:=sizestr+FormatFloat('0,00', ChrcQuery.FieldByName('NSIZE').AsFloat)+' x ';
                ChrcQuery.Next;
          end;

          ChrcQuery.First;
          While not ChrcQuery.Eof do
          begin
             If ChrcQuery.FieldByName('KIND').AsString <> '' Then
                 sizestr:=sizestr+Trim(ChrcQuery.FieldByName('KIND').AsString)+' x ';
             ChrcQuery.Next;
          end;

          sizestr:=Copy(sizestr,1,Length(sizestr)-3);

          // формирование строк
          with Form.Editor.Lines do
          begin

             Add('');
             Add('');
             Add(RepeatLine('-', 94));
             Add('');
             Add( CentrLine('МАРШРУТНАЯ КАРТА № '+qMainQuery.FieldByName('Number').asstring + '/' +
                                                  qMainQuery.FieldByName('Number_1').asstring, 94));
             Add('');
             Add('Цех: '+LeftLine(qMainQuery.FieldByName('Name').asstring, 52)+'   '+
                 'Срочность: '+qMainQuery.FieldByName('PR_URGEN').asstring);
             Add('');
             Add('Чертеж: '+LeftLine(ReplaceStr(qMainQuery.FieldByName('Name_1').asstring,'  ', ''),49)+'   '+
                 'Размеры: '+sizestr);
             Add('');
             Add('Номенклатурный номер: '+LeftLine(qMainQuery.FieldByName('Code').asstring, 43));
             Add('Номенклатура: '+LeftLine(qMainQuery.FieldByName('Name_2').asstring, 43)+'   '+
                 'Месяц: '+MonthByString(qMainQuery.FieldByName('date_in').asdatetime));
             Add('');
             Add('Заказчик: '+ LeftLine(ReplaceStr(qMainQuery.FieldByName('Name_3').asstring,' ',''),60));
             Add('');
             Add('Длина     Ширина     Высота       Вес      Вид заготовки');

             While not MtrpQuery.Eof do
             begin
                add(LeftLine(FormatFloat('0.000', MtrpQuery.FieldByName('lenght').AsFloat),9)+' '+
                    LeftLine(FormatFloat('0.000', MtrpQuery.FieldByName('Width').AsFloat), 10)+' '+
                    LeftLine(FormatFloat('0.000', MtrpQuery.FieldByName('hight').AsFloat), 12)+' '+
                    LeftLine(FormatFloat('0.000', MtrpQuery.FieldByName('Weight').AsFloat), 8)+' '+
                    LeftLine(MtrpQuery.FieldByName('Name').AsString, 50));
                MtrpQuery.Next;
             end;
             Add('');

             Add(RepeatLine('=', 94));
             Add(':#п/п:           Операция             : Разряд : Норма : Кол-во : Кол-во : Табельный : ОТК   :');
             Add(':    :                                :  работ :времени: заказ  :  факт  :   номер   :       :');
             Add(RepeatLine('=', 94));

             // таблица 1

             while not qTableQuery.eof do
             begin
                Add(RightLine(qTableQuery.FieldByName('lineno').asstring,4)+' '+
                    LeftLine(qTableQuery.FieldByName('Name').asstring, 32) +' '+
                    RightLine(qTableQuery.FieldByName('Rating').asstring, 8)+' '+
                    RightLine(FormatFloat('0.000', qTableQuery.FieldByName('NTIME').asfloat / 1000),8)+' '+
                    RightLine(FormatFloat('0.00', qMainQuery.FieldByName('Number_P').asfloat),8));

                qTableQuery.next;

             end;


             // таблица 2 материалов
             Add('');
             Add('в т.ч. материалы');

             while not qMTRQuery.eof do
             begin
                Add('     '+LeftLine(qMTRQuery.FieldByName('Name').asstring, 40)+' '+
                             RightLine(qMTRQuery.FieldByName('Number').asstring,9)+' '+
                             RightLine(FormatFloat( '0.00', qMTRQuery.FieldByName('Price').value),8));

                qMTRQuery.next;
             end;
          end;
          Query.Next;
          i:=i+1;

       end;

  PrForm.Destroy;

  Form.Caption := 'Печать маршрутной карты #' +  qMainQuery.FieldByName('Number').asstring;
  Form.Editor.Visible := True;
  Form.show;

end;

procedure TReport12Form.ChrtComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, ChrtQuery, ChrtCombo, 'select id, code, name from spr_chrt',
                        'Справочник: Чертежи (Выбор)', 0);
end;

procedure TReport12Form.ChrtComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(ChrtQuery, ChrtCombo, key, Shift, 1) = false then
    ChrtComboButtonClick(Sender);
end;

procedure TReport12Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport12Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport12Form.ButtonSelPerOutClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport12Form.OutMemoBoxClick(Sender: TObject);
begin
  If OutMemoBox.Checked = True Then OutMemoBox.Font.Style := [fsBold]
   else OutMemoBox.Font.Style := [];

end;

procedure TReport12Form.NmntRadioButtonClick(Sender: TObject);
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

procedure TReport12Form.CstRadioButtonClick(Sender: TObject);
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


procedure TReport12Form.PerInRadioButtonClick(Sender: TObject);
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

procedure TReport12Form.PerOutRadioButtonClick(Sender: TObject);
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

end.
