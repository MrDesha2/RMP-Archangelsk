{

     Модуль формы редактирования документа "Заявка".
     Модуль вызывается из глобальной формы, журнала заявок.
     Представляет собой объект "Документ "Заявка".

}

unit ReqEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Grids, DBGrids, ExtCtrls, Db, DBTables,
  ImgList, ComCtrls, ToolWin, RXDBCtrl, DBGridEh, Menus;

type
  TDOC_REQUESTForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Date_In: TDateEdit;
    Date_Out: TDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    OKButton: TButton;
    CloseButton: TButton;
    GroupBox: TGroupBox;
    RadioGroup: TRadioGroup;
    PR_EXEC: TRadioButton;
    PR_EXEC1: TRadioButton;
    PR_EXEC2: TRadioButton;
    qCheckStatusQuery: TQuery;
    ToolBar1: TToolBar;
    AddButton: TToolButton;
    FormTableSource: TDataSource;
    FormTableQuery: TQuery;
    EditButton: TToolButton;
    DelButton: TToolButton;
    RequestNumber: TMaskEdit;
    RQSTProc: TStoredProc;
    DELProc: TStoredProc;
    UPDATEProc: TStoredProc;
    qPDRQuery: TQuery;
    PDRSource: TDataSource;
    qCSTQuery: TQuery;
    CSTSource: TDataSource;
    PDR_Combo: TComboEdit;
    CST_Combo: TComboEdit;
    OrderGrid: TDBGridEh;
    RefreshButton: TButton;
    INFO: TRichEdit;
    MainMenu: TMainMenu;
    N1: TMenuItem;
    MenuNewOrd: TMenuItem;
    MenuEditOrd: TMenuItem;
    MenuDelOrd: TMenuItem;
    PopupMenu: TPopupMenu;
    SubNewOrd: TMenuItem;
    SubEditOrd: TMenuItem;
    SubDelOrd: TMenuItem;
    CheckStatusBut: TButton;
    procedure save_doc;
    procedure DocumentChange;
    procedure OKButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PDR_ComboButtonClick(Sender: TObject);
    procedure CST_ComboButtonClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure ValueChange(Sender: TObject);
    procedure OrderGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PDR_ComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CST_ComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RefreshButtonClick(Sender: TObject);
    procedure CheckStatusButClick(Sender: TObject);
  private
    { Private declarations }
  public
    IDDoc    : integer;  //  идентификатор документа
    NumDoc   : integer;  //  номер документа
    NewDoc   : boolean;  //  признак создания нового документа
    WasAnyChanges : boolean;       // признак, что в документе было какое-нибудь изменение
    DocCaption : string;           // заголовок окна редактирования документа
    ParSender: TForm;
    // конструктор формы документа
    constructor CreateN(AOwner: TForm; docID : integer);
    destructor Destroy; override;
  end;

var
  DOC_REQUESTForm: TDOC_REQUESTForm;
  EnumEdit : TForm;      // Форма списка справочника

  FormQuery: tQuery;     // запрос для открытия сущесвующего документа

implementation

uses     Base,
 EnumTreeForm,
     EnumForm,
    JRRQSTForm,
 OrderEditForm, EnumForm4Sel,
         Libs, Main;


{$R *.DFM}
{
  Процедура показа изменений в форме
}
procedure  TDOC_REQUESTForm.DocumentChange;
begin
 WasAnyChanges := true;
 caption := DocCaption + ' *';
end;

{
  Процедура записи документа.
  Вход: пусто;
  Выход: пусто;
  Описание:  выполняет транзакции по записи объекта "Документ "Заявка" в базу
  данных.
  При записи документа производится дополнение записи в таблицу dt_rqst.
}
procedure TDOC_REQUESTForm.save_doc;
var _s: string;
    ok : boolean;
    StorProc : tStoredProc;
begin

    ok := true;
   if not check_user_grand('DH_RQST', 'U', true) then exit;

    // Сохранение может быть нового или существующего документа
    if IDDoc = -1 then  // это новый документ

      begin
         StorProc :=  RQSTProc;

      end
    else

      begin
         StorProc :=  UPDATEProc;
         StorProc.ParamByName('IDDOC').asinteger  := IDDoc;

      end;

    // номер документа
    if not NewDoc then
      begin
       _s := trim(RequestNumber.EditText);
       NumDoc := strToInt(_s)
      end
     else
       if IDDOC = -1 then
         NUmDoc := -1
        else
          begin
            _s := trim(RequestNumber.EditText);
            NumDoc := strToInt(_s)

          end;


