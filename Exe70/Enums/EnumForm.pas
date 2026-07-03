{
                       Модуль EnunmForm.
   Описание.
     Форма редактирования любого справочника без дерева.
   Форма вызывается из всех форме, где требуется работа с одноуровневыми
   справочниками.

}
unit EnumForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, StdCtrls, ComCtrls, ExtCtrls, Grids, DBGrids, ToolWin, Db,
  DBTables, Menus, DBGridEh, ActnList;

type
  TLIST_EDITForm = class(TForm)
    BottomPanel:  TPanel;
    CenterPanel:  TPanel;
    TopPanel:     TPanel;
    EnumToolBar:  TToolBar;
    FormSplitter: TSplitter;
    CloseButton:  TButton;
    NewButtom: TToolButton;
    EditButton: TToolButton;
    DeleteButton: TToolButton;
    HelpButton: TToolButton;
    Gen_IDQuery: TQuery;
    GridMenu: TPopupMenu;
    MenuSub: TMenuItem;
    MenuSort1: TMenuItem;
    MenuSort2: TMenuItem;
    MenuSort3: TMenuItem;
    Searchkey: TEdit;
    FindButton: TButton;
    MenuNew: TMenuItem;
    FormSource: TDataSource;
    qFormQuery: TQuery;
    FormGrid: TDBGridEh;
    MenuEdit: TMenuItem;
    MenuDel: TMenuItem;
    DownButton: TToolButton;
    UpButton: TToolButton;
    CodeSearchKey: TEdit;
    ActionList: TActionList;
    acFindNext: TAction;
    acFindPrior: TAction;
    acFind: TAction;
    MainMenu: TMainMenu;
    N8: TMenuItem;
    MainMenuNew: TMenuItem;
    MainMenuEdit: TMenuItem;
    MainMenuDel: TMenuItem;
    MainMenuSub: TMenuItem;
    MainMenuSort1: TMenuItem;
    MainMenuSort2: TMenuItem;
    MainMenuSort3: TMenuItem;
    MenuRef: TMenuItem;
    MainMenuRef: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qFormQueryAfterPost(DataSet: TDataSet);
    procedure qFormQueryBeforePost(DataSet: TDataSet);
    procedure DeleteButtonClick(Sender: TObject);
    procedure MenuSort1Click(Sender: TObject);
    procedure MenuSort2Click(Sender: TObject);
    procedure MenuSort3Click(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure EditButtonClick(Sender: TObject);
    procedure NewButtomClick(Sender: TObject);
    procedure FormGridCellClick(Column: TColumnEh);
    procedure FormGridColEnter(Sender: TObject);
    procedure FormGridDrawColumnCell(Sender: TObject; const _Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormGridKeyPress(Sender: TObject; var Key: Char);
    procedure DownButtonClick(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CodeSearchKeyKeyPress(Sender: TObject; var Key: Char);
    procedure MenuRefClick(Sender: TObject);
    procedure FormGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
  private
    procedure new(IsFolder, ID: integer; sender: TLIST_EDITForm;
      Query: tQuery);

  public
    FormName  : string;
    TableName : string;
    sFormQuery: string;         // строка формирования запроса по таблице
    ID        : integer;        // идентификатор записи
    ElementForm  : tFormClass;  // Форма для редактирования элемента
    STR_Search: string;         // строка поиска
    searching : boolean;        // признак поиска по первым буквам
    constructor CreateN(AOwner: TComponent; _FormName: string;
        _TableName: string; Gen_IDName: string; tFormType: TFormClass);
    destructor Destroy; override;
    { Public declarations }
  end;

var
  LIST_EDITForm: TLIST_EDITForm;


implementation

uses main,
     base,
     Libs, ParamForm;
{$R *.DFM}


{
 Конструктор создания формы.
 Вход: владелец окна,
       заголовок формы,
       Имя таблицы,
       имя генератора, в случае, если справочник редактируется в таблице
       класс формы для редактирования элемента
       ID записи в случае выбора
}
constructor TLIST_EDITForm.CreateN(AOwner: TComponent; _FormName: string;
        _TableName: string; Gen_IDName: string; tFormType: TFormClass);
var qValue: string;
begin
  inherited Create(AOwner);

  // проверка на возможность редактирования
  if not check_user_grand(_TableName, 'S', true) then
    abort;

  TableName   := _TableName;    // запомним имя таблицы
  ElementForm := tFormType;     // запомним класс формы редактирования элемента
  // формирование запроса таблицы
  qFormQuery.close;
  qFormQuery.SQL.clear;
  sFormQuery := 'select * from ' + tablename;
  qFormQuery.sql.add(sFormQuery);
  qFormQuery.sql.add('Order by code');

  MenuSort1.Checked := true;

  // если для справочника определена форма редактирования элемента,
  // то редактирование в таблице запрещено.
  // В таком случае устанавливается свойство таблицы для редактирования
  if tFormType = nil then
    qFormQuery.RequestLive := true
  else
    qFormQuery.RequestLive := false;

  // открытие запроса формы
  qFormQuery.open;
  
  // формирование запроса для генератора
  Gen_IDQuery.sql.clear;
  qValue := 'SELECT GEN_ID(' + Gen_IDName + ', 1) FROM RDB$DATABASE';
  Gen_IDQuery.sql.add(qValue);

  caption := _FormName;

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

end;
{
   Деструктор формы
}
destructor TLIST_EDITForm.Destroy;
begin
  inherited;
end;

// Освобождение формы после нажатия кнопки Close
procedure TLIST_EDITForm.CloseButtonClick(Sender: TObject);
begin
  release;
end;

procedure TLIST_EDITForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

// Процедура
// Генерация ID записи после добавления
//
procedure TLIST_EDITForm.qFormQueryAfterPost(DataSet: TDataSet);
begin
  refreshquery( qFormQuery);
end;
{
    Формирование ID записи до добавления новой
}
procedure TLIST_EDITForm.qFormQueryBeforePost(DataSet: TDataSet);
begin
  // если справочник редактируется без формы редактирования элемента
  // то в момент добавления записи формируется ID записи
  if (FormGrid.DataSource.DataSet.state = dsInsert) AND (ElementForm = nil) then
    begin
      Gen_IDQuery.Open;
      qFormQuery.FieldByName('ID').asInteger:=
         Gen_IDQuery.Fields[0].asInteger;
      Gen_IDQuery.Close;



    end;

    // проверка на уникальность кода
    if (ElementForm = nil) then
      if (ChechUniqueCode(tablename, 'Code',
            qFormQuery.FieldByName('Code').asstring, qFormQuery.FieldByName('ID').asinteger) > 0)  then
       begin
         showmessage('Код не уникальный!');
         abort;

       end;


end;
//
//  Процедура удаления элемента
//
procedure TLIST_EDITForm.DeleteButtonClick(Sender: TObject);
var
  _Name: string;
     ID: integer;
begin

  if not check_user_grand(TableName, 'D', true) then
    exit;


  if  qFormQuery.Eof then exit;
  _Name := qFormQuery.FieldByName('Name').AsString;

  if messagedlg('Удалить запись ' + _Name + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    ID := qFormQuery.FieldByName('ID').AsInteger;

    with data.qDELQuery do
      begin
        close;
        sql.clear;
        sql.add('delete from ' + tablename + ' where id = ' + inttostr(id));
        data.RMPBase.StartTransaction;
        execSQL;
        data.RMPBase.commit;
      end;

   end;
  // обновление запроса
  refreshquery( qFormQuery);
end;

procedure SortQuery(var Query: tquery; sQueryText : string);
begin
  Query.close;
  Query.sql.clear;
  Query.SQL.add(sQueryText);
  Query.open;
end;

//
//  Процедура установки сортировки по коду
//
procedure TLIST_EDITForm.MenuSort1Click(Sender: TObject);
begin
  SortQuery ( qFormQuery, sFormQuery + ' Order by CODE');
  FormGrid.Columns[0].Title.SortMarker := smDownEh;
  MenuSort1.Checked := true;
  MenuSort2.Checked := false;
  MenuSort3.Checked := false;

end;
//
//  Процедура установки сортировки по наименованию
//
procedure TLIST_EDITForm.MenuSort2Click(Sender: TObject);
begin
  SortQuery ( qFormQuery, sFormQuery + ' Order by Name');
  FormGrid.Columns[1].Title.SortMarker := smDownEh;
  MenuSort2.Checked := true;
  MenuSort1.Checked := false;
  MenuSort3.Checked := false;

end;
//
//  Процедура установки сортировки по ID
//
procedure TLIST_EDITForm.MenuSort3Click(Sender: TObject);
begin
  SortQuery ( qFormQuery, sFormQuery + ' Order by ID');
  MenuSort1.Checked := false;
  MenuSort2.Checked := false;
  MenuSort3.Checked := true;
end;

// Процедура нажатия кнопки "Найти"
procedure TLIST_EDITForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then
  find(qFormQuery, FormGrid, Searchkey.text, 1);
end;
// Процедура нажатия "Enter" в поле "Поиск"
procedure TLIST_EDITForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if INTEGER(key) = 13 then
    find(qFormQuery, FormGrid, Searchkey.text, 1);
end;

{
    Поиск вниз

}

procedure TLIST_EDITForm.DownButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not qFormQuery.eof then qFormQuery.next;
    find(qFormQuery, FormGrid, Searchkey.text, 1);

end;

{
    Поиск вверх

}
procedure TLIST_EDITForm.UpButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not qFormQuery.bof then qFormQuery.prior;

    find(qFormQuery, FormGrid, Searchkey.text, -1);

end;


// Выполнение транзакций через кнопочки

// Общая процедура вызова формы редактирования элемента.
{

   Вход:  IsFolder - признак работы: 1 - добавление, 3 - редактирование
          ID - ID существующей записи;
          sender - форма редактирования элемента;
          Query - запрос редактирования свойств элемента.


}
procedure TLIST_EDITForm.new(IsFolder : integer; ID: integer; sender: TLIST_EDITForm; Query : tQuery);
var
  FormEdit: TForm;
begin
  mainform.IsFolder := isfolder;
  mainform.ID       := ID;

  if sender.ElementForm <> nil then
    begin
      application.createform(sender.ElementForm, FormEdit);
      FormEdit.Visible   := false;
      if FormEdit.showmodal = mrOK then
         refreshquery( Query);
    end

  else
  // редактирование простого справочника
    begin
      if IsFolder = 1 then // добавление
        begin
          FormGrid.SetFocus;
          FormGrid.DataSource.DataSet.Append;
          FormGrid.SelectedIndex := 0;

        end;


    end;

end;



//  Процедура редактирования элемента
//
//
procedure TLIST_EDITForm.EditButtonClick(Sender: TObject);
begin

   if  qFormQuery.Eof then exit;

   ID := qFormQuery.FieldByName('ID').AsInteger;

   if not qFormQuery.RequestLive then
     new(3, ID, self, qFormQuery) {Редактирование элемента}
   else
     qFormQuery.Edit;
   // тут еще не все

end;
//
//  Процедура добавления элемента
//
procedure TLIST_EDITForm.NewButtomClick(Sender: TObject);
begin
  if not check_user_grand(TableName, 'I', true) then
    exit;

  ID := qFormQuery.FieldByName('ID').AsInteger;
  new(1, ID, self, qFormQuery);  {Добавление элемента}

  // позиционируемся на введенную запись
  qFormQuery.Locate('ID', MainForm.ID, [loCaseInsensitive]);

end;

{
  Процедура при нажатии на столбец
}
procedure TLIST_EDITForm.FormGridCellClick(Column: TColumnEh);
begin
  ClearStr(Str_search, FormGrid);
end;
{
  Процедура при попадании на столбец
  При перемещении со столбца на столбец параметы поиска должны обнулиться
}
procedure TLIST_EDITForm.FormGridColEnter(Sender: TObject);
begin
  ClearStr(Str_search, FormGrid);
end;


{
    Процедура перерирования колонки при вводе символов
    Описание: при вводе строки поиска по первым символам производится
    перекрашиывание совпадающих симповолов стрики.
}
procedure TLIST_EDITForm.FormGridDrawColumnCell(Sender: TObject;
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
procedure TLIST_EDITForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  Reset_Key = [27,33..40,113];
begin
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
       46 :  begin
              if qFormQuery.State = dsEdit then exit;
                DeleteButtonClick(Sender); // удаление записи
             end;
       45 :  NewButtomClick(Sender);    // Добавление по Ins
       13 : begin
              if (qFormQuery.RequestLive = false) and (ElementForm <> nil) then
                 EditButtonClick(Sender)   // Редактирование по Enter
              else
                 qFormQuery.Edit;
            end;
     end;
end;
{
   По нажатию на кнопку в таблице производится поиск записи по первым символам
}
procedure TLIST_EDITForm.FormGridKeyPress(Sender: TObject; var Key: Char);
const
  Valid_Key = ['0'..'9', 'A'..'z','А'..'я', '-', '#',  '/','.',',','"','ё','Ё'];
  // массив символов ограничен
begin
   if ((qFormQuery.State = dsEdit) or (qFormQuery.State = dsInsert))
        and (searching = false) then
     exit;

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



procedure TLIST_EDITForm.HelpButtonClick(Sender: TObject);
begin
   application.HelpCommand(HELP_CONTEXT, 100);
end;

{

    Проверка, какая кнопка была нажата в форме

}

procedure TLIST_EDITForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_ESCAPE) and Searching then
   begin
     EscPressed := True;
     abort;

   end;

end;
{
   Процедура позиционирования записи по коду,
   введенному в поле  CodeSearchKey

}

procedure TLIST_EDITForm.CodeSearchKeyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if INTEGER(key) = 13 then

     if qFormQuery.Locate('Code', CodeSearchKey.Text, [loCaseInsensitive]) then
       formGrid.setfocus
      else
         MessageDlg('Элемента с кодом ' + trim(CodeSearchKey.Text) + ' не найдено', mtWarning, [mbOK], 0);


end;

procedure TLIST_EDITForm.MenuRefClick(Sender: TObject);
begin
  refreshQuery(qFormQuery);
end;


{

   Установка сортировки при нажатии на кнопку формы


}
procedure TLIST_EDITForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  MenuSort1.Checked := false;
  MenuSort2.Checked := false;
  MenuSort3.Checked := false;

  if ACol = 0 then
    begin
     SortQuery ( qFormQuery, sFormQuery + ' Order by CODE');
     MenuSort1.Checked := true;
    end
   else
     begin
       SortQuery ( qFormQuery, sFormQuery + ' Order by Name');
       MenuSort2.Checked := true;
     end;

   FormGrid.Columns[aCol].Title.SortMarker := smDownEh;
  
end;

end.
