unit Rep40;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel;

type
  TReport40Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    Label10: TLabel;
    EqptCombo: TComboEdit;
    EqptQuery: TQuery;
    Button1: TButton;
    Button2: TButton;
    MainQuery: TQuery;
    CellCheckBox: TCheckBox;
    Label1: TLabel;
    WrhsCombo: TComboEdit;
    WrhsQuery: TQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure WrhsComboButtonClick(Sender: TObject);
    procedure WrhsComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CellCheckBoxClick(Sender: TObject);

  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report40Form: TReport40Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport40Form.Button2Click(Sender: TObject);
begin
    Close;
end;

procedure TReport40Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
end;

procedure TReport40Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport40Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport40Form.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, EqptQuery, EqptCombo, 'select id, code, name from spr_eqpt',
                        'Справочник: Инструмент (Выбор)', 0);
end;

procedure TReport40Form.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EqptQuery, EqptCombo, key, Shift, 1) = false then
    EqptComboButtonClick(Sender);
end;

procedure TReport40Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       sstr : String;
       int_in, int_out, int_bef, int_to :Integer;
       sstr_in, sstr_out, sstr_bef, sstr_to :String;
       Id_Eqpt :Integer;
       sstr_wrhs : String;
       EQPT_ID : Integer;
       CODE_EQPT  : String;
       NAME_EQPT  : String;
       NAME_MARK  : String;
       CODE_EDIZ  : String;
       NUMBER_IN  : Real;
       NUMBER_OUT : Real;
       TYPE_DOC   : Integer;
       CELL : Integer;
       NAME_WRHS   : String;
       NUM_SAL_DO  : Integer;
       NUM_SAL_END : Integer;
begin

  if (CellCheckBox.Checked = False) Then
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
       MainQuery.SQL.Add('Select * From REPORT_40_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_EQPT)');
       MainQuery.SQL.Add('Order By NAME_EQPT, TYPE_DOC');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

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

          add('');
          add(RightLine(DateToStr(date),116));
          add(RightLine(TimeToStr(time),116));
          add('');
          add(CentrLine('Оборотная ведомость', 116));
          add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 116));
          add('');
          add(RepeatLine('-', 116));
          add('           |                                        |                 |    |         |         |         |         |');
          add('Инвентарный|        Наименование инструмента        |Марка инструмента|Ед. | Сальдо  | Приход  | Расход  | Сальдо  |');
          add('   номер   |                                        |                 |изм.|начальное|         |         |конечное |');
          add('           |                                        |                 |    |         |         |         |         |');
          add(RepeatLine('-', 116));

          While not MainQuery.Eof do
          begin

             sstr:='';
             sstr_in :='';
             sstr_out :='';
             sstr_bef := '';
             sstr_to := '';
             int_in :=0;
             int_out :=0;
             int_bef :=0;
             int_to := 0;

             Id_Eqpt := MainQuery.FieldByName('EQPT_ID').AsInteger;

             sstr := RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 11)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 40)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_MARK').AsString, 17)+'|'+
                     LeftLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 4)+'|';

             While (ID_Eqpt = MainQuery.FieldByName('EQPT_ID').AsInteger) and
                   (not MainQuery.Eof) do
             begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 If (MainQuery.FieldByName('TYPE_DOC').AsInteger = 0) Then
                 begin
                     int_in:=int_in + MainQuery.FieldByName('NUMBER_IN').AsInteger;
                 end
                  else
                    begin
                      int_out:=int_out + MainQuery.FieldByName('NUMBER_OUT').AsInteger;
                    end;

                 int_bef:=int_bef + MainQuery.FieldByName('NUMBER').AsInteger;

                 i:=i+1;
                 MainQuery.Next;

             end;

             If (int_bef = 0) Then sstr_bef := '0'
              else sstr_bef := FloatToStr(int_bef);

             If (int_in = 0) Then sstr_in := '0'
              else sstr_in:=FloatToStr(int_in);

             If (int_out = 0) Then sstr_out := '0'
              else sstr_out:=FloatToStr(int_out);

             sstr_to:=FloatToStr(StrToFloat(sstr_bef) + StrToFloat(sstr_in) - StrToFloat(sstr_out));

             sstr:=sstr + RightLine(sstr_bef, 9)+'|'+
                   RightLine(sstr_in, 9)+'|'+
                   RightLine(sstr_out, 9)+'|'+
                   RightLine(sstr_to, 9)+'|';

             add(sstr);
          end;
          add(RepeatLine('-', 116));
          add('');
          add('');

       end;

       PrForm.Destroy;

       Form.Caption := 'Оборотная ведомость по инструменту';
       Form.Editor.show;
       Form.show;
  end
   else
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
       MainQuery.SQL.Add('Select * From REPORT_40A_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_EQPT, :ID_WRHS)');
       MainQuery.SQL.Add('Order By NAME_WRHS, CELL, NAME_EQPT, CODE_EDIZ, NUMBER_IN, NUMBER_OUT, NUM_SAL_DO, NUM_SAl_END, TYPE_DOC');
