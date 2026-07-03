unit EnumCLPDRForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CurrEdit, StdCtrls, Mask, ToolEdit, CALCEdit, Db, DBTables;

type
  TENUM_CLCPDRForm = class(TForm)
    PDRName:      TLabel;
    Label4:       TLabel;
    PDRCombo:     TComboEdit;
    Label3:       TLabel;   
    NValue:       TRxCalcEdit;
    OKButton: TButton;
    Close_Button: TButton;
    qPDRQuery: TQuery;
    qFormQuery: TQuery;
    qQuery: TQuery;
    Label1: TLabel;
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OKButtonClick(Sender: TObject);
    procedure Close_ButtonClick(Sender: TObject);
  private
    { Private declarations }
  public

    constructor createN(AOwner: TENUM_CALCForm; _id : integer; _ownerID : integer; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ParForm : TENUM_CALCForm;
  FormType : integer;
  ID : integer;
  ownerID: integer; // Идентификатор владельца
  ENUM_CLCPDRForm: TENUM_CLCPDRForm;

implementation

uses libs, Main, Base;

{$R *.DFM}

{ TENUM_CLCPDRForm }
{

     Констуктор создания формы редактирования затрат по МВЗ
     Вход: форма владелец,
           ID записи,
           тип редактирования (для добавления, для редактирования)
     Выход: пусто.


}
constructor TENUM_CLCPDRForm.createN(AOwner: TENUM_CALCForm; _id, _ownerID,
  _TypeEdit: integer);
begin
  inherited Create(AOwner);

  ParForm := aOwner;
  ID := _id;
  ownerID := _ownerID;

  // запомним в глобальных переменных формы, зачем мы сюда пришли
  FormType := _typeEdit;     // тип редактирования формы

  if _TypeEdit = 1  then

         begin

             with qFormQuery do
               begin
                  close;
                  sql.add('insert into spr_clcmvz');
                  sql.add(' values (gen_id(spr_clcmvz_gen, 1), :id_calc, :id_pdr, :nvalue)');


               end;

            PDRCombo.ID := -1;

         end

   else
      // редактирование
      begin

            // проверка на разрешение редактирования
            OKButton.Enabled := check_user_grand(uppercase('spr_clcmvz'), 'U', true);

             with qFormQuery do
               begin
                  close;
                  sql.add('update spr_clcmvz');
                  sql.add(' set id_pdr = :id_pdr, id_calc = :id_calc, nvalue = :nvalue');
                  sql.add('where id = :id');

               end;

             qQuery.close;
             qQuery.ParamByName('id').asinteger := _id;
             qQuery.open;

             NValue.Text := qQuery.fieldByName('NValue').AsString;

            // заполнение поля "МВЗ"
            PDRCombo.ID := qQuery.fieldbyname('ID_PDR').asinteger;


      end;

            // строка подраздения
            PDRName.caption := 'Затраты: ' + ParForm._Name.text;


end;

destructor TENUM_CLCPDRForm.Destroy;
begin
  inherited;

end;

{
   Процедура выбора значения из справочника "МВЗ"

}

procedure TENUM_CLCPDRForm.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PDRCombo);


end;

procedure TENUM_CLCPDRForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);


end;


{
   Сохранение измений

}
procedure TENUM_CLCPDRForm.OKButtonClick(Sender: TObject);
begin
  // заполнение параметров запроса
  if FormType = 1 then
  else
     qFormQuery.ParamByName('ID').asinteger := ID;

  if NValue.Text <> '' then
     qFormQuery.ParamByName('NValue').asfloat  := strtofloat(trim(NValue.Text))
  else
     qFormQuery.ParamByName('NValue').value  := '0';

  // проверка на полноту ввода данных
  SetParamCombo(qFormQuery.ParamByName('ID_PDR'), PDRCombo);

  qFormQuery.ParamByName('ID_CALC').asinteger    := ownerID;

  // выполнение запроса
    data.RMPBase.StartTransaction;
    qFormQuery.ExecSQL;
    data.RMPBase.Commit;

  // восстановление исходных данных
  qquery.close;
  ModalResult := mrOK;

end;

procedure TENUM_CLCPDRForm.Close_ButtonClick(Sender: TObject);
begin

  ModalResult := mrCancel;

end;

end.
