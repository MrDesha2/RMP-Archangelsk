{
           Модуль  PRDocEditForm формы редактирования документа
           "Поступление инструмента".
      Модуль представляет приходный складской документ по учету инструмента
       и его проведение.

}

unit RSEQPTEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, RXDBCtrl, Mask, ToolEdit, Grids, DBGrids, ComCtrls,
  ToolWin, ExtCtrls, Db, DBTables, EnumForm,
  EnumTreeForm, DBGridEh, RxMemDS;

type

  StandardProc = procedure(ParentApplication: tApplication;
    ParentForm : tForm; iddoc : integer; data : tDataBase); StdCall;


  TDOC_RSEQPTForm = class(TForm)
    PanelBotton: TPanel;
    PanelMain: TPanel;
    Label1: TLabel;
    DateDoc: TDateEdit;
    LabelWRHS: TLabel;
    GroupBox1: TGroupBox;
    qTableQuery: TQuery;
    Close: TButton;
    OKButton: TButton;
    DocNum: TMaskEdit;
    LabelCST: TLabel;
    qWRHSQuery: TQuery;
    qCSTQuery: TQuery;
    WRHSCombo: TComboEdit;
    CSTCombo: TComboEdit;
    qFormQuery: TQuery;
    StorProcTable: TStoredProc;
    qORDERQuery: TQuery;
    PrintButton: TButton;
    Info: TRichEdit;
    AddStoredProc: TStoredProc;
    LabelWRKR: TLabel;
    RadioGroup1: TRadioGroup;
    Type_doc: TRadioButton;
    Type_doc2: TRadioButton;
    qWRKRQuery: TQuery;
    WRKRCombo: TComboEdit;
    MemoryData: TRxMemoryData;
    DataSource: TDataSource;
    EDIZCombo: TComboEdit;
    EQPTCombo: TComboEdit;
    PanelTable: TPanel;
    PanelTools: TPanel;
    ToolBar: TToolBar;
    ToolButtonAdd: TToolButton;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    ToolButtonUp: TToolButton;
    ToolButtonDown: TToolButton;
    Grid: TDBGridEh;
    qEQPTQuery: TQuery;
    qEDIZQuery: TQuery;
    LogicQuery: TQuery;
    procedure OKButtonClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WRHSComboButtonClick(Sender: TObject);
    procedure CSTComboButtonClick(Sender: TObject);
    procedure CSTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WRHSComboKeyDown(Sender: TObject; var Key: Word;
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
    procedure Type_docClick(Sender: TObject);
    procedure DBGridEh1Columns1EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure DBGridEh1Columns2EditButtonClick(Sender: TObject;
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
  DOC_RSEQPTForm: TDOC_RSEQPTForm;
  EnumEdit      : TForm;    //  формы
  IDDoc         : integer;  //  идентификатор документа
  NumDoc        : integer;  //  номер документа
  NewDoc        : boolean;  //  признак создания нового документа
  DocCaption    : string;   // заголовок окна
  WasAnyChanges : boolean;  // признак изменения формы


implementation

uses    Base,     // база
        Libs,     // библиотека дополнительных функций
EnumForm4Sel,     // форма выбора из справочников
 JRORDERForm,     // форма журнала заказов
 OrderEditLibs,
 Main, ParamForm;     // форма редактирования табличной формы


{$R *.DFM}
{
  Процедура показа изменений в форме
}
procedure  TDOC_RSEQPTForm.DocumentChange;
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
function TDOC_RSEQPTForm.SaveDoc: boolean;
var _s : string;
     i : integer;                 //

begin

  result := true;
 if not check_user_grand('DH_RS_EQPT', 'U', true) then exit;


  try



    // номер документа
    if (not NewDoc) then
      begin
       _s := trim(DocNum.EditText);
       NumDoc := StrToInt64(_s);
      end
      else    //Если номер докумнета проставлен вручную
       begin
          If Trim(DocNum.text) <> 'Новый' Then
          begin
               _s := trim(DocNum.EditText);
               NumDoc := StrToInt64(_s);
               if (ChechUniqueCode('DH_RS_EQPT', 'NUMDOC', _s, IDDoc) > 0)  then
               begin
                  result :=  false;
                  showmessage('Номер документа не уникальный!');
                  exit;
               end;
          end
       end;

    // если под этим номером уже есть документ и их ID разные
    if not NewDoc then
      if (ChechUniqueCode('DH_RS_EQPT', 'NUMDOC', _s, IDDoc) > 0)  then

        begin
          result :=  false;
          showmessage('Номер документа не уникальный!');
          exit;
        end;

    AddStoredProc.ParamByName('NUMDOC').asinteger := NumDoc;
    AddStoredProc.ParamByName('ID').asinteger  := IDDoc;

{    If Trim(DocNum.text) <> 'Новый' Then
    begin  //Если код документа введен в ручную
           LogicQuery.Close;
           LogicQuery.SQL.Clear;
           LogicQuery.SQL.Add('Select * From DH_RS_Eqpt Where numdoc = :code');
           LogicQuery.ParamByName('code').AsInteger := StrToInt64(Trim(DocNum.text));
           LogicQuery.Open;
           If not LogicQuery.Eof Then
           begin
              MessageDlg('Номер документа не уникален', mtWarning, [mbOk], 0);
              Exit;
           end;
           NumDoc := StrToInt64(Trim(DocNum.text));
    end;
    AddStoredProc.ParamByName('NUMDOC').AsFloat := NumDoc; }


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


    // получатель
    if (WRHSCombo.ID > 0)  then
      SetParamCombo(AddStoredProc.ParamByName('ID_WRHS'), WRHSCombo)
    else
      begin
        showmessage('Не проставлен склад-получатель...');
        result :=  false;
        WRHSCombo.color := clRed;

        WRHSCombo.setfocus;
        exit;
      end;

    // отправитель
    if (CSTCombo.ID > 0) and (CSTCombo.Visible) then
      SetParamCombo(AddStoredProc.ParamByName('ID_CST'), CSTCombo)
    else
      begin
        if type_doc2.Checked then
          begin
            showmessage('Не проставлен отправитель...');
            result :=  false;
            CSTCombo.color := clRed;
            CSTCombo.SetFocus;

            exit;

          end
         else
          SetParamCombo(AddStoredProc.ParamByName('ID_CST'), nil)

      end;

    // работник
    if (WRKRCombo.ID > 0) and(WRKRCombo.Visible) then
      SetParamCombo(AddStoredProc.ParamByName('ID_WRKR'), WRKRCombo)

    else
      begin

        if type_doc.Checked then
          begin
            showmessage('Не проставлен работник...');
            result :=  false;
            WRKRCombo.color := clRed;
            WRKRCombo.SetFocus;

            exit;

          end
         else
          SetParamCombo(AddStoredProc.ParamByName('ID_WRKR'), nil)


      end;


     // заполнение поля INFO
    AddStoredProc.ParamByName('INFO').value := INFO.Lines.Text;

    if Type_doc.Checked then
      AddStoredProc.ParamByName('TYPE_DOC').AsInteger := 0
      else
       AddStoredProc.ParamByName('TYPE_DOC').AsInteger := 1;

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

        StorProcTable.ParamByName('ID_RSEQPT').asinteger:= IDDoc;
        StorProcTable.ParamByName('DateDoc').asdate    := strtodate(datedoc.text);
        StorProcTable.ParamByName('LINENO').asinteger  := MemoryData.Fields[0].asinteger;
        StorProcTable.ParamByName('ID_EQPT').asinteger := MemoryData.Fields[4].asinteger;  // ID номенклатуры
        StorProcTable.ParamByName('NUMBER').asfloat    := MemoryData.Fields[3].asinteger;   // количество
        StorProcTable.ParamByName('ID_EDIZ').asinteger := MemoryData.Fields[5].asinteger;  // единица измерия
        StorProcTable.ParamByName('CELL').asinteger     := MemoryData.Fields[6].AsInteger;  // ячейка
        StorProcTable.ParamByName('ID_WRHS').asinteger := WRHSCombo.ID;    // склад
        StorProcTable.ParamByName('ID_WRKR').asinteger := WRKRCombo.ID;    // человек
        MemoryData.Next;

        if TYPE_DOC.Checked then
          StorProcTable.ParamByName('TYPE_DOC').asinteger:= 0
           else
             StorProcTable.ParamByName('TYPE_DOC').asinteger:= 1;

        StorProcTable.Prepare;
        StorProcTable.ExecProc;


        if StorProcTable.ParamByName('ERROR').asinteger = 1 then
          begin
            MessageDlg('На дату ' + DateDoc.text + ' на складе ' + WRHSCombo.Text
            + ' есть остаток ' + formatfloat('0.000', StorProcTable.paramByName('Rem_value').asfloat)
            + ' из необходимых ' + formatfloat('0.000', MemoryData.Fields[3].asfloat)
            + ' (на месте хранения №_' + MemoryData.Fields[6].AsString
            + ' есть остаток ' + formatfloat('0.000', StorProcTable.paramByName('Rem_value_cell').asfloat)+')'
            + ' инструмента ' + MemoryData.fields[1].asstring + '.'
            + #13+#10+'Документ не сохранен.', mtError, [mbOK], 0);

            result := false;
            Data.RMPBase.Rollback;
            break;


          end;


      end;


    // конец транзакции
    if result then
      data.RMPBase.Commit;


      
  except
   Data.RMPBase.Rollback; {on failure, undo the changes};
  raise; {raise the exception to prevent a call to CommitUpdates!}
  end;



end;



{
   Конструктор формы документа "Приходная накладная"
   Вход: компонент-приложения,
   IDDoc - идентификатор документа или -1 в случае создания нового документа.

}
constructor TDOC_RSEQPTForm.CreateN(AOwner: TForm; docID : integer);
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

      // Склад-получатель устанавливается по умолчанию
      WRHSCombo.ID := Param_Form.qWRHSQuery.Fields[0].asinteger;
      CSTCombo.ID  := -1;
      WRKRCombo.ID := -1;

      Type_doc.Checked := true;
      Type_doc2.Checked := false;


      DocCaption := 'Документ Списание инструмента: Новый';
      WasAnyChanges := true;
    end

  else  // для редактирования существующего документа

    begin

      NewDoc := false;
      // заполнение информации по полям
      qFormQuery.SQL.clear;
      qFormQuery.sql.add('select * from dh_rs_eqpt where id = ' + inttostr(IDDoc));
      qFormQuery.open;

      // заполнение поля "Организация"
      CSTCombo.ID := qFormQuery.fieldbyname('ID_CST').asinteger;

      // заполнение поля "Склад"
      WRHSCombo.ID := qFormQuery.fieldbyname('ID_WRHS').asinteger;

      // заполнение прочих полей
      DocNum.Text    := qFormQuery.fieldbyName('Numdoc').asstring;
      DateDoc.Text   := qformQuery.fieldbyName('Date_In').asstring;

      INFO.Lines.Add(qFormQuery.fieldbyname('INFO').asstring);

      WRKRCombo.ID   := qFormQuery.fieldbyname('ID_WRKR').asinteger;

      Type_doc.Checked := false;
      type_doc2.Checked := false;

      if qFormQuery.fieldbyname('type_doc').asinteger = 0 then
        TYPE_DOC.Checked :=true
        else
         TYPE_DOC2.Checked := true;



      DocCaption := 'Документ Списание инструмента: ' + DocNum.text + ' от ' + DateDoc.text;

      WasAnyChanges := false;

    end;
      // открываем запрос по заказам данной заявки
      qTableQuery.ParamByName('iddoc').asinteger := IDDoc;
      qTableQuery.open;

   // заполнить структуру временной таблицы
   MemoryData.LoadFromDataSet(qTableQuery,0,lmCopy);

   caption := DocCaption;
   Type_docClick(self);
   
end;

destructor TDOC_RSEQPTForm.Destroy;
begin
  inherited;
end;
{
   Процедура записи документа в базу
}
procedure TDOC_RSEQPTForm.OKButtonClick(Sender: TObject);
begin

 // при выполнении транзакции произошла ошибка
 if not SaveDoc then

   begin

  //     data.RMPBase.Rollback;
       exit;

   end;

 // далее необходимо обновить таблицу журналов заказов
 refreshquery(data.JRRSEQPTFormQuery);

 release;
end;
{
  Процедура закрытия документа
}
procedure TDOC_RSEQPTForm.CloseClick(Sender: TObject);
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
procedure TDOC_RSEQPTForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;
{
   Процедура выбора значения поля "Склад"
}
procedure TDOC_RSEQPTForm.WRHSComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  WRHSCombo.color := clWindow;

  SelectFromTable(WRHSCombo);

end;
{
    Процедура выбора значения поля "Организации"
}
procedure TDOC_RSEQPTForm.CSTComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  CSTCombo.color := clWindow;

  SelectFromTable(CSTCombo);

end;
{
    Процедура выбора значения поля "Организации"
}
procedure TDOC_RSEQPTForm.CSTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DocumentChange;

  CSTCombo.color := clWindow;

  if checkIfExistCode(CSTCombo, key, Shift) = false then
     CSTComboButtonClick(Sender);

end;
{
  Процедура выбора значения поля "Склады"

}
procedure TDOC_RSEQPTForm.WRHSComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DocumentChange;

  WRHSCombo.color := clWindow;

  if checkIfExistCode(WRHSCombo, key, Shift) = false then
     WRHSComboButtonClick(Sender);

end;


{
  Процедуры обработки таблицы

}
{
  Добавление в таблицу новой строки
}
procedure TDOC_RSEQPTForm.ToolButtonAddClick(Sender: TObject);
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
      MemoryData.fields[6].AsInteger := 0;

    end;

  MemoryData.Post;

  MemoryData.SortOnFields('lineno',false,false);

end;
{
   Редактирование
}
procedure TDOC_RSEQPTForm.ToolButtonEditClick(Sender: TObject);
begin
  if MemoryData.RecordCount = 0 then exit;
  DocumentChange;

  MemoryData.Edit;
  EQPTCombo.ID := MemoryData.fields[3].AsInteger;
  SelectFromTable(EQPTCombo);

  if EQPTCombo.ID > 0 then
    begin
      MemoryData.fields[3].AsInteger := EQPTCombo.ID;
      MemoryData.fields[1].AsString  := EQPTCombo.Text;
    end;

  MemoryData.Post;
  MemoryData.SortOnFields('lineno',false,false);

end;
{
   Удаление номенклатуры
}
procedure TDOC_RSEQPTForm.ToolButtonDelClick(Sender: TObject);
var i : integer;
begin
  if MemoryData.RecordCount = 0 then exit;
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
procedure TDOC_RSEQPTForm.ToolButtonUpClick(Sender: TObject);
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
procedure TDOC_RSEQPTForm.ToolButtonDownClick(Sender: TObject);
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
procedure TDOC_RSEQPTForm.GridTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;

end;

procedure TDOC_RSEQPTForm.DateDocChange(Sender: TObject);
begin
  DateDoc.color := clWindow;   
end;


{
   Процедура печати приходной накладной


}


procedure TDOC_RSEQPTForm.PrintButtonClick(Sender: TObject);
begin

  if iddoc < 0 then exit;


  if DLLHandle = 0 then
    DLLhandle := LoadLibrary('PrintForm');

  try

     @Print_pr_form := GetProcAddress(DLLHandle , 'Print_Report_42');

     // вызов функции печати из библиотеки
     Print_pr_form(application, self, IDDoc, data.RMPBase);

  finally
  end;


end;



{

    Процедура печати требования-накладной

}
procedure TDOC_RSEQPTForm.NeedBillButtonClick(Sender: TObject);
begin
   if iddoc < 0 then exit;

   if DLLHandle = 0 then
     DLLhandle := loadLibrary('PrintForm');

     @Print_Requirement_form := GetProcAddress(DLLHandle , 'Print_Requirement_form');

     // вызов функции печати из библиотеки
     Print_Requirement_form(application, self, IDDoc, data.RMPBase);


end;

procedure TDOC_RSEQPTForm.WRKRComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  WRKRCombo.color := clWindow;

  SelectFromTable(WRKRCombo);

end;

procedure TDOC_RSEQPTForm.WRKRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DocumentChange;

  WRKRCombo.color := clWindow;

  if checkIfExistCode(WRKRCombo, key, Shift) = false then
     WRKRComboButtonClick(Sender);


end;

procedure TDOC_RSEQPTForm.Type_docClick(Sender: TObject);
begin
   cstcombo.Visible := false;
   wrkrCombo.Visible:= false;


   if Type_doc2.Checked then
      cstcombo.Visible := true
    else
       WrkrCombo.Visible := true;

  LabelWRKR.Visible := WRKRCombo.Visible;
  LabelCST.Visible  := CSTCombo.Visible;
       

end;

procedure TDOC_RSEQPTForm.DBGridEh1Columns1EditButtonClick(Sender: TObject;
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
      begin
        MemoryData.fields[3].AsInteger := 0;
        MemoryData.fields[6].AsInteger := 0;
      end;
    end;

      idediz := getfieldname('spr_eqpt','spr_ediz','id_ediz',EQPTCombo.ID);
      MemoryData.fields[2].AsString  := idediz.Name;
      MemoryData.fields[5].AsInteger := idediz.Id;

   MemoryData.Post;


end;

procedure TDOC_RSEQPTForm.DBGridEh1Columns2EditButtonClick(Sender: TObject;
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

procedure TDOC_RSEQPTForm.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
//    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
//    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;

end;

end.

