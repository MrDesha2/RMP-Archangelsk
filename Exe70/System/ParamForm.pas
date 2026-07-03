{-----------------------------------------------------------------------------
 Unit Name: ParamForm
 Author:    Косицын Дмитрий
 Purpose:  Модуль формы редактирования основных параметров системы.
 History:  2004

 Для регистрации событий временно установлена компонента связи с БВ интербейса.
 
-----------------------------------------------------------------------------}


unit ParamForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Placemnt, Db, DBTables, StrUtils, inifiles,
  IBDatabase, IBEvents, ExtCtrls, ComCtrls, ShlObj;

type
  TParam_Form = class(TForm)
    qWRHSQuery: TQuery;
    qEDIZQuery: TQuery;
    qPlantQuery: TQuery;
    qMVPQuery: TQuery;
    qCountQuery: TQuery;
    qStatQuery: TQuery;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DateFromEdit: TDateEdit;
    DateToEdit: TDateEdit;
    BoxPlanPeriod: TComboBox;
    BoxFactPeriod: TComboBox;
    WorkDateEdit: TDateEdit;
    SelPeriodButton: TButton;
    OPENALLFORMMAXIMIZED: TCheckBox;
    Label11: TLabel;
    FileINI: TLabel;
    LabelUserName: TLabel;
    PanelBot: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    Label15: TLabel;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    WRHSCombo: TComboEdit;
    Label7: TLabel;
    EDIZCombo: TComboEdit;
    Label8: TLabel;
    PlantCombo: TComboEdit;
    Label9: TLabel;
    MVPCombo: TComboEdit;
    Label10: TLabel;
    CountCombo: TComboEdit;
    Label12: TLabel;
    StatCombo: TComboEdit;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    EditEnt: TEdit;
    EditServ: TEdit;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    EditEcon: TEdit;
    EditManager: TEdit;
    EditMech: TEdit;
    TabSheet3: TTabSheet;
    Label19: TLabel;
    WorkDateTimeBeg: TDateTimePicker;
    WorkDateTimeEnd: TDateTimePicker;
    Label20: TLabel;
    DinnerLabelFrom: TLabel;
    DinnerDateTimeFrom: TDateTimePicker;
    DinnerLabelTo: TLabel;
    DinnerDateTimeTo: TDateTimePicker;
    Label21: TLabel;
    EditOKYD: TEdit;
    Label22: TLabel;
    EditOKPO: TEdit;
    GroupBox3: TGroupBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    EditHOST: TEdit;
    EditPORT: TEdit;
    EditPOST_USERNAME: TEdit;
    EditPOST_PASSWORD: TEdit;
    Label27: TLabel;
    EditADRESS_FROM: TEdit;
    procedure CancelButtonClick(Sender: TObject);
    procedure Getparams;
    procedure OKButtonClick(Sender: TObject);
    procedure WRHSComboButtonClick(Sender: TObject);
    procedure EDIZComboButtonClick(Sender: TObject);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WRHSComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetMainForm;
    procedure PlantComboButtonClick(Sender: TObject);
    procedure PlantComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MVPComboButtonClick(Sender: TObject);
    procedure MVPComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CountComboButtonClick(Sender: TObject);
    procedure CountComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateFromEditChange(Sender: TObject);
    function  save: boolean;
    procedure FormCreate(Sender: TObject);
    procedure BoxPlanPeriodChange(Sender: TObject);
    procedure SelPeriodButtonClick(Sender: TObject);
    procedure StatComboButtonClick(Sender: TObject);
    procedure StatComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function ReadParams: boolean;
    procedure FormShow(Sender: TObject);
    procedure EditHOSTChange(Sender: TObject);
    procedure EditPORTChange(Sender: TObject);
    procedure EditPOST_USERNAMEChange(Sender: TObject);
    procedure EditPOST_PASSWORDChange(Sender: TObject);
    procedure EditOKYDChange(Sender: TObject);
    procedure EditOKPOChange(Sender: TObject);
    procedure WorkDateTimeBegChange(Sender: TObject);
    procedure WorkDateTimeEndChange(Sender: TObject);
    procedure DinnerDateTimeFromChange(Sender: TObject);
    procedure DinnerDateTimeToChange(Sender: TObject);
    function CodeString(s:string; code:boolean):string;
    procedure EditADRESS_FROMChange(Sender: TObject);

  private
  public
    CurPlanPeriod : integer;
    CurFactPeriod : integer;
    WorkDate : tDate;
    DateFrom : tDate;
    DateTo   : tdate;
    WorkTime_Beg :TDateTime;   //Время начала рабочего дня
    WorkTime_End :TDateTime;   //Время окончания рабочего дня
    DinnerTime_Beg :TDateTime; //Время начала обеда
    DinnerTime_End :TDateTime; //Время окончания обеда
    OKYD :String;
    OKPO :String;
    Host :String;
    Port :Integer;
    Post_USERNAME :String;
    Post_PASSWORD :String;
    Adress_From   :String;
    DataBaseName : string;
    glID_WRHS : integer;
    glID_EDIZ : integer;
    glID_Plant: integer;
    glID_MVP  : integer;
    glID_Count: integer;
    glID_Stat : integer;
    glOpenAllFormMaximized : boolean;
    glUpdateJROrder : boolean;
    lIniFile: tInifile;
  end;

