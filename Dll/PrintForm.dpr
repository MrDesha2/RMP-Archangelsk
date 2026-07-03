{***************************************************************
 *
 * Unit Name: Библиотека печатных форм для системы АСУ РМП.
 * Purpose  :
 * Author   : Косицын Дмитрий, Соколов Владислав
 * History  : 2004
 *

   Содержит:
     Print_map_form  - процедура печати маршрутной карты.
     Print_calc_form - процедура печати калькуляции заказа.
     Print_act_form  - процедура печати акта выполненных работ.
     Print_mapFact_form - процедура печати фактической маршрутной карты;
     Print_pr_form      - печать приходной накладной по готовой продукции;
     Print_pr_mtr_form  - печать приходной накладной по материалам;
     Print_Requirement_form - печать документа требование-накладная;
     Print_rs_mtr_form      - печать расходной накладной по материалам;
     Print_Mtr_Order_form   - печать заявки на материалы;

   Формы отчетов:
     Print_Report_1     - Индивидуальный график работы;
     Print_Report_2     - график работы ОТК;
     Print_Report_3     - планируемый период выполения заказа;
     Print_Report_4     - выработка по бригаде;
     Print_Report_5     - ведомость по архиву;
     Print_Report_6     - анализ повторяемости номенклатуры;
     Print_Report_7     - план по литью;
     Print_Report_8     - реестр документов;
     Print_Report_9     - отчет по выполненным работам;
     Print_Report_10    - отчет по плановым заказам (план работ);
     Print_Report_11    - отчет по выполненным услугам;
     Print_Report_12    - ведомость по журналам;
     Print_Report_13    - печать акта сверок;
     Print_Report_15    - бухотчет;
     Print_Report_16    - бухотчет, форма 2, отчёт для R/3 по выполненным услугам;
     Print_Report_17    - отчет план-факт;
     Print_Report_18    - форма статистических отчетов (отчет по выполненным работам (услугам));
     Print_Report_19    - анализ повторяемости цен;
     Print_Report_20    - отчет по незавершенному производству;
     Print_Report_21    - отчет о выполнении плана;
     Print_Report_22    - отчет по использованию материалов;
     Print_Report_23    - отчет по потребности в материалах;
     Print_Report_24    - Отчет по расходу основных материалов в производство по заказам;
     Print_Report_25    - плановая калькуляция заказов за заданный период, + ярлык;
     Print_Report_26    - лимитно-заборная карта;
     Print_Report_27    - отчет для R/3 по незавершенному производству;
     Print_Report_28    - карточка и оборотная ведомость по складам;
     Print_Report_29    - Инвентаризационная опись по незавершенному производству;
     Print_Report_30    - График фактического выполнения заказов в рублях;
     Print_Report_31    - График фактического выполнения операций по датам;
     Print_Report_32    - График фактического выполнения заказов для различных организаций (свой-чужой);
     Print_Report_34    - График фактического выполнения заказов для различных производств;
     Print_Report_35    - Загрузка оборудования;     
     Print_Report_36    - Диаграмма учета производства;
     Print_Report_37    - Аттестация рабочих;
     Print_Report_38    - Заявка на инструмент;
     Print_Report_39    - Учет прихода и расхода инструмента;
     Print_Report_40    - Оборотная ведомость по инструменту;
     Print_Report_41    - Форма учета выдачи инструмента ;
     Print_Report_42    - Требование-накладная на инструмент;
     Print_Report_43    - Диаграмма Ганта на выполнение заказа либо работы рабочего;
     Print_Report_44    - Оборотная ведомость по моделям;
     Print_Report_45    - Учет прихода и расхода моделей;
     Print_Report_46    - Учет кадров;
     Print_Report_47    - Карточка выдачи инсрумента рабочему;
     Print_Report_48    - отчет по использованию транспорта;
     Print_Report_49    - Карточка движения инструмента;
     Print_Report_50    - Форма учета по списанию инструмента ;
     Print_Report_51    - Сводная ведомость выдачи инструмента ;
     Print_Report_52    - Временная форма для вызова двух отчётов по форме 18 ;
     Print_Report_53    - Отчёт по станкочасам для производств ;
     Print_Report_54    - Отчёт по материалам на заказы выполненнные в период;
     Print_Report_55    - Отчёт учёта трудоёмкости неплановых работ;
     Print_Report_56    - Отчёт по трудоёмкости работ, выполненных ЦМО, для смежных участков;
     Print_Report_57    - Отчёт по движению заказов в производстве;
     Print_Report_58    - Отчёт по трудоёмкости работ по типам ремонтируемого оборуования;
     Print_Report_59    - Контроль за ходом выполнения заказов;
     Print_Report_60    - Загрузка станочника;
     Print_Report_61    - Невыполненные заказы запущенные в производство;
}



