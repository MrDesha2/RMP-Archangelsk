unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, ImgList, ToolWin, ExtCtrls, EnumForm, EnumTreeForm,
  JRORDERForm, JRRQSTForm, JRPlanFactForm, JROperForm, JRGantForm, RxCalc,
  StdCtrls, DB, DBTables, JREQPTRSPRForm, JRWRKRSERTForm;


type

  StandardProc = procedure(ParentApplication: tApplication;
    ParentForm : tForm; Base : tDataBase); stdcall;


  TMAINForm = class(TForm)
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuEnums: TMenuItem;
    MenuEnumCHRT: TMenuItem;
    MenuEnumEQPT: TMenuItem;
    MenuClose: TMenuItem;
    MainStatusBar: TStatusBar;
    MenuEnumCST: TMenuItem;
    MenuEnumMVZ: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    MenuEnumOther: TMenuItem;
    MenuEnumVHR: TMenuItem;
    MenuEnumNMNT: TMenuItem;
    N13: TMenuItem;
    MenuEnumVOP: TMenuItem;
    MenuEnumCALC: TMenuItem;
    MenuEnumWRKR: TMenuItem;
    MenuEnumPROF: TMenuItem;
    MenuEnumPOST: TMenuItem;
    MenuEnumWRHS: TMenuItem;
    MenuEnumSTAT: TMenuItem;
    MenuEnumEDIZ: TMenuItem;
    MenuEnumMOD: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N16: TMenuItem;
    MenuEnumTPEQ: TMenuItem;
    MenuEnumMVP: TMenuItem;
    N30: TMenuItem;
    MenuEnumPLANT: TMenuItem;
    MenuEnumCOUNT: TMenuItem;
    MenuEnumVMVZ: TMenuItem;
    MenuDocs: TMenuItem;
    MenuReports: TMenuItem;
    MenuServis: TMenuItem;
    MenuHelp: TMenuItem;
    MenuRQSTDoc: TMenuItem;
    MenuRQSTJrn: TMenuItem;
    MenuORDRJrn: TMenuItem;
    MenuPlanJrn: TMenuItem;
    MenuProdJrn: TMenuItem;
    MenuPRDoc: TMenuItem;
    MenuRSDoc: TMenuItem;
    MenuPRDocJrn: TMenuItem;
    MenuRSDocJrn: TMenuItem;
    MenuJorn: TMenuItem;
    N40: TMenuItem;
    N42: TMenuItem;
    N46: TMenuItem;
    MenuParameters: TMenuItem;
    MenuDataChange: TMenuItem;
    MenuHelpHelp: TMenuItem;
    N55: TMenuItem;
    MenoHelpAbout: TMenuItem;
    MenuWin: TMenuItem;
    MenuCloseAll: TMenuItem;
    MenuTile: TMenuItem;
    K1: TMenuItem;
    JRImageList: TImageList;
    MainImages: TImageList;
    MenuEnumSPRG: TMenuItem;
    N1: TMenuItem;
    Calculator: TMenuItem;
    CalculatorDialog: TRxCalculator;
    ControlBar: TControlBar;
    ToolBar_ENUMS: TToolBar;
    Tool_CHRT: TToolButton;
    Tool_NMNT: TToolButton;
    Tool_EQPT: TToolButton;
    Tool_CST: TToolButton;
    Tool_PDR: TToolButton;
    Tool_wrkr: TToolButton;
    ToolBar_Docs: TToolBar;
    Tool_RQST: TToolButton;
    Tool_PRDOC: TToolButton;
    Tool_RSDOC: TToolButton;
    ToolBar_JR: TToolBar;
    Tool_JRRQST: TToolButton;
    Tool_JRORDER: TToolButton;
    Tool_JRPR: TToolButton;
    Tool_JRRS: TToolButton;
    Tool_Sep_1: TToolButton;
    MenuPRMTR: TMenuItem;
    MenuRSMTR: TMenuItem;
    N5: TMenuItem;
    MenuPRMTRJR: TMenuItem;
    MenuRSMTRJR: TMenuItem;
    ToolBar_MTR: TToolBar;
    ToolButtonAddMTR: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Print_Report_28: TMenuItem;
    N2: TMenuItem;
    PopupMenuControlBar: TPopupMenu;
    IsEnumPanelShow: TMenuItem;
    IsDocPanelShow: TMenuItem;
    IsJRPanelShow: TMenuItem;
    IsMtrPanelShow: TMenuItem;
    ToolBar_Custom: TToolBar;
    ToolButtonAbout: TToolButton;
    IsSysPanelShow: TMenuItem;
    MenuEnumCalend: TMenuItem;
    MenuOperJrn: TMenuItem;
    MenuOpenGant: TMenuItem;
    N3: TMenuItem;
    ToolButtonCalc: TToolButton;
    ToolButtonHelp: TToolButton;
    PanelMessage: TPanel;
    MessageWin: TMemo;
    IsMessWinShow: TMenuItem;
    MenuEnumBrigade: TMenuItem;
    N4: TMenuItem;
    MenuMtrOrder: TMenuItem;
    N6: TMenuItem;
    MenuJRMtrOrder: TMenuItem;
    MenuEnumSertificate: TMenuItem;
    News: TMenuItem;
    N7: TMenuItem;
    MenuPREQPT: TMenuItem;
    MenuRSEQPT: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    MenuJRPREQPT: TMenuItem;
    MenuJRRSEQPT: TMenuItem;
    ToolBar_Tool: TToolBar;
    ToolButtonAddEQPT: TToolButton;
    ToolButtonDelEQPT: TToolButton;
    ToolButtonJRADDEQPT: TToolButton;
    ToolButtonJRDELEQPT: TToolButton;
    MenuRQSTEQPT: TMenuItem;
    MenuJRRQSTEQPT: TMenuItem;
    IsToolPanelShow: TMenuItem;
    N10: TMenuItem;
    MenuPRModelDoc: TMenuItem;
    MenuRSModelDoc: TMenuItem;
    N17: TMenuItem;
    MenuJRPrModel: TMenuItem;
    MenuJRRSModel: TMenuItem;
    N11: TMenuItem;
    MenuEnumACCESS: TMenuItem;
    N15: TMenuItem;
    MENUEqptToWrkr: TMenuItem;
    N18: TMenuItem;
    WrkrSert: TMenuItem;
    procedure MenuCloseClick(Sender: TObject);
    procedure MenuEnumCHRTClick(Sender: TObject);
    procedure MenuEnumEQPTClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuEnumCSTClick(Sender: TObject);
    procedure MenuEnumMVZClick(Sender: TObject);
    procedure MenuEnumVHRClick(Sender: TObject);
    procedure MenuEnumNMNTClick(Sender: TObject);
    procedure MenuEnumEDIZClick(Sender: TObject);
    procedure MenuEnumWRHSClick(Sender: TObject);
    procedure MenuEnumSTATClick(Sender: TObject);
    procedure MenuEnumVOPClick(Sender: TObject);
    procedure MenuEnumPROFClick(Sender: TObject);
    procedure MenuEnumPOSTClick(Sender: TObject);
    procedure MenuEnumCALCClick(Sender: TObject);
    procedure MenuEnumWRKRClick(Sender: TObject);
    procedure MenuEnumTPEQClick(Sender: TObject);
    procedure MenuEnumPLANTClick(Sender: TObject);
    procedure MenuEnumMVPClick(Sender: TObject);
    procedure MenuEnumCOUNTClick(Sender: TObject);
    procedure MenuEnumVMVZClick(Sender: TObject);
    procedure MenuEnumMODClick(Sender: TObject);
    procedure MenuRQSTDocClick(Sender: TObject);
    procedure MenuRQSTJrnClick(Sender: TObject);
    procedure MenuORDRJrnClick(Sender: TObject);
    procedure MenuPRDocClick(Sender: TObject);
    procedure MenuRSDocClick(Sender: TObject);
    procedure MenuPRDocJrnClick(Sender: TObject);
    procedure MenuRSDocJrnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MenuPlanJrnClick(Sender: TObject);
    procedure MenuProdJrnClick(Sender: TObject);
    procedure MenuParametersClick(Sender: TObject);
    procedure MenuTileClick(Sender: TObject);
    procedure MenuCascadeClick(Sender: TObject);
    procedure MenuCloseallClick(Sender: TObject);
    procedure MenoHelpAboutClick(Sender: TObject);
    procedure MenuHelpHelpClick(Sender: TObject);
    procedure MenuEnumSPRGClick(Sender: TObject);
    procedure Print_Report_Click(Sender: TObject);
    procedure CalculatorClick(Sender: TObject);
    procedure MenuPRMTRClick(Sender: TObject);
    procedure MenuRSMTRClick(Sender: TObject);
    procedure MenuPRMTRJRClick(Sender: TObject);
    procedure MenuRSMTRJRClick(Sender: TObject);
    procedure IsPanelShowClick(Sender: TObject);
    procedure MenuEnumCalendClick(Sender: TObject);
    procedure MenuOperJrnClick(Sender: TObject);
    procedure MenuOpenGantClick(Sender: TObject);
    procedure MenuEnumBrigadeClick(Sender: TObject);
    procedure MenuMtrOrderClick(Sender: TObject);
    procedure MenuJRMtrOrderClick(Sender: TObject);
    procedure MenuEnumSertificateClick(Sender: TObject);
    procedure NewsClick(Sender: TObject);
    procedure MenuPREQPTClick(Sender: TObject);
    procedure MenuRSEQPTClick(Sender: TObject);
    procedure MenuJRPREQPTClick(Sender: TObject);
    procedure MenuJRRSEQPTClick(Sender: TObject);
    procedure MenuRQSTEQPTClick(Sender: TObject);
    procedure MenuJRRQSTEQPTClick(Sender: TObject);
    procedure MenuPRModelDocClick(Sender: TObject);
    procedure MenuRSModelDocClick(Sender: TObject);
    procedure MenuJRPrModelClick(Sender: TObject);
    procedure MenuJRRSModelClick(Sender: TObject);
    procedure MenuEnumACCESSClick(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure MENUEqptToWrkrClick(Sender: TObject);
    procedure WrkrSertClick(Sender: TObject);

  private
    Print_Report: StandardProc;  // процедура для вызова внешней функции

  public
    EnumTreeEdit: TLIST_TREEEDITForm; {Форма для редактирования древовидного справочника}
    EnumForm: TLIST_EDITForm;
    IsFolder: integer;
    ID: Integer;
    ParentID: Integer;
    WorkDate: tdate;                      // рабочая дата
    JR_ORDER_Form_Main : TJR_ORDERForm;   // форма журнала заказов
    JR_RQSTForm_Main   : TJR_RQSTForm;    // форма журнала заявок
    JR_PLAN_MAIN       : TJR_PLANFACTForm;// форма планового журнала заказов
    JR_PROD_MAIN       : TJR_PLANFACTForm;// форма производственного журнала заказов
    JR_OPER_MAIN       : TJR_OPERForm;    // Форма оперативного журнала //добавлена 28.07.04
    JR_GANT_MAIN       : TJR_GANTForm;
    JR_EQPTRSPRForm    : TJR_EQPTRSPRForm;// Форма движения иснтурмента
    JR_WRKRSertForm    : TJR_EQPTRSPRForm;// Форма имения сертификата

end;

var
  MAINForm: TMAINForm;
  EscPressed         : boolean;         // признак нажатой клавиши Ecs для поиска
  Searching           : boolean;         // признак поиска в таблице
  DLLHandle          : tHandle;         // дескриптор библиотеки печати

  
implementation

uses    Base,
     MVZEdit,   // форма редактирования элемента справочника "Подразделения (МВЗ)"
     CSTEdit,   // форма редактирования элемента справочника "Организации"
    NMNTEdit,   // форма редактирования элемента справочника "Номенклатура"
    CHRTEdit,   // форма редактирования элемента справочника "Чертеж"
    EQPTEdit,   // форма редактирования элемента справочника "Оборудование"
    WRKREdit,   // форма редактирования элемента справочника "Работник"
EnumSTRGEdit,   // форма редактирования элемента справочника "Виды заготовок"
     VOPEdit,   // форма редактирования элемента справочника "Вид операции"
    WRHSEdit,   // форма редактирования элемента справочника "Склад"
    VCHREdit,   // форма редактирования элемента справочника "Вид чертежа"
    CALCEdit,   // форма редактирования элемента справочника "Затраты"
 BrigadeEdit,   // форма редактирования элемента справочника "Бригады"
     MDLEdit,   // форма редактирования элемента справочника "Модели"
EnumAccesstypeEdit, // форма редактирования элемента справочника "Типы допуска"

 ReqEditForm,   // форма редактирования документа "Заявка"
OrderEditForm,  // форма редактирования документа "Заказ"
PRDocEditForm,  // форма редактирования документа "Приходная накладная"
RSDocEditForm,  // форма редактирования документа "Расходная накладная"
PRMTRDocEditForm,  // форма редактирования документа "Поступление материалов"
RSMTRDocEditForm,  // форма редактирования документа "Отпуск материалов"
DocMTROrder,    // форма редактирования документаа "Заказ на материалы"

  JRPRDocForm,  // форма редактирования журнала документов "Приход готовой продукции"
  JRRSDocForm,  // форма редактирования журнала документов "Отпуск готовой продукции"
JRRSMTRForm,    // форма редактирования журнала документов "Приход материала"
JRPRMTRForm,    // форма редактирования журнала документов "Отпуск материала"
     TPEQEdit,  // форма редактирования элемента справочника "Типы оборудования"
JRMTROrderForm, // форма редактирования журнала документов "заказ на материалы"
PREQPTEditForm, // Форма редактирования документа "Поступление инструмента"
JRPREQPTDocForm,// Форма редактирования журнала документов "Поступление инструмента"
RSEQPTEditForm, // Форма редактирования документа "Списание инструмента"
JRRSEQPTDocForm,// Форма редактирования журнала документов "Списание инструмента"
RQSTEQPTEditForm,//Форма редактирования документа "Заявка на инструмент"
JRRQSTEQPTDocForm,//Форма редактирования журнала документов "Заявка на инструмент"
PRModelEditForm,  //Форма редактирования документа "Поступление моделей"
RSModelEditForm,  //Форма редактирования документа "Выбытие моделей"
JRPRMODELDocForm, //Форма редактирования журнала документов "Поступление моделей"
JRRSModelDocForm, //Форма редактирования журнала документов "Выбытие моделей"


     MyCalend,  // форма производственного календаря

    ParamForm,
         libs,
        About,
    MainFormLib;

{$R *.DFM}

{
    Процедура загрузки библиотеки печати при открытии формы

}




{
   Процедура инициализации системы при открытии формы
}
procedure TMAINForm.FormCreate(Sender: TObject);
begin

 {Типа глобальная процедура при начале работы системы}
 mainstatusbar.Panels.Items[2].Text := 'ТД: ' + DateToStr(Date);

 // формирование основного меню программы
 Make_main_menu(self);

 if not load_dll then
   close;

end;



procedure TMAINForm.MenuCloseClick(Sender: TObject);
begin
  close;
end;




{
   Процедура открытия справочника Чертежей


}

procedure TMAINForm.MenuEnumCHRTClick(Sender: TObject);
begin


  if CheckOfOpened('Справочник: Чертежи', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Чертежи',
                                'SPR_CHRT', TENUM_CHRTForm);
  EnumTreeEdit.show;


end;

{Процедура открытия справочника Оборудования}
procedure TMAINForm.MenuEnumEQPTClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Оборудование', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Оборудование',
                                        'SPR_EQPT', TENUM_EQPTForm);
  EnumTreeEdit.show;