var
  Param_Form: TParam_Form;

implementation

uses Main,
     base,
     GetPeriods,
     Libs;

{$R *.DFM}
{
     Процедура закрытия формы без сохранения
}
procedure TParam_Form.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TParam_Form.ReadParams: boolean;

var sparam : string;

begin

//   CurPlanPeriod := data.qSysQuery.Fieldbyname('CURPLANPERIOD').AsInteger;
//   CurFactPeriod := data.qSysQuery.Fieldbyname('CURFACTPERIOD').AsInteger;

   // заполнение поля "Единица измерения"
   EDIZCombo.ID := data.qSysQuery.Fieldbyname('MAINEDIZ').AsInteger;
   glID_Ediz    := EDIZCombo.ID;

    // заполнение поля "Склад"
   WRHSCombo.ID   := data.qSysQuery.Fieldbyname('MAINWRHS').AsInteger;
   glID_WRHS      := WRHSCombo.ID;

    // заполнение поля "Завод"
   PlantCombo.ID   := data.qSysQuery.Fieldbyname('MAINPLANT').AsInteger;
   glID_Plant      := PlantCombo.ID;

    // заполнение поля "МВП"
   MVPCombo.ID   := data.qSysQuery.Fieldbyname('MAINMVP').AsInteger;
   glID_MVP      := MVPCombo.ID;

    // заполнение поля "Счет"
   CountCombo.ID   := data.qSysQuery.Fieldbyname('MAINCOUNT').AsInteger;
   glID_Count      := CountCombo.ID;

    // заполнение поля "Статья статистики"
   StatCombo.ID   := data.qSysQuery.Fieldbyname('MAINSTAT').AsInteger;
   glID_Stat      := StatCombo.ID;

   workdate := date;
   DateFrom := data.qSysQuery.Fieldbyname('DATEFROM').AsDateTime;
   DateTo   := data.qSysQuery.Fieldbyname('DATETO').AsDateTime;

   sparam := datetostr(WorkDate);
   WorkDateEdit.Text := sparam;

   sparam := datetostr(DateFrom);
   DateFromEdit.text := sparam;

   sparam := datetostr(DateTo);
   DateToEdit.text   := sparam;

   WorkTime_Beg := data.qSysQuery.Fieldbyname('WORKTIME_BEG').AsDateTime;
   WorkDateTimeBeg.Time := WorkTime_Beg;

   WorkTime_End := data.qSysQuery.Fieldbyname('WORKTIME_END').AsDateTime;
   WorkDateTimeEnd.Time := WorkTime_End;

   DinnerTime_Beg := data.qSysQuery.Fieldbyname('DINNERTIME_BEG').AsDateTime;
   DinnerDateTimeFrom.Time := DinnerTime_Beg;

   DinnerTime_End := data.qSysQuery.Fieldbyname('DINNERTIME_BEG').AsDateTime;
   DinnerDateTimeTo.Time := DinnerTime_End;

   OKYD := data.qSysQuery.FieldByName('OKYD').AsString;
   OKPO := data.qSysQuery.FieldByName('OKPO').AsString;

   Host := data.qSysQuery.FieldByName('HOST').AsString;
   Port := data.qSysQuery.FieldByName('PORT').AsInteger;
   Post_USERNAME := CodeString(data.qSysQuery.FieldByName('POST_USERNAME').AsString, false);
   Post_PASSWORD := CodeString(data.qSysQuery.FieldByName('POST_PASSWORD').AsString, false);
   Adress_From   := CodeString(data.qSysQuery.FieldByName('ADRESS_FROM').AsString, false);

    if CurPlanPeriod > 0 then
      BoxPlanPeriod.ItemIndex := CurPlanPeriod
    else
      BoxPlanPeriod.ItemIndex := BoxPlanPeriod.Items.Count - 1;

    if CurFactPeriod > 0 then
      BoxFactPeriod.ItemIndex := CurFactPeriod
    else
      BoxFactPeriod.ItemIndex := BoxFactPeriod.Items.Count - 1;

   if data.qSysQuery.Fieldbyname('OPENALLFORMMAXIMIZED').Asinteger > 0 then
     glOpenAllFormMaximized := true
     else
       glOpenAllFormMaximized := false;

   OPENALLFORMMAXIMIZED.Checked := glOpenAllFormMaximized;

   if data.qSysQuery.Fieldbyname('UPDATEJRORDER').Asinteger > 0 then
     glUpdateJROrder := true
     else
       glUpdateJROrder := false;

   MainForm.WorkDate      := WorkDate;

   result := true;
   
