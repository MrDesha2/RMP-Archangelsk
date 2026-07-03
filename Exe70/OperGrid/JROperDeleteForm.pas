unit JROperDeleteForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, ComCtrls, StdCtrls, Mask, ToolEdit, JROperForm, AddExecuter_Form,
  ExtCtrls, DB, DBTables, DateUtils, DateUtil;

type
  TJR_OPERDELETEForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Title1Label: TLabel;
    Title2Label: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    TimeBEG: TDateTimePicker;
    TimeEND: TDateTimePicker;
    DelButton: TButton;
    CloseButton: TButton;
    MaxMinTimeQuery: TQuery;
    Title3Label: TLabel;
    DelPlanStoredProc: TStoredProc;
    procedure DelButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    constructor CreateN(AOwner1: TJR_OPERForm; AOwner2: TAddExecuterForm; _Period : integer; _ID_Pdr : Integer);
    destructor Destroy; override;
  end;

var
  JR_OPERDELETEForm: TJR_OPERDELETEForm;
  Period     : integer;        // период просмотра журнала
  ID_Pdr     : integer;        // подразделение для которого был создан план
  strMon     : string;

implementation

uses ParamForm;

{$R *.dfm}

constructor TJR_OPERDELETEForm.CreateN(AOwner1: TJR_OPERForm; AOwner2: TAddExecuterForm; _Period : integer; _ID_Pdr : Integer);
Var
 s : String;
 nMonth     : Word;     // текущая дата
 BegDateTime, EndDateTime : TDateTime;
begin

  Period := _Period;
  ID_Pdr := _Id_Pdr;
  nMonth := _Period - (_Period div 12) * 12 +1;
  case nMonth of
         1 : StrMon := 'Январь';
         2 : StrMon := 'Февраль';
         3 : StrMon := 'Март';
         4 : StrMon := 'Апрель';
         5 : StrMon := 'Май';
         6 : StrMon := 'Июнь';
         7 : StrMon := 'Июль';
         8 : StrMon := 'Август';
         9 : StrMon := 'Сентябрь';
         10 : StrMon := 'Октябрь';
         11 : StrMon := 'Ноябрь';
         12 : StrMon := 'Декабрь';
  end;

  BegDateTime := EncodeDateTime(2000+(Period div 12),
     Period - (Period div 12)*12 + 1, 1, HourOf(Param_Form.WorkDateTimeBeg.Time),
     MinuteOf(Param_Form.WorkDateTimeBeg.Time), SecondOf(Param_Form.WorkDateTimeBeg.Time), 0);

  s:=IntToStr(DaysPerMonth(2000+(Period div 12), Period - (Period div 12)*12 + 1));

  EndDateTime := EncodeDateTime(2000+(Period div 12),
     Period - (Period div 12)*12 + 1,
     DaysPerMonth(2000+(Period div 12), Period - (Period div 12)*12 + 1), HourOf(Param_Form.WorkDateTimeEnd.Time),
     MinuteOf(Param_Form.WorkDateTimeEnd.Time), SecondOf(Param_Form.WorkDateTimeEnd.Time), 0);

  s:=DateTimeToStr(EncodeDateTime(2000+(Period div 12),
     Period - (Period div 12)*12 + 1,
     DaysPerMonth(2000+(Period div 12), Period - (Period div 12)*12 + 1), 0, 0, 0, 0));

  If (AOwner1 <> Nil) Then
  begin
      inherited Create(AOwner1);
      Title3Label.Visible := False;
      Title1Label.Caption := 'Очистка времени выполнения операций';
      Title2Label.Caption := 'За период '+StrMon;
      MaxMinTimeQuery.Close;
      MaxMinTimeQuery.SQL.Clear;
      MaxMinTimeQuery.SQL.Add('Select min(DATE_BEG), max(DATE_END), min(TIME_BEG), max(TIME_END)');
      MaxMinTimeQuery.SQL.Add('From dt_order1 ');
      MaxMinTimeQuery.SQL.Add('Where date_beg >= :DATE_BEG and date_end <=:DATE_END ');
      MaxMinTimeQuery.ParamByName('DATE_BEG').AsDateTime := BegDateTime;
      MaxMinTimeQuery.ParamByName('DATE_END').AsDateTime := EndDateTime;
      MaxMinTimeQuery.Open;
  end
   else
      If (AOwner2 <> Nil) Then
      begin
        inherited Create(AOwner2);
        Title3Label.Visible := False;
        Title1Label.Caption := 'Очистка времени выполнения операций';
        Title2Label.Caption := 'За период '+StrMon;
        MaxMinTimeQuery.Close;
        MaxMinTimeQuery.SQL.Clear;
        MaxMinTimeQuery.SQL.Add('Select min(DATE_BEG), max(DATE_END), min(TIME_BEG), max(TIME_END), c.NAME');
        MaxMinTimeQuery.SQL.Add('From dt_order1 a, dh_order b, Spr_Pdr c');
        MaxMinTimeQuery.SQL.Add('Where a.date_beg >= :DATE_BEG and a.date_end <=:DATE_END and ');
        MaxMinTimeQuery.SQL.Add('b.id = a.id_order and b.id = :ID_PDR and b.ID_PDR = c.ID');
        MaxMinTimeQuery.ParamByName('DATE_BEG').AsDateTime := BegDateTime;
        MaxMinTimeQuery.ParamByName('DATE_END').AsDateTime := EndDateTime;
        MaxMinTimeQuery.ParamByName('ID_PDR').AsInteger := ID_Pdr;
        MaxMinTimeQuery.Open;
        Title3Label.Visible := True;
        Title3Label.Caption := 'Участок '+ Trim(MaxMinTimeQuery.FieldByName('NAME').AsString);
      end;

  //Если в запросе существует хотябы одно строка
  If (MaxMinTimeQuery.Eof) Then
      BegDateEdit.Date := MaxMinTimeQuery.FieldByName('DATE_BEG').AsDateTime
   else
       BegDateEdit.Date := DateOf(BegDateTime);

  If (MaxMinTimeQuery.Eof) Then
      EndDateEdit.Date := MaxMinTimeQuery.FieldByName('DATE_END').AsDateTime
   else
       EndDateEdit.Date := DateOf(EndDateTime);

  If (MaxMinTimeQuery.Eof) Then
      TimeBeg.Time := StrToTime(MaxMinTimeQuery.FieldByName('TIME_BEG').AsString)
   else
       TimeBeg.Time := TimeOf(BegDateTime);

  If (MaxMinTimeQuery.Eof) Then
      TimeEnd.Time := StrToTime(MaxMinTimeQuery.FieldByName('TIME_END').AsString)
   else
       TimeEnd.Time := TimeOf(EndDateTime);

