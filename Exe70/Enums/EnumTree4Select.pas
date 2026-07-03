{
        Модуль  EnumTreeForm
   Описание.
     Форма редактирования любого многоуровневого справочника с деревом.
   Форма вызывается из всех форме, где требуется работа с многоуровневыми
   справочниками.


}

unit EnumTree4Select;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Grids, DBGrids, ImgList, ToolWin, StdCtrls, Db,
  DBTables, Menus, TranceForm, DBGridEh, ActnList;

const
  scExpand = scCtrl  + VK_DOWN;
  scUp     = scCtrl  + VK_UP;

type
  TLIST_TREE4SelectForm = class(TForm)
    FormSource: TDataSource;
    qFormQuery: TQuery;
    FormGrid: TDBGridEh;
    TopPanel: TPanel;
    BotPanel: TPanel;
    CenterPanel: TPanel;
    Splitter: TSplitter;
    EnumTreeView: TTreeView;
    EnumToolBar: TToolBar;
    IsTreeButton: TToolButton;
    HelpButton: TToolButton;
    CloseButton: TButton;
    qTreeQuery: TQuery;
    TablePopupMenu: TPopupMenu;
    Searchkey: TEdit;
    FindButton: TButton;
    MenuSub: TMenuItem;
    MenuSortCode: TMenuItem;
    MenuSortName: TMenuItem;
    MenuSortID: TMenuItem;
    SearchDownButton: TToolButton;
    SearchUpButton: TToolButton;
    CodeSearchKey: TEdit;
    OKButton: TButton;
    ActionList: TActionList;
    acFindNext: TAction;
    acFindPrior: TAction;
    acFind: TAction;
    qParentQuery: TQuery;
    procedure N6Click(Sender: TObject);
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
    procedure IsTreeButtonClick(Sender: TObject);
    procedure EnumTreeGridDblClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure MenuSortCodeClick(Sender: TObject);
    procedure MenuSortNameClick(Sender: TObject);
    procedure MenuSortIDClick(Sender: TObject);
    procedure SearchDownButtonClick(Sender: TObject);
    procedure SearchUpButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure FormGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EnumTreeViewDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CodeSearchKeyKeyPress(Sender: TObject; var Key: Char);
    procedure OKButtonClick(Sender: TObject);
    procedure openQuery(QueryText : string);
    procedure FormGridDblClick(Sender: TObject);
    procedure EnumTreeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);

  private
    procedure SetID(newID : integer);
    function  GetID : integer;
    procedure sortQuery(var Query: tquery; sTextQuery: string;
      ID: integer);

    { Private declarations }
  public
    ElementForm  : tFormClass; // Форма для редактирования элемента
    TableName:     string;     // имя таблицы в запросе
    FormName:      string;     // имя формы
    sFormQuery:    string;     // строка формирования запроса по таблице
    sFormQueryFull:string;     // тоже самое для всей таблицы (без дерева)
    ID            : integer;
    property IDRec : integer read GetID write SetID;
  end;

var
  LIST_TREE4SelectForm: TLIST_TREE4SelectForm;
    STR_Search: string;         // строка поиска
    searching : boolean;        // признак поиска по первым буквам
  tQueryText  : string;         // строка запроса

implementation

uses Main,
     Libs, Base;

{$R *.DFM}

///             Процедуры работы с деревом
///
{
 Процедура:
   Разворачивает узел дерева
   Вход: узел дерева, который необходимо развернуть
}
Procedure tLIST_TREE4SelectForm.ExpandLevel( Node : TTreeNode);
Var i   : Integer;
    TreeNode : TTreeNode;
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
    For i:=1 To qTreeQuery.RecordCount Do
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
Procedure TLIST_TREE4SelectForm.RebuildTreeCompanies;
Begin

    EnumTreeView.Items.Clear;

    // Принудительное раскрытие самого верхнего уровня
    ExpandLevel(nil);
    EnumTreeView.Selected:=EnumTreeView.Items[0];
End;
//
//  Процедура полной принужденной перестройки дерева
//
procedure TLIST_TREE4SelectForm.N6Click(Sender: TObject);
begin
   rebuildTreeCompanies;