end;
{
   Сохранение параметров настройки

}
function TParam_Form.save: boolean;
var UserName: string;
begin
   result := false;

   if (EDIZCombo.ID  = -1) or
      (WRHSCombo.ID  = -1) or
      (PlantCombo.ID = -1) or
      (MVPCombo.ID   = -1) or
      (CountCombo.ID = -1) then
      begin
         MessageDlg('Некоторые константы не заполнены', mtWarning, [mbOK], 0);
         abort;
      end;

    if (trim(dateFromEdit.Text) = '.  .') then
      begin
         MessageDlg('Даты указаны не верно.', mtWarning, [mbOK], 0);
         abort;
      end;

    if (trim(dateToEdit.Text) = '.  .') then
      begin
         MessageDlg('Даты указаны не верно.', mtWarning, [mbOK], 0);
         exit;

      end;

    if DateFrom > DateTo then
      begin
         MessageDlg('Интервал дат не верен.', mtWarning, [mbOK], 0);
         exit;

      end;

    data.RMPBase.StartTransaction;

    UserName := trim(uppercase(data.glUserName));
    // параметры записываются для текущего пользователя в системную таблицу
    with data.qSys_proc do
      begin

        ParamByName('USERNAME').AsString  := UserName;
        SetParamCombo(ParamByName('MainEdiz'), EDIZCombo);
        SetParamCombo(ParamByName('MainWRHS'), WRHSCombo);
        SetParamCombo(ParamByName('MainPlant'),PlantCombo);
        SetParamCombo(ParamByName('MainMVP'),  MVPCombo);
        SetParamCombo(ParamByName('MainCount'),CountCombo);
        SetParamCombo(ParamByName('MainStat'), StatCombo);
        
        glOpenAllFormMaximized := OpenAllFormMaximized.Checked;
        if glOpenAllFormMaximized then
          ParamByName('OpenAllFormMaximized').asinteger :=  1
         else
          ParamByName('OpenAllFormMaximized').asinteger :=  0;

        if glUpdateJROrder then
          ParamByName('UPDATEJRORDER').asinteger :=  1
         else
          ParamByName('UPDATEJRORDER').asinteger :=  0;


//
        ParamByName('DateFrom').asdate := DateFrom;
        ParamByName('DateTo').asdate   := DateTo;
