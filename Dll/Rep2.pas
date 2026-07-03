unit Rep2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Mask, ToolEdit, EnumForm4Sel;

type
  TReport2Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    Button1: TButton;
    Button2: TButton;
    MainQuery: TQuery;
    ButtonSelPer: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report2Form: TReport2Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport2Form.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TReport2Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport2Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport2Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
begin

       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       If ((BegDateEdit.Text ='  .  .  ') or (EndDateEdit.Text = '  .  .  ')) Then
       begin
          MessageDlg('Даты не заполнены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select * From REPORT_2_PROCEDURE(:DATE_BEG, :DATE_END)');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       MainQuery.Open;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;

          add('');
          add('');
          add(CentrLine('График работы ОТК с '+ BegDateEdit.Text + ' по ' + EndDateEdit.Text, 167));
          add('');
          add(RepeatLine('-', 167));
          add('|  №заявки  |        Номенклатура       |   Чертеж   | Кол-во |   Текущая операция    | Начало операции |Завершение операции|     Исполнитель     |     Инструмент     |');
          add('|  №заказа  |                           |            |        |                       |                 |                   |                     |                    |');
          add(RepeatLine('-', 167));

          While (not MainQuery.Eof) do
          begin

                 PrForm.ProgressBar.Position:=(i)*100 div MainQuery.RecordCount;

                 add(RightLine(MainQuery.FieldByName('Num_Rqst').AsString + '/' +
                               MainQuery.FieldByName('Num_Order').AsString, 12)+' '+
                     LeftLine(MainQuery.FieldByName('Name_Nmnt').AsString, 27)+' '+
                     LeftLine(MainQuery.FieldByName('Code_Chrt').AsString,12)+' '+
                     RightLine(FormatFloat('0.000',MainQuery.FieldByName('Number').AsFloat), 8)+' '+
                     LeftLine(MainQuery.FieldByName('Line_No').AsString+' '+
                              MainQuery.FieldByName('Name_Vop').AsString, 23)+' '+
                     RightLine(MainQuery.FieldByName('Beg_Time').AsString+' '+
                               MainQuery.FieldByName('Beg_Date').AsString, 17)+' '+
                     RightLine(MainQuery.FieldByName('End_Time').AsString+' '+
                               MainQuery.FieldByName('End_Date').AsString, 19)+' '+
                     LeftLine(MainQuery.FieldByName('Name_Wrkr').AsString, 21)+' '+
                     LeftLine(MainQuery.FieldByName('Name_Eqpt').AsString, 20)+' ');

                 i:=i+1;
                 MainQuery.Next;
          end;
          add(RepeatLine('-', 167));
       end;

       PrForm.Destroy;

       Form.Caption := 'График работы ОТК';
       Form.Editor.show;
       Form.show;

end;

procedure TReport2Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
