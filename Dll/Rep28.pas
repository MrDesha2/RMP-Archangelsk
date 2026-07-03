{***************************************************************
 *
 * Unit Name: Rep28
 * Purpose  :
 * Author   : Косицын Дмитрий
 * History  :
 *        Ведомость по материалам
 ****************************************************************}

unit Rep28;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ToolEdit, Mask, Db, DBTables, EnumForm4Sel;

type
  TReport28Form = class(TForm)
    qNMNTQuery: TQuery;
    qWRHSQuery: TQuery;
    qMainQuery: TQuery;
    Panel1: TPanel;
    ButtonDo: TButton;
    ButtonCancel: TButton;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    NMNTCombo: TComboEdit;
    WRHSCombo: TComboEdit;
    ButtonSetPer: TButton;
    Panel4: TPanel;
    CheckAdd: TCheckBox;
    RadioGroup: TRadioGroup;
    RadioButton2: TRadioButton;
    RadioButton1: TRadioButton;
    Panel3: TPanel;
    RadioMTR: TRadioButton;
    RadioProd: TRadioButton;
    CheckDetail: TCheckBox;
    Label6: TLabel;
    CSTCombo: TComboEdit;
    qCSTQuery: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure ButtonDoClick(Sender: TObject);
    procedure NMNTComboButtonClick(Sender: TObject);
    procedure NMNTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure WRHSComboButtonClick(Sender: TObject);
    procedure WRHSComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSetPerClick(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure CSTComboButtonClick(Sender: TObject);
    procedure CSTComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    LISTForm : TLIST_4SELECTForm;
  end;

var
  Report28Form: TReport28Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;


{$R *.DFM}

procedure TReport28Form.FormCreate(Sender: TObject);
begin
  RadioButton1.Checked := true;

  ListForm := TLIST_4SELECTForm.create(Application);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);

end;



procedure TReport28Form.ButtonDoClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       n : integer;
       datebeg, dateend : tdatetime;
       Hour, Min, Sec, MSec: Word;
       tmptime  : tdatetime;
       typeDoc  : integer;
       sum_1, sum_2, sum_3, sum_4: real;
       NMNT : string;
       i : integer;

