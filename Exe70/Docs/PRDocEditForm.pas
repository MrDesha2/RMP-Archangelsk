{
           Модуль  PRDocEditForm формы редактирования документа "Приходная накладная".
      Модуль представляет приходный складской документ и его проведение.
}

unit PRDocEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, RXDBCtrl, Mask, ToolEdit, Grids, DBGrids, ComCtrls,
  ToolWin, ExtCtrls, Db, DBTables, EnumForm, EnumTreeForm, JRPRDocForm;

type

  StandardProc = procedure(ParentApplication: tApplication;
    ParentForm : tForm; iddoc : integer; data : tDataBase); StdCall;

  // структура документа
  pNMNTDoc = ^tNMNTDoc;
  tNMNTDoc = record
     ID      : integer;  // ID документа
     Number  : integer;  // номер документа
     ID_CST  : integer;  // ID организации
     Name_CST: string;   // Наименование организации
     ID_WRHS : integer;  // ID склада
     Name_WRHS: string;  // Наименование склада
     Type_doc: integer;  // тип документа 11 - приход готовой продукции
//                                          12 - приход выполненных работ
//                                          21 - расход готовой продукции
//                                          22 - акт выполненных работ
//                                          31 - поступление материлов
//                                          41 - отпуск материалов в производство

     is_sign : integer;  // признак подписи
     lNMNT   : tList;    // список табличной части;
     Info    : string;   // МЕМО поле

    end; 




  // материал операции
  pNMNT = ^tNMNT;
  tNMNT = record
     lineno : integer;   // номер строки материала
     ID_matr: integer;   // ID материала
     Name_matr: string;  // наименование материала
     ID_EdIz  : integer; // ID единицы измерения
     Name_EdIz: string;  // наименование единицы измерения
     nValue   : real;    // количество материала
     Price    : real;
     nCost    : real;    // стоимость материала
     nLenght  : real;
     nHeight  : real;
     nWidth   : real;
     nWeight  : double;
     ID_ORDER : integer;
     NumDocOrd: integer;
     ID_PDR   : integer;
     Name_PDR : string;
     Info     : string;

    end;


  TDOC_PRForm = class(TForm)
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
    Label3: TLabel;
    qWRHSQuery: TQuery;
    qCSTQuery: TQuery;
    WRHSCombo: TComboEdit;
    CSTCombo: TComboEdit;
    qFormQuery: TQuery;
    GridTable: TStringGrid;
    StorProcAdd: TStoredProc;
    StorProcUpdate: TStoredProc;
    StorProcTable: TStoredProc;
    qORDERQuery: TQuery;
    PrintButton: TButton;
    PR_CHRTCombo: TComboBox;
    Label4: TLabel;
    PR_EXEC: TCheckBox;
    Info: TRichEdit;
    ButtonCheckPrice: TButton;
    Button1: TButton;
    procedure OKButtonClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WRHSComboButtonClick(Sender: TObject);
    procedure CSTComboButtonClick(Sender: TObject);
    procedure CSTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WRHSComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
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
    procedure ButtonCheckPriceClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private

    Print_pr_form  : StandardProc;
    Print_Requirement_form: StandardProc;

  public
    { Public declarations }
    constructor CreateN(AOwner: TForm; docID : integer; ParentForm : TJR_PRDOCForm);
    destructor Destroy; override;
  end;

var
  DOC_PRForm: TDOC_PRForm;
  EnumEdit      : TForm;    //  формы
  IDDoc         : integer;  //  идентификатор документа
  NumDoc        : integer;  //  номер документа
  NewDoc        : boolean;  //  признак создания нового документа
  DocCaption    : string;   // заголовок окна
  WasAnyChanges : boolean;  // признак изменения формы
  lMainNMNT     : tList;    // основной список строк таблицы
  aNMNT         : pNMNT;

  ParentDocForm : TJR_PRDOCForm; // форма журнала документов


implementation

uses    Base,     // база
        Libs,     // библиотека дополнительных функций
EnumForm4Sel,     // форма выбора из справочников
 JRORDERForm,     // форма журнала заказов
 OrderEditLibs,
 DocNMNTEdit, Main, ParamForm;     // форма редактирования табличной формы


