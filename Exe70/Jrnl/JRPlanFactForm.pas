{***************************************************************
 *
 * Unit Name: JRPlanFactForm
 * Purpose  : Модуль формы планового и производственного журналов
 * Author   : Косицын Дмитрий
 * History  : 2003 год
 *
 ****************************************************************}

unit JRPlanFactForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ImgList, ComCtrls, ToolWin, Grids, DBGrids,
  ExtCtrls, DBGridEh, Menus;

type
  TJR_PLANFACTForm = class(TForm)
    pBotPanel: TPanel;
    pTopPanel: TPanel;
    pMainPanel: TPanel;
    CloseButton: TButton;
    ToolBar: TToolBar;
    ToolButtonAdd: TToolButton;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    PeriodBox: TComboBox;
    FormSource: TDataSource;
    qFormQuery: TQuery;
    qDelQuery: TQuery;
    qAddQuery: TQuery;
    Proc_change_period_plan: TStoredProc;
    Proc_change_period_prod: TStoredProc;
    FormGrid: TDBGridEh;
    ToolButtonFilter: TToolButton;
    CreatePlan_Proc: TStoredProc;
    ButtonMenu: TPopupMenu;
    MakePlan: TMenuItem;
    MakeRS_MTR_DOCS: TMenuItem;
    PlanButton: TToolButton;
    ToolButton2: TToolButton;
    PopupMenuTable: TPopupMenu;
    PopupAdd: TMenuItem;
    PopupEdit: TMenuItem;
    PopupDel: TMenuItem;
    PopupFilt: TMenuItem;
    PopupNewPeriod: TMenuItem;
    N6: TMenuItem;
    N1231: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Searchkey: TEdit;
    FindButton: TButton;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MainMenuAdd: TMenuItem;
    MainMenuEdit: TMenuItem;
    MainMenuDel: TMenuItem;
    MainMenuInt: TMenuItem;
    MainMenuFiltr: TMenuItem;
    N3: TMenuItem;
    N5: TMenuItem;
    MainMenuByWid: TMenuItem;
    N4: TMenuItem;
    MenuByWidth: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    MenuClearAll: TMenuItem;
    Columns: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    procedure ToolButtonAddClick(Sender: TObject);
    procedure ToolButtonEditClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure ToolButtonDelClick(Sender: TObject);
    procedure PeriodBoxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PlanButtonClick(Sender: TObject);
    procedure ChangePeriodClick(Sender: TObject);
    procedure changePlanPeriod;
    procedure changeFactPeriod;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonFilterClick(Sender: TObject);
    procedure FormGridTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure sort_table(type_of_sort: integer);
    procedure MakeRS_MTR_DOCSClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure FindButtonClick(Sender: TObject);
    procedure MainMenuByWidClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure MenuClearAllClick(Sender: TObject);
    procedure ColumnSet(Sender: TObject);
    procedure N11Click(Sender: TObject);

  private
    { Private declarations }
  public
    constructor CreateN(AOwner: TForm; _typeform : integer);
    destructor Destroy; override;
  end;

var
  JR_PLANFACTForm: TJR_PLANFACTForm;
  IDDoc      : Integer;        // ID документа
  FromDate   : string;         // начало интервала
  ToDate     : string;         // конец интервала
  FormType   : integer;        // тип формы: 1 - плановый журнал, 2 - производственный
  Period     : integer;        // период просмотра журнала
  TableName  : string;         // имя таблицы журнала

  sQueryText : string;         // текст запроса формы
  sOrderText : string;         // текст сортировки


  // фильтры для отбора журнала
  ID_PDR_Filter : integer; // по подразделениям
  ID_CST_Filter : integer; // по заказчикам
  PR_EXEC_Filter: integer; // по признаку выполнения
  filterstring   : string;

implementation

