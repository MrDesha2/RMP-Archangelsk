{
                 Модуль JRPRDocForm
      формы журнала приходных накладных по инструменту.

}
unit JRRQSTEQPTDocForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus, ActnList;

type
  TJR_RQSTEQPTForm = class(TForm)
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
  JR_RQSTEQPTForm: TJR_RQSTEQPTForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  ID_PDR_FILTER  : integer;
  ID_WRKR_FILTER : integer;
  filterstring   : string;

implementation

uses      libs,
     ParamForm,
          Main,
FiltrOrderEdit,   // форма редактирования фильтра по таблице
RQSTEQPTEditForm,
          Base,
    GetPeriods;
{$R *.DFM}

{
  Процедура закрытия журнала заказов
}
procedure TJR_RQSTEQPTForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{
  Процедура ввода нового  документа
}
procedure TJR_RQSTEQPTForm.ButtonAddClick(Sender: TObject);
var DocForm: TDOC_RQSTEQPTForm;
begin
  if not check_user_grand('DH_RQST_EQPT', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RQSTEQPTForm.CreateN(mainform, - 1);
  DocForm.show;

end;
{
     Процедура вызова формы редактирования формы документа "Приходная накладная"

}
procedure TJR_RQSTEQPTForm.ButtonEditClick(Sender: TObject);
var DocForm: TDOC_RQSTEQPTForm;
begin
  if  (data.qJRRQSTEQPTQuery.FieldByName('ID').isnull) then exit;

  IDDoc := data.qJRRQSTEQPTQuery.FieldByName('ID').asinteger;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RQSTEQPTForm.CreateN(mainform, IDDoc);
    DocForm.OKButton.Enabled :=  check_user_grand('DH_RQST_EQPT', 'U', true);

  DocForm.show;

end;
{
       Процедура удаления документа "Приходная накладная"

}
procedure TJR_RQSTEQPTForm.ButtonDelClick(Sender: TObject);
var number: string;
    date  : string;
begin
  if not check_user_grand('DH_RQST_EQPT', 'D', true) then exit;

  if  (data.qJRRQSTEQPTQuery.FieldByName('ID').isnull) then exit;

  Number := data.qJRRQSTEQPTQuery.FieldByName('NumDoc').AsString;
  date   := data.qJRRQSTEQPTQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить заявку  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.qJRRQSTEQPTQuery.FieldByName('ID').AsInteger;

    if not data.qJRRQSTEQPTQuery.Eof then
      data.qJRRQSTEQPTQuery.Prior;

    Stored_Del_Proc.ParamByName('IDDOC').asinteger := IDDoc;  //  записи.
    Stored_Del_Proc.ExecProc;
   end;

   refreshquery(data.qJRRQSTEQPTQuery);


end;

{

   Процедура установки интервала просмотра журнала Приходных накладных

}
procedure TJR_RQSTEQPTForm.ButtonIntClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;


  // изменим название окна
  caption := 'Журнал заявок по инструменту с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // обновление таблиц

  with data.qJRRQSTEQPTQuery do
    begin

      close;
      ParamByName('datein').asdate  := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
      ParamByName('ID_WRKR_FILTER').asinteger := ID_WRKR_FILTER;

      open;

    end;

end;

procedure TJR_RQSTEQPTForm.FormShow(Sender: TObject);
var    menuitem : tmenuitem;
       i : integer;

begin
  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  ID_PDR_Filter := -1;  //  по журналу
  ID_WRKR_Filter:= -1;  //

  with data.qJRRQSTEQPTQuery do

    begin
       sql.clear;
       sql.add('select * from BROWSE_RQSTEQPTDOC_PROC(:dateIn, :DateOut, :ID_PDR_FILTER, :ID_WRKR_Filter)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_PDR_FILTER').asinteger := ID_PDR_Filter;
       ParamByName('ID_WRKR_FILTER').asinteger:= ID_WRKR_Filter;
       sql.add('order by date_in');
       open;

       last;
    end;

  caption := 'Журнал заявок инструмента с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;

   filterstring := GetColumnsList('BROWSE_RQSTEQPTDOC_PROC', FormGrid);
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

procedure TJR_RQSTEQPTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_RQSTEQPTDOC_PROC', FormGrid, data.qJRRQSTEQPTQuery, filterstring);
  action := caFree;
end;

{
  Процедура поиска вниз

}

procedure TJR_RQSTEQPTForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.qJRRQSTEQPTQuery.eof then data.qJRRQSTEQPTQuery.next;

    find(data.qJRRQSTEQPTQuery, FormGrid, Searchkey.text, 1);

end;
{
  Процедура поиска вверх

}
procedure TJR_RQSTEQPTForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;

   if not data.qJRRQSTEQPTQuery.bof then data.qJRRQSTEQPTQuery.prior;
   
    find(data.qJRRQSTEQPTQuery, FormGrid, Searchkey.text, -1);

end;

{
   Процедура поиска по подстроке

}
procedure TJR_RQSTEQPTForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then

    find(data.qJRRQSTEQPTQuery, FormGrid, Searchkey.text, 1);

end;

procedure TJR_RQSTEQPTForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    find(data.qJRRQSTEQPTQuery, FormGrid, Searchkey.text, 1);

end;


{
   Процедура при редактировании таблицы
}

procedure TJR_RQSTEQPTForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 IdDoc  := data.qJRRQSTEQPTQuery.FieldByName('ID').asinteger;
 
  case Key of
    45 :  ButtonAddClick(sender);   // добавление записи
    46 :  ButtonDelClick(Sender);   // удаление записи
    13 :  ButtonEditClick(sender);  // Редактирование по Enter
    VK_F5 : refreshquery( data.qJRRQSTEQPTQuery); // обновление таблицы
  end;

end;

procedure TJR_RQSTEQPTForm.ToolButtonHelpClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 330);

