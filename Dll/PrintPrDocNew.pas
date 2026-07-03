unit PrintPrDocNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Math, Printers;

type
  TPrintPRDocFormNew = class(TForm)
    MainQuery: TQuery;
    procedure CreateReport(iddoc: integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrintPRDocFormNew: TPrintPRDocFormNew;

implementation

uses PrintFrm, printlibs, PrintProces, PrintAct;

procedure TPrintPRDocFormNew.CreateReport(iddoc : integer);
var Form :  TShowPrintForm;
    PrForm : TProcessForm;
    i : Integer;
    TotalSum: Real;
    CountChrt: integer;
    digitcount : integer;
    counter: integer;
    stringvalue : string;
    str_wrhs : string;
begin

   Form := TShowPrintForm.create(Application);
   PrForm  := TProcessForm.create(Application);

    MainQuery.Close;
    MainQuery.SQL.Clear;
    MainQuery.SQL.Add('Select * From REPORT_PR_DOC_PROCEDURE(:ID_DOC)');
    MainQuery.ParamByName('ID_DOC').AsInteger := iddoc;

    MainQuery.Open;
    MainQuery.First;
    PrForm.Show;

    with Form.Editor.Lines do
    begin

        clear;

        i:=1;
        CountChrt:=0;
        TotalSum := 0;

        add('');
        add(RightLine('Унифицированная форма № МХ-18', 193));
        add(RightLine('Утверждена постановлением Госкомстата', 193));
        add(RightLine('России от 09.08.99 № 66', 193));
        add(RightLine(RepeatLine('_', 11 ), 192));
        add(RightLine('           Форма по ОКУД |' + CentrLine(GetSystemParams('OKYD'),11) + '|', 193));
        add(RightLine('                         |-----------|', 193));
        // add(RightLine('                 по ОКПО | 00279195  |', 193));
        add(RightLine('                 по ОКПО |' + CentrLine(GetSystemParams('OKPO'),11) + '|', 193));
        add(RightLine('                         |-----------|', 193));
        add(RightLine('Вид деятельности по ОКДП |           |', 193));
        add(RightLine('                         |-----------|', 193));
        add(RightLine('            Вид операции |           |', 193));
        add(RightLine('                         |___________|', 193));
        add(CentrLine('АО "Архангельский ЦБК" РМП', 193));
        add('');
        add('');
        add(CentrLine('НАКЛАДНАЯ №' + MainQuery.FieldByName('NUM_DOC').AsString +
            ' от '+ MainQuery.FieldByName('DATE_DOC').AsString, 193));
        add(CentrLine('НА ПЕРЕДАЧУ ГОТОВОЙ ПРОДУКЦИИ В МЕСТА ХРАНЕНИЯ', 193));
        add('');
        add('');
        add(RepeatLine('-', 193));
        add('|                                     Отправитель                                      |                  Получатель                  |        Корреспондирующий счет         |     Шифр хоз,   |');
        add(RepeatLine('-', 174)+'|    операции     |');
        add('|                        структурное                        |     вид деятельности     |      структурное      |   вид деятельности   |    счет,субсчет    |код аналитического|                 |');
        add('|                       подразделение                       |         по ОКДП          |     подразделение     |       по ОКДП        |                    |      учета       |                 |');
        add(RepeatLine('-', 193));
        str_wrhs := MainQuery.FieldByName('CODE_WRHS').AsString;
        If (str_wrhs = '4') Then str_wrhs := '0004';
        add('|'+CentrLine(MainQuery.FieldByName('CODE_PDR').AsString + ' Участок', 59)+'|                          |'+
            CentrLine(MainQuery.FieldByName('CODE_PLANT').AsString+'/'+str_wrhs, 23)+'|'+
            '                      |     433.070000     |                  |       101       |');
        add('|'+CentrLine(MainQuery.FieldByName('NAME_PDR').AsString, 59)+'|                          |                       |'+
            '                      |                    |                  |                 |');
        add(RepeatLine('-', 193));
        add('');
        add(RepeatLine('-', 193));
        add('|             Продукция, товаро-материальные ценности             |            Характеристика           |   Единица   |  Вид  |                              Передано                           |');
        add(RepeatLine('-', 104) + '|  измерения  |упаков-|' + RepeatLine('-', 66));
        add('|                   наименование                   |Номенклатурный|       Номер       |   Заказ   |  |  |-------------|  ки   |     количество     |  масса  | количест- |   по учетным ценам   |');
        add('|                                                  |     номер    |      чертежа      |внутренний |  |  |наиме-|код по|       |--------------------| брутто  | во (масса |----------------------|');
        add('|                                                  |              |                   |           |  |  |нова- | ОКЕИ |       |в одном|  мест,  |  |         | нетто)    |цена за ед-|  сумма,  |');
        add('|                                                  |              |                   |           |  |  | ние  |      |       | месте |  штук   |  |         |           |цу,руб.коп.| руб.коп. |');
        add(RepeatLine('-', 193));
        add('|                        1                         |        2     |         3         |     4     |5 |6 |  7   |   8  |   9   |   10  |    11   |12|    13   |     14    |     15    |    16    |');
        add(RepeatLine('-', 193));

        While not MainQuery.Eof do
        begin

            PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

            add('|'+LeftLine(MainQuery.FieldByName('NAME_CHRT').AsString, 50)+' '+
                    RightLine(MainQuery.FieldByName('CODE_NMNT').AsString, 14)+' '+
                    RightLine(MainQuery.FieldByName('CODE_CHRT').AsString, 19)+' '+
                    RightLine(MainQuery.FieldByName('NUM_ORDER').AsString, 11)+' '+'   '+'   '+
                    CentrLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 6)+' '+RepeatLine(' ', 23)+
                    RightLine(FormatFloat('0.000', MainQuery.FieldByName('NUMBER').AsFloat), 9)+' '+repeatline(' ', 25)+
                    RightLine(MainQuery.FieldByName('PRICE_DOC').AsString, 11)+' '+
                    RightLine(MainQuery.FieldByName('SUM_DOC').AsString, 10)+'|');

            add('|  в т.ч. материалы'+RepeatLine(' ', 151)+
                 RightLine(FormatFloat('0.00',MainQuery.FieldByName('PRICE_NMNT_F').AsFloat), 11)+' '+
                 RightLine(FormatFloat('0.00',MainQuery.FieldByName('TOTAL_PRICE_NMNT_F').AsFloat), 10)+'|');

            add('|'+RepeatLine(' ', 191)+'|');
            TotalSum := TotalSum + MainQuery.FieldByName('SUM_DOC').AsFloat;
            CountChrt:=CountChrt+1;
            MainQuery.Next;

        end;

        add(RepeatLine('-', 193));
        add(RepeatLine(' ', 163)+'ИТОГО:             '+RightLine(FormatFloat('0.00', TotalSum), 10));

        stringvalue:=PrintActForm.float2words(CountChrt, 1);
        add('');
        add('');
        add(' Отпустил продукцию, товарно-материальные ценности '+RepeatLine('_', 30)+stringvalue+RepeatLine('_', 30)+' наименований');
        stringvalue:='';

        stringvalue:=PrintActForm.float2words(TotalSum, 0);
        add('');
        add('');
        add(' на сумму '+RepeatLine('_', 30)+' '+stringvalue+' '+RepeatLine('_', 30));
        add('');
        add('');
        add(' материально ответственное лицо '+RepeatLine('_', 30)+'  '+RepeatLine('_', 30)+'  '+RepeatLine('_', 30));
        add(RepeatLine(' ', 32)+CentrLine('(должность)', 30)+'  '+CentrLine('(подпись)', 30)+'  '+CentrLine('(расшифровка подписи)', 30));
        add('');
        add('');
        add(' Контролер '+RepeatLine('_', 30)+'  '+RepeatLine('_', 30));
        add(RepeatLine(' ', 11)+CentrLine('(подпись)', 30)+'  '+CentrLine('(расшифровка подписи)', 30));
        add('');
        add('');
        add(' Получил '+RepeatLine('_', 30)+'  '+RepeatLine('_', 30)+'  '+RepeatLine('_', 30));
        add(RepeatLine(' ', 9)+CentrLine('(должность)', 30)+'  '+CentrLine('(подпись)', 30)+'  '+CentrLine('(расшифровка подписи)', 30));
    end;

    PrForm.Destroy;

    Form.Caption := 'Печать приходной накладной #' +  MainQuery.FieldByName('Num_Doc').asstring;

    Form.FontDialog.Font.Size := 7;
    Form.FontCombo.ItemIndex  := 1;
    Form.FontComboChange(Form);
    Printer.Orientation:=poLandscape;

    Form.Editor.show;
    Form.show;

end;

{$R *.dfm}

end.