//       MainQuery.SQL.Add('Order By NAME_WRHS, CELL, EQPT_ID, CODE_EDIZ, NUMBER_IN, NUMBER_OUT, NUM_SAL_DO, NUM_SAl_END, TYPE_DOC');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (EqptCombo.Text = '') or (EqptCombo.Text = '<Объект не найден>') or (not EqptQuery.active) Then
            MainQuery.ParamByName('ID_EQPT').AsInteger := 0
        else
               MainQuery.ParamByName('ID_EQPT').AsInteger := EqptQuery.Fields[0].AsInteger;

       If (WrhsCombo.Text = '') or (WrhsCombo.Text = '<Объект не найден>') or (not WrhsQuery.active) Then
            MainQuery.ParamByName('ID_WRHS').AsInteger := 0
        else
               MainQuery.ParamByName('ID_WRHS').AsInteger := WrhsQuery.Fields[0].AsInteger;


       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

       clear;

       add('');
       add(RightLine(DateToStr(date),121));
       add(RightLine(TimeToStr(time),121));

         While not MainQuery.Eof do
         begin


          i := 1;

          add('');
          add(CentrLine('Оборотная ведомость', 123));
          add(CentrLine('по складу '+MainQuery.FieldByName('NAME_WRHS').AsString, 123));
          add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 123));
          add('');
          add(RepeatLine('-', 123));
          add('           |                                        |                 |    |      |         |         |         |         |');
          add('Инвентарный|        Наименование инструмента        |Марка инструмента|Ед. |Ячейка| Сальдо  | Приход  | Расход  | Сальдо  |');
          add('   номер   |                                        |                 |изм.|      |начальное|         |         |конечное |');
          add('           |                                        |                 |    |      |         |         |         |         |');
          add(RepeatLine('-', 123));

          sstr_wrhs := MainQuery.FieldByName('NAME_WRHS').AsString;

          While (sstr_wrhs = MainQuery.FieldByName('NAME_WRHS').AsString) and
                (not MainQuery.Eof) do
          begin

             sstr:='';

             Id_Eqpt := MainQuery.FieldByName('EQPT_ID').AsInteger;

             sstr := RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 11)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 40)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_MARK').AsString, 17)+'|'+
                     LeftLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 4)+'|'+
                     RightLine(MainQuery.FieldByName('CELL').AsString, 6)+'|'+
                     RightLine(MainQuery.FieldByName('NUM_SAL_DO').AsString, 9)+'|'+
                     RightLine(MainQuery.FieldByName('NUMBER_IN').AsString, 9)+'|'+
                     RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 9)+'|'+
                     RightLine(MainQuery.FieldByName('NUM_SAL_END').AsString, 9)+'|';

             EQPT_ID := MainQuery.FieldByName('EQPT_ID').AsInteger;
             CODE_EQPT := MainQuery.FieldByName('CODE_EQPT').AsString;
             NAME_EQPT := MainQuery.FieldByName('NAME_EQPT').AsString;
             NAME_MARK := MainQuery.FieldByName('NAME_MARK').AsString;
             CODE_EDIZ := MainQuery.FieldByName('CODE_EDIZ').AsString;
             NUMBER_IN := MainQuery.FieldByName('NUMBER_IN').AsFloat;
             NUMBER_OUT := MainQuery.FieldByName('NUMBER_OUT').AsFloat;
             TYPE_DOC := MainQuery.FieldByName('TYPE_DOC').AsInteger;
             CELL := MainQuery.FieldByName('CELL').AsInteger;
             NAME_WRHS := MainQuery.FieldByName('NAME_WRHS').AsString;
             NUM_SAL_DO := MainQuery.FieldByName('NUM_SAL_DO').AsInteger;
             NUM_SAL_END := MainQuery.FieldByName('NUM_SAL_END').AsInteger;

             Repeat
                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;
                 i:=i+1;

                 MainQuery.Next;
             Until not ((EQPT_ID = MainQuery.FieldByName('EQPT_ID').AsInteger) and
                   (CODE_EQPT = MainQuery.FieldByName('CODE_EQPT').AsString) and
                   (NAME_EQPT = MainQuery.FieldByName('NAME_EQPT').AsString) and
                   (NAME_MARK = MainQuery.FieldByName('NAME_MARK').AsString) and
                   (CODE_EDIZ = MainQuery.FieldByName('CODE_EDIZ').AsString) and
                   (NUMBER_IN = MainQuery.FieldByName('NUMBER_IN').AsFloat) and
                   (NUMBER_OUT = MainQuery.FieldByName('NUMBER_OUT').AsFloat) and
//                   (TYPE_DOC = MainQuery.FieldByName('TYPE_DOC').AsInteger) and
                   (CELL = MainQuery.FieldByName('CELL').AsInteger) and
                   (NAME_WRHS = MainQuery.FieldByName('NAME_WRHS').AsString) and
                   (NUM_SAL_DO = MainQuery.FieldByName('NUM_SAL_DO').AsInteger) and
                   (NUM_SAL_END = MainQuery.FieldByName('NUM_SAL_END').AsInteger) and
                   (not MainQuery.Eof));


             add(sstr);
          end;
          add(RepeatLine('-', 123));
          add('');
          add('');

         end;
       end;

       PrForm.Destroy;

       Form.Caption := 'Оборотная ведомость по инструменту';
       Form.Editor.show;
       Form.show;
   end;
end;   

procedure TReport40Form.WrhsComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrhsQuery, WrhsCombo, 'select id, code, name from spr_wrhs',
                        'Справочник: Инструмент (Выбор)', 0);

end;

procedure TReport40Form.WrhsComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(WrhsQuery, WrhsCombo, key, Shift, 1) = false then
    WrhsComboButtonClick(Sender);

end;

procedure TReport40Form.CellCheckBoxClick(Sender: TObject);
begin
  If (CellCheckBox.Checked = False) Then
  begin
      WrhsCombo.Enabled := False;
      Label1.Enabled := False;
  end
   else
   begin
       WrhsCombo.Enabled := True;
       Label1.Enabled := True;
   end
end;

end.