//    // если под этим номером уже есть документ и их ID разные
//    if (ChechUniqueCode('DH_RQST', 'NUMBER', _s, IDDoc) > 0)  then
//
//      begin
//        ok := false;
//        showmessage('Номер документа не уникальный!');
//
//      end;

//    if _s = '' then
//      begin
//       showmessage('Не указан номер документа!');
//       ok := false;
//      end
//    else

    StorProc.ParamByName('NUMBER').asinteger := NumDoc;


    // запись данных и проверка корректности
    if date_in.text = '  .  .  ' then
      begin
        showmessage('Не указана дата поступления!');
        ok := false;
      end
    else
      StorProc.ParamByName('DATE_IN').asdate   := strtodate(date_in.text);

    // проверка даты окончания
    if date_out.text = '  .  .    ' then
      begin
        showmessage('Не указана дата окончания работ!');
        ok := false;
      end
    else
      StorProc.ParamByName('DATE_OUT').asdate   := strtodate(date_out.text);



    // проверка подразделения
    if (PDR_Combo.ID = -1) then
      begin
        showmessage('Не указано подразделение!');
        ok := false;
      end
    else
      SetParamCombo(StorProc.ParamByName('id_pdr'), PDR_Combo);

    // проверка заказчика
    if (CST_Combo.ID <= 0)  then
      begin
        showmessage('Не указано заказчик!');
        ok := false;
      end
    else
      SetParamCombo(StorProc.ParamByName('id_cst'), CST_COmbo);

    if PR_EXEC.Checked = true then
      StorProc.ParamByName('pr_exec').asinteger:= 1
    else
     if PR_EXEC1.Checked = true then
      StorProc.ParamByName('pr_exec').asinteger:= 2
     else
      StorProc.ParamByName('pr_exec').asinteger:= 3;

    // заполнение поля INFO
    StorProc.ParamByName('INFO').value := INFO.Lines.Text;

    // если все правильно, то можно записать документ
    if ok = true then
      begin
        StorProc.Prepare;
        StorProc.ExecProc;

        // если это была процедура на новый документ, то
        // она возвратит ID сохраненного документа

        if IDDOC = -1 then
          begin
            IDDOC := StorProc.ParamByName('IDDOC').asinteger;
            NumDoc:= StorProc.ParamByName('NewNumDoc').asinteger;
            RequestNumber.text := inttostr(NumDoc);
            NewDoc := false;
            
          end;

       // обновление журнала документов
        if JR_RQSTForm <> nil then
          if data.JRRQSTFormQuery.Active = true then
            begin
              data.JRRQSTFormQuery.Close;
              data.JRRQSTFormQuery.ParamByName('datein').value :=  JRRQSTForm.FromDate;
              data.JRRQSTFormQuery.ParamByName('dateout').value := JRRQSTForm.ToDate;
              data.JRRQSTFormQuery.open;
            end;

      end;

   WasAnyChanges := false;
   Caption       := 'Документ Заявка: ' + RequestNumber.text + ' от ' + Date_in.text;


end;

