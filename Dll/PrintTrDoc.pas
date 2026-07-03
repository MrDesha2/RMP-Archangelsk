{***************************************************************
 *
 * Unit Name: PrintTrDoc
 * Purpose  :
 *        Модуль формирования печатной формы
 *        документа "Требование-накладная"
 * Author   : Косицын Дмитрий, Соколов Владислав
 * History  : 2004
 *
 ****************************************************************}

{



}
unit PrintTrDoc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Mask, Printers;

type
  TPrintTrDocForm = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    qMainQuery: TQuery;
    qTableQuery: TQuery;
    qMTRQuery: TQuery;
    IDEdit: TMaskEdit;
    EdizQuery: TQuery;
    procedure CreateReport(iddoc: integer);
  end;

var
  PrintTrDocForm: TPrintTrDocForm;

implementation
uses PrintFrm, printlibs;


{$R *.DFM}

procedure TPrintTrDocForm.CreateReport(iddoc : integer);
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

   if (iddoc = 0) then
     iddoc := strtoint(IDEdit.Text);

   // основной запрос
   with qMainquery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
       if eof then
         showmessage('Не полностью заполнены реквизиты документа!')
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
      Form.Editor.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pattern\TrbPttrn.txt');
    except
      MessageDlg('Не могу открыть файл шаблона!', mtWarning, [mbOK], 0);

    end;


    // формирование строк
    with Form.Editor do
      begin
        replacePattern(Form.Editor, 'DateDoc',  qMainQuery.FieldByName('date_in').asstring, 0);
        replacePattern(Form.Editor, 'NumDoc' ,  qMainQuery.FieldByName('NumDoc').asstring, 0);
        replacePattern(Form.Editor, 'WRHSName', qMainQuery.FieldByName('Name_2').asstring, 0);
        replacePattern(Form.Editor, 'CSTName',  qMainQuery.FieldByName('Name').asstring, 0);
//        replacePattern(Form.Editor, 'PDRCode',  qMainQuery.FieldByName('Code').asstring, 0);
//        replacePattern(Form.Editor, 'PDRName',  qMainQuery.FieldByName('Name_1').asstring, 0);
        replacePattern(Form.Editor, 'PLNT',     qMainQuery.FieldByName('Code_2').asstring, 0);
        If (qMainQuery.FieldByName('Code_3').asstring = '4') Then
        begin
            replacePattern(Form.Editor, 'WRHS',     '0004', 0);
            replacePattern(Form.Editor, 'Pdr', '                               ', 0);
        end
         else
         begin
              replacePattern(Form.Editor, 'WRHS',     qMainQuery.FieldByName('Code_3').asstring, 0);
              replacePattern(Form.Editor, 'Pdr', 'Структурное подразделение: РМП', 0);
         end;

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
             MTRTolal := 0.0;
             MTRSum   := 0.0;

             lines.insert(y,tablestr);
             y := y + 1;

             with EdizQuery do
             begin
                close;
                parambyname('id').asinteger := qTableQuery.FieldByName('Nmnt').AsInteger;
                open;
             end;

//             replacePattern(Form.Editor, 'CHRTCode',  qTableQuery.FieldByName('Code_1').asstring, 0);
             replacePattern(Form.Editor, 'NMNTName',  qTableQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'Ediz',   EdizQuery.FieldByName('Code').AsString, 1);
             replacePattern(Form.Editor, 'NMNTCode',  qTableQuery.FieldByName('Code').asstring, 1);
             replacePattern(Form.Editor, 'NUMNMNT',   FormatFloat( '0.00',  qTableQuery.FieldByName('Number').asfloat), 2);
             replacePattern(Form.Editor, 'NUM1'   ,   FormatFloat( '0.00',  qTableQuery.FieldByName('Number').asfloat), 2);
             replacePattern(Form.Editor, 'Price'  ,   FormatFloat( '0.00',  qTableQuery.FieldByName('Price').asfloat), 2);
             replacePattern(Form.Editor, 'Sum',       FormatFloat( '0.00',  qTableQuery.FieldByName('NSum').asfloat), 2);
             replacePattern(Form.Editor, 'NumOrder',  qTableQuery.FieldByName('NumOrder').asstring, 2);

             // таблица 1 материалов
             tableStr := PatternStr;
             lines.insert(y,tablestr);
             y := y + 1;

             tableStr := PatternMTR;  // шаблон табличной части

             lines.insert(y,tablestr);
             y := y + 1;

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

             TotalTot := TotalTot + qTableQuery.FieldByName('NSum').asfloat;

             qTableQuery.next;
          end;

          // подвал
          replacePattern(Form.Editor, 'TotalTot', FormatFloat( '0.00',  TotalTot), 2);
          replacePattern(Form.Editor, 'AllMTRTotal',   FormatFloat( '0.00', AllMTRTotal), 2);

      end;

  Form.Caption := 'Печать требования-накладной #' +  qMainQuery.FieldByName('NumDoc').asstring;

  Form.FontDialog.Font.Size := 7;
  Form.FontCombo.ItemIndex  := 1;
  Form.FontComboChange(Form);
  Printer.Orientation:= poPortrait;

  Form.Editor.show;
  Form.show;
end;




end.
