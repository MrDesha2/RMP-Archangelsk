{


    Модуль OROPEditForm операции заказа.
    Модуль вызывается только из документа "Заказ".
    Предназначен для редактирования как плановых так и
    фактических операций заказа, а так же для редактирования
    нормативной плановой себестоимости выполненной операции.



}
unit OROPEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolEdit, CurrEdit, Mask, StdCtrls, RXSpin, RXDBCtrl, ExtCtrls, Db,
  DBTables, OrderEditForm, Grids, ComCtrls, ToolWin, strutils, math;

type


  TDOCT_OPERForm = class(TForm)
    PanelButton: TPanel;
    CancelButton: TButton;
    OKButton: TButton;
    qVOPQuery: TQuery;
    qWRKRQuery1: TQuery;
    qEQPTQuery: TQuery;
    PageControl: TPageControl;
    TabSheet_Oper: TTabSheet;
    TabSheet_calc: TTabSheet;
    PanelFact: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DateBEG: TDateEdit;
    DateEND: TDateEdit;
    WRKRCombo: TComboEdit;
    EQPTCombo: TComboEdit;
    PanelMain: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    RatingEdit: TRxSpinEdit;
    NumberEdit: TMaskEdit;
    PriceEdit: TCurrencyEdit;
    VOPCombo: TComboEdit;
    NTimeEdit: TCurrencyEdit;
    CalcButton: TButton;
    Panel2: TPanel;
    GroupBoxCalc: TGroupBox;
    ToolBarCalc: TToolBar;
    ButtonAddCalc: TToolButton;
    ButtonEditCalc: TToolButton;
    ButtonDelCalc: TToolButton;
    GridCalc: TStringGrid;
    Panel1: TPanel;
    CalcINFO: TLabel;
    SplitterCalc: TSplitter;
    ButtonCaclUp: TToolButton;
    ButtonCaclDown: TToolButton;
    TabSheet_MTR: TTabSheet;
    GridFactMtr: TStringGrid;
    ToolBarMtFt: TToolBar;
    ButtonAddFactMt: TToolButton;
    ButtonEditFactMt: TToolButton;
    ButtonDelFactMt: TToolButton;
    ButtonUpFactMt: TToolButton;
    ButtonDownFactMt: TToolButton;
    Button_Calc: TButton;
    LabelCalcInfo: TLabel;
    TimeBEG: TDateTimePicker;
    TimeEND: TDateTimePicker;
    TabSheet1: TTabSheet;
    ToolBar1: TToolBar;
    ToolButtonAddEQPT: TToolButton;
    ToolButtonEditEQPT: TToolButton;
    ToolButtonDelEQPT: TToolButton;
    ButtonUpFactEQPT: TToolButton;
    ButtonDownFactEQPT: TToolButton;
    GridFactEQPT: TStringGrid;
    qWRKRQuery: TQuery;
    TabSheet_Transport: TTabSheet;
    ToolBar2: TToolBar;
    ToolButtonAddTransport: TToolButton;
    ToolButtonEditTransport: TToolButton;
    ToolButtonDelTransport: TToolButton;
    ButtonUpFactTransport: TToolButton;
    ButtonDownFactTransport: TToolButton;
    GridFactTransport: TStringGrid;
    LabelOper: TLabel;
    QueryOper: TQuery;
    ButtonOrder: TButton;
    procedure VOPComboButtonClick(Sender: TObject);
    procedure WRKRComboButtonClick(Sender: TObject);
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AnyChange(Sender: TObject);
    procedure WasChanges;
    procedure VOPComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WRKRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CalcButtonClick(Sender: TObject);
    function Save: boolean;
    procedure ButtonAddCalcClick(Sender: TObject);
    procedure ButtonEditCalcClick(Sender: TObject);
    procedure ButtonDelCalcClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button_CalcClick(Sender: TObject);
    procedure GridCalcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fill_count_table;
    procedure ButtonCaclUpClick(Sender: TObject);
    procedure ButtonCaclDownClick(Sender: TObject);
    procedure GridFactMtrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonAddFactMtClick(Sender: TObject);
    procedure ButtonEditFactMtClick(Sender: TObject);
    procedure ButtonDelFactMtClick(Sender: TObject);
    procedure ButtonUpFactMtClick(Sender: TObject);
    procedure ButtonDownFactMtClick(Sender: TObject);
    procedure NTimeEditExit(Sender: TObject);
    procedure NTimeEditChange(Sender: TObject);
    procedure ToolButtonAddEQPTClick(Sender: TObject);
    procedure ToolButtonEditEQPTClick(Sender: TObject);
    procedure ToolButtonDelEQPTClick(Sender: TObject);
    procedure ButtonUpFactEQPTClick(Sender: TObject);
    procedure ButtonDownFactEQPTClick(Sender: TObject);
    procedure GridFactEQPTKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonAddTRANSPORTClick(Sender: TObject);
    procedure ToolButtonEditTRANSPORTClick(Sender: TObject);
    procedure ToolButtonDelTRANSPORTClick(Sender: TObject);
    procedure ButtonUpFactTRANSPORTClick(Sender: TObject);
    procedure ToolButtonDownFactTRASNPORTClick(Sender: TObject);
    procedure GridFactTransportKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonOrderClick(Sender: TObject);
  private
    { Private declarations }
  public
    IDDoc    : integer;            // ID документа (добавлено 3.11.05)
    aOperation   : pOperation;
    constructor createN(AOwner: TDOC_ORDERForm; _TypeEdit: integer; docID : integer);  //docID : integer; (добавлено 3.11.05)
    destructor  Destroy; override;
  end;

var
  DOCT_OPERForm: TDOCT_OPERForm;
  FormType     : integer;   // тип редактирования формы: 1 - добавление, 2 - редактирование
  TableName    : string;    // имя таблицы редактирования
  EnumEdit     : TForm;     // Форма списка справочника
  FormCaption  : string;    // Заголовок формы
  EnumName     : string;    // наименование справочника
  WasAnyChanges: boolean;   // признак изменения формы
  ORDER_Form   : TDOC_ORDERForm;

  lCalcs       : tList;

implementation

uses Base,
          Libs,
ORCALCEditForm,           // форма редактирования затрат заказа
  OrderEditLibs,          // библиотека функций редактирования заказа
  ORMTREditForm,          // форма редактирования материала
  EnumForm4Sel,
  OREQPTEditForm,
  ORTransportEditForm,
  AddExecuter_Form,       // Добавлено (3.11.05);
  ParamForm,              // Добавлено (3.11.05);
  OrderOperForm;          // Добавлено (3.11.16);

