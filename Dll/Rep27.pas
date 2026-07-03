{***************************************************************
 *
 * Модуль   : Rep27
 * Описание : Отчет для R3 о незавершенном производстве
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep27;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, ToolEdit, Mask, EnumForm4Sel;

type
  TReport27Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    PdrCombo: TComboEdit;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    OkButton: TButton;
    CancelButton: TButton;
    SelectCombo: TComboBox;
    MainQuery: TQuery;
    XZQuery: TQuery;
    PdrQuery: TQuery;
    MtrfQuery: TQuery;
    NmntQuery: TQuery;
    NamePdrQuery: TQuery;
    OperCheckBox: TCheckBox;
    ZakQuery: TQuery;
    SmallCheckBox: TCheckBox;
    ButtonSelPer: TButton;
    NumberQuery: TQuery;
    CheckBox1: TCheckBox;
    procedure OkButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OperCheckBoxClick(Sender: TObject);
    procedure SmallCheckBoxClick(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LISTForm : TLIST_4SELECTForm;
  end;

var
  Report27Form: TReport27Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;


{$R *.DFM}

procedure TReport27Form.OkButtonClick(Sender: TObject);
Var    i : Integer;
    sstr : String; //Переменная для сбора очередной строки
  SumCex : Real;   //Сумма по цеховым расходам
  SumCst : Real;    //Сумма прочих расходов
  PdrStr : String;  //Сортировка по подразделению
  CstStr : String;  //счетчик показывает что я все еще вывожу акты одного заказчика
 CostStr : Integer; //(0, 1) Ремонт или изготовление
DateOpen : TDateTime;    //Дата начала работы по заказу
  nZak   : Integer; //id заказа для правильного подсчета суммы затрат до начала периода
  CstKol, CstMat, CstZP, CstFond, CstRS, CstCex, CstPr, CstAll : Real;
  PdrKol, PdrMat, PdrZP, PdrFond, PdrRS, PdrCex, PdrPr, PdrAll : Real;
  RemKol, RemMat, RemZP, RemFond, RemRS, RemCex, RemPr, RemAll : Real;
  AllKol, AllMat, AllZP, AllFond, AllRS, AllCex, AllPr, AllAll : Double;
  DoCstAll, DoPdrAll, DoRemAll, DoAllAll : Double;
  KolPos : Integer;
// Vid_Chrt : Integer;
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
        RemKol:=0;
        RemMat:=0;
        RemZP:=0;
        RemFond:=0;
        RemRS:=0;
        RemCex:=0;
        RemPr:=0;
        RemAll:=0;
        DoRemAll:=0;

        AllKol:=0;
        AllMat:=0;
        AllZP:=0;
        AllFond:=0;
        AllRS:=0;
        AllCex:=0;
        AllPr:=0;
        AllAll:=0;
        DoAllAll:=0;
        NZak:=0;
        KolPos:=0;

        MainQuery.Close;
        MainQuery.SQL.Clear;

        // поле отбора
        MainQuery.SQL.Add('Select ID_PDR_RQST, CODE_CST, NAME_CST, NUMDOC,');
        MainQuery.SQL.Add('       NUMBER_F, NUMBER, CODE_PLANT, CODE_CHRT,');
        MainQuery.SQL.Add('       NAME_CHRT, ID_ORDER, VID_CHRT, CODE_PDR_Z,');
        MainQuery.SQL.Add('       NAME_PDR_Z, CODE_PDR, CODE_COUNT, IS_INSTR,');
        MainQuery.SQL.Add('       CODE_EQPT, LINENO, NAME_VOP, ID_CALC, NVALUE,');
        MainQuery.SQL.Add('       CODE_NMNT, NAME_NMNT, NVALUEOLD');
        MainQuery.SQL.Add('From REPORT_27_PROCEDURE(:date_beg, :date_end, :id_pdr, :oper, :vid_ch)');
//        MainQuery.SQL.Add('Order By 11, 1, 2, 6');

        MainQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
        MainQuery.ParamByName('date_end').AsString := EndDateEdit.Text;

        If PDRQuery.Active Then
        begin
            MainQuery.ParamByName('id_pdr').AsInteger:= PdrQuery.FieldByName('ID').AsInteger;
        end
         else MainQuery.ParamByName('id_pdr').AsInteger:=0;

        //с расшифровкой по операциям
        If OperCheckBox.Checked = True Then
             MainQuery.ParamByName('oper').AsInteger:=1
         else //без расшифровки
               MainQuery.ParamByName('oper').AsInteger :=0;

        MainQuery.ParamByName('vid_ch').AsInteger:= SelectCombo.ItemIndex;

        MainQuery.Open;

        i:=0;
        PrForm.Show;

        // формирование строк
        with Form.Editor.lines do
        begin

          clear;
          add( RepeatLine('-', 206));
          add( '');
          add( '');
          add( LeftLine('АО "Архангельский ЦБК"',206));
          add( LeftLine('РМП',206));
          add( '');
          add( LeftLine('Дата распечатки: '+DateToStr(Date)+', время: '+TimeToStr(Time),206));
          add( LeftLine('Отчет о незавершенном производстве',206));

          add(' ');

          case SelectCombo.ItemIndex of
            0: add('Все данные');
            1: add('Данные по производству');
            2: add('Данные по услугам');

          end;

          If SmallCheckBox.Checked = True Then
          begin
             add( '');
             add( '');
             add( CentrLine('C '+BegDateEdit.Text+' по '+EndDateEdit.Text,206));
             add( RepeatLine('-', 206));
             add( '     № заказа     |        ОСЧ         |№ материала |          Вид работ          |  Сальдо на   | Материалы | Основная з/п | Отчислен.  |Общепроизвод|   Всего    |   Прочие   |     ВСЕГО    |    ВСЕГО     |');
             add( '                  |                    | Количество |                             |    начало    |   план    |     план     |  в фонды   |  ственные  |   цех с/с  |   расходы  |  расходы за  | по заказу на |');
             add( '                  |                    |            |                             |    месяца    |           |              |    план    |   расходы  |    план    |    план    |     месяц    | конец месяца |');
             add( RepeatLine('-', 206));
          end;   

          //цикл по количеству заказов
          While not MainQuery.Eof do
          begin

             PrForm.ProgressBar.Position:=(i+1)*100 div MainQuery.RecordCount;

             NamePdrQuery.Close;
             NamePdrQuery.ParamByName('id').AsInteger:=MainQuery.FieldByName('ID_PDR_RQST').AsInteger;
             NamePdrQuery.Open;

             // вывод шапки отчета
             If SmallCheckBox.Checked = False Then
             begin
                add( '');
                add( '');
                add( LeftLine('Отправитель: '+NamePdrQuery.FieldByName('CODE').AsString+
                       ' '+NamePdrQuery.FieldByName('NAME').AsString,206));
                add( CentrLine('C '+BegDateEdit.Text+' по '+EndDateEdit.Text,206));
                add( RepeatLine('-', 206));
                add( '     № заказа     |        ОСЧ         |№ материала |          Вид работ          |  Сальдо на   | Материалы | Основная з/п | Отчислен.  |Общепроизвод|   Всего    |   Прочие   |     ВСЕГО    |    ВСЕГО     |');
                add( '                  |                    | Количество |                             |    начало    |   план    |     план     |  в фонды   |  ственные  |   цех с/с  |   расходы  |  расходы за  | по заказу на |');
                add( '                  |                    |            |                             |    месяца    |           |              |    план    |   расходы  |    план    |    план    |     месяц    | конец месяца |');
                add( RepeatLine('-', 206));
             end;

             CstStr:=MainQuery.FieldByName('CODE_CST').AsString;
             CostStr:=MainQuery.FieldByName('VID_CHRT').AsInteger;

             If SmallCheckBox.Checked = False Then
             begin
                //если изготовление то получателя не печатаем
                If CostStr = 1 Then
                    add('Получатель:   '+MainQuery.FieldByName('CODE_PDR_Z').AsString+
                                ' '+MainQuery.FieldByName('NAME_PDR_Z').AsString)
                else
//                    add('Получатель:    Материалы');
                    add('Получатель:   ('+MainQuery.FieldByName('CODE_CST').AsString+
                                ') '+MainQuery.FieldByName('NAME_CST').AsString)
             end;

             PdrStr:=NamePdrQuery.FieldByName('ID').AsString;

             PdrKol:=0;
             PdrMat:=0;
             PdrZP:=0;
             PdrFond:=0;
             PdrRS:=0;
             PdrCex:=0;
             PdrPr:=0;
             PdrAll:=0;
             DoPdrAll:=0;

             CstKol:=0;
             CstMat:=0;
             CstZP:=0;
             CstFond:=0;
             CstRS:=0;
             CstCex:=0;
             CstPr:=0;
             CstAll:=0;
             DoCstAll:=0;

             While (MainQuery.FieldByName('ID_PDR_RQST').AsString = PdrStr) and
                   (not MainQuery.Eof) do
             begin

                //Если заказчик появился первый раз выводим
                If (MainQuery.FieldByName('CODE_CST').AsString <> CstStr) Then
                begin
                     CostStr:=MainQuery.FieldByName('VID_CHRT').AsInteger;

                     If SmallCheckBox.Checked = False Then
                     begin
                       //если изготовление то получателя не печатаем
                       If CostStr = 1 Then
                       begin
                          add('Получатель:   '+MainQuery.FieldByName('CODE_PDR_Z').AsString+
                                      ' '+MainQuery.FieldByName('NAME_PDR_Z').AsString);
                          CstKol:=0;
                          CstMat:=0;
                          CstZP:=0;
                          CstFond:=0;
                          CstRS:=0;
                          CstCex:=0;
                          CstPr:=0;
                          CstAll:=0;
                          DoCstAll:=0;
                       end
                        else
                        begin
//                          add('Получатель:    Материалы');
                    add('Получатель:   ('+MainQuery.FieldByName('CODE_CST').AsString+
                                ') '+MainQuery.FieldByName('NAME_CST').AsString);
                    CstKol:=0;
                    CstMat:=0;
                    CstZP:=0;
                    CstFond:=0;
                    CstRS:=0;
                    CstCex:=0;
                    CstPr:=0;
                    CstAll:=0;
                    DoCstAll:=0;
                        end;
                     end;

                     CstStr:=MainQuery.FieldByName('CODE_CST').AsString;

                end;

                SumCex:=0;
                SumCst:=0;
                sstr:='';

                sstr:=sstr+RightLine(MainQuery.FieldByName('NUMBER').AsString,18)+' '; //+
//                        RightLine(MainQuery.FieldByName('NUMDOC').AsString,11)+' ';

                //если предприятие внутреннее
                if MainQuery.FieldByName('IS_INSTR').AsInteger = 1  Then
                begin
                   //Если Vid_Chrt = 1 то производится ремонт иначе изготовление
                   If MainQuery.FieldByName('VID_CHRT').AsInteger = 1 Then
                       sstr:=sstr+RepeatLine(' ',20)+' '
//                     sstr:=sstr+RightLine(MainQuery.FieldByName('CODE_PDR').AsString,10)+' '
                    else
                       sstr:=sstr+RepeatLine(' ',20)+' ';
//                       sstr:=sstr+RightLine(MainQuery.FieldByName('CODE_PLANT').AsString,10)+' ';
                end
                 else
                 begin  //если заказ на Заказ (=2)
                      If MainQuery.FieldByName('IS_INSTR').AsInteger = 2  Then
                          sstr:=sstr+RightLine(MainQuery.FieldByName('NAME_CST').AsString,20)+' '
                       else //если заказчик внешний (=1)
                          sstr:=sstr+RightLine(MainQuery.FieldByName('CODE_COUNT').AsString,20)+' ';
                 end;

                //Если Vid_Chrt = 1 то производится ремонт иначе изготовление
                If MainQuery.FieldByName('VID_CHRT').AsInteger = 1 Then
                    sstr:=sstr+RightLine(MainQuery.FieldByName('CODE_EQPT').AsString, 12)+' '+
                               LeftLine(MainQuery.FieldByName('NAME_NMNT').AsString,29)+' '
                 else
                 begin
                    sstr:=sstr+RightLine(MainQuery.FieldByName('CODE_NMNT').AsString,12)+' '+
                               LeftLine(MainQuery.FieldByName('NAME_CHRT').AsString,29)+' ';
                 end;

                //Сумма по полю ID = 12 "Всего" операций сделанных до даты начала требуемого периода
                If NZak <> MainQuery.FieldByName('ID_ORDER').AsInteger Then
                begin
                    DoCstAll := DoCstAll + MainQuery.FieldByName('NVALUEOLD').AsFloat;
                    DoPdrAll := DoPdrAll + MainQuery.FieldByName('NVALUEOLD').AsFloat;
                    DoRemAll := DoRemAll + MainQuery.FieldByName('NVALUEOLD').AsFloat;
                    DoAllAll := DoAllAll + MainQuery.FieldByName('NVALUEOLD').AsFloat;
                    NZak := MainQuery.FieldByName('ID_ORDER').AsInteger;
                end;
                sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('NVALUEOLD').AsFloat), 14)+' ';

                //В справочнике Spr_Calc, поле ID = 1 означает "Материалы"
                sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('NVALUE').AsFloat), 11)+' ';
                SumCex:=SumCex+MainQuery.FieldByName('NVALUE').AsFloat;
                CstMat:=CstMat+MainQuery.FieldByName('NVALUE').AsFloat;
                PdrMat:=PdrMat+MainQuery.FieldByName('NVALUE').AsFloat;
                RemMat:=RemMat+MainQuery.FieldByName('NVALUE').AsFloat;
                AllMat:=AllMat+MainQuery.FieldByName('NVALUE').AsFloat;
                MainQuery.Next;
                i:=i+1;

                //В справочнике Spr_Calc, поле ID = 3 означает "Заработаную плату"
                sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('NVALUE').AsFloat), 14)+' ';
                SumCex:=SumCex+MainQuery.FieldByName('NVALUE').AsFloat;
                CstZP:=CstZP+MainQuery.FieldByName('NVALUE').AsFloat;
                PdrZP:=PdrZP+MainQuery.FieldByName('NVALUE').AsFloat;
                RemZP:=RemZP+MainQuery.FieldByName('NVALUE').AsFloat;
                AllZP:=AllZP+MainQuery.FieldByName('NVALUE').AsFloat;
                MainQuery.Next;
                i:=i+1;

                //В справочнике Spr_Calc, поле ID = 4 означает "Отчисления на соц нужды"
                sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('NVALUE').AsFloat), 12)+' ';
                SumCex:=SumCex+MainQuery.FieldByName('NVALUE').AsFloat;
                CstFond:=CstFond+MainQuery.FieldByName('NVALUE').AsFloat;
                PdrFond:=PdrFond+MainQuery.FieldByName('NVALUE').AsFloat;
                RemFond:=RemFond+MainQuery.FieldByName('NVALUE').AsFloat;
                AllFond:=AllFond+MainQuery.FieldByName('NVALUE').AsFloat;
                MainQuery.Next;
                i:=i+1;

                //В справочнике Spr_Calc, поле ID = 5 означает "Накладные расходы"
                sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('NVALUE').AsFloat), 12)+' ';
                SumCex:=SumCex+MainQuery.FieldByName('NVALUE').AsFloat;
                CstRS:=CstRS+MainQuery.FieldByName('NVALUE').AsFloat;
                PdrRS:=PdrRS+MainQuery.FieldByName('NVALUE').AsFloat;
                RemRS:=RemRS+MainQuery.FieldByName('NVALUE').AsFloat;
                AllRS:=AllRS+MainQuery.FieldByName('NVALUE').AsFloat;
                MainQuery.Next;
                i:=i+1;

                //Всего цеховые
                sstr:=sstr+RightLine(FormatFloat( '0.00',SumCex),12)+' ';
                CstCex:=CstCex+SumCex;
                PdrCex:=PdrCex+SumCex;
                RemCex:=RemCex+SumCex;
                AllCex:=AllCex+SumCex;

                //В справочнике Spr_Calc, поле ID = 7 означает "Общезаводские расходы"
