{***************************************************************
 *
 * Модуль   : Rep22
 * Описание : Отчет об использовании материаллов
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep22;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RXDBCtrl, Mask, ToolEdit, EnumForm4Sel, Db, DBTables, ExtCtrls;

type
  TReport22Form = class(TForm)
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
    MtchQuery: TQuery;
    FaktMtrfQuery: TQuery;
    RadioGroup1: TRadioGroup;
    RMPRadioButton: TRadioButton;
    BuhRadioButton: TRadioButton;
    PlanMtrpQuery: TQuery;
    EdizQuery: TQuery;
    ButtonSelPer: TButton;
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
    procedure ButtonSelPerClick(Sender: TObject);
  private
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report22Form: TReport22Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.DFM}

procedure TReport22Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport22Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i : integer;
       sstr : String;
       n : integer;
       TotalSum : Real; //факт и план запросов вытаскивают по 2 строки приход и расход. Данная переменная для их суммы
       IdNmnt   : Integer;  

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

       //Чертеж для ремонта
       MtchQuery.Close;
       MtchQuery.SQL.Clear;
       MtchQuery.SQL.Add('Select Sum(g.NUMBER), h.NAME, h.CODE, h.ID ');
       MtchQuery.SQL.Add('From Spr_Mtch g, DH_RS c, DT_RS d, Spr_Nmnt h,');
       MtchQuery.SQL.Add('Spr_Opch f, DH_Order b, DH_RQST a, Spr_Chrt e ');
       MtchQuery.SQL.Add('Where h.ID = g.ID_NMNT  and ');
       MtchQuery.SQL.Add('      g.ID_OPCH  = f.id and ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          MtchQuery.SQL.Add('a.ID_CST = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          MtchQuery.SQL.Add('a.ID_PDR = ' + PdrQuery.Fields[0].asstring + ' and ');

       MtchQuery.SQL.Add('c.date_in >=:begdate and c.date_in <=:enddate and ');
       MtchQuery.SQL.Add('d.id_rsmtr = c.id and   ');
       MtchQuery.SQL.Add('b.id = d.id_ord   and   ');
       MtchQuery.SQL.Add('f.ID_CHRT =  b.ID_CHRT  ');
       MtchQuery.SQL.Add('and a.ID = b.ID_RQST and');
       MtchQuery.SQL.Add('e.id = b.id_chrt and    ');
       MtchQuery.SQL.Add('e.vid_chrt = 1          ');
       MtchQuery.SQL.Add('Group by h.NAME, h.CODE, h.ID ');

       MtchQuery.SQL.Add('Union ');

       //Чертеж для изготовления
       MtchQuery.SQL.Add('Select Sum(g.NUMBER), h.NAME, h.CODE, h.ID ');
       MtchQuery.SQL.Add('From Spr_Mtch g, DH_PR c, DT_PR d, Spr_Nmnt h,');
       MtchQuery.SQL.Add('Spr_Opch f, DH_Order b, DH_RQST a, Spr_Chrt e ');
       MtchQuery.SQL.Add('Where h.ID = g.ID_NMNT  and ');
       MtchQuery.SQL.Add('      g.ID_OPCH = f.id  and ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          MtchQuery.SQL.Add('a.ID_CST = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          MtchQuery.SQL.Add('a.ID_PDR = ' + PdrQuery.Fields[0].asstring + ' and ');

       MtchQuery.SQL.Add('c.date_in >=:begdate and c.date_in <=:enddate and ');
       MtchQuery.SQL.Add('d.id_prmtr = c.id and   ');
       MtchQuery.SQL.Add('b.id = d.id_ord   and   ');
       MtchQuery.SQL.Add('f.ID_CHRT =  b.ID_CHRT  ');
       MtchQuery.SQL.Add('and a.ID = b.ID_RQST and');
       MtchQuery.SQL.Add('e.id = b.id_chrt and    ');
       MtchQuery.SQL.Add('e.vid_chrt <> 1         ');
       MtchQuery.SQL.Add('Group by h.NAME, h.CODE, h.ID ');
       MtchQuery.SQL.Add('Order by 3              ');

       MtchQuery.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
       MtchQuery.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);
       MtchQuery.Open;

       PrForm.Show;
       
       //Факт ремонта
       FaktMtrfQuery.Close;
       FaktMtrfQuery.SQL.Clear;
       FaktMtrfQuery.SQL.Add('Select Sum(a.NUMBER * b.NUMBER_F), h.NAME, h.CODE, h.ID');
       FaktMtrfQuery.SQL.Add('From DT_MTRF a, DT_Order2 e, Spr_Chrt d,');
       FaktMtrfQuery.SQL.Add('DH_ORDER b, DH_RQST c, DH_RS f, DT_RS g,');
       FaktMtrfQuery.SQL.Add('Spr_Nmnt h ');
       FaktMtrfQuery.SQL.Add('Where                                   ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          FaktMtrfQuery.SQL.Add('c.ID_CST = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          FaktMtrfQuery.SQL.Add('c.ID_PDR = ' + PdrQuery.Fields[0].asstring + ' and ');

       FaktMtrfQuery.SQL.Add('f.date_in >=:begdate and f.date_in <=:enddate and ');
       FaktMtrfQuery.SQL.Add('g.id_rsmtr = f.id and   ');
       FaktMtrfQuery.SQL.Add('b.id = g.id_ord  and    ');
       FaktMtrfQuery.SQL.Add('e.ID_ORDER = b.ID and   ');
       FaktMtrfQuery.SQL.Add('c.ID = b.ID_RQST  and   ');
       FaktMtrfQuery.SQL.Add('a.ID_OPF = e.ID_ORDER  and a.LINEOPF = e.LINENO and ');
       FaktMtrfQuery.SQL.Add('h.ID = a.ID_NMNT  and   ');
       FaktMtrfQuery.SQL.Add('d.id = b.id_chrt and    ');
       FaktMtrfQuery.SQL.Add('d.vid_chrt = 1          ');
       FaktMtrfQuery.SQL.Add('Group By h.NAME, h.CODE, h.ID');

       FaktMtrfQuery.SQL.Add('Union');

       //Факт изготовления
       FaktMtrfQuery.SQL.Add('Select Sum(a.NUMBER * b.NUMBER_F), h.NAME, h.CODE, h.ID');
       FaktMtrfQuery.SQL.Add('From DT_MTRF a, DT_Order2 e, Spr_Chrt d,');
       FaktMtrfQuery.SQL.Add('DH_ORDER b, DH_RQST c, DH_PR f, DT_PR g,');
       FaktMtrfQuery.SQL.Add('Spr_Nmnt h ');
       FaktMtrfQuery.SQL.Add('Where                                   ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          FaktMtrfQuery.SQL.Add('c.ID_CST = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          FaktMtrfQuery.SQL.Add('c.ID_PDR = ' + PdrQuery.Fields[0].asstring + ' and ');

       FaktMtrfQuery.SQL.Add('f.date_in >=:begdate and f.date_in <=:enddate and ');
       FaktMtrfQuery.SQL.Add('g.id_prmtr = f.id and   ');
       FaktMtrfQuery.SQL.Add('b.id = g.id_ord  and    ');
       FaktMtrfQuery.SQL.Add('e.ID_ORDER = b.ID and   ');
       FaktMtrfQuery.SQL.Add('c.ID = b.ID_RQST  and   ');
       FaktMtrfQuery.SQL.Add('a.ID_OPF = e.ID_ORDER  and a.LINEOPF = e.LINENO and ');
       FaktMtrfQuery.SQL.Add('h.ID = a.ID_NMNT  and   ');
       FaktMtrfQuery.SQL.Add('d.id = b.id_chrt and    ');
       FaktMtrfQuery.SQL.Add('d.vid_chrt <> 1         ');
       FaktMtrfQuery.SQL.Add('Group By h.NAME, h.CODE, h.ID');
       FaktMtrfQuery.SQL.Add('Order by 3              ');


       FaktMtrfQuery.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
       FaktMtrfQuery.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);
       FaktMtrfQuery.Open;

       //План ремонта
       PlanMtrpQuery.Close;
       PlanMtrpQuery.SQL.Clear;
       PlanMtrpQuery.SQL.Add('Select Sum(a.NUMBER * b.NUMBER_P), h.NAME, h.CODE, h.ID');
       PlanMtrpQuery.SQL.Add('From DT_MTRP a, DT_Order1 e, Spr_Chrt d, ');
       PlanMtrpQuery.SQL.Add('DH_ORDER b, DH_RQST c, DH_RS f, DT_RS g, ');
       PlanMtrpQuery.SQL.Add('Spr_Nmnt h ');
       PlanMtrpQuery.SQL.Add('Where ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          PlanMtrpQuery.SQL.Add('c.ID_CST = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          PlanMtrpQuery.SQL.Add('c.ID_PDR = ' + PdrQuery.Fields[0].asstring + ' and ');

       PlanMtrpQuery.SQL.Add('f.date_in >=:begdate and f.date_in <=:enddate and ');
       PlanMtrpQuery.SQL.Add('g.id_rsmtr = f.id and   ');
       PlanMtrpQuery.SQL.Add('b.id = g.id_ord   and   ');
       PlanMtrpQuery.SQL.Add('e.ID_ORDER = b.ID and   ');
       PlanMtrpQuery.SQL.Add('c.ID = b.ID_RQST  and   ');
       PlanMtrpQuery.SQL.Add('a.LINEOPP = e.LINENO and a.ID_OPP = e.ID_ORDER  and ');
       PlanMtrpQuery.SQL.Add('h.ID = a.ID_NMNT  and   ');
       PlanMtrpQuery.SQL.Add('d.id = b.id_chrt and    ');
       PlanMtrpQuery.SQL.Add('d.vid_chrt = 1          ');
       PlanMtrpQuery.SQL.Add('Group By h.NAME, h.CODE, h.ID');

       PlanMtrpQuery.SQL.Add('Union');

       //План изготовления
       PlanMtrpQuery.SQL.Add('Select Sum(a.NUMBER * b.NUMBER_P), h.NAME, h.CODE, h.ID');
       PlanMtrpQuery.SQL.Add('From DT_MTRP a, DT_Order1 e, Spr_Chrt d, ');
       PlanMtrpQuery.SQL.Add('DH_ORDER b, DH_RQST c, DH_PR f, DT_PR g, ');
       PlanMtrpQuery.SQL.Add('Spr_Nmnt h ');
       PlanMtrpQuery.SQL.Add('Where ');

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          PlanMtrpQuery.SQL.Add('c.ID_CST = ' + CSTQuery.Fields[0].asstring + ' and ');
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          PlanMtrpQuery.SQL.Add('c.ID_PDR = ' + PdrQuery.Fields[0].asstring + ' and ');

       PlanMtrpQuery.SQL.Add('f.date_in >=:begdate and f.date_in <=:enddate and ');
       PlanMtrpQuery.SQL.Add('g.id_prmtr = f.id and   ');
       PlanMtrpQuery.SQL.Add('b.id = g.id_ord   and   ');
       PlanMtrpQuery.SQL.Add('e.ID_ORDER = b.ID and   ');
       PlanMtrpQuery.SQL.Add('c.ID = b.ID_RQST  and   ');
       PlanMtrpQuery.SQL.Add('a.LINEOPP = e.LINENO and a.ID_OPP = e.ID_ORDER  and ');
       PlanMtrpQuery.SQL.Add('h.ID = a.ID_NMNT  and   ');
       PlanMtrpQuery.SQL.Add('d.id = b.id_chrt and    ');
       PlanMtrpQuery.SQL.Add('d.vid_chrt <> 1         ');
       PlanMtrpQuery.SQL.Add('Group By h.NAME, h.CODE, h.ID');
       PlanMtrpQuery.SQL.Add('Order by 3              ');

       PlanMtrpQuery.ParamByName('begdate').AsDate := StrToDate(BegDateEdit.Text);
       PlanMtrpQuery.ParamByName('enddate').AsDate := StrToDate(EndDateEdit.Text);
       PlanMtrpQuery.Open;

       If (MtchQuery.Eof) and (FaktMtrfQuery.Eof) and ((PlanMtrpQuery.Eof))Then
       begin
          PrForm.Destroy;
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       If RMPRadioButton.Checked Then n:=110 else n:=98;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          add(RepeatLine('-', n));
          add('');
          add('');
          add(CentrLine('Отчет об использовании материалов',n));
          add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,n));
          add('');
          add(RepeatLine('-', n));
          sstr:='Номенклатурный|                                                  | Ед. |';
          If RMPRadioButton.Checked Then sstr:=sstr+'  Норматив  |';
          sstr:=sstr+'  Норматив  |            |';
          add(sstr);
          sstr:='    номер     |                   Наименование                   |измер|';
          If RMPRadioButton.Checked Then sstr:=sstr+' по чертежу |';
          sstr:=sstr+'  по плану  |    Факт    |';
          add(sstr);
          sstr:='              |                                                  |     |';
          If RMPRadioButton.Checked Then sstr:=sstr+'            |';
          sstr:=sstr+'            |            |';
          add(sstr);
          add(RepeatLine('-', n));

          i:=1;
          sstr:='';

{          While (i<=MtchQuery.RecordCount) or
                (i<=PlanMtrpQuery.RecordCount) or
                (i<=FaktMtrfQuery.RecordCount) do}
          While not (PlanMtrpQuery.Eof) or
                not (FaktMtrfQuery.Eof) do
          begin
             PrForm.ProgressBar.Position:=i*100 div FaktMtrfQuery.RecordCount;

             //произвожу вывод используемых материалов сразу отсортировав по 3 таблицам
             //снчало сравниваю 2 запроса по что меньше код материала по плану
             //или по факту. Если по факту, то выполняю условие
             If (FaktMtrfQuery.FieldByName('CODE').AsInteger <
                   PlanMtrpQuery.FieldByName('CODE').AsInteger)
                   and not (FaktMtrfQuery.Eof) or (PlanMtrpQuery.Eof) Then
             begin
                //Теперь сравниваю запросы материал по факту и по чертежу
                If (FaktMtrfQuery.FieldByName('CODE').AsInteger <
                      MtchQuery.FieldByName('CODE').AsInteger)
                      and not (FaktMtrfQuery.Eof) or (MtchQuery.Eof)
                      or not (RMPRadioButton.Checked) Then
                begin

                    sstr:=RightLine(FaktMtrfQuery.FieldByName('CODE').AsString, 14)+' '+
                          LeftLine(FaktMtrfQuery.FieldByName('NAME').AsString, 50)+' ';

                    EdizQuery.Close;
                    EdizQuery.ParamByName('id').AsInteger := FaktMtrfQuery.FieldByName('ID').AsInteger;
                    EdizQuery.Open;

                    sstr:=sstr+LeftLine(EdizQuery.FieldByName('CODE').AsString, 5)+' ';

                    //Если такой же материал используется и по чертежу то выводим и его
                    if (FaktMtrfQuery.FieldByName('CODE').AsInteger =
                        MtchQuery.FieldByName('CODE').AsInteger) and
                        not (MtchQuery.Eof) and (RMPRadioButton.Checked) Then
                    begin

                          TotalSum:=0;
                          IdNmnt:=MtchQuery.FieldByName('ID').AsInteger;
                          TotalSum:=MtchQuery.FieldByName('SUM').AsFloat;
                          MtchQuery.Next;

                          //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                          If MtchQuery.FieldByName('ID').AsInteger = IdNmnt Then
                          begin
                              TotalSum:=TotalSum + MtchQuery.FieldByName('SUM').AsFloat;
                              MtchQuery.Next;
                          end;

                          sstr:=sstr+RightLine(FormatFloat('0.00', TotalSum), 12)+' ';
                    end
                     else
                           if RMPRadioButton.Checked Then sstr:=sstr+RightLine(' - ', 12)+' ';

                    //Если такой же материал используется и по плану то выводим и его
                    if (FaktMtrfQuery.FieldByName('CODE').AsInteger =
                        PlanMtrpQuery.FieldByName('CODE').AsInteger) and
                        not (PlanMtrpQuery.Eof)  Then
                    begin
                          TotalSum:=0;
                          IdNmnt:=PlanMtrpQuery.FieldByName('ID').AsInteger;
                          TotalSum:=PlanMtrpQuery.FieldByName('SUM').AsFloat;
                          PlanMtrpQuery.Next;

                          //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                          If not (PlanMtrpQuery.Eof) Then
                          begin
                              If (PlanMtrpQuery.FieldByName('ID').AsInteger = IdNmnt) Then
                              begin
                                  TotalSum:=TotalSum + PlanMtrpQuery.FieldByName('SUM').AsFloat;
                                  PlanMtrpQuery.Next;
                              end;
                          end;

                          sstr:=sstr+
                             RightLine(FormatFloat('0.00', TotalSum), 12)+' ';
                    end
                     else
                           sstr:=sstr+RightLine(' - ', 12)+' ';

                     TotalSum:=0;
                     IdNmnt:=FaktMtrfQuery.FieldByName('ID').AsInteger;
                     TotalSum:=FaktMtrfQuery.FieldByName('SUM').AsFloat;
                     FaktMtrfQuery.Next;

                     //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                     If not (FaktMtrfQuery.Eof) Then
                     begin
                         If (FaktMtrfQuery.FieldByName('ID').AsInteger = IdNmnt) Then
                         begin
                              TotalSum:=TotalSum + FaktMtrfQuery.FieldByName('SUM').AsFloat;
                              FaktMtrfQuery.Next;
                         end;
                     end;

                    //дописываю сумму по факту
                    sstr:=sstr+RightLine(FormatFloat('0.00', TotalSum), 12);

                end
                 else //иначе код номенклатуры по чертежу меньше кода номенклатуры по факту
                 begin

                      sstr:=RightLine(MtchQuery.FieldByName('CODE').AsString, 14)+' '+
                            LeftLine(MtchQuery.FieldByName('NAME').AsString, 50)+' ';

                      EdizQuery.Close;
                      EdizQuery.ParamByName('id').AsInteger := MtchQuery.FieldByName('ID').AsInteger;
                      EdizQuery.Open;

                      sstr:=sstr+LeftLine(EdizQuery.FieldByName('CODE').AsString, 5)+' ';

                      //????????????????????????????
                      //дописываю сумму по чертежу
                      TotalSum:=0;
                      IdNmnt:=MtchQuery.FieldByName('ID').AsInteger;
                      TotalSum:=MtchQuery.FieldByName('SUM').AsFloat;
                      MtchQuery.Next;

                      //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                      If MtchQuery.FieldByName('ID').AsInteger = IdNmnt Then
                          TotalSum:=TotalSum + MtchQuery.FieldByName('SUM').AsFloat
                       else MtchQuery.Prior;

                      sstr:=sstr+RightLine(FormatFloat('0.00', TotalSum), 12)+' ';

                      //Если такой же материал используется и по плану то выводим и его
                      if (MtchQuery.FieldByName('CODE').AsInteger =
                          PlanMtrpQuery.FieldByName('CODE').AsInteger) and
                          not (PlanMtrpQuery.Eof)  Then
                      begin
                            TotalSum:=0;
                            IdNmnt:=PlanMtrpQuery.FieldByName('ID').AsInteger;
                            TotalSum:=PlanMtrpQuery.FieldByName('SUM').AsFloat;
                            PlanMtrpQuery.Next;

                            //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                            If not (PlanMtrpQuery.Eof) Then
                            begin
                                If (PlanMtrpQuery.FieldByName('ID').AsInteger = IdNmnt) Then
                                begin
                                    TotalSum:=TotalSum + PlanMtrpQuery.FieldByName('SUM').AsFloat;
                                    PlanMtrpQuery.Next;
                                end;
                            end;

                            sstr:=sstr+
                               RightLine(FormatFloat('0.00', TotalSum), 12)+' ';
                      end
                       else
                             sstr:=sstr+RightLine(' - ', 12)+' ';

                      //Если такой же материал используется и по факту то выводим и его
                      if (FaktMtrfQuery.FieldByName('CODE').AsInteger =
                          MtchQuery.FieldByName('CODE').AsInteger) and
                          not (FaktMtrfQuery.Eof) Then
                      begin

                            TotalSum:=0;
                            IdNmnt:=FaktMtrfQuery.FieldByName('ID').AsInteger;
                            TotalSum:=FaktMtrfQuery.FieldByName('SUM').AsFloat;
                            FaktMtrfQuery.Next;

                            //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                            If not (FaktMtrfQuery.Eof) Then
                            begin
                                If (FaktMtrfQuery.FieldByName('ID').AsInteger = IdNmnt) Then
                                begin
                                    TotalSum:=TotalSum + FaktMtrfQuery.FieldByName('SUM').AsFloat;
                                    FaktMtrfQuery.Next;
                                end;
                            end;

                            sstr:=sstr+RightLine(FormatFloat('0.00', TotalSum), 12);
                      end
                       else
                             sstr:=sstr+RightLine(' - ', 12);

                      MtchQuery.Next;
                 end;
             end
              else //иначе оказалось что код номенклатуры плану меньше кода нменклатуры по факту
              begin
                 //Теперь сравниваю запросы материал по чертежу и по плану
                 If (PlanMtrpQuery.FieldByName('CODE').AsInteger <
                       MtchQuery.FieldByName('CODE').AsInteger)
                       and not (PlanMtrpQuery.Eof) or (MtchQuery.Eof)
                       or not (RMPRadioButton.Checked) Then
                 begin

                      sstr:=RightLine(PlanMtrpQuery.FieldByName('CODE').AsString, 14)+' '+
                            LeftLine(PlanMtrpQuery.FieldByName('NAME').AsString, 50)+' ';

                      EdizQuery.Close;
                      EdizQuery.ParamByName('id').AsInteger := PlanMtrpQuery.FieldByName('ID').AsInteger;
                      EdizQuery.Open;

                      sstr:=sstr+LeftLine(EdizQuery.FieldByName('CODE').AsString, 5)+' ';

                      //Если такой же материал используется и по чертежу то выводим и его
                      if (MtchQuery.FieldByName('CODE').AsInteger =
                          PlanMtrpQuery.FieldByName('CODE').AsInteger) and
                          not (MtchQuery.Eof) and (RMPRadioButton.Checked)Then
                      begin

                            TotalSum:=0;
                            IdNmnt:=MtchQuery.FieldByName('ID').AsInteger;
                            TotalSum:=MtchQuery.FieldByName('SUM').AsFloat;
                            MtchQuery.Next;

                            //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                            If MtchQuery.FieldByName('ID').AsInteger = IdNmnt Then
                            begin
                                TotalSum:=TotalSum + MtchQuery.FieldByName('SUM').AsFloat;
                                MtchQuery.Next;
                            end;

                            sstr:=sstr+
                               RightLine(FormatFloat('0.00', TotalSum), 12)+' ';
                      end
                       else
                             if RMPRadioButton.Checked Then sstr:=sstr+RightLine(' - ', 12)+' ';

                      //????????????????????
                      //дописываю сумму по плану
                      TotalSum:=0;
                      IdNmnt:=PlanMtrpQuery.FieldByName('ID').AsInteger;
                      TotalSum:=PlanMtrpQuery.FieldByName('SUM').AsFloat;
                      PlanMtrpQuery.Next;

                      //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                      If not (PlanMtrpQuery.Eof) Then
                      begin
                          If (PlanMtrpQuery.FieldByName('ID').AsInteger = IdNmnt) Then
                          begin
                              TotalSum:=TotalSum + PlanMtrpQuery.FieldByName('SUM').AsFloat
                          end
                           else PlanMtrpQuery.Prior;
                      end;

                      sstr:=sstr+RightLine(FormatFloat('0.00', TotalSum), 12)+' ';

                      //Если такой же материал используется и по факту то выводим и его
                      if (FaktMtrfQuery.FieldByName('CODE').AsInteger =
                          PlanMtrpQuery.FieldByName('CODE').AsInteger) and
                          not (FaktMtrfQuery.Eof) Then
                      begin

                            TotalSum:=0;
                            IdNmnt:=FaktMtrfQuery.FieldByName('ID').AsInteger;
                            TotalSum:=FaktMtrfQuery.FieldByName('SUM').AsFloat;
                            FaktMtrfQuery.Next;

                            //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                            If not (FaktMtrfQuery.Eof) Then
                            begin
                                If (FaktMtrfQuery.FieldByName('ID').AsInteger = IdNmnt) Then
                                begin
                                     TotalSum:=TotalSum + FaktMtrfQuery.FieldByName('SUM').AsFloat;
                                     FaktMtrfQuery.Next;
                                end;
                            end;

                            sstr:=sstr+
                               RightLine(FormatFloat('0.00', TotalSum), 12);
                      end
                       else
                            sstr:=sstr+RightLine(' - ', 12);

                      PlanMtrpQuery.Next;
                 end
                  else //иначе код номенклатуры по чертежу меньше кода номенклатуры по плану
                  begin

                      sstr:=RightLine(MtchQuery.FieldByName('CODE').AsString, 14)+' '+
                            LeftLine(MtchQuery.FieldByName('NAME').AsString, 50)+' ';

                      EdizQuery.Close;
                      EdizQuery.ParamByName('id').AsInteger := MtchQuery.FieldByName('ID').AsInteger;
                      EdizQuery.Open;

                      sstr:=sstr+LeftLine(EdizQuery.FieldByName('CODE').AsString, 5)+' ';

                      //?????????????????????????????
                      //дописываю сумму по чертежу
                      TotalSum:=0;
                      IdNmnt:=MtchQuery.FieldByName('ID').AsInteger;
                      TotalSum:=MtchQuery.FieldByName('SUM').AsFloat;
                      MtchQuery.Next;

                      //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                      If MtchQuery.FieldByName('ID').AsInteger = IdNmnt Then
                          TotalSum:=TotalSum + MtchQuery.FieldByName('SUM').AsFloat
                       else MtchQuery.Prior;

                      sstr:=sstr+RightLine(FormatFloat('0.00', TotalSum), 12)+' ';

                      //Если такой же материал используется и по плану то выводим и его
                      if (MtchQuery.FieldByName('CODE').AsInteger =
                          PlanMtrpQuery.FieldByName('CODE').AsInteger) and
                          not (PlanMtrpQuery.Eof)  Then
                      begin

                            TotalSum:=0;
                            IdNmnt:=PlanMtrpQuery.FieldByName('ID').AsInteger;
                            TotalSum:=PlanMtrpQuery.FieldByName('SUM').AsFloat;
                            PlanMtrpQuery.Next;

                            //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                            If not (PlanMtrpQuery.Eof) Then
                            begin
                                If (PlanMtrpQuery.FieldByName('ID').AsInteger = IdNmnt) Then
                                begin
                                     TotalSum:=TotalSum + PlanMtrpQuery.FieldByName('SUM').AsFloat;
                                     PlanMtrpQuery.Next;
                                end;
                            end;

                            sstr:=sstr+
                               RightLine(FormatFloat('0.00', TotalSum), 12)+' ';
                      end
                       else
                             sstr:=sstr+RightLine(' - ', 12)+' ';

                      //Если такой же материал используется и по факту то выводим и его
                      if (FaktMtrfQuery.FieldByName('CODE').AsInteger =
                          MtchQuery.FieldByName('CODE').AsInteger) and
                          not (FaktMtrfQuery.Eof) Then
                      begin

                            TotalSum:=0;
                            IdNmnt:=FaktMtrfQuery.FieldByName('ID').AsInteger;
                            TotalSum:=FaktMtrfQuery.FieldByName('SUM').AsFloat;
                            FaktMtrfQuery.Next;

                            //Поскольку приход и расход по номенклатуре делают 2 записи в запросе их надо сложить
                            If not (FaktMtrfQuery.Eof) Then
                            begin
                                If (FaktMtrfQuery.FieldByName('ID').AsInteger = IdNmnt) Then
                                begin
                                     TotalSum:=TotalSum + FaktMtrfQuery.FieldByName('SUM').AsFloat;
                                     FaktMtrfQuery.Next;
                                end;
                            end;

                            sstr:=sstr+RightLine(FormatFloat('0.00', TotalSum), 12);
                      end
                       else
                          sstr:=sstr+RightLine(' - ', 12);

                      MtchQuery.Next;
                 end;
              end;
              i:=i+1;
              add(sstr);
          end;
          add(RepeatLine('-', n));
          add('');
          add('');
          add('');
          add('       Отпустил: ____________________                        Получил: ____________________');
          add('                      кладовщик                                          мастер участка   ');
       end;
       PrForm.Destroy;

       Form.Caption := 'Отчет об использовании материалов';
       Form.Editor.show;
       Form.show;
end;

procedure TReport22Form.FormCreate(Sender: TObject);
begin

  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);

end;

procedure TReport22Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);
end;

procedure TReport22Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport22Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport22Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport22Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport22Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
