unit Rep46;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, DB, DBTables, EnumForm4Sel, DateUtils;

type
  TReport46Form = class(TForm)
    WrkrQuery: TQuery;
    WrkrCombo: TComboEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label10: TLabel;
    Label2: TLabel;
    SexCombo: TComboBox;
    Label3: TLabel;
    RankCombo: TComboBox;
    Label4: TLabel;
    ProfCombo: TComboEdit;
    Label5: TLabel;
    PdrCombo: TComboEdit;
    Label6: TLabel;
    EqptCombo: TComboEdit;
    Label7: TLabel;
    GroupCombo: TComboEdit;
    Label8: TLabel;
    OperCombo: TComboEdit;
    ProfQuery: TQuery;
    PdrQuery: TQuery;
    EqptQuery: TQuery;
    GroupQuery: TQuery;
    OperQuery: TQuery;
    MainQuery: TQuery;
    EqptCheckBox: TCheckBox;
    OperCheckBox: TCheckBox;
    ViewEqptQuery: TQuery;
    ViewOperQuery: TQuery;
    Label9: TLabel;
    DateBernComboBox: TComboBox;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure WrkrComboButtonClick(Sender: TObject);
    procedure WrkrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ProfComboButtonClick(Sender: TObject);
    procedure ProfComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GroupComboButtonClick(Sender: TObject);
    procedure GroupComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OperComboButtonClick(Sender: TObject);
    procedure OperComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report46Form: TReport46Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces;

{$R *.dfm}

procedure TReport46Form.Button2Click(Sender: TObject);
begin
        Close;
end;

procedure TReport46Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport46Form.FormCreate(Sender: TObject);
Var YearBeg : Integer;
          i : Integer;
begin
  ListForm := TLIST_4SELECTForm.create(self);
  DateBernComboBox.Items.Add('-');
  YearBeg := YearOf(Date);
  For i:=YearBeg-60 To YearBeg Do
    DateBernComboBox.Items.Add(IntToStr(i));
  DateBernComboBox.ItemIndex := 0;
end;

procedure TReport46Form.WrkrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, WrkrCombo, 'select id, code, name from spr_wrkr',
                        'Справочник: Работники (Выбор)', 0);
end;

procedure TReport46Form.WrkrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, WrkrCombo, key, Shift, 1) = false then
    WrkrComboButtonClick(Sender);
end;

procedure TReport46Form.ProfComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, ProfQuery, ProfCombo, 'select id, code, name from spr_prof',
                        'Справочник: Профессия (Выбор)', 0);
end;

procedure TReport46Form.ProfComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(ProfQuery, ProfCombo, key, Shift, 1) = false then
    ProfComboButtonClick(Sender);
end;

procedure TReport46Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделение (Выбор)', 0);
end;

procedure TReport46Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport46Form.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, EqptQuery, EqptCombo, 'select id, code, name from spr_eqpt',
                        'Справочник: Оборудование (Выбор)', 0);
end;

procedure TReport46Form.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EqptQuery, EqptCombo, key, Shift, 1) = false then
    EqptComboButtonClick(Sender);
end;

procedure TReport46Form.GroupComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, GroupQuery, GroupCombo, 'select id, code, name from spr_brigade',
                        'Справочник: Бригады (Выбор)', 0);
end;

procedure TReport46Form.GroupComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(GroupQuery, GroupCombo, key, Shift, 1) = false then
    GroupComboButtonClick(Sender);
end;

procedure TReport46Form.OperComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, OperQuery, OperCombo, 'select id, code, name from spr_vop',
                        'Справочник: Виды операций (Выбор)', 0);
end;

procedure TReport46Form.OperComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(OperQuery, OperCombo, key, Shift, 1) = false then
    OperComboButtonClick(Sender);
end;

