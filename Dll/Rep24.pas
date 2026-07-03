{***************************************************************
 *
 * Модуль   : Rep24
 * Описание : Oтчет по расходу основных материалов в производство по заказам
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep24;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXDBCtrl, Mask, ToolEdit, Db, DBTables, EnumForm4Sel, ExtCtrls;

type
  TReport24Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ButtonOK: TButton;
    ButtonNO: TButton;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    PdrQuery: TQuery;
    CstQuery: TQuery;
    Label6: TLabel;
    RadioGroup1: TRadioGroup;
    RMPRadioButtonPlan: TRadioButton;
    BuhRadioButton: TRadioButton;
    Query: TQuery;
    ButtonSelPer: TButton;
    RmpRadioButtonFact: TRadioButton;
    procedure ButtonNOClick(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report24Form: TReport24Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.DFM}

procedure TReport24Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport24Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport24Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport24Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport24Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;


procedure TReport24Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       n : integer;
    code : integer;
    sstr : String;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       Query.Close;

       //запрос по ремонту
       Query.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       Query.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          Query.ParamByName('ID_CST').AsInteger := CSTQuery.Fields[0].AsInteger
        else Query.ParamByName('ID_CST').AsInteger := -1;
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          Query.ParamByName('ID_PDR').AsInteger := PdrQuery.Fields[0].AsInteger
        else Query.ParamByName('ID_PDR').AsInteger := -1;

       Query.Open;

       If Query.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       if RMPRadioButtonFact.Checked then n:=127;
       if RMPRadioButtonPlan.Checked then n:=149;
       if BuhRadioButton.Checked Then n:=138;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          add(RepeatLine('-', n));
          add('');
          add(LeftLine('Дата распечатки: '+DateToStr(Date)+', время: '+TimeToStr(Time),45)+RightLine(GetSystemParams('Enterprise'),n-47));
          add('');
          add('');
          add(CentrLine('Отчет по расходу основных материалов', n));
          add(CentrLine('в производство по заказам',n));
          add('');
          add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,n));
          add('');
          add(RepeatLine('-', n));
          sstr:=' Заявка/Заказ |         Код          |Номенкла-|                                                  | Ед. |';
          if RmpRadioButtonFact.Checked then sstr:=sstr+'Израсходо-|          |';
          if RMPRadioButtonPlan.Checked then sstr:=sstr+' Норматив |';
          if RMPRadioButtonPlan.Checked or BuhRadioButton.Checked Then sstr:=sstr+' Норматив |Израсходо-|          |';
          add(sstr);
          sstr:='              |       чертежа        | турный  |              Наименование материала              |измер|';
          if RmpRadioButtonFact.Checked then sstr:=sstr+'   вано   |   Цена   |';
          if RMPRadioButtonPlan.Checked then sstr:=sstr+'по чертежу|';
          if RMPRadioButtonPlan.Checked or BuhRadioButton.Checked Then sstr:=sstr+' по плану |   вано   |   Цена   |';
          add(sstr);
          sstr:='              |                      |  номер  |                                                  |     |';
          if RmpRadioButtonFact.Checked then sstr:=sstr+'фактически|          |';
          if RMPRadioButtonPlan.Checked then sstr:=sstr+'          |';
          if RMPRadioButtonPlan.Checked or BuhRadioButton.Checked Then sstr:=sstr+'          |фактически|          |';
          add(sstr);
//          sstr:=sstr+'              |накладной|              |                                                  |';
//          if RMPRadioButtonPlan.Checked then sstr:=sstr+'            |';
//          sstr:=sstr+'            |             |';
          add(RepeatLine('-', n));

          i:=1;
//          j:=1;
          sstr:='';
          Query.First;
 //         ShowMessage('RecordCount = '+IntToStr(Query.RecordCount));

          While not Query.Eof do
          begin

