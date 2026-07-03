{
      Модуль   JRORDERFormп формы журнала заказов.
    Форма вызывается из основного меню программы.
    Представляет собой список всех заказов.

}
unit JRORDERForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, MemTable, Menus, ActnList;

type
  TJR_ORDERForm = class(TForm)
    PanelBot: TPanel;
    CloseButton: TButton;
    PanelTop: TPanel;
    PanelMain: TPanel;
    ToolBar1: TToolBar;
    ToolButtonAdd: TToolButton;
    ToolButtonDel: TToolButton;
    ToolButtonInt: TToolButton;
    ToolButtonHelp: TToolButton;
    Searchkey: TEdit;
    FindButton: TButton;
    FormOrderSource: TDataSource;
    OKButton: TButton;
    JROrderGrid: TDBGridEh;
    RefreshButton: TButton;
    ToolButtonFilter: TToolButton;
    ToolFindDown: TToolButton;
    ToolFindUp: TToolButton;
    TableMenu: TPopupMenu;
    MenuEdit: TMenuItem;
    MenuDel: TMenuItem;
    N1: TMenuItem;
    MenuInt: TMenuItem;
    MenuSel: TMenuItem;
    MenuInsertSub: TMenuItem;
    MenuRefresh: TMenuItem;
    MenuByWidth: TMenuItem;
    MenuMultiSelect: TMenuItem;
    N2: TMenuItem;
    MenuStucDoc: TMenuItem;
    MenuInsertWRHS: TMenuItem;
    MenuInsertOrder: TMenuItem;
    StorProcOrderAdd: TStoredProc;
    StorProcPlanOp: TStoredProc;
    StorProcPlanMTR: TStoredProc;
    ActionList: TActionList;
    acFindNext: TAction;
    acFindPrior: TAction;
    acFind: TAction;
    MainMenu: TMainMenu;
    N3: TMenuItem;
    MainMenuEdit: TMenuItem;
    MainMenuDel: TMenuItem;
    N6: TMenuItem;
    MainMenuInt: TMenuItem;
    MainMenuSel: TMenuItem;
    N9: TMenuItem;
    MainMenuStucDoc: TMenuItem;
    MainMenuByWidth: TMenuItem;
    MainMenuMultiSelect: TMenuItem;
    N13: TMenuItem;
    MainMenuInsertWRHS: TMenuItem;
    MainMenuInsertOrder: TMenuItem;
    N16: TMenuItem;
    MenuInsertWRHSOut: TMenuItem;
    N5: TMenuItem;
    MenuAddToPlan: TMenuItem;
    N7: TMenuItem;
    MainMenuInsertWRHSOut: TMenuItem;
    N8: TMenuItem;
    N4: TMenuItem;
    MainMenuCHRTUpdate: TMenuItem;
    N10: TMenuItem;
    MenuCHRTUpdate: TMenuItem;
    Columns: TMenuItem;
    chUpdateJROrder: TCheckBox;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButtonDelClick(Sender: TObject);
    procedure ToolButtonIntClick(Sender: TObject);
    procedure ToolButtonEditClick(Sender: TObject);
    procedure OpenDoc;
    procedure OKButtonClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure FindButtonClick(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure ToolButtonFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure JROrderGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolFindDownClick(Sender: TObject);
    procedure ToolFindUpClick(Sender: TObject);
    procedure ToolButtonHelpClick(Sender: TObject);
    procedure MenuInsertSubClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuByWidthClick(Sender: TObject);
    procedure MenuMultiSelectClick(Sender: TObject);
    procedure MenuStucDocClick(Sender: TObject);
    procedure MenuInsertOrderClick(Sender: TObject);
    procedure sort_table(type_of_sort: integer);
    procedure JROrderGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure MenuInsertWRHSOutClick(Sender: TObject);
    procedure MenuAddToPlanClick(Sender: TObject);
    procedure MainMenuCHRTUpdateClick(Sender: TObject);
    procedure ColumnSet(Sender: TObject);
    procedure chUpdateJROrderClick(Sender: TObject);
  private
    procedure SetID(newID : integer);
    function  GetID : integer;
  public
    numdoc     : integer;
    IDDoc      : Integer;        // ID документа
    TypeEdit   : integer;        // тип редактирования формы: 1 - редактирование, 2 -выбор
    property IDRec : integer read GetID write SetID; // Свойство ID для выбора доков
    procedure FormActivate(Sender :TObject; _TypeEdit : integer);
  end;

var
  JR_ORDERForm: TJR_ORDERForm;
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала
  FromPlanDate : tDateTime;
  ToPlanDate   : tDateTime;


  // фильтры для отбора журнала
  ID_PDR_Filter : integer; // по подразделениям
  ID_CST_Filter : integer; // по заказчикам
  PR_EXEC_Filter: integer; // по признаку выполнения
  ID_CHRT_FILTER: integer; // по чертежу
  ONLYPOSITIVE  : integer; // Только положительный остаток
  OPERNORM      : integer; // Наличие ненормированных операций

  filterstring  : string;

implementation

uses
          Main,
 OrderEditForm,   // форма редактирования заказа
          libs,   // библиотека функций
  DocStructFrm,   // форма показа структуры подчиненности документов
FiltrOrderEdit,   // форма редактирования фильтра по таблице
 PRDocEditForm,
 OrderEditLibs,
     ParamForm,   // форма параметров программы
          Base,
    GetPeriods;    

{$R *.DFM}
{
  Процедура закрытия журнала заказов
}
procedure TJR_ORDERForm.CloseButtonClick(Sender: TObject);
begin
  if TypeEdit = 1 then
    close
  else
    ModalResult := mrCancel;

end;


procedure TJR_ORDERForm.ColumnSet(Sender: TObject);
var item : tMenuItem;
    i : integer;
begin
  item := tMenuItem(sender);

  if Item.Checked then
    item.Checked := false
   else
     item.Checked := true;


//  Columns.Items[item.MenuIndex].Checked := item.Checked;

  for i := 0 to JROrderGrid.FieldCount - 1 do
    begin
      if (JROrderGrid.Columns[i].FieldName = item.Name)
       then
        JROrderGrid.Columns[i].Visible := item.Checked;

    end;

      if JROrderGrid.Columns[JROrderGrid.Columns.Count - 1].visible then
        data.JROrderFormQuery.ParamByName('needremain').AsInteger := 1
        else
          data.JROrderFormQuery.ParamByName('needremain').AsInteger := 0;


end;



{
   Процедура открытия журнала заказов
   Вход: приложение-владелец,
         тип формы: 1 - редактирование, 2 - для выбора
}
procedure TJR_ORDERForm.FormActivate(Sender :TObject; _TypeEdit : integer);
var    menuitem : tmenuitem;
       i : integer;
begin

  // проверка на возможность редактирования
  if not check_user_grand('BROWSE_ORDER_PROC', 'X', true) then
    begin
     typeedit := 1;
     close;
     exit;
    end;


  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  // обновление текста запроса
  with data.JROrderFormQuery do

    begin

       close;
       sql.Clear;
       sql.add('select * from BROWSE_ORDER_PROC(:datein, :dateout, :ID_PDR_FILTER,');
       sql.add('       :ID_CST_FILTER, :PR_EXEC_FILTER, :ID_CHRT_Filter, :FROMPLANDATE, :ToPLANDATE, :needremain, :onlypositive, :opernorm)');
       ParamByName('DateIn').asdate := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger  := -1;
       ParamByName('ID_CHRT_FILTER').asinteger := -1;
       ParamByName('ID_PDR_FILTER').asinteger  := -1;
       ParamByName('PR_EXEC_FILTER').asinteger := -1;
       ParamByName('FROMPLANDATE').asdate  := strtodate('01.01.1901');;
       ParamByName('ToPLANDATE').asdate    := strtodate('01.01.2500');
       if JROrderGrid.Columns[JROrderGrid.Columns.Count - 1].Visible then
         ParamByName('needremain').AsInteger := 1
         else
           ParamByName('needremain').AsInteger := 0;
       ParamByName('onlypositive').AsInteger   := onlypositive;
       ParamByName('opernorm').AsInteger       := opernorm;

       open;

//       last;

    end;

  if _typeEdit  = 1 then
    begin
      caption := 'Журнал заказов с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);
      OKButton.visible := false;
    end
  else
    begin
      caption := 'Журнал заказов с ' + datetostr(fromDate) + ' по ' + datetostr(toDate) + ' (Выбор)';
      OKButton.visible := true;
    end;


    Columns.Clear;

    for i := 0 to  JROrderGrid.Columns.Count - 1 do
    begin
       menuitem         := TMenuItem.Create(self);
       menuitem.Name    := JROrderGrid.Columns[i].FieldName;
       menuitem.Caption := JROrderGrid.Columns[i].Title.Caption;
       menuitem.Hint    := JROrderGrid.Columns[i].Title.Caption;
       menuitem.Checked := JROrderGrid.Columns[i].Visible;
       menuitem.OnClick := ColumnSet;
       Columns.Add(menuitem);


    end;
  MainMenuByWidth.Checked := JROrderGrid.AutoFitColWidths;
  MenuByWidth.Checked     := JROrderGrid.AutoFitColWidths;


  TypeEdit := _TypeEdit;

end;
{
  Процедура при закрытии окна
  Описание: при закрытии форма невидима

}
procedure TJR_ORDERForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

//   filterstring.ParamByName('ID_PDR_Filter').asinteger := ID_PDR_Filter;
//   filterstring.ParamByName('ID_CST_Filter').asinteger := ID_CST_Filter;
//   filterstring.ParamByName('PR_EXEC_Filter').asinteger:= PR_EXEC_Filter;
//   filterstring.ParamByName('ID_CHRT_FILTER').asinteger:= ID_CHRT_FILTER;
//   filterstring.ParamByName('FromPlanDate').AsDate     := FromPlanDate;
//   filterstring.ParamByName('ToPlanDate').AsDate       := ToPlanDate;



  SetColumnList('BROWSE_ORDER_PROC', JROrderGrid, DATA.JROrderFormQuery, filterstring);  //31.01.2013


  // если форма была для редактирования, то она уничножается
  if TypeEdit = 1 then
    begin
      data.JROrderFormQuery.Close;

      MainForm.JR_ORDER_Form_Main := nil;
      action := caFree;
    end;
end;
{
  Процедура вызова окна редактирования документа "Заказ".
  Вход: на вход в качестве глобальной переменной передается ID документа.
  Выход: пусто
}
procedure TJR_ORDERForm.OpenDoc;
var DocForm : TDOC_ORDERForm;   // форма редактирования документа Заказ
    ParentID: integer; // ID родительского документа Заявка
begin
  // открыть форму редактирования нового документа
  IdDoc    := data.JROrderFormQuery.FieldByName('ID').asinteger;
  ParentID := data.JROrderFormQuery.FieldByName('ID_RQST').asinteger;

  DocForm := TDOC_ORDERForm.CreateN(mainform, IdDoc, ParentID,
    data.JROrderFormQuery.FieldByName('RQST_NUMBER').asinteger, nil);

  DocForm.show;

end;
{
  Процедура удаления заказа
}
procedure TJR_ORDERForm.ToolButtonDelClick(Sender: TObject);
var number: string; // номер заказа
    date  : string; // дата заказа
begin
  if  data.JROrderFormQuery.FieldByName('ID').isnull then exit;

  If  data.JROrderFormQuery.FieldByName('PR_EXEC').AsInteger <> 1 then
  begin
       MessageDlg('Удаление завершенных заказов и находящихся в работе запрещено', mtError, [mbOk], 0);
       exit;
  end;
  
  // проверка на возможность редактирования
  if not check_user_grand('DH_ORDER', 'D', true) then
    abort;

  Number := data.JROrderFormQuery.FieldByName('Number').AsString;
  date   := data.JROrderFormQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить заказ  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
   
    IDDoc  := data.JROrderFormQuery.FieldByName('ID').AsInteger;

    if not data.JROrderFormQuery.Eof then
      data.JROrderFormQuery.Prior;

    with data.qDELQuery do
      begin
        close;
        sql.clear;
        sql.add('delete from dh_order where id = ' + inttostr(IDDoc));
        data.RMPBase.StartTransaction;
         execSQL;
        data.RMPBase.Commit;
      end;

    // обновление запроса
    if Param_form.glUpdateJROrder then
      refreshquery(data.JROrderFormQuery);

   end;
end;
{
  Процедура установления интервала просмотра журнала заказов
}
procedure TJR_ORDERForm.ToolButtonIntClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;

     // изменим название окна
     caption := 'Журнал заказов с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

    // обновление таблицы
    with data.JROrderFormQuery do
     begin

      close;
      sql.clear;
      sql.add('select * from BROWSE_ORDER_PROC(:datein, :dateout, :ID_PDR_FILTER, :ID_CST_FILTER, :PR_EXEC_FILTER, :ID_CHRT_Filter, :FromPlanDate, ');// :toPlanDate, :needremain, :onlypositive)');
      sql.add(':toPlanDate, :needremain, :onlypositive, :opernorm)');
      ParamByName('datein').asdate  := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
      ParamByName('ID_CHRT_Filter').asinteger := ID_CHRT_FILTER;
      ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
      ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
      ParamByName('FROMPLANDATE').asdate  := strtodate('01.01.1901');;
      ParamByName('ToPLANDATE').asdate    := strtodate('01.01.2500');

      if JROrderGrid.Columns[JROrderGrid.Columns.Count - 1].visible then
        ParamByName('needremain').AsInteger := 1
        else
          ParamByName('needremain').AsInteger := 0;
       ParamByName('onlypositive').AsInteger  := onlypositive;
       ParamByName('opernorm').AsInteger      := opernorm;

      open;

     end;


end;
{
  Процедура вызова формы редактирования дока
}
procedure TJR_ORDERForm.ToolButtonEditClick(Sender: TObject);
begin
  if data.JROrderFormQuery.FieldByName('ID').isnull then exit;

  numdoc      := data.JROrderFormQuery.fieldbyname('number').asinteger;
  IdDoc       := data.JROrderFormQuery.FieldByName('ID').asinteger;

  if TypeEdit = 1 then
    begin
      OpenDoc;

    end
  else
    ModalResult := mrOK;

end;
{
   Процедура установления свойства ID
}
procedure TJR_ORDERForm.SetID(newID : integer);
begin

  data.JROrderFormQuery.locate('ID', newID, [loCaseInsensitive]);
  
end;
{
  Функция нахождения ID записи
}
function TJR_ORDERForm.GetID : integer;
begin

  result := data.JROrderFormQuery.FieldByName('ID').asinteger;

end;


procedure TJR_ORDERForm.OKButtonClick(Sender: TObject);
begin
  numdoc      := data.JROrderFormQuery.fieldbyname('number').asinteger;
  IdDoc       := data.JROrderFormQuery.FieldByName('ID').asinteger;

  if TypeEdit = 2 then
    begin
      ModalResult := mrOK;
    end
  else
    close;

end;

{
   Поиск по журналу заказов по подстроке

}
procedure TJR_ORDERForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
   begin
     if not data.JROrderFormQuery.eof then data.JROrderFormQuery.next;
       find(data.JROrderFormQuery, JROrderGrid, Searchkey.text, 1);
       JROrderGrid.SetFocus;
   end;
end;
{
  Поиск по журналу заказов по подстроке
}
procedure TJR_ORDERForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then
  find(data.JROrderFormQuery, JROrderGrid, Searchkey.text, 1);

end;
{
  Поиск вверх
}
procedure TJR_ORDERForm.ToolFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
  if not data.JROrderFormQuery.bof then data.JROrderFormQuery.prior;
    find(data.JROrderFormQuery, JROrderGrid, Searchkey.text, -1);

end;
{
  Поиск вниз
}
procedure TJR_ORDERForm.ToolFindDownClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not data.JROrderFormQuery.eof then data.JROrderFormQuery.next;
    find(data.JROrderFormQuery, JROrderGrid, Searchkey.text, 1);

end;



{
   Процедура обноовления формы журнала
}
procedure TJR_ORDERForm.RefreshButtonClick(Sender: TObject);
begin
  refreshquery( data.JROrderFormQuery);
end;


{
    Процедура установки фильтра по запросу.


}
procedure TJR_ORDERForm.ToolButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm; // форма установки фильтра по журналу
    filtered   : integer;     // признак отфильтрованного журнала
    _FromDate, _ToDate : tDate;
    ret : integer;

begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);
  FilterForm.Pr_execEdit.MaxValue := 3;
  FilterForm.PanelCHRT.show;
  FilterForm.PanelMain.show;
  FilterForm.PanelWRHS.Hide;
  FilterForm.PanelCHRT.show;
  FilterForm.PanelDate.show;
  FilterForm.PanelOperFltr.Hide;

  FilterForm.id_pdr  := ID_PDR_FILTER;
  FilterForm.id_cst  := ID_cst_FILTER;
  FilterForm.pr_exec := PR_EXEC_FILTER;
  FilterForm.id_chrt := ID_CHRT_FILTER;
  FilterForm.FromDate:= FromPlanDate;
  FilterForm.ToDate  := ToPlanDate;
  FilterForm.chOnlyPositive.Visible := true;
  if OnlyPositive > 0 then
    FilterForm.chOnlyPositive.Checked :=  true
    else
     FilterForm.chOnlyPositive.Checked :=  false;

  FilterForm.OperCheckBox.Visible := true;
  if OperNorm > 0 then
    FilterForm.OperCheckBox.Checked :=  true
    else
     FilterForm.OperCheckBox.Checked :=  false;

  FilterForm.OnOpenForm;

  ret := FilterForm.showmodal;
  // если установлен фильтр
  if ret = mrOK then
