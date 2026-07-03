{***************************************************************
 *
 * Unit Name: OrderEditLibs
 * Purpose  : Процедуры для формы редактирования документа Заказ
 * Author   :
 * History  :
 *  Процедура расчета нормативно-плановых затрат заказа
 *   procedure OrderCalculation(Doc: TDOC_ORDERForm; Iddoc: integer);
 *  Процедура формирования информационной строки в заказе
 *   procedure Create_OrderInfostring(Doc: TDOC_ORDERForm; IDDOC: integer);
 *  Процедура расчета нормативно-плановых затрат операции заказа
 *   procedure Operation_calculate(Doc: TDOC_ORDERForm; Operform: TDOCT_OPERForm; Iddoc: integer);
 *
 ****************************************************************}

unit OrderEditLibs;

interface

uses
  Db, DBTables, Libs, SysUtils, classes, Grids, ToolEdit, math, rxStrUtils,
  OrderEditForm, // форма редактирования документа Заказ
  OROPEditForm,  // форма редактирования операции заказа
  PRDocEditForm,
  DocStructFrm;

{

   Процедура заполнения поля "Оборудование" на основании введенного чертежа

   Вход: qCHRTQuery - запрос работы с полем ввода "Чертеж"
         qEQPTQuery - запрос работы с полем ввода "Оборудование"
         Combo      - поле ввода "Оборудование"
   Выход: поле Combo  - новое значение
   Описание: производит поиск оборудования по чертежу.
}

procedure Fill_EQPT_Combo(CHRTCombo, EQPTCombo : TComboEdit);


{

   Процедура заполнения поля "Номенклатура" на основании введенного чертежа

   Вход: qCHRTQuery - запрос работы с полем ввода "Чертеж"
         qNMNTQuery - запрос работы с полем ввода "Номенклатура"
         Combo      - поле ввода "Номенклатура"
   Выход: поле Combo  - новое значение
   Описание: производит поиск номенклатуры по чертежу.
}


procedure Fill_NMNT_Combo(CHRTCombo, NMNTCombo : TComboEdit);


{
    Процедура проверки готовности заказа
}

procedure check_fact_operation(sender : TDOC_ORDERForm);

{
   Процедура заполнения строк таблиц документа "ЗАказ"
}

procedure  Fill_table(Form : TDOC_ORDERForm);
{

  Процедура отбора по строке материалов
}

procedure MakeSelectMTR(var Grid: TStringGrid; lMaterials : tList; lOperation : tList; needshowall : boolean);
{

  Процедура отбора по строке оборудования
}
procedure MakeSelectEQPT(var Grid: TStringGrid; lEQPTs : tList; lOperation : tlist; needshowall : boolean);

{

  Процедура отбора по строке трансортных средств
}
procedure MakeSelectTransport(var Grid: TStringGrid; lTransports : tList; lOperation : tlist; needshowall : boolean);

{

   Процедура расчета нормативно-плановых затрат заказа
}
procedure OrderCalculation(lFactOperations, lMainCosts : tList; number_f : real);

{
   Процедура формирования информационной строки в заказе
}
procedure Create_OrderInfostring(Doc: TDOC_ORDERForm; IDDOC: integer);

{
   Процедура расчета нормативно-плановых затрат операции заказа
}
function Operation_calculate(Doc: TDOC_ORDERForm;  aOperation   : pOperation; Iddoc: integer): tList;

{

   Процедура замены элементов списка

}
function Change_enum_list_pos( List : tList; CurPos , NewPos : integer): boolean;

{

   Функция проверки данных расчета себестоимости заказа.

}
function Check_cost_operaion(Doc: TDOC_ORDERForm) : boolean;

{
    Процедура заполнения поля "Статистика"
    автоматически после выбора поля "МВЗ".
    Справочник МВЗ содержит информацию по статье статистики

}
procedure fill_stat_field(Form :TDOC_ORDERForm );

{

   Процедура заполнения табличных форм документа при открытии
   Описание: получает данные из таблиц базы данных и формирует динамические
   списки данных по операциям, материалам и затратам.

}
procedure  Get_Table_data( Form : TDOC_ORDERForm);
{

      Процедура определения вида чертежа заказа по его ID
      Определяет это либо
        - изготовление
        - ремонт (Реставрация).
      Вход: форма заказа.


}
procedure SetVidChrt( Form : TDOC_ORDERForm);

{
   Процедура заполнения структуры Номенкталура для документов
    "Приход готовой продукции", "Расход готовой продукции",
    "Поступление материалов", "Отпуск материалов".
   Вход: запрос табличной формы, в которую записываются данные из
         БД.
         структура, в которой остаются заполненные данные.
   Выход: пусто

}
procedure Get_Table_NMNT_data( qQuery : tQuery; lList : tList);

{
  Функция заполнения таблицы формы документа данными из динамического
  массива данных.
  Вход: массив данных (список),
        таблица формы (Stringgrid);

}
procedure Fill_NMNT_table( lList : tList; Grid : tStringGrid);



{
   Процедура заполнения структуры ОБорудование для документов
    "Поступление инструмента", "Отпуск инструмента",
   Вход: запрос табличной формы, в которую записываются данные из
         БД.
         структура, в которой остаются заполненные данные.
   Выход: пусто

}
procedure Get_Table_EQPT_data( qQuery : tQuery; lList : tList);
{
  Функция заполнения таблицы формы документа данными из динамического
  массива данных.
  Вход: массив данных (список),
        таблица формы (Stringgrid);

}
procedure Fill_EQPT_table( lList : tList; Grid : tStringGrid);


{
  Функция проверки состояния заказа и его подчиненных документов
}
function Check_order_state_and_child(iddoc: integer; Doc: TDOC_ORDERForm) : boolean;


{
  Функция:   Get_sum_order_by_calc
     Возвращает сумму документа заказ по статье затрат.
     Для внутренних подразделений это статья цеховой себестоимости,
     для сторонних - полная себестоимость без НДС.
}
function Get_sum_order_by_calc(ID : integer; is_cst_int : integer): real;

{

   Функция поиска веса изделия по его чертежу.
   Вызывается при выборе чертежа в заказе

}
function FindWeightByChrt(id_chrt : integer): real;



implementation

uses Base, Dialogs, CurrEdit, ParamForm;
{

      Процедура рассчета затрат заказа
      Вход: Doc - форма документа, в которой производтся расчет затрат
            Iddoc - идентификатор документа.

      Выход: в форме документа заполнена таблица затрат.
      Описание: рассчитывает нормативно-плановые затраты заказа

}
procedure OrderCalculation(lFactOperations, lMainCosts : tList; number_f : real);

var sum_op          : real;    // суммы прямых затрат на операции и материалы
    qTMPQuery       : TQuery;  // запрос формирования затрат
    i,j,k           : integer; // циклические переменные
    id_op           : integer; // id операции

    lOpCalc         : tList;   // список затрат операции
    aCalculation, aOpCalc   : pCalculation;  // указатель затрату операции
    aOperation              : pOperation;    // указатель на операцию

begin

  if lFactOperations = nil then
    exit;

// во временный запрос выгружаются все строки справочнка затрат
    qTMPQuery := tQuery.Create(data);
    qTMPQuery.DatabaseName := data.RMPBase.DatabaseName;
    qTMPQuery.sql.clear;
    qTMPQuery.sql.add('select id, code, name from spr_calc order by code');
    qTMPQuery.open;

// Очистка списка затрат заказа
    lMainCosts.Clear;

// заполние таблицы затрат
    k := 1;
    while not qTMPQuery.Eof do

      begin

        // результат запроса заносится в таблицу
        id_op := qTMPQuery.FieldbyName('Id').asinteger;

        // перебор всех фактических операций
        sum_op := 0;
        for i := 0 to lFactOperations.Count - 1 do
         begin
            aOperation := lFactOperations.Items[i];
            lOpCalc    := aOperation^.lCalcs;
            // перебор всех статей затрат операции
            for j := 0 to lOpCalc.Count - 1 do
              begin
                aOpCalc := lOpCalc.Items[j];
                // суммирование по всем одинаковым статьям всех операций
                if aOpCalc^.ID_calc = id_op then
                  sum_op := sum_op + aOpCalc^.nvalue;

              end;

         end;

        new(aCalculation);
        aCalculation^.lineno    := k;
        aCalculation^.ID_calc   := qTMPQuery.fields[0].asinteger; // ID затраты
        aCalculation^.Name_calc := qTMPQuery.fields[2].asstring; // наименование статьи затрат
        aCalculation^.nvalue    := sum_op;
        k := k  + 1;

        lMainCosts.Add(aCalculation);

        qTMPQuery.next;
      end;

   // Полученные результаты необходимо умножить на количество изделий по факту
   if lMainCosts <> nil then
    for i := 0 to lMainCosts.count - 1 do
      begin
        aCalculation := lMainCosts.Items[i];
        aCalculation^.nvalue := aCalculation^.nvalue;// * number_f;

       end;

   qTMPQuery.Free;

end;


{

    Процедура расчета затрат операции.
    Вход: Doc - форма документа Заказ, где откуда рассчитываются затраты операции
          Oper - форма редактирования фактической операции заказа, откуда
             рассчитываются затраты операции
          Iddoc - идентификатор документа.
    Выход: в документе заказ заполнена таблица затрат операции в форме
           редактирования операции.

}
function Operation_calculate(Doc: TDOC_ORDERForm;  aOperation   : pOperation; Iddoc: integer): tList;
var sum_op, sum_mtr : real;    // суммы прямых затрат на операции и материалы
    sum_transport   : real;    // сумма транспортных затрат
    qCalcQuery      : TQuery;  // запрос формирования затрат
    qTMPQuery       : TQuery;  // запрос формирования затрат
    i,j             : integer; // циклические переменные
    val             : real;    // величина затрат
    Customer_is_int : integer; // признак заказчика: внутренний или внешний
    need_calc       : integer; // признак необходимости расчета величины затрат для заказчика
    percent         : real;    // процент отчислений

    customer_property : integer; // свойство принадлежности для элемента справочника "Заказчики"

    aCalculate_val  : array [0..20] of real; // массив для расчета затрат

    lMaterials : tList;        // список указателей по материалам
    aMaterial  : pMaterial;    // указатель на материал
    lCalcs     : tList;        // список указателей по затратам
    aCalc      : pCalculation; // указатель на затраты
    lTransports: tList;        // список указателей по транспортным средствам
    aTransport : pTransport;    // указатель на транспорт

