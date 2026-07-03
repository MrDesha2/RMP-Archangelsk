{***************************************************************
 *
 * Unit Name: PROC_MTRPLAN
 * Purpose  : Формирование потребности в материалах на основании
 * планового журнала заказов
 * Author   :
 * History  :
 *
 ****************************************************************}

unit PROC_MTRPLAN;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGridEh, ComCtrls, ToolWin, ExtCtrls,
  ImgList, Db, DBTables, Mask, ToolEdit;

type

  // Потребность в материалах
  pPlanMTR = ^tPlanMTR;
  tPlanMTR = record
        lineno  : integer; // номер строки
        Code_Mtr: integer; // номенклатурный номер
        Name_Mtr: string;  // наименование материала
        ID_mtr  : integer; // ID вида материала
        quantity: real;    // Количество материала
        ID_Ord  : Integer; // ID заказа
        Num_Ord : Integer; // номер заказа
        ID_PDR  : integer; // подразделение
        Price   : real;
       nLenght  : real;
       nHeight  : real;
       nWidth   : real;
       nWeight  : real;
       ID_STRG  : integer; // заготовка
       ID_EDIZ  : integer; // единица измерения
       STRG_NAME: string;
       EDIZ_NAME: string;
       REST     : real;    // остаток материала на складах на начало периода

     end;


  TPROC_MTR_PLANForm = class(TForm)
    PanelBot: TPanel;
    PanelMain: TPanel;
    ToolBarMtFt: TToolBar;
    ButtonAddFactMt: TToolButton;
    ButtonEditFactMt: TToolButton;
    ButtonDelFactMt: TToolButton;
    ButtonUpFactMt: TToolButton;
    ButtonDownFactMt: TToolButton;
    ButtonDo: TButton;
    ButtonCancel: TButton;
    Grid_Mtr: TStringGrid;
    qSelQuery: TQuery;
    StorProc: TStoredProc;
    StorProcTable: TStoredProc;
    Panel1: TPanel;
    Label1: TLabel;
    DateEdit: TDateEdit;
    ButtonRef: TButton;
    Panel2: TPanel;
    Label4: TLabel;
    NMNTCombo: TComboEdit;
    Button1: TButton;
    qNMNTQuery: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SelectMTR(Period : integer);
    procedure Fill_Table;
    procedure ButtonDelFactMtClick(Sender: TObject);
    procedure ButtonUpFactMtClick(Sender: TObject);
    procedure ButtonDownFactMtClick(Sender: TObject);
    procedure ButtonDoClick(Sender: TObject);
    procedure ButtonRefClick(Sender: TObject);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SetQueryFilter;
    procedure Button1Click(Sender: TObject);
  private
  public
    Period    : integer;
  end;

var
  PROC_MTR_PLANForm: TPROC_MTR_PLANForm;
  lMainList : tList;

implementation
uses    OrderEditLibs,
        Base, libs,
        ParamForm;
{$R *.DFM}

procedure TPROC_MTR_PLANForm.FormCreate(Sender: TObject);
begin
 Grid_Mtr.Cells[1,0] := 'Номер';
 Grid_Mtr.Cells[2,0] := 'Ном. номер';
 Grid_Mtr.Cells[3,0] := 'Наименование';
 Grid_Mtr.Cells[5,0] := 'Количество';
 Grid_Mtr.Cells[4,0] := 'Номер заказа';
 Grid_Mtr.Cells[6,0] := 'Остаток на складах';


 lMainList := tList.create;
 DateEdit.Text := datetostr(date);

      qNMNTQuery.ParamByName('ID').asInteger  := -1;
      qNMNTQuery.ParamByName('CODE').asinteger:= -1;
      qNMNTQuery.Open;

end;

procedure TPROC_MTR_PLANForm.ButtonCancelClick(Sender: TObject);
begin
  close;

end;

procedure TPROC_MTR_PLANForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;


//********************************************
//  SelectMTR - формирование списка материалов по потребностям заказов
// Вход:
// Выход:
// Описание:
//
procedure TPROC_MTR_PLANForm.SelectMTR(Period : integer);
var
    aMaterial    : pPlanMTR;
    i : integer;

