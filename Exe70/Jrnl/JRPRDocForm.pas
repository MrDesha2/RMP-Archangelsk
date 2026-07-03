{
                 Модуль JRPRDocForm
      формы журнала приходных накладных.

}
unit JRPRDocForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ImgList, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus, ActnList;

type
  TJR_PRDOCForm = class(TForm)
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
    N7: TMenuItem;
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
  JR_PRDOCForm: TJR_PRDOCForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала

  ID_CST_FILTER  : integer;
  ID_WRHS_FILTER : integer;
  PR_EXEC_FILTER : integer;
  ID_NMNT_FILTER : integer;
  filterstring   : string;

implementation

uses      libs,
     ParamForm,
          Main,
FiltrOrderEdit,   // форма редактирования фильтра по таблице
 PRDocEditForm,
          Base,
    GetPeriods;
{$R *.DFM}

{
  Процедура закрытия журнала заказов
}
procedure TJR_PRDOCForm.CloseButtonClick(Sender: TObject);
begin
  close;
end;
{
  Процедура ввода нового приходного документа
}
procedure TJR_PRDOCForm.ButtonAddClick(Sender: TObject);
var DocForm: TDOC_PRForm;
begin
  if not check_user_grand('DH_PR', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PRForm.CreateN(mainform, - 1, self);
  DocForm.show;

end;
{
     Процедура вызова формы редактирования формы документа "Приходная накладная"

}
procedure TJR_PRDOCForm.ButtonEditClick(Sender: TObject);
var DocForm: TDOC_PRForm;
begin
  if  data.JRPRFormQuery.FieldByName('ID').isnull then exit;

  IDDoc := data.JRPRFormQuery.FieldByName('ID').asinteger;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PRForm.CreateN(mainform, IDDoc, self);
    DocForm.OKButton.Enabled :=  check_user_grand('DH_PR', 'U', true);

  DocForm.show;

end;
{
       Процедура удаления документа "Приходная накладная"

}
procedure TJR_PRDOCForm.ButtonDelClick(Sender: TObject);
var number: string;
    date  : string;
begin
  if not check_user_grand('DH_PR', 'D', true) then exit;

  if  data.JRPRFormQuery.FieldByName('ID').isnull then exit;

  Number := data.JRPRFormQuery.FieldByName('NumDoc').AsString;
  date   := data.JRPRFormQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить приходную накладную  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    IDDoc := data.JRPRFormQuery.FieldByName('ID').AsInteger;

    if not data.JRPRFormQuery.Eof then
      data.JRPRFormQuery.Prior;

    Stored_Del_Proc.ParamByName('IDDOC').asinteger := IDDoc;  //  записи.
    Stored_Del_Proc.ExecProc;
   end;

   refreshquery(data.JRPRFormQuery);


end;

{

   Процедура установки интервала просмотра журнала Приходных накладных

}
procedure TJR_PRDOCForm.ButtonIntClick(Sender: TObject);
begin

  if not GetPeriod(FromDate, ToDate) then exit;


  // изменим название окна
  caption := 'Журнал приходных накладных с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // обновление таблиц

  with data.JRPRFormQuery do
    begin

      close;
      ParamByName('datein').asdate  := FromDate;
      ParamByName('dateout').asdate := ToDate;
      ParamByName('ID_CST_FILTER').asinteger  := ID_CST_FILTER;
      ParamByName('ID_WRHS_FILTER').asinteger := ID_WRHS_FILTER;
      ParamByName('ID_NMNT_FILTER').asinteger := ID_NMNT_FILTER;
      ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;

      open;

    end;

end;

procedure TJR_PRDOCForm.FormShow(Sender: TObject);
var    menuitem : tmenuitem;
       i : integer;

begin
  // интервал дат берется из формы параметров
  FromDate := strtodate(Param_Form.DateFromEdit.text);
  ToDate   := strtodate(Param_Form.DateToEdit.text);

  ID_CST_Filter := -1;  //  по журналу
  ID_WRHS_Filter:= -1;  //
  PR_EXEC_Filter:= -1;  //

  with data.JRPRFormQuery do

    begin
       sql.clear;
       sql.add('select * from BROWSE_PRDOC_PROC(:dateIn, :DateOut, :ID_CST_FILTER, :PR_EXEC_FILTER, :ID_WRHS_Filter, :ID_NMNT_FILTER)');
       ParamByName('DateIn').asdate  := FromDate;
       ParamByName('DateOut').asdate := ToDate;
       ParamByName('ID_CST_FILTER').asinteger := ID_CST_Filter;
       ParamByName('ID_WRHS_FILTER').asinteger:= ID_WRHS_Filter;
       ParamByName('ID_NMNT_FILTER').asinteger:= ID_NMNT_FILTER;
       ParamByName('PR_EXEC_FILTER').asinteger:= PR_EXEC_Filter;
       sql.add('order by date_in');
       open;

       last;
    end;

  caption := 'Журнал приходных накладных с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    Columns.Clear;

   filterstring := GetColumnsList('BROWSE_PRDOC_PROC', FormGrid);
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

procedure TJR_PRDOCForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetColumnList('BROWSE_PRDOC_PROC', FormGrid, data.JRPRFormQuery, filterstring);
  action := caFree;
end;

{
  Процедура поиска вниз

}

procedure TJR_PRDOCForm.ToolButtonFindDownClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;
   if not data.JRPRFormQuery.eof then data.JRPRFormQuery.next;

    find(data.JRPRFormQuery, FormGrid, Searchkey.text, 1);

end;
{
  Процедура поиска вверх

}
procedure TJR_PRDOCForm.ToolButtonFindUpClick(Sender: TObject);
begin

 if Searchkey.text = '' then exit;

   if not data.JRPRFormQuery.bof then data.JRPRFormQuery.prior;
   
    find(data.JRPRFormQuery, FormGrid, Searchkey.text, -1);

end;

{
   Процедура поиска по подстроке

}
procedure TJR_PRDOCForm.FindButtonClick(Sender: TObject);
begin

 if Searchkey.text <> '' then

    find(data.JRPRFormQuery, FormGrid, Searchkey.text, 1);

end;

procedure TJR_PRDOCForm.SearchkeyKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    find(data.JRPRFormQuery, FormGrid, Searchkey.text, 1);

end;


{
   Процедура при редактировании таблицы
}

procedure TJR_PRDOCForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

 IdDoc  := data.JRPRFormQuery.FieldByName('ID').asinteger;
 
  case Key of
    45 :  ButtonAddClick(sender);   // добавление записи
    46 :  ButtonDelClick(Sender);   // удаление записи
    13 :  ButtonEditClick(sender);  // Редактирование по Enter
    VK_F5 : refreshquery( data.JRPRFormQuery); // обновление таблицы
  end;

end;

procedure TJR_PRDOCForm.ToolButtonHelpClick(Sender: TObject);
begin
     application.HelpCommand(HELP_CONTEXT, 330);

end;

{
    Процедура ввода на основании расходной накладной



}


procedure TJR_PRDOCForm.MenuAddAnotherClick(Sender: TObject);
var    qTMPQuery : tQuery;

    aNMNT     : pNMNT;
    aNMNTDoc  : pNMNTDoc;
    lNMNT     : tList;
    lNMNTDoc  : tList;


begin

   // вызов процедуры ввода на основании прихода нового расходного документа
   //                                 : ID документа   тип неопределен   дата  форма

  lNMNT := tList.create;
  lNMNTDoc := tList.create;
  new(aNMNTDoc);

  qTMPQuery := tquery.create(self);
  with qTMPQuery do

    begin
      DatabaseName := 'RMP';

      sql.add('select ord.id as id_ord, prt.lineno,                                                      ');
      sql.add('      rqst.id_cst as id_cst,                                                    ');
      sql.add('      (select cst.name from spr_cst cst where rqst.id_cst = cst.id) as cst_name,');
      sql.add('      pr.id_wrhs,                                                               ');
      sql.add('      (select wrhs.name from spr_wrhs wrhs where wrhs.id = pr.id_wrhs) as wrhs_name,');
      sql.add('      pr.pr_chrt,                                                                   ');
      sql.add('      prt.id_nmnt,                                                                  ');
      sql.add('      (select nmnt.name from spr_nmnt nmnt where nmnt.id = prt.id_nmnt) as nmnt_name,');
      sql.add('      prt.number,                                                                   ');
      sql.add('      prt.price,                                                                    ');
      sql.add('      prt.id_ediz, pr.pr_chrt,                                                      ');
      sql.add('      (select ediz.name from spr_ediz ediz where ediz.id = prt.id_ediz) as ediz_name,');
      sql.add('      prt.LENGHT, prt.HIGHT, prt.WIDTH, prt.WEIGHT');
      sql.add('from dh_order ord, dh_pr pr, dt_pr prt, dh_rqst rqst                                ');
      sql.add('where pr.id = :iddoc and pr.id = prt.id_prmtr                                       ');
      sql.add('   and prt.id_ord = ord.id and ord.id_rqst = rqst.id                                ');

      ParamByName('iddoc').asinteger := data.JRPRFormQuery.FieldByName('ID').asinteger;
      Open;

      while not eof do
        begin
           new(aNMNT);
           aNMNT^.lineno      := qTMPquery.Fieldbyname('lineno').asinteger;
           aNMNT^.ID_matr     := qTMPquery.Fieldbyname('id_nmnt').asinteger;
           aNMNT^.Name_matr   := qTMPquery.Fieldbyname('nmnt_name').asstring;
           aNMNT^.ID_EdIz     := qTMPquery.Fieldbyname('id_Ediz').asinteger;
           aNMNT^.Name_EdIz   := qTMPquery.Fieldbyname('ediz_name').asstring;
           aNMNT^.nValue      := qTMPquery.Fieldbyname('number').asfloat;
           aNMNT^.Price       := qTMPquery.Fieldbyname('Price').asfloat;
           aNMNT^.ID_ORDER    := qTMPquery.Fieldbyname('id_ord').asinteger;
           aNMNT^.nCost       := aNMNT^.Price * aNMNT^.nValue;
           aNMNT^.nLenght     := qTMPquery.Fieldbyname('LENGHT').asfloat;
           aNMNT^.nHeight     := qTMPquery.Fieldbyname('HIGHT').asfloat;
           aNMNT^.nWidth      := qTMPquery.Fieldbyname('WIDTH').asfloat;
           aNMNT^.nWeight     := qTMPquery.Fieldbyname('WEIGHT').asfloat;

           // данные по исполнителю и складу в шапку документа
           aNMNTDoc^.ID_CST   := qTMPquery.Fieldbyname('id_cst').asinteger;
           aNMNTDoc^.Name_CST := qTMPquery.Fieldbyname('cst_name').asstring;
           aNMNTDoc^.ID_WRHS  := qTMPquery.Fieldbyname('id_wrhs').asinteger;
           aNMNTDoc^.Name_WRHS:= qTMPquery.Fieldbyname('wrhs_name').asstring;
           aNMNTDoc^.Type_doc := qTMPQuery.fieldbyname('pr_chrt').asinteger + 1;

           lNMNT.Add(aNMNT);

           next;
        end;
    end;

    aNMNTDoc^.lNMNT := lNMNT;
    lNMNTDoc.Add(aNMNTDoc);

   if lNMNT <> nil then 
    if lNMNT.Count > 0 then
     CreateNewRS_Doc(data.JRPRFormQuery.FieldByName('ID').asinteger, -1,         '',  self, lNMNTDoc)
   else
     MessageDlg('Неправильно заполнены данные документа.'+#13+#10+'Расходный документ не введен.', mtError, [mbYes], 0);

end;
{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_PRDOCForm.FormKeyDown(Sender: TObject; var Key: Word;
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
procedure TJR_PRDOCForm.MenuRefreshClick(Sender: TObject);
begin

   refreshQuery( data.JRPRFormQuery);

end;

procedure TJR_PRDOCForm.sort_table(type_of_sort: integer);
var strord : string;
begin

  if type_of_sort = 1 then

    strord :=  'order by date_in'

  else

    strord :=  'order by numdoc';

  with data.JRPRFormQuery do

    begin

       sql.clear;
       sql.add('select * from BROWSE_PRDOC_PROC(:dateIn, :DateOut, :ID_CST_FILTER, :PR_EXEC_FILTER, :ID_WRHS_FILTER, :ID_NMNT_FILTER)');
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


{

   Сортировка документов по дате

}
procedure TJR_PRDOCForm.MenuSortByDateClick(Sender: TObject);
begin
  sort_table(1);
end;

{

   Сортировка документов по виду документов

}
procedure TJR_PRDOCForm.MenuSortByDate1Click(Sender: TObject);
begin
  sort_table(2);
end;

{
   Процедура установки выравнивания таблицы по ширине

}
procedure TJR_PRDOCForm.MenuByWidthClick(Sender: TObject);
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
procedure TJR_PRDOCForm.ButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    filtered   : integer;
begin

  filtered := 0;

  FilterForm := TFilterForm.create(self);

  FilterForm.id_cst := ID_cst_FILTER;
  FilterForm.id_wrhs:= ID_WRHS_Filter;
  FilterForm.id_nmnt:= ID_NMNT_FILTER;

  FilterForm.OnOpenForm;

  FilterForm.PDRCombo.Enabled := false;
  FilterForm.PanelCHRT.Hide;
  FilterForm.PanelWRHS.Show;
  FilterForm.PanelOperFltr.Hide;
  FilterForm.Label3.Caption := 'Подписана';
  FilterForm.Label2.Caption := 'Исполнитель';
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

      // если есть отбор по признаку выполнения
      if FilterForm.pr_exec <> 0 then

        begin

           filtered := 1;
           PR_EXEC_FILTER := FilterForm.Pr_exec;

        end

       else
         PR_EXEC_FILTER := -1;

      // если есть отбор по заказчику
      if (FilterForm.WRHSCombo.text <> '') and (FilterForm.qWRHSQuery.active) then

        begin

          filtered := 1;
          ID_WRHS_FILTER := FilterForm.id_wrhs;

        end

       else
         ID_WRHS_FILTER := -1;

      // если есть отбор по заказчику
      if (FilterForm.NMNTCombo.text <> '') and (FilterForm.qNMNTQuery.active) then

        begin

          filtered := 1;
          ID_NMNT_FILTER := FilterForm.id_nmnt;

        end

       else
         ID_NMNT_FILTER := -1;

       // закрытие запроса

       with data.JRPRFormQuery do
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

       ID_CST_FILTER  := -1;
       PR_EXEC_FILTER := -1;
       ID_WRHS_Filter := -1;
       ID_NMNT_FILTER := -1;

       // обновление текста запроса
       with data.JRPRFormQuery do
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
   Процедура нажатия кнопки заголовка

}

procedure TJR_PRDOCForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin

  sort_table(aCol);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;

end;

procedure TJR_PRDOCForm.ColumnSet(Sender: TObject);
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
