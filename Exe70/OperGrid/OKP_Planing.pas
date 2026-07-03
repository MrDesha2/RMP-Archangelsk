unit OKP_Planing;

interface

uses
  Classes, DateUtils, Base, OperPlanForm, Dbtables, Controls, SysUtils, Variants, ComCtrls, Dialogs;

type
  TMasPlan = record
    DateBeg : TDate; //Дата начала планирования
    DateEnd : TDate; //Дата окончания планирования
    DateTimeBeg : TDateTime; //Время начала планирования
    DateTimeEnd : TDateTime; //Время окончания планирования
    WorkTimeBeg : TDateTime; //Время начала работы
    WorkTimeEnd : TDateTime; //Время завершения работы
    DinnerTimeBeg : TDateTime; //Время начала работы
    DinnerTimeEnd : TDateTime; //Время окончания работы
    Oper : array of String;
  end;

  OKPPlaning = class(TThread)
  procedure CopyStruct(StructCopy : Pointer; Progress: TProgressBar; OperPlan_Form : TOperPlan_Form; ThreadOKP : TThread);
  private
    Struct : array of TMasPlan;
    ProgressBar: TProgressBar;
    ThreadPlaningOKP : TThread;
  protected
    procedure Execute; override;
  public
  end;
var glOperPlan_Form : TOperPlan_Form;


implementation

uses DB;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure OKPPlaning.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

//uses OperPlanForm;

procedure OKPPlaning.CopyStruct(StructCopy : Pointer; Progress: TProgressBar;
OperPlan_Form : TOperPlan_Form; ThreadOKP : TThread);
begin
    Struct:=StructCopy;
    ProgressBar:=Progress;
    ThreadPlaningOKP:=ThreadOKP;
    glOperPlan_Form := OperPlan_Form;
    glOperPlan_Form.DelButton.Enabled:=False;
    glOperPlan_Form.BeginButton.Enabled:=False;
    ThreadPlaningOKP.FreeOnTerminate := True;
//    inherited ThreadPlaningOKP:=Create(False);
end;

procedure OKPPlaning.Execute;
Var Date_From : TDateTime;
    Date_To   : TDateTime;
    Date_Beg_Save : TDateTime;
    Date_End_Save : TDateTime;
    s,d : String;
    i, j: integer;
    q: TQuery;
begin

//  Q := TQuery.Create(self);

  Date_To := EncodeDateTime(YearOf(Struct[0].DateEnd), MonthOf(Struct[0].DateEnd),
                            DayOf(Struct[0].DateEnd), HourOf(Struct[0].DateTimeEnd),
                            MinuteOf(Struct[0].DateTimeEnd), SecondOf(Struct[0].DateTimeEnd), 0);

  If Length(Struct[0].Oper) = 0 Then
  begin
      glOperPlan_Form.OrderQuery.Close;
      glOperPlan_Form.OrderQuery.SQL.Clear;
      glOperPlan_Form.OrderQuery.SQL.Add('Select a.id, a.pr_exec, a.pr_urgen, a.date_out, ');
      glOperPlan_Form.OrderQuery.SQL.Add('a.number, a.id_chrt ');
      glOperPlan_Form.OrderQuery.SQL.Add('From DH_Order a, JR_PLAN b ');
      glOperPlan_Form.OrderQuery.SQL.Add('Where b.period = :PERIOD and ');
      glOperPlan_Form.OrderQuery.SQL.Add('      a.id = b.id_order and ');
      glOperPlan_Form.OrderQuery.SQL.Add('      a.pr_exec in (1,2) ');

      If (glOperPlan_Form.PDRCombo.Text <> '<Объект не найден>') and
          (glOperPlan_Form.PDRCombo.Text <> '') Then
            glOperPlan_Form.OrderQuery.SQL.Add('and a.id_pdr = :PDR');

      glOperPlan_Form.OrderQuery.SQL.Add('Order by 2 desc, 4, 3 ');
  end
   else
   begin

      glOperPlan_Form.OrderQuery.Close;
      glOperPlan_Form.OrderQuery.SQL.Clear;
      glOperPlan_Form.OrderQuery.SQL.Add('Select a.id, a.pr_exec, a.pr_urgen, a.date_out, ');
      glOperPlan_Form.OrderQuery.SQL.Add('a.number, a.id_chrt ');
      glOperPlan_Form.OrderQuery.SQL.Add('From DH_Order a, JR_PLAN b ');
      glOperPlan_Form.OrderQuery.SQL.Add('Where b.period = :PERIOD and ');
      glOperPlan_Form.OrderQuery.SQL.Add('      a.id = b.id_order and ');
      glOperPlan_Form.OrderQuery.SQL.Add('      a.pr_exec in (1,2) ');

      If (glOperPlan_Form.PDRCombo.Text <> '<Объект не найден>') and
          (glOperPlan_Form.PDRCombo.Text <> '') Then
            glOperPlan_Form.OrderQuery.SQL.Add('and a.id_pdr = :PDR');

      glOperPlan_Form.OrderQuery.SQL.Add('Order by 2 desc, 4, 3 ');


