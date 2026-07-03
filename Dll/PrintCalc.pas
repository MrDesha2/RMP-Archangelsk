{***************************************************************
 *
 * Unit Name: PrintCalc
 * Purpose  :
 *        ћодуль формировани€ печатной формы
 *        расчета себестоимости продукции по заказу
 * Author   :  осицын ƒмитрий, —околов ¬ладислав
 * History  : 2004
 *            сент€брь 2004
 ****************************************************************}

unit PrintCalc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, rxStrUtils;

type
  TPrintCalcForm = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    qMTRQuery: TQuery;
    qQueryCalc: TQuery;
    qMainQuery: TQuery;
    procedure CreateReport(iddoc: integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  PrintCalcForm: TPrintCalcForm;

implementation

uses PrintFrm, printlibs;


{$R *.DFM}

procedure TPrintCalcForm.CreateReport(iddoc : integer);
var Form :  TShowPrintForm;
    totals, price : real;
    num_f, sum   : real;
    tablestr: string;
begin


   Form := TShowPrintForm.create(Application);

   totals := 0;
//   totaln := 0;

   // основной запрос
   with qMainquery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;

       if eof then
         begin
           showmessage('Ќе полностью заполнены реквизиты документа!');
           abort;
         end;


    end;

   // запрос по материалам
   with qMTRQuery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
    end;

   //  запрос по затратам
   with qQueryCalc do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
    end;

    // загрузка шаблона из файла
    try
      Form.Editor.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pattern\CalcPttrn.txt');
    except
      MessageDlg('Ќе могу открыть файл шаблона!', mtWarning, [mbOK], 0);

    end;


    // формирование строк
    with Form.Editor do
      begin
        replacePattern(Form.Editor, 'Manager',  GetSystemParams('Manager'), 1);   
        replacePattern(Form.Editor, 'DataDoc',   DateToStr(Date){qMainQuery.FieldByName('date_out').asstring}, 0);
        replacePattern(Form.Editor, 'NumDoc' ,   qMainQuery.FieldByName('Number').asstring, 0);
        replacePattern(Form.Editor, 'Customer',  qMainQuery.FieldByName('Name').asstring, 0);
        replacePattern(Form.Editor, 'Design'  ,  ReplaceStr(qMainQuery.FieldByName('Name_2').asstring,'  ', ''), 0);
        replacePattern(Form.Editor, 'Nomenclature',  qMainQuery.FieldByName('Name_1').asstring, 0);

       // таблица 1 материалов
        tableStr := TablePattern(Form.Editor, '/tab_1');  // шаблон табличной части

        while not qMTRQuery.eof do
          begin
             lines.insert(Form.Editor.caretpos.y,tablestr);
             replacePattern(Form.Editor, 'Material',  qMTRQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'PriceMat',  FormatFloat( '0.00', qMTRQuery.FieldByName('Price').asfloat), 2);

             qMTRQuery.next;
          end;

        // таблица 2 "затраты"
        tableStr := TablePattern(Form.Editor, '/tab_2');  // шаблон табличной части

        while not qQueryCalc.eof do
          begin
             lines.insert(Form.Editor.caretpos.y,tablestr);
             replacePattern(Form.Editor, 'Num',  qQueryCalc.FieldByName('Lineno').asstring, 1);
             replacePattern(Form.Editor, 'Calculation',  qQueryCalc.FieldByName('Name').asstring, 0);

             num_f := qQueryCalc.FieldByName('number_f').asfloat;
             sum   := qQueryCalc.FieldByName('NVALUE').asfloat;
//             totaln  := num_f;
             totals  := totals + sum;

             if qQueryCalc.FieldByName('number_f').asfloat <> 0 then
               price := sum /  num_f
             else
               price := 0;

             replacePattern(Form.Editor, 'PriceCalc',  FormatFloat( '0.00', price), 2);
             replacePattern(Form.Editor, 'NumD', FormatFloat( '0.000', num_f), 2);
             replacePattern(Form.Editor, 'Cost', FormatFloat( '0.00', sum), 2);

             qQueryCalc.next;
          end;

          // подвал
     //     replacePattern(Form.Editor, 'TotD', FormatFloat( '0.000', totaln), 2);
     //     replacePattern(Form.Editor, 'TotCost', FormatFloat( '0.00', totals), 2);

          replacePattern(Form.Editor, 'Economist',  GetSystemParams('Economist'), 0)


      end;

  Form.Caption := 'ѕечать расчета себестоимости по заказу #' +  qMainQuery.FieldByName('Number').asstring;
  Form.Editor.show;
  Form.onshow;
  Form.show;

end;



procedure TPrintCalcForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;

end;

end.
