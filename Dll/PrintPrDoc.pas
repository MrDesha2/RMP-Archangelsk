{***************************************************************
 *
 * Unit Name: PrintPrDoc
 * Purpose  :  ћодуль формировани€ печатной формы
 *        приходной накладной
 * Author   :  осицын ƒмитрий, —околов ¬ладислав
 * History  : 2004
 *
 ****************************************************************}


unit PrintPrDoc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Printers;

type
  TPrintPRDocForm = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    qMainQuery: TQuery;
    qTableQuery: TQuery;
    qMTRQuery: TQuery;
    CexSebQuery: TQuery;
    EdizQuery: TQuery;
    procedure Button2Click(Sender: TObject);
    procedure CreateReport(iddoc: integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  PrintPRDocForm: TPrintPRDocForm;

implementation

uses PrintFrm, printlibs;

{$R *.DFM}

procedure TPrintPRDocForm.CreateReport(iddoc : integer);
var Form :  TShowPrintForm;
    TotalTot : real;
    MTRTolal, MTRSum   : real;
    AllMTRTotal : real;
    tablestr: string;
    PatternNMNT : string;
    PatternMTR  : string;
    PatternStr  : string;
    y : integer;
begin

   Form := TShowPrintForm.create(Application);
   TotalTot := 0;

   // основной запрос
   with qMainquery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
       if eof then
         showmessage('Ќе полностью заполнены реквизиты документа!')
    end;

   // запрос по материалам
   with qMTRQuery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
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
      Form.Editor.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pattern\PrNPttrn.txt');
    except
      MessageDlg('Ќе могу открыть файл шаблона!', mtWarning, [mbOK], 0);

    end;



    // формирование строк
    with Form.Editor do
      begin
        replacePattern(Form.Editor, 'DateDoc',  qMainQuery.FieldByName('date_in').asstring, 0);
        replacePattern(Form.Editor, 'NumDoc' ,  qMainQuery.FieldByName('NumDoc').asstring, 0);
        replacePattern(Form.Editor, 'DateDoc',  qMainQuery.FieldByName('date_in').asstring, 0);
        replacePattern(Form.Editor, 'PDRCode',  qMainQuery.FieldByName('Code_1').asstring, 0);
        replacePattern(Form.Editor, 'PLNT',     qMainQuery.FieldByName('Code_3').asstring, 0);
        if (qMainQuery.FieldByName('Code_2').asstring = '4') Then
           replacePattern(Form.Editor, 'WRHS',     '0004' , 0)
         else
            replacePattern(Form.Editor, 'WRHS',     qMainQuery.FieldByName('Code_2').asstring, 0);

{        if qMainQuery.FieldByName('VID_CHRT').asinteger = 1 then  // »зготовление
          replacePattern(Form.Editor, 'CSTCode',  qMainQuery.FieldByName('Code').asstring , 0)

        else
          replacePattern(Form.Editor, 'CSTCode',  qMainQuery.FieldByName('Code_2').asstring + ' ' + qMainQuery.FieldByName('Code_3').asstring , 0);
}

        replacePattern(Form.Editor, 'PDRName',  qMainQuery.FieldByName('Name_1').asstring, 0);
        replacePattern(Form.Editor, 'WRHSName', qMainQuery.FieldByName('Name_2').asstring, 0);
        replacePattern(Form.Editor, 'CountCode','101', 1);

        AllMTRTotal:=0;

        // таблица 2
        patternNMNT :=  TablePattern(Form.Editor, '/tab_1');
        PatternMTR  :=  TablePattern(Form.Editor, '/tab_3');
        PatternSTR  :=  TablePattern(Form.Editor, '/tab_4');
        y := Form.Editor.caretpos.y;

        while not qTableQuery.eof do
          begin

             // таблица 1
             tableStr := patternNMNT;  // шаблон табличной части

             lines.insert(y,tablestr);
             y := y + 1;

             //  запрос по затратам
             with CexSebQuery do
             begin
                close;
                parambyname('ord_id').asinteger := qTableQuery.FieldByName('ID').AsInteger;
                open;
             end;

             //  запрос по единицам измерени€
             with EdizQuery do
             begin
                close;
                parambyname('id').asinteger := qTableQuery.FieldByName('Nmnt').AsInteger;
                open;
             end;

             replacePattern(Form.Editor, 'Num',  qTableQuery.FieldByName('Lineno').asstring, 1);
             replacePattern(Form.Editor, 'NMNTName',  qTableQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'CHRTCode',  qTableQuery.FieldByName('Code_1').asstring, 2);
             replacePattern(Form.Editor, 'Ed',   EdizQuery.FieldByName('Code').AsString, 1); //'Ўт.'
             replacePattern(Form.Editor, 'NMNTCode',  qTableQuery.FieldByName('Code').asstring, 2);
             replacePattern(Form.Editor, 'NMNTNum',   FormatFloat( '0.000', qTableQuery.FieldByName('Number').asfloat), 2);
//             replacePattern(Form.Editor, 'NMNTPrice', FormatFloat( '0.00', qTableQuery.FieldByName('Price').asfloat), 2);
             replacePattern(Form.Editor, 'NMNTPrice', FormatFloat( '0.00', CexSebQuery.FieldByName('NValue').asfloat /
                                                                            qTableQuery.FieldByName('Number').asfloat), 2);
//             replacePattern(Form.Editor, 'Sum',       FormatFloat( '0.00', qTableQuery.FieldByName('NSum').asfloat), 2);
             replacePattern(Form.Editor, 'Sum',       FormatFloat( '0.00', CexSebQuery.FieldByName('NValue').asfloat), 2);
             replacePattern(Form.Editor, 'NumOrd',    qTableQuery.FieldByName('NumOrder').asstring, 2);

             // таблица 1 материалов
             tableStr := PatternStr;
             lines.insert(y,tablestr);
             y := y + 1;

             tableStr := PatternMTR;  // шаблон табличной части

             lines.insert(y,tablestr);
             y := y + 1;

             MTRTolal := 0.0;
             MTRSum   := 0.0;

             qMtrQuery.First;

             while not qMTRQuery.eof do
             begin
                if qMTRQuery.FieldByName('ID').AsInteger =
                                qTableQuery.FieldByName('ID').AsInteger Then
                begin
                     MTRSum:=MTRSum + qMTRQuery.FieldByName('Price').AsFloat;
                     MTRTolal:=MTRTolal + qMTRQuery.FieldByName('Price').AsFloat*
                                     qTableQuery.FieldByName('Number_F').AsFloat;
                end;
                qMTRQuery.next;
             end;

             AllMTRTotal:=AllMTRTotal+MTRTolal;

             replacePattern(Form.Editor, 'MTRSum',   FormatFloat( '0.00', MTRSum), 2);
             replacePattern(Form.Editor, 'MTRTotal',   FormatFloat( '0.00', MTRTolal), 2);

             TotalTot := TotalTot + CexSebQuery.FieldByName('NValue').asfloat; //qTableQuery.FieldByName('NSum').asfloat;

             qTableQuery.next;
          end;

          // подвал
          replacePattern(Form.Editor, 'TotalTot', FormatFloat( '0.00',  TotalTot), 2);
          replacePattern(Form.Editor, 'AllMTRTotal',   FormatFloat( '0.00', AllMTRTotal), 2);

      end;

  Form.Caption := 'ѕечать приходной накладной #' +  qMainQuery.FieldByName('NumDoc').asstring;
  Form.Editor.show;
  Form.onshow;
  Form.show;
end;



procedure TPrintPRDocForm.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TPrintPRDocForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
