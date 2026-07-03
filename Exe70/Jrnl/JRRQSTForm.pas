{
      Модуль   JRRQSTForm формы журнала заявок.
    Форма вызывается из основного меню программы.
    Представляет собой список всех заявок.

}
unit JRRQSTForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ToolWin, ComCtrls, Grids, DBGrids, StdCtrls, ExtCtrls,
  ReqEditForm, ImgList, ORDEREditForm, DBGridEh, Menus, ActnList;

type
  TJR_RQSTForm = class(TForm)
    PanelBot: TPanel;
    PanelTop: TPanel;
    PanelMain: TPanel;
    CloseButton: TButton;
    JRToolBar: TToolBar;
    FormRQSTSourse: TDataSource;
    PanelTable: TPanel;
    FormOrderSource: TDataSource;
    ToolButtonAdd: TToolButton;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    ToolButtonSetInt: TToolButton;
    ToolButtonSetView: TToolButton;
    PanelTop2: TPanel;
    ToolBar1: TToolBar;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    Searchkey: TEdit;
    FindButton: TButton;
    SearchKeyOrder: TEdit;
    FindOrderButton: TButton;
    ToolButtonHelp: TToolButton;
    JRRQSTGrid: TDBGridEh;
    JROrderGrid: TDBGridEh;
    Splitter: TSplitter;
    RefreshButton: TButton;
    ToolButtonSetFilter: TToolButton;
    ToolButtonFindDown: TToolButton;
    ToolButtonFindUp: TToolButton;
    TableMenu: TPopupMenu;
    N1: TMenuItem;
    MenuDel: TMenuItem;
    MenuEdit: TMenuItem;
    N2: TMenuItem;
    MenuSel: TMenuItem;
    MenuInt: TMenuItem;
    MenuOrd: TMenuItem;
    MenuRefresh: TMenuItem;
    N4: TMenuItem;
    MenuByWidth: TMenuItem;
    ToolFindOrDown: TToolButton;
    ToolFindOrUp: TToolButton;
    ActionList: TActionList;
    acFindNext: TAction;
    acFindPrior: TAction;
    acFind: TAction;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MainMenuAdd: TMenuItem;
    MainMenuEdit: TMenuItem;
    MainMenuDel: TMenuItem;
    MainMenuInt: TMenuItem;
    MainMenuFiltr: TMenuItem;
    MainMenuSetView: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    MainMenuByWid: TMenuItem;
    Columns: TMenuItem;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure JRRQSTGridDblClick(Sender: TObject);
    procedure FormRQSTQueryAfterScroll(DataSet: TDataSet);
    procedure ToolButtonAddClick(Sender: TObject);
    procedure JROrderGridDblClick(Sender: TObject);
    procedure ToolButtonDelClick(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButtonSetIntClick(Sender: TObject);
    procedure ToolButtonSetViewClick(Sender: TObject);
    procedure OpenOrder;
    procedure RefreshButtonClick(Sender: TObject);
    procedure FindButtonClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure FindOrderButtonClick(Sender: TObject);
    procedure SearchKeyOrderKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButtonSetFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JRRQSTGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure JROrderGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonFindDownClick(Sender: TObject);
    procedure ToolButtonFindUpClick(Sender: TObject);
    procedure ToolButtonHelpClick(Sender: TObject);
    procedure MenuOrdClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuByWidthClick(Sender: TObject);
    procedure ToolFindOrDownClick(Sender: TObject);
    procedure ToolFindOrUpClick(Sender: TObject);
    procedure JRRQSTGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure sort_table(type_of_sort: integer);
    procedure ColumnSet(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FormActivate(Sender :TObject);
  end;

var
  JR_RQSTForm: TJR_RQSTForm;
  IDDoc      : Integer;        // ID документа
  IDOrder    : integer;        // ID документа "заказ"
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  // фильтры для отбора журнала
  ID_PDR_Filter : integer; // по подразделениям
  ID_CST_Filter : integer; // по заказчикам
  PR_EXEC_Filter: integer; // по признаку выполнения
  filterstring   : string;

implementation

uses Base,
      FiltrOrderEdit,   // форма редактирования фильтра по таблице
     libs, ParamForm,
     Main, GetPeriods;

{$R *.DFM}
{
  Процедура закрытия формы
}
procedure TJR_RQSTForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;

procedure TJR_RQSTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_RQST_PROC', JRRQSTGrid, data.JRRQSTFormQuery, filterstring);
  mainForm.JR_RQSTForm_Main := nil;
  action := caFree;

end;

procedure TJR_RQSTForm.FormActivate(Sender :TObject);
begin
  // проверка на возможность редактирования
  if not check_user_grand('BROWSE_RQST_PROC', 'X', true) then
    close;
  if not check_user_grand('BROWSE_ORDER_PROC_RQST', 'X', false) then
    close;

  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  ToolButtonSetView.Down := true; // есть просмотр заказов
  caption := 'Журнал заявок с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

   // выполнение запроса по заказам
  with data.JRRQSTFormOrderQuery do
    begin

      sql.clear;
      sql.add('select * from BROWSE_RQORER_PROC(:ID_RQST_IN)');

    end;

  // выполнение запроса по форме
  with data.JRRQSTFormQuery do
    begin

      sql.clear;
      sql.add('select * from BROWSE_RQST_PROC(:datein, :dateout, :ID_PDR_FILTER, :ID_CST_FILTER, :PR_EXEC_FILTER)');
      ParamByName('DateIn').asdate  := FromDate;
      ParamByName('DateOut').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger  := -1;
      ParamByName('ID_PDR_FILTER').asinteger  := -1;
      ParamByName('PR_EXEC_FILTER').asinteger := -1;
      open;

      last;
    end;


  with data.JRRQSTFormOrderQuery do
    begin

      ParamByName('ID_RQST_IN').asinteger := data.JRRQSTFormQuery.FieldByName('id').asinteger;
      open;

    end;


end;


{
  Процедура открытия формы редактирования документа "Заявка"
}
procedure openDoc(sender: TJR_RqSTForm);
var DocForm : TDOC_RequestForm;
begin
  // открыть форму редактирования нового документа
  DocForm := TDOC_RequestForm.CreateN(sender, IdDoc);
    // проверка на возможность редактирования
    DocForm.OKButton.Enabled := check_user_grand('DH_RQST', 'U', true);

  DocForm.show;

end;

{
  Процедура открытия документа из журнала по IDDoc
}
procedure TJR_RQSTForm.JRRQSTGridDblClick(Sender: TObject);
begin
 // если запрос журнала заявок не пустой, то открываем документ
 if data.JRRQSTFormQuery.FieldByName('ID').isnull then exit;

 IDDoc := data.JRRQSTFormQuery.FieldByName('ID').asInteger;
 
 OpenDoc(self);
end;


{
  Процедура перепозиционирования в таблице заказов после изменения текущей заявки
}

procedure TJR_RQSTForm.FormRQSTQueryAfterScroll(DataSet: TDataSet);
var id: integer;
begin
  ID := data.JRRQSTFormQuery.FieldByName('ID').asinteger; // ID doc

  if not data.JRRQSTFormQuery.eof then
    begin
      data.JRRQSTFormOrderQuery.close;                                    //  установка
      data.JRRQSTFormOrderQuery.ParamByName('ID_RQST_IN').asinteger := ID;//  нового
      data.JRRQSTFormOrderQuery.Open;                                     //  фильтра по документам "заказ"
    end
  else
    data.JRRQSTFormOrderQuery.close;                                    //  установка

end;

{
   Процедура вызова формы редактирования нового документа "Заявка"
}
procedure TJR_RQSTForm.ToolButtonAddClick(Sender: TObject);
var DocForm: TDOC_RequestForm;
begin
  // если запрос журнала заявок не пустой, то открываем документ
//  if data.JRRQSTFormQuery.Eof then exit;

  // проверка на возможность редактирования
  if not check_user_grand('DH_RQST', 'I', true) then
    abort;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RequestForm.CreateN(mainform, - 1);
  DocForm.show;
end;

procedure TJR_RQSTForm.OpenOrder;
var DocForm : TDOC_ORDERForm;
begin
  // если запрос журнала заявок не пустой, то открываем документ
  if data.JRRQSTFormQuery.Eof then exit;
  
  // открыть форму редактирования нового документа
  DocForm := TDOC_ORDERForm.CreateN(mainform, IdOrder, IdDoc, data.JRRQSTFormQuery.FieldByName('Number').asInteger, nil);
     
  DocForm.show;
end;
{
  Процедура вызова редактирования документа "Заказ"
}
procedure TJR_RQSTForm.JROrderGridDblClick(Sender: TObject);
begin
  // если запрос журнала заказов не пустой, то открываем документ
  if data.JRRQSTFormOrderQuery.FieldByName('ID').isnull then exit;

  IDDoc   := data.JRRQSTFormQuery.FieldByName('ID').asInteger;
  IDOrder := data.JRRQSTFormOrderQuery.FieldByName('ID').asInteger;

  OpenOrder;
end;

{

  Процедура удаления заявки из журнала заявок
  
}
procedure TJR_RQSTForm.ToolButtonDelClick(Sender: TObject);
var number: string;
    date  : string;
begin

  if data.JRRQSTFormQuery.FieldByName('ID').isnull then exit;

  If  data.JRRQSTFormQuery.FieldByName('PR_EXEC').AsInteger <> 1 then
  begin
       MessageDlg('Удаление завершенных заданий и находящихся в работе запрещено', mtError, [mbOk], 0);
       exit;
  end;

     // проверка на возможность редактирования
     if not check_user_grand('DH_RQST', 'D', true) then
       exit;

  Number := data.JRRQSTFormQuery.FieldByName('Number').AsString;
  date   := data.JRRQSTFormQuery.FieldByName('Date_in').AsString;
  
  if messagedlg('Удалить заявку  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.JRRQSTFormQuery.FieldByName('ID').AsInteger;

    if not data.JRRQSTFormQuery.Eof then
      data.JRRQSTFormQuery.Prior;

    data.DEL_RQST_PROC.close;
    data.DEL_RQST_PROC.parambyname('iddoc').asinteger   := IDDoc;
    data.DEL_RQST_PROC.ExecProc;

    // обновление таблицы
    refreshquery(data.JRRQSTFormQuery)
   end;

   
end;
{
  Процедура удаления заказа из заявки
}
procedure TJR_RQSTForm.ToolButton7Click(Sender: TObject);
var number: string;
    date  : string;
begin
  if  data.JRRQSTFormOrderQuery.FieldByName('ID').isnull then exit;

  If  data.JRRQSTFormOrderQuery.FieldByName('PR_EXEC').AsInteger <> 1 then
  begin
       MessageDlg('Удаление завершенных заказов и находящихся в работе запрещено', mtError, [mbOk], 0);
       exit;
  end;

     // проверка на возможность редактирования
     if not check_user_grand('DH_ORDER', 'D', true) then
       exit;

  Number := data.JRRQSTFormOrderQuery.FieldByName('Number').AsString;
  date   := data.JRRQSTFormOrderQuery.FieldByName('Date_in').AsString;
  
  if messagedlg('Удалить заказ  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDOrder := data.JRRQSTFormOrderQuery.FieldByName('ID').AsInteger;

    with data.DEL_ORDER_PROC do
      begin
        close;
        parambyname('iddoc').asinteger   := IDOrder;
        ExecProc;
      end;

    // обновление таблицы
    refreshquery(data.JRRQSTFormOrderQuery);
   end;


end;
{
  Процедура установки границ просмотра журнала документов
}
procedure TJR_RQSTForm.ToolButtonSetIntClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;


  // изменим название окна
  caption := 'Журнал заявок с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);


  // обновление таблиц
  with data.JRRQSTFormQuery do
    begin
      close;
      sql.clear;
      sql.add('select * from BROWSE_RQST_PROC(:datein, :dateout, :ID_PDR_FILTER, :ID_CST_FILTER, :PR_EXEC_FILTER)');
      ParamByName('DateIn').asdate  := FromDate;
      ParamByName('DateOut').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger  := -1;
      ParamByName('ID_PDR_FILTER').asinteger  := -1;
      ParamByName('PR_EXEC_FILTER').asinteger := -1;
      open;
    end;

  with data.JRRQSTFormOrderQuery do
   begin
     close;                                        //  установка
     ParamByName('ID_RQST_IN').asinteger :=
         data.JRRQSTFormQuery.FieldByName('ID').asinteger;//  нового
     Open;                                         //  фильтра по документам "заказ"
   end;


end;
{
  Процедура установки типа просмотра журнала заявок
  Описание: в зависимости от значения кнопки   ToolButton10Click
    показывается или не показывается журнал заказов
}
procedure TJR_RQSTForm.ToolButtonSetViewClick(Sender: TObject);
begin
  {
   Проверка состояния кнопки. Если кнопка в панеле нажата, то просмотр всех записей
   в таблице, в противном случае только в виде дерева.
  }

  if (ToolButtonSetView.Down) then
    begin
      MenuOrd.checked := true;
      panelTable.Visible := true;
      MainMenuSetView.checked := true;
    end
  else
    begin
       panelTable.Visible := false;
      MenuOrd.checked := false;
       MainMenuSetView.checked := false;

    end;
end;


 {
  Процедура установки типа просмотра журнала заявок
  Описание: в зависимости от значения кнопки   ToolButton10Click
    показывается или не показывается журнал заказов
}

  {
   Проверка состояния кнопки. Если кнопка в панеле нажата, то просмотр всех записей
   в таблице, в противном случае только в виде дерева.
  }

procedure TJR_RQSTForm.MenuOrdClick(Sender: TObject);
begin
  if (MenuOrd.checked) then

    begin
      ToolButtonSetView.Down := false;
      panelTable.Visible := false;
      menuord.Checked := false;
      MainMenuSetView.Checked := false;
    end
  else
    begin
       panelTable.Visible := true;
      ToolButtonSetView.Down := true;
      menuord.Checked := true;
      MainMenuSetView.Checked := true;


    end;
end;
{
   Процедура обновления формы журнала
}
procedure TJR_RQSTForm.RefreshButtonClick(Sender: TObject);
begin
  refreshquery( data.JRRQSTFormQuery);
  refreshquery( data.JRRQSTFormOrderQuery);
end;

{

         Процедуры поиска по таблице заявок по подстроке

}
procedure TJR_RQSTForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
  if not data.JRRQSTFormQuery.eof then data.JRRQSTFormQuery.next;
    find(data.JRRQSTFormQuery, JRRQSTGrid, Searchkey.text, 1);

end;
{
    При редактировании строки поиска нажали Энтер

}
procedure TJR_RQSTForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
   begin
     if not data.JRRQSTFormQuery.eof then data.JRRQSTFormQuery.next;
       find(data.JRRQSTFormQuery, JRRQSTGrid, Searchkey.text, 1);
        JRRQSTGrid.SetFocus;
   end;

end;
{

         Процедуры поиска по таблице заказов по подстроке

}
procedure TJR_RQSTForm.FindOrderButtonClick(Sender: TObject);
begin

 if SearchkeyOrder.text <> '' then
  find(data.JRRQSTFormOrderQuery, JROrderGrid, SearchkeyOrder.text, 1);

end;
{
  Поиск вниз
}

procedure TJR_RQSTForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if SearchkeyOrder.text = '' then exit;

  if not data.JRRQSTFormQuery.eof then data.JRRQSTFormQuery.next;

    find(data.JRRQSTFormQuery, JRRQSTGrid, Searchkey.text, 1);

end;
{
  Поиск вверх
}
procedure TJR_RQSTForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;

  if not data.JRRQSTFormQuery.bof then data.JRRQSTFormQuery.prior;

    find(data.JRRQSTFormQuery, JRRQSTGrid, Searchkey.text, -1);

end;

{
    При редактировании строки поиска заказа нажали Энтер

}
procedure TJR_RQSTForm.SearchKeyOrderKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    find(data.JRRQSTFormOrderQuery, JROrderGrid, Searchkey.text, 1);

end;

{
  Процедура установки фильтра по журналу
}
procedure TJR_RQSTForm.ToolButtonSetFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);

  FilterForm.id_pdr := ID_PDR_FILTER;
  FilterForm.id_cst := ID_cst_FILTER;
  FilterForm.pr_exec:= PR_EXEC_FILTER;


  FilterForm.OnOpenForm;
  FilterForm.PanelCHRT.Hide;
  FilterForm.PanelOperFltr.Hide;

  // если установлен фильтр
  if FilterForm.showmodal = mrOK then

    begin
      // если есть отбор по подразделениям
      if (FilterForm.PDRCombo.text <> '') and (FilterForm.qPDRQuery.active) then
        begin

          filtered := 1;
          ID_PDR_FILTER := FilterForm.id_pdr;
        end

       else
         ID_PDR_FILTER := -1;

      // если есть отбор по заказчику
      if (FilterForm.CSTCombo.text <> '') and (FilterForm.qCSTQuery.active) then

        begin

          filtered := 1;
          ID_CST_FILTER := FilterForm.id_cst;
        end

       else
         ID_CST_FILTER := -1;

      // если есть отбор по признаку выполнения
      if FilterForm.pr_exec <> 0 then

        begin

           filtered := 1;
           PR_EXEC_FILTER := FilterForm.Pr_exec;

        end

       else
         PR_EXEC_FILTER := -1;


       // закрытие запроса

       with data.JRRQSTFormQuery do
         begin

          close;
          sql.clear;
          sql.add('select * from BROWSE_RQST_PROC(:datein, :dateout, :ID_PDR_FILTER, :ID_CST_FILTER, :PR_EXEC_FILTER)');
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

       // закрытие запроса
       ID_PDR_FILTER := -1;
       ID_CST_FILTER := -1;
       PR_EXEC_FILTER := -1;

       with data.JRRQSTFormQuery do
         begin

          close;
          sql.clear;
          sql.add('select * from BROWSE_RQST_PROC(:datein, :dateout, :ID_PDR_FILTER, :ID_CST_FILTER, :PR_EXEC_FILTER)');
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
          ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
          Open;

         end;

     end;

  FilterForm.Close;

   if data.JRRQSTFormQuery.eof then
     data.JRRQSTFormOrderQuery.close;

     
   if filtered = 1 then
     ToolButtonSetFilter.Down := true
   else
     ToolButtonSetFilter.Down := false;


end;


{

    Процедура установки сортировки таблицы

    Вход: направление сортировки


}
procedure TJR_RQSTForm.sort_table(type_of_sort: integer);
var strord : string;
begin

   case type_of_sort of

     0 : strord :=  'order by number';
     1 : strord :=  'order by date_in';
     2 : strord :=  'order by date_out';
   end;

       with data.JRRQSTFormQuery do
         begin

          close;
          sql.clear;
          sql.add('select * from BROWSE_RQST_PROC(:datein, :dateout, :ID_PDR_FILTER, :ID_CST_FILTER, :PR_EXEC_FILTER)');
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
          ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;

          sql.add(strord);
          open;

    end;


end;


{
   Процедура при открытии формы журнала

}
procedure TJR_RQSTForm.FormCreate(Sender: TObject);
var    menuitem : tmenuitem;
       i : integer;

begin

  ID_PDR_Filter := -1;  //  фильтр отбора
  ID_CST_Filter := -1;  //  по журналу
  PR_EXEC_Filter:= -1;  //
  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;

   filterstring := GetColumnsList('BROWSE_RQST_PROC', JRRQSTGrid);
    for i := 0 to  JRRQSTGrid.Columns.Count - 1 do
    begin
       menuitem         := TMenuItem.Create(self);
       menuitem.Name    := JRRQSTGrid.Columns[i].FieldName;
       menuitem.Caption := JRRQSTGrid.Columns[i].Title.Caption;
       menuitem.Hint    := JRRQSTGrid.Columns[i].Title.Caption;
       menuitem.Checked := JRRQSTGrid.Columns[i].Visible;
       menuitem.OnClick := ColumnSet;
       Columns.Add(menuitem);


    end;
    MainMenuByWid.Checked := JRRQSTGrid.AutoFitColWidths;
    MenuByWidth.Checked   := JRRQSTGrid.AutoFitColWidths;

end;

procedure TJR_RQSTForm.JRRQSTGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 // если запрос журнала заявок не пустой, то открываем документ
 if data.JRRQSTFormQuery.Eof then exit;
 IdDoc  := data.JRRQSTFormQuery.FieldByName('ID').asinteger;

  case Key of
    45 :  ToolButtonAddClick(sender);   // добавление записи
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    13 :  OpenDoc(self);                // Редактирование по Enter
  end;

end;

procedure TJR_RQSTForm.JROrderGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // если запрос журнала заказов не пустой, то открываем документ
  if data.JRRQSTFormOrderQuery.Eof then exit;

  IDDoc   := data.JRRQSTFormQuery.FieldByName('ID').asInteger;
  IDOrder := data.JRRQSTFormOrderQuery.FieldByName('ID').asInteger;
  case Key of
    46 :  ToolButton7Click(Sender);   // удаление записи
    13 :  OpenOrder;                // Редактирование по Enter
  end;

end;


procedure TJR_RQSTForm.ToolButtonHelpClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 310);

end;

{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_RQSTForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
   begin
     EscPressed := True;
     abort;
     
   end;


end;

procedure TJR_RQSTForm.MenuByWidthClick(Sender: TObject);
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

    JRRQSTGrid.AutoFitColWidths := MenuByWidth.Checked;


end;
{
   Процедура поиска по подстроке заказов вниз
}
procedure TJR_RQSTForm.ToolFindOrDownClick(Sender: TObject);
begin
 if SearchkeyOrder.text = '' then exit;
  if not data.JRRQSTFormOrderQuery.eof then data.JRRQSTFormOrderQuery.next;

    find(data.JRRQSTFormOrderQuery, JROrderGrid, SearchkeyOrder.text, 1);


end;
{
   Процедура поиска по подстроке вверх
}
procedure TJR_RQSTForm.ToolFindOrUpClick(Sender: TObject);
begin

 if SearchkeyOrder.text = '' then exit;
  if not data.JRRQSTFormOrderQuery.bof then data.JRRQSTFormOrderQuery.Prior;

    find(data.JRRQSTFormOrderQuery, JROrderGrid, SearchkeyOrder.text, 1);

end;

{
   Процедура нажатия кнопки заголовка

}

procedure TJR_RQSTForm.JRRQSTGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  sort_table(aCol);

  JRRQSTGrid.Columns[aCol].Title.SortMarker := smDownEh;


end;

procedure TJR_RQSTForm.ColumnSet(Sender: TObject);
var item : tMenuItem;
    i : integer;
begin
  item := tMenuItem(sender);

  if Item.Checked then
    item.Checked := false
   else
     item.Checked := true;


  for i := 0 to JRRQSTGrid.FieldCount - 1 do
    begin
      if (JRRQSTGrid.Columns[i].FieldName = item.Name)
       then
        JRRQSTGrid.Columns[i].Visible := item.Checked;

    end;
end;

end.
