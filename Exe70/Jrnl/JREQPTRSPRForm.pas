unit JREQPTRSPRForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ToolWin, ComCtrls, Grids, DBGrids, DB, DBTables, Menus,
  DBGridEh, StdCtrls;

type
  StandardProc = procedure(ParentApplication: tApplication;
    ParentForm : tForm; iddoc : integer; data : tDataBase); StdCall;
  StandardProc_Wrkr_Card = procedure(ParentApplication: tApplication;
    ParentForm : tForm; iddoc : integer; FromDate : TDateTime; ToDate : TDateTime; data : tDataBase); StdCall;

  TJR_EQPTRSPRForm = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    RightPanel: TPanel;
    PREqptPanel: TPanel;
    Splitter2: TSplitter;
    RSEqptPanel: TPanel;
    EqptQuery: TQuery;
    PREqptQuery: TQuery;
    RSEqptQuery: TQuery;
    EqptDataSource: TDataSource;
    PRDataSource: TDataSource;
    RSDataSource: TDataSource;
    Panel5: TPanel;
    EqptDBGridEh: TDBGridEh;
    PREqptDBGridEh: TDBGridEh;
    RSEqptDBGridEh: TDBGridEh;
    ControlBar1: TControlBar;
    ToolBar1: TToolBar;
    PREqptToolButton: TToolButton;
    RSEqptToolButton: TToolButton;
    ToolButton5: TToolButton;
    PR_Doc_ToolButton: TToolButton;
    RS_Doc_ToolButton: TToolButton;
    ToolBar2: TToolBar;
    Date_Filter_ToolButton: TToolButton;
    Searchkey: TEdit;
    FindButton: TButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    Button1: TButton;
    PRPanel: TPanel;
    RSPanel: TPanel;
    EQPT_RS_Button: TButton;
    TotalLabel: TLabel;
    EdizQuery: TQuery;
    refresh_button: TToolButton;
    Panel2: TPanel;
    Label_Eqpt_In_Vozvr: TLabel;
    Panel3: TPanel;
    Label_Eqpt_Out_Vyd: TLabel;
    Wrkr_Card_Button: TButton;
    Label_Eqpt_In_Post: TLabel;
    Label_Eqpt_In_Total: TLabel;
    Label_Eqpt_Out_Spis: TLabel;
    Label_Eqpt_Out_Total: TLabel;
    procedure FindButtonClick(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EqptDataSourceDataChange(Sender: TObject; Field: TField);
    procedure PREqptDBGridEhDblClick(Sender: TObject);
    procedure RSEqptDBGridEhDblClick(Sender: TObject);
    procedure EqptDBGridEhDblClick(Sender: TObject);
    procedure PREqptToolButtonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RSEqptToolButtonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PR_Doc_ToolButtonClick(Sender: TObject);
    procedure RS_Doc_ToolButtonClick(Sender: TObject);
    procedure Date_Filter_ToolButtonClick(Sender: TObject);
    procedure SearchkeyKeyPress(Sender: TObject; var Key: Char);
    procedure EqptDBGridEhTitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure sort_table(type_of_sort: integer);
    procedure EQPT_RS_ButtonClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure refresh_buttonClick(Sender: TObject);
    procedure PREqptDBGridEhDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure RSEqptDBGridEhDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure Wrkr_Card_ButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    Print_Eqpt_RS_form   : StandardProc;
    Print_Wrkr_Card_form : StandardProc_Wrkr_Card;
  public
    TypeForm   : Integer;           // тип формы расположенной на понели слева 1 - Инструмент, 2 - Работники
    constructor CreateN(AOwner: TForm; _TypeForm: Integer);
    destructor Destroy; override;
  end;

var
  JR_EQPTRSPRForm: TJR_EQPTRSPRForm;
  FromDate   : tdatetime;         // начало интервала
  ToDate     : tdatetime;         // конец интервала
  ProcAddr   : FarProc;

implementation

uses ParamForm,
     Libs,
     Base,
     Main,
     PREQPTEditForm,
     RSEQPTEditForm,
     EnumTreeForm,
     GetPeriods,
     EQPTEdit,
     WRKREdit;
{$R *.dfm}

// TypeForm - тип формы расположенной на понели слева: 1 - Инструмент
//                                                     2 - Работники
constructor TJR_EQPTRSPRForm.createN(AOwner: TForm; _TypeForm: Integer);
var i : integer;
    menuitem : tmenuitem;
    Eqpt_In_Post, Eqpt_In_Vozvr, Eqpt_In_Total,
    Eqpt_Out_Vyd, Eqpt_Out_Spis, Eqpt_Out_Total : Integer;

begin

  inherited Create(AOwner);

  TypeForm := _TypeForm;

  with PREqptQuery do
    begin

      close;
      sql.clear;

      Case TypeForm of
         1: begin
              sql.add('Select * From VIEW_EQPT_PR_PROC (:ID_EQPT, :DATE_BEG, :DATE_END)');
            end;
         2: begin
              sql.add('Select * From VIEW_WRKR_PR_PROC (:ID_WRKR, :DATE_BEG, :DATE_END)');
            end;
      end;

    end;


  with RSEqptQuery do
    begin

      close;
      sql.clear;
      Case TypeForm of
         1: begin
              sql.add('Select * From VIEW_EQPT_RS_PROC (:ID_EQPT, :DATE_BEG, :DATE_END)');
            end;
         2: begin
              sql.add('Select * From VIEW_WRKR_RS_PROC (:ID_WRKR, :DATE_BEG, :DATE_END)');
            end;
      end;

    end;


    with EqptQuery do
    begin

      close;
      sql.clear;

      //этот же запрос в проседуре sort_table
      Case TypeForm of
         1: begin
              sql.add('Select a.code, a.name, a.id, a.parentid, a.id_ediz, Sum(b.Number) as NSum');
              sql.add('From Spr_Eqpt a, St_Eqpt b ');
              sql.add('Where a.isfolder = 0 and b.ID_Eqpt = a.ID ');
              sql.add('Group By a.code, a.name, a.id, a.parentid, a.id_ediz');
              EqptDBGridEh.Columns[0].Title.Caption := 'Инв. номер';
              EqptDBGridEh.Columns[1].Title.Caption := 'Наименование';
            end;
         2: begin
              sql.add('Select a.code, a.name, a.id, Sum(b.Number) as NSum');
              sql.add('From Spr_Wrkr a, St_Eqpt b ');
              sql.add('Where b.ID_Wrkr = a.ID ');
              sql.add('Group By a.code, a.name, a.id');
              EqptDBGridEh.Columns[0].Title.Caption := 'Таб. номер';
              EqptDBGridEh.Columns[1].Title.Caption := 'Фамилия И.О.';
            end;
      end;
      open;

    end;

    Case TypeForm of
       1:  caption   := ':Журнал перемещения инструмента на складе';
       2:  caption   := ':Журнал выдачи инструмента работникам РМП';
    end;

    HelpContext := 352;

    EqptQuery.First;

    with PREqptQuery do
    begin

      close;
      Case TypeForm of
         1: begin
              parambyname('ID_EQPT').AsInteger := EqptQuery.FieldByName('ID').AsInteger;
              parambyname('DATE_BEG').AsDate := strtodate(Param_Form.DateFromEdit.text);
              parambyname('DATE_END').AsDate := strtodate(Param_Form.DateToEdit.text);
              PREqptDBGridEh.Columns[7].Title.Caption := 'Работник';
              //semanov
              //PREqptDBGridEh.Columns[7].Visible := True;
//              PREqptDBGridEh.Columns[4].Visible := False;
//              PREqptDBGridEh.Columns[5].Visible := False;
//              PREqptDBGridEh.Columns[6].Visible := False;
//              PREqptDBGridEh.Columns[7].Visible := False;
            end;
         2: begin
              parambyname('ID_WRKR').AsInteger := EqptQuery.FieldByName('ID').AsInteger;
              parambyname('DATE_BEG').AsDate := strtodate(Param_Form.DateFromEdit.text);
              parambyname('DATE_END').AsDate := strtodate(Param_Form.DateToEdit.text);
              PREqptDBGridEh.Columns[7].Title.Caption := 'Инструмент';
//              PREqptDBGridEh.Columns[7].Visible := False;
              //semanov
//              PREqptDBGridEh.Columns[4].Visible := False;
//              PREqptDBGridEh.Columns[5].Visible := False;
            end;
      end;
      open;
      First;
//      PREqptQuery.FieldByName('INFO').DataType:=ftString;
    end;


  with RSEqptQuery do
    begin

      close;
      Case TypeForm of
         1: begin
//              sql.add('Select * From VIEW_EQPT_RS_PROC (:ID_EQPT, :DATE_BEG, :DATE_END)');
              parambyname('ID_EQPT').AsInteger := EqptQuery.FieldByName('ID').AsInteger;
              parambyname('DATE_BEG').AsDate := strtodate(Param_Form.DateFromEdit.text);
              parambyname('DATE_END').AsDate := strtodate(Param_Form.DateToEdit.text);
              RSEqptDBGridEh.Columns[7].Title.Caption := 'Работник';
              //semanov
              //RSEqptDBGridEh.Columns[7].Visible := True;
//              RSEqptDBGridEh.Columns[4].Visible := False;
//              RSEqptDBGridEh.Columns[5].Visible := False;
              //RSEqptDBGridEh.Columns[6].Visible := False;
//              RSEqptDBGridEh.Columns[7].Visible := False;
            end;
         2: begin
//              sql.add('Select * From VIEW_WRKR_RS_PROC (:ID_WRKR, :DATE_BEG, :DATE_END)');
              parambyname('ID_WRKR').AsInteger := EqptQuery.FieldByName('ID').AsInteger;
              parambyname('DATE_BEG').AsDate := strtodate(Param_Form.DateFromEdit.text);
              parambyname('DATE_END').AsDate := strtodate(Param_Form.DateToEdit.text);
              RSEqptDBGridEh.Columns[7].Title.Caption := 'Инструмент';
//              RSEqptDBGridEh.Columns[7].Visible := False;
              //semanov
//              RSEqptDBGridEh.Columns[4].Visible := False;
//              RSEqptDBGridEh.Columns[5].Visible := False;
            end;
      end;
      open;
      First;

    end;

      If not RSEqptQuery.Eof Then EQPT_RS_Button.Enabled := True
       else EQPT_RS_Button.Enabled := False;

      If TypeForm = 2 Then Wrkr_Card_Button.Visible := True
       else Wrkr_Card_Button.Visible := False;

    //Вывод итогов по инструменту на складах
    If EqptQuery.FieldByName('NSum').AsFloat = Null Then
        TotalLabel.Caption := 'Итого: 0'
     else
          TotalLabel.Caption := 'Итого: '+ EqptQuery.FieldByName('NSum').AsString + ' шт.';

    Eqpt_In_Post := 0;
    Eqpt_In_Vozvr:= 0;
    Eqpt_In_Total:= 0;

    While not PREqptQuery.Eof do
    begin

       If PREqptQuery.FieldByName('Type_Doc').AsString = 'Возврат' Then
           Eqpt_In_Vozvr := Eqpt_In_Vozvr + PREqptQuery.FieldByName('Number').AsInteger;

       If PREqptQuery.FieldByName('Type_Doc').AsString = 'Поступление' Then
           Eqpt_In_Post := Eqpt_In_Post + PREqptQuery.FieldByName('Number').AsInteger;

       Eqpt_In_Total := Eqpt_In_Total + PREqptQuery.FieldByName('Number').AsInteger;

       PREqptQuery.Next;
    end;

    Label_Eqpt_In_Vozvr.Caption := 'Возвращено с '+DateToStr(FromDate)+' по '+
                            DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_In_Vozvr) + ' шт.';

    Label_Eqpt_In_Post.Caption := 'Поступило с '+DateToStr(FromDate)+' по '+
                            DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_In_Post) + ' шт.';

    Label_Eqpt_In_Total.Caption := 'Итого инструмента: '+IntToStr(Eqpt_In_Total) + ' шт.';

    Eqpt_Out_Vyd  := 0;
    Eqpt_Out_Spis := 0;
    Eqpt_Out_Total:= 0;

    While not RSEqptQuery.Eof do
    begin
       If RSEqptQuery.FieldByName('Type_Doc').AsString = 'Выдача' Then
           Eqpt_Out_Vyd := Eqpt_Out_Vyd + RSEqptQuery.FieldByName('Number').AsInteger;

       If RSEqptQuery.FieldByName('Type_Doc').AsString = 'Списание' Then
           Eqpt_Out_Spis := Eqpt_Out_Spis + RSEqptQuery.FieldByName('Number').AsInteger;

       Eqpt_Out_Total := Eqpt_Out_Total + RSEqptQuery.FieldByName('Number').AsInteger;

       RSEqptQuery.Next;
    end;

    Label_Eqpt_Out_Vyd.Caption := 'Выдано с '+DateToStr(FromDate)+' по '+
                            DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_Out_Vyd) + ' шт.';

    Label_Eqpt_Out_Spis.Caption := 'Списано с '+DateToStr(FromDate)+' по '+
                            DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_Out_Spis) + ' шт.';

    Label_Eqpt_Out_Total.Caption := 'Итого инструмента: '+IntToStr(Eqpt_Out_Total) + ' шт.';

    // в зависимости от пожелания открываются окна
    if Param_Form.glOpenAllFormMaximized then
    WindowState := wsMaximized;

    FromDate := strtodate(Param_Form.DateFromEdit.text);
    ToDate := strtodate(Param_Form.DateToEdit.text);

    PREqptPanel.Height := RightPanel.Height div 2;
    RSEqptPanel.Height := RightPanel.Height - PREqptPanel.Height;
    PREqptToolButton.Down := True;
    PREqptPanel.Align := alTop;
    RSEqptToolButton.Down := True;
    RSEqptPanel.Align := alClient;
    PREqptToolButton.Hint := 'Отключить Приходные документы';
    PREqptToolButton.ShowHint := True;
    RSEqptToolButton.Hint := 'Отключить Расходные документы';
    RSEqptToolButton.ShowHint := True;


