{
                 Модуль JRRSDocForm
      формы журнала расходных накладных готовой продукции.

}
unit JRRSDocForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus, ActnList;

type
  TJR_RSDocForm = class(TForm)
    PanelBot: TPanel;
    PanelTop: TPanel;
    PanelMain: TPanel;
    ToolBar: TToolBar;
    AddButton: TToolButton;
    EditButton: TToolButton;
    DelButton: TToolButton;
    IntButton: TToolButton;
    HelpButton: TToolButton;
    FindButton: TButton;
    Searchkey: TEdit;
    FormOrderSource: TDataSource;
    CloseButton: TButton;
    FormGrid: TDBGridEh;
    ButtonFilter: TToolButton;
    ToolButtonFindDown: TToolButton;
    ToolButtonFindUp: TToolButton;
    Stored_del_Proc: TStoredProc;
    TableMenu: TPopupMenu;
    MenuAdd: TMenuItem;
    MenuEdit: TMenuItem;
    MenuDel: TMenuItem;
    Separator: TMenuItem;
    N1: TMenuItem;
    MenuSortByDate: TMenuItem;
    MenuSotrByDoc: TMenuItem;
    MenuRefresh: TMenuItem;
    MenuByWidth: TMenuItem;
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
    N5: TMenuItem;
    MainMenuByWid: TMenuItem;
    Columns: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure IntButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FindButtonClick(Sender: TObject);
    procedure ToolButtonFindDownClick(Sender: TObject);
    procedure ToolButtonFindUpClick(Sender: TObject);
    procedure FormGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HelpButtonClick(Sender: TObject);
    procedure ButtonFilterClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuSortByDateClick(Sender: TObject);
    procedure MenuSotrByDocClick(Sender: TObject);
    procedure MenuRefreshClick(Sender: TObject);
    procedure sort_table(type_of_sort: integer);
    procedure MenuByWidthClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure FormGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure ColumnSet(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  JR_RSDocForm: TJR_RSDocForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  sorting       : integer;     // направление сортировки журнала
  sortingdoc    : integer;     // направление сортировки журнала

  ID_PDR_FILTER  : integer;
  ID_CST_FILTER  : integer;
  ID_WRHS_FILTER : integer;
  PR_EXEC_FILTER : integer;
  ID_NMNT_FILTER : integer;
  filterstring   : string;

implementation

uses   
     ParamForm,
          libs,
          Main,
FiltrOrderEdit,   // форма редактирования фильтра по таблице
 RSDocEditForm,
          Base,
    GetPeriods;
{$R *.DFM}

{
  Процедура закрытия журнала заказов
}
procedure TJR_RSDocForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{
  Процедура ввода нового расходного документа
}
procedure TJR_RSDocForm.AddButtonClick(Sender: TObject);
var DocForm: TDOC_RSForm;
begin
  // проверка прав на добавление
  if not check_user_grand('DH_RS', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSForm.CreateN(mainform, - 1, 1, self);
  DocForm.show;

end;
{
     Процедура вызова формы редактирования формы документа "Расходная накладная"

}
procedure TJR_RSDocForm.EditButtonClick(Sender: TObject);
var DocForm: TDOC_RSForm;
begin

  if  data.JRRSFormQuery.FieldByName('ID').isnull then exit;

  IDDoc := data.JRRSFormQuery.FieldByName('ID').asinteger;
  // открыть форму редактирования нового документа
  DocForm := TDOC_RSForm.CreateN(mainform, IDDoc, 1, self);
   // проверка прав на добавление
   DocForm.OKButton.Enabled := check_user_grand('DH_RS', 'U', true);

  DocForm.show;

end;
{
       Процедура удаления документа "Расходная накладная"

}
procedure TJR_RSDocForm.DelButtonClick(Sender: TObject);
var number: string;
    date  : string;
begin
  // проверка прав на добавление
  if not check_user_grand('DH_RS', 'D', true) then exit;


  if  data.JRRSFormQuery.FieldByName('ID').isnull then exit;

  Number := data.JRRSFormQuery.FieldByName('NumDoc').AsString;
  date   := data.JRRSFormQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить расходную накладную  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.JRRSFormQuery.FieldByName('ID').AsInteger;

    if not data.JRRSFormQuery.Eof then
      data.JRRSFormQuery.Prior;

    Stored_Del_Proc.ParamByName('IDDoc').asinteger := IDDoc;  //  записи.
    Stored_Del_Proc.ExecProc;
   end;

   refreshquery(data.JRRSFormQuery);

end;
{
   Процедура установки интервала просмотра журнала расходных накладных

}
procedure TJR_RSDocForm.IntButtonClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;

  // изменим название окна
  caption := 'Журнал расходных накладных с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // обновление таблиц
  with data.JRRSFormQuery do

    begin
      close;
      ParamByName('datein').asdate := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
      ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
      ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
      ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
      open;

    end;

end;

procedure TJR_RSDocForm.FormShow(Sender: TObject);
var    menuitem : tmenuitem;
       i : integer;

begin
  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  ID_CST_Filter := -1;  //  по журналу
  PR_EXEC_Filter:= -1;  //
  ID_WRHS_Filter:= -1;
  ID_NMNT_FILTER:= -1;

  with data.JRRSFormQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_RSDOC_PROC(:dateIn, :dateOut, :ID_CST_FILTER, :PR_EXEC_FILTER, :ID_WRHS_Filter, :ID_NMNT_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
       ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
       ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
       ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
       sql.add('order by date_in');
       open;

       last;

       // сортировка по умолчанию по дате
       sorting    := 0;
       sortingdoc := 0;
    end;

  caption := 'Журнал расходных накладных с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;

   filterstring := GetColumnsList('BROWSE_RSDOC_PROC', FormGrid);
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

procedure TJR_RSDocForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_RSDOC_PROC', FormGrid, data.JRRSFormQuery, filterstring);
  action := caFree;
end;

{
   Процедура поиска по подстроке

}
procedure TJR_RSDocForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then
      find(data.JRRSFormQuery, FormGrid, Searchkey.text, 1);

end;
{
  Процедура поиска вниз

}

procedure TJR_RSDocForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRRSFormQuery.eof then data.JRRSFormQuery.next;

     find(data.JRRSFormQuery, FormGrid, Searchkey.text, 1);


end;
{
  Процедура поиска вверх

}
procedure TJR_RSDocForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRRSFormQuery.bof then data.JRRSFormQuery.prior;

     find(data.JRRSFormQuery, FormGrid, Searchkey.text, -1);


end;


procedure TJR_RSDocForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then

     find(data.JRRSFormQuery, FormGrid, Searchkey.text, 1);

end;



{
   Процедура при редактировании таблицы
}

procedure TJR_RSDocForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 IdDoc  := data.JRRSFormQuery.FieldByName('ID').asinteger;
 
  case Key of
    45 :  AddButtonClick(sender);   // добавление записи
    46 :  DelButtonClick(Sender);   // удаление записи
    13 :  EditButtonClick(sender);  // Редактирование по Enter
    VK_F5 : refreshquery( data.JRRSFormQuery); // обновление таблицы

  end;

end;

procedure TJR_RSDocForm.HelpButtonClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 340);

end;


{
    Отбор по документу


}
procedure TJR_RSDocForm.ButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);

  FilterForm.id_pdr := ID_PDR_FILTER;
  FilterForm.id_cst := ID_cst_FILTER;
  FilterForm.pr_exec:= PR_EXEC_FILTER;
  FilterForm.id_wrhs:= ID_WRHS_FILTER;
  FilterForm.id_nmnt:= ID_NMNT_FILTER;

  FilterForm.OnOpenForm;

  FilterForm.PDRCombo.Enabled := false;
  FilterForm.PanelCHRT.Hide;
  FilterForm.PanelWRHS.Show;
  FilterForm.PanelOperFltr.Hide;
  FilterForm.Label3.Caption := 'Подписана';
  FilterForm.Label2.Caption := 'Заказчик';
  FilterForm.Pr_execEdit.MaxValue := 1;

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

      // если есть отбор по складу
      if (FilterForm.WRHSCombo.text <> '') and (FilterForm.qWRHSQuery.active) then

        begin

          filtered := 1;
          ID_WRHS_FILTER := FilterForm.id_wrhs;

        end

       else
         ID_WRHS_FILTER := -1;

      // если есть отбор по номенклатуре
      if (FilterForm.NMNTCombo.text <> '') and (FilterForm.qNMNTQuery.active) then

        begin

          filtered := 1;
          ID_NMNT_FILTER := FilterForm.id_nmnt;

        end

       else
         ID_NMNT_FILTER := -1;

      // если есть отбор по признаку выполнения
      if FilterForm.pr_exec <> 0 then

        begin

           filtered := 1;
           PR_EXEC_FILTER := FilterForm.Pr_exec;

        end

       else
         PR_EXEC_FILTER := -1;


       // закрытие запроса

       with data.JRRSFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
          ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
          ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       ID_PDR_FILTER := -1;
       ID_CST_FILTER := -1;
       ID_WRHS_Filter:= -1;
       ID_NMNT_FILTER:= -1;
       PR_EXEC_FILTER := -1;
       // обновление текста запроса
       with data.JRRSFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
          ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
          ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
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

    Проверка, какая кнопка была нажата в форме

}
procedure TJR_RSDocForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
   begin
     EscPressed := True;
     abort;
     
   end;

