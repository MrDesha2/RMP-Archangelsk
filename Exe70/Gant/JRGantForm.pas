unit JRGantForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, ToolWin, ComCtrls, DB, DBTables,
  StdCtrls, RXGrids, DateUtils;

type
  //Структура содержит информацию о клетке GantGrida
  TBusyTable = record
    Time : TDateTime;   //дата и время начала либо окончания операции
    Col  : integer;     //№ колонки
    Row  : integer;     //№ строки
    Busy : Boolean      //True - занято, False - свободно
  end;

  //Сокращенная структура TBusyTable, для сортировки времени из массива TimeBegOper
  TMas = record
    Time : TDateTime;
    Row  : Integer;
    Index : Integer; //№ индекса массива TimeBegOper
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
    Label1: TLabel;
    Label2: TLabel;
    DateTimeQuery: TQuery;
    procedure OperGridCellClick(Column: TColumnEh);
    procedure SelectField;
    function TextWidth(BegTxt, EndTxt: String; Col : Integer): String ;
    function Space(sp : integer): String;
    procedure BrushCol;
    procedure FillCells(ColumnBeg, ColumnEnd, Row : Integer);
    procedure AllFillCells;
//    function SortMas(Mas : array of TDateTime): TDateTime;
    procedure GantGridMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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
  private
    { Private declarations }
  public
    constructor CreateN(AOwner: TForm);
    destructor Destroy; override;
  end;

var
  JR_GantForm: TJR_GantForm;
  TableName  : string;         // имя таблицы журнала
  IDDoc      : Integer;        // ID документа
  TimeShape   : TShape;
  Drag_X, Drag_Y : Integer;    // Координаты перетаскиваемого времени
  TimeBegOper : array of TBusyTable;
  ColumnTime : array of TBusyTable;
  DateBeg : TDateTime;  //дата и время начала просмотра диаграммы Ганта
  DateEnd : TDateTime;  //дата и время завершения просмотра диаграммы Ганта


implementation

uses Types, ParamForm;

{$R *.dfm}

constructor TJR_GantForm.createN(AOwner: TForm);
begin

  inherited Create(AOwner);

  // создание запроса для формы

  with GantOperQuery do
    begin

      Close;
      
      sql.clear;
      sql.add('Select * From BROWSE_GANTOPER_PROC(9698)');

      open;

    end;

  Tablename := 'jr_gant';
  caption   := 'Gant Оперативный журнал заказов';

  HelpContext := 350;

  GantOperQuery.Last;

  SetLength(TimeBegOper, 0);
  SetLength(ColumnTime, 0);
  DateBeg:=StrToDateTime('1.07.04 9.00');
  DateEnd:=StrToDateTime('31.07.04 17.00');

  SelectField;

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

end;

destructor TJR_GantForm.Destroy;
begin
  inherited;
end;


procedure TJR_GantForm.OperGridCellClick(Column: TColumnEh);
Var i : Integer;
begin
       SelectField;

end;

procedure TJR_GantForm.SelectField;
Var Wrkr_Size : Integer;
    Eqpt_size : Integer;
    i : Integer;
//    d,t,j : String;
begin

        SetLength(TimeBegOper, 0);
        SetLength(ColumnTime, 0);

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
              TimeBegOper[Length(TimeBegOper)-1].Time :=
                       StrToDateTime(DateTimeQuery.FieldByName('date_beg').AsString + ' ' +
                       DateTimeQuery.FieldByName('time_beg').AsString);
              TimeBegOper[Length(TimeBegOper)-1].Row := i; //строка в Grid-е = исполнителю

              //дата и время окончания операции
              SetLength(TimeBegOper, Length(TimeBegOper)+1);
              TimeBegOper[Length(TimeBegOper)-1].Time :=
                       StrToDateTime(DateTimeQuery.FieldByName('date_end').AsString + ' ' +
                       DateTimeQuery.FieldByName('time_end').AsString);
              TimeBegOper[Length(TimeBegOper)-1].Row := i; //строка в Grid-е = исполнителю

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
   Fill : Boolean;     //клетка закрашена или нет;
 MasRow : Integer;     //содержит при обмене информацию о Mas[i].Row
 MasInd : Integer;     //содержит при обмене информацию о Mas[i].Index