{$R *.DFM}
{
  Процедура показа изменений в форме
}
procedure  TDOC_PRForm.DocumentChange;
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
function TDOC_PRForm.SaveDoc: boolean;
var _s : string;
     i : integer;                 //
     StorProc  : TStoredProc;     //  хранимая процедура для выполнения транзакции

begin

  result := true;
 if not check_user_grand('DH_PR', 'U', true) then exit;


  try

    // начало транзакции
    data.RMPBase.StartTransaction;

    // при добавлении и изменении данных выполняются разные процедуры
    if NewDoc = true then
      StorProc := StorProcAdd

    else
      begin
        StorProc := StorProcUpdate;
        StorProc.ParamByName('ID').asinteger  := IDDoc;
      end;

    // номер документа
    if not NewDoc then
      begin
       _s := trim(DocNum.EditText);
       NumDoc := strToInt(_s);
      end;

    // если под этим номером уже есть документ и их ID разные
    if not NewDoc then
      if (ChechUniqueCode('DH_PR', 'NUMDOC', _s, IDDoc) > 0)  then

        begin
          result :=  false;
          showmessage('Номер документа не уникальный!');
          exit;
        end;

    StorProc.ParamByName('NUMDOC').asinteger := NumDoc;

    // дата дока
    if (DateDoc.text = '  .  .  ') or (DateDoc.text = '  .  .    ') then
      begin
        showmessage('Не указана дата документа!');
        result :=  false;
        DateDoc.color := clRed;
        exit;

      end

    else
      try
        StorProc.ParamByName('DATE_IN').asdate   := strtodate(DateDoc.text);

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
      SetParamCombo(StorProc.ParamByName('ID_WRHS'), WRHSCombo)
    else
      begin
        showmessage('Не проставлен склад-получатель...');
        result :=  false;
        WRHSCombo.color := clRed;

        WRHSCombo.setfocus;
        exit;
      end;

    // отправитель
    if (CSTCombo.ID > 0) then
      SetParamCombo(StorProc.ParamByName('ID_CST'), CSTCombo)
    else
      begin
        showmessage('Не проставлен отправитель...');
        result :=  false;
        CSTCombo.color := clRed;
        CSTCombo.SetFocus;

        exit;
      end;



     // заполнение поля INFO
    StorProc.ParamByName('INFO').value := INFO.Lines.Text;


    // поле "Вид чертежа"
    StorProc.ParamByName('PR_CHRT').value := PR_CHRTCombo.ItemIndex;

    // поле "Подписана"
    if pr_exec.Checked then
      StorProc.ParamByName('PR_EXEC').asinteger := 1
    else
      StorProc.ParamByName('PR_EXEC').asinteger := 0;

    // выполнение запроса
    StorProc.Prepare;
    StorProc.ExecProc;

    if NewDoc = true then
      begin
        IDDoc  := StorProc.ParamByName('IDDOC').asinteger;
        NumDoc := StorProc.ParamByName('NewNumDoc').asinteger;
        DocNum.text := inttostr(NumDoc);
      end;

    // теперь табличная часть
    // перебор всех строк плановых операций документа
    if lMainNMNT <> nil then 
     for i := 0 to lMainNMNT.Count - 1 do

      begin
        aNMNT := lMainNMNT.items[i];

        StorProcTable.ParamByName('ID_PRMTR').asinteger:= IDDoc;
        StorProcTable.ParamByName('DateDoc').asdate    := strtodate(datedoc.text);
        StorProcTable.ParamByName('LINENO').asinteger  := aNMNT^.lineno;
        StorProcTable.ParamByName('ID_NMNT').asinteger := aNMNT^.ID_matr;  // ID номенклатуры
        StorProcTable.ParamByName('NUMBER').asfloat    := aNMNT^.nValue;   // количество
        StorProcTable.ParamByName('PRICE').asfloat     := aNMNT^.Price;    // цена
        StorProcTable.ParamByName('ID_EDIZ').asinteger := aNMNT^.ID_EdIz;  // единица измерия
        StorProcTable.ParamByName('ID_WRHS').asinteger := qWRHSQuery.fieldbyname('id').asinteger; // склад
        StorProcTable.ParamByName('ID_ORD').asinteger  := aNMNT^.ID_ORDER; // номер заказа при позаказном учете
        StorProcTable.ParamByName('Leng').asfloat      := aNMNT^.nLenght;  // длина
        StorProcTable.ParamByName('hight').asfloat     := aNMNT^.nHeight;  // высота
        StorProcTable.ParamByName('width').asfloat     := aNMNT^.nWidth;   // ширина
        StorProcTable.ParamByName('weight').asfloat    := aNMNT^.nWeight;  // вес

        StorProcTable.Prepare;
        StorProcTable.ExecProc;

      end;


    // конец транзакции
    data.RMPBase.Commit;

  except
   Data.RMPBase.Rollback; {on failure, undo the changes};
  raise; {raise the exception to prevent a call to CommitUpdates!}
  end;

 // далее необходимо обновить таблицу журналов заказов
 //  refreshquery( JR_PRDocForm.FormOrderQuery);
  if ParentDocForm <> nil then
  refreshquery( data.JRPRFormQuery);