//                sstr:=sstr+RightLine(FormatFloat( '0.00',XZQuery.FieldByName('NVALUE').AsFloat), 13)+' ';
                SumCst:=SumCst+MainQuery.FieldByName('NVALUE').AsFloat;
                MainQuery.Next;
                i:=i+1;

                //В справочнике Spr_Calc, поле ID = 9 означает "Плановая накопления (прибыль)"
//                sstr:=sstr+RightLine(FormatFloat( '0.00',XZQuery.FieldByName('NVALUE').AsFloat), 10)+' ';
                SumCst:=SumCst+MainQuery.FieldByName('NVALUE').AsFloat;
                MainQuery.Next;
                i:=i+1;

                //Прочие
//                sstr:=sstr+RepeatLine(' ',15);
                sstr:=sstr+RightLine(FormatFloat( '0.00',SumCst),12)+' ';
                CstPr:=CstPr+SumCst;
                PdrPr:=PdrPr+SumCst;
                RemPr:=RemPr+SumCst;
                AllPr:=AllPr+SumCst;

                //Всего
                //В справочнике Spr_Calc, поле ID = 12 означает "Всего"
                sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('NVALUE').AsFloat), 14)+' ';

                CstAll:=CstAll+SumCex+SumCst;
                PdrAll:=PdrAll+SumCex+SumCst;
                RemAll:=RemAll+SumCex+SumCst;
                AllAll:=AllAll+SumCex+SumCst;

                //Всего
                //В справочнике Spr_Calc, поле ID = 12 означает "Всего" операции за период+
                // операций сделанных до даты начала требуемого периода
                sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('NVALUE').AsFloat+
                                                         MainQuery.FieldByName('NVALUEOLD').AsFloat), 14)+' ';

                If SmallCheckBox.Checked = False Then
                   add( sstr);

                sstr:='';
                if MainQuery.FieldByName('CODE_EQPT').AsString <> '' Then
                    sstr:='Инв № '+ LeftLine(MainQuery.FieldByName('CODE_EQPT').AsString,12)
                 else sstr:=RepeatLine(' ' , 18);

                //Если Vid_Chrt = 0 то производится изготовление
                If (MainQuery.FieldByName('VID_CHRT').AsInteger = 0) or
                     (MainQuery.FieldByName('VID_CHRT').isnull) Then
                begin
                    sstr:=sstr+RepeatLine(' ', 12) +
                               RightLine(MainQuery.FieldByName('CODE_PLANT').AsString, 12)+' '+
                               LeftLine(MainQuery.FieldByName('NUMBER_F').AsString, 29);

                    CstKol:=CstKol+MainQuery.FieldByName('NUMBER_F').AsFloat;
                    PdrKol:=PdrKol+MainQuery.FieldByName('NUMBER_F').AsFloat;
                    RemKol:=RemKol+MainQuery.FieldByName('NUMBER_F').AsFloat;
                    AllKol:=AllKol+MainQuery.FieldByName('NUMBER_F').AsFloat;
                end
                 else sstr:=sstr+RepeatLine(' ' , 36);

                //дописываю название операции
                If OperCheckBox.Checked = True Then
                      sstr:=sstr+LeftLine(MainQuery.FieldByName('NAME_VOP').AsString, 29);

                If SmallCheckBox.Checked = False Then
                     add(sstr);

                MainQuery.Next;
                i:=i+1;
                KolPos:=KolPos+1;

                If SmallCheckBox.Checked = False Then
                begin

                    //Если заказчик появился первый раз выводим
                    If (MainQuery.FieldByName('CODE_CST').AsString <> CstStr) {and
                       (MainQuery.FieldByName('VID_CHRT').AsInteger = 1)} or
                          (MainQuery.Eof) Then
                    begin
                        sstr:='';
                        add(RepeatLine('-', 206));
                        sstr:='Итого по получателю ';
                        //если изготовление то получателя не печатаем
                        {If CostStr = 1 Then
                            sstr:=sstr+LeftLine(CstStr,10)+': '+LeftLine(IntToStr(KolPos), 10)
                          else}
                             sstr:=sstr+': '+LeftLine(IntToStr(KolPos), 11)+RepeatLine(' ', 20);
                        sstr:=sstr+
                        LeftLine(FormatFloat('0.00', CstKol), 29)+' '+
                        RightLine(FormatFloat('0.00', DoCstAll), 14)+' '+
                        RightLine(FormatFloat('0.00', CstMat), 11)+' '+
                        RightLine(FormatFloat('0.00', CstZP), 14)+' '+
                        RightLine(FormatFloat('0.00', CstFond), 12)+' '+
                        RightLine(FormatFloat('0.00', CstRS), 12)+' '+
                        RightLine(FormatFloat('0.00', CstCex), 12)+' '+
                        RightLine(FormatFloat('0.00', CstPr), 12)+' '+
                        RightLine(FormatFloat('0.00', CstAll), 14)+' '+
                        RightLine(FormatFloat('0.00', CstAll+DoCstAll), 14);
                        add(sstr);
                        add('');
                        KolPos:=0;
                    end;

                    If (CostStr <> MainQuery.FieldByName('VID_CHRT').AsInteger) or
                       (MainQuery.Eof) Then
                    begin

                       If SmallCheckBox.Checked = False Then
                           add( RepeatLine('~', 206));

                       if (CostStr = 0) Then
                       begin
                          add('Всего по изготовлению:   '+
                              LeftLine(NamePdrQuery.FieldByName('CODE').AsString,10)+
                              RepeatLine(' ',10)+
                              RepeatLine(' ', 8)+
                              LeftLine(FormatFloat('0.00', RemKol), 29)+' '+
                              RightLine(FormatFloat('0.00', DoRemAll), 14)+' '+
                              RightLine(FormatFloat('0.00', RemMat), 11)+' '+
                              RightLine(FormatFloat('0.00', RemZP), 14)+' '+
                              RightLine(FormatFloat('0.00', RemFond), 12)+' '+
                              RightLine(FormatFloat('0.00', RemRS), 12)+' '+
                              RightLine(FormatFloat('0.00', RemCex), 12)+' '+
                              RightLine(FormatFloat('0.00', RemPr), 12)+' '+
                              RightLine(FormatFloat('0.00', RemAll), 14)+' '+
                              RightLine(FormatFloat('0.00', RemAll+DoRemAll), 14));
                              add('');
                       end
                        else
                        begin
                           add('Всего по ремонтам:       '+
                               LeftLine(NamePdrQuery.FieldByName('CODE').AsString,10)+
                               RepeatLine(' ',10)+
                               RepeatLine(' ', 8)+
                               LeftLine(FormatFloat('0.00', RemKol), 29)+' '+
                               RightLine(FormatFloat('0.00', DoRemAll), 14)+' '+
                               RightLine(FormatFloat('0.00', RemMat), 11)+' '+
                               RightLine(FormatFloat('0.00', RemZP), 14)+' '+
                               RightLine(FormatFloat('0.00', RemFond), 12)+' '+
                               RightLine(FormatFloat('0.00', RemRS), 12)+' '+
                               RightLine(FormatFloat('0.00', RemCex), 12)+' '+
                               RightLine(FormatFloat('0.00', RemPr), 12)+' '+
                               RightLine(FormatFloat('0.00', RemAll), 14)+' '+
                               RightLine(FormatFloat('0.00', RemAll+DoRemAll), 14));
                               add('');
                        end;

                       RemKol:=0;
                       RemMat:=0;
                       RemZP:=0;
                       RemFond:=0;
                       RemRS:=0;
                       RemCex:=0;
                       RemPr:=0;
                       RemAll:=0;
                       DoRemAll:=0;

                    end;
                end;
             end;

             If SmallCheckBox.Checked = False Then
                   add( RepeatLine('=', 206));

             add('Всего по подразделению:  '+
                 LeftLine(NamePdrQuery.FieldByName('CODE').AsString,10)+
                 RepeatLine(' ',10)+
                 RepeatLine(' ', 8)+
                 LeftLine(FormatFloat('0.00', PdrKol), 29)+' '+
                 RightLine(FormatFloat('0.00', DoPdrAll), 14)+' '+
                 RightLine(FormatFloat('0.00', PdrMat), 11)+' '+
                 RightLine(FormatFloat('0.00', PdrZP), 14)+' '+
                 RightLine(FormatFloat('0.00', PdrFond), 12)+' '+
                 RightLine(FormatFloat('0.00', PdrRS), 12)+' '+
                 RightLine(FormatFloat('0.00', PdrCex), 12)+' '+
                 RightLine(FormatFloat('0.00', PdrPr), 12)+' '+
                 RightLine(FormatFloat('0.00', PdrAll), 14)+' '+
                 RightLine(FormatFloat('0.00', PdrAll+DoPdrAll), 14));
          end;
          add('');
          add('');
          add(RepeatLine('*', 206));
          add('ВСЕГО:  '+RepeatLine(' ', 45)+
              LeftLine(FormatFloat('0.00', AllKol), 29)+' '+
              RightLine(FormatFloat('0.00', DoAllAll), 14)+' '+
              RightLine(FormatFloat('0.00', AllMat), 11)+' '+
              RightLine(FormatFloat('0.00', AllZP), 14)+' '+
              RightLine(FormatFloat('0.00', AllFond), 12)+' '+
              RightLine(FormatFloat('0.00', AllRS), 12)+' '+
              RightLine(FormatFloat('0.00', AllCex), 12)+' '+
              RightLine(FormatFloat('0.00', AllPr), 12)+' '+
              RightLine(FormatFloat('0.00', AllAll), 14)+' '+
              RightLine(FormatFloat('0.00', AllAll+DoAllAll), 14));

              add('');
              add('');
              add('');
              // div 7 - количество статей
              add(LeftLine('           Количество заказов: '+ IntToStr(MainQuery.RecordCount div 7),175));
              If CheckBox1.Checked = True Then
              begin
                  NumberQuery.Close;
                  NumberQuery.ParamByName('Value').AsInteger := 0;
                  NumberQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
                  NumberQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
                  NumberQuery.Open;

                  add('');
                  add('  Количество плановых заказов: ' + NumberQuery.FieldByName('Num').AsString); //+
