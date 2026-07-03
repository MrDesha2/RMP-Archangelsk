{

                         Модуль  WRKREdit
  Описание:
      Модуль формы редактирования элемента справочника "Работники".
      Модуль вызывается из модуля EnumForm.

}

unit WRKREdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXDBCtrl, RXSpin, Mask, ToolEdit, Db, DBTables, EnumTreeForm, EnumForm,
  CurrEdit, Grids, DBGridEh, ComCtrls, ToolWin, ExtCtrls,
  EnumWorkerSertif;

type
  TENUM_WRKRForm = class(TForm)
    PageControl: TPageControl;
    SheetMain: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Code: TEdit;
    _Name: TEdit;
    Date_In: TDateEdit;
    Raiting: TRxSpinEdit;
    Sex: TComboBox;
    Date_BIR: TDateEdit;
    Payment: TComboBox;
    PROFCombo: TComboEdit;
    PostCombo: TComboEdit;
    PDRCombo: TComboEdit;
    EQPTCombo: TComboEdit;
    BOSSCombo: TComboEdit;
    Salary: TCurrencyEdit;
    qQuery: TQuery;
    qPROFQuery: TQuery;
    qPOSTQuery: TQuery;
    qPDRQuery: TQuery;
    qEQPTQuery: TQuery;
    qBOSSQuery: TQuery;
    PanelBot: TPanel;
    Close_Buttom: TButton;
    OKButton: TButton;
    SheetVOP: TTabSheet;
    SheetEQPT: TTabSheet;
    PanelBotVP: TPanel;
    ToolBarCH: TToolBar;
    ButtonAddVOP: TToolButton;
    ButtonEditVOP: TToolButton;
    ButtonDelVOP: TToolButton;
    PanelBotEQ: TPanel;
    ToolBar1: TToolBar;
    ButtonAddEQPT: TToolButton;
    ButtonEditEQPT: TToolButton;
    ButtonDelEqpt: TToolButton;
    PanelVOP: TPanel;
    VOPGrid: TDBGridEh;
    PanelEQ: TPanel;
    EQPTGrid: TDBGridEh;
    qVOPQuery: TQuery;
    qEQQuery: TQuery;
    DataSourceOp: TDataSource;
    DataSourceEQ: TDataSource;
    qVOPStoredProc: TStoredProc;
    qEQPTStoredProc: TStoredProc;
    Label16: TLabel;
    Address: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    Label19: TLabel;
    Panel2: TPanel;
    SertificateGrid: TDBGridEh;
    Panel3: TPanel;
    ToolBar2: TToolBar;
    ButtonAddAtt: TToolButton;
    ButtonEditAtt: TToolButton;
    ButtonDelAdd: TToolButton;
    DataSourceSertificate: TDataSource;
    qSertificateQuery: TQuery;
    Phone_1: TMaskEdit;
    Phone_2: TMaskEdit;
    Panel4: TPanel;
    GroupBox1: TGroupBox;
    INFO: TMemo;
    UpdateStoredProc: TStoredProc;
    qUpdateVOPQuery: TQuery;
    qSelectVOPQuery: TQuery;
    VOPCombo: TComboEdit;
    ComboEdit1: TComboEdit;
    qSelectEQPTQuery: TQuery;
    qUpdateEQPTQuery: TQuery;
    DismissDateEdit: TDateEdit;
    Label14: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PROFComboButtonClick(Sender: TObject);
    procedure PostComboButtonClick(Sender: TObject);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure BOSSComboButtonClick(Sender: TObject);
    procedure PROFComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PostComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BOSSComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonAddVOPClick(Sender: TObject);
    procedure ButtonEditVOPClick(Sender: TObject);
    procedure ButtonDelVOPClick(Sender: TObject);
    procedure VOPGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonAddEQPTClick(Sender: TObject);
    procedure ButtonEditEQPTClick(Sender: TObject);
    procedure ButtonDelEqptClick(Sender: TObject);
    procedure EQPTGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonAddAttClick(Sender: TObject);
    procedure ButtonEditAttClick(Sender: TObject);
    procedure ButtonDelAddClick(Sender: TObject);
    procedure SertificateGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_WRKRForm: TENUM_WRKRForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;
  newrecord: boolean;    // признак новой записи
  EnumEdit : TForm;      // Форма списка справочника
  EnumTreeEdit: TLIST_TREEEDITForm; // Форма древовидного справочника