{$R *.DFM}



{

    Процедура заполнения таблицы затрат операции по глобальной таблице.
    Вход: номер строки операции заказа
    Выход: заполненная визуальная таблица затрат в форме

}
procedure TDOCT_OPERForm.fill_count_table;
var i: integer;
    row : integer;
    GetCalcInfo: string;
    aCalculate : pCalculation;
begin

   row := 1;
   GridCalc.Rows[1].clear;

   if lCalcs <> nil then
    for i := 0 to lCalcs.Count - 1 do
      begin
         aCalculate := lCalcs.Items[i];
         aCalculate^.Lineno := i + 1;

         GridCalc.Cells[1, row] := inttostr(aCalculate^.lineno);  // номер строки
         GridCalc.Cells[2, row] := aCalculate^.Name_calc;         // наименование статьи затрат
         GridCalc.Cells[3, row] := formatfloat('0.00', aCalculate^.nvalue);// значение

         if i = (lCalcs.Count - 1) then
            begin
               GetCalcInfo := GridCalc.Cells[2, row] + ' ' + GridCalc.Cells[3, row];
               if aCalculate^.nvalue = 0 then
                 LabelCalcInfo.font.color := clRed
               else
                 LabelCalcInfo.font.color := clGray;

            end;

         row := row + 1;

     end;

   if row > 1 then
     GridCalc.RowCount := row

    else
      GridCalc.RowCount := 2;

   CalcINFO.caption := 'Количество по факту ' + ORDER_Form.number_f.text + ';';
   LabelCalcInfo.Caption := GetCalcInfo;


end;


{
  Генератор создания формы редактирования операций заказа
  Вход:
    компонент-владелец формы;
    тип редактирования: 1 - добавление плановой операции,
                        2 - редактирование существующей плановой операции,
                        3 - добавление фактической операции,
                        4 - редактирование существующей фактической операции,
}
constructor TDOCT_OPERForm.createN(AOwner: TDOC_ORDERForm; _TypeEdit: integer; docID : integer);  //docID : integer; (добавлено 3.11.05)
var row : integer;  // номер строки таблицы

begin
  inherited Create(AOwner);
  Order_form := AOwner;
  // если это добавление элемента
  FormType := _typeEdit;

  IDDoc := docID;

  ButtonOrder.Enabled := False;

//  // видимость закладки затрат
  if _TypeEdit < 3 then
    begin
       PageControl.Pages[1].TabVisible := false;    
       Button_Calc.Visible := false;
       TableName := 'DT_ORDER1';
     end
    else
      TableName := 'DT_ORDER2'; 

  lMaterials := tList.Create;
  lCalcs     := tList.Create;

  case _TypeEdit of  // добавление плановых операций
     1 :
         begin
           new(aOperation);
           aOperation^.lMaterials := nil;
           aOperation^.lCalcs     := nil;
           aOperation^.lEQPTs     := nil;
           aOperation^.lTransports     := nil;

           NumberEdit.text := '1';
           NTimeEdit.text  := '0';
           RatingEdit.text := '1';
           PriceEdit.text  := '0';
           VOPCombo.ID     := -1;
           timebeg.time := 0;
           timeend.time := 0;
//           PanelFact.Visible := false;       //коментарий от 28.07.04

          WRKRCombo.ID := -1;
          EQPTCombo.ID := -1;

           // нахождение максимального номера строки
           if Order_form.Grid_OperPlan.cells[1, 1] <> '' then
            NumberEdit.text := inttostr(Order_form.Grid_OperPlan.rowCount)
           else
            NumberEdit.text := '1';

           // признак изменения записи
           WasAnyChanges := true;
           EnumName      := 'Плановые операции заказа: ';
           FormCaption   := 'новая';
         end;

   // это редактирование плановых операций
    2 : begin
          row := Order_form.Grid_OperPlan.row;

          aOperation := Order_form.lPlanOperations.Items[row - 1];

          // заполнение полей на основании таблицы плановых операций заказа
          VOPCombo.ID := aOperation^.ID_op;

          text := aOperation^.Name_op;

          {***********************коментарий от 28.07.04***********************}

          DateBeg.text     := aOperation^.Date_beg; // дата начала
          DateEnd.text     := aOperation^.Date_end; // дата окончания

          // заполнение параметров для запроса по Работнику
          WRKRCombo.ID := aOperation^.ID_worker;

          EQPTCombo.ID := aOperation^.ID_eqpt; // оборудование
          {********************************************************************}
                                                                           
          NTimeEdit.value  := aOperation^.timework;           // продолжительность
          ratingEdit.text  := inttostr(aOperation^.rayting);  // разряд рабочего
          PriceEdit.text   := FormatFloat( '0.00', aOperation^.price);  // стоимость

          if (trim(aOperation^.time_beg) <> '') and (trim(aOperation^.time_beg) <> ':')
            then
            TimeBeg.time     := strtotime(aOperation^.time_beg) // время начала
            else
              TimeBeg.time := 0;

          if  (trim(aOperation^.time_end) <> '') and (trim(aOperation^.time_end) <> ':')
            then
            TimeEnd.time     := strtotime(aOperation^.time_end) // время окончания
            else
              TimeEnd.time := 0;

          // остальные реквизиты
          NumberEdit.text  := inttostr(aOperation^.lineno);   // номер строки
          NTimeEdit.value  := aOperation^.timework; // продолжительность
          ratingEdit.text  := inttostr(aOperation^.rayting);  // разряд рабочего
          PriceEdit.text   := FormatFloat( '0.00', aOperation^.price);    // стоимость

