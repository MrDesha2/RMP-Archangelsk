{

                         Модуль Base
   Описание:
     в модуле описаны все основные глобальные запросы работы с таблицами,
     источники, база данных, транзакции и хранимые процедуры.

}
unit Base;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, IBCtrls, ImgList, inifiles, IBEvents, IBDatabase,
  IBServices, IBCustomDataSet, IBQuery, ExtCtrls, IBStoredProc;

type

  // объявление записи по затратам
  PRecord = ^tRecord;

  tRecord = record
      id   : integer;  // ID записи
      Name : string;   // наименование записи
    end;



  TDATA = class(TDataModule)
    RMPBase: TDatabase;
    DocDH_RQSTQuery: TQuery;
    ADD_DT_PR_PROC: TStoredProc;
    ADD_DH_PR_PROC: TStoredProc;
    ADD_DH_RS_PROC: TStoredProc;
    ADD_DT_RS_PROC: TStoredProc;
    qDELQuery: TQuery;
    MainCalculateQuery: TQuery;
    DEL_RQST_PROC: TStoredProc;
    DEL_ORDER_PROC: TStoredProc;
    Session: TSession;
    Semaphor: TImageList;
    ImageListGalka: TImageList;
    EditImages: TImageList;
    TreeImages: TImageList;
    JROrderFormQuery: TQuery;
    JRRQSTFormQuery: TQuery;
    JRPRFormQuery: TQuery;
    JRRSFormQuery: TQuery;
    JRPRMTRFormQuery: TQuery;
    JRRSMPRFormQuery: TQuery;
    JRRQSTFormOrderQuery: TQuery;
    qSysQuery: TQuery;
    IBDatabase: TIBDatabase;
    IBEvents: TIBEvents;
    qCheckGrandQuery: TQuery;
    qSys_Proc: TStoredProc;
    qCheckGrandQueryRDBUSER: TStringField;
    qCheckGrandQueryRDBPRIVILEGE: TStringField;
    qCheckGrandQueryRDBGRANT_OPTION: TSmallintField;
    IBTransaction: TIBTransaction;
    JRMTROrderQuery: TQuery;
    qLogQuery: TQuery;
    Timer: TTimer;
    Add_Order_To_Plan: TStoredProc;
    AddCHRTStoredProc: TStoredProc;
    TableDefProc: TStoredProc;
    JRPREQPTFormQuery: TQuery;
    JRRSEQPTFormQuery: TQuery;
    qJRRQSTEQPTQuery: TQuery;
    sys_enumerationQuery: TQuery;
    JRPRMODELFormQuery: TQuery;
    JRRSMODELFORMQuery: TQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure EventAlerterEventAlert(Sender: TObject; EventName: String;
      EventCount: Integer; var CancelAlerts: Boolean);
    procedure LoginDialogCheckUser(Sender: TObject; const UserName,
      Password: String; var AllowLogin: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure JRRQSTFormQueryAfterScroll(DataSet: TDataSet);
    procedure RMPBaseAfterConnect(Sender: TObject);
    procedure RMPBaseBeforeDisconnect(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure RMPBaseAfterDisconnect(Sender: TObject);
  private
  public
    glPass, glUserName, glRole, glComputerName : string;
    lIniFile: tInifile;
    glCheckOnExit : boolean;
  end;

var
  DATA  : TDATA;
  messagefrm : tForm;

implementation
uses Main,
   mylogin,
 ParamForm,
      libs;

{$R *.DFM}

procedure TDATA.DataModuleDestroy(Sender: TObject);
begin
  RMPBase.Close;
end;

procedure TDATA.EventAlerterEventAlert(Sender: TObject; EventName: String;
  EventCount: longint; var CancelAlerts: Boolean);
begin

      if EventName = 'shutdown' then
        begin
          beep;
          glCheckOnExit := false;
          MAINForm.MenuCloseClick(self);

        end;
   if EventName = 'close' then
      begin
        beep;
        timer.Enabled := true;
//        MessageDlg('Пожалуйста, закройте программу.', mtWarning, [mbOK], 0);
        messagefrm := CreateMessageDialog('Пожалуйста, выйдите из системы.', mtWarning, [mbOK]);
        messagefrm.Show;
      end;

end;

procedure TDATA.LoginDialogCheckUser(Sender: TObject; const UserName,
  Password: String; var AllowLogin: Boolean);
begin
  glPass     := Password;
  glUserName := UserName;
end;
{-----------------------------------------------------------------------------
  Процедура: TDATA.DataModuleCreate
  Автор:    Administrator
  Аргументы: Sender: TObject
  Результат:    None
  Описание:
    Вызывается при начале работы системы. Открывает базу данных, регистрирует
     события и пр.
-----------------------------------------------------------------------------}
procedure TDATA.DataModuleCreate(Sender: TObject);
var FileName : string;
    iParam : integer;
    ParamList   : TStringList;
    DBPath      : string;
    lAliases    : TStringList;
    LocalMachine: array [0..MAX_COMPUTERNAME_LENGTH] of char;
    Size: DWORD;
     MyLoginDLG : TMyLoginDlg;

begin

  Size := Sizeof(LocalMachine);
  getcomputername(LocalMachine,Size);
  glComputerName := LocalMachine;
  glCheckOnExit  := false;

{  if not DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP') then
     if not CreateDir(GetEnvironmentVariable('APPDATA') + '\EnumRMP') then
       raise Exception.Create('Немогу сохранить временные данные по чертежу в '+GetEnvironmentVariable('APPDATA') + '\EnumRMP');
}

//  if DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP') then
//  begin
//   FileName := GetEnvironmentVariable('APPDATA') + '\EnumRMP\rmp.ini';    //1/12/10
   FileName := ExtractFilePath(Application.EXEName) + 'rmp.ini';
   lIniFile := TIniFile.Create(FileName);

    MyLoginDLG := TMyLoginDlg.create(self);

    if MyLoginDLG.ShowModal = mrOK  then
      begin
       glUserName := MyLoginDLG.UserName;
       glPass     := MyLoginDLG.UserPass;
       glRole     := MyLoginDLG.UserRole;
       MyLoginDLG.free;
      end
     else
      abort;

//      glUserName := 'SYSDBA';
//      glPass     := 'MASTERKEY';
//      glRole     := 'ADMINISTRATOR';





    if lIniFile.ReadInteger('Config', 'CheckBDEConfig',  1) = 0 then
      begin
         ParamList := TStringList.Create;
         lAliases  := TStringList.Create;

         // ищем алиас RMP
         Session.Active := true;
         try
           Session.GetAliasNames(lAliases);

         except
           MessageDlg('Ошибка чтения алиаса', mtWarning, [mbOK], 0);
           abort;
         end;

         DBPath := '';
         for iParam := 0 to lAliases.Count - 1 do
           if (lAliases.Strings[iParam] = 'RMP') or
               (lAliases.Strings[iParam] = 'rmp') then
             begin
               DBPath := lAliases.Strings[iParam];
               break;
             end;

        // ищем алиас RMP
        // Алиас не существует на компьютере
         if (DBPath = '') then
           begin
               ParamList := TStringList.Create;
               try
               with ParamList do
                 begin
                    DBPath := 'SERVER NAME=IB_SERVER:/PATH/DATABASE.GDB';
                    DBPath := lIniFile.ReadString('Config', 'DatabaseName',  DBPath);
                    Add('SERVER NAME='+DBPath);
                    add('LANGDRIVER=ancyrr');
                    Add('USER NAME=' + glUserName);
                    add('ROLE ='+glRole);
                 end;
                 RMPBase.Session.AddAlias('RMP', 'INTRBASE', ParamList);

                 // создание параметров подключения
                 with paramList do
                  begin
                    clear;
                    add('USER NAME=sysdba');
                    add('PASSWORD=masterkey');
                  end;
                 RMPBase.Params := ParamList;
                 RMPBase.Session.SaveConfigFile;
               finally
                 ParamList.Free;
               end;

           end
         // алиас найден
         else

            begin
              RMPBase.Session.GetAliasParams(data.RMPBase.AliasName, ParamList);
              DBPath := ParamList.Values['SERVER NAME'];

              DBPath := lIniFile.ReadString('Config', 'DatabaseName',  DBPath);
              ParamList.Values['SERVER NAME'] := DBPath;
              ParamList.Values['ROLE NAME']   := glRole;

              RMPBase.Session.ModifyAlias(data.RMPBase.AliasName, ParamList);
              RMPBase.Session.SaveConfigFile;

           end;

      end;
//   end;

   IBDataBase.Params.Clear;
   IBDataBase.Params.Add('USER_NAME=' + glUserName);
   IBDataBase.Params.Add('PASSWORD='  + glPass);
   IBDataBase.Params.Add('sql_role_name=' + uppercase(glRole));
   IBDataBase.Params.Add('lc_ctype=WIN1251');
   //
   //   Для регистрации сообщений от интербайса
   //
   try
       IBDataBase.DatabaseName := DBPath;
       IBDataBase.Connected    := true;
   except
     MessageDlg('Невозможно открыть базу '+ RMPBase.DatabaseName +#13+#10+'Программа будет закрыта.', mtError, [mbYes], 0);
     abort;
   end;

   glUserName := uppercase(glUserName);
   glRole     := uppercase(glRole);

   RMPBase.Params.Clear;
   RMPBase.Params.Add('USER NAME=SYSDBA'); // + glUserName);
   RMPBase.Params.Add('PASSWORD=masterkey'); //'  + glPass);
   RMPBase.Params.Add('lc_ctype=WIN1251');

   // открытие базы данных
   try
     RMPBase.Open;
   except
     MessageDlg('Невозможно открыть основную базу '+ RMPBase.DatabaseName +#13+#10+'Программа будет закрыта.', mtError, [mbYes], 0);
     abort;
   end;

   if not RMPBase.Connected then
     begin
        MessageDlg('База не открыта '+ RMPBase.DatabaseName +#13+#10+'Программа будет закрыта.', mtError, [mbYes], 0);
        abort;
     end;



   // заполнение настроек
   with qSysQuery do
     begin
       close;
       sql.clear;
       sql.Add('select * from system where username = :username');
       params[0].asstring := UpperCase(glUserName);
     end;

   // это самый первый запрос к базе. Если есть в нем ошибки,
   // то выходим.
   try
     qSysQuery.Open;
   except
     MessageDlg('Невозможно открыть базу '+ RMPBase.DatabaseName +#13+#10+'Программа будет закрыта.', mtError, [mbYes], 0);
     abort;
   end;


  glCheckOnExit := true;

end;

procedure TDATA.JRRQSTFormQueryAfterScroll(DataSet: TDataSet);
var id: integer;
begin
  ID := JRRQSTFormQuery.FieldByName('ID').asinteger; // ID doc

  if not JRRQSTFormQuery.eof then
    begin
      JRRQSTFormOrderQuery.close;                                    //  установка
      JRRQSTFormOrderQuery.ParamByName('ID_RQST_IN').asinteger := ID;//  нового
      JRRQSTFormOrderQuery.Open;                                     //  фильтра по документам "заказ"
    end
  else
    JRRQSTFormOrderQuery.close;                                    //  установка


end;

procedure TDATA.RMPBaseAfterConnect(Sender: TObject);
begin
  with qLogQuery do
   begin
     sql.Clear;
     sql.add('select isworking from system where username = :user');
     params[0].asstring := uppercase(glUserName);
     try
       open;
     except
       abort;
     end;  
   end;
  if not qLogQuery.Eof then
   if qLogQuery.Fields[0].asinteger > 0 then
    begin
      MessageDlg('Возможно пользователь с таким именем уже работает.', mtWarning, [mbOK], 0);
//      application.Terminate;
    end;

  with qLogQuery do
   begin
     sql.Clear;
     sql.add('update system set isworking = 1, computername = :name where username =  :user');
     params[1].asstring := uppercase(glUserName);
     params[0].asstring := uppercase(glComputerName);
     RMPBase.StartTransaction;
      ExecSQL;
     RMPBase.Commit;

   end;
           

end;

procedure TDATA.RMPBaseBeforeDisconnect(Sender: TObject);
begin
  with qLogQuery do
   begin
     sql.Clear;
     sql.add('update system set isworking = 0, computername = :name');
     sql.add(' where username =  :user');
     params[1].asstring := uppercase(glUserName);
     params[0].asstring := '';

     RMPBase.StartTransaction;
      ExecSQL;
     RMPBase.Commit;

   end;

end;

procedure TDATA.TimerTimer(Sender: TObject);
begin
  messagefrm.free;
  timer.Enabled := false;
end;

procedure TDATA.RMPBaseAfterDisconnect(Sender: TObject);
begin
  MAINForm.Close;
end;

end.