end;


{Процедура открытия справочника Организаций}
procedure TMAINForm.MenuEnumCSTClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Организации', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Организации',
                                        'SPR_CST', TENUM_CSTForm);
  EnumTreeEdit.show;
end;

{Процедура открытия справочника МВЗ}
procedure TMAINForm.MenuEnumMVZClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: МВЗ', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: МВЗ',
                                'SPR_PDR', TENUM_MVZForm);
  EnumTreeEdit.show;
end;

//
// Процедура вызова формы редактирования справочника "Виды характеристики"
//
procedure TMAINForm.MenuEnumVHRClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Виды характеристики', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Виды характеристики',
                                'SPR_VCHR', 'SPR_VCHR_GEN', TENUM_VCHRForm);
  EnumForm.show;

end;

//
// Процедура вызова формы редактирования справочника "Номенклатура"
//
procedure TMAINForm.MenuEnumNMNTClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Номенклатура', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Номенклатура',
                                'SPR_NMNT', TENUM_NMNTForm);

  EnumTreeEdit.show;
end;

{
  Процедура вызова редактирования справочника Единицы измерения
}
procedure TMAINForm.MenuEnumEDIZClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Единицы измерения', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Единицы измерения',
                                'SPR_EDIZ', 'SPR_EDIZ_GEN', nil);
  EnumForm.show;
