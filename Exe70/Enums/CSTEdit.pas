{
                   Модель CSTEdit
  Описание.
    Модуль формы редактирования элемента справочника "Организации".
  Форма вызывается из формы редактирования списка организаций.  


}
unit CSTEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ComCtrls, ExtCtrls, Grids, DBGrids, ToolWin,
  ImgList, Mask, DBCtrls, DBGridEh, ToolEdit;

type
  TENUM_CSTForm = class(TForm)
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    PanelButton: TPanel;
    OKButton: TButton;
    Close_Buttom: TButton;
    Panel2: TPanel;
    PageControl: TPageControl;
    TabSheetMain: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Code: TEdit;
    _Name: TEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    qQuotaQuery: TQuery;
    SprQuotaSource: TDataSource;
    ToolBar: TToolBar;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    ButtonFill: TButton;
    RadioGroupType: TRadioGroup;
    IS_INT2: TRadioButton;
    IS_INT1: TRadioButton;
    IS_INT: TRadioButton;
    CHRCGrid: TDBGridEh;
    Label5: TLabel;
    ID_Stat: TComboEdit;
    qStatQuery: TQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OK_ButtomClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure ToolButtonEditClick(Sender: TObject);
    procedure ToolButtonDelClick(Sender: TObject);
    procedure ButtonFillClick(Sender: TObject);
    procedure CHRCGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ID_StatButtonClick(Sender: TObject);
    procedure ID_StatKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_CSTForm: TENUM_CSTForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;
implementation
  uses base,
       libs,
       Main,
       EnumQuotaEdit;

{$R *.DFM}