//
//        ParamByName('CURPLANPERIOD').asinteger := CurPlanPeriod;
//        ParamByName('CURFACTPERIOD').asinteger := CurFactPeriod;

        ParamByName('WorkTime_Beg').AsDateTime   := WorkDateTimeBeg.Time;
        ParamByName('WorkTime_End').AsDateTime   := WorkDateTimeEnd.Time;
        ParamByName('DinnerTime_Beg').AsDateTime := DinnerDateTimeFrom.Time;
        ParamByName('DinnerTime_End').AsDateTime := DinnerDateTimeTo.Time;

        ParamByName('OKYD').AsString := OKYD;
        ParamByName('OKPO').AsString := OKPO;

        ParamByName('HOST').AsString := Host;
        ParamByName('PORT').AsInteger := Port;
        ParamByName('POST_USERNAME').AsString := CodeString(Post_USERNAME, true);
        ParamByName('POST_PASSWORD').AsString := CodeString(Post_PASSWORD, true);
        ParamByName('ADRESS_FROM').AsString   := CodeString(Adress_From, true);
     end;

   data.qSys_proc.Prepare;
   data.qSys_proc.ExecProc;

   data.RMPBase.Commit;

   lIniFile.WriteInteger('Config','CURPLANPERIOD', CurPlanPeriod);
   lIniFile.WriteInteger('Config','CURFACTPERIOD', CurFactPeriod);

   lIniFile.WriteString('Config', 'Enterprise', EditEnt.Text);
   lIniFile.WriteString('Config', 'Service', EditServ.Text);
   lIniFile.WriteString('Config', 'Mechanic', EditMech.Text);
   lIniFile.WriteString('Config', 'Manager', EditManager.Text);
   lIniFile.WriteString('Config', 'Economist', EditEcon.Text);

   lIniFile.WriteString('Config', 'OKYD', EditOKYD.Text);
   lIniFile.WriteString('Config', 'OKPO', EditOKPO.Text);

   lIniFile.WriteString('Config', 'HOST', EditHOST.Text);
   lIniFile.WriteString('Config', 'PORT', EditPORT.Text);
   lIniFile.WriteString('Config', 'POST_USERNAME', CodeString(EditPOST_USERNAME.Text, true));
   lIniFile.WriteString('Config', 'POST_PASSWORD', CodeString(EditPOST_PASSWORD.Text, true));
   lIniFile.WriteString('Config', 'ADRESS_FROM', CodeString(EditADRESS_FROM.Text, true));

   result := true;

end;

{
   Процедура активации формы.

}
procedure TParam_Form.GetParams;
var FileName : string;
    sparam : string;
    CurrentDate : tDate;


begin

{  if not DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP') then
     if not CreateDir(GetEnvironmentVariable('APPDATA') + '\EnumRMP') then
       raise Exception.Create('Немогу сохранить временные данные по чертежу в '+GetEnvironmentVariable('APPDATA') + '\EnumRMP');}

  FileName := ExtractFilePath(Application.EXEName) + 'rmp.ini';  //1/12/2010
