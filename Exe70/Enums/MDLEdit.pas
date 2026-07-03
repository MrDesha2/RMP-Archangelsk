{

            Модуль  MDLEdit
   Модуль формы редактирования элементов справочника "Модели".
   Модуль вызывается для редактирования из модуля EnumEdit.

}
unit MDLEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DB, DBTables, ExtCtrls, RXSpin, CurrEdit, Mask, ToolEdit,
  ComCtrls, Grids, DBGridEh, ToolWin;

type
  TENUM_MLDForm = class(TForm)
    PanelBot: TPanel;
    OKButton: TButton;
    Close_button: TButton;
    Panel1: TPanel;
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    qCHRTQuery: TQuery;
    Label6: TLabel;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    CodeEdit: TEdit;
    NameEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    CHRTCombo: TComboEdit;
    Label4: TLabel;
    Label5: TLabel;
    DRAWBACK_COUNT: TCurrencyEdit;
    ModelKind: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    COREBOX_COUNT: TCurrencyEdit;
    INCREASE_COUNT: TCurrencyEdit;
    Label9: TLabel;
    PATTERN_COUNT: TCurrencyEdit;
    Label10: TLabel;
    COMPLEXITYFORMING: TRxSpinEdit;
    COMPLEXITYMODEL: TRxSpinEdit;
    Label11: TLabel;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    ToolBarCh: TToolBar;
    ToolAddChar: TToolButton;
    ToolEditChar: TToolButton;
    ToolDelChar: TToolButton;
    CHEQGrid: TDBGridEh;
    ToolBar1: TToolBar;
    ToolAddBox: TToolButton;
    ToolEditBox: TToolButton;
    ToolDelBox: TToolButton;
    DBGridBox: TDBGridEh;
    ToolBar2: TToolBar;
    ToolAddInc: TToolButton;
    ToolEditInc: TToolButton;
    ToolDelInc: TToolButton;
    ChainGrid: TDBGridEh;
    ToolBar3: TToolBar;
    ToolAddDup: TToolButton;
    ToolEditDup: TToolButton;
    ToolDelDup: TToolButton;
    DBGridEhDubs: TDBGridEh;
    qCHMODELQuery: TQuery;
    DataSourceModel: TDataSource;
    qBoxQuery: TQuery;
    DataSourceBox: TDataSource;
    qINCQuery: TQuery;
    DataSourceInc: TDataSource;
    qDubQuery: TQuery;
    DataSourceDub: TDataSource;
    MODELCombo: TComboEdit;
    qModelQuery: TQuery;
    qMODELTableQuery: TQuery;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    ShelfEdit: TCurrencyEdit;
    Label13: TLabel;
    DeskEdit: TCurrencyEdit;
    Label14: TLabel;
    INFO: TEdit;
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure Close_buttonClick(Sender: TObject);
    procedure ToolAddCharClick(Sender: TObject);
    procedure ToolEditCharClick(Sender: TObject);
    procedure ToolDelCharClick(Sender: TObject);
    procedure CHRTComboButtonClick(Sender: TObject);
    procedure CHRTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolAddBoxClick(Sender: TObject);
    procedure ToolDelBoxClick(Sender: TObject);
    procedure ToolEditBoxClick(Sender: TObject);
    procedure ToolAddIncClick(Sender: TObject);
    procedure ToolDelIncClick(Sender: TObject);
    procedure ToolEditIncClick(Sender: TObject);
    procedure ToolAddDupClick(Sender: TObject);
    procedure ToolEditDupClick(Sender: TObject);
    procedure ToolDelDupClick(Sender: TObject);
    procedure DBGridEhDubsEditButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_MLDForm: TENUM_MLDForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;
  EnumEdit : TForm;
  newrecord: boolean;

implementation

uses Main, Base, libs,
  CHAREdit, ENUMModelbox, ENUMModelINC, CHAINEdit;

