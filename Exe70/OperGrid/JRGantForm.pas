unit JRGantForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, ToolWin, ComCtrls, DB, DBTables,
  StdCtrls, RXGrids, DateUtil, Math, InfOperForm, DateUtils;

type
  //Структура содержит информацию о клетке GantGrida
  TBusyTable = record
    Time : TDateTime;   //дата и время начала либо окончания операции
    Col  : integer;     //№ колонки
    Row  : integer;     //№ строки
    Busy : Boolean;     //True - занято, False - свободно
    Cur  : Integer;     //Текущая операция 0 - не текущая, 1 - текущая,
                        // 2 - текущая выделенная, 3 - не текущая выделенная операция
  end;

  //Сокращенная структура TBusyTable, для сортировки времени из массива TimeBegOper
  TMas = record
    Id_Wrkr : Integer; //ID работника находящегося в позиции Index
    Id_Eqpt : Integer;  //ID оборудования находящегося в позиции Index
    Index   : Integer;     //№ строки исполнителя операции
  end;

  TJR_GantForm = class(TForm)
    Panel1: TPanel;
    OperGrid: TDBGridEh;
    Splitter1: TSplitter;
    GantOperQuery: TQuery;
    OperDataSource: TDataSource;
    ToolBar1: TToolBar;
    GantGrid: TStringGrid;
    WEVQuery: TQuery;
    DateTimeQuery: TQuery;
    UpdateOrd1StoredProc: TStoredProc;
    HintQuery: TQuery;
    InfoOperQuery: TQuery;
    ButtonClose: TButton;
    procedure OperGridCellClick(Column: TColumnEh);
    procedure SelectField;
    function TextWidth(BegTxt, EndTxt: String; Col : Integer): String ;
    function Space(sp : integer): String;
    procedure BrushCol;
    procedure FillCells(ColumnBeg, ColumnEnd, Row, Cur: Integer);
    procedure AllFillCells;
