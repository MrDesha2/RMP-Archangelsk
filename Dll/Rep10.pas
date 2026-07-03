{***************************************************************
 *
 * Unit Name: Rep10
 * Purpose  :
 *     Форма отчета
 *     Отчет по плану
 * Author   : Косицын Дмитрий, Соколов Владислав
 * History  : 2004
 *
 ****************************************************************}


unit Rep10;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ExtCtrls, Mask, ToolEdit, DateUtil, EnumForm4Sel,
  ComCtrls, DateUtils;

type
  TReport10Form = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    CancelButton: TButton;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    qPDRQuery: TQuery;
    MainQueryAll: TQuery;
    MtchQueryCMO: TQuery;
    TimeOperQueryCMO: TQuery;
    MainQueryCMO: TQuery;
    MainQueryCCR: TQuery;
    TimeOperQueryCCR: TQuery;
    MainQueryMS: TQuery;
    TimeOperQueryMS: TQuery;
    FailQueryMS: TQuery;
    GroupBox2: TGroupBox;
    PDRCombo: TComboEdit;
    ButtonOther: TButton;
    OKButton: TButton;
    ButtonCCR: TButton;
    ButtonCCR_2: TButton;
    NmntAllQuery: TQuery;
    Order1AllQuery: TQuery;
    Order2AllQuery: TQuery;
    EdizAllQuery: TQuery;
    NmntQueryMS: TQuery;
    Order1QueryMS: TQuery;
    NmntQueryCMO: TQuery;
    StrgQueryCMO: TQuery;
    OpchQueryCMO: TQuery;
    NmntQueryCCR: TQuery;
    Order1QueryCCR: TQuery;
    Order2QueryCCR: TQuery;
    MonthAllQuery: TQuery;
    MonthComboBox: TComboBox;
    CstAllQuery: TQuery;
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCCRClick(Sender: TObject);
    procedure ButtonOtherClick(Sender: TObject);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonCCR_2Click(Sender: TObject);
    procedure DateEditChange(Sender: TObject);
    procedure FillPeriod;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
     aMonth   : array [0..13] of String;
  end;

var
  Report10Form: TReport10Form;

implementation

uses PrintFrm, printlibs,
         Libs, PrintProces;



{$R *.DFM}


{


      форма для ЦМО



}

procedure TReport10Form.OKButtonClick(Sender: TObject);
var
 MasVop : array[0..8] of Integer; 
 sstr   : String;
 CstStr : integer;
   i,j  : Integer;
     k  : Integer; //порадковый номер строки
     n  : Integer; //ширина отчёта
Total_k : Integer;
SumKolP : Real;  // Итог по количеству по плану
SumTime : Real;  // Итог по общему времени
SumTok  : Real;  // Итог по времени токарных станков
SumFr   : Real;  // Итог по времени фрезерных станков
SumRast : Real;  // Итог по времени расточных станков
SumStr  : Real;  // Итог по времени строгательных станков
SumSl   : Real;  // Итог по времени слесарных станков
SumShl  : Real;  // Итог по времени шлифовальных станков
SumSver : Real;  // Итог по времени сверлильных станков
SumSum  : Real;  // Итог по сумме
TotalSumKolP : Real;  // Итог по количеству по плану
TotalSumTime : Real;  // Итог по общему времени
TotalSumTok  : Real;  // Итог по времени токарных станков
TotalSumFr   : Real;  // Итог по времени фрезерных станков
TotalSumRast : Real;  // Итог по времени расточных станков
TotalSumStr  : Real;  // Итог по времени строгательных станков
TotalSumSl   : Real;  // Итог по времени слесарных станков
TotalSumShl  : Real;  // Итог по времени шлифовальных станков
TotalSumSver : Real;  // Итог по времени сверлильных станков
TotalSumSum  : Real;  // Итог по сумме
Year, Month, Day : Word;
MonthBet: Integer;
   Form : TShowPrintForm;
 PrForm : TProcessForm;

