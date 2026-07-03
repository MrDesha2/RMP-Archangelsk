{
                 Модуль JRPRDocForm
      формы журнала приходных накладных.

}
unit JRPRMTRForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus, ActnList;

type
  TJR_PRMTRForm = class(TForm)
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
    N5: TMenuItem;
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
//    procedure MenuAddAnotherClick(Sender: TObject);
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
  JR_PRMTRForm: TJR_PRMTRForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  ID_CST_FILTER  : integer;
  ID_WRHS_FILTER : integer;
  ID_NMNT_FILTER : integer;
  filterstring   : string;

implementation

uses 
        libs,
   ParamForm,
        Main,
FiltrOrderEdit,   // форма редактирования фильтра по таблице
PRMTRDocEditForm,
GetPeriods,
Base;
{$R *.DFM}

{
  Процедура закрытия журнала заказов
}
procedure TJR_PRMTRForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{
  Процедура ввода нового приходного документа
}
procedure TJR_PRMTRForm.ButtonAddClick(Sender: TObject);
var DocForm: TDOC_PR_MTRForm;
begin
  // проверка прав на добавление
  if not check_user_grand('DH_PR_MTR', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PR_MTRForm.CreateN(mainform, - 1, self);
  DocForm.show;

end;
{
     Процедура вызова формы редактирования формы документа "Приходная накладная"

}
procedure TJR_PRMTRForm.ButtonEditClick(Sender: TObject);
var DocForm: TDOC_PR_MTRForm;
begin
  if data.JRPRMTRFormQuery.FieldByName('ID').isnull then exit;

  IDDoc := data.JRPRMTRFormQuery.FieldByName('ID').asinteger;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PR_MTRForm.CreateN(mainform, IDDoc, self);

    // проверка прав на добавление
  DocForm.OKButton.Enabled := check_user_grand('DH_PR_MTR', 'U', true);

  DocForm.show;

end;
{
       Процедура удаления документа "Приходная накладная"

}
procedure TJR_PRMTRForm.ButtonDelClick(Sender: TObject);
var number: string;
    date  : string;
begin
  // проверка прав на добавление
  if not check_user_grand('DH_PR_MTR', 'D', true) then exit;

  if  data.JRPRMTRFormQuery.FieldByName('ID').isnull then exit;

  Number := data.JRPRMTRFormQuery.FieldByName('NumDoc').AsString;
  date   := data.JRPRMTRFormQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить приходную накладную  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.JRPRMTRFormQuery.FieldByName('ID').AsInteger;

    if not data.JRPRMTRFormQuery.Eof then
      data.JRPRMTRFormQuery.Prior;
    
    Stored_Del_Proc.ParamByName('IDDOC').asinteger := IDDoc;  //  записи.
    Stored_Del_Proc.ExecProc;
   end;

   refreshquery(data.JRPRMTRFormQuery);


end;

{

   Процедура установки интервала просмотра журнала Приходных накладных

}
procedure TJR_PRMTRForm.ButtonIntClick(Sender: TObject);
begin


  if not GetPeriod(FromDate, ToDate) then exit;

  // изменим название окна
  caption := 'Журнал приходных накладных с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

    // обновление таблиц

    with data.JRPRMTRFormQuery do
    begin

      close;
      ParamByName('datein').asdate  := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
      ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
      ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;

      open;

    end;

end;

procedure TJR_PRMTRForm.FormShow(Sender: TObject);
var    menuitem : tmenuitem;
       i : integer;

begin
  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  ID_CST_Filter := -1;  //  по журналу
  ID_WRHS_Filter:= -1;  //
  ID_NMNT_FILTER:= -1;

  with data.JRPRMTRFormQuery do

    begin
       sql.clear;
       sql.add('select * from BROWSE_PR_MTR_PROC(:dateIn, :DateOut, :ID_CST_FILTER, :ID_WRHS_FILTER, :ID_NMNT_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger := ID_CST_Filter;
       ParamByName('ID_WRHS_FILTER').asinteger:= ID_WRHS_FILTER;
       ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
       sql.add('order by date_in');
       open;

       last;
    end;

  caption := 'Журнал приходных накладных с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;

   filterstring :=  GetColumnsList('BROWSE_PR_MTR_PROC', FormGrid );
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

procedure TJR_PRMTRForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_PR_MTR_PROC', FormGrid, data.JRPRMTRFormQuery, filterstring);
  action := caFree;
end;

{
  Процедура поиска вниз

}

procedure TJR_PRMTRForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRPRMTRFormQuery.eof then data.JRPRMTRFormQuery.next;

    find(data.JRPRMTRFormQuery, FormGrid, Searchkey.text, 1);

end;
{
  Процедура поиска вверх

}
procedure TJR_PRMTRForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;

   if not data.JRPRMTRFormQuery.bof then data.JRPRMTRFormQuery.prior;
   
    find(data.JRPRMTRFormQuery, FormGrid, Searchkey.text, -1);

end;

{
   Процедура поиска по подстроке

}
procedure TJR_PRMTRForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then

    find(data.JRPRMTRFormQuery, FormGrid, Searchkey.text, 1);

end;

procedure TJR_PRMTRForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    find(data.JRPRMTRFormQuery, FormGrid, Searchkey.text, 1);

end;


{
   Процедура при редактировании таблицы
}

procedure TJR_PRMTRForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 IdDoc  := data.JRPRMTRFormQuery.FieldByName('ID').asinteger;
 
  case Key of
    45 :  ButtonAddClick(sender);   // добавление записи
    46 :  ButtonDelClick(Sender);   // удаление записи
    13 :  ButtonEditClick(sender);  // Редактирование по Enter
    VK_F5 : refreshquery( data.JRPRMTRFormQuery); // обновление таблицы
  end;

end;

procedure TJR_PRMTRForm.ToolButtonHelpClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 335);

end;

{
    Процедура ввода на основании расходной накладной



}

{
procedure TJR_PRMTRForm.MenuAddAnotherClick(Sender: TObject);
var    qTMPQuery : tQuery;
       sGrid     : tstringGrid;
       i, j      : integer;
begin

   // вызов процедуры ввода на основании прихода нового расходного документа
   //                                 : ID документа   тип неопределен   дата  форма
  // Данные по запросу проставляются в таблицу значений
  sGrid := tStringGrid.Create(self);

  qTMPQuery := tquery.create(self);
  with qTMPQuery do

    begin
      DatabaseName := 'RMP';
      sql.add('select a.id, d.id_cst, b.pr_chrt, c.id_nmnt, c.number, c.price, b.id_wrhs');
      sql.add('from dh_order a, dh_pr b, dt_pr c, dh_rqst d');
      sql.add('where b.id = :id and b.id = c.id_prmtr and c.id_ord = a.id and a.id_rqst = d.id');
      ParamByName('ID').asinteger := FormOrderQuery.FieldByName('ID').asinteger;
      Open;

      i := 0;
      while not eof do
        begin
           for j := 0 to FieldCount - 1 do
            sGrid.Cells[j, i] := inttostr(Fields[j].asinteger);

           sGrid.cells[5, i] := floattostr(Fields[5].asfloat);

           next;
           i := i + 1;
        end;
    end;



   CreateNewRS_Doc(FormOrderQuery.FieldByName('ID').asinteger, -1,         '',  self, sGrid);


end;
{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_PRMTRForm.FormKeyDown(Sender: TObject; var Key: Word;
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
procedure TJR_PRMTRForm.MenuRefreshClick(Sender: TObject);
begin

   refreshQuery( data.JRPRMTRFormQuery);

end;

procedure TJR_PRMTRForm.sort_table(type_of_sort: integer);
var strord : string;
begin

  if type_of_sort = 1 then

    strord :=  'order by date_in'

  else

    strord :=  'order by numdoc';

  with data.JRPRMTRFormQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_PR_MTR_PROC(:dateIn, :DateOut, :ID_CST_FILTER, :ID_WRHS_FILTER, :ID_NMNT_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
       ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
       ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
       sql.add(strord);
       open;

    end;


end;


{

   Сортировка документов по дате

}
procedure TJR_PRMTRForm.MenuSortByDateClick(Sender: TObject);
begin
  sort_table(1);
end;

{

   Сортировка документов по виду документов

}
procedure TJR_PRMTRForm.MenuSortByDate1Click(Sender: TObject);
begin
  sort_table(2);
end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_PRMTRForm.MenuByWidthClick(Sender: TObject);
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
procedure TJR_PRMTRForm.ButtonFilterClick(Sender: TObject);
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
  FilterForm.Label2.Caption := 'Поставщик';
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

      // если есть отбор по признаку выполнения
      if FilterForm.qWRHSQuery.Active then

        begin

           filtered := 1;
           ID_WRHS_FILTER := FilterForm.id_wrhs;

        end

       else
         ID_WRHS_FILTER := -1;

      // если есть отбор по признаку выполнения
      if FilterForm.qNMNTQuery.Active then

        begin

           filtered := 1;
           ID_NMNT_FILTER := FilterForm.id_nmnt;

        end

       else
         ID_NMNT_FILTER := -1;

       // закрытие запроса

       with data.JRPRMTRFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
          ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       ID_CST_FILTER  := -1;
       ID_WRHS_FILTER := -1;
       ID_NMNT_FILTER := -1;
       // обновление текста запроса
       with data.JRPRMTRFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
          ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
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

procedure TJR_PRMTRForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  sort_table(aCol);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;

end;

procedure TJR_PRMTRForm.ColumnSet(Sender: TObject);
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
