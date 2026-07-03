unit Rep60;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EnumForm4Sel, DB, DBTables, ToolEdit, Mask;

type
  TReport60Form = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    Label10: TLabel;
    WrkrCombo: TComboEdit;
    WrkrQuery: TQuery;
    Label4: TLabel;
    PdrQuery: TQuery;
    PdrCombo: TComboEdit;
    MainQuery: TQuery;
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure WrkrComboButtonClick(Sender: TObject);
    procedure WrkrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report60Form: TReport60Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces;

{$R *.DFM}

procedure TReport60Form.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TReport60Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
end;

procedure TReport60Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport60Form.WrkrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, WrkrQuery, WrkrCombo, 'select id, code, name from spr_wrkr',
                        'Справочник: Работники (Выбор)', 0);
end;

procedure TReport60Form.WrkrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(WrkrQuery, WrkrCombo, key, Shift, 1) = false then
    WrkrComboButtonClick(Sender);
end;

procedure TReport60Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport60Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport60Form.Button1Click(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i, m : Integer;
       Name_parent : String;
       Code_Wrkr   : Integer;
       All_Num : Real; //общее количество сделанной номенклатуры
       All_One : Real; //общее количество трудоемкости на еденицу
       All_All : Real; //общее количество общей трудоемкости
       All_Parent : Real; //общее количество общей трудоемкости на производство
begin
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       If (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Дата не определена!', mtWarning , [mbYes], 0);
          Exit;
       end;

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select NUM_RQST, NUM_ORDER, NAME_CHRT, NAME_VOP, NUMBER_F, ONE_TIME, ALL_TIME, NAME_CST, NAME_PARENTID, DATE_BEG,');
       MainQuery.SQL.Add('CODE_WRKR, NAME_WRKR, CODE_PDR, NAME_PDR');
       MainQuery.SQL.Add('From REPORT_60_PROCEDURE(:DATE_END, :ID_WRKR, :ID_PDR)');
       MainQuery.SQL.Add('Order by 13, 11, 9, 8, 10, 3, 1, 2');

       MainQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       If (WrkrCombo.Text = '') or (WrkrCombo.Text = '<Объект не найден>') or (not WrkrQuery.active) Then
            MainQuery.ParamByName('ID_Wrkr').AsInteger := -1
        else
               MainQuery.ParamByName('ID_Wrkr').AsInteger := WrkrQuery.Fields[0].AsInteger;

       If (PdrCombo.Text = '') or (PdrCombo.Text = '<Объект не найден>') or (not PdrQuery.active) Then
            MainQuery.ParamByName('ID_Pdr').AsInteger := -1
        else
               MainQuery.ParamByName('ID_Pdr').AsInteger := PdrQuery.Fields[0].AsInteger;

       MainQuery.Open;
       MainQuery.First;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;
          m:=175;
          i := 1;

          add( RepeatLine('-', m));
          add( LeftLine('Дата распечатки: '+DateToStr(Date)+', время: '+TimeToStr(Time),m));

          While (not MainQuery.Eof) do
          begin

              Code_Wrkr := MainQuery.FieldByName('CODE_WRKR').AsInteger;

              add('');
              add('');
              add('');
              If (WrkrQuery.active) and  (WrkrCombo.Text <> '') and (WrkrCombo.Text <> '<Объект не найден>') Then
                  add(CentrLine('Заказы в работе у '+WrkrCombo.Text+' таб. №'+WrkrQuery.Fields[2].AsString, m))
               else
                begin
                      add(CentrLine('Заказы в работе ('+MainQuery.FieldByName('CODE_PDR').AsString+') '+MainQuery.FieldByName('NAME_PDR').AsString, m));
                      add(CentrLine('станочник ' + MainQuery.FieldByName('NAME_WRKR').AsString + ' таб. №' + MainQuery.FieldByName('CODE_WRKR').AsString, m));
                end;

              add(CentrLine('НА '+EndDateEdit.Text , m));

              add(RepeatLine('-', m));
              add(' № п/п | №Заявка/№Заказ |          Заказчик          | Дата выдачи |          Наименование заказа           |    Наименование операции    |Количество|Трудоемкость|   Общая    |');
              add('       |                |                            |   в работу  |                                        |                             |          | на еденицу |трудоемкость|');
              add(RepeatLine('-', m));

              Name_parent := MainQuery.FieldByName('NAME_PARENTID').AsString;

              add(LeftLine(MainQuery.FieldByName('NAME_PARENTID').AsString+':', m)+'|');

              While (Code_WRKR = MainQuery.FieldByName('CODE_WRKR').AsInteger) and
                    (not MainQuery.Eof) do
              begin

                 PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

                 If (Name_parent <> MainQuery.FieldByName('NAME_PARENTID').AsString) Then
                 begin
                    add(RepeatLine('-', m));
                    add(RepeatLine(' ', m-13)+' '+
                        RightLine(FormatFloat('0.00', All_Parent), 12));
                    add(RepeatLine('-', m));
                    add(LeftLine(MainQuery.FieldByName('NAME_PARENTID').AsString+':', m)+'|');
                    Name_parent := MainQuery.FieldByName('NAME_PARENTID').AsString;
                    All_Parent := 0;
                 end;

                 add(RightLine(IntToStr(i), 7)+'|'+
                    RightLine(MainQuery.FieldByName('NUM_RQST').AsString+'/'+
                              MainQuery.FieldByName('NUM_ORDER').AsString, 16)+'|'+
                    LeftLine(MainQuery.FieldByName('NAME_CST').AsString, 28)+'|'+
                    CentrLine(MainQuery.FieldByName('DATE_BEG').AsString, 13)+'|'+
                    LeftLine(MainQuery.FieldByName('NAME_CHRT').AsString, 40)+'|'+
                    LeftLine(MainQuery.FieldByName('NAME_VOP').AsString, 29)+'|'+
                    RightLine(MainQuery.FieldByName('NUMBER_F').AsString, 10)+'|'+
                    RightLine(MainQuery.FieldByName('ONE_TIME').AsString, 12)+'|'+
                    RightLine(MainQuery.FieldByName('ALL_TIME').AsString, 12)+'|');


                 All_Num := All_Num + MainQuery.FieldByName('NUMBER_F').AsFloat;
                 All_One := All_One + MainQuery.FieldByName('ONE_TIME').AsFloat;
                 All_All := All_All + MainQuery.FieldByName('ALL_TIME').AsFloat;
                 All_Parent := All_Parent + MainQuery.FieldByName('ALL_TIME').AsFloat;

                 i:=i+1;
                 MainQuery.Next;
              end;

              add(RepeatLine('-', m));
              add(RepeatLine(' ', m-13)+' '+
                  RightLine(FormatFloat('0.00', All_Parent), 12));
              add(RepeatLine('-', m));
              add(RepeatLine(' ', m));

              add(RepeatLine(' ', m-37)+' '+
                  RightLine(FormatFloat('0.000', All_Num), 10)+' '+
                  RightLine(FormatFloat('0.00', All_One), 12)+' '+
                  RightLine(FormatFloat('0.00', All_All), 12));

              add('');
              add('');
              add('');
              add('    Мастер смены __________________________________');
          end;
       end;
       PrForm.Destroy;

       Form.Caption := 'Загрузка станочника';
       Form.Editor.show;
       Form.show;

end;

end.
