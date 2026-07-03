unit Rep57;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EnumForm4Sel, StdCtrls, DB, DBTables, Mask, ToolEdit, DateUtils,
  RXSpin;

type
  TReport57Form = class(TForm)
    Label5: TLabel;
    PdrCombo: TComboEdit;
    PdrQuery: TQuery;
    MainQuery: TQuery;
    Label2: TLabel;
    ButtonOK: TButton;
    ButtonNO: TButton;
    Label4: TLabel;
    CstCombo: TComboEdit;
    CstQuery: TQuery;
    Label1: TLabel;
    BegDateEdit: TDateEdit;
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonNOClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report57Form: TReport57Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport57Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport57Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport57Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  If (MonthOf(Date) = 1) Then
           BegDateEdit.Text := DateToStr(EncodeDate(YearOf(Date)-1, 12, DayOf(Date)))
        else
             BegDateEdit.Text := DateToStr(EncodeDate(YearOf(Date), MonthOf(Date)-1, DayOf(Date)));
end;

procedure TReport57Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport57Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport57Form.ButtonOKClick(Sender: TObject);
Var    Form         : TShowPrintForm;
       PrForm       : TProcessForm;
       Total_sum    : Real;
       n, i : Integer;
       sstr : String;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select * From REPORT_57_PROCEDURE(:ID_PDR, :ID_CST, :DATE_TODAY)');
       MainQuery.SQL.Add('Order by NAME_CST, CODE_PDR, NUMBER_RQST, NUMBER_ORDER');

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('ID_PDR').AsInteger := -1
        else
               MainQuery.ParamByName('ID_PDR').AsInteger := PdrQuery.Fields[0].AsInteger;

       If (CstCombo.Text = '') or (CstCombo.Text = '<Объект не найден>') or (not CstQuery.active) Then
            MainQuery.ParamByName('ID_CST').AsInteger := -1
        else
               MainQuery.ParamByName('ID_CST').AsInteger := CstQuery.Fields[0].AsInteger;

       MainQuery.ParamByName('DATE_TODAY').AsDate := StrToDate(BegDateEdit.Text);

       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

       If MainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       // формирование строк
       with Form.Editor.lines do
       begin

         clear;

             n := 139;
             i := 1;
             sstr := '';
             Total_sum := 0;

             add(RepeatLine('-', n));
             add('');
             add(CentrLine('Отчёт по движению заказов в производстве', n));

             add('');

             add(LeftLine('Следующие заказы находятся без двидения с '+BegDateEdit.Text + ':', n));
             add(RepeatLine('-', n));
             add('|  №  | №Заявки/№Заказа |           Заказчик           | Ответственный исполнитель |           Наименование работ           |Себестоимость|');
             add('| п.п.|                 |                              |                           |                                        |    (руб)    |');
             add(RepeatLine('-', n));

             //цикл по количеству заказов
             While (not MainQuery.Eof) do
             begin

                PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                sstr := '|' + RightLine(IntToStr(i), 5) + '|'+
                        RightLine(MainQuery.FieldByName('NUMBER_RQST').AsString + '/' +
                                  MainQuery.FieldByName('NUMBER_ORDER').AsString, 17) + '|' +
                        LeftLine(MainQuery.FieldByName('NAME_CST').AsString, 30)+ '|' +
                        LeftLine('('+MainQuery.FieldByName('CODE_PDR').AsString+') '+
                                 MainQuery.FieldByName('NAME_PDR').AsString , 27)+ '|' +
                        LeftLine('('+MainQuery.FieldByName('CODE_CHRT').AsString+') '+
                                 MainQuery.FieldByName('NAME_CHRT').AsString, 40)+ '|' +
                        RightLine(FormatFloat('0.00', MainQuery.FieldByName('SUM_NPRICE').asFloat), 13) + '|' ;

                add(sstr);
                i := i + 1;
                Total_sum := Total_sum + MainQuery.FieldByName('SUM_NPRICE').asFloat;
                MainQuery.Next;        

             end;

             add(RepeatLine('-', n));
             add(RightLine('Итого:', 124) + ' ' +
                 RightLine(FormatFloat('0.00', Total_sum), 13)  );
             add('');
             PrForm.Destroy;

             Form.Caption := 'Учёт трудоёмкости работ выплненных ЦМО, для смежных участков РМП';
             Form.Editor.show;
             Form.show;

       end;

end;

procedure TReport57Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);
end;

procedure TReport57Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

end.