library PrintForm;



uses
  SysUtils,
  Classes,
  Forms,
  dialogs,
  Windows,
  Db,
  DBTables,
  PrintLibs in 'PrintLibs.pas',
  PrintFrm in 'PrintFrm.pas' {ShowPrintForm},
  PrintMap in 'PrintMap.pas' {PrintMapForm},
  PrintCalc in 'PrintCalc.pas' {PrintCalcForm},
  PrintAct in 'PrintAct.pas' {PrintActForm},
  PrintRsMTRDoc in 'PrintRsMTRDoc.pas' {PrintRS_MTRDocForm},
  PrintTrDoc in 'PrintTrDoc.pas' {PrintTrDocForm},
  Rep10 in 'Rep10.pas' {Report10Form},
  Rep8 in 'Rep8.pas' {Report8Form},
  PrintProces in 'PrintProces.pas' {ProcessForm},
  Rep9 in 'Rep9.pas' {Report9Form},
  Libs in 'Libs.pas',
  Rep11 in 'Rep11.pas' {Report11Form},
  EnumForm4Sel in 'EnumForm4Sel.pas' {LIST_4SELECTForm},
  Rep12 in 'Rep12.pas' {Report12Form},
  Rep13 in 'Rep13.pas' {Report13Form},
  Rep18 in 'Rep18.pas' {Report18Form},
  Rep16 in 'Rep16.pas' {Report16Form},
  Rep17 in 'Rep17.pas' {Report17Form},
  Rep15 in 'Rep15.pas' {Report15Form},
  Rep19 in 'Rep19.pas' {Report19Form},
  PrintMapFact in 'PrintMapFact.pas' {PrintMapFactForm},
  Rep20 in 'Rep20.pas' {Report20Form},
  Rep21 in 'Rep21.pas' {Report21Form},
  Rep22 in 'Rep22.pas' {Report22Form},
  Rep23 in 'Rep23.pas' {Report23Form},
  Rep24 in 'Rep24.pas' {Report24Form},
  Rep25 in 'Rep25.pas' {Report25Form},
  Rep26 in 'Rep26.pas' {Report26Form},
  Rep27 in 'Rep27.pas' {Report27Form},
  Rep28 in 'Rep28.pas' {Report28Form},
  PrintPrDoc in 'PrintPrDoc.pas' {PrintPRDocForm},
  PrintPrMTRDoc in 'PrintPrMTRDoc.pas' {PrintPR_MTRDocForm},
  Rep29 in 'Rep29.pas' {Report29Form},
  Rep30 in 'Rep30.pas' {Report30Form},
  Rep31 in 'Rep31.pas' {Report31Form},
  Rep32 in 'Rep32.pas' {Report32Form},
  base in 'base.pas' {data: TDataModule},
  Rep7 in 'Rep7.pas' {Report7Form},
  Rep6 in 'Rep6.pas' {Report6Form},
  Rep34 in 'Rep34.pas' {Report34Form},
  PrintDgrm in 'PrintDgrm.pas' {PrintDiagram},
  Rep5 in 'Rep5.pas' {Report5Form},
  Rep4 in 'Rep4.pas' {Report4Form},
  Rep3 in 'Rep3.pas' {Report3Form},
  Rep2 in 'Rep2.pas' {Report2Form},
  Rep1 in 'Rep1.pas' {Report1Form},
  Rep35 in 'Rep35.pas' {Report35Form},
  PrintMtrOrderDoc in 'PrintMtrOrderDoc.pas' {PrintMTROrderDocForm},
  Rep36 in 'Rep36.pas' {Report36Form},
  Rep37 in 'Rep37.pas' {Report37Form},
  Rep38 in 'Rep38.pas' {Report38Form},
  Rep39 in 'Rep39.pas' {Report39Form},
  Rep40 in 'Rep40.pas' {Report40Form},
  Rep41 in 'Rep41.pas' {Report41Form},
  Rep42 in 'Rep42.pas' {Report42Form},
  Rep43 in 'Rep43.pas' {Report43Form},
  Rep44 in 'Rep44.pas' {Report44Form},
  Rep45 in 'Rep45.pas' {Report45Form},
  PrintPrDocNew in 'PrintPrDocNew.pas' {PrintPRDocFormNew},
  Rep46 in 'Rep46.pas' {Report46Form},
  Rep47 in 'Rep47.pas' {Report47Form},
  Rep48 in 'Rep48.pas' {Report48Form},
  Rep49 in 'Rep49.pas' {Report49Form},
  Rep50 in 'Rep50.pas' {Report50Form},
  Rep51 in 'Rep51.pas' {Report51Form},
  Rep52 in 'Rep52.pas' {Report52Form},
  Rep_18 in 'Rep_18.pas' {Report_18Form},
  Rep53 in 'Rep53.pas' {Report53Form},
  Rep54 in 'Rep54.pas' {Report54Form},
  Rep55 in 'Rep55.pas' {Report55Form},
  Rep56 in 'Rep56.pas' {Report56Form},
  Rep57 in 'Rep57.pas' {Report57Form},
  Rep58 in 'Rep58.pas' {Report58Form},
  Rep59 in 'Rep59.pas' {Report59Form},
  OutLookForm in 'OutLookForm.pas' {OutLook_Form},
  Rep60 in 'Rep60.pas' {Report60Form},
  Rep61 in 'Rep61.pas' {Report61Form};