begin
         if RadioButton1.Checked then
           if (NMNTCombo.text = '') or (not qNMNTQuery.active) then
             begin
               MessageDlg('Номенклатура обязательно должна быть выбрана.', mtWarning, [mbOK], 0);
               exit;
             end;

        datebeg := strtodate(begdateedit.text);
        dateend := strtodate(enddateedit.text);
          if datebeg > dateend then
            begin
              MessageDlg('Дата начала больше даты окончания', mtError, [mbOK], 0);
              exit;
            end;


       // тип формы отчета выбирается в форме
       // 0 - только по материалам
       // 2 - только по готовой продукции

       if RadioMTR.Checked then
         typedoc := 2
       else
         typedoc := 0;

       sum_1 :=0; sum_2 := 0; sum_3 := 0; sum_4 := 0;
       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(application);
       PrForm  := TProcessForm.create(application);
       Form.Editor.visible := false;

       If (trim(BegDateEdit.Text) = '.  .') or (trim(EndDateEdit.Text) = '.  .') Then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

      PrForm.Show;



      // Перестройка дат интервала.
      // Дата начала - время начало дня.
      // Дата окончания - время конец дня.
      Hour    := 0; Min := 0; Sec := 0; MSec := 0;
      tmptime := Encodetime(Hour, Min, Sec, MSec);
      ReplaceTime(datebeg, tmptime);

      Hour := 23; Min := 59; Sec := 59; MSec := 0;
      tmptime := Encodetime(Hour, Min, Sec, MSec);
      ReplaceTime(dateend, tmptime);



       // формирование карточки складского учета
       if RadioButton1.Checked then

         begin
           with qMainQuery.sql do
            begin
               clear;
               add('select * ');
               add(' from REPORT_CARD_PROCEDURE(:typedoc, ');
               add('  :id_nmnt, :datebeg, :dateend, :id_wrhs, :id_cst, :is_extended)');

            end;

            if not checkadd.Checked then
              n := 109
            else
              n := 122;

           // формирование строк
            with Form.Editor.lines do
             begin
                clear;
                     // формирование шапки отчета
                     add(RepeatLine('-', n));
                     add('');
                     add('');
                     add(CentrLine('Карточка складского учета', n));
                     if RadioMTR.Checked then
                       add('По материалам')
                     else
                       add('По готовой продукции');

                     add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,n));
                     add('');
                     add('Номенклатура:  ' + NMNTCombo.text + '    Ном. номер: ' + qNMNTQuery.Fieldbyname('Code').asstring);
                        if (WRHSCombo.text <> '') and (qWRHSQuery.active) then
                         add('По складу :  ' + WRHSCombo.text);

                     add('');
                     add(RepeatLine('-', n));
                     if not CheckAdd.Checked then
                        begin
                         add('|  Дата / Документ      |   Нач.    |  Приход  |  Расход  |   Кон.   |     Заказчик        | Заявка/Заказ  |');
                         add('|                       |  остаток  |          |          |  остаток |                     |               |');
                         add(RepeatLine('-', n));
                        end
                      else
                        begin
                         add('|  Дата / Документ      |         Нач. остаток   |        Приход         |        Расход         |       Кон. остаток    |');
                         add('|                       |  количество     вес    |  количество     вес   |  количество     вес   |  количество     вес   |');
                         add(RepeatLine('-', n));

                        end;

                 // карточка формируется по дням интервала

                     // формирование запроса из хранимой процедуры
                    with qMainQuery do
                      begin
                        close;

                        parambyname('id_nmnt').asinteger := qNMNTQuery.FieldbyName('ID').asinteger;

                        if (WRHSCombo.text <> '') and (qWRHSQuery.active) then
                          parambyname('id_wrhs').asinteger := qWRHSQuery.FieldbyName('ID').asinteger
                        else
                          parambyname('id_wrhs').asinteger := -1;


                        if (CSTCombo.text <> '') and (qCSTQuery.active) then
                          parambyname('id_cst').asinteger := qCSTQuery.FieldbyName('ID').asinteger
                        else
                          parambyname('id_cst').asinteger := -1;


                        parambyname('typedoc').asinteger := typedoc;
                        // расширенная для Литейного цеха
                        if checkadd.checked then
                          parambyname('is_extended').asstring := '1'
                         else
                           parambyname('is_extended').asstring := '';

                        // преобразование времени дат
                        Hour    := 0; Min := 0; Sec := 0; MSec := 0;
                        tmptime := Encodetime(Hour, Min, Sec, MSec);
                        ReplaceTime(datebeg, tmptime);
                        parambyname('datebeg').AsDateTime    := datebeg;

                        Hour := 23; Min := 59; Sec := 59; MSec := 0;
                        tmptime := Encodetime(Hour, Min, Sec, MSec);
                        ReplaceTime(dateend, tmptime);

                        parambyname('dateend').AsDateTime    := dateend;

                        open;

                      end;

                      // цикл по запросу
                      qMainQuery.first;
                      i := 0;
                      while not qMainQuery.eof do
                       begin

                         PrForm.ProgressBar.Position:=(i)*100 div qMainQuery.RecordCount;
                         i := i + 1;

                         if not CheckAdd.Checked then
                             Form.Editor.lines.add('|' +
                             LeftLine(datetostr(qMainQuery.fields[6].AsDateTime) + '/' +
                                     qMainQuery.fields[7].asstring
                                      , 22) +
                             ' | ' +
                             RightLine(Formatfloat('0.000',qMainQuery.fields[2].Asfloat), 10) +
                             '|' +
                             RightLine(Formatfloat('0.000',qMainQuery.fields[3].Asfloat), 10) +
                             '|' +
                             RightLine(Formatfloat('0.000',qMainQuery.fields[4].Asfloat), 10) +
                             '|' +
                             RightLine(Formatfloat('0.000',qMainQuery.fields[5].Asfloat), 10) +
                             '|' +
                             LeftLine(qMainQuery.fieldbyname('CST_NAME').Asstring, 21) +
                             '|' +
                             LeftLine(qMainQuery.fieldbyname('NUM_RQST').Asstring, 7) +
                             '/' +
                             LeftLine(qMainQuery.fieldbyname('NUM_ORDER').Asstring, 7) +
                             '|')
                           else
                              Form.Editor.lines.add('|' +
                              LeftLine(datetostr(qMainQuery.fields[6].AsDateTime) + '/' +
                                     qMainQuery.fields[7].asstring
                                      , 22) +
                               ' | ' +
                               RightLine(Formatfloat('0.000',qMainQuery.fields[2].Asfloat), 10) +
                               ' |' +
                               RightLine(Formatfloat('0.000',qMainQuery.fields[8].Asfloat), 10) +
                               ' |' +
                               RightLine(Formatfloat('0.000',qMainQuery.fields[3].Asfloat), 10) +
                               ' |' +
                               RightLine(Formatfloat('0.000',qMainQuery.fields[9].Asfloat), 10) +
                               ' |' +
                               RightLine(Formatfloat('0.000',qMainQuery.fields[4].Asfloat), 10) +
                               ' |' +
                               RightLine(Formatfloat('0.000',qMainQuery.fields[10].Asfloat), 10) +
                               ' |' +
                               RightLine(Formatfloat('0.000',qMainQuery.fields[5].Asfloat), 10) +
                               ' |' +
                               RightLine(Formatfloat('0.000',qMainQuery.fields[11].Asfloat), 10) + ' |' +
                               qMainQuery.fields[12].AsString
                               );




                          qMainQuery.next;
                       end;

                     add(RepeatLine('-', n));


           end;
           Form.Caption := 'Карточка складского учета';

         end

       else
