unit Rep42;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EnumForm4Sel, DB, DBTables;

type
  TReport42Form = class(TForm)
    MainQuery: TQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure CreateReport(iddoc : integer);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report42Form: TReport42Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport42Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport42Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
end;


procedure TReport42Form.CreateReport(iddoc : integer);
var Form :  TShowPrintForm;
    PrForm : TProcessForm;
    i : Integer;
begin

    Form := TShowPrintForm.create(Application);
    PrForm  := TProcessForm.create(Application);

    MainQuery.Close;
    MainQuery.SQL.Clear;
//    MainQuery.SQL.Add('Select * From REPORT_41_PROCEDURE(:DATE_BEG, ');
//    MainQuery.SQL.Add(':DATE_END, :ID_EQPT, :ID_WRKR, :ID_PDR)');
//    MainQuery.SQL.Add('Order By DATE_IN, TYPE_DOC, NAME_EQPT, DOCNUM');

    MainQuery.SQL.Add('Select * From REPORT_42_PROCEDURE(:NUMDOC)');
    MainQuery.ParamByName('NUMDOC').AsInteger := iddoc;

    MainQuery.Open;
    MainQuery.First;
    PrForm.Show;

    with Form.Editor.Lines do
    begin

        clear;

        i:=1;

        add('');
        add(CentrLine('ТРЕБОВАНИЕ-НАКЛАДНАЯ №'+IntToStr(MainQuery.FieldByName('NUMDOC').AsInteger), 100));
        add(CentrLine('на инструмент',100));
        add('');
        add('');
        add(LeftLine('Организация: АО "Архангельский ЦБК" ', 100));
        add(LeftLine('Подразделение: '+MainQuery.FieldByName('NAME_PDR').AsString, 100));
        add('');
        add(RepeatLine('-', 113));
        add('         |           |        |        Отправитель       |        Получатель        |  Корреспонд. счет |Учетная|');
        add('  Шифр   |   Дата    |Код вида|-------------|------------|-------------|------------|-------------------|единица|');
        add('документа|составления|операции|Подразделение|    Вид     | Структурное |    Вид     |  Счет  |Код аналит|(работ,|');
        add('         |           |        |             |деятельности|подразделение|деятельности| С/счет |   учета  | услуг)|');
        add(RepeatLine('-', 113));
        add('         |           |        |             |            |             |            |        |          |       |');
        add('         |'+CentrLine(DateToStr(Date), 11)+'|        |             |            |             |            |        |          |       |');
        add('         |           |        |             |            |             |            |        |          |       |');
        add(RepeatLine('-', 113));
        add('');
        add('');
        add('Через кого: _______________________________');
        add('');
        add('');
        add('Затребовал: _______________________________    Разрешил: ______________________________');
        add('');
        add(RepeatLine('-', 113));
        add('|  Кор. счет  |                Материальные ценности               |  Шифр   |Ед. |   Количество    |Порядковый |');
        add('|-------------|----------------------------------------------------|  хоз.   |изм.|-----------------|   № по    |');
        add('|C/счет| Код  |              Наименование              |Инвентарный|  опер-  |    | Затре  |Отпущено| складской |');
        add('|      |аналит|                                        |   номер   |  ации   |    | бовано |        |   карте   |');
        add(RepeatLine('-', 113));
        While not MainQuery.Eof do
        begin

            PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;
            
            add('|      |      |'+LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString+' ('+
                MainQuery.FieldByName('NAME_MARK').AsString+')', 40) + '|'+
                RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 11)+'|         |'+
                CentrLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 4)+'|        |'+
                RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 8)+'|           |');

            i:=i+1;
            MainQuery.Next;

        end;

        add(RepeatLine('-', 113));
        add('');
        add('');
        add('');
        add('   Отпустил:              '+MainQuery.FieldByName('NAME_WRKR_WRHS').AsString+'    Получил: __________________________________');

    end;

    PrForm.Destroy;

    Form.Caption := 'Требование-накладная на инструмент';
    Form.Editor.show;
    Form.show;

end;

end.