end;

destructor TJR_EQPTRSPRForm.Destroy;
begin
  inherited;
end;

procedure TJR_EQPTRSPRForm.FindButtonClick(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not EqptQuery.eof then EqptQuery.next;
    find(EqptQuery, EqptDBGridEh, Searchkey.text, 1);
end;

procedure TJR_EQPTRSPRForm.ToolButton7Click(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not EqptQuery.eof then EqptQuery.next;
    find(EqptQuery, EqptDBGridEh, Searchkey.text, 1);
end;

procedure TJR_EQPTRSPRForm.ToolButton8Click(Sender: TObject);
begin
 if Searchkey.text = '' then exit;
  if not EqptQuery.bof then EqptQuery.prior;
    find(EqptQuery, EqptDBGridEh, Searchkey.text, -1);
end;

procedure TJR_EQPTRSPRForm.Button1Click(Sender: TObject);
begin
    close;
end;

procedure TJR_EQPTRSPRForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
   begin
     EscPressed := True;
     abort;
     
   end;
end;

procedure TJR_EQPTRSPRForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TJR_EQPTRSPRForm.EqptDataSourceDataChange(Sender: TObject;
  Field: TField);
Var  Eqpt_In_Post, Eqpt_In_Vozvr, Eqpt_In_Total,
     Eqpt_Out_Vyd, Eqpt_Out_Spis, Eqpt_Out_Total : Integer;
begin

      PREqptQuery.Close;
      Case TypeForm of
         1: begin
              PREqptQuery.ParamByName('ID_EQPT').AsInteger := EqptQuery.FieldByName('id').AsInteger;
              PREqptQuery.ParamByName('DATE_BEG').AsDate := FromDate;
              PREqptQuery.ParamByName('DATE_END').AsDate := ToDate;
            end;
         2: begin
              PREqptQuery.ParamByName('ID_WRKR').AsInteger := EqptQuery.FieldByName('id').AsInteger;
              PREqptQuery.ParamByName('DATE_BEG').AsDate := FromDate;
              PREqptQuery.ParamByName('DATE_END').AsDate := ToDate;
            end;
      end;
      PREqptQuery.Open;
      PREqptQuery.First;


      RSEqptQuery.Close;
      Case TypeForm of
         1: begin
              RSEqptQuery.ParamByName('ID_EQPT').AsInteger := EqptQuery.FieldByName('id').AsInteger;
              RSEqptQuery.ParamByName('DATE_BEG').AsDate := FromDate;
              RSEqptQuery.ParamByName('DATE_END').AsDate := ToDate;
            end;
         2: begin
              RSEqptQuery.ParamByName('ID_WRKR').AsInteger := EqptQuery.FieldByName('id').AsInteger;
              RSEqptQuery.ParamByName('DATE_BEG').AsDate := FromDate;
              RSEqptQuery.ParamByName('DATE_END').AsDate := ToDate;
            end;
      end;
      RSEqptQuery.Open;
      RSEqptQuery.First;

      If not RSEqptQuery.Eof Then EQPT_RS_Button.Enabled := True
       else EQPT_RS_Button.Enabled := False;

      //Вывод итогов по инструменту на складах
      If EqptQuery.FieldByName('NSum').AsFloat = Null Then
          TotalLabel.Caption := 'Итого: 0'
       else
            TotalLabel.Caption := 'Итого: '+ EqptQuery.FieldByName('NSum').AsString;

      Eqpt_In_Post := 0;
      Eqpt_In_Vozvr:= 0;
      Eqpt_In_Total:= 0;

      While not PREqptQuery.Eof do
      begin

         If PREqptQuery.FieldByName('Type_Doc').AsString = 'Возврат' Then
             Eqpt_In_Vozvr := Eqpt_In_Vozvr + PREqptQuery.FieldByName('Number').AsInteger;

         If PREqptQuery.FieldByName('Type_Doc').AsString = 'Поступление' Then
             Eqpt_In_Post := Eqpt_In_Post + PREqptQuery.FieldByName('Number').AsInteger;

         Eqpt_In_Total := Eqpt_In_Total + PREqptQuery.FieldByName('Number').AsInteger;

         PREqptQuery.Next;
      end;

      Label_Eqpt_In_Vozvr.Caption := 'Возвращено с '+DateToStr(FromDate)+' по '+
                              DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_In_Vozvr) + ' шт.';

      Label_Eqpt_In_Post.Caption := 'Поступило с '+DateToStr(FromDate)+' по '+
                              DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_In_Post) + ' шт.';

      Label_Eqpt_In_Total.Caption := 'Итого инструмента: '+IntToStr(Eqpt_In_Total) + ' шт.';

      Eqpt_Out_Vyd  := 0;
      Eqpt_Out_Spis := 0;
      Eqpt_Out_Total:= 0;

      While not RSEqptQuery.Eof do
      begin
         If RSEqptQuery.FieldByName('Type_Doc').AsString = 'Выдача' Then
             Eqpt_Out_Vyd := Eqpt_Out_Vyd + RSEqptQuery.FieldByName('Number').AsInteger;

         If RSEqptQuery.FieldByName('Type_Doc').AsString = 'Списание' Then
             Eqpt_Out_Spis := Eqpt_Out_Spis + RSEqptQuery.FieldByName('Number').AsInteger;

         Eqpt_Out_Total := Eqpt_Out_Total + RSEqptQuery.FieldByName('Number').AsInteger;

         RSEqptQuery.Next;
      end;

      Label_Eqpt_Out_Vyd.Caption := 'Выдано с '+DateToStr(FromDate)+' по '+
                              DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_Out_Vyd) + ' шт.';

      Label_Eqpt_Out_Spis.Caption := 'Списано с '+DateToStr(FromDate)+' по '+
                              DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_Out_Spis) + ' шт.';

      Label_Eqpt_Out_Total.Caption := 'Итого инструмента: '+IntToStr(Eqpt_Out_Total) + ' шт.';

