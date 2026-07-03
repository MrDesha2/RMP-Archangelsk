unit Rep50;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel;

type
  TReport50Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Label5: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    EqptCombo: TComboEdit;
    Print: TButton;
    bClose: TButton;
    PdrCombo: TComboEdit;
    EqptQuery: TQuery;
    MainQuery: TQuery;
    WrkrQuery: TQuery;
    PdrQuery: TQuery;
    procedure bCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrintClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report50Form: TReport50Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport50Form.bCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TReport50Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport50Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport50Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport50Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport50Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport50Form.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, EqptQuery, EqptCombo, 'select id, code, name from spr_eqpt',
                        'Справочник: Инструмент (Выбор)', 0);
end;

procedure TReport50Form.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EqptQuery, EqptCombo, key, Shift, 1) = false then
    EqptComboButtonClick(Sender);
end;

procedure TReport50Form.PrintClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       Pdr_Id : Integer;
       Eqpt_Id: Integer;
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
       MainQuery.SQL.Add('Select * From REPORT_50_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_EQPT, :ID_PDR)');
       MainQuery.SQL.Add('Order By NAME_EQPT, DOCNUM ');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('ID_Pdr').AsInteger := 0
        else
               MainQuery.ParamByName('ID_Pdr').AsInteger := PdrQuery.Fields[0].AsInteger;

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
//          Pdr_ID := MainQuery.ParamByName('PDR_ID').AsInteger;
          add('');
          add(RightLine(DateToStr(date),143));
          add(RightLine(TimeToStr(time),143));
          add('');
          add(CentrLine('Форма учета списания инструмента', 145));
          add('');

          add(LeftLine('Подразделение: '+MainQuery.FieldByName('NAME_PDR').AsString, 145));
          add('');
          add(RepeatLine('-', 145));
          add('           |                                        |                 |    |          |                   Списано                    |          |');
          add('Инвентарный|        Наименование инструмента        |Марка инструмента|Ед. |  Сальдо  |----------------------------------------------|  Сальдо  |');
          add('   номер   |                                        |                 |изм.| начальное|   Дата   |  №   |Кол-во|    Подразделение    | конечное |');
          add('           |                                        |                 |    |          |  выдачи  |док-та|      |                     |          |');
          add(RepeatLine('-', 145));

          Eqpt_Id := MainQuery.FieldByName('EQPT_ID').AsInteger;

          While not MainQuery.Eof do
          begin

              sstr := '';


              PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

              sstr := RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 11)+'|'+
                      LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 40)+'|'+
                      LeftLine(MainQuery.FieldByName('NAME_MARK').AsString, 17)+'|'+
                      LeftLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 4)+'|'+
                      RightLine(MainQuery.FieldByName('NUMBER').AsString, 10)+'|'+
                      CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 10)+'|'+
                      RightLine(MainQuery.FieldByName('DOCNUM').AsString, 6)+'|'+
                      RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 6)+'|'+
                      LeftLine(MainQuery.FieldByName('NAME_PDR').AsString, 21)+'|'+
                      RightLine(FormatFloat( '0',MainQuery.FieldByName('NUMBER').AsFloat-MainQuery.FieldByName('NUMBER_OUT').AsFloat), 10)+'|';

              add(sstr);

              i:=i+1;
              MainQuery.Next;

              If (Eqpt_Id <> MainQuery.FieldByName('EQPT_ID').AsInteger) Then
              begin
                 add(RepeatLine('-', 145));
                 Eqpt_Id := MainQuery.FieldByName('EQPT_ID').AsInteger;
              end;


          end;

          add(RepeatLine('-', 145));
          add('');
          add('');
          
       end;
       PrForm.Destroy;

       Form.Caption := 'Форма учета выдачи инструмента рабочему персоналу РМП';
       Form.Editor.show;
       Form.show;
end;

end.
