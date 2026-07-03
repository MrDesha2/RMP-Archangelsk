{
                Модуль CHRTEdit
    Описание: модуль формы редактирования элемента справочника "Чертеж"
    Форма вызывается из формы EnumTreeEdit для редактирования и добавления
    элементов справочника
}
unit CHRTEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Db, ComCtrls, ExtCtrls, DBTables, Mask,
  ToolEdit, RXDBCtrl, EnumTreeForm, EnumForm, ImgList, CHAREdit, OPCHEdit,
  MTCHEdit, ToolWin, DBGridEh, RXSpin, IniFiles, RxRichEd;

type
  TENUM_CHRTForm = class(TForm)
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    Panel1: TPanel;
    CloseButton: TButton;
    OK_Button: TButton;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    SprChrCSource: TDataSource;
    qCHRCQuery: TQuery;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    GroupBox1: TGroupBox;
    OPSource: TDataSource;
    NMNTSource: TDataSource;
    qOpQuery: TQuery;
    qNMNTTableQuery: TQuery;
    Panel8: TPanel;
    Panel9: TPanel;
    GenIDQuery: TQuery;
    qEQPTQuery: TQuery;
    qMDLQuery: TQuery;
    ToolBarCH: TToolBar;
    TooButtonAdd: TToolButton;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    ToolBarOP: TToolBar;
    ToolButtonAddOp: TToolButton;
    ToolButtonEditOp: TToolButton;
    ToolButtonDelOp: TToolButton;
    qNMNTQuery: TQuery;
    ToolButtonUp: TToolButton;
    ToolButtonDown: TToolButton;
    OpGrid: TDBGridEh;
    CHRCGrid: TDBGridEh;
    Save_Button: TButton;
    qCHRCQueryID: TIntegerField;
    qCHRCQueryNAME: TStringField;
    qCHRCQueryNSIZE: TFloatField;
    qCHRCQueryKIND: TStringField;
    SplitterOp: TSplitter;
    OperatePageControl: TPageControl;
    MaterialTabSheet: TTabSheet;
    EQPTTabSheet: TTabSheet;
    NMNTGrid: TDBGridEh;
    ToolBarMtr: TToolBar;
    ToolButtonAddMtr: TToolButton;
    ToolButtonEditMtr: TToolButton;
    ToolButtonDelMtr: TToolButton;
    EQPTGrid: TDBGridEh;
    ToolBar1: TToolBar;
    ToolButtonAddEQPT: TToolButton;
    ToolButtonEditEQPT: TToolButton;
    ToolButtonDelEQPT: TToolButton;
    qEQPTTableQuery: TQuery;
    EQPTDataSource: TDataSource;
    Panel6: TPanel;
    Label1: TLabel;
    Code: TEdit;
    Label2: TLabel;
    _Name: TEdit;
    Label5: TLabel;
    NMNTCombo: TComboEdit;
    NMNTCode: TLabel;
    EQPTCombo: TComboEdit;
    Label3: TLabel;
    Label4: TLabel;
    MDLCombo: TComboEdit;
    Label6: TLabel;
    MtrVid: TComboBox;
    Vid_Chrt: TComboBox;
    Label8: TLabel;
    Label7: TLabel;
    Pr_chrt: TComboBox;
    DateEdit_Reg: TDateEdit;
    Label9: TLabel;
    Panel7: TPanel;
    Splitter2: TSplitter;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    MemoInfo: TMemo;
    GroupBox3: TGroupBox;
    MemoInfoEnter: TMemo;
    procedure Close_ButtomClick(Sender: TObject);
    procedure save;
    procedure OK_ButtomClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qOpQueryAfterScroll(DataSet: TDataSet);
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure MDLComboButtonClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure ButtonAddOpClick(Sender: TObject);
    procedure ButtonDelOpClick(Sender: TObject);
    procedure ButtonEditOpClick(Sender: TObject);
    procedure ButtonAddMtrClick(Sender: TObject);
    procedure ButtonDelMtrClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MDLComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CHRCGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OPGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NMNTGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonUpClick(Sender: TObject);
    procedure ToolButtonDownClick(Sender: TObject);
    procedure Save_ButtonClick(Sender: TObject);
    procedure SetNextFocus(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonAddEQPTClick(Sender: TObject);
    procedure ToolButtonEditEQPTClick(Sender: TObject);
    procedure ToolButtonDelEQPTClick(Sender: TObject);
    procedure EQPTGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_CHRTForm: TENUM_CHRTForm;
  EditType : integer;    // тип редактирования: 1 - добавление одного, 2 - добавление группы, 3 - редактирование
  IsFolder : integer;    // Признак группы
  ParentID : integer;    // Родительский элемент
  ID       : integer;    // Идентификатор
  RefreshFrm  : integer; // Флаг необходимости перерисовки окна
  newrecord : boolean;   // признак новой записи
  tNewText, tNewGroupText, tUpdateText : string;


implementation

uses Main, Base,
   EnumForm4Sel, EQCHEdit,
   Libs;

{$R *.DFM}
//
//  Процедура закрытия формы
//
procedure TENUM_CHRTForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

{
     Процедура принятия изменений

}
procedure TENUM_CHRTForm.save;
var Ini:TIniFile;
    FileName : String;
begin

  if EditType = 0 then // это добавление записи
      qQueryupdate.ParamByName('ParentID').asinteger := ParentID
  else
      qQueryupdate.ParamByName('ID').asinteger       := ID;



  if trim(code.text) = '' then
    begin
      showmessage('Код не указан!');
      abort;

    end;

    if (ChechUniqueCode('spr_chrt', 'code', trim(Code.text), ID) > 0) then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;

    if trim(_name.text) = '' then
      begin
        showmessage('Наименование не указано!');
        abort;

      end;

  // заполнение параметра Номенклатура
  SetParamCombo(qQueryupdate.ParamByName('id_NMNT'), NMNTCombo);


  // заполнение параметра Оборудование
  SetParamCombo(qQueryupdate.ParamByName('id_OBRD'), EQPTCombo);

  // поле модели.
  SetParamCombo(qQueryupdate.ParamByName('id_MDL'), MDLCombo);

  // поле "Вид материала"
  qQueryupdate.ParamByName('id_mtrk').value := MTRVid.ItemIndex;

  // поле "Вид чертежа"
  qQueryupdate.ParamByName('vid_chrt').value := vid_chrt.ItemIndex;

  // поле "Дата регистрации"
  qQueryupdate.ParamByName('date_reg').AsDate := DateEdit_Reg.Date;

  // поле "Дата регистрации"
  qQueryupdate.ParamByName('info').DataType := ftBlob;
  If Length(MemoInfoEnter.Lines.Text) > 0 Then
  begin
      qQueryupdate.ParamByName('info').Value := MemoInfo.Lines.Text+DateTimeToStr(Now)+'   '+MemoInfoEnter.Lines.Text+#13#10;
      MemoInfo.Lines.Text := MemoInfo.Lines.Text+DateTimeToStr(Now)+'   '+MemoInfoEnter.Lines.Text+#13#10;
      MemoInfoEnter.Lines.Text := '';
  end
   else  qQueryupdate.ParamByName('info').Value := MemoInfo.Lines.Text;

  // поля код и наименование
  qQueryupdate.ParamByName('Code').value    := Code.text;
  qQueryupdate.ParamByName('Name').value    := _Name.Text;

  qQueryupdate.ParamByName('Is_int').asinteger := Pr_chrt.ItemIndex;
   try
    data.RMPBase.StartTransaction;
    qQueryupdate.ExecSQL;
    data.RMPBase.commit;
   except
    data.RMPBase.Rollback;
   end;

  // поиск ID вновь введенной записи
  if ID = -1 then
    begin

       ID := findIDbyCode('spr_chrt', trim(code.text));
       MainForm.ID := ID;

       EditType := 1;
       qQueryupdate.sql.clear;
       qQueryupdate.sql.add(tUpdateText);

    end;

  qQuery.close;

{  if not DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp') then
     if not CreateDir(GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp') then
       raise Exception.Create('Немогу сохранить временные данные по чертежу в '+GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp');}

  if not DirectoryExists('c:\RmpTemp') then
     if not CreateDir('C:\RmpTemp') then
       raise Exception.Create('Немогу сохранить временные данные по чертежу в c:\RmpTemp');

//  if DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp') then
  if DirectoryExists('c:\RmpTemp') then
  begin
      FileName := {ExtractFilePath(Application.EXEName) +} 'c:\RmpTemp\rmp.ini'; //1/12/10
//      FileName := GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp\rmp.ini';

      //Процедура записи кода последнего сохраненного элемента в rmp.ini
      Ini:=TIniFile.Create(FileName);

      //Следующий оператор заносит в ключ CodeChrt раздела Sprav значение 'Code.text':
      Ini.WriteString('SpravChrt','CodeChrt', Code.text);

      //Следующие операторы сохраняют содержимое объекта Ini в файле на диске и разрушают объект Ini:
      Ini.UpdateFile;
      Ini.Free;
  end;    
end;

//
// Процедура выполнения транзакции при записи
// по нажатию кнопки "ОК"
procedure TENUM_CHRTForm.OK_ButtomClick(Sender: TObject);
begin
     save;
     ModalResult := mrOK;
end;
{

  Процедура записи
}
procedure TENUM_CHRTForm.Save_ButtonClick(Sender: TObject);
begin
  save;
end;

procedure TENUM_CHRTForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
end;
//
//  Процедура при откркытии окна
//  Описание: выполняет заполнение элеметов формы

procedure TENUM_CHRTForm.FormShow(Sender: TObject);

var prefix_name : string;  // префикс наименования чертежа
    Ini:TIniFile;
    FileName : String;

begin


  ParentID     := MainForm.ParentID;   // ID элемента выводится через глобальную переменную
  refreshFrm  := 0;                   // необходимость перерисовки окна

  ID           := -1;   // это при новом элементе

  tNewText     := 'insert into spr_chrt values (GEN_ID(SPR_chrt_GEN,1), :parentID, 0, :name,:ID_OBRD, :ID_MDL, :Is_int, :code, :id_nmnt, :id_mtrk, :vid_chrt, null, :date_reg, :info)';
  tNewGroupText:= 'insert into spr_chrt values (GEN_ID(SPR_chrt_GEN,1), :parentID, 1, :name,:ID_OBRD, :ID_MDL, :Is_int, :code, :id_nmnt, :id_mtrk, :vid_chrt, null, :date_reg, :info)';
  tUpdateText  := 'update spr_chrt set code = :code, name = :name , id_obrd = :id_obrd, id_mdl = :id_mdl, is_int = :Is_int, ' +
       'id_nmnt = :id_nmnt, id_mtrk = :id_mtrk, ' +
       'vid_chrt = :vid_chrt, date_reg = :date_reg, info = :info ' +
       'where ID =  :ID';


  // Формирование запроса для нахождения наименования родительского элемента
  prefix_name := '';
  if MainForm.ParentID <> 0 then
    begin

     qQuery.SQL.Clear;
     qQuery.SQL.Add('select name from spr_chrt');
     qQuery.SQL.Add('where id = ' + inttostr(ParentID));
     qQuery.open;

     if not qQuery.eof then
       prefix_name := copy(qQuery.Fields[0].asstring,0, 3) + '.';

    end;


  if MainForm.IsFolder = 1 then {Добавление элемента}

    begin

       //Данное условие просили доделать в Литейке
       if DirectoryExists('c:\RmpTemp') then
//       if DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp') then
       begin
             //Сохраняю некоторые данные по чертежу для каждого пользователя
//             FileName := GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp\rmp.ini';    //1/12/10
             FileName := {ExtractFilePath(Application.EXEName) + } 'C:\RmpTemp\rmp.ini';
             //Процедура записи кода последнего сохраненного элемента в rmp.ini
             Ini:=TIniFile.Create(FileName);

             //Следующий оператор заносит в ключ CodeChrt раздела Sprav значение 'Code.text':
             Code.text:=Ini.ReadString('SpravChrt','CodeChrt', '');

             //Следующие операторы сохраняют содержимое объекта Ini в файле на диске и разрушают объект Ini:
             Ini.UpdateFile;
             Ini.Free;
       end;

//       Code.Text   := '';
       _Name.text  := prefix_name + ''; //Новый элемент';
       Caption     := 'Справочник "Чертеж". Новый элемент';
       DateEdit_Reg.Date := Date;
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add(tNewText);

       MtrVid.ItemIndex   := 0;
       Vid_chrt.ItemIndex := 0;
       Pr_chrt.ItemIndex  := 0;
       EditType := 0;

       newrecord := true;

       // Заполнение запросов по нахождению значений реквизитов
       // "Номенклатура" и "Оборудование"
       NMNTCombo.ID := -1;
       EQPTCombo.ID := -1;
       MDLCombo.ID  := -1;

    end

  else

   if mainForm.isFolder = 2 then {Добавление новой группы}

     begin
       Code.Text   := '';
       _Name.text  := prefix_name + 'Новая группа';
       Caption     := 'Справочник "Чертеж". Новая группа';
       DateEdit_Reg.Date := Date;
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add(tNewGroupText);

       MtrVid.ItemIndex   := 0;
       Vid_chrt.ItemIndex := 0;

       EditType := 0;
       newrecord := true;

       // Заполнение запросов по нахождению значений реквизитов
       // "Номенклатура" и "Оборудование"
       NMNTCombo.ID := -1;
       EQPTCombo.ID := -1;
       MDLCombo.ID  := -1;

     end

   else {редактирование элемента}

    if mainForm.isFolder = 3 then

     begin
       // проверка на разрешение редактирования
       Save_Button.Enabled := check_user_grand('SPR_CHRT', 'U', true);

       newrecord := false;

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_chrt');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;

       // заполнение информации по полям
       code.Text   := qQuery.fieldByName('Code').AsString;
       _name.text  := qQuery.fieldByName('Name').AsString;
       ParentID    := qQuery.fieldByName('ParentID').AsInteger;
       Id          := qQuery.fieldByName('ID').AsInteger;
       DateEdit_Reg.Date := qQuery.fieldByName('DATE_REG').AsDateTime;
       MemoInfo.Lines.Text := qQuery.fieldByName('INFO').AsString;

       // формирование запроса для записи элемента
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add(tUpdateText);

       // заполнение поля "Номенклатура"
       NMNTCombo.ID := qQuery.fieldByName('ID_NMNT').AsInteger;
       NMNTCode.Caption := 'Код: ' + qNMNTQuery.FieldByName('Code').asstring;

       // заполнение поля "Оборудование"
       EQPTCombo.ID := qQuery.fieldByName('ID_OBRD').AsInteger;

       // заполнение поля "Модель"
       MDLCombo.ID := qQuery.fieldByName('ID_MDL').asinteger;

       // Признак чертежа
       Pr_chrt.ItemIndex := qQuery.fieldByName('Is_Int').AsInteger;

       EditType := 1; // тип редактирования - редактирование

       // поле "Вид материала"
       MtrVid.ItemIndex := qQuery.fieldByName('ID_MTRK').AsInteger;

       // поле "Вид черчежа"
       Vid_Chrt.ItemIndex := qQuery.fieldByName('Vid_chrt').AsInteger;


       // заполнение таблицы характеристик
       qCHRCQuery.close;
       qCHRCQuery.ParamByName('ID').asinteger := id;
       qCHRCQuery.open;


        // заполнение таблицы операций
       qOpQuery.close;
       qOpQuery.ParamByName('ID').asinteger := id;
       qOpQuery.open;

       // заполнение таблицы материалов
       qNMNTTableQuery.close;
       qNMNTTableQuery.ParamByName('ID').asinteger := qOpQuery.FieldByName('ID').asinteger;
       qNMNTTableQuery.open;

       // заполнение таблицы инструмента
       qEQPTTableQuery.close;
       qEQPTTableQuery.ParamByName('ID').asinteger := qOpQuery.FieldByName('ID').asinteger;
       qEQPTTableQuery.open;


       Caption := 'Справочник "Чертеж". Элемент: ' + _name.text;
     end;


   PageControl.ActivePageIndex := 0;
   OperatePageControl.ActivePageIndex := 0;
   Code.SetFocus;


end;

// Процедура изменения запроса по материалам в момент
// изменения операции
//
procedure TENUM_CHRTForm.qOpQueryAfterScroll(DataSet: TDataSet);
var id: integer;
begin
  ID := qOpQuery.FieldByName('ID').asinteger;
  qNMNTTableQuery.close;
  qNMNTTableQuery.ParamByName('ID').asinteger := ID;
  qNMNTTableQuery.Open;

  qEQPTTableQuery.Close;
  qEQPTTableQuery.ParamByName('ID').asinteger := ID;
  qEQPTTableQuery.Open;

end;
{
     Процедура выбора значения номенклатуры
}
procedure TENUM_CHRTForm.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(NMNTCombo);

       NMNTCode.Caption := 'Код: ' + qNMNTQuery.FieldByName('Code').asstring;
end;
{
    При редактировании поля Номенклатура нажали клавишу
}
procedure TENUM_CHRTForm.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( NMNTCombo, key, Shift) = false then
     NMNTComboButtonClick(Sender);

  NMNTCode.Caption := 'Код: ' + qNMNTQuery.FieldByName('Code').asstring;
  SetNextFocus(sender, key, shift);

end;

//
//  Процедура
//   Выбор значения поля EQPT из спрачника
procedure TENUM_CHRTForm.EQPTComboButtonClick(Sender: TObject);
begin
  SelectFromTable( EQPTCombo);

end;

//
//  Процедура
//   Выбор значения поля Модель из спрачника
procedure TENUM_CHRTForm.MDLComboButtonClick(Sender: TObject);
begin
  SelectFromTable(MDLCombo);

end;
{
   При редактировании поля "Вид характеристики" нажали кнопку клавы
}
procedure TENUM_CHRTForm.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EQPTCombo, key, Shift) = false then
     EQPTComboButtonClick(Sender);
  SetNextFocus(sender, key, shift);

end;
{
   При редактировании поля "Модели" нажали кнопку клавы
}
procedure TENUM_CHRTForm.MDLComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( MDLCombo, key, Shift) = false then
     MDLComboButtonClick(Sender);

  SetNextFocus(sender, key, shift);


end;



// ***********************************************************************





//
//  Процедура добавления характеристики чертежа
//
procedure TENUM_CHRTForm.ButtonAddClick(Sender: TObject);
var EditCHAR: tform;
begin
  // Добавление характеристик возможно только для существующих элементов
  if  ID < 0 then
    begin
      showmessage('Элемент не записан.');
      exit
    end;

  // характеристики можно добавлять только после записи элемента
  EditCHAR := TENUM_CHEQForm.CreateN(Application, 0, ID, 'spr_chrc', 'spr_chrc_gen', 1, 1);
  EditChar.caption := 'Добавление характеристики чертежа';



  if EditChar.showmodal = mrOK then
   if not newrecord then

     refreshquery( qCHRCQuery )
   else

     begin
       qCHRCQuery.ParamByName('ID').asinteger := ID;
       qCHRCQuery.Open;
     end;

    refreshquery( qCHRCQuery );
    
   EditChar.Release;
end;
//
//  Процедура редактирования характеристики чертежа
//
procedure TENUM_CHRTForm.ButtonEditClick(Sender: TObject);
var EditCHAR: tform;
    _id : integer;
begin

  // Если есть что редактировать
  if  qCHRCQuery.Eof then exit;
  // Нахождение ID элемента
  _id := qCHRCQuery.FieldByName('ID').asinteger;
  EditCHAR := TENUM_CHEQForm.CreateN(Application, _Id, ID, 'spr_chrc', 'spr_chrc_gen', 2, 1);
  EditChar.caption := 'Редактирование характеристики чертежа';
  if EditChar.showmodal = mrOK then
     refreshquery( qCHRCQuery);
  EditChar.Release;
end;
//
//   Процедура удаления характеристики чертежа
//
procedure TENUM_CHRTForm.ButtonDelClick(Sender: TObject);

begin
  // если есть что удалять
  if  qCHRCQuery.Eof then exit;
  // Формирование запроса для удаления элемента

  if messagedlg('Удалить запись ' + qCHRCQuery.FieldByName('Name').asstring + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with data.qDELQuery do
     begin

      close;
      sql.clear;
      sql.add('delete from spr_chrc where id = ' + qCHRCQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
        ExecSQL;
      data.RMPBase.Commit;

     end;

  // Обновление формы
  refreshquery(qCHRCQuery);
end;

//
//  Процедура добавление операции
//
procedure TENUM_CHRTForm.ButtonAddOpClick(Sender: TObject);
var EditVOP: tform;
begin
  // Добавление операций возможно только для существующих элементов
  if ID < 0 then
    begin
      showmessage('Элемент не записан.');
      exit
    end;

  // Открытие формы для редактирования свойств элемента
  EditVOP := TENUM_OPCHForm.CreateN(Application, 0, ID, 'spr_opch', 'spr_opch_gen', 1);
  EditVOP.caption := 'Добавление плановой операции чертежа';
  if EditVOP.showmodal = mrOK then
    if not newrecord then
     refreshquery( qOPQuery)

    else

     begin
       qOPQuery.ParamByName('id').asinteger := iD;
       qOPQuery.open;
       
     end;

      refreshquery( qOPQuery);

end;
//
//  Процедура удаления операции
//
procedure TENUM_CHRTForm.ButtonDelOpClick(Sender: TObject);

begin
  if qOPQuery.eof then exit;
  // Нахождение ID элемента
  if messagedlg('Удалить запись ' + qOpQuery.FieldByName('Name').asstring + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with data.qDELQuery do
     begin

      close;
      sql.clear;
      sql.add('delete from spr_opch where id = ' + qOpQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
      ExecSQL;
      data.RMPBase.Commit;


     end;

  // обновление таблицы
  refreshquery(qOpQuery);
end;
//
//  Процедура редактирования операции
//
procedure TENUM_CHRTForm.ButtonEditOpClick(Sender: TObject);
var EditVOP: tform;
    _id : integer;
begin
  // если есть что редактировать
  if  qOPQuery.Eof then exit;
  // Нахождение ID элемента
  _id := qOPQuery.FieldByName('ID').asinteger;
  // Открытие формы редактирование свойств элемента справочника
  EditVOP := TENUM_OPCHForm.CreateN(Application, _Id, ID, 'spr_opch', 'spr_opch_gen', 2);
  EditVOP.caption := 'Редактирование плановой операции чертежа';
  if EditVOP.showmodal = mrOK then
     refreshquery( qOPQuery);
end;
//
//  Процедура добавления материала
//
procedure TENUM_CHRTForm.ButtonAddMtrClick(Sender: TObject);
var EditNMNT: tform;
    _idOwner: integer;
begin
  // Материал можно добавлять только если записан элемент чертежа и
  // элемент операций
  if (ID < 0) or (qOPQuery.eof) then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;

  _idOwner := qOpQuery.FieldByName('ID').asinteger;
  // Открытие формы редактирования свойств материала
  EditNMNT := TENUM_MTCHForm.CreateN(Application, 0, _idOwner, 'spr_mtch', 'spr_mtch_gen', 1);
  EditNMNT.caption := 'Добавление планового материала чертежа';

  if EditNMNT.showmodal = mrOK then
     refreshquery( qNMNTTableQuery);


end;
//
//  Процедура удаления материала
//
procedure TENUM_CHRTForm.ButtonDelMtrClick(Sender: TObject);

begin
  if qNMNTTableQuery.eof then
    exit;


  // Нахождение ID элемента
  if messagedlg('Удалить запись ' + qNMNTTableQuery.FieldByName('Name').asstring + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with data.qDELQuery do
     begin
      close;
      sql.clear;
      sql.add('delete from spr_mtch where id = ' + qNMNTTableQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
      ExecSQL;
      data.RMPBase.Commit;

     end;

  // обновление таблицы
  refreshquery( qNMNTTableQuery);
end;
//
//  Процедура редактирования материала
//
procedure TENUM_CHRTForm.Button6Click(Sender: TObject);
var EditNMNT: tform;
    _idOwner, _id : integer;
begin
  // Если есть что редактировать
  if qNMNTTableQuery.eof then
     exit;
  // Нахождение ID элемента
  _id      := qNMNTTableQuery.FieldByName('ID').asinteger;
  _idOwner := qOpQuery.FieldByName('ID').asinteger;
  // Открытие формы редактирования свойств справочника
  EditNMNT := TENUM_MTCHForm.CreateN(Application, _Id, _IDOwner, 'spr_mtch', 'spr_mtch_gen', 2);
  EditNMNT.caption := 'Редактирование планового материала чертежа';
  if EditNMNT.showmodal = mrOK then
     refreshquery( qNMNTTableQuery);
end;
{
   Процедура при нажатии на любую кнопку в таблице
}
procedure TENUM_CHRTForm.CHRCGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelClick(Sender);   // удаление записи
    45 :  ButtonAddClick(Sender); // Добавление по Ins
    13 :  ButtonEditClick(Sender);  // Редактирование по Enter
    116: begin // обновление по F5
           qCHRCQuery.close;
           qCHRCQuery.open;
         end;

  end;
end;
{
    Процедура при нажатии на любую кнопку в таблице операций
}
procedure TENUM_CHRTForm.OPGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelOpClick(Sender);   // удаление записи
    45 :  ButtonAddOpClick(Sender);   // Добавление по Ins
    13 :  ButtonEditOpClick(Sender);  // Редактирование по Enter
    116: begin // обновление по F5
           qOpQuery.close;
           qOpQuery.open;
         end;
  end;
end;


{

   Процедура при нажатии на любую кнопку в таблице материалов чертежа
}
procedure TENUM_CHRTForm.NMNTGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelMtrClick(Sender);   // удаление записи
    45 :  ButtonAddMtrClick(Sender);   // Добавление по Ins
    13 :  Button6Click(Sender);  // Редактирование по Enter
    116: begin // обновление по F5
           qNMNTTableQuery.close;
           qNMNTTableQuery.open;
         end;
  end;
end;


procedure move_operation(query : tQuery; movement : integer);
var id_rec : integer;
    num_rec: integer;
    num_rec_1 : integer;
    id_rec_1  : integer;
    qSortQuery: tQuery;
begin

  id_rec  :=  query.FieldByName('id').asinteger;
  num_rec :=  query.FieldByName('number').asinteger;

  // вверх на одну
  if movement = 1 then
    begin
      Query.Prior;
      if query.Bof then exit;
    end

  else
    begin
      Query.next;
      if query.Eof then exit;
    end;


  num_rec_1 := query.FieldByName('number').asinteger;
  id_rec_1  := query.FieldByName('ID').asinteger;

  qSortQuery := tQuery.create(application);
  qSortQuery.databasename := 'RMP';

  qSortQuery.SQL.Clear;
  qSortQuery.SQL.add('update spr_opch set number = ' + inttostr(num_rec));
  qSortQuery.SQL.add('where id =' + inttostr(id_rec_1));
    data.RMPBase.StartTransaction;
    qSortQuery.execsql;
    data.RMPBase.Commit;

  qSortQuery.SQL.Clear;
  qSortQuery.SQL.add('update spr_opch set number = ' + inttostr(num_rec_1));
  qSortQuery.SQL.add('where id =' + inttostr(id_rec));
    data.RMPBase.StartTransaction;
     qSortQuery.execsql;
    data.RMPBase.Commit;


  if movement = 1 then
    Query.next

  else

    Query.Prior;



end;


{
   Изменение порядка строк вверх

}

procedure TENUM_CHRTForm.ToolButtonUpClick(Sender: TObject);
begin

  if qOpQuery.Bof then exit;

    move_operation(qOpQuery, 1);

  refreshquery(qOpQuery);

end;

{
   Изменение порядка строк вниз

}
procedure TENUM_CHRTForm.ToolButtonDownClick(Sender: TObject);
begin
  if qOpQuery.eof then exit;

    move_operation(qOpQuery, 2);

  refreshquery(qOpQuery);

end;


procedure TENUM_CHRTForm.SetNextFocus(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
     selectNext(tWinControl(sender), true, true);
end;

procedure TENUM_CHRTForm.ToolButtonAddEQPTClick(Sender: TObject);
var EditEQPT: tform;
    _idOwner: integer;
begin
  // Материал можно добавлять только если записан элемент чертежа и
  // элемент операций
  if (ID < 0) or (qOPQuery.eof) then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;

  _idOwner := qOpQuery.FieldByName('ID').asinteger;
  // Открытие формы редактирования свойств материала
  EditEQPT := TENUM_EQCHForm.CreateN(Application, 0, _idOwner, 'spr_eqptchrt', 'GEN_SPR_EQPTCHRT_ID', 1);
  EditEQPT.caption := 'Добавление планового инструмента чертежа';

  if EditEQPT.showmodal = mrOK then
     refreshquery( qEQPTTableQuery);

end;

procedure TENUM_CHRTForm.ToolButtonEditEQPTClick(Sender: TObject);

var EditEQPT: tform;
    _idOwner, _id : integer;
begin
  // Если есть что редактировать
  if qEQPTTableQuery.eof then
     exit;

  // Нахождение ID элемента
  _id      := qEQPTTableQuery.FieldByName('ID').asinteger;
  _idOwner := qOpQuery.FieldByName('ID').asinteger;
  // Открытие формы редактирования свойств справочника
  EditEQPT := TENUM_EQCHForm.CreateN(Application, _Id, _IDOwner, 'spr_eqptchrt', 'GEN_SPR_EQPTCHRT_ID', 2);
  EditEQPT.caption := 'Редактирование планового инструмента чертежа';
  if EditEQPT.showmodal = mrOK then
     refreshquery( qEQPTTableQuery);

end;

procedure TENUM_CHRTForm.ToolButtonDelEQPTClick(Sender: TObject);
begin
  if qEQPTTableQuery.eof then
    exit;


  // Нахождение ID элемента
  if messagedlg('Удалить запись ' + qEQPTTableQuery.FieldByName('Name').asstring + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with data.qDELQuery do
     begin
      close;
      sql.clear;
      sql.add('delete from spr_eqptchrt where id = ' + qEQPTTableQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
      ExecSQL;
      data.RMPBase.Commit;

     end;

  // обновление таблицы
  refreshquery( qEQPTTableQuery);

end;

procedure TENUM_CHRTForm.EQPTGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelEQPTClick(Sender);   // удаление записи
    45 :  ToolButtonAddEQPTClick(Sender);   // Добавление по Ins
    13 :  ToolButtonEditEQPTClick(Sender);  // Редактирование по Enter
    116: begin // обновление по F5
           qEQPTTableQuery.close;
           qEQPTTableQuery.open;
         end;
  end;

end;

end.