//
//         Формирование оборотной ведомости
//
         begin


           with qMainQuery.sql do
            begin
               clear;
               add('select * ');
               add(' from REPORT_BALANCE_PROCEDURE(:typedoc, ');
               add('  :id_nmnt, :datebeg, :dateend, :id_wrhs, :IS_detail, :is_extended)');

            end;

               if not checkadd.Checked then
                   n := 141
               else
                   n := 209;

          // формирование оборотной ведомости
           with Form.Editor.lines do
            begin
              clear;


               // формирование шапки документа
               add(RepeatLine('-', n));
               add('');
               add('');
               add(CentrLine('Оборотная ведомость', n));
                     if RadioMTR.Checked then
                       add(CentrLine('По материалам', n))
                     else
                       add(CentrLine('По готовой продукции', n));
               add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,n));
               add('');
                        if (WRHSCombo.text <> '') and (qWRHSQuery.active) then
                         add('По складу :  ' + WRHSCombo.text);

               add(RepeatLine('-', n));

               if not checkadd.Checked then
                 begin
                   add('|  Ном.    |               Наименование               |   Нач.    |  Приход   |  Расход   |   Кон.   |     Заказчик        | Заявка/Заказ  |');
                   add('| номер    |                                          |  остаток  |           |           |  остаток |                     |               |');

                 end
                else
                  begin
                   add('|  Ном.    |               Наименование               |     № чертежа      |      Нач. остаток     |       Приход          |         Расход        |      Кон. остаток    |     Заказчик        | Заявка/Заказ  |');
                   add('| номер    |                                          |     и признак      | количество    вес     | количество    вес     |  количество      вес  |  количество      вес |                     |               |');

                  end;

               add(RepeatLine('-', n));

             end;
                 // формирование запроса по хранимой процедуре
                 with qMainQuery do
                    begin
                      close;

                      if (NMNTCombo.text <> '') and (qNMNTQuery.active) then
                        parambyname('id_nmnt').asinteger := qNMNTQuery.FieldbyName('ID').asinteger
                       else
                        parambyname('id_nmnt').asinteger := -1;

                      if (WRHSCombo.text <> '') and (qWRHSQuery.active) then
                        parambyname('id_wrhs').asinteger := qWRHSQuery.FieldbyName('ID').asinteger
                      else
                        parambyname('id_wrhs').asinteger := -1;


                      parambyname('typedoc').asinteger     := typedoc;


                        // расширенная для Литейного цеха
                        if checkadd.checked then
                          parambyname('is_extended').asstring := '1'
                         else
                           parambyname('is_extended').asstring := '';

                      //  Детальный отчет при необходимости
                      //
                      if CheckDetail.Checked then
                        parambyname('IS_detail').asstring  := '1'
                       else
                         parambyname('IS_detail').asstring  := '0';

                      parambyname('datebeg').AsDateTime    := datebeg;
                      parambyname('dateend').AsDateTime    := dateend;

                      open;
                    end;

                    // цикл по запросу и вывод в отчет
                    qMainQuery.first;
                    NMNT := '';
                    i := 0;
                    while not qMainQuery.eof do
                     begin

                         PrForm.ProgressBar.Position:=(i)*100 div qMainQuery.RecordCount;
                         i := i + 1;

                         // Оборотка по всем, кроме литейного цеха
                         if not checkadd.Checked then

                            begin
                               // детально
                              if NMNT <> qMainQuery.fields[0].AsString then
                                begin

                                  Form.Editor.lines.add(' ' +
                                  LeftLine(qMainQuery.fields[0].AsString, 9)
                                   +
                                  ' | ' +
                                  LeftLine(qMainQuery.fields[1].AsString, 40) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[2].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[3].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[4].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[5].Asfloat), 10) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('CST_NAME').Asstring, 21) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('NUM_RQST').Asstring, 7) +
                                  '/' +
                                  LeftLine(qMainQuery.fieldbyname('NUM_ORDER').Asstring, 7) +
                                  '|');
                                   NMNT := qMainQuery.fields[0].AsString;

                                end

                              else

                                begin
                                  Form.Editor.lines.add(' ' +
                                  LeftLine('', 9)
                                  +
                                  ' |   ' +
                                  LeftLine((qMainQuery.fieldbyname('NUMDOC').AsString +
                                            ' от ' +
                                            datetostr(qMainQuery.fieldbyname('DATEDOC').AsDateTime))
                                  , 39) +
                                  '|' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[2].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[3].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[4].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[5].Asfloat), 10) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('CST_NAME').Asstring, 21) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('NUM_RQST').Asstring, 7) +
                                  '/' +
                                  LeftLine(qMainQuery.fieldbyname('NUM_ORDER').Asstring, 7) +
                                  '|')


                                end

                             end


                          else
                            begin
                               // детально
                              if NMNT <> qMainQuery.fields[0].AsString then
                                begin

                                 // формирование строки оборотки для литейного цеха
                                  Form.Editor.lines.add(' ' +
                                  LeftLine(qMainQuery.fields[0].AsString, 9)
                                  +
                                  ' | ' +
                                  LeftLine(qMainQuery.fields[1].AsString, 40) +
                                  ' |' +
                                  LeftLine(qMainQuery.fieldbyname('CHRT_Name').AsString, 17) +
                                  LeftLine('(' + qMainQuery.fieldbyname('PR_CHRT').AsString + ')',3) +
                                  '|' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[2].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[6].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[3].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[7].Asfloat), 10) +
                                  ' |' +
                                   RightLine(Formatfloat('0.000',qMainQuery.fields[4].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[8].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[5].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[9].Asfloat), 10) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('CST_NAME').Asstring, 21) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('NUM_RQST').Asstring, 7) +
                                  '/' +
                                  LeftLine(qMainQuery.fieldbyname('NUM_ORDER').Asstring, 7) +
                                  '|');
                                  NMNT := qMainQuery.fields[0].AsString;


                                end


                              else
                                begin


                                 // формирование строки оборотки для литейного цеха
                                  Form.Editor.lines.add(' ' +
                                  LeftLine('', 9)
                                  +
                                  ' |   ' +
                                  LeftLine((qMainQuery.fieldbyname('NUMDOC').AsString +
                                            ' от ' +
                                            datetostr(qMainQuery.fieldbyname('DATEDOC').AsDateTime))
                                  , 39) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('CHRT_Name').AsString, 17) +
                                  LeftLine('(' + qMainQuery.fieldbyname('PR_CHRT').AsString + ')',3) +
                                  '|' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[2].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[6].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[3].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[7].Asfloat), 10) +
                                  ' |' +
                                   RightLine(Formatfloat('0.000',qMainQuery.fields[4].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[8].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[5].Asfloat), 10) +
                                  ' |' +
                                  RightLine(Formatfloat('0.000',qMainQuery.fields[9].Asfloat), 10) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('CST_NAME').Asstring, 21) +
                                  '|' +
                                  LeftLine(qMainQuery.fieldbyname('NUM_RQST').Asstring, 7) +
                                  '/' +
                                  LeftLine(qMainQuery.fieldbyname('NUM_ORDER').Asstring, 7) +
                                  '|');

                                  NMNT := qMainQuery.fields[0].AsString;

                                end;

                             end;
                             sum_1 := sum_1 + qMainQuery.fields[2].Asfloat;
                             sum_2 := sum_2 + qMainQuery.fields[3].Asfloat;
                             sum_3 := sum_3 + qMainQuery.fields[4].Asfloat;
                             sum_4 := sum_4 + qMainQuery.fields[5].Asfloat;
                        qMainQuery.next;
                     end;

                      Form.Editor.Lines.add(RepeatLine('-', n));
                      if not checkadd.Checked then
                           Form.Editor.lines.add(' ' +
                           LeftLine(' Итого ', 9)
                            +
                           ' | ' +
                           LeftLine('', 40) +
                           ' |' +
                           RightLine(Formatfloat('0.000',sum_1), 10) +
                           ' |' +
                           RightLine(Formatfloat('0.000',sum_2), 10) +
                           ' |' +
                           RightLine(Formatfloat('0.000',sum_3), 10) +
                           ' |' +
                           RightLine(Formatfloat('0.000',sum_4), 10) + '|')
                        else
                           Form.Editor.lines.add(' ' +
                           LeftLine(' Итого ', 9)
                            +
                           ' | ' +
                           LeftLine('', 61) +
                           ' |' +
                           RightLine(Formatfloat('0.000',sum_1), 10) +
                           ' |           |' +
                           RightLine(Formatfloat('0.000',sum_2), 10) +
                           ' |           |' +
                           RightLine(Formatfloat('0.000',sum_3), 10) +
                           ' |           |' +
                           RightLine(Formatfloat('0.000',sum_4), 10) +
                           ' |          |');




              Form.Editor.lines.add(RepeatLine('-', n));


           Form.Caption := 'Оборотная ведомость по материалам';


         end;

       // завершение отчета
       PrForm.Destroy;

       Form.Editor.visible := true;
       Form.Editor.Font.Size := 8;
       Form.Editor.Update;
       Form.Editor.show;
       Form.show;