//  if FilterForm.showmodal = mrOK then

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

      // если есть отбор по заказчику
      if (FilterForm.CHRTCombo.text <> '') and (FilterForm.qCHRTQuery.active) then

        begin

          filtered := 1;
          ID_CHRT_FILTER := FilterForm.id_chrt;

        end

       else
         ID_CHRT_FILTER := -1;


      // если есть отбор по признаку выполнения
      if FilterForm.pr_exec <> 0 then

        begin

           filtered := 1;
           PR_EXEC_FILTER := FilterForm.Pr_exec;

        end

       else

         PR_EXEC_FILTER := -1;


      if trim(FilterForm.FromDateEdit.Text) <> '.  .' then
         begin
          FromPlanDate := strToDate(FilterForm.FromDateEdit.Text);
          _FromDate    := FromPlanDate;
         end
        else
          begin
            _FromDate := strtodate('01.01.1000');
            FromPlanDate := 0;
          end;

      if trim(FilterForm.ToDateEdit.Text) <> '.  .' then
        begin
          ToPlanDate   := strToDate(FilterForm.ToDateEdit.Text);
          _ToDate      := ToPlanDate;
        end
        else
          begin
            _ToDate    := strtodate('31.12.2500');
            ToPlanDate := 0;
          end;

        if FilterForm.chOnlyPositive.Checked then
        begin
           filtered := 1;
           OnlyPositive := 1
        end
          else OnlyPositive := 0;

        if FilterForm.OperCheckBox.Checked then
        begin
           filtered := 1;
          OperNorm := 1
        end  
          else OperNorm :=0;

       // закрытие запроса

       with data.JROrderFormQuery do
         begin

          close;
          sql.clear;
          sql.add('select * from BROWSE_ORDER_PROC(:datein, :dateout, ');
          sql.add(':ID_PDR_FILTER, :ID_CST_FILTER, :PR_EXEC_FILTER, :ID_CHRT_FILTER,');
          sql.add(':FROMPLANDATE, :TOPLANDATE, :needremain, :onlypositive, :opernorm)');
          ParamByName('datein').asdate  := FromDate;
          ParamByName('dateout').asdate := ToDate;
          ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
          ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
          ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
          ParamByName('ID_CHRT_FILTER').asinteger := ID_CHRT_FILTER;
          ParamByName('FROMPLANDATE').asdate := _FromDate;
          ParamByName('TOPLANDATE').asdate   := _ToDate;
          if JROrderGrid.Columns[JROrderGrid.Columns.Count - 1].visible then
            ParamByName('needremain').AsInteger := 1
            else
             ParamByName('needremain').AsInteger := 0;
          ParamByName('onlypositive').AsInteger  := onlypositive;
          ParamByName('opernorm').AsInteger      := opernorm;
          Open;

         end;

       FilterForm.Close;
    end

   else
     // отключение отбора
     begin

       if ret = mrCancel then

       begin

         ID_PDR_FILTER := -1;
         ID_CST_FILTER := -1;
         PR_EXEC_FILTER := -1;
         ID_CHRT_FILTER := -1;
         ONLYPOSITIVE   := 0;
         OPERNORM       := 0;
         // обновление текста запроса
         with data.JROrderFormQuery do
           begin

            close;
            sql.clear;
            sql.add('select * from BROWSE_ORDER_PROC(:datein, :dateout, :ID_PDR_FILTER, :ID_CST_FILTER,');
            sql.add('          :PR_EXEC_FILTER, :ID_CHRT_FILTER, :FromPlanDate, :ToPlanDate, :needremain, :onlypositive, :opernorm)');
            ParamByName('datein').asdate  := FromDate;
            ParamByName('dateout').asdate := ToDate;
            ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
            ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
            ParamByName('ID_CHRT_FILTER').asinteger  := ID_CHRT_FILTER;
            ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
            ParamByName('FROMPLANDATE').asdate  := strtodate('01.01.1901');;
            ParamByName('ToPLANDATE').asdate    := strtodate('01.01.2500');
            if JROrderGrid.Columns[JROrderGrid.Columns.Count - 1].visible then
              ParamByName('needremain').AsInteger := 1
              else
               ParamByName('needremain').AsInteger := 0;
            ParamByName('onlypositive').AsInteger  := onlypositive;
            ParamByName('opernorm').AsInteger      := opernorm;
            Open;

           end;
       end;
     end;

  FilterForm.Close;


   if filtered = 1 then
     ToolButtonFilter.Down := true
   else
     ToolButtonFilter.Down := false;

