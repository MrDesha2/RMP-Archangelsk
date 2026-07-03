unit Rep54;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, Mask, ToolEdit, EnumForm4Sel, ExtCtrls;

type
  TReport54Form = class(TForm)
    Label4: TLabel;
    Label5: TLabel;
    ButtonOK: TButton;
    ButtonNO: TButton;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    MainQuery: TQuery;
    CstQuery: TQuery;
    PdrQuery: TQuery;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    RadioGroup1: TRadioGroup;
    CompactRadioButton: TRadioButton;
    FullRadioButton: TRadioButton;
    NmntLabel: TLabel;
    NmntCombo: TComboEdit;
    NmntQuery: TQuery;
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonNOClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure NmntComboButtonClick(Sender: TObject);
    procedure NmntComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report54Form: TReport54Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport54Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport54Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport54Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);

end;

procedure TReport54Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);

end;

procedure TReport54Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);

end;

procedure TReport54Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport54Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport54Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
        i,n : Integer;
   Sum_Mtrp : Real;   
       sstr : String;
       sCode_Nmnt : String;
     Ed_izm : String;
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
       MainQuery.SQL.Add('Select * From REPORT_54_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_CST, :ID_PDR, :ID_NMNT, :SHORT)');

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

       If (NmntCombo.Text = '') or (NmntCombo.Text = '<Объект не найден>') or (not NmntQuery.active) Then
            MainQuery.ParamByName('ID_NMNT').AsInteger := -1
        else
               MainQuery.ParamByName('ID_NMNT').AsInteger := NmntQuery.Fields[0].AsInteger;

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
             n := 91;
             add(RepeatLine('-', n));
             add('');
             add('');
             add(CentrLine('Потребность в материалах на заказы',n));
             add(CentrLine('выполняемые c '+BegDateEdit.Text+' по '+EndDateEdit.Text, n));
             add('');
             add(RepeatLine('-', n));
             add('Номеноклатурный|                    Наменование                   |  Ед-цы  | Потребность |');
             add('    номенр     |                                                  |измерения|  по плану   |');
             add('               |                                                  |         |             |');
             add(RepeatLine('-', n));

             sstr:='';

             //цикл по количеству заказов
             While not MainQuery.Eof do
             begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 sstr:=RightLine(MainQuery.FieldByName('Code_Nmnt').AsString, 15)+' '+
                       LeftLine(MainQuery.FieldByName('Name_Nmnt').AsString, 50)+' '+
                       CentrLine(MainQuery.FieldByName('Code_Ediz').AsString, 9)+' '+
                       RightLine(MainQuery.FieldByName('Sum_Mtrp').AsString, 13)+' ';


                 MainQuery.Next;
                 i:=i+1;
                 add(sstr);
             end;
         end
          else
          begin
              n := 130;
              sstr:='';

             //цикл по количеству заказов
             While not MainQuery.Eof do
             begin

              add(RepeatLine('-', n));
              add('');
              add(CentrLine('Потребность в материалах на заказы',n));
              add(CentrLine('выполняемые c '+BegDateEdit.Text+' по '+EndDateEdit.Text, n));
              add(CentrLine('по материалу ('+MainQuery.FieldByName('Code_Nmnt').AsString + ') '+
                  MainQuery.FieldByName('Name_Nmnt').AsString,n));
              add('');
              add(RepeatLine('-', n));
              add('                Заказчик                |     Номер     |       Номер       |  Ед-цы  | Потребность |Колиечство|    Габаритные    ');
              add('                                        |  Заявка/Заказ |      чертежа      |измерения|  по плану   | деталей  |     размеры      ');
              add('                                        |               |                   |         |             |          |длина,шрина,высота');
              add(RepeatLine('-', n));

                 Sum_Mtrp := 0;

                 sCode_Nmnt := Trim(MainQuery.FieldByName('Code_Nmnt').AsString);

                 While (sCode_Nmnt = Trim(MainQuery.FieldByName('Code_Nmnt').AsString)) and
                        (not MainQuery.Eof) do
                 begin

                    PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                    sstr:=LeftLine(MainQuery.FieldByName('Name_Cst').AsString, 40)+'|'+
                          RightLine(MainQuery.FieldByName('Number_Rqst').AsString+'/'+
                                    MainQuery.FieldByName('Number_Order').AsString, 15)+'|'+
                          LeftLine(MainQuery.FieldByName('Code_Chrt').AsString, 19)+'|'+
                          CentrLine(MainQuery.FieldByName('Code_Ediz').AsString, 9)+'|'+
                          RightLine(MainQuery.FieldByName('Sum_Mtrp').AsString, 13)+'|'+
                          RightLine(MainQuery.FieldByName('Number_P').AsString, 10)+'|'+
                          RightLine(MainQuery.FieldByName('LENGHT').AsString+'x'+
                                   MainQuery.FieldByName('WIDTH').AsString+'x'+
                                   MainQuery.FieldByName('HIGHT').AsString, 18);


                    Sum_Mtrp := Sum_Mtrp + MainQuery.FieldByName('Sum_Mtrp').AsFloat;
                    Ed_izm := MainQuery.FieldByName('Code_Ediz').AsString;

                    MainQuery.Next;
                    i:=i+1;
                    add(sstr);
                 end;

                 add(RepeatLine('-', n));
                 add(RightLine('ИТОГО: ', 76)+ ' '+
                     CentrLine(Ed_izm, 9)+ ' ' +
                     RightLine(FormatFloat('0.000', Sum_Mtrp), 13));
             end;

          end;

         add(RepeatLine('-', n));
         add('');
         add('');
         add('');
         add('');
         add('     Технолог (Мастер) ______________________________');
         PrForm.Destroy;

         Form.Caption := 'Потребность в материалах на заказ';
         Form.Editor.show;
         Form.show;
       end;

end;

procedure TReport54Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport54Form.NmntComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, NmntQuery, NmntCombo, 'select id, code, name from spr_nmnt',
                        'Справочник: Номенклатура (Выбор)', 0);

end;

procedure TReport54Form.NmntComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(NmntQuery, NmntCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

end.
