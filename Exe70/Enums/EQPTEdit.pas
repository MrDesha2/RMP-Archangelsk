{-----------------------------------------------------------------------------
 Unit Name: EQPTEdit
 Author:    Косицын Дмитрий
 Purpose:   форма редактирования элемента справочника "Оборудование".
   Вызывается из формы EnumTreeForm.
 History:   2003
-----------------------------------------------------------------------------}

unit EQPTEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Grids, DBGrids, Mask, ToolEdit, RXDBCtrl,
  ComCtrls, ExtCtrls, EnumTreeForm, EnumForm, CHAREdit, RepEdit, ToolWin,
  ImgList, DBGridEh, CurrEdit;

type
  TENUM_EQPTForm = class(TForm)
    Panel1: TPanel;
    PageControl: TPageControl;
    TabSheetMain: TTabSheet;
    TabSheetCHRT: TTabSheet;
    TabSheetRep: TTabSheet;
    Code: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    _Name: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    OK_Button: TButton;
    CloseButton: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    CHEQSource: TDataSource;
    REPSource: TDataSource;
    FAILSource: TDataSource;
    qRepQuery: TQuery;
    qCHEQQuery: TQuery;
    qFAILQuery: TQuery;
    qQuery: TQuery;
    Label5: TLabel;
    BUILDER: TEdit;
    qQueryupdate: TQuery;
    Label6: TLabel;
    Label7: TLabel;
    BeginDate: TDateEdit;
    EndDate: TDateEdit;
    TabSheetChange: TTabSheet;
    Panel8: TPanel;
    CHAINSource: TDataSource;
    qChainQuery: TQuery;
    genIDQuery: TQuery;
    qPDRQuery: TQuery;
    qTYPEQuery: TQuery;
    PDRCombo: TComboEdit;
    TYPEID: TComboEdit;
    ToolBarCh: TToolBar;
    ToolButton1: TToolButton;
    ToolButtonEditCh: TToolButton;
    ToolButtonDelCh: TToolButton;
    ToolBarRep: TToolBar;
    ToolButtonAddRep: TToolButton;
    ToolButtonEditRep: TToolButton;
    ToolButtonDelRep: TToolButton;
    ToolBarFail: TToolBar;
    ToolButtonAddFail: TToolButton;
    ToolButtonEditFail: TToolButton;
    ToolButtonDelFail: TToolButton;
    ToolBarChain: TToolBar;
    ToolButtonAddChain: TToolButton;
    ToolButtonEditChain: TToolButton;
    ToolButtonDelChain: TToolButton;
    CHEQGrid: TDBGridEh;
    RepGrid: TDBGridEh;
    FailGrid: TDBGridEh;
    ChainGrid: TDBGridEh;
    Save_Button: TButton;
    qCHEQQueryID: TIntegerField;
    qCHEQQueryNAME: TStringField;
    qCHEQQueryNSIZE: TFloatField;
    qCHEQQueryKIND: TStringField;
    TabSheetVOP: TTabSheet;
    PanelVOPBot: TPanel;
    ToolBar1: TToolBar;
    ToolButtonVOPAdd: TToolButton;
    ToolButtonVOPEdit: TToolButton;
    ToolButtonVOPDel: TToolButton;
    PanelVOP: TPanel;
    VOPGrid: TDBGridEh;
    qVOPStoredProc: TStoredProc;
    VOPSource: TDataSource;
    qVOPQuery: TQuery;
    Splitter: TSplitter;
    qVIDQuery: TQuery;
    Label8: TLabel;
    TypeEQPTCombo: TComboBox;
    Label9: TLabel;
    GostEdit: TEdit;
    Label10: TLabel;
    StatusCombo: TComboBox;
    Label11: TLabel;
    ACTEdit: TEdit;
    Label12: TLabel;
    UsefuLifeEdit: TCurrencyEdit;
    Label13: TLabel;
    Label14: TLabel;
    MinValue: TCurrencyEdit;
    MaxValue: TCurrencyEdit;
    Label16: TLabel;
    MarkEdit: TEdit;
    Label17: TLabel;
    EDIZCombo: TComboEdit;
    qEDIZQuery: TQuery;
    VOPCombo: TComboEdit;
    qSelectVOPQuery: TQuery;
    qUpdateVOPQuery: TQuery;
    Label15: TLabel;
    CostEdit: TCurrencyEdit;
    procedure qRepQueryAfterScroll(DataSet: TDataSet);
    procedure CloseButtonClick(Sender: TObject);
    procedure OK_ButtonClick(Sender: TObject);
    procedure save;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure TYPEIDButtonClick(Sender: TObject);
    procedure ButtonAddChClick(Sender: TObject);
    procedure ButtonDelChClick(Sender: TObject);
    procedure ButtonEditChClick(Sender: TObject);
    procedure ButtonAddChainClick(Sender: TObject);
    procedure ButtonAddRepClick(Sender: TObject);
    procedure ButtonDelRepClick(Sender: TObject);
    procedure ButtonEditRepClick(Sender: TObject);
    procedure ButtonAddFailClick(Sender: TObject);
    procedure ButtonDelFailClick(Sender: TObject);
    procedure qFAILQueryBeforePost(DataSet: TDataSet);
    procedure qFAILQueryAfterPost(DataSet: TDataSet);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TYPEIDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CHEQGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RepGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FailGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonDelChainClick(Sender: TObject);
    procedure Save_ButtonClick(Sender: TObject);
    procedure ToolButtonVOPAddClick(Sender: TObject);
    procedure ToolButtonVOPEditClick(Sender: TObject);
    procedure ToolButtonVOPDelClick(Sender: TObject);
    procedure VOPGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonEditFailClick(Sender: TObject);
    procedure ToolButtonEditChainClick(Sender: TObject);
    procedure VOPGridColumns0EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure EDIZComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EDIZComboButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_EQPTForm: TENUM_EQPTForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;

  newrecord: boolean;
  tNewText, tNewGroupText, tUpdateText : string;

