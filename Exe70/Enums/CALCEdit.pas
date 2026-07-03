{

           Модуль  CALCEdit
   Описание:
     Модуль формы редактирования элементов справочника "Затраты".
     Модуль вызывается из формы редактирования элементов справочника "Затраты"
     EnumEdit.



}
unit CALCEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolEdit, Db, DBTables, StdCtrls, Mask, CurrEdit, EnumForm, Grids,
  DBGridEh, ComCtrls, ToolWin, ExtCtrls;

type
  TENUM_CALCForm = class(TForm)
    PanelMain: TPanel;
    PageControl: TPageControl;
    TabSheetMain: TTabSheet;
    TabSheetValues: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NValue: TRxCalcEdit;
    _Name: TEdit;
    _Code: TEdit;
    PDRCombo: TComboEdit;
    is_int_calc: TCheckBox;
    qQueryUpdate: TQuery;
    qQuery: TQuery;
    qPDRQuery: TQuery;
    PanelBot: TPanel;
    OKButton: TButton;
    Close_Buttom: TButton;
    PanelTool: TPanel;
    PanelGrid: TPanel;
    ToolBar: TToolBar;
    ToolButtonAdd: TToolButton;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    PDRValueGrid: TDBGridEh;
    qTableQuery: TQuery;
    TableSource: TDataSource;
    qTableQueryNVALUE: TFloatField;
    qTableQueryNAME: TStringField;
    qTableQueryID: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ToolButtonAddClick(Sender: TObject);
    procedure ToolButtonEditClick(Sender: TObject);
    procedure ToolButtonDelClick(Sender: TObject);
    procedure PDRValueGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_CALCForm: TENUM_CALCForm;
   EditType: integer; // тип редактирования формы: 1 - добавление, 2 - редактирование
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
 sQueryText: string;  // текст запроса заполнения

implementation

uses Main,
     Base,
     libs,
EnumCLPDRForm;

{$R *.DFM}
//
//            Процедура закрытия формы
//
procedure TENUM_CALCForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 release;
end;
//
// Процедура при открытии формы
//
procedure TENUM_CALCForm.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin


  ID := -1;

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin
       _Code.Text := '';

        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_calc');
       qtmpquery.open;
       _code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);

       _Name.text := 'Новый элемент';
       Caption     := 'Справочник "Затраты". Новый элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_calc');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_Calc_GEN,1), :code, :name, :tdate, :nvalue, :id_pdr, :is_int)');
       Caption := 'Новый элемент';
       EditType := 0;

       is_int_calc.Checked := false;
    end
  else
     begin
       // проверка на разрешение редактирования
       OKButton.Enabled := check_user_grand('SPR_CALC', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_calc');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       _code.Text   := qQuery.fieldByName('Code').AsString;
       _name.text  := qQuery.fieldByName('Name').AsString;
       NValue.Text := qQuery.fieldByName('NValue').AsString;

        // заполнение поля "МВЗ"
        PDRCombo.ID := qQuery.fieldbyname('ID_PDR').asinteger;

        if qQuery.FieldByName('IS_INT').asinteger = 1 then
          is_int_calc.Checked := true
        else
          is_int_calc.Checked := false;

       Id          := qQuery.fieldByName('ID').AsInteger;

       // запрос для выполнения транзакции
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_calc');
       qQueryUpdate.SQL.add('set CODE = :code, NAME = :name, DATE_CHG = :tdate, nvalue = :nvalue,');
       qQueryUpdate.SQL.add('id_pdr = :id_pdr, is_int = :is_int');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;
       Caption := 'Справочник "Затраты". Элемент: ' + _name.text;


       // заполнение табличной формы
       with qTableQuery do
         begin
           close;
           parambyname('id').asinteger := id;
           open;

         end;
     end;

end;
//
// Процедура нажатия кнопки "ОК"
// Описание:
//   При нажатии кнопки производится транзакция в таблицу
procedure TENUM_CALCForm.OKButtonClick(Sender: TObject);

begin
  // заполнение параметров запроса
  if EditType = 0 then
  else
     qQueryUpdate.ParamByName('ID').asinteger := ID;

    if (ChechUniqueCode('spr_calc', 'code', trim(_Code.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;

  // код и наименование
  qQueryupdate.ParamByName('Code').value    := _Code.text;
  qQueryupdate.ParamByName('Name').value    := _Name.Text;
  
  if NValue.Text <> '' then
     qQueryupdate.ParamByName('NValue').asfloat  := strtofloat(trim(NValue.Text))
  else
     qQueryupdate.ParamByName('NValue').asfloat  := 0;

  // проверка на полноту ввода данных
  SetParamCombo(qQueryUpdate.ParamByName('ID_PDR'), PDRCombo);


  if is_int_calc.Checked then
      qQueryUpdate.ParamByName('IS_INT').asinteger := 1
  else
      qQueryUpdate.ParamByName('IS_INT').asinteger := 0;


  qQueryupdate.ParamByName('tdate').value   := date;

  try
    // выполнение запроса
    data.RMPBase.StartTransaction;
    qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
  except
    data.RMPBase.Rollback;
  end;

  // поиск ID вновь введенной записи
  if ID = -1 then
    begin

       ID := findIDbyCode('spr_calc', trim(_code.text));

       MainForm.ID := ID;
    end;




  // восстановление исходных данных
  qquery.close;
  ModalResult := mrOK;

end;
//
//  Процедура нажатия кнопки "Close"
//
procedure TENUM_CALCForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;


{
   Процедура выбора значения из справочника "МВЗ"

}
procedure TENUM_CALCForm.PDRComboButtonClick(Sender: TObject);
begin
//  SelectFromTable(qPDRQuery, PDRCombo, 'spr_pdr',
//                        'Справочник: МВЗ (Выбор)', 1);

end;

procedure TENUM_CALCForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);

end;
{

     Процедура добавления разреза по МВЗ

}
procedure TENUM_CALCForm.ToolButtonAddClick(Sender: TObject);

var EditForm : TENUM_CLCPDRForm;

begin

  if ID > 0 then

    begin

      EditForm := TENUM_CLCPDRForm.CreateN(self, -1, ID, 1);

      if  EditForm.showmodal = mrOK then
       refreshquery( qTableQuery);

      EditForm.Release;

    end

  else
   showmessage('Элемент не записан!');

end;


{
   Процедура редактирования затраты

}
procedure TENUM_CALCForm.ToolButtonEditClick(Sender: TObject);
var _ID : integer;
    EditForm : TENUM_CLCPDRForm;

begin
  // Если есть что редактировать
  if  qTableQuery.Eof then exit;

  // Нахождение ID элемента
  _id := qTableQuery.FieldByName('ID').asinteger;

  EditForm := TENUM_CLCPDRForm.CreateN(self, _ID, ID, 2);

  if EditForm.showmodal = mrOK then
     refreshquery( qTableQuery);

  EditForm.Release;


end;
{
    Процедура удаления затраты

}
procedure TENUM_CALCForm.ToolButtonDelClick(Sender: TObject);
begin

  with data.qDELQuery do
   begin
     close;
     sql.clear;
     sql.add('delete from spr_clcmvz where id = ' + qTableQuery.FieldByName('ID').asstring);
    data.RMPBase.StartTransaction;
     ExecSql;
    data.RMPBase.Commit;

   end;


   // обновление таблицы
   refreshquery(qTableQuery);
end;

procedure TENUM_CALCForm.PDRValueGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;

end;

end.
