unit Rep44;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel;

type
  TReport44Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    MdlCombo: TComboEdit;
    PrintButton: TButton;
    CloseButton: TButton;
    MdlQuery: TQuery;
    MainQuery: TQuery;
    Label1: TLabel;
    WrhsCombo: TComboEdit;
    WrhsQuery: TQuery;
    procedure ButtonSelPerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MdlComboButtonClick(Sender: TObject);
    procedure MdlComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PrintButtonClick(Sender: TObject);
    procedure WrhsComboButtonClick(Sender: TObject);
    procedure WrhsComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report44Form: TReport44Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport44Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport44Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport44Form.MdlComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, MdlQuery, MdlCombo, 'select id, code, name from spr_mdl',
                        'Справочник: Моделей (Выбор)', 0);
end;

procedure TReport44Form.MdlComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(MdlQuery, MdlCombo, key, Shift, 1) = false then
    MdlComboButtonClick(Sender);
end;

procedure TReport44Form.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TReport44Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
end;

procedure TReport44Form.PrintButtonClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       sstr : String;
       sstr_in, sstr_out, sstr_bef, sstr_to :String;
       Id_Mdl  : Integer;
       Id_Wrhs : Integer;
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
       MainQuery.SQL.Add('Select * From REPORT_44_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_MDL, :ID_WRHS)');
       MainQuery.SQL.Add('Order By NAME_MDL, TYPE_DOC');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (MdlCombo.Text = '') or (MdlCombo.Text = '<Объект не найден>') or (not MdlQuery.active) Then
            MainQuery.ParamByName('ID_MDL').AsInteger := 0
        else
               MainQuery.ParamByName('ID_MDL').AsInteger := MdlQuery.Fields[0].AsInteger;
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

        i := 1;
        Id_Wrhs := 0;
        Id_Mdl  := 0;

        While not MainQuery.Eof do
        begin

           Id_Wrhs := MainQuery.FieldByName('WRHS_ID').AsInteger;

           While ((not MainQuery.Eof) and (Id_Wrhs = MainQuery.FieldByName('WRHS_ID').AsInteger)) do
           begin

             add('');
             add(RightLine(DateToStr(date),123));
             add(RightLine(TimeToStr(time),123));
             add('');
             add(CentrLine('Оборотная ведомость', 123));
             add(CentrLine(MainQuery.FieldByName('NAME_WRHS').AsString , 123));
             add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 123));
             add('');
             add(RepeatLine('-', 123));
             add('                    |                                        |                    |         |         |         |         |');
             add('        Код         |           Наименование модели          |        Чертеж      | Сальдо  | Приход  | Расход  | Сальдо  |');
             add('       модели       |                                        |                    |начальное|         |         |конечное |');
             add('                    |                                        |                    |         |         |         |         |');
             add(RepeatLine('-', 123));

             sstr:='';
             sstr_in :='';
             sstr_out :='';
             sstr_bef := '';
             sstr_to := '';

             Id_Mdl := MainQuery.FieldByName('MDL_ID').AsInteger;

             sstr := RightLine(MainQuery.FieldByName('CODE_MDL').AsString, 20)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_MDL').AsString, 40)+'|'+
                     LeftLine(MainQuery.FieldByName('CODE_CHRT').AsString, 20)+'|';

             While (ID_Mdl = MainQuery.FieldByName('MDL_ID').AsInteger) and
                   (Id_Wrhs = MainQuery.FieldByName('WRHS_ID').AsInteger) and
                   (not MainQuery.Eof) do
             begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 If (MainQuery.FieldByName('TYPE_DOC').AsInteger = 0) Then
                 begin
                     sstr_in:=RightLine(MainQuery.FieldByName('NUMBER_IN').AsString, 9);
                 end
                  else
                    begin
                      sstr_out:=RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 9);
                    end;


                 sstr_bef:= RightLine(MainQuery.FieldByName('NUMBER').AsString, 9) ;

                 i:=i+1;
                 MainQuery.Next;

             end;

             If ((sstr_bef = '') or (sstr_bef = Null)) Then sstr_bef := '0';
             If ((sstr_in = '') or (sstr_in = Null)) Then sstr_in := '0';
             If ((sstr_out = '') or (sstr_out = Null)) Then sstr_out := '0';

             sstr_to:=FloatToStr(StrToFloat(sstr_bef) + StrToFloat(sstr_in) - StrToFloat(sstr_out));


             sstr:=sstr + RightLine(sstr_bef, 9)+'|'+
                   RightLine(sstr_in, 9)+'|'+
                   RightLine(sstr_out, 9)+'|'+
                   RightLine(sstr_to, 9)+'|';

             add(sstr);
          end;
          add(RepeatLine('-', 123));
          add('');
          add('');

        end;
       end;

       PrForm.Destroy;

       Form.Caption := 'Оборотная ведомость по моделям';
       Form.Editor.show;
       Form.show;
end;

procedure TReport44Form.WrhsComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrhsQuery, WrhsCombo, 'select id, code, name from spr_wrhs',
                        'Справочник: Склады (Выбор)', 0);
end;

procedure TReport44Form.WrhsComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrhsQuery, WrhsCombo, key, Shift, 1) = false then
    WrhsComboButtonClick(Sender);
end;

end.