//          PanelFact.Visible:= false;   //коментарий от 28.07.04
          WasAnyChanges    := false;
          EnumName         := 'Плановые операции заказа: ';
          FormCaption      := VOPCombo.text;
       end;
   3 : begin // добавление фактических операций
           new(aOperation);
           aOperation^.lMaterials := nil;
           aOperation^.lCalcs     := nil;
           aOperation^.lEQPTs     := nil;
           aOperation^.lTransports:= nil;

           NumberEdit.text := '1';
           NTimeEdit.text  := '0';
           RatingEdit.text := '1';
           PriceEdit.text  := '0';
           timebeg.time := 0;
           timeend.time := 0;

           WRKRCombo.ID := -1;

           EQPTCombo.ID := -1;

           // нахождение максимального номера строки
           if Order_form.Grid_OperFact.cells[1, 1] <> '' then
            NumberEdit.text := inttostr(Order_form.Grid_OperFact.rowCount)
           else
            NumberEdit.text := '1';
           // для фактических операций добавляется новая панель
           PanelFact.Visible := true;
           // признак изменения записи активен
           WasAnyChanges     := true;
           EnumName          := 'Фактические операции заказа: ';
           FormCaption       := 'новая';


       end;
     4 : begin   // работа с редактрованием фактических операций
          row := Order_form.Grid_OperFact.row;

          aOperation := Order_form.lFactOperations.Items[row - 1];

          // заполнение полей
          NumberEdit.text  := inttostr(aOperation^.lineno);   // номер строки
          // заполнение поля "Вид операции"
          VOPCombo.ID      := aOperation^.ID_op;

          DateBeg.text     := aOperation^.Date_beg; // дата начала
          DateEnd.text     := aOperation^.Date_end; // дата окончания

          WRKRCombo.ID     := aOperation^.ID_worker; // работник
          EQPTCombo.ID     := aOperation^.ID_eqpt; // оборудование

          NTimeEdit.value  := aOperation^.timework;           // продолжительность
          ratingEdit.text  := inttostr(aOperation^.rayting);  // разряд рабочего
          PriceEdit.text   := FormatFloat( '0.00', aOperation^.price);  // стоимость

          if  (trim(aOperation^.time_beg) <> '') and (trim(aOperation^.time_beg) <> ':')
              then
            TimeBeg.Time     := strtotime(aOperation^.time_beg) // время начала
            else
              TimeBeg.Time     := 0;

          if (trim(aOperation^.time_end) <> '') and (trim(aOperation^.time_end) <> ':')
             then
            TimeEnd.Time     := strtotime(aOperation^.time_end) // время окончания
            else
             TimeEnd.Time     := 0;
             

          PanelFact.Visible:= true;
          WasAnyChanges    := false;
          EnumName         := 'Фактические операции заказа: ';
          FormCaption      := VOPCombo.text;

          lCalcs :=  aOperation^.lCalcs;

          // заполнение таблицы затрат
          fill_count_table;

       end;
     end;

          MakeSelectMTR(GridFactMtr, aOperation^.lMaterials, nil, false);
          MakeSelectEQPT(GridFactEQPT, aOperation^.lEQPTs, nil, false);
          MakeSelectTransport(GridFactTransport, aOperation^.lTransports, nil, false);



     
     caption := EnumName + FormCaption;

end;

destructor TDOCT_OPERForm.Destroy;
begin
  inherited;

end;
{
  Процедура выбора из справочника "Виды операций"
}
procedure TDOCT_OPERForm.VOPComboButtonClick(Sender: TObject);
begin
  SelectFromTable(VOPCombo);

end;
{
    Процедура заполнения поля Работник
}
procedure TDOCT_OPERForm.WRKRComboButtonClick(Sender: TObject);
Var s : String;
    OPForm1: TAddExecuterForm;
begin
   If (FormType < 3) Then  //Добавление или редактирование плановой операции
   begin
      qWrkrQuery.ParamByName('ID_ORDER').AsInteger := IDDoc;
      qWrkrQuery.ParamByName('LINENO').AsInteger :=  Order_form.Grid_OperPlan.row;
      qWrkrQuery.ParamByName('DATE_FROM').AsDateTime := Now;
      s := DateTimeToStr(qWrkrQuery.ParamByName('DATE_FROM').AsDateTime);
      qWrkrQuery.ParamByName('DATE_TO').AsDateTime := Now+10;
      s := DateTimeToStr(qWrkrQuery.ParamByName('DATE_TO').AsDateTime);
      qWrkrQuery.ParamByName('WORK_FROM').AsDateTime := Param_Form.WorkDateTimeBeg.Time;
      s := DateTimeToStr(qWrkrQuery.ParamByName('WORK_FROM').AsDateTime);
      qWrkrQuery.ParamByName('WORK_TO').AsDateTime := Param_Form.WorkDateTimeEnd.Time;
      s := DateTimeToStr(qWrkrQuery.ParamByName('WORK_TO').AsDateTime);
      qWrkrQuery.ParamByName('DINNER_FROM').AsDateTime := Param_Form.DinnerDateTimeFrom.Time;
      s := DateTimeToStr(qWrkrQuery.ParamByName('DINNER_FROM').AsDateTime);
      qWrkrQuery.ParamByName('DINNER_TO').AsDateTime := Param_Form.DinnerDateTimeTo.Time;
      s := DateTimeToStr(qWrkrQuery.ParamByName('DINNER_TO').AsDateTime);

