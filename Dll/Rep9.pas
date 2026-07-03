{***************************************************************
 *
 * Модуль   : Rep9
 * Описание : Отчет по выполненным работам
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}


unit Rep9;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ToolEdit, Mask, EnumForm4Sel, ExtCtrls;

type
  TReport9Form = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    PDRCombo: TComboEdit;
    OKButton: TButton;
    CancelButton: TButton;
    qPDRQuery: TQuery;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label4: TLabel;
    EndDateEdit: TDateEdit;
    CSTCombo: TComboEdit;
    Label5: TLabel;
    MainQuery: TQuery;
    MtrfQuery: TQuery;
    qCSTQuery: TQuery;
    AktQuery: TQuery;
    TimeQuery: TQuery;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    RadioGroup1: TRadioGroup;
    ButtonSelPer: TButton;
    Type_Zak_ComboBox: TComboBox;
    Label6: TLabel;
    TimePlanQuery: TQuery;
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OKButtonClick(Sender: TObject);
    procedure CSTComboButtonClick(Sender: TObject);
    procedure CSTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;

  end;

var
  Report9Form: TReport9Form;

implementation

uses PrintFrm,
    printlibs,
         Libs,
  PrintProces,
   GetPeriods;


{$R *.DFM}

procedure TReport9Form.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPDRQuery, PDRCombo, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);


end;

procedure TReport9Form.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPDRQuery, PDRCombo, key, Shift, 1) = false then
    PDRComboButtonClick(Sender);

end;

procedure TReport9Form.CSTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qCSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);


end;

procedure TReport9Form.CSTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qCSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;


procedure TReport9Form.OKButtonClick(Sender: TObject);
Var

sstr    : String;
PdrStr  : String;
SumFakt : Real;
SumMatr : Real;
SumNakl : Real;
SumAkt  : Real;
SumTime : Real;
SumPlanTime : Real;
i       : Integer;
k       : Integer;

    Form : TShowPrintForm;
  PrForm : TProcessForm;

