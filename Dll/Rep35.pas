unit Rep35;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Mask, ToolEdit, EnumForm4Sel;

type
  TReport35Form = class(TForm)
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
  Report35Form: TReport35Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport35Form.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TReport35Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport35Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport35Form.Button1Click(Sender: TObject);
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
       MainQuery.SQL.Add('Select * From REPORT_35_PROCEDURE(:DATE_BEG, :DATE_END)');

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
          add(CentrLine('Загрузка оборудования с '+ BegDateEdit.Text + ' по ' + EndDateEdit.Text, 72));
          add('');
          add(RepeatLine('-', 72));
          add('| Инвентарный |         Наименование         |  Загрузка оборудования  |');
          add('|    номер    |         оборудования         |  в часах  | в процентах |');
          add(RepeatLine('-', 72));

          While (not MainQuery.Eof) do
          begin

                 PrForm.ProgressBar.Position:=(i)*100 div MainQuery.RecordCount;

                 add(RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 14) + ' ' +
                     LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 30) + ' ' +
                     RightLine(FormatFloat('0.00',MainQuery.FieldByName('NUM_TIME').AsFloat / 1000), 11));
                 i:=i+1;
                 MainQuery.Next;
                 
          end;
          add(RepeatLine('-', 72));
       end;

       PrForm.Destroy;

       Form.Caption := 'Загрузка оборудования';
       Form.Editor.show;
       Form.show;

end;

procedure TReport35Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);


end;

end.