end;



{
   Конструктор формы документа "Приходная накладная"
   Вход: компонент-приложения,
   IDDoc - идентификатор документа или -1 в случае создания нового документа.

}
constructor TDOC_PRForm.CreateN(AOwner: TForm; docID : integer ; ParentForm : TJR_PRDOCForm);
var qTMPQuery : tQuery;
begin
  inherited Create(AOwner);

  IdDoc := docID;
  qTMPQuery             := TQuery.Create(self);
  qTMPQuery.DatabaseName:= data.RMPBase.databasename;

  if parentForm <> nil then
    ParentDocForm := parentForm;

  PR_CHRTCombo.ItemIndex := 0;
  lMainNMNT := tList.Create;


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


        PR_EXEC.Checked := false;
      DocCaption := 'Документ Приходная накладная: Новый';
      WasAnyChanges := true;
    end

  else  // для редактирования существующего документа

    begin

      NewDoc := false;
      // заполнение информации по полям
      qFormQuery.SQL.clear;
      qFormQuery.sql.add('select * from dh_pr where id = ' + inttostr(IDDoc));
      qFormQuery.open;

      // заполнение поля "Организация"
      CSTCombo.ID := qFormQuery.fieldbyname('ID_CST').asinteger;

      // заполнение поля "Склад"
      WRHSCombo.ID := qFormQuery.fieldbyname('ID_WRHS').asinteger;

      // заполнение прочих полей
      DocNum.Text    := qFormQuery.fieldbyName('Numdoc').asstring;
      DateDoc.Text   := qformQuery.fieldbyName('Date_In').asstring;

      INFO.Lines.Add(qFormQuery.fieldbyname('INFO').asstring);

      // Признак чертежа: ремонт, изготовление
      PR_CHRTCombo.ItemIndex := qFormQuery.fieldbyname('PR_CHRT').asinteger;

      // Признак "Подписана"
      if qFormQuery.FieldbyName('PR_EXEC').asinteger = 0 then
        PR_Exec.Checked := false
      else
        PR_Exec.Checked := true;


      // открываем запрос по заказам данной заявки
      qTableQuery.ParamByName('iddoc').asinteger := IDDoc;
      qTableQuery.open;
      DocCaption := 'Документ Приходная накладная: ' + DocNum.text + ' от ' + DateDoc.text;

      WasAnyChanges := false;

      // получить данные в список строк
      Get_Table_NMNT_data( qTableQuery, lMainNMNT);

      // заполнить данные в таблицу
      Fill_NMNT_table( lMainNMNT, GridTable);



    end;

   caption := DocCaption;

end;

destructor TDOC_PRForm.Destroy;
begin
  inherited;
end;
{
   Процедура записи документа в базу
}
procedure TDOC_PRForm.OKButtonClick(Sender: TObject);
begin

 // при выполнении транзакции произошла ошибка
 if not SaveDoc then

   begin

       data.RMPBase.Rollback;
       exit;

   end;


 release;
end;
{
  Процедура закрытия документа
}
procedure TDOC_PRForm.CloseClick(Sender: TObject);
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
procedure TDOC_PRForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;
{
   Процедура выбора значения поля "Склад"
}
procedure TDOC_PRForm.WRHSComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  WRHSCombo.color := clWindow;

  SelectFromTable(WRHSCombo);

end;
{
    Процедура выбора значения поля "Организации"
}
procedure TDOC_PRForm.CSTComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  CSTCombo.color := clWindow;

  SelectFromTable(CSTCombo);

