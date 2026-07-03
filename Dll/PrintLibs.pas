{
     Функции для работы со строками при печати

}

unit PrintLibs;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, ComCtrls, math, inifiles;


{
  Функция возвращает строку заданной длины. Если длина меньше
  заданой, то дополняет пробелами.
}
function leftstr(source: string; len : integer): string;

function RepeatLine(Ch : Char; i : Integer):String;
function LeftLine(S : String; i : Integer):String;
function RightLine(S : String; i : Integer):String;
function CentrLine(S : String; i : Integer):String;


{
  Процедура заменяет найденный шаблон значением
}
procedure replacePattern(editor : TRichEdit; pattern, strvalue : string; type_alignment : integer);
{
  Функция находит строку шаблона табличной части и возвращает шаблон строки
}
function  TablePattern(editor : tRichedit; pattern : string): string;

{
   Возвращает месяц строкой от заданной даты
   Вход: дата
}
function MonthByString(_date : tdatetime) : string;

function DateByString(_date : tdatetime) : string;

function begmonth(_date : tdatetime): tdatetime;

function endmonth(_date : tdatetime): tdatetime;
{
 возвращает год ввиде строки
 Вход: дата
}
function GetYearStr(_date : tdatetime) : string;

{
   функция возвращает константу по названию
}
function GetSystemParams(paramname : string): string;

function conv2words (number: integer; level: integer): string;

function CodeString(s:string;code:boolean):string;


implementation


{
  Функция возвращает строку заданной длины. Если длина меньше
  заданой, то дополняет пробелами.

  Вход: строка источник;
        требуемая длина.
  Выход: новая строка.
}

function leftstr(source: string; len : integer): string;
var i, stlen : integer;
begin
  result := '';
  stlen := strlen(pchar(source));

//  for i := 1 to max(len, stlen) do
  for i := 1 to len do

    if i <= stlen then

      result := result + source[i]

    else

      result := result + ' ';

end;

//Функция возвращаяет повторенный Ch символ i раз
function RepeatLine(Ch : Char; i : Integer):String;

var j : Integer;

begin
        Result:='';
        For j:=1 to i do
          Result:=Result+Ch;


end;

//Функция возвращаяет строку длинной i символов с прижатой влево подстрокой S
function LeftLine(S : String; i : Integer):String;
var sstr : String;
begin
        Result:='';
        sstr:=Copy(Trim(S),1,i);
        If Length(sstr)<i Then sstr:=sstr+RepeatLine(' ', i-Length(sstr));
        Result:=sstr;
end;

//Функция возвращаяет строку длинной i символов с прижатой вправо подстрокой S
function RightLine(S : String; i : Integer):String;
var sstr : String;
begin
        Result:='';
        sstr:=Copy(Trim(S),1,i);
        If Length(sstr)<i Then sstr:=RepeatLine(' ', i-Length(sstr))+sstr;
        Result:=sstr;
end;

//Функция возвращаяет строку длинной i символов с расположеной по центру
// подстрокой S
function CentrLine(S : String; i : Integer):String;
var sstr : String;
begin
        Result:='';
        sstr:=Copy(Trim(S),1,i);
        If Length(sstr)<i Then sstr:=RepeatLine(' ', (i-Length(sstr)) div 2)+sstr+RepeatLine(' ', i-(((i-Length(sstr)) div 2)+Length(sstr)));
        Result:=sstr;
end;


{
    Процедура замены шаблона строкой в редакторе
    Вход: editor - редактор;
         pattern - строка шаблона;
         strvalue- значение шаблона;
         type_alignment - тип выравнивания: 0 - по левому краю, 1 - по центру, 2 - по правому
    Выход: новая строка в редакторе.

}
procedure replacePattern(editor : TRichEdit; pattern, strvalue : string; type_alignment : integer);
var foundAt : integer;
    foundTo : integer;
    lenstr  : integer;
begin

  with Editor do
    begin
     // найдем вхождение шаблона
     foundAt := FindText('[' + pattern, 0, Length(Editor.Text), [stMatchCase]);
     // окончание шаблона
     foundTo := FindText(']', foundAt, Length(Editor.Text), [stMatchCase]);

     SelStart := foundAt;
     SelLength:= foundTo - foundAt + 1;

     case type_alignment of
       0: // выравнивание по левому краю
          begin

              SelText  := leftStr(strvalue, foundTo - FoundAt );

          end;
       1: // выравнивание по центру
         begin

             lenstr := StrLen(PChar(strvalue));
             // если строка не влезает полностью
             if lenstr > SelLength then

                SelText  := leftStr(strvalue, foundTo - FoundAt )

             else

                begin
                   //    выравнивание по центру строки
                   //    с начала и в конце добавление по половинке длины строки пробелами.
                   //
                   if (SelLength - lenstr) mod 2 = 0 then

                     SelText := leftStr('', (SelLength - lenstr) div 2 ) +
                                leftStr(strvalue, (SelLength - lenstr) div 2 + lenstr)

                    else

                     SelText := leftStr('', (SelLength - lenstr) div 2 ) +
                                leftStr(strvalue, (SelLength - lenstr) div 2 + lenstr ) + ' ';


                end;

         end;

        2: // выравнивание по правому краю
          begin

             lenstr := StrLen(PChar(strvalue));
             // если строка не влезает полностью
             if lenstr > SelLength then

                SelText  := leftStr(strvalue, foundTo - FoundAt )

             else

                begin

                  SelText := leftStr('', SelLength - lenstr) + strvalue;

                end;

          end;

      end;
    end;

