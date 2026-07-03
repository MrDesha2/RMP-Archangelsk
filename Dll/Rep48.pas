unit Rep48;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, ExtCtrls, ToolEdit, Mask, EnumForm4Sel;

type
  TReport48Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    ButtonOK: TButton;
    ButtonNO: TButton;
    CstCombo: TComboEdit;
    PdrCombo: TComboEdit;
    ButtonSelPer: TButton;
    PdrQuery: TQuery;
    CstQuery: TQuery;
    FaktMtrfQuery: TQuery;
    PlanMtrpQuery: TQuery;
    EdizQuery: TQuery;
    ComboBox: TComboBox;
    Label6: TLabel;
    procedure ButtonNOClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report48Form: TReport48Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.dfm}

procedure TReport48Form.ButtonNOClick(Sender: TObject);
begin
        Close;
end;

procedure TReport48Form.FormCreate(Sender: TObject);
begin
  ListForm := TLIST_4SELECTForm.create(self);
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
end;

procedure TReport48Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);
end;

procedure TReport48Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);
end;

procedure TReport48Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, PdrQuery, PdrCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport48Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);
end;

procedure TReport48Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport48Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);
end;

procedure TReport48Form.ButtonOKClick(Sender: TObject);
Var    Form : TShowPrintForm;
       PrForm : TProcessForm;
       i      : integer;
       sstr   : String;
       n      : integer;
       k      : integer;
       Kol    : Real;
       Sum    : Real;
       TotalPlan : Real;
       TotalFact : Real;
    TotalSumPlan : Real;
    TotalSumFact : Real;
      PlanEQPT   : Integer;
      FactEQPT   : Integer;
      PlanOrd    : Integer;
      FactOrd    : Integer;

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

       PrForm.Show;

       //Факт ремонта
       FaktMtrfQuery.Close;
       FaktMtrfQuery.SQL.Clear;
       FaktMtrfQuery.SQL.Add('Select * From REPORT_48_FACT_PROCEDURE(:DATE_BEG, :DATE_END, :ID_CST, :ID_PDR, :EXEC)');
       FaktMtrfQuery.SQL.Add('Order by CODE_EQPT, NUMBER_RQST, NUMBER_ORDER        ');

       PlanMtrpQuery.Close;
       PlanMtrpQuery.SQL.Clear;
       PlanMtrpQuery.SQL.Add('Select * From REPORT_48_PLAN_PROCEDURE(:DATE_BEG, :DATE_END, :ID_CST, :ID_PDR, :EXEC)');
       PlanMtrpQuery.SQL.Add('Order by CODE_EQPT, NUMBER_RQST, NUMBER_ORDER        ');


       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          PlanMtrpQuery.ParamByName('ID_CST').AsInteger := CSTQuery.Fields[0].AsInteger
        else
           PlanMtrpQuery.ParamByName('ID_CST').AsInteger := -1;
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          PlanMtrpQuery.ParamByName('ID_PDR').AsInteger := PDRQuery.Fields[0].AsInteger
        else
           PlanMtrpQuery.ParamByName('ID_PDR').AsInteger := -1;

       //Параметр = Заказчику
       if (CstCombo.Text <> '<Object not found>') and (CSTQuery.active) then
          FaktMtrfQuery.ParamByName('ID_CST').AsInteger := CSTQuery.Fields[0].AsInteger
        else
           FaktMtrfQuery.ParamByName('ID_CST').AsInteger := -1;
       //Параметр = Подразделению
       if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
          FaktMtrfQuery.ParamByName('ID_PDR').AsInteger := PDRQuery.Fields[0].AsInteger
        else
           FaktMtrfQuery.ParamByName('ID_PDR').AsInteger := -1;


       PlanMtrpQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       PlanMtrpQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);
       FaktMtrfQuery.ParamByName('DATE_BEG').AsDate := StrToDate(BegDateEdit.Text);
       FaktMtrfQuery.ParamByName('DATE_END').AsDate := StrToDate(EndDateEdit.Text);

       PlanMtrpQuery.ParamByName('EXEC').AsInteger := ComboBox.ItemIndex;
       FaktMtrfQuery.ParamByName('EXEC').AsInteger := ComboBox.ItemIndex;

       PlanMtrpQuery.Open;
       FaktMtrfQuery.Open;

       If (FaktMtrfQuery.Eof) and ((PlanMtrpQuery.Eof))Then
       begin
          PrForm.Destroy;
          MessageDlg('Ни одной записи не обнаружено!', mtWarning , [mbYes], 0);
          Exit;
       end;

       n:=159;

       // формирование строк
       with Form.Editor.lines do
       begin

          clear;

          add(RepeatLine('-', n));
          add('');
          add('');
          add(CentrLine('Отчет об использовании транспорта',n));
          if (PdrCombo.Text <> '<Object not found>') and (PdrQuery.active)then
             add(CentrLine('Участком: '+PDRQuery.Fields[1].AsString, n));
          add(CentrLine('c '+BegDateEdit.Text+' по '+EndDateEdit.Text,n));
          add('');
          add(RepeatLine('-', n));
          add('               |          |    Код     | Инвентарный  |                                                  | Ед. |  Норматив  |            |      Стоимость      |');
          add('№Заявки/№Заказа|№Документа| производ-  |    номер     |                   Наименование                   |измер|  по плану  |    Факт    |---------------------|');
          add('               |          |    ства    |              |                                                  |     |            |            |   план   |   факт   |');
          add(RepeatLine('-', n));

          i:=1;
          sstr:='';
          If FaktMtrfQuery.Eof Then k := 1
            else k:=FaktMtrfQuery.RecordCount;

          While not (PlanMtrpQuery.Eof) or
                not (FaktMtrfQuery.Eof) do
          begin

                 PrForm.ProgressBar.Position:=i*100 div k;
                 If FaktMtrfQuery.FieldByName('CODE_EQPT').Value = Null Then
                 begin
                     FactEQPT := 0;
                     FactOrd  := 0
                 end
                  else
                  begin
                      FactEQPT := FaktMtrfQuery.FieldByName('CODE_EQPT').AsInteger;
                      FactOrd  := FaktMtrfQuery.FieldByName('NUMBER_ORDER').AsInteger;
                  end;

                 If PlanMtrpQuery.FieldByName('CODE_EQPT').Value = Null Then
                 begin
                     PlanEQPT := 0;
                     PlanOrd  := 0;
                 end
                  else
                  begin
                       PlanEQPT := PlanMtrpQuery.FieldByName('CODE_EQPT').AsInteger;
                       PlanOrd  := PlanMtrpQuery.FieldByName('NUMBER_ORDER').AsInteger;
                  end;

                 //произвожу вывод используемых материалов сразу отсортировав по 2 таблицам
                 //снчало сравниваю 2 запроса по что меньше код материала по плану
                 //или по факту. Если по факту, то выполняю условие
{                 If (FaktMtrfQuery.FieldByName('CODE').AsInteger <
                       PlanMtrpQuery.FieldByName('CODE').AsInteger)
                       and not (FaktMtrfQuery.Eof) or (PlanMtrpQuery.Eof) Then}
                 If ((FactEQPT < PlanEQPT) or (FactOrd < PlanOrd)) and not (FaktMtrfQuery.Eof) or (PlanMtrpQuery.Eof) Then
                 begin
                        sstr:=RightLine(FaktMtrfQuery.FieldByName('NUMBER_RQST').AsString + '/' +
                                        FaktMtrfQuery.FieldByName('NUMBER_ORDER').AsString , 15)+' '+
                              RightLine(FaktMtrfQuery.FieldByName('NUMDOC').AsString, 10)+' '+
                              LeftLine(FaktMtrfQuery.FieldByName('CODE_CST').AsString, 12)+' '+
                              RightLine(FaktMtrfQuery.FieldByName('CODE_EQPT').AsString, 14)+' '+
                              LeftLine(FaktMtrfQuery.FieldByName('NAME_EQPT').AsString, 50)+' '+
                                LeftLine(FaktMtrfQuery.FieldByName('CODE_EDIZ').AsString, 5)+' ';

                        Kol := 0;
                        Sum := 0;

                        //Если такой же материал используется и по плану то выводим и его
                        If not (PlanMtrpQuery.Eof) Then
                        begin

                            if ((FaktMtrfQuery.FieldByName('CODE_EQPT').AsInteger =
                                 PlanMtrpQuery.FieldByName('CODE_EQPT').AsInteger) and
                                (FaktMtrfQuery.FieldByName('NUMBER_ORDER').AsInteger =
                                 PlanMtrpQuery.FieldByName('NUMBER_ORDER').AsInteger))  Then
                            begin
                                  Kol := PlanMtrpQuery.FieldByName('KOL').AsFloat;
                                  Sum := PlanMtrpQuery.FieldByName('PRICE').AsFloat;

                                  sstr:=sstr+
                                     RightLine(FormatFloat('0.00', Kol), 12)+' ';

                                  PlanMtrpQuery.Next;
                            end
                             else
                                   sstr:=sstr+RightLine(' - ', 12)+' ';

                            TotalPlan:=TotalPlan + Kol;
                            TotalSumPlan:=TotalSumPlan + Sum;
                        end
                          else sstr:=sstr+RightLine(' - ', 12)+' ';

                        Kol:=FaktMtrfQuery.FieldByName('KOL').AsFloat;

                        TotalFact:=TotalFact + Kol;
                        TotalSumFact:=TotalSumFact + FaktMtrfQuery.FieldByName('PRICE').AsFloat;

                        //дописываю сумму по факту
                        sstr:=sstr+RightLine(FormatFloat('0.00', Kol), 12)+' ';
                        sstr:=sstr+RightLine(FormatFloat('0.00', Sum), 10)+' ';

                        sstr:=sstr + RightLine(FormatFloat('0.00', FaktMtrfQuery.FieldByName('PRICE').AsFloat), 10)+' ';

                        FaktMtrfQuery.Next;

                 end
                  else //иначе оказалось что код номенклатуры плану меньше кода нменклатуры по факту
                  begin

                          sstr:=RightLine(PlanMtrpQuery.FieldByName('NUMBER_RQST').AsString + '/' +
                                          PlanMtrpQuery.FieldByName('NUMBER_ORDER').AsString , 15)+' '+
                                RightLine(PlanMtrpQuery.FieldByName('NUMDOC').AsString, 10)+' '+
                                LeftLine(PlanMtrpQuery.FieldByName('CODE_CST').AsString, 12)+' '+
                                RightLine(PlanMtrpQuery.FieldByName('CODE_EQPT').AsString, 14)+' '+
                                LeftLine(PlanMtrpQuery.FieldByName('NAME_EQPT').AsString, 50)+' '+
                                LeftLine(PlanMtrpQuery.FieldByName('CODE_EDIZ').AsString, 5)+' ';