var DLLApplication : tApplication;
      DLLProc        : Pointer;
{$R *.RES}

   procedure open_base(Base : tDataBase);
   begin
     if not assigned(data) then
       data := tdata.create(application);

     if not data.RMPBase.connected then
       data.RMPBase.Handle := Base.Handle;

   end;


  {
     Процедура вызова печатной формы маршрутной карты

  }
  procedure Print_map_form(ParentApplication: TApplication; ParentForm: TForm; IDDOC : integer; Base : tDataBase); export; stdcall;
  begin
     open_base(base);
     PrintMapForm := TPrintMapForm.Create(ParentForm);
     PrintMapForm.CreateReport(IDDoc);
     PrintMapForm.close;

  end;

  {
      Процедура вызова печатной формы расчета затрат

  }
  procedure Print_calc_form(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintCalcForm := TPrintCalcForm.Create(ParentForm);
     PrintCalcForm.CreateReport(IDDoc);
     PrintCalcForm.Release;

  end;

  {
      Процедура вызова печатной формы приходной накладной

  }
  procedure Print_pr_form(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintPRDocForm := TPrintPRDocForm.Create(ParentForm);
     PrintPRDocForm.CreateReport(IDDoc);
     PrintPRDocForm.Release;

  end;

  {
      Процедура вызова печатной формы приходной накладной новой

  }
  procedure Print_pr_form_new(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintPRDocFormNew := TPrintPRDocFormNew.Create(ParentForm);
     PrintPRDocFormNew.CreateReport(IDDoc);
     PrintPRDocFormNew.Release;

  end;

//******************* Print_pr_form *************************
//
//Вход:
//Выход:
//Описание:
//    Печать документа "Поступление материалов"
  procedure Print_pr_mtr_form(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintPR_MTRDocForm := TPrintPR_MTRDocForm.Create(ParentForm);
     PrintPR_MTRDocForm.CreateReport(IDDoc);
     PrintPR_MTRDocForm.Release;

  end;

  {
      Процедура вызова печатной формы акта выполненных работ

  }
  procedure Print_act_form(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintActForm := TPrintActForm.Create(ParentForm);
     PrintActForm.CreateReport(IDDoc);
     PrintActForm.Release;

  end;

  {
      Процедура вызова печатной формы акта выполненных работ

  }
  procedure Print_Requirement_form(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintTrDocForm := TPrintTrDocForm.Create(ParentForm);
     PrintTrDocForm.CreateReport(IDDoc);
     PrintTrDocForm.Release;

  end;


//******************* Print_RS_MTRDoc_form *************************
//
//Вход:
//Выход:
//Описание:
//      Процедура вызова печатной формы расхода материалов в производство
  procedure Print_rs_mtr_form(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintRS_MTRDocForm := TPrintRS_MTRDocForm.Create(ParentForm);
     PrintRS_MTRDocForm.CreateReport(IDDoc);
     PrintRS_MTRDocForm.Release;

  end;

//      Процедура вызова печатной формы заявки на материалы
  procedure Print_Mtr_Order_form(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintMTROrderDocForm := TPrintMTROrderDocForm.Create(ParentForm);
     PrintMTROrderDocForm.CreateReport(IDDoc);
     PrintMTROrderDocForm.Release;

  end;


  {
    Отчет "Индивидуальный график работы"
  }
  procedure Print_Report_1(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

//    if not assigned(Report5Form) then
     open_base(base);
     Report1Form              := TReport1Form.Create(ParentForm);

     Report1Form.show;

  end;

  {
    Отчет "график работы ОТК"
  }
  procedure Print_Report_2(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

//    if not assigned(Report5Form) then
     open_base(base);
     Report2Form              := TReport2Form.Create(ParentForm);

     Report2Form.show;

  end;

  {
    Отчет "планируемый период выполения заказа"
  }
  procedure Print_Report_3(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

//    if not assigned(Report5Form) then
     open_base(base);
     Report3Form              := TReport3Form.Create(ParentForm);

     Report3Form.show;

  end;

  {
    Отчет "Выработка по бригаде"
  }
  procedure Print_Report_4(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

//    if not assigned(Report5Form) then
     open_base(base);
     Report4Form              := TReport4Form.Create(ParentForm);

     Report4Form.show;

  end;

  {
    Отчет "Ведомость по архиву"
  }
  procedure Print_Report_5(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

//    if not assigned(Report5Form) then
     open_base(base);
     Report5Form              := TReport5Form.Create(ParentForm);

     Report5Form.show;

  end;

  {
    Отчет "Анализ повторяемости номенклатуры"
  }
  procedure Print_Report_6(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

//    if not assigned(Report6Form) then
     open_base(base);
     Report6Form              := TReport6Form.Create(ParentForm);

     Report6Form.show;

  end;


  {
    Отчет "План по литью"
  }
  procedure Print_Report_7(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

//    if not assigned(Report7Form) then
     open_base(base);
     Report7Form              := TReport7Form.Create(ParentForm);

     Report7Form.show;

  end;

  {
    Отчет "Реест документов
  }
  procedure Print_Report_8(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

//    if not assigned(Report8Form) then
     open_base(base);
     Report8Form              := TReport8Form.Create(ParentForm);

     Report8Form.show;

  end;

  {
     Отчет по выполненным работам

  }
  procedure Print_Report_9(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report9Form) then
        Report9Form              := TReport9Form.Create(ParentForm);

     Report9Form.show;

  end;


  {
     Отчет по плановым заказам

  }
  procedure Print_Report_10(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report10Form) then
        Report10Form              := TReport10Form.Create(ParentForm);

     Report10Form.show;

  end;

  {
     Отчет по выполненным услугам

  }
  procedure Print_Report_11(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report10Form) then
        Report11Form              := TReport11Form.Create(ParentForm);

     Report11Form.show;

  end;

  {
     Отчет по годовому журналу

  }
  procedure Print_Report_12(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report12Form) then
        Report12Form              := TReport12Form.Create(ParentForm);

     Report12Form.show;

  end;

  {
     Отчет по сверке заказом

  }
  procedure Print_Report_13(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report13Form) then
        Report13Form              := TReport13Form.Create(ParentForm);

     Report13Form.show;

  end;
  {
     Бухотчет

  }
  procedure Print_Report_15(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report15Form) then
        Report15Form              := TReport15Form.Create(ParentForm);

     Report15Form.show;

  end;
  {
     Бухотчет2

  }
  procedure Print_Report_16(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report16Form) then
        Report16Form              := TReport16Form.Create(ParentForm);

     Report16Form.show;

  end;
  {
     План-факт

  }
  procedure Print_Report_17(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report17Form) then
        Report17Form              := TReport17Form.Create(ParentForm);

     Report17Form.show;

  end;

  {

     Формы статистических отчетов

  }
  procedure Print_Report_18(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
        Report18Form              := TReport18Form.Create(ParentForm);

     Report18Form.show;

  end;

  procedure _Print_Report_18(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
        Report_18Form              := TReport_18Form.Create(ParentForm);

     Report_18Form.show;

  end;

  {

     Форма анализа повторяемости цен

  }
  procedure Print_Report_19(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report19Form) then
        Report19Form              := TReport19Form.Create(ParentForm);

     Report19Form.show;

  end;
  {

        Ведомость незавершенного производства

  }
  procedure Print_Report_20(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report20Form) then
        Report20Form              := TReport20Form.Create(ParentForm);

     Report20Form.show;

  end;

  {

        Отчет о выполнении плана

  }
  procedure Print_Report_21(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report21Form) then
        Report21Form              := TReport21Form.Create(ParentForm);

     Report21Form.show;

  end;

  {

        Отчет об использовании материалов

  }
  procedure Print_Report_22(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report22Form) then
        Report22Form              := TReport22Form.Create(ParentForm);

     Report22Form.show;

  end;

  {

        Отчет об потребности материалов

  }
  procedure Print_Report_23(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report23Form) then
        Report23Form              := TReport23Form.Create(ParentForm);

     Report23Form.show;

  end;

  {

        Отчет по расходу основных материалов в производство по заказам

  }
  procedure Print_Report_24(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
 //   if not assigned(Report24Form) then
        Report24Form              := TReport24Form.Create(ParentForm);

     Report24Form.show;

  end;

  {

        Отчет по плановой калькуляции заказов за заданный период

  }
  procedure Print_Report_25(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report25Form) then
        Report25Form              := TReport25Form.Create(ParentForm);

     Report25Form.show;

  end;
  {

        Плановая Лимитно-заборная карта

  }
  procedure Print_Report_26(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report26Form) then
        Report26Form              := TReport26Form.Create(ParentForm);

     Report26Form.show;

  end;
  {

        Отчет для R3 по незавершенному производству

  }
  procedure Print_Report_27(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report27Form) then
        Report27Form              := TReport27Form.Create(ParentForm);

     Report27Form.show;

  end;
//******************* Print_Report_28 *************************
//
//Вход:
//Выход:
//Описание:
//     Формирование оборотной ведомости по материалам
  procedure Print_Report_28(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report28Form) then
        Report28Form              := TReport28Form.Create(ParentForm);

     Report28Form.show;


  end;

  {

        Инвентаризационная опись по незавершенному производству

  }
  procedure Print_Report_29(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report29Form) then
        Report29Form              := TReport29Form.Create(ParentForm);

     Report29Form.show;

  end;

  {
     Процедура вызова печатной формы фактической маршрутной карты

  }
  procedure Print_mapFact_form(ParentApplication: TApplication; ParentForm: TForm; IDDoc : integer; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
     PrintMapFactForm := TPrintMapFactForm.Create(ParentForm);
     PrintMapFactForm.CreateReport(IDDoc);
     PrintMapFactForm.Release;

  end;

  {

        График фактического выполнения заказов в рублях

  }
  procedure Print_Report_30(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report30Form) then
        Report30Form              := TReport30Form.Create(ParentForm);

     Report30Form.show;
  end;

  {

        График фактического выполнения операций по датам

  }
  procedure Print_Report_31(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

     open_base(base);
//    if not assigned(Report31Form) then
        Report31Form              := TReport31Form.Create(ParentForm);

     Report31Form.show;
  end;

  {

        График фактического выполнения заказов для различных организаций (свой-чужой)

  }
  procedure Print_Report_32(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report32Form) then
        Report32Form              := TReport32Form.Create(ParentForm);

     Report32Form.show;
  end;


  {

        График фактического выполнения заказов по одному участку РМП

  }
  procedure Print_Report_34(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report34Form) then
        Report34Form              := TReport34Form.Create(ParentForm);

     Report34Form.show;
  end;

  {

        Загрузка оборудования

  }
  procedure Print_Report_35(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report35Form) then
        Report35Form              := TReport35Form.Create(ParentForm);

     Report35Form.show;
  end;

  {

        Учет производства

  }
  procedure Print_Report_36(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report36Form) then
        Report36Form              := TReport36Form.Create(ParentForm);

     Report36Form.show;
  end;

  {

        Аттестация рабочих

  }
  procedure Print_Report_37(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report37Form) then
        Report37Form              := TReport37Form.Create(ParentForm);

     Report37Form.show;
  end;

  {

        Заявка на инструмент

  }
  procedure Print_Report_38(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report38Form) then
        Report38Form              := TReport38Form.Create(ParentForm);

     Report38Form.show;
  end;

  {

        Учет прихода и расхода инструмента

  }
  procedure Print_Report_39(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report39Form) then
        Report39Form              := TReport39Form.Create(ParentForm);

     Report39Form.show;
  end;

  {

     Оборотная ведомость по инструменту;

  }
  procedure Print_Report_40(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report40Form) then
        Report40Form              := TReport40Form.Create(ParentForm);

     Report40Form.show;
  end;

  {

     Форма учета выдачи инструмента ;

  }
  procedure Print_Report_41(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report41Form) then
        Report41Form              := TReport41Form.Create(ParentForm);

     Report41Form.show;
  end;

  {

     Требование-накладная на инструмент;

  }
  procedure Print_Report_42(ParentApplication: TApplication; ParentForm: TForm; IDDOC : integer; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report42Form) then
        Report42Form              := TReport42Form.Create(ParentForm);
        Report42Form.CreateReport(IDDoc);
        Report42Form.Release;

//     Report42Form.show;
  end;

  {

     Диаграмма Ганта на выполнение заказа либо работы рабочего;

  }
  procedure Print_Report_43(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report43Form) then
        Report43Form              := TReport43Form.Create(ParentForm);

    Report43Form.show;
  end;

  {

     Оборотная ведомость по моделям;

  }
  procedure Print_Report_44(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report44Form) then
        Report44Form              := TReport44Form.Create(ParentForm);

    Report44Form.show;
  end;

  {

     Учет прихода и расхода моделей;

  }
  procedure Print_Report_45(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report45Form) then
        Report45Form              := TReport45Form.Create(ParentForm);

    Report45Form.show;
  end;

  {

     Учет кадров;

  }
  procedure Print_Report_46(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report46Form) then
        Report46Form              := TReport46Form.Create(ParentForm);

    Report46Form.show;
  end;

  {

     Карточка выдачи инсрумента рабочему;

  }
  procedure Print_Report_47(ParentApplication: TApplication; ParentForm: TForm; ID_Wrkr : integer; date_beg : tdatetime; date_end : tdatetime; Date_Base : tDataBase); export; stdcall;
  begin
//
    open_base(Date_Base);

        Report47Form              := TReport47Form.Create(ParentForm);
        Report47Form.CreateRep47(ID_Wrkr, date_beg, date_end);
        Report47Form.Release;

  end;

  {

     Отчет об использовании транспорта;

  }
  procedure Print_Report_48(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report44Form) then
        Report48Form              := TReport48Form.Create(ParentForm);

    Report48Form.show;
  end;

  {

     Карточка движения инструмента;

  }
  procedure Print_Report_49(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report44Form) then
        Report49Form              := TReport49Form.Create(ParentForm);

    Report49Form.show;
  end;


  {

     Форма учета списания инструмента ;

  }
  procedure Print_Report_50(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report50Form) then
        Report50Form              := TReport50Form.Create(ParentForm);

     Report50Form.show;
  end;

  {

     Сводная ведомость выдачи инструмента ;

  }
  procedure Print_Report_51(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report51Form) then
        Report51Form              := TReport51Form.Create(ParentForm);

     Report51Form.show;
  end;

  {

     Сводная ведомость выдачи инструмента ;

  }
  procedure Print_Report_52(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report52Form) then
        Report52Form              := TReport52Form.Create(ParentForm);

     Report52Form.show;
  end;

  {

     Отчёт по станкочасам по производствам ;

  }
  procedure Print_Report_53(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report53Form) then
        Report53Form              := TReport53Form.Create(ParentForm);

     Report53Form.show;
  end;

  {

     Отчёт по потребности в материалах на заказ ;

  }
  procedure Print_Report_54(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report54Form) then
        Report54Form              := TReport54Form.Create(ParentForm);

     Report54Form.show;
  end;

  {

     Отчёт по потребности в материалах на заказ ;

  }
  procedure Print_Report_55(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report55Form) then
        Report55Form              := TReport55Form.Create(ParentForm);

     Report55Form.show;
  end;

  {

     Отчёт по потребности в материалах на заказ ;

  }
  procedure Print_Report_56(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report56Form) then
        Report56Form              := TReport56Form.Create(ParentForm);

     Report56Form.show;
  end;

  {

     Отчёт по движению заказов в производстве ;

  }
  procedure Print_Report_57(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report57Form) then
        Report57Form              := TReport57Form.Create(ParentForm);

     Report57Form.show;
  end;

  {

     Отчёт по трудоёмкости работ по типам ремонтируемого оборуования ;

  }
  procedure Print_Report_58(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
//    if not assigned(Report58Form) then
        Report58Form              := TReport58Form.Create(ParentForm);

     Report58Form.show;
  end;

  {

     Контроль за ходом выполнения заказов;

  }
  procedure Print_Report_59(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
        Report59Form              := TReport59Form.Create(ParentForm);

     Report59Form.show;
  end;

  {

     Загрузка станочника;

  }
  procedure Print_Report_60(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
        Report60Form              := TReport60Form.Create(ParentForm);

     Report60Form.show;
  end;

  {

     Невыполненные заказы запущенные в производство;

  }
  procedure Print_Report_61(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
        Report61Form              := TReport61Form.Create(ParentForm);

     Report61Form.show;
  end;

  {

     Рассылка писем;

  }
{  procedure Form_OutLook(ParentApplication: TApplication; ParentForm: TForm; Base : tDataBase); export; stdcall;
  begin

    open_base(base);
    showmessage('1');
    OutLook_Form := TOutLook_Form.Create(ParentForm);
    showmessage('2');

     OutLook_Form.showmodal;
    showmessage('3');

  end; }

  procedure DLLUnloadProc(Reason: Integer); register;
  begin
    if Reason = DLL_PROCESS_DETACH then
      begin
        Application:=DllApplication;
        Data.RMPBase.Connected := false;
      end;
  end;

  exports

   // формы документов
   Print_mapFact_form,
   Print_map_form,
   Print_calc_form,
   Print_pr_form,
   Print_pr_mtr_form,
   Print_rs_mtr_form,
   Print_act_form,
   Print_Requirement_form,
   Print_Mtr_Order_form,
   Print_pr_form_new,

//   Form_OutLook,

   // формы отчетов
   Print_Report_1,
   Print_Report_2,
   Print_Report_3,
   Print_Report_4,
   Print_Report_5,
   Print_Report_6,
   Print_Report_7,
   Print_Report_8,
   Print_Report_9,
   Print_Report_10,
   Print_Report_11,
   Print_Report_12,
   Print_Report_13,
   Print_Report_15,
   Print_Report_16,
   Print_Report_17,
   Print_Report_18,
   _Print_Report_18,
   Print_Report_19,
   Print_Report_20,
   Print_Report_21,
   Print_Report_22,
   Print_Report_23,
   Print_Report_24,
   Print_Report_25,
   Print_Report_26,
   Print_Report_27,
   Print_Report_28,
   Print_Report_29,
   Print_Report_30,
   Print_Report_31,
   Print_Report_32,
   Print_Report_34,
   Print_Report_35,
   Print_Report_36,
   Print_Report_37,
   Print_Report_38,
   Print_Report_39,
   Print_Report_40,
   Print_Report_41,
   Print_Report_42,
   Print_Report_43,
   Print_Report_44,
   Print_Report_45,
   Print_Report_46,
   Print_Report_47,
   Print_Report_48,
   Print_Report_49,
   Print_Report_50,
   Print_Report_51,
   Print_Report_52,
   Print_Report_53,
   Print_Report_54,
   Print_Report_55,
   Print_Report_56,
   Print_Report_57,
   Print_Report_58,
   Print_Report_59,
   Print_Report_60,
   Print_Report_61
   ;


begin
   DllApplication:=Application;
   DLLProc := @DLLUnloadProc;
end.


