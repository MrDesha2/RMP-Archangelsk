unit Rep55;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, ToolEdit, Mask, ExtCtrls, EnumForm4Sel;

type
  TReport55Form = class(TForm)
    Label4: TLabel;
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    MainQuery: TQuery;
    CstQuery: TQuery;
    PdrQuery: TQuery;
    ButtonOK: TButton;
    ButtonNO: TButton;
    RadioGroup1: TRadioGroup;
    CompactRadioButton: TRadioButton;
    FullRadioButton: TRadioButton;
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonNOClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report55Form: TReport55Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport55Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);
end;

procedure TReport55Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport55Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport55Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport55Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport55Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport55Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport55Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport55Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       sCode_Cst_Parent : String;
       sCode_Cst : String;
       sCode_Pdr : String;
       n, i : Integer;
       sstr : String;
       Total_l : Integer;
       Total_h : Real;
       Total_p : Real;
       Total_tot_l : Integer;
       Total_tot_h : Real;
       Total_tot_p : Real;
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
       MainQuery.SQL.Add('Select * From REPORT_55_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_CST, :ID_PDR, :SHORT)');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (CstCombo.Text = '') or (CstCombo.Text = '<Объект не найден>') or (not CstQuery.active) Then
            MainQuery.ParamByName('ID_CST').AsInteger := -1
        else
               MainQuery.ParamByName('ID_CST').AsInteger := CstQuery.Fields[0].AsInteger;

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('ID_PDR').AsInteger := -1
        else
               MainQuery.ParamByName('ID_PDR').AsInteger := PdrQuery.Fields[0].AsInteger;

       If CompactRadioButton.Checked = True Then
           MainQuery.ParamByName('SHORT').AsInteger := 1
        else
             MainQuery.ParamByName('SHORT').AsInteger := 0;

       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

       If MainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       // формирование строк
       with Form.Editor.lines do
       begin

         clear;

         If (CompactRadioButton.Checked = True) Then
         begin
             n := 54;
             sstr := '';
             sCode_Pdr := '';
             Total_l := 0;
             Total_h := 0;
             Total_p := 0;

             //цикл по количеству заказов
             While (not MainQuery.Eof) do
             begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 add(RepeatLine('-', n));
                 add('');
                 add(CentrLine('Учёт трудоёмкости неплановых работ', n));

                 If not((PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active)) Then
                    add(CentrLine('по производству '+'('+PdrQuery.FieldByName('Code').AsString + ') '+
                        PdrQuery.FieldByName('Name').AsString,n));

                 add(CentrLine('выполненных c '+BegDateEdit.Text+' по '+EndDateEdit.Text, n));

                 if (MainQuery.FieldByName('Code_Cst_Parent').AsString = '') Then
                    add(CentrLine('для '+'('+MainQuery.FieldByName('Code_Cst').AsString + ') '+
                          MainQuery.FieldByName('Name_Cst').AsString, n))
                  else
                     add(CentrLine('по производству '+'('+MainQuery.FieldByName('Code_Cst_Parent').AsString + ') '+
                     MainQuery.FieldByName('Name_Cst_Parent').AsString,n));
                 add('');

                 add(RepeatLine('-', n));
                 add('|               |  Трудоёмкость выполненных заказов  |');
                 add('|  Лимит с/час  |------------------------------------|');
                 add('|               |      с/час       |        %        |');
                 add(RepeatLine('-', n));

                 If (MainQuery.FieldByName('Quota_Cst').AsString = '') Then
                     sstr := sstr + ' ' + RightLine('-', 15)+ ' '
                  else
                   begin
                        sstr := sstr + ' ' + RightLine(MainQuery.FieldByName('Quota_Cst').AsString, 15)+' ';
                        Total_l := MainQuery.FieldByName('Quota_Cst').AsInteger;
                   end;

                 sCode_Cst := Trim(MainQuery.FieldByName('Code_Cst_Parent').AsString);

                 While (sCode_Cst = Trim(MainQuery.FieldByName('Code_Cst_Parent').AsString)) and
                       (not MainQuery.Eof) do
                 begin

                   Total_h := Total_h + MainQuery.FieldByName('Sum_nTime').AsFloat;

                   MainQuery.Next;
                   i:=i+1;

                 end;

                 sstr := sstr + RightLine(FormatFloat('0.00',Total_h), 18)+' ';

                 If (Total_l > 0) Then
                     sstr := sstr + RightLine(FormatFloat('0.00', Total_h*100/Total_l), 17)+' '
                  else sstr := sstr + RightLine('-', 17) + ' ';

                 add(sstr);
                 sstr :='';