//    function SortMas(Mas : array of TDateTime): TDateTime;
    procedure OperGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure GantGridDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure OperGridDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure GantGridEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure TDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
    procedure GantGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GantGridClick(Sender: TObject);
    procedure GantGridRowMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure GantGridTopLeftChanged(Sender: TObject);
    procedure TStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure OperGridMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GantGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GantGridDblClick(Sender: TObject);
    procedure GantOperQueryAfterScroll(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    GANT_INFO : TInf_OperForm;
    constructor CreateN(AOwner: TForm; _ID_ORDER, _period : integer);
    destructor Destroy; override;
  end;

var
  JR_GantForm: TJR_GantForm;
  TableName  : string;         // имя таблицы журнала
//  IDDoc      : Integer;      // ID документа
  TimeShape   : TShape;        // прямоугольник времени
  Drag_X, Drag_Y : Integer;    // Координаты перетаскиваемого времени
  Mouse_X, Mouse_Y : Integer;  // Координаты Мыши
  TimeBegOper : array of TBusyTable;//Массив дат и времени выполнения операций в последовательности
                                    //начало операции, завершение операции
  ColumnTime : array of TBusyTable; //сортированный массив времени выполнения операций
                                    //(даты и время окончания стоят не последовательно,
                                    //а в порядке возрастания). В этом же массиве находится
                                    //вся отображаемая линейка времени. Нулевая ячейка
                                    //содержит информацию о первом столбце временной линейки
  Executer: array of TMas; //массив исполнителей иекщей операции
  DateBeg : TDateTime;  //дата и время начала просмотра диаграммы Ганта
  DateEnd : TDateTime;  //дата и время завершения просмотра диаграммы Ганта
  ID_ORDER: integer;
  PERIOD  : integer;

implementation

uses Types, ParamForm, MainFormLib;

{$R *.dfm}

constructor TJR_GantForm.createN(AOwner: TForm; _ID_ORDER, _Period : integer);
var day, mon, year :word;
begin

  inherited Create(AOwner);

  ID_ORDER := _ID_ORDER;
  Period   := _Period;

  SetLength(TimeBegOper, 0);
  SetLength(ColumnTime, 0);

  year := 2000 + (Period - 1) div 12;
  mon  := Period - (Period div 12) * 12 + 1;

  DateBeg := encodedate(year, mon, 1);
  DateEnd := encodedate(year, mon, DaysPerMonth(year, mon));

  GantGrid.Font.Size := 8; //размер букв в диаграмме ганта;

  // создание запроса для формы
  with GantOperQuery do
    begin

      Close;

      sql.clear;
      sql.add('Select * From BROWSE_GANTOPER_PROC(:ID)');
      params[0].asinteger := ID_ORDER;

      open;

    end;

  Tablename := 'jr_gant';
  caption   := 'Gant Оперативный журнал заказов';

  HelpContext := 350;

  GantOperQuery.Last;


//  SelectField;

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

end;

destructor TJR_GantForm.Destroy;
begin
  inherited;
end;


procedure TJR_GantForm.OperGridCellClick(Column: TColumnEh);
begin
       SelectField;

end;

{Процедура при выделении операции по ее коду высвечивает в диаграмме Ганта всех исполнителей}
procedure TJR_GantForm.SelectField;
Var Wrkr_Size : Integer;
    Eqpt_size : Integer;
    i : Integer;
    StrDate : String; //строка формирования даты для массива TimeBegOper
    d,t     : String;
begin

        SetLength(TimeBegOper, 0);
        SetLength(ColumnTime, 0);
        SetLength(Executer, 0);

       {Начальное значение ширины вдух первых столбцов}
       Wrkr_Size := 50;
       Eqpt_size := 50;

       {Запрос об исполнителях операии}
       WEVQuery.Close;
       WEVQuery.ParamByName('vop').AsInteger := GantOperQuery.FieldByName('ID_VOP').AsInteger;
       WEVQuery.ParamByName('wrkr').AsInteger := 0;
       WEVQuery.ParamByName('eqpt').AsInteger := 0;
       WEVQuery.Open;

       //количество строк в таблице GantGrid = количеству исполнителей
       GantGrid.RowCount := WEVQuery.RecordCount+1;
       If GantGrid.RowCount = 1 Then
       begin   //если ни кто не делает эту операцию
            GantGrid.FixedRows := 0;
            GantGrid.Color := clBtnFace;
       end
        else
        begin
              GantGrid.FixedRows := 1;
              GantGrid.Color := clWindow;
        end;


       GantGrid.FixedCols := 2;
       GantGrid.ColCount  := 3;  //свободных (не фиксированных) ячеек нет

       {Очистка таблицы}
{       For i:=0 to GantGrid.RowCount do
        For j:=0 to GantGrid.ColCount do
          GantGrid.Cells[j,i] := '';}

       {Заполнение 2-х первых столбцов}
       For i:=1 to WEVQuery.RecordCount do
       begin
          GantGrid.Cells[0,i] := WEVQuery.FieldByName('WRKR_NAME').AsString;
          GantGrid.Cells[1,i] := WEVQuery.FieldByName('EQPT_NAME').AsString;

          SetLength(Executer, Length(Executer)+1);
          Executer[Length(Executer)-1].Id_Wrkr := WEVQuery.FieldByName('WRKR_ID').AsInteger;
          Executer[Length(Executer)-1].Id_Eqpt := WEVQuery.FieldByName('EQPT_ID').AsInteger;
          Executer[Length(Executer)-1].Index   := 1;

          //ищем мах длину ФИО и название станка для установки ширины 2-х первых столбцов
          if Wrkr_Size < GantGrid.Canvas.TextWidth(WEVQuery.FieldByName('WRKR_NAME').AsString)+5 Then
              Wrkr_Size := GantGrid.Canvas.TextWidth(WEVQuery.FieldByName('WRKR_NAME').AsString)+5;
          if Eqpt_Size < GantGrid.Canvas.TextWidth(WEVQuery.FieldByName('Eqpt_NAME').AsString)+5 Then
              Eqpt_Size := GantGrid.Canvas.TextWidth(WEVQuery.FieldByName('Eqpt_NAME').AsString)+5;

          DateTimeQuery.Close;
          DateTimeQuery.ParamByName('wrkr_id').AsInteger := WEVQuery.FieldByName('WRKR_ID').AsInteger;
          DateTimeQuery.ParamByName('eqpt_id').AsInteger := WEVQuery.FieldByName('EQPT_ID').AsInteger;
          DateTimeQuery.ParamByName('date_in').AsDate    := DateBeg;
          DateTimeQuery.ParamByName('date_out').AsDate   := DateEnd;
          DateTimeQuery.Open;

          While not DateTimeQuery.Eof do
          begin
              //дата и время начала операции
              SetLength(TimeBegOper, Length(TimeBegOper)+1);

              d:= TimeToStr(DateBeg);
              t:= TimeToStr(StrToDateTime(DateTimeQuery.FieldByName('date_beg').AsString + ' ' +
                       DateTimeQuery.FieldByName('time_beg').AsString));

              {If (StrToDateTime(DateTimeQuery.FieldByName('date_beg').AsString + ' ' +
                       DateTimeQuery.FieldByName('time_beg').AsString) < DateBeg) Then
                  StrDate := DateToStr(DateBeg) + ' ' + '8:00'

               else}  StrDate := DateTimeQuery.FieldByName('date_beg').AsString + ' ' +
                       DateTimeQuery.FieldByName('time_beg').AsString;


              TimeBegOper[Length(TimeBegOper)-1].Time := StrToDateTime(StrDate);
              TimeBegOper[Length(TimeBegOper)-1].Row := i; //строка в Grid-е = исполнителю
              TimeBegOper[Length(TimeBegOper)-1].Busy := True;



              //дата и время окончания операции
              SetLength(TimeBegOper, Length(TimeBegOper)+1);

              {If StrToDateTime(DateTimeQuery.FieldByName('date_beg').AsString + ' ' +
                       DateTimeQuery.FieldByName('time_beg').AsString) > DateEnd Then
                  StrDate := DateToStr(DateEnd) + ' ' + '17:00'

               else}  StrDate := DateTimeQuery.FieldByName('date_end').AsString + ' ' +
                       DateTimeQuery.FieldByName('time_end').AsString;

              TimeBegOper[Length(TimeBegOper)-1].Time := StrToDateTime(StrDate);
              TimeBegOper[Length(TimeBegOper)-1].Row := i; //строка в Grid-е = исполнителю
              TimeBegOper[Length(TimeBegOper)-1].Busy := False;

              If (DateTimeQuery.FieldByName('LINENO').AsInteger = GantOperQuery.FieldByName('LINENO').AsInteger) and
                 (DateTimeQuery.FieldByName('ID_ORDER').AsInteger = GantOperQuery.FieldByName('ID_ORDER').AsInteger) Then
              begin
                    TimeBegOper[Length(TimeBegOper)-1].Cur := 1;
                    TimeBegOper[Length(TimeBegOper)-2].Cur := 1;
              end
               else
               begin
                      TimeBegOper[Length(TimeBegOper)-1].Cur := 0;
                      TimeBegOper[Length(TimeBegOper)-1].Cur := 0;
               end;       

              DateTimeQuery.Next;
          end;

{          For j:=0 to Length(TimeBegOper)-1 do
          begin
              d:= DateToStr(TimeBegOper[j]);
              t:= TimeToStr(TimeBegOper[j]);
          end;}

          WEVQuery.Next;
       end;

       {Установка ширины столбцов по длине максимального слова}
       GantGrid.ColWidths[0] := Wrkr_Size;
       GantGrid.ColWidths[1] := Eqpt_Size;

       BrushCol;

end;

{процедура рисования линейки времени}
procedure TJR_GantForm.BrushCol;
Var ColTime : TDateTime;
    Minute  : String;   //минуты первого дня
    i,j : integer;
    Min : TDateTime;
    Pos : Integer;
 Column : Integer;
   Fill : Boolean;     //клетка закрашена или нет для TimeBegOper;
    Tmp : Integer;     //содержит при обмене информацию о Mas[i].Row
Mas : array of Integer;
    d,t : String;
begin

       Fill := False;
       
       Column := 2; //колонка с которой начинается заполнение Диаграмы Ганта
       SetLength(ColumnTime, 0);

       //сортировка массива времени начала и окончания работ
       SetLength(Mas, 0);
       SetLength(Mas, Length(TimeBegOper));
//       Copy(TimeBegOper, 0, Length(TimeBegOper));
       For i:=0 to Length(TimeBegOper)-1 do
       begin
          Mas[i] := i;
       end;

       For i:=0 to Length(Mas)-1 do
       begin
         Min := TimeBegOper[Mas[i]].Time;
         Pos := i;
         For j:=i+1 to Length(Mas)-1 do
         begin
            if (Min > TimeBegOper[Mas[j]].Time) Then
            begin
                 Min := TimeBegOper[Mas[j]].Time;
                 Pos := j;
            end;
         end;
         Tmp := Mas[Pos];
         Mas[Pos] := Mas[i];
         Mas[i]   := Tmp
       end;


       ColTime:=DateBeg;     //начало смены   //НУЖНА ЗАМЕНА НА РЕАЛЬНУЮ ДАТУ
       j := 0;  //индекс массива Mas
       GantGrid.ColCount:=3;
       GantGrid.ColCount := GantGrid.ColCount+1; //прибавляю 1 колонку
            {  d:= TimeToStr(ColTime);
              t:= TimeToStr(TimeBegOper[Mas[j]].Time);}

       //рисую время для первой ячейки (минуты сохраняю отдельно)
       If j<Length(Mas) Then
       begin
         //ПРИ РАВЕНСТВЕ ДАТ
         If CompareDate(ColTime, TimeBegOper[Mas[j]].Time) = 0 Then
         begin
           //ColTime >= Mas[j].Time
           If (CompareTime(ColTime, TimeBegOper[Mas[j]].Time) = 0) or
              (CompareTime(ColTime, TimeBegOper[Mas[j]].Time) = 1)  Then
           begin
               Fill := TimeBegOper[Mas[j]].Busy;

               SetLength(ColumnTime, Length(ColumnTime)+1);

               ColumnTime[Length(ColumnTime)-1].Time := TimeBegOper[Mas[j]].Time;
               ColumnTime[Length(ColumnTime)-1].Col  := Column;
               TimeBegOper[Mas[j]].Col := 2;

               d:= TimeToStr(ColTime); //отладка
               t:= TimeToStr(TimeBegOper[Mas[j]].Time); //отладка

               Column:=Column + 1;

               //Время в массиве TimeBegOper[Mas[j]].Time может идти одинаковое
               // подряд несколько раз, для перехода к новому значению используем цикл
               i:=j;
               While (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                     (j < Length(TimeBegOper)-1) do
               begin
                  If Fill = True Then
                     TimeBegOper[Mas[j]].Col := Column
                   else //при завершениее заполнения полосы времени цветом в диаграме Ганта
                      TimeBegOper[Mas[j]].Col := Column-1;

                  ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                  j:=j+1;
                  Fill := TimeBegOper[Mas[j]].Busy;  //чтобы знать что ищем окончание операции

               end;

               If (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                  (j = Length(TimeBegOper)-1) Then
               begin
                  If Fill = True Then
                     TimeBegOper[Mas[j]].Col := Column
                   else //при завершении заполнения полосы времени цветом в диаграме Ганта
                      TimeBegOper[Mas[j]].Col := Column-1;

                  ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                  j:=j+1;
               end;


               //Если Fill = True то идут заполненные клетки до следующего значения
               //Mas[j] - время завершения операции
               If ColumnTime[Length(ColumnTime)-1].Busy = True Then
               begin
                  ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j]].Row;
               end
                else
                begin
                   ColumnTime[Length(ColumnTime)-1].Row  := 0;
                end;


           end
            else
            begin
                SetLength(ColumnTime, Length(ColumnTime)+1);

                ColumnTime[Length(ColumnTime)-1].Time := ColTime;
                ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                ColumnTime[Length(ColumnTime)-1].Col  := Column;

                Column:=Column + 1;
                ColTime:=IncHour(ColTime,1);

                //Если Fill = True то идут заполненные клетки до следующего значения
                //Mas[j] - время завершения операции
                If Fill = True Then
                begin
                   ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j]].Row;
                end
                 else
                 begin
                    ColumnTime[Length(ColumnTime)-1].Row  := 0;
                 end;

            end;
         end
           //КОГДА ПЕРЕЧИСЛЯЕМАЯ ДАТА МЕНЬШЕ ЧЕМ ДАТА В МАССИВЕ
           else
           begin
               //ColTime < Mas[j].Time
               If CompareDate(ColTime, TimeBegOper[Mas[j]].Time) = -1 Then
               begin
                  SetLength(ColumnTime, Length(ColumnTime)+1);

                  ColumnTime[Length(ColumnTime)-1].Time := ColTime;
                  ColumnTime[Length(ColumnTime)-1].Col  := Column;
                  ColumnTime[Length(ColumnTime)-1].Busy := Fill;

                  Column:=Column + 1;

                  //Если Fill = True то идут заполненные клетки до следующего значения
                  //Mas[j] - время завершения операции
                  If Fill = True Then
                  begin
                     ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j]].Row;
                  end
                   else
                   begin
                      ColumnTime[Length(ColumnTime)-1].Row  := 0;
                   end;

                  If HourOf(IncHour(ColTime,1))>17 Then
                  begin
                    ColTime := IncDay(ColTime);
                    ColTime := StrToDateTime(DateToStr(ColTime)+' 8:00');
                  end
                   else ColTime:=IncHour(ColTime,1);
               end
                 //КОГДА ПЕРЧИСЛЯЕМАЯ ДАТА БОЛЬШЕ ЧЕМ ДАТА В МАССИВЕ
                 else
                 begin
                     //ColTime > Mas[j].Time
                     If CompareDate(ColTime, TimeBegOper[Mas[j]].Time) = 1 Then
                     begin
                        Fill := TimeBegOper[Mas[j]].Busy;

                        SetLength(ColumnTime, Length(ColumnTime)+1);

                        ColumnTime[Length(ColumnTime)-1].Time := TimeBegOper[Mas[j]].Time;
                        ColumnTime[Length(ColumnTime)-1].Col  := Column;
                        TimeBegOper[Mas[j]].Col := 2;

                        Column:=Column + 1;

                        //Время в массиве TimeBegOper[Mas[j]].Time может идти одинаковое
                        // подряд несколько раз, для перехода к новому значению используем цикл
                        i:=j;
                        While (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                              (j < Length(TimeBegOper)-1) do
                        begin
                            If Fill = True Then
                               TimeBegOper[Mas[j]].Col := Column
                            else //при завершениее заполнения полосы времени цветом в диаграме Ганта
                                TimeBegOper[Mas[j]].Col := Column-1;

                            ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                            j:=j+1;
                            Fill := TimeBegOper[Mas[j]].Busy;  //чтобы знать что ищем окончание операции

                        end;

                        If (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                           (j = Length(TimeBegOper)-1) Then
                        begin
                            If Fill = True Then
                               TimeBegOper[Mas[j]].Col := Column
                            else //при завершении заполнения полосы времени цветом в диаграме Ганта
                                TimeBegOper[Mas[j]].Col := Column-1;

                            ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                            j:=j+1;
                        end;


                        //Если Fill = True то идут заполненные клетки до следующего значения
                        //Mas[j] - время завершения операции
                        If ColumnTime[Length(ColumnTime)-1].Busy = True Then
                        begin
                            ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j]].Row;
                        end
                         else
                         begin
                             ColumnTime[Length(ColumnTime)-1].Row  := 0;
                         end;
                     end;
                 end;
           end;
       end
        else
        begin
           SetLength(ColumnTime, Length(ColumnTime)+1);

           ColumnTime[Length(ColumnTime)-1].Time := ColTime;
           ColumnTime[Length(ColumnTime)-1].Col  := Column;
           ColumnTime[Length(ColumnTime)-1].Busy := Fill;

           Column:=Column + 1;
           ColTime:=IncHour(ColTime,1);

           //Если Fill = True то идут заполненные клетки до следующего значения
           //Mas[j] - время завершения операции
           If Fill = True Then
           begin
              ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j]].Row;
           end
            else
            begin
               ColumnTime[Length(ColumnTime)-1].Row  := 0;
            end;

        end;


       //заполняю остальные колонки в диаграме Ганта, кроме последней