begin
       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

        If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
        begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
        end;


        If RadioButton1.Checked = True Then
        begin

            MainQuery.Close;
            MainQuery.SQL.Clear;
            MainQuery.SQL.Add('Select * From REPORT_9_PROCEDURE(:Dok, :date_beg, :date_end, :id_pdr, :cst_code, :type_zak)');
            MainQuery.ParamByName('dok').AsInteger := 1;
        end
         else
         begin
              MainQuery.Close;
              MainQuery.SQL.Clear;
              MainQuery.SQL.Add('Select * From REPORT_9_PROCEDURE(:Dok, :date_beg, :date_end, :id_pdr, :cst_code, :type_zak)');
              MainQuery.ParamByName('dok').AsInteger := 0;


              {MainQuery.Close;
              MainQuery.SQL.Clear;
              MainQuery.SQL.Add('Select a.CODE, g.NAME, Sum(d.NVALUE) As Fakt, ');
              MainQuery.SQL.Add('f.CODE, f.NAME, b.ID, g.VID_CHRT, ');
              MainQuery.SQL.Add('c.NUMBER, b.NUMBER, k.NUMDOC');
              MainQuery.SQL.Add('From Spr_Cst a, DH_Order b, DH_Rqst c, ');
              MainQuery.SQL.Add('DT_Order3 d, Spr_Pdr f, Spr_Chrt g, ');
              MainQuery.SQL.Add('DT_RS h, DH_RS k');
              MainQuery.SQL.Add('Where k.DATE_IN>=:date_beg and ');
              MainQuery.SQL.Add('k.DATE_IN<=:date_end and b.PR_EXEC = 3 and ');
              MainQuery.SQL.Add('d.ID_RQST = b.ID and d.ID_CALC = 10 and ');
              MainQuery.SQL.Add('c.ID = b.ID_RQST and a.ID = c.ID_CST and ');
              MainQuery.SQL.Add('f.ID = b.ID_PDR and g.ID = b.ID_CHRT and ');
              MainQuery.SQL.Add('h.ID_ORD = b.ID and k.ID = h.ID_RSMTR');
              MainQuery.SQL.Add('Group by a.CODE, g.NAME, f.CODE, f.NAME, b.ID, g.VID_CHRT, ');
              MainQuery.SQL.Add('c.NUMBER, b.NUMBER, k.NUMDOC');
              MainQuery.SQL.Add('Order by 4, 1, 10');}
         end;

         If (CstCombo.Text  <> '') and (qCSTQuery.active) Then
         begin
             MainQuery.ParamByName('cst_code').AsString := qCstQuery.FieldByName('CODE').AsString;
         end
          else MainQuery.ParamByName('cst_code').AsString := '';

         If (PdrCombo.Text <> '') and (qPDRQuery.active) Then
         begin
             MainQuery.ParamByName('id_pdr').AsInteger:= qPdrQuery.FieldByName('ID').AsInteger;
         end
          else MainQuery.ParamByName('id_pdr').AsInteger := 0;

         MainQuery.ParamByName('date_beg').AsString  := BegDateEdit.Text;
         MainQuery.ParamByName('date_end').AsString  := EndDateEdit.Text;
         MainQuery.ParamByName('type_zak').AsInteger := Type_Zak_ComboBox.ItemIndex;
         MainQuery.Open;

         i:=0;

     // формирование строк
     with Form.Editor.lines do
      begin

         clear;
         PrForm.Show;
         //цикл по количеству заказов
         While i< MainQuery.RecordCount do
         begin
            // вывод шапки отчета
            add( RepeatLine('-', 161));
            add( '');
            add( '');
            add( CentrLine('Форма по выполнению услуг цехом '+MainQuery.FieldByName('NAME_PDR').AsString, 161));
            add( CentrLine('За период с '+BegDateEdit.Text+' по '+EndDateEdit.Text, 161));
            add( CentrLine(Type_Zak_ComboBox.Items[Type_Zak_ComboBox.ItemIndex], 161));
            If  (CstCombo.Text <> '') and (qCSTQuery.active) Then
                 add( CentrLine(CstCombo.Text, 161));
            add( RepeatLine('-', 161));
            add( '  №  | № Заявки/№ Заказа | № Документа |    Код     |         Наименование         |    Факт    |  Материал  |  Запчасти  |   Ремонт   |Трудоемкость|Трудоемкость|');
            add( ' п.п.|                   |             | производ-  |                              |            |            |            |            |    факт    |    план    |');
            add( '     |                   |             |    ства    |                              |            |            |            |            |            |            |');
            add( RepeatLine('-', 161));

            PdrStr  := MainQuery.FieldByName('NAME_PDR').AsString;
            SumFakt := 0;
            SumMatr := 0;
            SumTime := 0;
            SumPlanTime := 0;
            SumAkt  := 0;
            SumNakl := 0;
            k:=1;

            //цикл по все заказам одного производства
            While (MainQuery.FieldByName('NAME_PDR').AsString = PdrStr) and
                  (not MainQuery.Eof)do
            begin

               PrForm.ProgressBar.Position:=(i+1)*100 div MainQuery.RecordCount;

               MtrfQuery.Close;
               MtrfQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID_ORDER').AsInteger;
               MtrfQuery.Open;

               sstr  := '';
               sstr  :=  RightLine(IntToStr(k), 5)
                       + ' '
                       + RightLine(MainQuery.FieldByName('NUMBER_RQST').AsString
                       + '/'
                       + MainQuery.FieldByName('NUMBER_ORDER').AsString, 19)
                       + ' '
                       + RightLine(MainQuery.FieldByName('NUMDOC').AsString, 13)
                       + ' '
                       + RightLine(MainQuery.FieldByName('CODE_CST').AsString, 12)
                       + ' '
                       + LeftLine(MainQuery.FieldByName('NAME_CHRT').AsString, 30)
                       + ' '
                       + RightLine(FormatFloat( '0.00', MainQuery.FieldByName('NVALUE').AsFloat), 12)
                       + ' '
                       + RightLine(FormatFloat( '0.00', MtrfQuery.FieldByName('Matr').AsFloat), 12)
                       + ' ';


               //сумма по накладным (изготовление)
               AktQuery.Close;
               AktQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID_ORDER').AsInteger;
               AktQuery.ParamByName('vid').AsInteger:=0;
               AktQuery.Open;
               sstr    := sstr
                         + RightLine(FormatFloat( '0.00', AktQuery.FieldByName('Price').AsFloat), 12)
                         + ' ';
               SumNakl := SumNakl
                         + AktQuery.FieldByName('Price').AsFloat;

               //сумма по актам (ремонт)
               AktQuery.Close;
               AktQuery.ParamByName('id').AsInteger  := MainQuery.FieldByName('ID_ORDER').AsInteger;
               AktQuery.ParamByName('vid').AsInteger := 1;
               AktQuery.Open;
               sstr   := sstr
                         + RightLine(FormatFloat( '0.00', AktQuery.FieldByName('Price').AsFloat), 12)
                         + ' ';
               SumAkt := SumAkt
                         + AktQuery.FieldByName('Price').AsFloat;

               //сумма по времени по факту
               TimeQuery.Close;
               TimeQuery.ParamByName('id').AsInteger := MainQuery.FieldByName('ID_ORDER').AsInteger;
               TimeQuery.Open;
               sstr:=sstr+RightLine(FormatFloat('0.000', TimeQuery.FieldByName('nTime').AsFloat*
                                                         TimeQuery.FieldByName('NUMBER_F').AsInteger), 12) + ' ';

               //сумма по времени по плану
               TimePlanQuery.Close;
               TimePlanQuery.ParamByName('id').AsInteger := MainQuery.FieldByName('ID_ORDER').AsInteger;
               TimePlanQuery.Open;
               sstr:=sstr+RightLine(FormatFloat('0.000', TimePlanQuery.FieldByName('nTime').AsFloat*
                                                         TimePlanQuery.FieldByName('NUMBER_F').AsInteger), 12);

               SumFakt  := SumFakt
                         + MainQuery.FieldByName('NVALUE').AsFloat;
               SumMatr  := SumMatr
                         + MtrfQuery.FieldByName('Matr').AsFloat;
               SumTime  := SumTime
                         + TimeQuery.FieldByName('nTime').AsFloat*
                           TimeQuery.FieldByName('NUMBER_F').AsInteger;
               SumPlanTime := SumPlanTime
                         + TimePlanQuery.FieldByName('nTime').AsFloat*
                           TimePlanQuery.FieldByName('NUMBER_F').AsInteger;
               Try
                   add( sstr);
               except
                    MessageDlg('Не хватает памяти для вывода отчета!', mtWarning , [mbYes], 0);
               end;



               MainQuery.Next;
               i:=i+1;
               k:=k+1;

            end;
            add(RepeatLine('-', 161));
            add(RepeatLine(' ', 53)+'ИТОГО'+RepeatLine(' ', 26)+
                       RightLine(FormatFloat( '0.00', SumFakt), 12)+' '+
                       RightLine(FormatFloat( '0.00', SumMatr), 12)+' '+
                       RightLine(FormatFloat( '0.00', SumNakl), 12)+' '+
                       RightLine(FormatFloat( '0.00', SumAkt), 12) +' '+
                       RightLine(FormatFloat( '0.00', SumTime), 12)+' '+
                       RightLine(FormatFloat( '0.00', SumPlanTime), 12));

            add('');
            add('');
            add(' Мастер участка _______________________________ ');
            add('');
            add('');
            add('    Нормировщик _______________________________ ');
            add('');
            add('');
            add('      Экономист _______________________________ ');
            add('');
            add('');
            add('');
            add(CHR(12));
         end;
     end;


  PrForm.Destroy;


  Form.Caption := 'Отчет по выполненным работам';
  Form.Editor.show;
  Form.show;




end;



procedure TReport9Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  RadioButton1.Font.Style := [fsBold];
  RadioButton1.Checked := True;  
  RadioButton2.Font.Style := [];

end;

procedure TReport9Form.CancelButtonClick(Sender: TObject);
begin
  close;
end;

procedure TReport9Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport9Form.RadioButton1Click(Sender: TObject);
begin
  RadioButton1.Font.Style := [fsBold];
  RadioButton2.Font.Style := [];

end;

procedure TReport9Form.RadioButton2Click(Sender: TObject);
begin
  RadioButton1.Font.Style := [];
  RadioButton2.Font.Style := [fsBold];

end;

procedure TReport9Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