implementation

uses Main,
     Base,
     Libs,

EnumForm4Sel;

{$R *.DFM}

//
//  Процедура при активации формы
//
procedure TENUM_WRKRForm.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin

  PageControl.ActivePageIndex := 0;
  
  ParentID := MainForm.ParentID;

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin
        newrecord := true;

        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_wrkr');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);


       _Name.text := 'Новый элемент';
       Caption     := 'Новая элемент';

       UpdateStoredProc.ParamByName('IsFolder').asinteger := 0;
       EditType := 0;
       Salary.text := '0';


       // заполнение поля "Профессия"
       PROFCombo.ID := -1;

       // заполнение поля "Должность"
       POSTCombo.ID := -1;

       // заполнение поля "Подразделение"
       PDRCombo.ID  := -1;

       // заполнение поля "Станок"
       EQPTCombo.ID := -1;

       // заполнение поля "Бригадир"
       BOSSCombo.ID := -1;

       ID := -1;

    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin
        newrecord := true;

        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_wrkr');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);


       _Name.text  := 'Новая группа';
       Caption     := 'Справочник "Работники": Новая группа';

       UpdateStoredProc.ParamByName('IsFolder').asinteger := 1;
       EditType := 0;

       // заполнение поля "Профессия"
       PROFCombo.ID := -1;

       // заполнение поля "Должность"
       POSTCombo.ID := -1;

       // заполнение поля "Подразделение"
       PDRCombo.ID  := -1;

       // заполнение поля "Станок"
       EQPTCombo.ID := -1;

       // заполнение поля "Бригадир"
       BOSSCombo.ID := -1;

     end
   else {редактирование элемента}
    if mainForm.isFolder = 3 then
     begin
        newrecord := false;

        // проверка на разрешение редактирования
        OkButton.Enabled := check_user_grand('SPR_WRKR', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_wrkr');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       code.Text   := qQuery.fieldByName('Code').AsString;
       _name.text  := qQuery.fieldByName('Name').AsString;


       DATE_In.text  := qQuery.fieldByName('DATE_INT').AsString;
       Date_BIR.text := qQuery.fieldByName('DATE_BIR').AsString;
       SALARY.text   := qQuery.fieldByName('SALARY').AsString;
       Raiting.text  := qQuery.fieldByName('Rating').AsString;
       payment.ItemIndex := qQuery.fieldByName('PAY').AsInteger;
       sex.ItemIndex     := qQuery.fieldByName('SEX').AsInteger - 1;

       Id          := qQuery.fieldByName('ID').AsInteger;
       EditType := 1;   //режим редактирования - редактирование

       // заполнение поля "Профессия"
       PROFCombo.ID := qQuery.fieldByName('ID_PROF').AsInteger;
       POSTCombo.ID := qQuery.fieldByName('ID_post').AsInteger;
       PDRCombo.ID  := qQuery.fieldByName('ID_PDR').AsInteger;
       EQPTCombo.ID := qQuery.fieldByName('ID_EQPT').AsInteger;
       BOSSCombo.ID := qQuery.fieldByName('BRIGADE').AsInteger;
       Address.Text := qQuery.fieldByName('Address').AsString;
       phone_1.Text := qQuery.fieldByName('phone_1').AsString;
       phone_2.Text := qQuery.fieldByName('phone_2').AsString;
       info.Lines.Text := qQuery.fieldByName('info').value;
       DismissDateEdit.text := qQuery.fieldByName('DISMISS').AsString;

       Caption := 'Элемент: ' + _name.text;
     end;

     // открытие запроса по операциям работника
     qVOpQuery.ParamByName('ID').AsInteger := ID;
     qVOpQuery.Open;

     // открытие запроса по оборудованию работника
     qEQQuery.ParamByName('ID').AsInteger := ID;
     qEQQuery.Open;

     // открытие запроса по аттестации
     qSertificateQuery.ParamByName('ID_WRKR').asinteger := ID;
     qSertificateQuery.Open;


end;
//
// Процедура нажатия кнопки "Закрыть"
//
procedure TENUM_WRKRForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
//
//  Процедура нажатия кнопки "ОК"
//
procedure TENUM_WRKRForm.OKButtonClick(Sender: TObject);
begin
  if EditType = 0 then // это добавление записи
     UpdateStoredProc.ParamByName('ParentID').asinteger := ParentID
  else
      UpdateStoredProc.ParamByName('ID').asinteger      := ID;


    if (ChechUniqueCode('spr_wrkr', 'code', trim(Code.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;


  // заполнение полей таблицы из запросов
  SetParamCombo(UpdateStoredProc.ParamByName('id_eqpt'), EQPTCombo);

  // заполнение свойства профессия
  if (ProfCombo.ID > 0) then
    SetParamCombo(UpdateStoredProc.ParamByName('id_prof'), PROFCombo)
  else
    begin
      showmessage('Не выбрано поле "Профессия".');
      exit;
    end;

  // заполнение свойства подразделение
  if (PDRCombo.ID > 0) then
    SetParamCombo(UpdateStoredProc.ParamByName('id_PDR'), PDRCombo)
  else
    begin
      showmessage('Не выбрано поле "Подразделение".');
      exit;
    end;

  // заполнение свойства должность
  SetParamCombo(UpdateStoredProc.ParamByName('id_post'), POSTCombo);

  // заполнение свойства Бригада
  SetParamCombo(UpdateStoredProc.ParamByName('brigade'), BOSSCombo);

  if Code.text = '' then
    begin
      showmessage('Код не заполнен.');
      exit;
    end;
  if _Name.Text = '' then
    begin
      showmessage('ФИО не заполнено.');
      exit;
    end;


  UpdateStoredProc.ParamByName('Code').value    := Code.text;
  UpdateStoredProc.ParamByName('Name').value    := _Name.Text;

  // заполнение полей дата
  if date_in.Text <> '  .  .    ' then
    UpdateStoredProc.ParamByName('date_int').value:= date_in.Text
  else
    UpdateStoredProc.ParamByName('date_int').clear;

  if DATE_Bir.Text <> '  .  .    ' then
    UpdateStoredProc.ParamByName('date_bir').value:= DATE_Bir.Text
  else
    UpdateStoredProc.ParamByName('date_bir').clear;

  // заполнение поля "Пол"
  if Sex.ItemIndex + 1 > 0 then
    UpdateStoredProc.ParamByName('sex').asinteger := Sex.ItemIndex + 1
  else
    UpdateStoredProc.ParamByName('sex').asinteger := 1;

  UpdateStoredProc.ParamByName('rating').asinteger  := strtoint(trim(raiting.Text));
  UpdateStoredProc.ParamByName('salary').value      := salary.value;
  UpdateStoredProc.ParamByName('pay').asinteger     := payment.itemIndex;
  UpdateStoredProc.ParamByName('ADDRESS').asstring  := address.Text;
  UpdateStoredProc.ParamByName('PHONE_1').AsString  := Phone_1.Text;
  UpdateStoredProc.ParamByName('PHONE_2').AsString  := Phone_2.Text;
  UpdateStoredProc.ParamByName('info').value        := INFO.Lines.Text;
  if DismissDateEdit.Text <> '  .  .    ' then
    UpdateStoredProc.ParamByName('dismiss').value:= DismissDateEdit.Text
  else
    UpdateStoredProc.ParamByName('dismiss').clear;

   try
    data.RMPBase.StartTransaction;
     UpdateStoredProc.ExecProc;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  ID := findIDbyCode('spr_wrkr', trim(Code.text));
  MainForm.ID := ID;


  ModalResult := mrOK;
end;

procedure TENUM_WRKRForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;
//
//  Процедура выбора справочника профессий
//
procedure TENUM_WRKRForm.PROFComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ProfCombo);

end;
//
//  Процедура выбора справочника Должностей
//
procedure TENUM_WRKRForm.PostComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PostCombo);

end;
//
//  Процедура выбора справочника Подразделения
//
procedure TENUM_WRKRForm.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PDRCombo);

end;
//
//  Процедура выбора справочника Оборудованиеи
//
procedure TENUM_WRKRForm.EQPTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EQPTCombo);

