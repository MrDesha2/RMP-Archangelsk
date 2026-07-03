unit Rep5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, DB, DBTables, EnumForm4Sel, ExtCtrls;

type
  TReport5Form = class(TForm)
    Label6: TLabel;
    Label9: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    Label7: TLabel;
    RqstEdit: TEdit;
    Label8: TLabel;
    OrderEdit: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    ChrtCombo: TComboEdit;
    Label5: TLabel;
    NMNTCombo: TComboEdit;
    ChrtQuery: TQuery;
    qNMNTQuery: TQuery;
    Button1: TButton;
    Button2: TButton;
    ChrtToNmntQuery: TQuery;
    NmntToChrtQuery: TQuery;
    MainQuery: TQuery;
    Label10: TLabel;
    CstCombo: TComboEdit;
    Label11: TLabel;
    PdrCombo: TComboEdit;
    CstQuery: TQuery;
    PdrQuery: TQuery;
    ButtonSelPer: TButton;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure ChrtComboButtonClick(Sender: TObject);
    procedure ChrtComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report5Form: TReport5Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport5Form.ChrtComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, ChrtQuery, ChrtCombo, 'select id, code, name from spr_chrt',
                        'Справочник: Чертежи (Выбор)', 0);

  //Ищу по заданному чертежу номенклатуру
  {ChrtToNmntQuery.Close;
  ChrtToNmntQuery.ParamByName('id').AsInteger := ChrtQuery.FieldByName('id').AsInteger;
  ChrtToNmntQuery.Open;

  if (ChrtToNmntQuery.FieldByName('id').IsNull) and
     (ChrtToNmntQuery.FieldByName('id').AsInteger <> 0) Then
  begin
     //По найденной номенклатуре открываю запрос qNMNTQuery для его активизации и
     // в NMNTCombo.Text ставим наименование номенклатуры

     NMNTCombo.Text := ChrtToNmntQuery.FieldByName('name').AsString;
     qNMNTQuery.Close;
     qNMNTQuery.ParamByName('id').AsInteger := ChrtToNmntQuery.FieldByName('id').AsInteger;
     qNMNTQuery.ParamByName('code').AsInteger := ChrtToNmntQuery.FieldByName('code').AsInteger;
     qNMNTQuery.Open;
  end
   else NMNTCombo.Text := '';}

end;

procedure TReport5Form.ChrtComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(ChrtQuery, ChrtCombo, key, Shift, 1) = false then
    ChrtComboButtonClick(Sender);

end;

procedure TReport5Form.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qNMNTQuery, NMNTCombo, 'select id, code, name from spr_nmnt',
                        'Справочник: Номенклатура (Выбор)', 0);
{  //Ищу по заданной номенклатуре чертеж
  NmntToChrtQuery.Close;
  NmntToChrtQuery.ParamByName('id').AsInteger := qNmntQuery.FieldByName('id').AsInteger;
  NmntToChrtQuery.Open;

  if //(NmntToChrtQuery.FieldByName('id').isNull) and
     (NmntToChrtQuery.FieldByName('id').AsInteger <> 0) Then
  begin
     //По найденному чертежу открываю запрос ChrtQuery для его активизации и
     // в ChrtCombo.Text ставим наименование чертежа
     ChrtCombo.Text := NmntToChrtQuery.FieldByName('name').AsString;
     ChrtQuery.Close;
     ChrtQuery.ParamByName('id').AsInteger := NmntToChrtQuery.FieldByName('id').AsInteger;
     ChrtQuery.ParamByName('code').AsInteger := NmntToChrtQuery.FieldByName('code').AsInteger;
     ChrtQuery.Open;
  end
   else
   begin
      MessageDlg('У номенклатуры отсутствует чертеж!', mtWarning , [mbYes], 0);
      qNMNTQuery.Close;
      qNMNTQuery.Active := False;
      NmntToChrtQuery.Close;
      NmntToChrtQuery.Active := False;
   end;}

end;

procedure TReport5Form.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qNMNTQuery, NMNTCombo, key, Shift, 1) = false then
    NMNTComboButtonClick(Sender);

end;

procedure TReport5Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport5Form.Button2Click(Sender: TObject);
begin
        Close;

end;

procedure TReport5Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;

end;