end;

procedure TJR_EQPTRSPRForm.PREqptDBGridEhDblClick(Sender: TObject);
var DocForm: TDOC_PREQPTForm;
begin
  if  (PREQPTQuery.FieldByName('ID').isnull) then exit;

  IDDoc := PREqptQuery.FieldByName('ID').asinteger;


  // открыть форму редактирования нового документа
  DocForm := TDOC_PREQPTForm.CreateN(mainform, IDDoc);
    DocForm.OKButton.Enabled :=  check_user_grand('DH_PR_EQPT', 'U', true);

//  if CheckOfOpened(DocForm.Caption, '') = false then
//    DocForm.Release;

  DocForm.show;

end;

procedure TJR_EQPTRSPRForm.RSEqptDBGridEhDblClick(Sender: TObject);
var DocForm: TDOC_RSEQPTForm;
begin
  if  (RSEqptQuery.FieldByName('ID').isnull) then exit;

  IDDoc := RSEqptQuery.FieldByName('ID').asinteger;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSEQPTForm.CreateN(mainform, IDDoc);
    DocForm.OKButton.Enabled :=  check_user_grand('DH_RS_EQPT', 'U', true);

  DocForm.show;
end;

procedure TJR_EQPTRSPRForm.EqptDBGridEhDblClick(Sender: TObject);
var
  ParentID: integer;
  ID: integer;
  ENUM_EQPTForm : TENUM_EQPTForm;
  ENUM_WRKRForm : TENUM_WRKRForm;