//       i:=Column;
       While ColTime<=DateEnd do
       begin

           GantGrid.ColCount := GantGrid.ColCount+1;

           If j<Length(Mas) Then
           begin
             //ПРИ РАВЕНСТВЕ ДАТ
             If CompareDate(ColTime, TimeBegOper[Mas[j]].Time) = 0 Then
             begin
               //ColTime >= Mas[j].Time
               If (CompareTime(ColTime, TimeBegOper[Mas[j]].Time) = 0) or
                  (CompareTime(ColTime, TimeBegOper[Mas[j]].Time) = 1)  Then
               begin
                   Fill := TimeBegOper[Mas[j]].Busy;

                   SetLength(ColumnTime, Length(ColumnTime)+1);

                   ColumnTime[Length(ColumnTime)-1].Time := TimeBegOper[Mas[j]].Time;
                   ColumnTime[Length(ColumnTime)-1].Col  := Column;

                   GantGrid.Cells[Column-1,0] :=
                              TextWidth(Minute, IntToStr(HourOf(TimeBegOper[Mas[j]].Time)), Column-1);
                   Minute := IntToStr(MinuteOf(TimeBegOper[Mas[j]].Time));
                   If Length(Minute) = 1 Then Minute:='0'+Minute;

              d:= TimeToStr(ColTime);
              t:= TimeToStr(TimeBegOper[Mas[j]].Time);

                   //при равенстве времени
                   If (CompareTime(ColTime, TimeBegOper[Mas[j]].Time) = 0)  Then
                       ColTime:=IncHour(ColTime, 1);

                   //Время в массиве TimeBegOper[Mas[j]].Time может идти одинаковое
                   // подряд несколько раз, для перехода к новому значению используем цикл
                   d:=IntToStr(Length(TimeBegOper));
                   i:=j;
{                   If (j = Length(TimeBegOper)-1) Then
                   begin
                      If Fill = True Then
                         TimeBegOper[Mas[j]].Col := Column
                       else //при завершении заполнения полосы времени цветом в диаграме Ганта
                          TimeBegOper[Mas[j]].Col := Column-1;

                      ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                      j:=j+1;
                   end
                    else
                    begin
                       While (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                             (j < Length(TimeBegOper)-1) do
                       begin
                          If Fill = True Then
                             TimeBegOper[Mas[j]].Col := Column
                           else //при завершениее заполнения полосы времени цветом в диаграме Ганта
                              TimeBegOper[Mas[j]].Col := Column-1;

                          ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                          j:=j+1;
                          Fill := TimeBegOper[Mas[j]].Busy;  //чтобы знать что ищем окончание операции

                        end
                    end;
}

                   While (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                         (j < Length(TimeBegOper)-1) do
                   begin
                      If Fill = True Then
                         TimeBegOper[Mas[j]].Col := Column
                       else //при завершениее заполнения полосы времени цветом в диаграме Ганта
                          TimeBegOper[Mas[j]].Col := Column-1;

                      ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                      j:=j+1;
                      Fill := TimeBegOper[Mas[j]].Busy;  //чтобы знать что ищем окончание операции

                   end;

                   If (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                      (j = Length(TimeBegOper)-1) Then
                   begin
                      If Fill = True Then
                         TimeBegOper[Mas[j]].Col := Column
                       else //при завершении заполнения полосы времени цветом в диаграме Ганта
                          TimeBegOper[Mas[j]].Col := Column-1;

                      ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                      j:=j+1;
                   end;


                    //Если Fill = True то идут заполненные клетки до следующего значения
                    //Mas[j] - время завершения операции
                   If ColumnTime[Length(ColumnTime)-1].Busy = True Then
                   begin
                      ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j-1]].Row;
                   end
                    else
                    begin
                       ColumnTime[Length(ColumnTime)-1].Row  := 0;
                    end;

               end
                else
                begin
                    SetLength(ColumnTime, Length(ColumnTime)+1);

              d:= TimeToStr(ColTime);
              t:= TimeToStr(TimeBegOper[Mas[j]].Time);

                    ColumnTime[Length(ColumnTime)-1].Time := ColTime;
                    ColumnTime[Length(ColumnTime)-1].Busy := ColumnTime[Length(ColumnTime)-2].Busy;
                    ColumnTime[Length(ColumnTime)-1].Col  := Column;

                    //Если Fill = True то идут заполненные клетки до следующего значения
                    //Mas[j] - время завершения операции
                    If ColumnTime[Length(ColumnTime)-1].Busy = True Then
                    begin
                        ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j]].Row;
                    end
                     else
                     begin
                         ColumnTime[Length(ColumnTime)-1].Row  := 0;
                     end;

                    GantGrid.Cells[Column-1,0] := TextWidth(Minute, IntToStr(HourOf(ColTime)), Column-1);
                    Minute := IntToStr(MinuteOf(ColTime));
                    If Length(Minute) = 1 Then Minute:='0'+Minute;
                    ColTime:=IncHour(ColTime, 1);
                end;
             end
               //КОГДА ПЕРЕЧИСЛЯЕМАЯ ДАТА МЕНЬШЕ ЧЕМ ДАТА В МАССИВЕ
               else
               begin
                   //ColTime < Mas[j].Time
                   If CompareDate(ColTime, TimeBegOper[Mas[j]].Time) = -1 Then
                   begin
                      SetLength(ColumnTime, Length(ColumnTime)+1);

                      ColumnTime[Length(ColumnTime)-1].Time := ColTime;
                      ColumnTime[Length(ColumnTime)-1].Busy := ColumnTime[Length(ColumnTime)-2].Busy;
                      ColumnTime[Length(ColumnTime)-1].Col  := Column;

                      //Если Fill = True то идут заполненные клетки до следующего значения
                      //Mas[j] - время завершения операции
                      If ColumnTime[Length(ColumnTime)-1].Busy = True Then
                      begin
                          ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j]].Row;
                      end
                       else
                       begin
                           ColumnTime[Length(ColumnTime)-1].Row  := 0;
                       end;

                      GantGrid.Cells[Column-1,0] := TextWidth(Minute, IntToStr(HourOf(ColTime)), Column-1);
                      Minute := IntToStr(MinuteOf(ColTime));
                      If Length(Minute) = 1 Then Minute:='0'+Minute;
                      ColTime:=IncHour(ColTime, 1);
                   end
                     //КОГДА ПЕРЧИСЛЯЕМАЯ ДАТА БОЛЬШЕ ЧЕМ ДАТА В МАССИВЕ
                     else
                     begin
                         //ColTime > Mas[j].Time
                         If CompareDate(ColTime, TimeBegOper[Mas[j]].Time) = 1 Then
                         begin
                            Fill := TimeBegOper[Mas[j]].Busy;

                            SetLength(ColumnTime, Length(ColumnTime)+1);

                            ColumnTime[Length(ColumnTime)-1].Time := TimeBegOper[Mas[j]].Time;
                            ColumnTime[Length(ColumnTime)-1].Col  := Column;

                            If Fill = True Then
                                TimeBegOper[Mas[j]].Col := Column
                             else //при завершениее заполнения полосы времени цветом в диаграме Ганта
                                 TimeBegOper[Mas[j]].Col := Column-1;


                            GantGrid.Cells[Column-1,0] :=
                                    TextWidth(Minute, IntToStr(HourOf(TimeBegOper[Mas[j]].Time)), Column-1);

                            Minute := IntToStr(MinuteOf(TimeBegOper[Mas[j]].Time));
                            If Length(Minute) = 1 Then Minute:='0'+Minute;

                            //Время в массиве TimeBegOper[Mas[j]].Time может идти одинаковое
                            // подряд несколько раз, для перехода к новому значению используем цикл
                            i:=j;
                            While (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                                  (j < Length(TimeBegOper)-1) do
                            begin
                              If Fill = True Then
                                TimeBegOper[Mas[j]].Col := Column
                              else //при завершениее заполнения полосы времени цветом в диаграме Ганта
                                 TimeBegOper[Mas[j]].Col := Column-1;

                              ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                              j:=j+1;
                              Fill := TimeBegOper[Mas[j]].Busy;  //чтобы знать что ищем окончание операции

                            end;

                            If (TimeBegOper[Mas[j]].Time = TimeBegOper[Mas[i]].Time) and
                               (j = Length(TimeBegOper)-1) Then
                            begin
                                If Fill = True Then
                                     TimeBegOper[Mas[j]].Col := Column
                                else //при завершении заполнения полосы времени цветом в диаграме Ганта
                                      TimeBegOper[Mas[j]].Col := Column-1;

                                ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                                j:=j+1;
                            end;


                            //Если Fill = True то идут заполненные клетки до следующего значения
                            //Mas[j] - время завершения операции
                            If ColumnTime[Length(ColumnTime)-1].Busy = True Then
                            begin
                               ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j-1]].Row;
                            end
                             else
                             begin
                                ColumnTime[Length(ColumnTime)-1].Row  := 0;
                             end;

                         end;
                     end;
               end;
           end
            else
            begin
               SetLength(ColumnTime, Length(ColumnTime)+1);

               ColumnTime[Length(ColumnTime)-1].Time := ColTime;
               ColumnTime[Length(ColumnTime)-1].Busy := ColumnTime[Length(ColumnTime)-2].Busy;
               ColumnTime[Length(ColumnTime)-1].Col  := Column;

               //Если Fill = True то идут заполненные клетки до следующего значения
               //Mas[j] - время завершения операции
               If ColumnTime[Length(ColumnTime)-1].Busy = True Then
               begin
                   ColumnTime[Length(ColumnTime)-1].Row  := TimeBegOper[Mas[j]].Row;
               end
                else
                begin
                    ColumnTime[Length(ColumnTime)-1].Row  := 0;
                end;

               GantGrid.Cells[Column-1,0] := TextWidth(Minute, IntToStr(HourOf(ColTime)), Column-1);
               Minute := IntToStr(MinuteOf(ColTime));
               If Length(Minute) = 1 Then Minute:='0'+Minute;
               ColTime:=IncHour(ColTime, 1);
            end;

           Column := Column+1;

           If HourOf(ColTime)>17 Then
           begin
               ColTime := IncDay(ColTime);
               ColTime := StrToDateTime(DateToStr(ColTime)+' 9:00');
           end;
       end;

       //рисую время для последней ячейки (часов нет)
       GantGrid.Cells[GantGrid.ColCount-1,0] := TextWidth('00', ' ', GantGrid.ColCount-1);
       SetLength(Mas, 0);


       //Закрашиваю занятые клетки
       AllFillCells;