begin
{

   Стоимость выполненной операции заказа складывается из прямых затрат и
   косвенных. Прямые затраты - это стоимость всех выполненной по факту операций
   и стоимость потраченного материала.
   Косвенные затраты находятся в процентном отношении к величине прямых затрат.
   Проценты косвенных затрат задаются справочно и могут быть изменены в таблице
   spr_cost.



   Сначала находится стоимость всех выполненных операций.
   Стоимость операций указывается в 8-й колонке таблицы Grid_OperFact.

   Алгоритм расчета затрат
   1. Материалы = Сумма потраченных матералов
   2. Зарплата  = Сумма выполненных операций
   3. Отчисления в соцстрах = Стр 2 * процент отчислений (справочно).
   4. Накладные расходы = Стр 2 * процент отчслений + Сумма транспортных расходов
   5. Цеховая себестоимость = Сумма 1 - 4
   6. Общезаводские = Стр 4 * процент
   7. Производственная = Сумма 5 + Сумма 6
   8. Плановые накопления = Стр 7 * процент
   9. Полная с/ст = Сумма 7 + Сумма 8.
   10. НДС = Стр 9 * процент
   11. Всего = 9 + 8

}
   sum_op := aOperation^.price;

// Далее находится стоимость всех потраченных материалов.
  lMaterials := aOperation^.lMaterials;
  lTransports := aOperation^.lTransports;
//  lCalcs     := aOperation^.lCalcs;


  //
  lCalcs := tList.Create;


  sum_mtr       := 0;

  if aOperation^.lMaterials <> nil then
    for i := 0 to aOperation^.lMaterials.Count - 1 do
      begin
        aMaterial := lMaterials.items[i];
        sum_mtr   := sum_mtr + aMaterial^.nCost;
      end;

  sum_Transport := 0;

  if aOperation^.lTransports <> nil then
    for i := 0 to aOperation^.lTransports.Count - 1 do
      begin
        aTransport    := lTransports.items[i];
        sum_Transport := sum_Transport + Round(aTransport^.nValue * aTransport^.Cost * 100)/100;
      end;


// формирование запроса по нахождению статей косвенных затрат
    qCalcQuery  := data.MainCalculateQuery;

{
    // данные хранятся в таблице затрат по датам.
    // значения берутся на дату документа.

    Необходимо выбрать в справочнике затрат те записи,
    для которых принадлежность к подразделению равна Заказ.Заявка.Подразделение.ID
    а признак принадлежности >= признаку внутренний" Заказ.Заявка.Заказчик.Is_instr

}


    // выполнение запроса по статьям косвенных затрат
    qCalcQuery.close;
    qCalcQuery.paramByName('idvop').asinteger := aOperation^.ID_op;
    qCalcQuery.open;

    // определение признака заказчика: внутренний или внешний
    qTMPQuery := tQuery.Create(Doc);
    qTMPQuery.databasename := 'RMP';
    qTMPQuery.close;
    qTMPQuery.sql.clear;
    qTMPQuery.sql.add('select a.IS_INSTR from spr_cst a, dh_order b, dh_rqst c');
    qTMPQuery.sql.add(' where c.id_cst = a.id and b.id_rqst = c.id and b.id = ' + inttostr(iddoc));
    qTMPQuery.open;

    Customer_is_int := 0;
    if not qTMPQuery.eof then

      if (qTMPQuery.Fields[0].asinteger = 1) or
         (qTMPQuery.Fields[0].asinteger = 2)
       then
        Customer_is_int := 1;

// Необходимо найти признак заказчика для проверки найденных данных
    qTMPQuery.Close;
    qTMPQuery.sql.clear;
    qTMPQuery.sql.add('select a.is_instr from spr_cst a, dh_order b, dh_rqst c');
    qTMPQuery.sql.add('  where a.id = c.id_cst and c.id = b.id_rqst and b.id = ' + inttostr(iddoc));
    qTMPQuery.open;

//  Признак заказчика запоминается
    customer_property := 1;
    if not qTMPQuery.Eof then

       customer_property :=  qTMPQuery.Fields[0].asinteger;



// Теперь во временный запрос выгружаются все строки справочнка затрат
    qTMPQuery.Close;
    qTMPQuery.sql.clear;
    qTMPQuery.sql.add('select id, code, name from spr_calc order by code');
    qTMPQuery.open;

// очистка массива затрат
    for i := 0 to 20 do
      aCalculate_val[i] := 0;


// заполние таблицы затрат
    while not qTMPQuery.Eof do

      begin

        // результат запроса заносится в таблицу
        i := qTMPQuery.FieldbyName('Code').asinteger;
        new(aCalc);

        aCalc^.Name_calc := qTMPQuery.fields[2].asstring; // наименование статьи затрат
        aCalc^.ID_calc   := qTMPQuery.fields[0].asinteger; // ID затраты
        aCalc^.lineno    := i;

        
        // необходимость расчета величины затрат
        need_calc := 0;

        // позиционируется на величину затрат в запросе затрат по МВЗ
        if qCalcQuery.Locate('code', i, [loCaseInsensitive]) then

          begin

            percent   := qCalcQuery.FieldbyName('NValue').asfloat;
            percent:=Round(percent*100)/100;

            if qCalcQuery.fieldbyname('is_int').asinteger >= Customer_is_int then
               need_calc := 1;

          end
        else

            percent   := 0;


        val := 0;
        case i of
          1:  val := Round(sum_mtr * need_calc*100)/100; // strtofloat(trim(number_f.text)); // материалы

          2:  begin

                val := Round(sum_op * need_calc*100)/100; //* strtofloat(trim(number_f.text));  // зарплата

                {

                        Проверка.

                    Если величина заработной платы > 0, а затраты должны относиться на заказ, то
                    это ошибка. Иначе, если зарплата = 0, то затраты относятся не на заказ, то это
                    тоже ошибка.
                    Если затраты относятся на заказ, то признак  IS_INSTR для заказчика должен быть равен 3.


                }
                if   ((customer_property < 2) and (val = 0)) then

//                  showmessage('Для заказчика ' + LabelCustomer.Caption + ' величина заработной платы не должна быть равной 0!');

                if   ((customer_property = 2) and (val > 0)) then

//                  showmessage('Для заказчика ' + LabelCustomer.Caption + ' величина заработной платы должна быть равной 0!');




              end;

          3:  val := Round(percent * sum_op / 100 * need_calc*100)/100; //* strtofloat(trim(number_f.text));
                                        // социальный налог

          4:  val := Round(percent * sum_op / 100 * need_calc*100)/100+sum_transport; //* strtofloat(trim(number_f.text));
                                        // накладные расходы

          5:  begin

                for j := 1 to 4 do
                  val := val + aCalculate_val[j];

                val := val * need_calc;
                                         // цеховая себестоимость
              end;
          6:  val := (percent* aCalculate_val[5])/100 * need_calc;

                                         // общезаводские расходы
          7:  val := (aCalculate_val[5] + aCalculate_val[6]) * need_calc;
                                         // производственная с/ст

          8:  val := (aCalculate_val[7] * percent)/100 * need_calc;
                                         // плановая себест

          9:  val := (aCalculate_val[7] + aCalculate_val[8]) * need_calc;
                                         // полная себестоимость

          10:  val := (aCalculate_val[9] * percent)/100 * need_calc;
                                         // НДС

          11: val := (aCalculate_val[10] + aCalculate_val[9]) * need_calc;

        end;

        aCalculate_val[i] := val; // * strtofloat(trim(Doc.number_f.text));
        aCalc^.nvalue := val; // * strtofloat(Doc.Number_F.text);  // величина

        lCalcs.Add(aCalc);

        qTMPQuery.next;
      end;

      // умножаем все на количество по факту
     if Doc.Number_F.Value = 0 then
       MessageDlg('Количество изделий по факту 0.', mtError, [mbOK], 0);

     if lCalcs <> nil then
      for i := 0 to lCalcs.Count - 1 do
       begin
         aCalc := lCalcs.Items[i];
         aCalc^.nvalue := aCalc^.nvalue * Doc.number_f.Value;

       end;

     result := lCalcs;

end;


{

    Процедура формирования информационной строки по затратам

}

procedure Create_OrderInfostring(Doc: TDOC_ORDERForm; IDDOC: integer);

var str                  : string;
    sum_op, sum, sum_mtr : real; // суммы
    qTMPQuery       : TQuery;  // запрос формирования затрат
    i, j : integer;
    lMaterials      : tList;     // список указателей по материалам
    aMaterial       : pMaterial; // указатель на материал
    aCalc           : pCalculation; // указатель на затраты
    aOperation      : pOperation;   // указатель на операцию


