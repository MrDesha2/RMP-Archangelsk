unit InfOperForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ToolEdit, Mask, CurrEdit, DB,
  DBTables, DateUtils, Math;

type
  TInf_OperForm = class(TForm)
    Panel1: TPanel;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    Label1: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    Memo: TMemo;
    TimeQuery: TQuery;
    SaveButton: TButton;
    Button2: TButton;
    TimeEdit: TEdit;
    UpdateOrd1StoredProc: TStoredProc;
    TimeBEG: TMaskEdit;
    TimeEnd: TMaskEdit;
    Label4: TLabel;
    OldOperQuery: TQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    Column, Row : integer;
  public
    constructor CreateN(AOwner: TForm; BegTime, EndTime : TDateTime;
                       Wrkr, Eqpt, GantRow, GantCol : integer; Change: Boolean);
    destructor Destroy; override;
  end;

var
  Inf_OperForm: TInf_OperForm;

implementation

uses Types, ParamForm, JRGantForm;
{$R *.dfm}

constructor TInf_OperForm.createN(AOwner: TForm; BegTime, EndTime : TDateTime;
                                  Wrkr, Eqpt, GantRow, GantCol : integer; Change: Boolean);
Var a, b:String;
c, d: String;
begin

    inherited Create(AOwner);
    Row := GantRow;
    Column := GantCol;

    // создание запроса для формы

    with TimeQuery do
    begin

        Close;

        sql.clear;
        sql.add('Select * From INFO_OPER_PROC(:BEG_DATE, :END_DATE, :BEG_TIME, :END_TIME, :WRKR_ID, :EQPT_ID)');

        ParamByName('BEG_DATE').AsDate := DateOf(BegTime);
        ParamByName('END_DATE').AsDate := DateOf(EndTime);
        a:=DateToStr(ParamByName('BEG_DATE').AsDate);
        b:=DateToStr(ParamByName('END_DATE').AsDate);
        Label4.Caption := a+b;
        ParamByName('BEG_TIME').AsString := IntToStr(HourOf(BegTime))+':';

        //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
        If Length(IntToStr(MinuteOf(BegTime))) <= 1 Then
              ParamByName('BEG_TIME').AsString :=
                 ParamByName('BEG_TIME').AsString+'0'+IntToStr(MinuteOf(BegTime))
         else
              ParamByName('BEG_TIME').AsString :=
                 ParamByName('BEG_TIME').AsString+IntToStr(MinuteOf(BegTime));
        c:=ParamByName('BEG_TIME').AsString;

        ParamByName('END_TIME').AsString := IntToStr(HourOf(EndTime))+':';

        //Чтобы минуты не записывались одной цифрой впереди приписываем '0'
        If Length(IntToStr(MinuteOf(EndTime))) <= 1 Then
              ParamByName('END_TIME').AsString :=
                 ParamByName('END_TIME').AsString+'0'+IntToStr(MinuteOf(EndTime))
         else
              ParamByName('END_TIME').AsString :=
                 ParamByName('END_TIME').AsString+IntToStr(MinuteOf(EndTime));
        d:=ParamByName('END_TIME').AsString;
        ParamByName('WRKR_ID').AsInteger := Wrkr;
        ParamByName('EQPT_ID').AsInteger := Eqpt;


        open;

    end;

  //  Tablename := 'jr_gant';
    TimeEdit.Text := FormatFloat('0.00', TimeQuery.FieldByName('NTIME').AsFloat);
    BegDateEdit.Text := TimeQuery.FieldByName('DATE_BEG').AsString;
    EndDateEdit.Text := TimeQuery.FieldByName('DATE_END').AsString;
    TimeBeg.Text  := TimeQuery.FieldByName('TIME_BEG').AsString;
    TimeEnd.Text  := TimeQuery.FieldByName('TIME_END').AsString;

    If Change = False Then
    begin
       BegDateEdit.Enabled := False;
       EndDateEdit.Enabled := False;
       TimeBeg.Enabled := False;
       TimeEnd.Enabled := False;
    end
     else
     begin
        BegDateEdit.Enabled := True;
        EndDateEdit.Enabled := True;
        TimeBeg.Enabled := True;
        TimeEnd.Enabled := True;
     end;

    OldOperQuery.Close;
    OldOperQuery.ParamByName('id').AsInteger  := TimeQuery.FieldByName('ORDER_ID').AsInteger;
    OldOperQuery.ParamByName('line').AsInteger:= TimeQuery.FieldByName('LINE').AsInteger;
    OldOperQuery.Open;

    Memo.Text := '';
    Memo.Lines.Add('Заявка/Заказ: '+TimeQuery.FieldByName('Rqst_Number').AsString+'/'+
                                  TimeQuery.FieldByName('Order_Number').AsString);
    Memo.Lines.Add('Заказчик    : '+TimeQuery.FieldByName('NAME_CST').AsString);
    Memo.Lines.Add('Исполнитель : '+TimeQuery.FieldByName('NAME_PDR').AsString);
    Memo.Lines.Add('Номенклатура: '+TimeQuery.FieldByName('NAME_NMNT').AsString);
    Memo.Lines.Add('Чертеж      : '+TimeQuery.FieldByName('CODE_CHRT').AsString);
    Memo.Lines.Add('№ операции  : '+TimeQuery.FieldByName('LINE').AsString);
    Memo.Lines.Add('Операция    : '+TimeQuery.FieldByName('NAMEOP').AsString);
    Memo.Lines.Add('Дата начала : '+TimeQuery.FieldByName('DATE_BEG').AsString+' '+
                                    TimeQuery.FieldByName('TIME_BEG').AsString);
    Memo.Lines.Add('Дата финала : '+TimeQuery.FieldByName('DATE_END').AsString+' '+
                                    TimeQuery.FieldByName('TIME_END').AsString);
    Memo.Lines.Add('');
    Memo.Lines.Add('----------Предыдущие операции---------');
    Memo.Lines.Add('');

    While not OldOperQuery.Eof do
    begin
        Memo.Lines.Add(OldOperQuery.FieldByName('LINENO').AsString+'.'+
                       OldOperQuery.FieldByName('NAME').AsString + ' '+
                       OldOperQuery.FieldByName('DATE_END').AsString);
        OldOperQuery.Next;
    end;

    caption   := 'Информация к размышлению...';

    HelpContext := 350;

    // в зависимости от пожелания открываются окна
    if Param_Form.glOpenAllFormMaximized then
      WindowState := wsMaximized;

