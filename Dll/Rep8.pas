{***************************************************************
 *
 * Модуль   : Rep8
 * Описание : Реестр документов
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep8;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Mask, ToolEdit, EnumForm4Sel;

type
  TReport8Form = class(TForm)
    Label1: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    RollComboBox: TComboBox;
    EndDateEdit: TDateEdit;
    Label3: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    Label4: TLabel;
    Query: TQuery;
    PDRCombo: TComboEdit;
    Label5: TLabel;
    qPDRQuery: TQuery;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ButtonSelPer: TButton;
    ViewCheckBox: TCheckBox;
    Label6: TLabel;
    CstCombo: TComboEdit;
    qCstQuery: TQuery;
    WrhsCombo: TComboEdit;
    Label7: TLabel;
    qWrhsQuery: TQuery;
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WrhsComboButtonClick(Sender: TObject);
    procedure WrhsComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;

  end;

var
  Report8Form: TReport8Form;

implementation

uses PrintFrm, printlibs, Libs, PrintProces, GetPeriods, PrintAct;


{$R *.DFM}
{

       Процедура формирования отчета



}
procedure TReport8Form.OKButtonClick(Sender: TObject);
Var

sstr   : String;
  i    : Integer;
 IdPdr : String;
 Total : Real;
 Total_Pdr : Real;
   Total_i : Integer;

  Form : TShowPrintForm;
  PrForm : TProcessForm;

begin
       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       IdPdr:='';
       Total := 0;
       Total_i := 0;
       Total_Pdr := 0;

       If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

        Query.Close;
        Query.SQL.Clear;
        Query.SQL.Add('Select * From REPORT_8_PROCEDURE(:DATE_BEG, ');
        Query.SQL.Add(':DATE_END, :ID_PDR, :ID_CST, :ID_WRHS, :TYPE_DOC, :INVOICE)');
        Query.SQL.Add('Order by CODE_PDR, NUMDOC, DATE_IN');


{        If RadioButton1.Checked = True Then
        begin
          If  RollComboBox.ItemIndex = 2 then //'Приемо-сдаточный накладные'
          begin
              Query.SQL.Add('Select 3 as TYPE_DOC, b.NUMDOC, b.DATE_IN, ');
              Query.SQL.Add('g.CODE, g.NAME, Sum(c.nsum) As Nsum');
              Query.SQL.Add('From Spr_NMNT a, DH_PR b, DT_PR c, DH_ORDER d, ');
              Query.SQL.Add('DH_RQST f, Spr_Pdr g ');
              Query.SQL.Add('Where b.DATE_IN>=:date_beg and');
              Query.SQL.Add('b.DATE_IN<=:date_end and');
              Query.SQL.Add('c.ID_PRMTR = b.ID and d.ID = c.ID_ORD and ');
              Query.SQL.Add('f.ID = d.ID_RQST and a.ID = c.ID_NMNT and ');
              Query.SQL.Add('g.ID = f.ID_PDR and b.PR_CHRT = 0 and ');
              Query.SQL.Add('b.PR_EXEC = 1 and ');
              Query.SQL.Add('b.PR_CHRT = 0 '); //вывожу только приемо-сдаточные документы по изготовлению
          end                                  //ремонт не выводится

           else
            begin

               Query.SQL.Add('Select a.VID_NOM, b.NUMDOC, b.DATE_IN, ');
               Query.SQL.Add('g.CODE, g.NAME, b.TYPE_DOC, Sum(c.nsum) As Nsum');
               Query.SQL.Add('From Spr_NMNT a, DH_RS b, DT_RS c, ');
               Query.SQL.Add('DH_ORDER d, DH_RQST f, Spr_Pdr g');
               Query.SQL.Add('Where b.DATE_IN>=:date_beg and ');
               Query.SQL.Add('b.DATE_IN<=:date_end and ');
               Query.SQL.Add('c.ID_RSMTR = b.ID and d.ID = c.ID_ORD ');
               Query.SQL.Add('and f.ID = d.ID_RQST and a.ID = c.ID_NMNT and ');
               Query.SQL.Add('g.ID = f.ID_PDR and');
               Query.SQL.Add('b.PR_EXEC = 1 ');

               if RollComboBox.ItemIndex = 0 Then  // Акты
                   Query.SQL.Add('and b.TYPE_DOC = 2')
               else  //Требования-накладные
                   Query.SQL.Add('and b.TYPE_DOC = 1');
            end;
        end
         else //Не подписаны
         begin
           If  RollComboBox.ItemIndex = 2 then //'Приемо-сдаточный накладные'
           begin
               Query.SQL.Add('Select 3 as TYPE_DOC, b.NUMDOC, b.DATE_IN, ');
               Query.SQL.Add('g.CODE, g.NAME, Sum(c.nsum)  As Nsum');
               Query.SQL.Add('From Spr_NMNT a, DH_PR b, DT_PR c, DH_ORDER d, ');
               Query.SQL.Add('DH_RQST f, Spr_Pdr g ');
               Query.SQL.Add('Where b.DATE_IN>=:date_beg and');
               Query.SQL.Add('b.DATE_IN<=:date_end and d.PR_EXEC = 3 and');
               Query.SQL.Add('c.ID_PRMTR = b.ID and d.ID = c.ID_ORD and ');
               Query.SQL.Add('f.ID = d.ID_RQST and a.ID = c.ID_NMNT and');
               Query.SQL.Add('g.ID = f.ID_PDR and');
               Query.SQL.Add('(b.PR_EXEC = 0 or b.PR_EXEC is Null) and ');
               Query.SQL.Add('b.PR_CHRT = 0 '); //вывожу только приемо-сдаточные документы по изготовлению
           end                                  //ремонт не выводится

            else
             begin

                Query.SQL.Add('Select a.VID_NOM, b.NUMDOC, b.DATE_IN, ');
                Query.SQL.Add('g.CODE, g.NAME, b.TYPE_DOC, Sum(c.nsum) As Nsum');
                Query.SQL.Add('From Spr_NMNT a, DH_RS b, DT_RS c, ');
                Query.SQL.Add('DH_ORDER d, DH_RQST f, Spr_Pdr g');
                Query.SQL.Add('Where b.DATE_IN>=:date_beg and ');
                Query.SQL.Add('b.DATE_IN<=:date_end and d.PR_EXEC = 3 and');
                Query.SQL.Add('c.ID_RSMTR = b.ID and d.ID = c.ID_ORD ');
                Query.SQL.Add('and f.ID = d.ID_RQST and a.ID = c.ID_NMNT and ');
                Query.SQL.Add('g.ID = f.ID_PDR and');
                Query.SQL.Add('(b.PR_EXEC = 0 or PR_EXEC is Null)');

                if RollComboBox.ItemIndex = 0 Then  // Акты
                    Query.SQL.Add('and b.TYPE_DOC = 2')
                else  //Требования-накладные
                    Query.SQL.Add('and b.TYPE_DOC = 1');
             end;
         end;

        If (PdrCombo.Text <> '') and (qPDRQUery.active) Then
        begin
             Query.SQL.Add('and f.ID_PDR = :pdr');
             Query.ParamByName('pdr').AsInteger:=qPdrQuery.FieldByName('ID').AsInteger;
        end;

        If (CstCombo.Text <> '') and (qCstQuery.active) Then
        begin
             Query.SQL.Add('and f.ID_CST = :cst');
             Query.ParamByName('cst').AsInteger:=qCstQuery.FieldByName('ID').AsInteger;
        end;


        If  RollComboBox.ItemIndex = 2 then
              Query.SQL.Add('Group by b.NUMDOC, b.DATE_IN, g.CODE, g.NAME')
         else
               Query.SQL.Add('Group by a.VID_NOM, b.NUMDOC, b.DATE_IN, g.CODE, g.NAME, b.TYPE_DOC');

        Query.SQL.Add('Order by 4, 2, 3');    }

        Query.ParamByName('DATE_BEG').AsString := BegDateEdit.Text;
        Query.ParamByName('DATE_END').AsString := EndDateEdit.Text;

        If (PdrCombo.Text <> '') and (qPDRQuery.active) Then
           Query.ParamByName('ID_PDR').AsInteger := qPdrQuery.FieldByName('ID').AsInteger
         else
            Query.ParamByName('ID_PDR').AsInteger := 0;

        If (CstCombo.Text <> '') and (qCstQuery.active) Then
           Query.ParamByName('ID_CST').AsInteger := qCstQuery.FieldByName('ID').AsInteger
         else
            Query.ParamByName('ID_CST').AsInteger := 0;

        If (WrhsCombo.Text <> '') and (qWrhsQuery.active) Then
           Query.ParamByName('ID_WRHS').AsInteger := qWrhsQuery.FieldByName('ID').AsInteger
         else
           Query.ParamByName('ID_WRHS').AsInteger := 0;


        If RadioButton1.Checked = True Then
           Query.ParamByName('TYPE_DOC').AsInteger := 0
         else
            Query.ParamByName('TYPE_DOC').AsInteger := 1;

        if RollComboBox.ItemIndex = 0 Then  // Акты
             Query.ParamByName('INVOICE').AsInteger := 0;
        if RollComboBox.ItemIndex = 1 Then  //Требования-накладные
             Query.ParamByName('INVOICE').AsInteger := 1;
        if RollComboBox.ItemIndex = 2 Then  //Требования-накладные
             Query.ParamByName('INVOICE').AsInteger := 2;

        Query.Open;

        If Query.Eof Then
             MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);


       // формирование строк
     with Form.Editor.lines do
      begin

         clear;

         // вывод шапки отчета
         add( RepeatLine('-', 102));
         add( '');
         add( CentrLine(GetSystemParams('Enterprise'),30)
           + RightLine(' В бухгалтерию '
           + GetSystemParams('Enterprise'),45 ));
         add( CentrLine('РМП',30));
         add( RepeatLine('_',30));
         add( CentrLine('структурное подразделение',30));

         While (not Query.Eof) do
         begin

           add( '');
           add( '');
           add( CentrLine('Реестр документов',102));
           add( CentrLine('за период с '+BegDateEdit.Text+ ' по '+EndDateEdit.Text ,102));
           add( '');

           add(' по подразделению: ('+
                Query.FieldByName('CODE_PDR').AsString+') '+
                Query.FieldByName('NAME_PDR').AsString);

           If (CstCombo.Text <> '') and (qCstQuery.active) Then
           begin
               add(' для заказчика: ('+qCstQuery.FieldByName('CODE').AsString+') '+
                  qCstQuery.FieldByName('NAME').AsString);
           end;       

           add( RepeatLine('-', 102));
           add( '№ п.п.|№ документа|  Наименование документа  |   Дата   |        Склад       |      Примечания ');
           add( '      |           |                          |документа |                    |                 ');
           add( '      |           |                          |          |                    |                 ');

           add( RepeatLine('-', 102));

           IdPdr:=Query.FieldByName('CODE_PDR').AsString;

           Total_Pdr := 0;
           i := 0;
           PrForm.Show;

           //цикл по количеству заказов
           While (IdPdr=Query.FieldByName('CODE_PDR').AsString) and
                 (not Query.Eof) do
           begin
               sstr := '';

               PrForm.ProgressBar.Position:=(i+1)*100 div Query.RecordCount;

               sstr := RightLine(IntToStr(i+1),6)
                     + ' '
                     + CentrLine(Query.FieldByName('NUMDOC').AsString, 11)
                     + ' ';

               case Query.FieldByName('DOC_TYPE').AsInteger of
                      2: sstr := sstr
                               + CentrLine('Акт',26)
                               + ' ';
                      1: sstr := sstr
                               + CentrLine('Требование-накладная',26)
                               + ' ';
                      3: sstr := sstr
                               + CentrLine('Приемо-сдаточная накладная',26)
                               + ' ';

               end;
               sstr := sstr
                     + CentrLine(Query.FieldByName('DATE_IN').AsString, 10)+' ';

               sstr := sstr + LeftLine(Query.FieldByName('NAME_WRHS').AsString, 20)+' ';

               If ViewCheckBox.Checked = True Then
               begin
                    sstr := sstr + RightLine(FormatFloat('0.00', Query.FieldByName('SUM_DOC').AsFloat), 12);
                    Total_Pdr := Total_Pdr + Query.FieldByName('SUM_DOC').AsFloat;
               end;

               add( sstr);

               Query.Next;
               i := i + 1;

           end;

           Total_i := Total_i + i;
           add( RepeatLine('-', 102));
           If ViewCheckBox.Checked = True Then
           begin
              Total:=Total+Total_Pdr;
              add( RepeatLine(' ', 70)+'Итого: '+RightLine(FormatFloat('0.00', Total_Pdr), 13));
           end;

         end;