procedure TReport46Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i, n : integer;
       Pdr : String;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select * From REPORT_46_PROCEDURE(:WRKR_ID, :PROF_ID, ');
       MainQuery.SQL.Add(':PDR_ID, :EQPT_ID, :BRIGADE_ID, :OPER_ID, :SEX, :RANK, :YEAR_BERN)');
       MainQuery.SQL.Add('Order by CODE_PDR, NAME_WRKR');

       If (WrkrCombo.Text = '') or (WrkrCombo.Text = '<Объект не найден>') or (not WrkrQuery.active) Then
            MainQuery.ParamByName('WRKR_ID').AsInteger := 0
        else
               MainQuery.ParamByName('WRKR_ID').AsInteger := WrkrQuery.Fields[0].AsInteger;

       If (ProfCombo.Text = '') or (ProfCombo.Text = '<Объект не найден>') or (not ProfQuery.active) Then
            MainQuery.ParamByName('PROF_ID').AsInteger := 0
        else
               MainQuery.ParamByName('PROF_ID').AsInteger := ProfQuery.Fields[0].AsInteger;

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('PDR_ID').AsInteger := 0
        else
               MainQuery.ParamByName('PDR_ID').AsInteger := PdrQuery.Fields[0].AsInteger;

       If (EqptCombo.Text = '') or (EqptCombo.Text = '<Объект не найден>') or (not EqptQuery.active) Then
            MainQuery.ParamByName('EQPT_ID').AsInteger := 0
        else
               MainQuery.ParamByName('EQPT_ID').AsInteger := EqptQuery.Fields[0].AsInteger;

       If (GroupCombo.Text = '') or (GroupCombo.Text = '<Объект не найден>') or (not GroupQuery.active) Then
            MainQuery.ParamByName('BRIGADE_ID').AsInteger := 0
        else
               MainQuery.ParamByName('BRIGADE_ID').AsInteger := GroupQuery.Fields[0].AsInteger;

       If (OperCombo.Text = '') or (OperCombo.Text = '<Объект не найден>') or (not OperQuery.active) Then
            MainQuery.ParamByName('OPER_ID').AsInteger := 0
        else
               MainQuery.ParamByName('OPER_ID').AsInteger := OperQuery.Fields[0].AsInteger;

       MainQuery.ParamByName('SEX').AsInteger := SexCombo.ItemIndex;
       MainQuery.ParamByName('RANK').AsInteger := RankCombo.ItemIndex;
       If DateBernComboBox.ItemIndex > 0 Then
           MainQuery.ParamByName('YEAR_BERN').AsInteger := StrToInt(DateBernComboBox.Items[DateBernComboBox.ItemIndex])
        else
             MainQuery.ParamByName('YEAR_BERN').AsInteger := 0;

       MainQuery.Open;
       MainQuery.First;

       If EqptCheckBox.Checked = True Then
       begin
           ViewEqptQuery.Close;
           ViewEqptQuery.SQL.Clear;
           ViewEqptQuery.SQL.Add('Select a.code, a.name ');
           ViewEqptQuery.SQL.Add('From Spr_Eqpt a, Spr_WrEq b ');
           ViewEqptQuery.SQL.Add('Where b.id_wrkr = :id_wrkr and ');
           ViewEqptQuery.SQL.Add('      a.id = b.id_eqpt');
           ViewEqptQuery.ParamByName('id_wrkr').AsInteger := MainQuery.FieldByName('id_wrkr').AsInteger;
           ViewEqptQuery.Open;
       end;

       If OperCheckBox.Checked = True Then
       begin
           ViewOperQuery.Close;
           ViewOperQuery.SQL.Clear;
           ViewOperQuery.SQL.Add('Select a.code, a.name ');
           ViewOperQuery.SQL.Add('From Spr_Vop a, Spr_WrVop b ');
           ViewOperQuery.SQL.Add('Where b.id_wrkr = :id_wrkr and ');
           ViewOperQuery.SQL.Add('      a.id = b.id_vop');
           ViewOperQuery.ParamByName('id_wrkr').AsInteger := MainQuery.FieldByName('id_wrkr').AsInteger;
           ViewOperQuery.Open;
       end;

       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;
          n := MainQuery.RecordCount;

          add('');
          add(CentrLine('Учет кадров РМП АО "Архангельский ЦБК"', 165));
          While not MainQuery.Eof do
          begin

              add('');
              add('');
              add('('+MainQuery.FieldByName('CODE_PDR').AsString+') '+MainQuery.FieldByName('NAME_PDR').AsString);
              add(RepeatLine('-', 165));
              add('| Табельный № |          Фамилия И.О.          | Пол | Дата приема  |     Дата     |Разряд|               Профессия             |              Бригада              |');
              add('|             |                                |     |  на работу   |   рождения   |      |                                     |                                   |');
              add(RepeatLine('-', 165));

              Pdr := MainQuery.FieldByName('CODE_PDR').AsString;

              While (Pdr = MainQuery.FieldByName('CODE_PDR').AsString) and
                    (not MainQuery.Eof) do
              begin

                   PrForm.ProgressBar.Position:=i*100 div n;

                   add('|'+RightLine(MainQuery.FieldByName('CODE_WRKR').AsString, 13) +' '+
                       LeftLine(MainQuery.FieldByName('NAME_WRKR').AsString, 32) +' '+
                       CentrLine(MainQuery.FieldByName('OUT_SEX').AsString, 5) +' '+
                       CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 14) +' '+
                       CentrLine(MainQuery.FieldByName('DATE_BIR').AsString, 14) +' '+
                       RightLine(MainQuery.FieldByName('INT_RANK').AsString, 6) +' '+
                       LeftLine(MainQuery.FieldByName('NAME_PROF').AsString, 37) +'|'+
                       LeftLine(MainQuery.FieldByName('NAME_BRIGADE').AsString, 35) +'|');

                   add('|'+RightLine('Адрес: ',13)+' '+ LeftLine(MainQuery.FieldByName('ADRES').AsString, 32)+' '+
                       'Тел.: '+ LeftLine(MainQuery.FieldByName('ADRES').AsString, 14)+' '+
                       LeftLine(MainQuery.FieldByName('ADRES').AsString, 14)+' '+RepeatLine(' ', 44)+'|'+RepeatLine(' ', 35)+'|');

                   //Вывод выполняемых операций
                   If OperCheckBox.Checked = True Then
                   begin

                      ViewOperQuery.Close;
                      ViewOperQuery.ParamByName('id_wrkr').AsInteger := MainQuery.FieldByName('ID_WRKR').AsInteger;
                      ViewOperQuery.Open;

                      If not ViewOperQuery.Eof Then
                      begin

