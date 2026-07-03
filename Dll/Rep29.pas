{***************************************************************
 *
 * Модуль   : Rep29
 * Описание : Инвентаризационная опись незавершенного производства
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep29;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, ToolEdit, StdCtrls, Mask, EnumForm4Sel, ExtCtrls;

type
  TReport29Form = class(TForm)
    MainQuery: TQuery;
    PdrQuery: TQuery;
    CstQuery: TQuery;
    Panel1: TPanel;
    Label6: TLabel;
    Label1: TLabel;
    EndDateEdit: TDateEdit;
    Label2: TLabel;
    CstCombo: TComboEdit;
    Label4: TLabel;
    Label5: TLabel;
    PdrCombo: TComboEdit;
    Panel2: TPanel;
    Label3: TLabel;
    OrderEdit: TEdit;
    Label7: TLabel;
    OrderDateEdit: TDateEdit;
    Panel3: TPanel;
    Label8: TLabel;
    ResponsibleCombo2: TComboEdit;
    ResponsibleCombo1: TComboEdit;
    Panel4: TPanel;
    Label9: TLabel;
    presidentCombo: TComboEdit;
    Label10: TLabel;
    MemberCombo1: TComboEdit;
    MemberCombo2: TComboEdit;
    MemberCombo3: TComboEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Panel5: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Label14: TLabel;
    Label15: TLabel;
    StockmanCombo1: TComboEdit;
    Label16: TLabel;
    StockmanCombo2: TComboEdit;
    Label17: TLabel;
    StockmanCombo3: TComboEdit;
    Panel6: TPanel;
    ButtonOK: TButton;
    ButtonNO: TButton;
    Splitter5: TSplitter;
    WrkrQuery: TQuery;
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonNOClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ResponsibleCombo1ButtonClick(Sender: TObject);
    procedure ResponsibleCombo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ResponsibleCombo2ButtonClick(Sender: TObject);
    procedure ResponsibleCombo2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure presidentComboButtonClick(Sender: TObject);
    procedure presidentComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemberCombo1ButtonClick(Sender: TObject);
    procedure MemberCombo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemberCombo2ButtonClick(Sender: TObject);
    procedure MemberCombo2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MemberCombo3ButtonClick(Sender: TObject);
    procedure MemberCombo3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StockmanCombo1ButtonClick(Sender: TObject);
    procedure StockmanCombo1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StockmanCombo2ButtonClick(Sender: TObject);
    procedure StockmanCombo2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StockmanCombo3ButtonClick(Sender: TObject);
    procedure StockmanCombo3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report29Form: TReport29Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces;


{$R *.DFM}

procedure TReport29Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);
end;

procedure TReport29Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport29Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport29Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport29Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  EndDateEdit.text := datetostr(now);
  OrderDateEdit.Text := datetostr(now);
end;

procedure TReport29Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : integer;
       total_fnumber : real;