//                      ' на ' + FormatFloat('0.00', NumberQuery.FieldByName('SumDoc').AsFloat) + ' руб.');

                  NumberQuery.Close;
                  NumberQuery.ParamByName('Value').AsInteger := 1;
                  NumberQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
                  NumberQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
                  NumberQuery.Open;

                  add('');
                  add('   Количество годовых заказов: ' + NumberQuery.FieldByName('Num').AsString); //+
//                      ' на ' + FormatFloat('0.00', NumberQuery.FieldByName('SumDoc').AsFloat) + ' руб.');

                  NumberQuery.Close;
                  NumberQuery.ParamByName('Value').AsInteger := 2;
                  NumberQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
                  NumberQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
                  NumberQuery.Open;

                  add('');
                  add('Количество неплановых заказов: ' + NumberQuery.FieldByName('Num').AsString); //+
//                      ' на ' + FormatFloat('0.00', NumberQuery.FieldByName('SumDoc').AsFloat) + ' руб.');
                  
              end;


              add('');
              add('');
              add('');
              add('  Начальник производства РМП  _______________________ '+ GetSystemParams('Manager') ); //Захаров В.И.');
              add('');
              add('');
              add('');
              add('');
              add('  Ведущий экономист РМП       _______________________ '+ GetSystemParams('Economist') ); //Шмаков Ю.А.');
        end;
        PrForm.Destroy;

        Form.Caption := 'Отчет о незавершенном производстве';
        Form.Editor.show;
        Form.show;

end;

procedure TReport27Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ListForm := TLIST_4SELECTForm.create(self);

  SelectCombo.ItemIndex := 0;
end;                                     

procedure TReport27Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PDRQuery, PDRCombo, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);

end;

procedure TReport27Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PDRQuery, PDRCombo, key, Shift, 1) = false then
    PDRComboButtonClick(Sender);
end;

procedure TReport27Form.CancelButtonClick(Sender: TObject);
begin
        Close;
end;

procedure TReport27Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport27Form.OperCheckBoxClick(Sender: TObject);
begin
    If OperCheckBox.Checked = True Then
    begin
        OperCheckBox.Font.Style := [fsBold];
        SmallCheckBox.Checked := False;
        SmallCheckBox.Font.Style := [];
    end
     else
        OperCheckBox.Font.Style := [];
end;

procedure TReport27Form.SmallCheckBoxClick(Sender: TObject);
begin
    If SmallCheckBox.Checked = True Then
    begin
        SmallCheckBox.Font.Style := [fsBold];
        OperCheckBox.Checked := False;
        OperCheckBox.Font.Style := [];
    end
     else
        SmallCheckBox.Font.Style := [];

end;

procedure TReport27Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