procedure TDOC_REQUESTForm.OKButtonClick(Sender: TObject);
begin
  save_doc;

  // обновление формы журнала заявок
  if  mainForm.JR_RQSTForm_Main <> nil then

    refreshQuery(data.JRRQSTFormQuery);

  if MessageDlg('Закрыть форму?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then

     close;

end;
{
  Процедура закрытия формы документа.

}
procedure TDOC_REQUESTForm.CloseButtonClick(Sender: TObject);
begin
 // если это был новый документ
  if WasAnyChanges = true then
    if MessageDlg('Сохранить документ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
       begin
         Save_Doc;
         close;
       end;

   release;
end;

procedure TDOC_REQUESTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 // CloseButtonClick(sender);
  action := caFree;
end;

{
 Конструктор создания формы.
 Вход: владелец окна,
       документ редактирования: 1 - новый документ, 2 - существующий,
}
constructor TDOC_REQUESTForm.CreateN(AOwner: TForm; docID : integer);

begin
  inherited Create(AOwner);

  IdDoc := docID;

  // в зависимости от параметра формы: для выбора или редактирования
  // подключаются различные источник и запрос
  if IDDoc = - 1 then
    begin // для нового документа
      // формирование запроса для генератора
      NewDoc := true;        // флаг нового документа
      // дата документа устанавливается текущая
      date_in.Text := datetostr(date());
      // устанавливаются начальные значения полей
      Pr_exec.Checked := true;
      DocCaption := 'Документ Заявка: Новый';

      // найдем номер документа
      NumDoc := -1; //qtmpquery.Fields[0].asinteger + 1;
      IDDoc  := -1;
      RequestNumber.Text := 'Новый';

      // заполнение поля "Подразделение"
      PDR_Combo.ID := -1;

      // заполнение поля "Заказчик"
      CST_Combo.ID := -1;


      WasAnyChanges := true;

      // открываем запрос по заказам данной заявки
      FormTableQuery.ParamByName('id').asinteger := 0;
      FormTableQuery.open;

    end
  else  // для редактирования существующего документа
    begin
      NewDoc := false;
      // заполнение информации по полям
      FormQuery := data.DocDH_RQSTQuery;
      FormQuery.SQL.clear;
      FormQuery.sql.add('select * from dh_rqst where id = ' + inttostr(IDDoc));
      FormQuery.open;
      // заполнение поля "Подразделение"
      PDR_Combo.ID := FormQuery.fieldbyname('ID_PDR').asinteger;

      // заполнение поля "Заказчик"
      CST_Combo.ID := FormQuery.fieldbyname('ID_CST').asinteger;

      // заполнение прочих полей
      RequestNumber.Text := FormQuery.fieldbyName('Number').asstring;
      Date_In.Text       := formQuery.fieldbyName('Date_In').asstring;
      Date_Out.Text      := formQuery.fieldbyName('Date_Out').asstring;

      INFO.Lines.Add(formQuery.fieldbyname('INFO').asstring);

      case formQuery.fieldbyName('PR_EXEC').asinteger of
        1: PR_EXEC.Checked  := true;
        2: PR_EXEC1.Checked := true;
        3: PR_EXEC2.Checked := true;
      end;
      // открываем запрос по заказам данной заявки
      FormTableQuery.ParamByName('id').asinteger := IDDoc;
      FormTableQuery.open;
      WasAnyChanges := false;
      DocCaption := 'Документ Заявка: ' + RequestNumber.text + ' от ' + Date_in.text;

    end;

    caption := DocCaption;

end;

destructor TDOC_REQUESTForm.Destroy;
begin
//  if Assigned(MainForm.Form3) then MainFrm.Form3.Free;
  inherited;
end;
{
  Процедура выбора из справочника "Подразделения"
}
procedure TDOC_REQUESTForm.PDR_ComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PDR_Combo);
end;
{
  Процедура выбора из справочника "Организации"
}
procedure TDOC_REQUESTForm.CST_ComboButtonClick(Sender: TObject);
begin
  SelectFromTable(CST_Combo);
end;
{
  Процедура добавления документа "Заказ"
}
procedure TDOC_REQUESTForm.AddButtonClick(Sender: TObject);
var DocForm :TForm;
begin

  if IDDoc = -1 then
    begin

      showmessage('Документ не сохранен!');
      exit;

    end;

     // проверка на возможность редактирования
     if not check_user_grand('DH_ORDER', 'I', true) then
       exit;

  // открыть форму редактирования нового документа
  // проверка на заполнение формы
  if RequestNUmber.text = '' then
    begin
      MessageDlg('Не указан номер заявки!', mtError, [mbOK], 0);
      exit;
    end;

  DocForm := TDOC_ORDERForm.CreateN(self, - 1, IDDoc, strtoint(trim(RequestNUmber.text)), self);
  DocForm.show;

end;
{
   Процедура открытия формы редактирования существующего документа
}
procedure TDOC_REQUESTForm.EditButtonClick(Sender: TObject);
var DocForm : TForm;
    IDOrder : integer;
begin
  // открыть форму редактирования нового документа
  if FormTableQuery.Eof then exit;

    IDOrder := FormTableQuery.FieldByName('ID').asinteger;
    DocForm := TDOC_ORDERForm.CreateN(self, IdOrder, IDDoc, strtoint(trim(RequestNUmber.text)), self);
    DocForm.show;

end;
{
  Процедура удаления заказа
}
procedure TDOC_REQUESTForm.DelButtonClick(Sender: TObject);
var number: string;
    date  : string;
    id_ord : integer;
begin
  if  FormTableQuery.Eof then exit;

     // проверка на возможность редактирования
     if not check_user_grand('DH_ORDER', 'D', true) then
       exit;

    Number := FormTableQuery.FieldByName('Number').AsString;
    date   := FormTableQuery.FieldByName('Date_in').AsString;
  if messagedlg('Удалить заказ  ' + Number + ' от ' + date + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin

    id_ord  := FormTableQuery.FieldByName('ID').AsInteger;

    with data.qDELQuery do
      begin
        close;
        sql.clear;
        sql.add('delete from dh_order where id = ' + inttostr(id_ord));
        data.RMPBase.StartTransaction;
         execSQL;
        data.RMPBase.Commit;
      end;

   end;
   FormTableQuery.close;
   FormTableQuery.open;
  {}
end;

procedure TDOC_REQUESTForm.ValueChange(Sender: TObject);
begin
  DocumentChange;
end;

procedure TDOC_REQUESTForm.OrderGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    45 : AddButtonClick(sender);  // нажата кнопка "Ins"
    46 : DelButtonClick(sender);  // нажата кнопка "Del"
    12 : EditButtonClick(sender); // нажата кнопка "Ret"
    VK_F5 : refreshquery( FormTableQuery); // обновление таблицы

  end;
end;
{
  При редактировании поля "Подразделение" нажали кнопку клавы
}
procedure TDOC_REQUESTForm.PDR_ComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PDR_Combo, key, Shift) = false then
     PDR_ComboButtonClick(Sender);
  DocumentChange;
end;
{
  При нажатии кнопки на поле "Организации"
}
procedure TDOC_REQUESTForm.CST_ComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CST_Combo, key, Shift) = false then
    CST_ComboButtonClick(Sender);
  DocumentChange;