begin

      Case TypeForm of
         1: begin
              MainForm.ID := EqptQuery.FieldByName('id').AsInteger;
              MainForm.IsFolder := 3;
              ENUM_EQPTForm := TENUM_EQPTForm.create(self);
              ENUM_EQPTForm.ShowModal;
            end;
         2: begin
              MainForm.ID := EqptQuery.FieldByName('id').AsInteger;
              MainForm.IsFolder := 3;
              ENUM_WRKRForm := TENUM_WRKRForm.create(self);
              ENUM_WRKRForm.ShowModal;
            end;
      end;

end;

procedure TJR_EQPTRSPRForm.PREqptToolButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

   If Button = mbLeft Then
   begin
      If PREqptToolButton.Down = False Then
      begin

         If RSEqptToolButton.Down = True Then
         begin
           PREqptPanel.Align := alTop;
           PREqptPanel.Height := RightPanel.Height div 2;
           Splitter2.Align := alTop;
         end
          else
          begin
             Splitter2.Align := alBottom;
             PREqptPanel.Align := alClient;
          end;

         PREqptToolButton.Hint := 'Отключить Приходные документы';
         PREqptToolButton.ShowHint := True;
      end
       else
       begin
          PREqptPanel.Align := alTop;
          Splitter2.Align := alTop;
          PREqptPanel.Height := PRPanel.Height;
          PREqptToolButton.Hint := 'Подключить Приходные документы';
          PREqptToolButton.ShowHint := True;
       end;
   end;
