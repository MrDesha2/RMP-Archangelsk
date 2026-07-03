{***************************************************************
 *
 * Модуль   : Rep16
 * Описание : Отчет о выполненных услугах для R3
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}



unit Rep16;

interface
                                     
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ToolEdit, Mask, Db, EnumForm4Sel, DBTables, DateUtil;

type                                                         
  TReport16Form = class(TForm)
    PdrCombo: TComboEdit;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OkButton: TButton;
    CancelButton: TButton;
    MainQuery: TQuery;
    XZQuery: TQuery;
    PdrQuery: TQuery;
    MtrfQuery: TQuery;
    NmntQuery: TQuery;
    NamePdrQuery: TQuery;
    Label4: TLabel;
    SelectCombo: TComboBox;
    Label5: TLabel;
    SaldoQuery: TQuery;
    CheckBox: TCheckBox;
    ButtonSelPer: TButton;
    NumberQuery: TQuery;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure OkButtonClick(Sender: TObject);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LISTForm : TLIST_4SELECTForm;
  end;

var
  Report16Form: TReport16Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.DFM}

procedure TReport16Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ListForm := TLIST_4SELECTForm.create(self);
  
  SelectCombo.ItemIndex := 0;
end;

procedure TReport16Form.OkButtonClick(Sender: TObject);
Var     i  : Integer;
        j  : Real;
     sstr  : String; //Переменная для сбора очередной строки
     rstr  : Real;   //временная переменная для хранения значения ВСЕГО
   SumCex  : Real;   //Сумма по цеховым расходам
   SumCst  : Real;    //Сумма прочих расходов
   PdrStr  : String;  //Сортировка по подразделению
   CstStr  : String;  //счетчик показывает что я все еще вывожу акты одного заказчика
  CostStr  : Integer; //(0, 1) Ремонт или изготовление
StrDateBeg : String;  //дата начала месяца BegDateEdit
  CstKol, CstMat, CstZP, CstFond, CstRS, CstCex, CstPr, CstSaldo, CstMonth, CstAll : Real;
  PdrKol, PdrMat, PdrZP, PdrFond, PdrRS, PdrCex, PdrPr, PdrSaldo, PdrMonth, PdrAll : Real;
  AllKol, AllMat, AllZP, AllFond, AllRS, AllCex, AllPr, AllSaldo, AllMonth, AllAll : Double;
    Form : TShowPrintForm;
  PrForm : TProcessForm;