end;

{

    Процедура установки сортировки таблицы

    Вход: направление сортировки


}
procedure TJR_ORDERForm.sort_table(type_of_sort: integer);
var strord : string;
begin

   strord := 'order by ' +
     JROrderGrid.Columns.Items[type_of_sort].FieldName;

  with data.JROrderFormQuery do

    begin

       close;
       sql.clear;
       sql.add('select * from BROWSE_ORDER_PROC(:datein, :dateout, :ID_PDR_FILTER, :ID_CST_FILTER,');
       sql.add('       :PR_EXEC_FILTER, :ID_CHRT_FILTER, :FromPlanDate, :ToPlanDate, :needremain, :onlypositive, :opernorm)');
       ParamByName('datein').asdate  := FromDate;
       ParamByName('dateout').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
       ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
       ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;
       ParamByName('ID_CHRT_FILTER').asinteger := ID_CHRT_FILTER;
       ParamByName('FROMPLANDATE').asdate   := strtodate('01.01.1901');;
       ParamByName('ToPLANDATE').asdate     := strtodate('01.01.2500');
          if JROrderGrid.Columns[JROrderGrid.Columns.Count - 1].visible then
            ParamByName('needremain').AsInteger := 1
            else
             ParamByName('needremain').AsInteger := 0;
       ParamByName('onlypositive').AsInteger     := onlypositive;
       ParamByName('opernorm').AsInteger         := opernorm;
       sql.add(strord);
       open;

    end;