end;

destructor TInf_OperForm.Destroy;
begin
  inherited;
end;


procedure TInf_OperForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;

end;

procedure TInf_OperForm.SaveButtonClick(Sender: TObject);
Var Col : TDateTime;
 MasCol : Integer;
    m,j : Real;
      i : Integer;
begin

        MasCol:=0;
//        JR_GantForm.GantGrid.MouseToCell(Drag_X+32, Drag_Y, Column, Row);
        Col := StrToDateTime(BegDateEdit.Text + ' ' + Trim(TimeBeg.Text));

        //Убираем изменяемую операцию из массива ColumnTime
        j := TimeQuery.FieldByName('NTIME').AsFloat;
        i:=0;
        While (j > 0) { and (JR_GantForm.GantGrid.ColCount >= Column+i) } do
        begin
              ColumnTime[Column+i].Row := 0;
              ColumnTime[Column+i].Busy:= False;
              m:=RoundTo(HourSpan(ColumnTime[Column+i].Time,ColumnTime[Column+i+1].Time),-2);
              j:=RoundTo(j-m, -2);
              i:=i+1; //количество столбцов которое будет занимать новое время
        end;

        While ColumnTime[MasCol].Time <= Col do
          MasCol:=MasCol+1;

        MasCol:=MasCol-1;

        //проверка что вставленные часы не перекрываются с другими часами
        j := TimeQuery.FieldByName('NTIME').AsFloat;
        i:=0;

        While (j > 0) and {(JR_GantForm.GantGrid.ColCount >= Column+i) and}
              ((ColumnTime[MasCol+i].Busy = False) and (ColumnTime[MasCol+i].Row = Row) or
               (ColumnTime[MasCol+i].Row <> Row))  do
        begin
              m:=RoundTo(HourSpan(ColumnTime[MasCol+i].Time,ColumnTime[MasCol+i+1].Time),-2);

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

              j:=RoundTo(j-m, -2);
              i:=i+1; //количество столбцов которое будет занимать новое время
        end;

        //Если j<0 то мы не достали до следующего столбика следовательно можно уменьшить i на 1
        If j<0 Then i:=i-1;
        
        //если часы не перекрываются заполняем диаграму Ганта
        If (ColumnTime[MasCol+i].Busy = False) and (ColumnTime[MasCol+i].Row = Row) or
           (ColumnTime[MasCol+i].Row <> Row) Then
        begin

          //ЗАПИСЬ ПЛАНИРОВАНИЯ ОПЕРАЦИИ В БАЗУ
          UpdateOrd1StoredProc.ParamByName('ID_ORDER').AsInteger := TimeQuery.FieldByName('ORDER_ID').AsInteger;
          UpdateOrd1StoredProc.ParamByName('ID_CHRT').AsInteger  := TimeQuery.FieldByName('CHRT_ID').AsInteger;
          UpdateOrd1StoredProc.ParamByName('ID_VOP').AsInteger   := TimeQuery.FieldByName('VOP_ID').AsInteger;
          UpdateOrd1StoredProc.ParamByName('LINENO').AsInteger   := TimeQuery.FieldByName('LINE').AsInteger;
          UpdateOrd1StoredProc.ParamByName('DATE_BEG').AsDate    := DateOf(StrToDate(BegDateEdit.Text));
          UpdateOrd1StoredProc.ParamByName('DATE_END').AsDate    := DateOf(StrToDate(EndDateEdit.Text));
          UpdateOrd1StoredProc.ParamByName('TIME_BEG').AsString  := Trim(TimeBeg.Text);
          UpdateOrd1StoredProc.ParamByName('TIME_END').AsString  := Trim(TimeEnd.Text);
          UpdateOrd1StoredProc.ParamByName('ID_WRKR').AsInteger  := TimeQuery.FieldByName('ID_WRKR').AsInteger;
          UpdateOrd1StoredProc.ParamByName('ID_EQPT').AsInteger  := TimeQuery.FieldByName('ID_EQPT').AsInteger;

          try
             UpdateOrd1StoredProc.Prepare;
             UpdateOrd1StoredProc.ExecProc;
             Close;
          except
               MessageDlg('Ошибка записи!', mtError, [mbOk], 0);
          end;
        end
         else
         begin
            MessageDlg('Время операции превышает свободный промежуток!', mtWarning, [mbOk], 0);
         end;

end;

procedure TInf_OperForm.Button2Click(Sender: TObject);
begin
    Close;

end;

end.