Mas : array of TMas;
    d,t : String;
begin

       Fill := False;  //незакрашена
       //сортировка массива времени начала и окончания работ
       SetLength(Mas, 0);
       SetLength(Mas, Length(TimeBegOper));
//       Copy(TimeBegOper, 0, Length(TimeBegOper));
       For i:=0 to Length(TimeBegOper)-1 do
       begin
          Mas[i].Time  := TimeBegOper[i].Time;
          Mas[i].Row   := TimeBegOper[i].Row;
          Mas[i].Index := i;
       end;

       For i:=0 to Length(Mas)-1 do
       begin
         Min := Mas[i].Time;
         Pos := i;
         For j:=i+1 to Length(Mas)-1 do
         begin
            if Min > Mas[j].Time Then
            begin
                 Min := Mas[j].Time;
                 Pos := j;
            end;
         end;
         MasRow := Mas[Pos].Row;
         MasInd := Mas[Pos].Index;
         Mas[Pos].Time  := Mas[i].Time;
         Mas[Pos].Row   := Mas[i].Row;
         Mas[Pos].Index := Mas[i].Index;
         Mas[i].Time  := Min;
         Mas[i].Row   := MasRow;
         Mas[i].Index := MasInd;
       end;


       ColTime:=DateBeg;     //начало смены   //НУЖНА ЗАМЕНА НА РЕАЛЬНУЮ ДАТУ
       j := 0;  //индекс массива Mas
       GantGrid.ColCount := GantGrid.ColCount+1; //прибавляю 1 колонку


       //рисую время для первой ячейки (минуты сохраняю отдельно)
       If j<Length(Mas) Then
       begin
         //ПРИ РАВЕНСТВЕ ДАТ
         If CompareDate(ColTime, Mas[j].Time) = 0 Then
         begin
           //ColTime >= Mas[j].Time
           If (CompareTime(ColTime, Mas[j].Time) = 0) or
              (CompareTime(ColTime, Mas[j].Time) = 1)  Then
           begin
               If Fill = True Then Fill := False
                else Fill := True;

               SetLength(ColumnTime, Length(ColumnTime)+1);

               ColumnTime[Length(ColumnTime)-1].Time := Mas[j].Time;
               ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row;
               ColumnTime[Length(ColumnTime)-1].Col  := 2;
               ColumnTime[Length(ColumnTime)-1].Busy := Fill;
               TimeBegOper[Mas[j].Index].Col := 2;

               GantGrid.Cells[2,0] := TextWidth(' ', IntToStr(HourOf(Mas[j].Time)), 2);
               Minute := IntToStr(MinuteOf(Mas[j].Time));
               If Length(Minute) = 1 Then Minute:='0'+Minute;

               //при равенстве времени
               If TimeOf(ColTime) = TimeOf(Mas[j].Time)  Then
                   ColTime:=IncHour(ColTime, 1);

               j:=j+1;
           end
            else
            begin
                SetLength(ColumnTime, Length(ColumnTime)+1);

                ColumnTime[Length(ColumnTime)-1].Time := ColTime;
                ColumnTime[Length(ColumnTime)-1].Col  := 2;
                ColumnTime[Length(ColumnTime)-1].Busy := Fill;

                //Если Fill = True то идут заполненные клетки до следующего значения
                //Mas[j] - время завершения операции
                If Fill = True Then
                  ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row
                 else
                    ColumnTime[Length(ColumnTime)-1].Row  := 0;

                GantGrid.Cells[2,0] := TextWidth(' ', IntToStr(HourOf(ColTime)), 2);
                Minute := IntToStr(MinuteOf(ColTime));
                If Length(Minute) = 1 Then Minute:='0'+Minute;
                ColTime:=IncHour(ColTime, 1);
            end;
         end
           //КОГДА ПЕРЕЧИСЛЯЕМАЯ ДАТА МЕНЬШЕ ЧЕМ ДАТА В МАССИВЕ
           else
           begin
               //ColTime < Mas[j].Time
               If CompareDate(ColTime, Mas[j].Time) = -1 Then
               begin
                  SetLength(ColumnTime, Length(ColumnTime)+1);

                  ColumnTime[Length(ColumnTime)-1].Time := ColTime;
                  ColumnTime[Length(ColumnTime)-1].Col  := 2;
                  ColumnTime[Length(ColumnTime)-1].Busy := Fill;

                  //Если Fill = True то идут заполненные клетки до следующего значения
                  //Mas[j] - время завершения операции
                  If Fill = True Then
                    ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row
                   else
                      ColumnTime[Length(ColumnTime)-1].Row  := 0;

                  GantGrid.Cells[2,0] := TextWidth(' ', IntToStr(HourOf(ColTime)), 2);
                  Minute := IntToStr(MinuteOf(ColTime));
                  If Length(Minute) = 1 Then Minute:='0'+Minute;
                  ColTime:=IncHour(ColTime, 1);
               end
                 //КОГДА ПЕРЧИСЛЯЕМАЯ ДАТА БОЛЬШЕ ЧЕМ ДАТА В МАССИВЕ
                 else
                 begin
                     //ColTime > Mas[j].Time
                     If CompareDate(ColTime, Mas[j].Time) = 1 Then
                     begin
                        If Fill = True Then Fill := False
                         else Fill := True;

                        SetLength(ColumnTime, Length(ColumnTime)+1);

                        ColumnTime[Length(ColumnTime)-1].Time := Mas[j].Time;
                        ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row;
                        ColumnTime[Length(ColumnTime)-1].Col  := 2;
                        ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                        TimeBegOper[Mas[j].Index].Col := 2;

                        GantGrid.Cells[2,0] := TextWidth(' ', IntToStr(HourOf(Mas[j].Time)), 2);
                        Minute := IntToStr(MinuteOf(Mas[j].Time));
                        If Length(Minute) = 1 Then Minute:='0'+Minute;
                        j:=j+1;
                     end;
                 end;
           end;
       end
        else
        begin
           SetLength(ColumnTime, Length(ColumnTime)+1);

           ColumnTime[Length(ColumnTime)-1].Time := ColTime;
           ColumnTime[Length(ColumnTime)-1].Col  := 2;
           ColumnTime[Length(ColumnTime)-1].Busy := Fill;

           //Если Fill = True то идут заполненные клетки до следующего значения
           //Mas[j] - время завершения операции
           If Fill = True Then
               ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row
            else
               ColumnTime[Length(ColumnTime)-1].Row  := 0;

           GantGrid.Cells[2,0] := TextWidth(' ', IntToStr(HourOf(ColTime)), 2);
           Minute := IntToStr(MinuteOf(ColTime));
           If Length(Minute) = 1 Then Minute:='0'+Minute;
           ColTime:=IncHour(ColTime, 1);
        end;


        
       i:=3;
       While ColTime<=DateEnd do
       begin

           GantGrid.ColCount := GantGrid.ColCount+1;

           If j<Length(Mas) Then
           begin
             //ПРИ РАВЕНСТВЕ ДАТ
             If CompareDate(ColTime, Mas[j].Time) = 0 Then
             begin
               //ColTime >= Mas[j].Time
               If (CompareTime(ColTime, Mas[j].Time) = 0) or
                  (CompareTime(ColTime, Mas[j].Time) = 1)  Then
               begin
                   If Fill = True Then Fill := False
                    else Fill := True;

                   SetLength(ColumnTime, Length(ColumnTime)+1);

                   ColumnTime[Length(ColumnTime)-1].Time := Mas[j].Time;
                   ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row;
                   ColumnTime[Length(ColumnTime)-1].Col  := i;
                   ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                   TimeBegOper[Mas[j].Index].Col := i;

                   GantGrid.Cells[i,0] := TextWidth(Minute, IntToStr(HourOf(Mas[j].Time)), i);
                   Minute := IntToStr(MinuteOf(Mas[j].Time));
                   If Length(Minute) = 1 Then Minute:='0'+Minute;
                                                 
              d:= TimeToStr(ColTime);
              t:= TimeToStr(Mas[j].Time);

                   //при равенстве времени
                   If (CompareTime(ColTime, Mas[j].Time) = 0)  Then
                       ColTime:=IncHour(ColTime, 1);

                   j:=j+1;
               end
                else
                begin
                    SetLength(ColumnTime, Length(ColumnTime)+1);

              d:= TimeToStr(ColTime);
              t:= TimeToStr(Mas[j].Time);

                    ColumnTime[Length(ColumnTime)-1].Time := ColTime;
                    ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                    ColumnTime[Length(ColumnTime)-1].Col  := i;

                    //Если Fill = True то идут заполненные клетки до следующего значения
                    //Mas[j] - время завершения операции
                    If Fill = True Then
                       ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row
                     else
                         ColumnTime[Length(ColumnTime)-1].Row  := 0;

                    GantGrid.Cells[i,0] := TextWidth(Minute, IntToStr(HourOf(ColTime)), i);
                    Minute := IntToStr(MinuteOf(ColTime));
                    If Length(Minute) = 1 Then Minute:='0'+Minute;
                    ColTime:=IncHour(ColTime, 1);
                end;
             end
               //КОГДА ПЕРЕЧИСЛЯЕМАЯ ДАТА МЕНЬШЕ ЧЕМ ДАТА В МАССИВЕ
               else
               begin
                   //ColTime < Mas[j].Time
                   If CompareDate(ColTime, Mas[j].Time) = -1 Then
                   begin
                      SetLength(ColumnTime, Length(ColumnTime)+1);

                      ColumnTime[Length(ColumnTime)-1].Time := ColTime;
                      ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                      ColumnTime[Length(ColumnTime)-1].Col  := i;

                      //Если Fill = True то идут заполненные клетки до следующего значения
                      //Mas[j] - время завершения операции
                      If Fill = True Then
                         ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row
                       else
                           ColumnTime[Length(ColumnTime)-1].Row  := 0;

                      GantGrid.Cells[i,0] := TextWidth(Minute, IntToStr(HourOf(ColTime)), i);
                      Minute := IntToStr(MinuteOf(ColTime));
                      If Length(Minute) = 1 Then Minute:='0'+Minute;
                      ColTime:=IncHour(ColTime, 1);
                   end
                     //КОГДА ПЕРЧИСЛЯЕМАЯ ДАТА БОЛЬШЕ ЧЕМ ДАТА В МАССИВЕ
                     else
                     begin
                         //ColTime > Mas[j].Time
                         If CompareDate(ColTime, Mas[j].Time) = 1 Then
                         begin
                            If Fill = True Then Fill := False
                             else Fill := True;

                            SetLength(ColumnTime, Length(ColumnTime)+1);

                            ColumnTime[Length(ColumnTime)-1].Time := Mas[j].Time;
                            ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row;
                            ColumnTime[Length(ColumnTime)-1].Col  := i;
                            ColumnTime[Length(ColumnTime)-1].Busy := Fill;
                            TimeBegOper[Mas[j].Index].Col := i;

                            GantGrid.Cells[i,0] := TextWidth(Minute, IntToStr(HourOf(Mas[j].Time)), i);
                            Minute := IntToStr(MinuteOf(Mas[j].Time));
                            If Length(Minute) = 1 Then Minute:='0'+Minute;
                            j:=j+1;
                         end;
                     end;
               end;
           end
            else
            begin
               SetLength(ColumnTime, Length(ColumnTime)+1);

               ColumnTime[Length(ColumnTime)-1].Time := ColTime;
               ColumnTime[Length(ColumnTime)-1].Busy := Fill;
               ColumnTime[Length(ColumnTime)-1].Col  := i;

               //Если Fill = True то идут заполненные клетки до следующего значения
               //Mas[j] - время завершения операции
               If Fill = True Then
                  ColumnTime[Length(ColumnTime)-1].Row  := Mas[j].Row
                else
                    ColumnTime[Length(ColumnTime)-1].Row  := 0;

               GantGrid.Cells[i,0] := TextWidth(Minute, IntToStr(HourOf(ColTime)), i);
               Minute := IntToStr(MinuteOf(ColTime));
               If Length(Minute) = 1 Then Minute:='0'+Minute;
               ColTime:=IncHour(ColTime, 1);
            end;

           i := i+1;

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
procedure TJR_GantForm.FillCells(ColumnBeg, ColumnEnd, Row: Integer);
Var Column : Integer;
begin
      For Column := ColumnBeg+1 to ColumnEnd do
      begin
          With GantGrid.Canvas do
          begin
              Brush.Color:=clGreen;
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
          FillCells(TimeBegOper[i].Col, TimeBegOper[i+1].Col, TimeBegOper[i].Row);
          i:=i+2;    //время начала [1], время завершения [2]
       end;