//                 add(RepeatLine('-', n));
//                 add(RightLine('Итого',36) + ' ' + RightLine(FormatFloat('0.00', Total_l), 15) + ' '+
//                     RightLine(FormatFloat('0.00', Total_h), 16) + ' ' + RightLine(FormatFloat('0.00', Total_p), 15));

                 Total_l := 0;
                 Total_h := 0;
                 Total_p := 0;

             end;

             add(RepeatLine('-', n));
             add('');
             add('');
             PrForm.Destroy;

             Form.Caption := 'Учёт трудоёмкости неплановых работ';
             Form.Editor.show;
             Form.show;

         end
          else
           begin

             n := 158;
             sstr := '';
             sCode_Pdr := '';

             Total_l := 0;
             Total_h := 0;
             Total_p := 0;

             Total_tot_l := 0;
             Total_tot_h := 0;
             Total_tot_p := 0;

             //цикл по количеству заказов
             While (not MainQuery.Eof) do
             begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 add(RepeatLine('-', n));
                 add('');
                 add(CentrLine('Учёт трудоёмкости неплановых работ', n));

                 If not((PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active)) Then
                    add(CentrLine('по производству '+'('+PdrQuery.FieldByName('Code').AsString + ') '+
                        PdrQuery.FieldByName('Name').AsString,n));

                 add(CentrLine('выполненных c '+BegDateEdit.Text+' по '+EndDateEdit.Text, n));

                 if (MainQuery.FieldByName('Code_Cst_Parent').AsString = '') Then
                    add(CentrLine('для '+'('+MainQuery.FieldByName('Code_Cst').AsString + ') '+
                          MainQuery.FieldByName('Name_Cst').AsString, n))
                  else
                     add(CentrLine('по производству '+'('+MainQuery.FieldByName('Code_Cst_Parent').AsString + ') '+
                     MainQuery.FieldByName('Name_Cst_Parent').AsString,n));
                 add('');

                 add(RepeatLine('-', n));
                 add('                   |                                    |                                                    |               |Трудоёмкость выполненных заказов|');
                 add('   Заявка/Заказ    |              Заказчик              |             (Код) Наименование чертежа             |  Лимит с/час  |--------------------------------|');
                 add('                   |                                    |                                                    |               |     с/час      |       %       |');
                 add(RepeatLine('-', n));

                 sCode_Cst_Parent := Trim(MainQuery.FieldByName('Code_Cst_Parent').AsString);

                 While (sCode_Cst_Parent = Trim(MainQuery.FieldByName('Code_Cst_Parent').AsString)) and
                       (not MainQuery.Eof) do
                 begin

                    sCode_Cst := Trim(MainQuery.FieldByName('Code_Cst').AsString);

                    While (sCode_Cst = Trim(MainQuery.FieldByName('Code_Cst').AsString)) and
                          (not MainQuery.Eof) do
                    begin


                       sstr := sstr + RightLine(MainQuery.FieldByName('Number_Rqst').AsString + '/'+ MainQuery.FieldByName('Number_Order').AsString, 19)+' '+
                                      LeftLine('('+MainQuery.FieldByName('Code_Cst').AsString + ') '+MainQuery.FieldByName('Name_Cst').AsString, 36)+' '+
                                      LeftLine('('+MainQuery.FieldByName('Code_Chrt').AsString + ') '+MainQuery.FieldByName('Name_Chrt').AsString,52);

                       If (MainQuery.FieldByName('Quota_Cst').AsString = '') Then
                           sstr := sstr + RightLine('-', 15)+ ' '
                        else
                         begin
                            sstr := sstr + RightLine(MainQuery.FieldByName('Quota_Cst').AsString, 15)+' ';
                            Total_l := MainQuery.FieldByName('Quota_Cst').AsInteger;
                         end;

                       sstr := sstr + RightLine(FormatFloat('0.00', MainQuery.FieldByName('Sum_nTime').AsFloat), 16)+' ';
                       Total_h := Total_h + MainQuery.FieldByName('Sum_nTime').AsFloat;

                       If (MainQuery.FieldByName('Quota_Cst').AsFloat > 0) Then
                       begin
                             sstr := sstr +
                                RightLine(FormatFloat('0.00', MainQuery.FieldByName('Sum_nTime').AsFloat*100/MainQuery.FieldByName('Quota_Cst').AsFloat), 15)+' ';
                             Total_p := Total_p + MainQuery.FieldByName('Sum_nTime').AsFloat*100/MainQuery.FieldByName('Quota_Cst').AsFloat;
                       end
                        else sstr := sstr + RightLine('-', 15) + ' ';

                       MainQuery.Next;
                       i:=i+1;
                       add(sstr);
                       sstr :='';
                    end;

                     add(RepeatLine('-', n));
                     add(RightLine('Итого',108) + ' ' + RightLine(IntToStr(Total_l), 15) + ' '+
                         RightLine(FormatFloat('0.00', Total_h), 16) + ' ' + RightLine(FormatFloat('0.00', Total_p), 15));
                     add(' ');

                     Total_tot_l := Total_tot_l + Total_l;
                     Total_tot_h := Total_tot_h + Total_h;
                     Total_tot_p := Total_tot_p + Total_p;

                     Total_l := 0;
                     Total_h := 0;
                     Total_p := 0;

                 end;

                     add(RepeatLine('=', n));
                     add(RightLine('Всего',108) + ' ' + RightLine(IntToStr(Total_tot_l), 15) + ' '+
                         RightLine(FormatFloat('0.00', Total_tot_h), 16) + ' ' + RightLine(FormatFloat('0.00', Total_tot_p), 15));

                     Total_tot_l := 0;
                     Total_tot_h := 0;
                     Total_tot_p := 0;
             end;

             add(RepeatLine('-', n));
             add('');
             PrForm.Destroy;

             Form.Caption := 'Учёт трудоёмкости неплановых работ';
             Form.Editor.show;
             Form.show;


           end;
       end;
end;

end.