{$R *.DFM}
//
//       Процедура при открытии формы
//
procedure TENUM_MLDForm.FormShow(Sender: TObject);
begin

  ParentID := MainForm.ParentID;

  fill_enumeration(ModelKind, 'MODEL_TYPE');
  id := -1;

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin

       Codeedit.text := 'Новый';

       NameEdit.text  := 'Новый элемент';
       Caption     := 'Новый элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_mdl');
       qQueryupdate.SQL.add('(ID, parentid, isfolder, code, name, ID_CHRT,');
       qQueryupdate.SQL.add('MODEL_KIND, DRAWBACK_COUNT, COREBOX_COUNT, INCREASE_COUNT,');
       qQueryupdate.SQL.add('PATTERN_COUNT, COMPLEXITYFORMING, COMPLEXITYMODEL,');
       qQueryupdate.SQL.add('INFO, SHELVES, DESK)');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_MDL_GEN,1), :parentID, 0, :code, :name, :ID_CHRT,');
       qQueryUpdate.sql.add(':MODEL_KIND, :DRAWBACK_COUNT, :COREBOX_COUNT,');
       qQueryUpdate.sql.add(':INCREASE_COUNT, :PATTERN_COUNT, :COMPLEXITYFORMING, :COMPLEXITYMODEL,');
       qQueryUpdate.sql.add(':INFO, :SHELVES, :DESK)');

       EditType := 0;
       CHRTCombo.ID := -1;
       newrecord := true;
       ModelKind.ItemIndex := 0;

    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin
       CodeEdit.Text   := '';
       NameEdit.text  := 'Новая группа';
       Caption     := 'Справочник "Модели": Новая группа';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_mdl');
       qQueryupdate.SQL.add('(ID, parentid, isfolder, code, name, ID_CHRT,');
       qQueryupdate.SQL.add('MODEL_KIND, DRAWBACK_COUNT, COREBOX_COUNT, INCREASE_COUNT, PATTERN_COUNT, COMPLEXITYFORMING, COMPLEXITYMODEL)');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_MDL_GEN,1), :parentid, 1, :code, :name, :ID_CHRT,');
       qQueryupdate.SQL.add('MODEL_KIND, DRAWBACK_COUNT, COREBOX_COUNT, INCREASE_COUNT,');
       qQueryupdate.SQL.add('PATTERN_COUNT, COMPLEXITYFORMING, COMPLEXITYMODEL,');
       qQueryupdate.SQL.add('INFO, SHELVES, DESK)');
       EditType := 0;
       ModelKind.ItemIndex := 0;

       CHRTCombo.ID := -1;
       newrecord := true;

     end
  else {редактирование элемента}
    if mainForm.isFolder = 3 then
     begin
        // проверка на разрешение редактирования
        OkButton.Enabled := check_user_grand('SPR_MDL', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_mdl');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;

       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('  UPDATE SPR_MDL');
       qQueryupdate.SQL.add('SET PARENTID = :PARENTID, CODE = :CODE, NAME = :NAME, ID_CHRT = :ID_CHRT,');
       qQueryupdate.SQL.add('MODEL_KIND = :MODEL_KIND, DRAWBACK_COUNT = :DRAWBACK_COUNT, COREBOX_COUNT = :COREBOX_COUNT,');
       qQueryupdate.SQL.add('INCREASE_COUNT = :INCREASE_COUNT, PATTERN_COUNT = :PATTERN_COUNT, COMPLEXITYFORMING = :COMPLEXITYFORMING, ');
       qQueryupdate.SQL.add('COMPLEXITYMODEL = :COMPLEXITYMODEL,');
       qQueryupdate.SQL.add('INFO = :INFO, SHELVES = :SHELVES, DESK = :DESK');
       qQueryupdate.SQL.add('WHERE (ID = :ID)');

       // заполнение информации по полям
       codeEdit.Text   := qQuery.fieldByName('Code').AsString;    //  Код
       nameedit.text   := qQuery.fieldByName('Name').AsString;    //  Наименование
       Id              := qQuery.fieldByName('ID').AsInteger;      // идентификатор
       CHRTCombo.ID    := qQuery.fieldByName('ID_CHRT').AsInteger;      // идентификатор чертежа
       ModelKind.ItemIndex := qQuery.fieldByName('MODEL_KIND').AsInteger;
       DRAWBACK_COUNT.Value:= qQuery.fieldByName('DRAWBACK_COUNT').AsFloat;
       COREBOX_COUNT.Value := qQuery.fieldByName('COREBOX_COUNT').AsFloat;
       INCREASE_COUNT.Value:= qQuery.fieldByName('INCREASE_COUNT').AsFloat;
       PATTERN_COUNT.Value := qQuery.fieldByName('PATTERN_COUNT').AsFloat;
       COMPLEXITYFORMING.Value := qQuery.fieldByName('COMPLEXITYFORMING').AsInteger;
       COMPLEXITYMODEL.Value   := qQuery.fieldByName('COMPLEXITYMODEL').AsInteger;
       Info.Text           := qQuery.fieldByName('INFO').AsString;
       ShelfEdit.Text      := qQuery.fieldByName('SHELVES').AsString;
       DeskEdit.Text       := qQuery.fieldByName('DESK').AsString;

       EditType := 1;   //режим редактирования - редактирование

       Caption := 'Элемент: ' + nameedit.text;
       newrecord := false;

     end;

   PageControl.ActivePageIndex := 0;
   qCHMODELQuery.ParamByName('id').asinteger := id;
   qCHMODELQuery.Open;

   qBOXQuery.ParamByName('id').asinteger := id;
   qBOXQuery.Open;

   qINCQuery.ParamByName('id').asinteger := id;
   qINCQuery.Open;

   qDubQuery.ParamByName('id').asinteger := id;
   qDubQuery.Open;

end;

procedure TENUM_MLDForm.OKButtonClick(Sender: TObject);
begin

 try

  if EditType = 0 then // это добавление записи
  else
      qQueryupdate.ParamByName('ID').asinteger       := ID;

      qQueryupdate.ParamByName('Code').value    := CodeEdit.text;
      qQueryupdate.ParamByName('Name').value    := NameEdit.Text;
      qQueryupdate.ParamByName('Parentid').asinteger := Parentid;


      // выполнение запроса

    if (ChechUniqueCode('spr_mdl', 'code', trim(CodeEdit.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;

      SetParamCombo(qQueryupdate.ParamByName('ID_CHRT'), CHRTCombo);
      qQueryupdate.ParamByName('MODEL_KIND').value       := ModelKind.ItemIndex;
      qQueryupdate.ParamByName('DRAWBACK_COUNT').value   := DRAWBACK_COUNT.Value;
      qQueryupdate.ParamByName('COREBOX_COUNT').value    := COREBOX_COUNT.Value;
      qQueryupdate.ParamByName('INCREASE_COUNT').value   := INCREASE_COUNT.Value;
      qQueryupdate.ParamByName('PATTERN_COUNT').value    := PATTERN_COUNT.Value;
      qQueryupdate.ParamByName('COMPLEXITYFORMING').value:= COMPLEXITYFORMING.Value;
      qQueryupdate.ParamByName('COMPLEXITYMODEL').value  := COMPLEXITYMODEL.Value;
      qQueryupdate.ParamByName('INFO').asstring  := INFO.Text;
      qQueryupdate.ParamByName('SHELVES').value  := ShelfEdit.Value;
      qQueryupdate.ParamByName('DESK').value     := DeskEdit.Value;


    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;

  MainForm.ID := findIDbyCode('spr_mdl', trim(codeEdit.text));

  except
    MessageDlg('Ошибка при сохранении данных.', mtWarning, [mbOK], 0);
    data.RMPBase.Rollback;
  end;


  qquery.close;
  ModalResult := mrOK;



end;

procedure TENUM_MLDForm.Close_buttonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TENUM_MLDForm.ToolAddCharClick(Sender: TObject);
var EditCHAR: tform;
begin
  // Добавление характеристики возможно только для сохраненных элементов
  if ID < 0 then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;

  EditCHAR := TENUM_CHEQForm.CreateN(Application, 0, ID, 'spr_modelcharacter', 'GEN_SPR_MODELCHARACTER_ID', 1, 2);
  EditChar.Caption := 'Добавление характеристики модели';
  if EditCHAR.showmodal = mrOK then
     if not newrecord then

         refreshquery( qCHMODELQuery)
     else
      begin

         qCHMODELQuery.close;
         qCHMODELQuery.ParamByName('id').asinteger := ID;
         qCHMODELQuery.open;

      end;


end;


procedure TENUM_MLDForm.ToolEditCharClick(Sender: TObject);
var EditCHAR: tform;
    _id : integer;
begin
  // Если справочник характеристик не пустой, то можно редактировать
  if qCHMODELQuery.eof then
     exit;
  // Нахождение ID элемента справочника
  _id := qCHMODELQuery.FieldByName('ID').asinteger;
  EditCHAR := TENUM_CHEQForm.CreateN(Application, _Id, ID, 'spr_modelcharacter', 'GEN_SPR_MODELCHARACTER_ID', 2, 2);
  if EditCHAR.showmodal = mrOK then
         refreshquery( qCHMODELQuery);


end;


procedure TENUM_MLDForm.ToolDelCharClick(Sender: TObject);
begin
  // Проверка: есть ли что удалять
  if qCHMODELQuery.eof then
    exit;

 if messagedlg('Удалить запись ' + qCHMODELQuery.FieldByName('Name').asstring + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

  with data.qDELQuery do
    begin

     close;
     sql.clear;
     sql.add('delete from spr_modelcharacter where id = ' + qCHMODELQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

    end;

   refreshquery( qCHMODELQuery);

end;

procedure TENUM_MLDForm.CHRTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(CHRTCombo);

end;

procedure TENUM_MLDForm.CHRTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( CHRTCombo, key, Shift) = false then
    CHRTComboButtonClick(Sender);

end;

procedure TENUM_MLDForm.ToolAddBoxClick(Sender: TObject);
var EditCHAR: tform;
begin
  // Добавление характеристики возможно только для сохраненных элементов
  if ID < 0 then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;

  EditCHAR := TENUM_MODELBOX.CreateN(Application, 0, ID, 'SPR_MODELBOXES', 'GEN_SPR_MODELBOXES_ID', 1);
  EditChar.Caption := 'Добавление ящика модели';
  if EditCHAR.showmodal = mrOK then
     if not newrecord then

         refreshquery( qBOXQuery)
     else
      begin

         qBOXQuery.close;
         qBOXQuery.ParamByName('id').asinteger := ID;
         qBOXQuery.open;

      end;

end;

procedure TENUM_MLDForm.ToolDelBoxClick(Sender: TObject);
begin
  // Проверка: есть ли что удалять
  if qBOXQuery.eof then
    exit;

 if messagedlg('Удалить запись?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

  with data.qDELQuery do
    begin

     close;
     sql.clear;
     sql.add('delete from spr_modelboxes where id = ' + qBOXQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

    end;

   refreshquery( qBOXQuery);


end;

procedure TENUM_MLDForm.ToolEditBoxClick(Sender: TObject);
var _id : integer;
   EditCHAR: tform;


begin
  // Если справочник характеристик не пустой, то можно редактировать
  if qBOXQuery.eof then
     exit;

  _id := qBOXQuery.FieldByName('ID').asinteger;
  EditCHAR := TENUM_MODELBOX.CreateN(Application, _id, ID, 'SPR_MODELBOXES', 'GEN_SPR_MODELBOXES_ID', 2);
  EditChar.Caption := 'Редактирование ящика модели';
  if EditCHAR.showmodal = mrOK then
     if not newrecord then

         refreshquery( qBOXQuery)
     else
      begin

         qBOXQuery.close;
         qBOXQuery.ParamByName('id').asinteger := ID;
         qBOXQuery.open;

      end;

end;

procedure TENUM_MLDForm.ToolAddIncClick(Sender: TObject);
var EditCHAR: tform;
begin
  // Добавление характеристики возможно только для сохраненных элементов
  if ID < 0 then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;

  EditCHAR := TENUM_MODELINCEdit.CreateN(Application, 0, ID, 'SPR_MODELINCRIMENT', 'GEN_SPR_MODELINCRIMENT_ID', 1);
  EditChar.Caption := 'Добавление прибыли модели';
  if EditCHAR.showmodal = mrOK then
     if not newrecord then

         refreshquery( qINCQuery)
     else
      begin

         qINCQuery.close;
         qINCQuery.ParamByName('id').asinteger := ID;
         qINCQuery.open;

      end;



end;

procedure TENUM_MLDForm.ToolDelIncClick(Sender: TObject);
begin
  // Проверка: есть ли что удалять
  if qINCQuery.eof then
    exit;

 if messagedlg('Удалить запись?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

  with data.qDELQuery do
    begin

     close;
     sql.clear;
     sql.add('delete from SPR_MODELINCRIMENT where id = ' + qINCQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

    end;

   refreshquery( qINCQuery);


end;

procedure TENUM_MLDForm.ToolEditIncClick(Sender: TObject);
var _id : integer;
   EditCHAR: tform;


begin
  // Если справочник характеристик не пустой, то можно редактировать
  if qINCQuery.eof then
     exit;

  _id := qINCQuery.FieldByName('ID').asinteger;
  EditCHAR := TENUM_MODELINCEdit.CreateN(Application, _id, ID, 'SPR_MODELINCRIMENT', 'GEN_SPR_MODELINCRIMENT_ID', 2);
  EditChar.Caption := 'Редактирование прибыли модели';

  if EditCHAR.showmodal = mrOK then
     if not newrecord then

         refreshquery( qINCQuery)
     else
      begin

         qINCQuery.close;
         qINCQuery.ParamByName('id').asinteger := ID;
         qINCQuery.open;

      end;



end;

procedure TENUM_MLDForm.ToolAddDupClick(Sender: TObject);
begin
  MODELCombo.ID := -1;
  SelectFromTable(MODELCombo);

  if MODELCombo.ID > 0 then
    begin
       with qMODELTableQuery do
         begin
          // проверка на повтор
          sql.Clear;
          sql.Add('select * from SPR_MODELDUPLICATE ');
          sql.Add('where id_model = :id_model and ID_MODELDUPLICATE = :ID_MODELDUPLICATE');
          params[0].AsInteger := ID;
          params[1].AsInteger := ModelCombo.ID;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;


          sql.Clear;
          sql.Add('insert into SPR_MODELDUPLICATE ');
          sql.Add('values (GEN_ID(GEN_SPR_MODELDUPLICATE_ID,1), :id, :id_model)');
          params[0].AsInteger := id;
          params[1].AsInteger := Modelcombo.ID;
          ExecSQL;
         end;

       if not newrecord then

         refreshquery( qDubQuery)
        else
         begin

           qDubQuery.close;
           qDubQuery.ParamByName('id').asinteger := ID;
           qDubQuery.open;

         end;
    end;




end;

procedure TENUM_MLDForm.ToolEditDupClick(Sender: TObject);
begin
  MODELCombo.ID := qDubQuery.Fieldbyname('id_model').asinteger;
  SelectFromTable(MODELCombo);

  if MODELCombo.ID > 0 then
    begin
       with qMODELTableQuery do
         begin
          sql.Clear;
          sql.Add('select * from SPR_MODELDUPLICATE ');
          sql.Add('where id_model = :id_model and ID_MODELDUPLICATE = :ID_MODELDUPLICATE and id <> :id');
          params[0].AsInteger := id;
          params[1].AsInteger := ModelCombo.ID;
          params[2].AsInteger := qDubQuery.fieldbyname('id').asinteger;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;

          sql.Clear;
          sql.Add('update SPR_MODELDUPLICATE ');
          sql.Add('set ID_MODELDUPLICATE = :ID_MODELDUPLICATE');
          sql.Add('where id = :id');
          params[1].AsInteger := qDubQuery.fieldbyname('id').asinteger;
          params[0].AsInteger := Modelcombo.ID;
          ExecSQL;
         end;

       if not newrecord then

         refreshquery( qDubQuery)
        else
         begin

           qDubQuery.close;
           qDubQuery.ParamByName('id').asinteger := ID;
           qDubQuery.open;

         end;
    end;


end;

procedure TENUM_MLDForm.ToolDelDupClick(Sender: TObject);
begin
  // удаление элементов справочника возможно только в непустом справочнике
  if qDubQuery.eof then
     exit;

 if messagedlg('Удалить запись?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  with data.qDELQuery do
   begin
      close;
      sql.clear;
      sql.add('delete from SPR_MODELDUPLICATE where id = ' + qDubQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

   end;

   refreshquery( qDubQuery);

end;

procedure TENUM_MLDForm.DBGridEhDubsEditButtonClick(Sender: TObject);
begin
  MessageDlg('tdfhgjj', mtWarning, [mbOK], 0);
end;

end.
