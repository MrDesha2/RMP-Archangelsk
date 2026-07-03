{
        Модуль  EnumTreeForm
   Описание.
     Форма редактирования любого многоуровневого справочника с деревом.
   Форма вызывается из всех форме, где требуется работа с многоуровневыми
   справочниками.


}

unit EnumTreeForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Grids, DBGrids, ImgList, ToolWin, StdCtrls, Db,
  DBTables, Menus, TranceForm, DBGridEh, ActnList;

const
  scExpand = scCtrl  + VK_DOWN;
  scUp     = scCtrl  + VK_UP;


type
  TLIST_TREEEDITForm = class(TForm)
    FormSource: TDataSource;
    qFormQuery: TQuery;
    FormGrid: TDBGridEh;
    TopPanel: TPanel;
    BotPanel: TPanel;
    CenterPanel: TPanel;
    Splitter1: TSplitter;
    EnumTreeView: TTreeView;
    EnumToolBar: TToolBar;
    NewButtom: TToolButton;
    NewGroupButton: TToolButton;
    EditButton: TToolButton;
    DeleteButton: TToolButton;
    TranceButton: TToolButton;
    IsTreeButton: TToolButton;
    HelpButton: TToolButton;
    CloseButton: TButton;
    qTreeQuery: TQuery;
    TablePopupMenu: TPopupMenu;
    MenuDel: TMenuItem;
    Searchkey: TEdit;
    FindButton: TButton;
    MenuSub: TMenuItem;
    MenuSortCode: TMenuItem;
    MenuSortName: TMenuItem;
    MenuSortID: TMenuItem;
    MenuNew: TMenuItem;
    MenuEdit: TMenuItem;
    MenuSep: TMenuItem;
    MenuNewGroup: TMenuItem;
    SearchDownButton: TToolButton;
    SearchUpButton: TToolButton;
    MenuIsGroup: TMenuItem;
    CodeSearchKey: TEdit;
    ActionList: TActionList;
    acFindNext: TAction;
    acFindPrior: TAction;
    acFind: TAction;
    MainMenu: TMainMenu;
    N3: TMenuItem;
    MainMenuAdd: TMenuItem;
    MainMenuAddGroup: TMenuItem;
    MainMenuEdit: TMenuItem;
    MainMenuSep: TMenuItem;
    MainMenuSort: TMenuItem;
    MainMenuSort1: TMenuItem;
    MainMenuSort2: TMenuItem;
    MainMenuSort3: TMenuItem;
    MainMenuIsGroup: TMenuItem;
    MainmenuIsTree: TMenuItem;
    MainMenuTranceEl: TMenuItem;
    MainMenuDel: TMenuItem;
    MenuRef: TMenuItem;
    MainMenuRef: TMenuItem;
    IsTreeButtonMenu: TMenuItem;
    qParentQuery: TQuery;
    ToolButtonFilter: TToolButton;