uses OrderEditForm,
     Main,
     JRORDERForm,
     libs,
     FiltrOrderEdit,   // форма редактирования фильтра по таблице
     Planning_Form,    // форма оперативного планирования
     PROC_MTRPLAN,     // форма формирования потребности в материалах
     Base, ParamForm;
{$R *.DFM}
{
    Конструктор создания формы журнала
     Вход: приложение-владелец формы
           тип формы: редактирование планового журнала - 1
                      редактирование производственного журнала - 2

}
constructor TJR_PLANFACTForm.createN(AOwner: TForm; _typeform : integer);
var i : integer;
    menuitem : tmenuitem;

begin
  inherited Create(AOwner);
  FormType := _TypeForm;

  // заполнение списка периодов и выяснение текушего периода
  FillPeriodCombo(PeriodBox);


  ID_PDR_Filter := -1;  //  фильтр отбора
  ID_CST_Filter := -1;  //  по журналу
  PR_EXEC_Filter:= -1;  //


  if FormType = 1 then   // создание формы планового журнала заказов
    begin
       PeriodBox.ItemIndex := Param_Form.BoxPlanPeriod.ItemIndex;
       Period := PeriodBox.ItemIndex;
       // создание запроса для формы


       with qFormQuery do
         begin

           sql.clear;
           sql.add('select * from BROWSE_PLAN_PROC(:period, :ID_PDR_FILTER, :PR_EXEC_FILTER)');

           ParamByName('Period').asinteger := Period;
           ParamByName('ID_PDR_FILTER').asinteger  := -1;
           ParamByName('PR_EXEC_FILTER').asinteger := -1;
           open;

         end;

       Tablename := 'jr_plan';
       caption   := 'Плановый журнал заказов';


       HelpContext := 350;
    end
  else                   // создание формы производственного журнала заказов
    begin

       PeriodBox.ItemIndex := Param_Form.BoxFactPeriod.ItemIndex;
       Period := PeriodBox.ItemIndex;
       // создание запроса для формы


       with qFormQuery do

          begin

            sql.clear;
            sql.add('select * from BROWSE_PROD_PROC(:Period, :ID_PDR_FILTER, :PR_EXEC_FILTER)');
            ParamByName('ID_PDR_FILTER').asinteger  := -1;
            ParamByName('PR_EXEC_FILTER').asinteger := -1;
            ParamByName('Period').asinteger := Period;
            open;

          end;  

       Tablename := 'jr_prod';
       caption := 'Производственный журнал заказов';
       PlanButton.Visible := false;


       HelpContext := 360;

    end;

  Period := PeriodBox.ItemIndex;

  qFormQuery.Last;

  // в зависимости от пожелания открываются окна
  if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    if formtype = 1 then
     filterstring := GetColumnsList('BROWSE_PLAN_PROC', FormGrid)
     else
      filterstring := GetColumnsList('BROWSE_PROD_PROC', FormGrid);

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

destructor TJR_PLANFACTForm.Destroy;
begin
  inherited;
end;


{
   Процедура добавления заказа из годового журнала
}
procedure TJR_PLANFACTForm.ToolButtonAddClick(Sender: TObject);
var qTESTQuery : tQuery; // запрос для поиска существующих доков в журнале
    JR_Form    : TJR_ORDERForm;
    i : integer;