end;

procedure TJR_EQPTRSPRForm.RSEqptToolButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

   If Button = mbLeft Then
   begin
      If RSEqptToolButton.Down = False Then
      begin

         If PREqptToolButton.Down = True Then
         begin
           PREqptPanel.Align := alTop;
           PREqptPanel.Height := RightPanel.Height div 2;
           Splitter2.Align := alTop;
         end;

         RSEqptPanel.Align := alClient;
         RSEqptToolButton.Hint := 'Отключить Расходные документы';
         RSEqptToolButton.ShowHint := True;
      end
       else
       begin

          RSEqptPanel.Align := alNone;
          RSEqptPanel.Height := RSPanel.Height;
          RSEqptPanel.Align := alBottom;
          Splitter2.Align := alBottom;
          RSEqptToolButton.Hint := 'Подключить Расходные документы';
          RSEqptToolButton.ShowHint := True;

          If PREqptToolButton.Down = True Then
              PREqptPanel.Align := alClient;
       end;
   end;
end;

procedure TJR_EQPTRSPRForm.PR_Doc_ToolButtonClick(Sender: TObject);
var DocForm: TDOC_PREQPTForm;
begin
  if not check_user_grand('DH_PR_EQPT', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_PREQPTForm.CreateN(self, - 1);

  If TypeForm = 1 Then
  begin
    EdizQuery.Close;
    EdizQuery.SQL.Clear;
    EdizQuery.SQL.Add('Select Name From Spr_Ediz Where id = :id_ediz');
    EdizQuery.ParamByName('id_ediz').AsInteger := EqptQuery.FieldByName('ID_EDIZ').AsInteger;
    EdizQuery.Open;

    DocForm.MemoryData.Insert;
    DocForm.MemoryData.Fields[0].asinteger := 1;
    DocForm.MemoryData.Fields[1].AsString  := EqptQuery.FieldByName('NAME').AsString;
    DocForm.MemoryData.Fields[2].AsString  := EdizQuery.FieldByName('Name').AsString;
    DocForm.MemoryData.Fields[3].asinteger := 1;
    DocForm.MemoryData.Fields[4].asinteger := EqptQuery.FieldByName('ID').AsInteger;
    DocForm.MemoryData.Fields[5].asinteger := EqptQuery.FieldByName('ID_EDIZ').AsInteger;
    DocForm.MemoryData.Post;
  end;  

  DocForm.show;
end;

procedure TJR_EQPTRSPRForm.RS_Doc_ToolButtonClick(Sender: TObject);
var DocForm: TDOC_RSEQPTForm;
begin
  if not check_user_grand('DH_RS_EQPT', 'I', true)
    then exit;

  // открыть форму редактирования нового документа
  DocForm := TDOC_RSEQPTForm.CreateN(self, - 1);

  If TypeForm = 1 Then
  begin
    EdizQuery.Close;
    EdizQuery.SQL.Clear;
    EdizQuery.SQL.Add('Select Name From Spr_Ediz Where id = :id_ediz');
    EdizQuery.ParamByName('id_ediz').AsInteger := EqptQuery.FieldByName('ID_EDIZ').AsInteger;
    EdizQuery.Open;

    DocForm.MemoryData.Insert;
    DocForm.MemoryData.Fields[0].asinteger := 1;
    DocForm.MemoryData.Fields[1].AsString  := EqptQuery.FieldByName('NAME').AsString;
    DocForm.MemoryData.Fields[2].AsString  := EdizQuery.FieldByName('Name').AsString;
    DocForm.MemoryData.Fields[3].asinteger := 1;
    DocForm.MemoryData.Fields[4].asinteger := EqptQuery.FieldByName('ID').AsInteger;
    DocForm.MemoryData.Fields[5].asinteger := EqptQuery.FieldByName('ID_EDIZ').AsInteger;
    DocForm.MemoryData.Post;
  end;  

  DocForm.show;
end;

procedure TJR_EQPTRSPRForm.Date_Filter_ToolButtonClick(Sender: TObject);
Var  Eqpt_In_Post, Eqpt_In_Vozvr, Eqpt_In_Total,
     Eqpt_Out_Vyd, Eqpt_Out_Spis, Eqpt_Out_Total : Integer;
begin
  if not GetPeriod(FromDate, ToDate) then exit;

{
  // изменим название окна
  caption := 'Журнал списания инструмента с ' + datetostr(fromDate) + ' по ' + datetostr(toDate);
}
  // обновление таблиц

{  with EqptQuery do
    begin

      close;
      sql.clear;
      //этот же запрос в проседуре sort_table
      sql.add('Select a.code, a.name, a.id, a.parentid, Sum(b.Number) as NSum');
      sql.add('From Spr_Eqpt a, St_Eqpt b ');
      sql.add('Where a.isfolder = 0 and b.ID_Eqpt = a.ID and');
      sql.add('b.DateDoc >= :DATE_BEG and b.DateDoc <= :DATE_END');
      sql.add('Group By a.code, a.name, a.id, a.parentid');

      ParamByName('DATE_BEG').AsDate := FromDate;
      ParamByName('DATE_END').AsDate := ToDate;

      open;

    end;      }

  with PREqptQuery do
    begin

      close;
      Case TypeForm of
         1: begin
              ParamByName('DATE_BEG').asdate  := FromDate;
              ParamByName('DATE_END').asdate := ToDate;
              ParamByName('ID_EQPT').asinteger  := EqptQuery.FieldByName('ID').AsInteger;
            end;
         2: begin
              ParamByName('DATE_BEG').asdate  := FromDate;
              ParamByName('DATE_END').asdate := ToDate;
              ParamByName('ID_WRKR').asinteger  := EqptQuery.FieldByName('ID').AsInteger;
            end;
      end;
      open;
      First;
    end;

  with RSEqptQuery do
    begin

      close;
      Case TypeForm of
         1: begin
              ParamByName('DATE_BEG').asdate  := FromDate;
              ParamByName('DATE_END').asdate := ToDate;
              ParamByName('ID_EQPT').asinteger  := EqptQuery.FieldByName('ID').AsInteger;
            end;
         2: begin
              ParamByName('DATE_BEG').asdate  := FromDate;
              ParamByName('DATE_END').asdate := ToDate;
              ParamByName('ID_WRKR').asinteger  := EqptQuery.FieldByName('ID').AsInteger;
            end;
      end;
      open;
      First;

    end;

    Eqpt_In_Post := 0;
    Eqpt_In_Vozvr:= 0;
    Eqpt_In_Total:= 0;

    While not PREqptQuery.Eof do
    begin

       If PREqptQuery.FieldByName('Type_Doc').AsString = 'Возврат' Then
           Eqpt_In_Vozvr := Eqpt_In_Vozvr + PREqptQuery.FieldByName('Number').AsInteger;

       If PREqptQuery.FieldByName('Type_Doc').AsString = 'Поступление' Then
           Eqpt_In_Post := Eqpt_In_Post + PREqptQuery.FieldByName('Number').AsInteger;

       Eqpt_In_Total := Eqpt_In_Total + PREqptQuery.FieldByName('Number').AsInteger;

       PREqptQuery.Next;
    end;

    Label_Eqpt_In_Vozvr.Caption := 'Возвращено с '+DateToStr(FromDate)+' по '+
                            DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_In_Vozvr) + ' шт.';

    Label_Eqpt_In_Post.Caption := 'Поступило с '+DateToStr(FromDate)+' по '+
                            DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_In_Post) + ' шт.';

    Label_Eqpt_In_Total.Caption := 'Итого инструмента: '+IntToStr(Eqpt_In_Total) + ' шт.';

    Eqpt_Out_Vyd  := 0;
    Eqpt_Out_Spis := 0;
    Eqpt_Out_Total:= 0;

    While not RSEqptQuery.Eof do
    begin
       If RSEqptQuery.FieldByName('Type_Doc').AsString = 'Выдача' Then
           Eqpt_Out_Vyd := Eqpt_Out_Vyd + RSEqptQuery.FieldByName('Number').AsInteger;

       If RSEqptQuery.FieldByName('Type_Doc').AsString = 'Списание' Then
           Eqpt_Out_Spis := Eqpt_Out_Spis + RSEqptQuery.FieldByName('Number').AsInteger;

       Eqpt_Out_Total := Eqpt_Out_Total + RSEqptQuery.FieldByName('Number').AsInteger;

       RSEqptQuery.Next;
    end;

    Label_Eqpt_Out_Vyd.Caption := 'Выдано с '+DateToStr(FromDate)+' по '+
                            DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_Out_Vyd) + ' шт.';

    Label_Eqpt_Out_Spis.Caption := 'Списано с '+DateToStr(FromDate)+' по '+
                            DateToStr(ToDate)+' инструмента: '+IntToStr(Eqpt_Out_Spis) + ' шт.';

    Label_Eqpt_Out_Total.Caption := 'Итого инструмента: '+IntToStr(Eqpt_Out_Total) + ' шт.';