//  if DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP') then
//  begin
//   FileName := GetEnvironmentVariable('APPDATA') + '\EnumRMP\rmp.ini';
   lIniFile := TIniFile.Create(FileName);
   FileIni.Caption := FileName;

   CurPlanPeriod := lIniFile.ReadInteger('Config', 'CurPlanPeriod', 1);
   CurFactPeriod := lIniFile.ReadInteger('Config', 'CurFactPeriod', 1);

   FillPeriodCombo(BoxPlanPeriod);
   FillPeriodCombo(BoxFactPeriod);

   EditEnt.Text    := lIniFile.ReadString('Config', 'Enterprise', '');
   EditServ.Text   := lIniFile.ReadString('Config', 'Service', '');
   EditMech.Text   := lIniFile.ReadString('Config', 'Mechanic', '');
   EditManager.Text:= lIniFile.ReadString('Config', 'Manager', '');
   EditEcon.Text   := lIniFile.ReadString('Config', 'Economist', '');

   EditOKYD.Text   := lIniFile.ReadString('Config', 'OKYD', '');
   EditOKPO.Text   := lIniFile.ReadString('Config', 'OKPO', '');

   EditHOST.Text   := lIniFile.ReadString('Config', 'HOST', '');
   EditPORT.Text   := lIniFile.ReadString('Config', 'PORT', '');
   EditPOST_USERNAME.Text := CodeString(lIniFile.ReadString('Config', 'POST_USERNAME', ''), false);
   EditPOST_PASSWORD.Text := CodeString(lIniFile.ReadString('Config', 'POST_PASSWORD', ''), false);
   EditADRESS_FROM.Text   := CodeString(lIniFile.ReadString('Config', 'ADRESS_FROM', ''), false);

    if CurPlanPeriod > 0 then
      BoxPlanPeriod.ItemIndex := CurPlanPeriod
    else
      BoxPlanPeriod.ItemIndex := BoxPlanPeriod.Items.Count - 1;

    if CurFactPeriod > 0 then
      BoxFactPeriod.ItemIndex := CurFactPeriod
    else
      BoxFactPeriod.ItemIndex := BoxFactPeriod.Items.Count - 1;


   if data.glUserName <> '' then
     LabelUserName.Caption  := 'Пользователь: '  + uppercase(data.glUserName) +
                                  ', роль: ' + data.glRole;


   // настройки из системной таблицы
   if not data.qSysQuery.Eof then
     begin
       ReadParams;
       SetMainForm;
     end
    else
      begin
        MessageDlg('Обнаружен первый запуск системы пользователем. '+#13+#10+'Заполните реквизиты, используемы по умолчанию.', mtWarning, [mbOK], 0);

        CurrentDate := date;

        // начальное заполнение для нового пользователя
        sparam := datetostr(CurrentDate);
        WorkDateEdit.Text := sparam;

        sparam := datetostr(CurrentDate);
        DateFromEdit.text := sparam;

        sparam := datetostr(CurrentDate);
        DateToEdit.text   := sparam;

        EDIZCombo.ID := -1;
        MVPCombo.ID  := -1;
        CountCombo.ID:= -1;
        PlantCombo.ID:= -1;
        StatCombo.ID := -1;
        WRHSCombo.ID := -1;
        glUpdateJROrder := true;

        showmodal;
      end;
//  end

end;


procedure TParam_Form.SetMainForm;
begin

  if (curFactPeriod > 0) and (curplanPeriod > 0) then
   MainForm.MainStatusBar.Panels[1].Text := 'Факт: '
           + BoxFactPeriod.Items[curFactPeriod]
           + '; План: '
           + BoxPlanPeriod.Items[curplanPeriod];


end;



procedure TParam_Form.OKButtonClick(Sender: TObject);
begin
  // запомним параметры
  if not  save then exit;
  SetMainForm;

  ModalResult := mrOK;
end;

{
   Процедура выбора склада по умолчанию

}

procedure TParam_Form.WRHSComboButtonClick(Sender: TObject);
begin
  glID_WRHS      := SelectFromTable(WRHSCombo);

end;

procedure TParam_Form.WRHSComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if checkIfExistCode(WRHSCombo, key, Shift) = false then
     WRHSComboButtonClick(Sender);
     
   glID_WRHS      := WRHSCombo.ID;

end;
{
   Процедура выбора единицы по умолчанию

}

procedure TParam_Form.EDIZComboButtonClick(Sender: TObject);
begin
  glID_Ediz      :=   SelectFromTable(EDIZCombo);

end;
// -- '' --
procedure TParam_Form.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

  glID_Ediz      := EDIZCombo.ID;

end;



procedure TParam_Form.PlantComboButtonClick(Sender: TObject);
begin
  glID_Plant      :=   SelectFromTable(PlantCombo,);

end;

procedure TParam_Form.PlantComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PlantCombo, key, Shift) = false then
    PlantComboButtonClick(Sender);

  glID_Plant      := PlantCombo.ID;


end;

procedure TParam_Form.MVPComboButtonClick(Sender: TObject);
begin
  glID_MVP      :=   SelectFromTable(MVPCombo);

end;

procedure TParam_Form.MVPComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(MVPCombo, key, Shift) = false then
    MVPComboButtonClick(Sender);
  glID_MVP      := MVPCombo.ID;

end;

procedure TParam_Form.CountComboButtonClick(Sender: TObject);
begin
  glID_Count      :=   SelectFromTable(CountCombo);

end;

procedure TParam_Form.CountComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if checkIfExistCode(CountCombo, key, Shift) = false then
    CountComboButtonClick(Sender);

   glID_Count      := CountCombo.ID;

end;