begin
  // проверка прав доступа
  if not check_user_grand(uppercase(TableName), 'I', true) then exit;


  JR_Form := TJR_ORDERForm.Create(self);
  JR_Form.FormStyle := fsNormal;
  JR_Form.Visible   := false;
  JR_Form.FormActivate(self, 2);


  qAddQuery.sql.clear;
  if JR_Form.showmodal = mrOK then
    begin

      // для работы с плановым журналом и производственным будут разные запросы
      qTESTQuery             := TQuery.Create(self);
      qTestQuery.DatabaseName:= data.RMPBase.databasename;

  for i := 0 to  JR_Form.JROrderGrid.SelectedRows.Count - 1 do


    with JR_Form.JROrderGrid.DataSource.DataSet do

     begin
      // переход на первую выделенную запись
      GotoBookmark(pointer(JR_Form.JROrderGrid.SelectedRows.Items[i]));
      
       qTestQuery.sql.clear;
       qAddQuery.sql.clear;


      if FormType = 1 then
        begin
              if JR_Form.JROrderGrid.DataSource.DataSet.FieldByName('PR_EXEC').asinteger = 3 then
                begin
                   MessageDlg('Заказ уже выполнен и не может быть внесенным в план этого '+#13+#10+'периода.', mtWarning, [mbYes], 0);
                   abort;
                end;


          qAddQuery.sql.add('Insert into  jr_plan values(:IDDOC, :Period, :ID_PDR)');

          qTestQuery.sql.add('select id_order from jr_plan');

        end
      else
        begin

          qAddQuery.sql.add('Insert into  jr_prod values(:IDDOC, :Period, :ID_PDR, :PERIOD_F, :ISREADY)');
          qAddQuery.ParamByName('PERIOD_F').asinteger := Period;
          qAddQuery.ParamByName('ISREADY').asinteger  := 1;

          qTestQuery.sql.add('select id_order from jr_prod');

        end;

      qTestQuery.sql.add('where id_order = ' + inttostr(JR_Form.JROrderGrid.DataSource.DataSet.FieldByName('ID').asinteger));
      qTestQuery.sql.add(' and Period = ' + inttostr(Period));
      qTestQuery.open;

      If not qTestQuery.eof then
        begin

          showmessage('Заказ уже есть в текущем периоде журнала!');
          exit;

        end;


      // подготовка и выполнение запроса
      qAddQuery.ParamByName('IDDoc').asinteger := JR_Form.JROrderGrid.DataSource.DataSet.FieldByName('ID').asinteger;
      qAddQuery.ParamByName('Period').asinteger:= Period;
      qAddQuery.ParamByName('ID_PDR').asinteger:= data.JROrderFormQuery.FieldByName('ID_PDR').asinteger;
      data.RMPBase.StartTransaction;
       qAddQuery.ExecSql;
      data.RMPBase.Commit;

    end;

  end;
   JR_Form.close;
   refreshQuery(qFormQuery);


end;
{
  Процедура вызова окна редактирования документа "Заказ".
  Вход: на вход в качестве глобальной переменной передается ID документа.
  Выход: пусто
}

procedure TJR_PLANFACTForm.ToolButtonEditClick(Sender: TObject);

var DocForm : TForm;   // форма редактирования документа Заказ
    ParentID: integer; // ID родительского документа Заявка
 ParentNumber: integer;// номер родительского документа "Заявка"

begin

  if  qFormQuery.FieldByName('ID').isnull then exit;


  // открыть форму редактирования нового документа
  IdDoc    := qFormQuery.FieldByName('ID').asinteger;
  ParentID := qFormQuery.FieldByName('ID_RQST').asinteger;
  ParentNumber := qFormQuery.FieldByName('RQST_NUM').asinteger;

  DocForm := TDOC_ORDERForm.CreateN(mainform, IdDoc, ParentID, ParentNumber, nil);
  DocForm.show;

end;

{

   Закрытие формы

}
procedure TJR_PLANFACTForm.CloseButtonClick(Sender: TObject);
begin

  qFormQuery.Close;
  close;

end;

{

    Процедура удаления заказа из периода журнала

}

procedure TJR_PLANFACTForm.ToolButtonDelClick(Sender: TObject);
var number: string;
    date  : string;
begin
  // проверка прав доступа
  if not check_user_grand(uppercase(TableName), 'D', true) then exit;


  if  qFormQuery.FieldByName('ID').isnull then exit;

  Number := qFormQuery.FieldByName('Number').AsString;
  date   := qFormQuery.FieldByName('Date_in').AsString;

  if messagedlg('Удалить заказ ' + Number + ' от ' + date + ' из журнала?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

   begin

    IDDoc  := qFormQuery.FieldByName('ID').AsInteger;

    if not qFormQuery.Eof then
      qFormQuery.Prior;

    qDelQuery.SQL.clear;

    if FormType = 1 then
      qDelQuery.SQL.Add('delete from jr_plan')
    else
      qDelQuery.SQL.Add('delete from jr_prod');


      qDelQuery.SQL.Add('where ID_ORDER = :IDDoc and Period = :Period');
      qDelQuery.ParamByName('Period').asinteger := Period;
      qDelQuery.ParamByName('IDDoc').asinteger := IDDoc;
      data.RMPBase.StartTransaction;
       qDelQuery.ExecSQL;
      data.RMPBase.Commit;


   end;


   qFormQuery.close;
   qFormQuery.open;

end;

{
   Процедура изменения перида журнала
}
procedure TJR_PLANFACTForm.PeriodBoxChange(Sender: TObject);
begin
  if messagedlg('Установить период просмотра на ' + periodbox.Items[PeriodBox.ItemIndex] + ' ?',
    mtConfirmation, [mbYes, mbNo], 0) = mrNo then
     begin
       PeriodBox.ItemIndex := Period;
       abort;

     end;
{
 // проверка на правильность смены периода
  if Period > PeriodBox.ItemIndex then   // установка прошлого периода

    if messagedlg('Устанавливается закрытый период Продолжить?',
                 mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      begin
          PeriodBox.ItemIndex := Period;
          abort;

      end;
}

  {
     если устанавливается режим просмотра закрытого периода,
     то запретим редактирование
  }
  if ((FormType = 1) and (PeriodBox.ItemIndex < Param_Form.BoxPlanPeriod.ItemIndex))
     or
     ((FormType = 2) and (PeriodBox.ItemIndex < Param_Form.BoxFactPeriod.ItemIndex))
        then
        begin
           ToolButtonAdd.Enabled := false;
           ToolButtonDel.Enabled := false;
           planButton.Enabled:= false;
        end

   else

     begin
           ToolButtonAdd.Enabled := true;
           ToolButtonDel.Enabled := true;
           planButton.Enabled:= true;
     end;


  qFormQuery.close;
  qFormQuery.ParamByName('Period').asinteger := PeriodBox.ItemIndex;
  qFormQuery.open;
  Period := PeriodBox.ItemIndex;



end;

procedure TJR_PLANFACTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

    if formtype = 1 then
     SetColumnList('BROWSE_PLAN_PROC', FormGrid, qFormQuery, filterstring)
     else
       SetColumnList('BROWSE_PROD_PROC', FormGrid, qFormQuery, filterstring);

  if Formtype = 1 then
     mainForm.JR_PLAN_MAIN := nil
  else
     mainForm.JR_PROD_MAIN := nil;

  action := caFree;
end;

{
      Процедура формирования плана журнала


}
{

      Процедура формирования плана журнала


}
procedure TJR_PLANFACTForm.PlanButtonClick(Sender: TObject);
var Form : TPlanningForm;
    Need_clear : integer;
    i : integer;
begin


  Form := TPlanningForm.create(self);

  // проверка прав доступа
  Form.OKButton.Enabled := check_user_grand(uppercase(TableName), 'I', false);


//  Need_clear := 1;  // по умолчанию

  // Если есть необходимость очистки текущего журнала заказов
  if messagedlg('Удалить заказы в текущем плане?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     Need_clear := 1
   else
     Need_clear := 0;



  if Form.showmodal = mrOK then
    begin

      if ((Form.qPDRQuery.active) and (Form.qPDRQuery.FieldByName('ID').asinteger = 0)) and (Need_clear = 1) then
        if messagedlg('Подтверждаете полную очистку текущего периода планового журнала заказов?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
          Need_clear := 1
         else
           Need_clear := 0;



      // в глобальных массивах формы находятся ID заказов, которые необходимо внести
      // в план
      for i := 1 to Form.size do

         begin
            if Form.aIDarray[ i ] > 0 then
              begin

               // Вызов хранимой для заполнения плана журнала заказов
               // Хранимая процедура CREATE_PLAN проверяет совпадения заказов
               // в текущем периоде журнала заказов и заполняет период журнала.

               with CreatePlan_Proc do
                begin
                   // ID заказа
                   ParamByName('ID_ORDER').asinteger := Form.aIDarray[ i ];
                   // ID подразделения, необходимо для очистки журнала плана
                   // по текущему периоду по текущему подразделению. Если параметр не
                   // задан, то будет очищен весь журнал текущего периода
                   //
                   if Form.qPDRQuery.Active then
                      ParamByName('ID_PDR').asinteger := Form.qPDRQuery.FieldByName('ID').asinteger
                   else
                      ParamByName('ID_PDR').clear;

                   // Период
                   ParamByName('PERIOD').asinteger  := period;

                   // Признак очистки периода при дублировании записей
                   ParamByName('CLEAR_PERIOD').asinteger  := Need_clear;


                end;

               // Выполнение процедуры
               CreatePlan_Proc.ExecProc;

               Need_clear := 0;

              end;
         end;

      // обновление запроса формы
      refreshquery(qFormQuery);
    end;

    Form.Close;



end;

{
*************************************************************

       Процедуры смены периода журнала

*************************************************************

  Процедура смены периода планового периода
  Описание: производит смену периода планового журнала.

}

procedure TJR_PLANFACTForm.changePlanPeriod;

begin
//
 if messagedlg('Сменить период планового журнала на ' + periodbox.Items[PeriodBox.ItemIndex+1] + '?',
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin

       // проверим текущий период журнала
       if period < param_form.BoxPlanPeriod.ItemIndex then
        showMessage('Текущий период планового журнала ' +
               param_form.BoxFactPeriod.Items[param_form.BoxFactPeriod.ItemIndex] +
               ' Установите период просмотра в журнале на текущий (' +
               param_form.BoxPlanPeriod.Items[param_form.BoxPlanPeriod.ItemIndex] + ') ' +
               'и повторите процедуру.')


       else

         begin

          // начало транзакции
          data.RMPBase.StartTransaction;

          try

                // выполнение хранимой процедуры по смене периода
                Proc_change_period_plan.ParamByName('Period').asinteger    := PeriodBox.ItemIndex;
                Proc_change_period_plan.ParamByName('New_Period').asinteger := PeriodBox.ItemIndex + 1;
                proc_change_period_plan.ExecProc;

                Period := PeriodBox.ItemIndex + 1;

                PeriodBox.ItemIndex := PeriodBox.ItemIndex + 1;

                // в форме параметров меняется период журнала
                param_form.BoxplanPeriod.ItemIndex := period;
                param_form.CurplanPeriod           := period;

                data.RMPBase.Commit;


           except


                Data.RMPBase.Rollback; {on failure, undo the changes};
                raise; {raise the exception to prevent a call to CommitUpdates!}


           end;

         // обновление формы
         qFormQuery.close;
         qFormQuery.ParamByName('Period').asinteger := Period;
         qFormQuery.open;


         end;

     end;


end;

{
   Процедура смены периода производственного журнала
   Описание: производит смену периода производственного журнала
   При этом незавершенные заказы прошлого периода автоматически
   попадают в журнал текущего периода
}
procedure TJR_PLANFACTForm.changeFactPeriod;

begin
//
 if messagedlg('Сменить период производственного журнала на ' + periodbox.Items[PeriodBox.ItemIndex+1] + '?',
                 mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     begin

       // проверим текущий период журнала
       if period < param_form.BoxFactPeriod.ItemIndex then
        showMessage('Текущий период производственного журнала ' +
               param_form.BoxFactPeriod.Items[param_form.BoxFactPeriod.ItemIndex] +
               ' Установите период просмотра в журнале на текущий (' +
               param_form.BoxFactPeriod.Items[param_form.BoxFactPeriod.ItemIndex] + ') ' +
               'и повторите процедуру.')


       else

         begin

          // начало транзакции
          data.RMPBase.StartTransaction;

          try

                // выполнение хранимой процедуры по смене периода
                Proc_change_period_prod.ParamByName('Period').asinteger    := PeriodBox.ItemIndex;
                Proc_change_period_prod.ParamByName('New_Period').asinteger := PeriodBox.ItemIndex + 1;
                proc_change_period_prod.ExecProc;

                Period := PeriodBox.ItemIndex + 1;

                PeriodBox.ItemIndex := PeriodBox.ItemIndex + 1;

                // в форме параметров меняется период журнала
                param_form.BoxFactPeriod.ItemIndex := period;
                param_form.CurFactPeriod           := period;

                data.RMPBase.Commit;


           except


                Data.RMPBase.Rollback; {on failure, undo the changes};
                raise; {raise the exception to prevent a call to CommitUpdates!}


           end;

         // обновление формы
         qFormQuery.close;
         qFormQuery.ParamByName('Period').asinteger := Period;
         qFormQuery.open;


         end;

     end;


end;
{
   Процедура нажатия кнопки смены журнала.
   Она одна на плановый и производственный журнал

}

procedure TJR_PLANFACTForm.ChangePeriodClick(Sender: TObject);
begin

  if FormType = 1 then // смена периода планового журнала

    changePlanPeriod

  else                 // смена периода производственного журнала

    changeFactPeriod;

  param_form.SetMainForm;
  
end;
{

    Проверка, какая кнопка была нажата в форме

}

procedure TJR_PLANFACTForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_ESCAPE then
   begin
     EscPressed := True;
     abort;
     
   end;

end;

procedure TJR_PLANFACTForm.FormGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    45 : ToolButtonAddClick(sender); // нажата кнопка "Ins"
    46 : ToolButtonDelClick(sender); // нажата кнопка "Del"
    13 : ToolButtonEditClick(sender);  // Редактирование по Enter
  end;

end;
{


    Установка фильтра для просмотра журнала


}
procedure TJR_PLANFACTForm.ToolButtonFilterClick(Sender: TObject);
var FilterForm : TFilterForm;
    sText      : string;       // текст запроса
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
      sText := sQueryText;
      // если есть отбор по подразделениям
      if (FilterForm.PDRCombo.text <> '') and (FilterForm.qPDRQuery.active) then
        begin
          sText := sText +
             ' and a.id_pdr = ' + FilterForm.qPDRQuery.fieldbyname('id').asstring;
          filtered := 1;
          ID_PDR_FILTER := FilterForm.id_pdr;
        end

       else
         ID_PDR_FILTER := -1;

      // если есть отбор по признаку выполнения
      if FilterForm.pr_exec <> 0 then

        begin

           sText := sText +
             ' and a.pr_exec = ' + inttostr(FilterForm.pr_exec);
           filtered := 1;
           PR_EXEC_FILTER := FilterForm.Pr_exec;

        end

       else
         PR_EXEC_FILTER := -1;

       // закрытие запроса
       with qFormQuery do
        begin

           close;

          ParamByName('Period').asinteger := Period;
          ParamByName('ID_PDR_FILTER').asinteger  := ID_PDR_FILTER;
          ParamByName('PR_EXEC_FILTER').asinteger := PR_EXEC_FILTER;


          // открытие запроса
          Open;
         
        end;

    end

   else
     // отключение отбора
     begin

       // закрытие запроса
       with qFormQuery do
         begin
           close;
           ParamByName('Period').asinteger := Period;
           ParamByName('ID_PDR_FILTER').asinteger  := -1;
           ParamByName('PR_EXEC_FILTER').asinteger := -1;

           // открытие запроса
           Open;

         end;


     end;

     
   if filtered = 1 then
     ToolButtonFilter.Down := true
   else
     ToolButtonFilter.Down := false;

end;
{

    Процедура установки сортировки таблицы

    Вход: направление сортировки


}
procedure TJR_PLANFACTForm.sort_table(type_of_sort: integer);
var strord : string;
begin

   case type_of_sort of

     0 : strord :=  'order by number';
     1 : strord :=  'order by date_in';
     2 : strord :=  'order by date_out';
     3 : strord :=  'order by name_pdr';
   end;

      with qFormQuery do
         begin

           sql.clear;
           sql.add('select * from BROWSE_PLAN_PROC(:period, :ID_PDR_FILTER, :PR_EXEC_FILTER)');

           ParamByName('Period').asinteger := Period;
           ParamByName('ID_PDR_FILTER').asinteger  := -1;
           ParamByName('PR_EXEC_FILTER').asinteger := -1;
           sql.add(strord);
           open;

         end;


end;



procedure TJR_PLANFACTForm.FormGridTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  sort_table(aCol);

  FormGrid.Columns[aCol].Title.SortMarker := smDownEh;

end;

//******************* TJR_PLANFACTForm.MakeRS_MTR_DOCSClick *************************
//
//Вход:
//Выход:
//Описание: Вызывает процедуру формирования расходных документов
// на основании планового журнала текущего периода.
procedure TJR_PLANFACTForm.MakeRS_MTR_DOCSClick(Sender: TObject);
var Form : TPROC_MTR_PLANForm;

begin
   Form := TPROC_MTR_PLANForm.create(self);
   Form.Period := PeriodBox.ItemIndex;
   Form.SelectMTR(PeriodBox.ItemIndex);
   Form.show;


end;


procedure TJR_PLANFACTForm.SearchkeyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
   begin
     if not qFormQuery.eof then qFormQuery.next;
       find(qFormQuery, FormGrid, Searchkey.text, 1);
       FormGrid.SetFocus;
   end;

end;

procedure TJR_PLANFACTForm.FindButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not qFormQuery.eof then qFormQuery.next;
    find(qFormQuery, FormGrid, Searchkey.text, 1);

end;

procedure TJR_PLANFACTForm.MainMenuByWidClick(Sender: TObject);
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

procedure TJR_PLANFACTForm.N5Click(Sender: TObject);
begin
  qFormQuery.close;
  qFormQuery.open;
end;
{
   Процедура поиска по подстроке вниз
}
procedure TJR_PLANFACTForm.ToolButton1Click(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not qFormQuery.eof then qFormQuery.next;
    find(qFormQuery, FormGrid, Searchkey.text, 1);

end;

procedure TJR_PLANFACTForm.ToolButton3Click(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not qFormQuery.bof then qFormQuery.prior;
    find(qFormQuery, FormGrid, Searchkey.text, -1);

end;

{-----------------------------------------------------------------------------
  Procedure: TJR_PLANFACTForm.MenuClearAllClick
  Author:    admin
  Date:      18-апр-2005
  Arguments: Sender: TObject
  Result:    None
   Очищает весь текущий период журнала заказов
-----------------------------------------------------------------------------}

procedure TJR_PLANFACTForm.MenuClearAllClick(Sender: TObject);
begin
   // проверка прав доступа
  if not check_user_grand(uppercase(TableName), 'D', true) then exit;


  if  qFormQuery.eof then exit;

  if messagedlg('Удалить заказы в текущем периоде?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

   begin

    IDDoc  := qFormQuery.FieldByName('ID').AsInteger;

    if not qFormQuery.Eof then
      qFormQuery.Prior;

    qDelQuery.SQL.clear;

    if FormType = 1 then
     begin

      qDelQuery.SQL.Add('delete from jr_plan');
      qDelQuery.SQL.Add('where Period = :Period');
      qDelQuery.ParamByName('Period').asinteger := Period;

      try
        data.RMPBase.StartTransaction;
        qDelQuery.ExecSQL;
        data.RMPBase.Commit;
      except
        data.RMPBase.Rollback;
      end;

    end;

   end;

end;

procedure TJR_PLANFACTForm.ColumnSet(Sender: TObject);
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


procedure TJR_PLANFACTForm.N11Click(Sender: TObject);
begin
  if qFormQuery.FieldByName('PR_EXEC').AsInteger < 3 then
    begin
      MessageDlg('Заказ еще не выполнен!', mtWarning, [mbOK], 0);
      exit;
    end;


   if MessageDlg('Отредактировать данные чертежа по фактическим '+#13+#10+'операциям заказа?',
    mtWarning, [mbOK,mbCancel], 0) = mrCancel then exit;

 try
   data.RMPBase.StartTransaction;
   data.AddCHRTStoredProc.ParamByName('ID_ORDER').asinteger :=
      qFormQuery.FieldByName('id').AsInteger;

   data.AddCHRTStoredProc.Prepare;
   data.AddCHRTStoredProc.ExecProc;

   data.RMPBase.Commit;

 except
   data.RMPBase.Rollback;

 end;

end;

end.