begin

       If MonthComboBox.ItemIndex = -1 Then
       begin
          MessageDlg('Период не определен!', mtWarning , [mbYes], 0);
          Exit;
       end;

       If (PdrCombo.Text = '<Object not found>') or not (qPDRQuery.Active) Then
       begin
          MessageDlg('Подразделение не определено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       // форма для вывода
       // владелец - программа, а не dll
        Form := TShowPrintForm.create(Application);
        PrForm  := TProcessForm.create(Application);

//        Form.Editor.Paragraph.FirstIndent := 25;

        TotalSumKolP := 0;
        TotalSumTime := 0;
        TotalSumTok  := 0;
        TotalSumFr   := 0;
        TotalSumRast := 0;
        TotalSumStr  := 0;
        TotalSumSl   := 0;
        TotalSumShl  := 0;
        TotalSumSver := 0;
        TotalSumSum  := 0;

        MasVop[1]:=1;
        MasVop[2]:=2;
        MasVop[3]:=3;
        MasVop[4]:=4;
        MasVop[5]:=5;
        MasVop[6]:=4409;
        MasVop[7]:=6;

        n := 191;

     // формирование строк
     with Form.Editor.lines do
      begin

         clear;

         // вывод шапки отчета
         add( RepeatLine('-', n));
         add( '');
         add( RepeatLine(Chr(32),77)+'П Л А Н'+RepeatLine(Chr(32),45)+'УТВЕРЖДАЮ:');
         add( '');
         add( RepeatLine(' ', 127)+'ГЛАВНЫЙ МЕХАНИК');
         add( RepeatLine(' ', 10)+'НАЧАЛЬНИК ЦЕХА'+RepeatLine(' ', 44)+'РАБОТ НА '+
         MonthComboBox.Text+' года '+RepeatLine(' ', 32)+GetSystemParams('Enterprise'));
         add( '');
         add( RepeatLine(' ', 10)+'МЕХАНИЧЕСКОЙ ОБРАБОТКИ __________________'
                 + RepeatLine(' ', 17)
                 + 'ДЛЯ МЕХАНИЧЕСКОГО ЦЕХА РМЗ'
                 +RepeatLine(' ', 34)+GetSystemParams('Mechanic'));
         add( '');
         add( RepeatLine(' ',69) + PDRCombo.Text);
         add( '');
         add( '');

         //Открываю запрос основной информации по заказам:
         // 1) наименование и код заказчика 2)наименование номенклатуры
         // 3) код чертежа 4) дата завершения заказа
         // 5) наименование вида заготовки 6) сумма времени изготовления номенклатуры
         // 7) цена изготовления номенклатуры

         {MainQueryCMO - ЗАПРОС КОТОРЫЙ БЫЛ (отличается только Spr_Cst c
          Select b.ID, a.NUMBER, b.NUMBER, c.CODE, c.NAME, c.id,
          e.CODE, b.DATE_OUT, b.NUMBER_P, e.NAME, g.NAME

          From DH_RQST a, DH_Order b, Spr_Cst c,
          Spr_Chrt e, JR_PLAN f, Spr_Cst g
          Where  f.PERIOD = :month and b.ID = f.ID_ORDER
          and a.ID = b.ID_RQST and b.ID_PDR = :pdr
          and c.ID = a.ID_CST  and e.ID = b.ID_Chrt
          and g.ID = c.PARENTID

          Group by b.ID, a.NUMBER, b.NUMBER, c.CODE, c.NAME, c.id,
          e.CODE, b.DATE_OUT, b.NUMBER_P, e.NAME, g.NAME

          Order by 11, 5}

         //Выщитываю количество месяцев прошедших с 01.01.2000
         MonthBet:=MonthComboBox.ItemIndex;
         MainQueryCMO.Close;
         MainQueryCMO.ParamByName('month').AsInteger := MonthBet;
         MainQueryCMO.ParamByName('pdr').AsInteger := qPDRQuery.Fields[0].asinteger;
         MainQueryCMO.Open;

         i := 1;
         k := 1;
         Total_k := 0;

         PrForm.Show;

         //цикл по количеству заказов
         While i<= MainQueryCMO.RecordCount do
          begin

            add( '');
            add( RightLine( //'('+MainQueryCMO.FieldByName('NAME_2').AsString+') ' +
                           MainQueryCMO.FieldByName('NAME').AsString,n));
            add( RepeatLine('=', n));
            add( ' №  |  № заявки/  |             Деталь              |      Чертеж      |Месяц| Заготовка | Кол-во |  Время  |Токарные |Фрезерные|Расточные| Строга- |Слесарные|Шлифоваль|Пилоотрез|   Сумма    |');
            add( 'п.п.|  № заказа   |                                 |                  |     |           |по плану|на ед-цу |         |         |         | тельные |         |   ные   |   ная   |            |');
            add( RepeatLine('=', n));


            CstStr := MainQueryCMO.FieldByName('id_1').Asinteger;

            SumKolP :=0;
            SumTime :=0;
            SumTok  :=0;
            SumFr   :=0;
            SumRast :=0;
            SumStr  :=0;
            SumSl   :=0;
            SumShl  :=0;
            SumSver :=0;
            SumSum  :=0;
//            k := 1;

            //цикл по все заказам одного заказчика sstr
            While (MainQueryCMO.FieldByName('id_1').Asinteger = CstStr) and
                  (not MainQueryCMO.Eof)do
            begin

               PrForm.ProgressBar.Position:=(i)*100 div MainQueryCMO.RecordCount;
               NmntQueryCMO.Close;
               NmntQueryCMO.ParamByName('id').AsInteger:=MainQueryCMO.FieldByName('ID').AsInteger;
               NmntQueryCMO.Open;
               StrgQueryCMO.Close;
               StrgQueryCMO.ParamByName('id').AsInteger:=MainQueryCMO.FieldByName('ID').AsInteger;
               StrgQueryCMO.Open;
               OpchQueryCMO.Close;
               OpchQueryCMO.ParamByName('id').AsInteger:=MainQueryCMO.FieldByName('ID').AsInteger;
               OpchQueryCMO.Open;

               sstr    := '';
               DecodeDate(MainQueryCMO.FieldByName('DATE_OUT').AsDateTime, Year, Month, Day);

               SumKolP := SumKolP + MainQueryCMO.FieldByName('NUMBER_P').AsFloat;
               SumTime := SumTime + OpchQueryCMO.FieldByName('SumTime').AsFloat;

               sstr := RightLine(IntToStr(k), 4)+' '
                     + RightLine(MainQueryCMO.FieldByName('NUMBER').AsString
                     + '/'
                     + MainQueryCMO.FieldByName('NUMBER_1').AsString, 13)
                     + ' '
                     + LeftLine(MainQueryCMO.FieldByName('NAME_1').AsString, 33)
                     //если все нормально, то удалить NmntQueryCMO
//                     + LeftLine(NmntQueryCMO.FieldByName('NAME').AsString, 23)
                     + ' '
                     + LeftLine(MainQueryCMO.FieldByName('CODE_1').AsString, 18)
                     + ' '
                     + CentrLine(IntToStr(Month), 5)
                     + ' '
                     + LeftLine(StrgQueryCMO.FieldByName('NAME').AsString, 11)
                     + ' '
                     + RightLine(MainQueryCMO.FieldByName('NUMBER_P').AsString, 8)
                     + ' '
                     + RightLine(OpchQueryCMO.FieldByName('SumTime').AsString, 9)
                     + ' ';

               If RadioButton1.Checked = True Then
               begin
                  //По всем 7 видам (по их кодам в базе) операций, собираем сумму времени
                  For j := 1 to 7 do
                  begin
                     TimeOperQueryCMO.Close;
                     TimeOperQueryCMO.ParamByName('id').AsInteger :=
                                 MainQueryCMO.FieldByName('ID').AsInteger;
                     TimeOperQueryCMO.ParamByName('parentid').AsInteger := MasVop[j];
                     TimeOperQueryCMO.Open;

                     sstr := sstr
                           + RightLine(FormatFloat( '0.000',TimeOperQueryCMO.FieldByName('AllTime').AsFloat
                             * MainQueryCMO.FieldByName('NUMBER_P').AsInteger) , 9)
                           + ' ';


                     //накапливаю сумму по каждому виду станочных работ
                     Case j of
                        1 : SumTok := SumTok
                                    + TimeOperQueryCMO.FieldByName('AllTime').AsFloat
                                      * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;

                        2 : SumFr  := SumFr
                                    + TimeOperQueryCMO.FieldByName('AllTime').AsFloat
                                     * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;

                        3 : SumRast := SumRast
                                    + TimeOperQueryCMO.FieldByName('AllTime').AsFloat
                                      * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;

                        4 : SumStr := SumStr
                                    + TimeOperQueryCMO.FieldByName('AllTime').AsFloat
                                      * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;

                        5 : SumSl  := SumSl
                                    + TimeOperQueryCMO.FieldByName('AllTime').AsFloat
                                      * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;
                        6 : SumShl := SumShl
                                    + TimeOperQueryCMO.FieldByName('AllTime').AsFloat
                                      * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;
                        7 : SumSver := SumSver
                                    + TimeOperQueryCMO.FieldByName('AllTime').AsFloat
                                      * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;
                     end;
                  end;
                  //Вывод суммы
//                  sstr   := sstr
//                          + RightLine(OpchQueryCMO.FieldByName('SumPrice').AsString, 12);
                  sstr   := sstr
                          + RightLine(FormatFloat('0.00',MainQueryCMO.FieldByName('NUMBER_P').AsInteger
                          * OpchQueryCMO.FieldByName('SumTime').AsFloat), 12);
                  //сумма в денежном соотношении
//                SumSum := SumSum
//                        + OpchQueryCMO.FieldByName('SumPrice').AsFloat
//                         * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;

                  //сумма во временном соотношении
                  SumSum := SumSum
                          + OpchQueryCMO.FieldByName('SumTime').AsFloat
                           * MainQueryCMO.FieldByName('NUMBER_P').AsInteger;


               end;
               add( sstr);

               //запись материалов
               MtchQueryCMO.Close;
               MtchQueryCMO.ParamByName('id').AsInteger
                     := MainQueryCMO.FieldByName('ID').AsInteger;
               MtchQueryCMO.Open;

               if not MtchQueryCMO.Eof Then
               begin
                  add( RepeatLine('-', 70));
                  add( '             Материал              | Высота | Длина | Ширина |  Вес  |');
                  add( RepeatLine('-', 70));
               end;

               //цикл вывода материалов с размерами
               While not MtchQueryCMO.Eof do
               begin
                  add(LeftLine(MtchQueryCMO.FieldByName('NAME').AsString, 31)
                       + ' '
                       + RightLine(MtchQueryCMO.FieldByName('HIGHT').AsString, 8)
                       + ' '
                       + RightLine(MtchQueryCMO.FieldByName('LENGHT').AsString, 7)
                       + ' '
                       + RightLine(MtchQueryCMO.FieldByName('WIDTH').AsString, 8)
                       + ' '
                       + RightLine(MtchQueryCMO.FieldByName('WEIGHT').AsString, 7));


                  MtchQueryCMO.Next;
               end;

               add('');
               add( RepeatLine('.', n));
               add('');

               MainQueryCMO.Next;
               i := i + 1;
               k := k + 1;
            end;

            Total_k:=Total_k+k-1;
            add( RepeatLine('=', n));

            //вывод итогов по видам станочных операций
            If RadioButton1.Checked = True Then
            begin
               add( RepeatLine(' ', 83)
                   + 'ИТОГО: '
                   + RightLine(FormatFloat( '0.000', SumKolP),  8)
                   + ' ' //+ RepeatLine(' ', 18)
                   + RightLine(FormatFloat( '0.00', SumTime),  9)
                   + ' '
                   + RightLine(FormatFloat( '0.00', SumTok),  9)
                   + ' '
                   + RightLine(FormatFloat( '0.00', SumFr),   9)
                   + ' '
                   + RightLine(FormatFloat( '0.00', SumRast), 9)
                   + ' '
                   + RightLine(FormatFloat( '0.00', SumStr),  9)
                   + ' '
                   + RightLine(FormatFloat( '0.00', SumSl),   9)
                   + ' '
                   + RightLine(FormatFloat( '0.00', SumShl),   9)
                   + ' '
                   + RightLine(FormatFloat( '0.00', SumSver),   9)
                   + ' '
                   + RightLine(FormatFloat( '0.00', SumSum),  12));


               TotalSumKolP := TotalSumKolP + SumKolP;
               TotalSumTime := TotalSumTime + SumTime;
               TotalSumTok  := TotalSumTok  + SumTok;
               TotalSumFr   := TotalSumFr   + SumFr;
               TotalSumRast := TotalSumRast + SumRast;
               TotalSumStr  := TotalSumStr  + SumStr;
               TotalSumSl   := TotalSumSl   + SumSl;
               TotalSumShl  := TotalSumShl  + SumShl;
               TotalSumSver := TotalSumSver + SumSver;
               TotalSumSum  := TotalSumSum  + SumSum;
            end;


            add( '');
            add( '');

         end;

         add( '');
         add( '');
         add( RepeatLine('*', n));
         add( RepeatLine(' ', 83)
              + 'ВСЕГО: '
              + RightLine(FormatFloat( '0.000', TotalSumKolP),  8)
              + ' ' //+ RepeatLine(' ', 18)
              + RightLine(FormatFloat( '0.00', TotalSumTime),  9)
              + ' '
              + RightLine(FormatFloat( '0.00', TotalSumTok),  9)
              + ' '
              + RightLine(FormatFloat( '0.00', TotalSumFr),   9)
              + ' '
              + RightLine(FormatFloat( '0.00', TotalSumRast), 9)
              + ' '
              + RightLine(FormatFloat( '0.00', TotalSumStr),  9)
              + ' '
              + RightLine(FormatFloat( '0.00', TotalSumSl),   9)
              + ' '
              + RightLine(FormatFloat( '0.00', TotalSumShl),   9)
              + ' '
              + RightLine(FormatFloat( '0.00', TotalSumSver),   9)
              + ' '
              + RightLine(FormatFloat( '0.00', TotalSumSum),  12));

         add( 'Количество позиций: ' + IntToStr(k-1)); //Total_k

    end;


  PrForm.Destroy;


  Form.Caption := 'План работ. Форма для цеха механической обработки.';
  Form.Editor.show;
  Form.show;

end;


procedure TReport10Form.CancelButtonClick(Sender: TObject);
begin
  close;
end;

procedure TReport10Form.FormCreate(Sender: TObject);
begin
  ListForm  := TLIST_4SELECTForm.create(self);
  FillPeriod;
end;







{

       Печать планового отчета.
       Форма для цеха централизованного ремонта




}

procedure TReport10Form.ButtonCCRClick(Sender: TObject);
Var

sstr   : String;
CstStr : integer;
  i,j  : Integer;
    n  : Integer; // Ширина отчёта
SumTak  : Real;  // Итог по времени такелажных работ
SumSv   : Real;  // Итог по времени сварочных работ
SumSl   : Real;  // Итог по времени слесарных работ
SumSum  : Real;  // Итог по сумме
Month   : Double;

   Form : TShowPrintForm;
 PrForm : TProcessForm;

const MasVOP  : array[1..3] of integer = (5,7,8);
begin

       If MonthComboBox.ItemIndex = -1 Then
       begin
          MessageDlg('Период не определен!', mtWarning , [mbYes], 0);
          Exit;
       end;

       If (PdrCombo.Text = '<Object not found>') or not (qPDRQuery.Active) Then
       begin
          MessageDlg('Подразделение не определено!', mtWarning , [mbYes], 0);
          Exit;
       end;
       
     Form     := TShowPrintForm.create(application);
     PrForm   := TProcessForm.create(application);

     n := 196;

     // формирование строк
     with Form.Editor.lines do
      begin

         clear;

         // вывод шапки отчета
         add( RepeatLine('-', n));
         add( '');
         add( RepeatLine(Chr(32),97)+'П Л А Н'+RepeatLine(Chr(32),54)+'УТВЕРЖДАЮ:');
         add( '');
         add( RepeatLine(' ', 93)+'ГЛАВНЫЙ МЕХАНИК');
         add( RepeatLine(' ', 10)+'НАЧАЛЬНИК ЦЕХА'+RepeatLine(' ', 62)+'РАБОТ НА '+
               MonthComboBox.Text+' месяц'+RepeatLine(' ', 42)+GetSystemParams('Enterprise'));
         add( '');
         add( RepeatLine(' ', 10)+'ЦЕНТРАЛИЗОВАННОГО РЕМОНТА РМП ______________________'
               + RepeatLine(' ', 21)
               +'ДЛЯ ЦЕХА ЦЕНТРАЛИЗОВАННОГО РЕМОНТА'
               +RepeatLine(' ', 40)+GetSystemParams('Mechanic'));
         add( '');
         add( '');

         //Открываю запрос основной информации по заказам:
         // 1) наименование и код заказчика 2)наименование номенклатуры
         // 3) код чертежа 4) дата завершения заказа
         // 5) наименование вида заготовки 6) сумма времени изготовления номенклатуры
         // 7) цена изготовления номенклатуры

         //Выщитываю количество месяцев прошедших с 01.01.2000
         Month:=MonthComboBox.ItemIndex;

         MainQueryCCR.Close;
         MainQueryCCR.ParamByName('month').AsInteger := Trunc(Month);
         MainQueryCCR.ParamByName('pdr').AsInteger := qPDRQuery.Fields[0].asinteger;
         MainQueryCCR.Open;

         i := 0;

         PrForm.Show;
         //цикл по количеству заказов
         While i< MainQueryCCR.RecordCount do
         begin
            add( '');
            add( RepeatLine('-', n));
            add( '  № заявки/  |       Наименование работ        |      Чертеж      |                     Заказчик                     | Т/з общие     |     Т/з на текущий месяц      |  Т/з  |План |Факт |  Приме-  ');
            add( '  № заказа   |                                 |                  |                                                  |---------------|-------------------------------| факт. |  %  |  %  |  чания   ');
            add( '             |                                 |                  |                                                  |На весь|За пре-|Слесар-|Такела-| Эл.г. | Всего | ч/дн  |вып. |вып. |          ');
            add( '             |                                 |                  |                                                  |       |ыдущие | ные   | жные  |свароч-| ч/дн. |       |     |     |          ');
            add( '             |                                 |                  |                                                  |       |месяцы | ч/дн  | ч/дн  |  ные  |       |       |     |     |          ');
            add( '             |                                 |                  |                                                  |       |       |       |       | ч/дн  |       |       |     |     |          ');
            add( RepeatLine('-', n));

            CstStr := MainQueryCCR.FieldByName('id_1').Asinteger;

           SumTak  := 0;
           SumSv   := 0;
           SumSl   := 0;
//           SumSum  := 0;

          // ShowMessage('Заказчик ' + IntToStr(CstStr));
            //цикл по все заказам одного заказчика sstr
            While (MainQueryCCR.FieldByName('id_1').Asinteger = CstStr) or
                  (not MainQueryCCR.Eof)do
            begin

               PrForm.ProgressBar.Position:=(i+1)*100 div MainQueryCCR.RecordCount;
               NmntQueryCCR.Close;
               NmntQueryCCR.ParamByName('id').AsInteger:=MainQueryCCR.FieldByName('ID').AsInteger;
               NmntQueryCCR.Open;

               Order1QueryCCR.Close;
               Order1QueryCCR.ParamByName('id').AsInteger:=MainQueryCCR.FieldByName('ID').AsInteger;
               Order1QueryCCR.Open;

               Order2QueryCCR.Close;
               Order2QueryCCR.ParamByName('id').AsInteger:=MainQueryCCR.FieldByName('ID').AsInteger;
               Order2QueryCCR.Open;

               sstr    := '';
//               SumTak  := 0;
//               SumSv   := 0;
//               SumSl   := 0;
               SumSum  := 0;

               sstr := RightLine(MainQueryCCR.FieldByName('NUMBER').AsString
                     + '/'
                     + MainQueryCCR.FieldByName('NUMBER_1').AsString, 13)
                     + ' '
                     + LeftLine(MainQueryCCR.FieldByName('NAME_1').AsString, 33)
                     + ' '
                     + LeftLine(MainQueryCCR.FieldByName('CODE').AsString, 18)
                     + ' '
                     + LeftLine(MainQueryCCR.FieldByName('NAME').AsString, 50)
                     + ' '
                     + RightLine(Order1QueryCCR.FieldByName('SumPTime').AsString, 7)
                     + ' '
                     + RightLine(Order2QueryCCR.FieldByName('SumFTime').AsString, 7)
                     + ' ';

               If RadioButton1.Checked = True Then
               begin
                  //По всем 5 видам операций, собираем сумму времени
                  For j := 1 to 3 do
                  begin
                     TimeOperQueryCCR.Close;
                     TimeOperQueryCCR.ParamByName('id').AsInteger :=
                        MainQueryCCR.FieldByName('ID').AsInteger;
                     TimeOperQueryCCR.ParamByName('parentid').AsInteger :=
                        MasVOP[j];
                     TimeOperQueryCCR.ParamByName('month').AsInteger := Trunc(Month);
                     TimeOperQueryCCR.Open;

                     sstr := sstr
                           + RightLine(FormatFloat( '0.00', TimeOperQueryCCR.FieldByName('AllTime').AsFloat
                             *  MainQueryCCR.FieldByName('NUMBER_P').AsInteger) , 7)
                           + ' ';

                     //накапливаю сумму по каждому виду станочных работ
                     Case j of
                        1 : SumSl  :=SumSl  + TimeOperQueryCCR.FieldByName('AllTime').AsFloat*
                                                MainQueryCCR.FieldByName('NUMBER_P').AsInteger;
                        2 : SumTak :=SumTak + TimeOperQueryCCR.FieldByName('AllTime').AsFloat*
                                                MainQueryCCR.FieldByName('NUMBER_P').AsInteger;
                        3 : SumSv  :=SumSv  + TimeOperQueryCCR.FieldByName('AllTime').AsFloat*
                                                MainQueryCCR.FieldByName('NUMBER_P').AsInteger;
                     end;
                     SumSum := SumSum + TimeOperQueryCCR.FieldByName('AllTime').AsFloat*
                                           MainQueryCCR.FieldByName('NUMBER_P').AsInteger;

                  end;
                  //Вывод суммы
                  sstr := sstr
                        + RightLine(FormatFloat( '0.00', SumSum), 7)+' ';


                end

              else

                  sstr := sstr + RepeatLine(' ', 32);


               sstr := sstr
                     + RepeatLine(' ', 7)
                     + ' '
                     + CentrLine('100%',5);


               add( sstr);

               MainQueryCCR.Next;

               i := i + 1;


            end;

            add( RepeatLine('-', n));

            //вывод итогов по видам станочных операций
            If RadioButton1.Checked = True Then
            begin
               add( RepeatLine(' ', 127)
                    + 'ИТОГО: '
                    + RightLine(FormatFloat( '0.00', SumSl),  7)
                    + ' '
                    + RightLine(FormatFloat( '0.00', SumTak), 7)
                    + ' '
                    + RightLine(FormatFloat( '0.00', SumSv),  7));



            end;

            add( '');
            add( '');



         end;


     end;

  PrForm.Destroy;

  Form.Caption := 'План работ. Форма для ЦЦР';
  Form.Editor.show;
  Form.show;


end;





{


    Форма отчета для всех подразделений



}
procedure TReport10Form.ButtonOtherClick(Sender: TObject);
Var

 sstr   : String;
 CstStr : Integer;   // ID подразделения
CstParent : Integer; // PARENTID заказчика 
   i    : Integer;
   j    : Integer;   // Счетчик
   n    : Integer;   // Ширина отчёта
//Total_j : Integer;   // Сумма счетчика
   Form : TShowPrintForm;  // форма отчета
 PrForm : TProcessForm;    // форма прогрессора
 Month  : Double;
 pNorm, pOb, fNorm, fob : Real;  //Итого по плановой и фактической норме времени
 PCstNorm, FCstNorm  : Real;
 PlanParentCstNorm, FactParentCstNorm : Real; // Итог по производству
 tmpstr : String;

begin

       If MonthComboBox.ItemIndex = -1 Then
       begin
          MessageDlg('Период не определен!', mtWarning , [mbYes], 0);
          Exit;
       end;

       If (PdrCombo.Text = '<Object not found>') or not (qPDRQuery.Active) Then
       begin
          MessageDlg('Подразделение не определено!', mtWarning , [mbYes], 0);
          Exit;
       end;

     Form     := TShowPrintForm.create(application);
     PrForm   := TProcessForm.create(application);
     j  := 0;
     n  := 162;

     // формирование строк
     with Form.Editor.lines do
      begin

         clear;

         // вывод шапки отчета
         add( RepeatLine('-', n));
         add( '');
         add( RepeatLine(' ', 114) + CentrLine('УТВЕРЖДАЮ:',40));
         add( RepeatLine(' ', 114) + CentrLine('ГЛАВНЫЙ МЕХАНИК',40));
         add( RepeatLine(' ', 114) + CentrLine(GetSystemParams('Enterprise'),40));
         add( '');
         add( RepeatLine(' ', 114) + CentrLine('_________________' + GetSystemParams('Mechanic'),40));
         add( '');
         add( RepeatLine(' ', 114) + CentrLine('"    "_________________200  г.',40));
         add( '');
         add( CentrLine('План отчет участка (цеха) '+ PdrCombo.Text, n));
         add( CentrLine('на '+ MonthComboBox.Text+' месяц', n));
         add( '');

         add( '');
         add( RepeatLine('=', n));
         add( '     |   №заявки   |        Наименование работ         |      Чертеж      |  Месяц  | Ед. изм. |     Кол-во    |Плановая норма |Факт-кая норма |    Примечания         ');
         add( '  №  |      /      |           детали, узла            |                  |попадания|          |               |    времни     |    времени    |                       ');
         add( ' п.п.|   №заказа   |                                   |                  | в план  |          |---------------|---------------|---------------|                       ');
         add( '     |             |                                   |                  |         |          |  по   |   по  | норм. | общее | норм. | общее |                       ');
         add( '     |             |                                   |                  |         |          | плану | факту |       |       |       |       |                       ');
         add( RepeatLine('=', n));


         //Выщитываю количество месяцев прошедших с 01.01.2000
         Month:=MonthComboBox.ItemIndex;

         MainQueryAll.Close;
         MainQueryAll.ParamByName('month').AsInteger := Trunc(Month);
         MainQueryAll.ParamByName('pdr').AsInteger := qPDRQuery.Fields[0].asinteger;
         MainQueryAll.Open;

//         Total_j := 0;
         i := 0;
         PrForm.Show;

         //Обнуляем суммы по итогу
         pNorm:=0;
         pOb:=0;
         fNorm:=0;
         fob:=0;

         //цикл по количеству заказов
         While i< MainQueryAll.RecordCount do
         begin

            CstAllQuery.Close;
            CstAllQuery.ParamByName('id').AsInteger := MainQueryAll.FieldByName('parentid').AsInteger;
            CstAllQuery.Open;
            CstParent := CstAllQuery.FieldByName('id').AsInteger;
            add( 'Производство заказчик: '+CstAllQuery.FieldByName('NAME').AsString);
            PlanParentCstNorm := 0;
            FactParentCstNorm := 0;

            While (MainQueryAll.FieldByName('parentid').Asinteger = CstParent) and
                  (not MainQueryAll.Eof)do
            begin

               CstStr := MainQueryAll.FieldByName('id_1').Asinteger;
               add( '   Заказчик: '+MainQueryAll.FieldByName('NAME').AsString);
               //итоги по подразделению
               PCstNorm:=0;
               FCstNorm:=0;

               //цикл по все заказам одного заказчика sstr
               While (MainQueryAll.FieldByName('id_1').Asinteger = CstStr) and
                     (not MainQueryAll.Eof)do
               begin

                  PrForm.ProgressBar.Position:=(i+1)*100 div MainQueryAll.RecordCount;
                  //поиск номенклатуры по заказу
                  NmntAllQuery.Close;
                  NmntAllQuery.ParamByName('id').AsInteger := MainQueryAll.FieldByName('ID').AsInteger;
                  NmntAllQuery.Open;
                  //поиск суммарного времени на заказ по плану
                  Order1AllQuery.Close;
                  Order1AllQuery.ParamByName('id').AsInteger := MainQueryAll.FieldByName('ID').AsInteger;
                  Order1AllQuery.Open;
                  //поиск суммарного времени на заказ по факту
                  Order2AllQuery.Close;
                  Order2AllQuery.ParamByName('id').AsInteger := MainQueryAll.FieldByName('ID').AsInteger;
                  Order2AllQuery.Open;
                  //поиск едениц измереня номенклатуры
                  EdizAllQuery.Close;
                  EdizAllQuery.ParamByName('id').AsInteger := NmntAllQuery.FieldByName('ID').AsInteger;
                  EdizAllQuery.Open;
                  //поиск плансвсгс месяца
                  MonthAllQuery.Close;
                  MonthAllQuery.ParamByName('id').AsInteger := MainQueryAll.FieldByName('ID').AsInteger;
                  MonthAllQuery.Open;

                  j := j + 1;

                  sstr := '';
                  sstr := RightLine(IntToStr(j), 5)+' '
                        + RightLine(MainQueryAll.FieldByName('NUMBER').AsString
                        + '/'
                        + MainQueryAll.FieldByName('NUMBER_1').AsString, 13)
                        + ' '
//                        + LeftLine(NmntAllQuery.FieldByName('NAME').AsString, 25)
                        + LeftLine(MainQueryAll.FieldByName('NAME_1').AsString, 35)
                        + ' '
                        + LeftLine(MainQueryAll.FieldByName('CODE').AsString, 18)
                        + ' ';
//                        + LeftLine(MainQueryAll.FieldByName('NAME').AsString, 15)
//                        + ' '
                  Case MainQueryAll.FieldByName('WEIGHT_F').AsInteger of
                     0 : tmpstr:='П';
                     1 : tmpstr:='Г';
                     2 : tmpstr:='Н';
                   else tmpstr:='?';
                  end;
{                  sstr := sstr + CentrLine(IntToStr(MonthAllQuery.FieldByName('MIN').AsInteger-
                                    (MonthAllQuery.FieldByName('MIN').AsInteger div 12)*12+1)+tmpstr, 9)+' '
                               + CentrLine(EdizAllQuery.FieldByName('CODE').AsString, 10)+ ' ';}
                  sstr := sstr + CentrLine(IntToStr(MonthOf(MainQueryAll.FieldByName('Date_Out').AsDateTime))
                               +tmpstr, 9)+' '
                               + CentrLine(EdizAllQuery.FieldByName('CODE').AsString, 10)+ ' ';


                  //Время по плану и по факту сделанного за прошлые месяцы
                  If RadioButton1.Checked = True Then
                  begin
                     sstr := sstr
                           + RightLine(MainQueryAll.FieldByName('NUMBER_P').AsString, 7)
                           + ' '
                           + RightLine(MainQueryAll.FieldByName('NUMBER_F').AsString, 7)
                           + ' '
                           + RightLine(Order1AllQuery.FieldByName('TIME_P').AsString, 7)
                           + ' '
                           + RightLine(FormatFloat( '0.000', MainQueryAll.FieldByName('NUMBER_P').AsInteger
                             * Order1AllQuery.FieldByName('TIME_P').AsFloat), 7)
                           + ' '
                           + RightLine(Order2AllQuery.FieldByName('TIME_F').AsString, 7)
                           + ' '
                           + RightLine(FormatFloat( '0.000', MainQueryAll.FieldByName('NUMBER_F').AsInteger
                             * Order2AllQuery.FieldByName('TIME_F').AsFloat), 7)
                           + ' ';

                     pNorm:=pNorm+Order1AllQuery.FieldByName('TIME_P').AsFloat;
                     pOb:=pOb+MainQueryAll.FieldByName('NUMBER_P').AsInteger
                              * Order1AllQuery.FieldByName('TIME_P').AsFloat;
                     fNorm:=fNorm+Order2AllQuery.FieldByName('TIME_F').AsFloat;
                     fOb:=fOb+MainQueryAll.FieldByName('NUMBER_F').AsInteger
                              * Order2AllQuery.FieldByName('TIME_F').AsFloat;
                  end;

                  add( sstr);
                  add('');

                  PCstNorm:=PCstNorm+MainQueryAll.FieldByName('NUMBER_P').AsInteger
                              * Order1AllQuery.FieldByName('TIME_P').AsFloat;
                  FCstNorm:=FCstNorm+MainQueryAll.FieldByName('NUMBER_F').AsInteger
                              * Order2AllQuery.FieldByName('TIME_F').AsFloat;

                  PlanParentCstNorm := PlanParentCstNorm + MainQueryAll.FieldByName('NUMBER_P').AsInteger
                                       * Order1AllQuery.FieldByName('TIME_P').AsFloat;
                  FactParentCstNorm := FactParentCstNorm + MainQueryAll.FieldByName('NUMBER_F').AsInteger
                                       * Order2AllQuery.FieldByName('TIME_F').AsFloat;


                  MainQueryAll.Next;
                  i := i + 1;
               end;

//             Total_j := Total_j + j;

               If RadioButton1.Checked = True Then
               begin
                   add(RepeatLine('.', n));
                   add(RightLine('Итого по подразделению:    ', 120)+
                              RightLine(FormatFloat( '0.000', PCstNorm), 7)+'         '+
                              RightLine(FormatFloat( '0.000', FCstNorm), 7));
               end;
               add( '');
            end;

            If RadioButton1.Checked = True Then
            begin
                add(RepeatLine('=', n));
                add(RightLine('Итого по производству:     ', 120)+
                          RightLine(FormatFloat( '0.000', PlanParentCstNorm), 7)+'         '+
                          RightLine(FormatFloat( '0.000', FactParentCstNorm), 7));
            end;
            add( '');


         end;
         add( RepeatLine('*', n));
         If RadioButton1.Checked = True Then
             add( RepeatLine(' ', 102)+'Итого:    '+
                  RightLine(FormatFloat( '0.000', pNorm), 7)+' '+
                  RightLine(FormatFloat( '0.000', pOb), 7)+' '+
                  RightLine(FormatFloat( '0.000', fNorm), 7)+' '+
                  RightLine(FormatFloat( '0.000', fOb), 7));

         add( '');
         add( '');
         add(' Количество позиций: ' + IntToStr(j));
         add( '');
         add( '');
         add( RepeatLine(' ', 12)+'Начальник РМП');
         add( '');
         add( RepeatLine(' ', 12)+'Начальник цеха(участка)');


   end;


  PrForm.Destroy;


  Form.Caption := 'План работ. Форма для ' + PDRCombo.text;
  Form.Editor.show;
  Form.show;

end;

{

       Форма для механосборочного цеха

}


procedure TReport10Form.ButtonCCR_2Click(Sender: TObject);
Var

sstr   : String;
CstStr : Integer;
  i    : Integer;
  n    : Integer;  //Ширина отчёта
 Month : Double;
 pNorm, pOb, fNorm, fob : Real;  //Итого по плановой и фактической норме времени

   Form : TShowPrintForm;
 PrForm : TProcessForm;



begin

     Form     := TShowPrintForm.create(application);
     PrForm   := TProcessForm.create(application);


       If MonthComboBox.ItemIndex = -1 Then
       begin
          MessageDlg('Период не определен!', mtWarning , [mbYes], 0);
          Exit;
       end;

       If (PdrCombo.Text = '<Object not found>') or not (qPDRQuery.Active) Then
       begin
          MessageDlg('Подразделение не определено!', mtWarning , [mbYes], 0);
          Exit;
       end;

     n := 156;
       
     // формирование строк
     with Form.Editor.lines do
      begin

         clear;

         // вывод шапки отчета
         add( RepeatLine('-', n));
         add( '');
         add( RepeatLine(Chr(32),82)+'П Л А Н'+RepeatLine(Chr(32),31)+'УТВЕРЖДАЮ:');
         add( '');
         add( RepeatLine(' ', 117)+'ГЛАВНЫЙ МЕХАНИК');
         add( RepeatLine(' ', 10)+'НАЧАЛЬНИК ЦЕХА'+RepeatLine(' ', 47)+'РАБОТ НА '+
         MonthComboBox.Text+' месяц'+RepeatLine(' ', 17)
             +GetSystemParams('Enterprise'));
         add( '');
         add( RepeatLine(' ', 10)+'МЕХАНОСБОРОЧНОГО УЧАСТКА РМП ________________'
              + RepeatLine(' ', 18)
              + 'ДЛЯ ЦЕХА МЕХАНОСБОРКИ РМП '
              + RepeatLine(' ', 20)
              + GetSystemParams('Mechanic'));
         add( '');
         add( '');

         add( '');
         add( RepeatLine('-', n));
         add( '   №заявки   |       Наименование работ        |      Чертеж      | Причина отказа  |  Дата  |Кол-во |     План      |     Факт      |     Примечания     ');
         add( '      /      |                                 |                  |                 |        |       |---------------|---------------|                    ');
         add( '   №заказа   |                                 |                  |                 |        |       | норм. | общее | норм. | общее |                    ');
         add( '             |                                 |                  |                 |        |       |       |       |       |       |                    ');
         add( '             |                                 |                  |                 |        |       |       |       |       |       |                    ');
         add( '             |                                 |                  |                 |        |       |       |       |       |       |                    ');
         add( RepeatLine('-', n));



         //Открываю запрос основной информации по заказам:
         // 1) наименование и код заказчика 2)наименование номенклатуры
         // 3) код чертежа 4) дата завершения заказа
         // 5) наименование вида заготовки 6) сумма времени изготовления номенклатуры
         // 7) цена изготовления номенклатуры

         //Выщитываю количество месяцев прошедших с 01.01.2000
         Month:=MonthComboBox.ItemIndex;

         MainQueryMS.Close;
         MainQueryMS.ParamByName('month').AsInteger := Trunc(Month);
         MainQueryMS.ParamByName('pdr').AsInteger := qPDRQuery.Fields[0].asinteger;
         MainQueryMS.Open;

         i := 0;

         //Обнуляем суммы по итогу
         pNorm:=0;
         pOb:=0;
         fNorm:=0;
         fOb:=0;

         PrForm.Show;
         //цикл по количеству заказов
         While i< MainQueryMS.RecordCount do

          begin

            CstStr := MainQueryMS.FieldByName('id_1').Asinteger;
            add( 'Заказчик: '+MainQueryMS.FieldByName('NAME').AsString);

            //цикл по все заказам одного заказчика sstr
            While (MainQueryMS.FieldByName('id_1').Asinteger = CstStr) and
                  (not MainQueryMS.Eof)do
            begin

               PrForm.ProgressBar.Position:=(i+1)*100 div MainQueryMS.RecordCount;
               NmntQueryMS.Close;
               NmntQueryMS.ParamByName('id').AsInteger:=MainQueryMS.FieldByName('id').AsInteger;
               NmntQueryMS.Open;
               Order1QueryMS.Close;
               Order1QueryMS.ParamByName('id').AsInteger:=MainQueryMS.FieldByName('id').AsInteger;
               Order1QueryMS.Open;

               sstr := '';
               sstr := RightLine(MainQueryMS.FieldByName('NUMBER').AsString
                     + '/'
                     + MainQueryMS.FieldByName('NUMBER_1').AsString, 13)
                     + ' '
//                     + LeftLine(NmntQueryMS.FieldByName('NAME').AsString, 23)
                     + LeftLine(MainQueryMS.FieldByName('NAME_1').AsString, 33)
                     + ' '
                     + LeftLine(MainQueryMS.FieldByName('CODE').AsString, 18)
                     + ' ';
//                     + LeftLine(MainQueryMS.FieldByName('NAME').AsString, 10)
//                     + ' ';


               FailQueryMS.Close;
               FailQueryMS.ParamByName('id').AsInteger  := MainQueryMS.FieldByName('ID').AsInteger;
               FailQueryMS.ParamByName('date').AsInteger := Trunc(Month);
               FailQueryMS.Open;

               //считаю , что первая "причина отказа" является основной
               sstr := sstr
                     + LeftLine(FailQueryMS.FieldByName('NAME').AsString,17)
                     + ' '
                     + CentrLine(MainQueryMS.FieldByName('DATE_IN').AsString,8)
                     + ' '
                     + RightLine(MainQueryMS.FieldByName('NUMBER_P').AsString,7)
                     + ' ';

               //Время по плану и по факту сделанного за прошлые месяцы
               If RadioButton1.Checked = True Then
               begin
                  sstr := sstr
                        + RightLine(Order1QueryMS.FieldByName('SumPTime').AsString,7)
                        + ' '
                        + RightLine(FormatFloat( '0.000', MainQueryMS.FieldByName('NUMBER_P').AsInteger
                           * Order1QueryMS.FieldByName('SumPTime').AsFloat), 7)
                        + ' ';

                  TimeOperQueryMS.Close;
                  TimeOperQueryMS.ParamByName('id').AsInteger  := MainQueryMS.FieldByName('ID').AsInteger;
                  TimeOperQueryMS.Open;

                  sstr := sstr
                        + RightLine(TimeOperQueryMS.FieldByName('AllTime').AsString,7)
                        +' '
                        + RightLine(FormatFloat( '0.000', MainQueryMS.FieldByName('NUMBER_F').AsInteger
                          * TimeOperQueryMS.FieldByName('AllTime').AsFloat), 7)
                        + ' ';

                  pNorm:=pNorm+Order1QueryMS.FieldByName('SumPTime').AsFloat;
                  pOb:=pOb+MainQueryMS.FieldByName('NUMBER_P').AsInteger
                           * Order1QueryMS.FieldByName('SumPTime').AsFloat;
                  fNorm:=fNorm+TimeOperQueryMS.FieldByName('AllTime').AsFloat;
                  fOb:=fOb+MainQueryMS.FieldByName('NUMBER_F').AsInteger
                          * TimeOperQueryMS.FieldByName('AllTime').AsFloat;

               end;
               add( sstr);

               MainQueryMS.Next;

               i := i + 1;


            end;
            add( '');

         end;
         add( RepeatLine('-', n));
         If RadioButton1.Checked = True Then
             add( RepeatLine(' ', 92)+'Итого:    '+
                  RightLine(FormatFloat( '0.00', pNorm), 7)+' '+
                  RightLine(FormatFloat( '0.00', pOb), 7)+' '+
                  RightLine(FormatFloat( '0.00', fNorm), 7)+' '+
                  RightLine(FormatFloat( '0.00', fOb), 7));


         add( '');
         add( '');

     end;

  PrForm.Destroy;


  Form.Caption := 'План работ. Форма для механосборочного цеха';
  Form.Editor.show;
  Form.show;

end;


{

    Обработка выбора значения

}


procedure TReport10Form.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPDRQuery, PDRCombo, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);



end;

procedure TReport10Form.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPDRQuery, PDRCombo, key, Shift, 1) = false then
    PDRComboButtonClick(Sender);


end;



procedure TReport10Form.DateEditChange(Sender: TObject);
begin
end;

{
     Заполнение списка периодов

}
Procedure TReport10Form.FillPeriod;
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


procedure TReport10Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