end;

destructor TJR_OPERDELETEForm.Destroy;
begin
  inherited;
end;

procedure TJR_OPERDELETEForm.DelButtonClick(Sender: TObject);
Var s : String;
begin

    DelPlanStoredProc.Close;
    DelPlanStoredProc.ParamByName('period').AsInteger := Period;
    s:=DateTimeToStr(EncodeDateTime(2000+(Period div 12),
      Period - (Period div 12)*12 + 1, 1, 0, 0, 0, 0));
    DelPlanStoredProc.ParamByName('DATE_BEG').AsDateTime :=
        StrToDateTime(DateToStr(BegDateEdit.Date)+' '+TimeToStr(TimeBeg.Time));
    s:=DateToStr(BegDateEdit.Date)+' '+TimeToStr(TimeBeg.Time);

    DelPlanStoredProc.ParamByName('DATE_END').AsDateTime :=
      StrToDateTime(DateToStr(EndDateEdit.Date)+' '+TimeToStr(TimeEnd.Time));
    s:=DateToStr(EndDateEdit.Date)+' '+TimeToStr(TimeEnd.Time);

    If (ID_Pdr <>0) Then
      DelPlanStoredProc.ParamByName('ID_PDR').AsInteger:=ID_PDR;

    DelPlanStoredProc.Prepare;
    DelPlanStoredProc.ExecProc;
    DelPlanStoredProc.Close;
    MessageDlg('Удаление плана за '+StrMon+' завершено!', mtInformation,
            [mbOk], 0);
    CloseButtonClick(Nil);
end;

procedure TJR_OPERDELETEForm.CloseButtonClick(Sender: TObject);
begin
  Title3Label.Visible := False;
  Close;
end;

procedure TJR_OPERDELETEForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
