{***************************************************************
 *
 * Unit Name: PrintAct
 * Purpose  :
 *        Модуль формирования печатной формы
 *        акта выполненных работ
 * Author   : Косицын Дмитрий, Соколов Владислав
 * History  : 2004
 *
 ****************************************************************}


unit PrintAct;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Math;

type
  TPrintActForm = class(TForm)
    Label1: TLabel;
    Button2: TButton;
    qMainQuery: TQuery;
    qTableQuery: TQuery;
    qMTRQuery: TQuery;
    NDSQuery: TQuery;
    procedure CreateReport(iddoc: integer);
    function conv2words (number: integer; level: integer) : string;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  PrintActForm: TPrintActForm;

implementation

uses PrintFrm, printlibs;



procedure TPrintActForm.CreateReport(iddoc : integer);

var Form :  TShowPrintForm;
    TotalTot : real;
    MTRTolal, MTRSum   : real;
    AllMTRTotal : real;
    NDSTotal : real;
    tablestr: string;
    StrTotalTot : string;
    digitcount : integer;
    counter: integer;
    stringvalue : string;
    PatternNMNT : string;
    PatternEQPT : string;
    PatternMain : string;
    PatternMTR  : string;
    PatternStr  : string;
    y : integer;

begin

   Form := TShowPrintForm.create(Application);
   TotalTot := 0;
   StrTotalTot := '';
   NDSTotal := 0;

   // основной запрос
   with qMainquery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
       if eof then
         begin
           showmessage('Не полностью заполнены реквизиты документа!');
           abort;
         end;
    end;

   //  запрос по затратам
   with qTableQuery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
    end;

   // запрос по материалам
   with qMTRQuery do
    begin
       close;
       parambyname('iddoc').asinteger := iddoc;
       open;
    end;


    // загрузка шаблона из файла
    try
      Form.Editor.Lines.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Pattern\ActPttrn.txt');
    except
      MessageDlg('Не могу открыть файл шаблона!', mtWarning, [mbOK], 0);

    end;


    // формирование строк
    with Form.Editor do
      begin
        replacePattern(Form.Editor, 'DateDoc',  MonthByString(qMainQuery.FieldByName('date_in').AsDateTime)+
                                                ' '+GetYearStr(qMainQuery.FieldByName('date_in').AsDateTime), 0);
        replacePattern(Form.Editor, 'NumDoc' ,  qMainQuery.FieldByName('NumDoc').asstring, 0);
        replacePattern(Form.Editor, 'PDRName',  qMainQuery.FieldByName('Name_1').asstring, 0);
        replacePattern(Form.Editor, 'PDRCode',  qMainQuery.FieldByName('Code_1').asstring, 0);

        //если сторонняя организация (is_instr = 0)
        if qMainQuery.FieldByName('Is_Instr').AsInteger = 0 Then
             replacePattern(Form.Editor, 'Customer', ' ', 0)
         else //внутренний заказчик (is_instr = 1) илибо заказ на заказ (is_instr = 2)
              replacePattern(Form.Editor, 'Customer', qMainQuery.FieldByName('Name').asstring, 0);

        //если сторонняя организация (is_instr = 0)
        if qMainQuery.FieldByName('Is_Instr').AsInteger = 0 Then
             replacePattern(Form.Editor, 'PaperPlant',  qMainQuery.FieldByName('Name').asstring, 0)
         else //внутренний заказчик (is_instr = 1) илибо заказ на заказ (is_instr = 2)
             replacePattern(Form.Editor, 'PaperPlant',  GetSystemParams('Enterprise'), 0);

        //если внутренняя организация (is_instr = 1)
        if qMainQuery.FieldByName('Is_Instr').AsInteger = 1 Then
             replacePattern(Form.Editor, 'ParentCustomer', qMainQuery.FieldByName('ParentCustomer').asstring, 0)
         else
              replacePattern(Form.Editor, 'ParentCustomer', '...............................', 0);

        //если внутренняя организация (is_instr = 1)
        if qMainQuery.FieldByName('Is_Instr').AsInteger = 1 Then
             replacePattern(Form.Editor, 'CustomerCode', qMainQuery.FieldByName('Code').asstring, 0)
         else
              replacePattern(Form.Editor, 'CustomerCode', ' ', 0);
