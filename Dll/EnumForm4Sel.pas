{***************************************************************
 *
 * Unit Name: EnumForm4Sel
 * Purpose  :     Модуль предназначен для открытия любого справочника и
    выбора параметра из него. Форма открывается модально и
    работает со всеми справочниками любого типа.

 * Author   :
 * History  :
 *
 ****************************************************************}

unit EnumForm4Sel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, Grids, DBGrids, StdCtrls, ExtCtrls, DBGridEh, Menus,
  ImgList, ComCtrls, ToolWin;

type
  TLIST_4SELECTForm = class(TForm)
    Panel1: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    FormSource: TDataSource;
    qFormQuery: TQuery;
    FormGrid: TDBGridEh;
    GridMenu: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    EnumToolBar: TToolBar;
    Search_string: TEdit;
    SearchButton: TButton;
    DownButton: TToolButton;
    ImageList: TImageList;
    UpButton: TToolButton;
    Query: TQuery;
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure openQuery(QueryText : string);
    procedure FormGridCellClick(Column: TColumnEh);
    procedure FormGridColEnter(Sender: TObject);
    procedure FormGridDblClick(Sender: TObject);
    procedure FormGridDrawColumnCell(Sender: TObject; const _Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormGridKeyPress(Sender: TObject; var Key: Char);
    procedure Search_stringKeyPress(Sender: TObject; var Key: Char);
    procedure SearchButtonClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure DownButtonClick(Sender: TObject);
    procedure UpButtonClick(Sender: TObject);
  private
    procedure SetID(newID : integer);
    function  GetID : integer;
  public
    property IDRec : integer read GetID write SetID;
  end;

var
  LIST_4SELECTForm: TLIST_4SELECTForm;
  Str_search : string;    // строка поиска
  tQueryText  : string;    // строка запроса
Searching    : boolean;   // признак выполнения поиска


implementation

uses Libs;

{$R *.DFM}
{
   Процедура нажатия кнопки ОК
}
procedure TLIST_4SELECTForm.OKButtonClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;
{
   Процедура открытия запроса.
   Вход: готовый текст запроса по справочной таблице.
   Выход: пусто.
   Описание: выполняется запрос формы таблицы,
             открывается выборка по запросу, данные в таблице.

}
procedure TLIST_4SELECTForm.openQuery(QueryText : string);
begin


  // если справочник уже открыт, то не стоит его снова спрашивать
  if tQueryText <> '' then
    if (tQueryText = QueryText) and (qFormQuery.Active)  then
      exit;

  tQueryText := QueryText;

  qFormQuery.close;
  qFormQuery.sql.clear;
  qFormQuery.sql.add(tQueryText);
  qFormQuery.Sql.add('order by code');
  qFormQuery.open;


end;

procedure TLIST_4SELECTForm.SetID(newID : integer);
begin
  qFormQuery.locate('ID', newID, [loCaseInsensitive]);
end;

function TLIST_4SELECTForm.GetID : integer;
begin
  result := qFormQuery.FieldByName('ID').asinteger;
end;
{
   Отмена редактирования
}
procedure TLIST_4SELECTForm.CancelButtonClick(Sender: TObject);
begin
 ModalResult := mrCancel;
end;

{

 Процедуры организации поиска в таблице, позиционирования курсора

}

{
   Процедура при клике на столбце.
   При перемещении со столбца на столбец параметы поиска должны обнулиться
}
procedure TLIST_4SELECTForm.FormGridCellClick(Column: TColumnEh);
begin
  Str_search := '';
  FormGrid.SelectedField.ReadOnly := False;
  FormGrid.Options := [dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,
                                            dgRowLines,dgTabs,dgCancelOnExit];
end;
{
  Процедура при попадании на столбец
  При перемещении со столбца на столбец параметы поиска должны обнулиться
}
procedure TLIST_4SELECTForm.FormGridColEnter(Sender: TObject);
begin
  Str_search := '';
  FormGrid.SelectedField.ReadOnly := False;
  FormGrid.Options := [dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,
                                        dgRowLines,dgTabs,dgCancelOnExit];
end;
{
  Процедура при попадании на столбец
  При перемещении со столбца на столбец параметы поиска должны обнулиться
}
procedure TLIST_4SELECTForm.FormGridDblClick(Sender: TObject);
begin
  Str_search := '';
  FormGrid.SelectedField.ReadOnly := False;
  FormGrid.Options := [dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,
                                            dgRowLines,dgTabs,dgCancelOnExit];
  ModalResult := mrOK;
end;
{
    Процедура перерирования колонки при вводе символов
    Описание: при вводе строки поиска по первым символам производится
    перекрашиывание совпадающих симповолов стрики. 
}
procedure TLIST_4SELECTForm.FormGridDrawColumnCell(Sender: TObject;
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
procedure TLIST_4SELECTForm.FormGridKeyDown(Sender: TObject; var Key: Word;
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
                                dgColLines,dgRowLines,dgTabs,dgCancelOnExit];
     end;
   // если нажата клавиша Return, то возвращаяем значение
   if key = 13 then
     ModalResult := mrOK;
end;
{
   По нажатию на кнопку в таблице производится поиск записи по первым символам
}
procedure TLIST_4SELECTForm.FormGridKeyPress(Sender: TObject;
  var Key: Char);
const
  Valid_Key = ['0'..'9', 'A'..'z','А'..'я', '-', '#', '/','.',',','"','ё','Ё'];
  // массив символов ограничен
begin

  // Если введен символ №, то введен символ #
  if char(key) = '№' then
    key := '#';


  If (char(Key) in Valid_Key) then
    begin
       FormGrid.EditorMode := FALSE;
       FormGrid.SelectedField.ReadOnly := False;
       FormGrid.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgCancelOnExit];
       // вызов процедуры поиска
       Quick_Search(FormGrid,FormGrid.SelectedField.FieldName,Key,qFormQuery,STR_search, searching);
    end;
  // если нажата backspace или пробел
  if ((char(Key) = #8)  OR (char(Key) = ' ')) AND Searching then begin
    FormGrid.EditorMode := FALSE;
    FormGrid.Options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgTabs,dgCancelOnExit];
    FormGrid.selectedfield.ReadOnly := True;
    // вызов процедуры поиска
    Quick_Search(FormGrid,FormGrid.SelectedField.FieldName,Key,qFormQuery,STR_search, searching);
  end;

end;
{
      Процедура окончания редактирования окна поиска
      и начало поиска
}
procedure TLIST_4SELECTForm.Search_stringKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    find(qFormQuery, FormGrid, Search_string.text, 1);

end;
{
   Начало поиска по подстроке по нажатию кнопки
}
procedure TLIST_4SELECTForm.SearchButtonClick(Sender: TObject);
begin
  find(qFormQuery, FormGrid, Search_string.text, 1);
end;
{
    Поиск вниз

}

procedure TLIST_4SELECTForm.DownButtonClick(Sender: TObject);
begin
    if not qFormQuery.eof then qFormQuery.next;
    find(qFormQuery, FormGrid, Search_string.text, 1);

end;
{
    Поиск вверх

}

procedure TLIST_4SELECTForm.UpButtonClick(Sender: TObject);
begin
    if not qFormQuery.bof then qFormQuery.prior;

    find(qFormQuery, FormGrid, Search_string.text, -1);

end;

{
   Установка сортировки по коду
}
procedure TLIST_4SELECTForm.N2Click(Sender: TObject);
 var id : integer;
begin
  id := qFormQuery.fieldbyname('id').asinteger;
  qFormQuery.sql.clear;
  qFormQuery.close;
  qFormQuery.sql.add(tQueryText);
  qFormQuery.Sql.add('order by code');
  qFormQuery.open;
  qFormQuery.locate('ID',  ID, [loCaseInsensitive]);
end;
{
   Установка сортировки справочника по наименованию
}
procedure TLIST_4SELECTForm.N3Click(Sender: TObject);
 var id : integer;
begin
  id := qFormQuery.fieldbyname('id').asinteger;
  qFormQuery.sql.clear;
  qFormQuery.close;
  qFormQuery.sql.add(tQueryText);
  qFormQuery.Sql.add('order by name');
  qFormQuery.open;
  qFormQuery.locate('ID',  ID, [loCaseInsensitive]);
end;
{
  Установка сортировки справочника по ID
}
procedure TLIST_4SELECTForm.N4Click(Sender: TObject);
 var id : integer;
begin
  id := qFormQuery.fieldbyname('id').asinteger;
  qFormQuery.sql.clear;
  qFormQuery.close;
  qFormQuery.sql.add(tQueryText);
  qFormQuery.Sql.add('order by ID');
  qFormQuery.open;
  qFormQuery.locate('ID',  ID, [loCaseInsensitive]);
end;



end.