begin

  {
     Формирование запроса на нахождение потребностей в материалах по
     плановому журналу заказов

  }

  with qSelQuery do
   begin
     close;
     sql.clear;
     sql.add('select * from PROC_MTR_PLAN(:Period, :datedoc)');
     ParamByName('Period').asinteger := Period;
     ParamByName('DateDoc').asdate   := strtodate(dateEdit.text);
     open;

   end;

  qSelQuery.first;
  lMainList.Clear;
  i := 1;
  {
    Все полученные данные заносятся в список значений
  }
  while not qSelQuery.Eof do
    begin
      new(aMaterial);
      aMaterial^.lineno   := i;
      aMaterial^.Name_Mtr := qSelQuery.Fieldbyname('NAME_MTR').asstring;
      aMaterial^.ID_mtr   := qSelQuery.Fieldbyname('ID_MTR').asinteger;
      aMaterial^.Code_Mtr := qSelQuery.Fieldbyname('CODE').asinteger;
      aMaterial^.quantity := qSelQuery.Fieldbyname('Quantity').asfloat;
      aMaterial^.Num_Ord  := qSelQuery.Fieldbyname('Numdoc').asinteger;
      aMaterial^.ID_Ord   := qSelQuery.Fieldbyname('ID_ORD').asinteger;
      aMaterial^.ID_EDIZ  := qSelQuery.Fieldbyname('ID_EDIZ').asinteger;
      aMaterial^.EDIZ_NAME:= qSelQuery.Fieldbyname('EDIZ_NAME').asstring;
      aMaterial^.ID_STRG  := qSelQuery.Fieldbyname('ID_STRG').asinteger;
      aMaterial^.STRG_NAME:= qSelQuery.Fieldbyname('STRG_NAME').asstring;
      aMaterial^.nLenght  := qSelQuery.Fieldbyname('nLenght').asfloat;
      aMaterial^.nHeight  := qSelQuery.Fieldbyname('nHeight').asfloat;
      aMaterial^.nWidth   := qSelQuery.Fieldbyname('nWidth').asfloat;
      aMaterial^.nWeight  := qSelQuery.Fieldbyname('nWeight').asfloat;
      aMaterial^.Price    := qSelQuery.Fieldbyname('Price').asfloat;
      aMaterial^.ID_PDR   := qSelQuery.Fieldbyname('ID_PDR').asInteger;
      aMaterial^.REST     := qSelQuery.Fieldbyname('Rest').asfloat;

      lMainList.Add(aMaterial);
      qSelQuery.next;
    end;

    // Обновление таблицы формы
    Fill_Table;

end;

//********************************************
//   Fill_Table
// Вход:
// Выход:
// Описание:
//   Заполняет таблицу на основании списка lMainList

procedure TPROC_MTR_PLANForm.Fill_Table;
var i : integer;
    aMaterial    : pPlanMTR;

begin

   for i := 1 to 2 do
       Grid_Mtr.Rows[i].Clear;

   if lMainList <> nil then
    for i := 1 to lMainList.count do

     begin
      aMaterial := lMainList.Items[i - 1];

      aMaterial^.lineno        := i;

      Grid_Mtr.Cells[1, i] := inttostr(aMaterial^.Lineno);   // номер строки
      Grid_Mtr.Cells[2, i] := inttostr(aMaterial^.Code_Mtr); // код материала
      Grid_Mtr.Cells[3, i] := aMaterial^.Name_Mtr;           // наименование материала
      Grid_Mtr.Cells[5, i] := FormatFloat( '0.000', aMaterial^.quantity); // количество
      Grid_Mtr.Cells[4, i] := inttostr(aMaterial^.Num_Ord);  // номер заказао
      Grid_Mtr.Cells[6, i] := FormatFloat( '0.000', aMaterial^.rest); // остаток на складах
      Grid_Mtr.Cells[7, i] := inttostr(aMaterial^.Num_Ord);  // заказ

     end;

     if lMainList <> nil then
            begin
             if lMainList.count > 0 then
              Grid_Mtr.rowcount := lMainList.count + 1
             else
              Grid_Mtr.rowcount := 2;
            end
          else
             Grid_Mtr.rowcount := 2;



end;