end;
{
  Процедура вызова редактирования справочника "Склады"
}
procedure TMAINForm.MenuEnumWRHSClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Склады', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Склады',
                                'SPR_WRHS', TENUM_WRHSForm);
  EnumTreeEdit.show;

end;
{
  Процедура вызова редактирования справочника "Статистика"
}
procedure TMAINForm.MenuEnumSTATClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Статистика', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Статистика',
                                'SPR_STAT', 'SPR_STAT_GEN', nil);
  EnumForm.show;

end;
//
// Процедура редактирования справоника "Виды операций"
//
procedure TMAINForm.MenuEnumVOPClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Виды операций', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Виды операций',
                                        'SPR_VOP', TENUM_VOPForm);
  EnumTreeEdit.show;

end;

//
//  Процедура вызова редактирования справочника "Профессия"
//
procedure TMAINForm.MenuEnumPROFClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Профессии', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Профессии',
                                'SPR_PROF', 'SPR_PROF_GEN', nil);
  EnumForm.show;

end;
//
//  Процедура вызова редактирования справочника "Должности"
//
procedure TMAINForm.MenuEnumPOSTClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Должности', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Должности',
                                'SPR_POST', 'SPR_POST_GEN', nil);
  EnumForm.show;

end;
//
//  Процедура вызова редактирования справочника "Бригады"
//
procedure TMAINForm.MenuEnumBrigadeClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Бригады', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Бригады',
                                'SPR_BRIGADE', 'SPR_BRIGADE_GEN', TENUM_BRIGADEForm);
  EnumForm.show;