procedure TReport5Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       Pdr, Cst : String;
       Total_Num : Real;  //Всего количество
       Total_Sum : Real;  //Всего Сумма
       Total_Hour: Real;  //Всего Трудозатраты
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

       Total_Num :=0;
       Total_Sum :=0;
       Total_Hour:=0;

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select * From REPORT_5_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :NUM_RQST, :NUM_ORDER, :ID_CST, :ID_PDR, :ID_CHRT, :ID_NMNT, :VID)');

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

       If (CstCombo.Text <> '') and (CstCombo.Text <> '<Объект не найден>') Then
          MainQuery.ParamByName('ID_CST').AsInteger := CstQuery.Fields[0].AsInteger
        else
           MainQuery.ParamByName('ID_CST').AsInteger := 0;

       If (PdrCombo.Text <> '') and (PdrCombo.Text <> '<Объект не найден>') Then
          MainQuery.ParamByName('ID_PDR').AsInteger := PdrQuery.Fields[0].AsInteger
        else
           MainQuery.ParamByName('ID_PDR').AsInteger := 0;

       If (ChrtCombo.Text <> '') and (ChrtCombo.Text <> '<Объект не найден>') Then
          MainQuery.ParamByName('ID_CHRT').AsInteger := ChrtQuery.Fields[0].AsInteger
        else
           MainQuery.ParamByName('ID_CHRT').AsInteger := 0;

       If (NmntCombo.Text <> '') and (NmntCombo.Text <> '<Объект не найден>') Then
          MainQuery.ParamByName('ID_NMNT').AsInteger := qNmntQuery.Fields[0].AsInteger
        else
           MainQuery.ParamByName('ID_NMNT').AsInteger := 0;

       If (RadioButton2.Checked = True) Then
            MainQuery.ParamByName('VID').AsInteger := 0
        else
            MainQuery.ParamByName('VID').AsInteger := 1;

       MainQuery.Open;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;

          While (not MainQuery.Eof) do
          begin

             Pdr := Trim(MainQuery.FieldByName('PDR_NAME').AsString);

             While ((Pdr = Trim(MainQuery.FieldByName('PDR_NAME').AsString)) and
                   (not MainQuery.Eof)) do
             begin

                add('');
                add('');
                add(CentrLine('Выполнение заказов '
                   + GetSystemParams('Service'),141));
                add(CentrLine('участком '+Trim(MainQuery.FieldByName('PDR_NAME').AsString),141));
                add('');
                add('Заказчик: '+Trim(MainQuery.FieldByName('CST_NAME').AsString));
                add(RepeatLine('-', 141));
                add(' №Заявка/№Заказ | № Документа |           Наименование номенклатуры           |    Код чертежа    |Количество|    Дата    |  Сумма  |Трудоза|');
                add('                |             |                                               |                   |          | расходного |         | траты |');
                add('                |             |                                               |                   |          |  документа |         |       |');
                add(RepeatLine('-', 141));
                                                      
                Cst := Trim(MainQuery.FieldByName('CST_NAME').AsString);

                While ((Cst = Trim(MainQuery.FieldByName('CST_NAME').AsString)) and
                      (not MainQuery.Eof)) do
                begin

                   PrForm.ProgressBar.Position:=(i)*100 div MainQuery.RecordCount;

                   add(RightLine(MainQuery.FieldByName('RQST_NUM').AsString+'/'+
                                 MainQuery.FieldByName('ORDER_NUM').AsString, 16)+' '+
                       RightLine(MainQuery.FieldByName('DOC_NUM').AsString, 13)+' '+
                       LeftLine(MainQuery.FieldByName('NMNT_NAME').AsString, 47)+' '+
                       RightLine(MainQuery.FieldByName('CHRT_CODE').AsString, 19)+' '+
                       RightLine(MainQuery.FieldByName('NUMBER').AsString, 10)+' '+
                       CentrLine(MainQuery.FieldByName('DOC_DATE').AsString, 12)+' '+
                       RightLine(FormatFloat('0.00', MainQuery.FieldByName('SUM_DOC').AsFloat), 9)+' '+
                       RightLine(FormatFloat('0.00', MainQuery.FieldByName('SUM_TIME').AsFloat/1000), 7));

                   Total_Num :=Total_Num + MainQuery.FieldByName('NUMBER').AsFloat;
                   Total_Sum :=Total_Sum + MainQuery.FieldByName('SUM_DOC').AsFloat;
                   Total_Hour:=Total_Hour+ MainQuery.FieldByName('SUM_TIME').AsFloat/1000;

                   i:=i+1;
                   MainQuery.Next;
                end;
                add(RepeatLine('-', 141));
                add(RepeatLine(' ', 90)+'ИТОГО:   '+ RightLine(FormatFloat('0.00',Total_Num),10)+ RepeatLine(' ', 13)+
                    RightLine(FormatFloat('0.00',Total_Sum),10)+' '+RightLine(FormatFloat('0.00',Total_Hour),7));

                Total_Num :=0;
                Total_Sum :=0;
                Total_Hour:=0;

             end;
          end;
          add(RepeatLine('-', 141));
       end;
       PrForm.Destroy;

       Form.Caption := 'Ведомость по архиву';
       Form.Editor.show;
       Form.show;

end;

procedure TReport5Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport5Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport5Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);

end;

procedure TReport5Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);

end;

procedure TReport5Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport5Form.RadioButton1Click(Sender: TObject);
begin
  RadioButton1.Font.Style := [fsBold];
  RadioButton2.Font.Style := [];
end;

procedure TReport5Form.RadioButton2Click(Sender: TObject);
begin
  RadioButton1.Font.Style := [];
  RadioButton2.Font.Style := [fsBold];
end;

end.