end;


function TJR_GantForm.TextWidth(BegTxt, EndTxt: String; Col : Integer): String;
Var Width : Integer;
begin
      //считываю ширину ячейки в пикселях
      Width := GantGrid.ColWidths[Col];
      //из ширины ячейки вычитаю минуты, часы, "отступ"
      Width := Width - GantGrid.Canvas.TextWidth(BegTxt)
                     - GantGrid.Canvas.TextWidth(EndTxt) - 2;

      //Если ширина ячейки в пикселях оказалась меньше пробела
      //назначаю новую ширину ячейки
      If Width < GantGrid.Canvas.TextWidth(' ') Then
          GantGrid.ColWidths[Col] := GantGrid.Canvas.TextWidth(BegTxt) +
                                     GantGrid.Canvas.TextWidth(EndTxt) + 2 +
                                     GantGrid.Canvas.TextWidth(' ');

      //Возвращаю минуты пробел часы на всю ширину ячейки
      Result:=BegTxt+Space(Width div GantGrid.Canvas.TextWidth(' '))+EndTxt;
end;

function TJR_GantForm.Space(sp : integer): String;
Var i : integer;
begin

    Result:='';
    For i:=1 to sp do
      Result := Result + ' ';

end;

//Закрашиваю требуемые клетки строки Row
procedure TJR_GantForm.FillCells(ColumnBeg, ColumnEnd, Row, Cur: Integer);
Var Column : Integer;
begin

      //+1 - поскольку закрашивание происходит со следующей клетки после
      //требуемого времени
      For Column := ColumnBeg{+1} to ColumnEnd do
      begin
          With GantGrid.Canvas do
          begin
              Case Cur of
                 0: Brush.Color:=clGreen;
                 1: Brush.Color:=clMaroon;
                 2: Brush.Color:=clRed;
                 3: Brush.Color:=clLime;
              end;
              FillRect(GantGrid.CellRect(Column, Row));
          end;
      end;
end;

//Закрашиваю все клетки текущей операции
procedure TJR_GantForm.AllFillCells;
Var i : Integer;
begin
       //Закрашиваю занятые клетки
       i:=0;
       GantGrid.Repaint;

       While i < Length(TimeBegOper) do
       begin
          //FillCells(время начала операции, время окончания операции, строка-исполнитель)
          FillCells(TimeBegOper[i].Col, TimeBegOper[i+1].Col, TimeBegOper[i].Row, TimeBegOper[i].Cur);
          i:=i+2;    //время начала [1], время завершения [2]
       end;
end;



