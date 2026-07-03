{-----------------------------------------------------------------------------
 Unit Name: MainFormLib
 Author:    Косицын Дмитрий
 Purpose:   Функции обработки формы Main системы АСУ РМП
 History:   2004
-----------------------------------------------------------------------------}


unit MainFormLib;

interface

Uses Main,
  Windows, Dialogs;

    function Load_dll: boolean;
    function CheckOfOpened(_formCaption, _formname: string): boolean;


implementation


function Load_dll: boolean;
var res : boolean;
begin
  res := true;

  DLLHandle := LoadLibrary('PrintForm');

  if DLLHandle = 0 then
   begin
    showmessage('Ошибка загрузки библиотеки печати!');
    res := false;

   end;

   result := res;

end;

//
//   Функция CheckOfOpened
//   Описание: проверяет по названию открытые дочерние окна, проверка дублирования
//   Вход: название окна, выход: результат проверки
function CheckOfOpened(_formCaption, _formname: string): boolean;
var i: integer;
begin
  result := true;
  for i:= 0 to MainForm.MDIChildCount - 1 do
  begin
   if (MainForm.MDIChildren[i].Name =  _formname)
     or (MainForm.MDIChildren[i].Caption  =  _formCaption) then
    begin
     result := false;
     MainForm.MDIChildren[i].show;
    end;
  end;

end;


end.
 