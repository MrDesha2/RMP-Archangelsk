{***************************************************************
 *
 * Unit Name: PrintPrMTRDoc
 * Purpose  :  Модуль формирования печатной формы
 *        приходной накладной по материалам
 * Author   : Косицын Дмитрий, Соколов Владислав
 * History  : 2004
 *
 ****************************************************************}



unit PrintPrMTRDoc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls;

type
  TPrintPR_MTRDocForm = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    qMainQuery: TQuery;
    procedure Button2Click(Sender: TObject);
    procedure CreateReport(iddoc: integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  PrintPR_MTRDocForm: TPrintPR_MTRDocForm;

implementation

uses PrintFrm, printlibs;

{$R *.DFM}

procedure TPrintPR_MTRDocForm.CreateReport(iddoc : integer);
var Form :  TShowPrintForm;
    TotalNum, TotalSum : real;
    tablestr: string;
    PatternNMNT : string;
    y : integer;

begin

   Form     := TShowPrintForm.create(Application);
   TotalSum := 0;
   TotalNum := 0;
 
   // основной запрос
   with qMainquery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
       if eof then
         begin
           showmessage('Не полностью заполнены реквизиты документа!');
           abort;
         end;
           
    end;

    // загрузка шаблона из файла
    try
      Form.Editor.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pattern\PrMTRNptrn.txt');
    except
      MessageDlg('Не могу открыть файл шаблона!', mtWarning, [mbOK], 0);

    end;

    Form.Editor.Visible := false;
    // формирование строк
    with Form.Editor do
      begin



        qMainQuery.First;
        replacePattern(Form.Editor, 'DateDoc',  qMainQuery.FieldByName('date_in').asstring, 0);
        replacePattern(Form.Editor, 'NumDoc' ,  qMainQuery.FieldByName('NumDoc').asstring, 0);
        replacePattern(Form.Editor, 'CSTName',  qMainQuery.FieldByName('cst_name').asstring, 0);
        replacePattern(Form.Editor, 'WRHSName', qMainQuery.FieldByName('wrhs_name').asstring, 0);


        // таблица 2
        patternNMNT :=  TablePattern(Form.Editor, '/tab_1');
        y := Form.Editor.caretpos.y;

        qMainQuery.First;
        while not qMainQuery.eof do
          begin

             // таблица 1
             tableStr := patternNMNT;  // шаблон табличной части

             lines.insert(y,tablestr);
             y := y + 1;

             replacePattern(Form.Editor, 'Num',       qMainQuery.FieldByName('Lineno').asstring, 1);
             replacePattern(Form.Editor, 'NMNTName',  qMainQuery.FieldByName('NMNT_Name').asstring, 0);
             replacePattern(Form.Editor, 'NMNTCode',  qMainQuery.FieldByName('NMNT_Code').asstring, 2);
             replacePattern(Form.Editor, 'Ed',        qMainQuery.FieldByName('ediz_name').asstring, 1);
             replacePattern(Form.Editor, 'NMNTNum',   FormatFloat( '0.000', qMainQuery.FieldByName('Number').asfloat), 2);
             replacePattern(Form.Editor, 'NMNTPrice', FormatFloat( '0.00',  qMainQuery.FieldByName('Price').asfloat), 2);
             replacePattern(Form.Editor, 'Sum',       FormatFloat( '0.00',  qMainQuery.FieldByName('NSum').asfloat), 2);

             TotalNum := TotalNum + qMainQuery.FieldByName('Number').asfloat;
             TotalSum := TotalSum + qMainQuery.FieldByName('NSum').asfloat;

             qMainQuery.next;
          end;

          // подвал
          replacePattern(Form.Editor, 'TotalNum', FormatFloat( '0.00',  TotalNum), 2);
          replacePattern(Form.Editor, 'TotalSum', FormatFloat( '0.00',  TotalSum), 2);


      end;

  Form.Caption := 'Печать приходной накданой #' +  qMainQuery.FieldByName('NumDoc').asstring;
  Form.Editor.show;
  Form.onshow;
  Form.show;

end;



procedure TPrintPR_MTRDocForm.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TPrintPR_MTRDocForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