{  qWrkrQuery.ParamByName('ID_ORDER').AsInteger := 21990;
  qWrkrQuery.ParamByName('LINENO').AsInteger :=  2;
  qWrkrQuery.ParamByName('DATE_FROM').AsDateTime := StrToDateTime('16.11.05 13:00:00');
  qWrkrQuery.ParamByName('DATE_TO').AsDateTime := StrToDateTime('26.11.05 13:00:00');
  qWrkrQuery.ParamByName('WORK_FROM').AsDateTime := StrToDateTime('5.11.05 8:00:00');
  qWrkrQuery.ParamByName('WORK_TO').AsDateTime := StrToDateTime('5.11.05 17:00:00');
  qWrkrQuery.ParamByName('DINNER_FROM').AsDateTime := StrToDateTime('5.11.05 12:00:00');
  qWrkrQuery.ParamByName('DINNER_TO').AsDateTime := StrToDateTime('5.11.05 13:00:00');  }


 { qWrkrQuery.Close;
  qWrkrQuery.SQL.Clear;
  qWrkrQuery.SQL.Add('Select * From Spr_ediz');  }
      qWrkrQuery.Close;
      qWrkrQuery.Open;
      qWrkrQuery.RecordCount;

      If qWrkrQuery.RecordCount > 0 Then
      begin
        // открыть форму добавления исполнителя
        OPForm1 := TAddExecuterForm.CreateN(self, qWrkrQuery, WRKRCombo);
        OPForm1.Show;
      end
      else
       begin
          SelectFromTable(WRKRCombo);

          QueryOper.Close;
          QueryOper.SQL.Clear;
          QueryOper.SQL.Add('Select a.date_beg, sum(a.ntime) as ntime');
          QueryOper.SQL.Add('From dt_order1 a');
          QueryOper.SQL.Add('where a.id_wrkr = :id_wrkr and');
          QueryOper.SQL.Add('a.date_beg = (Select max(b.date_beg)');
          QueryOper.SQL.Add('From DT_Order1 b');
          QueryOper.SQL.Add('Where b.id_wrkr = :id_wrkr)');
          QueryOper.SQL.Add('Group by a.date_beg');

          QueryOper.ParambyName('id_wrkr').AsInteger := WRKRCombo.Query.fieldbyname('ID').AsInteger;

          QueryOper.Open;

          If QueryOper.RecordCount > 0 Then
          begin
              ButtonOrder.Enabled := True;
              LabelOper.font.color := clRed;
              LabelOper.Caption := 'Предыдущая операция: ' +
                                   WRKRCombo.Query.fieldbyname('NAME').AsString + '   '+
                                   QueryOper.FieldbyName('date_beg').AsString + '  '+
                                   FormatFloat('0.00',QueryOper.FieldbyName('ntime').AsInteger/1000) + ' час'; //ntime').AsInteger/1000/24
          end
            else
            begin
               ButtonOrder.Enabled := False;
               LabelOper.Caption := 'Предыдущая операция:';
               LabelOper.font.color := clGray;
            end;
       end;
   end
    else
     begin
          SelectFromTable(WRKRCombo);

        // формируем строку посленей даты работы и сумму времени в этот день
        QueryOper.Close;
        QueryOper.SQL.Clear;
        QueryOper.SQL.Add('Select a.date_beg, sum(a.ntime) as ntime');
        QueryOper.SQL.Add('From dt_order2 a');
        QueryOper.SQL.Add('where a.id_wrkr = :id_wrkr and');
        QueryOper.SQL.Add('a.date_beg = (Select max(b.date_beg)');
        QueryOper.SQL.Add('From DT_Order2 b');
        QueryOper.SQL.Add('Where b.id_wrkr = :id_wrkr)');
        QueryOper.SQL.Add('Group by a.date_beg');

        QueryOper.ParambyName('id_wrkr').AsInteger := WRKRCombo.Query.fieldbyname('ID').AsInteger;

        QueryOper.Open;

        If QueryOper.RecordCount > 0 Then
        begin
            ButtonOrder.Enabled := True;
            LabelOper.font.color := clRed;
            LabelOper.Caption := 'Предыдущая операция: ' +
                                 WRKRCombo.Query.fieldbyname('NAME').AsString + '   '+
                                 QueryOper.FieldbyName('date_beg').AsString + '  '+
                                 FormatFloat('0.00',QueryOper.FieldbyName('ntime').AsInteger/1000) + ' час';  //ntime').AsInteger/1000/24
        end
          else
          begin
             ButtonOrder.Enabled := False;
             LabelOper.Caption := 'Предыдущая операция:';
             LabelOper.font.color := clGray;
          end;
     end;
end;
{
     Процедура заполнения поля Оборудование
}
procedure TDOCT_OPERForm.EQPTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EQPTCombo);

end;