//        replacePattern(Form.Editor, 'TodayDate',  DateToStr(Date), 0);
        replacePattern(Form.Editor, 'TodayDate', qMainQuery.FieldByName('date_in').AsString, 0);

       AllMTRTotal:=0;

       patternNMNT :=  TablePattern(Form.Editor, '/tab_1');
       PatternMain :=  TablePattern(Form.Editor, '/tab_2');
       PatternMTR  :=  TablePattern(Form.Editor, '/tab_3');
       PatternSTR  :=  TablePattern(Form.Editor, '/tab_4');
       PatternEQPT :=  TablePattern(Form.Editor, '/tab_5');
       y := Form.Editor.caretpos.y;
        while not qTableQuery.eof do
          begin

             // таблица 1
             tableStr := patternNMNT;  // шаблон табличной части

             lines.insert(y,tablestr);
             replacePattern(Form.Editor, 'NMNTName',  qTableQuery.FieldByName('Name_2').asstring, 0);

             // наименования изготовляемой вещи
             tableStr := patternEQPT;  // шаблон табличной части

             y := y + 1;
             lines.insert(y,tablestr);
             replacePattern(Form.Editor, 'EQPTName',  qTableQuery.FieldByName('Name_1').asstring, 0);

             tableStr := patternMain;  // шаблон табличной части

             y := y + 1;
             lines.insert(y,tablestr);
             y := y + 1;

             replacePattern(Form.Editor, 'Num',  qTableQuery.FieldByName('Lineno').asstring, 1);
             replacePattern(Form.Editor, 'NumOrd',  qTableQuery.FieldByName('NumOrder').asstring, 2);
//             replacePattern(Form.Editor, 'EQPTName',  qTableQuery.FieldByName('Name_1').asstring, 0);
             replacePattern(Form.Editor, 'CHRTCode',  qTableQuery.FieldByName('Code_1').asstring, 0);
             replacePattern(Form.Editor, 'PriceEd',   FormatFloat('0.000', qTableQuery.FieldByName('Ntime').AsFloat/1000) , 2);
             replacePattern(Form.Editor, 'Ediz',      qTableQuery.FieldByName('Code_2').asstring, 1);
             replacePattern(Form.Editor, 'NumF',      qTableQuery.FieldByName('Number_F').asstring, 2);
             replacePattern(Form.Editor, 'Price',     FormatFloat( '0.00', qTableQuery.FieldByName('Price').asfloat), 2);
             replacePattern(Form.Editor, 'Sum',       FormatFloat( '0.00', qTableQuery.FieldByName('NSum').asfloat)  , 2);
//             replacePattern(Form.Editor, 'Total',     FormatFloat( '0.00', qTableQuery.FieldByName('NSum').asfloat)  , 2);

             // таблица 2 материалов
             tableStr := PatternStr;
             lines.insert(y,tablestr);
             y := y + 1;

             tableStr := PatternMTR;  // шаблон табличной части

             lines.insert(y,tablestr);
             y := y + 1;

             MTRSum:=0;
             MTRTolal:=0;

             qMtrQuery.First;

             while not qMTRQuery.eof do
             begin
//             replacePattern(Form.Editor, 'MTRName',  qMTRQuery.FieldByName('Name').asstring, 0);
//             replacePattern(Form.Editor, 'Ediz',     qMTRQuery.FieldByName('Code').asstring, 1);
//             replacePattern(Form.Editor, 'MNum',     qMTRQuery.FieldByName('Number').asstring, 2);
                if qMTRQuery.FieldByName('ID').AsInteger =
                                qTableQuery.FieldByName('ID').AsInteger Then
                begin
                       MTRSum:=MTRSum + qMTRQuery.FieldByName('Price').AsFloat;
                       MTRTolal:=MTRTolal + qMTRQuery.FieldByName('Price').AsFloat*
                                     qTableQuery.FieldByName('Number_F').AsInteger;
                end;
                qMTRQuery.next;
             end;
             AllMTRTotal:=AllMTRTotal+MTRTolal;

             replacePattern(Form.Editor, 'MTRSum',   FormatFloat( '0.00', MTRSum), 2);
             replacePattern(Form.Editor, 'MTRTotal',   FormatFloat( '0.00', MTRTolal), 2);

