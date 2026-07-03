{-----------------------------------------------------------------------------
 Unit Name: JROperForm
 Author:    admin
 Purpose:   Форма редактирования планового оперативного журнала заказов
    Показывает плановые операции заказов в разрезе операций, исполнителей, оборудования
 History:
-----------------------------------------------------------------------------}


unit JROperForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ToolWin, Menus, ActnList, ExtCtrls, Grids,
  DBGridEh, DB, DBTables, DateUtils, DateUtil;

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
    N1: TMenuItem;
    MenuSel: TMenuItem;
    MenuRefresh: TMenuItem;
    N2: TMenuItem;
    MenuByWidth: TMenuItem;
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
    Searchkey: TEdit;
    FindButton: TButton;
    ToolFindDown: TToolButton;
    ToolFindUp: TToolButton;
    Columns: TMenuItem;
    sd: TMenuItem;
    TabColumns: TMenuItem;
    PlanButton: TToolButton;
    ToolButton2: TToolButton;
    DelPlanButton: TToolButton;
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
    procedure MainMenuRefreshClick(Sender: TObject);
    procedure ToolButtonFilterClick(Sender: TObject);
    procedure sort_table(type_of_sort: integer);
    procedure JROperGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure ToolFindUpClick(Sender: TObject);
    procedure ToolFindDownClick(Sender: TObject);
    procedure ColumnSet(Sender: TObject);
    procedure MainMenuByWidthClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PlanButtonClick(Sender: TObject);
    procedure DelPlanButtonClick(Sender: TObject);
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
  TableName  : string;         // имя таблицы журнала
  IDDoc      : Integer;        // ID документа
  sQueryText : string;         // текст запроса формы


  // фильтры для отбора журнала
  ID_WRKR_Filter  : integer; // по исполнителям
  ID_VOP_Filter   : integer; // по наименованию операции
  ID_EQPT_Filter  : integer; // по оборудованию
  ID_ORDER_Filter : integer; // по заказу

implementation

uses ParamForm,
     OROPEditForm,              // форма редактирования операций заказа (плановые, фактические)
     OrderEditForm,
    FiltrOrderEdit,   // форма редактирования фильтра по таблице
     Main,
     JRGantForm,
     OperPlanForm,
     JROperDeleteForm,
     Libs, Base;

{$R *.dfm}

constructor TJR_OPERForm.createN(AOwner: TForm; _typeform : integer);
var i : integer;
    menuitem : tmenuitem;