{Процедура работает при переносе прямоугольника времени над диаграммой Ганта}
procedure TJR_GantForm.GantGridDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
      Accept := Source is TShape;
    If (TimeShape <> nil) Then
    begin
      if TimeShape.Parent <> GantGrid Then
      begin
          TimeShape.Parent := GantGrid;
      end;
      Drag_X := x-32;
      Drag_Y := y-12;
      TimeShape.Left := Drag_X;
      TimeShape.Top  := Drag_Y;
    end;
end;

{Процедура работает при переносе прямоугольника времени над журналом операций}
procedure TJR_GantForm.OperGridDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
      Accept := Source is TShape;
      If (TimeShape <> nil) Then
      begin
         if TimeShape.Parent <> OperGrid Then
         begin
              TimeShape.Parent := OperGrid;
         end;
         Drag_X := x;
         Drag_Y := y;
         TimeShape.Left := Drag_X;
         TimeShape.Top  := Drag_Y;
      end;

end;


{Создаю прямоугольник времени}
procedure TJR_GantForm.OperGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var i : Integer;
    width : Integer;
    Column, Row: Integer;
begin

 //    OperGridCellClick(OperGrid.Columns.Items[1]);

//     If OperGrid.Focused = True Then OperGrid.SetFocus := False;
//     opergrid.OnCellClick
     If (Sender = OperGrid) Then
     begin
       if (TimeShape = nil) Then
       begin
          TimeShape := TShape.Create(self);
          TimeShape.Parent := OperGrid;
          TimeShape.BringToFront;
          TimeShape.OnDragOver  := TDragOver;
          TimeShape.OnEndDrag   := TEndDrag;
          TimeShape.OnStartDrag := TStartDrag;
          TimeShape.Visible := False;

          Width := 0;
          For i := 0 to OperGrid.FieldCount - 1 do
             Width := Width + OperGrid.Columns[i].Width;

          TimeShape.Left := x - TimeShape.Width div 2;
          TimeShape.Top  := y - 12;
          TimeShape.Height := 25;
          TimeShape.Width := Width;
          TimeShape.Brush.Color := clRed;
          TimeShape.Brush.Style := bsSolid;

          While  TimeShape.Width - 50 > 65 do
          begin
            TimeShape.Width := TimeShape.Width - 50;
            TimeShape.Left := x - TimeShape.Width div 2;
            TimeShape.Repaint;
          end;
          TimeShape.Width := 65;
          Drag_X := x;
          Drag_Y := y;
          TimeShape.DragMode :=dmManual; // dmAutomatic; //
          TimeShape.DragCursor := crHandPoint; //crDrag;
//          PostMessage(0, WM_LBUTTONUP, 0, 0);
          TimeShape.BeginDrag(False);
          OperGrid.SetFocus;
       end;
     end
      else //Sender = GantGrid
      begin

        if (TimeShape = nil) Then
        begin
           GantGrid.MouseToCell(X, Y, Column, Row);

           i:=1;
           While  not ((TimeBegOper[i-1].Col <= Column) and (TimeBegOper[i].Col >= Column) and
                 (TimeBegOper[i].Row = Row)) and (i <= Length(TimeBegOper)-1) do
             i:=i+2;

           If i <= Length(TimeBegOper)-1 Then
           begin

              //Ищем выделенный прямоугольник времени на диаграме Ганта

              InfoOperQuery.ParamByName('BEG_DATE').AsDate := DateOf(TimeBegOper[i-1].Time);
              InfoOperQuery.ParamByName('END_DATE').AsDate := DateOf(TimeBegOper[i].Time);
              InfoOperQuery.ParamByName('BEG_TIME').AsString := IntToStr(HourOf(TimeBegOper[i-1].Time))+':';

              //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
              If Length(IntToStr(MinuteOf(TimeBegOper[i-1].Time))) <= 1 Then
                    InfoOperQuery.ParamByName('BEG_TIME').AsString :=
                       InfoOperQuery.ParamByName('BEG_TIME').AsString+'0'+
                       IntToStr(MinuteOf(TimeBegOper[i-1].Time))
               else
                    InfoOperQuery.ParamByName('BEG_TIME').AsString :=
                       InfoOperQuery.ParamByName('BEG_TIME').AsString+
                       IntToStr(MinuteOf(TimeBegOper[i-1].Time));

              InfoOperQuery.ParamByName('END_TIME').AsString := IntToStr(HourOf(TimeBegOper[i].Time))+':';

              //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
              If Length(IntToStr(MinuteOf(TimeBegOper[i].Time))) <= 1 Then
                    InfoOperQuery.ParamByName('END_TIME').AsString :=
                       InfoOperQuery.ParamByName('END_TIME').AsString+'0'+
                       IntToStr(MinuteOf(TimeBegOper[i].Time))
               else
                    InfoOperQuery.ParamByName('END_TIME').AsString :=
                       InfoOperQuery.ParamByName('END_TIME').AsString+
                       IntToStr(MinuteOf(TimeBegOper[i].Time));

              InfoOperQuery.ParamByName('WRKR_ID').AsInteger := Executer[i].Id_Wrkr;
              InfoOperQuery.ParamByName('EQPT_ID').AsInteger := Executer[i].Id_Eqpt;

              InfoOperQuery.Open;

              //Удаляем переносимое время
              If not InfoOperQuery.Eof Then
              begin
                  UpdateOrd1StoredProc.ParamByName('ID_ORDER').AsInteger := InfoOperQuery.FieldByName('ID_ORDER').AsInteger;
                  UpdateOrd1StoredProc.ParamByName('ID_CHRT').AsInteger  := InfoOperQuery.FieldByName('ID_CHRT').AsInteger;
                  UpdateOrd1StoredProc.ParamByName('ID_VOP').AsInteger   := InfoOperQuery.FieldByName('ID_VOP').AsInteger;
                  UpdateOrd1StoredProc.ParamByName('LINENO').AsInteger   := InfoOperQuery.FieldByName('LINENO').AsInteger;
                  UpdateOrd1StoredProc.ParamByName('DATE_BEG').Value    := Null;
                  UpdateOrd1StoredProc.ParamByName('DATE_END').Value    := Null;
                  UpdateOrd1StoredProc.ParamByName('TIME_BEG').AsString  := '';
                  UpdateOrd1StoredProc.ParamByName('TIME_END').AsString  := '';
                  UpdateOrd1StoredProc.ParamByName('ID_WRKR').AsInteger  := 0;
                  UpdateOrd1StoredProc.ParamByName('ID_EQPT').AsInteger  := 0;

                  try
                     UpdateOrd1StoredProc.Prepare;
                     UpdateOrd1StoredProc.ExecProc;
                  except
                        MessageDlg('Ошибка записи!', mtError, [mbOk], 0);
                  end;
              end;


              TimeShape := TShape.Create(self);
              TimeShape.Parent := GantGrid;
              TimeShape.BringToFront;
              TimeShape.OnDragOver  := TDragOver;
              TimeShape.OnEndDrag   := TEndDrag;
              TimeShape.OnStartDrag := TStartDrag;
              TimeShape.Visible := False;

              Width := 0;
              For i := 0 to OperGrid.FieldCount - 1 do
                 Width := Width + OperGrid.Columns[i].Width;

              TimeShape.Left := x - TimeShape.Width div 2;
              TimeShape.Top  := y - 12;
              TimeShape.Height := 25;
              TimeShape.Width := Width;
              TimeShape.Brush.Color := clRed;
              TimeShape.Brush.Style := bsSolid;

              While  TimeShape.Width - 50 > 65 do
              begin
                TimeShape.Width := TimeShape.Width - 50;
                TimeShape.Left := x - TimeShape.Width div 2;
                TimeShape.Repaint;
              end;
              TimeShape.Width := 65;
              Drag_X := x;
              Drag_Y := y;
              TimeShape.DragMode :=dmManual; // dmAutomatic; //
              TimeShape.DragCursor := crHandPoint; //crDrag;
//          PostMessage(0, WM_LBUTTONUP, 0, 0);
              TimeShape.BeginDrag(False);
              GantGrid.SetFocus;

           end;

           BrushCol;
        end;
      end;
end;

{Процедура срабатывает когда прямоугольник времени опускают на диаграмму Ганиа}
procedure TJR_GantForm.TEndDrag(Sender, Target: TObject; X,
  Y: Integer);
Var Column, Row : integer;
  m,  j : Real;
  i : Integer;