//             TotalSum := TotalSum + qTableQuery.FieldByName('NSum').asfloat;
             TotalTot := TotalTot + qTableQuery.FieldByName('NSum').asfloat;

             // запрос по материалам
             with NDSQuery do
             begin
                close;
                parambyname('id').asinteger := qTableQuery.FieldByName('ID').AsInteger;
                open;
             end;
             NDSTotal := NDSTotal + NdsQuery.FieldByName('NValue').AsFloat;

             qTableQuery.next;
          end;


          // подвал
//          replacePattern(Form.Editor, 'TotalSum', FormatFloat( '0.00',  TotalSum), 2);
          replacePattern(Form.Editor, 'TotalTot', FormatFloat( '0.00',  TotalTot), 2);
          replacePattern(Form.Editor, 'AllMTRTotal',   FormatFloat( '0.00', AllMTRTotal), 2);
          replacePattern(Form.Editor, 'NDSTotal',   FormatFloat( '0.00', NDSTotal), 2);

 //       TotalTot:=5307.42;
 //     символьная запись TotalTot

          if TotalTot > 0 Then
          begin
             {определяем длину введенной строки - необходимо для разбиения
              на группы по 3 цифры }
             digitcount:=trunc(log10(Trunc(TotalTot)))+1;

             {задаем счетчик, который будет обозначать соответствующий "уровень"}
             counter:=1;

             {в случае, если введенное число состоит более чем из 3-х цифр,
             начинаем цикл, последовательно разбивающий введенное число на
             группы по 3 цифры справа налево }
             if (digitcount>3) Then
             {выполняем цикл до тех пор, пока число оставшихся цифр будет больше 3-х (т.е., если
              число из 5 цифр, то цикл выполнится всего один раз, отобрав 3 цифры и оставив 2, которые
              будут обработаны ниже }
                while (digitcount>3) do
                begin
                 {вызываем функцию перевода чисел в слова, в качестве числа для
                  перевода передаем 3 цифры, полученные смещением на 3 символа
                  слева и "вырезанием" 3 символов с получившейся позиции.
                  также функции передается значение счетчика, которое фактически
                  обозначает уровень данной "тройки" цифр.
                  в случае, если цикл выполняется во 2-й и более раз,
                  к строчке также присоединяется значение, полученное при
                  предыдущем выполнении цикла (выстраивание "уровней" в цепочку:
                  миллионы - тысячи - сотни) }
                   stringvalue:=conv2words(Trunc(Frac(TotalTot/power(1000,counter))*1000),counter)+stringvalue;

                  {увеличение счетчика на 1 - переход на следующий уровень }
                   counter:=counter+1;

                  {уменьшение переменной на 3 - необходимо для изменения
                   позиции смещения, с которой "вырезаются" 3 следующих цифры }
                   digitcount:=digitcount-3;
                end;

             {строчка, обрабатывающая оставшиеся цифры - 3 или менее (число
              оставшихся необработанныхцифр получаем из переменной digitcount) }
             stringvalue:=conv2words(Trunc(Frac(TotalTot/power(1000,counter))*1000),counter)
                       +stringvalue+FloatToStr(Round(Frac(TotalTot)*100))+' коп.';
          end
          else
             {если введенное число - ноль, то пишем "ноль" :) }
              stringvalue:='ноль рублей ' + FloatToStr(Frac(TotalTot))+' коп.';

          replacePattern(Form.Editor, 'StrTotalTot', stringvalue, 2);
          //вычисляю длину числа
//          length:=trunc(log10(Trunc(TotalTot)))+1;
//          StrTotalTot:=conv2words(Trunc(TotalTot), trunc((length-1)/3) +1);


//      Подпись "Принято"
          If qMainQuery.FieldByName('VID_CHRT').AsInteger = 1 Then
          begin
               replacePattern(Form.Editor, 'Prinyto', 'Принято и установлено:', 0);
          end
           else
               replacePattern(Form.Editor, 'Prinyto', 'Принял:', 0);
      end;

  Form.Caption := 'Печать акта выполненных работ №' +  qMainQuery.FieldByName('NumDoc').asstring;
  Form.Editor.Show;
  Form.onshow;
  Form.show;

end;