end;


procedure TJR_ORDERForm.FormCreate(Sender: TObject);
begin

  ID_PDR_Filter := -1;  //  фильтр отбора
  ID_CST_Filter := -1;  //  по журналу
  PR_EXEC_Filter:= -1;  //
  ID_CHRT_FILTER:= -1;
  FromPlanDate  := 0;
  ToPlanDate    := 0;
  onlypositive  := 0;
  opernorm      := 0;


   filterstring   := GetColumnsList('BROWSE_ORDER_PROC', JROrderGrid);
//   if not filterstring.FindParam('ID_PDR_Filter').IsNull then
//     ID_PDR_Filter  := filterstring.ParamByName('ID_PDR_Filter').asinteger;
//   if not filterstring.FindParam('ID_CST_Filter').IsNull  then
//   ID_CST_Filter  := filterstring.ParamByName('ID_CST_Filter').asinteger;
//   if not filterstring.FindParam('PR_EXEC_Filter').IsNull then
//   PR_EXEC_Filter  := filterstring.ParamByName('PR_EXEC_Filter').asinteger;
//   if not filterstring.FindParam('ID_CHRT_FILTER').IsNull  then
//   ID_CHRT_FILTER  := filterstring.ParamByName('ID_CHRT_FILTER').asinteger;
//   if not filterstring.FindParam('FromPlanDate').IsNull then
//   FromPlanDate    := filterstring.ParamByName('FromPlanDate').AsDate;
//   if not filterstring.FindParam('ToPlanDate').IsNull then
//   ToPlanDate      := filterstring.ParamByName('ToPlanDate').AsDate;
//   ID_PDR_Filter  := filterstring.
//    strtoint(getfiltervalue(filterstring, 'ID_PDR_Filter'));
//   ID_PDR_Filter  :=  strtoint(getfiltervalue(filterstring, 'ID_PDR_Filter'));
//   ID_CST_Filter  :=  strtoint(getfiltervalue(filterstring, 'ID_CST_Filter'));
//   PR_EXEC_Filter := strtoint(getfiltervalue(filterstring, 'PR_EXEC_Filter'));
//   ID_CHRT_FILTER := strtoint(getfiltervalue(filterstring, 'ID_CHRT_FILTER'));
//   FromPlanDate   := strtodate(getfiltervalue(filterstring, 'FromPlanDate'));
//   ToPlanDate     := strtodate(getfiltervalue(filterstring, 'ToPlanDate'));


  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

  chUpdateJROrder.Checked := Param_Form.glUpdateJROrder;  


end;
{
   Процедура при редактировании таблицы
}
procedure TJR_ORDERForm.JROrderGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 IdDoc  := data.JROrderFormQuery.FieldByName('ID').asinteger;
 if TypeEdit = 1 then
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    13 :  OpenDoc;  // Редактирование по Enter
  end;
end;

{

     Процедура вызова контексной подсказки по объекту

}


procedure TJR_ORDERForm.ToolButtonHelpClick(Sender: TObject);
begin
   application.HelpCommand(HELP_CONTEXT, 320);

end;



{

     Процедура ввода на основании заказа приходной накладной

}
procedure TJR_ORDERForm.MenuInsertSubClick(Sender: TObject);
var ID_PR : integer;         // ID подразделения
    i     : integer;
    qTMPQuery : tQuery;      // временный запрос
    is_repair : boolean;     // признак заказ на ремонт
    lineno    : integer;

    aNMNT     : pNMNT;       // указатель табличной части номенклатуры
    aNMNTDoc  : pNMNTDoc;    // указатель шапки накладной
    lNMNT     : tList;       // список номенклатуры накладной
    lNMNTDoc  : tList;       // список указателей шапки документа