end;
//
//  Процедура выбора справочника Работники для поля "Бригадир"
//
procedure TENUM_WRKRForm.BOSSComboButtonClick(Sender: TObject);
begin
  SelectFromTable(BossCombo);

end;
{
   При редактировании поля "профессий" нажали кнопку клавы
}
procedure TENUM_WRKRForm.PROFComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( PROFCombo, key, Shift) = false then
     PROFComboButtonClick(Sender);

end;
{
   При редактировании поля "Должностей" нажали кнопку клавы
}
procedure TENUM_WRKRForm.PostComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( PostCombo, key, Shift) = false then
     PostComboButtonClick(Sender);

end;
{
   При редактировании поля "Подразделения" нажали кнопку клавы
}
procedure TENUM_WRKRForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);

end;
{
   При редактировании поля "Оборудованиеи" нажали кнопку клавы
}
procedure TENUM_WRKRForm.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EQPTCombo, key, Shift) = false then
     EQPTComboButtonClick(Sender);

end;
{
   При редактировании поля "Boss" нажали кнопку клавы
}
procedure TENUM_WRKRForm.BOSSComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( BOSSCombo, key, Shift) = false then
     BOSSComboButtonClick(Sender);

end;



// ***********************************************************************



//
//  Процедура добавления вида операции
//
procedure TENUM_WRKRForm.ButtonAddVOPClick(Sender: TObject);
begin

  VOPCombo.ID := -1;
  SelectFromTable(VOPCombo);

  if VOPCombo.ID > 0 then
    begin
       with qUpdateVOPQuery do
         begin
          // проверка на повтор
          sql.Clear;
          sql.Add('select * from SPR_WRVOP ');
          sql.Add('where ID_WRKR = :ID_WRKR and ID_VOP = :ID_VOP');
          params[0].AsInteger := ID;
          params[1].AsInteger := VOPCombo.ID;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;


          sql.Clear;
          sql.Add('insert into SPR_WRVOP ');
          sql.Add('values (GEN_ID(SPR_WRVP_GEN,1), :ID_WRKR, :ID_VOP)');
          params[0].AsInteger := id;
          params[1].AsInteger := VOPCombo.ID;
          ExecSQL;
         end;


      if not newrecord then
         refreshQuery(qVOPQuery)
      else

       begin
         qVOPQuery.ParamByName('ID').asinteger := ID;
         qVOPQuery.Open;
       end;

    end;


