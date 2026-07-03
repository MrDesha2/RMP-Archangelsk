unit Rep1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, DB, DBTables, EnumForm4Sel, DateUtils;

type
  TReport1Form = class(TForm)
    Label6: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    Label4: TLabel;
    WrkrCombo: TComboEdit;
    WrkrQuery: TQuery;
    Button1: TButton;
    Button2: TButton;
    MainQuery: TQuery;
    ButtonSelPer: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure WrkrComboButtonClick(Sender: TObject);
    procedure WrkrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report1Form: TReport1Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport1Form.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TReport1Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport1Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport1Form.WrkrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WRkrQuery, WrkrCombo, 'select id, code, name from spr_Wrkr',
                        'Справочник: исполнитель (Выбор)', 0);
end;

procedure TReport1Form.WrkrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, WrkrCombo, key, Shift, 1) = false then
    WrkrComboButtonClick(Sender);
end;

procedure TReport1Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       Num_Wrkr, i : Integer;
       Sum_Time : Real;
       Sum_Num  : Real;
       DateTime_Beg, DateTime_End : TDateTime;
begin

       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);
       Sum_Time := 0;
       Sum_Num  := 0;

       If ((BegDateEdit.Text ='  .  .  ') or (EndDateEdit.Text = '  .  .  ')) Then
       begin
          MessageDlg('Даты не заполнены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select * From REPORT_1_PROCEDURE(:DATE_BEG, :DATE_END, :ID_WRKR)');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (WrkrCombo.Text <> '') and (WrkrCombo.Text <> '<Объект не найден>') Then
          MainQuery.ParamByName('id_WRKR').AsInteger := WrkrQuery.Fields[0].AsInteger
        else
           MainQuery.ParamByName('id_Wrkr').AsInteger := 0;

       MainQuery.Open;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          i := 1;

          While (not MainQuery.Eof) do
          begin

              Num_Wrkr := MainQuery.FieldByName('num_wrkr').AsInteger;

              add('');
              add('');
              add(CentrLine('График работы '+
                             MainQuery.FieldByName('NAME_WRKR').AsString,171));
              add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text, 171));
              add('');
              add(RepeatLine('-', 171));
              add('|  №заявки  |        Номенклатура       |   Чертеж   | Кол-во | №  |   Текущая операция    | Начало операции |Завершение операции|              Оборудование              |');
              add('|  №заказа  |                           |            |        |опер|                       |                 |                   |                                        |');
              add(RepeatLine('-', 171));

              While ((Num_Wrkr = MainQuery.FieldByName('Num_Wrkr').AsInteger) and
                     (not MainQuery.Eof)) do
              begin

                 PrForm.ProgressBar.Position:=(i)*100 div MainQuery.RecordCount;

                 add(RightLine(MainQuery.FieldByName('Num_Rqst').AsString + '/' +
                               MainQuery.FieldByName('Num_Order').AsString, 12)+'|'+
                     LeftLine(MainQuery.FieldByName('Name_Nmnt').AsString, 27)+'|'+
                     LeftLine(MainQuery.FieldByName('Code_Chrt').AsString,12)+'|'+
                     RightLine(FormatFloat('0.000',MainQuery.FieldByName('Number').AsFloat), 8)+'|'+
                     CentrLine(MainQuery.FieldByName('Line_No').AsString, 4)+'|'+
                     LeftLine(MainQuery.FieldByName('Name_Vop').AsString, 23)+'|'+
//                     RightLine(MainQuery.FieldByName('Beg_Time').AsString+' '+
                               RightLine(MainQuery.FieldByName('Beg_Date').AsString, 19)+'|'+
//                     RightLine(MainQuery.FieldByName('End_Time').AsString+' '+
                               RightLine(MainQuery.FieldByName('End_Date').AsString, 19)+'|'+
                     LeftLine(MainQuery.FieldByName('Name_Eqpt').AsString, 40));

                 Sum_Num := Sum_Num +  MainQuery.FieldByName('Number').AsFloat;
                 DateTime_Beg := EncodeDateTime(YearOf(MainQuery.FieldByName('Beg_Date').AsDateTime),
                                                MonthOf(MainQuery.FieldByName('Beg_Date').AsDateTime),
                                                DayOf(MainQuery.FieldByName('Beg_Date').AsDateTime),
                                                HourOf(MainQuery.FieldByName('Beg_Date').AsDateTime),
                                                MinuteOf(MainQuery.FieldByName('Beg_Date').AsDateTime),
                                                SecondOf(MainQuery.FieldByName('Beg_Date').AsDateTime), 0);
//                 DateTime_Beg := EncodeDateTime(2005,8,1,8,0,0, 0);

                 DateTime_End := EncodeDateTime(YearOf(MainQuery.FieldByName('End_Date').AsDateTime),
                                                MonthOf(MainQuery.FieldByName('End_Date').AsDateTime),
                                                DayOf(MainQuery.FieldByName('End_Date').AsDateTime),
                                                HourOf(MainQuery.FieldByName('End_Date').AsDateTime),
                                                MinuteOf(MainQuery.FieldByName('End_Date').AsDateTime),
                                                SecondOf(MainQuery.FieldByName('End_Date').AsDateTime), 0);
//                 DateTime_End := EncodeDateTime(2005,8,1,9,0,0, 0);
//                 ShowMessage(FloatToStr(DateTime_End - DateTime_Beg));
                 Sum_Time := Sum_Time +  (DateTime_End - DateTime_Beg);
{                 ShowMessage(MainQuery.FieldByName('Beg_Date').AsString+ '   ' +
                             MainQuery.FieldByName('End_Date').AsString+ '   '+ TimeToStr(FloatToDateTime(DateTime_End - DateTime_Beg)));}
                 i:=i+1;
                 MainQuery.Next;
              end;
              add(RepeatLine('-', 171));
              add('');                                           
              add('      Количество деталий за период = '+FormatFloat('0.00', Sum_Num));
              add('');
              add('      Количество часов за период = '+FormatFloat('0.00',Sum_Time*24));
          end;
       end;                                                          ;
       PrForm.Destroy;

       Form.Caption := 'Индивидуальный график работы';
       Form.Editor.show;
       Form.show;

end;

procedure TReport1Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
