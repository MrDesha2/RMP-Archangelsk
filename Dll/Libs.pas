{
    Модуль представляет собой функции, наиболее встречающиеся

    Quick_Search - процедура поиска в таблице по первым символам;
    Find         - процедура поиска по подстроке во всех колонках таблицы;
    Refreshquery - обновление параметров запроса;
    checkIfExistCode - проверка существования элемента справочника с заданным кодом;
    SelectFromTable  - процедура выбора элемента из справочной таблицы.
    move_rows        - процедура замены местами строк в таблицах


}

unit Libs;


interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Grids, DBGridEh, ImgList, DBGrids, DBCtrls, ToolEdit,
  EnumForm4Sel;



// процедура поиска по первым символам
procedure Quick_Search(Grid : TDBGridEh;
   Field : string ;
     Key : char;
   Query : tquery;
   var STR_search : string; var searching : boolean);

// процедура поиска по подстроке во всех колонках таблицы
procedure find(Query : tquery; grid :TDBGridEh; text :string; direction : integer);

// процедура обновления запроса
procedure refreshquery( Query: tquery);

// процедура проверки на существование элемента справочника с кодом
function checkIfExistCode(var qQuery: tQuery; var Combo : tComboEdit; key: Word;
  Shift: TShiftState; FieldType : integer) : boolean;

// процедура выбора значения из справочной таблицы
procedure SelectFromTable(ListForm : TLIST_4SELECTForm; var Query : tQuery; var Combo : TComboEdit;
                          tQueryText : string; tCaption : string; FieldType : integer);

// функция представления цветовой гаммы
Function EditColor(AOwner:TComponent; AColor:TColor):TColor;

  var  ESC_Key : Boolean ;

implementation

{
   Процедура поиска записи по первым символам в любой таблице
  На входе: Таблице типа TDBGridEh (!);
            Наименование поля, по которому производится поиск;
            Символ с клавиатуры;
            Запрос по которой формируется таблица;
            Строка поиска;
            признак выполнения поиска.

}
procedure Quick_Search(Grid : TDBGridEh;
   Field : string ;
     Key : char;
   Query : tquery;
   var STR_search : string; var searching : boolean);
var i : integer;
   len: integer;
   val: string;
begin
  Query.DisableControls;
  try
    len := length(str_search);

      //установка режима для столбца
    If len = 0 then
     begin
       for i:=0 to Grid.FieldCount-1 do
          Grid.Columns[i].Title.SortMarker := smNoneEh;
       Grid.FieldColumns[Field].Title.SortMarker := smDownEh;
     end;


      IF Key = #8 then // это backspace
         begin
          IF   Len = 0 then // если длина 0, то строка поиска пустая
             STR_search := ''
          else   // иначе уменьшается длина строки поиска на 1
            STR_search := copy (STR_search,1, Len - 1);
        end
      else // в противном случае добавляем символ поиска
        STR_search := AnsiUpperCase(STR_search + char(Key)) ;

      len := length(str_search);
      searching := true;
      // а теперь мой поиск
      while not Query.eof  do
        begin
           val := Query.fieldbyname(Field).asstring;
           val := copy(ansiUpperCase(val),1, len);
           if val = STR_search then
             begin
                exit;
             end;
           Query.next;
        end;

  finally
    Query.EnableControls;
  end;

end;
{
               Процедура поиска по подстроке в таблице
   Описание: производит перебор всех строк и колонок и
     ищет вхождение подстроки в значение.
   Вход: Запрос таблицы,
         Таблица класса TDBGridEh,
         Строка поиска.
         Направление поиска

}
procedure find(Query : tquery; grid :TDBGridEh; text :string; direction : integer);
var field : string;
    val : string;
    J : integer;
begin
  // а теперь мой поиск
//  Query.first;
  while ((not Query.eof) and (direction = 1))  or
        ((not Query.bof) and (direction = -1)) do

    begin
      for j := 0 to grid.FieldCount - 1 do
        begin
           field := grid.Columns[j].FieldName;
           val := Query.fieldbyname(field).asstring;
           if POS( AnsiUpperCase(text), AnsiUpperCase(val)) > 0 then
             begin
               exit;
             end;
         end;

        if direction = 1 then
          Query.next

        else
          Query.Prior;


     end;