end;

procedure TJR_EQPTRSPRForm.SearchkeyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then
    find(EqptQuery, EqptDBGridEh, Searchkey.text, 1);
end;

procedure TJR_EQPTRSPRForm.EqptDBGridEhTitleBtnClick(Sender: TObject;
  ACol: Integer; Column: TColumnEh);
begin
  sort_table(aCol);

  EqptDBGridEh.Columns[aCol].Title.SortMarker := smDownEh;
end;

{

    Процедура установки сортировки таблицы

    Вход: направление сортировки


}
procedure TJR_EQPTRSPRForm.sort_table(type_of_sort: integer);
var strord : string;
begin

   strord := 'order by ' +
     EqptDBGridEh.Columns.Items[type_of_sort].FieldName;

  with EqptQuery do

    begin

       close;
       sql.clear;
       Case TypeForm of
         1: begin
               sql.add('Select a.code, a.name, a.id, a.parentid, a.id_ediz, Sum(b.Number) as NSum');
               sql.add('From Spr_Eqpt a, St_Eqpt b ');
               sql.add('Where a.isfolder = 0 and b.ID_Eqpt = a.ID ');
               sql.add('Group By a.code, a.name, a.id, a.parentid, a.id_ediz');
               sql.add(strord);
            end;
         2: begin
              sql.add('Select a.code, a.name, a.id, Sum(b.Number) as NSum');
              sql.add('From Spr_Wrkr a, St_Eqpt b ');
              sql.add('Where b.ID_Wrkr = a.ID ');
              sql.add('Group By a.code, a.name, a.id');
              sql.add(strord);
            end;
       end;
       open;

    end;


