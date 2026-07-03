{***************************************************************
 *
 * Unit Name: Rep11
 * Purpose  :
 *    Форма отчета
 *    Отчет по выполненным услугам
 * Author   : Косицын Дмитрий, Соколов Владислав
 * History  : 2004
 *
 ****************************************************************}

unit Rep11;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ToolEdit, Mask, EnumForm4Sel, ExtCtrls;

type
  TReport11Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label4: TLabel;
    EndDateEdit: TDateEdit;
    PDRCombo: TComboEdit;
    Label3: TLabel;
    Label5: TLabel;
    CSTCombo: TComboEdit;
    qPDRQuery: TQuery;
    qCSTQuery: TQuery;
    OKButton: TButton;
    CancelButton: TButton;
    MainQuery: TQuery;
    MtrfQuery: TQuery;
    AktQuery: TQuery;
    RadioGroup1: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    SelPeriod: TButton;
    procedure OKButtonClick(Sender: TObject);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CSTComboButtonClick(Sender: TObject);
    procedure CSTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure SelPeriodClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LISTForm : TLIST_4SELECTForm;
  end;

var
  Report11Form: TReport11Form;

implementation

uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;


{$R *.DFM}

procedure TReport11Form.OKButtonClick(Sender: TObject);
Var

sstr    : String;
CstStr  : String;
SumFakt : Real;
SumMatr : Real;
SumNakl : Real;
SumAkt  : Real;
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
         MainQuery.SQL.Add('Select * From REPORT_11_PROCEDURE(:Dok, :date_beg, :date_end, :id_pdr, :id_cst)');
         MainQuery.ParamByName('dok').AsInteger := 1;
   end
    else
    begin
         MainQuery.Close;
         MainQuery.SQL.Clear;
         MainQuery.SQL.Add('Select * From REPORT_11_PROCEDURE(:Dok, :date_beg, :date_end, :id_pdr, :id_cst)');
         MainQuery.ParamByName('dok').AsInteger := 0;

         {MainQuery.SQL.Add('Select a.CODE, g.NAME, Sum(d.NVALUE) As Fakt,');
         MainQuery.SQL.Add('f.NAME, b.ID, g.VID_CHRT, ');
         MainQuery.SQL.Add('c.NUMBER, b.NUMBER, k.NUMDOC');
         MainQuery.SQL.Add('From Spr_Pdr a, DH_Order b, DH_Rqst c, ');
         MainQuery.SQL.Add('DT_Order3 d, Spr_Cst f, Spr_Chrt g, ');
         MainQuery.SQL.Add('DT_RS h, DH_RS k');
         MainQuery.SQL.Add('Where k.DATE_IN>=:date_beg and ');
         MainQuery.SQL.Add('k.DATE_IN<=:date_end and  ');
         MainQuery.SQL.Add('d.ID_RQST = b.ID and d.ID_CALC = 10 and  ');
         MainQuery.SQL.Add('c.ID = b.ID_RQST and a.ID = b.ID_PDR and ');
         MainQuery.SQL.Add('f.ID = c.ID_CST and g.ID = b.ID_CHRT and ');
         MainQuery.SQL.Add('h.ID_ORD = b.ID and k.ID = h.ID_RSMTR    ');
         MainQuery.SQL.Add('Group by a.CODE, g.NAME, f.NAME, b.ID, g.VID_CHRT, ');
         MainQuery.SQL.Add('c.NUMBER, b.NUMBER, k.NUMDOC');
         MainQuery.SQL.Add('Order by 4,1,9');}
    end;

   If (CstCombo.Text  <> '') and (qCSTQuery.active) Then
   begin
       MainQuery.ParamByName('id_cst').AsInteger := qCstQuery.FieldByName('ID').AsInteger;
   end
    else MainQuery.ParamByName('id_cst').AsInteger := 0;

   If (PdrCombo.Text <> '') and (qPDRQuery.active) Then
   begin
       MainQuery.ParamByName('id_pdr').AsInteger:= qPdrQuery.FieldByName('ID').AsInteger;
   end
    else MainQuery.ParamByName('id_pdr').AsInteger := 0;

   MainQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
   MainQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
   MainQuery.Open;

   i:=0;
   PrForm.Show;

     // формирование строк
   with Form.Editor.lines do
    begin

         clear;


         //цикл по количеству заказов
         While i< MainQuery.RecordCount do
         begin
            // вывод шапки отчета
            add( RepeatLine('-', 136));
            add( '');
            add( '');
            add( CentrLine('Форма по выполнению плана для '+MainQuery.FieldByName('NAME_Cst').AsString, 136));
            add( CentrLine('За период с '+BegDateEdit.Text+' по '+EndDateEdit.Text, 136));

            If (PdrCombo.Text <> '') and (qPDRQUery.active) Then
                 add( CentrLine(PdrCombo.Text, 136));


            add( RepeatLine('-', 136));
            add( '  №  | № Заявки/№ Заказа | № Документа |    Код     |         Наименование         |    Факт    |  Материал  |  Запчасти  |   Ремонт   |');
            add( ' п.п.|                   |             | производ-  |                              |            |            |            |            |');
            add( '     |                   |             |    ства    |                              |            |            |            |            |');
            add( RepeatLine('-', 136));

            CstStr:=MainQuery.FieldByName('NAME_CST').AsString;
            SumFakt:=0;
            SumMatr:=0;
            SumNakl:=0;
            SumAkt :=0;
            k:=1;

            //цикл по все заказам одного производства
            While (MainQuery.FieldByName('NAME_CST').AsString = CstStr) and
                  (not MainQuery.Eof)do
            begin

               PrForm.ProgressBar.Position:=(i+1)*100 div MainQuery.RecordCount;
               MtrfQuery.Close;
               MtrfQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID_Order').AsInteger;
               MtrfQuery.Open;

               sstr := '';
               sstr :=  RightLine(IntToStr(k), 5)
                      + ' '
                      + RightLine(MainQuery.FieldByName('NUMBER_RQST').AsString
                      + '/'
                      + MainQuery.FieldByName('NUMBER_Order').AsString, 19)
                      + ' '
                      + RightLine(MainQuery.FieldByName('NUMDOC').AsString, 13)
                      + ' '
                      + RightLine(MainQuery.FieldByName('CODE_Pdr').AsString, 12)
                      + ' '
                      + LeftLine(MainQuery.FieldByName('NAME_Chrt').AsString, 30)
                      + ' '
                      + RightLine(FormatFloat( '0.00', MainQuery.FieldByName('Nvalue').AsFloat), 12)
                      + ' '
                      + RightLine(FormatFloat( '0.00', MtrfQuery.FieldByName('Matr').AsFloat), 12)
                      + ' ';


               //сумма по накладным (изготовление)
               AktQuery.Close;
               AktQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID_Order').AsInteger;
               AktQuery.ParamByName('vid').AsInteger:=0;
               AktQuery.Open;
               sstr    := sstr
                         + RightLine(FormatFloat( '0.00', AktQuery.FieldByName('Price').AsFloat), 12)
                         + ' ';
               SumNakl := SumNakl
                         + AktQuery.FieldByName('Price').AsFloat;

               //сумма по актам (ремонт)
               AktQuery.Close;
               AktQuery.ParamByName('id').AsInteger  := MainQuery.FieldByName('ID_Order').AsInteger;
               AktQuery.ParamByName('vid').AsInteger := 1;
               AktQuery.Open;
               sstr   := sstr
                         + RightLine(FormatFloat( '0.00', AktQuery.FieldByName('Price').AsFloat), 12);
               SumAkt := SumAkt
                         + AktQuery.FieldByName('Price').AsFloat;

               SumFakt  := SumFakt + MainQuery.FieldByName('NValue').AsFloat;
               SumMatr  := SumMatr + MtrfQuery.FieldByName('Matr').AsFloat;

               Try
                   add( sstr);
               except
                    MessageDlg('Не хватает памяти для выввода отчета!', mtWarning , [mbYes], 0);
               end;

               MainQuery.Next;
               i:=i+1;
               k:=k+1;
            end;
            add(RepeatLine('-', 136));
            add(RepeatLine(' ', 53)+'ИТОГО'+RepeatLine(' ', 26)+
                       RightLine(FormatFloat( '0.00', SumFakt), 12)+' '+
                       RightLine(FormatFloat( '0.00', SumMatr), 12)+' '+
                       RightLine(FormatFloat( '0.00', SumNakl), 12)+' '+
                       RightLine(FormatFloat( '0.00', SumAkt), 12));

            add( '');
            add( '');
         end;


    end;

  PrForm.Destroy;

  Form.Caption := 'Отчет по оказанным услугам';
  Form.Editor.show;
  Form.show;




end;

procedure TReport11Form.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPDRQuery, PDRCombo, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);



end;

procedure TReport11Form.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPDRQuery, PDRCombo, key, Shift, 1) = false then
    PDRComboButtonClick(Sender);


end;

procedure TReport11Form.CSTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qCSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);



end;

procedure TReport11Form.CSTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qCSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);


end;

procedure TReport11Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  RadioButton1.Font.Style := [fsBold];
  RadioButton1.Checked := True;  
  RadioButton2.Font.Style := [];
  ListForm := TLIST_4SELECTForm.create(self);

end;

procedure TReport11Form.CancelButtonClick(Sender: TObject);
begin
  close;
end;

procedure TReport11Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport11Form.RadioButton1Click(Sender: TObject);
begin
  RadioButton1.Font.Style := [fsBold];
  RadioButton2.Font.Style := [];
end;

procedure TReport11Form.RadioButton2Click(Sender: TObject);
begin
  RadioButton1.Font.Style := [];
  RadioButton2.Font.Style := [fsBold];
end;

procedure TReport11Form.SelPeriodClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);



end;

end.