procedure TParam_Form.DateFromEditChange(Sender: TObject);
begin
  if trim(WorkDateEdit.text) <> '.  .' then
    WorkDate := strtoDate(WorkDateEdit.text);

  if trim(DateFromEdit.text) <> '.  .' then
    DateFrom := strToDate(DateFromEdit.text);

  if trim(DateToEdit.text) <> '.  .' then
    DateTo   := strToDate(DateToEdit.text);

end;

procedure TParam_Form.FormCreate(Sender: TObject);
begin
  Getparams;
  PageControl.ActivePageIndex := 0;
end;

procedure TParam_Form.BoxPlanPeriodChange(Sender: TObject);
begin
  CurPlanPeriod :=  BoxPlanPeriod.ItemIndex;
  CurFactPeriod :=  BoxFactPeriod.ItemIndex;
end;



{-----------------------------------------------------------------------------
  Процедура: TParam_Form.SelPeriodButtonClick
  Описание: Выбор периода
  Вход:  Sender: TObject
  Выход: None
-----------------------------------------------------------------------------}

procedure TParam_Form.SelPeriodButtonClick(Sender: TObject);
var _d1, _d2: tdatetime;
    sparam : string;
begin
   _d1 := DateFrom;
   _d2 := DateTo;
   GetPeriod(_d1, _d2);
   DateFrom := _d1;
   DateTo   := _d2;
   sparam := datetostr(DateFrom);
   DateFromEdit.text := sparam;

   sparam := datetostr(DateTo);
   DateToEdit.text   := sparam;

end;

procedure TParam_Form.StatComboButtonClick(Sender: TObject);
begin
  glID_Stat      :=   SelectFromTable(StatCombo);

end;

procedure TParam_Form.StatComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(StatCombo, key, Shift) = false then
    StatComboButtonClick(Sender);

  glID_Stat      := StatCombo.ID;
end;

procedure TParam_Form.FormShow(Sender: TObject);
begin
   pagecontrol.ActivePageIndex := 0;
end;

procedure TParam_Form.EditHOSTChange(Sender: TObject);
begin
    Host := Trim(EditHOST.Text);
end;

procedure TParam_Form.EditPORTChange(Sender: TObject);
begin
    Port :=  StrtoInt(EditPORT.Text);
end;

procedure TParam_Form.EditPOST_USERNAMEChange(Sender: TObject);
begin
    Post_USERNAME := EditPOST_USERNAME.Text;
end;

procedure TParam_Form.EditPOST_PASSWORDChange(Sender: TObject);
begin
    Post_PASSWORD := EditPOST_PASSWORD.Text;
end;

procedure TParam_Form.EditADRESS_FROMChange(Sender: TObject);
begin
    Adress_From := EditADRESS_FROM.Text;
end;

procedure TParam_Form.EditOKYDChange(Sender: TObject);
begin
    OKYD := EditOKYD.Text;
end;

procedure TParam_Form.EditOKPOChange(Sender: TObject);
begin
    OKPO := EditOKPO.Text;
end;

procedure TParam_Form.WorkDateTimeBegChange(Sender: TObject);
begin
    WorkTime_Beg := WorkDateTimeBeg.Time;
end;

procedure TParam_Form.WorkDateTimeEndChange(Sender: TObject);
begin
    WorkTime_End := WorkDateTimeEnd.Time;
end;

procedure TParam_Form.DinnerDateTimeFromChange(Sender: TObject);
begin
    DinnerTime_Beg := DinnerDateTimeFrom.Time;
end;

procedure TParam_Form.DinnerDateTimeToChange(Sender: TObject);
begin
    DinnerTime_End := DinnerDateTimeTo.Time;
end;

//code = true - зашифровывает, code = false - расшифровывает
function TParam_Form.CodeString(s:string;code:boolean):string;
const
   Pas=10;
var
  i,Delta,Res:integer;
begin
  Result:='';
  for i:=1 to Length(s) do
  begin
    Delta:=((i xor Pas) mod (256-32));
    if code then
      Res:=((ord(s[i])+Delta) mod (256-32))+32
    else
    begin
      Res:=ord(s[i])-Delta-32;
      if Res<32 then
        Res:=Res+256-32;
    end;
      Result:=Result+chr(Res);
  end;
end;

end.

