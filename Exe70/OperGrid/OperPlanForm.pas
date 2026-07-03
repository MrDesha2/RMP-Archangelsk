unit OperPlanForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Mask, ToolEdit, ExtCtrls, DBTables, DB, DateUtils,
  RXCtrls;

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

  TOperPlan_Form = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DateTimeBeg: TDateTimePicker;
    DateTimeEnd: TDateTimePicker;
    DinnerLabelFrom: TLabel;
    DinnerCheckBox: TCheckBox;
    DinnerDateTimeFrom: TDateTimePicker;
    DinnerLabelTo: TLabel;
    DinnerDateTimeTo: TDateTimePicker;
    ProgressBar: TProgressBar;
    BeginButton: TButton;
    CloseButton: TButton;
    StopButton: TButton;
    OrderQuery: TQuery;
    VOPQuery: TQuery;
    CommitQuery: TQuery;
    UpdateStoredProc: TStoredProc;
    Label5: TLabel;
    WorkDateTimeBeg: TDateTimePicker;
    Label6: TLabel;
    WorkDateTimeEnd: TDateTimePicker;
    OperCheckBox: TCheckBox;
    OperCheckListBox: TRxCheckListBox;
    Splitter: TSplitter;
    OperQuery: TQuery;
    Label7: TLabel;
    qPDRQuery: TQuery;
    DelButton: TButton;
    DelPlanStoredProc: TStoredProc;
    CreateTableStoredProc: TStoredProc;
    DateBeg: TDateEdit;
    DateEnd: TDateEdit;
    PdrCombo: TComboEdit;
    procedure DinnerCheckBoxClick(Sender: TObject);
    procedure BeginButtonClick(Sender: TObject);
    procedure OperCheckBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    Num_Oper : integer;          // содержит количество операций отображаемых OperCheckListBox
    ThreadPlaningActive : Boolean;
    Struct : array of TMasPlan;
    constructor CreateN(AOwner: TForm; _Period : integer);
    destructor Destroy; override;
  end;

var
  OperPlan_Form: TOperPlan_Form;
  Period     : integer;        // период просмотра журнала

implementation

uses Base, JROPERForm, ParamForm, OKP_Planing, libs;

var ThreadPlaning : OKPPlaning;

{$R *.dfm}

constructor TOperPlan_Form.CreateN(AOwner: TForm; _Period : integer);
var day, mon, year :word;
begin

  inherited Create(AOwner);

  Period   := _Period;

  //Дата и время начала планирования
  DateBeg.Text := DateToStr(Date);
  if (Param_Form.WorkDateTimeBeg.Time = Null)  then
        DateTimeBeg.Time := EncodeTime(8,0,0,0) //Time+1;
   else
        DateTimeBeg.Time := Param_Form.WorkDateTimeBeg.Time;

  //Дата и время окончания планирования
  DateEnd.Text := DateToStr(Date+5);
  if (Param_Form.WorkDateTimeEnd.Time = Null)  then
        DateTimeEnd.Time := EncodeTime(17,0,0,0) //Time+1;
   else
        DateTimeEnd.Time := Param_Form.WorkDateTimeEnd.Time;

  //Время начала работы
  if (Param_Form.WorkDateTimeBeg.Time = Null)  then
        WorkDateTimeBeg.Time := EncodeTime(8,0,0,0)
   else
        WorkDateTimeBeg.Time := Param_Form.WorkDateTimeBeg.Time;

  //Время окончания работы
  if (Param_Form.WorkDateTimeEnd.Time = Null)  then
        WorkDateTimeEnd.Time := EncodeTime(17,0,0,0)
   else
        WorkDateTimeEnd.Time := Param_Form.WorkDateTimeEnd.Time;

  //Время начала обеда
  if (Param_Form.DinnerDateTimeFrom.Time = Null)  then
        DinnerDateTimeFrom.Time := EncodeTime(8,0,0,0)
   else
        DinnerDateTimeFrom.Time := Param_Form.DinnerDateTimeFrom.Time;

  //Время окончания работа
  if (Param_Form.DinnerDateTimeTo.Time = Null)  then
        DinnerDateTimeTo.Time := EncodeTime(17,0,0,0)
   else
        DinnerDateTimeTo.Time := Param_Form.DinnerDateTimeTo.Time;

//  Tablename := 'jr_gant';
  caption   := 'Оперативное планирование';

  HelpContext := 350;

  If DinnerCheckBox.Checked = True Then
  begin
    DinnerLabelFrom.Enabled := True;
    DinnerLabelTo.Enabled := True;
    DinnerDateTimeFrom.Enabled := True;
    DinnerDateTimeTo.Enabled := True;
  end
   else
   begin
     DinnerLabelFrom.Enabled := False;
     DinnerLabelTo.Enabled := False;
     DinnerDateTimeFrom.Enabled := False;
     DinnerDateTimeTo.Enabled := False;
   end;

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

end;

destructor TOperPlan_Form.Destroy;
begin
  inherited;
end;


procedure TOperPlan_Form.DinnerCheckBoxClick(Sender: TObject);
begin
  If DinnerCheckBox.Checked = True Then
  begin
    DinnerLabelFrom.Enabled := True;
    DinnerLabelTo.Enabled := True;
    DinnerDateTimeFrom.Enabled := True;
    DinnerDateTimeTo.Enabled := True;
  end
   else
   begin
     DinnerLabelFrom.Enabled := False;
     DinnerLabelTo.Enabled := False;
     DinnerDateTimeFrom.Enabled := False;
     DinnerDateTimeTo.Enabled := False;
   end
end;

procedure TOperPlan_Form.BeginButtonClick(Sender: TObject);
Var Date_From : TDateTime;
    Date_To   : TDateTime;
    Date_Beg_Save : TDateTime;
    Date_End_Save : TDateTime;
    s,d : String;
    i : Integer;