implementation

uses Main,
        EnumForm4Sel,
        libs, Base,
        CHAINEdit,
        FAILEdit;

{$R *.DFM}
// Процедура изменения запроса по материалам в момент
// изменения операции
//
procedure TENUM_EQPTForm.qRepQueryAfterScroll(DataSet: TDataSet);
begin
  qFAILQuery.close;
  qFAILQuery.ParamByName('ID').asinteger := qREPQuery.FieldByName('ID_1').asinteger;
  qFAILQuery.Open;
end;

procedure TENUM_EQPTForm.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
{
      Процедура записи

}
procedure TENUM_EQPTForm.save;

begin

  if (EditType = 0) then // это добавление записи
      qQueryupdate.ParamByName('ParentID').asinteger := ParentID
  else
      qQueryupdate.ParamByName('ID').asinteger       := ID;


  if trim(code.text) = '' then
    begin
      showmessage('Код не указан!');
      abort;

    end;


    // если под этим номером уже есть запись и их ID разные
   if (ChechUniqueCode('spr_eqpt', 'Code', trim(code.text), ID) > 0) then
    begin
      showmessage('Код не уникальный!');
      abort;

    end;



  // заполние параметров запроса
  if PDRCombo.ID > 0 then
    SetParamCombo(qQueryupdate.ParamByName('id_pdr'), PDRCombo)
  else
    begin
      showmessage('Не заполнено поле "Подразделение".');
      exit;
    end;

  // заполнение свойства тип оборудование
  SetParamCombo(qQueryupdate.ParamByName('typeid'), TypeID);

  SetParamCombo(qQueryupdate.ParamByName('id_ediz'), EdizCombo);


  qQueryupdate.ParamByName('Code').value    := Code.text;
  qQueryupdate.ParamByName('Name').value    := _Name.Text;
  qQueryupdate.ParamByName('builder').value := builder.Text;
  qQueryupdate.ParamByName('Date_beg').DataType := ftDate;
  qQueryupdate.ParamByName('Date_end').DataType := ftDate;

  if trim(BeginDate.Text) <> '.  .' then
    qQueryupdate.ParamByName('Date_beg').value:= BeginDate.Text
  else
    begin
      showmessage('Дата начала эксплуатации не указана!');
      exit;
    end;

  if trim(EndDate.Text) <> '.  .' then
    qQueryupdate.ParamByName('Date_end').value:= EndDate.Text
  else
    begin
      showmessage('Дата окончания эксплуатации не указана!');