{ converting function
   функция, производящая конвертирование чисел в текст.
   функции передаются 2 аргумента:
   $number - трех- или меньше значное число,
   $level - "уровень" этого числа. уровень считается справа, каждый
   уровень состоит из 3-х цифр (или меньше, если уровень самый левый
   и на него не хватило цифр). например, число 1435777 состоит из 3-х уровней:
   777 - 1-й уровень (сотни), 435 - 2-й уровень (тысячи), 1 (001) - 3-й уровень (миллионы) }
function TPrintActForm.conv2words (number: integer; level: integer): string;
   {массив, содержащий названия чисел от 1 до 19
    значения от 11 до 19 необходимы потому, что эти числа
    называются не по общей системе (название десятков-название единиц):
    т.е. одиннадцать, двенадцать, а не десять-один, десять-два и т.п. }
var values1to19: array[1..19] of string;

   {массив, содержащий названия десятков - от 20 до 90
    (10 нет, т.к. учтено в предыдущем массиве) }
    values20to90: array[1..10] of string;

   {двумерный массив, содержащий названия уровней.
    первый уровень пустой, т.к. мы говорим не "десять единиц", а просто "десять"
    определения остальных уровней являются вложенными массивами, т.к. слова для
    обозначения различаются в зависимости от значения:
          например:
              1 тысЯЧА
              2 тысЯЧИ
               ...
              4 тысЯЧИ
              5 тысЯЧ
               ...
     т.е. можно выделить 3 группы:
              для 1 единицы,
              для 2-4 единиц,
              для оставшегося диапазона (5-9) }
    levelvalues: array[1..5, 1..3] of string;
    rublvalues : array[1..3] of string;
    i: integer;
    sublevel : integer;
    substringvalue : string;
    stringvalue : string;
begin
       values1to19[1] := 'один';
       values1to19[2] :='два';
       values1to19[3] :='три';
       values1to19[4] :='четыре';
       values1to19[5] :='пять';
       values1to19[6] :='шесть';
       values1to19[7] :='семь';
       values1to19[8] :='восемь';
       values1to19[9] :='девять';
       values1to19[10] :='десять';
       values1to19[11] :='одиннадцать';
       values1to19[12] :='двенадцать';
       values1to19[13] :='тринадцать';
       values1to19[14] :='четырнадцать';
       values1to19[15] :='пятнадцать';
       values1to19[16] :='шестнадцать';
       values1to19[17] :='семнадцать';
       values1to19[18] :='восемнадцать';
       values1to19[19] :='девятнадцать';

       values20to90[2] := 'двадцать';
       values20to90[3] := 'тридцать';
       values20to90[4] :='сорок';
       values20to90[5] :='пятьдесят';
       values20to90[6] :='шестьдесят';
       values20to90[7] :='семьдесят';
       values20to90[8] :='восемьдесят';
       values20to90[9] :='девяносто';

       levelvalues[1,1] := '';
       levelvalues[1,2] := '';
       levelvalues[1,3] := '';
       levelvalues[2,1] := 'тысяча';
       levelvalues[2,2] := 'тысячи';
       levelvalues[2,3] := 'тысяч';
       levelvalues[3,1] := 'миллион';
       levelvalues[3,2] := 'миллиона';
       levelvalues[3,3] := 'миллионов';
       levelvalues[4,1] := 'миллиард';
       levelvalues[4,2] := 'миллиарда';
       levelvalues[4,3] := 'миллиардов';
       { фактически не может быть использовано, т.к. выходит за пределы целочисленного типа;
           можно исправить, но пока не вижу смысла }
       levelvalues[5,1] := 'триллион';
       levelvalues[5,2] := 'триллиона';
       levelvalues[5,3] := 'триллионов';

       rublvalues[1]:='рубль ';
       rublvalues[2]:='рубля ';
       rublvalues[3]:='рублей ';


        { данное переопределение значений вышезаданного массива необходимо в силу того,
           что слово "тысяча" женского рода, в отличие от обозначений всех остальных уровней;
           т.к. функция вызывается отдельно для каждого уровня, а массив определяется внутри
           функции, то данная замена не окажет влияния на уровни, отличные от 2 (тысячи) }

       if (level=2) Then
       begin
            values1to19[1]:='одна';
            values1to19[2]:='две';
       end;
        { определяем первый (слева) символ из 3-х переданных функции - разряд сотен
           значение для сравнения с условием получается путем округления вниз
           результата деления трехзначного числа (т.е. фактически просто отбрасываем
           дробную часть) }
        i:=Trunc(((number/1000)-(number div 1000))*10);
        Case  i of
            { словесное обозначение сотен до 4 включительно является уникальным,
               поэтому приходится указывать его вручную }
            0:  substringvalue:='';
            1:  substringvalue:='сто';
            2:  substringvalue:='двести';
            3:  substringvalue:='триста';
            4:  substringvalue:='четыреста';

            { значение для сотен больше 4-х может быть получено путем соединения 2-х строк:
               словесного обозначения нужной цифры и добавления дополнительного корня "сот",
               например: "пять"+"сот"="пятьсот"
               словесное обозначение конкретной цифры извлекается из вышезаданного массива }
            else   substringvalue:=values1to19[Trunc(((number/1000)-(number div 1000))*10)]+'сот';
         end;

        { получаем остаток от деления нашего трехзначного числа на 100 и проверяем, не меньше
           ли он 20. в том случае если меньше, то нет смысла дальше отдельно рассматривать
           десятки и единицы, т.к. значения с 1 до 19 у нас уже имеются - извлекаем их из
           массива и приписываем к результирующей строчке }

