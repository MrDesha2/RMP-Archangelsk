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
  OrderEditForm, PRDocEditForm, RSDocEditForm, base, ParamForm, Main,
  inifiles, Menus, strutils;


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
function checkIfExistCode(var Combo : tComboEdit; key: Word;
  Shift: TShiftState) : boolean; export; stdcall;

// процедура выбора значения из справочной таблицы
function SelectFromTable(var Combo : TComboEdit): integer; export; stdcall;

procedure SetParamCombo(Param : tParam; Combo : TComboEdit);

// Процедура ввода на основании заказа документа "Приходная накладная"

function CreateNewPR_Doc(IDDoc : integer; Sender: TForm; onlycheck : integer; lNMNTDoc : tList): integer;


// Процедура ввода на основании приходной накладной новой расходной
function CreateNewRS_Doc(IDDoc, type_doc : integer; date_doc : string; sender : tForm; lNMNTDoc : tList): integer;


// Функция проверки уникальности кодов при сохранении
function ChechUniqueCode(tablename , FieldName, Code: string;  id : integer): integer;

// Функция поиска ID новой записи в справочнике
function findIDbyCode(tablename, Code : string) : integer;

{
   Процедура заполнения периодами списка
}
procedure FillPeriodCombo(PeriodBox : tComboBox);

{
  Процедура формирования основного меню
}
procedure Make_main_menu(Form: TMAINForm);

function beginofmonth(_date : tdate): tdate;
function endofmonth(_date : tdate): tdate;

procedure ClearStr(var Str_search: string; var FormGrid : TDBGridEh);

{
 Процедура заполнения списка перечислений
}
procedure fill_enumeration(List : tComboBox; enumname : string);


{
  Процедура получения наименования реквизита
}
function getfieldname(tableone, tabletwo, fieldname: string; id : integer): pRecord;


{
   Процедура установки списка отбора журнала
   Вход: запрос журнала
   Выход: строка фильтра отбора
}
function setfilterlist(query : tQuery): string;

{
  Функция получения значения фильтра из строки фильтров
  Вход: строка фильтра; имя параметра фильтра
  Выход: значение фильтра;

}
function getfiltervalue(filterlist, filtername : string) : string;

{-----------------------------------------------------------------------------
  Процедура: checkgrand
  Описание: Проверка прав доступа к объектам
-----------------------------------------------------------------------------}

function check_user_grand(tablename : string; privilege : char; showmessage : boolean): boolean;

procedure myMessage(messtext : string);

function  GetColumnsList(tablename : string; grid : tDBGridEh) : string;
procedure SetColumnList(tablename : string; grid : tDBGridEh; query :tQuery; filters : string);


implementation

uses EnumTree4Select,
        EnumForm4Sel;

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
   var STR_search : string;
    var searching : boolean);

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

      EscPressed := false;

      // а теперь мой поиск
      while not (Query.eof or EscPressed) do
        begin
           val := Query.fieldbyname(Field).asstring;
           val := copy(ansiUpperCase(val),1, len);

           // проверка на совпадение
           if val = STR_search then
             begin
                exit;
             end;

           // Смотрим, были ли события
           Application.ProcessMessages;
           if EscPressed = true then exit;

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

  if text = '' then exit;

  if direction > 0 then
    if not Query.eof then Query.next;

  if direction < 0 then
    if not Query.bof then Query.prior;  

  EscPressed := false;
  Searching   := true;

  Query.DisableControls;

  while ((not Query.eof) and (direction = 1))  or
        ((not Query.bof) and (direction = -1))
        do

    begin
      for j := 0 to grid.FieldCount - 1 do
        begin
           field := grid.Columns[j].FieldName;
           val := Query.fieldbyname(field).asstring;
           if POS( AnsiUpperCase(text), AnsiUpperCase(val)) > 0 then
             begin
               Searching := false;
               grid.setfocus;
               Query.EnableControls;
               exit;
             end;
         end;

        if direction = 1 then
          Query.next

        else
          Query.Prior;

        application.ProcessMessages;
        if EscPressed = true then
          begin

           Searching := false;
           Query.EnableControls;
           exit;
          end;

     end;

     Searching := false;
     Query.EnableControls;

end;

{
    Процедура обновления таблицы
}
procedure refreshquery( Query: tquery);
 var id : integer;
begin
   if not Query.active then exit;
   id := query.fieldbyname('id').asinteger;
   Query.close;
   Query.open;
   query.locate('ID',  ID, [loCaseInsensitive]);