end;
{

    Процедура установки сортировки таблицы

    Вход: направление сортировки


}
procedure TJR_RSDocForm.sort_table(type_of_sort: integer);
var strord : string;
begin

   case type_of_sort of

     0 : strord :=  'order by date_in, type_doc';
     1 : strord :=  'order by date_in descending, type_doc';
     2 : strord :=  'order by type_doc, date_in';
     3 : strord :=  'order by type_doc descending, date_in';
     4 : strord :=  'order by numdoc, date_in';
   end;

  with data.JRRSFormQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_RSDOC_PROC(:dateIn, :dateOut, :ID_CST_FILTER, :PR_EXEC_FILTER, :ID_WRHS_FILTER, :ID_NMNT_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
       ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
       ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
       ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
       sql.add(strord);
       open;

    end;


end;

procedure TJR_RSDocForm.MenuSortByDateClick(Sender: TObject);
begin

  if sorting = 0 then
    sorting := 1
  else
    sorting := 0;


  sort_table(sorting + sortingdoc);


end;

procedure TJR_RSDocForm.MenuSotrByDocClick(Sender: TObject);
begin

  if sortingdoc = 0 then
    sortingdoc := 2
  else
    sortingdoc := 0;

  sort_table(sorting + sortingdoc);

end;
{

    Процедура обновления запроса

}
procedure TJR_RSDocForm.MenuRefreshClick(Sender: TObject);
begin

  refreshQuery( data.JRRSFormQuery );

end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_RSDocForm.MenuByWidthClick(Sender: TObject);
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
   Процедура нажатия кнопки заголовка

}
procedure TJR_RSDocForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  if ACol = 0 then
     sort_table(4)
  else
    sort_table(0);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;
end;

procedure TJR_RSDocForm.ColumnSet(Sender: TObject);
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