//       total_plan : real;
       total_fakt : real;
  AYear, AMonth, ADay: Word;
  LastDate: String;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       If (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Дата не определена!', mtWarning , [mbYes], 0);
          Exit;
       end;

       total_fnumber := 0;
//       total_plan := 0;
       total_fakt := 0;

       MainQuery.Close;

       MainQuery.ParamByName('date_out').AsString := EndDateEdit.Text;

       If PDRQuery.Active Then
       begin
           MainQuery.ParamByName('id_pdr').AsInteger:= PdrQuery.FieldByName('ID').AsInteger;
       end
        else MainQuery.ParamByName('id_pdr').AsInteger:=0;

       If CstQuery.Active Then
       begin
           MainQuery.ParamByName('id_cst').AsInteger:= CstQuery.FieldByName('ID').AsInteger;
       end
        else MainQuery.ParamByName('id_cst').AsInteger:=0;

       MainQuery.Open;

       i:=1;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;
          add( RepeatLine(' ', 80) + 'Форма № ИНВ' );
          add( RepeatLine(' ', 80) + 'Утверждена Приказом об учетной политике');
          add( RepeatLine(' ', 80) + 'по ' + GetSystemParams('Enterprise'));
          add( RepeatLine(' ', 80) + 'от '+ DateToStr(OrderDateEdit.Date)+' №'+OrderEdit.Text);  //13
          add( '');
          add( RepeatLine(' ', 100) + ' __________________ ');
          add( RepeatLine(' ', 100) + '|       Код        |');
          add( CentrLine(GetSystemParams('Enterprise'), 100) + '|__________________|');
          add( RepeatLine('_', 100) + '|__________________|');
          add( CentrLine('(организация)', 100) + '|__________________|');
          add( CentrLine(GetSystemParams('Service'), 100) +'|                  |');
          add( RepeatLine('_', 100) + '|__________________|');
          add( CentrLine('(структурное подразделение)', 83)+'Вид деятельности '+'|                  |');
          add( RepeatLine(' ', 100) +'|__________________|');
          add( 'Основание для проведения инвентаризации: '+
                 CentrLine('приказ, постановление, распоряжение', 53)+
                 'номер '+ '|        36        |');
          add( RepeatLine(' ', 41)+RepeatLine('_', 59) + '|__________________|');
          add( RepeatLine(' ', 47) + CentrLine('(ненужное зачеркнуть)', 48)+'дата '+'|                  |');
          add( RepeatLine(' ', 100) + '|__________________|');

          DecodeDate(StrToDate(EndDateEdit.Text), AYear, AMonth, ADay);
          If (AMonth+1 > 12) Then
          begin
             AMonth := 1;
             AYear  := AYear + 1;
          end
           else Amonth := Amonth + 1;
          LastDate := DateToStr(EncodeDate(AYear,AMonth, 1)-1);
          add( RepeatLine(' ', 73) + 'Дата начала инвентаризации ' + '|'+CentrLine(LastDate, 18)+'|');
          add( RepeatLine(' ', 100) + '|__________________|');
          add( RepeatLine(' ', 70) + 'Дата окончания инвентаризации ' + '|'+CentrLine(LastDate, 18)+'|');
          add( RepeatLine(' ', 100) + '|__________________|');
          add( RepeatLine(' ', 87) +'Вид операции ' +  '|__________________|');
          add( '');
          add( RepeatLine(' ', 80) +' ___________________________________');
          add( RepeatLine(' ', 80) +'|  Номер документа |Дата составления|');
          add( RepeatLine(' ', 80) +'|__________________|________________|');
          add( RepeatLine(' ', 54) + ' ИНВЕНТАРИЗАЦИОННАЯ ОПИСЬ '+'|__________________|________________|');
          add( RepeatLine(' ', 54) + 'незавершенного производства');
          add( '');
          add( RepeatLine('_', 119)+',');
          add( CentrLine('(вид товароматериальных ценностей)', 120));
          add( '');
          add( 'находящихся  '+RepeatLine('_', 107));
          add( CentrLine('(в собственности организации, полученные для переработки)', 120));
          add( '');
          add( CentrLine('РАСПИСКА',120));
          add( '');
          add( 'К началу проведения инвентаризации все расходные и приходные документы на товароматериальные ценности сданы в бухгалтерию');
          add( 'и все товароматериальные ценности, поступившие на мою (нашу) ответственность, оприходованы, а выбывшие списаны в расход.');
          add( '');
          add( 'Материально ответственное(ые) ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(ResponsibleCombo1.Text))) div 2)+Trim(ResponsibleCombo1.Text)+
              RepeatLine('_', (40-Length(Trim(ResponsibleCombo1.Text)))-(40 - Length(Trim(ResponsibleCombo1.Text))) div 2));
          add( '                                      (должность)                     (подпись)                      (расшифровка подписи)    ');
          add( '');
          add( '                              ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(ResponsibleCombo2.Text))) div 2)+Trim(ResponsibleCombo2.Text)+
              RepeatLine('_', (40-Length(Trim(ResponsibleCombo2.Text)))-(40 - Length(Trim(ResponsibleCombo2.Text))) div 2));
          add( '                                      (должность)                     (подпись)                      (расшифровка подписи)    ');
          add( '');
          add( 'Произведено снятие фактических остатков ценностей по состоянию на "_______"  ____________________  ________ г.');
          add( '');
          add( '');
          add( RepeatLine('-', 120));
          add( ' №  |               |          | Счет, |Номенклатурный|  наименование,  | Единица |Фактическое|  Себестоимость (руб.)  |');
          add( 'п.п.|№заявки/№заказа|   МВЗ    |субсчет|     номер    |  характеристика |измерения|количество |-----------|------------|');
          add( '    |               |          |       |              |(вид,сорт,группа)|         |           |   План    |    Факт    |');
          add( RepeatLine('-', 120));

          While not MainQuery.Eof do
          begin

              PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

              add( RightLine(IntToStr(i), 4) + ' '+
                   RightLine(MainQuery.FieldByName('NUMBER_RQST').AsString + '/' +
                             MainQuery.FieldByName('NUMBER_ORDER').AsString, 15)+ ' ' +
                   RightLine(MainQuery.FieldByName('CODE_PDR').AsString,10) + ' ' +
                   RepeatLine(' ', 7) + ' ' +
                   RightLine(MainQuery.FieldByName('CODE_NMNT').AsString, 14) + ' '+
                   LeftLine(MainQuery.FieldByName('CHRT_VID_CHAR').AsString, 17) + ' ' +
                   CentrLine(MainQuery.FieldByName('CODE_EDIZ').AsString, 9) + ' '+
                   RightLine(FormatFloat('0.000',MainQuery.FieldByName('FNUMBER').AsFloat), 11) + ' '+
//                   RightLine(FormatFloat('0.00',MainQuery.FieldByName('PLAN_TOTAL_PRICE').AsFloat), 11));// + ' '+
                   RightLine(FormatFloat('0.00',MainQuery.FieldByName('FAKT_TOTAL_PRICE').AsFloat), 12));

              total_fnumber := total_fnumber + MainQuery.FieldByName('FNUMBER').AsFloat;
//              total_plan := total_plan + MainQuery.FieldByName('PLAN_TOTAL_PRICE').AsFloat;
              total_fakt := total_fakt + MainQuery.FieldByName('FAKT_TOTAL_PRICE').AsFloat;

//              total_plan:=total_plan*100;
//              total_plan:=Round(total_plan)/100;
              total_fakt:=total_fakt*100;
              total_fakt:=Round(total_fakt)/100;
              MainQuery.Next;
              i:=i+1;
          end;

          add( RepeatLine('-', 120));
          add( RepeatLine(' ', 76) + 'Итого: '+
                RightLine(FormatFloat('0.000', total_fnumber), 11)+' '+
 //               RightLine(FormatFloat('0.00', total_plan), 11));//+' '+
                RightLine(FormatFloat('0.00', total_fakt), 12));
          add( '');
          add( '');
          add( '    Итого по описи:');
          add( '                    a) количество порядковых номеров      ' + RepeatLine('_', 62));
          add( RepeatLine(' ', 58) + CentrLine('(прописью)', 62));
          add( '');
          add( '                    б) общее количество единиц фактически ' + RepeatLine('_', 62));
          add( RepeatLine(' ', 58) + CentrLine('(прописью)', 62));
          add( '');
          add( '                    в) на сумму фактически                ' + RepeatLine('_', 62));
          add( RepeatLine(' ', 58) + CentrLine('(прописью)', 62));
          add( '');
          add( RepeatLine(' ', 20) + RepeatLine('_', 85)+'руб.'+RepeatLine('_', 7)+'коп.');
          add( '');
          add( 'Все цены, подсчеты итогов по строкам, страницам и в целом ');
          add( 'по инвентаризационной описи товарно-материальных ценностей проверены.');
          add( '');
          add( '      Председатель комиссии   ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(presidentCombo.Text))) div 2)+Trim(presidentCombo.Text)+
              RepeatLine('_', (40-Length(Trim(presidentCombo.Text)))-(40 - Length(Trim(presidentCombo.Text))) div 2));
          add( '                                      (должность)                     (подпись)                      (расшифровка подписи)    ');
          add( '');
          add( '             Члены комиссии   ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(MemberCombo1.Text))) div 2)+Trim(MemberCombo1.Text)+
              RepeatLine('_', (40-Length(Trim(MemberCombo1.Text)))-(40 - Length(Trim(MemberCombo1.Text))) div 2));
          add( '                                      (должность)                     (подпись)                      (расшифровка подписи)    ');
          add( '');
          add( '                              ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(MemberCombo2.Text))) div 2)+Trim(MemberCombo2.Text)+
              RepeatLine('_', (40-Length(Trim(MemberCombo2.Text)))-(40 - Length(Trim(MemberCombo2.Text))) div 2));
          add( '                                      (должность)                     (подпись)                     (расшифровка подписи)    ');
          add( '');
          add( '                              ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(MemberCombo3.Text))) div 2)+Trim(MemberCombo3.Text)+
              RepeatLine('_', (40-Length(Trim(MemberCombo3.Text)))-(40 - Length(Trim(MemberCombo3.Text))) div 2));
          add( '                                      (должность)                     (подпись)                      (расшифровка подписи)    ');
          add( '');
          add( 'Все товароматериальные ценности, поименованные в настоящей инвентаризационной описи с № ____________ по № _____________,');
          add( 'комиссией проверены в натуре в моем (нашем) присутствии и внесены в опись, в связи с чем претензий к инвентаризационной ');
          add( 'комиссии не имею (не имеем). Товарно-материальные ценности, перечисленные в описи, находятся на моем (нашем) ответственном');
          add( 'хранении.');
          add( '');
          add( 'Лицо(а), ответственное(ые) за сохранность товарно-материальных ценностей:');
          add( '');
          add( '                              ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(StockmanCombo1.Text))) div 2)+Trim(StockmanCombo1.Text)+
              RepeatLine('_', (40-Length(Trim(StockmanCombo1.Text)))-(40 - Length(Trim(StockmanCombo1.Text))) div 2));
          add( '                                      (должность)                     (подпись)                      (расшифровка подписи)    ');
          add( '');
          add( '                              ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(StockmanCombo2.Text))) div 2)+Trim(StockmanCombo2.Text)+
              RepeatLine('_', (40-Length(Trim(StockmanCombo2.Text)))-(40 - Length(Trim(StockmanCombo2.Text))) div 2));
          add( '                                      (должность)                     (подпись)                      (расшифровка подписи)    ');
          add( '');
          add( '                              ____________________________   ____________________________   '+
              RepeatLine('_', (40 - Length(Trim(StockmanCombo3.Text))) div 2)+Trim(StockmanCombo3.Text)+
              RepeatLine('_', (40-Length(Trim(StockmanCombo3.Text)))-(40 - Length(Trim(StockmanCombo3.Text))) div 2));
          add( '                                      (должность)                     (подпись)                      (расшифровка подписи)    ');
          add( '');
          add( '                              "_____" _________________ ______ г.');
          add( '');
          add( 'Указанные в настоящей описи');
          add( 'данные и расчеты проверил');
          add( '                              ____________________________   ____________________________   ____________________________');
          add( '                                      (должность)                     (подпись)                (расшифровка подписи)    ');
          add( '');
          add( '                              "_____" _________________ ______ г.');
       end;
       PrForm.Destroy;

       Form.Caption := 'Инвентаризационная ведомость незавершенного производства';
       Form.Editor.show;
       Form.show;

end;

procedure TReport29Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport29Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport29Form.ResponsibleCombo1ButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, ResponsibleCombo1, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.ResponsibleCombo1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, ResponsibleCombo1, key, Shift, 1) = false then
    ResponsibleCombo1ButtonClick(Sender);