{                          EdizQuery.Close;
                          EdizQuery.ParamByName('id').AsInteger := PlanMtrpQuery.FieldByName('ID').AsInteger;
                          EdizQuery.Open;

                          sstr:=sstr+LeftLine(EdizQuery.FieldByName('CODE').AsString, 5)+' ';
}
                          //????????????????????
                          //дописываю сумму по плану
                          Kol:=PlanMtrpQuery.FieldByName('KOL').AsFloat;

                          TotalPlan:=TotalPlan + Kol;
                          sstr:=sstr+RightLine(FormatFloat('0.00', Kol), 12)+' ';

                          //Если такой же материал используется и по факту то выводим и его
                          Kol := 0;
                          Sum := 0;
                          If not (FaktMtrfQuery.Eof) Then
                          begin
                              if ((FaktMtrfQuery.FieldByName('CODE_EQPT').AsInteger =
                                   PlanMtrpQuery.FieldByName('CODE_EQPT').AsInteger) and
                                  (FaktMtrfQuery.FieldByName('NUMBER_ORDER').AsInteger =
                                   PlanMtrpQuery.FieldByName('NUMBER_ORDER').AsInteger)) Then
                              begin

                                    Kol := FaktMtrfQuery.FieldByName('KOL').AsFloat;
                                    Sum := FaktMtrfQuery.FieldByName('PRICE').AsFloat;

                                    sstr:=sstr+
                                       RightLine(FormatFloat('0.00', Kol), 12)+' ';

                                    TotalFact:=TotalFact + Kol;
                                    TotalSumFact:=TotalSumFact + Sum;
                                    FaktMtrfQuery.Next;

                              end
                               else
                                    sstr:=sstr+RightLine(' - ', 12)+' ';


                          end
                           else sstr:=sstr+RightLine(' - ', 12)+' ';

                          TotalSumPlan:=TotalSumPlan + PlanMtrpQuery.FieldByName('PRICE').AsFloat;
                          sstr:=sstr + RightLine(FormatFloat('0.00', PlanMtrpQuery.FieldByName('PRICE').AsFloat), 10)+' ';
                          sstr:=sstr + RightLine(FormatFloat('0.00', Sum), 10)+' ';

                          PlanMtrpQuery.Next;
                  end;
                  i:=i+1;
                  add(sstr);
          end;
          add(RepeatLine('-', n));
          add(RepeatLine(' ', 106) + 'ИТОГО:'+
              RightLine(FormatFloat('0.00', TotalPlan), 12)+' '+
              RightLine(FormatFloat('0.00', TotalFact), 12)+' '+
              RightLine(FormatFloat('0.00', TotalSumPlan), 10)+' '+
              RightLine(FormatFloat('0.00', TotalSumFact), 10));

       end;
       PrForm.Destroy;

       Form.Caption := 'Отчет об использовании материалов';
       Form.Editor.show;
       Form.show;
end;

end.
