unit Rep45;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel;

type
  TReport45Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    MdlCombo: TComboEdit;
    PrintButton: TButton;
    CloseButton: TButton;
    MdlQuery: TQuery;
    MainQuery: TQuery;
    Label1: TLabel;
    WrhsCombo: TComboEdit;
    WrhsQuery: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure MdlComboButtonClick(Sender: TObject);
    procedure MdlComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PrintButtonClick(Sender: TObject);
    procedure WrhsComboButtonClick(Sender: TObject);
    procedure WrhsComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report45Form: TReport45Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport45Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport45Form.CloseButtonClick(Sender: TObject);
begin
    Close;
end;

procedure TReport45Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport45Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport45Form.MdlComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, MdlQuery, MdlCombo, 'select id, code, name from spr_mdl',
                        'Справочник: Моделей (Выбор)', 0);
end;

procedure TReport45Form.MdlComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(MdlQuery, MdlCombo, key, Shift, 1) = false then
    MdlComboButtonClick(Sender);
end;

procedure TReport45Form.PrintButtonClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       sstr : String;
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
       MainQuery.SQL.Add('Select * From REPORT_45_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_MDL, :ID_WRHS)');
       MainQuery.SQL.Add('Order By NAME_MDL, DATE_IN, TYPE_DOC, DOCNUM');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (MdlCombo.Text = '') or (MdlCombo.Text = '<Объект не найден>') or (not MdlQuery.active) Then
            MainQuery.ParamByName('ID_MDL').AsInteger := 0
        else
               MainQuery.ParamByName('ID_MDL').AsInteger := MdlQuery.Fields[0].AsInteger;

       If (WrhsCombo.Text = '') or (WrhsCombo.Text = '<Объект не найден>') or (not WrhsQuery.active) Then
            MainQuery.ParamByName('ID_WRHS').AsInteger := 0
        else
               MainQuery.ParamByName('ID_WRHS').AsInteger := WrhsQuery.Fields[0].AsInteger;
       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

         clear;

         i := 1;
         add('');
         add(RightLine(DateToStr(date),191));
         add(RightLine(TimeToStr(time),191));
         add('');
         add(CentrLine('Форма учета прихода расхода инструмента', 194));

         If (MainQuery.FieldByName('WRHS_ID').AsInteger <> 0) or
             (MainQuery.FieldByName('TYPE_DOC').IsNull = True) Then
                    add(CentrLine(MainQuery.FieldByName('WRHS_NAME').AsString, 194));

         add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 194));
         add('');
         add(RepeatLine('-', 193));
         add('                    |                              |                    |       Поступление       |            Расход                 |       |                                                  |');
         add('        Код         |     Наименование модели      |    Код Чертежа     |-------------------------|-----------------------------------|Остаток|                  Место хранения                  |');
         add('       Модели       |                              |                    |   Дата    |  №   |Кол-во|   Дата   |  №   |Кол-во|   Код    |       |                                                  |');
         add('                    |                              |                    |поступления|док-та|      |  расхода |док-та|      | заказчка |       |                                                  |');
         add(RepeatLine('-', 194));

         While not MainQuery.Eof do
         begin


                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;
                 sstr:='';

                 sstr:=RightLine(MainQuery.FieldByName('CODE_MDL').AsString, 20)+'|'+
                       LeftLine(MainQuery.FieldByName('NAME_MDL').AsString, 30)+'|'+
                       LeftLine(MainQuery.FieldByName('CODE_CHRT').AsString, 20)+'|';

                 If (MainQuery.FieldByName('TYPE_DOC').AsInteger = 0) or
                    (MainQuery.FieldByName('TYPE_DOC').IsNull = True) Then
                 begin
                     sstr:=sstr + CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 11)+'|'+
                           RightLine(MainQuery.FieldByName('DOCNUM').AsString, 6)+'|'+
                           RightLine(MainQuery.FieldByName('NUMBER_IN').AsString, 6)+'|'+
                           '          |      |      |';
                 end
                  else
                    begin
                      sstr:=sstr + '           |      |      |'+
                            CentrLine(MainQuery.FieldByName('DATE_IN').AsString, 10)+'|'+
                            RightLine(MainQuery.FieldByName('DOCNUM').AsString, 6)+'|'+
                            RightLine(MainQuery.FieldByName('NUMBER_OUT').AsString, 6)+'|';
                    end;

                 sstr:=sstr + LeftLine(MainQuery.FieldByName('CST_CODE').AsString, 10)+'|'+
                       RightLine(MainQuery.FieldByName('NUMBER').AsString, 7)+'|'+
                       LeftLine(MainQuery.FieldByName('WRHS_NAME').AsString, 50)+'|';

                 add(sstr);

                 i:=i+1;
                 MainQuery.Next;

         end;

         add(RepeatLine('-', 194));
         add('');
         add('');


       end;
       PrForm.Destroy;

       Form.Caption := 'Форма учета прихода расхода моделей';
       Form.Editor.show;
       Form.show;

end;

procedure TReport45Form.WrhsComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrhsQuery, WrhsCombo, 'select id, code, name from spr_wrhs',
                        'Справочник: Склады (Выбор)', 0);
end;

procedure TReport45Form.WrhsComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrhsQuery, WrhsCombo, key, Shift, 1) = false then
    WrhsComboButtonClick(Sender);
end;

end.
