{***************************************************************
 *
 * Unit Name: Rep13
 * Purpose  : Отчет формирования сверки по заказам
 * Author   : Соколов Владислав
 * History  : 2004
 *
 ****************************************************************}



unit Rep13;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ToolEdit, Mask, EnumForm4Sel;

  
type
  TReport13Form = class(TForm)
    Label1: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    PDRComboBeg: TComboEdit;
    Label4: TLabel;
    qPDRQueryBeg: TQuery;
    Label5: TLabel;
    PDRComboEnd: TComboEdit;
    qPDRQueryEnd: TQuery;
    OKButton: TButton;
    CloseButton: TButton;
    MainQuery: TQuery;
    qSELQuery: TQuery;
    ButtonSelPer: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PDRComboBegButtonClick(Sender: TObject);
    procedure PDRComboBegKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PDRComboEndKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PDRComboEndButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public

     LISTForm : TLIST_4SELECTForm;

  end;

var
  Report13Form: TReport13Form;

implementation

uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;


{$R *.DFM}

procedure TReport13Form.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{


}
procedure TReport13Form.OKButtonClick(Sender: TObject);
var
sstr    : String;
PdrStr  : Integer;
SumKol  : Real;
SumPr   : Real;
i       : Integer;
   Form : TShowPrintForm;
 PrForm : TProcessForm;



begin

     Form     := TShowPrintForm.create(application);
     PrForm   := TProcessForm.create(application);


        If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
        begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
        end;
        If not (qPDRQueryEnd.active) or not (qPDRQueryEnd.active) Then
        begin
          MessageDlg('Подразделения не определены!', mtWarning , [mbYes], 0);
          Exit;
        end;

         SumKol := 0;
         SumPr  := 0;

         MainQuery.Close;



     // формирование строк
     with Form.Editor.lines do
      begin

         clear;

         // Открыть запрос
         qSELQuery.open;

         // позиционирование на начальное PDR
         qSELQuery.Locate('id', qPDRQueryBeg.Fields[0].asinteger, [loCaseInsensitive]) ;


         PdrStr := qSELQuery.Fields[0].AsInteger;

         // вывод шапки отчета
         add( RepeatLine('-', 70));
         add( '');
         add( '');
         add( 'По данным отчета с сервера');
         add( RepeatLine('-', 36));
         add( 'Данные с МВЗ '+ PdrComboBeg.Text + ' по МВЗ '+ PdrComboEnd.Text);
         add( RepeatLine('-', 36));
         add( 'Данные с '+BegDateEdit.Text+' по '+ EndDateEdit.Text);
         add( RepeatLine('-', 36));
         add( '');
         add( '');
         add( RepeatLine('-', 70));
         add( '     Код    |         Наименование         | Количество |    Сумма   |');
         add( 'производства|                              |            |            |');
         add( '            |                              |            |            |');
         add( RepeatLine('-', 70));

         i := 0;
         PrForm.Show;
         //цикл по количеству подразделений
          //Заполняю EndPdrComboBox , которая ограничивает последующию выбрку с низу
         While (not qSELQuery.Eof) and
               (qSELQuery.Fields[0].AsInteger <> qPdrQueryEnd.Fields[0].asinteger) do
         begin

            PrForm.ProgressBar.Position:=(i+1)*100 div qSELQuery.RecordCount;
            sstr:='';

            MainQuery.Close;
            MainQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
            MainQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
            MainQuery.ParamByName('pdr').AsInteger     := PdrStr;
            MainQuery.Open;


            If not MainQuery.Eof Then
            begin
               sstr := RightLine(MainQuery.FieldByName('CODE').AsString, 12)
                     + ' '
                     + LeftLine(MainQuery.FieldByName('NAME').AsString, 30)
                     + ' '
                     + RightLine(MainQuery.FieldByName('Number').AsString, 12)
                     + ' '
                     + RightLine(FormatFloat( '0.00',MainQuery.FieldByName('Price').AsFloat), 12);

               SumKol := SumKol
                     + MainQuery.FieldByName('Number').AsFloat;

               SumPr := SumPr + MainQuery.FieldByName('Price').AsFloat;

               add( sstr);
               add( '');

            end;

            qSELQuery.Next;
            i := i + 1;

            PdrStr := qSELQuery.Fields[0].AsInteger;

         end;

         add(RepeatLine('-', 70));
         add(RepeatLine(' ', 13)+'ИТОГО'+RepeatLine(' ', 26)+
                    RightLine(FormatFloat( '0.00',SumKol), 12)+' '+
                    RightLine(FormatFloat( '0.00',SumPr), 12));


   end;


  PrForm.Destroy;


  Form.Caption := 'Форма сверки.';
  Form.Editor.show;
  Form.show;


end;

procedure TReport13Form.FormCreate(Sender: TObject);
begin

  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);



end;

procedure TReport13Form.PDRComboBegButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPDRQueryBeg, PDRComboBeg, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);




end;

procedure TReport13Form.PDRComboBegKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPDRQueryBeg, PDRComboBeg, key, Shift, 1) = false then
    PDRComboBegButtonClick(Sender);


end;

procedure TReport13Form.PDRComboEndKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPDRQueryEnd, PDRComboEnd, key, Shift, 1) = false then
    PDRComboEndButtonClick(Sender);


end;

procedure TReport13Form.PDRComboEndButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPDRQueryEnd, PDRComboEnd, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);


end;

procedure TReport13Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport13Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);


end;

end.