{Select a.id_order,
       (Select count(b.id_vop) From dt_order1 b, Spr_Vop c
        Where b.id_order = a.id_order and c.id = b.id_vop and c.parentid in
        (Select d.id From Spr_Vop d Where d.name = 'ТОКАРНЫЕ' or d.name = 'ФРЕЗЕРНЫЕ'))
From dt_order1 a
Group By a.id_order}

//       OperPlan_Form.OrderQuery.Close;
//       OperPlan_Form.OrderQuery.SQL.Clear;
//       OperPlan_Form.OrderQuery.SQL.Add('Select a.id_order, ');
//       OperPlan_Form.OrderQuery.SQL.Add('(Select count(b.id_vop) From dt_order1 b, Spr_Vop c ');
//       OperPlan_Form.OrderQuery.SQL.Add('Where b.id_order = a.id_order and c.id = b.id_vop and c.parentid in ');
//       OperPlan_Form.OrderQuery.SQL.Add('(Select d.id From Spr_Vop d ');

//       i:=0;
//       j:=0;
//       While (i < Length(Struct[0].Oper)) do
//       begin
//            If (j = 0) Then
//            begin
//               j := 1;
//               OperPlan_Form.OrderQuery.SQL.Add('Where d.name = '+''''+Struct[0].Oper[i]+'''');
//               OperPlan_Form.OrderQuery.SQL.Text;    //Проверка
//            end
//             else
//                OperPlan_Form.OrderQuery.SQL.Add('and d.name = '+''''+Struct[0].Oper[i]+'''');
//            i:=i+1;
//       end;

