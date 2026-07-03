{
                 Модуль JRRSDocForm
      формы журнала расходных накладных по инструменту.

}
unit JRRSEQPTDocForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus, ActnList;

type
  TJR_RSEQPTForm = class(TForm)
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
    procedure MenuAddAnotherClick(Sender: TObject);
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
  JR_RSEQPTForm: TJR_RSEQPTForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  ID_CST_FILTER  : integer;
  ID_WRHS_FILTER : integer;
  filterstring   : string;

implementation

uses      libs,
     ParamForm,
          Main,
FiltrOrderEdit,   // форма редактирования фильтра по таблице
RSEQPTEditForm,
          Base,
    GetPeriods;
{$R *.DFM}

{
  Процедура закрытия журнала заказов
}
procedure TJR_RSEQPTForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{
  Процедура ввода нового приходного документа
}
procedure TJR_RSEQPTForm.ButtonAddClick(Sender: TObject);
var DocForm: TDOC_RSEQPTForm;
begin
  if not check_user_grand('DH_RS_EQPT', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSEQPTForm.CreateN(mainform, - 1);
  DocForm.show;

end;
{
     Процедура вызова формы редактирования формы документа "Расход"

}
procedure TJR_RSEQPTForm.ButtonEditClick(Sender: TObject);
var DocForm: TDOC_RSEQPTForm;
begin
  if  (data.JRRSEQPTFormQuery.FieldByName('ID').isnull) then exit;

  IDDoc := data.JRRSEQPTFormQuery.FieldByName('ID').asinteger;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSEQPTForm.CreateN(mainform, IDDoc);
    DocForm.OKButton.Enabled :=  check_user_grand('DH_RS_EQPT', 'U', true);

  DocForm.show;

end;
{
       Процедура удаления документа "Расход"

}
procedure TJR_RSEQPTForm.ButtonDelClick(Sender: TObject);
var number: string;
    date  : string;
begin
  if not check_user_grand('DH_PR_EQPT', 'D', true) then exit;

  if  (data.JRRSEQPTFormQuery.FieldByName('ID').isnull) then exit;

  Number := data.JRRSEQPTFormQuery.FieldByName('NumDoc').AsString;
  date   := data.JRRSEQPTFormQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить списание инструмента  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.JRRSEQPTFormQuery.FieldByName('ID').AsInteger;

    if not data.JRRSEQPTFormQuery.Eof then
      data.JRRSEQPTFormQuery.Prior;

    Stored_Del_Proc.ParamByName('IDDOC').asinteger := IDDoc;  //  записи.
    Stored_Del_Proc.ExecProc;
   end;

   refreshquery(data.JRRSEQPTFormQuery);


end;

{

   Процедура установки интервала просмотра журнала Приходных накладных

}
procedure TJR_RSEQPTForm.ButtonIntClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;


  // изменим название окна
  caption := 'Журнал списания инструмента с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // обновление таблиц

  with data.JRRSEQPTFormQuery do
    begin

      close;
      ParamByName('datein').asdate  := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
      ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;

      open;

    end;

end;

procedure TJR_RSEQPTForm.FormShow(Sender: TObject);
var    menuitem : tmenuitem;
       i : integer;

begin
  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  ID_CST_Filter := -1;  //  по журналу
  ID_WRHS_Filter:= -1;  //

  with data.JRRSEQPTFormQuery do

    begin
       sql.clear;
       sql.add('select * from BROWSE_RSEQPTDOC_PROC(:dateIn, :DateOut, :ID_CST_FILTER, :ID_WRHS_Filter)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger := ID_CST_Filter;
       ParamByName('ID_WRHS_FILTER').asinteger:= ID_WRHS_Filter;
       sql.add('order by date_in');
       open;

       last;
    end;

  caption := 'Журнал списания инструмента с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;

   filterstring := GetColumnsList('BROWSE_RSEQPTDOC_PROC', FormGrid);
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
    MainMenuByWid.Checked := FormGrid.AutoFitColWidths;
    MenuByWidth.Checked   := FormGrid.AutoFitColWidths;

end;

procedure TJR_RSEQPTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_RSEQPTDOC_PROC', FormGrid, data.JRRSEQPTFormQuery, filterstring);
  action := caFree;
end;

{
  Процедура поиска вниз

}

procedure TJR_RSEQPTForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRRSEQPTFormQuery.eof then data.JRRSEQPTFormQuery.next;

    find(data.JRRSEQPTFormQuery, FormGrid, Searchkey.text, 1);

end;
{
  Процедура поиска вверх

}
procedure TJR_RSEQPTForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;

   if not data.JRRSEQPTFormQuery.bof then data.JRRSEQPTFormQuery.prior;
   
    find(data.JRRSEQPTFormQuery, FormGrid, Searchkey.text, -1);

end;

{
   Процедура поиска по подстроке

}
procedure TJR_RSEQPTForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then

    find(data.JRRSEQPTFormQuery, FormGrid, Searchkey.text, 1);

end;

procedure TJR_RSEQPTForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    find(data.JRRSEQPTFormQuery, FormGrid, Searchkey.text, 1);

end;


{
   Процедура при редактировании таблицы
}

procedure TJR_RSEQPTForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 IdDoc  := data.JRRSEQPTFormQuery.FieldByName('ID').asinteger;
 
  case Key of
    45 :  ButtonAddClick(sender);   // добавление записи
    46 :  ButtonDelClick(Sender);   // удаление записи
    13 :  ButtonEditClick(sender);  // Редактирование по Enter
    VK_F5 : refreshquery( data.JRRSEQPTFormQuery); // обновление таблицы
  end;

end;

procedure TJR_RSEQPTForm.ToolButtonHelpClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 330);

end;

{
    Процедура ввода на основании расходной накладной



}


procedure TJR_RSEQPTForm.MenuAddAnotherClick(Sender: TObject);
begin
end;
{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_RSEQPTForm.FormKeyDown(Sender: TObject; var Key: Word;
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
procedure TJR_RSEQPTForm.MenuRefreshClick(Sender: TObject);
begin

   refreshQuery( data.JRRSEQPTFormQuery);

end;

procedure TJR_RSEQPTForm.sort_table(type_of_sort: integer);
var strord : string;
begin

  if type_of_sort = 1 then

    strord :=  'order by date_in'

  else

    strord :=  'order by numdoc';

  with data.JRRSEQPTFormQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_RSEQPTDOC_PROC(:dateIn, :DateOut, :ID_CST_FILTER, :ID_WRHS_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
       ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
       sql.add(strord);
       open;

    end;


end;


{

   Сортировка документов по дате

}
procedure TJR_RSEQPTForm.MenuSortByDateClick(Sender: TObject);
begin
  sort_table(1);
end;

{

   Сортировка документов по виду документов

}
procedure TJR_RSEQPTForm.MenuSortByDate1Click(Sender: TObject);
begin
  sort_table(2);
end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_RSEQPTForm.MenuByWidthClick(Sender: TObject);
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
procedure TJR_RSEQPTForm.ButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);

  FilterForm.id_cst := ID_cst_FILTER;
  FilterForm.id_wrhs:= ID_WRHS_Filter;
  FilterForm.id_nmnt:= -1; //ID_NMNT_FILTER;
  FilterForm.PDRCombo.Enabled := false;

  FilterForm.OnOpenForm;

  FilterForm.PDRCombo.Enabled := false;
  FilterForm.PanelCHRT.Hide;
  FilterForm.PanelWRHS.Show;
  FilterForm.PanelOperFltr.Hide;
  FilterForm.Label3.Caption := 'Подписана';
  FilterForm.Label2.Caption := 'Исполнитель';
  FilterForm.Pr_execEdit.Enabled :=false;
  FilterForm.NMNTCombo.Enabled := false;

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

//      // если есть отбор по признаку выполнения
//      if FilterForm.pr_exec <> 0 then
//
//        begin
//
//           filtered := 1;
//           PR_EXEC_FILTER := FilterForm.Pr_exec;
//
//        end
//
//       else
//         PR_EXEC_FILTER := -1;

      // если есть отбор по заказчику
      if (FilterForm.WRHSCombo.text <> '') and (FilterForm.qWRHSQuery.active) then

        begin

          filtered := 1;
          ID_WRHS_FILTER := FilterForm.id_wrhs;

        end

       else
         ID_WRHS_FILTER := -1;

       // закрытие запроса

       with data.JRRSEQPTFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       ID_CST_FILTER  := -1;
       ID_WRHS_Filter := -1;

       // обновление текста запроса
       with data.JRRSEQPTFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
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

procedure TJR_RSEQPTForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  sort_table(aCol);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;

end;

procedure TJR_RSEQPTForm.ColumnSet(Sender: TObject);
var item : tMenuItem;
    i : integer;
begin
  item := tMenuItem(sender);

  if Item.Checked then
    item.Checked := false
   else
     item.Checked := true;


//  Columns.Items[item.MenuIndex].Checked := item.Checked;

  for i := 0 to Formgrid.FieldCount - 1 do
    begin
      if (Formgrid.Columns[i].FieldName = item.Name)
       then
        Formgrid.Columns[i].Visible := item.Checked;

    end;
end;


end.
