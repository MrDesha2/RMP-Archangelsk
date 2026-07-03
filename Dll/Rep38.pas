unit Rep38;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, EnumForm4Sel, DB, DBTables;

type
  TReport38Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    Button1: TButton;
    Button2: TButton;
    Label10: TLabel;
    WrkrCombo: TComboEdit;
    WrkrQuery: TQuery;
    MainQuery: TQuery;
    Label1: TLabel;
    PdrCombo: TComboEdit;
    PdrQuery: TQuery;
    NumDocEdit: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    EqptCombo: TComboEdit;
    EqptQuery: TQuery;
    procedure ButtonSelPerClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure WrkrComboButtonClick(Sender: TObject);
    procedure WrkrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report38Form: TReport38Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport38Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport38Form.Button2Click(Sender: TObject);
begin
    Close;
end;

procedure TReport38Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport38Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport38Form.WrkrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, WrkrCombo, 'select id, code, name from spr_wrkr',
                        'Справочник: Работники (Выбор)', 0);

end;

procedure TReport38Form.WrkrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, WrkrCombo, key, Shift, 1) = false then
    WrkrComboButtonClick(Sender);
end;

procedure TReport38Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       NumDoc : Integer;
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
       MainQuery.SQL.Add('Select * From REPORT_38_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_EQPT, :NUMDOC, :ID_PDR, :ID_WRKR)');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If ((NumDocEdit.Text = '0') or (Trim(NumDocEdit.Text) = '')) Then
            MainQuery.ParamByName('NUMDOC').AsInteger := 0
        else
               Try
                  MainQuery.ParamByName('NUMDOC').AsInteger := StrToInt(NumDocEdit.Text)
                except
                    MainQuery.ParamByName('NUMDOC').AsInteger := 0;
               end;

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('ID_Pdr').AsInteger := 0
        else
               MainQuery.ParamByName('ID_Pdr').AsInteger := PdrQuery.Fields[0].AsInteger;

       If (WrkrCombo.Text = '') or (WrkrCombo.Text = '<Объект не найден>') or (not WrkrQuery.active) Then
            MainQuery.ParamByName('ID_Wrkr').AsInteger := 0
        else
               MainQuery.ParamByName('ID_Wrkr').AsInteger := WrkrQuery.Fields[0].AsInteger;

       If (EqptCombo.Text = '') or (EqptCombo.Text = '<Объект не найден>') or (not EqptQuery.active) Then
            MainQuery.ParamByName('ID_EQPT').AsInteger := 0
        else
               MainQuery.ParamByName('ID_EQPT').AsInteger := EqptQuery.Fields[0].AsInteger;    

       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;

          While not MainQuery.Eof do
          begin

              NumDoc := MainQuery.FieldByName('DOCNUM').AsInteger;

              add('');
              add(RightLine('От работника подразделения: '+Trim(MainQuery.FieldByName('NAME_PDR').AsString), 97));
              add(RightLine(Trim(MainQuery.FieldByName('WRKR_NAME').AsString), 97));
              add(RightLine(MainQuery.FieldByName('DATE_IN').AsString, 97));
              add('');
              add('');
              add(CentrLine('Заявка на инструмент для РМП АЦБК '+MainQuery.FieldByName('DOCNUM').AsString, 97));
              add('');

              add(RepeatLine('-', 97));
              add('  №  |        Наименование инструмента        |       Марка       |  Ед.  |Кол-во|Требуемая дата|');
              add(' п/п |                                        |                   |  изм. |      | приобритения |');
              add(RepeatLine('-', 97));

              While (NumDoc = MainQuery.FieldByName('DOCNUM').AsInteger) and
                    (not MainQuery.Eof) do
              begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 add(RightLine(MainQuery.FieldByName('LINENO').AsString, 5)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 40)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_MARK').AsString, 19)+'|'+
                     CentrLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 7)+'|'+
                     RightLine(MainQuery.FieldByName('NUMBER').AsString, 6)+'|');

                 i:=i+1;
                 MainQuery.Next;

              end;

              add(RepeatLine('-', 97));
              add('');
              add('');
          end;    
       end;
       PrForm.Destroy;

       Form.Caption := 'Заявка на инструмент для РМП АЦБК';
       Form.Editor.show;
       Form.show;
end;

procedure TReport38Form.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, EqptQuery, EqptCombo, 'select id, code, name from spr_eqpt',
                        'Справочник: Инструмент (Выбор)', 0);
end;

procedure TReport38Form.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EqptQuery, EqptCombo, key, Shift, 1) = false then
    EqptComboButtonClick(Sender);
end;

procedure TReport38Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport38Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

end.