//       OperPlan_Form.OrderQuery.SQL.Add(')) From dt_order1 a ');
//       OperPlan_Form.OrderQuery.SQL.Add('Group By a.id_order ');  }
//       OperPlan_Form.OrderQuery.SQL.Add('Order by 2 ');
   end;

   If (glOperPlan_Form.PDRCombo.Text <> '<Объект не найден>') and
       (glOperPlan_Form.PDRCombo.Text <> '') Then
         glOperPlan_Form.OrderQuery.ParamByName('Pdr').AsInteger := glOperPlan_Form.qPDRQuery.FieldByName('id').AsInteger;


  glOperPlan_Form.OrderQuery.ParamByName('Period').AsInteger := Period;
  glOperPlan_Form.OrderQuery.Open;
  glOperPlan_Form.ProgressBar.Max := glOperPlan_Form.OrderQuery.RecordCount;
  glOperPlan_Form.ProgressBar.Position := 0;

  While (not glOperPlan_Form.OrderQuery.Eof) and
        (not Terminated)  do
  begin

      glOperPlan_Form.ProgressBar.Position := glOperPlan_Form.ProgressBar.Position + 1;
   //   OperPlan_Form.ProgressBar.Refresh;
      Date_From := EncodeDateTime(YearOf(Struct[0].DateBeg), MonthOf(Struct[0].DateBeg),
                            DayOf(Struct[0].DateBeg), HourOf(Struct[0].DateTimeBeg),
                            MinuteOf(Struct[0].DateTimeBeg), SecondOf(Struct[0].DateTimeBeg), 0);
      glOperPlan_Form.VOPQuery.Close;
      glOperPlan_Form.VOPQuery.SQL.Clear;
      glOperPlan_Form.VOPQuery.SQL.Add('Select b.id, b.name, a.lineno, a.ntime ');
      glOperPlan_Form.VOPQuery.SQL.Add('From DT_Order1 a, Spr_Vop b ');
      glOperPlan_Form.VOPQuery.SQL.Add('Where a.id_order = :TMP_ID and ');
      glOperPlan_Form.VOPQuery.SQL.Add('b.id = a.ID_VOP ');
      glOperPlan_Form.VOPQuery.SQL.Add('Order by 3 ');

      glOperPlan_Form.VOPQuery.ParamByName('TMP_ID').AsInteger := glOperPlan_Form.OrderQuery.FieldBYName('ID').AsInteger;
      glOperPlan_Form.VOPQuery.Open;

      Repeat
      begin

          glOperPlan_Form.CommitQuery.Close;
          glOperPlan_Form.CommitQuery.SQL.Clear;
          glOperPlan_Form.CommitQuery.SQL.Add('Select * ');
          glOperPlan_Form.CommitQuery.SQL.Add('From ADD_OPERPLAN_PROC(:DATE_FROM, :DATE_TO, :TMP_ID, ');
          glOperPlan_Form.CommitQuery.SQL.Add(':TMP_ID_CHRT, :TMP_ID_VOP, :LINENO_VOP, :TMP_NTIME, ');
          glOperPlan_Form.CommitQuery.SQL.Add(':DINNER_FROM, :DINNER_TO, :WORK_FROM, :WORK_TO)');

{          If (glOperPlan_Form.OrderQuery.FieldByName('id').AsInteger = 17759) and
             (glOperPlan_Form.VOPQuery.FieldByName('lineno').AsInteger = 7)Then
              s:= DateTimeToStr(Date_From);}

          glOperPlan_Form.CommitQuery.ParamByName('DATE_FROM').AsDateTime := Date_From;
//          s:= DateTimeToStr(Date_From);
          glOperPlan_Form.CommitQuery.ParamByName('DATE_TO').AsDateTime:=Date_To;
