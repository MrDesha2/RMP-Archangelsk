{***************************************************************
 *
 * Unit Name: PrintPrDoc
 * Purpose  :  Модуль формирования печатной формы
 *        заказа на материалы
 * Author   : Косицын Дмитрий, Соколов Владислав
 * History  : 2004
 *
 ****************************************************************}


unit PrintMtrOrderDoc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls;

type
  TPrintMTROrderDocForm = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    qMainQuery: TQuery;
    qTableQuery: TQuery;
    EditId: TEdit;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure CreateReport(iddoc: integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  PrintMTROrderDocForm: TPrintMTROrderDocForm;

implementation

uses PrintFrm, printlibs;

{$R *.DFM}

procedure TPrintMTROrderDocForm.CreateReport(iddoc : integer);
var Form :  TShowPrintForm;
    TotalNum : real;
    tablestr: string;
    PatternNMNT : string;
    y : integer;

begin

   Form := TShowPrintForm.create(Application);
   TotalNum := 0;

   if iddoc = 0 then
     iddoc := strtoint(editid.text);

   // основной запрос
   with qMainquery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
       if eof then
         showmessage('Не полностью заполнены реквизиты документа!')
    end;

   //  запрос по затратам
   with qTableQuery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
    end;

    // загрузка шаблона из файла
    try
      Form.Editor.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pattern\MtrOrderPttrn.txt');
    except
      MessageDlg('Не могу открыть файл шаблона!', mtWarning, [mbOK], 0);

    end;



    // формирование строк
    with Form.Editor do
      begin
        replacePattern(Form.Editor, 'DateDoc',  qMainQuery.FieldByName('datedoc').asstring, 0);
        replacePattern(Form.Editor, 'NumDoc' ,  qMainQuery.FieldByName('NumDoc').asstring, 0);
        replacePattern(Form.Editor, 'Enterprise', GetSystemParams('Enterprise'), 0);
        replacePattern(Form.Editor, 'CSTName',  qMainQuery.FieldByName('CST_Name').asstring, 0);
        replacePattern(Form.Editor, 'PDRName',     qMainQuery.FieldByName('PDR_Name').asstring, 0);


        // таблица 2
        patternNMNT :=  TablePattern(Form.Editor, '/tab_1');
        y := Form.Editor.caretpos.y;

        while not qTableQuery.eof do
          begin

             // таблица 1
             tableStr := patternNMNT;  // шаблон табличной части

             lines.insert(y,tablestr);
             y := y + 1;


             replacePattern(Form.Editor, 'Num',       qTableQuery.FieldByName('Lineno').asstring, 1);
             replacePattern(Form.Editor, 'NMNTCode',  qTableQuery.FieldByName('Code').asstring, 0);
             replacePattern(Form.Editor, 'NMNTName',  qTableQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'NMNTNum',   FormatFloat( '0.000', qTableQuery.FieldByName('Number').asfloat), 2);
//             replacePattern(Form.Editor, 'Sum',       FormatFloat( '0.00', CexSebQuery.FieldByName('NValue').asfloat), 2);
             replacePattern(Form.Editor, 'EDCode',    qTableQuery.FieldByName('Name_ediz').asstring, 2);
             replacePattern(Form.Editor, 'Remains',    ' ', 2);

             TotalNum := TotalNum + qTableQuery.FieldByName('Number').value;

             qTableQuery.next;

          end;

          // подвал
          replacePattern(Form.Editor, 'TotalNum', FormatFloat( '0.00',  TotalNum), 2);

      end;

  Form.Caption := 'Печать заказа на материалы #' +  qMainQuery.FieldByName('NumDoc').asstring;
  Form.Editor.show;
  Form.onshow;
  Form.show;

end;



procedure TPrintMTROrderDocForm.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TPrintMTROrderDocForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
