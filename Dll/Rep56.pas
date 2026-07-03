unit Rep56;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, ExtCtrls, ToolEdit, Mask, EnumForm4Sel;

type
  TReport56Form = class(TForm)
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
    ButtonOK: TButton;
    ButtonNO: TButton;
    MainQuery: TQuery;
    CstQuery: TQuery;
    PdrQuery: TQuery;
    ComboBoxFlag: TComboBox;
    Label7: TLabel;
    ComboBoxSelection: TComboBox;
    Label8: TLabel;
    RadioGroup1: TRadioGroup;
    FullRadioButton: TRadioButton;
    CompactRadioButton: TRadioButton;
    procedure ButtonSelPerClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CstComboButtonClick(Sender: TObject);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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
  Report56Form: TReport56Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport56Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport56Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport56Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);
end;

procedure TReport56Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport56Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport56Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport56Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport56Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport56Form.ButtonOKClick(Sender: TObject);
Var    Form         : TShowPrintForm;
       PrForm       : TProcessForm;
       sstr         : String;
       sCode_Cst    : String;
       Total_sum    : Real;
       AllTotal_sum : Real;
       i,n,k:   Integer;
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
       MainQuery.SQL.Add('Select * From REPORT_56_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_CST, :ID_PDR, :FLAG, :SELECTION)');
       MainQuery.SQL.Add('Group By NUMBER_RQST, NUMBER_ORDER,');
       MainQuery.SQL.Add('         CODE_CST, NAME_CST, CODE_CST_PARENT,');
       MainQuery.SQL.Add('         NAME_CST_PARENT, CODE_PDR, NAME_PDR,');
       MainQuery.SQL.Add('         CODE_CHRT, NAME_CHRT, SUM_NTIME');
       MainQuery.SQL.Add('Order by CODE_CST_PARENT, NAME_CST, CODE_PDR, NUMBER_RQST, NUMBER_ORDER');

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

       If (ComboBoxFlag.ItemIndex = 0) Then MainQuery.ParamByName('FLAG').AsInteger := -1
        else MainQuery.ParamByName('FLAG').AsInteger := ComboBoxFlag.ItemIndex - 1;  //счёт начинается с 0 (выполненные заказы)

       //если ничего не выбрано
       MainQuery.ParamByName('SELECTION').AsInteger := ComboBoxSelection.ItemIndex;

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

             n := 135;
             i := 1;
             k := 1;
             sstr := '';
             sCode_Cst := '';
             Total_sum := 0;
             AllTotal_sum := 0;

             add(RepeatLine('-', n));
             add('');
             add(CentrLine('Отчёт по трудоёмкости работ выплненных', n));
             add(CentrLine('ЦМО, для смежных участков РМП', n));
             add(CentrLine('выполненных c '+BegDateEdit.Text+' по '+EndDateEdit.Text, n));

             add('');

             add(RepeatLine('-', n));
             If (FullRadioButton.Checked = True) Then
             begin
                add('|  №  | №Заявки/№Заказа |        Заказчик        | Ответственный участок  |           Наименование работ           |Трудоёмкость работ|');
                add('| п.п.|                 |                        |                        |                                        |(30-20)ЦМО,в часах|');
             end
              else
              begin
                 add('|  №  |                 Заказчик                 |                      Ответственный участок                      |Трудоёмкость работ|');
                 add('| п.п.|                                          |                                                                 |(30-20)ЦМО,в часах|');
              end;
             add(RepeatLine('-', n));

             //цикл по количеству заказов
             While (not MainQuery.Eof) do
             begin

                 sCode_Cst := Trim(MainQuery.FieldByName('NAME_CST_PARENT').AsString);

                 If (FullRadioButton.Checked = True) Then
                 begin
                    add('('+MainQuery.FieldByName('CODE_CST_PARENT').AsString+')'+
                         MainQuery.FieldByName('NAME_CST_PARENT').AsString);

                    k := 1;
                    add(RepeatLine('-', n));
                 end
                  else
                     sstr :='|'+RightLine(IntToStr(k)+'.', 5)+ '|'+
                            LeftLine('('+MainQuery.FieldByName('CODE_CST_PARENT').AsString+')'+
                                     MainQuery.FieldByName('NAME_CST_PARENT').AsString, 42)+'|';

                 While (sCode_Cst = Trim(MainQuery.FieldByName('NAME_CST_PARENT').AsString)) and
                       (not MainQuery.Eof) do
                 begin

                     PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                     If (FullRadioButton.Checked = True) Then
                     begin
                         sstr := '|'+RightLine(IntToStr(k)+'.', 5)+ '|'+
                                 RightLine(MainQuery.FieldByName('NUMBER_RQST').AsString+'/'+
                                           MainQuery.FieldByName('NUMBER_ORDER').AsString, 17)+ '|' +
                                 LeftLine(MainQuery.FieldByName('NAME_CST').AsString, 24)+ '|' +
                                 LeftLine('('+MainQuery.FieldByName('CODE_PDR').AsString+')'+
                                          MainQuery.FieldByName('NAME_PDR').AsString , 24)+ '|' +
                                 LeftLine('('+MainQuery.FieldByName('CODE_CHRT').AsString+')'+
                                          MainQuery.FieldByName('NAME_CHRT').AsString, 40)+ '|' +
                                 RightLine(FormatFloat('0.00', MainQuery.FieldByName('SUM_NTIME').asFloat), 18) + '|' ;

                         add(sstr);
                         k := k + 1;
                     end;
                     Total_sum := Total_sum + MainQuery.FieldByName('SUM_NTIME').asFloat;
                     i := i + 1;
                     MainQuery.Next;
                 end;

                 If (CompactRadioButton.Checked = True) Then
                 begin
                    sstr := sstr + LeftLine('('+MainQuery.FieldByName('CODE_PDR').AsString+')'+
                                             MainQuery.FieldByName('NAME_PDR').AsString , 65)+ '|' +
                            RightLine(FormatFloat('0.00', Total_sum), 18) + '|';
                    add(sstr);
                    k := k + 1;
                 end
                  else
                  begin
                     add(RepeatLine('-', n));
                     add(RightLine('Итого для ' +
                         sCode_Cst + ':' , 115) + ' ' +
                         RightLine(FormatFloat('0.00', Total_sum), 18)  );
                     add('');
                     add(RepeatLine('-', n));
                  end;

                  AllTotal_Sum := AllTotal_Sum + Total_sum;
                  Total_sum := 0;

             end;
             add(RepeatLine('=', n));
             add(RightLine('ВСЕГО: ' ,115) + ' ' +
                         RightLine(FormatFloat('0.00', AllTotal_sum), 18)  );
             add('');
             PrForm.Destroy;

             Form.Caption := 'Учёт трудоёмкости работ выплненных ЦМО, для смежных участков РМП';
             Form.Editor.show;
             Form.show;


       end;

end;

end.
