{-----------------------------------------------------------------------------
 Unit Name: MyCalend
 Author:    Администратор
 Purpose:  Модуль формы редактирования производственного календаря
           Календарь находится в таблице Calend сервера БД
 History:

   Дата определяется с 12/30/1899.
-----------------------------------------------------------------------------}


unit MyCalend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, strutils, dateutils, Mask, Menus,
  DB, DBTables, IBDatabase, IBCustomDataSet, IBTable, IBStoredProc;

type
  TMyDay = class
        Cell : tPanel;
        day  : integer;
        month: integer;
        year : integer;
    duration : integer;
        mdate: tdate;
    end;


  TCalendarForm = class(TForm)
    CalPanel: TPanel;
    PanelTop: TPanel;
    ButtonYearMin: TButton;
    ButtonMonthMin: TButton;
    ButtonMonthPlus: TButton;
    ButtonYearPlus: TButton;
    PanelBot: TPanel;
    mPanel9: TPanel;
    mPanel8: TPanel;
    mPanel7: TPanel;
    mPanel6: TPanel;
    mPanel5: TPanel;
    mPanel42: TPanel;
    mPanel41: TPanel;
    mPanel40: TPanel;
    mPanel4: TPanel;
    mPanel39: TPanel;
    mPanel38: TPanel;
    mPanel37: TPanel;
    mPanel36: TPanel;
    mPanel35: TPanel;
    mPanel34: TPanel;
    mPanel33: TPanel;
    mPanel32: TPanel;
    mPanel31: TPanel;
    mPanel30: TPanel;
    mPanel3: TPanel;
    mPanel29: TPanel;
    mPanel28: TPanel;
    mPanel27: TPanel;
    mPanel26: TPanel;
    mPanel25: TPanel;
    mPanel24: TPanel;
    mPanel23: TPanel;
    mPanel22: TPanel;
    mPanel21: TPanel;
    mPanel20: TPanel;
    mPanel2: TPanel;
    mPanel19: TPanel;
    mPanel18: TPanel;
    mPanel17: TPanel;
    mPanel16: TPanel;
    mPanel15: TPanel;
    mPanel14: TPanel;
    mPanel13: TPanel;
    mPanel12: TPanel;
    mPanel11: TPanel;
    mPanel10: TPanel;
    mPanel1: TPanel;
    Label1: TLabel;
    EditDay: TMaskEdit;
    PopupMenu: TPopupMenu;
    BegMonth: TMenuItem;
    EndMonth: TMenuItem;
    BegYear: TMenuItem;
    EndYear: TMenuItem;
    Curdate: TMenuItem;
    ButtonSave: TButton;
    ButtonClose: TButton;
    Label2: TLabel;
    MonthInfo: TLabel;
    StoredProc: TStoredProc;
    Table: TTable;
    procedure save;
    procedure recalcdays;
    procedure filldayvalue;
    procedure rebuildcalendar;
    procedure FormCreate(Sender: TObject);
    procedure ButtonMonthMinClick(Sender: TObject);
    procedure ButtonYearMinClick(Sender: TObject);
    procedure mPanelClick(Sender: TObject);
    procedure EndMonthClick(Sender: TObject);
    procedure CurdateClick(Sender: TObject);
    procedure BegYearClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditDayExit(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    mDay : word;
    mMonth: word;
    mYear : word;
    mDate : tdate;
    mcell : integer;

  end;

var
  CalendarForm: TCalendarForm;
  mArray : array [0 .. 35] of TMyDay; // массив значений

  
implementation

{$R *.dfm}
{-----------------------------------------------------------------------------
  Процедура: firstdayofmonth
  Автор:    Administrator
  Аргументы: _date : tdate
  Результат:    tdate - первый день месяца
-----------------------------------------------------------------------------}

function firstdayofmonth(_date : tdate): tdate;
var _myyear, _mymonth, _day : word;
begin
  decodedate(_date, _myyear, _mymonth, _day);
  result := encodedate(_myyear, _mymonth, 1);

end;

{-----------------------------------------------------------------------------
  Процедура: getmonthstring
  Автор:    Administrator
  Аргументы: month: integer
  Результат:    string возвращает месяц строкой
-----------------------------------------------------------------------------}

function getmonthstring(month: integer): string;
begin
  case month of
    1: result := 'Январь';
    2: result := 'Февраль';
    3: result := 'Март';
    4: result := 'Апрель';
    5: result := 'Май';
    6: result := 'Июнь';
    7: result := 'Июль';
    8: result := 'Август';
    9: result := 'Сентябрь';
    10: result := 'Октябрь';
    11: result := 'Ноябрь';
    12: result := 'Декабрь';
   end;
end;

{-----------------------------------------------------------------------------
  Procedure: TCalendarForm.rebuildcalendar
  Author:    Администратор
  Date:      15-июн-2004
  Arguments: None
  Result:    None
   Перестраивает календарь
-----------------------------------------------------------------------------}

procedure TCalendarForm.rebuildcalendar;
var i, j : integer;
    days : integer;
    _dayofweek : integer;
    curday : tdate;
begin
 // mdate := encodedate(mYear, mMonth, mDay);
  _dayofweek := dayofweek(firstdayofmonth(mDate)) - 1;


  // очистить ячейки и их значение, цвет и выпусклость.
  for i := 0 to 41 do
    begin
      mArray[i].Cell.Caption := '';
      mArray[i].day          := 0;
      mArray[i].Cell.Color   := clBtnFace;
      mArray[i].Cell.font.Color := clWindowText;
      mArray[i].Cell.BorderStyle := bsNone
    end;

  j := 1;

  // количество дней месяца
  days := (DaysInAMonth(myear, mmonth) - 1);
  if _dayofweek = 0 then _dayofweek := 7;


  // заполнение массива дней календаря
  for i := 0 to days do
    begin
      curday := encodedate(mYear, mMonth, i + 1);

      mArray[i + _dayofweek - 1].Cell.Caption := inttostr(j);
      mArray[i + _dayofweek - 1].mdate        := curday;
      mArray[i + _dayofweek - 1].day          := j;

      j := j + 1;

      // сегодняшнюю дату выделить
      if curday = today then
        begin
          mArray[i + _dayofweek - 1].Cell.color := clAqua;
          mcell := i + _dayofweek - 1;
        end;

      // текущую выбранную дату веделить
      if (mArray[i + _dayofweek - 1].mdate <> mdate) then
        mArray[i + _dayofweek - 1].Cell.BorderStyle := bsNone
       else
         mArray[i + _dayofweek - 1].Cell.BorderStyle := bssingle;

      // заполнение календаря по таблице
      if table.Locate('daydate',curday, [loCaseInsensitive]) then
        mArray[i + _dayofweek - 1].duration := table.Fields[1].asinteger
       else
         mArray[i + _dayofweek - 1].duration := 0;

      // выходные и праздничные дни выделить
      if mArray[i + _dayofweek - 1].duration = 0 then
         mArray[i + _dayofweek - 1].Cell.Font.Color := clRed
       else
          mArray[i + _dayofweek - 1].Cell.font.Color := clWindowText;


    end;

    // итог по месяцу
    PanelTop.Caption := GetMonthString(mMonth) + ' ' + inttostr(mYear);
    filldayvalue;

end;

procedure TCalendarForm.FormCreate(Sender: TObject);
var i,k : integer;
    Temp: TComponent;
    myday: TMyDay;

begin

  table.open;

  // заполнение массива панелек и их значения
  for I := 0 to ComponentCount - 1 do
  begin
    Temp := Components[I];
    if Temp is tpanel then
      if leftstr(Temp.Name,1) = 'm' then
        begin
           myday := tmyday.Create;
           myday.Cell := tpanel(Temp);
           k := strtoint(myday.Cell.Caption);
           mArray[k - 1]  := myday;
        end;

  end;

  // календарь начинается с сегодняшней даты
  mDate := now;
  mday  := DayOfTheMonth(mdate);
  mmonth:= MonthOfTheYear(mdate);
  myear := YearOf(mdate);

  // построение календаря
  rebuildcalendar;
  tPanel(sender).BorderStyle := bssingle;
  recalcdays;

end;

{-----------------------------------------------------------------------------
  Процедура: TCalendarForm.ButtonMonthMinClick
  Автор:    Administrator
  Аргументы: Sender: TObject
  Результат:    None - сдвиг календаря на месяц
-----------------------------------------------------------------------------}
procedure TCalendarForm.ButtonMonthMinClick(Sender: TObject);
begin

  save;

  if tButton(Sender) = ButtonMonthMin then
    begin
      mMonth := mMonth - 1;
      if mMonth < 1 then
        begin
          mYear := mYear - 1;
          mMonth := 12;
        end;
    end
   else
     begin
       mMonth := mMonth + 1;
       if mday > DaysInAMonth(myear, mmonth)  then
         mday := DaysInAMonth(myear, mmonth);

       if mMonth > 12 then
         begin
           mMonth := 1;
           mYear := mYear + 1;

         end;
     end;

    mdate := encodedate(myear,mmonth,mday);
    rebuildcalendar;
end;


{-----------------------------------------------------------------------------
  Процедура: TCalendarForm.ButtonYearMinClick
  Автор:    Administrator
  Аргументы: Sender: TObject
  Результат:    None
    Сдвиг календаря на год
-----------------------------------------------------------------------------}

procedure TCalendarForm.ButtonYearMinClick(Sender: TObject);
begin

  save;

  if tButton(Sender) = ButtonYearMin then
    mYear := mYear - 1
   else
     mYear := mYear + 1;

  mdate := encodedate(myear,mmonth, mday);
  rebuildcalendar;
end;


procedure TCalendarForm.filldayvalue;
begin
   EditDay.Text := inttostr(mArray[mcell].duration);

end;

{-----------------------------------------------------------------------------
  Процедура: TCalendarForm.mPanelClick
  Автор:    Administrator
  Аргументы: Sender: TObject
  Результат:    None
    Обработка нажатия панельки календаря
-----------------------------------------------------------------------------}
procedure TCalendarForm.mPanelClick(Sender: TObject);
var i : integer;
begin
  EditDayExit(sender);

  for i := 0 to 41 do
    begin
      mArray[i].Cell.BorderStyle := bsNone;
      if mArray[i].Cell.Name = tPanel(sender).Name then
        if mArray[i].Cell.caption <> '' then
          begin
           mday  := strtoint(mArray[i].Cell.caption);
           mdate := encodedate(myear, mmonth, mday);
           mcell := i;
          end;
    end;

  tPanel(sender).BorderStyle := bssingle;
  filldayvalue;

end;
{-----------------------------------------------------------------------------
  Процедура: TCalendarForm.EndMonthClick
  Автор:    Administrator
  Аргументы: Sender: TObject
  Результат:    None
    Перейти на конец месяца
-----------------------------------------------------------------------------}
procedure TCalendarForm.EndMonthClick(Sender: TObject);
var _myyear, _mymonth, _day : word;
begin
 //  mdate := today;
   decodedate(mdate,_myyear,_mymonth, _day);
   myear := _myyear;
   mmonth:= _mymonth;

   if tmenuitem(sender).Name = 'BegMonth' then
      mday  := 1
    else
        mday  := daysinmonth(mdate);

   mdate := encodedate(myear, mmonth, mday);

   rebuildcalendar;

end;

{-----------------------------------------------------------------------------
  Процедура: TCalendarForm.CurdateClick
  Автор:    Administrator
  Аргументы: Sender: TObject
  Результат:    None
    Переход на текущую дату
-----------------------------------------------------------------------------}
procedure TCalendarForm.CurdateClick(Sender: TObject);
var _myyear, _mymonth, _day : word;
begin
   mdate := today;
   decodedate(mdate,_myyear,_mymonth, _day);
   myear := _myyear;
   mmonth:= _mymonth;
   mday  := _day;
   rebuildcalendar;

end;
{-----------------------------------------------------------------------------
  Процедура: TCalendarForm.BegYearClick
  Автор:    Administrator
  Аргументы: Sender: TObject
  Результат:    None
    Переход на начало месяца
-----------------------------------------------------------------------------}
procedure TCalendarForm.BegYearClick(Sender: TObject);
var _myyear, _mymonth, _day : word;
begin
   decodedate(mdate,_myyear,_mymonth, _day);
   myear := _myyear;
   if tmenuitem(sender).Name = 'BegYear' then
     begin
       mmonth:= 1;
       mday  := 1;
     end
    else
      begin
       mmonth:= 12;
       mday  := 31;
      end;
   mdate := encodedate(myear, mmonth, mday);

   rebuildcalendar;

end;

procedure TCalendarForm.ButtonCloseClick(Sender: TObject);
begin
  table.close;

  close;
end;

procedure TCalendarForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  table.active := false;

  action := caFree;
end;

{-----------------------------------------------------------------------------
  Процедура: recalcdays
  Date:      23-июн-2004
  Вход:      None
  Выход:    None
  Описаниве:
-----------------------------------------------------------------------------}
procedure TCalendarForm.recalcdays;
var i, sum, days : integer;
begin
  sum := 0;
  days:= 0;
  for i := 0 to 41 do
    begin
      sum := sum + mArray[i].duration;
      if mArray[i].duration > 0 then
        days := days + 1;
    end;
    MonthInfo.caption := 'Дней: ' + inttostr(days) + chr(13)+
                 'часов: ' + inttostr(sum);

end;

{-----------------------------------------------------------------------------
  Процедура: TCalendarForm.EditDayExit
  Автор:     Администратор
  Дата:      17-июн-2004
  Аргументы: Sender: TObject
  Выход:     None
  Описание: Записать значение в таблицу
-----------------------------------------------------------------------------}

procedure TCalendarForm.EditDayExit(Sender: TObject);
begin


  if strtoint(trim(editDay.Text)) > 23 then
    begin
     editDay.Text := '0';
     abort;
    end;

   mArray[mcell].duration := strtoint(trim(editDay.Text));
     if mArray[mcell].duration = 0 then
        mArray[mcell].Cell.Font.Color := clRed
      else
        mArray[mcell].Cell.font.Color := clWindowText;

   recalcdays;

end;

{-----------------------------------------------------------------------------
  Процедура: TCalendarForm.save
  Date:      23-июн-2004
  Вход:      None
  Выход:    None
  Описаниве:  сохранить календарь в БД
-----------------------------------------------------------------------------}
procedure TCalendarForm.save;
var i: integer;
begin
   for i := 0 to 41 do
     begin
       if mArray[i].cell.Caption <> '' then
         begin
           StoredProc.Close;
           StoredProc.Params[0].asdate    := mArray[i].mdate;
           StoredProc.Params[1].AsInteger := mArray[i].duration;
           StoredProc.Prepare;
           StoredProc.ExecProc;
         end;
     end;
end;


procedure TCalendarForm.ButtonSaveClick(Sender: TObject);
begin
  save;
end;

end.