begin

    //Если прямоугольник времени опускается на диаграмму Ганта
    // то начинаем проверку можно сюда вставить или нет
    If TimeShape.Parent = GantGrid Then
    begin

      GantGrid.MouseToCell(Drag_X+32, Drag_Y, Column, Row);

      If (Column >= 2) and (Column <= GantGrid.ColCount-1) and
         (Row >= 1) and (Row <= GantGrid.RowCount-1) Then
      begin
        //Убираю прямоугольник времени
        TimeShape.DragCursor := crDefault;

        TimeShape.OnDragOver  := nil;
        TimeShape.OnStartDrag := nil;

        TimeShape.Free;
        TimeShape := nil;      

        GantGrid.Repaint;

        
        Column:=Column - 2; //поскольку первые 2 стобца исполнители
        j := GantOperQuery.FieldByName('NTIME').AsFloat;
        i:=0;

        //проверка что вставленные часы не перекрываются с другими часами
        While (j > 0) and (GantGrid.ColCount >= Column+i) and
              ((ColumnTime[Column+i].Busy = False) and (ColumnTime[Column+i].Row = Row) or
               (ColumnTime[Column+i].Row <> Row))  do
        begin
              m:=RoundTo(HourSpan(ColumnTime[Column+i].Time,ColumnTime[Column+i+1].Time),-2);
              //Если m больше 1, значит мы оказались на стыке дат
              If m > 1 Then
              begin
                  //Если 8 часов меньше первого часа в ColumnTime[Column+i+1].Time
                  If CompareDateTime(StrToDateTime(DateToStr(DateOf(ColumnTime[Column+i+1].Time))+' 8:00'),
                              ColumnTime[Column+i+1].Time) = -1 Then
                  begin
                      m:=RoundTo(HourSpan(
                                  StrToDateTime(DateToStr(DateOf(ColumnTime[Column+i+1].Time))+'8:00'),
                                  ColumnTime[Column+i+1].Time),-2)
                  end
                   else
                     m:=RoundTo(HourSpan(
                        StrToDateTime(DateToStr(DateOf(ColumnTime[Column+i+1].Time))+' '+
                                       IntToStr(HourOf(ColumnTime[Column+i+1].Time))+':00'),
                        ColumnTime[Column+i+1].Time),-2);
              end;

              j:=j-m;
              i:=i+1; //количество столбцов которое будет занимать новое время
        end;

        //если часы не перекрываются заполняем диаграму Ганта
        If (ColumnTime[Column+i].Busy = False) and (ColumnTime[Column+i].Row = Row) or
               (ColumnTime[Column+i].Row <> Row) Then
        begin

           //Если j отрицательное значит время окончания новой операции и
           //время начало очередного столбца не равны. Нужно вводить еще
           //один столбцец
           j:=RoundTo(j, -2);
           If j < 0 Then j:=1+j
            else i:=i+1;

{           For k:=0 To i-1 do
           begin
              //Закрашиваю часы на диаграме Ганта
              With GantGrid.Canvas do
              begin
                  //заполнение клеток цветом
                  Brush.Color:=clGreen;
                  FillRect(GantGrid.CellRect(column+k+2, Row));

                  ColumnTime[column+k].Row := Row; //строка в Grid-е = исполнителю
                  ColumnTime[column+k].Busy := True;
              end;
           end;
}
           //дата и время начала операции
           SetLength(TimeBegOper, Length(TimeBegOper)+1);

           If CompareDate(ColumnTime[Column].Time,
                          ColumnTime[Column+1].Time) = -1 Then
           begin
              //Если день начинается с 8:00
              If CompareDateTime(StrToDateTime(DateToStr(DateOf(ColumnTime[Column+1].Time))+' 8:00'),
                              ColumnTime[Column+1].Time) = -1 Then
              begin
                 TimeBegOper[Length(TimeBegOper)-1].Time :=
                                StrToDateTime(DateToStr(DateOf(ColumnTime[Column+1].Time))+
                                              ' 8:00');
              end
               else//иначе раньше 8:00
               begin
                   TimeBegOper[Length(TimeBegOper)-1].Time := ColumnTime[Column+1].Time;
               end;
           end
            else
            begin
                 TimeBegOper[Length(TimeBegOper)-1].Time := ColumnTime[Column].Time;
            end;
                 
           TimeBegOper[Length(TimeBegOper)-1].Col  := Column+2;   //два первых столбца
           TimeBegOper[Length(TimeBegOper)-1].Row  := Row; //строка в Grid-е = исполнителю
           TimeBegOper[Length(TimeBegOper)-1].Busy := True;
           TimeBegOper[Length(TimeBegOper)-1].Cur  := 1;

           //дата и время окончания операции
           SetLength(TimeBegOper, Length(TimeBegOper)+1);

           //Если следующий час находится в следующем дне
           If CompareDate(DateOf(ColumnTime[Column+i-1].Time),
                          DateOf(ColumnTime[Column+i].Time)) = -1 Then
           begin
              //Если день начинается с 8:00
              If CompareDateTime(StrToDateTime(DateToStr(DateOf(ColumnTime[Column+i].Time))+' 8:00'),
                              ColumnTime[Column+i].Time) = -1 Then
              begin
                 TimeBegOper[Length(TimeBegOper)-1].Time :=
                                StrToDateTime(DateToStr(DateOf(ColumnTime[Column+i].Time))+' '+
                                              '8:'+IntToStr(Round(60*j)));
              end
               else//иначе раньше 8:00
               begin
                   TimeBegOper[Length(TimeBegOper)-1].Time :=
                                  StrToDateTime(DateToStr(DateOf(ColumnTime[Column+i].Time))+' '+
                                                IntToStr(HourOf(ColumnTime[Column+i].Time))+':'+
                                                IntToStr(Round(60*j)));
               end;
           end
            else //иначе в том же
            begin
                TimeBegOper[Length(TimeBegOper)-1].Time :=
                              StrToDateTime(DateToStr(DateOf(ColumnTime[Column+i-1].Time))+' '+
                                            IntToStr(HourOf(ColumnTime[Column+i-1].Time))+':'+
                                            IntToStr(Round(60*j)));
            end;

           TimeBegOper[Length(TimeBegOper)-1].Col  := Column+i-1+2;  //два первых столбца
           TimeBegOper[Length(TimeBegOper)-1].Row  := Row; //строка в Grid-е = исполнителю
           TimeBegOper[Length(TimeBegOper)-1].Busy := False;
           TimeBegOper[Length(TimeBegOper)-1].Cur  := 1;

           //ЗАПИСЬ ПЛАНИРОВАНИЯ ОПЕРАЦИИ В БАЗУ
           UpdateOrd1StoredProc.ParamByName('ID_ORDER').AsInteger := GantOperQuery.FieldByName('ID_ORDER').AsInteger;
           UpdateOrd1StoredProc.ParamByName('ID_CHRT').AsInteger  := GantOperQuery.FieldByName('ID_CHRT').AsInteger;
           UpdateOrd1StoredProc.ParamByName('ID_VOP').AsInteger   := GantOperQuery.FieldByName('ID_VOP').AsInteger;
           UpdateOrd1StoredProc.ParamByName('LINENO').AsInteger   := GantOperQuery.FieldByName('LINENO').AsInteger;
           UpdateOrd1StoredProc.ParamByName('DATE_BEG').AsDate    := DateOf(TimeBegOper[Length(TimeBegOper)-2].Time);
           UpdateOrd1StoredProc.ParamByName('DATE_END').AsDate    := DateOf(TimeBegOper[Length(TimeBegOper)-1].Time);
           UpdateOrd1StoredProc.ParamByName('TIME_BEG').AsString  := IntToStr(HourOf(TimeBegOper[Length(TimeBegOper)-2].Time))+':';

           //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
           If Length(IntToStr(MinuteOf(TimeBegOper[Length(TimeBegOper)-2].Time))) <= 1 Then
                UpdateOrd1StoredProc.ParamByName('TIME_BEG').AsString :=
                     UpdateOrd1StoredProc.ParamByName('TIME_BEG').AsString +
                     '0'+IntToStr(MinuteOf(TimeBegOper[Length(TimeBegOper)-2].Time))
            else
                UpdateOrd1StoredProc.ParamByName('TIME_BEG').AsString  :=
                     UpdateOrd1StoredProc.ParamByName('TIME_BEG').AsString +
                     IntToStr(MinuteOf(TimeBegOper[Length(TimeBegOper)-2].Time));

           UpdateOrd1StoredProc.ParamByName('TIME_END').AsString  := IntToStr(HourOf(TimeBegOper[Length(TimeBegOper)-1].Time))+':';

           If Length(IntToStr(MinuteOf(TimeBegOper[Length(TimeBegOper)-1].Time))) <= 1 Then
                UpdateOrd1StoredProc.ParamByName('TIME_END').AsString :=
                     UpdateOrd1StoredProc.ParamByName('TIME_END').AsString +
                     '0'+IntToStr(MinuteOf(TimeBegOper[Length(TimeBegOper)-1].Time))
            else
                UpdateOrd1StoredProc.ParamByName('TIME_END').AsString :=
                     UpdateOrd1StoredProc.ParamByName('TIME_END').AsString +
                     IntToStr(MinuteOf(TimeBegOper[Length(TimeBegOper)-1].Time));

           UpdateOrd1StoredProc.ParamByName('ID_WRKR').AsInteger  := Executer[Row-1].Id_Wrkr;
           UpdateOrd1StoredProc.ParamByName('ID_EQPT').AsInteger  := Executer[Row-1].Id_Eqpt;

           try
              UpdateOrd1StoredProc.Prepare;
              UpdateOrd1StoredProc.ExecProc;
           except
                MessageDlg('Ошибка записи!', mtError, [mbOk], 0);
           end;

        end
         else
           MessageDlg('Время операции превышает свободный промежуток!', mtWarning, [mbOk], 0)

      end;

      OperGrid.SetFocus;

    end;

    if  TimeShape <> nil Then
    begin

        //Убираю прямоугольник времени
        TimeShape.DragCursor := crDefault;

        TimeShape.OnDragOver  := nil;
        TimeShape.OnStartDrag := nil;

        TimeShape.Free;
        TimeShape := nil;
        OperGrid.SetFocus;

    end;

       SelectField;
