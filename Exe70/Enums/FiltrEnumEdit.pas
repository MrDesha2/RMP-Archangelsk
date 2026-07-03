unit FiltrEnumEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, DBTables, Mask, ToolEdit;

type
  TFiltrEnumForm = class(TForm)
    Panel1: TPanel;
    OkButton: TButton;
    CancelButton: TButton;
    CloseButton: TButton;
    ChrtPanel: TPanel;
    NmntChrtCombo: TComboEdit;
    Label1: TLabel;
    qNMNTChrtQuery: TQuery;
    OperCheckBox: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    ChrtChrtCombo: TComboEdit;
    OperChrtCombo: TComboEdit;
    qOperChrtQuery: TQuery;
    qChrtChrtQuery: TQuery;
    procedure NmntChrtComboButtonClick(Sender: TObject);
    procedure NmntChrtComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OkButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    Procedure OnOpenForm;
    procedure ChrtChrtComboButtonClick(Sender: TObject);
    procedure ChrtChrtComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OperChrtComboButtonClick(Sender: TObject);
    procedure OperChrtComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
  public
    id_enum_chrt: integer;  //чертёж
    id_enum_oper: integer;  //операция
    id_enum_nmnt: integer;  //номенклатура
    enumopernorm : integer; //наличие не нормированных операций в справочнике
  end;

var
  FiltrEnumForm: TFiltrEnumForm;

implementation

uses libs,
     GetPeriods;


{$R *.dfm}

procedure TFiltrEnumForm.NmntChrtComboButtonClick(Sender: TObject);
begin
  id_enum_nmnt := SelectFromTable(NMNTChrtCombo);

end;

procedure TFiltrEnumForm.NmntChrtComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if checkIfExistCode(NMNTChrtCombo, key, Shift) = false then
     NMNTChrtComboButtonClick(Sender);

  id_enum_nmnt := qNMNTChrtQuery.Fields[0].asinteger;

end;

procedure TFiltrEnumForm.FormCreate(Sender: TObject);
begin
    id_enum_chrt := -1;
    id_enum_oper := -1;
    id_enum_nmnt := -1;
    enumopernorm := 0;

end;

procedure TFiltrEnumForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TFiltrEnumForm.OkButtonClick(Sender: TObject);
begin
   ModalResult := mrOK;
end;

procedure TFiltrEnumForm.CancelButtonClick(Sender: TObject);
begin
    // очистить фильтр
    qChrtChrtQuery.close;
    ChrtChrtCombo.Text := '';
    qOperChrtQuery.close;
    OperChrtCombo.Text := '';
    qNmntChrtQuery.close;
    NmntChrtCombo.Text := '';

    ModalResult := mrCancel;
end;

procedure TFiltrEnumForm.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrIgnore;
end;

{
   Процедура при открытии формы фильтра
   При открытии заполняются значения отбора, если они установлены

}
Procedure TFiltrEnumForm.OnOpenForm;
begin
  // заполнение запроса
  // если есть отбор по чертежу
  ChrtChrtCombo.ID := id_enum_chrt;
  // если есть отбор по операциям
  OperChrtCombo.ID := id_enum_oper;
  // если есть отбор по номенклатуре
  NMNTChrtCombo.ID := id_enum_nmnt;
end;


procedure TFiltrEnumForm.ChrtChrtComboButtonClick(Sender: TObject);
begin
  id_enum_chrt := SelectFromTable(ChrtChrtCombo);

end;

procedure TFiltrEnumForm.ChrtChrtComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if checkIfExistCode(ChrtChrtCombo, key, Shift) = false then
     ChrtChrtComboButtonClick(Sender);

  id_enum_chrt := qChrtChrtQuery.Fields[0].asinteger;

end;

procedure TFiltrEnumForm.OperChrtComboButtonClick(Sender: TObject);
begin
  id_enum_oper := SelectFromTable(OperChrtCombo);

end;

procedure TFiltrEnumForm.OperChrtComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if checkIfExistCode(OperChrtCombo, key, Shift) = false then
     OperChrtComboButtonClick(Sender);

  id_enum_oper := qOperChrtQuery.Fields[0].asinteger;

end;

end.
