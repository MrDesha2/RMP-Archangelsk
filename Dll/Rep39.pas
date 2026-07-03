unit Rep39;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel;

type
  TReport39Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    Label10: TLabel;
    EqptCombo: TComboEdit;
    EqptQuery: TQuery;
    Button1: TButton;
    Button2: TButton;
    MainQuery: TQuery;
    WrhsCombo: TComboEdit;
    Label1: TLabel;
    Label4: TLabel;
    CellEdit: TEdit;
    WrhsQuery: TQuery;
    CheckBox: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure WrhsComboButtonClick(Sender: TObject);
    procedure WrhsComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report39Form: TReport39Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport39Form.Button2Click(Sender: TObject);
begin
    Close;
end;

procedure TReport39Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport39Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport39Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport39Form.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, EqptQuery, EqptCombo, 'select id, code, name from spr_eqpt',
                        'Справочник: Инструмент (Выбор)', 0);
end;

procedure TReport39Form.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EqptQuery, EqptCombo, key, Shift, 1) = false then
    EqptComboButtonClick(Sender);
end;

procedure TReport39Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       sstr : String;
       str_eqpt : String;
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

       If (CheckBox.Checked = false) Then
       begin
           MainQuery.Close;
           MainQuery.SQL.Clear;
           MainQuery.SQL.Add('Select * From REPORT_39_PROCEDURE(:DATE_BEG, ');
           MainQuery.SQL.Add(':DATE_END, :ID_EQPT, :ID_WRHS, :NUM_CELL)');
           MainQuery.SQL.Add('Order By NAME_EQPT, DATE_IN, VID_DOC, DOCNUM');

           MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
           MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

           If (EqptCombo.Text = '') or (EqptCombo.Text = '<Объект не найден>') or (not EqptQuery.active) Then
                MainQuery.ParamByName('ID_EQPT').AsInteger := 0
            else
                   MainQuery.ParamByName('ID_EQPT').AsInteger := EqptQuery.Fields[0].AsInteger;

           If (WrhsCombo.Text = '') or (WrhsCombo.Text = '<Объект не найден>') or (not WrhsQuery.active) Then
                MainQuery.ParamByName('ID_WRHS').AsInteger := 0
            else
                   MainQuery.ParamByName('ID_WRHS').AsInteger := WrhsQuery.Fields[0].AsInteger;

           If (CellEdit.Text = '') Then
                MainQuery.ParamByName('NUM_CELL').AsInteger := 0
            else
                   MainQuery.ParamByName('NUM_CELL').AsInteger := StrToInt(CellEdit.Text);

           MainQuery.Open;
           MainQuery.First;
           PrForm.Show;

           // формирование строк
           with Form.Editor.lines do
           begin

              clear;

              i := 1;

              add('');
              add(RightLine(DateToStr(date),176));
              add(RightLine(TimeToStr(time),176));
              add('');
              add(CentrLine('Форма учета прихода расхода инструмента', 176));
              add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 176));
              add('');
              add(RepeatLine('-', 176));
              add('           |                                        |                 |    |          Поступление           |            Расход             |       |                    |      |');
              add('Инвентарный|        Наименование инструмента        |Марка инструмента|Ед. |--------------------------------|-------------------------------|Остаток|        Склад       |Ячейка|');
              add('   номер   |                                        |                 |изм.|   Дата    |  №   |Кол-во|Табел.|   Дата   |  №   |Кол-во|Табел.|   на  |                    |      |');
              add('           |                                        |                 |    |поступления|док-та|      |номер |  расхода |док-та|      |номер | складе|                    |      |');
              add(RepeatLine('-', 176));

              While not MainQuery.Eof do
              begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;
                 sstr:='';

                 sstr:=RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 11)+'|'+
                       LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 40)+'|'+
                       LeftLine(MainQuery.FieldByName('NAME_MARK').AsString, 17)+'|'+
                       LeftLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 4)+'|';

                 If (MainQuery.FieldByName('VID_DOC').AsInteger = 0) Then
                 begin
                     sstr:=sstr + CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 11)+'|'+
                           RightLine(MainQuery.FieldByName('DOCNUM').AsString, 6)+'|'+
                           RightLine(MainQuery.FieldByName('NUMBER_IN').AsString, 6)+'|'+
                           RightLine(MainQuery.FieldByName('WRKR_CODE').AsString, 6)+'|'+
                           '          |      |      |      |';
                 end
                  else
                    begin
                      sstr:=sstr + '           |      |      |      |'+
                            CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 10)+'|'+
                            RightLine(MainQuery.FieldByName('DOCNUM').AsString, 6)+'|'+
                            RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 6)+'|'+
                            RightLine(MainQuery.FieldByName('WRKR_CODE').AsString, 6)+'|';
                    end;

                 sstr:=sstr + // RightLine(MainQuery.FieldByName('WRKR_CODE').AsString, 6)+'|'+
                       RightLine(MainQuery.FieldByName('NUMBER').AsString, 7)+'|'+
                       LeftLine(MainQuery.FieldByName('WRHS_NAME').AsString, 20)+'|'+
                       RightLine(MainQuery.FieldByName('CELL').AsString, 6)+'|';

                 add(sstr);

                 i:=i+1;
                 MainQuery.Next;

              end;

              add(RepeatLine('-', 176));
              add('');
              add('');

           end;
       end
       else
        begin
             MainQuery.Close;
             MainQuery.SQL.Clear;
             MainQuery.SQL.Add('Select * From REPORT_39A_PROCEDURE(:DATE_BEG, ');
             MainQuery.SQL.Add(':DATE_END, :ID_EQPT, :ID_WRHS, :NUM_CELL)');
             MainQuery.SQL.Add('Order By NAME_EQPT, VID_DOC');

             MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
             MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

             If (EqptCombo.Text = '') or (EqptCombo.Text = '<Объект не найден>') or (not EqptQuery.active) Then
                  MainQuery.ParamByName('ID_EQPT').AsInteger := 0
              else
                     MainQuery.ParamByName('ID_EQPT').AsInteger := EqptQuery.Fields[0].AsInteger;

             If (WrhsCombo.Text = '') or (WrhsCombo.Text = '<Объект не найден>') or (not WrhsQuery.active) Then
                  MainQuery.ParamByName('ID_WRHS').AsInteger := 0
              else
                     MainQuery.ParamByName('ID_WRHS').AsInteger := WrhsQuery.Fields[0].AsInteger;

             If (CellEdit.Text = '') Then
                  MainQuery.ParamByName('NUM_CELL').AsInteger := 0
              else
                     MainQuery.ParamByName('NUM_CELL').AsInteger := StrToInt(CellEdit.Text);

             MainQuery.Open;
             MainQuery.First;
             PrForm.Show;

             // формирование строк
             with Form.Editor.lines do
             begin

                clear;

                i := 1;

                add('');
                add(RightLine(DateToStr(date),176));
                add(RightLine(TimeToStr(time),176));
                add('');
                add(CentrLine('Форма учета прихода расхода инструмента', 176));
                add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 176));
                add('');
                add(RepeatLine('-', 176));
                add('           |                                        |                 |    |          Поступление           |            Расход             |       |                    |      |');
                add('Инвентарный|        Наименование инструмента        |Марка инструмента|Ед. |--------------------------------|-------------------------------|Остаток|        Склад       |Ячейка|');
                add('   номер   |                                        |                 |изм.|   Дата    |  №   |Кол-во|Табел.|   Дата   |  №   |Кол-во|Табел.|   на  |                    |      |');
                add('           |                                        |                 |    |поступления|док-та|      |номер |  расхода |док-та|      |номер | складе|                    |      |');
                add(RepeatLine('-', 176));

                While not MainQuery.Eof do
                begin

                   PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;
                   sstr:='';

                   sstr:=RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 11)+'|'+
                         LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 40)+'|'+
                         LeftLine(MainQuery.FieldByName('NAME_MARK').AsString, 17)+'|'+
                         LeftLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 4)+'|';

                   str_eqpt := MainQuery.FieldByName('CODE_EQPT').AsString;

                   If (MainQuery.FieldByName('VID_DOC').AsInteger = 0) Then
                   begin
                       sstr:=sstr + CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 11)+'|'+
                             RepeatLine(' ', 6)+'|'+
                             RightLine(MainQuery.FieldByName('NUMBER_IN').AsString, 6)+'|'+
                             RepeatLine(' ', 6)+'|';

                       i:=i+1;
                       MainQuery.Next;

                       If (str_eqpt = MainQuery.FieldByName('CODE_EQPT').AsString) and
                          (not MainQuery.Eof) Then
                       begin
                           sstr:=sstr + CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 10)+'|'+
                                 RepeatLine(' ', 6)+'|'+
                                 RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 6)+'|'+
                                 RepeatLine(' ', 6)+'|';
                       end
                        else
                        begin
                           sstr:=sstr + '          |      |      |      |';
                           If (not MainQuery.Eof) Then
                           begin
                               i:=i-1;
                               MainQuery.Prior;
                           end;    
                        end;
                   end
                    else
                      begin
                        sstr:=sstr + '           |      |      |      |'+
                              CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 10)+'|'+
                              RepeatLine(' ', 6)+'|'+
                              RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 6)+'|'+
                              RepeatLine(' ', 6)+'|';
                      end;

                   sstr:=sstr + // RightLine(MainQuery.FieldByName('WRKR_CODE').AsString, 6)+'|'+
                         RightLine(MainQuery.FieldByName('NUMBER').AsString, 7)+'|'+
                         LeftLine(MainQuery.FieldByName('WRHS_NAME').AsString, 20)+'|'+
                         RightLine(MainQuery.FieldByName('CELL').AsString, 6)+'|';

                   add(sstr);

                   i:=i+1;
                   MainQuery.Next;

                end;

                add(RepeatLine('-', 176));
                add('');
                add('');

             end;
        end;
       PrForm.Destroy;

       Form.Caption := 'Форма учета прихода расхода инструмента';
       Form.Editor.show;
       Form.show;

end;

procedure TReport39Form.WrhsComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrhsQuery, WrhsCombo, 'select id, code, name from spr_wrhs',
                        'Справочник: Складов (Выбор)', 0);
end;

procedure TReport39Form.WrhsComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrhsQuery, WrhsCombo, key, Shift, 1) = false then
    WrhsComboButtonClick(Sender);
end;

end.
