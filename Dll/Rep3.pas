unit Rep3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel;

type
  TReport3Form = class(TForm)
    Label9: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    Label7: TLabel;
    RqstEdit: TEdit;
    Label8: TLabel;
    OrderEdit: TEdit;
    Label1: TLabel;
    ChrtCombo: TComboEdit;
    NMNTCombo: TComboEdit;
    ChrtQuery: TQuery;
    ChrtToNmntQuery: TQuery;
    qNMNTQuery: TQuery;
    NmntToChrtQuery: TQuery;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    RadioButtonPlan: TRadioButton;
    RadioButtonFakt: TRadioButton;
    MainQuery: TQuery;
    ButtonSelPer: TButton;
    procedure ChrtComboButtonClick(Sender: TObject);
    procedure ChrtComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report3Form: TReport3Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport3Form.ChrtComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, ChrtQuery, ChrtCombo, 'select id, code, name from spr_chrt',
                        'Справочник: Чертежи (Выбор)', 0);

end;

procedure TReport3Form.ChrtComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(ChrtQuery, ChrtCombo, key, Shift, 1) = false then
    ChrtComboButtonClick(Sender);

end;

procedure TReport3Form.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qNMNTQuery, NMNTCombo, 'select id, code, name from spr_nmnt',
                        'Справочник: Номенклатура (Выбор)', 0);

end;

procedure TReport3Form.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qNMNTQuery, NMNTCombo, key, Shift, 1) = false then
    NMNTComboButtonClick(Sender);

end;

procedure TReport3Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);

end;

procedure TReport3Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;

end;

procedure TReport3Form.Button2Click(Sender: TObject);
begin
        Close;
end;

procedure TReport3Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       Num_Ord, i : Integer;
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
       MainQuery.SQL.Add('Select * From REPORT_3_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :NUM_RQST, :NUM_ORDER, :ID_CHRT, :ID_NMNT, :STATUS)');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If RqstEdit.Text <> '' Then
          MainQuery.ParamByName('NUM_RQST').AsInteger := StrToInt(RqstEdit.Text)
        else
           MainQuery.ParamByName('NUM_RQST').AsInteger := 0;

       If OrderEdit.Text <> '' Then
          MainQuery.ParamByName('NUM_ORDER').AsInteger := StrToInt(OrderEdit.Text)
        else
           MainQuery.ParamByName('NUM_ORDER').AsInteger := 0;

       If (ChrtCombo.Text <> '') and (ChrtCombo.Text <> '<Объект не найден>') Then
          MainQuery.ParamByName('ID_CHRT').AsInteger := ChrtQuery.Fields[0].AsInteger
        else
           MainQuery.ParamByName('ID_CHRT').AsInteger := 0;

       If (NmntCombo.Text <> '') and (NmntCombo.Text <> '<Объект не найден>') Then
          MainQuery.ParamByName('ID_NMNT').AsInteger := qNmntQuery.Fields[0].AsInteger
        else
           MainQuery.ParamByName('ID_NMNT').AsInteger := 0;

       If RadioButtonPlan.Checked = True Then
           MainQuery.ParamByName('STATUS').AsInteger := 0
        else
            MainQuery.ParamByName('STATUS').AsInteger := 1;

       MainQuery.Open;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;

          While (not MainQuery.Eof) do
          begin

              Num_Ord := MainQuery.FieldByName('ORDER_NUM').AsInteger;

              add('');
              add('');
              add(CentrLine('Планируемый период выполения заказа №'+
                             MainQuery.FieldByName('RQST_NUM').AsString+'/'+
                             MainQuery.FieldByName('ORDER_NUM').AsString,124));
              add(CentrLine('участком '+Trim(MainQuery.FieldByName('PDR_NAME').AsString),124));
              add('');
              add('Заказчик: '+Trim(MainQuery.FieldByName('CST_NAME').AsString));
              add('');
              add('Чертеж: '+Trim(MainQuery.FieldByName('CHRT_CODE').AsString));
              add('');
              add('Количество: '+Trim(MainQuery.FieldByName('NUMBER').AsString));
              add(RepeatLine('-', 124));
              add(' №  | Наименование операции |   Время Дата   |    Время Дата     |        Инструмент        |          Исполнитель          |');
              add('п.п.|                       | начала операции|завершения операции|                          |                               |');
              add(RepeatLine('-', 124));

              While ((Num_Ord = MainQuery.FieldByName('ORDER_NUM').AsInteger) and
                     (not MainQuery.Eof)) do
              begin

                 PrForm.ProgressBar.Position:=(i)*100 div MainQuery.RecordCount;
                 
                 add(RightLine(MainQuery.FieldByName('LINE_NO').AsString, 3)+'.|'+
                     LeftLine(MainQuery.FieldByName('NAME_VOP').AsString, 23)+'|'+
                     RightLine(MainQuery.FieldByName('BEG_TIME').AsString, 5)+' '+
                     LeftLine(MainQuery.FieldByName('BEG_DATE').AsString, 10)+'|'+
                     CentrLine(RightLine(MainQuery.FieldByName('END_TIME').AsString, 5)+' '+
                     LeftLine(MainQuery.FieldByName('END_DATE').AsString, 10), 19)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 26)+'|'+
                     LeftLine(MainQuery.FieldByName('NAME_WRKR').AsString, 31)+'|');

                  i:=i+1;
                  MainQuery.Next
              end;
              add(RepeatLine('-', 124));
          end;
       end;
       PrForm.Destroy;

       Form.Caption := 'Планируемый период выполения заказа';
       Form.Editor.show;
       Form.show;

end;

procedure TReport3Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
