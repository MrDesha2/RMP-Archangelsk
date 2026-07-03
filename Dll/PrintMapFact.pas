{***************************************************************
 *
 * Unit Name: PrintMapFact
 * Purpose  :
 *      ћодуль формировани€ печатной формы
 *      фактической маршрутной карты по заказу
 * Author   :  осицын ƒмитрий, —околов ¬ладислав
 * History  : 2004
 *
 ****************************************************************}

unit PrintMapFact;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, rxStrUtils, Math;

type
  TPrintMapFactForm = class(TForm)
    qMainQuery: TQuery;
    ChrcQuery: TQuery;
    FactTableQuery: TQuery;
    FactMTRQuery: TQuery;
    Label1: TLabel;
    Button2: TButton;
    MtrfQuery: TQuery;
    qTransQuery: TQuery;
    procedure CreateReport(iddoc : integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  PrintMapFactForm: TPrintMapFactForm;

implementation
uses PrintFrm, PrintLibs;


{$R *.DFM}


{


}
procedure TPrintMapFactForm.CreateReport(iddoc : integer);
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
           showmessage('Ќе полностью заполнены реквизиты документа!');
           abort;
         end;

    end;

   // запрос по фактическм материалам
   with FactMTRQuery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
    end;

   //  запрос по фактическим затратам
   with FactTableQuery do
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
   with MtrfQuery do
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
      MessageDlg('Ќе могу открыть файл шаблона!' + ExtractFilePath(Application.ExeName) + 'Pattern\MapPttrn.txt', mtWarning, [mbOK], 0);

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

    SumTime := 0;
    sizestr:=Copy(sizestr,1,Length(sizestr)-3);

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

        While not MtrfQuery.Eof do
        begin
           lines.insert(Form.Editor.caretpos.y,tablestr);
           replacePattern(Form.Editor, 'Length', FormatFloat('0.000', MtrfQuery.FieldByName('lenght').AsFloat), 0);
           replacePattern(Form.Editor, 'Width', FormatFloat('0.000', MtrfQuery.FieldByName('Width').AsFloat), 0);
           replacePattern(Form.Editor, 'Height', FormatFloat('0.000', MtrfQuery.FieldByName('hight').AsFloat), 0);
           replacePattern(Form.Editor, 'Weight', FormatFloat('0.000', MtrfQuery.FieldByName('Weight').AsFloat), 0);
           replacePattern(Form.Editor, 'NameStrg', MtrfQuery.FieldByName('Name').AsString, 0);
           MtrfQuery.Next;
        end;

        // таблица 1
        tableStr := TablePattern(Form.Editor, '/tab_1');  // шаблон табличной части


        while not FactTableQuery.eof do
          begin
             lines.insert(Form.Editor.caretpos.y,tablestr);
             replacePattern(Form.Editor, 'Num',  FactTableQuery.FieldByName('lineno').asstring, 1);
             replacePattern(Form.Editor, 'OpName',  FactTableQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'Rating',  FactTableQuery.FieldByName('Rating').asstring, 2);
             replacePattern(Form.Editor, 'Time',    FormatFloat('0.000', FactTableQuery.FieldByName('NTIME').asfloat / 1000) , 2);
             replacePattern(Form.Editor, 'NumP',    FormatFloat('0.00', qMainQuery.FieldByName('Number_F').asfloat), 2);

             SumTime := SumTime + FactTableQuery.FieldByName('NTIME').asfloat / 1000;
             FactTableQuery.next;

          end;

       replacePattern(Form.Editor, 'STime', FormatFloat('0.00', SumTime), 2);

       // таблица 2 материалов
        tableStr := TablePattern(Form.Editor, '/tab_2');  // шаблон табличной части

       while not FactMTRQuery.eof do
          begin
             lines.insert(Form.Editor.caretpos.y,tablestr);
             replacePattern(Form.Editor, 'MTRName',  FactMTRQuery.FieldByName('Name').asstring, 0);
             replacePattern(Form.Editor, 'MTRNum',   FactMTRQuery.FieldByName('Number').asstring, 2);
             replacePattern(Form.Editor, 'MTRSum',   FormatFloat( '0.00', FactMTRQuery.FieldByName('Price').value), 2);

             FactMTRQuery.next;
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

  Form.Caption := 'ѕечать маршрутной карты #' +  qMainQuery.FieldByName('Number').asstring;
  Form.Editor.show;
  Form.onshow;
  Form.show;

end;

procedure TPrintMapFactForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
