{***************************************************************
 *
 * Unit Name: PrintMap
 * Purpose  :
 *      Модуль формирования печатной формы
 *      плановой маршрутной карты по заказу
 * Author   : Косицын Дмитрий, Соколов Владислав
 * History  : 2004
 *
 ****************************************************************}


unit PrintMap;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, rxStrUtils, Math;

type
  TPrintMapForm = class(TForm)
    Label1: TLabel;
    qMainQuery: TQuery;
    qTableQuery: TQuery;
    qMTRQuery: TQuery;
    Button2: TButton;
    ChrcQuery: TQuery;
    MtrpQuery: TQuery;
    qTransQuery: TQuery;
    procedure CreateReport(iddoc : integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  PrintMapForm: TPrintMapForm;

implementation
uses PrintFrm, PrintLibs;


{$R *.DFM}


{


}
procedure TPrintMapForm.CreateReport(iddoc : integer);
var Form :  TShowPrintForm;
    tablestr: string;
     sizestr: string;
     SumTime: Real;

begin

   Form := TShowPrintForm.create(Application);

   // основной запрос
   with qMainquery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
       if eof then
         begin
           MessageDlg('dsf ' + inttostr(iddoc), mtWarning, [mbOK], 0);
           showmessage('Не полностью заполнены реквизиты документа!');
           abort;
         end;

    end;

   // запрос по плановым материалам
   with qMTRQuery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
    end;

   //  запрос по плановым затратам
   with qTableQuery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
    end;

   //  запрос по размерам детали
   with ChrcQuery do
    begin
       close;
       parambyname('id').asinteger := iddoc;
       open;
    end;

   //  запрос по размерам заготовки
   with MtrpQuery do
    begin
       close;
       parambyname('id').asinteger := iddoc;
       open;
    end;

   //  запрос по плановому транспорту
   with qTransQuery do
    begin
       close;
       parambyname('id').asinteger := iddoc;
       open;
    end;

    // загрузка шаблона из файла
    try
      Form.Editor.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pattern\MapPttrn.txt');
    except
      MessageDlg('Не могу открыть файл шаблона!' + ExtractFilePath(Application.ExeName) + 'Pattern\MapPttrn.txt', mtWarning, [mbOK], 0);

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
    SumTime:=0;

    // формирование строк
    with Form.Editor do
      begin
        replacePattern(Form.Editor, 'Codemap',  qMainQuery.FieldByName('Number_1').asstring + '/'+
                                                qMainQuery.FieldByName('Number').asstring, 0);
        replacePattern(Form.Editor, 'PDRName' , qMainQuery.FieldByName('Name').asstring, 0);
        replacePattern(Form.Editor, 'CHRTName', ReplaceStr(qMainQuery.FieldByName('Name_1').asstring,'  ', ''), 0);
        replacePattern(Form.Editor, 'NMNTCode', qMainQuery.FieldByName('Code').asstring, 0);
        replacePattern(Form.Editor, 'NMNTName', qMainQuery.FieldByName('Name_2').asstring, 0);
        replacePattern(Form.Editor, 'CstName',  '  ' + ReplaceStr(qMainQuery.FieldByName('Name_3').asstring,' ',''), 0);
        replacePattern(Form.Editor, 'PR_URGEN', qMainQuery.FieldByName('PR_URGEN').asstring, 0);
        replacePattern(Form.Editor, 'Sizeble', sizestr, 0);
        replacePattern(Form.Editor, 'Month', MonthByString(qMainQuery.FieldByName('date_in').asdatetime), 0);

        tableStr := TablePattern(Form.Editor, '/tab_0');  // шаблон табличной части

        While not MtrpQuery.Eof do
        begin
           lines.insert(Form.Editor.caretpos.y,tablestr);
           replacePattern(Form.Editor, 'Length', FormatFloat('0.000', MtrpQuery.FieldByName('lenght').AsFloat), 0);
           replacePattern(Form.Editor, 'Width', FormatFloat('0.000', MtrpQuery.FieldByName('Width').AsFloat), 0);
           replacePattern(Form.Editor, 'Height', FormatFloat('0.000', MtrpQuery.FieldByName('hight').AsFloat), 0);
           replacePattern(Form.Editor, 'Weight', FormatFloat('0.000', MtrpQuery.FieldByName('Weight').AsFloat), 0);
           replacePattern(Form.Editor, 'NameStrg', MtrpQuery.FieldByName('Name').AsString, 0);
           MtrpQuery.Next;
        end;

        // таблица 1
        tableStr := TablePattern(Form.Editor, '/tab_1');  // шаблон табличной части


        while not qTableQuery.eof do
          begin
             lines.insert(Form.Editor.caretpos.y,tablestr);
             replacePattern(Form.Editor, 'Num',  qTableQuery.FieldByName('lineno').asstring, 1);
             replacePattern(Form.Editor, 'OpName',  qTableQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'Rating',  qTableQuery.FieldByName('Rating').asstring, 0);
             replacePattern(Form.Editor, 'Time',    FormatFloat('0.000', qTableQuery.FieldByName('NTIME').asfloat / 1000) , 2);
             replacePattern(Form.Editor, 'NumP',    FormatFloat('0.00', qMainQuery.FieldByName('Number_P').asfloat), 2);

             SumTime := SumTime + qTableQuery.FieldByName('NTIME').asfloat;

             qTableQuery.next;

          end;

       replacePattern(Form.Editor, 'STime',    FormatFloat('0.000', SumTime / 1000) , 2);

       // таблица 2 материалов
       tableStr := TablePattern(Form.Editor, '/tab_2');  // шаблон табличной части

       while not qMTRQuery.eof do
          begin
             lines.insert(Form.Editor.caretpos.y,tablestr);
             replacePattern(Form.Editor, 'MTRName',  qMTRQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'MTRNum',   qMTRQuery.FieldByName('Number').asstring, 2);
             replacePattern(Form.Editor, 'MTRSum',   FormatFloat( '0.00', qMTRQuery.FieldByName('Price').value), 2);

             qMTRQuery.next;
          end;

       // таблица 3 материалов
       tableStr := TablePattern(Form.Editor, '/tab_3');  // шаблон табличной части

       while not qTransQuery.eof do
          begin
             lines.insert(Form.Editor.caretpos.y,tablestr);
             replacePattern(Form.Editor, 'TransportName',  qTransQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'TransNum', qTransQuery.FieldByName('Number').asstring, 2);
             replacePattern(Form.Editor, 'TranSum',  FormatFloat( '0.00', Round(qTransQuery.FieldByName('Cost').value*
                                                                          qTransQuery.FieldByName('Number').Value*100)/100), 2);

             qTransQuery.next;
          end;

      end;

  Form.Caption := 'Печать маршрутной карты #' +  qMainQuery.FieldByName('Number').asstring;
  Form.Editor.show;
  Form.onshow;
  Form.show;

end;

procedure TPrintMapForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
