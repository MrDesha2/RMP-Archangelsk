unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, ImgList, ToolWin, ExtCtrls, EnumForm, EnumTreeForm,
  JRORDERForm, JRRQSTForm, JRPlanFactForm, RxCalc;

type

  StandardProc = procedure(sender : tComponent);


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
    MenuORDRDoc: TMenuItem;
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
    MenuHerpHelp: TMenuItem;
    N55: TMenuItem;
    MenoHelpAbout: TMenuItem;
    MenuWin: TMenuItem;
    MenuCloseAll: TMenuItem;
    MenuTile: TMenuItem;
    K1: TMenuItem;
    JRImageList: TImageList;
    MainImages: TImageList;
    MenuEnumSPRG: TMenuItem;
    Print_Report_8: TMenuItem;
    Print_Report_10: TMenuItem;
    Print_Report_9: TMenuItem;
    Print_Report_11: TMenuItem;
    N1: TMenuItem;
    Calculator: TMenuItem;
    CalculatorDialog: TRxCalculator;
    Print_Report_12: TMenuItem;
    Print_Report_13: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Print_Report_15: TMenuItem;
    Print_Report_17: TMenuItem;
    Rep_16Sub: TMenuItem;
    Print_Report_18: TMenuItem;
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
    Print_Report_19: TMenuItem;
    N4: TMenuItem;
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
    Print_Report_20: TMenuItem;
    Print_Report_21: TMenuItem;
    Print_Report_22: TMenuItem;
    Print_Report_23: TMenuItem;
    Print_Report_24: TMenuItem;
    Print_Report_25: TMenuItem;
    SubMenuPlan: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    Print_Report_16: TMenuItem;
    Print_Report_27: TMenuItem;
    Print_Report_26: TMenuItem;
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
    procedure MenuORDRDocClick(Sender: TObject);
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
    procedure MenuHerpHelpClick(Sender: TObject);
    procedure Load_dll;
    procedure MenuEnumSPRGClick(Sender: TObject);
    procedure Print_Report_Click(Sender: TObject);
    procedure CalculatorClick(Sender: TObject);
    procedure MenuPRMTRClick(Sender: TObject);
    procedure MenuRSMTRClick(Sender: TObject);
    procedure MenuPRMTRJRClick(Sender: TObject);
    procedure MenuRSMTRJRClick(Sender: TObject);

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
 ReqEditForm,   // форма редактирования документа "Заявка"
OrderEditForm,  // форма редактирования документа "Заказ"
PRDocEditForm,  // форма редактирования документа "Приходная накладная"
RSDocEditForm,  // форма редактирования документа "Расходная накладная"
PRMTRDocEditForm,  // форма редактирования документа "Поступление материалов"
RSMTRDocEditForm,  // форма редактирования документа "Отпуск материалов"
  JRPRDocForm,  // форма редактирования журнала документов "Приход готовой продукции"
  JRRSDocForm,  // форма редактирования журнала документов "Отпуск готовой продукции"
JRRSMTRForm,    // форма редактирования журнала документов "Приход материала"
JRPRMTRForm,    // форма редактирования журнала документов "Отпуск материала"
     TPEQEdit,  // форма редактирования элемента справочника "Типы оборудования"
    ParamForm,

        About; 


{$R *.DFM}

{
    Процедура загрузки библиотеки печати при открытии формы

}
procedure TMAINForm.Load_dll;
begin
{  DLLHandle := LoadLibrary('PrintForm');

  if DLLHandle = 0 then
   begin
    showmessage('Ошибка загрузки библиотеки печати!');
    close;

   end;
}

end;




{
   Процедура инициализации системы при открытии формы
}
procedure TMAINForm.FormCreate(Sender: TObject);
begin

 {Типа глобальная процедура при начале работы системы}
 mainstatusbar.Panels.Items[2].Text := 'ТД: ' + DateToStr(Date);


end;



procedure TMAINForm.MenuCloseClick(Sender: TObject);
begin
  close;
end;

//
//   Функция CheckOfOpened
//   Описание: проверяет по названию открытые дочерние окна, проверка дублирования
//   Вход: название окна, выход: результат проверки
function CheckOfOpened(_formCaption, _formname: string): boolean;
var i: integer;
begin
  result := true;
  for i:= 0 to MainForm.MDIChildCount - 1 do
   if (MainForm.MDIChildren[i].Name =  _formname)
     or (MainForm.MDIChildren[i].Caption  =  _formCaption) then
    begin
     result := false;
     MainForm.MDIChildren[i].show;
    end;



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

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Склады',
                                'SPR_WRHS', 'SPR_WRHS_GEN', TENUM_WRHSForm);
  EnumForm.show;

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

  EnumForm := TLIST_EDITForm.CreateN(Application, 'Справочник: Работники',
                                'SPR_WRKR', 'SPR_WRKR_GEN', TENUM_WRKRForm);
  EnumForm.show;

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
//
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
  Процедура открытия формы редактирования нового документа "Заказ"
}
procedure TMAINForm.MenuORDRDocClick(Sender: TObject);
// var DocForm: TORDER_EditForm;
begin
  showmessage('Добавление заказа возможно только из документа "Заявка"!');
  exit;

  // открыть форму редактирования нового документа
//  DocForm := TORDER_EditForm.CreateN(self, - 1, -1);
//   DocForm.show;

end;
{
  Процедура открытия формы редактирования нового документа "Приходная накладная"
}
procedure TMAINForm.MenuPRDocClick(Sender: TObject);
var DocForm: TDOC_PRForm;
begin

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
begin


//  if MessageDlg('Закрыть программу?',
//    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//
//
//  // при закрытии уничтожается библиотека печати форм
//  try
//
//    if DLLHandle <> 0 then
//      FreeLibrary(DLLHandle);
//
//  finally
//  end;

//    if not param_form.save then
//      param_form.ShowModal;

    application.Terminate;


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


procedure TMAINForm.MenuHerpHelpClick(Sender: TObject);
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
begin

   DLLhandle := loadLibrary('PrintForm');
   function_name := '';

  try
     with TMenuItem(Sender) do begin
        function_name  := name;
       end;

     if function_name <> '' then
       begin

        @Print_Report := GetProcAddress(DLLHandle , pchar(function_name));

        // вызов функции печати из библиотеки
        Print_Report(application);
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


end.
