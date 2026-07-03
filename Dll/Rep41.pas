unit Rep41;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel;

type
  TReport41Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    Label10: TLabel;
    EqptCombo: TComboEdit;
    Button1: TButton;
    Button2: TButton;
    EqptQuery: TQuery;
    MainQuery: TQuery;
    Label1: TLabel;
    Label4: TLabel;
    WrkrCombo: TComboEdit;
    WrkrQuery: TQuery;
    Label5: TLabel;
    PdrCombo: TComboEdit;
    PdrQuery: TQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WrkrComboButtonClick(Sender: TObject);
    procedure WrkrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report41Form: TReport41Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport41Form.Button2Click(Sender: TObject);
begin
    Close;
end;

procedure TReport41Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport41Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport41Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport41Form.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, EqptQuery, EqptCombo, 'select id, code, name from spr_eqpt',
                        'Справочник: Инструмент (Выбор)', 0);
end;

procedure TReport41Form.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EqptQuery, EqptCombo, key, Shift, 1) = false then
    EqptComboButtonClick(Sender);
end;

procedure TReport41Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport41Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport41Form.WrkrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, WrkrCombo, 'select id, code, name from spr_wrkr',
                        'Справочник: Работники (Выбор)', 0);
end;

procedure TReport41Form.WrkrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, WrkrCombo, key, Shift, 1) = false then
    WrkrComboButtonClick(Sender);
end;

procedure TReport41Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       Wrkr_Id : Integer;
       sstr : String;
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
       MainQuery.SQL.Add('Select * From REPORT_41_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_EQPT, :ID_WRKR, :ID_PDR)');
       MainQuery.SQL.Add('Order By NAME_WRKR, DATE_IN, TYPE_DOC, NAME_EQPT, DOCNUM');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

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

              Wrkr_Id := MainQuery.FieldByName('WRKR_ID').AsInteger;
              sstr := '';

              add('');
              add(RightLine(DateToStr(date),146));
              add(RightLine(TimeToStr(time),146));
              add('');
              add(CentrLine('Форма учета выдачи инструмента рабочему персоналу РМП', 148));
              add('');
              add(LeftLine('Табельный номер: '+MainQuery.FieldByName('CODE_WRKR').AsString, 148));
              add(LeftLine('Фамилия И.О.: '+MainQuery.FieldByName('NAME_WRKR').AsString, 148));
              add(LeftLine('Участок: '+MainQuery.FieldByName('NAME_PDR').AsString, 148));
              add(LeftLine('Профессия: '+MainQuery.FieldByName('NAME_PROF').AsString, 148));
              add(LeftLine('Дата поступления на работу: '+MainQuery.FieldByName('DATE_INTO').AsString, 148));
              add('');
              add(RepeatLine('-', 148));
              add('           |                                        |                 |    |              Выдача               |               Возврат             |');
              add('Инвентарный|        Наименование инструмента        |Марка инструмента|Ед. |-----------------------------------|-----------------------------------|');
              add('   номер   |                                        |                 |изм.|   Дата   |  №   |Кол-во|% годности|   Дата   |  №   |Кол-во| % выдачи |');
              add('           |                                        |                 |    |  выдачи  |док-та|      |          | возврата |док-та|      |          |');
              add(RepeatLine('-', 148));

              While (Wrkr_Id = MainQuery.FieldByName('WRKR_ID').AsInteger) and
                    (not MainQuery.Eof) do
              begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 sstr := RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 11)+'|'+
                         LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 40)+'|'+
                         LeftLine(MainQuery.FieldByName('NAME_MARK').AsString, 17)+'|'+
                         LeftLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 4)+'|';

                 If (MainQuery.FieldByName('TYPE_DOC').AsInteger = 0) Then
                 begin
                        sstr:=sstr + CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 10)+'|'+
                            RightLine(MainQuery.FieldByName('DOCNUM').AsString, 6)+'|'+
                            RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 6)+'|'+
                           '          |          |      |      |';
                 end
                  else
                    begin
                      sstr:=sstr + '          |      |      |          |'+
                            CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 10)+'|'+
                            RightLine(MainQuery.FieldByName('DOCNUM').AsString, 6)+'|'+
                            RightLine(MainQuery.FieldByName('NUMBER_IN').AsString, 6)+'|';
                    end;

                 add(sstr);

                 i:=i+1;
                 MainQuery.Next;

              end;

              add(RepeatLine('-', 148));
              add('');
              add('');

          end;
       end;
       PrForm.Destroy;

       Form.Caption := 'Форма учета выдачи инструмента рабочему персоналу РМП';
       Form.Editor.show;
       Form.show;

end;

end.
