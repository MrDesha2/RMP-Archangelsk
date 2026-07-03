unit Rep49;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, DB, DBTables, EnumForm4Sel;

type
  TReport49Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonSelPer: TButton;
    ButtonOK: TButton;
    ButtonNO: TButton;
    Label10: TLabel;
    EqptCombo: TComboEdit;
    EqptQuery: TQuery;
    MainQuery: TQuery;
    procedure ButtonSelPerClick(Sender: TObject);
    procedure ButtonNOClick(Sender: TObject);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report49Form: TReport49Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;


{$R *.dfm}

procedure TReport49Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport49Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport49Form.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, EqptQuery, EqptCombo, 'select id, code, name from spr_eqpt',
                        'Справочник: Инструмент (Выбор)', 0);
end;

procedure TReport49Form.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EqptQuery, EqptCombo, key, Shift, 1) = false then
    EqptComboButtonClick(Sender);
end;

procedure TReport49Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport49Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport49Form.ButtonOKClick(Sender: TObject);
Var    Form    : TShowPrintForm;
       PrForm  : TProcessForm;
       sstr    : String;
       tmp_str : String;
       i : Integer;
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
       MainQuery.SQL.Add('Select * From REPORT_49_PROCEDURE(:DATE_BEG, ');
       MainQuery.SQL.Add(':DATE_END, :ID_EQPT)');
//       MainQuery.SQL.Add('Order By DATE_IN, TYPE_DOC, NAME_EQPT, DOCNUM');

       MainQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (EqptCombo.Text = '') or (EqptCombo.Text = '<Объект не найден>') or (not EqptQuery.active) Then
       begin
          MessageDlg('Инструмент не заполнен!', mtWarning , [mbYes], 0);
          Exit;
       end
//            MainQuery.ParamByName('ID_EQPT').AsInteger := 0
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

              sstr := '';

          add('');
          add(RightLine(DateToStr(date),145));
          add(RightLine(TimeToStr(time),145));
          add('');
          add(CentrLine('Карточка учёта инструмента', 147));
          add('');
          add(LeftLine('Инвентарный номер: '+MainQuery.FieldByName('CODE_EQPT').AsString, 147));
          add(LeftLine('Наименование: '+MainQuery.FieldByName('NAME_EQPT').AsString, 147));
          add('');
          add(RepeatLine('-', 147));
          add('|                           | Начальный остаток|  Приход  |  Расход  | Конечный остаток |                     |      |                     |      |');
          add('|   Дата   /    Документ    |------------------|----------|----------|------------------|      Получатель     |Ячейка|     Отправитель     |Ячейка|');
          add('|                           |на складе|на руках|          |          |на складе|на руках|                     |      |                     |      |');
          add(RepeatLine('-', 147));


          While not MainQuery.Eof do
          begin


              PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

              If (MainQuery.FieldByName('Vid_Doc').AsInteger = 0) Then
              begin
                 if (MainQuery.FieldByName('Type_Doc').AsInteger = 0) Then tmp_str := 'Пост. '
                  else tmp_str := 'Возвр.';
              end
               else
               begin
                  if (MainQuery.FieldByName('Type_Doc').AsInteger = 0) Then tmp_str := 'В цех.'
                   else tmp_str := 'Спис. ';
               end;
              sstr := '|'+CentrLine(MainQuery.FieldByName('DATE_RSPR').AsString, 10)+'/'+
                      tmp_str+LeftLine(MainQuery.FieldByName('NUM_DOC').AsString, 10)+'|'+
                      RightLine(MainQuery.FieldByName('S_NUMBER_IN').AsString, 9)+'|'+
                      RightLine(MainQuery.FieldByName('S_NUMBER_HAND').AsString, 8)+'|';

              If MainQuery.FieldByName('Vid_Doc').AsInteger = 0 Then
                  sstr := sstr + RightLine(MainQuery.FieldByName('NUMBER').AsString, 10)+'|'+
                          RepeatLine(' ',10)+'|'
               else
                   sstr := sstr + RepeatLine(' ',10)+'|'+
                           RightLine(MainQuery.FieldByName('NUMBER').AsString, 10)+'|';

              sstr := sstr + RightLine(MainQuery.FieldByName('SE_NUMBER_IN').AsString, 9)+'|'+
                      RightLine(MainQuery.FieldByName('SE_NUMBER_HAND').AsString, 8)+'|';

              If (MainQuery.FieldByName('Vid_Doc').AsInteger = 0) Then
              begin
                 if (MainQuery.FieldByName('Type_Doc').AsInteger = 0) Then
                      sstr := sstr + LeftLine(MainQuery.FieldByName('NAME_WRHS').AsString, 21)+'|'+
                              RightLine(MainQuery.FieldByName('CELL').AsString, 6)+'|'+
                              LeftLine(MainQuery.FieldByName('NAME_CST').AsString, 21)+'|'+
                              RepeatLine(' ', 6)+'|'
                  else
                       sstr := sstr + LeftLine(MainQuery.FieldByName('NAME_WRHS').AsString, 21)+'|'+
                                      RightLine(MainQuery.FieldByName('CELL').AsString, 6)+'|'+
                                      LeftLine(MainQuery.FieldByName('NAME_WRKR').AsString, 21)+'|'+
                                      RepeatLine(' ', 6)+'|';
              end
               else
               begin
                  if (MainQuery.FieldByName('Type_Doc').AsInteger = 0) Then
                       sstr := sstr + LeftLine(MainQuery.FieldByName('NAME_WRKR').AsString, 21)+'|'+
                               RepeatLine(' ', 6)+'|'+
                               LeftLine(MainQuery.FieldByName('NAME_WRHS').AsString, 21)+'|'+
                               RightLine(MainQuery.FieldByName('CELL').AsString, 6)+'|'
                   else
                        sstr := sstr + LeftLine(MainQuery.FieldByName('NAME_CST').AsString, 21)+'|'+
                                       RepeatLine(' ', 6)+'|'+
                                       LeftLine(MainQuery.FieldByName('NAME_WRHS').AsString, 21)+'|'+
                                       RightLine(MainQuery.FieldByName('CELL').AsString, 6)+'|';
               end;

             add(sstr);

             i:=i+1;
             MainQuery.Next;

          end;
          add(RepeatLine('-', 147));
          add('');
          add('');

       end;

       PrForm.Destroy;

       Form.Caption := 'Карточка движения инструмента';
       Form.Editor.show;
       Form.show;


end;

end.