//    BrushCol;
//    AllFillCells;
end;

procedure TJR_GantForm.GantGridEndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
             // SUDA VRODE NIKOGDA NE ZAXODIM!!!
    TimeShape.DragCursor := crDefault;
    TimeShape.Free;
    TimeShape := nil;


end;

{Для переноса прямоугольника времени, центрирую курсор мыши в центре прямоугольника
 и создаю ощущения, что я постоянно несу что-то над ним, вто время как переношу
 его самого}
procedure TJR_GantForm.TDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
Var Column, Row : integer;
    myRect: TGridRect;
begin
       Drag_X := Drag_X - (32 - x);
       Drag_Y := Drag_Y - (12 - y);
       TimeShape.Left := Drag_X;
       TimeShape.Top  := Drag_Y;

      If TimeShape.Parent = GantGrid Then
      begin
          GantGrid.MouseToCell(Drag_X+32, Drag_Y, Column, Row);

          If (Column >= 2) and (Column <= GantGrid.ColCount-1) and
             (Row >= 1) and (Row <= GantGrid.RowCount-1) Then
          begin
{          Label1.Caption := IntToStr(GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y])+'  |  '+
                             IntToStr(Drag_X+32)+'  :  '+IntTostr(Drag_Y)+'  \  '+
                             IntToStr(GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y+24])+'  |  '+
                             IntToStr(Drag_X+32)+'  :  '+IntTostr(Drag_Y+24);
}
             //12632256 - цвет решетки StringGrid-a
             if (GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y] = 16777215) or
                (GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y] = 12937777) or       //синий цвет фокуса
                (GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y+24] = 16777215) or   //белый цвет 
                (GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y+24] = 12937777)  Then
             begin
               TimeShape.DragCursor := crHandPoint;
               myRect.Left := Column;
               myRect.Top := Row;
               myRect.Right := Column;
               myRect.Bottom := Row;
               GantGrid.Selection := myRect;
             end
              else
              begin
                  TimeShape.DragCursor := crNoDrop;

                 //Закрашиваю занятые клетки
                 AllFillCells;
                 TimeShape.Repaint;

{                  If (GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y] <> 12632256) Then
                  begin
                      With GantGrid.Canvas do
                      begin
                        Brush.Color:=clGreen;
                        FillRect(GantGrid.CellRect(column, Row));
                      end;
//                      TimeShape.Repaint;
                  end;}
              end;
          end;
      end;
end;

procedure TJR_GantForm.GantGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
Var i : Integer;
    Column, Row : integer;
    Repaint : Boolean;
begin
      Mouse_X:=X;
      Mouse_Y:=Y;

      If (GantGrid.Canvas.Pixels[Mouse_X, Mouse_Y] <> 255)   and     //Ярко-красный цвет текущей операции
         (GantGrid.Canvas.Pixels[Mouse_X, Mouse_Y] <> 65280) and     //Светло-Зеленый цвет
         (GantGrid.Canvas.Pixels[Mouse_X, Mouse_Y] <> 12632256) Then //12632256 - цвет решетки StringGrid-a
      begin

         If Length(TimeBegOper) > 0 Then
         begin

           GantGrid.MouseToCell(Mouse_X, Mouse_Y, Column, Row);

           Repaint := False;
           i:=1;
           While (i <= Length(TimeBegOper)-1) do
           begin
               If TimeBegOper[i].Cur = 2 Then
               begin
                   TimeBegOper[i-1].Cur := 1;
                   TimeBegOper[i].Cur := 1;
                   Repaint := True;
               end;

               If TimeBegOper[i].Cur = 3 Then
               begin
                   TimeBegOper[i-1].Cur := 0;
                   TimeBegOper[i].Cur := 0;
                   Repaint := True;
               end;

               i:=i+2;
           end;

           //Закрашиваю занятые клетки
           If Repaint = True Then
                AllFillCells;

           GantGrid.Hint:='';
           GantGrid.ShowHint:=False;     
         end;
      end;


//                Label1.Caption := IntToStr(GantGrid.Canvas.Pixels[X, y])+'  |  '+
//                             IntToStr(X)+'  :  '+IntTostr(y);

end;

procedure TJR_GantForm.GantGridClick(Sender: TObject);
Var Column, Row : integer;
    i : Integer;
begin

       GantGrid.MouseToCell(Mouse_X, Mouse_Y, Column, Row);


       //Просмотр массива на совпадение с занятым временем
{       If (GantGrid.Canvas.Pixels[Mouse_X, Mouse_Y] = 128) or       //Темно-красный цвет текущей операции
          (GantGrid.Canvas.Pixels[Mouse_X, Mouse_Y] = 32768) Then   //Зеленый цвет
       begin
}
         i:=1;
         if Length(TimeBegOper) = 0 then abort;

         While  not ((TimeBegOper[i-1].Col <= Column) and (TimeBegOper[i].Col >= Column) and
               (TimeBegOper[i].Row = Row)) and (i <= Length(TimeBegOper)-1) do
           i:=i+2;

         If i <= Length(TimeBegOper)-1 Then
         begin
             If TimeBegOper[i].Cur = 1 Then
             begin
                 TimeBegOper[i-1].Cur := 2;
                 TimeBegOper[i].Cur := 2;
             end
              else
              begin
                  TimeBegOper[i-1].Cur := 3;
                  TimeBegOper[i].Cur := 3;
              end;

             //Закрашиваю занятые клетки
             AllFillCells;


             HintQuery.Close;
             HintQuery.ParamByName('BEG_DATE').AsDate := DateOf(TimeBegOper[i-1].Time);
             HintQuery.ParamByName('END_DATE').AsDate := DateOf(TimeBegOper[i].Time);
             HintQuery.ParamByName('BEG_TIME').AsString := IntToStr(HourOf(TimeBegOper[i-1].Time))+':';

             //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
             If Length(IntToStr(MinuteOf(TimeBegOper[i-1].Time))) <= 1 Then
                  HintQuery.ParamByName('BEG_TIME').AsString :=
                     HintQuery.ParamByName('BEG_TIME').AsString+'0'+IntToStr(MinuteOf(TimeBegOper[i-1].Time))
             else
                  HintQuery.ParamByName('BEG_TIME').AsString :=
                     HintQuery.ParamByName('BEG_TIME').AsString+IntToStr(MinuteOf(TimeBegOper[i-1].Time));

             HintQuery.ParamByName('END_TIME').AsString := IntToStr(HourOf(TimeBegOper[i].Time))+':';

             //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
             If Length(IntToStr(MinuteOf(TimeBegOper[i].Time))) <= 1 Then
                  HintQuery.ParamByName('END_TIME').AsString :=
                     HintQuery.ParamByName('END_TIME').AsString+'0'+IntToStr(MinuteOf(TimeBegOper[i].Time))
             else
                  HintQuery.ParamByName('END_TIME').AsString :=
                     HintQuery.ParamByName('END_TIME').AsString+IntToStr(MinuteOf(TimeBegOper[i].Time));

             HintQuery.ParamByName('WRKR_ID').AsInteger := Executer[i-1].Id_Wrkr;
             HintQuery.ParamByName('EQPT_ID').AsInteger := Executer[i-1].Id_Eqpt;

             HintQuery.Open;

             GantGrid.Hint := 'Заявка/Заказ: '+HintQuery.FieldByName('Rqst_Number').AsString+'/'+
                                  HintQuery.FieldByName('Order_Number').AsString+' '+
             'Заказчик: '+HintQuery.FieldByName('NAME_CST').AsString+' '+
             'Номенклатура: '+HintQuery.FieldByName('NAME_NMNT').AsString+' '+
             'Чертеж: '+HintQuery.FieldByName('CODE_CHRT').AsString+' '+
             '№ операции: '+HintQuery.FieldByName('LINE').AsString+' '+
             'Операция: '+HintQuery.FieldByName('NAMEOP').AsString;
             GantGrid.ShowHint := True;
         end;