end;

procedure TJR_GantForm.GantGridMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

       //Рисую линеку времени
       BrushCol;

       //Закрашиваю занятые клетки
       AllFillCells;
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
//    Column, Row: Longint;
begin

     OperGridCellClick(OperGrid.Columns.Items[1]);

//     If OperGrid.Focused = True Then OperGrid.SetFocus := False;
//     opergrid.OnCellClick

     if (TimeShape = nil) Then
     begin
//        ShowMessage('еще нажата');
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
        TimeShape.BeginDrag(True);
        OperGrid.SetFocus;
     end;

end;

procedure TJR_GantForm.TEndDrag(Sender, Target: TObject; X,
  Y: Integer);
Var Column, Row : integer;
begin

    If TimeShape.Parent = GantGrid Then
    begin

      GantGrid.MouseToCell(Drag_X+32, Drag_Y, Column, Row);

      Label2.Caption := IntToStr(Column)+'  :  '+IntTostr(Row);
      If (Column >= 2) and (Column <= GantGrid.ColCount-1) and
         (Row >= 1) and (Row <= GantGrid.RowCount-1) Then
      begin
        //Убираю прямоугольник времени
        TimeShape.DragCursor := crDefault;
        TimeShape.Free;
        TimeShape := nil;

        GantGrid.Repaint;  
        With GantGrid.Canvas do
        begin
            Brush.Color:=clGreen;
            FillRect(GantGrid.CellRect(column, Row));
//            Brush.Color:=clRed;
//            FillRect(GantGrid.CellRect(column+2, Row));
        end;

      end;

    end;
     
    if  TimeShape <> nil Then
    begin

        //Убираю прямоугольник времени
        TimeShape.DragCursor := crDefault;
        TimeShape.Free;
        TimeShape := nil;

    end;
    
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
                (GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y] = 12937777) or
                (GantGrid.Canvas.Pixels[Drag_X+32, Drag_Y+24] = 16777215) or
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
begin
//          Label1.Caption := IntToStr(GantGrid.Canvas.Pixels[X, y])+'  |  '+
//                             IntToStr(X)+'  :  '+IntTostr(y);

end;

procedure TJR_GantForm.GantGridClick(Sender: TObject);
begin
       //Закрашиваю занятые клетки
       AllFillCells;
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
          Label1.Caption := IntToStr(X)+'  :  '+IntTostr(y);

end;

procedure TJR_GantForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
