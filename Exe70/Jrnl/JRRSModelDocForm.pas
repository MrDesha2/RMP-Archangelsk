{
                 Модуль JRPRDocForm
      формы журнала расходных накладных по моделям.

}
unit JRRSModelDocForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus, ActnList;

type
  TJR_RSModelForm = class(TForm)
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
  JR_RSModelForm: TJR_RSModelForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  ID_WRHS_FILTER : integer;
  filterstring   : string;

implementation

uses      libs,
     ParamForm,
          Main,
FiltrOrderEdit,   // форма редактирования фильтра по таблице
RSModelEditForm,
          Base,
   MainFormLib,          
    GetPeriods;
{$R *.DFM}

{
  Процедура закрытия журнала заказов
}
procedure TJR_RSModelForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{
  Процедура ввода нового приходного документа
}
procedure TJR_RSModelForm.ButtonAddClick(Sender: TObject);
var DocForm: TDOC_RSModelForm;
begin
  if not check_user_grand('DH_RS_MODEL', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSMODELForm.CreateN(mainform, - 1);
  DocForm.show;

end;
{
     Процедура вызова формы редактирования формы документа "Приходная накладная"

}
procedure TJR_RSModelForm.ButtonEditClick(Sender: TObject);
var DocForm: TDOC_RSModelForm;
begin
//  if  (data.JRRSModelFormQuery.eof) and (data.JRRSModelFormQuery.bof) then exit;
  if  (data.JRRSModelFormQuery.FieldByName('ID').isnull) then exit;

  IDDoc := data.JRRSModelFormQuery.FieldByName('ID').asinteger;


  // открыть форму редактирования нового документа
  DocForm := TDOC_RSMODELForm.CreateN(mainform, IDDoc);
    DocForm.OKButton.Enabled :=  check_user_grand('DH_RS_model', 'U', true);

//  if CheckOfOpened(DocForm.Caption, '') = false then
//    DocForm.Release;

  DocForm.show;

end;
{
       Процедура удаления документа "Приходная накладная"

}
procedure TJR_RSModelForm.ButtonDelClick(Sender: TObject);
var number: string;
    date  : string;
begin
  if not check_user_grand('DH_RS_MODEL', 'D', true) then exit;

  if  (data.JRRSMODELFormQuery.FieldByName('ID').isnull) then exit;

  Number := data.JRRSMODELFormQuery.FieldByName('NumDoc').AsString;
  date   := data.JRRSMODELFormQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить поступление инструмента  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.JRRSMODELFormQuery.FieldByName('ID').AsInteger;

    if not data.JRRSMODELFormQuery.Eof then
      data.JRRSMODELFormQuery.Prior;

    Stored_Del_Proc.ParamByName('IDDOC').asinteger := IDDoc;  //  записи.
    Stored_Del_Proc.ExecProc;
   end;

   refreshquery(data.JRRSMODELFormQuery);


end;

{

   Процедура установки интервала просмотра журнала Приходных накладных

}
procedure TJR_RSModelForm.ButtonIntClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;


  // изменим название окна
  caption := 'Журнал поступления инструмента с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // обновление таблиц

  with data.JRRSMODELFormQuery do
    begin

      close;
      ParamByName('datein').asdate  := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;

      open;

    end;

end;

procedure TJR_RSModelForm.FormShow(Sender: TObject);
var    menuitem : tmenuitem;
       i : integer;

begin
  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  ID_WRHS_Filter:= -1;  //

  with data.JRRSMODELFormQuery do

    begin
       sql.clear;
       sql.add('select * from BROWSE_RSMODELDOC_PROC(:dateIn, :DateOut, :ID_WRHS_Filter)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_WRHS_FILTER').asinteger:= ID_WRHS_Filter;
       sql.add('order by date_in');
       open;

       last;
    end;

  caption := 'Журнал списания моделей с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;

   filterstring := GetColumnsList('BROWSE_RSMODELDOC_PROC', FormGrid);
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

procedure TJR_RSModelForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_RSMODELDOC_PROC', FormGrid, data.JRRSMODELFormQuery, filterstring);
  action := caFree;
end;

{
  Процедура поиска вниз

}

procedure TJR_RSModelForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRRSMODELFormQuery.eof then data.JRRSMODELFormQuery.next;

    find(data.JRRSMODELFormQuery, FormGrid, Searchkey.text, 1);

end;
{
  Процедура поиска вверх

}
procedure TJR_RSModelForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;

   if not data.JRRSMODELFormQuery.bof then data.JRRSMODELFormQuery.prior;
   
    find(data.JRRSMODELFormQuery, FormGrid, Searchkey.text, -1);

end;

{
   Процедура поиска по подстроке

}
procedure TJR_RSModelForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then

    find(data.JRRSMODELFormQuery, FormGrid, Searchkey.text, 1);

end;

procedure TJR_RSModelForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    find(data.JRRSMODELFormQuery, FormGrid, Searchkey.text, 1);

end;


{
   Процедура при редактировании таблицы
}

procedure TJR_RSModelForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 IdDoc  := data.JRRSMODELFormQuery.FieldByName('ID').asinteger;
 
  case Key of
    45 :  ButtonAddClick(sender);   // добавление записи
    46 :  ButtonDelClick(Sender);   // удаление записи
    13 :  ButtonEditClick(sender);  // Редактирование по Enter
    VK_F5 : refreshquery( data.JRRSMODELFormQuery); // обновление таблицы
  end;

end;

procedure TJR_RSModelForm.ToolButtonHelpClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 330);

end;

{
    Процедура ввода на основании расходной накладной



}


procedure TJR_RSModelForm.MenuAddAnotherClick(Sender: TObject);
begin
end;
{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_RSModelForm.FormKeyDown(Sender: TObject; var Key: Word;
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
procedure TJR_RSModelForm.MenuRefreshClick(Sender: TObject);
begin

   refreshQuery( data.JRRSMODELFormQuery);

end;

procedure TJR_RSModelForm.sort_table(type_of_sort: integer);
var strord : string;
begin

  if type_of_sort = 1 then

    strord :=  'order by date_in'

  else

    strord :=  'order by numdoc';

  with data.JRRSMODELFormQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_RSMODELDOC_PROC(:dateIn, :DateOut, :ID_WRHS_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
       sql.add(strord);
       open;

    end;


end;


{

   Сортировка документов по дате

}
procedure TJR_RSModelForm.MenuSortByDateClick(Sender: TObject);
begin
  sort_table(1);
end;

{

   Сортировка документов по виду документов

}
procedure TJR_RSModelForm.MenuSortByDate1Click(Sender: TObject);
begin
  sort_table(2);
end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_RSModelForm.MenuByWidthClick(Sender: TObject);
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
procedure TJR_RSModelForm.ButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);

  FilterForm.id_cst := -1;
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
      if (FilterForm.WRHSCombo.text <> '') and (FilterForm.qWRHSQuery.active) then

        begin

          filtered := 1;
          ID_WRHS_FILTER := FilterForm.id_wrhs;

        end

       else
         ID_WRHS_FILTER := -1;

       // закрытие запроса

       with data.JRRSMODELFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       ID_WRHS_Filter := -1;

       // обновление текста запроса
       with data.JRRSMODELFormQuery do
         begin

          close;
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
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

procedure TJR_RSModelForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  sort_table(aCol);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;

end;

procedure TJR_RSModelForm.ColumnSet(Sender: TObject);
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