begin
        // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

        If (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') Then
        begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
        end;
{       If (PdrCombo.Text = '<Object not found>') and not (PDRQuery.Active) Then
       begin
          MessageDlg('Подразделение не определено!', mtWarning , [mbYes], 0);
          Exit;
       end;
}
        AllKol:=0;
        AllMat:=0;
        AllZP:=0;
        AllFond:=0;
        AllRS:=0;
        AllCex:=0;
        AllPr:=0;
        AllSaldo:=0;
        AllMonth:=0;
        AllAll:=0;

        MainQuery.Close;
        MainQuery.SQL.Clear;

        // поле отбора
        case SelectCombo.ItemIndex of
          0:   begin
                MainQuery.SQL.Add('Select h.ID_PDR, g.CODE, g.NAME, a.NUMDOC, b.NUMBER_F, ');
                MainQuery.SQL.Add('b.NUMBER, f.CODE, e.CODE, e.NAME, b.ID, e.VID_CHRT, ');
                MainQuery.SQL.Add('k.NAME, k.CODE, n.CODE, p.CODE, g.IS_INSTR, q.CODE');
//                MainQuery.SQL.Add('cast(SUBSTRING(g.NAME FROM 1 FOR 40) as Char(40)) as NAME_2, g.CODE, n.CODE, p.CODE, g.IS_INSTR, q.CODE');
                MainQuery.SQL.Add('From DH_PR a, DH_Order b, Spr_Wrhs c,');
                MainQuery.SQL.Add('DT_PR d, Spr_Chrt e, Spr_Cst g, DH_Rqst h, Spr_Pdr n,');
                MainQuery.SQL.Add('(((DH_Order m Left Join Spr_Pdr k On k.ID = m.ID_COST )');
                MainQuery.SQL.Add('Left Join Spr_Count p On p.ID = m.ID_COUNT) ');
                MainQuery.SQL.Add('Left Join Spr_Eqpt q On q.ID = m.ID_EQPT) ');
                MainQuery.SQL.Add('Left Join Spr_Plant f On  f.ID = m.ID_PLANT');
                MainQuery.SQL.Add('Where a.DATE_IN>=:date_beg and ');
                MainQuery.SQL.Add('a.DATE_IN<=:date_end and ');
                MainQuery.SQL.Add('d.ID_PRMTR = a.ID and ');
                MainQuery.SQL.Add('b.ID = d.ID_ORD   and ');
                MainQuery.SQL.Add('a.PR_EXEC = 1     and ');
                MainQuery.SQL.Add('g.ID = h.ID_CST   and ');
                MainQuery.SQL.Add('c.ID = a.ID_WRHS  and ');
                MainQuery.SQL.Add('e.ID = b.ID_CHRT  and ');
                MainQuery.SQL.Add('b.ID_RQST = h.ID  and ');
                MainQuery.SQL.Add('n.ID = h.ID_PDR   and ');
                MainQuery.SQL.Add('m.ID = b.ID       and ');
                MainQuery.SQL.Add('(e.VID_CHRT = 0 or e.VID_CHRT is NULL)');

                If PDRQuery.Active Then
                begin
                   MainQuery.SQL.Add('and h.ID_PDR = :id');
                   MainQuery.ParamByName('id').AsInteger:= PdrQuery.FieldByName('ID').AsInteger;
                end;

                MainQuery.SQL.Add('Union ');
                MainQuery.SQL.Add('Select h.ID_PDR, g.CODE, g.NAME, a.NUMDOC, b.NUMBER_F, ');
                MainQuery.SQL.Add('b.NUMBER, f.CODE, e.CODE, e.NAME, b.ID, e.VID_CHRT, ');
                MainQuery.SQL.Add('k.NAME, k.CODE, n.CODE, p.CODE, g.IS_INSTR, q.CODE');
                MainQuery.SQL.Add('From DH_RS a, DH_Order b, Spr_Wrhs c,');
                MainQuery.SQL.Add('DT_RS d, Spr_Chrt e, Spr_Cst g, DH_Rqst h, Spr_Pdr n,');
                MainQuery.SQL.Add('(((DH_Order m Left Join Spr_Pdr k On k.ID = m.ID_COST) ');
                MainQuery.SQL.Add('Left Join Spr_Count p On p.ID = m.ID_COUNT) ');
                MainQuery.SQL.Add('Left Join Spr_Eqpt q On q.ID = m.ID_EQPT) ');
                MainQuery.SQL.Add('Left Join Spr_Plant f On  f.ID = m.ID_PLANT');
                MainQuery.SQL.Add('Where a.DATE_IN>=:date_beg and ');
                MainQuery.SQL.Add('a.DATE_IN<=:date_end and ');
                MainQuery.SQL.Add('d.ID_RSMTR = a.ID and ');
                MainQuery.SQL.Add('b.ID = d.ID_ORD   and ');
                MainQuery.SQL.Add('a.PR_EXEC = 1     and ');
                MainQuery.SQL.Add('g.ID = a.ID_CST   and ');
                MainQuery.SQL.Add('c.ID = a.ID_WRHS  and ');
                MainQuery.SQL.Add('e.ID = b.ID_CHRT  and ');
                MainQuery.SQL.Add('b.ID_RQST = h.ID  and ');
                MainQuery.SQL.Add('n.ID = h.ID_PDR   and ');
                MainQuery.SQL.Add('m.ID = b.ID       and ');
                MainQuery.SQL.Add('e.VID_CHRT = 1 ');

                If PDRQuery.Active Then
                begin
                    MainQuery.SQL.Add('and h.ID_PDR = :id');
                    MainQuery.ParamByName('id').AsInteger:= PdrQuery.FieldByName('ID').AsInteger;
                end;

                //выяснение кол-ва плановых, неплановых и годовых заказов
                NumberQuery.Close;
                NumberQuery.SQL.Clear;
                NumberQuery.SQL.Add('Select count(b.ID) As Num, Sum(b.sum_doc) As SumDoc');
                NumberQuery.SQL.Add('From DH_RS a, Dh_Order b, DT_RS d, Spr_Chrt e ');
                NumberQuery.SQL.Add('Where a.DATE_IN>=:date_beg and ');
                NumberQuery.SQL.Add('a.DATE_IN<=:date_end and ');
                NumberQuery.SQL.Add('d.ID_RSMTR = a.ID    and ');
                NumberQuery.SQL.Add('a.PR_EXEC = 1        and ');
                NumberQuery.SQL.Add('b.ID = d.ID_ORD      and ');
                NumberQuery.SQL.Add('e.ID = b.ID_CHRT     and ');
                NumberQuery.SQL.Add('e.VID_CHRT = 1       and ');
                NumberQuery.SQL.Add('b.WEIGHT_F = :Value      ');
                NumberQuery.SQL.Add('Union ');
                NumberQuery.SQL.Add('Select count(b.ID) As Num, Sum(b.sum_doc) As SumDoc');
                NumberQuery.SQL.Add('From DH_PR a, Dh_Order b, DT_PR d, Spr_Chrt e ');
                NumberQuery.SQL.Add('Where a.DATE_IN>=:date_beg and ');
                NumberQuery.SQL.Add('a.DATE_IN<=:date_end and ');
                NumberQuery.SQL.Add('d.ID_PRMTR = a.ID    and ');
                NumberQuery.SQL.Add('a.PR_EXEC = 1        and ');
                NumberQuery.SQL.Add('b.ID = d.ID_ORD      and ');
                NumberQuery.SQL.Add('e.ID = b.ID_CHRT     and ');
                NumberQuery.SQL.Add('(e.VID_CHRT = 0 or e.VID_CHRT is NULL) and ');
                NumberQuery.SQL.Add('b.WEIGHT_F = :Value      ');

               end;
          1:   begin
                MainQuery.SQL.Add('Select h.ID_PDR, g.CODE, g.NAME, a.NUMDOC, b.NUMBER_F, ');
                MainQuery.SQL.Add('b.NUMBER, f.CODE, e.CODE, e.NAME, b.ID, e.VID_CHRT, ');
                MainQuery.SQL.Add('k.NAME, k.CODE, n.CODE, p.CODE, g.IS_INSTR, q.CODE');
//                MainQuery.SQL.Add('cast(SUBSTRING(g.NAME FROM 1 FOR 40) as Char(40)) as NAME_2, g.CODE, n.CODE, p.CODE, g.IS_INSTR, q.CODE');
                MainQuery.SQL.Add('From DH_PR a, DH_Order b, Spr_Wrhs c,');
                MainQuery.SQL.Add('DT_PR d, Spr_Chrt e, Spr_Cst g, DH_Rqst h, Spr_Pdr n,');
                MainQuery.SQL.Add('(((DH_Order m Left Join Spr_Pdr k On k.ID = m.ID_COST) ');
                MainQuery.SQL.Add('Left Join Spr_Count p On p.ID = m.ID_COUNT) ');
                MainQuery.SQL.Add('Left Join Spr_Eqpt q On q.ID = m.ID_EQPT) ');
                MainQuery.SQL.Add('Left Join Spr_Plant f On  f.ID = m.ID_PLANT');
                MainQuery.SQL.Add('Where a.DATE_IN>=:date_beg and ');
                MainQuery.SQL.Add('a.DATE_IN<=:date_end and ');
                MainQuery.SQL.Add('d.ID_PRMTR = a.ID and ');
                MainQuery.SQL.Add('b.ID = d.ID_ORD   and ');
                MainQuery.SQL.Add('a.PR_EXEC = 1     and ');
                MainQuery.SQL.Add('g.ID = h.ID_CST   and ');
                MainQuery.SQL.Add('c.ID = a.ID_WRHS  and ');
                MainQuery.SQL.Add('e.ID = b.ID_CHRT  and ');
                MainQuery.SQL.Add('b.ID_RQST = h.ID  and ');
                MainQuery.SQL.Add('n.ID = h.ID_PDR   and ');
                MainQuery.SQL.Add('m.ID = b.ID       and ');
                MainQuery.SQL.Add('(e.VID_CHRT = 0 or e.VID_CHRT is NULL)');

                If PDRQuery.Active Then
                begin
                    MainQuery.SQL.Add('and h.ID_PDR = :id');
                    MainQuery.ParamByName('id').AsInteger:= PdrQuery.FieldByName('ID').AsInteger;
                end;

                //выяснение кол-ва плановых, неплановых и годовых заказов
                NumberQuery.Close;
                NumberQuery.SQL.Clear;
                NumberQuery.SQL.Add('Select count(b.ID) As Num, Sum(b.sum_doc) As SumDoc');
                NumberQuery.SQL.Add('From DH_PR a, Dh_Order b, DT_PR d, Spr_Chrt e ');
                NumberQuery.SQL.Add('Where a.DATE_IN>=:date_beg and ');
                NumberQuery.SQL.Add('a.DATE_IN<=:date_end and ');
                NumberQuery.SQL.Add('d.ID_PRMTR = a.ID    and ');
                NumberQuery.SQL.Add('a.PR_EXEC = 1        and ');
                NumberQuery.SQL.Add('b.ID = d.ID_ORD      and ');
                NumberQuery.SQL.Add('e.ID = b.ID_CHRT     and ');
                NumberQuery.SQL.Add('(e.VID_CHRT = 0 or e.VID_CHRT is NULL) and ');
                NumberQuery.SQL.Add('b.WEIGHT_F = :Value      ');


               end;
          2:   begin
                MainQuery.SQL.Add('Select h.ID_PDR, g.CODE, g.NAME, a.NUMDOC, b.NUMBER_F, ');
                MainQuery.SQL.Add('b.NUMBER, f.CODE, e.CODE, e.NAME, b.ID, e.VID_CHRT, ');
                MainQuery.SQL.Add('k.NAME, k.CODE, n.CODE, p.CODE, g.IS_INSTR, q.CODE');
                MainQuery.SQL.Add('From DH_RS a, DH_Order b, Spr_Wrhs c,');
                MainQuery.SQL.Add('DT_RS d, Spr_Chrt e, Spr_Cst g, DH_Rqst h, Spr_Pdr n,');
                MainQuery.SQL.Add('(((DH_Order m Left Join Spr_Pdr k On k.ID = m.ID_COST) ');
                MainQuery.SQL.Add('Left Join Spr_Count p On p.ID = m.ID_COUNT) ');
                MainQuery.SQL.Add('Left Join Spr_Eqpt q On q.ID = m.ID_EQPT) ');
                MainQuery.SQL.Add('Left Join Spr_Plant f On  f.ID = m.ID_PLANT');
                MainQuery.SQL.Add('Where a.DATE_IN>=:date_beg and ');
                MainQuery.SQL.Add('a.DATE_IN<=:date_end and ');
                MainQuery.SQL.Add('d.ID_RSMTR = a.ID and ');
                MainQuery.SQL.Add('b.ID = d.ID_ORD   and ');
                MainQuery.SQL.Add('a.PR_EXEC = 1     and ');
                MainQuery.SQL.Add('g.ID = h.ID_CST   and ');
                MainQuery.SQL.Add('c.ID = a.ID_WRHS  and ');
                MainQuery.SQL.Add('e.ID = b.ID_CHRT  and ');
                MainQuery.SQL.Add('b.ID_RQST = h.ID  and ');
                MainQuery.SQL.Add('n.ID = h.ID_PDR   and ');
                MainQuery.SQL.Add('m.ID = b.ID       and ');
                MainQuery.SQL.Add('e.VID_CHRT = 1 ');

                If PDRQuery.Active Then
                begin
                    MainQuery.SQL.Add('and h.ID_PDR = :id');
                    MainQuery.ParamByName('id').AsInteger:= PdrQuery.FieldByName('ID').AsInteger;
                end;

{                If PDRQuery.Active Then
                begin
                    If (PDRQuery.FieldByName('code').AsString = '30-20') Then
                    begin
                       MainQuery.SQL.Add('and b.ID_PDR in (4802, 4803, 4804, 4805, 1608, 1630, 1652, 1696)')
                    end
                     else
                     begin
                        MainQuery.SQL.Add('and h.ID_PDR = :id');
                        MainQuery.ParamByName('id').AsInteger:= PdrQuery.FieldByName('ID').AsInteger;
                     end;
                end;
}
                //выяснение кол-ва плановых, неплановых и годовых заказов
                NumberQuery.Close;
                NumberQuery.SQL.Clear;
                NumberQuery.SQL.Add('Select count(b.ID) As Num, Sum(b.sum_doc) As SumDoc');
                NumberQuery.SQL.Add('From DH_RS a, Dh_Order b, DT_RS d, Spr_Chrt e ');
                NumberQuery.SQL.Add('Where a.DATE_IN>=:date_beg and ');
                NumberQuery.SQL.Add('a.DATE_IN<=:date_end and ');
                NumberQuery.SQL.Add('d.ID_RSMTR = a.ID    and ');
                NumberQuery.SQL.Add('a.PR_EXEC = 1        and ');
                NumberQuery.SQL.Add('b.ID = d.ID_ORD      and ');
                NumberQuery.SQL.Add('e.ID = b.ID_CHRT     and ');
                NumberQuery.SQL.Add('e.VID_CHRT = 1       and ');
                NumberQuery.SQL.Add('b.WEIGHT_F = :Value      ');

               end;

        end;

        MainQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
        MainQuery.ParamByName('date_end').AsString := EndDateEdit.Text;

        If (not CheckBox.Checked) Then
            MainQuery.SQL.Add('Order by 11, 1, 13, 4')    //13<-->2
         else
              MainQuery.SQL.Add('Order by 1, 13, 4');    //13<-->2
//        MainQuery.SQL.Add('Order by 4, 1, 2');

        MainQuery.Open;

        i:=0;
        PrForm.Show;

        StrDateBeg:='01.'+IntToStr(ExtractMonth(StrToDate(BegDateEdit.Text)))+'.'+
                          IntToStr(ExtractYear(StrToDate(BegDateEdit.Text)));

        // формирование строк
        with Form.Editor.lines do
        begin

          clear;
          add( RepeatLine('-', 210));
          add( '');
          add( '');
          add( LeftLine('Дата распечатки: '+DateToStr(Date)+', время: '+TimeToStr(Time),174));
          add( LeftLine('Отчет о выполненных услугах',174));

          add(' ');

          case SelectCombo.ItemIndex of
            0: add('Все данные');
            1: add('Данные по производству');
            2: add('Данные по услугам');

          end;

          If (CheckBox.Checked) Then
          begin
               add( CentrLine('C '+BegDateEdit.Text+' по '+EndDateEdit.Text,210));
               add( RepeatLine('-', 210));
               add( '   № заказа   | № Акта |        ОСЧ         |№ материала|  Количество изготовденных   |  Сальдо на   | Материалы | Основная з/п | Отчислен.  |Общепрозвод-|   Всего    |   Прочие   |    Всего     |     ВСЕГО    |');
               add( '              |        |                    | Количество|           деталей           |    начало    |   план    |     план     |  в фонды   |  ственные  |   цех с/с  |   расходы  |   за месяц   |              |');
               add( '              |        |                    |           |                             |    месяца    |           |              |    план    |   расходы  |    план    |    план    |              |              |');
               add( RepeatLine('-', 210));
          end;

          //цикл по количеству заказов
          While not MainQuery.Eof do
          begin

             PrForm.ProgressBar.Position:=(i+1)*100 div MainQuery.RecordCount;

             NamePdrQuery.Close;
             NamePdrQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID_PDR').AsInteger;
             NamePdrQuery.Open;

             If (not CheckBox.Checked) Then
             begin
               // вывод шапки отчета
               add( '');
               add( '');
               add( LeftLine('Отправитель: '+NamePdrQuery.FieldByName('CODE').AsString+
                      ' '+NamePdrQuery.FieldByName('NAME').AsString,210));
               add( CentrLine('C '+BegDateEdit.Text+' по '+EndDateEdit.Text,210));
               add( RepeatLine('-', 210));
               add( '   № заказа   | № Акта |        ОСЧ         |№ материала|          Вид работ          |  Сальдо на   | Материалы | Основная з/п | Отчислен.  |Общепрозвод-|   Всего    |   Прочие   |    Всего     |     ВСЕГО    |');
               add( '              |        |                    | Количество|                             |    начало    |   план    |     план     |  в фонды   |  ственные  |   цех с/с  |   расходы  |   за месяц   |              |');
               add( '              |        |                    |           |                             |    месяца    |           |              |    план    |   расходы  |    план    |    план    |              |              |');
               add( RepeatLine('-', 210));
             end;

             CstStr:=MainQuery.FieldByName('CODE_3').AsString;
             CostStr:=MainQuery.FieldByName('VID_CHRT').AsInteger;

             If (not CheckBox.Checked) Then
             begin
               //если изготовление то получателя не печатаем
               If CostStr = 1 Then
                   add('Получатель:   '+MainQuery.FieldByName('CODE_3').AsString+
                               ' '+MainQuery.FieldByName('NAME_2').AsString)
                else
//                   add('Получатель:   '+MainQuery.FieldByName('CODE_3').AsString+
//                               ' '+MainQuery.FieldByName('NAME_2').AsString)
                   add('Получатель:   ');
             end;

             PdrStr:=NamePdrQuery.FieldByName('ID').AsString;

             PdrKol:=0;
             PdrMat:=0;
             PdrZP:=0;
             PdrFond:=0;
             PdrRS:=0;
             PdrCex:=0;
             PdrPr:=0;
             PdrSaldo:=0;
             PdrMonth:=0;
             PdrAll:=0;

             CstKol:=0;
             CstMat:=0;
             CstZP:=0;
             CstFond:=0;
             CstRS:=0;
             CstCex:=0;
             CstPr:=0;
             CstSaldo:=0;
             CstMonth:=0;
             CstAll:=0;

             While (MainQuery.FieldByName('ID_PDR').AsString = PdrStr) and
                   (not MainQuery.Eof) do
             begin

                //Если заказчик появился первый раз выводим
                If MainQuery.FieldByName('CODE_3').AsString <> CstStr  Then
                begin
                     CostStr:=MainQuery.FieldByName('VID_CHRT').AsInteger;

                     If (not CheckBox.Checked) Then
                     begin
                       //если изготовление то получателя не печатаем
                       If CostStr = 1 Then
                       begin
                          add('Получатель:   '+MainQuery.FieldByName('CODE_3').AsString+
                                      ' '+MainQuery.FieldByName('NAME_2').AsString);
                       end
                        else
                        begin
//                          add('Получатель:   '+MainQuery.FieldByName('CODE_3').AsString+
//                                      ' '+MainQuery.FieldByName('NAME_2').AsString);
                          add('Получатель:   ');
                        end;
                     end;

                     CstStr:=MainQuery.FieldByName('CODE_3').AsString;

                     CstKol:=0;
                     CstMat:=0;
                     CstZP:=0;
                     CstFond:=0;
                     CstRS:=0;
                     CstCex:=0;
                     CstPr:=0;
                     CstSaldo:=0;
                     CstMonth:=0;
                     CstAll:=0;
                end;

                SumCex:=0;
                SumCst:=0;
                sstr:='';

                NmntQuery.Close;
                NmntQuery.ParamByName('id').AsInteger := MainQuery.FieldByName('ID').AsInteger;
                NmntQuery.Open;
//                add('Номенклатура: '+NmntQuery.FieldByName('NAME').AsString);

                sstr:=sstr+RightLine(IntToStr(12100000+MainQuery.FieldByName('NUMBER').AsInteger),14)+' '+
   //                 RightLine(MainQuery.FieldByName('NUMDOC').AsString,8)+' '+
                        RightLine(MainQuery.FieldByName('NUMDOC').AsString,8)+' ';

                //если предприятие внутреннее
                if MainQuery.FieldByName('IS_INSTR').AsInteger = 1  Then
                begin
                   //Если Vid_Chrt = 1 то производится ремонт иначе изготовление
                   If MainQuery.FieldByName('VID_CHRT').AsInteger = 1 Then
                       sstr:=sstr+RepeatLine(' ',20)+' '
//                       sstr:=sstr+RightLine(MainQuery.FieldByName('CODE_4').AsString,10)+' '
                    else
                       sstr:=sstr+RepeatLine(' ',20)+' ';
//                     sstr:=sstr+RightLine(MainQuery.FieldByName('CODE_1').AsString,10)+' ';
                end
                 else
                 begin  //если заказ на Заказ (=2)
                      If MainQuery.FieldByName('IS_INSTR').AsInteger = 2  Then
                          sstr:=sstr+RightLine(MainQuery.FieldByName('NAME').AsString,20)+' '
                       else //если заказчик внешний (=1)
                          sstr:=sstr+RightLine(MainQuery.FieldByName('CODE_5').AsString,20)+' ';
                 end;

                //Если Vid_Chrt = 1 то производится ремонт иначе изготовление
                If MainQuery.FieldByName('VID_CHRT').AsInteger = 1 Then
                    sstr:=sstr+RepeatLine(' ', 12)+
                               LeftLine(NmntQuery.FieldByName('NAME').AsString,29)+' '
                 else
                 begin
                    sstr:=sstr+RightLine(NmntQuery.FieldByName('CODE').AsString,11)+' '+
                               LeftLine(NmntQuery.FieldByName('NAME').AsString,29)+' ';
                 end;

                //сальдо на начало периода
                If (MainQuery.FieldByName('ID').AsInteger = 8888) or
                   (MainQuery.FieldByName('ID').AsInteger = 8891) or
                   (MainQuery.FieldByName('ID').AsInteger = 8892) Then
                begin
                SaldoQuery.Close;
                SaldoQuery.ParamByName('id').AsInteger := MainQuery.FieldByName('ID').AsInteger;
                SaldoQuery.ParamByName('end_date').AsDate := StrToDate(StrDateBeg);
                SaldoQuery.ParamByName('st').AsInteger := 6;
//                XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
//                XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                SaldoQuery.Open;
                end
                else
                begin
                //Сальдо на начало периода
                SaldoQuery.Close;
                SaldoQuery.ParamByName('id').AsInteger := MainQuery.FieldByName('ID').AsInteger;
                SaldoQuery.ParamByName('end_date').AsDate := StrToDate(StrDateBeg);
                SaldoQuery.ParamByName('st').AsInteger := 10;
//                XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
//                XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                SaldoQuery.Open;
                end;

                If SaldoQuery.FieldByName('nValue').AsFloat > 0 Then
                    sstr:=sstr + RightLine(FormatFloat('0.00', SaldoQuery.FieldByName('nValue').AsFloat), 14)+' '
                 else
                     sstr:=sstr + RightLine('0.00', 14)+' ';

                CstSaldo := CstSaldo + SaldoQuery.FieldByName('nValue').AsFloat;
                PdrSaldo := PdrSaldo + SaldoQuery.FieldByName('nValue').AsFloat;
                AllSaldo := AllSaldo + SaldoQuery.FieldByName('nValue').AsFloat;



                //В справочнике Spr_Calc, поле ID = 1 означает "Материалы"
                XZQuery.Close;
                XZQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                XZQuery.ParamByName('calc').AsInteger:=1;
                XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
                XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                XZQuery.Open;
                sstr:=sstr+RightLine(FormatFloat( '0.00',XZQuery.FieldByName('NVALUE').AsFloat), 11)+' ';
                SumCex:=SumCex+XZQuery.FieldByName('NVALUE').AsFloat;
                CstMat:=CstMat+XZQuery.FieldByName('NVALUE').AsFloat;
                PdrMat:=PdrMat+XZQuery.FieldByName('NVALUE').AsFloat;
                AllMat:=AllMat+XZQuery.FieldByName('NVALUE').AsFloat;


                //В справочнике Spr_Calc, поле ID = 3 означает "Заработаную плату"
                XZQuery.Close;
                XZQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                XZQuery.ParamByName('calc').AsInteger:=3;
                XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
                XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                XZQuery.Open;
                sstr:=sstr+RightLine(FormatFloat( '0.00',XZQuery.FieldByName('NVALUE').AsFloat), 14)+' ';
                SumCex:=SumCex+XZQuery.FieldByName('NVALUE').AsFloat;
                CstZP:=CstZP+XZQuery.FieldByName('NVALUE').AsFloat;
                PdrZP:=PdrZP+XZQuery.FieldByName('NVALUE').AsFloat;
                AllZP:=AllZP+XZQuery.FieldByName('NVALUE').AsFloat;

                //В справочнике Spr_Calc, поле ID = 4 означает "Отчисления на соц нужды"
                XZQuery.Close;
                XZQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                XZQuery.ParamByName('calc').AsInteger:=4;
                XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
                XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                XZQuery.Open;
                sstr:=sstr+RightLine(FormatFloat( '0.00',XZQuery.FieldByName('NVALUE').AsFloat), 12)+' ';
                SumCex:=SumCex+XZQuery.FieldByName('NVALUE').AsFloat;
                CstFond:=CstFond+XZQuery.FieldByName('NVALUE').AsFloat;
                PdrFond:=PdrFond+XZQuery.FieldByName('NVALUE').AsFloat;
                AllFond:=AllFond+XZQuery.FieldByName('NVALUE').AsFloat;

                //В справочнике Spr_Calc, поле ID = 5 означает "Накладные расходы"
                XZQuery.Close;
                XZQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                XZQuery.ParamByName('calc').AsInteger:=5;
                XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
                XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                XZQuery.Open;
                sstr:=sstr+RightLine(FormatFloat( '0.00',XZQuery.FieldByName('NVALUE').AsFloat), 12)+' ';
                SumCex:=SumCex+XZQuery.FieldByName('NVALUE').AsFloat;
                CstRS:=CstRS+XZQuery.FieldByName('NVALUE').AsFloat;
                PdrRS:=PdrRS+XZQuery.FieldByName('NVALUE').AsFloat;
                AllRS:=AllRS+XZQuery.FieldByName('NVALUE').AsFloat;

                //Всего цеховые
                sstr:=sstr+RightLine(FormatFloat( '0.00',SumCex),12)+' ';
                CstCex:=CstCex+SumCex;
                PdrCex:=PdrCex+SumCex;
                AllCex:=AllCex+SumCex;

                //В справочнике Spr_Calc, поле ID = 7 означает "Общезаводские расходы"
                XZQuery.Close;
                XZQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                XZQuery.ParamByName('calc').AsInteger:=7;
                XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
                XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                XZQuery.Open;
//                sstr:=sstr+RightLine(FormatFloat( '0.00',XZQuery.FieldByName('NVALUE').AsFloat), 13)+' ';
                SumCst:=SumCst+XZQuery.FieldByName('NVALUE').AsFloat;

                //В справочнике Spr_Calc, поле ID = 9 означает "Плановая накопления (прибыль)"
                XZQuery.Close;
                XZQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                XZQuery.ParamByName('calc').AsInteger:=9;
                XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
                XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                XZQuery.Open;
//                sstr:=sstr+RightLine(FormatFloat( '0.00',XZQuery.FieldByName('NVALUE').AsFloat), 12)+' ';
                SumCst:=SumCst+XZQuery.FieldByName('NVALUE').AsFloat;

                //Прочие
                sstr:=sstr+RightLine(FormatFloat( '0.00',SumCst),12)+' ';
                CstPr:=CstPr+SumCst;
                PdrPr:=PdrPr+SumCst;
                AllPr:=AllPr+SumCst;

                //Всего за месяц
                //В справочнике Spr_Calc, поле ID = 12 означает "Всего"
                If MainQuery.FieldByName('IS_INSTR').AsInteger = 1 Then
                begin
                   XZQuery.Close;
                   XZQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                   XZQuery.ParamByName('calc').AsInteger:=12;
                   XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
                   XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                   XZQuery.Open;
                   rstr:=XZQuery.FieldByName('NVALUE').AsFloat;
                end
                 else
                 begin
                    //В справочнике Spr_Calc, поле ID = 10 означает "Полная себестоимость"
                    XZQuery.Close;
                    XZQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                    XZQuery.ParamByName('calc').AsInteger:=10;
                    XZQuery.ParamByName('beg_date').AsString:=StrDateBeg;
                    XZQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
                    XZQuery.Open;
                    rstr:=XZQuery.FieldByName('NVALUE').AsFloat;
                 end;

                //Всего
                sstr:=sstr+RightLine(FormatFloat( '0.00',rstr), 14)+' ';
                sstr:=sstr+RightLine(FormatFloat( '0.00',rstr + SaldoQuery.FieldByName('nValue').AsFloat), 14)+' ';

                CstMonth:=CstMonth+(rstr );
                PdrMonth:=PdrMonth+(rstr );
                AllMonth:=AllMonth+(rstr );

                //ВСЕГО
                CstAll:=CstMonth + CstSaldo;
                PdrAll:=PdrMonth + PdrSaldo;
                AllAll:=AllMonth + AllSaldo;
{                CstAll:=CstAll+SumCex+SumCst;
                PdrAll:=PdrAll+SumCex+SumCst;
                AllAll:=AllAll+SumCex+SumCst;}

                If (not CheckBox.Checked) Then
                    add( sstr);

                sstr:='';
                if MainQuery.FieldByName('CODE_6').AsString <> '' Then
                    sstr:='Инв № '+ LeftLine(MainQuery.FieldByName('CODE_6').AsString,12)
                 else sstr:=RepeatLine(' ' , 18);

                //Если Vid_Chrt = 0 то производится изготовление
                If (MainQuery.FieldByName('VID_CHRT').AsInteger = 0) or
                     (MainQuery.FieldByName('VID_CHRT').isnull) Then
                begin
                    sstr:=sstr+RepeatLine(' ', 34) +
                               RightLine(MainQuery.FieldByName('CODE_1').AsString, 11)+' '+
                               LeftLine(MainQuery.FieldByName('NUMBER_F').AsString, 29);
//                    sstr:=sstr+RepeatLine(' ' , 24)+
//                           RightLine(MainQuery.FieldByName('NUMBER_F').AsString, 11);

                    CstKol:=CstKol+MainQuery.FieldByName('NUMBER_F').AsFloat;
                    PdrKol:=PdrKol+MainQuery.FieldByName('NUMBER_F').AsFloat;
                    AllKol:=AllKol+MainQuery.FieldByName('NUMBER_F').AsFloat;
                end;

                If (not CheckBox.Checked) Then
                      add(sstr);

{                MtrfQuery.Close;
                MtrfQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID').AsInteger;
                MtrfQuery.Open;

                While not MtrfQuery.Eof do
                begin
                   sstr:=RepeatLine(' ' ,39);
                   //количество материала
                   sstr:=sstr+RightLine(FormatFloat( '0.000',MtrfQuery.FieldByName('NUMBER').AsFloat),11)+' ';
                   //наименование материала
                   sstr:=sstr+LeftLine(MtrfQuery.FieldByName('NAME').AsString,29)+' ';
                   add( sstr);
                   MtrfQuery.Next;
                end;
 }

                MainQuery.Next;
                i:=i+1;

                If (not CheckBox.Checked) Then
                begin
                  //Если заказчик появился первый раз выводим
                  If (MainQuery.FieldByName('CODE_3').AsString <> CstStr) or
                        (MainQuery.Eof) Then
                  begin
                      sstr:='';
                      add(RepeatLine('-', 210));
                      sstr:='Итого по заказчику:  ';
                      //если изготовление то получателя не печатаем
                      If CostStr = 1 Then
                          sstr:=sstr+LeftLine(CstStr,10)
                        else
                           sstr:=sstr+RepeatLine(' ', 10);

                      sstr:=sstr+RepeatLine(' ', 11)+
                          RepeatLine(' ', 15)+
                          LeftLine(FormatFloat('0.00', CstKol), 29)+' '+
                          RightLine(FormatFloat('0.00', CstSaldo), 14)+' '+
                          RightLine(FormatFloat('0.00', CstMat), 11)+' '+
                          RightLine(FormatFloat('0.00', CstZP), 14)+' '+
                          RightLine(FormatFloat('0.00', CstFond), 12)+' '+
                          RightLine(FormatFloat('0.00', CstRS), 12)+' '+
                          RightLine(FormatFloat('0.00', CstCex), 12)+' '+
//                          RepeatLine(' ', 13)+
                          RightLine(FormatFloat('0.00', CstPr), 12)+' '+
                          RightLine(FormatFloat('0.00', CstMonth), 14)+' '+
                          RightLine(FormatFloat('0.00', CstAll), 14);
                          add(sstr);
                          add('');
                  end
                end;
             end;
 {                   add(RepeatLine(' ', 39)+RepeatLine('-', 210-39));
                    add('Итого по заказчику:  '+
                        LeftLine(CstStr,10)+
                        RepeatLine(' ', 8)+
                        RightLine(FormatFloat('0.00', CstKol), 11)+' '+
                        RepeatLine(' ', 30)+
                        RightLine(FormatFloat('0.00', CstMat), 9)+' '+
                        RightLine(FormatFloat('0.00', CstZP), 14)+' '+
                        RightLine(FormatFloat('0.00', CstFond), 12)+' '+
                        RightLine(FormatFloat('0.00', CstRS), 12)+' '+
                        RightLine(FormatFloat('0.00', CstCex), 12)+' '+
                        RightLine(FormatFloat('0.00', CstPr), 12)+' '+
                        RightLine(FormatFloat('0.00', CstAll), 14));}

             If (not CheckBox.Checked) Then
                   add( RepeatLine('=', 210));

//             add(RepeatLine(' ', 39)+RepeatLine('-', 210-49));
             add('Всего по подразделению:  '+
                 LeftLine(NamePdrQuery.FieldByName('CODE').AsString,10)+
                 RepeatLine(' ', 7)+
                 RepeatLine(' ', 15)+
                 LeftLine(FormatFloat('0.00', PdrKol), 29)+' '+
                 RightLine(FormatFloat('0.00', PdrSaldo), 14)+' '+
                 RightLine(FormatFloat('0.00', PdrMat), 11)+' '+
                 RightLine(FormatFloat('0.00', PdrZP), 14)+' '+
                 RightLine(FormatFloat('0.00', PdrFond), 12)+' '+
                 RightLine(FormatFloat('0.00', PdrRS), 12)+' '+
                 RightLine(FormatFloat('0.00', PdrCex), 12)+' '+
//                 RepeatLine(' ', 13)+
                 RightLine(FormatFloat('0.00', PdrPr), 12)+' '+
                 RightLine(FormatFloat('0.00', PdrMonth), 14)+' '+
                 RightLine(FormatFloat('0.00', PdrAll), 14));
          end;
          add('');
          add('');
          add(RepeatLine('*', 210));
          add('ВСЕГО:  '+RepeatLine(' ', 34)+
              RepeatLine(' ', 15)+
              LeftLine(FormatFloat('0.00', AllKol), 29)+' '+
              RightLine(FormatFloat('0.00', AllSaldo), 14)+' '+
              RightLine(FormatFloat('0.00', AllMat), 11)+' '+
              RightLine(FormatFloat('0.00', AllZP), 14)+' '+
              RightLine(FormatFloat('0.00', AllFond), 12)+' '+
              RightLine(FormatFloat('0.00', AllRS), 12)+' '+
              RightLine(FormatFloat('0.00', AllCex), 12)+' '+
//              RepeatLine(' ', 13)+
              RightLine(FormatFloat('0.00', AllPr), 12)+' '+
              RightLine(FormatFloat('0.00', AllMonth), 14)+' '+
              RightLine(FormatFloat('0.00', AllAll), 14));

              add('');
              add('');
              add('');
              add(LeftLine('      Количество заказов: ' + IntToStr(MainQuery.RecordCount),210));

              //вывод количества плановых, неплановых и годовых заказов
              If CheckBox1.Checked = True Then
              begin
                  NumberQuery.Close;
                  NumberQuery.ParamByName('Value').AsInteger := 0;
                  NumberQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
                  NumberQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
                  NumberQuery.Open;

                  j := 0;
                  i := 0;
                  //вывод изготовления и ремонтов
                  If SelectCombo.ItemIndex = 0 Then
                  begin
                     i := NumberQuery.FieldByName('Num').AsInteger;
                     j := NumberQuery.FieldByName('SumDoc').AsFloat;
                     NumberQuery.Next;
                     i := i + NumberQuery.FieldByName('Num').AsInteger;
                     j := j + NumberQuery.FieldByName('SumDoc').AsFloat;
                  end
                   else
                   begin
                      i := NumberQuery.FieldByName('Num').AsInteger;
                      j := NumberQuery.FieldByName('SumDoc').AsFloat;
                   end;

                  add('');
                  add('  Количество плановых заказов: ' + IntToStr(i) + ' на ' + FormatFloat('0.00',j) + ' руб.');

                  NumberQuery.Close;
                  NumberQuery.ParamByName('Value').AsInteger := 1;
                  NumberQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
                  NumberQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
                  NumberQuery.Open;

                  i := 0;
                  j := 0;
                  If SelectCombo.ItemIndex = 0 Then
                  begin
                     i := NumberQuery.FieldByName('Num').AsInteger;
                     j := NumberQuery.FieldByName('SumDoc').AsFloat;
                     NumberQuery.Next;
                     i := i + NumberQuery.FieldByName('Num').AsInteger;
                     j := j + NumberQuery.FieldByName('SumDoc').AsFloat;
                  end
                   else
                   begin
                      i := NumberQuery.FieldByName('Num').AsInteger;
                      j := NumberQuery.FieldByName('SumDoc').AsFloat;
                   end;

                  add('');
                  add('   Количество годовых заказов: ' + IntToStr(i) + ' на ' + FormatFloat('0.00', j) + ' руб.');

                  NumberQuery.Close;
                  NumberQuery.ParamByName('Value').AsInteger := 2;
                  NumberQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
                  NumberQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
                  NumberQuery.Open;

                  i := 0;
                  j := 0;
                  If SelectCombo.ItemIndex = 0 Then
                  begin
                     i := NumberQuery.FieldByName('Num').AsInteger;
                     j := NumberQuery.FieldByName('SumDoc').AsFloat;
                     NumberQuery.Next;
                     i := i + NumberQuery.FieldByName('Num').AsInteger;
                     j := j + NumberQuery.FieldByName('SumDoc').AsFloat;
                  end
                   else
                   begin
                      i := NumberQuery.FieldByName('Num').AsInteger;
                      j := NumberQuery.FieldByName('SumDoc').AsFloat;
                   end;

                  add('');
                  add('Количество неплановых заказов: ' + IntToStr(i) + ' на ' + FormatFloat('0.00',j) + ' руб.');
              end;
              add('');
              add('');
              add('');
              add('  Начальник производства  _______________________ '
                + GetSystemParams('Manager'));
              add('');
              add('');
              add('');
              add('');
              add('  Ведущий экономист '
                 + GetSystemParams('Service')
                 + ' _______________________ '
                 + GetSystemParams('Economist'));
        end;
        PrForm.Destroy;

        Form.Caption := 'Отчет о выполненных услугах';
        Form.Editor.show;
        Form.show;

end;

procedure TReport16Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PDRQuery, PDRCombo, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);
end;

procedure TReport16Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PDRQuery, PDRCombo, key, Shift, 1) = false then
    PDRComboButtonClick(Sender);

end;

procedure TReport16Form.CancelButtonClick(Sender: TObject);
begin
        Close;
end;

procedure TReport16Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport16Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