//    procedure N6Click(Sender: TObject);
    procedure FormGridCellClick(Column: TColumnEh);
    procedure FormGridColEnter(Sender: TObject);
    procedure FormGridDrawColumnCell(Sender: TObject; const _Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormGridKeyPress(Sender: TObject; var Key: Char);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    Procedure ExpandLevel( Node : TTreeNode);
    procedure EnumTreeViewExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    Procedure RebuildTreeCompanies;
    procedure qFormQueryAfterPost(DataSet: TDataSet);
    procedure NewButtomClick(Sender: TObject);
    procedure NewGroupButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure TranceButtonClick(Sender: TObject);
    procedure IsTreeButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EnumTreeGridDblClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure MenuSortCodeClick(Sender: TObject);
    procedure MenuSortNameClick(Sender: TObject);
    procedure MenuSortIDClick(Sender: TObject);
    procedure SearchDownButtonClick(Sender: TObject);
    procedure SearchUpButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure MenuIsGroupClick(Sender: TObject);
    function  FindAnyChildren: boolean;
    procedure FormGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EnumTreeViewDblClick(Sender: TObject);
    procedure EnumTreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure EnumTreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CodeSearchKeyKeyPress(Sender: TObject; var Key: Char);
    procedure EnumTreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MainmenuIsTreeClick(Sender: TObject);
    procedure MenuRefClick(Sender: TObject);
    procedure FormGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure IsTreeButtonMenuClick(Sender: TObject);
    procedure ToolButtonFilterClick(Sender: TObject);

  private
    procedure sortQuery(var Query: tquery; sTextQuery: string;
      ID: integer);

    { Private declarations }
  public
    ElementForm  : tFormClass; // Форма для редактирования элемента
    TableName:     string;     // имя таблицы в запросе
    FormName:      string;     // имя формы
    sFormQuery:    string;     // строка формирования запроса по таблице
    sFormQueryFull:string;     // тоже самое для всей таблицы (без дерева)
    ID:            integer;
    constructor CreateN(AOwner: TComponent; _FormName: string; _TableName: string;
                        tFormType: TFormClass);
    destructor  Destroy; override;
  end;

var
  LIST_TREEEDITForm: TLIST_TREEEDITForm;
    STR_Search: string;         // строка поиска
    searching : boolean;        // признак поиска по первым буквам

  // фильтры для отбора журнала
  ID_CHRT_FILTER : integer; // по чертежу
  ID_OPER_FILTER : integer; // по операциям
  ID_NMNT_FILTER : integer; // по пноменклатуре
  EnumOperNorm   : integer; // Наличие ненормированных операций

implementation

uses Main,
     FiltrEnumEdit,   // форма редактирования фильтра по таблице
     Libs, Base, ParamForm;

{$R *.DFM}

///             Процедуры работы с деревом
///
{
 Процедура:
   Разворачивает узел дерева
   Вход: узел дерева, который необходимо развернуть
}
Procedure tLIST_TREEEDITForm.ExpandLevel( Node : TTreeNode);
Var i   : Integer;
    TreeNode : TTreeNode;
    Ncount : Integer; //количество записей в базе
Begin

    // Для самого верхнего уровня выбрать только тех,
    // кто не имеет родителей.
    IF Node = nil Then
     begin
       ID:=0;
       Node := EnumTreeView.Items.Add(nil, FormName) // в качестве верщины записывается имя справочника
     end
    Else ID:=Integer(Node.Data);

    qTreeQuery.Close;
    qTreeQuery.ParamByName('ParentID').AsInteger:=ID;
    qTreeQuery.Open;

    EnumTreeView.Items.BeginUpdate;

    // Для каждой строки из полученного набора данных
    // формируем ветвь в TreeView, как дочерние ветки к той,
    // которую мы только что "раскрыли"
    NCount := qTreeQuery.RecordCount;
    For i:=1 To NCount Do
    Begin
       // в дерево записываются только узлы справочника
       if qTreeQuery.FieldByName('IsFolder').asinteger = 1 then
         begin
          // Запишем в поле Data ветки ее идентификационный номер(ID) в таблице
          TreeNode:=EnumTreeView.Items.AddChildObject(Node ,
                                  qTreeQuery.FieldByName('Name').AsString ,
                                  Pointer(qTreeQuery.FieldByName('ID').AsInteger));

           TreeNode.ImageIndex   :=3;
           TreeNode.SelectedIndex:=4;

           // Добавим фиктивную (пустую) дочернюю ветвь только для того,
           // чтобы был отрисован [+] на ветке и ее можно было бы раскрыть
           EnumTreeView.Items.AddChildObject(TreeNode , '' , nil);

         end;
         qTreeQuery.Next;
    End;

    EnumTreeView.Items.EndUpdate;

End;


//----------------------------------------------------------------------------------------
// Полная перестройка дерева
//----------------------------------------------------------------------------------------
Procedure TLIST_TREEEDITForm.RebuildTreeCompanies;
Begin

    EnumTreeView.Items.Clear;

    // Принудительное раскрытие самого верхнего уровня
    ExpandLevel(nil);
    EnumTreeView.Selected:=EnumTreeView.Items[0];
End;
{
  Процедура
    Вызов при изменении дерева списка
  Описание: формирует запрос для таблицы.
}
procedure TLIST_TREEEDITForm.EnumTreeViewDblClick(Sender: TObject);
begin
     IF TTreeView(Sender).Selected <> nil Then
   Begin
       // ID родительской ветки , для нее и ищем все дочерние
       ID:=Integer(TTreeView(Sender).Selected.Data);

       qFormQuery.Close;
       qFormQuery.ParamByName('ParentID').AsInteger:=ID;
       qFormQuery.Open;

   End;
end;

{

    Процеруда открытия ветки дерева по Enter

}
procedure TLIST_TREEEDITForm.EnumTreeViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if key = 13 then

    EnumTreeViewDblClick(sender);

end;



{
 Процедура
  Вызов при раскрытии дерева списка.
}
procedure TLIST_TREEEDITForm.EnumTreeViewExpanding(Sender: TObject;
  Node: TTreeNode; var AllowExpansion: Boolean);
begin
  IF Node = nil Then Exit;

  // Если первая дочерняя ветвь той, которую мы хотим раскрыть, пустая
  // значит это фиктивная ветвь, дерево еще не достраивалось по этой ветви.
  // Удаляем фиктивную ветвь и "разворачиваем" дерево вглубь той ветки,
  // на которой стоим
  IF Node.getFirstChild.Data = nil
  Then Begin
          Node.DeleteChildren;
          ExpandLevel(Node);
       End;

end;


{
 Процедура - конструктор формы редактирования списка справочника
 Вход: владелец окна;
       имя формы;
       запрос для формирования формы;
       имя таблицы;
       тип открытия формы: 1 - редактирование, 0 - для выбора
       tFormType - класс формы для редактирования элемента справочника
       IDREc : ID записи в случае выбора.
}
constructor TLIST_TREEEDITForm.CreateN(AOwner: TComponent; _FormName: string;
     _TableName: string; tFormType: TFormClass);
begin

  ID_CHRT_FILTER := -1;
  ID_OPER_FILTER := -1;
  ID_NMNT_FILTER := -1;
  EnumOperNorm   := 0;

  inherited Create(AOwner);

  // проверка на возможность редактирования
  if not check_user_grand(_TableName, 'S', true) then
    abort;


  TableName   := _TableName;

  //Филтр в справочнике работает только при открытии чертежей
  If (TableName = 'SPR_CHRT') Then
     ToolButtonFilter.Enabled := True
   else
        ToolButtonFilter.Enabled := False;
        
  ElementForm := tFormType;     //запомним класс формы редактирования элемента

  qFormQuery.SQL.clear;
  sFormQuery := 'select id, parentid, isfolder, code, name from ' +
                                _tablename + ' where ParentID =:ParentID ';

  sFormQueryFull := 'select id, parentid, isfolder, code, name from ' + tablename;


  qFormQuery.sql.add(sFormQuery);
  qFormQuery.sql.add(' order by code');

  MenuSortCode.Checked := true;

  // привязывание источника к запросу
  qTreeQuery.SQL.clear;
  qTreeQuery.sql.add('select id, parentid, name, isfolder from ' + _tablename);
  qTreeQuery.sql.add('where ParentID =:ParentID');

  qParentQuery.SQL.Clear;
  qParentQuery.sql.add('select parentid from ' + _tablename);
  qParentQuery.sql.add('where ID = :ID');


  // установка свойств формы:
  caption  := _FormName;                  // заголовок
  FormName := _FormName;                  // имя


  qFormQuery.ParamByName('parentid').asinteger := 0;
  qFormQuery.Open;

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

end;

destructor TLIST_TREEEDITForm.Destroy;
begin
  inherited;
end;

procedure TLIST_TREEEDITForm.CloseButtonClick(Sender: TObject);
begin
  Close;
end;
{
  Процедура при открытии формы
}
procedure TLIST_TREEEDITForm.FormShow(Sender: TObject);
begin
  RebuildTreeCompanies;    {Перестройка дерева списка}
end;



procedure TLIST_TREEEDITForm.qFormQueryAfterPost(DataSet: TDataSet);
begin
  refreshquery( qFormQuery);
  RebuildTreeCompanies;
end;
{
// Выполнение транзакций через кнопочки

  Общая процедура вызова формы редактирования элемента.
  Вход:
      IsFolder - признак редактирования: 1 - ввод элемента, 2 - ввод группы, 3 - редактирование;
      ID - идентификатор записи;
      ParentID - идентификатор родителя;
      sender - владелец окна;
      Query  - запрос открытия формы.

}
procedure new(IsFolder : integer; ID: integer; ParentID: integer;
        sender: TLIST_TREEEDITForm; Query : tquery);
var

  FormEdit: TForm;

begin

  mainform.IsFolder := isfolder;       //  передача параметров формы
  mainform.ID       := ID;             //  редактирования элемента
  mainform.ParentID := ParentID;       //

  if sender.ElementForm <> nil then
    begin
      application.createform(sender.ElementForm, FormEdit);

      if FormEdit.showmodal = mrOK then
       begin

         refreshquery( Query);

       end;
    end;

end;

{
  Процедура добавления элемента справочника
}
procedure TLIST_TREEEDITForm.NewButtomClick(Sender: TObject);
var
  ParentID: integer;
begin
  if not check_user_grand(TableName, 'I', true) then
    exit;


  if not qFormQuery.Active then exit;

  ID := qFormQuery.FieldByName('ID').AsInteger;
  ParentID := Integer(EnumTreeView.Selected.Data);
  new(1, ID, ParentID, self, qFormQuery);  {Добавление элемента}

  // позиционируемся на введенную запись
  qFormQuery.Locate('ID', MainForm.ID, [loCaseInsensitive]);

end;

{
 Процедура добавления узлового элемента в справочник
}
procedure TLIST_TREEEDITForm.NewGroupButtonClick(Sender: TObject);
var
  ID, ParentID: integer;
begin
  if not check_user_grand(TableName, 'I', true) then
    exit;


  if not qFormQuery.Active then exit;

   ID := qFormQuery.FieldByName('ID').AsInteger;
   ParentID := Integer(EnumTreeView.Selected.Data);
   new(2, ID, ParentID, self, qFormQuery);   {Добавление группы}

   // позиционируемся на введенную запись
   qFormQuery.Locate('ID', MainForm.ID, [loCaseInsensitive]);
   RebuildTreeCompanies;

end;

{
 Процедура редактирования элемента справочника
}
procedure TLIST_TREEEDITForm.EditButtonClick(Sender: TObject);
var
  ParentID: integer;
begin


   if  qFormQuery.Eof then exit;


   // при клике на признаке группы (на желтом чемоданчике) разворачиваем узел
   if FormGrid.SelectedIndex = 0 then

      if qFormQuery.Fields[2].AsInteger = 1 then // это группа

         begin
             // ID родительской ветки , для нее и ищем все дочерние
             ID:= qFormQuery.Fields[0].asinteger;

             qFormQuery.Close;
             qFormQuery.ParamByName('ParentID').AsInteger:=ID;
             qFormQuery.Open;

             abort;

         end;

        ID       := qFormQuery.FieldByName('ID').AsInteger;
        ParentID := qFormQuery.FieldByName('ParentID').AsInteger;
        new(3, ID, ParentID, self, qFormQuery); {Редактирование элемента}

//      end;
      FormGrid.EndDrag(true);

end;

{

    Функция нахождения детей
    Описание: находит дочерние элементы для заданного и возвращает
    true если они есть и false в противном случае

}

function TLIST_TREEEDITForm.FindAnyChildren: boolean;

var qQuery : tQuery;

begin

   qQuery := tQuery.create(self);
   qQuery.databaseName := 'RMP';

    // формирование запроса на нахождение дочерних элементов
    qQuery.sql.clear;
    qQuery.sql.add('select id from ' + TableName +
                  ' where parentid = ' +
                   inttostr(qFormQuery.FieldByName('ID').asinteger) );
    qQuery.open;

    if qQuery.eof then

      result := false

    else

      begin

        showmessage('Элемент содержит подчиненные');
        result := true;

      end;


end;

{
  Процедура удаления элемента справочника
}
procedure TLIST_TREEEDITForm.DeleteButtonClick(Sender: TObject);
var
  _Name: string;
  IsFolder : integer;
begin
  if not check_user_grand(TableName, 'D', true) then
    exit;


  if  qFormQuery.Eof then exit;

  if FindAnyChildren then exit;

  _Name    := qFormQuery.FieldByName('Name').AsString;
  IsFolder := qFormQuery.FieldByName('IsFolder').asinteger;
  if messagedlg('Удалить запись ' + _Name + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    ID := qFormQuery.FieldByName('ID').AsInteger;


    with data.qDELQuery do
      begin
        close;
        sql.clear;
        sql.add('delete from ' + tablename + ' where id = ' + inttostr(id));
        try
          data.RMPBase.StartTransaction;
          execSQL;
          data.RMPBase.Commit;
        except
          MessageDlg('Ошибка удаления', mtError	, [mbOk], 0);
          data.RMPBase.Rollback;
        end;
      end;


    // обновление запроса
    RefreshQuery( qFormQuery);
    // при удалении группы обновляется дерево
    if isFolder = 1 then
      RebuildTreeCompanies;

   end;
end;
{
 Процедура перевода элемента из одной группы в другую
}
procedure TLIST_TREEEDITForm.TranceButtonClick(Sender: TObject);
var
 ID: integer;
 TranceForm: Tform;
begin
  if  qFormQuery.Eof then exit;
    ID := qFormQuery.FieldByName('ID').AsInteger;
    TranceForm := TTrance_Form.createN(application, tablename,
                ID, qFormQuery.FieldByName('CODE').AsString,
                qFormQuery.FieldByName('NAME').asString);
    TranceForm.ShowModal; // это форма перевода элемента из одного подчинения в другое.
end;

{
 Процедура установки просмотра таблицы: вся или в подчинении
}
procedure TLIST_TREEEDITForm.IsTreeButtonClick(Sender: TObject);

var parId: Integer;
begin
  {
   Проверка состояния кнопки. Если кнопка в панеле нажата, то просмотр всех записей
   в таблице, в противном случае только в виде дерева.
  }
  if IsTreeButton.down then
    begin
      MainmenuIsTree.Checked := true;
      IsTreeButtonMenu.Checked := true;
     if qFormQuery.eof then
      id := 0
     else
      ID    := qFormQuery.FieldByName('ID').asinteger;

     // формирование запроса формы по всем записям без групп
     qFormQuery.Close;
     qFormQuery.SQL.clear;
     qFormQuery.sql.add(sFormQueryFull);
     qFormQuery.open;

     // позиционирование туда, где были
     qFormQuery.locate('ID',  ID, [loCaseInsensitive]);

     EnumTreeView.Enabled := false;
    end
  else
    begin
      MainmenuIsTree.Checked := false;
      IsTreeButtonMenu.Checked := false;

     if qFormQuery.eof then
       begin
        id    := 0;
        ParId := 0
       end
     else
       begin
         ID    := qFormQuery.FieldByName('ID').asinteger;
         ParId := qFormQuery.FieldByName('ParentID').asinteger;
       end;

     // формирование запроса формы по группам
     qFormQuery.SQL.clear;
     qFormQuery.sql.add(sFormQuery);
     qFormQuery.sql.add(' Order by ID');
     qFormQuery.ParamByName('ParentID').AsInteger := parID;
     qFormQuery.open;

     // позиционирование туда, где были
     qFormQuery.locate('ID',  ID, [loCaseInsensitive]);

     EnumTreeView.Enabled := true;
    // RebuildTreeCompanies;
    end;

end;
//
//  При закрытии формы необходимо освободить форму редактирования элемента,
//  которая все это время была активной.
procedure TLIST_TREEEDITForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;
//
// Вызов процедуры редактирования записи при двойном нажатии на строку таблицы.
//
procedure TLIST_TREEEDITForm.EnumTreeGridDblClick(Sender: TObject);
begin
  EditButtonClick(sender);
end;

{
  Процедура поиска по подстроке

}
procedure TLIST_TREEEDITForm.FindButtonClick(Sender: TObject);
begin
 if Searchkey.text <> '' then
    find(qFormQuery, FormGrid, Searchkey.text, 1);
end;

procedure TLIST_TREEEDITForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if INTEGER(key) = 13 then
    find(qFormQuery, FormGrid, Searchkey.text, 1);
end;


{

   Процедура поиска вниз
}
procedure TLIST_TREEEDITForm.SearchDownButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
   if not qFormQuery.eof then qFormQuery.next;
    find(qFormQuery, FormGrid, Searchkey.text, 1);

end;

{
   Процедура поиска вверх

}
procedure TLIST_TREEEDITForm.SearchUpButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not qFormQuery.bof then qFormQuery.prior;

    find(qFormQuery, FormGrid, Searchkey.text, -1);

end;


{
 Процедура установки сортировки по ключу
}
procedure TLIST_TREEEDITForm.sortQuery(var Query : tquery; sTextQuery : string; ID : integer);
begin
  Query.close;
  Query.SQL.clear;
  Query.SQL.Add(sTextQuery);
  // Только при просмотре списка по дереву
  if not isTreeButton.down then
    Query.ParamByName('ParentID').AsInteger:=ID;
  Query.open;
end;

procedure TLIST_TREEEDITForm.MenuSortCodeClick(Sender: TObject);
begin
  if isTreeButton.Down then
     sortQuery( qFormQuery, sFormQueryFull + ' Order by CODE', ID)
  else
     sortQuery( qFormQuery, sFormQuery + ' Order by CODE', ID);

  FormGrid.Columns[1].Title.SortMarker := smDownEh;
  MenuSortCode.Checked := true;
  MenuSortName.Checked := false;
  MenuSortID.Checked   := false;
end;
{
 Процедура установки сортировки по коду
}
procedure TLIST_TREEEDITForm.MenuSortNameClick(Sender: TObject);
begin
  if isTreeButton.Down then

     sortQuery( qFormQuery, sFormQueryFull + ' Order by Name', ID)
  else

     sortQuery( qFormQuery, sFormQuery + ' Order by Name', ID);

  FormGrid.Columns[2].Title.SortMarker := smDownEh;
  MenuSortCode.Checked := false;
  MenuSortName.Checked := true;
  MenuSortID.Checked   := false;

end;

procedure TLIST_TREEEDITForm.MenuSortIDClick(Sender: TObject);
begin
  if isTreeButton.Down then

     sortQuery( qFormQuery, sFormQueryFull + ' Order by ID', ID)
  else
     sortQuery( qFormQuery, sFormQuery + ' Order by ID', ID);

  MenuSortCode.Checked := false;
  MenuSortName.Checked := false;
  MenuSortID.Checked   := true;

end;

{
  Очсистка параметров поиска по первым символам
}
procedure ClearStr(var Str_search: string; var FormGrid : TDBGridEh);
begin
  Str_search := '';
  FormGrid.SelectedField.ReadOnly := False;
  FormGrid.Options := [dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,
                                            dgRowLines,dgCancelOnExit];
end;
{
  Процедура при нажатии на столбец
}
procedure TLIST_TREEEDITForm.FormGridCellClick(Column: TColumnEh);
begin
  if qFormQuery.active then
    ClearStr(Str_search, FormGrid);
    
end;
{
  Процедура при попадании на столбец
  При перемещении со столбца на столбец параметы поиска должны обнулиться
}
procedure TLIST_TREEEDITForm.FormGridColEnter(Sender: TObject);
begin
  if qFormQuery.active then
    ClearStr(Str_search, FormGrid);

end;

{
    Процедура перерирования колонки при вводе символов
    Описание: при вводе строки поиска по первым символам производится
    перекрашиывание совпадающих симповолов стрики.
}
procedure TLIST_TREEEDITForm.FormGridDrawColumnCell(Sender: TObject;
  const _Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  ColorTmp : TColor;
  MyRect : TRect;
  CanvX : Integer;
begin
   with TDBGridEh(Sender) do begin
     if (gdFocused in State) and (Column.Field <> nil) and searching then begin
       ColorTmp := Canvas.Font.Color;
       try
         Canvas.FillRect(_Rect);
         Canvas.TextOut(2+_Rect.Left, 2+ _Rect.Top, Column.Field.AsString);

         Canvas.Font.Color := clRed;
         Canvas.TextOut(2+_Rect.Left, 2+_Rect.Top, Copy(Column.Field.AsString, 1, length(Str_search)));
         CanvX  := Canvas.PenPos.X;

         MyRect := Rect(0+_Rect.Left, 0+ _Rect.Top, Canvx , _Rect.Bottom+0);
         Canvas.Brush.Color := clWhite;
         Canvas.FrameRect(MyRect);

       finally
         Canvas.Font.Color := ColorTmp;
       end;
     end
     else
       Inherited;
   end;
end;
{
  Процедура при нажатии любой клавиши.
  Отлавливает клавиши REsET, Esc и пр.
}
procedure TLIST_TREEEDITForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  Reset_Key = [27,33..40,113];

begin

   // по нажатию Ctrl + Down разворачиваем узел
   if scExpand = ShortCut(Key, Shift) then
     begin
       if  qFormQuery.Eof then exit;


         if qFormQuery.Fields[2].AsInteger = 1 then // это группа

           begin
              // ID родительской ветки , для нее и ищем все дочерние
              ID:= qFormQuery.Fields[0].asinteger;

              qFormQuery.Close;
              qFormQuery.ParamByName('ParentID').AsInteger:=ID;
              qFormQuery.Open;

              abort;

           end;


     end;

     // по нажатию ctrl + up поднимаемся на уровень вверх
    if scUp = ShortCut(Key, Shift) then
     begin
       if  qFormQuery.Eof then exit;

              // ID родительской ветки , для нее и ищем все дочерние
              ID := qFormQuery.Fields[1].asinteger;
              qParentQuery.Close;
              qParentQuery.ParamByName('ID').asinteger := ID;
              qParentQuery.Open;
              ID := qParentQuery.Fields[0].asinteger;

              qFormQuery.Close;
              qFormQuery.ParamByName('ParentID').AsInteger:=ID;
              qFormQuery.Open;

              abort;


     end;


   if (Key in Reset_Key) AND Searching then
     begin
        Str_search := '';
        searching     := false;
        FormGrid.SelectedField.ReadOnly := False;
        FormGrid.Options := [dgEditing,dgTitles,dgIndicator,dgColumnResize,
                                dgColLines,dgRowLines,dgCancelOnExit];
     end
   else
     case Key of
       46 :  DeleteButtonClick(Sender); // удаление записи
       45 :  NewButtomClick(Sender);    // Добавление по Ins
       13 :
           if (qFormQuery.RequestLive = false) and (ElementForm <> nil) then
             EditButtonClick(Sender);   // Редактирование по Enter
//           else
//              qFormQuery.edit;

     end;
end;

{
   По нажатию на кнопку в таблице производится поиск записи по первым символам
}
procedure TLIST_TREEEDITForm.FormGridKeyPress(Sender: TObject; var Key: Char);
const
  Valid_Key = ['0'..'9', 'A'..'z','А'..'я', '-', '#', '№', '/','.',',','"','ё','Ё'];
  // массив символов ограничен
begin
  // Если введен символ №, то введен символ #
  if char(key) = '№' then
    key := '#';

  If (char(Key) in Valid_Key) then
    begin
       FormGrid.EditorMode := FALSE;
       FormGrid.SelectedField.ReadOnly := False;
       FormGrid.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgCancelOnExit];
       // вызов процедуры поиска
       Quick_Search(FormGrid, FormGrid.SelectedField.FieldName, Key,
                                qFormQuery, STR_search, searching);
    end;
  // если нажата backspace или пробел
  if ((char(Key) = #8)  OR (char(Key) = ' ')) AND Searching then begin
    FormGrid.EditorMode := FALSE;
    FormGrid.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgCancelOnExit];
    FormGrid.selectedfield.ReadOnly := True;
    // вызов процедуры поиска
    Quick_Search(FormGrid, FormGrid.SelectedField.FieldName,
                        Key, qFormQuery, STR_search, searching);
  end;

end;
{
   Процедура вызова контексной помощи


}


procedure TLIST_TREEEDITForm.HelpButtonClick(Sender: TObject);
begin
   application.HelpCommand(HELP_CONTEXT, 105);

end;


{
    Процедура преобразования элемента в группу и обратно
    Описание:
      Производит преобразование элемента справочника в группой,
      если он был листом и в лист, если он был группой

}

procedure TLIST_TREEEDITForm.MenuIsGroupClick(Sender: TObject);

var qQuery : tQuery;

begin

    qQuery := tQuery.create(self);
    qQuery.databasename := 'RMP';

   // Текущий элемент является группой
   if qFormQuery.FieldByName('ISFolder').asinteger = 1 then

      begin

       if messagedlg('Преобразовать элемент ' +
             qFormQuery.FieldByName('NAME').asstring +
             ' в лист?',
              mtConfirmation, [mbYes, mbNo], 0) = mrYes then
           begin

             if FindAnyChildren = false then

               begin

                   qQuery.sql.clear;
                   qQuery.sql.add('update ' + TableName );
                   qQuery.SQL.add('set isfolder = 0 where id = '  +
                        inttostr(qFormQuery.FieldByName('ID').asinteger));
                   data.RMPBase.StartTransaction;
                    qQuery.ExecSQL;
                   data.RMPBase.Commit;

               end;


           end;

      end

   else

      begin

       if messagedlg('Преобразовать элемент ' +
             qFormQuery.FieldByName('NAME').asstring +
             ' в группу?',
              mtConfirmation, [mbYes, mbNo], 0) = mrYes then
           begin

                   qQuery.sql.clear;
                   qQuery.sql.add('update ' + TableName );
                   qQuery.SQL.add('set isfolder = 1 where id = '  +
                        inttostr(qFormQuery.FieldByName('ID').asinteger));
                   data.RMPBase.StartTransaction;
                    qQuery.ExecSQL;;
                   data.RMPBase.Commit;

           end;

      end;

     refreshquery(qFormQuery);

end;

procedure TLIST_TREEEDITForm.FormGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if(button = mbleft) and (Shift = [ssShift, ssLeft]) then
    (sender as TDBGridEh).begindrag(false, 20);
end;

procedure TLIST_TREEEDITForm.EnumTreeViewDragDrop(Sender, Source: TObject;
  X, Y: Integer);

var qQuery : tQuery;
    parID  : integer;
begin

  if source.classname = 'TDBGridEh' then
    begin
      if messagedlg('Перенести ' + qFormQuery.FieldByName('Name').asstring +
        ' в группу ' +  EnumTreeView.selected.Text + '?',
          mtConfirmation, [mbYes, mbNo], 0) = mrYes then

        begin
           qQuery := tQuery.create(self);
           parID  := Integer(TTreeView(Sender).Selected.Data);

           with qQuery do
             begin
               databasename := 'RMP';
               sql.add('update ' + tablename);
               sql.add('set ParentID = ' +  inttostr(parID));
               sql.add('where ID = ' + qFormQuery.FieldByName('id').asstring);
               data.RMPBase.StartTransaction;
                ExecSQL;
               data.RMPBase.Commit;
             end;

            // обновление запроса
            refreshQuery(qFormQuery);
        end;

    end;

end;

procedure TLIST_TREEEDITForm.EnumTreeViewDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if source.classname = 'TDBGridEh' then
    accept := true
  else
    accept := false;

end;

{

    Проверка, какая кнопка была нажата в форме

}

procedure TLIST_TREEEDITForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then // and searching then
   begin
     EscPressed := True;
     abort;

   end;

end;
{
   Процедура позиционирования записи по коду,
   введенному в поле  CodeSearchKey

}

procedure TLIST_TREEEDITForm.CodeSearchKeyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if INTEGER(key) = 13 then
   if qFormQuery.Active then

     if qFormQuery.Locate('Code', CodeSearchKey.Text, [loCaseInsensitive]) then

       formGrid.setfocus
      else
         MessageDlg('Элемента с кодом ' + trim(CodeSearchKey.Text) + ' не найдено', mtWarning, [mbOK], 0);

end;


procedure TLIST_TREEEDITForm.MainmenuIsTreeClick(Sender: TObject);
begin
  if not MainmenuIsTree.Checked then
    begin
      IsTreeButton.Down := true;
      IsTreeButtonMenu.Checked := true;
      IsTreeButtonClick(sender);
    end
   else
     begin
       IsTreeButton.down := false;
       IsTreeButtonMenu.Checked := false;
       IsTreeButtonClick(sender);
     end;
end;

procedure TLIST_TREEEDITForm.IsTreeButtonMenuClick(Sender: TObject);
begin
  if not IsTreeButtonMenu.Checked then
    begin
      IsTreeButton.Down := true;
      MainmenuIsTree.Checked := true;
      IsTreeButtonClick(sender);
    end
   else
     begin
       IsTreeButton.down := false;
       MainmenuIsTree.Checked := false;
       IsTreeButtonClick(sender);
     end;

end;


procedure TLIST_TREEEDITForm.MenuRefClick(Sender: TObject);
begin
  refreshquery(qFormQuery);
  rebuildTreeCompanies;

end;

procedure TLIST_TREEEDITForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
   MenuSortCode.checked := false;
   MenuSortName.checked := false;
   MenuSortId.checked   := false;

   if aCol = 1 then
     begin
       MenuSortCode.checked := true;
       if isTreeButton.Down then
           sortQuery( qFormQuery, sFormQueryFull + ' Order by CODE', ID)
       else
           sortQuery( qFormQuery, sFormQuery + ' Order by code', ID);

     end
   else
     begin
       MenuSortName.Checked := true;
      if isTreeButton.Down then

        sortQuery( qFormQuery, sFormQueryFull + ' Order by Name', ID)
      else

        sortQuery( qFormQuery, sFormQuery + ' Order by Name', ID);

     end;

    FormGrid.Columns[aCol].Title.SortMarker := smDownEh;

end;


procedure TLIST_TREEEDITForm.ToolButtonFilterClick(Sender: TObject);
var FiltrEnumForm : TFiltrEnumForm; // форма установки фильтра по справочнику
    filtered   : integer;     // признак отфильтрованного журнала
//    _FromDate, _ToDate : tDate;
    ret   : integer;
    ParId : integer;
begin

  filtered := 0;

  FiltrEnumForm := TFiltrEnumForm.create(self);
  If (tablename = 'SPR_CHRT') Then
  begin
     FiltrEnumForm.ChrtPanel.show;
  end;

  FiltrEnumForm.id_enum_chrt := ID_CHRT_FILTER;
  FiltrEnumForm.id_enum_oper := ID_OPER_FILTER;
  FiltrEnumForm.id_enum_nmnt := ID_NMNT_FILTER;

  FiltrEnumForm.OperCheckBox.Visible := true;
  if EnumOperNorm > 0 then
    FiltrEnumForm.OperCheckBox.Checked :=  true
    else
     FiltrEnumForm.OperCheckBox.Checked :=  false;


  FiltrEnumForm.OnOpenForm;

  ret := FiltrEnumForm.showmodal;
  // если установлен фильтр
  if ret = mrOK then
   begin
      // если есть отбор по номенклатуре
      if (FiltrEnumForm.NMNTChrtCombo.text <> '') and (FiltrEnumForm.qNMNTChrtQuery.active) then
        begin

          filtered := 1;
          ID_NMNT_FILTER := FiltrEnumForm.id_enum_nmnt;
        end

       else
           ID_NMNT_FILTER := -1;

      // если есть отбор по чертежу
      if (FiltrEnumForm.CHRTChrtCombo.text <> '') and (FiltrEnumForm.qCHRTChrtQuery.active) then

        begin

          filtered := 1;
          ID_CHRT_FILTER := FiltrEnumForm.id_enum_chrt;

        end

       else
         ID_CHRT_FILTER := -1;

      // если есть отбор по опеарции
      if (FiltrEnumForm.OperCHRTCombo.text <> '') and (FiltrEnumForm.qOperCHRTQuery.active) then

        begin

          filtered := 1;
          ID_OPER_FILTER := FiltrEnumForm.id_enum_oper;

        end

       else
         ID_OPER_FILTER := -1;

      if FiltrEnumForm.OperCheckBox.Checked then
       begin
           filtered := 1;
           EnumOperNorm := 1
       end
        else EnumOperNorm :=0;


      If (tablename = 'SPR_CHRT') Then
      begin
         sFormQueryFull := 'select id, parentid, isfolder, code, name from BROWSE_SPR_CHRT_FILTR ('+ IntToStr(ID_CHRT_FILTER)+', '+
                           IntToStr(ID_OPER_FILTER)+ ', '+  IntToStr(ID_NMNT_FILTER)+ ', '+ IntToStr(enumopernorm)+ ')';
      end;

{          sFormQueryFull := 'select a.id, a.parentid, a.isfolder, a.code, a.name ';
          sFormQueryFull := sFormQueryFull+' from ' + tablename + ' a, spr_opch b, spr_mtch c ';
          sFormQueryFull := sFormQueryFull+' where b.id_chrt = a.id and b.id = c.id_opch and c.id_nmnt = '+IntToStr(ID_NMNT_FILTER);}
//           sFormQueryFull := 'select a.id, a.parentid, a.isfolder, a.code, a.name from ' + tablename;


       // закрытие запроса

      MainmenuIsTree.Checked := true;
      IsTreeButtonMenu.Checked := true;
      if qFormQuery.eof then
        id := 0
      else
      ID    := qFormQuery.FieldByName('ID').asinteger;

      // формирование запроса формы по всем записям без групп
      qFormQuery.Close;
      qFormQuery.SQL.clear;
      qFormQuery.sql.add(sFormQueryFull);
      qFormQuery.open;

      // позиционирование туда, где были
      qFormQuery.locate('ID',  ID, [loCaseInsensitive]);

      EnumTreeView.Enabled := false;

      FiltrEnumForm.Close;
   end

    else
     // отключение отбора
     begin

       if ret = mrCancel then

       begin

         ID_CHRT_FILTER := -1;
         ID_OPER_FILTER := -1;
         ID_NMNT_FILTER := -1;
         EnumOperNorm   := 0;

         MainmenuIsTree.Checked := false;
         IsTreeButtonMenu.Checked := false;

         if qFormQuery.eof then
         begin
           id    := 0;
           ParId := 0
         end
          else
           begin
             ID    := qFormQuery.FieldByName('ID').asinteger;
             ParId := qFormQuery.FieldByName('ParentID').asinteger;
           end;

        // формирование запроса формы по группам
        qFormQuery.SQL.clear;
        qFormQuery.sql.add(sFormQuery);
        qFormQuery.sql.add(' Order by ID');
        qFormQuery.ParamByName('ParentID').AsInteger := parID;
        qFormQuery.open;

        // позиционирование туда, где были
        qFormQuery.locate('ID',  ID, [loCaseInsensitive]);

        EnumTreeView.Enabled := true;

       end;
     end;

     FiltrEnumForm.Close;


     if filtered = 1 then
       ToolButtonFilter.Down := true
     else
        ToolButtonFilter.Down := false;

end;

end.
