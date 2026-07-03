unit FiltrOrderEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXSpin, Db, DBTables, Mask, ToolEdit, ExtCtrls, Grids, ValEdit,
  Placemnt;

type

    PFilter = ^tFilterValue;

    tFilterValue = record
       FilterName : string;
       FilterValue: string;
    end;

  TFilterForm = class(TForm)
    qPDRQuery: TQuery;
    qCSTQuery: TQuery;
    PanelMain: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    PDRCombo: TComboEdit;
    CSTCombo: TComboEdit;
    PanelCHRT: TPanel;
    CHRTCombo: TComboEdit;
    Label4: TLabel;
    Label3: TLabel;
    PanelBtn: TPanel;
    CancelButton: TButton;
    OKButton: TButton;
    qCHRTQuery: TQuery;
    PanelWRHS: TPanel;
    Label5: TLabel;
    WRHSCombo: TComboEdit;
    qWRHSQuery: TQuery;
    PanelOperFltr: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EQPTCombo: TComboEdit;
    WRKRCombo: TComboEdit;
    VOPCombo: TComboEdit;
    qEQPTQuery: TQuery;
    qWRKRQuery: TQuery;
    qVOPQuery: TQuery;
    Label9: TLabel;
    NMNTCombo: TComboEdit;
    qNMNTQuery: TQuery;
    PanelDate: TPanel;
    Label10: TLabel;
    Pr_execEdit: TRxSpinEdit;
    FromDateEdit: TDateEdit;
    ToDateEdit: TDateEdit;
    Button1: TButton;
    Pr_execCombo: TComboBox;
    chOnlyPositive: TCheckBox;
    CloseButton: TButton;
    OperCheckBox: TCheckBox;
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CSTComboButtonClick(Sender: TObject);
    procedure CSTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Procedure OnOpenForm;
    procedure CHRTComboButtonClick(Sender: TObject);
    procedure CHRTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WRHSComboButtonClick(Sender: TObject);
    procedure WRHSComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EQPTComboButtonClick(Sender: TObject);
    procedure EQPTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WRKRComboButtonClick(Sender: TObject);
    procedure WRKRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VOPComboButtonClick(Sender: TObject);
    procedure VOPComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Pr_execEditChange(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
  private

  public
    id_pdr : integer;
    id_cst : integer;
    pr_exec: integer;
    id_chrt: integer;
    id_wrhs: integer;
    id_wrkr: integer;
    id_eqpt: integer;
    id_vop : integer;
    id_nmnt: integer;
    FromDate : tdate;
    ToDate   : tdate;
    onlypositive : integer;
    opernorm : integer;     //наличие не нормированных операций

    FilterList : tList;



  end;

var
  FilterForm: TFilterForm;
     Filter : pFilter;


implementation

uses libs,
     GetPeriods;

{$R *.DFM}
{
    Процедура выбора из справочника подразделений
}
procedure TFilterForm.PDRComboButtonClick(Sender: TObject);
begin
  id_pdr := SelectFromTable(PDRCombo);

end;
{
   Процедура обработки нажатия клавиши в окне подразделений
}
procedure TFilterForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);

  id_pdr := qPDRQuery.Fields[0].asinteger;

end;
{

   Процедура выбора из справочника заказчиков
}
procedure TFilterForm.CSTComboButtonClick(Sender: TObject);
begin
  id_cst:=SelectFromTable(CSTCombo);

end;
{

    Процедура обработки нажатия клавиши в окне заказчиков
}
procedure TFilterForm.CSTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTCombo, key, Shift) = false then
     CSTComboButtonClick(Sender);

  id_cst := qCSTQuery.Fields[0].asinteger;

end;

{
    Нажата кнопка ОК
}
procedure TFilterForm.OKButtonClick(Sender: TObject);
begin
   ModalResult := mrOK;
end;

{
         Процедура закрытия формы по Cancel
}
procedure TFilterForm.CancelButtonClick(Sender: TObject);
begin
    // очистить фильтр
    qPDRQuery.close;
    qCSTQuery.close;
    qWRHSQuery.close;
    qWRKRQuery.close;
    qEQPTQuery.close;
    qVOPQuery.close;

    PDRCombo.Text := '';
    CSTCombo.text := '';
    WRKRCombo.text:= '';
    WRHSCombo.text:= '';
    EQPTCombo.text:= '';
    VOPCombo.text := '';
    
    PR_EXECEdit.Text  := '0';

    ModalResult := mrCancel;
end;

