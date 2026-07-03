{***************************************************************
 *
 * Модуль   : Rep20
 * Описание : Ведомость незавершенного производства
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep20;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXDBCtrl, Mask, ToolEdit, EnumForm4Sel, Db, DBTables;

type
  TReport20Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    Label4: TLabel;
    Label5: TLabel;
    ButtonOK: TButton;
    ButtonNO: TButton;
    MainQuery: TQuery;
    PdrQuery: TQuery;
    CstQuery: TQuery;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    CalcOperQuery: TQuery;
    CalcPMatrQuery: TQuery;
    ItemQuery: TQuery;
    CheckBox: TCheckBox;
    procedure ButtonNOClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
    { Public declarations }
  end;

var
  Report20Form: TReport20Form;

implementation

uses PrintFrm, printlibs,
         Libs, PrintProces;

{$R *.DFM}

procedure TReport20Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport20Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i, j : Integer;
       sstr : String;
       tmpstr: String;
       mtrPrice : Real;
       operPrice: Real;
       Price    :Real;
       Price1   :Real;
       Str1, Str2, Str3, Str4, Str5,Str6, Str7, Str8, Str9, Str10 : String;
       n : integer;


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

       MainQuery.Close;
       MainQuery.SQL.Clear;
       MainQuery.SQL.Add('Select a.NUMBER, b.NUMBER, c.CODE, d.CODE, ');
       MainQuery.SQL.Add('e.CODE, a.NUMBER_F, f.CODE, a.ID, g.IS_INSTR, g.ID');
       MainQuery.SQL.Add('From DH_ORDER a, DH_RQST b, SPR_PDR d, ');
       MainQuery.SQL.Add('SPR_CST g, DT_ORDER2 h,');
       MainQuery.SQL.Add('(SPR_CHRT c Left Join SPR_NMNT e on e.ID = c.ID_NMNT)');
       MainQuery.SQL.Add(' Left Join SPR_EDIZ f on f.ID = e.ID_EDIZ');
       MainQuery.SQL.Add('Where ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          MainQuery.SQL.Add('g.id = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          MainQuery.SQL.Add('d.id = ' + PdrQuery.Fields[0].asstring + ' and ');

       MainQuery.SQL.Add('      a.ID_RQST = b.ID      and ');
       MainQuery.SQL.Add('      c.ID      = a.ID_CHRT and ');
       MainQuery.SQL.Add('      d.ID      = b.ID_PDR  and ');
       MainQuery.SQL.Add('      h.ID_ORDER = a.ID     and ');
       MainQuery.SQL.Add('      h.DATE_BEG<=:enddate  and ');
       MainQuery.SQL.Add('      a.PR_EXEC = 2 and         ');
       MainQuery.SQL.Add('      g.ID      = b.ID_CST      ');
       MainQuery.SQL.Add('Group By a.NUMBER, b.NUMBER, c.CODE, d.CODE, ');
       MainQuery.SQL.Add('e.CODE, a.NUMBER_F, f.CODE, a.ID, g.IS_INSTR, g.ID');
       MainQuery.SQL.Add('Order by b.NUMBER, a.NUMBER, d.CODE, g.ID           ');

       MainQuery.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);

       MainQuery.Open;

       If MainQuery.Eof Then
       begin
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       i := 1;
       if CheckBox.Checked Then n := 156 else n := 129;
       PrForm.Show;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          add(RepeatLine('-', n));
          add('');
          add('');
          add(CentrLine('Ведомость незавершенного производства',n));
          add(CentrLine('на '+EndDateEdit.Text,n));
          add('');
          add(RepeatLine('-', n));
          sstr:='        |                   |                | Ответственное |         |                |             |             |            ';
          if CheckBox.Checked Then sstr:=sstr+'|                         |';
          add(sstr);
          sstr:=' № п.п. | № Заявки/№ Заказа |     Чертеж     |      МВЗ      | Ед.Изм. | № Номенклатуры | Кол-во факт |   План СС   |   Факт СС  ';
          if CheckBox.Checked Then sstr:=sstr+'|      Статьи затрат      |';
          add(sstr);
          sstr:='        |                   |                |               |         |                |             |             |            ';
          if CheckBox.Checked Then sstr:=sstr+'|                         |';
          add(sstr);
          add(RepeatLine('-', n));


          //цикл по количеству заказов
          While i-1< MainQuery.RecordCount do
          begin

            Str1:='';
            Str2:=RepeatLine(' ', 103);
            Str3:=RepeatLine(' ', 103);
            Str4:=RepeatLine(' ', 103);
            Str5:=RepeatLine(' ', 103);
            Str6:=RepeatLine(' ', 103);
            Str7:=RepeatLine(' ', 103);
            Str8:=RepeatLine(' ', 103);
            Str9:=RepeatLine(' ', 103);
            Str10:=RepeatLine(' ', 103);
            tmpstr:='';
            sstr:=CentrLine(IntToStr(i),8)+' '+
                  RightLine(MainQuery.FieldByName('NUMBER_1').AsString + '/' +
                            MainQuery.FieldByName('NUMBER').AsString, 19)+ ' ' +
                  LeftLine(MainQuery.FieldByName('CODE').AsString,16) + ' ' +
                  RightLine(MainQuery.FieldByName('CODE_1').AsString, 15) + ' ' +
                  CentrLine(MainQuery.FieldByName('CODE_3').AsString, 9) + ' ' +
                  RightLine(MainQuery.FieldByName('CODE_2').AsString, 15) + ' ' +
                  RightLine(MainQuery.FieldByName('NUMBER_F').AsString, 14)+ ' ' ;

            //первый цикл по плановым операциям второй по фактическим
            for j:=1 to 2 do
            begin
              PrForm.ProgressBar.Position:=i*100 div MainQuery.RecordCount;

              //Запрос по операциям: при j=1 плановые операции,при j=2 фактические
              CalcOperQuery.Close;
              CalcOperQuery.SQL.Clear;
              CalcOperQuery.SQL.Add('select a.NTIME, a.RATING, b.RANK_1, b.RANK_2, ');
              CalcOperQuery.SQL.Add('b.RANK_3, b.RANK_4, b.RANK_5, b.RANK_6 ');
              CalcOperQuery.SQL.Add('From DT_Order'+IntToStr(j)+' a, Spr_Vop b ');
              CalcOperQuery.SQL.Add('Where a.id_order = :id and b.id = a.id_vop ');

              //Сумма стоимости операций  плану
              Price:=0;
              CalcOperQuery.ParamByName('ID').AsInteger:=
                                               MainQuery.FieldByName('ID').AsInteger;
              CalcOperQuery.Open;

              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 2;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              While not(CalcOperQuery.Eof) do
              begin
                   Case CalcOperQuery.FieldByName('RATING').AsInteger of
                     1 : Price:=Price + CalcOperQuery.FieldByName('NTIME').AsInteger/1000
                                          * CalcOperQuery.FieldByName('RANK_1').AsInteger/100;
                     2 : Price:=Price + CalcOperQuery.FieldByName('NTIME').AsInteger/1000
                                          * CalcOperQuery.FieldByName('RANK_2').AsInteger/100;
                     3 : Price:=Price + CalcOperQuery.FieldByName('NTIME').AsInteger/1000
                                          * CalcOperQuery.FieldByName('RANK_3').AsInteger/100;
                     4 : Price:=Price + CalcOperQuery.FieldByName('NTIME').AsInteger/1000
                                          * CalcOperQuery.FieldByName('RANK_4').AsInteger/100;
                     5 : Price:=Price + CalcOperQuery.FieldByName('NTIME').AsInteger/1000
                                          * CalcOperQuery.FieldByName('RANK_5').AsInteger/100
                   else // 6:
                      Price:=Price + CalcOperQuery.FieldByName('NTIME').AsInteger/1000
                                       * CalcOperQuery.FieldByName('RANK_6').AsInteger/100;
                   end;
                   Price:=Price*100;
                   Price:=Round(Price)/100;
                   CalcOperQuery.Next;
              end;

              Price := Price * ItemQuery.FieldByName('NValue').AsFloat/100
                                 * ItemQuery.FieldByName('Is_Int').AsInteger;
              OperPrice:= Price;

              //Материалы
              CalcPMatrQuery.Close;
              CalcPMatrQuery.ParamByName('ID').AsInteger:=
                                               MainQuery.FieldByName('ID').AsInteger;
              CalcPMatrQuery.Open;

              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 1;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price:=0;
              While not(CalcPMatrQuery.Eof) do
              begin  // Если цена в плане не указана берем цену в справочнике материалов
                  If CalcPMatrQuery.FieldByName('Price').AsFloat > 0 Then
                       Price:=Price + CalcPMatrQuery.FieldByName('Price').AsFloat *
                          CalcPMatrQuery.FieldByName('Number').AsFloat*
                          ItemQuery.FieldByName('NValue').AsFloat/100*
                          ItemQuery.FieldByName('Is_Int').AsInteger
                   else
                       Price:=Price + CalcPMatrQuery.FieldByName('Price_1').AsFloat *
                          CalcPMatrQuery.FieldByName('Number').AsFloat*
                          ItemQuery.FieldByName('NValue').AsFloat/100*
                          ItemQuery.FieldByName('Is_Int').AsInteger;
                  CalcPMatrQuery.Next;
              end;

              Price:=Price*100;
              Price:=Round(Price)/100;
              MtrPrice:=Price;

              //вывод материаллов
              if (CheckBox.Checked) and (j=1) Then Str1:=RightLine(FormatFloat('0.00', MtrPrice),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str1:=Str1+RightLine(FormatFloat('0.00', MtrPrice),13)+' '+
                            LeftLine('Материалы',25);
                     sstr:=sstr+Str1;
                     add(sstr);
              end;

              //вывод заработной платы
              if (CheckBox.Checked) and (j=1) Then Str2:=Str2+RightLine(FormatFloat('0.00', OperPrice),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str2:=Str2+RightLine(FormatFloat('0.00', OperPrice),13)+' '+
                            LeftLine('Заработная плата',25);
                     add(Str2);
              end;

              //Отчисления на соцстрах
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 3;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price1:=OperPrice
                          * ItemQuery.FieldByName('NValue').AsFloat/100
                          * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price1:=Price1*100;
              Price1:=Round(Price1)/100;

              //вывод Отчисления на соцстрах
              if (CheckBox.Checked) and (j=1) Then Str3:=Str3+RightLine(FormatFloat('0.00', Price1),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str3:=Str3+RightLine(FormatFloat('0.00', Price1),13)+' '+
                            LeftLine('Отчисления на соцстрах',25);
                     add(Str3);
              end;

              //Общепроизводственные расходы
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 4;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price:=OperPrice
                               * ItemQuery.FieldByName('NValue').AsFloat/100
                               * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price:=Price*100;
              Price:=Round(Price)/100;

              //вывод Общепроизводственные расходы
              if (CheckBox.Checked) and (j=1) Then Str4:=Str4+RightLine(FormatFloat('0.00', Price),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str4:=Str4+RightLine(FormatFloat('0.00', Price),13)+' '+
                            LeftLine('Общепроизводственные расходы',25);
                     add(Str4);
              end;

              //Цеховая себестоимость
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 5;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price:=(Price+Price1+OperPrice+MtrPrice) * ItemQuery.FieldByName('NValue').AsFloat/100
                               * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price:=Price*100;
              Price:=Round(Price)/100;

              //вывод Цеховая себестоимость
              if (CheckBox.Checked) and (j=1) Then Str5:=Str5+RightLine(FormatFloat('0.00', Price),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str5:=Str5+RightLine(FormatFloat('0.00', Price),13)+' '+
                            LeftLine('Цеховая себестоимость',25);
                     add(Str5);
              end;

              //Общезаводские расходы
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 6;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price1:=Price
                          * ItemQuery.FieldByName('NValue').AsFloat/100
                          * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price1:=Price1*100;
              Price1:=Round(Price1)/100;

              //вывод Общезаводские расходы
              if (CheckBox.Checked) and (j=1) Then Str6:=Str6+RightLine(FormatFloat('0.00', Price1),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str6:=Str6+RightLine(FormatFloat('0.00', Price1),13)+' '+
                            LeftLine('Общезаводские расходы',25);
                     add(Str6);
              end;

              //Производственные расходы
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 7;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price:=(Price+Price1) * ItemQuery.FieldByName('NValue').AsFloat/100
                               * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price:=Price*100;
              Price:=Round(Price)/100;

              //вывод Производственные расходы
              if (CheckBox.Checked) and (j=1) Then Str7:=Str7+RightLine(FormatFloat('0.00', Price),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str7:=Str7+RightLine(FormatFloat('0.00', Price),13)+' '+
                            LeftLine('Производственные расходы',25);
                     add(Str7);
              end;

              //Плановые накопления
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 8;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price1:=Price
                          * ItemQuery.FieldByName('NValue').AsFloat/100
                          * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price1:=Price1*100;
              Price1:=Round(Price1)/100;

              //вывод Плановые накопления
              if (CheckBox.Checked) and (j=1) Then Str8:=Str8+RightLine(FormatFloat('0.00', Price1),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str8:=Str8+RightLine(FormatFloat('0.00', Price1),13)+' '+
                            LeftLine('Плановые накопления',25);
                     add(Str8);
              end;

              //Полная себестоимость
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 9;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price:=(Price1+Price) * ItemQuery.FieldByName('NValue').AsFloat/100
                               * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price:=Price*100;
              Price:=Round(Price)/100;

              //вывод Полная себестоимость
              if (CheckBox.Checked) and (j=1) Then Str9:=Str9+RightLine(FormatFloat('0.00', Price),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str9:=Str9+RightLine(FormatFloat('0.00', Price),13)+' '+
                            LeftLine('Полная себестоимость',25);
                     add(Str9);
              end;

              //НДС
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger := 10;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price1:=Price
                          * ItemQuery.FieldByName('NValue').AsFloat/100
                          * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price1:=Price1*100;
              Price1:=Round(Price1)/100;

              //вывод НДС
              if (CheckBox.Checked) and (j=1) Then Str10:=Str10+RightLine(FormatFloat('0.00', Price1),13);
              if (CheckBox.Checked) and (j=2) Then
              begin
                     Str10:=Str10+RightLine(FormatFloat('0.00', Price1),13)+' '+
                            LeftLine('НДС',25);
                     add(Str10);
              end;

              //Всего
              ItemQuery.Close;
              ItemQuery.ParamByName('code').AsInteger :=11;
              ItemQuery.ParamByName('idorder').AsInteger := MainQuery.FieldByName('ID').AsInteger;
              ItemQuery.Open;

              Price:=(Price1+Price) * ItemQuery.FieldByName('NValue').AsFloat/100
                               * ItemQuery.FieldByName('Is_Int').AsInteger;

              Price:=Price*100;
              Price:=Round(Price)/100;

              tmpstr:=tmpstr + RightLine(FormatFloat('0.00', Price),13);

              if (CheckBox.Checked) and (j=2) Then
              begin
                     tmpstr:=RepeatLine(' ',103)+tmpstr+' '+LeftLine('Всего',25);
              end;
            end;

           //вывод Всего
            if CheckBox.Checked  Then
            begin
                add(tmpstr);
                add('');
            end
             else add(sstr+tmpstr);

            MainQuery.Next;
            i:=i+1;
          end;

       end;
       PrForm.Destroy;

       Form.Caption := 'Ведомость незавершенного производства';
       Form.Editor.show;
       Form.show;
end;

procedure TReport20Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  EndDateEdit.text := datetostr(now);

end;

procedure TReport20Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);
end;

procedure TReport20Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport20Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport20Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport20Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