procedure TENUM_CSTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TENUM_CSTForm.FormShow(Sender: TObject);
begin
 {}

  ParentID := MainForm.ParentID;
  id       := -1;
  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin

      code.text  := '';

       _Name.text := 'Новый элемент';
       Caption    := 'Справочник "Организации". Новый элемент';
       // формирование рабочего запроса для выполнения транзакции в справочнике
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_cst');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_CST_GEN,1), :parentID, 0, :code, :name, :isInstr, :ID_Stat)');
       is_int.Checked := false;
       is_int1.Checked := true;
       is_int2.Checked := false;

       // заполнение поля "Статистика"
       ID_Stat.ID    := -1;

       EditType := 0;
    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin
       Code.Text   := '';
       _Name.text  := 'Новая группа';
       Caption     := 'Справочник "Организации". Новая группа';
       // формирование рабочего запроса для выполнения транзакции в справочнике
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_cst');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_CST_GEN,1), :parentID, 1, :code, :name, :isInstr, :id_Stat)');
       is_int.Checked := false;
       is_int1.Checked := true;
       is_int2.Checked := false;

       // заполнение поля "Статистика"
       ID_Stat.ID := -1;

       EditType := 0;
     end
   else {редактирование элемента}
    if mainForm.isFolder = 3 then
     begin
       // проверка на разрешение редактирования
       OKButton.Enabled := check_user_grand('SPR_CST', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_cst');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       code.Text   := qQuery.fieldByName('Code').AsString;
       _name.text  := qQuery.fieldByName('Name').AsString;
       ParentID    := qQuery.fieldByName('ParentID').AsInteger;
       Id          := qQuery.fieldByName('ID').AsInteger;

       is_int.Checked := false;
       is_int1.Checked := false;
       is_int2.Checked := false;

       case  qQuery.fieldByName('Is_Instr').AsInteger of
         1: Is_int.Checked := true;
         0: Is_int1.Checked := true;
         2: Is_int2.Checked := true;
       end;


       // формирование рабочего запроса для выполнения транзакции в справочнике
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_cst');
       qQueryUpdate.SQL.add('set CODE = :code, NAME = :name, IS_Instr = :isInstr, id_Stat = :id_Stat');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;

       qQuotaQuery.ParamByName('id').asinteger := id;
       qQuotaQuery.open;

       // заполнение поля "Статистика"
       ID_Stat.ID := qQuery.fieldByName('ID_Stat').AsInteger;
       Caption := 'Справочник "Организации". Элемент: ' + _name.text;
     end;

end;

procedure TENUM_CSTForm.OK_ButtomClick(Sender: TObject);
begin
 {}
  if EditType = 0 then

      qQueryupdate.ParamByName('ParentID').asinteger := ParentID

  else

      qQueryUpdate.ParamByName('ID').asinteger   := ID;

    if (ChechUniqueCode('spr_cst', 'code', trim(Code.text),ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;



      // Признак заказчика
      if is_int.Checked then      // внутреннее подразделение
        qQueryupdate.ParamByName('IsInstr').value    := '1';

      if is_int1.Checked then     // внешняя организация
         qQueryupdate.ParamByName('IsInstr').value    := '0';

      if is_int2.Checked then     // конкретный заказ
         qQueryupdate.ParamByName('IsInstr').value    := '2';


  qQueryupdate.ParamByName('Code').value    := Code.text;
  qQueryupdate.ParamByName('Name').value    := _Name.Text;
  // статья статистики
  SetParamCombo(qQueryupdate.ParamByName('ID_Stat'), ID_Stat);


   try
    data.RMPBase.StartTransaction;
    qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  // поиск ID вновь введенной записи
  if ID = -1 then
    begin

       ID := findIDbyCode('spr_cst', trim(code.text));
       MainForm.ID := ID;

    end;

  // обновление формы
  ModalResult := mrOK;
end;

procedure TENUM_CSTForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;
{
  Процедура редактирования квоты
}
procedure TENUM_CSTForm.ToolButtonEditClick(Sender: TObject);
var Form    : TENUM_QUOTACST;
    id_tpeq : integer;
begin
  id_tpeq := qQuotaQuery.fieldByName('id_tpeq').asinteger;
  Form := TENUM_QUOTACST.createN(self, ID, 2, id_tpeq);

  if Form.ShowModal = mrOK then
    begin
      qQuotaQuery.close;
      qQuotaQuery.open;
      form.Close;
    end;
end;
{
  Процедура удаления квоты
}

procedure TENUM_CSTForm.ToolButtonDelClick(Sender: TObject);
var
    id_tpeq : integer;
begin

  // Вопрос пользователю
  if messagedlg('Удалить запись? Возможно нарушение функций планирования!!!', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    exit;

  id_tpeq := qQuotaQuery.fieldByName('id_tpeq').asinteger;

  with data.qDELQuery do
    begin

     close;
     sql.clear;
     sql.add('delete from quotacst where id_cst = ' + inttostr(id));
     sql.add('and id_tpeq = ' + inttostr(id_tpeq));
    data.RMPBase.StartTransaction;
     ExecSQL;
    data.RMPBase.Commit;


    end;

  // обновление запроса по квотам
  qQuotaQuery.close;
  qQuotaQuery.open;

end;
{
   Процедура формирования списка квот на станочные группы для организации

}
procedure TENUM_CSTForm.ButtonFillClick(Sender: TObject);
var qTMPQuery : tQuery;
    qTMPSUMQuery : tQuery;
    qAddQuery : tQuery;
begin
  if id < 0 then
    begin
      showmessage('Элемент не записан...');
      exit;
    end;

 // формирование временного запроса
 qTMPQuery := tQuery.Create(self);
 qTMPQuery.DatabaseName := data.RMPBase.DatabaseName;
 qTMPQuery.SQL.clear;

 qTMPSUMQuery := tQuery.Create(self);
 qTMPSUMQuery.DatabaseName := data.RMPBase.DatabaseName;
 qTMPSUMQuery.SQL.clear;

 qAddQuery := tQuery.Create(self);
 qAddQuery.DatabaseName := data.RMPBase.DatabaseName;

 if messagedlg('Заполнить квоты на основании справочника? Перед заполнением таблица будет очищена.', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
     // удаление всех квот в таблице
     qTMPQuery.sql.Add('delete from quotacst where id_cst = ' + inttostr(ID));
     data.RMPBase.StartTransaction;
     qTMPQuery.ExecSQL;
     data.RMPBase.Commit;

     // выбор групп оборудования из справочника типо оборудования
     qTMPQuery.sql.clear;
     qTMPQuery.sql.add('select id');
     qTMPQuery.sql.add('from spr_tpeq');
     qTMPQuery.sql.add('where isfolder = 1');
     qTMPQuery.open;

     // выбор суммы квот починённых производств из справочника типов оборудования
     qTMPSUMQuery.sql.clear;
     qTMPSUMQuery.sql.add('Select Sum(a.nsize) as nsize');
     qTMPSUMQuery.sql.add('From QuotaCst a');
     qTMPSUMQuery.sql.add('Where a.id_tpeq = :id_tpeq and');
     qTMPSUMQuery.sql.add('a.id_cst in (Select b.id From Spr_Cst b Where b.parentid = :id_cst)');

     qAddQuery.sql.add('insert into quotaCst values(:id_cst, :nsize, :id_tpeq)');

     // заполнение таблицы квот
     while not qTMPQuery.eof do
       begin
         qAddQuery.ParamByName('id_cst').asinteger := id;

         qTMPSUMQuery.close;
         qTMPSUMQuery.ParamByName('id_tpeq').AsInteger := qTMPQuery.fieldbyname('id').asinteger;
         qTMPSUMQuery.ParamByName('id_cst').AsInteger  := id;
         qTMPSUMQuery.open;

         qAddQuery.ParamByName('nsize').asinteger  := qTMPSUMQuery.fieldbyname('nsize').asinteger; //0;
         qAddQuery.ParamByName('id_tpeq').asinteger:= qTMPQuery.fieldbyname('id').asinteger;
         data.RMPBase.StartTransaction;
         qAddQuery.ExecSQL;
         data.RMPBase.Commit;
         qTMPQuery.next;
       end;

     // обновление запроса
     qQuotaQuery.close;
     qQuotaQuery.open;


   end;

end;
{
     При работе с таблицей нажали кнопку.

}
procedure TENUM_CSTForm.CHRCGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;

end;

procedure TENUM_CSTForm.ID_StatButtonClick(Sender: TObject);
begin
  SelectFromTable(ID_Stat);


end;

procedure TENUM_CSTForm.ID_StatKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode( ID_Stat, key, Shift) = false then
    ID_StatButtonClick(Sender);


end;

end.