//        if (Trunc(((number/100)-(number div 100))*100)<20) Then
//            substringvalue:=substringvalue+' '+
//                      values1to19[Trunc(((number/100)-(number div 100))*100)]  //Trunc(((number/100)-(number div 100))*100)
        if (((number/10)-(number div 10))*10+Trunc(Trunc(((number/100)-(number div 100))*100)/10)*10<20) Then
            substringvalue:=substringvalue+' '+
                      values1to19[Round(((number/10)-(number div 10))*10)+Trunc(Trunc(((number/100)-(number div 100))*100)/10)*10]  //Trunc(((number/100)-(number div 100))*100)
        else
          {в том случае, если значение остатка от деления (двухзначное число) больше 19,
           извлекаем название разряда десятков из соответствующего массива, а число единиц
           (оставшийся разряд) - из массива чисел от 1 до 19 (реально обращение здесь будет
           происходить к значениям от 1 до 9) }
            substringvalue:=substringvalue+' '+
                   values20to90[StrToInt(IntToStr(number)[Length(IntToStr(number))-1])]+
                   ' '+values1to19[StrToInt(IntToStr(number)[Length(IntToStr(number))])];

    {     showmessage('number = '+IntToStr(number));
         showmessage('десятки = '+
            values20to90[StrToInt(IntToStr(number)[Length(IntToStr(number))-1])]);
         showmessage('единицы = '+
            values1to19[StrToInt(IntToStr(number)[Length(IntToStr(number))])]); }
        {далее по условию определяем, какое из обозначений уровня использовать:
           например:
               для значения 1 выбираем "подуровень" A,
               для значения между 1 и 5 - "подуровень" B,
               для значения больше 4 - "подуровень" C.
           данные действия необходимы для того, чтобы знать, какое название нам извлекать
           из двумерного массива названий уровней.
           также учитываем то, что для значений от 10 до 19 значения также должны попадать
           в "подуровень" C, независимо от вышеописанных диапазонов }
        if (Round(Frac(number/10)*10) =1) and (Round(Frac(number/100)*10)<>1) Then
            sublevel:=1
        else
          if (Round(Frac(number/10)*10) >=2) and
             (Round(Frac(number/10)*10) <5)  and
             (Round(Frac(number/100)*10)<>1) Then
              sublevel:=2
           else
               sublevel:=3;

        { делаем пустым определение "уровня" в случае, если все цифры данной тройки - нули }
//        if (number=0) Then levelvalues:='';

        { получаем результирующую строку, путем соединения числовых обозначений сотен, десятков
           и единиц и добавлением соответствующего существительного, определяющего уровень
           например: "сто пятнадцать" + "тысяч" = "сто пятнадцать тысяч" }
        substringvalue:=substringvalue+' '+levelvalues[level][sublevel]+' '+stringvalue;

        if level = 1 Then substringvalue:=Trim(substringvalue)+' '
                                                 +rublvalues[sublevel];

        {возвращаем полученную строку из функции }
        Result:=substringvalue;
end;



{$R *.DFM}

procedure TPrintActForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.