//          s:= DateTimeToStr(Date_To);
          glOperPlan_Form.CommitQuery.ParamByName('TMP_ID').AsInteger :=glOperPlan_Form.OrderQuery.FieldByName('id').AsInteger;
          glOperPlan_Form.CommitQuery.ParamByName('TMP_ID_CHRT').AsInteger := glOperPlan_Form.OrderQuery.FieldByName('id_chrt').AsInteger;
          glOperPlan_Form.CommitQuery.ParamByName('TMP_ID_VOP').AsInteger := glOperPlan_Form.VOPQuery.FieldByName('id').AsInteger;
          glOperPlan_Form.CommitQuery.ParamByName('LINENO_VOP').AsInteger := glOperPlan_Form.VOPQuery.FieldByName('lineno').AsInteger;
          glOperPlan_Form.CommitQuery.ParamByName('TMP_NTIME').AsInteger := glOperPlan_Form.VOPQuery.FieldByName('ntime').AsInteger;
          glOperPlan_Form.CommitQuery.ParamByName('DINNER_FROM').AsDateTime := Struct[0].DinnerTimeBeg;
          s:= DateTimeToStr(Struct[0].DinnerTimeBeg);
          glOperPlan_Form.CommitQuery.ParamByName('DINNER_TO').AsDateTime := Struct[0].DinnerTimeEnd;
          s:= DateTimeToStr(Struct[0].DinnerTimeEnd);
          glOperPlan_Form.CommitQuery.ParamByName('WORK_FROM').AsDateTime := Struct[0].WorkTimeBeg;
          s:= DateTimeToStr(Struct[0].WorkTimeBeg);
          glOperPlan_Form.CommitQuery.ParamByName('WORK_TO').AsDateTime := Struct[0].WorkTimeEnd;
          s:= DateTimeToStr(Struct[0].WorkTimeEnd);

          glOperPlan_Form.CommitQuery.Open;

          Date_Beg_Save := glOperPlan_Form.CommitQuery.FieldByName('DATE_BEG').AsDateTime;
{          If (TimeOf(glOperPlan_Form.CommitQuery.FieldByName('DATE_BEG').AsDateTime) > StrToTime('17:00:00')) or
             (TimeOf(glOperPlan_Form.CommitQuery.FieldByName('DATE_BEG').AsDateTime) < StrToTime('8:00:00')) Then
            s:= DateTimeToStr(Date_Beg_Save);}
          Date_End_Save := glOperPlan_Form.CommitQuery.FieldByName('DATE_END').AsDateTime;
{          If (TimeOf(glOperPlan_Form.CommitQuery.FieldByName('DATE_END').AsDateTime) > StrToTime('17:00:00')) or
             (TimeOf(glOperPlan_Form.CommitQuery.FieldByName('DATE_END').AsDateTime) < StrToTime('8:00:00')) Then
            d:= DateTimeToStr(Date_End_Save);}

          If ((Date_Beg_Save <> Null) and (Date_End_Save <> Null)) Then
          begin

             data.RMPBase.StartTransaction;
             glOperPlan_Form.UpdateStoredProc.Close;
             glOperPlan_Form.UpdateStoredProc.ParamByName('ID').AsInteger := glOperPlan_Form.OrderQuery.FieldByName('id').AsInteger;
             glOperPlan_Form.UpdateStoredProc.ParamByName('LINENO_VOP').AsInteger := glOperPlan_Form.VOPQuery.FieldByName('lineno').AsInteger;
             glOperPlan_Form.UpdateStoredProc.ParamByName('ID_WRKR').AsInteger := glOperPlan_Form.CommitQuery.FieldByName('TMP_WRKR_MIN').AsInteger;
             glOperPlan_Form.UpdateStoredProc.ParamByName('ID_EQPT').AsInteger := glOperPlan_Form.CommitQuery.FieldByName('TMP_EQPT_MIN').AsInteger;
             glOperPlan_Form.UpdateStoredProc.ParamByName('DATE_BEG').AsDateTime := Date_Beg_Save;
             glOperPlan_Form.UpdateStoredProc.ParamByName('DATE_END').AsDateTime := Date_End_Save;
             glOperPlan_Form.UpdateStoredProc.Prepare;
             glOperPlan_Form.UpdateStoredProc.ExecProc;

             Date_From := Date_End_Save;
             data.RMPBase.Commit;
          end;

          glOperPlan_Form.VOPQuery.Next;
      end
      until ((glOperPlan_Form.VOPQuery.Eof) or
             ((Date_Beg_Save = Null) and (Date_End_Save = Null)));

      glOperPlan_Form.OrderQuery.Next;
  end;

  If glOperPlan_Form.ThreadPlaningActive = True Then
  begin
         glOperPlan_Form.DelButton.Enabled:=True;
         glOperPlan_Form.BeginButton.Enabled:=True;
         ThreadPlaningOKP.FreeOnTerminate:=True;
         ThreadPlaningOKP.Terminate;
         glOperPlan_Form.ThreadPlaningActive := false;
         glOperPlan_Form.StopButton.Enabled :=False;
         glOperPlan_Form.Close ;
  end;
end;

end.
