{***************************************************************
 *
 * Unit Name: OrderEditForm
 * Purpose  :
 * Author   :
 * History  :
 *
 ****************************************************************}

{
        Модуль  OrderEditForm.
     Модуль формы документа "Заказ".
     Модуль вызывается из основной формы, формы журнала заказов,
     журнала заявок, формы заявки.
     Большое количество визуальных компонент объясняется сложностью
     описания объекта "Заказ".

     В форме табличные данные находятся в списках.
     При открытии формы документа все данные заносятся в списки, редактирование
     производится также с их помощью. При выполнении транзакции производится запись
     из списков.




}
unit OrderEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, ToolEdit, RXSpin, StdCtrls, ExtCtrls, ComCtrls, Mask, ToolWin,
  Grids, Db, DBTables, Menus, ReqEditForm, DateUtil, CurrEdit, DateUtils,
  StrUtils, IniFiles, ActnList;



type

  StandardProc = procedure(ParentApplication: tApplication;
    ParentForm : tForm; iddoc : integer; data : tDataBase); StdCall;

  // объявление записи по затратам
  PCalculation = ^tCalculation;

  tCalculation = record
      lineno : integer;  // номер строки затрат
      ID_calc: integer;  // ID статьи затрат
      Name_calc : string;// наименование статьи затрат
      nvalue    : real;  // Значение статьи затрат
    end;

  // материал операции
  pMaterial = ^tMaterial;
  tMaterial = record
     lineno : integer;   // номер строки материала
     num_oper : integer; // номер операции  
     ID_matr: integer;   // ID материала
     Name_matr: string;  // наименование материала
     nValue   : real;    // количество материала
     nCost    : real;    // стоимость материала
     nLenght  : real;
     nHeight  : real;
     nWidth   : real;
     nWeight  : real;
     ID_STRG  : integer; // заготовка
     ID_EDIZ  : integer; // единица измерения
     STRG_NAME: string;
     EDIZ_NAME: string;
     
    end;

  // инструмент операции
  pEQPT = ^tEQPT;
  tEQPT = record
     lineno : integer; // номер строки оборудования
     num_oper : integer; // номер операции
     ID_EQPT  : integer; // ID оборудования
     Name_EQPT: string;  // Наименование оборудования
     nValue   : real;    // Количество оборудования
     ID_EDIZ  : integer; // Единица измерения
     EDIZ_NAME: string;  //
   end;

  // транспорт используемый в операции
  pTransport = ^tTransport;
  tTransport = record
     lineno   : integer; //номер строки транспорта
     num_oper : integer; //номер операции
     ID_EQPT  : integer; // ID транспорта
     Name_EQPT: string;  // Наименование транспорта
     nValue   : real;    // Количество транспорта
     ID_EDIZ  : integer; // Единица измерения
     EDIZ_NAME: string;  // Наименование единиц измерения
     Cost     : real;    // Стоимость машино/часа
  end;   


  // операция заказа
  pOperation = ^tOperation;
  tOperation = record
        typeOp : integer; // плановая или фактическая операцияж
        lineno : integer; // номер строки операции
        Name_op: string;  // наименование операции
        ID_op  : integer; // ID вида операции
        Date_beg: string; // дата начала операции
        Date_end: string; // дата окончания операции
        ID_worker: integer;  // ID исполнителя
        Name_worker: string; // ФИО исполнителя
        ID_eqpt  : integer;  // ID оборудования
        Name_eqpt: string;   // Наименование оборудования
        rayting : integer;   // разряд рабочего
        timework: real;      // время выполнения
        price   : real;      // цена
        time_beg: string;
        time_end: string;

        lMaterials : tList;  // список материалов
        lCalcs     : tList;  // список затрат операции
        lEQPTs     : tList;  // список оборудования операции
        lTransports: tList;  // список транспорта
        
     end;

  TDOC_ORDERForm = class(TForm)
    pBotPanel: TPanel;
    OKButton: TButton;
    CloseButton: TButton;
    pTopPanel: TPanel;
    Label1: TLabel;
    OrderNumber: TMaskEdit;
    DateIn: TDateEdit;
    pMainPanel: TPanel;
    PageControl: TPageControl;
    SheetMain: TTabSheet;
    SheetPlan: TTabSheet;
    SheetFact: TTabSheet;
    SheetCalc: TTabSheet;
    SheetOher: TTabSheet;
    Label2: TLabel;
    RQSTCombo: TMaskEdit;
    LabelCustomer: TLabel;
    RadioGroup1: TRadioGroup;
    PR_EXEC: TRadioButton;
    PR_EXEC1: TRadioButton;
    PR_EXEC2: TRadioButton;
    LabelCHRTName: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    PR_URGEN: TRxSpinEdit;
    DateOut: TDateEdit;
    PlantCombo: TComboEdit;
    PDRCombo: TComboEdit;
    NMNTCombo: TComboEdit;
    EQPTCombo: TComboEdit;
    Label9: TLabel;
    pMTRPlanPanel: TPanel;
    SplitterPlan: TSplitter;
    pOperPlanPanel: TPanel;
    GroupBoxOpPlan: TGroupBox;
    Grid_OperPlan: TStringGrid;
    ToolBarOpPl: TToolBar;
    ButtonAddPlanOp: TToolButton;
    ButtonEditPlOp: TToolButton;
    ButtonDelPlOp: TToolButton;
    ButtonUpPlOp: TToolButton;
    ButtonDownPlOp: TToolButton;
    pMTRFactPanel: TPanel;
    SplitterFact: TSplitter;
    pOperFactPanel: TPanel;
    GroupBoxOpFact: TGroupBox;
    ToolBarOpFt: TToolBar;
    ButtonAddFactOp: TToolButton;
    ButtonEditFactOp: TToolButton;
    ButtonDelFactOp: TToolButton;
    ButtonUpFactOp: TToolButton;
    ButtonDownFactOp: TToolButton;
    qPlantQuery: TQuery;
    qPDRQuery: TQuery;
    qNMNTQuery: TQuery;
    qCountQuery: TQuery;
    qMVPQuery: TQuery;
    qStatQuery: TQuery;
    qORDERQuery: TQuery;
    ORDERSource: TDataSource;
    qEQPTQuery: TQuery;
    qFormQuery: TQuery;
    qORDERPlanQuery: TQuery;
    qMTRPlanQuery: TQuery;
    qORDERFactQuery: TQuery;
    qMTRFactQuery: TQuery;
    qCostQuery: TQuery;
    StorProcOrderAdd: TStoredProc;
    StorProcPlanOp: TStoredProc;
    StorProcPlanMTR: TStoredProc;
    CHRTCombo: TComboEdit;
    qCHRTQuery: TQuery;
    StorProcFactOp: TStoredProc;
    StorProcFactMTR: TStoredProc;
    StorProcCalc: TStoredProc;
    StorProcOrderUpdate: TStoredProc;
    PrintMapButton: TButton;
    Vid_Chrt: TLabel;
    Label15: TLabel;
    Sum_Doc: TLabel;
    qTMPQuery: TQuery;
    PrintMapFactButton: TButton;
    Label16: TLabel;
    IDCostCombo: TComboEdit;
    qIDCostQuery: TQuery;
    PR_ORDER: TComboBox;
    PanelInfo: TPanel;
    CalcINFO: TLabel;
    PrintCalctButton: TButton;
    CalcButton: TButton;
    PanelCalc: TPanel;
    GroupBoxCalc: TGroupBox;
    ToolBarCalc: TToolBar;
    ButtonAddCalc: TToolButton;
    ButtonEditCalc: TToolButton;
    ButtonDelCalc: TToolButton;
    GridCalc: TStringGrid;
    SplitterCalc: TSplitter;
    qOperCostQuery: TQuery;
    StorProcOperCalc: TStoredProc;
    ButtonCalcUp: TToolButton;
    ButtonCalcDown: TToolButton;
    Grid_operFact: TStringGrid;
    ButtonFill: TButton;
    ErrorCalcLabel: TLabel;
    Number_F: TCurrencyEdit;
    Number_P: TCurrencyEdit;
    Label17: TLabel;
    WeightEdit: TCurrencyEdit;
    Label18: TLabel;
    ButtonRecalcWeight: TButton;
    PlanPageControl: TPageControl;
    TabSheetPlanMat: TTabSheet;
    ToolBarMtPl: TToolBar;
    ButtonAddPlMat: TToolButton;
    ButtonEditPlMat: TToolButton;
    ButtonDelPlMat: TToolButton;
    ButtonUpPlMat: TToolButton;
    ButtonDownPlMat: TToolButton;
    ShowAllPlanMtr: TToolButton;
    GridMTRPlan: TStringGrid;
    TabSheetPlanTool: TTabSheet;
    ToolBar1: TToolBar;
    ButtonAddPlEQPT: TToolButton;
    ButtonEditPlEQPT: TToolButton;
    ToolButton3: TToolButton;
    ButtonUpPlEQPT: TToolButton;
    ButtonDownPlEQPT: TToolButton;
    ShowAllPlanEQPT: TToolButton;
    GridEQPTPlan: TStringGrid;
    PageControlFact: TPageControl;
    TabSheetFactMat: TTabSheet;
    TabSheetFactTool: TTabSheet;
    ToolBarMtFt: TToolBar;
    ButtonAddFactMt: TToolButton;
    ButtonEditFactMt: TToolButton;
    ButtonDelFactMt: TToolButton;
    ButtonUpFactMt: TToolButton;
    ButtonDownFactMt: TToolButton;
    ShowAllFactMtr: TToolButton;
    GridFactMtr: TStringGrid;
    ToolBar2: TToolBar;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ButtonUpFactEQPT: TToolButton;
    ButtonDownFactEQPT: TToolButton;
    ShowAllFactEQPT: TToolButton;
    GridEQPTFact: TStringGrid;
    qEQPTPlanQuery: TQuery;
    qEQPTFACTQuery: TQuery;
    ADD_EQPT_FACT_PROC: TStoredProc;
    ADD_EQPT_PLAN_PROC: TStoredProc;
    Panel1: TPanel;
    GroupBox: TGroupBox;
    InfoView: TRichEdit;
    Splitter1: TSplitter;
    GroupBox1: TGroupBox;
    info: TRichEdit;
    Panel2: TPanel;
    StatCombo: TComboEdit;
    MVPCombo: TComboEdit;
    CountCombo: TComboEdit;
    Label14: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Splitter2: TSplitter;
    TabSheet1: TTabSheet;
    ToolBar3: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ButtonUpFactTransport: TToolButton;
    ButtonDownFactTransport: TToolButton;
    ShowAllFactTransport: TToolButton;
    GridTransportFact: TStringGrid;
    TabSheetPlanTransport: TTabSheet;
    GridTransportPlan: TStringGrid;
    ToolBar4: TToolBar;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ButtonUpPlTransport: TToolButton;
    ButtonDownPlTransport: TToolButton;
    ShowAllPlanTransport: TToolButton;
    qTransportPlanQuery: TQuery;
    qTransportFactQuery: TQuery;
    ADD_TRANSPORT_PLAN_PROC: TStoredProc;
    ADD_TRANSPORT_FACT_PROC: TStoredProc;
    ActionList: TActionList;
    ChangeRecDoc: TAction;
    ChangeRQSTButton: TButton;
    procedure ValueChange(Sender: TObject);
    procedure DocumentChange;
    function  SaveDoc: boolean;
    procedure ButtonClickOK(Sender: TObject);
    procedure ButtonClickClose(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonFillClick(Sender: TObject);
    procedure ButtonAddPlanOpClick(Sender: TObject);
    procedure ButtonEditPlOpClick(Sender: TObject);
    procedure ButtonDelPlOpClick(Sender: TObject);
    procedure ButtonUpPlOpClick(Sender: TObject);
    procedure ButtonDownPlOpClick(Sender: TObject);
    procedure ButtonAddPlMatClick(Sender: TObject);
    procedure ButtonEditPlMatClick(Sender: TObject);
    procedure ButtonDelPlMatClick(Sender: TObject);
    procedure ButtonUpPlMatClick(Sender: TObject);
    procedure ButtonDownPlMatClick(Sender: TObject);
    procedure ButtonAddFactOpClick(Sender: TObject);
    procedure ButtonEditFactOpClick(Sender: TObject);
    procedure ButtonDelFactOpClick(Sender: TObject);
    procedure ButtonUpFactOpClick(Sender: TObject);
    procedure ButtonDownFactOpClick(Sender: TObject);
    procedure ButtonAddFactMtClick(Sender: TObject);
    procedure ButtonEditFactMtClick(Sender: TObject);
    procedure ButtonDelFactMtClick(Sender: TObject);
    procedure ButtonUpFactMtClick(Sender: TObject);
    procedure ButtonDownFactMtClick(Sender: TObject);
    procedure ButtonAddCalcClick(Sender: TObject);
    procedure ButtonEditCalcClick(Sender: TObject);
    procedure ButtonDelCalcClick(Sender: TObject);
    procedure PlantComboButtonClick(Sender: TObject);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure CountComboButtonClick(Sender: TObject);
    procedure MVPComboButtonClick(Sender: TObject);
    procedure StatComboButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PlantComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CountComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MVPComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StatComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure Grid_OperPlanSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Grid_OperFactSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Grid_OperPlanKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridMTRPlanKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Grid_OperFactKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridFactMtrKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridCalcKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CHRTComboButtonClick(Sender: TObject);
    procedure CHRTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonClickCalc(Sender: TObject);
    procedure PrintMapButtonClick(Sender: TObject);
    procedure ButtonClickPrintCalct(Sender: TObject);
    procedure DateInChange(Sender: TDateEdit);
    procedure PrintMapFactButtonClick(Sender: TObject);
    procedure IDCostComboButtonClick(Sender: TObject);
    procedure IDCostComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonCalcUpClick(Sender: TObject);
    procedure ButtonCalcDownClick(Sender: TObject);
    procedure ShowAllPlanMtrClick(Sender: TObject);
    procedure ShowAllFactMtrClick(Sender: TObject);
    procedure ButtonRecalcWeightClick(Sender: TObject);
    procedure CHRTComboChange(Sender: TObject);
    procedure ButtonAddPlEQPTClick(Sender: TObject);
    procedure ButtonUpPlEQPTClick(Sender: TObject);
    procedure ButtonDownPlEQPTClick(Sender: TObject);
    procedure ShowAllPlanEQPTClick(Sender: TObject);
    procedure ButtonUpFactEQPTClick(Sender: TObject);
    procedure ButtonDownFactEQPTClick(Sender: TObject);
    procedure ShowAllFactEQPTClick(Sender: TObject);
    procedure ButtonUpFactTransportClick(Sender: TObject);
    procedure ButtonDownFactTransportClick(Sender: TObject);
    procedure ShowAllFactTransportClick(Sender: TObject);
    procedure ButtonUpPlTransportClick(Sender: TObject);
    procedure ButtonDownPlTransportClick(Sender: TObject);
    procedure ShowAllPlanTransportClick(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure ChangeRecDocExecute(Sender: TObject);
    procedure ChangeRQSTButtonClick(Sender: TObject);

    // внешние библиотеки печати

  private

    Print_map_form : StandardProc;
    Print_mapFact_form : StandardProc;
    Print_calc_form: StandardProc;

  public
    IDDoc    : integer;            // ID документа
    NumDoc   : integer;            // номер документа
    ParentID : integer;            // ID родительского документа (заявки)
    NewDoc   : boolean;            // признак, что документ создается заново
    WasAnyChanges : boolean;       // признак, что в документе было какое-нибудь изменение
    DocCaption : string;           // заголовок окна

    lPlanOperations : tList;
    lFactOperations : tList;
    lMainCosts      : tList;
    lEQPTs          : tList;
    lTransports     : tList;

    ID_CST   : integer;            // ID Заказчика
    glVID_CHRT : integer;          // признак чертежа: изготовление, ремонт

    ParentRQSTForm   : TDOC_REQUESTForm; // форма редактирования заявки, откуда вызвана форма
    sum_order        : real;       // цеховая себестоимость выполненного заказа

    // конструктор формы документа
    constructor CreateN(_AOwner: TForm; docID : integer; _ParentId : integer; ParentNumber : integer; ParentForm :TDOC_REQUESTForm);
    destructor Destroy; override;

    { Public declarations }
  end;

var
  DOC_ORDERForm: TDOC_ORDERForm;
  EnumEdit   : TForm;      // Форма списка справочника

  // переменные модуля
  qFormQuery : tQuery;     // запрос для открытия сущесвующего документа
  AOwner     : TForm;      // форма, откуда открывается данный модуль
  aOperation : pOperation;
   ProcAddr  : FarProc;


implementation

uses   Base,
 libs,
 JRRQSTForm,               // форма журнала заявок
JRORDERForm,               // форма журнала заказов
OROPEditForm,              // форма редактирования операций заказа (плановые, фактические)
ORMTREditForm,             // форма редактирования материалов операции
EnumForm4Sel,              // форма выбора из справочника
        Main,
OrderEditLibs,
ParamForm,
PRDocEditForm,              // форма редактирования прихода готовой продукции
ORCALCEditForm ;            // форма редактирования затрат заказа

{$R *.DFM}



{
  Процедура показа изменений в форме
}
procedure  TDOC_ORDERForm.DocumentChange;
begin

 WasAnyChanges := true;
 caption := DocCaption + ' *';

end;
{
   При изменении любого объекта формы изменяется признак изменения документа
}
procedure TDOC_ORDERForm.ValueChange(Sender: TObject);
begin

 DocumentChange;

end;
{
   Процедура закрытия формы
}
procedure TDOC_ORDERForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;





{
   Конструктор создания формы редактирования документа
   На входе:
     компонета - форма владелец;
     IDDoc     - ID документа (-1 в случае создания нового документа Заказ);
     ParentID  - ID родительского документа, заказ всегда создается только для существующей заявки.
     ParentNumber - номер родительской заявки,
     ParentForm   - форма родительской заявки.
}
constructor TDOC_ORDERForm.CreateN(_AOwner: TForm; docID : integer; _ParentID : integer; ParentNumber : integer;
        ParentForm : TDOC_REQUESTForm);
Var Ini:TIniFile;
    FileName : String;
    str      : String;
begin

  inherited Create(_AOwner);

  IdDoc                 := docID;
  ParentID              := _ParentID;
  AOwner                := _AOwner;

  // проверка доступа
  OKButton.Enabled := check_user_grand('DH_ORDER', 'U', true);

  if ParentForm <> nil then
    ParentRQSTForm := ParentForm;

  // в зависимости от параметра формы: для выбора или редактирования
  // подключаются различные источник и запрос
  if IDDoc = - 1 then

    begin // для нового документа

      NewDoc := true;        // флаг нового документа

      // дата документа устанавливается текущая
      datein.Text := ParentRQSTForm.Date_In.Text; //          datetostr(date());
      Pr_exec.Checked := true;
      DocCaption := 'Документ Заказ: Новый';

      // если заказ вводится из заявки, то номер заявки известен
      if ParentNumber < 0 then
        RQSTCombo.text := 'Заявка?'
      else
        RQSTCombo.text := inttostr(ParentNumber);

      // формирование запроса для нахождения номера документа
//      qTMPQuery.sql.clear;
//      qtmpquery.sql.add('select max(number) from dh_order');
//      qtmpquery.open;
//      NumDoc := qtmpquery.Fields[0].asinteger + 1;


      // начальные данные

        //Данное условие просили доделать в Литейке
//       if DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp') then
       if DirectoryExists('c:\RmpTemp') then
       begin

         FileName := {ExtractFilePath(Application.EXEName) +} 'c:\RmpTemp\rmp.ini';  //1/12/10
//         FileName := GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp\rmp.ini';

         //Процедура записи кода последнего сохраненного элемента в rmp.ini
         Ini:=TIniFile.Create(FileName);

         //Следующий оператор заносит в ключ CodeChrt раздела Sprav значение 'Code.text':
         DateOut.text:=Ini.ReadString('JournalOrder','DateOut', '  .  .  ');

         //Следующие операторы сохраняют содержимое объекта Ini в файле на диске и разрушают объект Ini:
         Ini.UpdateFile;
         Ini.Free;
      end;

      Number_P.value     := 0; // количество по факту
      Number_F.value     := 0; // количество по плану
      PR_ORDER.itemindex := 0; // признак плана
      PR_Urgen.Value     := 1; // признак срочности
      WeightEdit.Value   := 0; // вес

      // завод по умолчанию
      PlantCombo.ID := Param_Form.qPlantQuery.Fields[0].asinteger;

      // счет по умолчанию
      CountCombo.ID := Param_Form.qCountQuery.Fields[0].asinteger;

      // МВП по умолчанию
      MVPCombo.ID := Param_Form.qMVPQuery.Fields[0].asinteger;

      // заполнение поля "Подразделение"
      // Подразделение проставляется из заявки. При необходимости
      // оно заменяется
      PDRCombo.ID := ParentRQSTForm.qPDRQuery.Fieldbyname('id').asinteger;

      // заполнение поля "Вид затрат"
      IDCostCombo.ID := -1;

      // заполнение поля "Чертеж"
      CHRTCombo.ID := -1;

      // заполнение поля "Номенклатура"
      NMNTCombo.ID := -1;

      // заполнение поля "Оборудование"
      EQPTCombo.ID := -1;

      // заполнение поля "Статистика"
      STATCombo.ID := -1;

      OrderNumber.Text := 'Новый';
      WasAnyChanges := true;
      Sum_Doc.Caption:= '0';

    end

  else  // для редактирования существующего документа

    begin

      NewDoc := false;

      // заполнение информации по полям
      qFormQuery.SQL.clear;
      qFormQuery.sql.add('select * from dh_order where id = ' + inttostr(IDDoc));
      qFormQuery.open;

      // заполнение поля "Подразделение"
      PDRCombo.ID := qFormQuery.fieldbyname('ID_PDR').asinteger;

      IDCostCombo.ID := qFormQuery.fieldbyname('ID_COST').asinteger;

      // заполнение поля "Завод"
      PLANTCombo.ID := qFormQuery.fieldbyname('ID_PLANT').asinteger;

      // заполнение поля "Чертеж"
      CHRTCombo.ID := qFormQuery.fieldbyname('ID_CHRT').asinteger;

      // заполнение поля "Номенклатура"
      NMNTCombo.ID := qFormQuery.fieldbyname('ID_NMNT').asinteger;

      // заполнение поля "Оборудование"
      EQPTCombo.ID := qFormQuery.fieldbyname('ID_EQPT').asinteger;

      // заполнение поля "Завод"
      COUNTCombo.ID := qFormQuery.fieldbyname('ID_Count').asinteger;

      // заполнение поля "МВП"
      MVPCombo.ID := qFormQuery.fieldbyname('ID_mvp').asinteger;

      // заполнение поля "Статистика"
      StatCombo.ID := qFormQuery.fieldbyname('ID_Stat').asinteger;

      // заполнение прочих полей
      OrderNumber.Text   := qFormQuery.fieldbyName('Number').asstring;  // номер докумемнта
      RQSTCombo.text     := qFormQuery.fieldbyName('ID_RQST').asstring; // заказ
      DateIn.Text        := qformQuery.fieldbyName('Date_In').asstring; // дата поступления
      DateOut.Text       := qformQuery.fieldbyName('Date_Out').asstring;// дата окончания
      Number_P.value     := qformQuery.fieldbyName('Number_P').asfloat;// количество по факту
      Number_F.value     := qformQuery.fieldbyName('Number_F').asfloat;// количество по плану
      PR_ORDER.itemindex := qformQuery.fieldbyName('WEIGHT_F').asinteger;// вес
      PR_Urgen.value     := qformQuery.fieldbyName('PR_Urgen').asinteger;// признак срочности
      WEIGHTEdit.Text    := formatfloat('0.000', qformQuery.fieldbyName('WEIGHT').asfloat);// вес

      
      // поле "признак выполнения"
      case qformQuery.fieldbyName('PR_EXEC').asinteger of
        1: PR_EXEC.Checked  := true;
        2: PR_EXEC1.Checked := true;
        3: PR_EXEC2.Checked := true;
      end;

//      INFO.Lines.Add(qFormQuery.fieldbyname('INFO').asstring); 4.12.2006
      InfoView.Lines.Add(qFormQuery.fieldbyname('INFO').asstring);

    //Необходимо убрать пустые строки в InfoView.Lines.Text
      str := InfoView.Lines.Text;
      While (Pos(#13#10#13#10, str) > 0) do
      begin
          Delete(str, Pos(#13#10#13#10, str), 2);
      end;

      InfoView.Lines.Text := str;

      DocCaption := 'Документ Заказ: ' + OrderNumber.text + ' от ' + Datein.text;
      RQSTCombo.Text := intToStr(ParentNumber);



      WasAnyChanges := false;
    end;
   // создание временного запроса для того, чтобы найти наименование заказчика
   // зная только ID заявки
   qTMPQuery.close;
   qTMPQuery.sql.Clear;
   qTMPQuery.sql.add('select a.id, a.number, b.name, b.code, b.id as id_cst, a.id_cst from dh_rqst a, spr_cst b where a.id = ' + inttostr(parentID) + ' and a.id_cst = b.id');
   qTMPQuery.open;

   LabelCustomer.Caption := 'Заказчик: ' + qTMPQuery.FieldByName('NAME').asstring +
                                ', код: ' + qTMPQuery.FieldByName('Code').asstring;
   ID_CST  := qTMPQuery.FieldByName('ID_CST').asinteger;
   Caption := DocCaption;

   // процедура заполнения строк в таблицах
   lPlanOperations := tList.create;
   lFactOperations := tList.create;
   lMainCosts      := tList.Create;

   // получить данные в таблицах
   Get_Table_data(self);
   // заполнить таблицы данных
   Fill_table(self);

   // строка затрат
   CalcInfo.Caption := '';
   ErrorCalcLabel.Caption := '';

   // если документ существует, то пересчет себестоимости
    if NewDoc then
      with qTMPQuery do
        begin
          close;
          sql.Clear;
          sql.Add('select id_stat from spr_cst where id = :id');
          params[0].asinteger :=ID_CST;
          open;
          if not qTMPQuery.Eof then
            begin
              // заполнение поля "Статистика"
              qStatQuery.Close;
              StatCombo.ID := qTMPQuery.fieldbyname('ID_Stat').asinteger;

            end;

      end;



   // опознание вида чертежа
   SetVidChrt(self);

   PageControl.ActivePageIndex := 0;

end;

{
  Деструктор формы редактирования документа
}
destructor TDOC_ORDERForm.Destroy;
begin
  inherited;

end;




{  ****************************************************************************


  Процедура записи документа.
  Вход: пусто;
  Выход: пусто;
  Описание:  выполняет транзакции по записи объекта "Документ "Заказ" в базу
  данных.




}
function TDOC_ORDERForm.SaveDoc: boolean;
var _s : string;
     i, j          : integer;
     StorProcOrder : TStoredProc;
     _PR_EXEC      : integer;
     Period_beg,Period_end : real;
     aCosts : pCalculation;
     aEQPT  : pEQPT;
     aTransport  : pTransport;
     lCosts : TList;
     dDate  : tDateTime;
     aYear, aMonth, aDay, aHour, aMin : word;
     dTime  : tTime;
     str : string;

begin

 result := true;
 if not check_user_grand('DH_ORDER', 'U', true) then exit;


 try

    // Проверить данные по расчету себестоимости Для закрытого заказа
    if PR_EXEC2.Checked then
      if not Check_cost_operaion(self) then
        if  MessageDlg('Себестоимость выполненных операций не совпадает с итоговой. '+#13+#10+'Возможно не рассчитана общая себестоимость заказа или '+#13+#10+'затраты фактических операций.'+#13+#10+'Сохранить документ?', mtError, [mbYes, mbNo], 0) = mrNo then
          begin
            MessageDlg('Документ не сохранен', mtInformation, [mbOK], 0);
            exit;
          end;

    {
       Здесь производится проверка на подчиненные документы. Если
       есть подчиненные, то статус выполнения не может быть меньше 3.

    }
    if not newDoc then
      if Check_order_state_and_child(IDDoc, self) then
        exit;

    // начало транзакции
    data.RMPBase.StartTransaction;

    // при добавлении и изменении данных выполняются разные процедуры
    if NewDoc then
      StorProcOrder := StorProcOrderAdd

    else
      begin
        StorProcOrder := StorProcOrderUpdate;
        StorProcOrder.ParamByName('IDDOC').asinteger  := IDDoc;
      end;

    if not NewDoc then
      begin
       _s := trim(OrderNumber.EditText);
       NumDoc := strToInt(_s)
      end
     else
       NumDoc := -1;

    // если под этим ноером уже есть документ и их ID разные
  if not NewDoc then
    if (ChechUniqueCode('DH_ORDER', 'NUMBER', _s, IDDoc) > 0)  then

      begin
        result :=  false;
        showmessage('Номер документа не уникальный!');
        exit;
      end;

    StorProcOrder.ParamByName('NUMBER').asinteger := NumDoc;
    StorProcOrder.ParamByName('ID_RQST').asinteger:= ParentID;

    // производство
    if  (PlantCombo.ID > 0) then
      SetParamCombo(StorProcOrder.ParamByName('ID_PLANT'), PlantCombo)
    else
      begin
        showmessage('Не указано производство!');
        result :=  false;
        PLANTCombo.Color := clRed;
        exit;
      end;


    // проверка подразделения
    if (PDRCombo.ID = -1) then
      begin
        showmessage('Не указано МВЗ!');
        result :=  false;
        PDRCombo.Color := clRed;
        exit;


      end
    else
      SetParamCombo(StorProcOrder.ParamByName('ID_PDR'), PDRCombo);

    // проверка вида затрат
    // Вид затрат проставляется только при выполнении ремонта для внутренних заказчиков
    if (IDCostCombo.ID = -1) then
      begin

       if glVID_CHRT = 1 then //Vid_chrt.Caption = 'Вид работ: ремонт' then

         begin

           with qTMPQuery do
             begin
               sql.clear;
               sql.add('select is_instr from spr_cst where id = ' + inttostr(ID_CST));
               open;

             end;

           if not qTmpQuery.eof then
            if qTMPQUery.Fields[0].asinteger > 0 then

               showmessage('Не указан вид затрат!');

          end;

         StorProcOrder.ParamByName('ID_COST').asinteger := 0;
       end
    else
      SetParamCombo(StorProcOrder.ParamByName('ID_COST'), IDCostCombo);

    // чертеж
    if  (CHRTCombo.ID > 0) then
      SetParamCombo(StorProcOrder.ParamByName('ID_CHRT'), CHRTCombo)
    else
      begin
        showmessage('Не указана чертеж!');
        result :=  false;
        CHRTCombo.color := clRed;
        exit;

      end;


    // проверка номенклатуры
    SetParamCombo(StorProcOrder.ParamByName('ID_NMNT'), NMNTCombo);


    // проверка значения поля "Оборудование"
    SetParamCombo(StorProcOrder.ParamByName('ID_EQPT'), EQPTCombo);


    // признак срочности
    StorProcOrder.ParamByName('PR_URGEN').value   := PR_URGEN.value;




    // дата начала
    if (datein.text = '  .  .  ') or (datein.text = '  .  .    ') then
      begin
        showmessage('Не указана дата документа!');
        result :=  false;
        datein.color := clRed;
        exit;

      end

    else
      try
        StorProcOrder.ParamByName('DATE_IN').asdate   := strtodate(datein.text);

      except
        showmessage('Дата начала указана не верно!');
        result :=  false;
        datein.color := clRed;
        exit;
        raise;
      end;

    // дата окончания


    if (dateout.text =  '  .  .  ') then //) or (dateout.text = '  .  .    ') then
      begin
        showmessage('Не указана дата окончания работ!');
        result :=  false;
        dateout.Color := clRed;
        exit;

      end

    else
      try
        StorProcOrder.ParamByName('DATE_OUT').asdate  := strtodate(dateout.text);

      except
        showmessage('Дата окончания указана не верно!');
        result :=  false;
        datein.color := clRed;
        exit;
        raise;
      end;


    // Проверка на правильность ввода дат
    if strtodate(dateout.text) < strToDate(dateIn.text) then
      begin
        showmessage('Дата окончания раньше даты начала!!!');
        result :=  false;
        dateout.Color := clRed;
        datein.Color := clRed;
        exit;

      end;


    // Поле признак заказа
    StorProcOrder.ParamByName('WEIGHT_F').asinteger := PR_ORDER.ItemIndex;

    // вес изделия
    StorProcOrder.ParamByName('WEIGHT').asfloat     := WeightEdit.Value;


    // количество по плану
    StorProcOrder.ParamByName('NUMBER_P').value := NUMBER_P.value;

    // количество по факту
    StorProcOrder.ParamByName('NUMBER_F').value := NUMBER_F.value;

    // проверка на состоятельность вводимых данных
    if StatCombo.ID > 0 then
      SetParamCombo(StorProcOrder.ParamByName('ID_STAT'), STATCombo)
     else
      begin
        showmessage('Статья статистики не указана...');
        result :=  false;
        exit;

      end;

    // место возникновения прибыли
    if MVPCombo.ID > 0 then
      SetParamCombo(StorProcOrder.ParamByName('ID_MVP'), MVPCombo)
      else
       begin
        showmessage('Статья МВП не указана...');
        result :=  false;
        exit;

       end;


    // счет затрат
    if CountCombo.ID > 0 then
      SetParamCombo(StorProcOrder.ParamByName('ID_COUNT'), CountCombo)
     else
       begin
        showmessage('Счет затрат не указан...');
        result :=  false;
        exit;

       end;



    // признак выполнения
    if PR_EXEC.Checked = true then
      _PR_EXEC := 1
    else
     if PR_EXEC1.Checked = true then
      _PR_EXEC := 2
     else
      _PR_EXEC := 3;


    // изменение статуса заказа при вводе фактических операций
    if (Grid_operFact.RowCount > 2) then

      // если введено более одной фактической операции
      if Grid_OperFact.cells[2, 1] <> '' then

        // если статус заказа до исполнения был "Не выполнен"
        if PR_EXEC.Checked then

          begin

            PR_EXEC.Checked := false;
            PR_EXEC1.Checked := true;

          end;

     // Запись статуса заказа
    StorProcOrder.ParamByName('pr_exec').asinteger:= _PR_EXEC;

    // заполнение поля INFO
//    StorProcOrder.ParamByName('INFO').value := INFO.Lines.Text; 4.12.2006

    If Length(INFO.Lines.Text) > 0 Then
    begin
       StorProcOrder.ParamByName('INFO').value := InfoView.Lines.Text+DateTimeToStr(Now)+'   '+INFO.Lines.Text;
       InfoView.Lines.Text := InfoView.Lines.Text+'('+DateTimeToStr(Now)+')   '+INFO.Lines.Text;
       INFO.Lines.Text := '';
    end
     else  StorProcOrder.ParamByName('INFO').value := InfoView.Lines.Text;


    // заполнение стоимости заказа
    StorProcOrder.ParamByName('SUM_DOC').asfloat := sum_order;

    // выполнение запроса
    // если все правильно, то можно записать документ
    StorProcOrder.Prepare;
    StorProcOrder.ExecProc;

    Caption:= 'Документ Заказ: ' + OrderNumber.text + ' от ' + Datein.text;

    // получение ID документа
    IDDoc  := StorProcOrder.ParamByName('IDDOC').asinteger;
    if NewDoc then
     begin
      NumDoc := StorProcOrder.ParamByName('NumDoc').asinteger;
      OrderNumber.text := inttostr(NumDoc);
     end;

    NewDoc := false; // если документ уже сохранен, то он не новый


    // перебор всех строк плановых операций документа
    if lPlanOperations <> nil then
     for i := 0 to lPlanOperations.count - 1 do

      begin
        aOperation := lPlanOperations.Items[i];

        // запись плановых операций заказа
        StorProcPlanOp.ParamByName('ID_ORDER').asinteger:= IDDoc;

        if  CHRTCombo.ID > 0 then
          SetParamCombo(StorProcPlanOp.ParamByName('ID_CHRT'), CHRTCombo) // ID чертежа
        else

          begin
             showmessage('Не проставлен чертеж!');
             exit;
          end;

          StorProcPlanOp.ParamByName('ID_VOP').asinteger  := aOperation^.ID_op;    // ID вида операции
          StorProcPlanOp.ParamByName('LINENO').asinteger  := aOperation^.lineno;   // номер строки
          StorProcPlanOp.ParamByName('NTIME').value       := aOperation^.timework * 1000; // время выполнения
          StorProcPlanOp.ParamByName('RATING').asinteger  := aOperation^.rayting;  // разряд рабочего
          StorProcPlanOp.ParamByName('PRICE').asfloat     := aOperation^.price;    // стоимость


//        Для функции оперативного планирования требуется заполнение дат и времени
//        начала и окончания выполнения операций. Если указана хоть одна дата, то требуется
//        заполнить все даты и время.

        StorProcPlanOp.ParamByName('DATE_BEG').Clear;
        StorProcPlanOp.ParamByName('DATE_END').Clear;
        StorProcPlanOp.ParamByName('TIME_END').Clear;
        StorProcPlanOp.ParamByName('TIME_END').Clear;


        if ((trim(aOperation^.Date_beg) <> '') or (trim(aOperation^.Date_beg) <> '.  .'))
        or ((trim(aOperation^.Date_end)<> '') or (trim(aOperation^.Date_end) <> '.  .'))

           then

            begin

              if (trim(aOperation^.Date_beg) <> '.  .') and (trim(aOperation^.Date_beg) <> '') then

              try
                dDate := strtodate(aOperation^.Date_beg);
                decodedate( dDate, aYear, aMonth, aDay);
                if (trim(aOperation^.time_beg) <> ':  :') and
                    (trim(aOperation^.time_beg) <> ':') and
                     (trim(aOperation^.time_beg) <> '')
                   then
                  begin
                   ahour := strtoint(leftstr(aOperation^.time_beg, length(aOperation^.time_beg) - 6));
                   amin  := strtoint(
                                     leftstr(
                                       rightstr(aOperation^.time_beg, 5), 2));
                  end
                   else
                     begin
                       ahour := 0;
                       amin  := 0;
                     end;

                dDate := EncodeDateTime(aYear, aMonth, aDay,
                        ahour, amin, 0 ,0);

                StorProcPlanOp.ParamByName('DATE_BEG').AsDateTime   := dDate // дата начала

              except
//                showmessage('Дата начала плановой операции №'+IntToStr(aOperation^.lineno)+' указана не верно!');
//                result :=  false;
//                exit;
//                raise;
                StorProcPlanOp.ParamByName('DATE_BEG').Clear;
              end;




              if (trim(aOperation^.Date_end) <> '.  .') and (trim(aOperation^.Date_end) <> '') then

               try
                 dDate := strtodate(aOperation^.Date_end);
                 decodedate( dDate, aYear, aMonth, aDay);

                 if  (trim(aOperation^.time_end) <> ':') and
                      (trim(aOperation^.time_end) <> ':  :') and
                       (trim(aOperation^.time_end) <> '')
                    then
                   begin
                    ahour := strtoint(leftstr(aOperation^.time_end, length(aOperation^.time_end) - 6));
                    amin  := strtoint(
                                     leftstr(
                                       rightstr(aOperation^.time_end, 5), 2));
                   end
                   else
                     begin
                       ahour := 0;
                       amin  := 0;
                     end;

                   dDate := EncodeDateTime(aYear, aMonth, aDay,
                          ahour, amin, 0 ,0);


                  StorProcPlanOp.ParamByName('DATE_END').AsDateTime   := dDate // дата окончания

               except
//                 showmessage('Дата окончания плановой операции №'+IntToStr(aOperation^.lineno)+' указана не верно!');
//                 result :=  false;
//                 exit;
//                 raise;
                   StorProcPlanOp.ParamByName('DATE_END').Clear;
               end;



             if (trim(aOperation^.time_beg) <> ':') and (aOperation^.time_beg <> '') then

              try
                 StorProcPlanOp.ParamByName('TIME_BEG').AsString := aOperation^.time_beg;  // время начала
              except
//                 showmessage('Время начала плановой операции №'+IntToStr(aOperation^.lineno)+' указано не верно!');
//                 result :=  false;
//                 exit;
//                 raise;
                   StorProcPlanOp.ParamByName('TIME_BEG').Clear;
              end;



            if (trim(aOperation^.time_end) <> ':') and (aOperation^.time_end <> '') then

              try

                StorProcPlanOp.ParamByName('TIME_END').AsString := aOperation^.time_end;  // время окончания
              except
//                showmessage('Время окончания плановой операции №'+IntToStr(aOperation^.lineno)+' указано не верно!');
//                result :=  false;
//                exit;
//                raise;
                   StorProcPlanOp.ParamByName('TIME_END').Clear;
              end;


        end;

        if aOperation^.ID_worker > 0 then
          StorProcPlanOp.ParamByName('ID_WRKR').asinteger := aOperation^.ID_worker // работник
        else
           StorProcPlanOp.ParamByName('ID_WRKR').Clear;


        // оборудование может быть не проставлено
        if aOperation^.ID_eqpt > 0 then
          StorProcPlanOp.ParamByName('ID_EQPT').asinteger := aOperation^.ID_eqpt  // оборудование
        else
          StorProcPlanOp.ParamByName('ID_EQPT').clear;
//******************************************************************************

          StorProcPlanOp.Prepare;
          StorProcPlanOp.ExecProc;

          lMaterials := aOperation^.lMaterials;

          // добавление материалов операции
          if lMaterials <> nil then
            for j := 0 to lMaterials.Count - 1 do

              begin
                  aMaterial := lMaterials.Items[j];
                  StorProcPlanMTR.ParamByName('ID_OPP').asinteger := IDDOC;             // ID документа
                  StorProcPlanMTR.ParamByName('LINEOPP').asinteger:= aOperation^.lineno; // номер строки плановой операции
                  StorProcPlanMTR.ParamByName('LINENO').asinteger := aMaterial^.lineno;  // номер строки
                  StorProcPlanMTR.ParamByName('ID_NMNT').asinteger:= aMaterial^.ID_matr; // ID номенклатуры
                  StorProcPlanMTR.ParamByName('NUMBER').asfloat   := aMaterial^.nValue;  // количество
                  StorProcPlanMTR.ParamByName('PRICE').asfloat    := aMaterial^.nCost;   // стоимость
                  StorProcPlanMTR.ParamByName('HIGHT').asfloat    := aMaterial^.nHeight; // высота
                  StorProcPlanMTR.ParamByName('LENGHT').asfloat   := aMaterial^.nLenght; // длина
                  StorProcPlanMTR.ParamByName('WIDTH').asfloat    := aMaterial^.nWidth;  // ширина
                  StorProcPlanMTR.ParamByName('WEIGHT').asfloat   := aMaterial^.nWeight; // вес
                  StorProcPlanMTR.ParamByName('ID_EDIZ').asinteger:= aMaterial^.ID_EDIZ; // единица измерения
                  StorProcPlanMTR.ParamByName('ID_STRG').asinteger:= aMaterial^.ID_STRG; // заготовка

                  // все сохранить в базу
                  StorProcPlanMTR.Prepare;
                  StorProcPlanMTR.ExecProc;

              end;


          lEQPTs := aOperation^.lEQPTs;

          // добавление инструментов операции
          if lEQPTs <> nil then
            for j := 0 to lEQPTs.Count - 1 do

              begin
                  aEQPT := lEQPTs.Items[j];
                  ADD_EQPT_PLAN_PROC.ParamByName('ID_OPP').asinteger := IDDOC;             // ID документа
                  ADD_EQPT_PLAN_PROC.ParamByName('LINEOPP').asinteger:= aOperation^.lineno; // номер строки плановой операции
                  ADD_EQPT_PLAN_PROC.ParamByName('LINENO').asinteger := aEQPT^.lineno;  // номер строки
                  ADD_EQPT_PLAN_PROC.ParamByName('ID_EQPT').asinteger:= aEQPT^.ID_EQPT; // ID номенклатуры
                  ADD_EQPT_PLAN_PROC.ParamByName('NUMBER').asfloat   := aEQPT^.nValue;  // количество
                  ADD_EQPT_PLAN_PROC.ParamByName('ID_EDIZ').asinteger   := aEQPT^.ID_EDIZ; // единица измерения

                  // все сохранить в базу
                  ADD_EQPT_PLAN_PROC.Prepare;
                  ADD_EQPT_PLAN_PROC.ExecProc;

              end;

          lTransports := aOperation^.lTransports;

          // добавление транспорта операции
          if lTransports <> nil then
            for j := 0 to lTransports.Count - 1 do

              begin
                  aTransport := lTransports.Items[j];
                  ADD_TRANSPORT_PLAN_PROC.ParamByName('ID_OPP').asinteger := IDDOC;               // ID документа
                  ADD_TRANSPORT_PLAN_PROC.ParamByName('LINEOPP').asinteger:= aOperation^.lineno;  // номер строки плановой операции
                  ADD_TRANSPORT_PLAN_PROC.ParamByName('LINENO').asinteger := aTransport^.lineno;  // номер строки
                  ADD_TRANSPORT_PLAN_PROC.ParamByName('ID_EQPT').asinteger:= aTransport^.ID_EQPT; // ID номенклатуры
                  ADD_TRANSPORT_PLAN_PROC.ParamByName('NUMBER').asfloat   := aTransport^.nValue;  // количество
                  ADD_TRANSPORT_PLAN_PROC.ParamByName('ID_EDIZ').asinteger:= aTransport^.ID_EDIZ; // единица измерения
                  ADD_TRANSPORT_PLAN_PROC.ParamByName('COST').asfloat     := aTransport^.Cost;    // Цена м/ч

                  // все сохранить в базу
                  ADD_TRANSPORT_PLAN_PROC.Prepare;
                  ADD_TRANSPORT_PLAN_PROC.ExecProc;

              end;


      end;


     // проведение транзакции по фактическим операциям документа
    if lFactOperations    <> nil then
     for i := 0 to lFactOperations.Count - 1 do

      begin
        aOperation := lFactOperations.Items[i];

        StorProcFactOp.ParamByName('ID_ORDER').asinteger := IDDoc;

        // ID чертежа заказа. Он к этому моменту уже проверен
        SetParamCombo(StorProcFactOp.ParamByName('ID_CHRT'), CHRTCombo);      // ID чертежа
        StorProcFactOp.ParamByName('ID_VOP').asinteger  := aOperation^.ID_op;  // ID вида операции
        StorProcFactOp.ParamByName('LINENO').asinteger  := aOperation^.lineno; // номер строки
        StorProcFactOp.ParamByName('RATING').asinteger  := aOperation^.rayting;// разряд рабочего
        StorProcFactOp.ParamByName('NTIME').value       := 1000 * aOperation^.timework; // время выполнения
        StorProcFactOp.ParamByName('PRICE').asfloat     := aOperation^.price;  // стоимость

        // параметры для работы с производственным журналом
        StorProcFactOp.ParamByName('ID_PDR').asinteger := PDRCombo.ID;
        StorProcFactOp.ParamByName('PR_EXEC').asinteger:= _PR_EXEC;
        StorProcFactOp.ParamByName('PERIOD').asinteger := Param_Form.BoxFactPeriod.ItemIndex;

        {
           Необходимо отследить необходимость записи заказа в производственный журнал заказов.
           Заказ записывается, если дата начала выполнения операции или дата окончания
           попадает в период производственного журнала заказов.
        }

        Period_beg := MonthsBetween(strtodate('01.01.00'), strtodate(aOperation^.Date_beg));
        If (trim(aOperation^.Date_end) <> '.  .') Then            //2017 просили сохранять факт без даты окончания операции
           Period_end := MonthsBetween(strtodate('01.01.00'), strtodate(aOperation^.Date_end))
          else Period_end :=  Period_beg;                         //2017 просили сохранять факт без даты окончания операции

        if  (int(Period_beg)= Param_Form.BoxFactPeriod.ItemIndex)
          or
           (int(Period_end) = Param_Form.BoxFactPeriod.ItemIndex)
          then
            StorProcFactOp.ParamByName('NEED_INPUT_PROD').asinteger := 1
          else
            StorProcFactOp.ParamByName('NEED_INPUT_PROD').asinteger := 0;



        if trim(aOperation^.Date_beg) <> '.  .' then

            try
              begin
                dDate := strtodate(aOperation^.Date_beg);
                decodedate( dDate, aYear, aMonth, aDay);
                if (trim(aOperation^.time_beg) <> ':  :') and
                   (trim(aOperation^.time_beg) <> ':') and
                       (trim(aOperation^.time_end) <> '')  then
                  begin
                   ahour := strtoint(leftstr(aOperation^.time_beg, length(aOperation^.time_beg) - 6));
                   amin  := strtoint(
                                     leftstr(
                                       rightstr(aOperation^.time_beg, 5), 2));
                  end
                   else
                     begin
                       ahour := 0;
                       amin  := 0;
                     end;

                dDate := EncodeDateTime(aYear, aMonth, aDay,
                        ahour, amin, 0 ,0);

                StorProcFactOp.ParamByName('DATE_BEG').AsDateTime := dDate; // дата начала
              end
            except
              showmessage('Дата начала фактических указана не верно!');
              result :=  false;
              exit;
             raise;
           end


        else
          StorProcFactOp.ParamByName('DATE_BEG').asdate := strtodate('01.01.00');



        if trim(aOperation^.Date_end) <> '.  .' then

            try
              begin
                dDate := strtodate(aOperation^.Date_end);
                decodedate( dDate, aYear, aMonth, aDay);

                if  (trim(aOperation^.time_end) <> ':') and
                      (trim(aOperation^.time_end) <> ':  :') and
                       (trim(aOperation^.time_end) <> '')
                    then
                  begin
                   ahour := strtoint(leftstr(aOperation^.time_end, length(aOperation^.time_end) - 6));
                   amin  := strtoint(
                                     leftstr(
                                       rightstr(aOperation^.time_end, 5), 2));
                  end
                  else
                    begin
                      ahour := 0;
                      amin  := 0;
                    end;

                dDate := EncodeDateTime(aYear, aMonth, aDay,
                        ahour, amin, 0 ,0);


                 StorProcFactOp.ParamByName('DATE_END').AsDateTime   := dDate // дата окончания
              end
            except
              showmessage('Дата окончания фактических указана не верно!');
              result :=  false;
              exit;
             raise;
           end

        else
          StorProcFactOp.ParamByName('DATE_END').Clear;
//          StorProcFactOp.ParamByName('DATE_END').AsDate := strtodate('01.01.00');

       if (trim(aOperation^.time_beg) <> ':  :') and
            (trim(aOperation^.time_beg) <> ':') and
            (trim(aOperation^.time_beg) <> '') then
            StorProcFactOp.ParamByName('TIME_BEG').asstring := aOperation^.time_beg  // время начала
         else StorProcFactOp.ParamByName('TIME_BEG').asstring := '0:00:00';            //2017 просили сохранять факт без даты окончания операции

       if (trim(aOperation^.time_end) <> ':  :') and
            (trim(aOperation^.time_end) <> ':') and
            (trim(aOperation^.time_end) <> '') then
           StorProcFactOp.ParamByName('TIME_END').asstring := aOperation^.time_end  // время окончания
         else StorProcFactOp.ParamByName('TIME_END').asstring := '0:00:00';            //2017 просили сохранять факт без даты окончания операции

        StorProcFactOp.ParamByName('ID_WRKR').asinteger := aOperation^.ID_worker; // работник

        // оборудование может быть не проставлено
        if aOperation^.ID_eqpt > 0 then
          StorProcFactOp.ParamByName('ID_EQPT').asinteger := aOperation^.ID_eqpt  // оборудование
        else
          StorProcFactOp.ParamByName('ID_EQPT').clear;

        StorProcFactOp.Prepare;
        StorProcFactOp.ExecProc;

          lMaterials := aOperation^.lMaterials;

          // добавление материалов операции
          if lMaterials <> nil then

            for j := 0 to lMaterials.Count - 1 do

             begin
                aMaterial := lMaterials.Items[j];

                StorProcFactMTR.ParamByName('ID_OPF').asinteger := IDDOC;           // ID документа
                StorProcFactMTR.ParamByName('LINEOPF').asinteger:= aOperation^.lineno;// номер строки фактической операции
                StorProcFactMTR.ParamByName('LINENO').asinteger := aMaterial^.lineno; // номер строки
                StorProcFactMTR.ParamByName('ID_NMNT').asinteger:= aMaterial^.ID_matr;// ID номенклатуры
                StorProcFactMTR.ParamByName('NUMBER').asfloat   := aMaterial^.nValue; // количество
                StorProcFactMTR.ParamByName('PRICE').asfloat    := aMaterial^.nCost;  // стоимость
                StorProcFactMTR.ParamByName('HIGHT').asfloat    := aMaterial^.nHeight;// высота
                StorProcFactMTR.ParamByName('LENGHT').asfloat   := aMaterial^.nLenght;// длина
                StorProcFactMTR.ParamByName('WIDTH').asfloat    := aMaterial^.nWidth; // ширина
                StorProcFactMTR.ParamByName('WEIGHT').asfloat   := aMaterial^.nWeight;// вес
                StorProcFactMTR.ParamByName('ID_EDIZ').asinteger:= aMaterial^.ID_EDIZ; // единица измерения
                StorProcFactMTR.ParamByName('ID_STRG').asinteger:= aMaterial^.ID_STRG; // заготовка

                StorProcFactMTR.Prepare;
                StorProcFactMTR.ExecProc;
             end;  // цикла по фактическим материалам


          lEQPTs := aOperation^.lEQPTs;

          // добавление инструментов операции
          if lEQPTs <> nil then
            for j := 0 to lEQPTs.Count - 1 do

              begin
                  aEQPT := lEQPTs.Items[j];
                  ADD_EQPT_FACT_PROC.ParamByName('ID_OPF').asinteger := IDDOC;             // ID документа
                  ADD_EQPT_FACT_PROC.ParamByName('LINEOPF').asinteger:= aOperation^.lineno; // номер строки плановой операции
                  ADD_EQPT_FACT_PROC.ParamByName('LINENO').asinteger := aEQPT^.lineno;  // номер строки
                  ADD_EQPT_FACT_PROC.ParamByName('ID_EQPT').asinteger:= aEQPT^.ID_EQPT; // ID номенклатуры
                  ADD_EQPT_FACT_PROC.ParamByName('NUMBER').asfloat   := aEQPT^.nValue;  // количество
                  ADD_EQPT_FACT_PROC.ParamByName('ID_EDIZ').asinteger   := aEQPT^.ID_EDIZ; // единица измерения

                  // все сохранить в базу
                  ADD_EQPT_FACT_PROC.Prepare;
                  ADD_EQPT_FACT_PROC.ExecProc;

              end;

          lTransports := aOperation^.lTransports;

          // добавление транспорта операции
          if lTransports <> nil then
            for j := 0 to lTransports.Count - 1 do

              begin
                  aTransport := lTransports.Items[j];
                  ADD_TRANSPORT_FACT_PROC.ParamByName('ID_OPF').asinteger := IDDOC;                  // ID документа
                  ADD_TRANSPORT_FACT_PROC.ParamByName('LINEOPF').asinteger:= aOperation^.lineno;     // номер строки плановой операции
                  ADD_TRANSPORT_FACT_PROC.ParamByName('LINENO').asinteger := aTransport^.lineno;     // номер строки
                  ADD_TRANSPORT_FACT_PROC.ParamByName('ID_EQPT').asinteger:= aTransport^.ID_EQPT;    // ID номенклатуры
                  ADD_TRANSPORT_FACT_PROC.ParamByName('NUMBER').asfloat   := aTransport^.nValue;     // количество
                  ADD_TRANSPORT_FACT_PROC.ParamByName('ID_EDIZ').asinteger:= aTransport^.ID_EDIZ; // единица измерения
                  ADD_TRANSPORT_FACT_PROC.ParamByName('COST').asfloat     := aTransport^.Cost;         // Цена м/ч

                  // все сохранить в базу
                  ADD_TRANSPORT_FACT_PROC.Prepare;
                  ADD_TRANSPORT_FACT_PROC.ExecProc;

              end;


          // Запись затрат по операции
          lCosts := aOperation^.lCalcs;

          if lCosts <> nil then
           for j := 0 to lCosts.Count - 1 do
            begin
              aCosts  := lCosts.Items[j];

              StorProcOperCalc.ParamByName('ID_ORDER').asinteger := IDDoc;
              StorProcOperCalc.ParamByName('LINE_OP').asinteger  := aOperation^.lineno; // строка операции
              StorProcOperCalc.ParamByName('LINENO').asinteger   := aCosts^.lineno;     // номер строки
              StorProcOperCalc.ParamByName('ID_CALC').asinteger  := aCosts^.ID_calc;    // ID статьи операции
              StorProcOperCalc.ParamByName('NVALUE').asfloat     := aCosts^.nvalue;     // значение

              StorProcOperCalc.Prepare;
              StorProcOperCalc.ExecProc;

            end;

      end; // цикла по фактическим операциям


      // проведение транзакции по затратам
      if lMainCosts <> nil then

       for j := 0 to lMainCosts.Count - 1 do

        begin
           aCosts := lMainCosts.Items[j];

           StorProcCalc.ParamByName('ID').asinteger     := IDDoc;
           StorProcCalc.ParamByName('LINENO').asinteger := aCosts^.lineno;
           StorProcCalc.ParamByName('ID_CALC').asinteger:= aCosts^.ID_calc;
           StorProcCalc.ParamByName('NVALUE').asfloat   := aCosts^.nvalue;
           StorProcCalc.Prepare;
           StorProcCalc.ExecProc;

        end;


     data.RMPBase.Commit;


  except


    Data.RMPBase.Rollback; {on failure, undo the changes;}
    raise; {raise the exception to prevent a call to CommitUpdates!}


   end;

  // далее необходимо обновить таблицу журналов заказов

  if ParentRQSTForm <> nil then
   begin
    parentRQSTForm.FormTableQuery.ParamByName('id').asinteger := ParentId;
    refreshQuery(parentRQSTForm.FormTableQuery);
   end;


  if mainForm.JR_ORDER_Form_Main <> nil then
    if Param_form.glUpdateJROrder then
      refreshQuery(data.JROrderFormQuery);

  if mainForm.JR_RQSTForm_Main <> nil then
    refreshQuery(data.JRRQSTFormOrderQuery);

  // обновление журнала произвоственного
  if mainForm.JR_PROD_MAIN <> nil then
    refreshQuery(mainForm.JR_PROD_MAIN.qFormQuery);


  // обновление журнала планового
  if mainForm.JR_PLAN_MAIN <> nil then
    refreshQuery(mainForm.JR_PLAN_MAIN.qFormQuery);

  result := true;
end;






{
************************************************************
  Процедуры обработки нажатия кнопок формы

}
{
  Нажатие кнопки ОК
}
procedure TDOC_ORDERForm.ButtonClickOK(Sender: TObject);

var ID_PR: integer;
    cancreate : boolean;
    qFindQuery: tQuery;

    aNMNT     : pNMNT;
    aNMNTDoc  : pNMNTDoc;
    lNMNT     : tList;
    lNMNTDoc  : tList;

    Ini:TIniFile;
    FileName : String;

begin
  // если транзакция выполнена успешно, то закрывается форма.



  if SaveDoc = false then

    begin

       data.RMPBase.Rollback;
       exit;

    end;

   WasAnyChanges := false;
   
   // Если заказ закрыт, то для заказов можно предложить ввести документ
   // прихода готовой продукции на склад, а для заказов на ремонт к тому же
   // еще и документ расхода со склада "Акт выполненных работ".

   if PR_EXEC2.Checked then

   begin

       // создание структуры для ввода на основании
       new(aNMNTDoc);
       new(aNMNT);
       lNMNT    := tList.create;
       lNMNTDoc := tList.create;

         aNMNT^.ID_matr  := qNMNTQuery.Fieldbyname('ID').asinteger;
         aNMNT^.Name_matr:= NMNTCombo.Text;
         aNMNT^.nValue   := number_f.value;

         if  aNMNT^.nValue <> 0 Then
            aNMNT^.Price    := Get_sum_order_by_calc(IDDoc, -1) / aNMNT^.nValue
         else
            aNMNT^.Price    := 0;

         // вес изделия
         aNMNT^.nWeight  := WeightEdit.Value;   

         aNMNT^.ID_ORDER := IDDoc;
         aNMNT^.NumDocOrd:= strtoInt(trim(OrderNumber.Text));

           // формирование запроса для нахождения единицы измерения
           qFindQuery := tQuery.Create(self);
           with qFindQuery do
             begin
              databasename := data.RMPBase.DatabaseName;
              close;
              Sql.clear;
              Sql.add('select a.id, a.name from spr_ediz a, spr_nmnt b');
              Sql.add('where a.id = b.id_ediz and ');
              Sql.add('  b.id = :id');
              Parambyname('ID').asinteger := qNMNTQuery.Fields[0].asinteger;
             end;

           qFindQuery.open;

         // единица измерения номенклатуры выбрана из справочника номенклатуры
         if not qFindQuery.Eof then
           begin
            aNMNT^.ID_EdIz   := qFindQuery.Fields[0].asinteger;
            aNMNT^.Name_EdIz := qFindQuery.Fields[1].asstring;
           end
         else // иначе по умолчанию
           begin
            aNMNT^.ID_EdIz   := param_form.qEDIZQuery.Fields[0].asinteger;
            aNMNT^.Name_EdIz := param_form.EDIZCombo.text;
              mymessage('Не заполнена единица измерения в номенклатуре заказа');
           end;



         // формирование запроса для нахождения ID исполнителя в справочнике организаций
         with qfindQuery do
          begin
            sql.clear;
            sql.add('select id, name from spr_cst where code = :code');
            parambyname('code').asstring := qPDRQuery.fieldbyname('code').asstring;
            open;
            first;

          end;

         // шапка документа
         aNMNTDoc^.ID_CST  := qfindQuery.fields[0].asinteger;
         aNMNTDoc^.Name_CST:= qfindQuery.fields[1].asstring;
         aNMNTDoc^.ID_WRHS := Param_Form.qWRHSQuery.Fields[0].asinteger;
         aNMNTDoc^.Name_WRHS := Param_Form.WRHSCombo.Text;

         // тип документа
         if  glVid_CHRT = 1 then
          aNMNTDoc^.Type_doc:= 1
         else
          aNMNTDoc^.Type_doc:= 0;

         lNMNT.add(aNMNT);
         aNMNTDoc^.lNMNT := lNMNT;

         lNMNTDoc.add(aNMNTDoc);

         cancreate := true;

         // если заказ закончен, то можно ввести документ "Приходная накладная"

          // ввод нового документа на основании

         // вызов фунции проверки существования документа прихода.
         // при возвращении -1 документ уже существует.
         if CreateNewPR_Doc(IDDoc, self, 0, lNMNTDoc) > 0 then

           begin
            // спросить у пользователя необходимость ввода приходной
            if messagedlg('Заказ закрыт. Ввести приход на склад готовой продукции?',
                    mtConfirmation, [mbYes, mbNo], 0) = mrYes then


              begin
                // Проверка расчета заказа. Ввод на основании
                // возможен только на основании рассчитанного документа.
                if Sum_order = 0 then

                  if MessageDlg('Стоимость заказа равна 0. Продолжить?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then

                     cancreate := false;

                if cancreate then

                  begin

//                   // Проверим, есть ли закрытые операции в текущем периоде
//                   qfindQuery.SQL.Clear;
//                   qfindQuery.SQL.add('select id_order from jr_prod');
//                   qfindQuery.SQL.add('where id_order = :id_order and period = :period');
//                   qfindQuery.Params[0].asinteger := iddoc;
//                   qfindQuery.Params[1].asinteger := Param_Form.CurFactPeriod;
//                   qfindQuery.Open;
//
//                    if qfindQuery.Eof then
//                      MessageDlg('Нет закрытых операций в текущем периоде.', mtWarning, [mbOK], 0);

                    //   вызов функции создания приходного документа на основании заказа
                    //
                    ID_PR := CreateNewPR_Doc(IDDoc, self, 1, lNMNTDoc);

                      // Если заказ был на выполнение работ, то можно сразу ввести
                      // и акт выполненных работ
                      if glVID_CHRT = 1 then // Vid_chrt.Caption = 'Вид работ: ремонт' then

                        if ID_PR > 0 then

                           if MessageDlg('Заказ на выполнение работ. '+#13+#10+'Ввести акт выполненных работ?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk then

                             begin
                               aNMNTDoc := lNMNTDoc.Items[0];

                                 // формирование запроса на нахождение заказчика
                                 with qfindQuery do
                                    begin
                                      sql.clear;

                                      sql.add('select b.name, b.id as id_cst, a.id_cst');
                                      sql.add('from dh_rqst a, spr_cst b where a.id = ' + inttostr(parentID) + ' and a.id_cst = b.id');
                                      open;
                                      first;

                                    end;

                               aNMNTDoc^.ID_CST   := qfindQuery.Fields[1].asinteger;
                               aNMNTDoc^.Name_CST := qfindQuery.Fields[0].asstring;
                               aNMNTDoc^.Type_doc := 2;

                               //   вызов функции создания расходного документа на основании
                               //     приходного документа
                               //
                               if not CreateNewRS_Doc(ID_PR, 2, datein.text, self, lNMNTDoc) > 0 then
                                 MessageDlg('Раходный документ не создан.', mtError, [mbOK], 0);

                             end;



                  end;


              end;


           end
            else MessageDlg('Не забудьте изменить приходный документ!!!', mtInformation, [mbOk], 0);



   end; // проверки PR_EXEC


//  if MessageDlg('Закрыть форму документа?',
//        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//    close;

    if not DirectoryExists('c:\RmpTemp') then
       if not CreateDir('C:\RmpTemp') then
         raise Exception.Create('Немогу сохранить временные данные по чертежу в c:\RmpTemp');

{     if not DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp') then
        if not CreateDir(GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp') then
          raise Exception.Create('Немогу сохранить временные данные по чертежу в '+GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp');}

    if DirectoryExists('c:\RmpTemp') then
//    if DirectoryExists(GetEnvironmentVariable('APPDATA') + '\EnumRMP\RmpTemp') then
    begin
//       FileName := GetEnvironmentVariable('APPDATA') + '\EnumRMP\rmp.ini';    //1/12/10
       FileName := {ExtractFilePath(Application.EXEName) +} 'c:\RmpTemp\rmp.ini';
       //Процедура записи кода последнего сохраненного элемента в rmp.ini
       Ini:=TIniFile.Create(FileName);

       //Следующий оператор заносит в ключ Journal раздела Sprav значение 'Подразделение':
       Ini.WriteString('JournalOrder','DateOut', DateOut.Text);

       //Следующие операторы сохраняют содержимое объекта Ini в файле на диске и разрушают объект Ini:
       Ini.UpdateFile;
       Ini.Free;
    end;


end;
{
  Нажатие кнопки Close
}
procedure TDOC_ORDERForm.ButtonClickClose(Sender: TObject);
begin
 // если это был новый документ
  if WasAnyChanges = true then
    case MessageDlg('Сохранить документ?',
        mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
     mrYes:
       begin
         SaveDoc;
         close;
       end;
     mrNo: close;
    end

   else
    close;
end;

{
  Процедура заполнения плановых операций из чертежа
  Описание:
     При автоматическом заполнении операций по номенклатуре производится
     нахождение ID чертежа по выбранной номенклатуре,
     по найденному ID выбираются все плановые операции из справочника SPR_CHRT,
     операции добавляются в документ,
     по найденным операциям находятся материалы в справочнике SPR_MTCH,
     материалы добавляются в документ.

}
procedure TDOC_ORDERForm.ButtonFillClick(Sender: TObject);
var n, k :  integer;
    qOPQuery       : TQuery; // Запрос поиска операций чертежа по ID номенклатуры
    qMTQuery       : TQuery; // запрос поиска материалов операций по ID операции
    qEQQuery       : tQuery; // запрос поиска оборудования операции
    lEQPTs         : tList;
    aEQPT          : pEQPT;
begin
   if not check_user_grand('DT_ORDER1', 'I', true) then
     exit;
   if not check_user_grand('DT_ORDER1', 'D', false) then
     exit;

   if  qCHRTQuery.Eof then
    begin
     MessageDlg('Чертеж не выбран.', mtWarning, [mbOK], 0);
     exit;
    end;

  DocumentChange;
  if messagedlg('Заполнить операции на основании чертежа? '+#13+#10+'Перед заполнением таблица будет очищена.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin

      // формирование промежуточного запроса для выполнения операции 1 (см. описание процедуры)
      qOPQuery := tQuery.create(self);
      qOPQuery.DatabaseName := data.RMPBase.DatabaseName;

      // формирование запроса для нахождения операций по чертежу
      qOPQuery.sql.clear;
      qOPQuery.sql.add('select a.number, b.name, a.rating, a.ntime / 1000, a.price, a.id, b.id');
      qOPQuery.sql.add('from spr_opch a,  spr_vop b');
      qOPQuery.sql.add('where a.id_chrt = :id_chrt and a.id_vop = b.id');
      qOPQuery.sql.add('order  by number');
      qOPQuery.ParamByName('id_chrt').asinteger := qCHRTQuery.FieldByName('id').asinteger;

      // выполнение запроса  и позиционировaние на начало выборки
      qOPQuery.open;
      qOPQuery.First;

      // создание запроса для нахождения материалов плановой операции чертежа
      qMTQuery := tQuery.create(self);
      qMTQuery.DatabaseName := data.RMPBase.DatabaseName;
      qMTQuery.SQL.add('select b.name, a.number, b.price, b.id, a.lenght, a.hight, a.width, a.weight, a.ID_STRG,');
      qMTQuery.SQL.add('(select strg.name from spr_strg strg where strg.id = a.id_strg) as strg_name,');
      qMTQuery.SQL.add('a.id_ediz,');
      qMTQuery.SQL.add('(select ediz.name from spr_ediz ediz where ediz.id = a.id_ediz) as ediz_name');
      qMTQuery.SQL.add('from spr_mtch a, spr_nmnt b');
      qMTQuery.SQL.add('where a.id_opch = :ID_OPCH and b.id = a.id_nmnt');

      // создание запроса для нахождения инструмента плановой операции чертежа
      qEQQuery := tQuery.create(self);
      qEQQuery.DatabaseName := data.RMPBase.DatabaseName;
      qEQQuery.SQL.add('select b.name, a.number, b.id, ');
      qEQQuery.SQL.add('a.id_ediz,');
      qEQQuery.SQL.add('(select ediz.name from spr_ediz ediz where ediz.id = a.id_ediz) as ediz_name');
      qEQQuery.SQL.add('from spr_eqptchrt a, spr_eqpt b');
      qEQQuery.SQL.add('where a.id_opch = :ID_OPCH and b.id = a.id_eqpt');


      n := 1;
      // очистить список плановых операций
      lPlanOperations.Clear;
    //  lMaterials.Clear;

     while not qOPQuery.eof do

       begin
        new(aOperation);
        aOperation^.lineno    := n;                             // номер строки
        aOperation^.Name_op   := qOPQuery.fields[1].asstring;   // наименование операции
        aOperation^.rayting   := qOPQuery.fields[2].asinteger;  // разряд рабочего
        aOperation^.timework  := qOPQuery.fields[3].asfloat;      // норма времени выполнения
        aOperation^.price     := qOPQuery.fields[4].asfloat;    // стоимость
        aOperation^.ID_op     := qOPQuery.fields[6].asinteger;  // ID вида операции

        // Заполнение таблицы плановых материалов
        qMTQuery.Close;
        qMTQuery.ParamByName('ID_OPCH').asinteger :=
                 qOPQuery.fields[5].asinteger;
        qMTQuery.open;
        k := 0;
        n := n + 1;

        // заполнение материалов операции
        lMaterials := tList.Create;

        while not qMTQuery.eof do

           begin
              new(aMaterial);

              aMaterial^.lineno    := k;              // номер строки
              aMaterial^.num_oper  := aOperation^.lineno;
              aMaterial^.Name_matr := qMTQuery.fields[0].asstring; // наименование
              //если чертеж является работай и количество материала стоит 1 (ставили по умолчанию) то ставить 0
              If ((qCHRTQuery.FieldByName('vid_chrt').asinteger = 1) and (qMTQuery.fields[1].asfloat = 1)) Then
              begin
                    aMaterial^.nValue := 0;  //количество
                    aMaterial^.nCost  := 0;  //цена
              end
                else
                begin
                     aMaterial^.nValue    := qMTQuery.fields[1].asfloat; //*Number_P.Value; // количество
                     aMaterial^.nCost     := qMTQuery.fields[2].asfloat; //*Number_P.Value; // цена
                end;
              aMaterial^.ID_matr   := qMTQuery.fields[3].asinteger; // ID номенклатуры
              aMaterial^.nLenght   := qMTQuery.fields[4].asfloat; // длина
              aMaterial^.nHeight   := qMTQuery.fields[5].asfloat; // высота
              aMaterial^.nWidth    := qMTQuery.fields[6].asfloat; // ширина
              aMaterial^.nWeight   := qMTQuery.fields[7].asfloat; // вес
              aMaterial^.ID_STRG   := qMTQuery.fields[8].asinteger; // ID заготовки
              aMaterial^.STRG_NAME := qMTQuery.fields[9].asstring; // ID заготовки
              aMaterial^.ID_EDIZ   := qMTQuery.fields[10].asinteger; // ID заготовки
              aMaterial^.EDIZ_NAME := qMTQuery.fields[11].asstring; // ID заготовки


              qMTQuery.Next;

              lMaterials.Add(aMaterial);
              k := k + 1;
           end;

         aOperation^.lMaterials := lMaterials;


        // Заполнение таблицы плановых инструментов
        qEQQuery.Close;
        qEQQuery.ParamByName('ID_OPCH').asinteger :=
                 qOPQuery.fields[5].asinteger;
        qEQQuery.open;
        k := 1;

        // заполнение инструмента операции
        lEQPTs := tList.Create;

        while not qEQQuery.eof do

           begin
              new(aEQPT);

              aEQPT^.lineno    := k;              // номер строки
              aEQPT^.num_oper  := aOperation^.lineno;
              aEQPT^.Name_EQPT := qEQQuery.fields[0].asstring; // наименование
              aEQPT^.nValue    := qEQQuery.fields[1].asfloat; // количество
              aEQPT^.ID_EQPT   := qEQQuery.fields[2].asinteger; // ID обрудования
              aEQPT^.ID_EDIZ   := qEQQuery.fields[3].asinteger; // единица
              aEQPT^.EDIZ_NAME := qEQQuery.fields[4].asstring;  // измерения

              qEQQuery.Next;

              lEQPTs.Add(aEQPT);
              k := k + 1;
           end;

         aOperation^.lEQPTs := lEQPTs;

        // заполнение транспортных средств операции
         lTransports := tList.Create;
         aOperation^.lTransports := lTransports;

         qOPQuery.next;

         lPlanOperations.Add(aOperation);
       end;


  end;


   fill_table(self);

end;
{

    Процедуры работы с таблицами заказа:
      плановые операции,
      плановые материалы операции,
      фактические операции,
      фактические материалы операции,
      затраты.



   Процедура добавления плановой операции
}
procedure TDOC_ORDERForm.ButtonAddPlanOpClick(Sender: TObject);
 var Form : TDOCT_OPERForm;
begin
  // в запрос для формирования плановых операций необходимо указать
   if not check_user_grand('DT_ORDER1', 'I', true) then
     exit;

   DocumentChange;

  // Создание новой формы редактирования операции
  Form := TDOCT_OPERForm.createN(self, 1, IDDoc); // вызов формы редактирования операций для добавления плановой  (IDDoc добавлено 3.11.05)

  Form.showmodal;

  Form.Close;

   fill_table(self);
end;
{

   Процедура редактирования плановой операции

}
procedure TDOC_ORDERForm.ButtonEditPlOpClick(Sender: TObject);
var Form : TDOCT_OPERForm;
begin
  // если есть что редактировать
  if Grid_OperPlan.cells[1, 1] = '' then exit;
  DocumentChange;  // признак изменения документа

  // Создание формы редактирования операции
  Form := TDOCT_OPERForm.createN(self, 2, IDDoc); // вызов формы редактирования  (IDDoc добавлено 3.11.05)
                                           // операции заказа
     Form.OKButton.Enabled := check_user_grand('DT_ORDER1', 'U', true);

  Form.showmodal;

  Form.Close;

   fill_table(self);
end;

{
   Процедура удаления плановой операции
  При удалении производится сдвиг вверх всех строк и уменьшается их количество.
}
procedure TDOC_ORDERForm.ButtonDelPlOpClick(Sender: TObject);
begin

 if lPlanOperations = nil then exit;
 if lPlanOperations.Count = 0 then exit;

   if not check_user_grand('DT_ORDER1', 'D', true) then
     exit;

   DocumentChange;  // признак изменения документа

   if messagedlg('Удалить операцию?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

      lPlanOperations.Delete(Grid_OperPlan.row -1);

   fill_table(self);

end;

{
  Процедура сдвига плановой операции вверх
}
procedure TDOC_ORDERForm.ButtonUpPlOpClick(Sender: TObject);
begin
  Change_enum_list_pos(lPlanOperations, Grid_OperPlan.row - 1, Grid_OperPlan.row - 2);
  if Grid_OperPlan.row > 1 then Grid_OperPlan.row := Grid_OperPlan.row - 1;

   fill_table(self);

end;

{
  Процедура сдвига плановой операции вниз
}
procedure TDOC_ORDERForm.ButtonDownPlOpClick(Sender: TObject);
begin

  Change_enum_list_pos(lPlanOperations, Grid_OperPlan.row - 1, Grid_OperPlan.row);
  if Grid_OperPlan.row < (Grid_OperPlan.RowCount - 1) then Grid_OperPlan.row := Grid_OperPlan.row + 1;

   fill_table(self);

end;
{
  Процедура добавления планового материала
}
procedure TDOC_ORDERForm.ButtonAddPlMatClick(Sender: TObject);
var Form : TDOCT_MTRForm;
    aOp  : pOperation;

begin
   DocumentChange;
  // если есть что редактировать в плановых материалах
  if Grid_OperPlan.cells[1, Grid_OperPlan.row] = '' then exit;
  // вызов конструктора формы редактирования номенклатуры плановой операции
  aOp  := lPlanOperations.Items[Grid_OperPlan.row - 1];
  Form := TDOCT_MTRForm.createN(aOp, 1, -1);
  Form.aOperate := aOP;

  Form.showmodal;
      Form.Close;

   fill_table(self);

  
end;
{
   Процедура редактирования планового материала
}
procedure TDOC_ORDERForm.ButtonEditPlMatClick(Sender: TObject);
//var Form : TDOCT_MTRForm;
//    aOp  : pOperation;

begin
//   DocumentChange;
//
//  // если есть что редактировать в плановых материалах
//  if GridMTRPlan.cells[1, 1] = '' then exit;
//
//  // вызов конструктора формы редактирования номенклатуры плановой операции
//  aOp  := lPlanOperations.Items[Grid_OperPlan.row - 1];
//  Form := TDOCT_MTRForm.createN(aOp, 2, GridMTRPlan.row - 1);
//  Form.aOperate := aOP;
//
//  Form.showmodal;
//
//  Grid_OperPlan.Refresh;
//
//  Form.Close;
//
//   fill_table(self);
end;
{
    Процедура удаления планового материала
}
procedure TDOC_ORDERForm.ButtonDelPlMatClick(Sender: TObject);

begin

   if messagedlg('Удалить материал?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

    begin

      aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
      lMaterials := aOperation^.lMaterials;

      if lMaterials <> nil then
        if lMaterials.Count > 0 then
          lMaterials.Delete(GridMTRPlan.row - 1);

    end;

   fill_table(self);

end;
{
   Процедура сдвига планового материала вверх
}
procedure TDOC_ORDERForm.ButtonUpPlMatClick(Sender: TObject);

begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  lMaterials := aOperation^.lMaterials;

  Change_enum_list_pos(lMaterials, GridMTRPlan.row - 1, GridMTRPlan.row - 2);
  if  GridMTRPlan.Row > 1 then GridMTRPlan.Row := GridMTRPlan.Row - 1;

   fill_table(self);
end;
{
   Процедура сдвига планового материала вниз
}
procedure TDOC_ORDERForm.ButtonDownPlMatClick(Sender: TObject);

begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  lMaterials := aOperation^.lMaterials;

  Change_enum_list_pos(lMaterials, GridMTRPlan.row - 1, GridMTRPlan.row);
  if  GridMTRPlan.Row < (GridMTRPlan.RowCount - 1) then GridMTRPlan.Row := GridMTRPlan.Row + 1;

   fill_table(self);
end;






{

    Процедура добавления фактической операции

}
procedure TDOC_ORDERForm.ButtonAddFactOpClick(Sender: TObject);
var Form : TDOCT_OPERForm;
    row : integer;
    aPlanOp : pOperation;
    i : integer;
    aPlanMtr: pMaterial;
    aPlanEQPT, aEQPT : pEQPT;
    aPlanTransport, aTransport : pTransport;
    lPlanMTR: tList;
    lFactMTR: tList;
    lPlanEQPT : tList;
    lFactEQPT : tList;
    lPlanTransport : tList;
    lFactTransport : tList;

begin
   if not check_user_grand('DT_ORDER2', 'I', true) then
     exit;

  // в запрос для формирования плановых операций необходимо указать
  DocumentChange;

  // Создание формы ввода новой операции
  If (Grid_OperFact.cells[3, Grid_OperFact.Rowcount-1] <> '.  .') and (Grid_OperFact.cells[4, Grid_OperFact.Rowcount-1] = '.  .') Then  //2017 просили сохранять факт без даты окончания операции
  begin                                                                                             //2017 просили сохранять факт без даты окончания операции
     ShowMessage('Не закрыта предыдущая операция');                                                 //2017 просили сохранять факт без даты окончания операции
     exit;                                                                                         //2017 просили сохранять факт без даты окончания операции
  end                                                                                               //2017 просили сохранять факт без даты окончания операции
   else                                                                                             //2017 просили сохранять факт без даты окончания операции
      Form := TDOCT_OPERForm.createN(self, 3, IDDoc); // вызов формы добавления фактической операции   (IDDoc добавлено 3.11.05)

  // в качестве новой операции проставляется следующая плановая операция,
  // если таковая еще есть
  // заполнение поля "Вид операции"

  if Grid_OperFact.cells[2, 1] <> '' then
    row := Grid_OperFact.Rowcount
  else
    row := 1;

  //  Проверка. Есть ли вообще плановые операции и количество плановых больше,
  // чем количество фактических.
  if lPlanOperations <> nil then

   if (lPlanOperations.Count > 0) and (row  <= lPlanOperations.Count) then

    begin
      aPlanOp := lPlanOperations.Items[row - 1];

      Form.VOPCombo.text := aPlanOp^.Name_op; // название операции
      Form.VOPCombo.ID   := aPlanOp^.ID_op;

      // заполнение полей по данным плановой операции
      Form.NumberEdit.text := inttostr(aPlanOp^.lineno);  // номер строки
      Form.NTimeEdit.text  := FormatFloat( '0.000', aPlanOp^.timework);// продолжительность
      Form.ratingEdit.text := inttostr(aPlanOp^.rayting);              // разряд рабочего
      Form.PriceEdit.text  := FormatFloat( '0.00', aPlanOp^.price);  // стоимость

      Form.DateBEG.Text    := aPlanOp^.Date_beg;
      Form.DateEND.Text    := aPlanOp^.Date_end;
      if  (trim(aPlanOp^.time_beg) <> '') and (trim(aPlanOp^.time_beg) <> ':') then
        Form.TimeBEG.time    := strtotime(aPlanOp^.time_beg);

      if  (trim(aPlanOp^.time_end) <> '') and (trim(aPlanOp^.time_end) <> ':') then
        Form.TimeEND.time    := strtotime(aPlanOp^.time_end);

      Form.WRKRCombo.ID := aPlanOp^.ID_worker;
      Form.EQPTCombo.ID := aPlanOp^.ID_eqpt;

      lFactMtr := tList.Create;

      // скопируем материалы плановые в фактические

      if aPlanOp^.lMaterials <> nil then
        if aPlanOp^.lMaterials.Count > 0 then
          begin
             lPlanMTR := aPlanOp^.lMaterials;

             for i := 0 to lPlanMTR.Count - 1 do
               begin
                 aPlanMtr := lPlanMTR.Items[i];
                 new(aMaterial);

                 aMaterial.lineno    := aPlanMtr.lineno;
                 aMaterial.num_oper  := aPlanOp.lineno;
                 aMaterial.ID_matr   := aPlanMtr.ID_matr;
                 aMaterial.Name_matr := aPlanMtr.Name_matr;
                 aMaterial.nValue    := aPlanMtr.nValue;
                 aMaterial.nCost     := aPlanMtr.nCost;
                 aMaterial.nLenght   := aPlanMtr.nLenght;
                 aMaterial.nHeight   := aPlanMtr.nHeight;
                 aMaterial.nWidth    := aPlanMtr.nWidth;
                 aMaterial.nWeight   := aPlanMtr.nWeight;
                 aMaterial.ID_STRG   := aPlanMtr.ID_STRG;
                 aMaterial.ID_EDIZ   := aPlanMtr.ID_EDIZ;
                 aMaterial.STRG_NAME := aPlanMtr.STRG_NAME;
                 aMaterial.EDIZ_NAME := aPlanMtr.EDIZ_NAME;

                 lFactMtr.Add(aMaterial);
               end;
          end;



      // скопируем инструменты плановые в фактические

      lFactEQPT := tList.Create;

      if aPlanOp^.lEQPTs <> nil then
        if aPlanOp^.lEQPTs.Count > 0 then
          begin
             lPlanEQPT := aPlanOp^.lEQPTs;

             for i := 0 to lPlanEQPT.Count - 1 do
               begin
                 aPlanEQPT := lPlanEQPT.Items[i];
                 new(aEQPT);

                 aEQPT.lineno    := aPlanEQPT.lineno;
                 aEQPT.num_oper  := aPlanOp.lineno;
                 aEQPT.ID_EQPT   := aPlanEQPT.ID_EQPT;
                 aEQpT.Name_EQPT := aPlanEQPT.Name_EQPT;
                 aEQPT.nValue    := aPlanEQPT.nValue;
                 aEQPT.ID_EDIZ   := aPlanEQPT.ID_EDIZ;
                 aEQPT.EDIZ_NAME := aPlanEQPT.EDIZ_NAME;

                 lFactEQPT.Add(aEQPT);
               end;
          end;

      // скопируем транспорт плановый в фактический

      lFactTransport := tList.Create;

      if aPlanOp^.lTransports <> nil then
        if aPlanOp^.lTransports.Count > 0 then
          begin
             lPlanTransport := aPlanOp^.lTransports;

             for i := 0 to lPlanTransport.Count - 1 do
               begin
                 aPlanTransport := lPlanTransport.Items[i];
                 new(aTransport);

                 aTransport.lineno    := aPlanTransport.lineno;
                 aTransport.num_oper  := aPlanOp.lineno;
                 aTransport.ID_EQPT   := aPlanTransport.ID_EQPT;
                 aTransport.Name_EQPT := aPlanTransport.Name_EQPT;
                 aTransport.nValue    := aPlanTransport.nValue;
                 aTransport.ID_EDIZ   := aPlanTransport.ID_EDIZ;
                 aTransport.EDIZ_NAME := aPlanTransport.EDIZ_NAME;
                 aTransport.Cost      := aPlanTransport.Cost;

                 lFactTransport.Add(aTransport);
               end;
          end;



      Form.aOperation^.lMaterials := lFactMtr;
      Form.aOperation^.lEQPTs     := lFactEQPT;
      Form.aOperation^.lTransports:= lFactTransport;
      Form.aOperation.lineno      := aPlanOp.lineno;

      MakeSelectMTR(  Form.GridFactMtr,  aPlanOp^.lMaterials, lFactOperations, ShowAllFactMtr.Down);
      MakeSelectEQPT( Form.GridFactEQPT, aPlanOp^.lEQPTs,     lFactOperations, ShowAllFactEQPT.Down);
      MakeSelectTransport( Form.GridFactTransport, aPlanOp^.lTransports,     lFactOperations, ShowAllFactTransport.Down);


    end
   // Плановых операций больше нет.
   else
    begin
      // заполнение параметров для запроса по операциям
      Form.qVOPQuery.ParamByName('Code').asInteger := -1;
      Form.qVOPQuery.ParamByName('ID').asInteger   := -1;
      Form.qVOPQuery.Open;

    end;


  if Form.showmodal = mrOK then
    begin


    {
      При заполнении фактической операции нужно проверить фактические операции.
      Если она последняя, то заказ можно закрыть. Если нет, то ответственное
      подразделение будет другим.

    }
       check_fact_operation(self);

       // расчет итоговых затрат
       ButtonClickCalc(Sender);

    end;

   Form.Close;

   fill_table(self);
end;
{
   Процедура редактирования фактической операции
}
procedure TDOC_ORDERForm.ButtonEditFactOpClick(Sender: TObject);
var Form : TDOCT_OPERForm;
begin

  // если есть что редактировать
  if Grid_OperFact.cells[1, 1] = '' then exit;
  DocumentChange;

  // Создание формы редактирования операций фактических
  Form := TDOCT_OPERForm.createN(self, 4, IDDoc); // вызов формы редактирования фактической операции (IDDoc добавлено 3.11.05)

   if not check_user_grand('DT_ORDER2', 'U', true) then
     begin
       Form.OKButton.Enabled := false;
       Form.Button_Calc.Enabled := false;
       Form.CalcButton.Enabled  := false;
     end;

  if Form.showmodal = mrOK then
    begin


    {
      При заполнении фактической операции нужно проверить фактические операции.
      Если она последняя, то заказ можно закрыть. Если нет, то ответственное
      подразделение будет другим.

    }
       check_fact_operation(self);

       // расчет итоговых затрат
       ButtonClickCalc(Sender);
    end;

  Form.Close;

   fill_table(self);
end;
{
   Процедура удаления фактической операции
}
procedure TDOC_ORDERForm.ButtonDelFactOpClick(Sender: TObject);
begin


   if not check_user_grand('DT_ORDER2', 'D', true) then
     exit;

 if lFactOperations = nil then exit;
 if lFactOperations.Count = 0 then exit;

  if messagedlg('Удалить операцию?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin

      lFactOperations.Delete(Grid_OperFact.row -1);

       // расчет итоговых затрат
       ButtonClickCalc(Sender);

    end;

   fill_table(self);

end;
{
    Процедура сдвига факт. операции вверх
}
procedure TDOC_ORDERForm.ButtonUpFactOpClick(Sender: TObject);
begin
  Change_enum_list_pos(lFactOperations, Grid_OperFact.row - 1, Grid_OperFact.row - 2);
  if Grid_OperFact.row > 1 then Grid_OperFact.row := Grid_OperFact.row - 1;

   fill_table(self);

end;
{
   Процедура сдвига факт операции вниз
}
procedure TDOC_ORDERForm.ButtonDownFactOpClick(Sender: TObject);
begin

  Change_enum_list_pos(lFactOperations, Grid_OperFact.row - 1, Grid_OperFact.row);
  if Grid_OperFact.row < (Grid_OperFact.rowcount - 1) then Grid_OperFact.row := Grid_OperFact.row + 1;

   fill_table(self);
end;
{
   Процедура добавления фактического материала
}
procedure TDOC_ORDERForm.ButtonAddFactMtClick(Sender: TObject);
var Form : TDOCT_MTRForm;
    aOp  : pOperation;

begin
   DocumentChange;
  // если есть что редактировать в плановых материалах
  if Grid_OperFact.cells[1, Grid_OperFact.row] = '' then exit;

  // вызов конструктора формы редактирования номенклатуры плановой операции
  aOp  := lFactOperations.Items[Grid_OperFact.row - 1];
  Form := TDOCT_MTRForm.createN(aOp, 3, -1);
  Form.aOperate := aOP;

  Form.showmodal;
      Form.Close;

   fill_table(self);
end;
{
    Процедура редактирования фактического материала
}
procedure TDOC_ORDERForm.ButtonEditFactMtClick(Sender: TObject);
//var Form : TDOCT_MTRForm;
//    aOp  : pOperation;

begin
//
//   DocumentChange;
//
//  // если есть что редактировать в плановых материалах
//  if GridFactMTR.cells[1, 1] = '' then exit;
//
//  // вызов конструктора формы редактирования номенклатуры плановой операции
//  aOp  := lFactOperations.Items[Grid_OperFact.row - 1];
//  Form := TDOCT_MTRForm.createN(aOp, 4, GridFactMtr.row - 1);
//  Form.aOperate := aOP;
//
//  Form.showmodal;
//
//  Form.Close;
//
//   fill_table(self);
end;
{
    Процедура удаления фактического материала
}
procedure TDOC_ORDERForm.ButtonDelFactMtClick(Sender: TObject);

begin
   if messagedlg('Удалить материал?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

    begin

      aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
      lMaterials := aOperation^.lMaterials;

      if lMaterials <> nil then
       if lMaterials.Count > 0 then
        lMaterials.Delete(GridFactMTR.row - 1);

    end;

   fill_table(self);

end;
{
    Процедура сдвига фактического материала вверх
}
procedure TDOC_ORDERForm.ButtonUpFactMtClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  lMaterials := aOperation^.lMaterials;

  Change_enum_list_pos(lMaterials, GridFactMTR.row - 1, GridFactMTR.row - 2);
   if GridFactMTR.Row > 1 then GridFactMTR.Row := GridFactMTR.Row - 1;

   fill_table(self);
end;
{
    Процедура сдвига фактического материала вниз
}
procedure TDOC_ORDERForm.ButtonDownFactMtClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  lMaterials := aOperation^.lMaterials;

  Change_enum_list_pos(lMaterials, GridFactMTR.row - 1, GridFactMTR.row);
    if GridFactMTR.Row < (GridFactMTR.RowCount - 1) then GridFactMTR.Row := GridFactMTR.Row + 1;

   fill_table(self);

end;
{
    Процедура добавления затрат
}
procedure TDOC_ORDERForm.ButtonAddCalcClick(Sender: TObject);
var Form : TDOCT_CALCForm;
begin

  if not check_user_grand('DT_ORDER3', 'I', true) then exit;

  DocumentChange;
  // вызов конструктора формы редактирования затрат
  Form := TDOCT_CALCForm.createN(lMainCosts, 1, GridCalc.RowCount + 1);

  Form.showmodal;

  Form.Close;
   fill_table(self);
end;
{
    Процедура редактирования затрат
}
procedure TDOC_ORDERForm.ButtonEditCalcClick(Sender: TObject);
var Form : TDOCT_CALCForm;
begin
  // если есть что редактировать
  if lMainCosts = nil then exit;
  if lMainCosts.count = 0 then exit;
  DocumentChange;

  Form := TDOCT_CALCForm.createN(lMainCosts, 2, GridCalc.row- 1); // вызов формы редактирования затрат

    Form.OKButton.Enabled := check_user_grand('DT_ORDER3', 'U', true);

  Form.showmodal;

  Form.Close;

   fill_table(self);
end;
{
     Процедура удаления затрат
}
procedure TDOC_ORDERForm.ButtonDelCalcClick(Sender: TObject);
begin

  if not check_user_grand('DT_ORDER3', 'D', true) then exit;

  if lMainCosts = nil then exit;
  if lMainCosts.count = 0 then exit;
   if messagedlg('Удалить затраты?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

     lMainCosts.Delete(GridCalc.Row - 1);

   fill_table(self);

end;
{
   Процедура сдвига строки статьи затрат вверх

}
procedure TDOC_ORDERForm.ButtonCalcUpClick(Sender: TObject);
begin

  Change_enum_list_pos(lMainCosts, GridCalc.row - 1, GridCalc.row - 2);
  if GridCalc.row > 1 then GridCalc.row := GridCalc.row - 1;

   fill_table(self);
end;
{
   Процедура сдвига строки статьи затрат вниз

}
procedure TDOC_ORDERForm.ButtonCalcDownClick(Sender: TObject);
begin
  Change_enum_list_pos(lMainCosts, GridCalc.row - 1, GridCalc.row);
    if GridCalc.row < (GridCalc.rowcount - 1) then GridCalc.row := GridCalc.row + 1;

   fill_table(self);

end;



{
    Процедура выбора из справочника "Заводы"
}
procedure TDOC_ORDERForm.PlantComboButtonClick(Sender: TObject);
begin
  PlantCombo.Color := clWindow;
  SelectFromTable(PlantCombo);
end;
{
     Процедура выбора из справочника "Подразделения"
}
procedure TDOC_ORDERForm.PDRComboButtonClick(Sender: TObject);
begin
  PDRCombo.Color := clWindow;
  SelectFromTable(PDRCombo);
  // заполнить поле "Статистика"
  fill_stat_field(self);
end;
{
    Процедура выбора из справочника "Подразделения"
}
procedure TDOC_ORDERForm.IDCostComboButtonClick(Sender: TObject);
begin
  IDCostCombo.Color := clWindow;
  SelectFromTable(IDCostCombo);

end;


{
    Процедура выбора из справочника "Номенклатура"
}
procedure TDOC_ORDERForm.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(NMNTCombo);

end;
{
    Процедура выбора из справочника "Счет"
}
procedure TDOC_ORDERForm.CountComboButtonClick(Sender: TObject);
begin
  SelectFromTable(CountCombo);

end;


{
    Процедура выбора из справочника "МВП"
}
procedure TDOC_ORDERForm.MVPComboButtonClick(Sender: TObject);
begin

  SelectFromTable(MVPCombo);


end;

{
    Процедура выбора из справочника "Статистика"
}
procedure TDOC_ORDERForm.StatComboButtonClick(Sender: TObject);
begin

  SelectFromTable(StatCombo);


end;
{
    Процедура выбора из справочника "Оборудование"
}
procedure TDOC_ORDERForm.EQPTComboButtonClick(Sender: TObject);
begin


  SelectFromTable(EQPTCombo);



end;






{
    Процедура выбора из справочника "Чертеж"
}
procedure TDOC_ORDERForm.CHRTComboButtonClick(Sender: TObject);
begin
  CHRTCombo.Color := clWindow;

  SelectFromTable(ChrtCombo);

  if qCHRTQuery.Active then

    begin

     // заполнение поля "Оборудование" на основании введённого чертежа

     Fill_EQPT_Combo(CHRTCombo, EQPTCombo);

     // заполнение поля "НОменклатура" на основании введенного чертежа
     Fill_NMNT_Combo(CHRTCombo, NMNTCombo);

     WeightEdit.value := FindWeightByChrt(qCHRTQuery.FieldByName('ID').asinteger);

     // опознание вида чертежа
     SetVidChrt(self);

    end; 

end;

{
  При редактировании поля "Завод" нажали кнопку клавы
}
procedure TDOC_ORDERForm.PlantComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   if checkIfExistCode(PlantCombo, key, Shift) = false then
     PlantComboButtonClick(Sender);


  DocumentChange;


end;


{
  При редактировании поля "Подразделение" нажали кнопку клавы
}
procedure TDOC_ORDERForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if checkIfExistCode(PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);


  DocumentChange;
  fill_stat_field(self);

end;

procedure TDOC_ORDERForm.IDCostComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(IDCostCombo, key, Shift) = false then
     IDCostComboButtonClick(Sender);


  DocumentChange;

end;



{
  При редактировании поля "Номенклатура" нажали кнопку клавы
}
procedure TDOC_ORDERForm.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if checkIfExistCode(NMNTCombo, key, Shift) = false then
     NMNTComboButtonClick(Sender);


  DocumentChange;


end;


{
  При редактировании поля "Оборудование" нажали кнопку клавы
}

procedure TDOC_ORDERForm.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if checkIfExistCode(EQPTCombo, key, Shift) = false then

     EQPTComboButtonClick(Sender);


  DocumentChange;

end;

{
  При редактировании поля "Счет" нажали кнопку клавы
}
procedure TDOC_ORDERForm.CountComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if checkIfExistCode(CountCombo, key, Shift) = false then
     CountComboButtonClick(Sender);

  DocumentChange;


end;

{
  При редактировании поля "МВП" нажали кнопку клавы
}
procedure TDOC_ORDERForm.MVPComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if checkIfExistCode(MVPCombo, key, Shift) = false then
     MVPComboButtonClick(Sender);

  DocumentChange;


end;


{
  При редактировании поля "статистика" нажали кнопку клавы
}

procedure TDOC_ORDERForm.StatComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if checkIfExistCode(StatCombo, key, Shift) = false then
     StatComboButtonClick(Sender);


  DocumentChange;

end;

{
  При редактировании поля "Чертеж" нажали кнопку клавы
}
procedure TDOC_ORDERForm.CHRTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if checkIfExistCode(CHRTCombo, key, Shift) = false then
     CHRTComboButtonClick(Sender);

  DocumentChange;

  // заполнение поля "НОменклатура" на основании введенного чертежа
  Fill_NMNT_Combo(CHRTCombo, NMNTCombo);

  WeightEdit.value := FindWeightByChrt(qCHRTQuery.FieldByName('ID').asinteger);

   // опознание вида чертежа
   SetVidChrt(self);


end;


{
   Процедура изменения даты начала

}
procedure TDOC_ORDERForm.DateInChange(Sender: TDateEdit);
begin
  Sender.Color := clWindow;
  valueChange(sender);
end;






//             ------- конец кнопок ----------------
// *****************************************************************************

{
   Процедура при открытии формы
}
procedure TDOC_ORDERForm.FormShow(Sender: TObject);
begin

  // формирование структуры таблиц
  // таблица плановых операций
  Grid_OperPlan.Cells[1,0] := 'Номер';
  Grid_OperPlan.Cells[2,0] := 'Операция';
  Grid_OperPlan.Cells[3,0] := 'Разряд рабочего';
  Grid_OperPlan.Cells[4,0] := 'Время';
  Grid_OperPlan.Cells[5,0] := 'Стоимость';
  Grid_OperPlan.cells[6,0] := 'ID ОПЕРАЦИИ';
  Grid_OperPlan.cells[7,0] := 'ID ВИДА ОПЕРАЦИИ';


  // таблица плановых материалов
  GridMTRPlan.Cells[1,0]   := 'Строка';
  GridMTRPlan.Cells[2,0]   := 'Материал';
  GridMTRPlan.Cells[3,0]   := 'Количество';
  GridMTRPlan.Cells[4,0]   := 'Стоимость';
  GridMTRPlan.Cells[5,0]   := 'Операция';

  // таблица плановых инструментов
  GridEQPTPlan.Cells[1,0]   := 'Строка';
  GridEQPTPlan.Cells[2,0]   := 'Инструмент';
  GridEQPTPlan.Cells[3,0]   := 'Ед. изм.';
  GridEQPTPlan.Cells[4,0]   := 'Количество';

  // таблица плановых транспортных средств
  GridTransportPlan.Cells[1,0]   := 'Строка';
  GridTransportPlan.Cells[2,0]   := 'Транспортное средство';
  GridTransportPlan.Cells[3,0]   := 'Ед. изм.';
  GridTransportPlan.Cells[4,0]   := 'Количество';
  GridTransportPlan.Cells[5,0]   := 'Стоимость';

  // таблица фактических операций
  Grid_OperFact.Cells[1,0]   := 'Номер';
  Grid_OperFact.Cells[2,0]   := 'Операция';
  Grid_OperFact.Cells[3,0]   := 'Дата начала';
  Grid_OperFact.Cells[4,0]   := 'Дата окончания';
  Grid_OperFact.Cells[5,0]   := 'Работник';
  Grid_OperFact.Cells[6,0]   := 'Станок';
  Grid_OperFact.Cells[7,0]   := 'Продолжительность';
  Grid_OperFact.Cells[8,0]   := 'Стоимость';
  {  В остальных колонках таблицы Grid_OperFact хранится информация:
     9  - ID вида операции;
     10 - ID работника;
     11 - ID станка;
     12 - разряд рабочего;
     13 - время начала работ;
     14 - время окончания работ.
     Эти колонки не выводятся на экран. Информация из них берется в момент открытия
     формы редактирования операции.

  }
  // таблица фактических материалов
  GridFactMtr.Cells[1,0]   := 'Строка';
  GridFactMtr.Cells[2,0]   := 'Материал';
  GridFactMtr.Cells[3,0]   := 'Количество';
  GridFactMtr.Cells[4,0]   := 'Стоимость';
  GridFactMtr.Cells[5,0]   := 'Операция';

  // таблица фактических инструментов
  GridEQPTFact.Cells[1,0]   := 'Строка';
  GridEQPTFact.Cells[2,0]   := 'Инструмент';
  GridEQPTFact.Cells[3,0]   := 'Ед. изм.';
  GridEQPTFact.Cells[4,0]   := 'Количество';

  // таблица фактических Транспортных средств
  GridTransportFact.Cells[1,0]   := 'Строка';
  GridTransportFact.Cells[2,0]   := 'Транспортное средство';
  GridTransportFact.Cells[3,0]   := 'Ед. изм.';
  GridTransportFact.Cells[4,0]   := 'Количество';
  GridTransportFact.Cells[5,0]   := 'Стоимость';


  // таблица затрат
  GridCalc.Cells[1,0]   := 'Строка';
  GridCalc.Cells[2,0]   := 'Затраты';
  GridCalc.Cells[3,0]   := 'Величина';


end;

{
   При изменении позиции строки плановой таблицы операции измениются
   значения плановой таблицы материалов
}
procedure TDOC_ORDERForm.Grid_OperPlanSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var aOp : pOperation;
begin
  if ARow <> Grid_OperPlan.row then
    begin
      aOp := lPlanOperations.Items[aRow - 1];
      MakeSelectMTR(GridMTRPlan, aOp^.lMaterials, lPlanOperations, ShowAllPlanMtr.Down);
      MakeSelectEQPT(GridEQPTPlan, aOp^.lEQPTs,   lPlanOperations, ShowAllPlanEQPT.Down);
      MakeSelectTransport(GridTransportPlan, aOp^.lTransports, lPlanOperations, ShowAllPlanEQPT.Down);
    end;
end;
{
   При изменении позиции строки фактической таблицы операции измениются
   значения фактической таблицы материалов
}
procedure TDOC_ORDERForm.Grid_OperFactSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var aOp : pOperation;

begin
  if ARow <> Grid_OperFact.row then
    begin
      aOP := lFactOperations.Items[aRow - 1];
      MakeSelectMTR(GridFactMTR,   aOp^.lMaterials, lFactOperations, ShowAllFactMtr.Down);
      MakeSelectEQPT(GridEQPTFact, aOp^.lEQPTs,   lFactOperations, ShowAllFactEQPT.Down);
      MakeSelectTransport(GridTransportFact, aOp^.lTransports, lFactOperations, ShowAllFactTransport.Down);
    end;
end;
{
********************************************************

   Обработка нажатия кнопок в таблицах

 Таблица плановых операций
}
procedure TDOC_ORDERForm.Grid_OperPlanKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelPlOpClick(Sender);   // удаление записи
    45 :  ButtonAddPlanOpClick(Sender); // Добавление по Ins
    13 :  ButtonEditPlOpClick(Sender);  // Редактирование по Enter
  end;
end;
{
   Нажата кнопка в таблице плановых материалов
}
procedure TDOC_ORDERForm.GridMTRPlanKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  case Key of
//    46 :  ButtonDelPlMatClick(Sender);   // удаление записи
//    45 :  ButtonAddPlMatClick(Sender); // Добавление по Ins
//    13 :  ButtonEditPlMatClick(Sender);  // Редактирование по Enter
//  end;
end;
{
  Нажата кнопка в таблице фактических операций
}
procedure TDOC_ORDERForm.Grid_OperFactKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelFactOpClick(Sender);   // удаление записи
    45 :  ButtonAddFactOpClick(Sender); // Добавление по Ins
    13 :  ButtonEditFactOpClick(Sender);  // Редактирование по Enter
  end;
end;
{
   Нажата кнопка в таблице фактических материалов
}
procedure TDOC_ORDERForm.GridFactMtrKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  case Key of
//    46 :  ButtonDelFactMtClick(Sender);   // удаление записи
//    45 :  ButtonAddFactMtClick(Sender); // Добавление по Ins
//    13 :  ButtonEditFactMtClick(Sender);  // Редактирование по Enter
//  end;
end;
{
   Нажата кнопка в таблице затрат
}
procedure TDOC_ORDERForm.GridCalcKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ButtonDelCalcClick(Sender);   // удаление записи
    45 :  ButtonAddCalcClick(Sender); // Добавление по Ins
    13 :  ButtonEditCalcClick(Sender);  // Редактирование по Enter
  end;
end;



{

      Процедура рассчета затрат заказа

      Общие затраты рассчитываются как сумма всех затрат фактических операций.

}
procedure TDOC_ORDERForm.ButtonClickCalc(Sender: TObject);

begin
  if not check_user_grand('DT_ORDER3', 'I', true) then exit;
   if not check_user_grand('DT_ORDER3', 'U', false) then exit;

   OrderCalculation(lFactOperations, lMainCosts, number_f.value);

   // формирование информационной строки
   Create_OrderInfostring(self, IDDoc);

   fill_table(self);

end;



{

   Процедура печати маршрутной карты
}
procedure TDOC_ORDERForm.PrintMapButtonClick(Sender: TObject);
begin
   if iddoc < 0 then exit;

   if DLLHandle = 0 then
     DLLhandle := loadLibrary('PrintForm');

     ProcAddr := GetProcAddress(DLLHandle , 'Print_map_form');

     if ProcAddr <> nil then
     begin
       Print_map_form := ProcAddr;
       // вызов функции печати из библиотеки
       Print_map_form(application, application.MainForm, IDDoc, data.RMPBase);
     end;

end;

{
   Процедура формирования печатной формы калькуляции

}
procedure TDOC_ORDERForm.ButtonClickPrintCalct(Sender: TObject);
begin


   if iddoc < 0 then exit;
   if lMainCosts.Count < 2 then exit;


   // проверим на корректность печати калькуляции
   if Grid_OperFact.RowCount > 1 then
     begin

      aOperation := lFactOperations.Items[Grid_OperFact.RowCount - 2];

       if (aOperation^.Date_end <> '') or (trim(aOperation^.Date_end) <> '.  .') then
         if beginofmonth(now) > beginofmonth(strtodate(aOperation^.Date_end)) then
           MessageDlg('Текущий период больше даты последней операции', mtWarning, [mbOK], 0);

     end;


   if DLLHandle = 0 then
     DLLhandle := loadLibrary('PrintForm');


     ProcAddr := GetProcAddress(DLLHandle , 'Print_calc_form');
     if ProcAddr <> nil then
       begin
         Print_calc_form := ProcAddr;
         // вызов функции печати из библиотеки
         Print_calc_form(application, self, IDDoc, data.RMPBase);
       end;



end;
{
   Процедура формирования печатной формы фактической маршрутной карты

}

procedure TDOC_ORDERForm.PrintMapFactButtonClick(Sender: TObject);
begin
   if iddoc < 0 then exit;

   if DLLHandle = 0 then
     DLLhandle := loadLibrary('PrintForm');

     ProcAddr := GetProcAddress(DLLHandle , 'Print_mapFact_form');

     if ProcAddr <> nil then
       begin
         Print_mapFact_form := ProcAddr;
         // вызов функции печати из библиотеки
         Print_mapFact_form(application, self, IDDoc, data.RMPBase);

       end;


end;





procedure TDOC_ORDERForm.ShowAllPlanMtrClick(Sender: TObject);
begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  MakeSelectMTR( GridMtrPlan, aOperation^.lMaterials, lPlanOperations, ShowAllPlanMtr.Down);
end;

procedure TDOC_ORDERForm.ShowAllFactMtrClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  MakeSelectMTR( GridFactMtr, aOperation^.lMaterials, lFactOperations, ShowAllFactMtr.Down);
end;

procedure TDOC_ORDERForm.ButtonRecalcWeightClick(Sender: TObject);
begin
  if lFactOperations.Count > 0 then
   begin
    aOperation      := lFactOperations.Items[Grid_OperFact.row - 1];
    WeightEdit.text := FormatFloat('0.000', aOperation^.timework);
   end
    else
      WeightEdit.text := '0';

end;

procedure TDOC_ORDERForm.CHRTComboChange(Sender: TObject);
begin
   DocumentChange;

   // заполнение поля "Оборудование" на основании введенного чертежа
  Fill_EQPT_Combo(CHRTCombo, NMNTCombo);

   // заполнение поля "НОменклатура" на основании введенного чертежа
  Fill_NMNT_Combo(CHRTCombo, NMNTCombo);

  WeightEdit.value := FindWeightByChrt(qCHRTQuery.FieldByName('ID').asinteger);

   // опознание вида чертежа
   SetVidChrt(self);

end;

procedure TDOC_ORDERForm.ButtonAddPlEQPTClick(Sender: TObject);
begin
  //
end;

procedure TDOC_ORDERForm.ButtonUpPlEQPTClick(Sender: TObject);
begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  lEQPTs := aOperation^.lEQPTs;

  Change_enum_list_pos(lEQPTs, GridEQPTPlan.row - 1, GridEQPTPlan.row - 2);
  if  GridEQPTPlan.Row > 1 then GridEQPTPlan.Row := GridEQPTPlan.Row - 1;

   fill_table(self);

end;

procedure TDOC_ORDERForm.ButtonDownPlEQPTClick(Sender: TObject);
begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  lEQPTs := aOperation^.lEQPTs;

  Change_enum_list_pos(lEQPTs, GridEQPTPlan.row - 1, GridEQPTPlan.row);
  if  GridEQPTPlan.Row < (GridEQPTPlan.RowCount - 1) then GridEQPTPlan.Row := GridEQPTPlan.Row + 1;

   fill_table(self);

end;

procedure TDOC_ORDERForm.ShowAllPlanEQPTClick(Sender: TObject);
begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  MakeSelectEQPT( GridEQPTPlan, aOperation^.lEQPTs,
     lPlanOperations, ShowAllPlanEQPT.Down);

end;

procedure TDOC_ORDERForm.ButtonUpFactEQPTClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  lEQPTs := aOperation^.lEQPTs;

  Change_enum_list_pos(lEQPTs, GridEQPTFact.row - 1, GridEQPTFact.row - 2);
   if GridEQPTFact.Row > 1 then GridEQPTFact.Row := GridEQPTFact.Row - 1;

   fill_table(self);

end;

procedure TDOC_ORDERForm.ButtonDownFactEQPTClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  lEQPTs := aOperation^.lEQPTs;

  Change_enum_list_pos(lEQPTs, GridEQPTFact.row - 1, GridEQPTFact.row);
    if GridEQPTFact.Row < (GridEQPTFact.RowCount - 1) then GridEQPTFact.Row := GridEQPTFact.Row + 1;

   fill_table(self);


end;

procedure TDOC_ORDERForm.ShowAllFactEQPTClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  MakeSelectEQPT( GridEQPTFact, aOperation^.lEQPTs,
      lFactOperations, ShowAllFactEQPT.Down);

end;

procedure TDOC_ORDERForm.ButtonUpFactTransportClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  lTransports := aOperation^.lTransports;

  Change_enum_list_pos(lTransports, GridTransportFact.row - 1, GridTransportFact.row - 2);
   if GridTransportFact.Row > 1 then GridTransportFact.Row := GridTransportFact.Row - 1;

   fill_table(self);

end;

procedure TDOC_ORDERForm.ButtonDownFactTransportClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  lTransports := aOperation^.lTransports;

  Change_enum_list_pos(lTransports, GridTransportFact.row - 1, GridTransportFact.row);
    if GridTransportFact.Row < (GridTransportFact.RowCount - 1) then GridTransportFact.Row := GridTransportFact.Row + 1;

   fill_table(self);

end;

procedure TDOC_ORDERForm.ShowAllFactTransportClick(Sender: TObject);
begin
  aOperation := lFactOperations.Items[Grid_OperFact.row - 1];
  MakeSelectTransport( GridTransportFact, aOperation^.lTransports,
      lFactOperations, ShowAllFactTransport.Down);

end;

procedure TDOC_ORDERForm.ButtonUpPlTransportClick(Sender: TObject);
begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  lTransports := aOperation^.lTransports;

  Change_enum_list_pos(lTransports, GridTransportPlan.row - 1, GridTransportPlan.row - 2);
  if  GridTransportPlan.Row > 1 then GridTransportPlan.Row := GridTransportPlan.Row - 1;

   fill_table(self);
end;

procedure TDOC_ORDERForm.ButtonDownPlTransportClick(Sender: TObject);
begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  lTransports := aOperation^.lTransports;

  Change_enum_list_pos(lTransports, GridTransportPlan.row - 1, GridTransportPlan.row);
  if  GridTransportPlan.Row < (GridTransportPlan.RowCount - 1) then GridTransportPlan.Row := GridTransportPlan.Row + 1;

   fill_table(self);

end;

procedure TDOC_ORDERForm.ShowAllPlanTransportClick(Sender: TObject);
begin
  aOperation := lPlanOperations.Items[Grid_OperPlan.row - 1];
  MakeSelectTransport( GridTransportPlan, aOperation^.lTransports,
     lPlanOperations, ShowAllPlanTransport.Down);
end;

procedure TDOC_ORDERForm.Action1Execute(Sender: TObject);
begin

end;

//
//   Процедура  ChangeRecDocExecute
//   Описание: изменяет родительскую заявку документа
//   вызывается по нажатию секретных кнопок Ctrl+Alt+C
//
procedure TDOC_ORDERForm.ChangeRecDocExecute(Sender: TObject);
var _Query : tQuery;
begin
   if RQSTCombo.Enabled then
      RQSTCombo.Enabled := false
    else
      RQSTCombo.Enabled := true;

  ChangeRQSTButton.Visible := RQSTCombo.Enabled;

end;


procedure TDOC_ORDERForm.ChangeRQSTButtonClick(Sender: TObject);
begin
  with qTMPQuery do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select id from dh_rqst where number = ' + trim(RQSTCombo.Text));
      open;
    end;
   if qTMPQuery.Eof then
    MessageDlg('Заявка не найдена!', mtWarning, [mbOK], 0)
   else
    begin
      MessageDlg('Заявка найдена!', mtWarning, [mbOK], 0);
      ParentID := qTMPQuery.Fields[0].AsInteger;

    end;
      RQSTCombo.Enabled        := false;
      ChangeRQSTButton.Visible := false;
end;

end.