end;


procedure TJR_EQPTRSPRForm.EQPT_RS_ButtonClick(Sender: TObject);
var IDDoc : Integer;
    Num : Integer;
begin

     IDDoc := RSEqptQuery.FieldByName('ID').AsInteger;
     Num := RSEqptQuery.FieldByName('numdoc').AsInteger;
     if ( IDDoc = Null) then exit;

     if DLLHandle = 0 then
       DLLhandle := loadLibrary('PrintForm');

       ProcAddr := GetProcAddress(DLLHandle , 'Print_Report_42');

       if ProcAddr <> nil then
       begin
         Print_Eqpt_RS_form := ProcAddr;
         // вызов функции печати из библиотеки
         Print_Eqpt_RS_form(application, application.MainForm, IDDoc, data.RMPBase);
       end;

end;

procedure TJR_EQPTRSPRForm.FormResize(Sender: TObject);
begin
  If Panel5.Width > 360 Then
    TotalLabel.Left := Panel5.Width - 130
  Else TotalLabel.Left := 234;
end;

procedure TJR_EQPTRSPRForm.refresh_buttonClick(Sender: TObject);
Var Num : Integer;
begin
  Num := EqptQuery.FieldByName('code').AsInteger;
  EqptQuery.Close;
  EqptQuery.Open;
  EqptQuery.locate('code',  Num, [loCaseInsensitive]);