procedure TDOCT_OPERForm.CancelButtonClick(Sender: TObject);
begin
  if WasAnyChanges = true then
    if MessageDlg('Сохранить изменения?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then

          if not save then
            exit;

            
   FormStyle := fsNormal;
   ModalResult := mrCancel;


end;
{
           Процедура записи изменений
   При принятии изменений все данные записываются в таблицы в форме заказа.
   В зависимости от параметра FormType производится изменение либо таблицы
   плановых операций (1 или 2) либо таблицы фактических операций (3 - 4).

}

function TDOCT_OPERForm.Save: boolean;

begin
 result := false;

 if not check_user_grand(uppercase(tablename), 'U', false) then exit;

 result := true;

 if FormType < 3 then
  begin
    // определенеи текущией строки таблицы, если это новая запись, то
    // добавляется строка в таблицу
//    if FormType = 1 then
//      new(aOperation)
//
//    else
//      aOperation := ORDER_Form.lPlanOperations.Items[ORDER_Form.Grid_OperPlan.Row - 1];

{**************************************добавлена 28.07.04**********************}
    // определенеи текущией строки таблицы, если это новая запись, то
    // добавляется строка в таблицу
    // как ввели даты
         if  (trim(DATEBeg.text) <> '.  .') or (trim(DATEEnd.text) <> '.  .') then

           begin
             if (trim(DATEBeg.text) = '.  .') then
              begin
                showmessage('Дата начала работ указана неверно');
                result := false;
                exit;
              end;

             if (trim(DATEEnd.text) = '.  .') then
              begin
                showmessage('Дата окончания работ указана неверно');
                result := false;
                exit;
              end;

             if strToDate(DateBeg.text) > strToDate(DateEnd.text) then
             begin
                showmessage('Дата окончания работ позже даты начала!!!');
                result := false;
                exit;
             end;

             if (DATEBeg.text = DATEEnd.text)  Then
             begin
                if (TimeBeg.time = 0) or (TimeEnd.time = 0) Then
                begin
                   showmessage('Время начала или окончания работ пропущено!!!');
                   result := false;
                   exit;
                end;

                if (TimeBeg.time > TimeEnd.time)  Then
                begin
                   showmessage('Время окончания работ раньше времени начала!!!');
                   result := false;
                   exit;
                end;
             end;

             if strToDate(DateBeg.text) < strToDate(DateEnd.text) then
             begin
                if (TimeBeg.time = 0) or (TimeEnd.time = 0) Then
                begin
                   showmessage('Время начала или окончания работ пропущено!!!');
                   result := false;
                   exit;
                end;
             end;

             aOperation^.Date_beg := dateToStr(StrTodate(DATEBeg.text));     // дата начала
             aOperation^.Date_end := dateToStr(StrTodate(DATEEnd.text));     // дата окончания
           end
         else
            begin
              aOperation^.Date_beg := '';
              aOperation^.Date_end := '';


            end;


    if (VOPCombo.ID = -1) then
        begin
          showmessage('Не проставлена операция...');
          result := false;
          exit;
        end;


    // установка значений в таблицу
    aOperation^.lineno  := strtoint(trim(NumberEdit.text));
    aOperation^.Name_op := VOPCombo.text;
    aOperation^.rayting := strtoint(trim(RatingEdit.text));
    aOperation^.timework:= NTimeEdit.value;
    aOperation^.price   := PriceEdit.value;
    aOperation^.ID_op   := VOPCombo.ID;


{**************************************добавлена 28.07.04**********************}
    aOperation^.Name_worker := WRKRCombo.text;     // ФИО работника
    aOperation^.Name_eqpt   := EQPTCombo.text;     // Название станка
    aOperation^.ID_worker   := WRKRCombo.ID;
    aOperation^.ID_eqpt     := EQPTCombo.ID;

     // остальная информация добавляется в хвост таблицы. она не будет видна на экране.
    aOperation^.rayting  := strtoint(trim(RatingEdit.text));          // разряд рабочего
    aOperation^.time_beg := timetostr(TimeBeg.time);    // время начала
    aOperation^.time_end := timetostr(TimeEnd.time);    // время окончания
{******************************************************************************}

    if FormType = 1 then
       ORDER_Form.lPlanOperations.add(aOperation);


   end



 else   // ввод фактических операций



    begin

    // определенеи текущией строки таблицы, если это новая запись, то
    // добавляется строка в таблицу
    // как ввели даты
         if (trim(DATEBeg.text) <> '.  .')  Then
//            and (trim(DATEEnd.text) <> '.  .') then          //2017 просили сохранять факт без даты окончания операции
           begin

             If (trim(DATEEnd.text) <> '.  .') Then            //2017 просили сохранять факт без даты окончания операции
                if strToDate(DateBeg.text) > strToDate(DateEnd.text) then
                begin
                   showmessage('Дата окончания работ позже даты начала!!!');
                   result := false;
                   exit;
                end;


             aOperation^.Date_beg := dateToStr(StrTodate(DATEBeg.text));     // дата начала
             If (trim(DATEEnd.text) <> '.  .') Then            //2017 просили сохранять факт без даты окончания операции
                aOperation^.Date_end := dateToStr(StrTodate(DATEEnd.text))     // дата окончания
              else aOperation^.Date_end := '.  .';             //2017 просили сохранять факт без даты окончания операции

             If (trim(DATEEnd.text) <> '.  .') Then            //2017 просили сохранять факт без даты окончания операции
                if (DATEBeg.text = DATEEnd.text)  Then
                begin
                   if (TimeBeg.time = 0) or (TimeEnd.time = 0) Then
                   begin
                      showmessage('Время начала или окончания работ пропущено!!!');
                      result := false;
                      exit;
                   end;

                   if (TimeBeg.time > TimeEnd.time)  Then
                   begin
                      showmessage('Время окончания работ раньше времени начала!!!');
                      result := false;
                      exit;
                   end;

                 aOperation^.time_beg := timetostr(TimeBeg.time);    // время начала
//                 If (trim(DATEEnd.text) <> '.  .') Then            //2017 просили сохранять факт без даты окончания операции
                    aOperation^.time_end := timetostr(TimeEnd.time);    // время окончания

                end;

           end
         else
            begin
              showmessage('Даты указаны не верно!');
              result := false;
              exit;

            end;

     // Вид операции
     if (VOPCombo.ID = -1)then
        begin
          showmessage('Не проставлена операция...');
          result := false;
          exit;
        end;

     // проверка исполнителя
     if (WRKRCombo.ID = -1) then
        begin
          showmessage('Не проставлен исполнитель...');
          result := false;
          exit;
        end;

     // оборудование
     if (EQPTCombo.ID = -1) then
       begin
         showmessage('Не проставлено оборудование...');
       //  exit;
       end;


     // установка значений в таблицу фактических операций
     aOperation^.lineno := strtoint(trim(NumberEdit.text));  // номер строки
     aOperation^.Name_op:= VOPCombo.text;    // название операции



     If (trim(DATEEnd.text) <> '.  .') Then            //2017 просили сохранять факт без даты окончания операции
        if strToDate(DateBeg.text) > strToDate(DateEnd.text) then
         begin
            showmessage('Дата окончания работ позже даты начала!!!');
            result := false;
            exit;

         end;



     aOperation^.Name_worker := WRKRCombo.text;     // ФИО работника
     aOperation^.Name_eqpt   := EQPTCombo.text;     // Название станка
     aOperation^.price    := PriceEdit.value;       // стоимость
     aOperation^.timework := NTimeEdit.value;       // продолжительность
     aOperation^.ID_op    := VOPCombo.ID;
     aOperation^.ID_worker:= WRKRCombo.ID;
     aOperation^.ID_eqpt  := EQPTCombo.ID;

     // остальная информация добавляется в хвост таблицы. она не будет видна на экране.
     aOperation^.rayting  := strtoint(trim(RatingEdit.text));          // разряд рабочего

     aOperation^.lCalcs   := lCalcs;

     // новая строка в таблице
     if (FormType = 3) then
       ORDER_Form.lFactOperations.add(aOperation);

     if lCalcs <> nil then 
      if lCalcs.count = 0 then
       begin

          MessageDlg('Затраты операции не рассчитаны.', mtWarning, [mbOK], 0);
       end;

  end;


end;



procedure TDOCT_OPERForm.OKButtonClick(Sender: TObject);
begin

  // сохранение изменений
  if Save then

     // закрываем форму редактирования
     ModalResult := mrOK;

end;

procedure TDOCT_OPERForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if lCalcs <> nil then
   lCalcs := nil;

  action := caFree;
end;

procedure TDOCT_OPERForm.AnyChange(Sender: TObject);
begin

  If DateEND.Text = '  .  .    ' Then CalcButton.Enabled := False
   else CalcButton.Enabled := True;

  WasChanges;
end;

{
  Процедура показа изменений в форме
}
procedure  TDOCT_OPERForm.WasChanges;
begin

 WasAnyChanges := true;

 if VOPCombo.text <> '' then
   FormCaption := VOPCombo.text;

 caption := EnumName + FormCaption + '*' ;
end;
{
  При нажатии кнопки на поле "Виды операций "
}
procedure TDOCT_OPERForm.VOPComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(VOPCombo, key, Shift) = false then
    VOPComboButtonClick(Sender);

end;
{
  При нажатии кнопки на поле "Работник"
}
procedure TDOCT_OPERForm.WRKRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WRKRCombo, key, Shift) = false then
    WRKRComboButtonClick(Sender);

end;
{
  При нажатии кнопки на поле "Оборудование"
}
procedure TDOCT_OPERForm.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EQPTCombo, key, Shift) = false then
    EQPTComboButtonClick(Sender);

end;


{
    Процедура рассчета стоимости операции по операции, разряду и времени
    выполнения

}
procedure TDOCT_OPERForm.CalcButtonClick(Sender: TObject);
var qSelQuery : tQuery;
    price     : real;