end;
{

  Процедура    RefreshButtonClick
  Обновление табличной части документа

}
procedure TDOC_REQUESTForm.RefreshButtonClick(Sender: TObject);
begin
  // Установка параметра запроса
  FormTableQuery.ParamByName('id').asinteger := IDDoc;
  
  refreshQuery(FormTableQuery);
end;
{-----------------------------------------------------------------------------
  Процедура: TDOC_REQUESTForm.CheckStatusButClick
  Дата:      28-апр-2004
  Аргументы: Sender: TObject
  Возврат:   None
  Описание:  Проверка статуса заявки. Если все заказы
             выполнены, то заявка закрывается.
-----------------------------------------------------------------------------}

procedure TDOC_REQUESTForm.CheckStatusButClick(Sender: TObject);
var is_ready_count,
    is_inwork,
    k : integer;
begin
  with qCheckStatusQuery do
    begin
      close;
      params[0].AsInteger := iddoc;
      open;
      first;
    end;

  is_ready_count := 0;
  is_inwork := 0;
  k := 0;
  while not qCheckStatusQuery.eof do
    begin
      k := k + 1;

      if qCheckStatusQuery.fields[0].asinteger = 3 then
        is_ready_count := is_ready_count + 1;
      if qCheckStatusQuery.fields[0].asinteger = 2 then
        is_inwork := is_inwork + 1;

      qCheckStatusQuery.next;
    end;

   if (k = is_ready_count) and (k > 0) then
     begin
       MessageDlg('Все заказы заявки выполнены', mtWarning, [mbOK], 0);
       PR_EXEC.Checked := false;
       PR_EXEC1.Checked := false;
       PR_EXEC2.Checked := true;
     end;

    if (is_ready_count + is_inwork = 0) then
     begin
       MessageDlg('Заявка не запущена в производство', mtWarning, [mbOK], 0);
       PR_EXEC.Checked := true;
       PR_EXEC1.Checked := false;
       PR_EXEC2.Checked := false;
     end;

   if ((is_inwork > 0) or (is_ready_count > 0)) and (is_ready_count < k)then
     begin
       MessageDlg('Заявка в производстве', mtWarning, [mbOK], 0);
       PR_EXEC.Checked := false;
       PR_EXEC1.Checked := true;
       PR_EXEC2.Checked := false;
     end;



end;

end.
