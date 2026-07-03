{
           Модуль  PRMTRDocEditForm формы редактирования
           документа "Отпуск материалов".
      Модуль представляет приходный складской документ и его проведение.


}

unit RSMTRDocEditForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, RXDBCtrl, Mask, ToolEdit, Grids, DBGrids, ComCtrls,
  ToolWin, ExtCtrls, Db, DBTables, EnumForm, EnumTreeForm, JRRsMTRForm,
  PRDocEditForm;

type

  StandardProc = procedure(ParentApplication: tApplication;
    ParentForm : tForm; iddoc : integer; base : tDatabase); stdcall;

  TDOC_RS_MTRForm = class(TForm)
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
    INFO: TRichEdit;
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

  private

    Print_form  : StandardProc;

  public
    { Public declarations }
    constructor CreateN(AOwner: TForm; docID : integer; ParentForm : TJR_RSMTRForm);
    destructor Destroy; override;
  end;

var
  DOC_RS_MTRForm: TDOC_RS_MTRForm;
  EnumEdit      : TForm;    //  формы
  IDDoc         : integer;  //  идентификатор документа
  NumDoc        : integer;  //  номер документа
  NewDoc        : boolean;  //  признак создания нового документа
  DocCaption    : string;   // заголовок окна
  WasAnyChanges : boolean;  // признак изменения формы
  lMainNMNT     : tList;
  aMaterial     : pNMNT;

  ParentDocForm : TJR_RSMTRForm; // форма журнала документов

implementation

uses    Base,     // база
        Libs,     // библиотека дополнительных функций
EnumForm4Sel,     // форма выбора из справочников
 OrderEditLibs,

 JRORDERForm,     // форма журнала заказов
 DocNMNTEdit, Main, ParamForm;     // форма редактирования табличной формы


{$R *.DFM}
{
  Процедура показа изменений в форме
}
procedure  TDOC_RS_MTRForm.DocumentChange;
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
function TDOC_RS_MTRForm.SaveDoc: boolean;
var _s : string;
     i : integer;                 //
     StorProc  : TStoredProc;     //  хранимая процедура для выполнения транзакции

