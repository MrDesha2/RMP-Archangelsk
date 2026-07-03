{
          Модуль  CHAINEdit
        Писал Влад  

}
unit CHAINEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, DBGrids, ComCtrls, ToolWin, ImgList, StdCtrls, Buttons,
  RXCtrls, Db, DBTables, DBCtrls, Mask, ToolEdit;

type
  TENUM_CHAINForm = class(TForm)
    OK_Button: TButton;
    Close_Button: TButton;
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    Label3: TLabel;
    VCHRCombo: TComboEdit;
    Label1: TLabel;
    EqptCombo: TComboEdit;
    qVCHRQuery: TQuery;
    qEQPTQuery: TQuery;
    LabelEQPT: TLabel;
    procedure Close_ButtomClick(Sender: TObject);
    procedure VCHRComboButtonClick(Sender: TObject);
    procedure VCHRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EqptComboButtonClick(Sender: TObject);
    procedure EqptComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Close_ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OK_ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _OwnerID, _ID: integer; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_CHAINForm: TENUM_CHAINForm;
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
   FormType: integer; // Тип формы при открытии 2 - для редактирования, 1 - для добавления;
 sQueryText: string;  // текст запроса заполнения

implementation

uses libs, Base;

{$R *.DFM}

//
//  Генератор создания формы редактирования элемента справочника "Ремонт оборудования"
//
constructor TENUM_CHAINForm.createN(AOwner: TComponent;  _OwnerID, _ID: integer; _TypeEdit: integer);
begin
  inherited Create(AOwner);;


  ID      := _Id;           // Номер строки отказа
  OwnerID := _ownerID;      // Идентификатор владельца

  // если это добавление элемента
  FormType := _typeEdit;

  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into spr_chain ' +
        ' values ( :id_eqpt, :id_vid, :nextideq,GEN_ID(SPR_CHAIN_GEN, 1)) ';

       VCHRCombo.ID := -1;
       EQPTCombo.ID := -1;

    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin
       // проверка на разрешение редактирования
       Ok_Button.Enabled := check_user_grand(uppercase('spr_fail'), 'U', true);

       sQueryText := 'update spr_chain ' +
        ' set nextideq = :nextideq, id_vid = :id_vid, id_eqpt = :id_eqpt ' +
        ' where id = :id';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from spr_chain');
       qQuery.sql.add('where id = :id');
       qQuery.ParamByName('id').asinteger := _Id;
       qQuery.open;


       // заполнение поля "Характеристика"
       VCHRCombo.ID := qQuery.fieldByName('ID_VID').AsInteger;

       // заполнение поля "Оборудование"
       EQPTCombo.ID := qQuery.fieldByName('Nextideq').AsInteger;

    end;


end;
//
//     Деструктор формы
//
destructor TENUM_CHAINForm.Destroy;
begin
  inherited;
end;


procedure TENUM_CHAINForm.Close_ButtomClick(Sender: TObject);
begin
  close;
end;

procedure TENUM_CHAINForm.VCHRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(VCHRCombo);

end;

procedure TENUM_CHAINForm.VCHRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( VCHRCombo, key, Shift) = false then
     VCHRComboButtonClick(Sender);

end;

procedure TENUM_CHAINForm.EqptComboButtonClick(Sender: TObject);
begin
  SelectFromTable(EQPTCombo);


end;

procedure TENUM_CHAINForm.EqptComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( EQPTCombo, key, Shift) = false then
     EqptComboButtonClick(Sender);

end;

procedure TENUM_CHAINForm.Close_ButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TENUM_CHAINForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TENUM_CHAINForm.OK_ButtonClick(Sender: TObject);
begin
    qQuery.Close;
    with qQuery do
     begin
       sql.Clear;
       sql.Add('select nextideq from spr_chain');
       sql.Add('where id_eqpt = :id_eqpt and id_vid = :id_vid');
       sql.add('and nextideq = :nextideq and id <> :id');
       params[0].asinteger := OwnerID;
       SetParamCombo(params[1], VCHRCombo);
       SetParamCombo(params[2], EQPTCombo);
       params[3].asinteger := id;
       open;
       if not eof then
        begin
          MessageDlg('Такая запись уже введена.', mtWarning, [mbOK], 0);
          exit;
        end;
     end;

    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

    qQueryUpdate.ParamByName('ID_EQPT').asinteger  := OwnerID;
    SetParamCombo(qQueryUpdate.ParamByName('id_vid'), VCHRCombo);
    SetParamCombo(qQueryUpdate.ParamByName('nextideq'), EQPTCombo);

    if  FormType = 2 then
      qQueryUpdate.ParamByName('id').asinteger:= id;


   try
     data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
     data.RMPBase.Commit;
   except
     data.RMPBase.Rollback;
   end;

    ModalResult := mrOK;

end;

end.