end;
//
//  Процедура редактирования операции
procedure TENUM_WRKRForm.ButtonEditVOPClick(Sender: TObject);
begin
  if  qVOpQuery.Eof then exit;

  VOPCombo.ID := qVOPQuery.Fieldbyname('id_vop').asinteger;
  SelectFromTable(VOPCombo);

  if VOPCombo.ID > 0 then
    begin
       with qUpdateVOPQuery do
         begin
          sql.Clear;
          sql.Add('select * from SPR_WRVOP ');
          sql.Add('where ID_WRKR = :ID_WRKR and ID_VOP = :ID_VOP and id <> :id');
          params[0].AsInteger := id;
          params[1].AsInteger := VOPCombo.ID;
          params[2].AsInteger := qVOPQuery.fieldbyname('id').asinteger;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;

          sql.Clear;
          sql.Add('update SPR_WRVOP ');
          sql.Add('set id_vop = :id_vop');
          sql.Add('where id = :id');
          params[1].AsInteger := qVOPQuery.fieldbyname('id').asinteger;
          params[0].AsInteger := VOPCombo.ID;
          ExecSQL;
         end;

       if not newrecord then

         refreshquery( qVOPQuery)
        else
         begin

           qVOPQuery.close;
           qVOPQuery.ParamByName('id').asinteger := ID;
           qVOPQuery.open;

         end;
    end;