//      exit;
    end;

  qQueryupdate.ParamByName('status').asinteger := StatusCombo.ItemIndex;
  qQueryupdate.ParamByName('type_eqpt').asinteger := TypeEqptCombo.ItemIndex;
  qQueryupdate.ParamByName('act').asstring     := ActEdit.Text;
  qQueryupdate.ParamByName('Gost').asstring    := GostEdit.Text;
  qQueryupdate.ParamByName('mark').asstring    := MarkEdit.Text;

  qQueryupdate.ParamByName('Min_value').value  := MinValue.Value;
  qQueryupdate.ParamByName('Max_value').value  := MaxValue.Value;
  qQueryupdate.ParamByName('Usefulife').value  := UsefuLifeEdit.Value;
  qQueryupdate.ParamByName('Cost').value       := CostEdit.Value;





   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  // поиск ID вновь введенной записи
  if ID = -1 then
    begin
       ID := findIDbyCode('spr_eqpt', trim(code.text));
       MainForm.ID := ID;

       EditType := 1;
       qQueryupdate.sql.clear;
       qQueryupdate.sql.add(tUpdateText);

    end;


end;


//
//  Процедура выполнения транзакции по нажатию "ОК"
//
procedure TENUM_EQPTForm.OK_ButtonClick(Sender: TObject);
begin
     save;
     ModalResult := mrOK;
end;

{
    Процедура записи

}
procedure TENUM_EQPTForm.Save_ButtonClick(Sender: TObject);
begin
  save;
end;


//
//  Процедура при закрытии формы освобождает форму.
//
procedure TENUM_EQPTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;
//
//  Процедура при открытии формы редактирования элемента справочника
//
procedure TENUM_EQPTForm.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin

  ParentID := MainForm.ParentID;

  PageControl.ActivePageIndex := 0;

  // Формирование запроса для генерации ID справочника ремонтов
  GenIDQuery.sql.clear;
  GenIDQuery.sql.add('SELECT GEN_ID(SPR_REP_GEN, 1) FROM RDB$DATABASE');


  tNewText      := 'insert into spr_eqpt ' +
                'values (GEN_ID(SPR_eqpt_GEN,1), :parentID, 0, :code, :name, ' +
                ':id_pdr, :typeid, :builder, :date_beg, :date_end, ' +
                ':TYPE_EQPT, :GOST, :STATUS, :ACT, :USEFULIFE, :Min_value, :max_value, ' +
                ':id_ediz, :mark, :cost) ';
  tNewGroupText := 'insert into spr_eqpt ' +
                'values (GEN_ID(SPR_eqpt_GEN,1), :parentID, 1, :code, :name, '+
                ':id_pdr, :typeid, :builder, :date_beg, :date_end, ' +
                ':TYPE_EQPT, :GOST, :STATUS, :ACT, :USEFULIFE, :Min_value, :max_value, ' +
                ':id_ediz, :mark, :cost) ';
  tUpdateText   := 'update spr_eqpt ' +
                'set CODE = :code, NAME = :name, id_pdr = :id_pdr, typeid = :typeID, ' +
                'builder = :builder, date_beg = :date_beg, date_end = :date_end, ' +
                'TYPE_EQPT = :TYPE_EQPT, GOST = :GOST, STATUS = :STATUS, ACT = :ACT, ' +
                'USEFULIFE = :USEFULIFE, Min_value = :Min_value, max_value = :max_value, ' +
                'id_ediz = :id_ediz, mark = :mark, cost = :cost ' +
                'where ID =  :ID ';


  ID          := -1;

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin

       newrecord := true;

        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_eqpt');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);

       _Name.text := 'Новый элемент';
       Caption    := 'Справочник "Оборудование". Новый элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add(tNewText);
       EditType := 0;

       PDRCombo.ID  := -1;
       TYPEID.ID    := -1;

       StatusCombo.ItemIndex := 0;
       TypeEQPTCombo.ItemIndex := 0;
       EDIZCombo.ID := -1;

    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin
       newrecord := true;


       Code.Text   := '';
       _Name.text  := 'Новая группа';
       Caption     := 'Справочник "Оборудование". Новая группа';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add(tNewGroupText);
       EditType := 0;

       PDRCombo.ID := -1;
       TYPEID.ID   := -1;

       StatusCombo.ItemIndex := 0;
       TypeEQPTCombo.ItemIndex := 0;
       EDIZCombo.ID := -1;

     end
   else {редактирование элемента}
    if mainForm.isFolder = 3 then {Добавление новой группы}
     begin

       // проверка на разрешение редактирования
       Save_Button.Enabled := check_user_grand(uppercase('spr_eqpt'), 'U', true);

       newrecord := false;


       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_eqpt');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       code.Text   := qQuery.fieldByName('Code').AsString;
       _name.text  := qQuery.fieldByName('Name').AsString;
       ParentID    := qQuery.fieldByName('ParentID').AsInteger;
       Id          := qQuery.fieldByName('ID').AsInteger;
       // завод-изготовитель
       Builder.text  := qQuery.fieldByName('BUILDER').asstring;
       BeginDate.Text:= qQuery.fieldByName('DATE_BEG').asstring;
       EndDate.text  := qQuery.fieldByName('DATE_END').asstring;

       // формирование запроса для записи элемента
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add(tUpdateText);

       // заполнение поля "Подразделение"
       PDRCombo.ID := qQuery.fieldByName('ID_PDR').AsInteger;

       // заполнение поля "Тип станка"
       TYPEID.ID := qQuery.fieldByName('TYPEID').asinteger;

       EditType := 1; // тип редактирования - редактирование

       EDIZCombo.ID          := qQuery.FieldByName('id_ediz').asinteger;
       if not qQuery.FieldByName('status').IsNull then
        StatusCombo.ItemIndex := qQuery.FieldByName('status').asinteger;

       if not qQuery.FieldByName('Type_EQPT').IsNull then
         TypeEQPTCombo.ItemIndex:= qQuery.FieldByName('Type_EQPT').asinteger;

       GostEdit.Text         := qQuery.FieldByName('Gost').asstring;
       MarkEdit.Text         := qQuery.FieldByName('mark').asstring;
       ActEdit.Text          := qQuery.FieldByName('act').asstring;

       if not qQuery.FieldByName('Min_Value').isnull then
         MinValue.Value        := qQuery.FieldByName('Min_Value').value;

       if not qQuery.FieldByName('Max_Value').isnull then
         MaxValue.Value        := qQuery.FieldByName('Max_Value').value;

       if not qQuery.FieldByName('Usefulife').isnull then
         UsefuLifeEdit.Value   := qQuery.FieldByName('Usefulife').value;

       if not qQuery.FieldByName('Cost').IsNull then
         CostEdit.Text         := qQuery.FieldByName('Cost').value;



       Caption := 'Справочник "Оборудование". Элемент: ' + _name.text;
     end;
       // заполнение таблицы характеристик
       qCHeqQuery.close;
       qCHEQQuery.ParamByName('ID').asinteger := id;
       qCHEQQuery.open;


        // заполнение таблицы ремонтов
       qREPQuery.close;
       qREPQuery.ParamByName('ID').asinteger := id;
       qREPQuery.open;

       // заполнение таблицы причин отказов
       qFAILQuery.close;
       qFAILQuery.ParamByName('ID').asinteger := qREPQuery.FieldByName('ID_1').asinteger;
       qFAILQuery.open;

       // заполнение таблицы замен
       qChainQuery.Close;
       qChainQuery.ParamByName('ID').asinteger := id;
       qChainQuery.open;

     // открытие запроса по операциям работника
     qVOPQuery.ParamByName('ID').AsInteger := ID;
     qVOPQuery.Open;