//                          add('|'+RepeatLine(' ', 127)+'|'+RepeatLine(' ', 35)+'|');
                          add('|  Выполняемые операции:'+RepeatLine(' ', 104)+'|'+RepeatLine(' ', 35)+'|');

                          While not ViewOperQuery.Eof do
                          begin
                             add('|       '+LeftLine('('+Trim(ViewOperQuery.FieldByName('CODE').AsString)+') '+
                                 Trim(ViewOperQuery.FieldByName('NAME').AsString), 40)+RepeatLine(' ', 80)+'|'+RepeatLine(' ', 35)+'|');
                             ViewOperQuery.Next;
                          end;
                      end;

                   end;

                   //Вывод используемого при работе оборудования
                   If EqptCheckBox.Checked = True Then
                   begin

                      ViewEqptQuery.Close;
                      ViewEqptQuery.ParamByName('id_wrkr').AsInteger := MainQuery.FieldByName('ID_WRKR').AsInteger;
                      ViewEqptQuery.Open;

                      If (not ViewEqptQuery.Eof) or (not MainQuery.FieldByName('CODE_EQPT').IsNull) Then
                      begin
//                          add('|'+RepeatLine(' ', 127)+'|'+RepeatLine(' ', 35)+'|');
                          add('|  Используемое оборудование:'+RepeatLine(' ', 99)+'|'+RepeatLine(' ', 35)+'|');

                          //Основное оборудование работника, прописано в его карточке
                          If not MainQuery.FieldByName('CODE_EQPT').IsNull Then
                             add('|       '+LeftLine('('+Trim(MainQuery.FieldByName('CODE_EQPT').AsString)+') '+
                                 Trim(MainQuery.FieldByName('NAME_EQPT').AsString), 40)+RepeatLine(' ', 80)+'|'+RepeatLine(' ', 35)+'|');

                          While not ViewEqptQuery.Eof do
                          begin
                             add('|       '+LeftLine('('+Trim(ViewEqptQuery.FieldByName('CODE').AsString)+') '+
                                 Trim(ViewEqptQuery.FieldByName('NAME').AsString), 40)+RepeatLine(' ', 80)+'|'+RepeatLine(' ', 35)+'|');
                             ViewEqptQuery.Next;
                          end;
                      end;

                   end;

                   i := i + 1;
                   MainQuery.Next;
                   If (not MainQuery.Eof) and (Pdr = MainQuery.FieldByName('CODE_PDR').AsString) Then
                       add('|'+RepeatLine('.', 127)+'|'+RepeatLine('.', 35)+'|');
              end;

              add(RepeatLine('-', 165));

          end;

          add('');
          add('');
          add('');
          add('     Итого количество записей: '+IntToStr(i-1));
       end;
       PrForm.Destroy;

       Form.Caption := 'Учет работников';
       Form.Editor.show;
       Form.show;


end;

end.