//         add( RepeatLine('-', 82));
         If ViewCheckBox.Checked = True Then
         begin

           add( '');
           add( '');
           add( RepeatLine('*', 102));
           add( RepeatLine(' ', 70)+'Всего: '+RightLine(FormatFloat('0.00', Total), 13));
           add( '');
           add( '');
         end;
         add( '');
         add( 'Итого документов:'+RepeatLine('_',10)+PrintActForm.float2words(Total_i, 1)+RepeatLine('_',10));
         add( '');
         add( '');
         add( 'Документы по реестру сдал зав. складом:____________________подпись');
         add( '');
         add( '');
         add( '"    "__________________200   г.');
         add( '');
         add( '');
         add( 'Документы по реестру принял ст. бухгалтер:_________________подпись');
         add( '');
         add( '');
         add( '"    "__________________200   г.');

  end;

  PrForm.Destroy;


  Form.Caption := 'Реестр документов';
  Form.Editor.Show;
  Form.show;


end;

procedure TReport8Form.CancelButtonClick(Sender: TObject);
begin
  close;
end;

procedure TReport8Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ListForm := TLIST_4SELECTForm.create(self);
  RollComboBox.ItemIndex:=0;

end;

procedure TReport8Form.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPDRQuery, PDRCombo, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);

end;

procedure TReport8Form.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPDRQuery, PDRCombo, key, Shift, 1) = false then
    PDRComboButtonClick(Sender);

end;

procedure TReport8Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport8Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport8Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qCstQuery, CstCombo, 'select id, code, name from spr_cst',
                        'Справочник: Заказчики (Выбор)', 0);
end;

procedure TReport8Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qCstQuery, CstCombo, key, Shift, 1) = false then
    CstComboButtonClick(Sender);
end;

procedure TReport8Form.WrhsComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qWrhsQuery, WrhsCombo, 'select id, code, name from spr_wrhs',
                        'Справочник: Склады(Выбор)', 0);
end;

procedure TReport8Form.WrhsComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qWrhsQuery, WrhsCombo, key, Shift, 1) = false then
    CstComboButtonClick(Sender);
end;

end.