//******************* TPROC_MTR_PLANForm.ButtonDelFactMtClick *************************
//
//Вход:
//Выход:
//Описание:
// Удалить строку
procedure TPROC_MTR_PLANForm.ButtonDelFactMtClick(Sender: TObject);
begin
  if messagedlg('Удалить материал?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

      if lMainList <> nil then
       if lMainList.Count > 0 then
        lMainList.Delete(Grid_MTR.row - 1);


    Fill_Table;

end;
//
//  Сдвиг строки таблицы вверх
//
procedure TPROC_MTR_PLANForm.ButtonUpFactMtClick(Sender: TObject);
begin

  Change_enum_list_pos(lMainList, Grid_MTR.row - 1, Grid_MTR.row);

   Fill_Table;

end;
//
//  Сдвиг строки таблицы вниз
//
procedure TPROC_MTR_PLANForm.ButtonDownFactMtClick(Sender: TObject);
begin
  Change_enum_list_pos(lMainList, Grid_MTR.row - 1, Grid_MTR.row - 2);

  Fill_Table;

end;
//******************* TPROC_MTR_PLANForm.ButtonDoClick *************************
//    ButtonDoClick
//Вход:
//Выход:
//Описание:
//  Формирование запроса на создание расходного документа со склада материалов
//
procedure TPROC_MTR_PLANForm.ButtonDoClick(Sender: TObject);
var IDDoc : integer;
    i : integer;
    aMaterial : pPlanMTR;
begin


  try

    // начало транзакции
    data.RMPBase.StartTransaction;

    // номер документа проставится автоматически
    StorProc.ParamByName('NUMDOC').asinteger := 0;
    StorProc.ParamByName('DATE_IN').asdate   := date;

    // отправитель
    if lMainList <> nil then
      begin
        aMaterial := lMainList.items[0];
        StorProc.ParamByName('ID_PDR').asinteger:= aMaterial^.ID_PDR;
      end
     else
       StorProc.ParamByName('ID_PDR').asinteger:= 1;


    // получатель
    StorProc.ParamByName('ID_CST').asinteger := 1; //qCSTQuery.fieldbyname('id').asinteger

    // инфо
    StorProc.ParamByName('INFO').value       := 'Создан автоматически на основании планового журнала';

    // выполнение запроса
    StorProc.Prepare;
    StorProc.ExecProc;

    IDDoc  := StorProc.ParamByName('IDDOC').asinteger;

    // теперь табличная часть
    // перебор всех строк плановых операций документа
    // теперь табличная часть
    // перебор всех строк плановых операций документа
    if lMainList <> nil then

     for i := 0 to lMainList.Count - 1 do

      begin
        aMaterial := lMainList.items[i];

        if aMaterial^.REST < aMaterial^.quantity then
          begin
            StorProcTable.ParamByName('ID').asinteger:= IDDoc;
            StorProcTable.ParamByName('LINENO').asinteger  := aMaterial^.lineno;
            StorProcTable.ParamByName('ID_NMNT').asinteger := aMaterial^.ID_mtr;  // ID номенклатуры
            StorProcTable.ParamByName('NUMBER').asfloat    := aMaterial^.quantity;   // количество
            StorProcTable.ParamByName('PRICE').asfloat     := aMaterial^.price;    // цена
            StorProcTable.ParamByName('ID_EDIZ').asinteger := aMaterial^.ID_EdIz;  // единица измерия
            StorProcTable.ParamByName('Leng').asfloat      := aMaterial^.nLenght;  // длина
            StorProcTable.ParamByName('hight').asfloat     := aMaterial^.nHeight;  // высота
            StorProcTable.ParamByName('width').asfloat     := aMaterial^.nWidth;   // ширина
            StorProcTable.ParamByName('weight').asfloat    := aMaterial^.nWeight;  // вес
            StorProcTable.ParamByName('ID_ORD').asinteger  := aMaterial^.ID_Ord;   // производственный заказ

            StorProcTable.Prepare;
            StorProcTable.ExecProc;
            
          end;

      end;


    // конец транзакции
    data.RMPBase.Commit;

   except
    begin
     MessageDlg('Документ не создан.', mtError, [mbOK], 0);
     Data.RMPBase.Rollback; {on failure, undo the changes};
    end;

  raise; {raise the exception to prevent a call to CommitUpdates!}

    MessageDlg('Документ не создан.', mtError, [mbOK], 0);
  end;

end;

procedure TPROC_MTR_PLANForm.ButtonRefClick(Sender: TObject);
begin

  SelectMTR(Period);

end;

procedure TPROC_MTR_PLANForm.SetQueryFilter;
begin
   if (not qNMNTQuery.Eof) and (qNMNTQuery.Fieldbyname('id').asinteger > 0) then
     begin
      qSelQuery.Filter := 'ID_MTR = ' + qNMNTQuery.Fields[0].asstring;
      qSelQuery.Filtered := true;
      SelectMTR(Period);;
     end;

end;


procedure TPROC_MTR_PLANForm.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(NMNTCombo);
  SetQueryFilter;
end;

procedure TPROC_MTR_PLANForm.NMNTComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(NMNTCombo, key, Shift) = false then
     NMNTComboButtonClick(Sender);
  SetQueryFilter;
end;

procedure TPROC_MTR_PLANForm.Button1Click(Sender: TObject);
begin
  qSelQuery.Filtered := false;
  qSelQuery.Filter   := '';
  NMNTCombo.Text := '<Объект не найден>';
  SelectMTR(Period);
      qNMNTQuery.close;
      qNMNTQuery.ParamByName('ID').asInteger  := -1;
      qNMNTQuery.ParamByName('CODE').asinteger:= -1;
      qNMNTQuery.Open;

end;

end.
