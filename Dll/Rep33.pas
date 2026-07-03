unit Rep33;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ToolEdit, Db, DBTables, Mask, EnumForm4Sel;

type
  TReport33Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    Label3: TLabel;
    EndDateEdit: TDateEdit;
    qMainQuery: TQuery;
    qWRHSQuery: TQuery;
    qNMNTQuery: TQuery;
    NMNTCombo: TComboEdit;
    Label5: TLabel;
    Label4: TLabel;
    WRHSCombo: TComboEdit;
    RadioGroup: TRadioGroup;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ButtonDo: TButton;
    ButtonCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WRHSComboButtonClick(Sender: TObject);
    procedure WRHSComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonDoClick(Sender: TObject);
  private
    { Private declarations }
  public
     _Owner   : tComponent;
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report33Form: TReport33Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces;

{$R *.DFM}

procedure TReport33Form.FormCreate(Sender: TObject);
begin
  RadioButton1.Checked := true;

  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport33Form.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qNMNTQuery, NMNTCombo, 'select id, code, name from spr_nmnt',
                        'Справочник: Номенклатура (Выбор)', 0);
end;

procedure TReport33Form.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qNMNTQuery, NMNTCombo, key, Shift, 1) = false then
    NMNTComboButtonClick(Sender);
end;

procedure TReport33Form.WRHSComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qWRHSQuery, WRHSCombo, 'select id, code, name from spr_wrhs',
                        'Справочник: Места хранения (Выбор)', 0);
end;

procedure TReport33Form.WRHSComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qWRHSQuery, WRHSCombo, key, Shift, 0) = false then
     WRHSComboButtonClick(Sender);
end;

procedure TReport33Form.ButtonCancelClick(Sender: TObject);
begin
        Close;
end;

procedure TReport33Form.ButtonDoClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(_Owner);
       PrForm  := TProcessForm.create(_Owner);

       If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

{       i:=1;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;
          add( CentrLine('Карточка складского учета по литейному цеху', 150));
          add( CentrLine('с '+BegDateEdit.Text+ ' по '+EndDateEdit.Text, 150));
          add( RepeatLine('-', 150));
          add( '|                    |                |       | Вес 1 шт. |            Приход             |                 Расход                  |   Остатка    |Номенклатур|
          add( '|    Наименование    |   № Чертежа    | Марка |   (кг.)   |-------------------------------|-----------------------------------------|--------------|    ный    |
          add( '|                    |                |       |           |к/шт|вес (кг.)| № док |  Дата  |к/шт|вес (кг.)| № док |  Дата  | Фамилия |к/шт|вес (кг.)|   номер   |
          add( RepeatLine('-', 150));    }

end;

end.