begin

   if (VOPCombo.ID = -1) then exit;

   // формирование запроса на нахождение стоимости единицы операции заданным разрядом
   qSelQuery := tQuery.Create(self);
   qSelQuery.databasename := 'RMP';
   qSelQuery.sql.Add('select * from spr_vop where id = ' + inttostr(qVopQuery.fieldbyname('ID').asinteger));
   qSelQuery.open;

   // стоимости операции в зависимости от введенного разряда рабочего
   case strtoint(RatingEdit.text) of
     1, 0 : price := qSelQuery.FieldByName('RANK_1').asfloat / 100;
     2 : price := qSelQuery.FieldByName('RANK_2').asfloat / 100;
     3 : price := qSelQuery.FieldByName('RANK_3').asfloat / 100;
     4 : price := qSelQuery.FieldByName('RANK_4').asfloat / 100;
     5 : price := qSelQuery.FieldByName('RANK_5').asfloat / 100;
   else
     price := qSelQuery.FieldByName('RANK_6').asfloat / 100;
   end;

   // проверка на сумму операции
   if price = 0 then
      MessageDlg('Не указана стоимость операции ' +
        VOPCombo.text
        + 'в справочнике.', mtWarning, [mbOK], 0);

   // сумма операции
   if nTimeEdit.text <> '' then
     price := price * strtofloat(nTimeEdit.text)
   else
     price := 0;

   // проверка времени выполнения операции
   if nTimeEdit.Value = 0 then
      MessageDlg('Не указано время операции.', mtWarning, [mbOK], 0);



   price := roundto(price, -2);
   PriceEdit.text := floatToStr(Price);

   // сохранение изменений

    // расчет затрат операции заказа при редактировании фактической операции
    if FormType > 2 then
     begin

       aOperation^.price  := Price;
       aOperation^.ID_op  := VOPCombo.ID;
       lCalcs := Operation_calculate(ORDER_Form, aOperation, ORDER_Form.Iddoc);
       fill_count_table;

      end;


end;

{
    Процедура добавления затрат
}

procedure TDOCT_OPERForm.ButtonAddCalcClick(Sender: TObject);
var Form :  TDOCT_CALCForm;
begin
  // проверка доступа, если нельзя редактировать операцию, то и затраты тоже
  if not check_user_grand(Tablename, 'U', true) then
    exit;


  // вызов конструктора формы редактирования затрат
  Form := TDOCT_CALCForm.createN(lCalcs, 1, GridCalc.rowCount + 1);

  Form.showmodal;

  Form.Close;

  fill_count_table;

end;

{
    Процедура редактирования затрат
}
procedure TDOCT_OPERForm.ButtonEditCalcClick(Sender: TObject);
var Form :  TDOCT_CALCForm;
begin
  // если есть что редактировать
  if lCalcs = nil then exit;
  if lCalcs.Count = 0 then exit;

  Form := TDOCT_CALCForm.createN(lCalcs, 2, GridCalc.row - 1); // вызов формы редактирования затрат

    Form.OKButton.Enabled := check_user_grand(TableName, 'U', true);

  Form.showmodal;

  Form.Close;

  fill_count_table;

end;