end;
//
//  Процедура вызова редактирования справочника "Затраты"
//
procedure TMAINForm.MenuEnumCALCClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Затраты', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Затраты',
                                'SPR_CALC', 'SPR_CALC_GEN', TENUM_CALCForm);
  EnumForm.show;

end;
//
// Процедура вызова формы редактирования справочника
// "Работники"
procedure TMAINForm.MenuEnumWRKRClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Работники', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Работники',
                                'SPR_WRKR', TENUM_WRKRForm);
  EnumTreeEdit.show;

{  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Работники',
                                'SPR_WRKR', 'SPR_WRKR_GEN', TENUM_WRKRForm);
  EnumForm.show;  }

end;
//
// Процедура вызова формы редактирования справочника
// "Типы станков"
procedure TMAINForm.MenuEnumTPEQClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Типы станков', '') = false then exit; // проверка на существование открытых окон

  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Типы станков',
                                        'SPR_TPEQ', TENUM_TPEQ);
  EnumTreeEdit.show;

end;

{

  Процедура открытия формы редактирования
  справочника "Виды заготовок"
}
procedure TMAINForm.MenuEnumSPRGClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Виды заготовок', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Виды заготовок',
                                'SPR_STRG', 'SPR_STRG_GEN', TEnum_STRGForm);

  EnumForm.show;

