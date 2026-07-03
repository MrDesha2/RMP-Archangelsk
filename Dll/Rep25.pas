{***************************************************************
 *
 * Модуль   : Rep25
 * Описание : Отчет по плановой калькуляции заказов
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep25;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXDBCtrl, Mask, ToolEdit, Db, DBTables, EnumForm4Sel, rxStrUtils;

type
  TReport25Form = class(TForm)
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ButtonOK: TButton;
    ButtonNO: TButton;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    PdrQuery: TQuery;
    CstQuery: TQuery;
    MainQuery: TQuery;
    CalcOperQuery: TQuery;
    CalcPMatrQuery: TQuery;
    ItemQuery: TQuery;
    Label3: TLabel;
    Label6: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    Label2: TLabel;
    Label7: TLabel;
    RqstEdit: TEdit;
    OrderEdit: TEdit;
    LabelButton: TButton;
    LabelQuery: TQuery;
    SizeQuery: TQuery;
    LitQuery: TQuery;
    ButtonSelPer: TButton;
    procedure ButtonNOClick(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabelButtonClick(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report25Form: TReport25Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.DFM}

procedure TReport25Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport25Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport25Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport25Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport25Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;


procedure TReport25Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : Integer;
       j : Integer;  //кол-во выведенных строк на листе
  Tmpstr : String;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);
       ESC_Key := False;

       If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       MainQuery.Close;

       MainQuery.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
       MainQuery.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
       begin
          MainQuery.ParamByName('cst').AsInteger := CSTQuery.Fields[0].AsInteger;
       end
        else MainQuery.ParamByName('cst').AsInteger:=0;

       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
       begin
          MainQuery.ParamByName('pdr').AsInteger := PdrQuery.Fields[0].AsInteger;
       end
        else MainQuery.ParamByName('pdr').AsInteger:=0;

       //Параметр = Заявке
       if (RqstEdit.Text <> '')  then
       begin
          try
             MainQuery.ParamByName('rqst').AsInteger := StrToInt(RqstEdit.Text);
          except
                 MessageDlg('Ошибка номера заявки!', mtWarning , [mbYes], 0);
                 Exit;
          end

       end
        else MainQuery.ParamByName('rqst').AsInteger:=0;

       //Параметр = Заказу
       if (OrderEdit.Text <> '')  then
       begin
          try
             MainQuery.ParamByName('order').AsInteger := StrToInt(OrderEdit.Text);
          except
                 MessageDlg('Ошибка номера заказа!', mtWarning , [mbYes], 0);
                 Exit;
          end

       end
        else MainQuery.ParamByName('order').AsInteger:=0;

       MainQuery.Open;

       If MainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       i := 1;
       j := 0;
       PrForm.Show;
       Form.Editor.Visible := False;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          //цикл по количеству заказов
          While i-1< MainQuery.RecordCount do
          begin

            tmpstr:='';  //tmpstr это не tmpPrice :)
            add('');
//            add(RepeatLine('-', 88));
            add('');

            PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

            add(CentrLine('Плановая калькуляция заказа',88));
            add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,88));
            add('');
            add(RepeatLine('-', 88));
            add('');
            add(LeftLine('Заказчик:     '+MainQuery.FieldByName('NAME_CST').AsString, 50));
            add(LeftLine('Чертеж:       '+MainQuery.FieldByName('NAME_CHRT').AsString, 20));
            add(LeftLine('Номенклатура: '+MainQuery.FieldByName('NAME_NMNT').AsString, 50));
            add(LeftLine('Материалы:                                         Цена', 70));

            CalcPMatrQuery.Close;
            CalcPMatrQuery.ParamByName('number').AsInteger := MainQuery.FieldByName('NUMBER_ORDER').AsInteger;
            CalcPMatrQuery.Open;

            While not CalcPMatrQuery.Eof do
            begin
               If CalcPMatrQuery.FieldByName('PRICE_MTRP').AsFloat > 0 Then
                   add(LeftLine(CalcPMatrQuery.FieldByName('NAME').AsString, 50)+
                       LeftLine(FormatFloat('0.00',CalcPMatrQuery.FieldByName('PRICE_MTRP').AsFloat), 10))
                else //Если нет цены по плану берем цену из справочника номенклатуры
                    add(LeftLine(CalcPMatrQuery.FieldByName('NAME').AsString, 50)+
                        LeftLine(FormatFloat('0.00',CalcPMatrQuery.FieldByName('PRICE_SPR').AsFloat), 10));

               CalcPMatrQuery.Next;
            end;   

            add('');
            add(RepeatLine('-', 88));
            add('                   |                         |                 |Кол-во |               |');
            add(' № Заявки/№ Заказа |      Статья затрат      |Плановая величина|деталей|Общая стоимость|');
            add('                   |                         |                 |       |               |');
            add(RepeatLine('-', 88));

            add(RightLine(MainQuery.FieldByName('NUMBER_RQST').AsString + '/' +
                          MainQuery.FieldByName('NUMBER_ORDER').AsString, 19)+ ' '+
                          LeftLine('Материалы',25)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('NMNT_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('NMNT_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));
            add(RepeatLine(' ',20)+LeftLine('заработная плата',25)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('OPER_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('OPER_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            add(RepeatLine(' ',20)+LeftLine('Отчисления на соц.нужды',25)+' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('SOCSTR_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('SOCSTR_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            add(RepeatLine(' ',20)+LeftLine('Накладные расходы',25)+' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('OBRASH_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('OBRASH_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            //Цеховая себестоимость
            add(RepeatLine(' ',20)+LeftLine('Цеховая себестоимость',25)+' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('CEHSEB_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('CEHSEB_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            //Общезаводские расходы
            add(RepeatLine(' ',20)+LeftLine('Общезаводские расходы',25)+' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('OBZAV_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('OBZAV_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            //Производственные расходы
            add(RepeatLine(' ',20)+LeftLine('Производственная себестоимость',25)+' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('PRRASH_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('PRRASH_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            //Плановые накопления
            add(RepeatLine(' ',20)+LeftLine('Плановые накопления',25)+' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('PLANNAK_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('PLANNAK_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            //Полная себестоимость
            add(RepeatLine(' ',20)+LeftLine('Плановая себестоимость',25)+ ' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('ALLSEB_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('ALLSEB_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            //НДС
            add(RepeatLine(' ',20)+LeftLine('НДС',25)+' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('NDS_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('NDS_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            //Всего
            add(RepeatLine(' ',20)+LeftLine('Всего',25)+  ' '+
                              RightLine(FormatFloat('0.00',MainQuery.FieldByName('PLAN_TOTAL_PRICE').AsFloat),17)+' '+
                          RightLine(FormatFloat('0.000',MainQuery.FieldByName('PNUMBER').AsFloat),7)+' '+
                          RightLine(FormatFloat('0.00',MainQuery.FieldByName('PLAN_TOTAL_PRICE').AsFloat*
                                                       MainQuery.FieldByName('PNUMBER').AsFloat),15));

            add(RepeatLine('-', 88));
            add('');
            add('');
            add('');
            add(' Экономист ___________________________________');
            MainQuery.Next;
            i:=i+1;
            add('');
            j:=j+1;

            //Смотрим событие
            Application.ProcessMessages;
            If ESC_Key = True Then
            begin
                break;
            end;

            If j=3 Then
            begin
               add(StrToOem(CHR(12)));
               j:=0;
            end;
          end;

       end;
       Form.Editor.Visible := True;
       PrForm.Destroy;

       Form.Caption := 'Отчет по плановой калькуляции заказов';
       Form.Editor.show;
       Form.show;

end;

procedure TReport25Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now-30);
  EndDateEdit.text := datetostr(now);
  ESC_Key := False;

end;

procedure TReport25Form.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        If (Key = VK_ESCAPE) Then
           ESC_Key := True;
end;

procedure TReport25Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport25Form.LabelButtonClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : integer;
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       PrForm.Show;
       Form.Editor.Visible := False;

       LabelQuery.Close;
       LabelQuery.SQL.Clear;
       LabelQuery.SQL.Add('Select a.NUMBER, b.NUMBER, c.code, d.code || d.name as cst_name, ');
       LabelQuery.SQL.Add('       c.name, e.code, a.number_f, f.code || f.name as pdr_name, ');
       LabelQuery.SQL.Add('       a.id, f.id ');
       LabelQuery.SQL.Add('From Dh_Rqst b, Spr_cst d, Spr_Chrt e, Spr_Pdr f, '); //DH_PR g, DT_PR h,
       LabelQuery.SQL.Add('     Dh_Order a, Spr_Nmnt c');
       LabelQuery.SQL.Add('Where ');

       If (BegDateEdit.Text <> '  .  .  ') Then
       begin
           LabelQuery.SQL.Add('a.date_in >= :begdate and');
           LabelQuery.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
       end;


       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
       begin
          LabelQuery.SQL.Add('d.id = :cst and ');
          LabelQuery.ParamByName('cst').AsInteger := CSTQuery.Fields[0].AsInteger;
       end;

       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
       begin
          LabelQuery.SQL.Add('f.id = :pdr and ');
          LabelQuery.ParamByName('pdr').AsInteger := PdrQuery.Fields[0].AsInteger;
       end;

       //Параметр = Заявке
       if (RqstEdit.Text <> '')  then
       begin
          try
             LabelQuery.SQL.Add('b.number = :rqst and ');
             LabelQuery.ParamByName('rqst').AsInteger := StrToInt(RqstEdit.Text);
          except
                 MessageDlg('Ошибка номера заявки!', mtWarning , [mbYes], 0);
                 Exit;
          end

       end;

       //Параметр = Заказу
       if (OrderEdit.Text <> '')  then
       begin
          try
             LabelQuery.SQL.Add('a.number = :order and ');
             LabelQuery.ParamByName('order').AsInteger := StrToInt(OrderEdit.Text);
          except
                 MessageDlg('Ошибка номера заказа!', mtWarning , [mbYes], 0);
                 Exit;
          end

       end;

       LabelQuery.SQL.Add('a.id_nmnt = c.id and');
       LabelQuery.SQL.Add('a.id_rqst = b.id and b.id_cst = d.id and  ');
       LabelQuery.SQL.Add('a.id_pdr = f.id and e.id = a.id_chrt and e.vid_chrt <> 1 ');
       LabelQuery.SQL.Add('Order by 2, 1, 4, 8');
       LabelQuery.Open;

       i := 1;
       PrForm.Show;
       Form.Editor.Visible := False;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          add(RepeatLine('-', 80));
          //цикл по количеству заказов
          While i-1< LabelQuery.RecordCount do
          begin

             PrForm.ProgressBar.Position:=i*100 div LabelQuery.RecordCount;

             add(' ');
             add(RepeatLine('-', 80));
             add(':'+CentrLine('Я Р Л Ы К', 78)+':');
             add(RepeatLine('-', 80));
             add(':'+LeftLine('Заявка/Заказ', 26)+': '+
                     LeftLine(LabelQuery.FieldByName('Number_1').AsString+'/'+
                     LabelQuery.FieldByName('Number').AsString, 50)+':');
             add(':'+LeftLine('Номенклатурный №', 26)+': '+
                     LeftLine(LabelQuery.FieldByName('code').AsString, 50)+':');
             add(':'+LeftLine('Заказчик', 26)+': '+
                     LeftLine(LabelQuery.FieldByName('cst_name').AsString, 50)+':');
             add(':'+LeftLine('Наименование номенклатуры', 26)+': '+
                     LeftLine(LabelQuery.FieldByName('name').AsString, 50)+':');
             add(':'+LeftLine('Номер чертежа', 26)+': '+
                     LeftLine(LabelQuery.FieldByName('code_1').AsString, 50)+':');
             add(':'+LeftLine('Количество', 26)+': '+
                     LeftLine(LabelQuery.FieldByName('number_f').AsString, 50)+':');
             add(':'+LeftLine('Размеры по чертежу', 26)+': '+ RepeatLine(' ', 50)+':');

             SizeQuery.Close;
             SizeQuery.ParamByName('id').AsInteger := LabelQuery.FieldByName('id').AsInteger;
             SizeQuery.Open;

             While (not SizeQuery.Eof) do
             begin
                add(':'+RightLine(SizeQuery.FieldByName('NAME').AsString, 26)+': '+
                        LeftLine(FormatFloat('0.000', SizeQuery.FieldByName('nsize').AsFloat) +
                                 SizeQuery.FieldByName('kind').AsString  + ' ' +
                                 SizeQuery.FieldByName('code').AsString, 50)+':');
                SizeQuery.Next;
             end;

             If LabelQuery.FieldByName('id_1').AsInteger = 1718 Then
             begin

                  LitQuery.Close;
                  LitQuery.SQL.Clear;
                  LitQuery.SQL.Add('Select Max(a.ntime)/1000 As NTime');
                  LitQuery.SQL.Add('From DT_Order2 a');
                  LitQuery.SQL.Add('Where a.id_order = :id');
                  LitQuery.ParamByName('id').AsInteger := LabelQuery.FieldByName('id').AsInteger;
                  LitQuery.Open;

                  add(':'+LeftLine('Вес фактический', 26)+': '+
                        LeftLine(FormatFloat('0.000', LitQuery.FieldByName('ntime').AsFloat), 50)+':');
             end;

             add(':'+LeftLine('Отправитель', 26)+': '+
                     LeftLine(LabelQuery.FieldByName('pdr_name').AsString, 50)+':');
             add(RepeatLine('-', 80));

             add(' ');
             add(' ');
             add(RepeatLine('-', 80));
             add(' ');
             LabelQuery.Next;
             i:=i+1;
         end;
      end;
      Form.Editor.Visible := True;
      PrForm.Destroy;

      Form.Caption := 'Ярлык';
      Form.Editor.show;
      Form.show;

end;

procedure TReport25Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
