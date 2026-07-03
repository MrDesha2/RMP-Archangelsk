unit Rep37;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, EnumForm4Sel, StdCtrls, Mask, ToolEdit, DB, DBTables, DateUtil;

type
  TReport37Form = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    Button2: TButton;
    Button1: TButton;
    WrkrCombo: TComboEdit;
    WrkrQuery: TQuery;
    SertCombo: TComboEdit;
    Label10: TLabel;
    Label4: TLabel;
    SertQuery: TQuery;
    MainQuery: TQuery;
    procedure ButtonSelPerClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure WrkrComboButtonClick(Sender: TObject);
    procedure WrkrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SertComboButtonClick(Sender: TObject);
    procedure SertComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report37Form: TReport37Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport37Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport37Form.Button2Click(Sender: TObject);
begin
        Close;
end;

procedure TReport37Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport37Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := '01.01.1900';//datetostr(now);
  EndDateEdit.text := '31.12.2999';//datetostr(now);
end;

procedure TReport37Form.WrkrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, WrkrCombo, 'select id, code, name from spr_wrkr',
                        'Справочник: Работники (Выбор)', 0);
end;

procedure TReport37Form.WrkrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, WrkrCombo, key, Shift, 1) = false then
    WrkrComboButtonClick(Sender);
end;

procedure TReport37Form.SertComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, SertQuery, SertCombo, 'select id, code, name from spr_sertificate',
                        'Справочник: Аттестация (Выбор)', 0);
end;

procedure TReport37Form.SertComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(SertQuery, SertCombo, key, Shift, 1) = false then
    SertComboButtonClick(Sender);
end;

procedure TReport37Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       Wrkr_Code : Integer;
       Sert_Code : Integer;
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
       MainQuery.SQL.Add('Select * From REPORT_37_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_WRKR, :ID_SERT)');
       MainQuery.SQL.Add('Order by CODE_SERT, DATE_EXP, NAME_WRKR');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (WrkrCombo.Text = '') or (WrkrCombo.Text = '<Объект не найден>') or (not WrkrQuery.active) Then
            MainQuery.ParamByName('ID_Wrkr').AsInteger := 0
        else
               MainQuery.ParamByName('ID_Wrkr').AsInteger := WrkrQuery.Fields[0].AsInteger;

       If (SertCombo.Text = '') or (SertCombo.Text = '<Объект не найден>') or (not SertQuery.active) Then
            MainQuery.ParamByName('ID_SERT').AsInteger := 0
        else
               MainQuery.ParamByName('ID_SERT').AsInteger := SertQuery.Fields[0].AsInteger;

       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;

          If (WrkrCombo.Text = '') or (WrkrCombo.Text = '<Объект не найден>') or (not WrkrQuery.active) Then
          begin

            While (not MainQuery.Eof) do
            begin
              add('');
              add(CentrLine('Аттестация рабочих с '+BegDateEdit.Text+' по '+EndDateEdit.Text, 121));
              add(CentrLine('по специальности '+ MainQuery.FieldByName('NAME_SERT').AsString, 121));
              add(RepeatLine('-', 144));
              add('  №  | Таб. № |       Фамилия Имя Отчество       |   №   |   №    |Дата получения|Дата окончания|            Допуск            |   Примечание  |');
              add(' п/п |        |                                  |проток.| удост. |    допуска   |   допуска    |                              |               |');
              add(RepeatLine('-', 144));

              Sert_Code := MainQuery.FieldByName('CODE_SERT').AsInteger;

              While (Sert_Code = MainQuery.FieldByName('CODE_SERT').AsInteger) and
                    (not MainQuery.Eof) do
              begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 add(RightLine(IntToStr(i), 5)+'|'+
                     RightLine(MainQuery.FieldByName('CODE_WRKR').AsString, 8)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_WRKR').AsString, 34)+'|'+
                     RightLine(MainQuery.FieldByName('PROTOCOL').AsString, 7)+'|'+
                     RightLine(MainQuery.FieldByName('NUMBER').AsString, 8)+'|'+
                     CentrLine(MainQuery.FieldByName('DATE_SERT').AsString, 14)+'|'+
                     CentrLine(MainQuery.FieldByName('DATE_EXP').AsString, 14)+'|'+
                     LeftLine(MainQuery.FieldByName('ACCESS').AsString, 30)+'|'+
                     LeftLine('', 15)+'|');

                 i:=i+1;
                 MainQuery.Next;

              end;

              add(RepeatLine('-', 144));
              add('');
              add('');
              add('');

            end;
          end
           else
           begin

             While (not MainQuery.Eof) do
             begin

               add('');
               add(CentrLine('Аттестация ('+MainQuery.FieldByName('CODE_WRKR').AsString+') '+MainQuery.FieldByName('NAME_WRKR').AsString, 107));
               add(CentrLine('за период c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 108));
               add(RepeatLine('-', 125));
               add('  №  |        Наименование сертификата        |   №   |    №   |Дата получения|Дата окончания|            Допуск            |');
               add(' п/п |                                        |проток.| удост. |    допуска   |    допуска   |                              |');
               add(RepeatLine('-', 125));

               Wrkr_Code := MainQuery.FieldByName('CODE_WRKR').AsInteger;

               While (Wrkr_Code = MainQuery.FieldByName('CODE_WRKR').AsInteger) and
                     (not MainQuery.Eof) do
               begin

                  PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                  add(RightLine(IntToStr(i), 5)+'|'+
                      LeftLine(MainQuery.FieldByName('NAME_SERT').AsString, 40)+'|'+
                      RightLine(MainQuery.FieldByName('PROTOCOL').AsString, 7)+'|'+
                      RightLine(MainQuery.FieldByName('NUMBER').AsString, 8)+'|'+
                      CentrLine(MainQuery.FieldByName('DATE_SERT').AsString, 14)+'|'+
                      CentrLine(MainQuery.FieldByName('DATE_EXP').AsString, 14)+'|'+
                      LeftLine(MainQuery.FieldByName('ACCESS').AsString, 30)+'|');

                  i:=i+1;
                  MainQuery.Next;

               end;

               add(RepeatLine('-', 125));
               add('');
               add('');
               add('');
             end;

           end;
       end;

       PrForm.Destroy;

       Form.Caption := 'Аттестация работников';
       Form.Editor.show;
       Form.show;
end;

end.