procedure TFilterForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;
{
   Процедура при открытии формы фильтра
   При открытии заполняются значения отбора, если они установлены

}
Procedure TFilterForm.OnOpenForm;
begin
  // заполнение запроса
  // если есть отбор по подразделениям
  PDRCombo.ID  := id_pdr;
  CSTCombo.ID  := id_cst;
  CHRTCombo.ID := id_chrt;
  WRHSCombo.ID := id_wrhs;
  WRKRCombo.ID := id_wrkr;
  EQPTCombo.ID := id_eqpt;
  VOPCombo.ID  := id_vop;
  NMNTCombo.ID := id_nmnt;

  // если есть отбор по выполнениям
  if pr_exec > 0 then
    begin
      PR_EXECEdit.text := inttostr(pr_exec);
    end;

  if FromDate <> 0 then
    FromDateEdit.Text := datetostr(FromDate)
    else
     FromDateEdit.Text := '';

  if ToDate <> 0 then
    ToDateEdit.Text   := datetostr(ToDate)
    else
      ToDateEdit.Text   := '';

      

end;
{
      Выбор из справочника чертежей
}
procedure TFilterForm.CHRTComboButtonClick(Sender: TObject);
begin
  id_chrt := SelectFromTable(CHRTCombo);

end;
{

}
procedure TFilterForm.CHRTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CHRTCombo, key, Shift) = false then
     CHRTComboButtonClick(Sender);

  id_chrt := qCHRTQuery.Fields[0].asinteger;

end;
//
//  Выбор из справочника складов
procedure TFilterForm.WRHSComboButtonClick(Sender: TObject);
begin
  id_wrhs := SelectFromTable(WRHSCombo);

end;

procedure TFilterForm.WRHSComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WRHSCombo, key, Shift) = false then
     WRHSComboButtonClick(Sender);

  id_wrhs := qWRHSQuery.Fields[0].asinteger;

end;

procedure TFilterForm.EQPTComboButtonClick(Sender: TObject);
begin
//  If EQPTCombo.ID = 0 Then EQPTCombo.ID := -1;
  id_eqpt := SelectFromTable(EQPTCombo);

end;

procedure TFilterForm.EQPTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(EQPTCombo, key, Shift) = false then
     EQPTComboButtonClick(Sender);
  id_eqpt := qEQPTQuery.Fields[0].asinteger;

end;

procedure TFilterForm.WRKRComboButtonClick(Sender: TObject);
begin
//  WRKRCombo.ID := -1;
  id_wrkr :=SelectFromTable(WRKRCombo);

end;

procedure TFilterForm.WRKRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WRKRCombo, key, Shift) = false then
     WRKRComboButtonClick(Sender);

  id_wrkr := qWRKRQuery.Fields[0].asinteger;

end;

procedure TFilterForm.VOPComboButtonClick(Sender: TObject);
begin
  id_vop := SelectFromTable(VOPCombo);

end;

procedure TFilterForm.VOPComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if checkIfExistCode(VOPCombo, key, Shift) = false then
     VOPComboButtonClick(Sender);

  id_vop := qVOPQuery.Fields[0].asinteger;

end;

procedure TFilterForm.NMNTComboButtonClick(Sender: TObject);
begin
  id_nmnt := SelectFromTable(NMNTCombo);

end;

procedure TFilterForm.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if checkIfExistCode(NMNTCombo, key, Shift) = false then
     NMNTComboButtonClick(Sender);

  id_nmnt := qNMNTQuery.Fields[0].asinteger;

end;

procedure TFilterForm.Button1Click(Sender: TObject);
var _d1, _d2: tdatetime;
    sparam : string;
begin
   if trim(FromDateEdit.text) <> '.  .' then
     _d1 := strtodate(FromDateEdit.text)
    else
       _d1 := date;

   if trim(ToDateEdit.text) <> '.  .' then
    _d2 := strtodate(ToDateEdit.text)
     else
      _d2 := date;

   GetPeriod(_d1, _d2);
   sparam := datetostr(_d1);
   FromDateEdit.text := sparam;

   sparam := datetostr(_d2);
   ToDateEdit.text   := sparam;



end;

procedure TFilterForm.FormCreate(Sender: TObject);
begin
    id_pdr := -1;
    id_cst := -1;
    pr_exec := 0;
    id_chrt := -1;
    id_wrhs := -1;
    id_wrkr := -1;
    id_eqpt := -1;
    id_vop  := -1;
    id_nmnt := -1;
    FromDate := 0;
    ToDate   := 0;

end;

procedure TFilterForm.Pr_execEditChange(Sender: TObject);
begin
  pr_exec := strtoint(PR_ExecEdit.text);
end;

procedure TFilterForm.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrIgnore;
end;

end.