{
     Процедура удаления затрат
}
procedure TDOCT_OPERForm.ButtonDelCalcClick(Sender: TObject);
begin
  // проверка доступа, если нельзя редактировать операцию, то и затраты тоже
  if not check_user_grand(Tablename, 'U', true) then
    exit;

 if lCalcs <> nil then
  if lCalcs.Count > 0 then
   if messagedlg('Удалить затраты?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

      lCalcs.Delete(GridCalc.row -1);

     fill_count_table;

end;

procedure TDOCT_OPERForm.FormShow(Sender: TObject);
begin
  // таблица затрат
  GridCalc.Cells[1,0]   := 'Строка';
  GridCalc.Cells[2,0]   := 'Затраты';
  GridCalc.Cells[3,0]   := 'Величина';

  // таблица фактических материалов
  GridFactMtr.Cells[1,0]   := 'Строка';
  GridFactMtr.Cells[2,0]   := 'Материал';
  GridFactMtr.Cells[3,0]   := 'Количество';
  GridFactMtr.Cells[4,0]   := 'Стоимость';

  // таблица фактических инструментов
  GridFactEQPT.Cells[1,0]   := 'Строка';
  GridFactEQPT.Cells[2,0]   := 'Инструмент';
  GridFactEQPT.Cells[3,0]   := 'Ед.изм.';
  GridFactEQPT.Cells[4,0]   := 'Количество';

  // таблица фактических транспортных средств
  GridFactTransport.Cells[1,0]   := 'Строка';
  GridFactTransport.Cells[2,0]   := 'Транспортное средство';
  GridFactTransport.Cells[3,0]   := 'Ед.изм.';
  GridFactTransport.Cells[4,0]   := 'Кол-во (м/ч)';

  PageControl.ActivePageIndex := 0;

  If DateEND.Text = '  .  .    ' Then CalcButton.Enabled := False
   else CalcButton.Enabled := True;

end;

procedure TDOCT_OPERForm.Button_CalcClick(Sender: TObject);
begin

  aOperation^.price  := PriceEdit.value;
  lCalcs := Operation_calculate(ORDER_Form, aOperation, ORDER_Form.Iddoc);
  aOperation^.lCalcs := lCalcs;
  fill_count_table;

end;

procedure TDOCT_OPERForm.GridCalcKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelCalcClick(Sender);   // удаление записи
    45 :  ButtonAddCalcClick(Sender); // Добавление по Ins
    13 :  ButtonEditCalcClick(Sender);  // Редактирование по Enter
  end;

end;

procedure TDOCT_OPERForm.ButtonCaclUpClick(Sender: TObject);
begin

  Change_enum_list_pos(lCalcs, GridCalc.row - 1, GridCalc.row - 2);
   if GridCalc.row > 1 then GridCalc.row := GridCalc.row - 1;

  fill_count_table;

end;

procedure TDOCT_OPERForm.ButtonCaclDownClick(Sender: TObject);
begin

  Change_enum_list_pos(lCalcs, GridCalc.row - 1, GridCalc.row);
    if GridCalc.row < (GridCalc.rowcount - 1) then GridCalc.row := GridCalc.row + 1;

  fill_count_table;

end;


procedure TDOCT_OPERForm.GridFactMtrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelFactMtClick(Sender);   // удаление записи
    45 :  ButtonAddFactMtClick(Sender); // Добавление по Ins
    13 :  ButtonEditFactMtClick(Sender);  // Редактирование по Enter
  end;

end;

procedure TDOCT_OPERForm.ButtonAddFactMtClick(Sender: TObject);
var Form : TDOCT_MTRForm;
begin
  // если есть что редактировать в плановых материалах

  // вызов конструктора формы редактирования номенклатуры плановой операции
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено

  if FormType > 2 then
    if trim(dateend.text) <> '.  .' then
      if (strtodate(DateEnd.Text) + 1) < date then
        begin
          MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
          abort;
        end;

  // проверка доступа, если нельзя редактировать операцию, то и затраты тоже
  if not check_user_grand(Tablename, 'U', true) then
    exit;

  Form := TDOCT_MTRForm.createN(aOperation, 3, 0);
  Form.aOperate := aOperation;

  Form.showmodal;
      Form.Close;

   MakeSelectMTR(GridFactMtr, aOperation.lMaterials, nil, false);

end;

procedure TDOCT_OPERForm.ButtonEditFactMtClick(Sender: TObject);
var Form : TDOCT_MTRForm;

begin
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено
  if FormType > 2 then
   if trim(dateEnd.Text) <> '.  .' then
    if (strtodate(DateEnd.Text) + 1) < date then
      begin
        MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
        abort;
      end;

  // если есть что редактировать в плановых материалах
  if GridFactMTR.cells[1, 1] = '' then exit;

  // вызов конструктора формы редактирования номенклатуры плановой операции
  Form := TDOCT_MTRForm.createN(aOperation, 4, GridFactMTR.Row - 1);
  Form.aOperate := aOperation;
  // проверка доступа, если нельзя редактировать операцию, то и затраты тоже
  Form.OKButton.Enabled := check_user_grand(Tablename, 'U', true);

  Form.showmodal;

  Form.Close;

   MakeSelectMTR(GridFactMtr, aOperation^.lMaterials, nil, false);

end;

procedure TDOCT_OPERForm.ButtonDelFactMtClick(Sender: TObject);
begin
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено

  if FormType > 2 then
   if (strtodate(DateEnd.Text) + 1) < date then
    begin
      MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
      abort;
    end;

  // проверка доступа, если нельзя редактировать операцию, то и материалы тоже
  if not check_user_grand(Tablename, 'U', true) then
    exit;

   if messagedlg('Удалить материал?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

    begin

     // aOperation := Order_form.lFactOperations.Items[GridFactMTR.row - 1];
      lMaterials := aOperation^.lMaterials;

      if lMaterials <> nil then
       if lMaterials.Count > 0 then
        lMaterials.Delete(GridFactMTR.row - 1);

    end;

    MakeSelectMTR(GridFactMtr, aOperation^.lMaterials, nil, false);

end;

procedure TDOCT_OPERForm.ButtonUpFactMtClick(Sender: TObject);
begin
  aOperation := Order_form.lFactOperations.Items[Order_form.Grid_OperFact.row - 1];
  lMaterials := aOperation^.lMaterials;

  Change_enum_list_pos(lMaterials, GridFactMTR.row - 1, GridFactMTR.row - 2);
   if GridFactMTR.row > 1 then GridFactMTR.row := GridFactMTR.row - 1;

   MakeSelectMTR(GridFactMtr, aOperation^.lMaterials, nil, false);

end;

procedure TDOCT_OPERForm.ButtonDownFactMtClick(Sender: TObject);
begin
  aOperation := Order_form.lFactOperations.Items[Order_form.Grid_OperFact.row - 1];
  lMaterials := aOperation^.lMaterials;

  Change_enum_list_pos(lMaterials, GridFactMTR.row - 1, GridFactMTR.row);
   if GridFactMTR.row < (GridFactMTR.rowcount - 1) then GridFactMTR.row := GridFactMTR.row + 1;

  MakeSelectMTR(GridFactMtr, aOperation^.lMaterials, nil, false);


end;

procedure TDOCT_OPERForm.NTimeEditExit(Sender: TObject);
begin
   CalcButtonClick(sender);
end;


procedure TDOCT_OPERForm.NTimeEditChange(Sender: TObject);
begin
  aOperation.timework := NTimeEdit.value;
  AnyChange(sender);
end;

procedure TDOCT_OPERForm.ToolButtonAddEQPTClick(Sender: TObject);
var Form : TDOCT_EQPTForm;
begin
  // если есть что редактировать в плановых инструментах

  // вызов конструктора формы редактирования номенклатуры плановой операции
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено

  if FormType > 2 then
    if trim(dateend.text) <> '.  .' then
      if (strtodate(DateEnd.Text) + 1) < date then
        begin
          MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
          abort;
        end;

  // проверка доступа, если нельзя редактировать операцию, то и затраты тоже
  if not check_user_grand(Tablename, 'U', true) then
    exit;

  Form := TDOCT_EQPTForm.createN(aOperation, 3, 0);
  Form.aOperate := aOperation;

  Form.showmodal;
      Form.Close;

   MakeSelectEQPT(GridFactEQPT, aOperation.lEQPTs, nil, false);

end;


procedure TDOCT_OPERForm.ToolButtonEditEQPTClick(Sender: TObject);
var Form : TDOCT_EQPTForm;

begin
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено
  if FormType > 2 then
   if trim(dateEnd.Text) <> '.  .' then
    if (strtodate(DateEnd.Text) + 1) < date then
      begin
        MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
        abort;
      end;

  // если есть что редактировать в плановых материалах
  if GridFactEQPT.cells[1, 1] = '' then exit;

  // вызов конструктора формы редактирования номенклатуры плановой операции
  Form := TDOCT_EQPTForm.createN(aOperation, 4, GridFactEQPT.Row - 1);
  Form.aOperate := aOperation;
  // проверка доступа, если нельзя редактировать операцию, то и затраты тоже
  Form.OKButton.Enabled := check_user_grand(Tablename, 'U', true);

  Form.showmodal;

  Form.Close;

   MakeSelectEQPT(GridFactEQPT, aOperation^.lEQPTs, nil, false);

end;

procedure TDOCT_OPERForm.ToolButtonDelEQPTClick(Sender: TObject);
begin
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено

  if FormType > 2 then
   if (strtodate(DateEnd.Text) + 1) < date then
    begin
      MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
      abort;
    end;

  // проверка доступа, если нельзя редактировать операцию, то и материалы тоже
  if not check_user_grand(Tablename, 'U', true) then
    exit;

   if messagedlg('Удалить инструмент?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

    begin

     // aOperation := Order_form.lFactOperations.Items[GridFactMTR.row - 1];
      lEQPTs := aOperation^.lEQPTs;

      if lEQPTs <> nil then
       if lEQPTs.Count > 0 then
        lEQPTs.Delete(GridFactEQPT.row - 1);

    end;

    MakeSelectEQPT(GridFactEQPT, aOperation^.lEQPTs, nil, false);

end;

procedure TDOCT_OPERForm.ButtonUpFactEQPTClick(Sender: TObject);
begin
  aOperation := Order_form.lFactOperations.Items[Order_form.Grid_OperFact.row - 1];
  lEQPTs     := aOperation^.lEQPTs;

  Change_enum_list_pos(lEQPTs, GridFactEQPT.row - 1, GridFactEQPT.row - 2);

   if GridFactEQPT.row > 1 then GridFactEQPT.row := GridFactEQPT.row - 1;

   MakeSelectEQPT(GridFactEQPT, aOperation^.lEQPTs, nil, false);

end;

procedure TDOCT_OPERForm.ButtonDownFactEQPTClick(Sender: TObject);
begin
  aOperation := Order_form.lFactOperations.Items[Order_form.Grid_OperFact.row - 1];
  lEQPTs := aOperation^.lEQPTs;

  Change_enum_list_pos(lEQPTs, GridFactEQPT.row - 1, GridFactEQPT.row);
   if GridFactEQPT.row < (GridFactEQPT.rowcount - 1)
     then GridFactEQPT.row := GridFactEQPT.row + 1;

  MakeSelectEQPT(GridFactEQPT, aOperation^.lEQPTs, nil, false);

end;

procedure TDOCT_OPERForm.GridFactEQPTKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelEQPTClick(Sender);   // удаление записи
    45 :  ToolButtonAddEQPTClick(Sender); // Добавление по Ins
    13 :  ToolButtonEditEQPTClick(Sender);  // Редактирование по Enter
  end;


end;

procedure TDOCT_OPERForm.ToolButtonAddTRANSPORTClick(Sender: TObject);
var Form : TDOCT_TransportForm;
begin
  // если есть что редактировать в плановых инструментах

  // вызов конструктора формы редактирования номенклатуры плановой операции
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено

  if FormType > 2 then
    if trim(dateend.text) <> '.  .' then
      if (strtodate(DateEnd.Text) + 1) < date then
        begin
          MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
          abort;
        end;

  // проверка доступа, если нельзя редактировать операцию, то и затраты тоже
  if not check_user_grand(Tablename, 'U', true) then
    exit;

  Form := TDOCT_TransportForm.createN(aOperation, 3, 0);
  Form.aOperate := aOperation;

  Form.showmodal;
  Form.Close;

  MakeSelectTransport(GridFactTransport, aOperation.lTransports, nil, false);

end;

procedure TDOCT_OPERForm.ToolButtonEditTRANSPORTClick(Sender: TObject);
var Form : TDOCT_TransportForm;
begin
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено
  if FormType > 2 then
   if trim(dateEnd.Text) <> '.  .' then
    if (strtodate(DateEnd.Text) + 1) < date then
      begin
        MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
        abort;
      end;

  // если есть что редактировать в плановом траспорте
  if GridFactTransport.cells[1, 1] = '' then exit;

  // вызов конструктора формы редактирования номенклатуры плановой операции
  Form := TDOCT_TransportForm.createN(aOperation, 4, GridFactTransport.Row - 1);
  Form.aOperate := aOperation;
  // проверка доступа, если нельзя редактировать операцию, то и затраты тоже
  Form.OKButton.Enabled := check_user_grand(Tablename, 'U', true);

  Form.showmodal;

  Form.Close;

   MakeSelectTransport(GridFactTransport, aOperation^.lTransports, nil, false);

end;

procedure TDOCT_OPERForm.ToolButtonDelTRANSPORTClick(Sender: TObject);
begin
  // Проверка на доступ.
  // В операции, дата окончания которых раньше текущей - 1,
  // редактирование материалов запрещено

  if FormType > 2 then
   if (strtodate(DateEnd.Text) + 1) < date then
    begin
      MessageDlg('Дата операции меньше текущей. Редактирование '+#13+#10+'материалов запрещено.', mtError, [mbOK], 0);
      abort;
    end;

  // проверка доступа, если нельзя редактировать операцию, то и материалы тоже
  if not check_user_grand(Tablename, 'U', true) then
    exit;

   if messagedlg('Удалить инструмент?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

    begin

     // aOperation := Order_form.lFactOperations.Items[GridFactMTR.row - 1];
      lTransports := aOperation^.lTransports;

      if lTransports <> nil then
       if lTransports.Count > 0 then
        lTransports.Delete(GridFactTransport.row - 1);

    end;

    MakeSelectTransport(GridFactTransport, aOperation^.lTransports, nil, false);

end;

procedure TDOCT_OPERForm.ButtonUpFactTRANSPORTClick(Sender: TObject);
begin
  aOperation := Order_form.lFactOperations.Items[Order_form.Grid_OperFact.row - 1];
  lTransports:= aOperation^.lTransports;

  Change_enum_list_pos(lTransports, GridFactTransport.row - 1, GridFactTransport.row - 2);

   if GridFactTransport.row > 1 then GridFactTransport.row := GridFactTransport.row - 1;

   MakeSelectTransport(GridFactTransport, aOperation^.lTransports, nil, false);

end;

procedure TDOCT_OPERForm.ToolButtonDownFactTRASNPORTClick(Sender: TObject);
begin
  aOperation := Order_form.lFactOperations.Items[Order_form.Grid_OperFact.row - 1];
  lTransports := aOperation^.lTransports;

  Change_enum_list_pos(lTransports, GridFactTransport.row - 1, GridFactTransport.row);
   if GridFactTransport.row < (GridFactTransport.rowcount - 1)
     then GridFactTransport.row := GridFactTransport.row + 1;

  MakeSelectTransport(GridFactTransport, aOperation^.lTransports, nil, false);

end;

procedure TDOCT_OPERForm.GridFactTransportKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelTRANSPORTClick(Sender);   // удаление записи
    45 :  ToolButtonAddTRANSPORTClick(Sender); // Добавление по Ins
    13 :  ToolButtonEditTRANSPORTClick(Sender);  // Редактирование по Enter
  end;

end;

procedure TDOCT_OPERForm.ButtonOrderClick(Sender: TObject);
Var OrderForm: TORDER_OperForm;
begin
        // открыть форму добавления исполнителя
        OrderForm := TORDER_OperForm.CreateN(self, WRKRCombo);

        OrderForm.Show;

end;

end.