begin

        StopButton.Enabled := True;
        if (ThreadPlaning = nil) or (ThreadPlaningActive = false) then // make sure its not already running
        begin
             SetLength(Struct, Length(Struct)+1);
             Struct[0].DateBeg := DateBeg.Date;
             Struct[0].DateEnd := DateEnd.Date;
             Struct[0].DateTimeBeg := DateTimeBeg.Time;
             Struct[0].DateTimeEnd := DateTimeEnd.Time;
             Struct[0].WorkTimeBeg := WorkDateTimeBeg.Time;
             Struct[0].WorkTimeEnd := WorkDateTimeEnd.Time;
             Struct[0].DinnerTimeBeg := DinnerDateTimeFrom.Time;
             Struct[0].DinnerTimeEnd := DinnerDateTimeTo.Time;

             If OperCheckBox.Checked = True Then
             begin
               i:=0;
               While (i < Num_Oper) do
               begin
                  If (OperCheckListBox.Checked[i] = True) Then
                  begin
                     SetLength(Struct[0].Oper, Length(Struct[0].Oper)+1);
                     Struct[0].Oper[Length(Struct[0].Oper)-1] := OperCheckListBox.Items[i] ;
                  end;
                  i:=i+1;
               end;
             end;
             ThreadPlaning:=OKPPlaning.Create(True);
             ThreadPlaning.CopyStruct(Struct, ProgressBar, self, ThreadPlaning);
             ThreadPlaningActive := true;
             ThreadPlaning.Resume;
//             OperPlan_Form.Close;
        end
         else
            ShowMessage('Копирование еще выполняется');


end;


procedure TOperPlan_Form.OperCheckBoxClick(Sender: TObject);
begin
    If OperCheckBox.Checked = True Then
    begin
        OperCheckListBox.Visible := True;
        Splitter.Visible := True;

        OperQuery.Close;
        OperQuery.SQL.Clear;
        OperQuery.SQL.Add('Select NAME From Spr_Vop Where ISFOLDER = 1 Order By 1 ');
        OperQuery.Open;

        Num_Oper := 0;
        OperCheckListBox.Clear;
        While not OperQuery.Eof do
        begin
           OperCheckListBox.Items.Add(OperQuery.FieldByName('NAME').AsString);
           Num_Oper := Num_Oper + 1;
           OperQuery.Next;
        end;
    end
     else
     begin
          OperCheckListBox.Visible := False;
          Splitter.Visible := False;
     end;


end;

procedure TOperPlan_Form.FormCreate(Sender: TObject);
begin

          PdrCombo.ID := -1;
          OperCheckListBox.Visible := False;
          Splitter.Visible := False;
          OperCheckBox.Checked := False;
          StopButton.Enabled := False;
end;

procedure TOperPlan_Form.StopButtonClick(Sender: TObject);
begin
      If StopButton.Caption = '&Остановить' Then
      begin
         ThreadPlaning.Suspend;
         StopButton.Caption := '&Продолжить';
         StopButton.Repaint;
      end
       else
       begin
         ThreadPlaning.Resume;
         StopButton.Caption := '&Остановить';
         StopButton.Repaint;
       end;
end;

procedure TOperPlan_Form.CloseButtonClick(Sender: TObject);
begin
         If ThreadPlaningActive = True Then
         begin
            If StopButton.Caption = '&Продолжить' Then
                ThreadPlaning.Resume;
            ThreadPlaning.FreeOnTerminate:=True;
            ThreadPlaning.Terminate;
            ThreadPlaningActive := false;
//            ThreadPlaning.Free;
         end;
         Close;
 //        OperPlan_Form.Free;
//         Application.Terminate;
end;

procedure TOperPlan_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
         If ThreadPlaningActive = True Then
         begin
            ThreadPlaning.FreeOnTerminate:=True;
            ThreadPlaning.Terminate;
            ThreadPlaningActive := false;
         end;
         Action := caFree;
//         Free;
//         Application.Terminate;
end;

procedure TOperPlan_Form.PDRComboButtonClick(Sender: TObject);
begin
   SelectFromTable(PDRCombo);
end;

procedure TOperPlan_Form.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);
end;

procedure TOperPlan_Form.DelButtonClick(Sender: TObject);
Var sstr : String;
begin

      If MessageDlg('Вы действительно хотите удалить план '+sstr,
         mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin

          sstr := '';

          If (PDRCombo.Text <> '<Объект не найден>') and
             (PDRCombo.Text <> '') Then sstr := PDRCombo.Text;

          DelPlanStoredProc.Close;
          DelPlanStoredProc.ParamByName('PERIOD').AsInteger := Period;
          DelPlanStoredProc.ParamByName('DATE_BEG').AsDateTime := EncodeDateTime(yearof(datebeg.Date),
              monthof(datebeg.date), dayof(datebeg.date), hourof(datetimebeg.Time), minuteof(datetimebeg.Time),
              SecondOf(datetimebeg.Time), 0);
          DelPlanStoredProc.ParamByName('DATE_END').AsDateTime := EncodeDateTime(yearof(dateend.Date),
              monthof(dateend.date), dayof(dateend.date), hourof(datetimeend.Time), minuteof(datetimeend.Time),
              SecondOf(datetimeend.Time), 0);

          If (PDRCombo.Text <> '<Объект не найден>') and
             (PDRCombo.Text <> '') Then
                DelPlanStoredProc.ParamByName('id_pdr').AsInteger := qPdrQuery.FieldByName('id').AsInteger;

          DelPlanStoredProc.Prepare;
          DelPlanStoredProc.ExecProc;

      end


end;

end.