end;
{
   Функция     checkIfExistCode
   Вход:
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
function checkIfExistCode(var Combo : TComboEdit;
        key: Word; Shift: TShiftState) : boolean; export; Stdcall;
var i : integer;
    s: char;
    FieldType : word;
    codelen   : integer;
begin
  result := true;

  if (Combo.Query = nil) then Exit;

  // это кнопка ентер и без контрола
  if (key = 13) and (Shift <> [ssCtrl]) then
    begin
     codelen := 10;
     try
       // проверка на тип поля "Code"
       if (Combo.Query.FieldByName('Code').DataType = ftString) then
        begin
         FieldType := 1;
         codelen := Combo.Query.Fieldbyname('CODE').Size;
        end
       else
         FieldType := 0;
     except
        FieldType := 1;
     end;


      Combo.Query.close;
      // поле "Код" может быть как символьным, так и числовым
      if FieldType = 1 then
         Combo.Query.ParamByName('code').asstring := leftstr(AnsiUpperCase(trim(combo.text)), codelen)
      else
        begin
         // проверка на длину введенной строки. по пустой искать нечего
         if Length(Combo.text) = 0 then
           begin
            Combo.ID := -1;
            result   := false;
            exit;
           end;

         // проверка, все ли символы являются числами
         for i := 1 to Length(combo.text) do
           begin
             s := combo.text[i];
             if not (s in ['0'..'9']) then
               begin
                 showmessage('Неправильный формат кода');
                 Combo.ID   := -1;
                 Combo.text := '';
                 result := false;
                 exit;
               end;
           end;
           Combo.Query.ParamByName('code').asinteger:= strtoint(trim(combo.text)); //copy(combo.text, 0, 8));
        end;
      // можно пытаться искать в запросе
      Combo.Query.ParamByName('id').asinteger   := -1;
      Combo.Query.open;
//      qQuery.ParamByName('id').asinteger := qQuery.fieldbyname('ID').asinteger;
      if not Combo.Query.eof then
          begin
             Combo.text := Combo.Query.fieldbyname('name').asstring;
             Combo.ID   := Combo.Query.FieldByName('ID').Asinteger;
          end
        else
         result := false;
    end
  else
   // по бакспейсу чистим поле
   if (key = 8) and (Shift = [ssShift]) then
     Combo.ID := -1;

end;
{
  Процедура  SelectFromTable
  Вход:  combo - объект типа ComboEdit, в который возращается значение поля Name,
  Выход: в переменной Combo возвращается значение выбора.
  Описание:
    Процедура производит выбор из справочной таблице. Значение поля Name
    возращается в переменной Combo.

}
function SelectFromTable(var Combo : TComboEdit): integer; export; stdcall;
var qFindQuery : tQuery;
    FieldType  : integer;
begin

  result := -1;

  if not Combo.Query.Active then
    Combo.Query.open;

  if Combo.Query.Fields[1].FieldName <> 'PARENTID' then
    begin

     LIST_4SELECTForm.openQuery('select id, code, name from ' + Combo.Tablename);
     LIST_4SELECTForm.Caption := Combo.TableDescription;
     if Combo.Text = '' then
       LIST_4SELECTForm.IDRec := 0
     else
       LIST_4SELECTForm.IDRec := Combo.Query.ParamByName('ID').asinteger;

     if LIST_4SELECTForm.showmodal = mrOK then
       begin
         if Combo.Query.FieldByName('Code').DataType = ftInteger then
           FieldType := 0
           else
            FieldType := 1;

         Combo.Query.close;

         if FieldType = 1 then
            Combo.Query.ParamByName('code').asstring := ''
         else
            Combo.Query.ParamByName('code').asinteger := -1;

         Combo.Query.ParamByName('ID').asinteger  := LIST_4SELECTForm.IDRec;
         Combo.Query.open;
         Combo.text := Combo.Query.fieldbyname('name').asstring;
         Combo.ID   := Combo.Query.fieldbyname('ID').asinteger;
         result := Combo.Query.Fields[0].asinteger;
       end;
    end

   else

     begin

       LIST_TREE4SelectForm.Caption := Combo.TableDescription;
       LIST_TREE4SelectForm.FormName:= Combo.TableDescription;

       qFindQuery := tQuery.create(application);
       qFindQuery.DatabaseName := data.RMPBase.DatabaseName;

       with qFindQuery do
        begin
         sql.add('select code from ' + Combo.TableName);
         sql.add('where id = ' + Combo.Query.ParamByName('ID').asstring);
         open;
         LIST_TREE4SelectForm.CodeSearchKey.text := qFindQuery.Fields[0].asstring;
       end;


       LIST_TREE4SelectForm.openQuery('select id, parentid, isfolder, code, name from '
                      + Combo.TableName);
       if Combo.Text = '' then
        LIST_TREE4SelectForm.IDRec := 0
       else
        LIST_TREE4SelectForm.IDRec := Combo.Query.ParamByName('ID').asinteger;


       if LIST_TREE4SelectForm.showmodal = mrOK then
        begin
         if Combo.Query.FieldByName('Code').DataType = ftInteger then
           FieldType := 0
           else
            FieldType := 1;

          if not Combo.CanSelectGroup then
            begin
              if LIST_TREE4SelectForm.qFormQuery.FieldByName('isfolder').AsInteger = 1 then
                begin
                  MessageDlg('Нельзя выбирать группу', mtWarning, [mbOK], 0);
                  result := -1;
                  exit;
                end;
            end;

          Combo.Query.close;

          if FieldType = 1 then
             Combo.Query.ParamByName('code').asstring := ''
          else
             Combo.Query.ParamByName('code').asinteger := -1;

          Combo.Query.ParamByName('ID').asinteger  := LIST_TREE4SelectForm.IDRec;
          Combo.Query.open;
          Combo.text := Combo.Query.fieldbyname('name').asstring;
          Combo.ID   := Combo.Query.fieldbyname('ID').asinteger;
          result := Combo.Query.Fields[0].asinteger;

        end;
     end;


end;





{

      Процедура создания нового приходного документа по приходной накладной
      Описание: производит выполнение хранимых процедур на
                создание нового документа типа "Приходная накладная", в

      Вход: ID документа заказ,
            форма родительская,
            признак: 0 - только проверка, 1 - создание
            sGrid - таблица значений
              sGrid[0] - ID заказа
                    1  - ID_CST - заказчик;
                    2  - PR_CHRT признак чертежа
                    3  - ID_NMNT номенклатура
                    4  - NUMBER количество
                    5  - PRICE цена
      Выход: ID - ID нового документа при удачном создании, -1 - иначе


}

function CreateNewPR_Doc(IDDoc : integer; Sender: TForm; onlycheck : integer; lNMNTDoc : tList): integer;

  var qFindQuery : tQuery;
      Proc_add_pr_doc : TstoredProc;
      Proc_add_pr_table: TStoredProc;
      Form  : TDOC_PRForm;
      ID_PR : integer;      // ID приходной
      is_created : boolean;
      j, i   : integer;
      lineno : integer;
      foundstr : string;


    aNMNT     : pNMNT;
    aNMNTDoc  : pNMNTDoc;
    lNMNT     : tList;

    Hour, Min, Sec, MSec: Word;
    _now : TDateTime;
begin

   // выполнение запроса на нахождение приходной накладной по этому документу
  qFindQuery             := TQuery.Create(sender);
  qFindQuery.DatabaseName:= 'RMP';

  is_created := false;

  // Проверка. Выбрана ли хоть одна запись
    if lNMNTDoc = nil then
      begin
        result := -1;
        exit;
      end;

    if lNMNTDoc = nil then
      begin
        result := -1;
        exit;
      end;

    if lNMNTDoc.Count = 0 then
      begin
        result := -1;
        exit;
      end;

      // создание запроса на нахождение приходного документа с таким заказом
      qFindQuery.sql.clear;
      qFindQuery.Sql.add('select a.id, a.numdoc, a.date_in, c.code');
      qFindQuery.Sql.add(' from dh_pr a, dt_pr b, spr_nmnt c');
      qFindQuery.Sql.add('  where a.id = b.id_prmtr and c.id = b.id_nmnt and ');
      qFindQuery.Sql.add('      b.id_ord = :id_ord');

  // перебор всех записей списка
  // где хранится информация о документе
  //
  for j := 0 to lNMNTDoc.Count - 1 do

    begin
      aNMNTDoc := lNMNTDoc.items[j];
      lNMNT    := aNMNTDoc^.lNMNT;
      foundstr := '';

      for i := 0 to lNMNT.Count - 1 do
        begin
          aNMNT := lNMNT.Items[i];

          qFindQuery.close;
          qFindQuery.ParamByName('id_ord').asinteger := aNMNT^.ID_ORDER;
          qFindQuery.open;

          // если нашли, то выход
          if (not qFindQuery.Eof) then
            begin
              qFindQuery.First;

              foundstr := 'Приход на основании заказа уже введен'+#13+#10+'под номером '
                         + qFindQuery.Fieldbyname('numdoc').asstring + ' от '
                         +  qFindQuery.Fieldbyname('date_in').asstring
                         + ' номенклатурный номер '
                         +  qFindQuery.Fieldbyname('code').asstring + ' ';

              aNMNT^.Info := foundStr;

            end;


        end;

    end;

    result := 1;
    if onlycheck = 0 then
      begin
        if foundstr <> '' then
          result := -1
        else
          result := 1;

        exit;
      end;

  // проверка прав на добавление документа
  if not check_user_grand('DH_PR', 'I', true) then exit;

 try
  // начало транзакции
  data.RMPBase.StartTransaction;


  // создание хранимой процедуры для создания документа "Приходная накладная"
  Proc_add_pr_doc := data.ADD_DH_PR_PROC;
  aNMNTDoc := lNMNTDoc.Items[0];

  // нахождение номера приходной накладной
  qFindQuery.sql.clear;
  qFindQuery.sql.add('select max(numdoc) as M from dh_pr');
  qFindQuery.open;

  Proc_add_pr_doc.ParamByName('NUMDOC').asinteger  := qFindQuery.Fields[0].asinteger + 1;
  Proc_add_pr_doc.ParamByName('ID_CST').asinteger  := aNMNTDoc^.ID_CST;
  // дата проставляется из текущей
  _now := param_form.WorkDateEdit.Date;
//  _now := now;
  DecodeTime(_now, Hour, Min, Sec, MSec);
  hour := 0;
  min  := 0;
  sec  := 0;

  Proc_add_pr_doc.ParamByName('DATE_IN').asdate    := Param_Form.WorkDate;
  Proc_add_pr_doc.ParamByName('ID_WRHS').asinteger := aNMNTDoc^.ID_WRHS;
  Proc_add_pr_doc.ParamByName('INFO').value        := aNMNTDoc^.Info;

  // Признак чертежа
  Proc_add_pr_doc.ParamByName('PR_CHRT').value     := aNMNTDoc^.Type_doc;

  // Признак "Подписана"
  Proc_add_pr_doc.ParamByName('PR_EXEC').asinteger := 0;


  Proc_add_pr_doc.ExecProc;

  // теперь IDDOC - это ID нового документа "Приходная накладная"
  ID_PR := Proc_add_pr_doc.ParamByName('IDDoc').asinteger;


  // на возврат в случае удачного создания документа ID созданного документа.
  result := ID_PR;


  //*******************************************************************
  // Шапка документа создана. Создается табличная часть.


  lineno := 1;
  // создание табличной формы приходной накладной
  Proc_add_pr_table          := data.ADD_DT_PR_PROC;
  lNMNT := aNMNTDoc^.lNMNT;

  for j := 0 to lNMNT.Count - 1 do

    begin

       // получили элемент табличной части из списка
       aNMNT := lNMNT.Items[j];

       if aNMNT^.ID_matr = 0 then
         begin

           MessageDlg('В заказе не указан номенклатурный номер.', mtError, [mbOK], 0);
           data.RMPBase.Rollback;
           exit;
           
         end;

      if aNMNT^.Info <> '' then
        MessageDlg(aNMNT^.Info, mtWarning, [mbOK], 0)

      else

        begin

         is_created := true;


             Proc_add_pr_table.ParamByName('ID_PRMTR').asinteger := ID_PR;
             Proc_add_pr_table.ParamByName('DateDOC').asdate     := param_form.WorkDate;
             Proc_add_pr_table.ParamByName('LINENO').asinteger   := lineno;
             Proc_add_pr_table.ParamByName('ID_NMNT').asinteger  := aNMNT^.ID_matr;
             Proc_add_pr_table.ParamByName('NUMBER').asfloat     := aNMNT^.nValue;
             Proc_add_pr_table.ParamByName('PRICE').asfloat      := aNMNT^.Price;

             Proc_add_pr_table.ParamByName('ID_EDIZ').asinteger  := aNMNT^.ID_EdIz;
             Proc_add_pr_table.ParamByName('ID_WRHS').asinteger  := param_form.qWRHSQuery.Fieldbyname('id').asinteger;
             Proc_add_pr_table.ParamByName('ID_ORD').asinteger   := aNMNT^.ID_ORDER;
             Proc_add_pr_table.ParamByName('LENG').asfloat       := aNMNT^.nLenght;
             Proc_add_pr_table.ParamByName('HIGHT').asfloat      := aNMNT^.nHeight;
             Proc_add_pr_table.ParamByName('WIDTH').asfloat      := aNMNT^.nWidth;
             Proc_add_pr_table.ParamByName('WEIGHT').asfloat     := aNMNT^.nWeight;

             Proc_add_pr_table.ExecProc;

             lineno := lineno + 1;

       end;

    end;

  if is_created then
     begin
       data.RMPBase.Commit;

       // открытие формы редактирования документа
       Form := TDOC_PRForm.CreateN(sender, ID_PR, nil);
        Form.show;

       mymessage('Введен приходный документ ' + Form.DocNum.Text + ' от ' + Form.DateDoc.text);
     end

  else

     data.RMPBase.Rollback;

 except

  data.RMPBase.Rollback;
  result := -1;
 end;

end;


{

      Процедура создания нового расходного  документа по готовой продукции
      если заказ полностью выполнен.
      Описание: производит выполнение хранимых процедур на
                создание нового документа типа "Приходная накладная", в
                случае полного выполнения заказа.

      Вход: IDDoc - ID приходной накладной
            вид документа - расходная или акт выполненных работ,
            дата документа
            Форма, откуда вызвана процедура
            lNMNTDoc - список значений полей документа
      Выход: ID - ID нового документа при удачном создании, -1 иначе


}

function CreateNewRS_Doc(IDDoc, type_doc : integer; date_doc : string; sender : tForm; lNMNTDoc : tList ): integer;
  var qFindQuery : tQuery;
      Proc_add_rs_doc  : TstoredProc;
      Proc_add_rs_table: TStoredProc;
      Form  : TDOC_RSForm;
      ID_RS : integer;        // ID расходной
      j, i : integer;
      lineno : integer;
      is_created : boolean;

     foundstr : string;

    aNMNT     : pNMNT;
    aNMNTDoc  : pNMNTDoc;
    lNMNT     : tList;

    Hour, Min, Sec, MSec: Word;
    _now : TDateTime;


begin

   // выполнение запроса на нахождение приходной накладной по этому документу
  qFindQuery             := TQuery.Create(sender);
  qFindQuery.DatabaseName:= 'RMP';


  // Проверка. Выбрана ли хоть одна запись
  if lNMNTDoc = nil then
    begin
      result := -1;
      exit;
    end;

  if lNMNTDoc.Count = 0 then
    begin
      result := -1;
      exit;
    end;


  // выполнение запроса для нахождения заказа по ID
  //  result := -1;
  is_created := false;

  // формирование запроса на нахождение расходного документа с таким заказом
  // во избежание повторов
  with qFindQuery do
    begin
      sql.clear;
      sql.add('select a.numdoc, a.date_in, c.code');
      sql.add('from dh_rs a, dt_rs b, spr_nmnt c');
      sql.add('where a.id = b.id_rsmtr and b.id_nmnt = c.id and b.id_ord = :iddoc');


    end;

  // дата проставляется из текущей
  _now := param_form.WorkDateEdit.Date;
//  _now := now;
  DecodeTime(_now, Hour, Min, Sec, MSec);
  hour := 12;
  min  := 0;
  sec  := 0;


  // перебор всех записей списка
  // где хранится информация о документе
  //
  for j := 0 to lNMNTDoc.count - 1  do

    begin

      aNMNTDoc := lNMNTDoc.items[j];
      lNMNT    := aNMNTDoc^.lNMNT;
      foundstr := '';

      // Проверка, если ли уже расход по такому заказу.
      for i := 0 to lNMNT.Count - 1 do
        begin
          aNMNT := lNMNT.Items[i];
          aNMNT.Info := '';

           with qFindQuery do
            begin
              close;
              params[0].asinteger := aNMNT^.ID_ORDER;
              open;
             end;

          // если нашли, то выход
          if (not qFindQuery.Eof) then
            begin
              qFindQuery.First;

              foundstr := 'Расход на основании заказа уже введен'+#13+#10+'под номером '
                         + qFindQuery.Fieldbyname('numdoc').asstring + ' от '
                         +  qFindQuery.Fieldbyname('date_in').asstring
                         + ' номенклатурный номер '
                         +  qFindQuery.Fieldbyname('code').asstring + ' ';

              aNMNT^.Info := foundStr;

            end;


        end;

    end;

  result := 1;
  // проверка прав на добавление
  if not check_user_grand('DH_RS', 'I', true) then exit;


  try
    // начало транзакции
    data.RMPBase.StartTransaction;
    aNMNTDoc := lNMNTDoc.Items[0];

    // создание хранимой процедуры для создания документа "расходная накладная готовой продукции"
    Proc_add_rs_doc := data.ADD_DH_RS_PROC;

    // нахождение номера расходной накладной
    qFindQuery.sql.clear;
    qFindQuery.sql.add('select max(numdoc) as M from dh_rs');
    qFindQuery.open;

    Proc_add_rs_doc.ParamByName('NUMDOC').asinteger  := qFindQuery.Fields[0].asinteger + 1;
    Proc_add_rs_doc.ParamByName('ID_CST').asinteger  := aNMNTDoc^.ID_CST;


    Proc_add_rs_doc.ParamByName('DATE_IN').asdate    := Param_form.workdate;
    Proc_add_rs_doc.ParamByName('ID_WRHS').asinteger := aNMNTDoc^.ID_WRHS;
    Proc_add_rs_doc.ParamByName('INFO').value        := aNMNTDoc^.Info;
    Proc_add_rs_doc.ParamByName('PR_EXEC').asinteger := 0;  // поле означает, что документ не отдан заказчику




    // определение типа документа: акт или расходная

    Proc_add_rs_doc.ParamByName('TYPE_DOC').asinteger := aNMNTDoc^.Type_doc;



    Proc_add_rs_doc.ExecProc;


    // теперь IDDOC - это ID нового документа "Расходная накладная"
    ID_RS := Proc_add_rs_doc.ParamByName('IDDoc').asinteger;

    // возврат ID документа в случае удачного создания
    result := ID_RS;


    //*******************************************************************
    // Шапка документа создана. Создается табличная часть.



    lineno := 1;
    // создание табличной формы расходной накладной
   Proc_add_rs_table          := data.ADD_DT_RS_PROC;

   lNMNT := aNMNTDoc^.lNMNT;

   for j := 0 to lNMNT.Count - 1 do

    begin

       // получили элемент табличной части из списка
       aNMNT := lNMNT.Items[j];

       if aNMNT^.ID_matr = 0 then
         begin

           MessageDlg('В заказе не указан номенклатурный номер.', mtError, [mbOK], 0);
           data.RMPBase.Rollback;
           exit;
           
         end;
       

      if aNMNT^.Info <> '' then
        MessageDlg(aNMNT^.Info, mtWarning, [mbOK], 0)

      else

          begin

           is_created := true;


               Proc_add_rs_table.ParamByName('ID_RS').asinteger    := ID_RS;
               Proc_add_rs_table.ParamByName('LINENO').asinteger   := lineno;
               Proc_add_rs_table.ParamByName('ID_NMNT').asinteger  := aNMNT^.ID_matr;
               Proc_add_rs_table.ParamByName('NUMBER').asfloat     := aNMNT^.nValue;
               Proc_add_rs_table.ParamByName('PRICE').asFloat      := aNMNT^.Price;
               Proc_add_rs_table.ParamByName('ID_EDIZ').asinteger  := aNMNT^.ID_EdIz;
               Proc_add_rs_table.ParamByName('ID_WRHS').asinteger  := aNMNTDoc^.ID_WRHS;
               Proc_add_rs_table.ParamByName('ID_ORD').asinteger   := aNMNT^.ID_ORDER;
               Proc_add_rs_table.ParamByName('LENG').asfloat       := aNMNT^.nLenght;
               Proc_add_rs_table.ParamByName('HIGHT').asfloat      := aNMNT^.nHeight;
               Proc_add_rs_table.ParamByName('WIDTH').asfloat      := aNMNT^.nWidth;
               Proc_add_rs_table.ParamByName('WEIGHT').asfloat     := aNMNT^.nWeight;

               Proc_add_rs_table.ParamByName('DateDOC').asdate     := Param_form.workdate;

               Proc_add_rs_table.Prepare;
               Proc_add_rs_table.ExecProc;

               if Proc_add_rs_table.ParamByName('ERROR').asinteger = 1 then
                 begin
                    MessageDlg('Ошибка при создании расходного документа.', mtError, [mbOK], 0);
//                  MessageDlg('На дату ' + datetostr(now) + ' на складе ' + aNMNTDoc^.Name_WRHS
//                   + ' есть остаток ' + formatfloat('0.000', Proc_add_rs_table.paramByName('Rem_value').asfloat)
//                   + ' из необходимых ' + formatfloat('0.000', aMaterial^.nValue)
//                   + ' номенклатуры ' + aMaterial^.Name_matr + '.'
//                   + #13+#10+'Документ не сохранен.', mtError, [mbOK], 0);

                    result := -1;
                    break;

                 end;

               lineno := lineno + 1;


           end;

      end;

    if is_created then
       begin
         data.RMPBase.Commit;

         // открытие формы редактирования документа
          Form := TDOC_RSForm.CreateN(sender, ID_RS, 1, nil);
          Form.show;

          mymessage('Введен расходный документ ' + Form.DocNum.text + ' от ' + Form.DateDoc.text);
       end

    else

       data.RMPBase.Rollback;

   except

       data.RMPBase.Rollback;
       result := -1;
   end;


end;

//******************* ChechUniqueCode *************************
//  Функция проверяет уникальность кода в таблице
//  Вход: имя таблицы,
//        поле проверки,
//        значение поля
//        Id записи
//  Выход: id другой записи с таким же кодом в случае неудачи,
//         -1 в случае положительного исхода.
 
function ChechUniqueCode(tablename , FieldName, Code : string;  id : integer): integer;

var Query : tQuery;

begin

   Query := tQuery.create(application);
   Query.databasename := 'RMP';
   Query.sql.add('select id from ' + tablename + ' where ' + FieldName + ' = :code');
   query.parambyname('code').asstring := code;
   Query.open;

   if not Query.eof then
     begin
       if Query.Fields[0].asinteger <> id then
         result := Query.Fields[0].asinteger
       else
         result := -1;
     end
   else
     result := -1;

end;



{-----------------------------------------------------------------------------
  Функция: findIDbyCode
  Автор:     Администратор
  Дата:      31-авг-2004
  Аргументы: tablename, Code : string
  Выход:     integer
  Описание:  Возвращает ID вновь введенной записи
-----------------------------------------------------------------------------}
function findIDbyCode(tablename, Code : string) : integer;
var qQuery : tQuery;

begin
  qQuery := tQuery.create(application);
  qQuery.DatabaseName := data.RMPBase.DatabaseName;
  with qQuery do
    begin
      sql.Clear;
      sql.Add('select ID from ' + tablename + ' where code = :code');
      params[0].asstring := code;
      open;
    end;

  if not qQuery.Eof then
    result := qQuery.Fields[0].asinteger
   else
     result := -1;   

end;

{

   Процедура заполнения периодами списка

}
procedure FillPeriodCombo(PeriodBox : tComboBox);
var Year, Month, Day: Word;
 nYear, nMonth, nDay: Word;     // текущая дата
    j, N            : integer;
    _date, _now       : TDate;
    strMon, strDate : string;
begin
   PeriodBox.Clear;
   // заполнение списка периодов
   _date := strtodate('01.01.2000');
   _now := date; // текущая дата
   DecodeDate(_now, nYear, nMonth, nDay);
   if nYear < 2000 then
     N := 1
   else
     N := nYear - 2000;

   for j := 0 to 12 *(N + 1) do
    begin
      DecodeDate(_date, Year, Month, Day);
      case Month of
         1 : StrMon := 'Январь';
         2 : StrMon := 'Февраль';
         3 : StrMon := 'Март';
         4 : StrMon := 'Апрель';
         5 : StrMon := 'Май';
         6 : StrMon := 'Июнь';
         7 : StrMon := 'Июль';
         8 : StrMon := 'Август';
         9 : StrMon := 'Сентябрь';
         10 : StrMon := 'Октябрь';
         11 : StrMon := 'Ноябрь';
         12 : StrMon := 'Декабрь';
      end;
      StrDate := StrMon + ' ' + inttostr(Year);
      PeriodBox.Items.Add(StrDate);
      _date := incmonth(_date, 1);
    end;

end;


//******************* Make_main_menu *************************
//
//Вход:
//Выход:
//Описание:
//  Формирует основное меню программы из файла ini

procedure Make_main_menu(Form: TMAINForm);
var FileName : string;
     lIniFile: tInifile;
    i   : integer;
    str : tstrings;
    menuitem, parent : tmenuitem;
begin
  FileName := ExtractFilePath(Application.EXEName) + 'dll.ini';  //1/12/10
//  FileName := GetEnvironmentVariable('APPDATA') + '\EnumRMP\dll.ini';
  lIniFile := TIniFile.Create(FileName);

  str := TStringList.Create;
  lIniFile.ReadSections(str);
  form.MainMenu.Items[4].Clear;
  parent     := form.MainMenu.Items[4];

  for i := 0 to  str.Count - 1 do
    begin
       menuitem := TMenuItem.Create(Form);
       menuitem.Name    := str.strings[i];
       menuitem.Caption := lIniFile.ReadString(str.strings[i],'Caption','Не нашел');
       menuitem.Hint    := lIniFile.ReadString(str.strings[i],'Hint','');

       if lIniFile.ReadInteger(str.strings[i],'Submenu',0) = 1 then
         parent := menuitem
       else
         menuitem.OnClick := mainform.Print_Report_Click;




       if lIniFile.ReadString(str.strings[i],'Parent','') <> '' then
         begin
             parent.add(menuitem);

         end
       else
         form.MainMenu.Items[4].Add(menuitem);


    end;

end;
{-----------------------------------------------------------------------------
  Процедуры работы с датами
  Автор:     Администратор
  Дата:      16-июн-2004
  Аргументы: None
  Выход:     None
  Описание:
-----------------------------------------------------------------------------}
function beginofmonth(_date : tdate): tdate;
var _year, _month, _day : word;
begin
  decodedate(_DATE, _year, _month, _day);
  result := encodedate(_year, _month, 1);
end;

function endofmonth(_date : tdate): tdate;
begin
  result := incmonth(_date, 1) - 1;
end;


procedure ClearStr(var Str_search: string; var FormGrid : TDBGridEh);
begin
  Str_search := '';
  FormGrid.SelectedField.ReadOnly := False;
  FormGrid.Options := [dgEditing,dgTitles,dgIndicator,dgColumnResize,dgColLines,
                                            dgRowLines,dgCancelOnExit];
end;




{-----------------------------------------------------------------------------
  Процедура: myMessage
  Автор:     Администратор
  Дата:      01-сен-2004
  Аргументы: messtext : string
  Выход:     None
  Описание:  Процедура вывода информации в окно сообщений
-----------------------------------------------------------------------------}
procedure myMessage(messtext : string);
begin
   MainForm.MessageWin.Lines.Add(messtext);
   MainForm.MessageWin.Refresh;
end;

{-----------------------------------------------------------------------------
  Процедура: checkgrand
  Автор:    Administrator
  Аргументы: table - имя таблицы, privilege - право доступа
  Результат: результат проверки
  Описание:  проверяет права на редактирование таблицы
-----------------------------------------------------------------------------}
function check_user_grand(tablename : string; privilege : char; showmessage : boolean): boolean;
var str : string;
    res : boolean;
begin
  with data.qCheckGrandQuery do
   begin
     close;
     parambyname('USERNAME').asstring := uppercase(data.glRole);
     parambyname('object').asstring   := uppercase(tablename);
     parambyname('privelege').asstring:= privilege;
     open;

   end;
   // если права не заданы, то по умолчанию прав нет
   if data.qCheckGrandQuery.Eof then
     res := false
    else
      res := true;

   if res then
     result := true
    else
      begin
        case privilege of
          'i','I': str := 'добавления';
          's','S': str := 'чтения';
          'u','U': str := 'редактирования';
          'd','D': str := 'удаления';
          'x','X': str := 'просмотра/выполнения';
         end;

         if showmessage then
           MessageDlg('Нет прав для ' +  str + ' объекта', mtWarning, [mbOK], 0);

        result := false;
     end;



end;
{-----------------------------------------------------------------------------
  Procedure: SetParamCombo
  Author:    Desha
  Date:      22-июн-2005
  Arguments: Param : tParam; Combo : TComboEdit
    Устанавливает значение параметра из Combo
-----------------------------------------------------------------------------}

procedure SetParamCombo(Param : tParam; Combo : TComboEdit );
begin
  if (Combo = nil) or (Combo.ID = -1) then
    begin
      Param.DataType := ftInteger;
      Param.Clear;
//      Param.AsInteger := -1;
    end
   else
     Param.asinteger := Combo.ID;

end;

function GetColumnsList(tablename : string; grid : tDBGridEh): string;
var i, j : integer;
    s : array [0..100] of integer;
    v : string;
    filter, val : string;
    list   : tstringlist;
    Params : tParams;
begin
  data.TableDefProc.ParamByName('username').AsString  := uppercase(data.glUserName);
  data.TableDefProc.ParamByName('tablename').AsString := uppercase(tablename);
  data.TableDefProc.ParamByName('coldef').AsString    := '';
  data.TableDefProc.ParamByName('TYPEWORK').asinteger := 0;
  data.TableDefProc.ExecProc;

//  filter := data.TableDefProc.ParamByName('FILTERDEFOUT').asstring;

  if data.TableDefProc.ParamByName('COLDEFOUT').asstring = '' then
    begin
      for i := 0 to grid.Columns.Count - 1 do
        grid.Columns[i].Visible := true;
    end
    else
     begin
       v := data.TableDefProc.ParamByName('COLDEFOUT').asstring;
       if leftstr(v, 1) = '0' then
         grid.AutoFitColWidths := false
         else
          grid.AutoFitColWidths := true;

       i := 0;
       j := 1;
       while (length(v) > 0) and (j > 0) do
         begin
          j    := pos('[', v);
          v    := rightstr(v, length(v) - j);
          s[i] := strtoint(leftstr(v, 1));
          i    := i + 1;
         end;

       for i := 0 to grid.Columns.Count - 1 do
         if s[i] = 1 then
           grid.Columns[i].Visible := true
           else
            grid.Columns[i].Visible := false;




     end;
   Params := tParams.Create;
   list   := tStringList.Create;

  if data.TableDefProc.ParamByName('FILTERLIST').asstring <> '' then
    begin
      list.Text := data.TableDefProc.ParamByName('FILTERLIST').asstring;
      for i := 0 to list.Count - 1 do
        begin
          val    := list.Strings[i];
          v      := leftstr(val,pos('=',val) - 1);
          filter := rightstr(val, (length(val) - 1 - pos('=',val)));

          if filter = '' then
            filter := '-1';
          with Params.CreateParam(ftString, v, ptInput) do
            AsString := filter;
        end;

    end;

  result := '';

end;

procedure SetColumnList(tablename : string; grid : tDBGridEh; query : tquery; filters : string);
var i : integer;
    s, v : string;
    filter : string;

begin
  s := '';
  if grid.AutoFitColWidths then
   s := s + '1'
    else
     s := s + '0';

  for i := 0 to grid.Columns.Count - 1 do
    begin
      v := '[';
      if grid.Columns[i].Visible then
        v := v + '1'
         else
          v := v + '0';


      s := s + v + ']';
    end;

//  filter := setfilterlist(query);
  try
    data.RMPBase.StartTransaction;
    data.TableDefProc.ParamByName('username').AsString   := uppercase(data.glUserName);
    data.TableDefProc.ParamByName('tablename').AsString  := uppercase(tablename);
    data.TableDefProc.ParamByName('coldef').AsString     := s;
    data.TableDefProc.ParamByName('TYPEWORK').asinteger  := 1;
    data.TableDefProc.ExecProc;
    data.RMPBase.Commit;
  except
    data.RMPBase.Rollback;
  end;

end;


{-----------------------------------------------------------------------------
  Procedure: fill_enumeration
  Author:    Desha
  Date:      16-ноя-2005
  Arguments: List : tComboBox - список значений
  Result:  заполненный список

    Процедура заполнения списка перечислениями из базы
-----------------------------------------------------------------------------}

procedure fill_enumeration(List : tComboBox; enumname : string);
begin
  List.Items.Clear;

  with data.sys_enumerationQuery do
    begin
      Close;
      params[0].asstring := enumname;
      open;
      first;
      while not eof do
        begin
          List.Items.Add(fields[1].asstring);
          next;
        end;
     end;

end;



{-----------------------------------------------------------------------------
  Procedure: getfieldname
    Получает наименование значения поля
  Author:    Desha
  Date:      05-дек-2005
  Arguments: tableone,  - основная таблица
             tabletwo,  - таблица справочника
             fieldname: string; - имя поля в основной таблице
             id : integer - id Записи
  Result:    string
-----------------------------------------------------------------------------}
function getfieldname(tableone, tabletwo, fieldname: string; id : integer): pRecord;
var qgetfieldname : tQuery;
begin
  qgetfieldname := tQuery.Create(data);
  qgetfieldname.DatabaseName := data.RMPBase.DatabaseName;
  with qgetfieldname do
    begin
      SQL.Clear;
      sql.Add('select a.name, a.id from ' + tabletwo + ' a, ' + tableone + ' b');
      sql.Add('where a.id = b.' + fieldname);
      sql.Add('and b.id = ' + inttostr(id));
      open;
    end;

   new(result);
   if not qgetfieldname.Eof then
      begin
        result.id   := qgetfieldname.Fields[1].asinteger;
        result.name := qgetfieldname.Fields[0].asstring
      end
    else
      begin
        result.id   := -1;
        result.name := '';
      end;

end;



{
   Процедура установки списка отбора журнала
   Вход: запрос журнала

}
function setfilterlist(query : tQuery): string;
var i :integer;
    s : string;
begin
   s := '';
   if query.Active then
     begin
       for i := 0 to query.ParamCount - 1 do
         begin
           s := s + query.Params[i].Name + '=' + query.Params[i].AsString + ';';
         end;
     end;
  result := s;
end;
{
  Функция получения значения фильтра из строки фильтров
  Вход: строка фильтра; имя параметра фильтра
  Выход: значение фильтра;

}
function getfiltervalue(filterlist, filtername : string) : string;
var l,s : integer;
    str : string;
begin

  s := pos(uppercase(filtername), uppercase(filterlist));
  if  s > 0 then
    begin
      l   := length(filtername);
      str := rightstr(filterlist, Length(filterlist) - s  -  l + 1);
      l   := pos(';', str);
      s   := pos('=', str) + 1;
      str := midstr(str, s, l - 2);
    end;
  result := str;
end;


end.
