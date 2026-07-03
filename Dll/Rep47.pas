unit Rep47;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls;

type
  TReport47Form = class(TForm)
    qMainQuery: TQuery;
    procedure CreateRep47(id_wrkr : integer; date_beg : tdatetime; date_end : tdatetime);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Report47Form: TReport47Form;

implementation

uses PrintFrm, printlibs, PrintProces;

{$R *.dfm}

procedure TReport47Form.CreateRep47(id_wrkr : integer; date_beg : tdatetime; date_end : tdatetime);
var Form :  TShowPrintForm;
  PrForm : TProcessForm;
    i : Integer;
begin

   Form    := TShowPrintForm.create(Application);
   PrForm  := TProcessForm.create(Application);
   // основной запрос
   with qMainquery do
    begin
       close;
       parambyname('id_wrkr').asinteger := id_wrkr;
       parambyname('date_beg').AsDate := date_beg;
       parambyname('date_end').AsDate := date_end;
       open;
       if eof then
         begin
           showmessage('Данные не найдены!');
           abort;
         end;
    end;

     // формирование строк
    with Form.Editor.lines do
      begin
         clear;
         i := 0;

         // вывод шапки отчета
         add( RepeatLine('-', 86));
         add( '');
         add( CentrLine('Инструментальная карточка', 84));
         add( CentrLine('('+qMainQuery.FieldByName('code').AsString+') ' +
              qMainQuery.FieldByName('name').AsString , 84));
         add( '');
         add( 'с '+DateToStr(Date_Beg)+' по '+DateToStr(Date_End));
         add( RepeatLine('-', 86));
         add('|   Дата    |          Наименование инструменат          |Кол-во|     Примечание     |');
         add('| документа |                                            |      |                    |');
         add( RepeatLine('-', 86));

         While not qMainQuery.Eof do
         begin

            PrForm.ProgressBar.Position:=(i+1)*100 div qMainQuery.RecordCount;

            add( '|'+CentrLine(qMainQuery.FieldByName('date_in').AsString, 11)+'|'+
                 LeftLine(qMainQuery.FieldByName('Eqpt').AsString, 44)+'|'+
                 RightLine(qMainQuery.FieldByName('Number').AsString, 6)+'|'+
                 RepeatLine(' ', 20)+'|');

            i := i + 1;
            qMainQuery.Next;
         end;
         add( RepeatLine('-', 86));
         add( '');
         add( '');
         add( 'Количество позиций: '+IntToStr(i));
      end;
      PrForm.Destroy;


      Form.Caption := 'Карточка выданного инструмента';
      Form.Editor.Show;
      Form.show;
end;
end.