begin
  // При пустой таблице выход
  if  (data.JROrderFormQuery.Eof) and (data.JROrderFormQuery.bof) then exit;

  lNMNT := tList.Create;
  lNMNTDoc := tList.Create;

  qTMPQuery := tquery.create(self);
  qTMPQuery.DatabaseName := 'RMP';


//  // Проверим, есть ли закрытые операции в текущем периоде
//  qTMPQUery.SQL.Clear;
//  qTMPQUery.SQL.add('select id_order from jr_prod');
//  qTMPQUery.SQL.add('where id_order = :id_order and period = :period');
//  qTMPQUery.Params[0].asinteger := iddoc;
//  qTMPQUery.Params[1].asinteger := Param_Form.CurFactPeriod;
//  qTMPQuery.Open;
//
//  if qTMPQuery.Eof then
//      MessageDlg('Нет закрытых операций в текущем периоде.', mtWarning, [mbOK], 0);


  qTmPQuery.sql.Clear;
  qTmPQuery.sql.add('select ord.id as iddoc,      ');
  qTmPQuery.sql.add('       cst.id as id_cst,     ');
  qTmPQuery.sql.add('       cst.name as name_cst, ');
  qTmPQuery.sql.add('       chrt.vid_chrt,        ');
  qTmPQuery.sql.add('       ord.id_nmnt as id_nmnt,          ');
  qTmPQuery.sql.add('       (select nmnt.name from spr_nmnt nmnt where nmnt.id = ord.id_nmnt) as name_nmnt,                                         ');
  qTmPQuery.sql.add('       (select ediz.id from spr_ediz ediz, spr_nmnt nmnt where nmnt.id = ord.id_nmnt and nmnt.id_ediz = ediz.id) as id_ediz,   ');
  qTmPQuery.sql.add('       (select ediz.name from spr_ediz ediz, spr_nmnt nmnt where nmnt.id = ord.id_nmnt and nmnt.id_ediz = ediz.id) as name_ediz,');
  qTmPQuery.sql.add('       ord.number_f,         ');
  qTmPQuery.sql.add('       ord.sum_doc,          ');
  qTmPQuery.sql.add('       ord.weight            ');
  qTmPQuery.sql.add('from dh_order ord, spr_chrt chrt, spr_cst cst, spr_pdr pdr ');
  qTmPQuery.sql.add('where ord.id = :iddoc and ord.id_chrt = chrt.id            ');
  qTmPQuery.sql.add('and cst.code = pdr.code and pdr.id = ord.id_pdr            ');


  // Данные по запросу проставляются в список записей
  new(aNMNTDoc);

  is_repair := false;

  // Проверка выбора строк
  if JROrderGrid.SelectedRows.Count = 0 then
    begin
      MessageDlg('Строки не выбраны.'+#13+#10+'Возможно отключен режим многострочного выбора.', mtWarning, [mbOK], 0);
      exit;

    end;

  // ввод на основании возможен на основании нескольких выделенных строк
  lineno := 0;

  for i := 0 to JROrderGrid.SelectedRows.Count - 1 do


    with JROrderGrid.DataSource.DataSet do

     begin
      // переход на первую выделенную запись
      GotoBookmark(pointer(JROrderGrid.SelectedRows.Items[i]));

      // Ввод на основании возможен только для выполненных заказов
      if FieldByName('PR_EXEC').asinteger = 3 then

        begin

           qTMPQuery.close;
           qTMPQuery.ParamByName('iddoc').asinteger := FieldByName('ID').asinteger;
           qTMPQuery.open;
           qTMPQuery.First;

           new(aNMNT);
           aNMNT^.lineno      := lineno;
           aNMNT^.ID_matr     := qTMPquery.Fieldbyname('id_nmnt').asinteger;
           aNMNT^.Name_matr   := qTMPquery.Fieldbyname('name_nmnt').asstring;

           // 08.02.06
           // Вес в заказе дается на единицу
           aNMNT^.nWeight     := qTMPquery.Fieldbyname('weight').asfloat
                                  * qTMPquery.Fieldbyname('number_f').asfloat;

           // единица измерения номенклатуры выбрана из справочника номенклатуры
           if qTMPquery.Fieldbyname('id_Ediz').asinteger > 0 then
             begin
               aNMNT^.ID_EdIz     := qTMPquery.Fieldbyname('id_Ediz').asinteger;
               aNMNT^.Name_EdIz   := qTMPquery.Fieldbyname('name_ediz').asstring;
             end
           else // иначе по умолчанию
             begin
              aNMNT^.ID_EdIz   := param_form.qEDIZQuery.Fields[0].asinteger;
              aNMNT^.Name_EdIz := param_form.EDIZCombo.text;
              mymessage('Не заполнена единица измерения в номенклатуре заказа');
             end;

           aNMNT^.nValue      := qTMPquery.Fieldbyname('number_f').asfloat;
           aNMNT^.nCost       := Get_sum_order_by_calc(FieldByName('ID').asinteger, -1);
           aNMNT^.ID_ORDER    := qTMPquery.Fieldbyname('iddoc').asinteger;

           if aNMNT^.nValue <> 0 then
             aNMNT^.Price := aNMNT^.nCost / aNMNT^.nValue
           else
             aNMNT^.Price := 0;

           // данные по исполнителю и складу в шапку документа
           if qTMPquery.Fieldbyname('id_cst').asinteger <> 0 then
             aNMNTDoc^.ID_CST   := qTMPquery.Fieldbyname('id_cst').asinteger
            else
              begin
                MessageDlg('Подразделение-исполнитель отсутствует в справочнике Организаций.', mtWarning, [mbOK], 0);
                abort;
              end;
           aNMNTDoc^.Name_CST := qTMPquery.Fieldbyname('name_cst').asstring;
           aNMNTDoc^.ID_WRHS  := param_form.qWRHSQuery.Fieldbyname('id').asinteger;
           aNMNTDoc^.Name_WRHS:= param_form.WRHSCombo.text;
           aNMNTDoc^.Type_doc := qTMPQuery.fieldbyname('vid_chrt').asinteger;
           aNMNTDOc^.info     := ''; //'Документ введен на основании из журнала заказов';

           lNMNT.Add(aNMNT);

           if qTMPQuery.fieldbyname('vid_chrt').asinteger > 0 then
            is_repair := true;

        end
{
         // создание нового документа приходной накладной
         ID_PR := CreateNewPR_Doc(FieldByName('ID').asinteger, self, 1);

         // для заказов на выполнение ремонтных услуг расходный документ создается
         // сразу.
         if ID_PR > 0 then

            if FieldByName('VID_CHRT').asinteger = 1 then

               if MessageDlg('Заказ на выполнение работ. '+#13+#10+'Ввести акт выполненных работ?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk then

                   CreateNewRS_Doc(ID_PR, 2, FieldByName('date_in').asstring, self)
}

         else
           begin
             showmessage('Заказ еще не выполнен!');
             exit;
           end;


    end;

     aNMNTDoc^.lNMNT := lNMNT;
     lNMNTDoc.add(aNMNTDoc);

     ID_PR := CreateNewPR_Doc(1, self, 1, lNMNTDoc);

     if is_repair then

       begin

         if MessageDlg('Заказ на выполнение работ. '+#13+#10+'Ввести акт выполненных работ?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk then
           begin

                 qTMPQuery := tquery.create(self);
                // формирование запроса на нахождение заказчика
                 with qTMPQuery do
                   begin
                      DatabaseName := 'RMP';
                      sql.clear;
                      sql.add('select b.name, b.id as id_cst, a.id_cst');
                      sql.add('from dh_rqst a, spr_cst b, dh_order ord');
                      sql.add('where a.id = ord.id_rqst and a.id_cst = b.id and ord.id = :idord');
                      params[0].asinteger := data.JROrderFormQuery.FieldByName('ID').asinteger;
                      open;
                      first;

                    end;

                    aNMNTDoc^.ID_CST   := qTMPQuery.Fields[1].asinteger;
                    aNMNTDoc^.Name_CST := qTMPQuery.Fields[0].asstring;
                    aNMNTDoc^.Type_doc := 2;
                    aNMNTDOc^.info     := ''; //'Документ введен на основании из журнала заказов';

                      //   вызов функции создания расходного документа на основании
                      //     приходного документа
                      //
                      CreateNewRS_Doc(ID_PR, 2, datetostr(now), self, lNMNTDoc);


           end;


       end;

    if Param_form.glUpdateJROrder then
      refreshquery( data.JROrderFormQuery);

end;
{

   Процедура ввода на основании нового заказа по невыполненныму
   количеству деталей.

}

procedure TJR_ORDERForm.MenuInsertOrderClick(Sender: TObject);
var qFindQuery : tQuery;   // запрос поиска
    DisCount   : real;  // переменная разницы
    NewID      : integer;  // признак нового документа
    IDDoc      : integer;  // ID документа
    j, i       : integer;  //
    NumDoc     : integer;  // номер документа
    qTMPQuery  : tQuery;   // временный запрос
    ParentNumber : integer;// номер заявки
    DocForm    : TDOC_ORDERForm;  // Дескриптор формы заказа
    ParentID   : integer;         // ID заказа
    isfound    : boolean;         // признак найденной записи

    
begin
  {
     Если количество выполненных деталей меньше планового,
     то появляется возможность ввести новый заказ на основании
     данного.
  }
  if (data.JROrderFormQuery.Eof ) and (data.JROrderFormQuery.Bof) then exit;


  try



    Iddoc := data.JROrderFormQuery.FieldByName('ID').asinteger;

    qFindQuery := tQuery.Create(self);
     with qFindQuery do
       begin

         databasename := data.RMPBase.DatabaseName;
         sql.Add('select number_p, number_f from dh_order');
         sql.add('where id = ' + inttostr(Iddoc));
         open;
      end;

      if qFindQuery.eof then exit;

      // количество по плану больше выполненного количества
      DisCount := qFindQuery.Fields[0].asfloat - qFindQuery.Fields[1].asfloat;

      if DisCount <= 0 then
        begin
           MessageDlg('Плановое и фактическое количество деталей совпадает.', mtWarning, [mbOk], 0);
           Exit;
        end;

      if MessageDlg('Ввести новый заказ на разницу ' + floattostr(DisCount) + ' ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then Exit;

      // формирование запроса на нахождение реквизитов документа
      with qFindQuery do
        begin
          sql.clear;
          sql.add('select * from dh_order where id = ' + inttostr(Iddoc));
          open;

          if qFindQUery.eof then exit;

          // формирование запроса для нахождения номера документа
          qTMPQuery := TqUERY.CREATE(SELF);
          qTMPQuery.DatabaseName := data.RMPBase.DatabaseName;

          qtmpquery.sql.add('select max(number) from dh_order');
          qtmpquery.open;
          NumDoc := qtmpquery.Fields[0].asinteger + 1;

         // начало транзакции
         data.RMPBase.StartTransaction;


          // заполнение полей хранимой процедуры
          for j := 0 to StorProcOrderAdd.ParamCount - 2 do
            begin

               isfound := false;

               // сопоставление полей запроса и параметров процедуры по именам
               for i := 0 to qFindQUery.FieldCount - 1 do
                 if StorProcOrderAdd.Params[j].Name = qFindQUery.Fields[i].FullName then
                    begin
                      isfound := true;
                      break;
                    end;


              if isfound then
                StorProcOrderAdd.Params[j].Value := qFindQuery.Fields[i].value;


            end;

         // номер документа другой
         StorProcOrderAdd.ParamByName('NUMBER').asinteger := NumDoc;

         // количество по факту другое
         StorProcOrderAdd.ParamByName('NUMBER_F').asfloat := DisCount;

         // Признак заказа - невыполнен
         StorProcOrderAdd.ParamByName('PR_EXEC').asinteger := 1;

         // Дата документа - сегодня
         StorProcOrderAdd.ParamByName('DATE_IN').asdate := now;




         // выполнение запроса
         // если все правильно, то можно записать документ
         StorProcOrderAdd.Prepare;
         StorProcOrderAdd.ExecProc;

         // получение ID документа
         NewID  := StorProcOrderAdd.ParamByName('IDDOC').asinteger;


         // Теперь заполнение таблиц плановых операций и материалов
         with qFindQuery do
           begin

             close;
             sql.clear;
             sql.Add('select * from dt_order1');
             sql.add('where id_order = ' + inttostr(Iddoc));
             open;

             // заполнение таблиц операций
             while not eof do
               begin
                // заполнение полей запроса
                for j := 0 to StorProcPlanOp.ParamCount - 1 do
                  begin

                    isfound := false;

                    for i := 0 to qFindQUery.FieldCount - 1 do
                     if StorProcPlanOp.Params[j].Name = qFindQUery.Fields[i].FullName then
                       begin
                         isfound := true;
                         break;
                       end;

                    if isfound then
                      StorProcPlanOp.Params[j].Value := qFindQuery.Fields[i].value;


                  end;

                  StorProcPlanOp.Parambyname('ID_ORDER').asinteger := NewID;
                  // Записать плановые операции
                  StorProcPlanOp.Prepare;
                  StorProcPlanOp.ExecProc;

                  next;

               end;

          end;


         // заполнение таблиц плановых материалов
         with qFindQuery do
           begin

             close;
             sql.clear;
             sql.Add('select * from dt_mtrp');
             sql.add('where id_opp = ' + inttostr(Iddoc));
             open;

             // заполнение таблиц операций
             while not eof do
               begin
                // заполнение полей запроса
                for j := 0 to StorProcPlanMTR.ParamCount - 1 do
                  begin

                    isfound := false;

                    for i := 0 to qFindQUery.FieldCount - 1 do
                     if StorProcPlanMTR.Params[j].Name = qFindQUery.Fields[i].FullName then
                       begin
                         isfound := true;
                         break;
                       end;

                    if isfound then
                      StorProcPlanMTR.Params[j].Value := qFindQuery.Fields[i].value;


                  end;

                  StorProcPlanMTR.Parambyname('ID_OPP').asinteger := NewID;

                  // Записать плановые операции
                  StorProcPlanMTR.Prepare;
                  StorProcPlanMTR.ExecProc;

                  next;

               end;

          end;



         // подтверждение транзакции
         data.RMPBase.Commit;

         // формирование и выполнение запроса для нахождение номера документа-владельца
         qTMPQuery:= tQuery.Create(self);
         qTMPQuery.databasename := 'RMP';
         qTMPQuery.sql.add('select number from dh_rqst where id = ' + data.JROrderFormQuery.FieldByName('ID_RQST').asstring);
         qTMPQuery.open;

         ParentNumber := qTMPQuery.Fields[0].asinteger;
         ParentID     := data.JROrderFormQuery.FieldByName('ID_RQST').asinteger;


         DocForm := TDOC_ORDERForm.CreateN(mainform, NewID, ParentID, ParentNumber, nil);
         DocForm.show;

        end;

        
   except

      data.RMPBase.Rollback;

   end;

    if Param_form.glUpdateJROrder then
      refreshquery( data.JROrderFormQuery);

end;


{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_ORDERForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
     EscPressed := True;
     abort;
     
   end;

end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_ORDERForm.MenuByWidthClick(Sender: TObject);
begin
   if MenuByWidth.Checked then
     begin
       MenuByWidth.Checked := false;
       mainMenuByWidth.Checked := false;
     end
   else
    begin
      MenuByWidth.Checked := true;
      MainMenuByWidth.Checked := true;
    end;

    JROrderGrid.AutoFitColWidths := MenuByWidth.Checked;

end;

procedure TJR_ORDERForm.MenuMultiSelectClick(Sender: TObject);
begin
   JROrderGrid.options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgRowSelect,dgConfirmDelete,dgCancelOnExit,dgMultiSelect];

   if MenuMultiSelect.Checked then
    begin
      MenuMultiSelect.Checked := false;
      JROrderGrid.options := [dgTitles,dgIndicator,dgColumnResize,dgColLines,dgRowLines,dgRowSelect,dgConfirmDelete,dgCancelOnExit];
      MainMenuMultiSelect.Checked := false;

    end
   else
     begin
      MenuMultiSelect.Checked := true;
      MainMenuMultiSelect.Checked := true;
     end;

end;
{

    Процедура открытия формы структуры подчиненности документов
}
procedure TJR_ORDERForm.MenuStucDocClick(Sender: TObject);
var StrForm : TDOC_Structure_Form;
begin
  //
  StrForm := TDOC_Structure_Form.Create(application);
  StrForm.idorder := data.JROrderFormQuery.fieldbyname('ID').asinteger;
  StrForm.OpenQuery;

end;

{
   Процедура нажатия кнопки заголовка

}

procedure TJR_ORDERForm.JROrderGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  sort_table(aCol);

  JROrderGrid.Columns[aCol].Title.SortMarker := smDownEh;


end;
{-----------------------------------------------------------------------------
  Процедура: TJR_ORDERForm.N4Click
  Дата:      27-апр-2004
  Аргументы: Sender: TObject
  Возврат:   None
  Описание:  Процедура ввода на основании заказа
     расходного документа
-----------------------------------------------------------------------------}

procedure TJR_ORDERForm.MenuInsertWRHSOutClick(Sender: TObject);
var
    i     : integer;
    qOrderQuery : tQuery;  // Запрос по заказам
    qPRQuery    : tQuery;  // запрос по приходным докам
    lineno      : integer; // номер строки

    aNMNT     : pNMNT;     // указатель номенклатуры
    aNMNTDoc  : pNMNTDoc;  // указатель шапки документа
    lNMNT     : tList;     // список указателей табльчной части
    lNMNTDoc  : tList;     // список указателей шапки документа


begin

  // При пустой таблице выход
  if  (data.JROrderFormQuery.Eof) and (data.JROrderFormQuery.bof) then exit;

  lNMNT    := tList.Create;
  lNMNTDoc := tList.Create;

  qOrderQuery := tquery.create(self);
  qOrderQuery.DatabaseName := 'RMP';

  //     По запросу находятся заказ, заказчик из заявки,
  //     вид чертежа, номенклатура, единицы измерения,
  //     сумма и количество по заказу.
  //

  with  qOrderQuery.sql do
    begin
      clear;
      add('select ord.id as iddoc,      ');
      add('       cst.id as id_cst,     ');
      add('       cst.name as name_cst, ');
      add('       chrt.vid_chrt,        ');
      add('       ord.id_nmnt as id_nmnt,          ');
      add('       (select nmnt.name from spr_nmnt nmnt where nmnt.id = ord.id_nmnt) as name_nmnt,                                         ');
      add('       (select ediz.id from spr_ediz ediz, spr_nmnt nmnt where nmnt.id = ord.id_nmnt and nmnt.id_ediz = ediz.id) as id_ediz,   ');
      add('       (select ediz.name from spr_ediz ediz, spr_nmnt nmnt where nmnt.id = ord.id_nmnt and nmnt.id_ediz = ediz.id) as name_ediz,');
      add('       ord.number_f,         ');
      add('       ord.sum_doc,          ');
      add('       ord.weight            ');
      add('from dh_order ord, spr_chrt chrt, spr_cst cst, dh_rqst rqst ');
      add('where ord.id = :iddoc and ord.id_chrt = chrt.id and       ');
      add('      cst.id = rqst.id_cst and rqst.id = ord.id_rqst        ');
    end;


  //   Формирование запроса на нахождение приходного
  //   документа по заказу. Для создания расходного документа
  //   приход должен уже быть.

  qPRQuery := tquery.create(self);
  qPRQuery.DatabaseName := 'RMP';
  with  qPRQuery.sql do
    begin
      clear;
      add('select pr.id');
      add('from dh_pr pr, dt_pr prt');
      add('where pr.id = prt.id_prmtr and prt.id_ord = :iddoc');

    end;


  // Данные по запросу проставляются в список записей
  new(aNMNTDoc);

  // Проверка выбора строк
  if JROrderGrid.SelectedRows.Count = 0 then
    begin
      MessageDlg('Строки не выбраны.'+#13+#10+'Возможно отключен режим многострочного выбора.', mtWarning, [mbOK], 0);
      exit;

    end;

  // ввод на основании возможен на основании нескольких выделенных строк
  lineno := 0;

  for i := 0 to JROrderGrid.SelectedRows.Count - 1 do


    with JROrderGrid.DataSource.DataSet do

     begin
      // переход на первую выделенную запись
      GotoBookmark(pointer(JROrderGrid.SelectedRows.Items[i]));

      // Ввод на основании возможен только для выполненных заказов
      if FieldByName('PR_EXEC').asinteger = 3 then

        begin
           // расходный документ можно формировать только если уже создан
           // приходный на склад готовой продукции
           qPRQuery.close;
           qPRQuery.ParamByName('iddoc').asinteger := FieldByName('ID').asinteger;
           qPRQuery.open;

           // если запрос пустой, то приходного докумнта для заказа нет
           if qPRQuery.Eof then
             begin
               MessageDlg('На основании заказа № ' + FieldByName('Number').asstring
                          + ' еще нет прихода.', mtError, [mbOK], 0);
               exit;
             end;


           // выполнение запроса по нахождению значений реквизитов расходного
           // документа
           qOrderQuery.close;
           qOrderQuery.ParamByName('iddoc').asinteger := FieldByName('ID').asinteger;
           qOrderQuery.open;
           qOrderQuery.First;


           new(aNMNT);
           aNMNT^.lineno      := lineno;
           aNMNT^.ID_matr     := qOrderQuery.Fieldbyname('id_nmnt').asinteger;
           aNMNT^.Name_matr   := qOrderQuery.Fieldbyname('name_nmnt').asstring;
           aNMNT^.ID_EdIz     := qOrderQuery.Fieldbyname('id_Ediz').asinteger;
           aNMNT^.Name_EdIz   := qOrderQuery.Fieldbyname('name_ediz').asstring;
           aNMNT^.nValue      := qOrderQuery.Fieldbyname('number_f').asfloat;
           aNMNT^.nCost       := qOrderQuery.Fieldbyname('sum_doc').asfloat;
           aNMNT^.ID_ORDER    := qOrderQuery.Fieldbyname('iddoc').asinteger;

           // 08.02.06 Вес в заказе дается на  единицу, а на складе нужен общий
           aNMNT^.nWeight     := qOrderQuery.Fieldbyname('weight').asfloat
                * qOrderQuery.Fieldbyname('number_f').asfloat;

           if aNMNT^.nValue <> 0 then
             aNMNT^.Price := aNMNT^.nCost / aNMNT^.nValue
           else
             aNMNT^.Price := 0;

           // данные по исполнителю и складу в шапку документа
           aNMNTDoc^.ID_CST   := qOrderQuery.Fieldbyname('id_cst').asinteger;
           aNMNTDoc^.Name_CST := qOrderQuery.Fieldbyname('name_cst').asstring;
           aNMNTDoc^.ID_WRHS  := param_form.qWRHSQuery.Fieldbyname('id').asinteger;
           aNMNTDoc^.Name_WRHS:= param_form.WRHSCombo.text;
           aNMNTDoc^.Type_doc := qOrderQuery.fieldbyname('vid_chrt').asinteger + 1;
           aNMNTDOc^.info     := ''; //'Документ введен на основании из журнала заказов';

           lNMNT.Add(aNMNT);

        end

         else
           begin
             showmessage('Заказ еще не выполнен!');
             exit;
           end;


    end;

     aNMNTDoc^.lNMNT := lNMNT;
     lNMNTDoc.add(aNMNTDoc);


     //
     //   Вызов процедуры создания расходного документа по готовой продукции
     //
     CreateNewRS_Doc(1, 2, datetostr(now), self, lNMNTDoc);

    if Param_form.glUpdateJROrder then
       refreshquery( data.JROrderFormQuery);


end;
{-----------------------------------------------------------------------------
  Procedure: TJR_ORDERForm.MenuAddToPlanClick
  Author:    Desha
  Date:      01-июн-2005
  Arguments: Sender: TObject
  Добавляет заказ или несколько заказов в план
-----------------------------------------------------------------------------}

procedure TJR_ORDERForm.MenuAddToPlanClick(Sender: TObject);
var i : integer;
    res : string;
    count : integer;

begin
  // При пустой таблице выход
  if  (data.JROrderFormQuery.Eof) and (data.JROrderFormQuery.bof) then exit;


  // Проверка выбора строк
  if JROrderGrid.SelectedRows.Count = 0 then
    begin
      MessageDlg('Строки не выбраны.'+#13+#10+
          'Возможно отключен режим многострочного выбора.',
           mtWarning, [mbOK], 0);
      exit;

    end;

  res := 'В успешно добавлены заказы: ';
  count := 0;

  for i := 0 to JROrderGrid.SelectedRows.Count - 1 do


    with JROrderGrid.DataSource.DataSet do

     begin
      // переход на первую выделенную запись
      GotoBookmark(pointer(JROrderGrid.SelectedRows.Items[i]));
      if FieldByName('PR_EXEC').asinteger < 3 then
        begin
          data.Add_Order_To_Plan.Parambyname('ID_ORDER').asinteger := Fieldbyname('id').asinteger;
          data.Add_Order_To_Plan.Parambyname('PERIOD').asinteger := Param_Form.CurPlanPeriod;
          data.Add_Order_To_Plan.Parambyname('ID_PDR').asinteger := Fieldbyname('id_pdr').asinteger;

          res := res + FieldbyName('Number').AsString +#13+#10;

          data.RMPBase.StartTransaction;
          try
            data.Add_Order_To_Plan.Prepare;
            data.Add_Order_To_Plan.ExecProc;
            data.RMPBase.Commit;
            count := count + 1;
          except
            data.RMPBase.Rollback;
          end;
        end;

      end;
     if count > 0 then
       MessageDlg(res, mtInformation, [mbOK], 0);

end;

{-----------------------------------------------------------------------------
  Procedure: TJR_ORDERForm.MainMenuCHRTUpdateClick
  Author:    Desha
  Date:      07-июн-2005
  Arguments: Sender: TObject
 Процедура добавляет в чертеж технологическую информацию по факту
 выполнения заказа
-----------------------------------------------------------------------------}

procedure TJR_ORDERForm.MainMenuCHRTUpdateClick(Sender: TObject);
begin

  if FormOrderSource.DataSet.FieldByName('PR_EXEC').AsInteger < 3 then
    begin
      MessageDlg('Заказ еще не выполнен!', mtWarning, [mbOK], 0);
      exit;
    end;


   if MessageDlg('Отредактировать данные чертежа по фактическим '+#13+#10+'операциям заказа?',
    mtWarning, [mbOK,mbCancel], 0) = mrCancel then exit;

 try
   data.RMPBase.StartTransaction;
   data.AddCHRTStoredProc.ParamByName('ID_ORDER').asinteger :=
      FormOrderSource.DataSet.FieldByName('id').AsInteger;

   data.AddCHRTStoredProc.Prepare;
   data.AddCHRTStoredProc.ExecProc;

   data.RMPBase.Commit;

 except
   data.RMPBase.Rollback;

 end;

end;

procedure TJR_ORDERForm.chUpdateJROrderClick(Sender: TObject);
begin
  Param_Form.glUpdateJROrder := chUpdateJROrder.Checked;
end;

end.