end;



//
//      Процедура открытия формы редактирования справочника "Заводы"
//
procedure TMAINForm.MenuEnumPLANTClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Заводы', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Заводы',
                                'SPR_PLANT', 'SPR_PLANT_GEN', nil);
  EnumForm.show;

end;


procedure TMAINForm.MenuEnumSertificateClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Аттестация', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Аттестация',
                                'SPR_SERTIFICATE', 'SPR_SERTIFICATE_GEN', nil);
  EnumForm.show;

end;

//
//            Процедура редактирования справочника
//          "Места возникновения прибыли".
//
procedure TMAINForm.MenuEnumMVPClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: МВП', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: МВП',
                                'SPR_MVP', 'SPR_MVP_GEN', nil);
  EnumForm.show;

end;
///
//          Процедура открытия формы редактирования справочника "Счета"
//
procedure TMAINForm.MenuEnumCOUNTClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Счета', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Счета',
                                'SPR_COUNT', 'SPR_COUNT_GEN', nil);
  EnumForm.show;

end;
//
//             Процедура открытия формы редактирования справочника
//                      "Виды МВЗ"
procedure TMAINForm.MenuEnumVMVZClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Виды МВЗ', '') = false then exit; // проверка на существование открытых окон

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Виды МВЗ',
                                'SPR_VIDPDR', 'SPR_VIDPDR_GEN', nil);
  EnumForm.show;

end;
//
//           Процедура вызова формы редактирования
//      справочника "Модели".
//
procedure TMAINForm.MenuEnumMODClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Модели', '') = false then exit; // проверка на существование открытых окон


  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Модели',
                                'SPR_MDL', TENUM_MLDForm);
  EnumTreeEdit.show;

end;

{
  Процедура открытия формы документа "Заявка"
  Вход: пусто;
  Выход: пусто;
  Описание: создает и открывает форму редактирования документа "Заявка"
}
procedure TMAINForm.MenuRQSTDocClick(Sender: TObject);
var DocForm: TDOC_RequestForm;
begin
  if not check_user_grand('DH_RQST', 'I', true) then
    exit;

  if CheckOfOpened('Документ: Заявка', '') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TDOC_RequestForm.CreateN(Self, - 1);
  DocForm.show;

end;

{
   Процедура открытия формы журнала документов "Заявки"
}
procedure TMAINForm.MenuRQSTJrnClick(Sender: TObject);
var Form : TJR_RQSTForm;
    i : integer;