end;

{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_RQSTEQPTForm.FormKeyDown(Sender: TObject; var Key: Word;
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
procedure TJR_RQSTEQPTForm.MenuRefreshClick(Sender: TObject);
begin

   refreshQuery( data.qJRRQSTEQPTQuery);

end;

procedure TJR_RQSTEQPTForm.sort_table(type_of_sort: integer);
var strord : string;
begin

  if type_of_sort = 1 then

    strord :=  'order by date_in'

  else

    strord :=  'order by numdoc';

  with data.qJRRQSTEQPTQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_RQSTEQPTDOC_PROC(:dateIn, :DateOut, :ID_PDR_FILTER, :ID_WRKR_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
       ParamByName('ID_WRKR_FILTER').asinteger := ID_WRKR_FILTER;
       sql.add(strord);
       open;

    end;


end;


{

   Сортировка документов по дате

}
procedure TJR_RQSTEQPTForm.MenuSortByDateClick(Sender: TObject);
begin
  sort_table(1);
end;

{

   Сортировка документов по виду документов

}
procedure TJR_RQSTEQPTForm.MenuSortByDate1Click(Sender: TObject);
begin
  sort_table(2);
end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_RQSTEQPTForm.MenuByWidthClick(Sender: TObject);
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
procedure TJR_RQSTEQPTForm.ButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);

  FilterForm.id_pdr := ID_pdr_FILTER;
  FilterForm.id_wrkr:= ID_WRKR_Filter;

  FilterForm.OnOpenForm;

  with FilterForm do
    begin
      PDRCombo.Enabled := true;
      PanelCHRT.Hide;
      PanelWRHS.Hide;
      PanelMain.Show;
      PanelOperFltr.Show;
      EQPTCombo.Enabled := false;
      VOPCombo.Enabled  := false;
      CSTCombo.Enabled := false;
      Pr_execEdit.Enabled := false;
    end;

  // если установлен фильтр
  if FilterForm.showmodal = mrOK then

    begin

      // если есть отбор по заказчику
      if (FilterForm.CSTCombo.ID > 0) then

        begin

          filtered := 1;
          ID_PDR_FILTER := FilterForm.id_pdr;

        end

       else
         ID_PDR_FILTER := -1;

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
      if (FilterForm.WRKRCombo.ID > 0) then

        begin

          filtered := 1;
          ID_WRKR_FILTER := FilterForm.id_wrkr;

        end

       else
         ID_WRKR_FILTER := -1;

       // закрытие запроса

       with data.qJRRQSTEQPTQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
          ParamByName('ID_WRKR_FILTER').asinteger := ID_WRKR_FILTER;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       ID_PDR_FILTER  := -1;
       ID_WRKR_Filter := -1;

       // обновление текста запроса
       with data.qJRRQSTEQPTQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
          ParamByName('ID_WRKR_FILTER').asinteger := ID_WRKR_FILTER;
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

procedure TJR_RQSTEQPTForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  sort_table(aCol);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;

end;

procedure TJR_RQSTEQPTForm.ColumnSet(Sender: TObject);
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