end;
//******************* TReport28Form.NMNTComboButtonClick *************************
//
//Вход:
//Выход:
//Описание:
//   Выбор из справочника   Номенклатура
procedure TReport28Form.NMNTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qNMNTQuery, NMNTCombo, 'select id, code, name from spr_nmnt',
                        'Справочник: Номенклатура (Выбор)', 0);


end;

procedure TReport28Form.NMNTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qNMNTQuery, NMNTCombo, key, Shift, 1) = false then
    NMNTComboButtonClick(Sender);


end;

//******************* TReport28Form.WRHSComboButtonClick *************************
//
//Вход:
//Выход:
//Описание:
//   Выбор из справочника Места хранения
procedure TReport28Form.WRHSComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qWRHSQuery, WRHSCombo, 'select id, code, name from spr_wrhs',
                        'Справочник: Места хранения (Выбор)', 0);


end;

procedure TReport28Form.WRHSComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qWRHSQuery, WRHSCombo, key, Shift, 0) = false then
     WRHSComboButtonClick(Sender);


end;

procedure TReport28Form.ButtonCancelClick(Sender: TObject);
begin
        Close;

end;

procedure TReport28Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport28Form.ButtonSetPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport28Form.RadioButton2Click(Sender: TObject);
begin
  if RadioButton2.Checked then
    CheckDetail.Enabled := true
   else
     CheckDetail.Enabled := false;
end;

procedure TReport28Form.CSTComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qCSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);


end;

procedure TReport28Form.CSTComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qCSTQuery, CSTCombo, key, Shift, 1) = false then
     CSTComboButtonClick(Sender);


end;

end.