begin

  result := true;
 if not check_user_grand('DH_RS_MTR', 'U', true) then exit;


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
      if (ChechUniqueCode('DH_RS_MTR', 'NUMDOC', _s, IDDoc) > 0)  then

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



    // инфо
    StorProc.ParamByName('INFO').value:= INFO.Lines.Text;

    // выполнение запроса
    StorProc.Prepare;
    StorProc.ExecProc;

    if NewDoc then
      begin
        IDDoc  := StorProc.ParamByName('IDDOC').asinteger;
        NumDoc := StorProc.ParamByName('NewNumDoc').asinteger;
        DocNum.text := Inttostr(NumDoc);
      end;  

    // теперь табличная часть
    // перебор всех строк плановых операций документа
    // теперь табличная часть
    // перебор всех строк плановых операций документа
    if lMainNMNT <> nil then 

     for i := 0 to lMainNMNT.Count - 1 do

      begin
        aMaterial := lMainNMNT.items[i];

        StorProcTable.ParamByName('ID_RSMTR').asinteger:= IDDoc;
        StorProcTable.ParamByName('DateDoc').asdate    := strtodate(datedoc.text);
        StorProcTable.ParamByName('LINENO').asinteger  := aMaterial^.lineno;
        StorProcTable.ParamByName('ID_NMNT').asinteger := aMaterial^.ID_matr;  // ID номенклатуры
        StorProcTable.ParamByName('NUMBER').asfloat    := aMaterial^.nValue;   // количество
        StorProcTable.ParamByName('PRICE').asfloat     := aMaterial^.Price;    // цена
        StorProcTable.ParamByName('ID_EDIZ').asinteger := aMaterial^.ID_EdIz;  // единица измерия
        SetParamCombo(StorProcTable.ParamByName('ID_WRHS'), WRHSCombo);
        StorProcTable.ParamByName('Leng').asfloat      := aMaterial^.nLenght;  // длина
        StorProcTable.ParamByName('hight').asfloat     := aMaterial^.nHeight;  // высота
        StorProcTable.ParamByName('width').asfloat     := aMaterial^.nWidth;   // ширина
        StorProcTable.ParamByName('weight').asfloat    := aMaterial^.nWeight;  // вес
        StorProcTable.ParamByName('id_ord').asinteger  := aMaterial^.ID_ORDER;  // вес
        StorProcTable.ParamByName('id_pdr').asinteger  := aMaterial^.ID_PDR;  // вес

        StorProcTable.Prepare;
        StorProcTable.ExecProc;

        if StorProcTable.ParamByName('ERROR').asinteger = 1 then
          begin
            MessageDlg('На дату ' + DateDoc.text + ' на складе ' + WRHSCombo.Text
            + ' есть остаток ' + formatfloat('0.000', StorProcTable.paramByName('Rem_value').asfloat)
            + ' из необходимых ' + formatfloat('0.000', aMaterial^.nValue)
            + ' номенклатуры ' + aMaterial^.Name_matr + '.'
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

 // далее необходимо обновить таблицу журналов заказов
 //  refreshquery( JR_PRDocForm.FormOrderQuery);
  if ParentDocForm <> nil then
  refreshquery( data.JRRSMPRFormQuery);


end;



{
   Конструктор формы документа "Приходная накладная"
   Вход: компонент-приложения,
   IDDoc - идентификатор документа или -1 в случае создания нового документа.

}
constructor TDOC_RS_MTRForm.CreateN(AOwner: TForm; docID : integer ; ParentForm : TJR_RSMTRForm);
var qTMPQuery : tQuery;
begin
  inherited Create(AOwner);

  IdDoc := docID;
  qTMPQuery             := TQuery.Create(self);
  qTMPQuery.DatabaseName:= data.RMPBase.databasename;

  if parentForm <> nil then
    ParentDocForm := parentForm;

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
      CSTCombo.ID := -1;

      DocCaption := 'Документ Отпуск материалов в производство: Новый';
      WasAnyChanges := true;
    end

  else  // для редактирования существующего документа

    begin

      NewDoc := false;
      // заполнение информации по полям
      qFormQuery.SQL.clear;
      qFormQuery.sql.add('select * from dh_rs_mtr where id = ' + inttostr(IDDoc));
      qFormQuery.open;

      // заполнение поля "Организация"
      CSTCombo.ID := qFormQuery.fieldbyname('ID_CST').asinteger;
      // заполнение поля "Склад"
      WRHSCombo.ID := qFormQuery.fieldbyname('ID_WRHS').asinteger;

      // заполнение прочих полей
      DocNum.Text    := qFormQuery.fieldbyName('Numdoc').asstring;
      DateDoc.Text   := qformQuery.fieldbyName('Date_In').asstring;

      INFO.Lines.Add(qFormQuery.fieldbyname('INFO').asstring);

      // открываем запрос по заказам данной заявки
      qTableQuery.ParamByName('iddoc').asinteger := IDDoc;
      qTableQuery.open;
      DocCaption := 'Документ Отпуск материалов в производство: ' + DocNum.text + ' от ' + DateDoc.text;

      WasAnyChanges := false;

      // получить данные в список строк
      Get_Table_NMNT_data( qTableQuery, lMainNMNT);

      // заполнить данные в таблицу
      Fill_NMNT_table( lMainNMNT, GridTable);

    end;

   caption := DocCaption;

end;

destructor TDOC_RS_MTRForm.Destroy;
begin
  inherited;
end;
{
   Процедура записи документа в базу
}
procedure TDOC_RS_MTRForm.OKButtonClick(Sender: TObject);
begin

 // при выполнении транзакции произошла ошибка
 if not SaveDoc then

   begin

       exit;

   end;


 release;
end;
{
  Процедура закрытия документа
}
procedure TDOC_RS_MTRForm.CloseClick(Sender: TObject);
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
procedure TDOC_RS_MTRForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;
{
   Процедура выбора значения поля "Склад"
}
procedure TDOC_RS_MTRForm.WRHSComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  WRHSCombo.color := clWindow;

  SelectFromTable(WRHSCombo);

end;
{
    Процедура выбора значения поля "Организации"
}
procedure TDOC_RS_MTRForm.CSTComboButtonClick(Sender: TObject);
begin
  DocumentChange;

  CSTCombo.color := clWindow;

  SelectFromTable(CSTCombo);

end;
{
    Процедура выбора значения поля "Организации"
}
procedure TDOC_RS_MTRForm.CSTComboKeyDown(Sender: TObject; var Key: Word;
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
procedure TDOC_RS_MTRForm.WRHSComboKeyDown(Sender: TObject; var Key: Word;
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
procedure TDOC_RS_MTRForm.FormShow(Sender: TObject);
begin
  GridTable.cells[1, 0] := 'Строка';
  GridTable.cells[2, 0] := 'Номенклатура';
  GridTable.cells[3, 0] := 'Единица измерения';
  GridTable.cells[4, 0] := 'Количество';
  GridTable.cells[5, 0] := 'Цена';
  GridTable.cells[6, 0] := 'Сумма';
  GridTable.cells[7, 0] := 'Номер заказа';
  GridTable.cells[8, 0] := 'МВЗ';



end;
{
  Процедуры обработки таблицы

}
{
  Добавление в таблицу новой строки
}
procedure TDOC_RS_MTRForm.ToolButtonAddClick(Sender: TObject);
var Form : TDOC_NMNT;
begin
  DocumentChange;
  new(aMaterial);

  aMaterial^.nValue := 0;
  aMaterial^.nCost  := 0;
  aMaterial^.nLenght:= 0;
  aMaterial^.nHeight:= 0;
  aMaterial^.nWidth := 0;
  aMaterial^.nWeight:= 0;
  aMaterial^.Price  := 0;
  aMaterial^.NumDocOrd := 0;
  aMaterial^.lineno := 0;
  aMaterial^.ID_PDR := 0;

  Form := TDOC_NMNT.createNMNT(self, aMaterial); // вызов формы редактирования операций для добавления плановой

  if Form.showmodal = mrOK then
    lMainNMNT.add(aMaterial);
  Form.Close;

  Fill_NMNT_table( lMainNMNT, GridTable);

end;
{
   Редактирование номенклатуры
}
procedure TDOC_RS_MTRForm.ToolButtonEditClick(Sender: TObject);
var Form : TDOC_NMNT;
begin
  // если есть что редактировать
  if lMainNMNT = nil then exit;
  if lMainNMNT.count = 0 then exit;

  DocumentChange;  // признак изменения документа

  Form := TDOC_NMNT.createNMNT(self, lMainNMNT.items[GridTable.row - 1]); // вызов формы редактирования

  Form.showmodal;
  Form.Close;

  Fill_NMNT_table( lMainNMNT, GridTable);

end;
{
   Удаление номенклатуры
}
procedure TDOC_RS_MTRForm.ToolButtonDelClick(Sender: TObject);
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
procedure TDOC_RS_MTRForm.ToolButtonUpClick(Sender: TObject);
begin

  Change_enum_list_pos(lMainNMNT, GridTable.row - 1, GridTable.row - 2);
   if GridTable.row > 1 then GridTable.row := GridTable.row - 1;

   Fill_NMNT_table( lMainNMNT, GridTable);

end;
{
   Процедура сдвига позиции номенклатуры вниз
}
procedure TDOC_RS_MTRForm.ToolButtonDownClick(Sender: TObject);
begin
  Change_enum_list_pos(lMainNMNT, GridTable.row - 1, GridTable.row);
   if GridTable.row < (GridTable.rowcount - 1) then GridTable.row := GridTable.row + 1;

   Fill_NMNT_table( lMainNMNT, GridTable);
end;
{
  Процедура при нажатии кнопки клавиатуры в таблице документа

}
procedure TDOC_RS_MTRForm.GridTableKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    46 :  ToolButtonDelClick(Sender);   // удаление записи
    45 :  ToolButtonAddClick(Sender); // Добавление по Ins
    13 :  ToolButtonEditClick(Sender);  // Редактирование по Enter
  end;

end;

procedure TDOC_RS_MTRForm.DateDocChange(Sender: TObject);
begin
  DateDoc.color := clWindow;   
end;


{
   Процедура печати приходной накладной


}


procedure TDOC_RS_MTRForm.PrintButtonClick(Sender: TObject);
begin

  if iddoc < 0 then exit;

  if DLLHandle = 0 then
    DLLhandle := LoadLibrary('PrintForm');

  try

     @Print_form := GetProcAddress(DLLHandle , 'Print_rs_mtr_form');

     // вызов функции печати из библиотеки
     Print_form(application, self, IDDoc, data.RMPBase);

  finally
  end;


end;




end.
