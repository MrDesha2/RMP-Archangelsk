unit JROperForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Menus, ActnList, ExtCtrls, Grids,
  DBGridEh, DB, DBTables;

type
  TJR_OPERForm = class(TForm)
    JROperGrid: TDBGridEh;
    PanelBot: TPanel;
    CloseButton: TButton;
    ActionList: TActionList;
    acFindNext: TAction;
    acFindPrior: TAction;
    acFind: TAction;
    TableMenu: TPopupMenu;
    MenuEdit: TMenuItem;
    MenuDel: TMenuItem;
    N1: TMenuItem;
    MenuInt: TMenuItem;
    MenuSel: TMenuItem;
    MenuInsertSub: TMenuItem;
    MenuInsertOrder: TMenuItem;
    N5: TMenuItem;
    MenuInsertWRHS: TMenuItem;
    MenuInsertWRHSOut: TMenuItem;
    MenuRefresh: TMenuItem;
    MenuStucDoc: TMenuItem;
    N2: TMenuItem;
    MenuByWidth: TMenuItem;
    MenuMultiSelect: TMenuItem;
    MainMenu: TMainMenu;
    N3: TMenuItem;
    MainMenuEdit: TMenuItem;
    MainMenuDel: TMenuItem;
    N6: TMenuItem;
    MainMenuInt: TMenuItem;
    MainMenuSel: TMenuItem;
    MainMenuRefresh: TMenuItem;
    N16: TMenuItem;
    MainMenuByWidth: TMenuItem;
    JROperQuery: TQuery;
    JROperDataSource: TDataSource;
    ToolBar: TToolBar;
    ToolButtonAdd: TToolButton;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    ToolButtonFilter: TToolButton;
    PeriodBox: TComboBox;
    ToolButton2: TToolButton;
    PlanButton: TToolButton;
    Searchkey: TEdit;
    FindButton: TButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure PeriodBoxChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FindButtonClick(Sender: TObject);
    procedure JROperGridDblClick(Sender: TObject);
    procedure JROperGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure  DocumentChange;
    procedure MainMenuRefreshClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButtonFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    DocCaption : string;           // заголовок окна
    constructor CreateN(AOwner: TForm; _typeform : integer);
    destructor Destroy; override;

  end;

var
  JR_OPERForm: TJR_OPERForm;
  Period     : integer;        // период просмотра журнала
  TableName  : string;         // им€ таблицы журнала
  IDDoc      : Integer;        // ID документа

  // фильтры дл€ отбора журнала
  ID_WRKR_Filter : integer; // по исполнител€м
  ID_VOP_Filter : integer;  // по операци€м
  ID_EQPT_Filter: integer;  // по оборудованию

implementation

uses ParamForm,
     OROPEditForm,              // форма редактировани€ операций заказа (плановые, фактические)
     OrderEditForm,
     Main,
     Libs;

{$R *.dfm}

constructor TJR_OPERForm.createN(AOwner: TForm; _typeform : integer);
begin

  inherited Create(AOwner);
  // заполнение списка периодов и вы€снение текушего периода
  FillPeriodCombo(PeriodBox);


  ID_WRKR_Filter := -1;  //  фильтр отбора
  ID_EQPT_Filter := -1;  //  по журналу
  ID_VOP_Filter:= -1;  //


  PeriodBox.ItemIndex := Param_Form.BoxPlanPeriod.ItemIndex;
  Period := PeriodBox.ItemIndex;
  // создание запроса дл€ формы


  with JROperQuery do
    begin

      close;
      sql.clear;
      sql.add('select * from BROWSE_OPER_PROC(:period, :ID_WRKR_FILTER, :ID_VOP_FILTER, :ID_EQPT_FILTER)');

      ParamByName('Period').asinteger := Period;
      ParamByName('ID_WRKR_FILTER').asinteger  := -1;
      ParamByName('ID_VOP_FILTER').asinteger := -1;
      ParamByName('ID_EQPT_FILTER').asinteger := -1;
      open;

    end;

  Tablename := 'jr_plan';
  caption   := 'ќперативный журнал заказов';

  HelpContext := 350;

  Period := PeriodBox.ItemIndex;

  JROperQuery.Last;
  // в зависимости от пожелани€ открываютс€ окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;


end;

destructor TJR_OPERForm.Destroy;
begin
  inherited;
end;

procedure TJR_OPERForm.CloseButtonClick(Sender: TObject);
begin
  JROperQuery.Close;
  Close;
end;