end;
{
    Процедура выбора значения поля "Организации"
}
procedure TDOC_PRForm.CSTComboKeyDown(Sender: TObject; var Key: Word;
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
procedure TDOC_PRForm.WRHSComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DocumentChange;

  WRHSCombo.color := clWindow;

  if checkIfExistCode(WRHSCombo, key, Shift) = false then
     WRHSComboButtonClick(Sender);

end;



{
    Процедура при открытии формы

}
procedure TDOC_PRForm.FormShow(Sender: TObject);
begin
  GridTable.cells[1, 0] := 'Строка';
  GridTable.cells[2, 0] := 'Номенклатура';
  GridTable.cells[3, 0] := 'Единица измерения';
  GridTable.cells[4, 0] := 'Количество';
  GridTable.cells[5, 0] := 'Цена';
  GridTable.cells[6, 0] := 'Сумма';

  {
    В остальных колонках таблицы
    7 - ID номенклатуры
    8 - ID единицы измерения

  }

end;
{
  Процедуры обработки таблицы

}
{
  Добавление в таблицу новой строки
}
procedure TDOC_PRForm.ToolButtonAddClick(Sender: TObject);
var Form : TDOC_NMNT;
begin
  DocumentChange;
  new(aNMNT);

  aNMNT^.nValue := 0;
  aNMNT^.nCost  := 0;
  aNMNT^.nLenght:= 0;
  aNMNT^.nHeight:= 0;
  aNMNT^.nWidth := 0;
  aNMNT^.nWeight:= 0;
  aNMNT^.Price  := 0;
  aNMNT^.NumDocOrd := 0;
  aNMNT^.lineno := 0;



  Form := TDOC_NMNT.createNMNT(self, aNMNT); // вызов формы редактирования операций для добавления плановой
  Form.PDRCombo.visible := false;
  Form.LabelPDR.visible := false;

  if Form.showmodal = mrOK then
    lMainNMNT.add(aNMNT);
  Form.Close;

  Fill_NMNT_table( lMainNMNT, GridTable);

end;
{
   Редактирование номенклатуры
}
procedure TDOC_PRForm.ToolButtonEditClick(Sender: TObject);
var Form : TDOC_NMNT;
begin
  // если есть что редактировать
  if lMainNMNT = nil then exit;
  if lMainNMNT.count = 0 then exit;

  DocumentChange;  // признак изменения документа

  Form := TDOC_NMNT.createNMNT(self, lMainNMNT.items[GridTable.row - 1]); // вызов формы редактирования
  Form.PDRCombo.visible := false;
  Form.LabelPDR.visible := false;

  Form.showmodal;
  Form.Close;

  Fill_NMNT_table( lMainNMNT, GridTable);

end;
{
   Удаление номенклатуры
}
procedure TDOC_PRForm.ToolButtonDelClick(Sender: TObject);
begin
  if lMainNMNT = nil then exit;
  if lMainNMNT.Count = 0 then exit;

  DocumentChange;  // признак изменения документа
  if messagedlg('Удалить номенклатуру?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

    lMainNMNT.Delete(GridTable.row -1);

  Fill_NMNT_table( lMainNMNT, GridTable);

end;
{
    Процедура сдвига позиции номенклатуры вверх
}
procedure TDOC_PRForm.ToolButtonUpClick(Sender: TObject);
begin

  Change_enum_list_pos(lMainNMNT, GridTable.row - 1, GridTable.row - 2);
   if GridTable.row > 1 then GridTable.row := GridTable.row - 1;

   Fill_NMNT_table( lMainNMNT, GridTable);

end;
{
   Процедура сдвига позиции номенклатуры вниз
}
procedure TDOC_PRForm.ToolButtonDownClick(Sender: TObject);
begin
  Change_enum_list_pos(lMainNMNT, GridTable.row - 1, GridTable.row);
   if GridTable.row < (GridTable.rowcount - 1) then GridTable.row := GridTable.row + 1;

   Fill_NMNT_table( lMainNMNT, GridTable);
end;
{
  Процедура при нажатии кнопки клавиатуры в таблице документа

}
procedure TDOC_PRForm.GridTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;

end;

procedure TDOC_PRForm.DateDocChange(Sender: TObject);
begin
  DateDoc.color := clWindow;   
end;


{
   Процедура печати приходной накладной


}


procedure TDOC_PRForm.PrintButtonClick(Sender: TObject);
begin

  if iddoc < 0 then exit;

  // Печатается только форма для чертежей "Изготовление"
  if PR_CHRTCombo.ItemIndex = 1 then

    begin

       showmessage('Печатная форма документа предназначена только для вида чертежа "Изготовление"!');
       exit;

    end;

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
procedure TDOC_PRForm.NeedBillButtonClick(Sender: TObject);
begin
   if iddoc < 0 then exit;

   if DLLHandle = 0 then
     DLLhandle := loadLibrary('PrintForm');

     @Print_Requirement_form := GetProcAddress(DLLHandle , 'Print_Requirement_form');

     // вызов функции печати из библиотеки
     Print_Requirement_form(application, self, IDDoc, data.RMPBase);


end;
{-----------------------------------------------------------------------------
  Процедура: TDOC_PRForm.ButtonCheckPriceClick
  Автор:     Администратор
  Дата:      16-июн-2004
  Аргументы: Sender: TObject
  Выход:     None
  Описание:  Проверяет позиции документа за текущий месяц на предмет
             расхождения в ценах
-----------------------------------------------------------------------------}

procedure TDOC_PRForm.ButtonCheckPriceClick(Sender: TObject);
var qQuery : tQuery;
    strinfo: tstringlist;
    i : integer;
    datebeg, dateend : tdate;

begin
   strinfo := tstringlist.Create;

   qQuery := tQuery.Create(self);
   qQuery.DatabaseName := data.RMPBase.DatabaseName;

   with qQuery do
     begin
       sql.Clear;
       sql.Add('select nmnt.code, nmnt.name, doct.price, doc.date_in, doc.numdoc');
       sql.add('from spr_nmnt nmnt, dh_pr doc, dt_pr doct');
       sql.add('where doc.date_in >= :datebeg and  doc.date_in <= :dateend and');
       sql.add('doc.id = doct.id_prmtr and doct.id_nmnt = spr_nmnt.id and');
       sql.add('nmnt.vid_nom = 1 and nmnt.id = :id and ');
       sql.add('(doc.id <> :iddoc  or (doc.id = :iddoc and doct.lineno <> :lineno))'); // было doc.id <> :iddoc

     end;


   datebeg := beginofmonth(strtodate(datedoc.Text));
   dateend := endofmonth(strtodate(datedoc.Text));
   for i := 0  to lMainNMNT.Count - 1 do
     begin
       aNMNT := lMainNMNT.items[i];

       qQuery.Close;
       qQuery.ParamByName('datebeg').AsDate := datebeg;
       qQuery.ParamByName('dateend').AsDate := dateend;
       qQuery.ParamByName('id').AsInteger   := aNMNT.ID_matr;
       qQuery.ParamByName('iddoc').AsInteger:= IDDOC;
       qQuery.ParamByName('lineno').AsInteger:= i+1;
       qQuery.Open;

       if not qQuery.Eof then
         begin
           qQuery.First;
           while not qQuery.Eof do
             begin
               if formatfloat('0.00',qQuery.Fields[2].asfloat) <> formatfloat('0.00',aNMNT.Price) then
                 strinfo.Add('Материал: ' + qQuery.Fields[1].asstring +
                   ' цена ' + formatfloat('0.00',qQuery.Fields[2].asfloat) +
                   ' приход № ' + qQuery.Fields[4].asstring+
                   ' от ' + qQuery.Fields[3].asstring);
               qQuery.Next;
             end;
          end;

     end;

  // если список записей не пуст, то выводим его
  if strinfo.Count <> 0 then
    MessageDlg(strinfo.Text, mtWarning, [mbOK], 0)
   else
     MessageDlg('Повторов неверных цен не найдено в текущем месяце', mtWarning, [mbOK], 0);
end;

procedure TDOC_PRForm.Button1Click(Sender: TObject);
begin
  if iddoc < 0 then exit;

  // Печатается только форма для чертежей "Изготовление"
  if PR_CHRTCombo.ItemIndex = 1 then

    begin

       showmessage('Печатная форма документа предназначена только для вида чертежа "Изготовление"!');
       exit;

    end;

  if DLLHandle = 0 then
    DLLhandle := LoadLibrary('PrintForm');

  try

     @Print_pr_form := GetProcAddress(DLLHandle , 'Print_pr_form_new');

     // вызов функции печати из библиотеки
     Print_pr_form(application, self, IDDoc, data.RMPBase);

  finally
  end;

end;

end.