end;

procedure TENUM_WRKRForm.ButtonDelVOPClick(Sender: TObject);
begin
  // если есть что удалять
  if  qVOpQuery.Eof then exit;
  // Формирование запроса для удаления элемента

  if messagedlg('Удалить запись ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with data.qDELQuery do
     begin

      close;
      sql.clear;
        sql.add('delete from spr_wrvop where id = ' +
          inttostr(qVOpQuery.FieldByName('ID').asinteger));
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

     end;

       refreshQuery(qVOpQuery);

end;

procedure TENUM_WRKRForm.VOPGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       46 :  ButtonDelVOPClick(Sender); // удаление записи
       45 :  ButtonAddVOPClick(Sender);    // Добавление по Ins
       13 :  ButtonEditVOPClick(Sender)   // Редактирование по Enter
     end;

end;

procedure TENUM_WRKRForm.ButtonAddEQPTClick(Sender: TObject);
begin

  EQPTCombo.ID := -1;
  SelectFromTable(EQPTCombo);

  if EQPTCombo.ID > 0 then
    begin
       with qUpdateEQPTQuery do
         begin
          // проверка на повтор
          sql.Clear;
          sql.Add('select * from SPR_WREQ ');
          sql.Add('where ID_WRKR = :ID_WRKR and ID_EQPT = :ID_EQPT');
          params[0].AsInteger := ID;
          params[1].AsInteger := EQPTCombo.ID;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;


          sql.Clear;
          sql.Add('insert into SPR_WREQ ');
          sql.Add('values (GEN_ID(SPR_WREQ_GEN,1), :ID_WRKR, :ID_VOP)');
          params[0].AsInteger := id;
          params[1].AsInteger := EQPTCombo.ID;
          ExecSQL;
         end;


      if not newrecord then
         refreshQuery(qEQQuery)
      else

       begin
         qEQQuery.ParamByName('ID').asinteger := ID;
         qEQQuery.Open;
       end;

    end;


end;

procedure TENUM_WRKRForm.ButtonEditEQPTClick(Sender: TObject);
begin
  if  qEqQuery.Eof then exit;

  EQPTCombo.ID := qEQQuery.Fieldbyname('id_eqpt').asinteger;
  SelectFromTable(EQPTCombo);

  if EQPTCombo.ID > 0 then
    begin
       with qUpdateEQPTQuery do
         begin
          sql.Clear;
          sql.Add('select * from SPR_WREQ ');
          sql.Add('where ID_WRKR = :ID_WRKR and ID_EQPT = :ID_EQPT and id <> :id');
          params[0].AsInteger := id;
          params[1].AsInteger := EQPTCombo.ID;
          params[2].AsInteger := qEQQuery.fieldbyname('id').asinteger;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;

          sql.Clear;
          sql.Add('update SPR_WREQ ');
          sql.Add('set ID_EQPT = :ID_EQPT');
          sql.Add('where id = :id');
          params[1].AsInteger := qEQQuery.fieldbyname('id').asinteger;
          params[0].AsInteger := EQPTCombo.ID;
          ExecSQL;
         end;

       if not newrecord then

         refreshquery( qEQQuery)
        else
         begin

           qEQQuery.close;
           qEQQuery.ParamByName('id').asinteger := ID;
           qEQQuery.open;

         end;
    end;

end;

procedure TENUM_WRKRForm.ButtonDelEqptClick(Sender: TObject);
begin
 // если есть что удалять
  if  qEqQuery.Eof then exit;
  // Формирование запроса для удаления элемента

  if messagedlg('Удалить запись ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with data.qDELQuery do
     begin

      close;
      sql.clear;
        sql.add('delete from spr_wreq where id = ' +
          inttostr(qEqQuery.FieldByName('ID').asinteger));
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

     end;

       refreshQuery(qEqQuery);

end;

procedure TENUM_WRKRForm.EQPTGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       46 :  ButtonDelEqptClick(Sender); // удаление записи
       45 :  ButtonAddEQPTClick(Sender);    // Добавление по Ins
       13 :  ButtonEditEQPTClick(Sender)   // Редактирование по Enter
     end;
end;

procedure refreshthisquery(qQuery : tQuery);
var lineno : integer;
begin
   lineno := qQuery.Fieldbyname('lineno').asinteger;
   qQuery.close;
   qQuery.open;
   qquery.locate('lineno',  lineno, [loCaseInsensitive]);

end;


procedure TENUM_WRKRForm.ButtonAddAttClick(Sender: TObject);
var Form : TENUM_WORKERSERTFORM;

begin
  // Добавление характеристик возможно только для существующих элементов
  if  ID < 0 then
    begin
      showmessage('Элемент не записан.');
      exit
    end;
  Form  := TENUM_WORKERSERTFORM.CreateN(Application, ID,
    qSertificateQuery.RecordCount + 1, 0);


  if Form.showmodal = mrOK then
     refreshthisquery(qSertificateQuery);

  Form.Release;

end;

procedure TENUM_WRKRForm.ButtonEditAttClick(Sender: TObject);
var Form : TENUM_WORKERSERTFORM;

begin
  // Добавление характеристик возможно только для существующих элементов
  if  ID < 0 then
    begin
      showmessage('Элемент не записан.');
      exit
    end;
  if qSertificateQuery.eof then exit;

  Form  := TENUM_WORKERSERTFORM.CreateN(Application, ID,
    qSertificateQuery.FieldByName('Lineno').asinteger, 1);

  if Form.showmodal = mrOK then
       refreshthisquery(qSertificateQuery);

  Form.Release;

end;

procedure TENUM_WRKRForm.ButtonDelAddClick(Sender: TObject);
begin
 // если есть что удалять
  if  qSertificateQuery.Eof then exit;
  // Формирование запроса для удаления элемента

  if messagedlg('Удалить запись ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with data.qDELQuery do
     begin

      close;
      sql.clear;
      sql.add('delete from SPR_SERTIFICATEACCESS where id_wrkr = :wrkr and ');
      sql.add('wrkr_lineno = :lineno ');
      parambyname('wrkr').AsInteger := ID;
      parambyname('lineno').AsInteger := qSertificateQuery.FieldByName('Lineno').AsInteger;
      data.RMPBase.StartTransaction;
       ExecSQL;

      close;
      sql.clear;
        sql.add('delete from SPR_WORKERSERTIFICATE where id_wrkr = ' +
          inttostr(ID) + ' and lineno = ' +
           qSertificateQuery.FieldByName('Lineno').asstring);
       ExecSQL;
      data.RMPBase.Commit;

     end;

       refreshthisquery(qSertificateQuery);


end;

procedure TENUM_WRKRForm.SertificateGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     case Key of
       46 :  ButtonDelAddClick(Sender);    // удаление записи
       45 :  ButtonAddAttClick(Sender);    // Добавление по Ins
       13 :  ButtonEditAttClick(Sender)   // Редактирование по Enter
     end;

end;

end.