begin

  inherited Create(AOwner);
  // заполнение списка периодов и выяснение текушего периода
  FillPeriodCombo(PeriodBox);


  ID_WRKR_Filter := -1;  //  фильтр отбора
  ID_VOP_Filter  := -1;  // по наименованию операции
  ID_EQPT_Filter := -1;  //  по журналу

  PeriodBox.ItemIndex := Param_Form.BoxPlanPeriod.ItemIndex;
  Period := PeriodBox.ItemIndex;

  // создание запроса для формы


  with JROperQuery do
    begin

      close;
      sql.clear;
      sql.add('select * from BROWSE_OPER_PROC(:period, :ID_WRKR_FILTER, :ID_EQPT_FILTER, :ID_VOP_Filter)');

      ParamByName('Period').asinteger := Period;         //ТЕСТИРОВАЛСЯ НА 60
      ParamByName('ID_WRKR_FILTER').asinteger  := -1;
      ParamByName('ID_VOP_Filter').Asinteger  := -1;
      ParamByName('ID_EQPT_FILTER').asinteger := -1;

      open;

    end;

  Tablename := 'jr_plan';
  caption   := 'Оперативный журнал заказов';

  HelpContext := 352;

  Period := PeriodBox.ItemIndex;

  JROperQuery.Last;


  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;
    TabColumns.Clear;

    for i := 0 to  JROperGrid.Columns.Count - 1 do
    begin
       menuitem         := TMenuItem.Create(AOwner);
       menuitem.Name    := JROperGrid.Columns[i].FieldName;
       menuitem.Caption := JROperGrid.Columns[i].Title.Caption;
       menuitem.Hint    := JROperGrid.Columns[i].Title.Caption;
       menuitem.Checked := true;
       menuitem.OnClick := ColumnSet;
       Columns.Add(menuitem);

       menuitem         := TMenuItem.Create(AOwner);
       menuitem.Caption := JROperGrid.Columns[i].Title.Caption;
       menuitem.Hint    := JROperGrid.Columns[i].Title.Caption;
       menuitem.Checked := true;
       menuitem.OnClick := ColumnSet;
       menuitem.Name    := 'M' +JROperGrid.Columns[i].FieldName;
       TabColumns.Add(menuitem);


    end;


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
  if messagedlg('Установить период просмотра на ' + periodbox.Items[PeriodBox.ItemIndex] + ' ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
     begin
       PeriodBox.ItemIndex := Period;
       abort;

     end;

  {
     если устанавливается режим просмотра закрытого периода,
     то запретим редактирование
  }
  if  (PeriodBox.ItemIndex < Param_Form.BoxFactPeriod.ItemIndex) then
        begin
           ToolButtonAdd.Enabled := false;
           ToolButtonDel.Enabled := false;
        end
   else
     begin
           ToolButtonAdd.Enabled := true;
           ToolButtonDel.Enabled := true;
     end;


  JROperQuery.close;
  JROperQuery.ParamByName('Period').asinteger := PeriodBox.ItemIndex;
  JROperQuery.open;
  Period := PeriodBox.ItemIndex;


end;

{

    Проверка, какая кнопка была нажата в форме

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
var //DocForm     : TDOC_ORDERForm;   // форма редактирования документа Заказ
//    ParentID    : integer;          // ID родительского документа Заявка
//    qTMPQuery   : tQuery;           // временный запрос для нахождения номера заявки по ID
//    ParentNumber: integer;          // номер родительского документа "Заявка"
//    OperForm    : TDOCT_OPERForm;
//    NumOrd      : integer;
    Gant        : TJR_GantForm;

begin
  
  if  JROperQuery.RecordCount = 0  then exit;

{
  // открыть форму редактирования нового документа
  IdDoc    := JROperQuery.FieldByName('ORDER_ID').asinteger;
  ParentID := JROperQuery.FieldByName('RQST_ID').asinteger;

  // формирование и выполнение запроса для нахождение номера документа-владельца
  qTMPQuery:= tQuery.Create(self);
  qTMPQuery.databasename := 'RMP';
  qTMPQuery.sql.add('select number from dh_order where id = '
        + JROperQuery.FieldByName('ORDER_ID').asstring);
  qTMPQuery.open;
  ParentNumber := qTMPQuery.Fields[0].asinteger;

  DocForm := TDOC_ORDERForm.CreateN(mainform, IdDoc, ParentID, ParentNumber, nil);
  DocForm.show;

  DocForm.Grid_OperPlan.Row := JROperQuery.FieldByName('Lineno').asinteger;

  // Создание формы редактирования операции
  OperForm := TDOCT_OPERForm.createN(DocForm, 2); // вызов формы редактирования
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

}

    Gant := TJR_GantForm.createN(self,
    JROperQuery.FieldByName('ORDER_ID').asinteger,
    PeriodBox.itemIndex{,
    JROperQuery.FieldByName('LINENO').asinteger});

end;

procedure TJR_OPERForm.JROperGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
//    45 : ToolButtonAddClick(sender); // нажата кнопка "Ins"
//    46 : ToolButtonDelClick(sender); // нажата кнопка "Del"
    13 : JROperGridDblClick(sender);  // Редактирование по Enter
   end;
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

procedure TJR_OPERForm.JROperGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  sort_table(aCol);

  JROperGrid.Columns[aCol].Title.SortMarker := smDownEh;


end;

procedure TJR_OPERForm.sort_table(type_of_sort: integer);
var strord : string;
begin

   case type_of_sort of

     0 : strord :=  'order by number';
     1 : strord :=  'order by OPER_NAME';
     2 : strord :=  'order by LINENO';
     3 : strord :=  'order by DATE_IN, TIME_IN';
     4 : strord :=  'order by DATE_IN, TIME_IN';
     5 : strord :=  'order by DATE_OUT, TIME_OUT';
     6 : strord :=  'order by DATE_OUT, TIME_OUT';
     7 : strord :=  'order by WRKR_NAME';
     8 : strord :=  'order by EQPT_NAME';
   end;

  with JROperQuery do

    begin

       close;
       sql.clear;
       sql.add('select * from BROWSE_OPER_PROC (:PERIOD, :ID_WRKR_FILTER, :ID_EQPT_FILTER, :ID_VOP_FILTER)');
       ParamByName('PERIOD').AsInteger := Period;
       ParamByName('ID_WRKR_FILTER').asinteger  := ID_WRKR_FILTER;
       ParamByName('ID_EQPT_FILTER').asinteger  := ID_EQPT_FILTER;
       ParamByName('ID_VOP_FILTER').asinteger   := ID_VOP_FILTER;
       sql.add(strord);
       open;

    end;


end;


{-----------------------------------------------------------------------------
  Процедура: TJR_OPERForm.ToolButtonFilterClick
  Автор:    Administrator
  Аргументы: Sender: TObject
  Результат:    None
  Описание:     Установка отбора просмотра операций
-----------------------------------------------------------------------------}
procedure TJR_OPERForm.ToolButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);

  FilterForm.Pr_execEdit.MaxValue := 3;
  FilterForm.PanelCHRT.Hide;
  FilterForm.PanelMain.Hide;
  FilterForm.PanelWRHS.Hide;
  FilterForm.PanelCHRT.Hide;
  FilterForm.PanelDate.Hide;
  FilterForm.PanelOperFltr.Align := alClient;;


{  FilterForm.OnOpenForm(-1, -1, -1, -1, -1, ID_WRKR_FILTER, ID_EQPT_Filter, ID_VOP_FILTER, -1);}
  FilterForm.id_wrkr := ID_WRKR_FILTER;
  FilterForm.id_eqpt := ID_EQPT_FILTER;
  FilterForm.id_vop  := ID_VOP_FILTER;



  // если установлен фильтр
  if FilterForm.showmodal = mrOK then
    begin
      // если есть отбор по исполнителям
      if (FilterForm.qWRKRQuery.active) then
        begin

          filtered := 1;
          ID_WRKR_FILTER := FilterForm.qWRKRQuery.fieldbyname('id').asinteger;

        end

       else
         ID_WRKR_FILTER := -1;

      // если есть отбор по оборудованию
      if (FilterForm.qEQPTQuery.active) then

        begin

          filtered := 1;
          ID_EQPT_FILTER := FilterForm.qEQPTQuery.fieldbyname('id').asinteger;

        end

       else
         ID_EQPT_FILTER := -1;

      // если есть отбор по операциям
      if (FilterForm.qVOPQuery.active) then

        begin

          filtered := 1;
          ID_VOP_FILTER := FilterForm.qVOPQuery.fieldbyname('id').asinteger;

        end

       else
         ID_VOP_FILTER := -1;

       // закрытие запроса

       with JROperQuery do
         begin

          close;
          sql.clear;
          sql.add('select * from BROWSE_OPER_PROC (:PERIOD, :ID_WRKR_FILTER, :ID_EQPT_FILTER, :ID_VOP_FILTER)');
          ParamByName('PERIOD').AsInteger          := Period;
          ParamByName('ID_WRKR_FILTER').asinteger  := ID_WRKR_FILTER;
          ParamByName('ID_EQPT_FILTER').asinteger  := ID_EQPT_FILTER;
          ParamByName('ID_VOP_FILTER').asinteger   := ID_VOP_FILTER;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       ID_WRKR_FILTER  := -1;
       ID_EQPT_FILTER  := -1;
       ID_VOP_FILTER   := -1;

       // обновление текста запроса
       with JROperQuery do
         begin

          close;
          sql.clear;
          sql.add('select * from BROWSE_OPER_PROC (:PERIOD, :ID_WRKR_FILTER, :ID_EQPT_FILTER, :ID_VOP_FILTER)');
          ParamByName('PERIOD').AsInteger          := Period;
          ParamByName('ID_WRKR_FILTER').asinteger  := ID_WRKR_FILTER;
          ParamByName('ID_EQPT_FILTER').asinteger  := ID_EQPT_FILTER;
          ParamByName('ID_VOP_FILTER').asinteger   := ID_VOP_FILTER;
          Open;

         end;

     end;

  FilterForm.Close;


   if filtered = 1 then
     ToolButtonFilter.Down := true
   else
     ToolButtonFilter.Down := false;




end;



procedure TJR_OPERForm.ToolFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
  if not JROperQuery.bof then JROperQuery.prior;
    find(JROperQuery, JROperGrid, Searchkey.text, -1);


end;

procedure TJR_OPERForm.ToolFindDownClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not JROperQuery.eof then JROperQuery.next;
    find(JROperQuery, JROperGrid, Searchkey.text, 1);


end;

procedure TJR_OPERForm.ColumnSet(Sender: TObject);
var item : tMenuItem;
    i : integer;
begin
  item := tMenuItem(sender);

  if Item.Checked then
    item.Checked := false
   else
     item.Checked := true;


  if item.Parent = TabColumns then
   Columns.Items[item.MenuIndex].Checked := item.Checked
   else
     TabColumns.Items[item.MenuIndex].Checked := item.Checked;

  for i := 0 to JROperGrid.FieldCount - 1 do
    begin
      if (JROperGrid.Columns[i].FieldName = item.Name)
       or ('M' + JROperGrid.Columns[i].FieldName = item.Name) then
        JROperGrid.Columns[i].Visible := item.Checked;

    end;
end;

procedure TJR_OPERForm.MainMenuByWidthClick(Sender: TObject);
begin
   if MenuByWidth.Checked then
     begin
       MenuByWidth.Checked := false;
       mainMenuByWidth.Checked := false;
     end
   else
    begin
      MenuByWidth.Checked := true;
      MainMenuByWidth.Checked := true;
    end;

    JROperGrid.AutoFitColWidths := MenuByWidth.Checked;


end;

procedure TJR_OPERForm.FormActivate(Sender: TObject);
begin
//    refreshquery(JrOperQuery);
end;

procedure TJR_OPERForm.PlanButtonClick(Sender: TObject);
Var OPForm: TOperPlan_Form;
begin
  // открыть форму редактирования нового документа
  PlanButton.Enabled:=False;
  DelPlanButton.Enabled:=False;

  OPForm := TOperPlan_Form.CreateN(self, period);

  OPForm.show;

  JROperGrid.Repaint;

  PlanButton.Enabled:=True;
  DelPlanButton.Enabled:=True;

end;

procedure TJR_OPERForm.DelPlanButtonClick(Sender: TObject);
var s : string;
    OPForm: TJR_OPERDELETEForm;
begin
{    DelPlanStoredProc.Close;
    DelPlanStoredProc.ParamByName('period').AsInteger := Period;
    s:=DateTimeToStr(EncodeDateTime(2000+(Period div 12),
      Period - (Period div 12)*12 + 1, 1, 0, 0, 0, 0));
    DelPlanStoredProc.ParamByName('DATE_BEG').AsDateTime := EncodeDateTime(2000+(Period div 12),
      Period - (Period div 12)*12 + 1, 1, 0, 0, 0, 0);
      s:=IntToStr(DaysPerMonth(2000+(Period div 12), Period - (Period div 12)*12 + 1));
    DelPlanStoredProc.ParamByName('DATE_END').AsDateTime := EncodeDateTime(2000+(Period div 12),
      Period - (Period div 12)*12 + 1,
      DaysPerMonth(2000+(Period div 12), Period - (Period div 12)*12 + 1), 0, 0, 0, 0);
    s:=DateTimeToStr(EncodeDateTime(2000+(Period div 12),
      Period - (Period div 12)*12 + 1,
      DaysPerMonth(2000+(Period div 12), Period - (Period div 12)*12 + 1), 0, 0, 0, 0));
    DelPlanStoredProc.Prepare;
    DelPlanStoredProc.ExecProc;
    JROperGrid.Refresh; }

    // открыть форму редактирования нового документа
    PlanButton.Enabled:=False;
    DelPlanButton.Enabled:=False;

    OPForm := TJR_OPERDELETEForm.CreateN(self, Nil, period, 0);

    OPForm.show;

    JROperGrid.Repaint;

    PlanButton.Enabled:=True;
    DelPlanButton.Enabled:=True;


    JROperGrid.Refresh;

end;

end.