end;

procedure TJR_EQPTRSPRForm.PREqptDBGridEhDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);

begin
    If PREqptQuery.FieldByName('Type_Doc').AsString ='Возврат' Then
        PREqptDBGridEh.Canvas.Font.Color := clGreen;
    If State = [gdSelected] Then //если строка выделена курсором, закрашивать белым
        PREqptDBGridEh.Canvas.Font.Color := clWhite;
    PREqptDBGridEh.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TJR_EQPTRSPRForm.RSEqptDBGridEhDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
    //выдача закрашивать зеленым
    If RSEqptQuery.FieldByName('Type_Doc').AsString ='Выдача' Then
        RSEqptDBGridEh.Canvas.Font.Color := clGreen; //clBlue;
    If State = [gdSelected] Then //если строка выделена курсором, закрашивать белым
        RSEqptDBGridEh.Canvas.Font.Color := clWhite;
    RSEqptDBGridEh.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TJR_EQPTRSPRForm.Wrkr_Card_ButtonClick(Sender: TObject);
var ID_Wrkr : Integer;
begin

     ID_Wrkr := EqptQuery.FieldByName('ID').AsInteger;
     if ( ID_Wrkr = Null) then exit;

     if DLLHandle = 0 then
       DLLhandle := loadLibrary('PrintForm');

       ProcAddr := GetProcAddress(DLLHandle , 'Print_Report_47');

       if ProcAddr <> nil then
       begin
         Print_Wrkr_Card_form := ProcAddr;
         // вызов функции печати из библиотеки
         Print_Wrkr_Card_form(application, application.MainForm, ID_Wrkr, FromDate, ToDate, data.RMPBase);    //
       end;
end;

procedure TJR_EQPTRSPRForm.FormActivate(Sender: TObject);
begin
    refresh_buttonClick(self);
end;

end.
