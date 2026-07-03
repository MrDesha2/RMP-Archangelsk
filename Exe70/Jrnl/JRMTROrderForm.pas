{
                 Модуль JRPRDocForm
      формы журнала приходных накладных.

}
unit JRMTROrderForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus, ActnList;

type
  TJR_MTROrderForm = class(TForm)
    PanelBot: TPanel;
    PanelTop: TPanel;
    PanelMain: TPanel;
    ToolBar1: TToolBar;
    ButtonAdd: TToolButton;
    ButtonEdit: TToolButton;
    ButtonDel: TToolButton;
    ButtonInt: TToolButton;
    ToolButtonHelp: TToolButton;
    FindButton: TButton;
    Searchkey: TEdit;
    FormOrderSource: TDataSource;
    CloseButton: TButton;
    ToolButtonFindDown: TToolButton;
    ToolButtonFindUp: TToolButton;
    FormGrid: TDBGridEh;
    Stored_Del_Proc: TStoredProc;
    TableMenu: TPopupMenu;
    MenuAdd: TMenuItem;
    MenuDel: TMenuItem;
    MenuEdit: TMenuItem;
    N4: TMenuItem;
    MenuAddAnother: TMenuItem;
    N1: TMenuItem;
    MenuSortByDate: TMenuItem;
    MenuSortByDate1: TMenuItem;
    MenuRefresh: TMenuItem;
    MenuByWidth: TMenuItem;
    ButtonFilter: TToolButton;
    MenuSetInt: TMenuItem;
    ActionList: TActionList;
    acFindNext: TAction;
    acFindPrior: TAction;
    acFind: TAction;
    MainMenu: TMainMenu;
    N2: TMenuItem;
    MainMenuAdd: TMenuItem;
    MainMenuEdit: TMenuItem;
    MainMenuDel: TMenuItem;
    MainMenuInt: TMenuItem;
    MainMenuFiltr: TMenuItem;
    N3: TMenuItem;
    MainMenuRefrech: TMenuItem;
    MainMenuByWid: TMenuItem;
    Columns: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure ButtonAddClick(Sender: TObject);
    procedure ButtonEditClick(Sender: TObject);
    procedure ButtonDelClick(Sender: TObject);
    procedure ButtonIntClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButtonFindDownClick(Sender: TObject);
    procedure ToolButtonFindUpClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure FormGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonHelpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuRefreshClick(Sender: TObject);
    procedure MenuSortByDateClick(Sender: TObject);
    procedure MenuSortByDate1Click(Sender: TObject);
    procedure MenuByWidthClick(Sender: TObject);
    procedure ButtonFilterClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure FormGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure ColumnSet(Sender: TObject);
  private
    procedure sort_table(type_of_sort: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  JR_MTROrderForm: TJR_MTROrderForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  ID_CST_FILTER  : integer;
  ID_PDR_FILTER  : integer;
  PR_EXEC_FILTER : integer;
  filterstring   : string;

  
implementation

uses   
          libs,
     ParamForm,
          Main,
   DocMTROrder,
FiltrOrderEdit,   // форма редактирования фильтра по таблице
          Base,
    GetPeriods;
{$R *.DFM}

{
  Процедура закрытия журнала заказов
}
procedure TJR_MTROrderForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{
  Процедура ввода нового приходного документа
}
procedure TJR_MTROrderForm.ButtonAddClick(Sender: TObject);
var DocForm: TDOC_MTROrderForm;
begin
  if not check_user_grand('DH_MTROrder', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_MTROrderForm.CreateN(mainform, - 1, self);
  DocForm.show;

end;
{
     Процедура вызова формы редактирования формы документа "Приходная накладная"

}
procedure TJR_MTROrderForm.ButtonEditClick(Sender: TObject);
var DocForm: TDOC_MTROrderForm;
begin
  if  data.JRMTROrderQuery.FieldByName('ID').isnull then exit;

  IDDoc := data.JRMTROrderQuery.FieldByName('ID').asinteger;

  // открыть форму редактирования нового документа
  DocForm := TDOC_MTROrderForm.CreateN(mainform, IDDoc, self);
    DocForm.OKButton.Enabled :=  check_user_grand('DH_MTRORDER', 'U', true);

  DocForm.show;

end;
{
       Процедура удаления документа "Приходная накладная"

}
procedure TJR_MTROrderForm.ButtonDelClick(Sender: TObject);
var number: string;
    date  : string;
begin
  if not check_user_grand('DH_MtrOrder', 'D', true) then exit;

  if  data.JRMTROrderQuery.eof then exit;

  Number := data.JRMTROrderQuery.FieldByName('NumDoc').AsString;
  date   := data.JRMTROrderQuery.FieldByName('DateDoc').AsString;

  if messagedlg('Удалить заказ на материалы  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.JRMTROrderQuery.FieldByName('ID').AsInteger;

    if not data.JRMTROrderQuery.Eof then
      data.JRMTROrderQuery.Prior;

    Stored_Del_Proc.ParamByName('IDDOC').asinteger := IDDoc;  //  записи.
    Stored_Del_Proc.ExecProc;
   end;

   refreshquery(data.JRMTROrderQuery);


end;

{

   Процедура установки интервала просмотра журнала Приходных накладных

}
procedure TJR_MTROrderForm.ButtonIntClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;

  // изменим название окна
  caption := 'Журнал заказов на материалы с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // обновление таблиц

  with data.JRMTRORderQuery do
    begin

      close;
      ParamByName('datein').asdate  := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger := ID_CST_FILTER;
      ParamByName('ID_PDR_FILTER').asinteger := ID_PDR_FILTER;
      ParamByName('PR_EXEC_FILTER').asinteger:= PR_EXEC_FILTER;

      open;

    end;

    
end;

procedure TJR_MTROrderForm.ColumnSet(Sender: TObject);
var item : tMenuItem;
    i : integer;
begin
  item := tMenuItem(self);

  if Item.Checked then
    item.Checked := false
   else
     item.Checked := true;


//  Columns.Items[item.MenuIndex].Checked := item.Checked;

  for i := 0 to FormGrid.FieldCount - 1 do
    begin
      if (FormGrid.Columns[i].FieldName = item.Name)
       then
        FormGrid.Columns[i].Visible := item.Checked;

    end;
end;



procedure TJR_MTROrderForm.FormShow(Sender: TObject);
var i :integer;
    menuitem : tmenuitem;
begin
  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  ID_CST_Filter := -1;  //  по журналу
  ID_PDR_Filter := -1;  //

  with data.JRMTROrderQuery do

    begin
       sql.clear;
       sql.add('select * from BROWSE_MTRORDER_PROC(:dateIn, :DateOut, :ID_CST_FILTER, :ID_PDR_Filter, :PR_EXEC_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger := ID_CST_Filter;
       ParamByName('ID_PDR_FILTER').asinteger := ID_PDR_Filter;
       ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
       sql.add('order by datedoc');
       open;

       last;
    end;

  caption := 'Журнал заказов на материалы с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;



   filterstring :=  GetColumnsList('BROWSE_MTRORDER_PROC', FormGrid);
    for i := 0 to  FormGrid.Columns.Count - 1 do
    begin
       menuitem         := TMenuItem.Create(self);
       menuitem.Name    := FormGrid.Columns[i].FieldName;
       menuitem.Caption := FormGrid.Columns[i].Title.Caption;
       menuitem.Hint    := FormGrid.Columns[i].Title.Caption;
       menuitem.Checked := FormGrid.Columns[i].Visible;
       menuitem.OnClick := ColumnSet;
       Columns.Add(menuitem);


    end;



end;

procedure TJR_MTROrderForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_MTRORDER_PROC', FormGrid, data.JRMTROrderQuery, filterstring);
  action := caFree;
end;

{
  Процедура поиска вниз

}

procedure TJR_MTROrderForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRMTROrderQuery.eof then data.JRMTROrderQuery.next;

    find(data.JRMTROrderQuery, FormGrid, Searchkey.text, 1);

end;
{
  Процедура поиска вверх

}
procedure TJR_MTROrderForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;

   if not data.JRMTROrderQuery.bof then data.JRMTROrderQuery.prior;
   
    find(data.JRMTROrderQuery, FormGrid, Searchkey.text, -1);

end;

{
   Процедура поиска по подстроке

}
procedure TJR_MTROrderForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then

    find(data.JRMTROrderQuery, FormGrid, Searchkey.text, 1);

end;

procedure TJR_MTROrderForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    find(data.JRMTROrderQuery, FormGrid, Searchkey.text, 1);

end;


{
   Процедура при редактировании таблицы
}

procedure TJR_MTROrderForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 IdDoc  := data.JRMTROrderQuery.FieldByName('ID').asinteger;
 
  case Key of
    45 :  ButtonAddClick(sender);   // добавление записи
    46 :  ButtonDelClick(Sender);   // удаление записи
    13 :  ButtonEditClick(sender);  // Редактирование по Enter
    VK_F5 : refreshquery( data.JRMTROrderQuery); // обновление таблицы
  end;

end;

procedure TJR_MTROrderForm.ToolButtonHelpClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 330);

end;

{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_MTROrderForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
     EscPressed := True;
     abort;
     
   end;

end;
{

   Процедура обновления таблицы запроса

}
procedure TJR_MTROrderForm.MenuRefreshClick(Sender: TObject);
begin

   refreshQuery( data.JRMTROrderQuery);

end;

procedure TJR_MTROrderForm.sort_table(type_of_sort: integer);
var strord : string;
begin

  if type_of_sort = 1 then

    strord :=  'order by datedoc'

  else

    strord :=  'order by numdoc';

  with data.JRMTROrderQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_MTRORDER_PROC(:dateIn, :DateOut, :ID_CST_FILTER, :ID_PDR_FILTER, :PR_EXEC_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger := ID_CST_FILTER;
       ParamByName('ID_PDR_FILTER').asinteger := ID_PDR_FILTER;
       ParamByName('PR_EXEC_FILTER').asinteger:= PR_EXEC_FILTER;
       sql.add(strord);
       open;

    end;


end;


{

   Сортировка документов по дате

}
procedure TJR_MTROrderForm.MenuSortByDateClick(Sender: TObject);
begin
  sort_table(1);
end;

{

   Сортировка документов по виду документов

}
procedure TJR_MTROrderForm.MenuSortByDate1Click(Sender: TObject);
begin
  sort_table(2);
end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_MTROrderForm.MenuByWidthClick(Sender: TObject);
begin
   if MenuByWidth.Checked then
     begin
       MenuByWidth.Checked := false;
       MainMenuByWid.checked := false
     end
   else
     begin

        MainMenuByWid.Checked := true;
        MenuByWidth.Checked := true;
     end;
    FormGrid.AutoFitColWidths := MenuByWidth.Checked;

end;

{

    Процедура установки фильтра по журналу документов

}
procedure TJR_MTROrderForm.ButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);

  FilterForm.id_cst := ID_cst_FILTER;
  FilterForm.id_pdr := ID_PDR_Filter;


  FilterForm.OnOpenForm;

//  FilterForm.PDRCombo.Enabled := false;
  FilterForm.PanelCHRT.Hide;
  FilterForm.PanelWRHS.hide;
  FilterForm.Label1.Caption := 'Заказчик:';
  FilterForm.Label3.Caption := 'Статус заказа:';
  FilterForm.Label2.Caption := 'Поставщик:';
  FilterForm.Pr_execEdit.MaxValue := 2;

  // если установлен фильтр
  if FilterForm.showmodal = mrOK then

    begin

      // если есть отбор по заказчику
      if (FilterForm.CSTCombo.text <> '') and (FilterForm.qCSTQuery.active) then

        begin

          filtered := 1;
          ID_CST_FILTER := FilterForm.id_cst;

        end

       else
         ID_CST_FILTER := -1;

      // если есть отбор по заказчику
      if (FilterForm.PDRCombo.text <> '') and (FilterForm.qPDRQuery.active) then

        begin

          filtered := 1;
          ID_PDR_FILTER := FilterForm.id_pdr;

        end

       else
         ID_PDR_FILTER := -1;

      // если есть отбор по признаку выполнения
      if FilterForm.pr_exec <> 0 then

        begin

           filtered := 1;
           PR_EXEC_FILTER := FilterForm.Pr_exec;

        end

       else

         PR_EXEC_FILTER := -1;


       // закрытие запроса
       with data.JRMTROrderQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
          ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       ID_CST_FILTER  := -1;
       ID_PDR_Filter  := -1;
       PR_EXEC_FILTER := -1;

       // обновление текста запроса
       with data.JRMTROrderQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger := ID_CST_FILTER;
          ParamByName('ID_PDR_FILTER').asinteger := ID_PDR_FILTER;
          ParamByName('PR_EXEC_FILTER').asinteger:= PR_EXEC_FILTER;
          Open;

         end;

     end;

  FilterForm.Close;


   if filtered = 1 then
     ButtonFilter.Down := true
   else
     ButtonFilter.Down := false;

end;


{
   Процедура нажатия кнопки заголовка

}

procedure TJR_MTROrderForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  sort_table(aCol);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;

end;

end.
