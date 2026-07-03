{
           Модуль  PRDocEditForm формы редактирования документа
           "Поступление моделей".
      Модуль представляет приходный складской документ по учету инструмента
       и его проведение.

}

unit PRMODELEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, RXDBCtrl, Mask, ToolEdit, Grids, DBGrids, ComCtrls,
  ToolWin, ExtCtrls, Db, DBTables, EnumForm,
  EnumTreeForm, JRPRModelDocForm, OrderEditForm, RxMemDS, DBGridEh,
  MemTable;

type

  StandardProc = procedure(ParentApplication: tApplication;
    ParentForm : tForm; iddoc : integer; data : tDataBase); StdCall;




  TDOC_PRMODELForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ToolBar1: TToolBar;
    ToolButtonAdd: TToolButton;
    Label1: TLabel;
    DateDoc: TDateEdit;
    LabelWRHS: TLabel;
    GroupBox1: TGroupBox;
    qTableQuery: TQuery;
    Close: TButton;
    OKButton: TButton;
    ToolButtonEdit: TToolButton;
    ToolButtonDel: TToolButton;
    ToolButtonUp: TToolButton;
    ToolButtonDown: TToolButton;
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
    LabelWRKR: TLabel;
    qWRHS2Query: TQuery;
    RadioGroup1: TRadioGroup;
    Type_doc: TRadioButton;
    Type_doc2: TRadioButton;
    WRHS2Combo: TComboEdit;
    AddStoredProc: TStoredProc;
    Grid: TDBGridEh;
    MemoryData: TRxMemoryData;    // таблица для хранения табличной части
    DataSource: TDataSource;
    ModelCombo: TComboEdit;
    qMODELQuery: TQuery;
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
    procedure WRHS2ComboButtonClick(Sender: TObject);
    procedure WRHS2ComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Type_docClick(Sender: TObject);
    procedure GridColumns1EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure  SortTable;
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
  DOC_PRMODELForm: TDOC_PRMODELForm;
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
 MainFormLib,
 Main, ParamForm;     // форма редактирования табличной формы


{$R *.DFM}
{
  Процедура показа изменений в форме
}
procedure  TDOC_PRMODELForm.DocumentChange;
begin
 WasAnyChanges := true;
 caption := DocCaption + ' *';
end;

{
  Процедура записи документа.
  Вход: пусто;
  Выход: пусто;
  Описание:  выполняет транзакции по записи объекта "Документ "Приходная моделей" в базу
  данных.
}
function TDOC_PRMODELForm.SaveDoc: boolean;
var _s : string;
     i : integer;                 //