begin
  // проверка среди открытых окон
  for i:= 0 to MainForm.MDIChildCount - 1 do
   if MainForm.MDIChildren[i].Name = 'JR_RQSTForm'
     then
       begin
         JR_RQSTForm_Main.show;
         exit;
       end;

  // если нет среди созданных, то создается и запоминается
  Form := TJR_RQSTForm.Create(self);
  Form.FormActivate(self);
  JR_RQSTForm_Main := Form;


end;
{
  Процедура открытия формы журнала заказов

}
procedure TMAINForm.MenuORDRJrnClick(Sender: TObject);
var Form : TJR_ORDERForm;
    i : integer;
begin

  // проверка среди открытых окон
  for i:= 0 to MainForm.MDIChildCount - 1 do
   if MainForm.MDIChildren[i].Name = 'JR_ORDERForm'
     then
       begin
         JR_ORDER_Form_Main.show;
         exit;
       end;

  Form := TJR_ORDERForm.Create(self);
  Form.FormActivate(self, 1);
  JR_ORDER_Form_Main := Form;

end;

{
  Процедура открытия формы редактирования нового документа "Приходная накладная"
}
procedure TMAINForm.MenuPRDocClick(Sender: TObject);
var DocForm: TDOC_PRForm;
begin
  if not check_user_grand('DH_PR', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PRForm.CreateN(self, - 1, nil);
  DocForm.show;

end;
{
  Процедура открытия формы редактирования нового документа "Расходная накладная"
}
procedure TMAINForm.MenuRSDocClick(Sender: TObject);
var DocForm: TDOC_RSForm;
begin
  if not check_user_grand('DH_RS', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSForm.CreateN(self, - 1, 1, nil);
  DocForm.show;

end;

{

  Процедура открывает форму редактирования документа
  "Поступление материалов"
}
procedure TMAINForm.MenuPRMTRClick(Sender: TObject);
var DocForm: TDOC_PR_MTRForm;

begin
  // проверка прав на добавление
  if not check_user_grand('DH_PR_MTR', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PR_MTRForm.CreateN(self, - 1, nil);
  DocForm.show;

end;

{
  Процедура открывает форму редактирования
  документа "Отпуск материалов"
}
procedure TMAINForm.MenuRSMTRClick(Sender: TObject);
var DocForm: TDOC_RS_MTRForm;
begin
  // проверка прав на добавление
  if not check_user_grand('DH_RS_MTR', 'I', true) then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RS_MTRForm.CreateN(self, - 1, nil);
  DocForm.show;

end;

{
   Процедура открытия формы журнала приходных накладных
}
procedure TMAINForm.MenuPRDocJrnClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_PRDOCForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_PRDocForm.Create(self);
  DocForm.show;

end;
{
   Процедура открытия формы журнала приходных накладных
}
procedure TMAINForm.MenuRSDocJrnClick(Sender: TObject);
var docForm : TForm;

begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_RSDocForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_RSDocForm.Create(self);
  DocForm.show;

end;

{
  Процедура открывает журнал приходов материалов
}
procedure TMAINForm.MenuPRMTRJRClick(Sender: TObject);
var docForm : TForm;

begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_PRMTRForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_PRMTRForm.Create(self);
  DocForm.show;

end;

procedure TMAINForm.MenuEnumCalendClick(Sender: TObject);
var Form : TCalendarForm;

begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'CalendarForm') = false then exit; // проверка на существование открытых окон
    Form := TCalendarForm.Create(self);

  form.Show;
    
end;
{
   Процедура открывает журнал расходов материалов
}
procedure TMAINForm.MenuRSMTRJRClick(Sender: TObject);
var docForm : TForm;

begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_RSMTRForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_RSMTRForm.Create(self);
  DocForm.show;


end;


{
   Процедура открытия планового журнала заказов
}
procedure TMAINForm.MenuPlanJrnClick(Sender: TObject);
var JRForm: TJR_PLanFactForm;
begin
  if CheckOfOpened('Плановый журнал заказов', '') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  JRForm := TJR_PLanFactForm.CreateN(self, 1);

  JR_PLAN_MAIN := JRForm;
  JRForm.show;

end;
{
     Процедура открытия производственного журнала заказов
}
procedure TMAINForm.MenuProdJrnClick(Sender: TObject);
var JRForm: TJR_PLanFactForm;
begin
  if CheckOfOpened('Производственный журнал заказов', '') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  JRForm := TJR_PLanFactForm.CreateN(self, 2);
  JR_PROD_MAIN := JRForm;
  JRForm.show;

end;

{
   Закрытие программы
}
procedure TMAINForm.FormClose(Sender: TObject; var Action: TCloseAction);
var i: integer;
    isExit : boolean;
begin

 if data.glCheckOnExit then
   begin
     isExit := false;

     if MessageDlg('Закрыть программу?',
         mtConfirmation, [mbYes, mbNo], 0) = mrYes then
       isExit := true;

   end
  else
   isExit := true;

  if IsExit then
    begin
      // закроем все открытые окна
      for i:= 0 to MainForm.MDIChildCount - 1 do
       MainForm.MDIChildren[i].Close;
       
      // сохранение параметров
      Param_form.save;

      action := caFree;

    end
   else
     abort;

end;
{
   Процедура вывода подсказки о программе

}
procedure TMAINForm.MenoHelpAboutClick(Sender: TObject);
begin

  Application.CreateForm(TAboutBox, AboutBox);

end;

{
    Процедура открытия формы редактирования параметров

}
procedure TMAINForm.MenuParametersClick(Sender: TObject);
begin
  // открыть форму редактирования параметров
  Param_Form.showmodal;

end;

{
  Процедура работы с окнами

}
procedure TMAINForm.MenuTileClick(Sender: TObject);
begin
  tile;
end;

procedure TMAINForm.MenuCascadeClick(Sender: TObject);
begin
  cascade;
end;

procedure TMAINForm.MenuCloseallClick(Sender: TObject);
var i : integer;
begin
  for i:= 0 to MainForm.MDIChildCount - 1 do
    if MainForm.MDIChildren[i] <> nil then 
     MainForm.MDIChildren[i].close;

end;


procedure TMAINForm.MenuHelpHelpClick(Sender: TObject);
begin
   application.HelpCommand(HELP_FINDER, 1);
end;

//******************* TMAINForm.Print_Report_Click *************************
//
//Вход:  объект типа tMenuItem (хотелось бы)
//Выход:
//Описание:
//    Процедура вызова функций печати отчетов из библиотеки  PrintForm

procedure TMAINForm.Print_Report_Click(Sender: TObject);
var function_name : string;
          ProcAddr: FarProc;

begin

  if DLLHandle = 0 then
   exit;
   
   function_name := '';

  try
     with TMenuItem(Sender) do begin
        function_name  := name;
       end;

     if function_name <> '' then
       begin

        ProcAddr := GetProcAddress(DLLHandle , pchar(function_name));

        if ProcAddr <> nil then
        begin
           Print_Report := ProcAddr;
          // вызов функции печати из библиотеки
           Print_Report(application, self, data.RMPBase);
        end;
      end
     else

       MessageDlg('Ошибка инициализации функции библиотеки PrintForm.dll', mtError, [mbOK], 0);

  finally
  end;

end;



procedure TMAINForm.CalculatorClick(Sender: TObject);
begin
   CalculatorDialog.execute;
end;


{-----------------------------------------------------------------------------
  Процедура: TMAINForm.IsPanelShowClick
  Дата:      28-апр-2004
  Аргументы: Sender: TObject
  Возврат:   None
  Описание:  Управление видимостью панели инструментов
-----------------------------------------------------------------------------}

procedure TMAINForm.IsPanelShowClick(Sender: TObject);
begin
  with TMenuItem(Sender) do
    begin
      if Checked then
        Checked := false
       else
        Checked := true;

      if sender = IsEnumPanelShow then ToolBar_Enums.Visible  := Checked;
      if sender = IsDocPanelShow  then ToolBar_Docs.Visible := Checked;
      if sender = IsJRPanelShow   then ToolBar_JR.Visible   := Checked;
      if sender = IsMTRPanelShow  then ToolBar_MTR.Visible  := Checked;
      if sender = IsSysPanelShow  then ToolBar_Custom.Visible  := Checked;
      if sender = IsMessWinShow   then PanelMessage.Visible := Checked;
      if sender = iSToolPanelShow then ToolBar_Tool.Visible  := Checked;

    end;
end;


{
   Процедура открытия оперативного журнала заказов
}
procedure TMAINForm.MenuOperJrnClick(Sender: TObject);
var JRForm: TJR_OperForm;
begin

  if CheckOfOpened('Оперативный журнал заказов', '') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  JRForm := TJR_OperForm.CreateN(self, 1);

  JR_OPER_MAIN := JRForm;
  JRForm.show;


end;

procedure TMAINForm.MenuOpenGantClick(Sender: TObject);
var JRForm: TJR_GantForm;
begin

  if CheckOfOpened('Gant Оперативный журнал заказов', '') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
//  JRForm := TJR_GantForm.CreateN(self);
//
//  JR_GANT_MAIN := JRForm;
//  JRForm.show;

end;



{-----------------------------------------------------------------------------
  Процедура: TMAINForm.MenuMtrOrderClick
  Выход:     None
  Описание:  Вызов формы редактирования нового документа "Заказ на материалы"
-----------------------------------------------------------------------------}
procedure TMAINForm.MenuMtrOrderClick(Sender: TObject);
var DocForm: TDOC_MTROrderForm;
begin
  if not check_user_grand('DH_MTRORDER', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_MTROrderForm.CreateN(self, - 1, nil);
  DocForm.show;
end;

{-----------------------------------------------------------------------------
  Процедура: TMAINForm.MenuJRMtrOrderClick
  Выход:     None
  Описание:  Процедура вызова формы редактирования журнала заказов
             на поставку материалов
-----------------------------------------------------------------------------}
procedure TMAINForm.MenuJRMtrOrderClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_MTROrderForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_MTROrderForm.Create(self);
  DocForm.show;

end;


procedure TMAINForm.NewsClick(Sender: TObject);
var filename : string;
begin
   filename := ExtractFilePath(application.ExeName) + 'news.txt';

   if FileExists(filename) then
     WinExec(pchar('notepad.exe ' + filename), SW_SHOWNORMAL );

end;

procedure TMAINForm.MenuPREQPTClick(Sender: TObject);
var DocForm: TDOC_PREQPTForm;
begin
  if not check_user_grand('DH_PR_EQPT', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PREQPTForm.CreateN(self, - 1);
  DocForm.show;


end;

procedure TMAINForm.MenuRSEQPTClick(Sender: TObject);
var DocForm: TDOC_RSEQPTForm;
begin
  if not check_user_grand('DH_RS_EQPT', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSEQPTForm.CreateN(self, - 1);
  DocForm.show;


end;

procedure TMAINForm.MenuJRPREQPTClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_PREQPTDOCForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_PREQPTForm.Create(self);
  DocForm.show;


end;

procedure TMAINForm.MenuJRRSEQPTClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_RSEQPTDOCForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_RSEQPTForm.Create(self);
  DocForm.show;


end;

procedure TMAINForm.MenuRQSTEQPTClick(Sender: TObject);
var DocForm: TDOC_RQSTEQPTForm;
begin
  if not check_user_grand('DH_RQST_EQPT', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RQSTEQPTForm.CreateN(self, - 1);
  DocForm.show;


end;

procedure TMAINForm.MenuJRRQSTEQPTClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_RQSTEQPTForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_RQSTEQPTForm.Create(self);
  DocForm.show;


end;

procedure TMAINForm.MenuPRModelDocClick(Sender: TObject);
var DocForm: TDOC_PRModelForm;
begin
  if not check_user_grand('DH_PR_MODEL', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PRMODELForm.CreateN(self, - 1);
  DocForm.show;
end;

procedure TMAINForm.MenuRSModelDocClick(Sender: TObject);
var DocForm: TDOC_RSModelForm;
begin
  if not check_user_grand('DH_RS_MODEL', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSMODELForm.CreateN(self, - 1);
  DocForm.show;


end;

procedure TMAINForm.MenuJRPrModelClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_PRMODELDOCForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_PRMODELForm.Create(self);
  DocForm.show;

end;

procedure TMAINForm.MenuJRRSModelClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('', 'JR_RSMODELDOCForm') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_RSMODELForm.Create(self);
  DocForm.show;



end;

procedure TMAINForm.MenuEnumACCESSClick(Sender: TObject);
begin
  if CheckOfOpened('Справочник: Виды допуска', '') = false then exit; // проверка на существование открытых окон


  EnumTreeEdit := TLIST_TREEEDITForm.CreateN(Application, 'Справочник: Виды допуска',
                                'SPR_ACCESSTYPE', TENUM_ACCESSTYPEForm);
  EnumTreeEdit.show;

end;

procedure TMAINForm.N15Click(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('Движение инструмента на складе', '') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_EQPTRSPRForm.CreateN(self, 1);
  DocForm.show;

end;

procedure TMAINForm.MENUEqptToWrkrClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('Выдача инструмента работникам', '') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_EQPTRSPRForm.CreateN(self, 2);
  DocForm.show;

end;

procedure TMAINForm.WrkrSertClick(Sender: TObject);
var docForm : TForm;
begin
  // проверка среди открытых окон
  if CheckOfOpened('Аттестация работников', '') = false then exit; // проверка на существование открытых окон

  // открыть форму редактирования нового документа
  DocForm := TJR_WRKRSERTForm.CreateN(self);
  DocForm.show;

end;

end.