begin
   // формирование информационной строки
    str := '';

    qTMPQuery := tQuery.Create(Doc);
    qTMPQuery.databasename := 'RMP';

    // Формирование запроса для нахождения заказчика
    qTMPQuery.sql.clear;
    qTMPQuery.sql.Add('select a.name, a.is_instr ');
    qTMPQuery.sql.Add('from spr_cst a, dh_order b, dh_rqst c');
    qTMPQuery.sql.Add('where a.id = c.id_cst and');
    qTMPQuery.sql.Add('  c.id = b.id_rqst and b.id = ' + IntToStr(IDDOC));
    qTMPQuery.open;

    // если заказ не существует, то выход
    if qTMPQuery.eof then
      exit;

    str := str + 'Заказчик: ' + qTMPQuery.Fields[0].asstring;
    if qTMPQuery.Fields[1].asinteger = 0 then
      str := str + ' -   сторонняя организация ' + chr(13)
    else
      str := str + ' -   внутренее подразделение' + chr(13);

     str := str + 'Количество по факту ' + Doc.number_f.text + ';';


     // Определение стоимости операций и материалов
     sum_op  := 0;
     sum_mtr := 0;

     
     if Doc.lFactOperations <> nil then
      for i := 0 to Doc.lFactOperations.count - 1 do
        begin
          aOperation := Doc.lFactOperations.Items[i];
          lMaterials := aOperation^.lMaterials;
          sum_op := sum_op + aOperation^.price;

          // если список материалов не пустой
          if lMaterials <> nil then
            for j := 0 to lMaterials.Count - 1 do
              begin
               aMaterial := lMaterials.Items[j];
               sum_mtr   := sum_mtr + aMaterial^.nCost;
             end;
       end;

     sum_op  := sum_op   * Doc.number_f.value;

     sum_mtr := sum_mtr  * Doc.number_f.value;


     sum := 0;
     if Doc.GridCalc.cells[3, Doc.GridCalc.rowcount - 1] <> '' then
       begin
         aCalc := Doc.lMainCosts.Last;
         if aCalc^.Name_calc <> 'Всего' then
           sum := 0
         else
           sum   := aCalc^.nvalue;

         // найти цеховую себестоимость заказа  
         for j := 0 to Doc.lMainCosts.Count - 1 do
           begin
             aCalc := Doc.lMainCosts.Items[j];
             if aCalc.ID_calc = 6 then
               Doc.sum_order := aCalc.nvalue;
           end;
       end;


     str := str +  'Cтоимость выполненных операций: ' + FormatFloat( '0.00', sum_op) + ' руб;' + chr(13) +
      'Стоимость материалов: ' + FormatFloat( '0.00', sum_mtr) + ' руб; ' +
      'Общая стоимость : ' + FormatFloat( '0.00', sum) + ' руб ';

    Doc.CalcINFO.Caption := str;
    Doc.Sum_doc.caption  := ' ' + FormatFloat( '0.00', sum);

    {
       Проверка стоимости заказа. Строимость выполненного заказа
       не должна сильно отличаться от

    }
    with qTMPQuery do
      begin
        sql.Clear;
        sql.Add('select nmnt.price from spr_nmnt nmnt, dh_order ord');
        sql.add('where nmnt.id = ord.id_nmnt and ord.id = :id');
        params[0].AsInteger := doc.IDDoc;
        open;
      end;
    {
       Запрос не пустой. В заказе указана номенклатура
    }
    if not qTMPQuery.Eof then
      begin
        if roundto(qTMPQuery.Fields[0].Asfloat * doc.Number_F.value - sum, -2) <> 0 then
          begin
            str := 'Цена номенклатуры ' + Doc.NMNTCombo.Text + ' ' +
                 FormatFloat( '0.00', qTMPQuery.Fields[0].Asfloat ) + '.';
            Doc.ErrorCalcLabel.Caption := str;
            Doc.ErrorCalcLabel.Top := Doc.CalcINFO.Top + Doc.CalcINFO.Height + 1;
          end;
      end;


    Doc.CalcInfo.Repaint;
    Doc.ErrorCalcLabel.Repaint;

end;

{

   Процедура замены элементов списка

}
function Change_enum_list_pos( List : tList; CurPos , NewPos : integer): boolean;
begin
  result := false;

  if List = nil then exit;

  if (List.Count = 0) then exit;

  if (NewPos < 0) or (NewPos >= List.count) then exit;

  List.Exchange(CurPos, NewPos);

  result := true;

end;