end;
{
  Процедура
    Вызов при изменении дерева списка
  Описание: формирует запрос для таблицы.
}
procedure TLIST_TREE4SelectForm.EnumTreeViewDblClick(Sender: TObject);
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
   Процедура выполнения выбора из дерева по нажатию
   кнопки

}
procedure TLIST_TREE4SelectForm.EnumTreeViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   //

   if key = 13 then
    EnumTreeViewDblClick(sender);

end;



{
 Процедура
  Вызов при раскрытии дерева списка.
}
procedure TLIST_TREE4SelectForm.EnumTreeViewExpanding(Sender: TObject;
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



procedure TLIST_TREE4SelectForm.CloseButtonClick(Sender: TObject);
begin

  ModalResult := mrCancel;
  
end;
{
  Процедура при открытии формы
}
procedure TLIST_TREE4SelectForm.FormShow(Sender: TObject);
begin

  //RebuildTreeCompanies;    {Перестройка дерева списка}

end;



{
 Процедура установки просмотра таблицы: вся или в подчинении
}
procedure TLIST_TREE4SelectForm.IsTreeButtonClick(Sender: TObject);

var parId: Integer;

begin
  {
   Проверка состояния кнопки. Если кнопка в панеле нажата, то просмотр всех записей
   в таблице, в противном случае только в виде дерева.
  }
  if IsTreeButton.down then
    begin
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

     ID    := qFormQuery.FieldByName('ID').asinteger;
     ParId := qFormQuery.FieldByName('ParentID').asinteger;

     // формирование запроса формы по группам
     qFormQuery.SQL.clear;
     qFormQuery.sql.add(sFormQuery);
     qFormQuery.ParamByName('ParentID').AsInteger := parID;
     qFormQuery.open;

     // позиционирование туда, где были
     qFormQuery.locate('ID',  ID, [loCaseInsensitive]);

     EnumTreeView.Enabled := true;
    // RebuildTreeCompanies;
    end;

end;
{

    Процедура формирования формы при открытии

}
procedure TLIST_TREE4SelectForm.openQuery(QueryText : string);
begin
  // если справочник уже открыт, то не стоит его снова спрашивать
  if tQueryText <> '' then
    if tQueryText = QueryText then
      exit;

  tQueryText := QueryText;

  with qFormQuery do
    begin
     sql.clear;
     close;
     sql.add(tQueryText);
     sql.add('where ParentID =:ParentID');
     sFormQuery     := sql.Text;
     Sql.add('order by code');
     parambyname('parentID').asinteger := 0;
     open;
    end;

  sFormQueryFull := tQueryText;
  istreebutton.down    := false;
  EnumTreeView.Enabled := true;

  menusortcode.Checked := true;

  with qTreeQuery do
    begin
      sql.clear;
      sql.add(tQueryText);
      sql.add('where ParentID =:ParentID');
    end;



  RebuildTreeCompanies;    {Перестройка дерева списка}

end;

//
// Вызов процедуры редактирования записи при двойном нажатии на строку таблицы.
//
procedure TLIST_TREE4SelectForm.EnumTreeGridDblClick(Sender: TObject);
begin

  ModalResult := mrOK;
end;

{
  Процедура поиска по подстроке

}
procedure TLIST_TREE4SelectForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then
    find(qFormQuery, FormGrid, Searchkey.text, 1);
end;

procedure TLIST_TREE4SelectForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if INTEGER(key) = 13 then
    find(qFormQuery, FormGrid, Searchkey.text, 1);
end;


{

   Процедура поиска вниз
}
procedure TLIST_TREE4SelectForm.SearchDownButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not qFormQuery.eof then qFormQuery.next;
    find(qFormQuery, FormGrid, Searchkey.text, 1);

end;

{
   Процедура поиска вверх

}
procedure TLIST_TREE4SelectForm.SearchUpButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not qFormQuery.bof then qFormQuery.prior;

    find(qFormQuery, FormGrid, Searchkey.text, -1);

end;


{
 Процедура установки сортировки по ключу
}
procedure TLIST_TREE4SelectForm.sortQuery(var Query : tquery; sTextQuery : string; ID : integer);
begin
  Query.close;
  Query.SQL.clear;
  Query.SQL.Add(sTextQuery);
  // Только при просмотре списка по дереву
  if not isTreeButton.down then
    Query.ParamByName('ParentID').AsInteger:=ID;
  Query.open;
end;

procedure TLIST_TREE4SelectForm.MenuSortCodeClick(Sender: TObject);
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
procedure TLIST_TREE4SelectForm.MenuSortNameClick(Sender: TObject);
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

procedure TLIST_TREE4SelectForm.MenuSortIDClick(Sender: TObject);
begin
  if isTreeButton.Down then

     sortQuery( qFormQuery, sFormQueryFull + ' Order by ID', ID)
  else
     sortQuery( qFormQuery, sFormQuery + ' Order by ID' , ID);

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
procedure TLIST_TREE4SelectForm.FormGridCellClick(Column: TColumnEh);
begin
  if qFormQuery.active then
    ClearStr(Str_search, FormGrid);
    
end;
{
  Процедура при попадании на столбец
  При перемещении со столбца на столбец параметы поиска должны обнулиться
}
procedure TLIST_TREE4SelectForm.FormGridColEnter(Sender: TObject);
begin
  if qFormQuery.active then
    ClearStr(Str_search, FormGrid);

end;

{
    Процедура перерирования колонки при вводе символов
    Описание: при вводе строки поиска по первым символам производится
    перекрашиывание совпадающих симповолов стрики.
}
procedure TLIST_TREE4SelectForm.FormGridDrawColumnCell(Sender: TObject;
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
procedure TLIST_TREE4SelectForm.FormGridKeyDown(Sender: TObject; var Key: Word;
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

       13 :  ModalResult := mrOK;

     end;
end;

{
   По нажатию на кнопку в таблице производится поиск записи по первым символам
}
procedure TLIST_TREE4SelectForm.FormGridKeyPress(Sender: TObject; var Key: Char);
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


procedure TLIST_TREE4SelectForm.HelpButtonClick(Sender: TObject);
begin
   application.HelpCommand(HELP_CONTEXT, 105);

end;



procedure TLIST_TREE4SelectForm.FormGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if button = mbleft then
    (sender as TDBGridEh).begindrag(false, 20);
end;


{

    Проверка, какая кнопка была нажата в форме

}

procedure TLIST_TREE4SelectForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if (Key = VK_ESCAPE) then // and searching then
//   begin
//     EscPressed := True;
//     abort;
//
//   end;

end;
{
   Процедура позиционирования записи по коду,
   введенному в поле  CodeSearchKey

}

procedure TLIST_TREE4SelectForm.CodeSearchKeyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if INTEGER(key) = 13 then
   if qFormQuery.Active then
     if qFormQuery.Locate('Code', CodeSearchKey.Text, [loCaseInsensitive]) then

        formgrid.setfocus
      else
         MessageDlg('Элемента с кодом ' + trim(CodeSearchKey.Text) + ' не найдено', mtWarning, [mbOK], 0);


end;
{
   Процедура установления свойства ID
}
procedure TLIST_TREE4SelectForm.SetID(newID : integer);
begin

  qFormQuery.locate('ID', newID, [loCaseInsensitive]);

end;
{
  Функция нахождения ID записи
}
function TLIST_TREE4SelectForm.GetID : integer;
begin

  result := qFormQuery.FieldByName('ID').asinteger;

end;


procedure TLIST_TREE4SelectForm.OKButtonClick(Sender: TObject);
begin

   ModalResult := mrOK

end;

procedure TLIST_TREE4SelectForm.FormGridDblClick(Sender: TObject);
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


    ModalResult := mrOK;


end;


procedure TLIST_TREE4SelectForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) then // and searching then
   begin
     EscPressed := True;
     abort;

   end;


end;

procedure TLIST_TREE4SelectForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  MenuSortCode.Checked := false;
  MenuSortName.Checked := false;
  MenuSortId.Checked   := false;

  if ACol = 1 then
    begin
      MenuSortCode.Checked := true;
      if isTreeButton.Down then
        sortQuery( qFormQuery, sFormQueryFull + ' Order by CODE', ID)
      else
        sortQuery( qFormQuery, sFormQuery + ' Order by CODE', ID)

         
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

end.