end;
//
// Процедура выбора значения "Подразделение"
//
procedure TENUM_EQPTForm.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PDRCombo);
end;
//
// Процедура выбора значения "Тип станка"
//
procedure TENUM_EQPTForm.TYPEIDButtonClick(Sender: TObject);
begin
  SelectFromTable(TYPEID);

end;
//
//  Процедура добавления характеристики Оборудования
//
procedure TENUM_EQPTForm.ButtonAddChClick(Sender: TObject);
var EditCHAR: tform;
begin
  // Добавление характеристики возможно только для сохраненных элементов
  if ID < 0 then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;

  EditCHAR := TENUM_CHEQForm.CreateN(Application, 0, ID, 'spr_cheq', 'spr_cheq_gen', 1, 2);
  if EditCHAR.showmodal = mrOK then
     if not newrecord then

         refreshquery( qCHEQQuery)
     else
      begin

         qCHEQQuery.close;
         qCHEQQuery.ParamByName('id').asinteger := ID;
         qCHEQQuery.open;

      end;


end;
//
//   Процедура удаления характеристики Оборудования
//
procedure TENUM_EQPTForm.ButtonDelChClick(Sender: TObject);

begin
  // Проверка: есть ли что удалять
  if qCHEQQuery.eof then
    exit;

 if messagedlg('Удалить запись ' + qCHEQQuery.FieldByName('Name').asstring + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

  with data.qDELQuery do
    begin
    
     close;
     sql.clear;
     sql.add('delete from spr_cheq where id = ' + qCHEQQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

    end;

   refreshquery( qCHEQQuery);
end;
//
//  Процедура редактирования характеристики чертежа
//
procedure TENUM_EQPTForm.ButtonEditChClick(Sender: TObject);
var EditCHAR: tform;
    _id : integer;
begin
  // Если справочник характеристик не пустой, то можно редактировать
  if qCHEQQuery.eof then
     exit;
  // Нахождение ID элемента справочника
  _id := qCHEQQuery.FieldByName('ID').asinteger;
  EditCHAR := TENUM_CHEQForm.CreateN(Application, _Id, ID, 'spr_cheq', 'spr_cheq_gen', 2, 2);
  if EditCHAR.showmodal = mrOK then
         refreshquery( qCHEQQuery);
end;

//
//  Процедура добавления наследника станка
//
procedure TENUM_EQPTForm.ButtonAddChainClick(Sender: TObject);
var Form: TEnum_CHAINForm;
begin
  // Добавление ремонтов оборудования возможно только для
  // сохраненных элементов
  if ID < 0 then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;
  // Формирование формы для редактирования свойств элемента справочника
  Form := TENUM_CHAINForm.createN(application,  ID, 0, 1);
  Form.LabelEQPT.Caption := _Name.Text;
  Form.caption := 'Добавление альтернативы оборудования';
  if Form.showmodal = mrOK then
     if not newrecord then
       refreshquery( qChainQuery)
     else
       begin
         qChainQuery.close;
         qChainQuery.ParamByName('id').asinteger := ID;
         qChainQuery.open;
       end;


end;

procedure TENUM_EQPTForm.ToolButtonEditChainClick(Sender: TObject);
var Form: TEnum_CHAINForm;
begin
  // Добавление ремонтов оборудования возможно только для
  // сохраненных элементов
  if ID < 0 then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;

   if qChainQuery.eof then exit;

  // Формирование формы для редактирования свойств элемента справочника
  Form := TENUM_CHAINForm.createN(application,  ID, qChainQuery.Fields[0].asinteger, 2);
  Form.LabelEQPT.Caption := _Name.Text;
  Form.caption := 'Редактирование альтернативы оборудования';
  if Form.showmodal = mrOK then
     if not newrecord then
       refreshquery( qChainQuery)
     else
       begin
         qChainQuery.close;
         qChainQuery.ParamByName('id').asinteger := ID;
         qChainQuery.open;
       end;


end;


procedure TENUM_EQPTForm.ToolButtonDelChainClick(Sender: TObject);
begin
  // удаление элементов справочника возможно только в непустом справочнике
  if qChainQuery.eof then
     exit;

 if messagedlg('Удалить запись?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  with data.qDELQuery do
   begin
      close;
      sql.clear;
      sql.add('delete from spr_chain where id = ' + qChainQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

   end;

   refreshquery( qChainQuery);

end;


//
//  Процедура вызова формы добавления ремонта оборудования
//
procedure TENUM_EQPTForm.ButtonAddRepClick(Sender: TObject);
var Form: tform;
begin
  // Добавление ремонтов оборудования возможно только для
  // сохраненных элементов
  if ID < 0 then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;
  // Формирование формы для редактирования свойств элемента справочника
  Form := TENUM_REPForm.createN(application, 0, ID, 'spr_rep', 'spr_rep_gen', 1);
  Form.caption := 'Добавление ремонта оборудования';
  if Form.showmodal = mrOK then
     if not newrecord then
         refreshquery( qREPQuery)

     else
      begin

         qREPQuery.close;
         qREPQuery.ParamByName('id').asinteger := ID;
         qREPQuery.open;

      end;


     refreshquery( qREPQuery);

     
end;
//
//  Процедура удаления Ремонта оборудования
//
procedure TENUM_EQPTForm.ButtonDelRepClick(Sender: TObject);

begin
  // удаление элементов справочника возможно только в непустом справочнике
  if qREPQuery.eof then
     exit;

 if messagedlg('Удалить запись?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  with data.qDELQuery do
   begin
      close;
      sql.clear;
      sql.add('delete from spr_rep where id = ' + qREPQuery.FieldByName('ID_1').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

   end;

   refreshquery( qREPQuery);
end;
//
//  Процедура редактирования ремонта оборудования
//
procedure TENUM_EQPTForm.ButtonEditRepClick(Sender: TObject);
var EditVOP: tform;
    _id : integer;
begin
  if qREPQuery.eof then
    exit;

  _id := qREPQuery.FieldByName('ID_1').asinteger;
  EditVOP := TENUM_REPForm.createN(application, _ID, ID, 'spr_rep', 'spr_rep_gen', 2);
  EditVOP.caption := 'Редактирование плановой операции чертежа';
  if EditVOP.showmodal = mrOK then
      refreshquery( qREPQuery);

end;
//
//  Процедура вызова формы добавления причины отказа
//
procedure TENUM_EQPTForm.ButtonAddFailClick(Sender: TObject);
var FailForm : TENUM_FAILEdit;
begin
  if qRepQuery.Eof then
   begin
    MessageDlg('Сведения о ремонте не введены.', mtWarning, [mbOK], 0);
    exit;
   end;

  FailForm := TENUM_FAILEdit.createN(application, qREPQuery.FieldByName('ID_1').asinteger, 0, 1);
  if FailForm.showmodal = mrOK then
    begin
         qFAILQuery.Close;
         qFailQuery.Params[0].asinteger := qREPQuery.FieldByName('ID_1').asinteger;
         qFAILQuery.open;
    end;


end;

procedure TENUM_EQPTForm.ToolButtonEditFailClick(Sender: TObject);
var FailForm : TENUM_FAILEdit;
begin
  if qRepQuery.Eof then
   begin
    MessageDlg('Сведения о ремонте не введены.', mtWarning, [mbOK], 0);
    exit;
   end;

  FailForm := TENUM_FAILEdit.createN(application,
    qREPQuery.FieldByName('ID_1').asinteger,
    qFAILQuery.Fields[0].asinteger, 2);
  if FailForm.showmodal = mrOK then
    begin
         qFAILQuery.Close;
         qFailQuery.Params[0].asinteger := qREPQuery.FieldByName('ID_1').asinteger;
         qFAILQuery.open;
    end;

end;
//
//  Процедура удаления причины отказа
//
procedure TENUM_EQPTForm.ButtonDelFailClick(Sender: TObject);
begin
  // удаление элементов справочника возможно только в непустом справочнике
  if qREPQuery.eof then
     exit;

 if messagedlg('Удалить запись?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  with data.qDELQuery do
   begin
      close;
      sql.clear;
      sql.add('delete from spr_fail where code = ' + qFailQuery.FieldByName('code').asstring
        + ' and id_rep = ' + qRepQuery.FieldByName('ID_1').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

   end;

   qFailQuery.close;
   qFailQuery.open;


end;
//
//   Процедура редактирования причины отказа
//

///
//        Процедура генерации идентификатора записи элемента
//    справочника причины отказов
//
procedure TENUM_EQPTForm.qFAILQueryBeforePost(DataSet: TDataSet);
begin
  if FailGrid.DataSource.State = dsInsert then
    begin
      GenIDQuery.Open;
      qFAILQuery.FieldByName('ID').asInteger:=
         GenIDQuery.Fields[0].asInteger;
      qFAILQuery.FieldByName('ID').asInteger:=
         ID;
      GenIDQuery.Close;
    end;
end;
//
//    Процедура обновления формы справочника
//
procedure TENUM_EQPTForm.qFAILQueryAfterPost(DataSet: TDataSet);
begin
  refreshquery(qFAILQuery);
end;
{
  При нажатии кнопки на поле "Подразделения"
}
procedure TENUM_EQPTForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( PDRCombo, key, Shift) = false then
    PDRComboButtonClick(Sender);
end;
{
  При нажатии кнопки на поле "Тип станка"
}
procedure TENUM_EQPTForm.TYPEIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( TYPEID, key, Shift) = false then
    TYPEIDButtonClick(Sender);
end;

{
      Процедура при редактировании таблицы характеристик
       нажали на кнопку клавы

}
procedure TENUM_EQPTForm.CHEQGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelChClick(Sender);   // удаление записи
    45 :  ButtonAddChClick(Sender);   // Добавление по Ins
    13 :  ButtonEditChClick(Sender);  // Редактирование по Enter
    116: begin                        // обновление по F5
           qCHEQQuery.close;
           qCHEQQuery.open;
         end;
  end;
end;

{
    Процедура при нажатии на таблицу ремонтов нажали кнопку клавы
}
procedure TENUM_EQPTForm.RepGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelRepClick(Sender);   // удаление записи
    45 :  ButtonAddRepClick(Sender);   // Добавление по Ins
    13 :  ButtonEditRepClick(Sender);  // Редактирование по Enter
    116:  begin                        // обновление по F5
            qrepQuery.close;
            qrepQuery.open;
          end;
  end;
end;


{
    Процедура при редактировании таблицы причин отказов
    нажали на кнопку клавы

}
procedure TENUM_EQPTForm.FailGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelfailClick(Sender);   // удаление записи
    45 :  ButtonAddfailClick(Sender);   // Добавление по Ins
    13 :  ToolButtonEditFailClick(Sender);  // Редактирование по Enter
    116:  begin                        // обновление по F5
            qFailQuery.close;
            qFailQuery.open;
          end;
  end;
end;


procedure TENUM_EQPTForm.ToolButtonVOPAddClick(Sender: TObject);
begin
  VOPCombo.ID := -1;
  SelectFromTable(VOPCombo);

  if VOPCombo.ID > 0 then
    begin
       with qUpdateVOPQuery do
         begin
          // проверка на повтор
          sql.Clear;
          sql.Add('select * from SPR_EQVOP ');
          sql.Add('where id_eqpt = :id_eqpt and ID_VOP = :ID_VOP');
          params[0].AsInteger := ID;
          params[1].AsInteger := VOPCombo.ID;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;


          sql.Clear;
          sql.Add('insert into SPR_EQVOP ');
          sql.Add('values (GEN_ID(SPR_EQVOP_GEN,1), :id_eqpt, :ID_VOP)');
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

procedure TENUM_EQPTForm.ToolButtonVOPEditClick(Sender: TObject);
begin
  if  qVOPQuery.Eof then exit;

  VOPCombo.ID := qVOPQuery.Fieldbyname('id_vop').asinteger;
  SelectFromTable(VOPCombo);

  if VOPCombo.ID > 0 then
    begin
       with qUpdateVOPQuery do
         begin
          sql.Clear;
          sql.Add('select * from SPR_EQVOP ');
          sql.Add('where id_eqpt = :id_eqpt and ID_VOP = :ID_VOP and id <> :id');
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
          sql.Add('update SPR_EQVOP ');
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

procedure TENUM_EQPTForm.ToolButtonVOPDelClick(Sender: TObject);
begin
 // если есть что удалять
  if  qVOPQuery.Eof then exit;
  // Формирование запроса для удаления элемента

  if messagedlg('Удалить запись ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    with data.qDELQuery do
     begin

      close;
      sql.clear;
        sql.add('delete from spr_eqvop where id = ' +
          inttostr(qVOPQuery.FieldByName('ID').asinteger));
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

     end;

       refreshQuery(qVOPQuery);



end;

procedure TENUM_EQPTForm.VOPGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case Key of
       46 :  ToolButtonVOPDelClick(Sender); // удаление записи
       45 :  ToolButtonVOPAddClick(Sender);    // Добавление по Ins
       13 :  ToolButtonVOPEditClick(Sender)   // Редактирование по Enter
     end;

end;



procedure TENUM_EQPTForm.VOPGridColumns0EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
//  qVIDQuery.open;
//  SelectFromTable(qVIDQuery, ComboEdit, 'SPR_VOP',
//                        'Справочник: Операции оборудования (Выбор)', 0);
//    qVOPStoredProc.Params[0].asinteger := ID;
//    qVOPStoredProc.Params[1].asinteger := OwnerID;
//
//    // проверка
//    if not (qVIDQuery.eof) and (qVIDQuery.Active) then
//      qVOPStoredProc.Params[2].asinteger  := qVIDQuery.fieldbyname('ID').asinteger;
//
//     qVOPStoredProc.ExecProc;
//
//      // конец транзакции
//     data.RMPBase.Commit;
//
//       qVOPQuery.ParamByName('ID').asinteger := ID;
//       qVOPQuery.Open;
//
//
end;

procedure TENUM_EQPTForm.EDIZComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EDIZCombo, key, Shift) = false then
    EDIZComboButtonClick(Sender);

end;

procedure TENUM_EQPTForm.EDIZComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EDIZCombo);
end;

end.