begin

  result := true;
 if not check_user_grand('DH_PR_MODEL', 'U', true) then exit;


  try

    // начало транзакции
    data.RMPBase.StartTransaction;


    // номер документа
    if not NewDoc then
      begin
       _s := trim(DocNum.EditText);
       NumDoc := strToInt(_s);
      end;

    // если под этим номером уже есть документ и их ID разные
    if not NewDoc then
      if (ChechUniqueCode('DH_PR_MODEL', 'NUMDOC', _s, IDDoc) > 0)  then

        begin
          result :=  false;
          showmessage('Номер документа не уникальный!');
          exit;
        end;

    AddStoredProc.ParamByName('NUMDOC').asinteger := NumDoc;
    AddStoredProc.ParamByName('ID').asinteger  := IDDoc;

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
    if (WRHSCombo.ID > 0) then
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
    if (CSTCombo.ID > 0) and (CstCombo.Visible) then
      SetParamCombo(AddStoredProc.ParamByName('ID_CST'), CSTCombo)
    else
      begin
        if type_doc.Checked then
           begin
             showmessage('Не проставлен отправитель...');
             result :=  false;
             CSTCombo.color := clRed;
             CSTCombo.SetFocus;

             exit;

           end
          else
           SetParamCombo(AddStoredProc.ParamByName('ID_CST'), nil);

      end;

    // работник
    if (WRHS2Combo.ID > 0) and (WRHS2Combo.Visible) then
      SetParamCombo(AddStoredProc.ParamByName('ID_WRHS2'), WRHS2Combo)
    else
      begin
        if type_doc2.Checked then
          begin
           showmessage('Не проставлен склад...');
           result :=  false;
           WRHS2Combo.color := clRed;
           WRHS2Combo.SetFocus;

           exit;

         end
        else
          SetParamCombo(AddStoredProc.ParamByName('ID_WRHS2'), nil);


      end;

    if Type_doc.Checked then
      AddStoredProc.ParamByName('TYPE_DOC').AsInteger := 0
      else
       AddStoredProc.ParamByName('TYPE_DOC').AsInteger := 1;


     // заполнение поля INFO
    AddStoredProc.ParamByName('INFO').value := INFO.Lines.Text;


    // выполнение запроса
    AddStoredProc.Prepare;
    AddStoredProc.ExecProc;

    if NewDoc = true then
      begin
        IDDoc  := AddStoredProc.ParamByName('IDDOC').asinteger;
        NumDoc := AddStoredProc.ParamByName('NewNumDoc').asinteger;
        DocNum.text := inttostr(NumDoc);
      end;

    // теперь табличная часть
    // перебор всех строк плановых операций документа
     MemoryData.First;
     
     for i := 0 to MemoryData.RecordCount - 1 do

      begin

        StorProcTable.ParamByName('ID_DOC').asinteger:= IDDoc;
        StorProcTable.ParamByName('DateDoc').asdate     := strtodate(datedoc.text);
        StorProcTable.ParamByName('LINENO').asinteger   := MemoryData.fields[0].asinteger;
        StorProcTable.ParamByName('ID_MODEL').asinteger := MemoryData.fields[3].asinteger;  // ID номенклатуры
        StorProcTable.ParamByName('Quantity').asinteger := MemoryData.fields[2].asinteger;   // количество
        StorProcTable.ParamByName('ID_WRHS').asinteger  := WRHSCOmbo.ID;
        StorProcTable.ParamByName('ID_WRHS2').asinteger := WRHS2Combo.ID;

        if TYPE_DOC.Checked then
          StorProcTable.ParamByName('TYPE_DOC').asinteger:= 0
           else
             StorProcTable.ParamByName('TYPE_DOC').asinteger:= 1;


        StorProcTable.Prepare;
        StorProcTable.ExecProc;
        MemoryData.Next;

        if StorProcTable.ParamByName('ERROR').asinteger = 1 then
          begin
            MessageDlg('На дату ' + DateDoc.text
            + ' есть остаток ' + formatfloat('0.000', StorProcTable.paramByName('Rem_value').asfloat)
            + ' из необходимых ' + MemoryData.fields[2].asstring
            + ' моделей ' + MemoryData.fields[1].asstring + '.'
            + #13+#10+'Документ не сохранен.', mtError, [mbOK], 0);

            result := false;
//            Data.RMPBase.Rollback;
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
constructor TDOC_PRMODELForm.CreateN(AOwner: TForm; docID : integer);

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
      WRHS2Combo.ID := -1;

      Type_doc.Checked := true;
      Type_doc2.checked := false;

      qTableQuery.ParamByName('iddoc').asinteger := -1;
      qTableQuery.open;


      DocCaption := 'Документ Поступление моделей: Новый';
      WasAnyChanges := true;
    end

  else  // для редактирования существующего документа

    begin

      NewDoc := false;
      // заполнение информации по полям
      qFormQuery.SQL.clear;
      qFormQuery.sql.add('select * from dh_pr_model where id = ' + inttostr(IDDoc));
      qFormQuery.open;

      // заполнение поля "Организация"
      CSTCombo.ID := qFormQuery.fieldbyname('ID_CST').asinteger;

      // заполнение поля "Склад"
      WRHSCombo.ID := qFormQuery.fieldbyname('ID_WRHS').asinteger;

      // заполнение прочих полей
      DocNum.Text    := qFormQuery.fieldbyName('Numdoc').asstring;
      DateDoc.Text   := qformQuery.fieldbyName('Date_In').asstring;

      INFO.Lines.Add(qFormQuery.fieldbyname('INFO').asstring);

      //
      WRHS2Combo.id   := qformQuery.fieldbyName('ID_WRHS2').asinteger;

      type_doc.Checked := false;
      type_doc2.Checked := false;


      if qformQuery.fieldbyName('TYPE_DOC').asinteger = 0 then
        type_doc.Checked := true
         else
          type_doc2.Checked := true;

      // открываем запрос по заказам данной заявки
      qTableQuery.ParamByName('iddoc').asinteger := IDDoc;
      qTableQuery.open;
      DocCaption := 'Документ Поступление моделей: ' + DocNum.text + ' от ' + DateDoc.text;

      WasAnyChanges := false;

    end;

   // заполнить структуру временной таблицы
  MemoryData.LoadFromDataSet(qTableQuery,0,lmCopy);


   caption := DocCaption;
   Type_docClick(self);



end;

destructor TDOC_PRMODELForm.Destroy;
begin
  inherited;
end;
{
   Процедура записи документа в базу
}
procedure TDOC_PRMODELForm.OKButtonClick(Sender: TObject);
begin

 // при выполнении транзакции произошла ошибка
 if not SaveDoc then

   begin

       data.RMPBase.Rollback;
       exit;

   end;

 // далее необходимо обновить таблицу журналов заказов
 refreshquery(data.JRPRModelFormQuery);


 release;
end;
{
  Процедура закрытия документа
}
procedure TDOC_PRMODELForm.CloseClick(Sender: TObject);
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
procedure TDOC_PRMODELForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;
{
   Процедура выбора значения поля "Склад"
}
procedure TDOC_PRMODELForm.WRHSComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  WRHSCombo.color := clWindow;

  SelectFromTable(WRHSCombo);

end;
{
    Процедура выбора значения поля "Организации"
}
procedure TDOC_PRMODELForm.CSTComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  CSTCombo.color := clWindow;

  SelectFromTable(CSTCombo);

end;
{
    Процедура выбора значения поля "Организации"
}
procedure TDOC_PRMODELForm.CSTComboKeyDown(Sender: TObject; var Key: Word;
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
procedure TDOC_PRMODELForm.WRHSComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DocumentChange;

  WRHSCombo.color := clWindow;

  if checkIfExistCode(WRHSCombo, key, Shift) = false then
     WRHSComboButtonClick(Sender);

end;

procedure  TDOC_PRMODELForm.SortTable;
begin
  MemoryData.SortOnFields('lineno',false,false);
end;



{


  Процедуры обработки таблицы




  Добавление в таблицу новой строки
}
procedure TDOC_PRMODELForm.ToolButtonAddClick(Sender: TObject);
begin
  DocumentChange;
  MemoryData.Insert;
  MemoryData.Fields[0].AsInteger := MemoryData.RecordCount + 1;

  ModelCombo.ID := -1;
  SelectFromTable(ModelCombo);

  if ModelCombo.ID > 0 then
    begin
      MemoryData.fields[3].AsInteger := ModelCombo.ID;
      MemoryData.fields[1].AsString  := ModelCombo.Text;
      MemoryData.fields[2].AsInteger := 0;
    end;

  MemoryData.Post;

  SortTable;

end;
{
   Редактирование
}
procedure TDOC_PRMODELForm.ToolButtonEditClick(Sender: TObject);
begin
  if MemoryData.RecordCount = 0 then exit;

  DocumentChange;  // признак изменения документа

  MemoryData.Edit;
  ModelCombo.ID := MemoryData.fields[3].AsInteger;
  SelectFromTable(ModelCombo);

  if ModelCombo.ID > 0 then
    begin
      MemoryData.fields[3].AsInteger := ModelCombo.ID;
      MemoryData.fields[1].AsString  := ModelCombo.Text;
    end;

  MemoryData.Post;

end;
{
   Удаление номенклатуры
}
procedure TDOC_PRMODELForm.ToolButtonDelClick(Sender: TObject);
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
procedure TDOC_PRMODELForm.ToolButtonUpClick(Sender: TObject);
var i,j : integer;
begin

  if  MemoryData.RecNo > 1 then
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
procedure TDOC_PRMODELForm.ToolButtonDownClick(Sender: TObject);
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
procedure TDOC_PRMODELForm.GridTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  case Key of
//    46 :  ToolButtonDelClick(Sender);   // удаление записи
//    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
//    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
//  end;

end;

procedure TDOC_PRMODELForm.DateDocChange(Sender: TObject);
begin
  DateDoc.color := clWindow;   
end;


{
   Процедура печати приходной накладной


}


procedure TDOC_PRMODELForm.PrintButtonClick(Sender: TObject);
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
procedure TDOC_PRMODELForm.NeedBillButtonClick(Sender: TObject);
begin
   if iddoc < 0 then exit;

   if DLLHandle = 0 then
     DLLhandle := loadLibrary('PrintForm');

     @Print_Requirement_form := GetProcAddress(DLLHandle , 'Print_Requirement_form');

     // вызов функции печати из библиотеки
     Print_Requirement_form(application, self, IDDoc, data.RMPBase);


end;

procedure TDOC_PRMODELForm.WRHS2ComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  WRHS2Combo.color := clWindow;

  SelectFromTable(WRHS2Combo);


end;

procedure TDOC_PRMODELForm.WRHS2ComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DocumentChange;

  WRHS2Combo.color := clWindow;

  if checkIfExistCode(WRHS2Combo, key, Shift) = false then
     WRHS2ComboButtonClick(Sender);

end;

procedure TDOC_PRMODELForm.Type_docClick(Sender: TObject);
begin
   cstcombo.Visible := false;
   WRHS2Combo.Visible:= false;



   if Type_doc.Checked then
      cstcombo.Visible := true
    else
       WRHS2Combo.Visible := true;

  LabelWRKR.Visible := WRHS2Combo.Visible;
  LabelCST.Visible  := CSTCombo.Visible;

end;

procedure TDOC_PRMODELForm.GridColumns1EditButtonClick(Sender: TObject;
  var Handled: Boolean);
begin
  DocumentChange;
  if MemoryData.State = dsInsert then
    begin
      MemoryData.Fields[0].AsInteger := MemoryData.RecordCount + 1;
      ModelCombo.ID := -1;
    end
   else
     begin
       MemoryData.Edit;
       ModelCombo.ID := MemoryData.fields[3].AsInteger;
     end;

  SelectFromTable(ModelCombo);

  if ModelCombo.ID > 0 then
    begin
      MemoryData.fields[3].AsInteger := ModelCombo.ID;
      MemoryData.fields[1].AsString  := ModelCombo.Text;
      if MemoryData.State = dsInsert then
        MemoryData.fields[2].AsInteger := 0;
    end;

   MemoryData.Post;

end;

procedure TDOC_PRMODELForm.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
//    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;
end;

end.

