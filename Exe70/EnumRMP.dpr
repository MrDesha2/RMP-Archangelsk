program EnumRMP;

uses
  Forms,
  Main in 'Main.pas' {MAINForm},
  Base in 'Base.pas' {DATA: TDataModule},
  MVZEdit in 'Enums\MVZEdit.pas' {ENUM_MVZForm},
  CSTEdit in 'Enums\CSTEdit.pas' {ENUM_CSTForm},
  NMNTEdit in 'Enums\NMNTEdit.pas' {ENUM_NMNTForm},
  CHRTEdit in 'Enums\CHRTEdit.pas' {ENUM_CHRTForm},
  EQPTEdit in 'Enums\EQPTEdit.pas' {ENUM_EQPTForm},
  WRKREdit in 'Enums\WRKREdit.pas' {ENUM_WRKRForm},
  VOPEdit in 'Enums\VOPEdit.pas' {ENUM_VOPForm},
  BrigadeEdit in 'Enums\BrigadeEdit.pas' {ENUM_BRIGADEForm},
  VCHREdit in 'Enums\VCHREdit.pas' {ENUM_VCHRForm},
  OPCHEdit in 'Enums\OPCHEdit.pas' {ENUM_OPCHForm},
  EQCHEdit in 'Enums\EQCHEdit.pas' {ENUM_EQCHForm},
  REPEdit in 'Enums\REPEdit.pas' {ENUM_REPForm},
  FAILEdit in 'Enums\FAILEdit.pas' {ENUM_FAILEdit},
  CALCEdit in 'Enums\CALCEdit.pas' {ENUM_CALCForm},
  MDLEdit in 'Enums\MDLEdit.pas' {ENUM_MLDForm},
  EnumForm4Sel in 'Enums\EnumForm4Sel.pas' {LIST_4SELECTForm},
  TPEQEdit in 'Enums\TPEQEdit.pas' {ENUM_TPEQ},
  EnumQuotaEdit in 'Enums\EnumQuotaEdit.pas' {ENUM_QUOTACST},
  EnumTreeForm in 'Enums\EnumTreeForm.pas' {LIST_TREEEDITForm},
  EnumTree4Select in 'Enums\EnumTree4Select.pas' {LIST_TREE4SelectForm},
  EnumForm in 'Enums\EnumForm.pas' {LIST_EDITForm},
  WRHSEdit in 'Enums\WRHSEdit.pas' {ENUM_WRHSForm},
  CHAREdit in 'Enums\CHAREdit.pas' {ENUM_CHEQForm},
  EnumCLPDRForm in 'Enums\EnumCLPDRForm.pas' {ENUM_CLCPDRForm},
  EnumSTRGEdit in 'Enums\EnumSTRGEdit.pas' {ENUM_STRGForm},
  CHAINEdit in 'Enums\CHAINEdit.pas' {ENUM_CHAINForm},
  TranceForm in 'Enums\TranceForm.pas' {Trance_Form},
  ENUMModelbox in 'Enums\ENUMModelbox.pas' {ENUM_MODELBOX},
  ENUMModelINC in 'Enums\ENUMModelINC.pas' {ENUM_MODELINCEdit},
  EnumWorkerSertif in 'Enums\EnumWorkerSertif.pas' {ENUM_WORKERSERTFORM},
  MTCHEdit in 'Enums\MTCHEdit.pas' {ENUM_MTCHForm},
  JRRQSTForm in 'Jrnl\JRRQSTForm.pas' {JR_RQSTForm},
  JRORDERForm in 'Jrnl\JRORDERForm.pas' {JR_ORDERForm},
  JRRSMTRForm in 'Jrnl\JRRSMTRForm.pas' {JR_RSMTRForm},
  JRPRMTRForm in 'Jrnl\JRPRMTRForm.pas' {JR_PRMTRForm},
  JRPlanFactForm in 'Jrnl\JRPlanFactForm.pas' {JR_PLANFACTForm},
  JRRSEQPTDocForm in 'Jrnl\JRRSEQPTDocForm.pas' {JR_RSEQPTForm},
  JRRSDocForm in 'Jrnl\JRRSDocForm.pas' {JR_RSDocForm},
  JRMTROrderForm in 'Jrnl\JRMTROrderForm.pas' {JR_MTROrderForm},
  FiltrOrderEdit in 'Jrnl\FiltrOrderEdit.pas' {FilterForm},
  JRPRDocForm in 'Jrnl\JRPRDocForm.pas' {JR_PRDOCForm},
  JRRQSTEQPTDocForm in 'Jrnl\JRRQSTEQPTDocForm.pas' {JR_RQSTEQPTForm},
  JRRSModelDocForm in 'Jrnl\JRRSModelDocForm.pas' {JR_RSModelForm},
  JRPRModelDocForm in 'Jrnl\JRPRModelDocForm.pas' {JR_PRModelForm},
  JRPREQPTDocForm in 'Jrnl\JRPREQPTDocForm.pas' {JR_PREQPTForm},
  ReqEditForm in 'Docs\ReqEditForm.pas' {DOC_REQUESTForm},
  DocMTROrder in 'Docs\DocMTROrder.pas' {DOC_MTROrderForm},
  OrderEditForm in 'Docs\OrderEditForm.pas' {DOC_ORDERForm},
  OrderEditLibs in 'Docs\OrderEditLibs.pas',
  ORCALCEditForm in 'Docs\ORCALCEditForm.pas' {DOCT_CALCForm},
  OROPEditForm in 'Docs\OROPEditForm.pas' {DOCT_OPERForm},
  OREQPTEditForm in 'Docs\OREQPTEditForm.pas' {DOCT_EQPTForm},
  PRMTRDocEditForm in 'Docs\PRMTRDocEditForm.pas' {DOC_PR_MTRForm},
  RSMTRDocEditForm in 'Docs\RSMTRDocEditForm.pas' {DOC_RS_MTRForm},
  RSDocEditForm in 'Docs\RSDocEditForm.pas' {DOC_RSForm},
  DocStructFrm in 'Docs\DocStructFrm.pas' {DOC_Structure_Form},
  RQSTEQPTEditForm in 'Docs\RQSTEQPTEditForm.pas' {DOC_RQSTEQPTForm},
  RSMODELEditForm in 'Docs\RSMODELEditForm.pas' {DOC_RSMODELForm},
  ORMTREditForm in 'Docs\ORMTREditForm.pas' {DOCT_MTRForm},
  PRDocEditForm in 'Docs\PRDocEditForm.pas' {DOC_PRForm},
  DocNMNTEdit in 'Docs\DocNMNTEdit.pas' {DOC_NMNT},
  PREQPTEditForm in 'Docs\PREQPTEditForm.pas' {DOC_PREQPTForm},
  RSEQPTEditForm in 'Docs\RSEQPTEditForm.pas' {DOC_RSEQPTForm},
  PRMODELEditForm in 'Docs\PRMODELEditForm.pas' {DOC_PRMODELForm},
  Libs in 'Libs.pas',
  Planning_Form in 'Planing\Planning_Form.pas' {PlanningForm},
  PROC_MTRPLAN in 'Planing\PROC_MTRPLAN.pas' {PROC_MTR_PLANForm},
  ParamForm in 'System\ParamForm.pas' {Param_Form},
  About in 'System\About.pas' {AboutBox},
  Splash in 'System\SPLASH.PAS' {SplashForm},
  MyCalend in 'System\MyCalend.pas' {CalendarForm},
  MainFormLib in 'MainFormLib.pas',
  JROperForm in 'OperGrid\JROperForm.pas' {JR_OPERForm},
  JRGantForm in 'OperGrid\JRGantForm.pas' {JR_GantForm},
  InfOperForm in 'OperGrid\InfOperForm.pas' {Inf_OperForm},
  OperPlanForm in 'OperGrid\OperPlanForm.pas' {OperPlan_Form},
  OKP_Planing in 'OperGrid\OKP_Planing.pas',
  AddExecuter_Form in 'OperGrid\AddExecuter_Form.pas' {AddExecuterForm},
  JROperDeleteForm in 'OperGrid\JROperDeleteForm.pas' {JR_OPERDELETEForm},
  EnumAccesstypeEdit in 'Enums\EnumAccesstypeEdit.pas' {ENUM_ACCESSTYPEForm},
  JREQPTRSPRForm in 'Jrnl\JREQPTRSPRForm.pas' {JR_EQPTRSPRForm},
  JRWRKRSERTForm in 'Jrnl\JRWRKRSERTForm.pas' {JR_WRKRSERTForm},
  ORTransportEditForm in 'Docs\ORTransportEditForm.pas' {DOCT_TransportForm},
  FiltrEnumEdit in 'Enums\FiltrEnumEdit.pas' {FiltrEnumForm},
  OrderOperForm in 'OperGrid\OrderOperForm.pas' {ORDER_OperForm};

{$R *.RES}
begin
  SplashForm := TSplashForm.Create(Application);
  SplashForm.Show;
  SplashForm.Update;

  Application.Initialize;
  Application.Title := 'PMASC: MES';
  Application.helpfile := 'rmphelp.hlp';
  Application.CreateForm(TMAINForm, MAINForm);
  Application.CreateForm(TDATA, DATA);
  Application.CreateForm(TFiltrEnumForm, FiltrEnumForm);
  if data.RMPBase.Connected then
    begin
      Application.CreateForm(TLIST_4SELECTForm, LIST_4SELECTForm);
      Application.CreateForm(TLIST_TREE4SelectForm, LIST_TREE4SelectForm);
      Application.CreateForm(TParam_Form, Param_Form);
      SplashForm.Hide;
      SplashForm.Free;
      Application.Run;
    end
   else
    begin
      SplashForm.Hide;
      SplashForm.Free;
    end;


end.