//             ShowMessage(IntToStr(i));
             PrForm.ProgressBar.Position:=i*100 div Query.RecordCount;

             If ((Query.FieldByName('VID').AsInteger <> 1) and
                (BuhRadioButton.Checked = True)) or
                (RMPRadioButtonPlan.Checked = True) or
                ((Query.FieldByName('VID').AsInteger = 3) and
                (RmpRadioButtonFact.Checked = True)) Then
             begin
                   sstr:=RightLine(Query.FieldByName('NUMBER_RQST').AsString + '/' +
                                   Query.FieldByName('NUMBER_ORDER').AsString, 14)+ ' ' +
                         LeftLine(Query.FieldByName('NUMDOC').AsString, 22) + ' ' +
                         RightLine(Query.FieldByName('CODE').AsString, 9) + ' ' +
                         LeftLine(Query.FieldByName('NAME').AsString, 50)+' '+
                         LeftLine(Query.FieldByName('CODE_EDIZ').AsString, 5)+' ';

                   code:=Query.FieldByName('CODE').AsInteger;

                   //вытаскиваем материал который указан в изготовлениии данного заказа по чертежу
                   //если выводим заказ для нужд РМП
                   if RMPRadioButtonPlan.Checked Then
                   begin
                      If (Query.FieldByName('VID').AsInteger = 1) and
                         (Query.FieldByName('CODE').AsInteger = code) Then
                      begin
                           sstr:=sstr+RightLine(Query.FieldByName('NUMBER').AsString+' ', 10)+' ';
                           code:=Query.FieldByName('CODE').AsInteger;
                           Query.Next;
                           i:=i+1;
                      end
                      else
                        sstr:=sstr+RepeatLine(' ',9)+'- ';
                   end;

                   //вытаскиваем материал который указан в изготовлениии данного заказа по плану
                   if RMPRadioButtonPlan.Checked or BuhRadioButton.Checked Then
                   begin
                      If (Query.FieldByName('VID').AsInteger = 2) and
                         (Query.FieldByName('CODE').AsInteger = code) Then
                      begin
                          sstr:=sstr+RightLine(Query.FieldByName('NUMBER').AsString+' ', 10)+' ';
                          code:=Query.FieldByName('CODE').AsInteger;
                          Query.Next;
                          i:=i+1;
                      end
                       else
                           sstr:=sstr+RepeatLine(' ',9)+'- ';
                   end;        

                   //вытаскиваем материал который указан в изготовлениии данного заказа по факту
                   If (Query.FieldByName('VID').AsInteger = 3) and
                      (Query.FieldByName('CODE').AsInteger = code) Then
                   begin
                       sstr:=sstr+RightLine(Query.FieldByName('NUMBER').AsString+' ', 10)+' '+
                                  RightLine(FormatFloat( '0.00',Query.FieldByName('PRICE').AsFloat), 10);
                       code:=Query.FieldByName('CODE').AsInteger;
                       Query.Next;
                       i:=i+1;
                   end
                    else
                         sstr:=sstr+RepeatLine(' ',9)+'- ';

                   add(sstr);
             end
              else
              begin             //Номенклатура иногда испльзуется только по чертежу,
                  Query.Next;   //а так как для вывода для бухгалтерии запрос
                  i:=i+1;       //про чертеж не рассматривается, то нужно самому
//                  j:=i;         //перемещаться к следующей записи без вывода на экран
              end;
          end;
          add(RepeatLine('-', n));
          add('');
          add('');
          add('');
          add('                   Начальник Цеха _______________________   _________________________');
          add('                                          подпись              расшифровка подписи   ');
          add('');
          add('');
          add('');
          add('   Ведущий экономист по планиров. _______________________   _________________________');
          add('                                          подпись              расшифровка подписи   ');
       end;
       PrForm.Destroy;

       Form.Caption := 'Отчет по расходу основных материалов в производство по заказам';
       Form.Editor.show;
       Form.show;

end;

procedure TReport24Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport24Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport24Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