end;

procedure TReport29Form.ResponsibleCombo2ButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, ResponsibleCombo2, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.ResponsibleCombo2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, ResponsibleCombo2, key, Shift, 1) = false then
    ResponsibleCombo2ButtonClick(Sender);
end;

procedure TReport29Form.presidentComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, PresidentCombo, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.presidentComboKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, presidentCombo, key, Shift, 1) = false then
    presidentComboButtonClick(Sender);
end;

procedure TReport29Form.MemberCombo1ButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, MemberCombo1, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.MemberCombo1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, MemberCombo1, key, Shift, 1) = false then
    MemberCombo1ButtonClick(Sender);
end;

procedure TReport29Form.MemberCombo2ButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, MemberCombo2, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.MemberCombo2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, MemberCombo2, key, Shift, 1) = false then
    MemberCombo2ButtonClick(Sender);
end;

procedure TReport29Form.MemberCombo3ButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, MemberCombo3, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.MemberCombo3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, MemberCombo3, key, Shift, 1) = false then
    MemberCombo3ButtonClick(Sender);
end;

procedure TReport29Form.StockmanCombo1ButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, StockmanCombo1, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.StockmanCombo1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, StockmanCombo1, key, Shift, 1) = false then
    StockmanCombo1ButtonClick(Sender);
end;

procedure TReport29Form.StockmanCombo2ButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, StockmanCombo2, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.StockmanCombo2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, StockmanCombo2, key, Shift, 1) = false then
    StockmanCombo2ButtonClick(Sender);
end;

procedure TReport29Form.StockmanCombo3ButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, StockmanCombo3, 'select id, code, name from spr_wrkr',
                        'Справочник: Персонал РМП (Выбор)', 0);
end;

procedure TReport29Form.StockmanCombo3KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, StockmanCombo3, key, Shift, 1) = false then
    StockmanCombo3ButtonClick(Sender);
end;

end.
