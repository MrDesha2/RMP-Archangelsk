unit OperPlanProc;

interface

uses
  Classes;

type
  OperPlanProc = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure OperPlanProc.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ OperPlanProc }

procedure OperPlanProc.Execute;
begin
Var Date_From : TDateTime;
    Date_To   : TDateTime; 
    Date_Beg_Save : TDateTime;
    Date_End_Save : TDateTime;
    s,d : String;
begin

  Date_To := EncodeDateTime(YearOf(DateEnd.Date), MonthOf(DateEnd.Date), DayOf(DateEnd.Date),
                              HourOf(DateTimeEnd.Time), MinuteOf(DateTimeEnd.Time), SecondOf(DateTimeEnd.Time), 0);

  If OperCheckBox.Checked = False Then
  begin
      OrderQuery.Close;
      OrderQuery.SQL.Clear;
      OrderQuery.SQL.Add('Select a.id, a.pr_exec, a.pr_urgen, a.date_out, ');
      OrderQuery.SQL.Add('a.number, a.id_chrt ');
      OrderQuery.SQL.Add('From DH_Order a, JR_PLAN b ');
      OrderQuery.SQL.Add('Where b.period = :PERIOD and ');
      OrderQuery.SQL.Add('      a.id = b.id_order and ');
      OrderQuery.SQL.Add('      a.pr_exec in (1,2) ');
      OrderQuery.SQL.Add('Order by 2 desc, 4, 3 ');
  end
   else
   begin
       OrderQuery.Close;
       OrderQuery.SQL.Clear;
       OrderQuery.SQL.Add('Select a.id, a.pr_exec, a.pr_urgen, a.date_out, ');
       OrderQuery.SQL.Add('a.number, a.id_chrt ');
       OrderQuery.SQL.Add('From DH_Order a, JR_PLAN b ');
       OrderQuery.SQL.Add('Where b.period = :PERIOD and ');
       OrderQuery.SQL.Add('      a.id = b.id_order and ');
       OrderQuery.SQL.Add('      a.pr_exec in (1,2) ');
       OrderQuery.SQL.Add('Order by 2 desc, 4, 3 ');
   end;


  OrderQuery.ParamByName('Period').AsInteger := Period;
  OrderQuery.Open;
  ProgressBar.Max := OrderQuery.RecordCount;
  ProgressBar.Position := 0;

  While not OrderQuery.Eof do
  begin

      ProgressBar.Position := ProgressBar.Position + 1;
      Date_From := EncodeDateTime(YearOf(DateBeg.Date), MonthOf(DateBeg.Date), DayOf(DateBeg.Date),
                                  HourOf(DateTimeBeg.Time), MinuteOf(DateTimeBeg.Time), SecondOf(DateTimeBeg.Time), 0);
      VOPQuery.Close;
      VOPQuery.ParamByName('TMP_ID').AsInteger := OrderQuery.FieldBYName('ID').AsInteger;
      VOPQuery.Open;

      Repeat
      begin
          data.RMPBase.StartTransaction;
          CommitQuery.Close;
          CommitQuery.ParamByName('DATE_FROM').AsDateTime := Date_From;
          CommitQuery.ParamByName('DATE_TO').AsDateTime:=Date_To;
          CommitQuery.ParamByName('TMP_ID').AsInteger :=OrderQuery.FieldByName('id').AsInteger;
          CommitQuery.ParamByName('TMP_ID_CHRT').AsInteger := OrderQuery.FieldByName('id_chrt').AsInteger;
          CommitQuery.ParamByName('TMP_ID_VOP').AsInteger := VOPQuery.FieldByName('id').AsInteger;
          CommitQuery.ParamByName('LINENO_VOP').AsInteger := VOPQuery.FieldByName('lineno').AsInteger;
          CommitQuery.ParamByName('TMP_NTIME').AsInteger := VOPQuery.FieldByName('ntime').AsInteger;
          CommitQuery.ParamByName('DINNER_FROM').AsDateTime := DinnerDateTimeFrom.Time;
          CommitQuery.ParamByName('DINNER_TO').AsDateTime := DinnerDateTimeTo.Time;
          CommitQuery.ParamByName('WORK_FROM').AsDateTime := WorkDateTimeBeg.Time;
          CommitQuery.ParamByName('WORK_TO').AsDateTime := WorkDateTimeEnd.Time;
          CommitQuery.Open;

          Date_Beg_Save := CommitQuery.FieldByName('DATE_BEG').AsDateTime;
          s:= DateTimeToStr(Date_Beg_Save);
          Date_End_Save := CommitQuery.FieldByName('DATE_END').AsDateTime;
          d:= DateTimeToStr(Date_End_Save);

          If ((Date_Beg_Save <> Null) and (Date_End_Save <> Null)) Then
          begin

             UpdateStoredProc.Close;
             UpdateStoredProc.ParamByName('ID').AsInteger := OrderQuery.FieldByName('id').AsInteger;
             UpdateStoredProc.ParamByName('LINENO_VOP').AsInteger := VOPQuery.FieldByName('lineno').AsInteger;
             UpdateStoredProc.ParamByName('ID_WRKR').AsInteger := CommitQuery.FieldByName('TMP_WRKR_MIN').AsInteger;
             UpdateStoredProc.ParamByName('ID_EQPT').AsInteger := CommitQuery.FieldByName('TMP_EQPT_MIN').AsInteger;
             UpdateStoredProc.ParamByName('DATE_BEG').AsDateTime := Date_Beg_Save;
             UpdateStoredProc.ParamByName('DATE_END').AsDateTime := Date_End_Save;
             UpdateStoredProc.Prepare;
             UpdateStoredProc.ExecProc;

             Date_From := Date_End_Save;
          end;
          data.RMPBase.Commit;

          VOPQuery.Next;
      end
      until ((VOPQuery.Eof) or
             ((Date_Beg_Save = Null) and (Date_End_Save = Null)));

      OrderQuery.Next;
  end;
end;

end.
 