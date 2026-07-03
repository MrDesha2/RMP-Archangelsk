{
           Модуль  RQSTEQPTEditForm формы редактирования документа
           "Поступление инструмента".
      Модуль представляет приходный складской документ по учету инструмента
       и его проведение.

}

unit RQSTEQPTEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, RXDBCtrl, Mask, ToolEdit, Grids, DBGrids, ComCtrls,
  ToolWin, ExtCtrls, Db, DBTables, EnumForm,
  EnumTreeForm, OrderEditForm, RxMemDS, DBGridEh;

type

  StandardProc = procedure(ParentApplication: tApplication;
    ParentForm : tForm; iddoc : integer; data : tDataBase); StdCall;


  TDOC_RQSTEQPTForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ToolBar1: TToolBar;
    ToolButtonAdd: TToolButton;
    Label1: TLabel;
    DateDoc: TDateEdit;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    qTableQuery: TQuery;
    Close: TButton;
    OKButton: TButton;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    ToolButtonUp: TToolButton;
    ToolButtonDown: TToolButton;
    DocNum: TMaskEdit;
    qPDRQuery: TQuery;
    PDRCombo: TComboEdit;
    qFormQuery: TQuery;
    StorProcTable: TStoredProc;
    qORDERQuery: TQuery;
    PrintButton: TButton;
    Info: TRichEdit;
    AddStoredProc: TStoredProc;
    Label4: TLabel;
    WRKRCombo: TComboEdit;
    Label5: TLabel;
    qWRKRQuery: TQuery;
    RadioGroup1: TRadioGroup;
    Type_doc: TRadioButton;
    Type_doc2: TRadioButton;
    Grid: TDBGridEh;
    MemoryData: TRxMemoryData;
    DataSource: TDataSource;
    EQPTCombo: TComboEdit;
    EDIZCombo: TComboEdit;
    qEDIZQuery: TQuery;
    qEQPTQuery: TQuery;
    LogicQuery: TQuery;
    procedure OKButtonClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure CSTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function  saveDoc : boolean;
    procedure DocumentChange;
    procedure ToolButtonAddClick(Sender: TObject);
    procedure ToolButtonEditClick(Sender: TObject);
    procedure ToolButtonDelClick(Sender: TObject);
    procedure ToolButtonUpClick(Sender: TObject);
    procedure ToolButtonDownClick(Sender: TObject);
    procedure GridTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateDocChange(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure NeedBillButtonClick(Sender: TObject);
    procedure WRKRComboButtonClick(Sender: TObject);
    procedure WRKRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridColumns1EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure GridColumns2EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure GridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private

    Print_pr_form  : StandardProc;
    Print_Requirement_form: StandardProc;

  public
    { Public declarations }
    constructor CreateN(AOwner: TForm; docID : integer);
    destructor Destroy; override;
  end;

var
  DOC_RQSTEQPTForm: TDOC_RQSTEQPTForm;
  IDDoc         : integer;  //  идентификатор документа
  NumDoc        : integer;  //  номер документа
  NewDoc        : boolean;  //  признак создания нового документа
  DocCaption    : string;   // заголовок окна
  WasAnyChanges : boolean;  // признак изменения формы


implementation

uses    Base,     // база
        Libs,     // библиотека дополнительных функций
EnumForm4Sel,     // форма выбора из справочников
 OrderEditLibs,
 Main, ParamForm;     // форма редактирования табличной формы


{$R *.DFM}
{
  Процедура показа изменений в форме
}
procedure  TDOC_RQSTEQPTForm.DocumentChange;
begin
 WasAnyChanges := true;
 caption := DocCaption + ' *';
end;

{
  Процедура записи документа.
  Вход: пусто;
  Выход: пусто;
  Описание:  выполняет транзакции по записи объекта "Документ "Приходная накладная" в базу
  данных.
}
function TDOC_RQSTEQPTForm.SaveDoc: boolean;
var _s : string;
     i : integer;                 //

begin

  result := true;
 if not check_user_grand('DH_RQST_EQPT', 'U', true) then exit;


  try



    // номер документа
    if not NewDoc then
      begin
       _s := trim(DocNum.EditText);
       NumDoc := strToInt(_s);
      end
      else    //Если номер докумнета проставлен вручную
       begin
          If Trim(DocNum.text) <> 'Новый' Then
          begin
               _s := trim(DocNum.EditText);
               NumDoc := StrToInt64(_s);
               if (ChechUniqueCode('DH_RQST_EQPT', 'NUMDOC', _s, IDDoc) > 0)  then
               begin
                  result :=  false;
                  showmessage('Номер документа не уникальный!');
                  exit;
               end;
          end
       end;

    // если под этим номером уже есть документ и их ID разные
    if not NewDoc then
      if (ChechUniqueCode('DH_RQST_EQPT', 'NUMDOC', _s, IDDoc) > 0)  then

        begin
          result :=  false;
          showmessage('Номер документа не уникальный!');
          exit;
        end;

    AddStoredProc.ParamByName('NUMDOC').asinteger := NumDoc;
    AddStoredProc.ParamByName('ID').asinteger     := IDDoc;

{    If Trim(DocNum.text) <> 'Новый' Then
    begin  //Если код документа введен в ручную
           LogicQuery.Close;
           LogicQuery.SQL.Clear;
           LogicQuery.SQL.Add('Select * From DH_RQST_Eqpt Where numdoc = :code');
           LogicQuery.ParamByName('code').AsInteger := StrToInt64(Trim(DocNum.text));
           LogicQuery.Open;
           If not LogicQuery.Eof Then
           begin
              MessageDlg('Номер документа не уникален', mtWarning, [mbOk], 0);
              Exit;
           end;
           NumDoc := StrToInt64(Trim(DocNum.text));
    end;
    AddStoredProc.ParamByName('NUMDOC').AsFloat := NumDoc;}

    // дата дока
    if trim(DateDoc.text) = '.  .'  then
      begin
        showmessage('Не указана дата документа!');
        result :=  false;
        DateDoc.color := clRed;
        exit;

      end

    else
      try
        AddStoredProc.ParamByName('DATE_IN').asdate   := strtodate(DateDoc.text);

      except
        showmessage('Дата начала указана не верно!');
        result :=  false;
        DateDoc.color := clRed;
        DateDoc.SetFocus;
        exit;
        raise;
      end;


    // работник
    if (WRKRCombo.ID > 0) then
      SetParamCombo(AddStoredProc.ParamByName('ID_WRKR'), WRKRCombo)
    else
      begin
        showmessage('Не проставлен работник...');
        result :=  false;
        WRKRCombo.color := clRed;

        WRKRCombo.setfocus;
        exit;
      end;

    // подразделение
    if (PDRCombo.ID > 0) then
      SetParamCombo(AddStoredProc.ParamByName('ID_PDR'), PDRCombo)
    else
      begin
        showmessage('Не проставлено подразделение...');
        result :=  false;
        PDRCombo.color := clRed;
        PDRCombo.SetFocus;

        exit;
      end;


    if Type_doc.Checked then
      AddStoredProc.ParamByName('TYPE_DOC').AsInteger := 0
      else
       AddStoredProc.ParamByName('TYPE_DOC').AsInteger := 1;


     // заполнение поля INFO
    AddStoredProc.ParamByName('INFO').value := INFO.Lines.Text;

    // начало транзакции
    data.RMPBase.StartTransaction;

    // выполнение запроса
    AddStoredProc.Prepare;
    AddStoredProc.ExecProc;

    if NewDoc = true then
    begin
        IDDoc  := AddStoredProc.ParamByName('IDDOC').asinteger;

        If Trim(DocNum.text) = 'Новый' Then
        begin
            NumDoc := StrToInt64(AddStoredProc.ParamByName('NewNumDoc').AsString);
            DocNum.text := AddStoredProc.ParamByName('NewNumDoc').AsString;
        end
         else
               NumDoc := StrToInt64(Trim(DocNum.text));
    end;

    // теперь табличная часть
    // перебор всех строк плановых операций документа
     MemoryData.First;

     for i := 0 to MemoryData.RecordCount - 1 do

      begin

        StorProcTable.ParamByName('ID_DOC').asinteger:= IDDoc;
        StorProcTable.ParamByName('DateDoc').asdate    := strtodate(datedoc.text);
        StorProcTable.ParamByName('LINENO').asinteger  := MemoryData.Fields[0].asinteger;
        StorProcTable.ParamByName('ID_EQPT').asinteger := MemoryData.Fields[4].AsInteger;  // ID номенклатуры
        StorProcTable.ParamByName('NUMBER').asfloat    := MemoryData.Fields[3].AsInteger;   // количество
        StorProcTable.ParamByName('ID_EDIZ').asinteger := MemoryData.Fields[5].AsInteger;  // единица измерия

        StorProcTable.Prepare;
        StorProcTable.ExecProc;

        MemoryData.Next;
      end;


    // конец транзакции
    data.RMPBase.Commit;

  except
   Data.RMPBase.Rollback; {on failure, undo the changes};
  raise; {raise the exception to prevent a call to CommitUpdates!}
  end;

 // далее необходимо обновить таблицу журналов заказов
 refreshquery(data.qJRRQSTEQPTQuery);
//  if ParentDocForm <> nil then
//  refreshquery( data.JRPFormQuery);


end;



{
   Конструктор формы документа "Приходная накладная"
   Вход: компонент-приложения,
   IDDoc - идентификатор документа или -1 в случае создания нового документа.

}
constructor TDOC_RQSTEQPTForm.CreateN(AOwner: TForm; docID : integer);
var qTMPQuery : tQuery;
begin
  inherited Create(AOwner);

  IdDoc := docID;

  // в зависимости от параметра формы: для выбора или редактирования
  // подключаются различные источник и запрос
  if IDDoc = - 1 then

    begin // для нового документа

      NumDoc      := -1;
      DocNum.text := 'Новый';

      NewDoc := true;        // флаг нового документа


      // дата документа устанавливается текущая
      dateDoc.Text := datetostr(date());
      PDRCombo.ID  := -1;
      WRKRCombo.ID := -1;

      Type_doc.Checked := true;
      Type_doc2.checked := false;


      DocCaption := 'Документ Заявка на инструмент: Новый';
      WasAnyChanges := true;
    end

  else  // для редактирования существующего документа

    begin

      NewDoc := false;
      // заполнение информации по полям
      qFormQuery.SQL.clear;
      qFormQuery.sql.add('select * from dh_rqst_eqpt where id = ' + inttostr(IDDoc));
      qFormQuery.open;

      // заполнение поля "Организация"
      PDRCombo.ID := qFormQuery.fieldbyname('ID_PDR').asinteger;

      // заполнение прочих полей
      DocNum.Text    := qFormQuery.fieldbyName('Numdoc').asstring;
      DateDoc.Text   := qformQuery.fieldbyName('Date_In').asstring;

      INFO.Lines.Add(qFormQuery.fieldbyname('INFO').asstring);

      //
      WRKRCombo.id   := qformQuery.fieldbyName('ID_WRKR').asinteger;

      type_doc.Checked := false;
      type_doc2.Checked := false;


      if qformQuery.fieldbyName('TYPE_DOC').asinteger = 0 then
        type_doc.Checked := true
         else
          type_doc2.Checked := true;

      // открываем запрос по заказам данной заявки
      qTableQuery.ParamByName('iddoc').asinteger := IDDoc;
      qTableQuery.open;
      DocCaption := 'Документ Заявка на инструмент: ' + DocNum.text + ' от ' + DateDoc.text;

      WasAnyChanges := false;

    end;

      // открываем запрос по заказам данной заявки
      qTableQuery.ParamByName('iddoc').asinteger := IDDoc;
      qTableQuery.open;
      // заполнить структуру временной таблицы
      MemoryData.LoadFromDataSet(qTableQuery,0,lmCopy);

   caption := DocCaption;

end;

destructor TDOC_RQSTEQPTForm.Destroy;
begin
  inherited;
end;
{
   Процедура записи документа в базу
}
procedure TDOC_RQSTEQPTForm.OKButtonClick(Sender: TObject);
begin

 // при выполнении транзакции произошла ошибка
 if not SaveDoc then

   begin

//       data.RMPBase.Rollback;
       exit;

   end;


 release;
end;
{
  Процедура закрытия документа
}
procedure TDOC_RQSTEQPTForm.CloseClick(Sender: TObject);
begin
 // если это был новый документ
  if WasAnyChanges = true then

    if MessageDlg('Сохранить документ?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
       begin
         SaveDoc;
       end;

  release;

end;
{
  Уничтожение формы при закрытии
}
procedure TDOC_RQSTEQPTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;
{
   Процедура выбора значения поля "Подразделение"
}
procedure TDOC_RQSTEQPTForm.PDRComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  PDRCombo.color := clWindow;

  SelectFromTable(PDRCombo);

end;
procedure TDOC_RQSTEQPTForm.CSTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;
{
  Процедура выбора значения поля "Склады"

}
procedure TDOC_RQSTEQPTForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DocumentChange;

  PDRCombo.color := clWindow;

  if checkIfExistCode(PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);

end;



{
  Процедуры обработки таблицы

}
{
  Добавление в таблицу новой строки
}
procedure TDOC_RQSTEQPTForm.ToolButtonAddClick(Sender: TObject);
var idediz : pRecord;
begin
  DocumentChange;

  MemoryData.Insert;
  MemoryData.Fields[0].AsInteger := MemoryData.RecordCount + 1;

  EQPTCombo.ID := -1;
  SelectFromTable(EQPTCombo);

  if EQPTCombo.ID > 0 then
    begin
      MemoryData.fields[4].AsInteger := EQPTCombo.ID;
      MemoryData.fields[1].AsString  := EQPTCombo.Text;
      idediz := getfieldname('spr_eqpt','spr_ediz','id_ediz',EQPTCombo.ID);
      MemoryData.fields[2].AsString  := idediz.Name;
      MemoryData.fields[3].AsInteger := 0;
      MemoryData.fields[5].AsInteger := idediz.Id;

    end;

  MemoryData.Post;

  MemoryData.SortOnFields('lineno',false,false);


end;
{
   Редактирование
}
procedure TDOC_RQSTEQPTForm.ToolButtonEditClick(Sender: TObject);
begin

  MemoryData.Edit;
  EQPTCombo.ID := MemoryData.fields[3].AsInteger;
  SelectFromTable(EQPTCombo);

  if EQPTCombo.ID > 0 then
    begin
      MemoryData.fields[3].AsInteger := EQPTCombo.ID;
      MemoryData.fields[1].AsString  := EQPTCombo.Text;
    end;

  MemoryData.Post;

end;
{
   Удаление номенклатуры
}
procedure TDOC_RQSTEQPTForm.ToolButtonDelClick(Sender: TObject);
var i : integer;
begin

  if MessageDlg('Удалить строку?', mtConfirmation, [mbOK], 0) = mrNo then exit;
  DocumentChange;

  MemoryData.Delete;
  MemoryData.First;
  i := 1;
  while not MemoryData.Eof do
    begin
       MemoryData.Edit;
       MemoryData.Fields[0].AsInteger := i;
       MemoryData.Post;
       i := i + 1;
       MemoryData.Next;
    end;



end;
{
    Процедура сдвига позиции номенклатуры вверх
}
procedure TDOC_RQSTEQPTForm.ToolButtonUpClick(Sender: TObject);
var i,j : integer;
begin

  if MemoryData.RecNo > 1 then
    begin
      i := Memorydata.Fields[0].AsInteger;
      MemoryData.Prior;
      j := MemoryData.Fields[0].AsInteger;
      MemoryData.edit;
      MemoryData.Fields[0].AsInteger := i;
      MemoryData.Post;
      memorydata.Next;
      MemoryData.edit;
      MemoryData.Fields[0].AsInteger := j;
      MemoryData.Post;
    end;
    MemoryData.SortOnFields('lineno',false,false);

end;
{
   Процедура сдвига позиции номенклатуры вниз
}
procedure TDOC_RQSTEQPTForm.ToolButtonDownClick(Sender: TObject);
var i,j : integer;
begin
  if MemoryData.RecNo < MemoryData.RecordCount then
    begin
      i := Memorydata.Fields[0].AsInteger;
      MemoryData.next;
      j := MemoryData.Fields[0].AsInteger;
      MemoryData.edit;
      MemoryData.Fields[0].AsInteger := i;
      MemoryData.Post;
      memorydata.Prior;
      MemoryData.edit;
      MemoryData.Fields[0].AsInteger := j;
      MemoryData.Post;
    end;
    MemoryData.SortOnFields('lineno',false,false);

end;
{
  Процедура при нажатии кнопки клавиатуры в таблице документа

}
procedure TDOC_RQSTEQPTForm.GridTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;

end;

procedure TDOC_RQSTEQPTForm.DateDocChange(Sender: TObject);
begin
  DateDoc.color := clWindow;   
end;


{
   Процедура печати приходной накладной


}


procedure TDOC_RQSTEQPTForm.PrintButtonClick(Sender: TObject);
begin

  if iddoc < 0 then exit;


  if DLLHandle = 0 then
    DLLhandle := LoadLibrary('PrintForm');

  try

     @Print_pr_form := GetProcAddress(DLLHandle , 'Print_pr_form');

     // вызов функции печати из библиотеки
     Print_pr_form(application, self, IDDoc, data.RMPBase);

  finally
  end;


end;



{

    Процедура печати требования-накладной

}
procedure TDOC_RQSTEQPTForm.NeedBillButtonClick(Sender: TObject);
begin
   if iddoc < 0 then exit;

   if DLLHandle = 0 then
     DLLhandle := loadLibrary('PrintForm');

     @Print_Requirement_form := GetProcAddress(DLLHandle , 'Print_Requirement_form');

     // вызов функции печати из библиотеки
     Print_Requirement_form(application, self, IDDoc, data.RMPBase);


end;

procedure TDOC_RQSTEQPTForm.WRKRComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  WRKRCombo.color := clWindow;

  SelectFromTable(WRKRCombo);


end;

procedure TDOC_RQSTEQPTForm.WRKRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DocumentChange;

  WRKRCombo.color := clWindow;

  if checkIfExistCode(WRKRCombo, key, Shift) = false then
     WRKRComboButtonClick(Sender);

end;

procedure TDOC_RQSTEQPTForm.GridColumns1EditButtonClick(Sender: TObject;
  var Handled: Boolean);
var idediz : precord;
begin
  DocumentChange;
  if MemoryData.State = dsInsert then
    begin
      MemoryData.Fields[0].AsInteger := MemoryData.RecordCount + 1;
      EQPTCombo.ID := -1;
    end
   else
     begin
       MemoryData.Edit;
       EQPTCombo.ID := MemoryData.fields[4].AsInteger;
     end;

  SelectFromTable(EQPTCombo);

  if EQPTCombo.ID > 0 then
    begin
      MemoryData.fields[4].AsInteger := EQPTCombo.ID;
      MemoryData.fields[1].AsString  := EQPTCombo.Text;
      if MemoryData.State = dsInsert then
        MemoryData.fields[3].AsInteger := 0;
    end;

      idediz := getfieldname('spr_eqpt','spr_ediz','id_ediz',EQPTCombo.ID);
      MemoryData.fields[2].AsString  := idediz.Name;
      MemoryData.fields[5].AsInteger := idediz.Id;

   MemoryData.Post;

end;

procedure TDOC_RQSTEQPTForm.GridColumns2EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  DocumentChange;
  MemoryData.Edit;
  EDIZCombo.ID := MemoryData.fields[5].AsInteger;

  SelectFromTable(EDIZCombo);

  if EDIZCombo.ID > 0 then
    begin
      MemoryData.fields[5].AsInteger := EDIZCombo.ID;
      MemoryData.fields[2].AsString  := EDIZCombo.Text;
    end;

   MemoryData.Post;


end;

procedure TDOC_RQSTEQPTForm.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
//    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;

end;

end.

