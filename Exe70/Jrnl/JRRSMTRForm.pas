{
                 Модуль JRRSDocForm
      формы журнала отпуска материалов со склада.



      

}
unit JRRSMTRForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus, ActnList;

type
  TJR_RSMTRForm = class(TForm)
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
    MenuSort: TMenuItem;
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
    MainMenuRefresh: TMenuItem;
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
  JR_RSMTRForm: TJR_RSMTRForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  sorting       : integer;     // направление сортировки журнала
  sortingdoc    : integer;     // направление сортировки журнала

  ID_WRHS_FILTER : integer;
  ID_CST_FILTER  : integer;
  ID_NMNT_FILTER : integer;
  filterstring   : string;


implementation

uses     
       ParamForm,
            libs,
            Main,
  FiltrOrderEdit,   // форма редактирования фильтра по таблице
RSMTRDocEditForm,
      GetPeriods,
            Base;
{$R *.DFM}

{
  Процедура закрытия журнала заказов
}
procedure TJR_RSMTRForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{
  Процедура ввода нового расходного документа
}
procedure TJR_RSMTRForm.AddButtonClick(Sender: TObject);
var DocForm: TDOC_RS_MTRForm;
begin
  // проверка прав на добавление
  if not check_user_grand('DH_RS_MTR', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RS_MTRForm.CreateN(mainform, - 1, self);
  DocForm.show;

end;
{
     Процедура вызова формы редактирования формы документа "Расходная накладная"

}
procedure TJR_RSMTRForm.EditButtonClick(Sender: TObject);
var DocForm: TDOC_RS_MTRForm;
begin
  if  (data.JRRSMPRFormQuery.FieldByName('ID').isnull) then exit;

  IDDoc := data.JRRSMPRFormQuery.FieldByName('ID').asinteger;
  // открыть форму редактирования нового документа
  DocForm := TDOC_RS_MTRForm.CreateN(mainform, IDDoc, self);

  // проверка прав на добавление
  DocForm.OKButton.Enabled := check_user_grand('DH_RS_MTR', 'U', true);

  DocForm.show;

end;
{
       Процедура удаления документа "Расходная накладная"

}
procedure TJR_RSMTRForm.DelButtonClick(Sender: TObject);
var number: string;
    date  : string;
begin

  // проверка прав на добавление
  if not check_user_grand('DH_RS_MTR', 'D', true) then exit;

  if  data.JRRSMPRFormQuery.FieldByName('ID').isnull then exit;

  Number := data.JRRSMPRFormQuery.FieldByName('NumDoc').AsString;
  date   := data.JRRSMPRFormQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить расходную накладную  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.JRRSMPRFormQuery.FieldByName('ID').AsInteger;

    if not data.JRRSMPRFormQuery.Eof then
      data.JRRSMPRFormQuery.Prior;

    Stored_Del_Proc.ParamByName('IDDoc').asinteger := IDDoc;  //  записи.
    Stored_Del_Proc.ExecProc;
   end;

   refreshquery(data.JRRSMPRFormQuery);

end;
{
   Процедура установки интервала просмотра журнала расходных накладных

}
procedure TJR_RSMTRForm.IntButtonClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;

  // изменим название окна
  caption := 'Журнал расходных накладных с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // обновление таблиц
  with data.JRRSMPRFormQuery do

    begin
      close;
      ParamByName('datein').asdate := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
      ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
      ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
      open;

    end;

    
end;

procedure TJR_RSMTRForm.FormShow(Sender: TObject);
var    menuitem : tmenuitem;
       i : integer;
begin
  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  with data.JRRSMPRFormQuery do

    begin
    
       sql.clear;
       sql.add('select * from BROWSE_RS_MTR_PROC(:dateIn, :dateOut, :ID_CST_FILTER, :ID_WRHS_FILTER, :ID_NMNT_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
       ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
       ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
       sql.add('order by date_in');
       open;

       last;

       // сортировка по умолчанию по дате
       sorting    := 0;
       sortingdoc := 0;
    end;

  caption := 'Журнал отпуска материалов с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;

   filterstring :=   GetColumnsList('BROWSE_RS_MTR_PROC', FormGrid);
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

procedure TJR_RSMTRForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_RS_MTR_PROC', FormGrid, data.JRRSMPRFormQuery, filterstring);
  action := caFree;
end;

{
   Процедура поиска по подстроке

}
procedure TJR_RSMTRForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then
      find(data.JRRSMPRFormQuery, FormGrid, Searchkey.text, 1);

end;
{
  Процедура поиска вниз

}

procedure TJR_RSMTRForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRRSMPRFormQuery.eof then data.JRRSMPRFormQuery.next;

     find(data.JRRSMPRFormQuery, FormGrid, Searchkey.text, 1);


end;
{
  Процедура поиска вверх

}
procedure TJR_RSMTRForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRRSMPRFormQuery.bof then data.JRRSMPRFormQuery.prior;

     find(data.JRRSMPRFormQuery, FormGrid, Searchkey.text, -1);


end;


procedure TJR_RSMTRForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin

  if key = #13 then

     find(data.JRRSMPRFormQuery, FormGrid, Searchkey.text, 1);

end;



{
   Процедура при редактировании таблицы
}

procedure TJR_RSMTRForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 IdDoc  := data.JRRSMPRFormQuery.FieldByName('ID').asinteger;
 
  case Key of
    45 :  AddButtonClick(sender);   // добавление записи
    46 :  DelButtonClick(Sender);   // удаление записи
    13 :  EditButtonClick(sender);  // Редактирование по Enter
    VK_F5 : refreshquery( data.JRRSMPRFormQuery); // обновление таблицы

  end;

end;

procedure TJR_RSMTRForm.HelpButtonClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 345);

end;


{
    Отбор по документу


}
procedure TJR_RSMTRForm.ButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);
  FilterForm.id_cst := ID_cst_FILTER;
  FilterForm.id_wrhs:= ID_WRHS_FILTER;
  FilterForm.id_nmnt:= ID_NMNT_FILTER;

  FilterForm.OnOpenForm;

  FilterForm.PDRCombo.Enabled := false;
  FilterForm.PanelCHRT.Hide;
  FilterForm.PanelOperFltr.Hide;
  FilterForm.Label2.Caption := 'Получатель:';
  FilterForm.Label3.hide;
  FilterForm.Label1.hide;
  FilterForm.Pr_execEdit.Hide;
  FilterForm.PDRCombo.hide;
  FilterForm.Pr_execEdit.MaxValue := 1;
  FilterForm.PanelWRHS.Show;

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

       // закрытие запроса

       with data.JRRSMPRFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
          ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       ID_WRHS_FILTER := -1;
       ID_CST_FILTER  := -1;
       ID_NMNT_FILTER := -1;
       // обновление текста запроса
       with data.JRRSMPRFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
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

    Проверка, какая кнопка была нажата в форме

}
procedure TJR_RSMTRForm.FormKeyDown(Sender: TObject; var Key: Word;
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
procedure TJR_RSMTRForm.sort_table(type_of_sort: integer);
var strord : string;
begin

   case type_of_sort of

     0 : strord :=  'order by date_in, type_doc';
     1 : strord :=  'order by date_in descending, type_doc';
     2 : strord :=  'order by type_doc, date_in';
     3 : strord :=  'order by type_doc descending, date_in';
     4 : strord :=  'order by numdoc, date_in';
   end;

  with data.JRRSMPRFormQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_RS_MTR_PROC(:dateIn, :dateOut, :ID_CST_FILTER, :ID_WRHS_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
       ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
       sql.add(strord);
       open;

    end;


end;

procedure TJR_RSMTRForm.MenuSortByDateClick(Sender: TObject);
begin

  if sorting = 0 then
    sorting := 1
  else
    sorting := 0;


  sort_table(sorting + sortingdoc);


end;

procedure TJR_RSMTRForm.MenuSotrByDocClick(Sender: TObject);
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
procedure TJR_RSMTRForm.MenuRefreshClick(Sender: TObject);
begin

  refreshQuery( data.JRRSMPRFormQuery );

end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_RSMTRForm.MenuByWidthClick(Sender: TObject);
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
procedure TJR_RSMTRForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  if ACol = 0 then
     sort_table(4)
  else
    sort_table(0);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;
end;

procedure TJR_RSMTRForm.ColumnSet(Sender: TObject);
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