end;

{
    Процедура обновления таблицы
}
procedure refreshquery( Query: tquery);
 var id : integer;
begin
   id := query.fieldbyname('id').asinteger;
   Query.close;
   Query.open;
   query.locate('ID',  ID, [loCaseInsensitive]);
end;
{
   Функция     checkIfExistCode
   Вход:  запрос формы, в котором ищется запись с заданным кодом
          Поле, в которое возвращаяется поле Name в случае успеха поиска
          строка поиска кода,
          состояние кнопок Shift.
   Выход: true  в случае удачного поиска,
          false иначе.
   Описание:
      Функция ищет с заданной таблице запроса запись, для которой поле CODE
         совпадает с заданным и в случае успеха заполняет значением поля Name
         поле Combo.
}
function checkIfExistCode(var qQuery: tQuery; var Combo : TComboEdit;
        key: Word; Shift: TShiftState; FieldType : integer) : boolean;
var i : integer;
    s: char;
begin
  result := true;
  // это кнопка ентер и без контрола
  if (key = 13) and (Shift <> [ssCtrl]) then
    begin
      qQuery.close;
      // поле "Код" может быть как символьным, так и числовым
      if FieldType = 1 then
        qQuery.ParamByName('code').asstring := AnsiUpperCase(copy(combo.text, 0, 8))
      else
        begin
         // проверка на длину введенной строки. по пустой искать нечего
         if Length(Combo.text) = 0 then exit;

         // проверка, все ли символы являются числами
         for i := 1 to Length(combo.text) do
           begin
             s := combo.text[i];
             if not (s in ['0'..'9']) then
               begin
                 showmessage('Неправильный формат кода');
                 exit;
               end;
           end;
         qQuery.ParamByName('code').asinteger:= strtoint(copy(combo.text, 0, 8));
        end;
      // можно пытаться искать в запросе
      qQuery.ParamByName('id').asinteger   := -1;
      qQuery.open;
      qQuery.ParamByName('id').asinteger := qQuery.fieldbyname('ID').asinteger;
      if not qQuery.eof then
         Combo.text := qQuery.fieldbyname('name').asstring
        else
         result := false;
    end
  else
   // по бакспейсу чистим поле
   if key = 8 then
     begin
      Combo.text := '';
      qQuery.ParamByName('id').asinteger := -1;
      qQuery.ParamByName('code').asstring:= '';
      qQuery.close;
      
     end;

end;
{
  Процедура  SelectFromTable
  Вход: query - запрос, из которого производится выбор значения,
        combo - объект типа ComboEdit, в который возращается значение поля Name,
        tQueryText - текст запроса по таблице,
        tCaption   - сообщение в заголовке окна выбора.
        FieldType  - тип значения поля CODE (для всех справочников разное)
  Выход: в переменной Combo возвращается значение выбора.
  Описание:
    Процедура производит выбор из справочной таблице. Значение поля Name
    возращается в переменной Combo.

}
procedure SelectFromTable(ListForm : TLIST_4SELECTForm; var Query : tQuery; var Combo : TComboEdit;
                          tQueryText : string; tCaption : string; FieldType : integer);
begin

  LISTForm.openQuery(tQueryText);
  LISTForm.Caption := tCaption;
  if Combo.Text = '' then
    LISTForm.IDRec := 0
  else
    LISTForm.IDRec := Query.ParamByName('ID').asinteger;
  if LISTForm.showmodal = mrOK then
    begin
      Query.close;
      if FieldType = 1 then
         Query.ParamByName('code').asstring := ''
      else
         Query.ParamByName('code').asinteger := -1;

      Query.ParamByName('ID').asinteger  := LISTForm.IDRec;
      Query.open;
      Combo.text := Query.fieldbyname('name').asstring;
    end;

end;


Function EditColor(AOwner:TComponent; AColor:TColor):TColor;
Begin
  With TColorDialog.Create(AOwner) do
  try
    Color:=AColor;
    if Execute then AColor:=Color;
  finally
    Free;
  end;
  result:=AColor;
end;


end.