end;

procedure TJR_GantForm.GantGridRowMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
begin
       //Закрашиваю занятые клетки
       AllFillCells;
end;

procedure TJR_GantForm.GantGridTopLeftChanged(Sender: TObject);
begin
       //Закрашиваю занятые клетки
       AllFillCells;
end;

procedure TJR_GantForm.TStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
      TimeShape.Visible := True;
end;

procedure TJR_GantForm.OperGridMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
//          Label1.Caption := IntToStr(X)+'  :  '+IntTostr(y);

end;

procedure TJR_GantForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TJR_GantForm.GantGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Var i : Integer;
Column, Row : integer;
begin
      If Key = VK_DELETE Then
      begin

           GantGrid.MouseToCell(Mouse_X, Mouse_Y, Column, Row);

           i:=1;
           While  not ((TimeBegOper[i-1].Col <= Column) and (TimeBegOper[i].Col >= Column) and
                 (TimeBegOper[i].Row = Row)) and (i <= Length(TimeBegOper)-1) do
             i:=i+2;

           If i <= Length(TimeBegOper)-1 Then
           begin

              //Ищем выделенный прямоугольник времени на диаграме Ганта
              InfoOperQuery.Close;
              InfoOperQuery.ParamByName('BEG_DATE').AsDate := DateOf(TimeBegOper[i-1].Time);
              InfoOperQuery.ParamByName('END_DATE').AsDate := DateOf(TimeBegOper[i].Time);
              InfoOperQuery.ParamByName('BEG_TIME').AsString := IntToStr(HourOf(TimeBegOper[i-1].Time))+':';

              //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
              If Length(IntToStr(MinuteOf(TimeBegOper[i-1].Time))) <= 1 Then
                    InfoOperQuery.ParamByName('BEG_TIME').AsString :=
                       InfoOperQuery.ParamByName('BEG_TIME').AsString+'0'+
                       IntToStr(MinuteOf(TimeBegOper[i-1].Time))
               else
                    InfoOperQuery.ParamByName('BEG_TIME').AsString :=
                       InfoOperQuery.ParamByName('BEG_TIME').AsString+
                       IntToStr(MinuteOf(TimeBegOper[i-1].Time));

              InfoOperQuery.ParamByName('END_TIME').AsString := IntToStr(HourOf(TimeBegOper[i].Time))+':';

              //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
              If Length(IntToStr(MinuteOf(TimeBegOper[i].Time))) <= 1 Then
                    InfoOperQuery.ParamByName('END_TIME').AsString :=
                       InfoOperQuery.ParamByName('END_TIME').AsString+'0'+
                       IntToStr(MinuteOf(TimeBegOper[i].Time))
               else
                    InfoOperQuery.ParamByName('END_TIME').AsString :=
                       InfoOperQuery.ParamByName('END_TIME').AsString+
                       IntToStr(MinuteOf(TimeBegOper[i].Time));

              InfoOperQuery.ParamByName('WRKR_ID').AsInteger := Executer[Row-1].Id_Wrkr;
              InfoOperQuery.ParamByName('EQPT_ID').AsInteger := Executer[Row-1].Id_Eqpt;

              InfoOperQuery.Open;

              InfoOperQuery.First;
              //Удаляем переносимое время
              If (InfoOperQuery.FieldByName('ORDER_ID').AsInteger = GantOperQuery.FieldByName('ID_ORDER').AsInteger) and
                 (InfoOperQuery.FieldByName('CHRT_ID').AsInteger  = GantOperQuery.FieldByName('ID_CHRT').AsInteger)  and
                 (InfoOperQuery.FieldByName('VOP_ID').AsInteger   = GantOperQuery.FieldByName('ID_VOP').AsInteger)   and
                 (InfoOperQuery.FieldByName('LINE').AsInteger     = GantOperQuery.FieldByName('LINENO').AsInteger)
              Then
              begin

                UpdateOrd1StoredProc.ParamByName('ID_ORDER').AsInteger := GantOperQuery.FieldByName('ID_ORDER').AsInteger;
                UpdateOrd1StoredProc.ParamByName('ID_CHRT').AsInteger  := GantOperQuery.FieldByName('ID_CHRT').AsInteger;
                UpdateOrd1StoredProc.ParamByName('ID_VOP').AsInteger   := GantOperQuery.FieldByName('ID_VOP').AsInteger;
                UpdateOrd1StoredProc.ParamByName('LINENO').AsInteger   := GantOperQuery.FieldByName('LINENO').AsInteger;
                UpdateOrd1StoredProc.ParamByName('DATE_BEG').Value     := Null;
                UpdateOrd1StoredProc.ParamByName('DATE_END').Value     := Null;
                UpdateOrd1StoredProc.ParamByName('TIME_BEG').AsString  := '';
                UpdateOrd1StoredProc.ParamByName('TIME_END').AsString  := '';
                UpdateOrd1StoredProc.ParamByName('ID_WRKR').AsInteger  := 0;
                UpdateOrd1StoredProc.ParamByName('ID_EQPT').AsInteger  := 0;

                try
                   UpdateOrd1StoredProc.Prepare;
                   UpdateOrd1StoredProc.ExecProc;
                except
                      MessageDlg('Ошибка записи!', mtError, [mbOk], 0);
                end;

                SelectField;
              end
               else
                  MessageDlg('Ошибка. Вы удаляете время НЕ текущей операции!', mtError, [mbOk], 0);
           end
      end;
end;

procedure TJR_GantForm.GantGridDblClick(Sender: TObject);
var JRForm: TInf_OperForm;
    BegTime, EndTime : TDateTime;
    Wrkr, Eqpt : integer;
    Column, Row : integer;
    i : Integer;
    Change : Boolean;
begin

  GantGrid.MouseToCell(Mouse_X, Mouse_Y, Column, Row);
  Change := False;  //Если мы 2-раза щелкнули по не текущей (зеленой) операции

  i:=1;
  While  not ((TimeBegOper[i-1].Col <= Column) and (TimeBegOper[i].Col >= Column) and
        (TimeBegOper[i].Row = Row)) and (i <= Length(TimeBegOper)-1) do
    i:=i+2;

  If i <= Length(TimeBegOper)-1 Then
  begin
      BegTime := TimeBegOper[i-1].Time;
      EndTime := TimeBegOper[i].Time;
      Wrkr    := Executer[Row-1].Id_Wrkr;
      Eqpt    := Executer[Row-1].Id_Eqpt;

      If (TimeBegOper[i].Cur = 1) or (TimeBegOper[i].Cur = 2) Then
         Change := True;   //Если мы 2-раза щелкнули по текущей (Красной) операции

      if CheckOfOpened('Info Информация по операции', '') = false then exit; // проверка на существование открытых окон

      // открыть форму информации  по операции
      JRForm := TInf_OperForm.CreateN(self, BegTime, EndTime, Wrkr, Eqpt, Row, TimeBegOper[i-1].Col-2, Change);

      GANT_INFO := JRForm;
      JRForm.Show;

  end;

end;

procedure TJR_GantForm.GantOperQueryAfterScroll(DataSet: TDataSet);
begin
//     OperGridCellClick(OperGrid.Columns.Items[1]);

end;

procedure TJR_GantForm.FormActivate(Sender: TObject);
begin
    SelectField;

end;


procedure TJR_GantForm.ButtonCloseClick(Sender: TObject);
begin
  close;
end;

end.