end;

{
   Функция работы с шаблоном табличной части
   Вход: редактор - tRichEdit;
         шаблон таблицы
   Выход: внутренний шаблон табличной части.
   Описание: находит строку табличной части по заданному шаблону,
   выделяет шаблон строки, удаяет строку таблицы.

}
function  TablePattern(editor : tRichedit; pattern : string): string;
var lineno : integer;
    foundAt : integer;
    foundTo : integer;
begin
  with editor do
    begin
      // найдем вхождение шаблона
      foundAt := FindText('[' + pattern, 0, Length(Editor.Text), [stMatchCase]);
      // окончание шаблона
      foundTo := FindText(']', foundAt, Length(Editor.Text), [stMatchCase]);

      // сдвигаемся на конец шаблона
      foundAt := foundTo + 1;

      // окончание шаблона
      foundTo := FindText('[/end]', foundAt, Length(Editor.Text), [stMatchCase]);

      // все, что между ними, нужно запомнить. остальное удалить целой строкой
      // вырезаем выделенный кусок
      SelStart := foundAt;

      // номер строки
      lineno  := editor.CaretPos.y;

      // конец выделения
      SelLength:= foundTo - foundAt;

      // запомним, что нужно
      result := SelText;

      // строку удаляем
      lines.delete(lineno);

    end;
end;


{

       Функции работы с датой
}
function MonthByString(_date : tdatetime) : string;
var
  Year, Month, Day: Word;
begin

   DecodeDate(_date, Year, Month, Day);
   case month of
     1: result := 'Январь';
     2: result := 'Февраль';
     3: result := 'Март';
     4: result := 'Апрель';
     5: result := 'Май';
     6: result := 'Июнь';
     7: result := 'Июль';
     8: result := 'Август';
     9: result := 'Сентябрь';
     10: result := 'Октябрь';
     11: result := 'Ноябрь';
     12: result := 'Декабрь';
   end;

end;

function DateByString(_date : tdatetime) : string;
var
  Year, Month, Day: Word;

begin
   DecodeDate(_date, Year, Month, Day);

   result := inttostr(day) + ' ';
   case month of
     1: result := result + 'января';
     2: result := result + 'февраля';
     3: result := result + 'марта';
     4: result := result + 'апреля';
     5: result := result + 'мая';
     6: result := result + 'июня';
     7: result := result + 'июля';
     8: result := result + 'августа';
     9: result := result + 'сентября';
     10: result := result + 'октября';
     11: result := result + 'ноября';
     12: result := result + 'декабря';
   end;
   result := result + ' ' + inttostr(Year) + ' года';



end;

function begmonth(_date : tdatetime): tdatetime;
var Year, Month, Day: Word;
begin
  DecodeDate(_date, Year, Month, Day);
  result := strtodate('01.'
           + inttostr(Month)
           + '.' + inttostr(year));

end;

function endmonth(_date : tdatetime): tdatetime;
var Year, Month, Day: Word;
begin
  DecodeDate(_date, Year, Month, Day);
  _date  := strtodate('01.'
          + inttostr(Month)
          + '.' + inttostr(year));

  result := incmonth(_date, 1) + 1;

end;

function GetYearStr(_date : tdatetime) : string;
var Year, Month, Day: Word;
begin
  DecodeDate(_date, Year, Month, Day);
  Result := IntToStr(Year);
end;

{-----------------------------------------------------------------------------
  Функция: GetSystemParams
  аргумент: paramname : string
  результат:    string
  Описание:
      функция возвращает константу по названию
-----------------------------------------------------------------------------}

function GetSystemParams(paramname : string): string;
var INIFile : tINIFile;
    FileName: string;

begin
  FileName := ExtractFilePath(Application.EXEName) + 'rmp.ini';
  INIFile  := TIniFile.Create(FileName);

  If ((paramname = 'POST_PASSWORD') or (paramname = 'POST_USERNAME') or (paramname = 'ADRESS_FROM')) Then
      result := CodeString(INIFile.ReadString('Config', paramname, ''),false)
   Else
        result := INIFile.ReadString('Config', paramname, '');

end;


{ converting function
   функция, производящая конвертирование чисел в текст.
   функции передаются 2 аргумента:
   $number - трех- или меньше значное число,
   $level - "уровень" этого числа. уровень считается справа, каждый
   уровень состоит из 3-х цифр (или меньше, если уровень самый левый
   и на него не хватило цифр). например, число 1435777 состоит из 3-х уровней:
   777 - 1-й уровень (сотни), 435 - 2-й уровень (тысячи), 1 (001) - 3-й уровень (миллионы) }
function conv2words (number: integer; level: integer): string;
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

function CodeString(s:string;code:boolean):string;
const
   Pas=10;
var
  i,Delta,Res:integer;
begin
  Result:='';
  for i:=1 to Length(s) do
  begin
    Delta:=((i xor Pas) mod (256-32));
    if code then
      Res:=((ord(s[i])+Delta) mod (256-32))+32
    else
    begin
      Res:=ord(s[i])-Delta-32;
      if Res<32 then
        Res:=Res+256-32;
    end;
      Result:=Result+chr(Res);
  end;
end;



end.
