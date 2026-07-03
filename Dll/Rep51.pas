unit Rep51;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel;

type
  TReport51Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    EqptCombo: TComboEdit;
    Button1: TButton;
    Button2: TButton;
    PdrCombo: TComboEdit;
    EqptQuery: TQuery;
    MainQuery: TQuery;
    PdrQuery: TQuery;
    WrkrQuery: TQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report51Form: TReport51Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport51Form.Button2Click(Sender: TObject);
begin
    Close;
end;

procedure TReport51Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport51Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport51Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport51Form.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, EqptQuery, EqptCombo, 'select id, code, name from spr_eqpt',
                        'Справочник: Инструмент (Выбор)', 0);
end;

procedure TReport51Form.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EqptQuery, EqptCombo, key, Shift, 1) = false then
    EqptComboButtonClick(Sender);
end;

procedure TReport51Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport51Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport51Form.Button1Click(Sender: TObject);
Var    Form   : TShowPrintForm;
       PrForm : TProcessForm;
       i,k    : Integer;
       post   : String;
       sstr   : String;
       Eqpt_Code : String;
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
       MainQuery.SQL.Add('Select * From REPORT_51_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_EQPT, :ID_PDR)');
       MainQuery.SQL.Add('Order By NAME_EQPT, TYPE_DOC');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('ID_Pdr').AsInteger := 0
        else
               MainQuery.ParamByName('ID_Pdr').AsInteger := PdrQuery.Fields[0].AsInteger;

       If (EqptCombo.Text = '') or (EqptCombo.Text = '<Объект не найден>') or (not EqptQuery.active) Then
            MainQuery.ParamByName('ID_EQPT').AsInteger := 0
        else
               MainQuery.ParamByName('ID_EQPT').AsInteger := EqptQuery.Fields[0].AsInteger;    

       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;

          add('');
          add(RightLine(DateToStr(date),129));
          add(RightLine(TimeToStr(time),129));
          add('');
          add(CentrLine('Сводная ведомость выдачи инструмента рабочему персоналу РМП', 131));
          add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 131));
          If not ((PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active)) Then
             add(CentrLine('по подразделению ' + PdrQuery.FieldByName('NAME').AsString, 131));
          add('');
          add('');
          add(RepeatLine('-', 131));
          add('           |                                        |                 |    |   Остаток   |            |             |             |');
          add('Инвентарный|        Наименование инструмента        |Марка инструмента|Ед. |  начальный  |   Выдача   |   Возврат   |   Остаток   |');
          add('   номер   |                                        |                 |изм.|      на     |            |             |             |');
          add('           |                                        |                 |    |'+
              CentrLine(BegDateEdit.Text, 13)+'|            |             |             |');
          add(RepeatLine('-', 131));

          While not MainQuery.Eof do
          begin

              Eqpt_Code := MainQuery.FieldByName('CODE_EQPT').AsString;
              sstr := '';

              k:=MainQuery.FieldByName('TYPE_DOC').AsInteger;

              sstr := RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 11)+'|'+
                      LeftLine(MainQuery.FieldByName('NAME_EQPT').AsString, 40)+'|'+
                      LeftLine(MainQuery.FieldByName('NAME_MARK').AsString, 17)+'|'+
                      LeftLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 4)+'|'+
                      RightLine(MainQuery.FieldByName('NUMBER_BEF').AsString, 13)+'|';

              While (Eqpt_Code = MainQuery.FieldByName('CODE_EQPT').AsString) and
                    (not MainQuery.Eof) do
              begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 If (MainQuery.FieldByName('TYPE_DOC').AsInteger = 0) Then
                 begin
                        sstr:=sstr + RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 12)+'|';
                 end
                  else
                    begin
                      if (k = 0) Then
                         sstr:=sstr + RightLine(MainQuery.FieldByName('NUMBER_IN').AsString, 13)+'|'
                       else
                          sstr:=sstr + '            |' + RightLine(MainQuery.FieldByName('NUMBER_IN').AsString, 13)+'|';
                    end;

                 i := i+1;
                 k := MainQuery.FieldByName('TYPE_DOC').AsInteger;
                 post := RightLine(MainQuery.FieldByName('NUMBER_POST').AsString, 13)+ '|';
                 MainQuery.Next;

              end;

              If (k = 0) Then sstr:=sstr + '             |';

              sstr := sstr + post;
//              sstr := sstr + RightLine(MainQuery.FieldByName('NUMBER_POST').AsString, 13)+ '|';
              add(sstr);

          end;
          add(RepeatLine('-', 131));
          add('');
          add('');
       end;
       PrForm.Destroy;

       Form.Caption := 'Форма учета выдачи инструмента рабочему персоналу РМП';
       Form.Editor.show;
       Form.show;
end;

end.