procedure TJR_OPERForm.PeriodBoxChange(Sender: TObject);
begin
  if messagedlg('”становить период просмотра на ' + periodbox.Items[PeriodBox.ItemIndex] + ' ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
     begin
       PeriodBox.ItemIndex := Period;
       abort;

     end;

  {
     если устанавливаетс€ режим просмотра закрытого периода,
     то запретим редактирование
  }
  if  (PeriodBox.ItemIndex < Param_Form.BoxFactPeriod.ItemIndex) then
        begin
           ToolButtonAdd.Enabled := false;
           ToolButtonDel.Enabled := false;
           planButton.Enabled:= false;
        end 
   else
     begin
           ToolButtonAdd.Enabled := true;
           ToolButtonDel.Enabled := true;
           planButton.Enabled:= true;
     end;


  JROperQuery.close;
  JROperQuery.ParamByName('Period').asinteger := PeriodBox.ItemIndex;
  JROperQuery.open;
  Period := PeriodBox.ItemIndex;


end;

{

    ѕроверка, кака€ кнопка была нажата в форме

}
procedure TJR_OPERForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
   begin
     EscPressed := True;
     abort;
     
   end;

end;

procedure TJR_OPERForm.FindButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not JROperQuery.eof then JROperQuery.next;
    find(JROperQuery, JROperGrid, Searchkey.text, 1);

end;

procedure TJR_OPERForm.JROperGridDblClick(Sender: TObject);
var DocForm     : TDOC_ORDERForm;   // форма редактировани€ документа «аказ
    ParentID    : integer; // ID родительского документа «а€вка
    qTMPQuery   : tQuery; // временный запрос дл€ нахождени€ номера за€вки по ID
    ParentNumber: integer;// номер родительского документа "«а€вка"
    OperForm    : TDOCT_OPERForm;
    NumOrd      : integer;


begin
  
  if  JROperQuery.eof then exit;


  // открыть форму редактировани€ нового документа
  IdDoc    := JROperQuery.FieldByName('ORDER_ID').asinteger;
  ParentID := JROperQuery.FieldByName('RQST_ID').asinteger;
  // формирование и выполнение запроса дл€ нахождение номера документа-владельца
  qTMPQuery:= tQuery.Create(self);
  qTMPQuery.databasename := 'RMP';
  qTMPQuery.sql.add('select number from dh_order where id = '
        + JROperQuery.FieldByName('ORDER_ID').asstring);
  qTMPQuery.open;
  ParentNumber := qTMPQuery.Fields[0].asinteger;

  DocForm := TDOC_ORDERForm.CreateN(mainform, IdDoc, ParentID, ParentNumber, nil);
  DocForm.show;

  DocForm.Grid_OperPlan.Row := JROperQuery.FieldByName('Lineno').asinteger;

  // —оздание формы редактировани€ операции
  OperForm := TDOCT_OPERForm.createN(DocForm, 2); // вызов формы редактировани€
                                                  // операции заказа
  if OperForm.showmodal = mrOK then
    begin
     DocForm.SaveDoc;
     NumOrd := JROperQuery.FieldByName('Number').asinteger;
     JROperQuery.Close;
     JROperQuery.open;
     JROperQuery.locate('Number',  NumOrd, [loCaseInsensitive]);
    end;

  OperForm.Close;
  DocForm.close;

  // fill_table(self);


end;

{
  ѕроцедура показа изменений в форме
}
procedure  TJR_OPERForm.DocumentChange;
begin

 WasAnyChanges := true;
 caption := DocCaption + ' *';

end;


procedure TJR_OPERForm.JROperGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
{  case Key of
    45 : ToolButtonAddClick(sender); // нажата кнопка "Ins"
    46 : ToolButtonDelClick(sender); // нажата кнопка "Del"
    13 : ToolButtonEditClick(sender);  // –едактирование по Enter
   end; }
end;

procedure TJR_OPERForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TJR_OPERForm.MainMenuRefreshClick(Sender: TObject);
var NumOrd : integer;
begin
     NumOrd := JROperQuery.FieldByName('Number').asinteger;
     JROperQuery.Close;
     JROperQuery.open;
     JROperQuery.locate('Number',  NumOrd, [loCaseInsensitive]);
end;

procedure TJR_OPERForm.ToolButton2Click(Sender: TObject);
begin

end;

{-----------------------------------------------------------------------------
  ѕроцедура: TJR_OPERForm.ToolButtonFilterClick
  јвтор:    Administrator
  јргументы: Sender: TObject
  –езультат:    None
  ќписание:     ”становка отбора просмотра операций
-----------------------------------------------------------------------------}
procedure TJR_OPERForm.ToolButtonFilterClick(Sender: TObject);
begin
  //
end;

end.