{-----------------------------------------------------------------------------
  Функция: Check_order_state_and_child
  Дата:      29-апр-2004
  Аргументы: iddoc
  Возврат:   Check_order_state_and_child : boolean
  Описание:  Проверяет состояние заказа (признак выполнения) и
             наличие подчиненных документов. Если состояние изменено
             на < 3, и существуют приходные и расходные документы по
             готовой продукции на основании данного заказа, то это ошибка.
-----------------------------------------------------------------------------}
function Check_order_state_and_child(iddoc: integer; Doc: TDOC_ORDERForm) : boolean;
var List : tStringList;
begin
   {
     Структура содержит подчиненные документы для заказа
     0 - ID заявки, 1 - номер заявки, 2 - дата
     3 - ID заказа
     6 - ID прихода,
     9 - ID расхода.

   }
   List := DOC_Structure_Form.Find_consistency(IdDoc);


   result := false;
   // Признак выполнения заказа < 3
   if (Doc.PR_EXEC.Checked) or (Doc.PR_EXEC1.Checked) then
     begin
       // признак заказа < 3, а документы есть
       if (trim(list[6]) <> '-1') or (trim(list[9]) <> '-1') then
         begin
           MessageDlg('Признак выполнения заказа не совпадает со статусом.'+#13+#10+'Есть подчиненные документы. Документ не сохранен.', mtError, [mbOK], 0);
           result := true;

         end;
     end;

end;

{
    Функция проверки себестоимости заказа.
    Вход: контекст формы заказа.
    Выход: истина в случае совпадения данных, ложь - иначе.
    Описание:
      Данные по себестоимости расчетов храняться в
      операциях, общая же себестоимость заказа находится в
      таблице расчета себестомости. Данные по себестоимости
      каждой операции должны совпадать с итоговой себестоимостью.

}

function Check_cost_operaion(Doc: TDOC_ORDERForm) : boolean;
var
     aMainCost, aCost : pCalculation; // указатель на затраты
     lCosts            : TList;       // список затрат
     aOperation   : pOperation;       // указатель на операцию

     i, j, k : integer;
     sum_1, sum_2  : real;            // суммы
begin
  result := true;

  sum_1       := 0;
  sum_2       := 0;

  if Doc.lMainCosts <> nil then
   for i := 0 to Doc.lMainCosts.count - 1 do
    begin

      aMainCost := Doc.lMainCosts.Items[i];
      sum_1     := sum_1 + aMainCost.nvalue;
    end;

   if Doc.lFactOperations <> nil then
    for j := 0 to Doc.lFactOperations.count - 1 do
     begin
       aOperation := Doc.lFactOperations.Items[j];

       lCosts := aOperation^.lCalcs;

       if lCosts <> nil then
        for k := 0 to lCosts.Count - 1 do
         begin
           aCost := lCosts.Items[k];
           sum_2   := sum_2 + aCost.nvalue;
         end;

     end;

  //  count := strtofloat(trim(doc.number_f.Text));
  //  sum_2 := sum_2 * count;
    sum_1 := sum_1 - sum_2;

    if roundto(sum_1, -2) <> 0 then
     result := false;

end;

{

   Процедура заполняет на основании данных из динамических массивов в
   визуальные таблицы формы.

}

procedure  Fill_table(Form : TDOC_ORDERForm);
var i, j : integer;
        aOperation   : pOperation;  // указатель на операцию
        aMaterial    : pMaterial;   // указатель на материал операции
        aEQPT        : pEQPT;       // указатель на оборудование операции
        aTransport   : pTransport;  // указатель на транспортные средства операции
        lMaterials   : tList;       // список материалов
        lEQPTs       : tList;       // список оборудования
        lTransports  : tList;       // список транспорта
        aCosts       : pCalculation;// указатель на затраты операции
        PR_EX        : integer;     // признак выполнения
begin
//
//     Все табличные данные по заказу находятся в списках значений
//     Теперь их можно вывести на экран
//
 with Form do
 begin
   for i := 1 to 2 do
     begin
       Grid_OperPlan.Rows[i].Clear;
       Grid_OperFact.rows[i].clear;
       GridMTRPlan.rows[i].clear;
       GridFactMTR.rows[i].clear;
       GridEQPTPlan.Rows[i].Clear;
       GridEQPTFact.Rows[i].Clear;
       GridTransportPlan.Rows[i].Clear;
       GridTransportFact.Rows[i].Clear;
       GridCalc.rows[i].clear;
     end;


   if lPlanOperations <> nil then
    for i := 1 to lPlanOperations.count do

     begin
      aOperation := lPlanOperations.Items[i - 1];

      aOperation^.lineno        := i;

      Grid_OperPlan.Cells[1, i] := inttostr(aOperation^.Lineno);  // номер строки
      Grid_OperPlan.Cells[2, i] := aOperation^.Name_op;  // наименование операции
      Grid_OperPlan.Cells[3, i] := inttostr(aOperation^.rayting);  // разряд рабочего
      Grid_OperPlan.Cells[4, i] := FormatFloat( '0.000', aOperation^.timeWork); // время выполнения
      Grid_OperPlan.Cells[5, i] := FormatFloat( '0.00', aOperation^.Price);   // стоимость

     end;


     if lPlanOperations <> nil then
      if lPlanOperations.count > 0  then
       begin

         Grid_OperPlan.RowCount := lPlanOperations.count + 1;

         if Grid_OperPlan.rowcount > 0 then
          begin
            aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
            lMaterials := aOperation^.lMaterials;
            lEQPTs     := aOperation^.lEQPTs;
            lTransports:= aOperation^.lTransports;
          end
          else
            begin
              lMaterials := tList.Create;
              lEQPTs     := tList.Create;
              lTransports:= tList.Create;
            end;

         if lMaterials <> nil then

           for j := 1 to lMaterials.count do

             begin
               aMaterial := lMaterials.items[j - 1];
               aMaterial^.lineno       := j;

               GridMTRPlan.cells[1, j] := inttostr(aMaterial^.lineno);   // номер строки
               GridMTRPlan.cells[2, j] := aMaterial^.Name_matr; // наименование
               GridMTRPlan.cells[3, j] := FormatFloat( '0.000', aMaterial^.nvalue);   // количество
               GridMTRPlan.cells[4, j] := FormatFloat( '0.00', aMaterial^.nCost); // цена
               GridMTRPlan.cells[5, j] := inttostr(aMaterial^.num_oper); // номер операции

             end;

          if lMaterials <> nil then
            begin
              if lMaterials.count > 0 then
               GridMTRPlan.rowcount := lMaterials.count + 1
              else
                GridMTRPlan.rowcount := 2;

            end

          else

             GridMTRPlan.rowcount := 2;


          if lEQPTs <> nil then
           for j := 1 to lEQPTs.count do

             begin
               aEQPT := lEQPTs.items[j - 1];
               aEQPT^.lineno       := j;

               GridEQPTPlan.cells[1, j] := inttostr(j);   // номер строки
               GridEQPTPlan.cells[2, j] := aEQPT^.Name_EQPT; // наименование
               GridEQPTPlan.cells[3, j] := aEQPT^.EDIZ_NAME; // наименование едиз
               GridEQPTPlan.cells[4, j] := FormatFloat( '0.000', aEQPT^.nvalue);   // количество

             end;

          if lEQPTs <> nil then
            begin
              if lEQPTs.count > 0 then
               GridEQPTPlan.rowcount := lEQPTs.count + 1
              else
                GridEQPTPlan.rowcount := 2;

            end

          else

             GridEQPTPlan.rowcount := 2;




          if lTransports <> nil then
           for j := 1 to lTransports.count do

             begin
               aTransport := lTransports.items[j - 1];
               aTransport^.lineno       := j;

               GridTransportPlan.cells[1, j] := inttostr(j);   // номер строки
               GridTransportPlan.cells[2, j] := aTransport^.Name_EQPT; // наименование
               GridTransportPlan.cells[3, j] := aTransport^.EDIZ_NAME; // наименование едиз
               GridTransportPlan.cells[4, j] := FormatFloat( '0.00', aTransport^.nvalue);   // количество
               GridTransportPlan.cells[5, j] := FormatFloat( '0.00', Round(aTransport^.nvalue * aTransport^.Cost * 100)/100);   // количество

             end;

          if lTransports <> nil then
            begin
              if lTransports.count > 0 then
               GridTransportPlan.rowcount := lTransports.count + 1
              else
                GridTransportPlan.rowcount := 2;

            end

          else

             GridTransportPlan.rowcount := 2;




       end

     else
       Grid_OperPlan.RowCount := 2;


   // поле "признак выполнения"
   if not qFormQuery.eof then
     begin
       PR_EX := qformQuery.fieldbyName('PR_EXEC').asinteger;

      if  (lFactOperations = nil) or (lFactOperations.count = 0) then
        PR_EX := 1
      else
        if (lFactOperations <> nil) and (PR_EX = 1) then
          PR_EX := 2;

     end
    else
     PR_Ex := 1;

    if (PR_EXEC2.Checked) and (PR_EX = 1) then
      MessageDlg('Фактические заказы не соответствуют статусу заказа '+#13+#10+'"Выполнен". Статус исправлен.', mtWarning, [mbOK], 0);


        PR_EXEC.Checked  := false;
        PR_EXEC1.Checked := false;
        PR_EXEC2.Checked := false;

      case PR_EX of
        1: PR_EXEC.Checked  := true;
        2: PR_EXEC1.Checked := true;
        3: PR_EXEC2.Checked := true;
      end;


   // фактические операции
   if  lFactOperations <> nil then
    for i := 1 to lFactOperations.count do

     begin
      aOperation := lFactOperations.Items[i - 1];
      aOperation^.lineno        := i;

      Grid_OperFact.Cells[1, i] := inttostr(aOperation^.Lineno);  // номер строки
      Grid_OperFact.Cells[2, i] := aOperation^.Name_op;           // наименование операции
      Grid_OperFact.Cells[3, i] := aOperation^.Date_beg; // Дата начала
      Grid_OperFact.Cells[4, i] := aOperation^.Date_end; // Дата окончания
      Grid_OperFact.Cells[5, i] := aOperation^.Name_worker;       // ФИО работника

      Grid_OperFact.Cells[6, i] := aOperation^.Name_eqpt;         // Наименование оборудования
      Grid_OperFact.Cells[5, i] := aOperation^.Name_worker;       // ФИО работника
      Grid_OperFact.Cells[7, i] := FormatFloat( '0.000', aOperation^.timeWork);// время выполнения
      Grid_OperFact.Cells[8, i] := FormatFloat( '0.00', aOperation^.Price);   // стоимость

     end;

     if lFactOperations <> nil then
      if lFactOperations.count > 0  then
       begin
         Grid_OperFact.RowCount := lFactOperations.count + 1;

         if Grid_OperFact.rowcount > 0 then
          begin
            aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
            lMaterials := aOperation^.lMaterials;
            lEQPTs     := aOperation^.lEQPTs;
            lTransports:= aOperation^.lTransports;
          end
         else
           begin
              lMaterials := tList.create;
              lEQPTs     := tList.create;
              lTransports:= tList.create;
           end;

         if lMaterials <> nil then

          for j := 1 to lMaterials.count do

           begin
             aMaterial := lMaterials.items[j - 1];
             aMaterial^.lineno       := j;

             GridFactMTR.cells[1, j] := inttostr(aMaterial^.lineno);   // номер строки
             GridFactMTR.cells[2, j] := aMaterial^.Name_matr;          // наименование
             GridFactMTR.cells[3, j] := FormatFloat( '0.000', aMaterial^.nvalue);  // количество
             GridFactMTR.cells[4, j] := FormatFloat( '0.00', aMaterial^.nCost);    // цена
             GridFactMTR.cells[5, j] := inttostr(aMaterial^.num_oper); // номер операции

          end;


          if lMaterials <> nil then
            begin
             if lMaterials.count > 0 then
              GridFactMTR.rowcount := lMaterials.count + 1
             else
              GridFactMTR.rowcount := 2;
            end
          else
             GridFactMTR.rowcount := 2;

         // заполнение оборудования
         if lEQPTs <> nil then

          for j := 1 to lEQPTs.count do

           begin
             aEQPT := lEQPTs.items[j - 1];
             aEQPT^.lineno       := j;

             GridEQPTFact.cells[1, j] := inttostr(aEQPT^.lineno);   // номер строки
             GridEQPTFact.cells[2, j] := aEQPT^.Name_EQPT;          // наименование
             GridEQPTFact.cells[4, j] := FormatFloat( '0.000', aEQPT^.nvalue);  // количество
             GridEQPTFact.cells[3, j] := aEQPT^.EDIZ_NAME;
             GridEQPTFact.cells[5, j] := inttostr(aEQPT^.num_oper); // номер операции

          end;


          if lEQPTs <> nil then
            begin
             if lEQPTs.count > 0 then
              GridEQPTFact.rowcount := lEQPTs.count + 1
             else
              GridEQPTFact.rowcount := 2;
            end
          else
             GridEQPTFact.rowcount := 2;


         // заполнение транспорта
         if lTransports <> nil then

          for j := 1 to lTransports.count do

           begin
             aTransport := lTransports.items[j - 1];
             aTransport^.lineno := j;

             GridTransportFact.cells[1, j] := inttostr(aTransport^.lineno);   // номер строки
             GridTransportFact.cells[2, j] := aTransport^.Name_EQPT;          // наименование
             GridTransportFact.cells[4, j] := FormatFloat( '0.00', aTransport^.nvalue);  // количество
             GridTransportFact.cells[3, j] := aTransport^.EDIZ_NAME;
             GridTransportFact.cells[5, j] := FormatFloat( '0.00', Round(aTransport^.nvalue * aTransport^.Cost * 100)/100);  // количество
             GridTransportFact.cells[6, j] := inttostr(aTransport^.num_oper); // номер операции
          end;


          if lTransports <> nil then
            begin
             if lTransports.count > 0 then
              GridTransportFact.rowcount := lTransports.count + 1
             else
              GridTransportFact.rowcount := 2;
            end
          else
             GridTransportFact.rowcount := 2;




       end

      else
         Grid_OperFact.RowCount := 2;


// заполнение таблицы затрат
   // фактические операции
   if lMainCosts <> nil then
    for i := 1 to lMainCosts.count do

     begin
      aCosts := lMainCosts.Items[i - 1];
      aCosts^.lineno       := i;

      GridCalc.Cells[1, i] := inttostr(aCosts^.Lineno);  // номер строки
      GridCalc.Cells[2, i] := aCosts^.Name_calc;         // наименование статьи
      GridCalc.Cells[3, i] := FormatFloat( '0.00', aCosts^.nValue);       // Значение

     end;

   if lMainCosts <> nil then
     if lMainCosts.count > 1  then
      GridCalc.RowCount := lMainCosts.count + 1
     else
      GridCalc.RowCount := 2;

   // создание информационной строки
   Create_OrderInfostring(Form, IDDoc);


 end;

end;


{
   Процедура изменения отбора материалов операции.
   Описание: при изменении строки операции производится отбор всех материалов
   этой операции и выводится в таблицу материалов на экран.
   Вход: визуальная таблица материалов,
         полная таблица материалов,
         номер строки - колонки,
         номер операции.
   Описание: производит отбор по полной таблице материалов по ID и формирует
       визуальную таблицу материалов.
}
procedure MakeSelectMTR(var Grid: TStringGrid; lMaterials : tList; lOperation : tlist; needshowall : boolean);
var  j,i, k : integer;        // счетчики цикла
     aOperation : pOperation; // указатель на операцию
     aMaterial  : pMaterial;  // указатель на материал операции
begin

   Grid.RowCount := 2; // урезали таблицу материалов
   for j := 1 to 5 do

     Grid.cells[j, 1] := '';



//      aOperation := lOperation.Items[aRow - 1];
//      lMaterials := aOperation^.lMaterials;

  if not needshowall then
    begin

      if lMaterials <> nil then

        begin
          if lMaterials <> nil then

          for j := 1 to lMaterials.count do

            begin
              aMaterial := lMaterials.items[j - 1];

              Grid.cells[1, j] := inttostr(aMaterial^.lineno);   // номер строки
              Grid.cells[2, j] := aMaterial^.Name_matr; // наименование
              Grid.cells[3, j] := FormatFloat( '0.000', aMaterial^.nvalue);   // количество
              Grid.cells[4, j] := FormatFloat( '0.00', aMaterial^.nCost); // цена
              Grid.cells[5, j] := inttostr(aMaterial^.num_oper);
             // lOperation.
            end;

          if lMaterials <> nil then
            if lMaterials.count > 0 then
              Grid.rowcount := lMaterials.count + 1;

        end;

    end
  // если установлен режим просмотра всех материалов в табличке
  else
    begin
      k := 1;
      for i := 0 to lOperation.Count - 1 do
        begin
          aOperation := lOperation.Items[i];
          lMaterials := aOperation.lMaterials;

          for j := 0 to lMaterials.Count - 1 do
            begin
              aMaterial := lMaterials.items[j];

              Grid.cells[1, k] := inttostr(aMaterial^.lineno);   // номер строки
              Grid.cells[2, k] := aMaterial^.Name_matr; // наименование
              Grid.cells[3, k] := FormatFloat( '0.000', aMaterial^.nvalue);   // количество
              Grid.cells[4, k] := FormatFloat( '0.00', aMaterial^.nCost); // цена
              Grid.cells[5, k] := inttostr(aMaterial^.num_oper);

              k := k + 1;
            end;
        end;

       if k > 1 then
         Grid.rowcount := k;

    end;


end;



{
   Процедура изменения отбора инструмента операции.
   Описание: при изменении строки операции производится отбор всех инструментов
   этой операции и выводится в таблицу инструмента на экран.
   Вход: визуальная таблица материалов,
         полная таблица инструментов,
         номер строки - колонки,
         номер операции.
   Описание: производит отбор по полной таблице материалов по ID и формирует
       визуальную таблицу материалов.
}
procedure MakeSelectEQPT(var Grid: TStringGrid; lEQPTs : tList; lOperation : tlist; needshowall : boolean);
var  j,i, k : integer;        // счетчики цикла
     aOperation : pOperation; // указатель на операцию
     aEQPT      : pEQPT;      // указатель на инструмент операции
begin

   Grid.RowCount := 2; // урезали таблицу
   for j := 1 to 5 do

     Grid.cells[j, 1] := '';




  if not needshowall then
    begin

      if lEQPTs <> nil then

        begin
          if lEQPTs <> nil then

          for j := 1 to lEQPTs.count do

            begin
              aEQPT := lEQPTs.items[j - 1];

              Grid.cells[1, j] := inttostr(aEQPT^.lineno);   // номер строки
              Grid.cells[2, j] := aEQPT^.Name_EQPT; // наименование
              Grid.cells[4, j] := FormatFloat( '0.000', aEQPT^.nvalue);   // количество
              Grid.cells[3, j] := aEQPT^.EDIZ_Name;
              Grid.cells[5, j] := inttostr(aEQPT^.num_oper);
             // lOperation.
            end;

          if lEQPTs <> nil then
            if lEQPTs.count > 0 then
              Grid.rowcount := lEQPTs.count + 1;

        end;

    end
  // если установлен режим просмотра всех инструментов в табличке
  else
    begin
      k := 1;
      for i := 0 to lOperation.Count - 1 do
        begin
          aOperation := lOperation.Items[i];
          lEQPTs     := aOperation.lEQPTs;

          for j := 0 to lEQPTs.Count - 1 do
            begin
              aEQPT := lEQPTs.items[j];

              Grid.cells[1, k] := inttostr(aEQPT^.lineno);   // номер строки
              Grid.cells[2, k] := aEQPT^.Name_EQPT; // наименование
              Grid.cells[4, k] := FormatFloat( '0.000', aEQPT^.nvalue);   // количество
              Grid.cells[3, k] := aEQPT^.EDIZ_NAME;
              Grid.cells[5, k] := inttostr(aEQPT^.num_oper);

              k := k + 1;
            end;
        end;

       if k > 1 then
         Grid.rowcount := k;

    end;


end;



{
   Процедура изменения отбора транспорта операции.
   Описание: при изменении строки операции производится отбор всех транспортных средств
   этой операции и выводится в таблицу транспорта на экран.
   Вход: визуальная таблица транспорта,
         полная таблица транспорта,
         номер строки - колонки,
         номер операции.
   Описание: производит отбор по полной таблице транспорта по ID и формирует
       визуальную таблицу транспорта.
}
procedure MakeSelectTransport(var Grid: TStringGrid; lTransports : tList; lOperation : tlist; needshowall : boolean);
var  j,i, k : integer;        // счетчики цикла
     aOperation : pOperation; // указатель на операцию
     aTransport : pTransport;      // указатель на инструмент операции
begin

   Grid.RowCount := 2; // урезали таблицу
   for j := 1 to 5 do

     Grid.cells[j, 1] := '';




  if not needshowall then
    begin

      if lTransports <> nil then

        begin
          if lTransports <> nil then

          for j := 1 to lTransports.count do

            begin
              aTransport := lTransports.items[j - 1];

              Grid.cells[1, j] := inttostr(aTransport^.lineno);   // номер строки
              Grid.cells[2, j] := aTransport^.Name_EQPT; // наименование
              Grid.cells[4, j] := FormatFloat( '0.00', aTransport^.nvalue);   // количество
              Grid.cells[3, j] := aTransport^.EDIZ_Name;
              Grid.cells[5, j] := inttostr(aTransport^.num_oper);
             // lOperation.
            end;

          if lTransports <> nil then
            if lTransports.count > 0 then
              Grid.rowcount := lTransports.count + 1;

        end;

    end
  // если установлен режим просмотра всех инструментов в табличке
  else
    begin
      k := 1;
      for i := 0 to lOperation.Count - 1 do
        begin
          aOperation := lOperation.Items[i];
          lTransports     := aOperation.lTransports;

          for j := 0 to lTransports.Count - 1 do
            begin
              aTransport := lTransports.items[j];

              Grid.cells[1, k] := inttostr(aTransport^.lineno);   // номер строки
              Grid.cells[2, k] := aTransport^.Name_EQPT; // наименование
              Grid.cells[4, k] := FormatFloat( '0.000', aTransport^.nvalue);   // количество
              Grid.cells[3, k] := aTransport^.EDIZ_NAME;
              Grid.cells[5, k] := inttostr(aTransport^.num_oper);

              k := k + 1;
            end;
        end;

       if k > 1 then
         Grid.rowcount := k;

    end;


end;




{

      Процедура проверки состояния фактических операций.
  Описание. При вводе новых фактических операций или редактирования существующих
  необходимо проверить состояние

}
procedure check_fact_operation(sender : TDOC_ORDERForm);
//var idop : integer;
//    row  : integer;
//    aOperation   : pOperation;

begin

  sender.Grid_OperFact.Repaint;
  // Если таблица пустая, то выход
  if (sender.lPlanOperations = nil) or
     (sender.lFactOperations = nil) then
     exit;

  if (sender.lPlanOperations.count = 0) or
     (sender.lFactOperations.count = 0) then
     exit;
  // Автоматическое заполнение следующей операции по плановой
  //
  // если операция не последняя, то предлагается изменить отвественное
  // подразделение.
  //
  //
  //
//  if sender.lPlanOperations.count > sender.lFactOperations.count then
//
//    begin
//      with sender do
//       begin
//
//        row  :=  sender.Grid_OperFact.Row;

//        aOperation := sender.lPlanOperations.items[row];
//        idop :=  aOperation^.ID_op;

//        qTMPQuery.sql.clear;
//        qTMPQuery.sql.add('select id_pdr from spr_vop where id = ' + inttostr(idop));
//        qTMPQuery.Open;
//
//        // подразделение берется следующее по опрерации
//        qPDRQuery.close;
//        qPDRQuery.ParamByName('ID').asInteger := qTMPQuery.fieldbyname('ID_PDR').asinteger;
//        qPDRQuery.ParamByName('CODE').asstring:= '';
//        qPDRQuery.Open;
//        PDRCombo.text := qPDRQuery.FieldByName('Name').asstring;
//      end;
//    end
//
//  // если операция последняя, то заказ закрывается
//  else
//    begin
//        sender.PR_EXEC3.Checked := true;
//        sender.PR_EXEC2.Checked := false;
//        sender.PR_EXEC1.Checked := false;
//
//
//    end;


end;

{

   Процедура заполнения поля "Оборудование" на основании введенного чертежа

   Вход: qCHRTQuery - запрос работы с полем ввода "Чертеж"
         qEQPTQuery - запрос работы с полем ввода "Оборудование"
         Combo      - поле ввода "Оборудование"
   Выход: поле Combo  - новое значение
   Описание: производит поиск оборудования по чертежу.
}


procedure Fill_EQPT_Combo(CHRTCombo, EQPTCombo : TComboEdit);
begin

  if CHRTCombo.ID > 0 then
    EQPTCombo.ID := CHRTCombo.Query.Fieldbyname('ID_OBRD').asinteger
   else
    EQPTCombo.id := -1;

end;


{

   Процедура заполнения поля "Номенклатура" на основании введенного чертежа

   Вход: qCHRTQuery - запрос работы с полем ввода "Чертеж"
         qNMNTQuery - запрос работы с полем ввода "Номенклатура"
         Combo      - поле ввода "Номенклатура"
   Выход: поле Combo  - новое значение
   Описание: производит поиск номенклатуры по чертежу.
}


procedure Fill_NMNT_Combo(CHRTCombo, NMNTCombo : TComboEdit);
begin

  if CHRTCombo.ID > 0 then
    NMNTCombo.ID := CHRTCombo.Query.Fieldbyname('ID_NMNT').asinteger
   else
    NMNTCombo.id := -1;

end;


{
    Процедура заполнения поля "Статистика"
    автоматически после выбора поля "МВЗ".
    Справочник МВЗ содержит информацию по статье статистики

}
procedure fill_stat_field(Form :TDOC_ORDERForm );
var qFindQuery : tQuery;  // временный запрос
begin
 with Form do
 begin

  qFindQuery := tQuery.create(Form);

  if not qPDRQuery.active then exit;
  with  qFindQuery do
    begin
     DatabaseName := data.RMPBase.DatabaseName;
//     sql.add('select id_stat from spr_pdr');      //Изменено Соколовым В.Е. 9.09.04
//     sql.add('where id = ' + inttostr(qPDRQuery.fields[0].asinteger));
     sql.add('select id_stat from spr_cst');
     sql.add('where id = ' + inttostr(ID_CST));     open;

    end;

  if not qFindQuery.Eof then
    begin
      // заполнение поля "Статистика"
      qStatQuery.close;
      qStatQuery.ParamByName('ID').asInteger  := qFindQuery.Fieldbyname('id_stat').asinteger;
      qStatQuery.ParamByName('CODE').asinteger:= -1;
      qStatQuery.Open;
      statcombo.Text := qStatQuery.fieldbyname('name').asstring;

    end;

 end;

end;



{

   Процедура заполнения табличных форм документа при открытии
   Описание: получает данные из таблиц базы данных и формирует динамические
   списки данных по операциям, материалам и затратам.

}
procedure  Get_Table_data( Form : TDOC_ORDERForm);
var
        aOperation   : pOperation;  // указатель на операцию
        aCalculation : pCalculation;// указатель на затраты операции
        aMaterial    : pMaterial;   // указатель на материалы операции
        aEQPT        : pEQPT;       // указатель на инструмент операции
        aTransport   : pTransport;  // указатель на транспорт операции
        lMaterials   : tList;       // список материалов
        lCalcs       : tList;       // список затрат операции

begin

 with Form do
 begin

// ********************************************************
// заполнение табличных частей
// заполнение таблицы плановых операций
   if check_user_grand('DT_ORDER1', 'S', false) then
     begin
      qORDERPlanQuery.parambyname('IDDOC').asinteger := IDdoc;
      qORDERPlanQuery.open;

      // Формирование списка плановых операций
      while not qORDERPlanQuery.eof do

       begin

         new(aOperation);
         aOperation^.typeOp := 1;
         aOperation^.lineno := qORDERPlanQuery.fields[0].asinteger;   // номер строки
         aOperation^.Name_op:= qORDERPlanQuery.fields[1].asstring;    // наименование операции
         aOperation^.ID_op  := qORDERPlanQuery.fields[6].asinteger;   // ID операции
         aOperation^.ID_worker:= 0;
         aOperation^.Name_worker:= '';
         aOperation^.ID_eqpt    := 0;
         aOperation^.Name_eqpt  := '';
         aOperation^.rayting    := qORDERPlanQuery.fields[2].asinteger;// разряд рабочего
         aOperation^.timework   := qORDERPlanQuery.fields[3].asfloat;  // время выполнения
         aOperation^.price      := qORDERPlanQuery.fields[4].asfloat;  // стоимость

         if qORDERPlanQuery.fields[7].AsDateTime > 0 then
           aOperation^.Date_beg   := datetostr(qORDERPlanQuery.fields[7].AsDateTime);  // дата начала работ по плану

         if qORDERPlanQuery.fields[8].AsDateTime > 0 then
           aOperation^.Date_end   := datetostr(qORDERPlanQuery.fields[8].AsDateTime);  // дата окончания работ по плану

         aOperation^.time_beg   := qORDERPlanQuery.fields[9].AsString;  // время начала работ по плану
         aOperation^.time_end   := qORDERPlanQuery.fields[10].AsString; // время окончания работ по плану
         if  aOperation^.time_beg = '' then aOperation^.time_beg := '0:00:00';
         if  aOperation^.time_end = '' then aOperation^.time_end := '0:00:00';

         aOperation^.ID_worker  := qORDERPlanQuery.fields[11].AsInteger; // id работника
         aOperation^.Name_worker:= qORDERPlanQuery.fields[13].AsString;  // ФИО работника
         aOperation^.ID_eqpt    := qORDERPlanQuery.fields[12].AsInteger; // id оборудования
         aOperation^.Name_eqpt  := qORDERPlanQuery.fields[14].AsString;  // Наименование оборудования



         lMaterials := tList.Create;


         // Заполнение таблицы плановых материалов
         qMTRPlanQuery.Close;
         qMTRPlanQuery.ParamByName('idopp').asinteger := IDDoc;
         qMTRPlanQuery.ParamByName('LINEOPP').asinteger := qORDERPlanQuery.FieldByName('LINENO').asinteger;
         qMTRPlanQuery.open;

         while not qMTRPlanQuery.eof do

          begin
             new(aMaterial);
             aMaterial^.lineno    := qMTRPlanQuery.fields[0].asinteger;    // номер строки
             aMaterial^.num_oper  := aOperation^.lineno;                   // номер операции
             aMaterial^.ID_matr   := qMTRPlanQuery.fields[5].asinteger;    // ID номенклатуры
             aMaterial^.Name_matr := qMTRPlanQuery.fields[1].asstring;  // наименование
             aMaterial^.nValue    := qMTRPlanQuery.fields[2].AsFloat;   // количество
             aMaterial^.nCost     := qMTRPlanQuery.fields[3].asfloat;   // цена
             aMaterial^.nLenght   := qMTRPlanQuery.fields[7].AsFloat;   // длина
             aMaterial^.nHeight   := qMTRPlanQuery.fields[6].AsFloat;   // высота
             aMaterial^.nWidth    := qMTRPlanQuery.fields[8].AsFloat;   // ширина
             aMaterial^.nWeight   := qMTRPlanQuery.fields[9].AsFloat;   // вес
             aMaterial^.ID_STRG   := qMTRPlanQuery.fields[10].asinteger;   // заготовка
             aMaterial^.ID_EDIZ   := qMTRPlanQuery.fields[11].asinteger;   // единица измерения
             aMaterial^.STRG_NAME := qMTRPlanQuery.fields[12].asstring;   // заготовка
             aMaterial^.EDIZ_NAME := qMTRPlanQuery.fields[13].asstring;   // единица измерения

             lMaterials.Add(aMaterial);

             qMTRPlanQuery.Next;
          end;

         aOperation^.lMaterials := lMaterials;

         lEQPTs := tList.Create;


         // Заполнение таблицы плановых инструментов
         qEQPTPlanQuery.Close;
         qEQPTPlanQuery.ParamByName('idopp').asinteger   := IDDoc;
         qEQPTPlanQuery.ParamByName('LINEOPP').asinteger := qORDERPlanQuery.FieldByName('LINENO').asinteger;
         qEQPTPlanQuery.open;

         while not qEQPTPlanQuery.eof do

          begin
             new(aEQPT);
             aEQPT^.lineno    := qEQPTPlanQuery.fieldbyname('lineno').asinteger;  // номер строки
             aEQPT^.num_oper  := aOperation^.lineno;                        // номер операции
             aEQPT^.ID_EQPT   := qEQPTPlanQuery.fieldbyname('ID_EQPT').asinteger;  // ID инструмента
             aEQPT^.Name_EQPT := qEQPTPlanQuery.fieldbyname('NAME').asstring;      // наименование
             aEQPT^.nValue    := qEQPTPlanQuery.fieldbyname('number').AsFloat;     // количество
             aEQPT^.ID_EDIZ   := qEQPTPlanQuery.fieldbyname('ID_EDIZ').asinteger;  //
             aEQPT^.EDIZ_NAME := qEQPTPlanQuery.fieldbyname('EDIZ_NAME').asstring;    // единица измерения

             lEQPTs.Add(aEQPT);

             qEQPTPlanQuery.Next;
          end;
         aOperation^.lEQPTs := lEQPTs;


         lTransports := tList.Create;

         // Заполнение таблицы плановых транспортных средств
         qTransportPlanQuery.Close;
         qTransportPlanQuery.ParamByName('idopp').asinteger   := IDDoc;
         qTransportPlanQuery.ParamByName('LINEOPP').asinteger := qORDERPlanQuery.FieldByName('LINENO').asinteger;
         qTransportPlanQuery.open;

         while not qTransportPlanQuery.eof do

          begin
             new(aTransport);
             aTransport^.lineno    := qTransportPlanQuery.fieldbyname('lineno').asinteger;  // номер строки
             aTransport^.num_oper  := aOperation^.lineno;                        // номер операции
             aTransport^.ID_EQPT   := qTransportPlanQuery.fieldbyname('ID_EQPT').asinteger;  // ID инструмента
             aTransport^.Name_EQPT := qTransportPlanQuery.fieldbyname('NAME').asstring;      // наименование
             aTransport^.nValue    := qTransportPlanQuery.fieldbyname('number').AsFloat;     // количество
             aTransport^.ID_EDIZ   := qTransportPlanQuery.fieldbyname('ID_EDIZ').asinteger;  //
             aTransport^.EDIZ_NAME := qTransportPlanQuery.fieldbyname('EDIZ_NAME').asstring; // единица измерения
             aTransport^.Cost      := qTransportPlanQuery.fieldbyname('cost').AsFloat;       // Стоимость м/ч

             lTransports.Add(aTransport);

             qTransportPlanQuery.Next;
          end;
         aOperation^.lTransports := lTransports;



         lPlanOperations.Add(aOperation);

         qORDERPlanQuery.next;
     end;

   end;


  if check_user_grand('DT_ORDER2', 'S', false) then

   begin
     // Формирование списка фактических операций
     qORDERFactQuery.parambyname('IDDOC').asinteger := IDdoc;
     qORDERFactQuery.open;


     // Формирование списка плановых операций
     while not qORDERFactQuery.eof do

      begin

         new(aOperation);
         aOperation^.typeOp := 2;
         aOperation^.lineno := qORDERFactQuery.fields[0].asinteger; // номер строки
         aOperation^.Name_op:= qORDERFactQuery.fields[1].asstring;  // наименование операции
         aOperation^.ID_op  := qOrderFactQuery.fields[9].asinteger; // ID вида операции
         aOperation^.ID_worker  := qOrderFactQuery.fields[10].asinteger;// ID исполнителя
         aOperation^.Name_worker:= qOrderFactQuery.fields[4].asstring;  // ФИО работника
         aOperation^.ID_eqpt    := qOrderFactQuery.fields[11].asinteger;// ID оборудования
         aOperation^.Name_eqpt  := qOrderFactQuery.fields[5].asstring;  // Наименование оборудования
         aOperation^.rayting    := qOrderFactQuery.fields[12].asinteger;// разряд рабочего
         aOperation^.timework   := qOrderFactQuery.fields[6].asfloat;   // Продолжительность
         aOperation^.price      := qOrderFactQuery.fields[7].asfloat;   // Стоимость
         aOperation^.time_beg   := qOrderFactQuery.fields[13].asstring;    // время начала работ
         aOperation^.time_end   := qOrderFactQuery.fields[14].asstring;    // время окончания работ
         aOperation^.date_beg   := datetostr(qOrderFactQuery.fields[2].asdatetime);     // дата начала работ
         If qOrderFactQuery.fields[3].IsNull Then aOperation^.date_end   := '.  .' else     //2017 просили сохранять факт без даты окончания операции
             aOperation^.date_end   := datetostr(qOrderFactQuery.fields[3].asdatetime);     // дата окончания работ

         lMaterials := tList.Create;
         lCalcs     := tList.Create;

         // Заполнение таблицы плановых материалов
         qMTRFactQuery.Close;
         qMTRFactQuery.ParamByName('idopf').asinteger := IDDOC;
         qMTRFactQuery.ParamByName('LINE_OPF').asinteger :=
             qORDERFactQuery.fieldByName('LINENO').asinteger;
         qMTRFactQuery.open;

         while not qMTRFactQuery.eof do

          begin
             new(aMaterial);
             aMaterial^.lineno := qMTRFactQuery.fields[0].asinteger;    // номер строки
             aMaterial^.num_oper  := aOperation^.lineno;                // номер операции
             aMaterial^.ID_matr:= qMTRFactQuery.fields[5].asinteger;    // ID номенклатуры
             aMaterial^.Name_matr := qMTRFactQuery.fields[1].asstring;  // наименование
             aMaterial^.nValue    := qMTRFactQuery.fields[2].AsFloat;   // количество
             aMaterial^.nCost     := qMTRFactQuery.fields[3].AsFloat; // цена
             aMaterial^.nLenght   := qMTRFactQuery.fields[7].AsFloat;   // длина
             aMaterial^.nHeight   := qMTRFactQuery.fields[6].AsFloat;   // высота
             aMaterial^.nWidth    := qMTRFactQuery.fields[8].AsFloat;   // ширина
             aMaterial^.nWeight   := qMTRFactQuery.fields[9].AsFloat;   // вес
             aMaterial^.ID_STRG   := qMTRFactQuery.fields[10].asinteger;   // заготовка
             aMaterial^.ID_EDIZ   := qMTRFactQuery.fields[11].asinteger;   // единица измерения
             aMaterial^.STRG_NAME := qMTRFactQuery.fields[12].asstring;   // заготовка
             aMaterial^.EDIZ_NAME := qMTRFactQuery.fields[13].asstring;   // единица измерения

             lMaterials.Add(aMaterial);

             qMTRFactQuery.Next;
          end;

         aOperation^.lMaterials := lMaterials;

         lEQPTs := tList.Create;


         // Заполнение таблицы фактических инструментов
         qEQPTFactQuery.Close;
         qEQPTFactQuery.ParamByName('idopf').asinteger   := IDDoc;
         qEQPTFactQuery.ParamByName('LINEOPF').asinteger := qORDERFactQuery.FieldByName('LINENO').asinteger;
         qEQPTFactQuery.open;

         while not qEQPTFactQuery.eof do

          begin
             new(aEQPT);
             aEQPT^.lineno    := qEQPTFactQuery.fieldbyname('lineno').asinteger;  // номер строки
             aEQPT^.num_oper  := aOperation^.lineno;                        // номер операции
             aEQPT^.ID_EQPT   := qEQPTFactQuery.fieldbyname('ID_EQPT').asinteger;  // ID инструмента
             aEQPT^.Name_EQPT := qEQPTFactQuery.fieldbyname('NAME').asstring;      // наименование
             aEQPT^.nValue    := qEQPTFactQuery.fieldbyname('number').AsFloat;     // количество
             aEQPT^.ID_EDIZ   := qEQPTFactQuery.fieldbyname('ID_EDIZ').asinteger;  //
             aEQPT^.EDIZ_NAME := qEQPTFactQuery.fieldbyname('EDIZ_NAME').asstring;    // единица измерения

             lEQPTs.Add(aEQPT);

             qEQPTFactQuery.Next;
          end;
         aOperation^.lEQPTs := lEQPTs;


         lTransports := tList.Create;


         // Заполнение таблицы фактического траспорта
         qTransportFactQuery.Close;
         qTransportFactQuery.ParamByName('idopf').asinteger   := IDDoc;
         qTransportFactQuery.ParamByName('LINEOPF').asinteger := qORDERFactQuery.FieldByName('LINENO').asinteger;
         qTransportFactQuery.open;

         while not qTransportFactQuery.eof do

          begin
             new(aTransport);
             aTransport^.lineno    := qTransportFactQuery.fieldbyname('lineno').asinteger;  // номер строки
             aTransport^.num_oper  := aOperation^.lineno;                        // номер операции
             aTransport^.ID_EQPT   := qTransportFactQuery.fieldbyname('ID_EQPT').asinteger;  // ID инструмента
             aTransport^.Name_EQPT := qTransportFactQuery.fieldbyname('NAME').asstring;      // наименование
             aTransport^.nValue    := qTransportFactQuery.fieldbyname('number').AsFloat;     // количество
             aTransport^.ID_EDIZ   := qTransportFactQuery.fieldbyname('ID_EDIZ').asinteger;  //
             aTransport^.EDIZ_NAME := qTransportFactQuery.fieldbyname('EDIZ_NAME').asstring;    // единица измерения
             aTransport^.Cost      := qTransportFactQuery.fieldbyname('cost').AsFloat;       // Стоимость м/ч

             lTransports.Add(aTransport);

             qTransportFactQuery.Next;
          end;
         aOperation^.lTransports := lTransports;




         // Заполнение таблицы фактических затрат
         qOperCostQuery.Close;
         qOperCostQuery.ParamByName('id').asinteger   := IDDoc;
         qOperCostQuery.ParamByName('line_op').asinteger   := qORDERFactQuery.fields[0].asinteger;

         qOperCostQuery.open;

         while not qOperCostQuery.eof do

          begin
             new(aCalculation);
             aCalculation^.lineno    := qOperCostQuery.fields[1].asinteger; // номер строки
             aCalculation^.ID_calc   := qOperCostQuery.fields[2].asinteger; // ID статьи затрат
             aCalculation^.Name_calc := qOperCostQuery.fields[3].asstring;  // наименование
             aCalculation^.nValue    := qOperCostQuery.fields[4].AsFloat;   // величина

             lCalcs.Add(aCalculation);

             qOperCostQuery.Next;
          end;

         aOperation^.lCalcs := lCalcs;

         lFactOperations.Add(aOperation);

         qORDERFactQuery.next;

     end;

   end;

 if check_user_grand('DT_ORDER3', 'S', false) then

  begin

   qCostQuery.close;
   qCostQuery.ParamByName('IDDOC').asinteger := IDdoc;
   qCostQuery.open;

   while not qCostQuery.eof do

     begin
       new(aCalculation);

       aCalculation^.lineno    := qCostQuery.fields[0].asinteger; // номер строки
       aCalculation^.ID_calc   := qCostQuery.fields[3].asinteger; // ID статьи затрат
       aCalculation^.Name_calc := qCostQuery.fields[1].asstring;  // наименование
       aCalculation^.nValue    := qCostQuery.fields[2].AsFloat;   // величина

       lMainCosts.Add(aCalculation);

       qCostQuery.Next;
     end;

  end;

 end;

end;

{

      Процедура определения вида чертежа заказа по его ID
      Определяет это либо
        - изготовление
        - ремонт (Реставрация).
      Вход: форма заказа.


}
procedure SetVidChrt( Form : TDOC_ORDERForm);

begin
  with Form do
  begin
   if (CHRTCombo.ID > 0) then

      begin

          qTMPQuery.sql.clear;
          qTMPQuery.sql.add('select code, vid_chrt from spr_chrt where id = '
                + inttostr(CHRTCombo.ID));
          qTMPQuery.open;
          Vid_chrt.Caption := 'Код: ' + qTMPQuery.Fields[0].asstring;

          if qTMPQuery.Fields[1].asinteger = 0 then

             Vid_chrt.Caption := Vid_chrt.Caption + ' Вид работ: изготовление'

          else
             Vid_chrt.Caption := Vid_chrt.Caption + ' Вид работ: ремонт';

          glVID_CHRT := qTMPQuery.Fields[1].asinteger;
       end

   else

         Vid_chrt.Caption := 'Чертеж не выбран';


  end;

end;


{
   Процедура заполнения структуры Номенкталура для документов
    "Приход готовой продукции", "Расход готовой продукции",
    "Поступление материалов", "Отпуск материалов".
   Вход: запрос табличной формы, в которую записываются данные из
         БД.
         структура, в которой остаются заполненные данные.
   Выход: пусто

}
procedure Get_Table_NMNT_data( qQuery : tQuery; lList : tList);
var
     aMaterial    : pNMNT;  // указатель на материал операции
        FieldList : TStringList;
        str       : string;
begin
  FieldList := TStringList.Create;

  qQuery.GetFieldNames(FieldList);

  str :=  FieldList.GetText;

  qQuery.First;
  while not qQuery.eof do
    begin
      new(aMaterial);
              aMaterial^.nLenght := 0;
              aMaterial^.nHeight := 0;
              aMaterial^.nWidth  := 0;
              aMaterial^.nWeight := 0;
              aMaterial^.ID_PDR  := 0;
              aMaterial^.Name_PDR:= '';
              aMaterial^.NumDocOrd:= 0;
              aMaterial^.ID_Order := 0;



      aMaterial^.lineno   := qQuery.FieldByName('lineno').asinteger;
      aMaterial^.ID_matr  := qQuery.FieldByName('ID_NMNT').asinteger;
      aMaterial^.Name_matr:= qQuery.FieldByName('NMNT').AsString;
      aMaterial^.ID_EdIz  := qQuery.FieldByName('ID_EDIZ').asinteger;
      aMaterial^.Name_EdIz:= qQuery.FieldByName('EDIZ').AsString;
      aMaterial^.nValue   := qQuery.FieldByName('number').asfloat;
      aMaterial^.Price    := qQuery.FieldByName('Price').asfloat;
      aMaterial^.nCost    := qQuery.FieldByName('NSum').asfloat;

      
      if FindPart('numdoc', lowercase(str)) > 0 then
          aMaterial^.NumDocOrd:= qQuery.FieldByName('Numdoc').asinteger;
      if FindPart('id_ord', lowercase(str)) > 0 then
          aMaterial^.ID_Order := qQuery.FieldByName('id_ord').asinteger;

         if FindPart('lenght', lowercase(str)) > 0 then
           begin
              aMaterial^.nLenght := qQuery.FieldByName('lenght').asfloat;
              aMaterial^.nHeight := qQuery.FieldByName('hight').asfloat;
              aMaterial^.nWidth  := qQuery.FieldByName('width').asfloat;
              aMaterial^.nWeight := qQuery.FieldByName('Weight').asfloat;

              if (qQuery.Fields.FindField('ID_PDR') <> nil) then
                aMaterial^.ID_PDR  := qQuery.FieldByName('ID_PDR').AsInteger;

              if (qQuery.Fields.FindField('Name_PDR') <> nil) then
                aMaterial^.Name_PDR:= qQuery.Fields.FindField('Name_PDR').asstring;

           end;

      // это поля таблицы документов движения материалов


      lList.Add(aMaterial);

      qQuery.Next;
    end;
end;

{
  Функция заполнения таблицы формы документа данными из динамического
  массива данных.
  Вызывается из форм редактирования документов: Приход материала, Расход
  материалов в производство, Приход готовой продукции, Отпуск готовой продукции
  Вход: массив данных (список),
        таблица формы (Stringgrid);

}
procedure Fill_NMNT_table( lList : tList; Grid : tStringGrid);
var i : integer;
    aMaterial : pNMNT;  // указатель на материал операции

begin
//
//     Все табличные данные по заказу находятся в списках значений
//     Теперь их можно вывести на экран
//
   for i := 1 to 2 do
     Grid.rows[i].Clear;


  if lList <> nil then
   for i := 1 to lList.count do

     begin
      aMaterial := lList.Items[i - 1];

      aMaterial^.lineno        := i;

      Grid.Cells[1, i] := inttostr(aMaterial^.Lineno);  // номер строки
      Grid.Cells[2, i] := aMaterial^.Name_matr;          // наименование номенклатуры
      Grid.Cells[3, i] := aMaterial^.Name_EdIz;          // наименование единицы измерения
      Grid.Cells[4, i] := FormatFloat( '0.000', aMaterial^.nValue);  // количество
      Grid.Cells[5, i] := FormatFloat( '0.00', aMaterial^.Price);    // стоимость
      Grid.Cells[6, i] := FormatFloat( '0.00', aMaterial^.nCost);    // стоимость
      if aMaterial^.ID_ORDER > 0 then
        Grid.Cells[7, i] := inttostr(aMaterial^.NumDocOrd);    // стоимость

      if aMaterial^.ID_PDR > 0 then
        Grid.Cells[8, i] := aMaterial^.Name_PDR;    // МВЗ

     end;

   if lList <> nil then
    if lList.Count > 0 then
     Grid.RowCount := lList.Count + 1
    else
     Grid.RowCount := 2;


end;



{
   Процедура заполнения структуры ОБорудование для документов
    "Поступление инструмента", "Отпуск инструмента",
   Вход: запрос табличной формы, в которую записываются данные из
         БД.
         структура, в которой остаются заполненные данные.
   Выход: пусто

}
procedure Get_Table_EQPT_data( qQuery : tQuery; lList : tList);
var
     aEQPT        : pEQPT;  // указатель на инструмент операции
        FieldList : TStringList;
        str       : string;
begin
  FieldList := TStringList.Create;

  qQuery.GetFieldNames(FieldList);

  str :=  FieldList.GetText;

  qQuery.First;
  while not qQuery.eof do
    begin
      new(aEQPT);

      aEQPT^.lineno   := qQuery.FieldByName('lineno').asinteger;
      aEQPT^.ID_EQPT  := qQuery.FieldByName('ID_EQPT').asinteger;
      aEQPT^.Name_EQPT:= qQuery.FieldByName('EQPT').AsString;
      aEQPT^.ID_EdIz  := qQuery.FieldByName('ID_EDIZ').asinteger;
      aEQPT^.EDIZ_NAME:= qQuery.FieldByName('EDIZ').AsString;
      aEQPT^.nValue   := qQuery.FieldByName('number').asfloat;

      // это поля таблицы документов движения материалов


      lList.Add(aEQPT);

      qQuery.Next;
    end;
end;
{
  Функция заполнения таблицы формы документа данными из динамического
  массива данных.
  Вызывается из форм редактирования документов: Приход материала, Расход
  материалов в производство, Приход готовой продукции, Отпуск готовой продукции
  Вход: массив данных (список),
        таблица формы (Stringgrid);

}
procedure Fill_EQPT_table( lList : tList; Grid : tStringGrid);
var i : integer;
    aEQPT : pEQPT;  // указатель на материал операции

begin
//
//     Все табличные данные по заказу находятся в списках значений
//     Теперь их можно вывести на экран
//
   for i := 1 to 2 do
     Grid.rows[i].Clear;


  if lList <> nil then
   for i := 1 to lList.count do

     begin
      aEQPT := lList.Items[i - 1];

      aEQPT^.lineno        := i;

      Grid.Cells[1, i] := inttostr(aEQPT^.Lineno);  // номер строки
      Grid.Cells[2, i] := aEQPT^.Name_EQPT;         // наименование номенклатуры
      Grid.Cells[3, i] := aEQPT^.EDIZ_NAME;          // наименование единицы измерения
      Grid.Cells[4, i] := FormatFloat( '0.000', aEQPT^.nValue);  // количество

     end;

   if lList <> nil then
    if lList.Count > 0 then
     Grid.RowCount := lList.Count + 1
    else
     Grid.RowCount := 2;


end;



{-----------------------------------------------------------------------------
  Функция:   Get_sum_order_by_calc
  Date:      12-май-2004
  Вход:      ID : integer
  Выход:     real
  Описание:
     Возвращает сумму документа заказ по статье затрат.
     Для внутренних подразделений это статья цеховой себестоимости,
     для сторонних - полная себестоимость без НДС.

-----------------------------------------------------------------------------}
function Get_sum_order_by_calc(ID : integer; is_cst_int : integer): real;
var qGet_sum_order_by_calc : tQuery; // временный запрос
    ID_Calc : integer;               // ID статьи затрат
begin

  qGet_sum_order_by_calc := tQuery.Create(data);

  with qGet_sum_order_by_calc do
    begin
      qGet_sum_order_by_calc.DatabaseName := data.RMPBase.DatabaseName;

      // если тип заказчика неизвестен, то найти его по заказу
      if is_cst_int = -1 then
        begin
          close;
          sql.Clear;
          sql.Add('select spr.is_instr');
          sql.Add('from dh_order dh, spr_cst spr, dh_rqst rqst');
          sql.Add('where spr.id = rqst.id_cst and dh.id_rqst = rqst.id and dh.id = :id');
          params[0].asinteger := id;
          open;
          if not qGet_sum_order_by_calc.Eof then
            is_cst_int := qGet_sum_order_by_calc.Fields[0].asinteger
           else
             is_cst_int := 0;
        end;


      close;
      sql.clear;
      sql.Add('select dt.nvalue as sumdoc');
      sql.Add('from dt_order3 dt');
      sql.Add('where dt.id_rqst = :iddoc');
      sql.Add('and dt.id_calc = :calc_id');


      // тип статьи читать из файла настройки                           
      if is_cst_int = 0 then
        ID_Calc := param_form.lIniFile.ReadInteger('Calculation','CalcIDForExternal', 10)
       else
         ID_Calc := param_form.lIniFile.ReadInteger('Calculation','CalcIDForInternal', 6);



      Params[0].asinteger := ID;
      Params[1].asinteger := ID_Calc;
      open;
    end;

    if not qGet_sum_order_by_calc.eof then
      result := qGet_sum_order_by_calc.fields[0].asfloat
     else
       result := 0;

  qGet_sum_order_by_calc.free;

end;

function FindWeightByChrt(id_chrt : integer): real;
var
   qWeighQuery : tquery;
begin
   // заполнение поля "Вес" на основании чертежа
   qWeighQuery := tQuery.Create(data);
   qWeighQuery.DatabaseName := data.RMPBase.DatabaseName;
   with qWeighQuery do
     begin
       sql.Clear;
       sql.Add('select ch.nsize from SPR_CHRC ch, spr_vchr vh where ch.id_chrt = :id ');
       sql.Add(' and ch.id_vid = vh.id and upper(vh.name) = ''ВЕС''');
       params[0].asinteger := id_chrt;
       open;
     end;
    if not qWeighQuery.Eof then
     result := qWeighQuery.Fields[0].asfloat
     else
      result := 0;

end;


end.
