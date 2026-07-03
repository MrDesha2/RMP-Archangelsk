{
                           Модуль EnumPlanRelForm
       Модуль редактирования элемента справочника: сертификация рабочего

}
unit EnumWorkerSertif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, StdCtrls, CurrEdit, Mask, ToolEdit, RXDBCtrl, DBTables, EnumForm,
  ExtCtrls, Grids, DBGridEh, ComCtrls, ToolWin;

type
  TENUM_WORKERSERTFORM = class(TForm)
    qSertQuery: TQuery;
    Panel1: TPanel;
    Close_Buttom: TButton;
    OK_Buttom: TButton;
    Panel2: TPanel;
    LabelPlan: TLabel;
    Enum_label: TLabel;
    SertificateCombo: TComboEdit;
    Protokol_number: TEdit;
    Label1: TLabel;
    SERTIFICATE_DATA: TDateEdit;
    Label2: TLabel;
    Number: TEdit;
    Label3: TLabel;
    EXPARE_DATE: TDateEdit;
    GroupBox1: TGroupBox;
    Info: TMemo;
    StoredProc: TStoredProc;
    qMainQuery: TQuery;
    GroupBox2: TGroupBox;
    Access_type: TMemo;
    PanelGrid: TPanel;
    ToolBar3: TToolBar;
    ToolAddDup: TToolButton;
    ToolEditDup: TToolButton;
    ToolDelDup: TToolButton;
    Grid: TDBGridEh;
    qACCESSQuery: TQuery;
    DataSource: TDataSource;
    spr_accesstype: TComboEdit;
    qDelQuery: TQuery;
    qSelACCESSTYPEQuery: TQuery;
    qUPDATEACCESSQuery: TQuery;
    procedure OK_ButtomClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SertificateComboButtonClick(Sender: TObject);
    procedure SertificateComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolAddDupClick(Sender: TObject);
    procedure ToolEditDupClick(Sender: TObject);
    procedure ToolDelDupClick(Sender: TObject);
    procedure GridColumns1EditButtonClick(Sender: TObject;
      var Handled: Boolean);
  private

  public
    sQueryText: string;  // текст запроса заполнения
    sPlanEnum : string;  // название справочника на русском
    EnumTableName : string; // подчиненный справочник
    sSumEnumQuery : string; // запрос подчиненного справочника
    constructor createN(AOwner: TComponent; _Id, _Lineno, typeedit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_WORKERSERTFORM: TENUM_WORKERSERTFORM;
   FormType: integer; // тип редактирования формы: 1 - добавление, 2 - редактирование
         ID: integer; // Идентификатор элемента для редактирования
     Lineno: integer; // Идентификатор владельца
   qEnumQuery : tQuery;     // запрос справочника формы
       newrec : boolean;

implementation

uses CHRTEdit,
         Base,
     EQPTEdit,
         Libs,
 EnumForm4Sel;

{$R *.DFM}

//
//  Процедура при открытии формы.
//  Выполняет заполнение формы
procedure TENUM_WORKERSERTFORM.FormShow(Sender: TObject);
begin
end;
//
//  Процедура сохранения изменений в форме
//  по нажатию "ОК"
procedure TENUM_WORKERSERTFORM.OK_ButtomClick(Sender: TObject);
begin
  try
    // начало транзакции

    if  trim(SERTIFICATE_DATA.text) = '.  .' then
      begin
        MessageDlg('Дата указана не верно!', mtError, [mbOK], 0);
        exit;
      end;
    if  trim(EXPARE_DATE.text) = '.  .' then
      begin
        MessageDlg('Дата указана не верно!', mtError, [mbOK], 0);
        exit;
      end;


    StoredProc.Parambyname('ID_WRKR').asinteger := ID;
    StoredProc.Parambyname('Lineno').asinteger  := Lineno;
    StoredProc.Parambyname('PROTOCOL_NUMBER').asstring   := Protokol_number.Text;
    StoredProc.Parambyname('SERTIFICATE_DATE').AsDate    := strtodate(SERTIFICATE_DATA.text);
    StoredProc.Parambyname('NUMBER').asstring    := Number.Text;
    StoredProc.Parambyname('EXPARE_DATE').AsDate := strtodate(EXPARE_DATE.text);
    StoredProc.Parambyname('INFO').value         := Info.Lines.Text;
    StoredProc.Parambyname('ACCESS_TYPE').value  := Access_type.Lines.Text;


    // проверка
    if (SertificateCombo.ID > 0) then
      SetParamCombo(StoredProc.Parambyname('ID_SERTIFICATE'), SertificateCombo)
    else
      begin
        MessageDlg('Вид не указан...', mtError, [mbOK], 0);
        exit;
      end;

     data.RMPBase.StartTransaction;
     StoredProc.Prepare;
     StoredProc.ExecProc;

      // конец транзакции
     data.RMPBase.Commit;

     if newrec then
       ModalResult := mrOK;

     newrec := false;
  except
    MessageDlg('Не верно заполнены данные!', mtWarning, [mbOK], 0);
    Data.RMPBase.Rollback; {on failure, undo the changes};
    exit;
  raise; {raise the exception to prevent a call to CommitUpdates!}
  end;


end;

procedure TENUM_WORKERSERTFORM.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

destructor TENUM_WORKERSERTFORM.Destroy;
begin
  inherited;
//
end;

constructor TENUM_WORKERSERTFORM.createN(AOwner: TComponent; _Id, _Lineno, typeedit: integer);


begin
  inherited Create(AOwner);

  ID         := _Id;
  Lineno     := _Lineno;      // Идентификатор владельца
  FormType   := typeedit;

  if typeedit = 0 then // добавление новой записи
    begin
       // заполнение полей
       SertificateCombo.ID := -1;
       newrec := true;
    end

  else  // это редактирование элемента
    begin
       // проверка на разрешение редактирования
       OK_Buttom.Enabled := check_user_grand(uppercase('SPR_WORKERSERTIFICATE'), 'U', true);

       qMainQuery.SQL.Clear;
       qMainQuery.SQL.add('select * from SPR_WORKERSERTIFICATE where id_wrkr = ' +
          inttostr(id) + ' and lineno = ' + inttostr(lineno));
       qMainQuery.Open;

       // заполнение полей
       SertificateCombo.ID  := qMainQuery.Fieldbyname('ID_SERTIFICATE').asinteger;

       Protokol_number.Text  := qMainQuery.Fieldbyname('PROTOCOL_NUMBER').asstring;
       SERTIFICATE_DATA.Text := qMainQuery.Fieldbyname('SERTIFICATE_DATE').asstring;
       Number.Text      := qMainQuery.Fieldbyname('NUMBER').asstring;
       EXPARE_DATE.Text := qMainQuery.Fieldbyname('EXPARE_DATE').asstring;
       Info.Lines.Text  := qMainQuery.Fieldbyname('Info').value;
       newrec := false;
    end;


    qACCESSQuery.Params[0].asinteger := id;
    qACCESSQuery.Params[1].asinteger := lineno;
    qACCESSQuery.Open;

end;

procedure TENUM_WORKERSERTFORM.SertificateComboButtonClick(
  Sender: TObject);
begin
  SelectFromTable(SertificateCombo);


end;

procedure TENUM_WORKERSERTFORM.SertificateComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode( SertificateCombo, key, Shift) = false then
     SertificateComboButtonClick(Sender);


end;

procedure TENUM_WORKERSERTFORM.ToolAddDupClick(Sender: TObject);
begin
  if newrec then
    begin
      MessageDlg('Элемент не сохранен.', mtWarning, [mbOK], 0);
      exit;
    end;

  spr_accesstype.ID := -1;
  SelectFromTable(spr_accesstype);

  if spr_accesstype.ID > 0 then
    begin
       with qUPDATEACCESSQuery do
         begin
          // проверка на повтор
          sql.Clear;
          sql.Add('select id from SPR_SERTIFICATEACCESS ');
          sql.Add('where ID_ACCESSTYPE = :ID_ACCESSTYPE ');
          sql.Add(' and ID_WRKR = :ID_WRKR and WRKR_LINENO = :WRKR_LINENO');
          params[0].AsInteger := spr_accesstype.ID;
          params[1].AsInteger := ID;
          params[2].AsInteger := lineno;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;


          sql.Clear;
          sql.Add('insert into spr_sertificateaccess ');
          sql.Add('values (GEN_ID(SPR_SERTIFICATEACCESS_GEN,1), :id_wrkr, :wrkr_lineno, :lineno, :id_accesstype)');
          params[0].AsInteger := id;
          params[1].AsInteger := lineno;
          if qACCESSQuery.recordcount = 0 then
            params[2].AsInteger := 1
           else
             params[2].AsInteger := qACCESSQuery.recordcount + 1;

          params[3].AsInteger := spr_accesstype.ID;
          ExecSQL;
         end;

           qACCESSQuery.close;
           qACCESSQuery.Params[0].asinteger := ID;
           qACCESSQuery.Params[1].asinteger := lineno;
           qACCESSQuery.open;
    end;


end;

procedure TENUM_WORKERSERTFORM.ToolEditDupClick(Sender: TObject);
begin
  spr_accesstype.ID := qACCESSQuery.Fieldbyname('id_accesstype').asinteger;
  SelectFromTable(spr_accesstype);

  if spr_accesstype.ID > 0 then
    begin
       with qUPDATEACCESSQuery do
         begin
          // проверка на повтор
          sql.Clear;
          sql.Add('select * from spr_sertificateaccess ');
          sql.Add('where id_accesstype = :id_accesstype and id_wrkr = :id_wrkr and wrkr_lineno = :wrkr_lineno');
          params[0].AsInteger := spr_accesstype.ID;
          params[1].AsInteger := ID;
          params[2].AsInteger := lineno;
          open;
          if not eof then
            begin
              MessageDlg('Такое уже введено.', mtWarning, [mbOK], 0);
              exit;
            end;

          sql.Clear;
          sql.Add('update spr_sertificateaccess ');
          sql.Add('set id_accesstype = :id_accesstype');
          sql.Add('where id_wrkr = :id_wrkr and wrkr_lineno = :wrkr_lineno and lineno = :lineno');
          params[0].AsInteger := spr_accesstype.ID;
          params[1].AsInteger := id;
          params[2].AsInteger := lineno;
          params[3].AsInteger := qACCESSQuery.fieldbyname('lineno').AsInteger;

          ExecSQL;
         end;

           qACCESSQuery.close;
           qACCESSQuery.Params[0].asinteger := ID;
           qACCESSQuery.Params[1].asinteger := lineno;
           qACCESSQuery.open;
    end;

end;

procedure TENUM_WORKERSERTFORM.ToolDelDupClick(Sender: TObject);
begin
  // удаление элементов справочника возможно только в непустом справочнике
  if qACCESSQuery.eof then
     exit;

 if messagedlg('Удалить запись?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  with data.qDELQuery do
   begin
      close;
      sql.clear;
      sql.add('delete from spr_sertificateaccess where id = ' + qACCESSQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

   end;

   refreshquery( qACCESSQuery);

end;

procedure TENUM_WORKERSERTFORM.GridColumns1EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  ToolEditDupClick(self);
end;

end.
