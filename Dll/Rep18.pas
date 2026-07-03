{***************************************************************
 *
 * Модуль   : Rep18
 * Описание : Отчет о выполненных работах
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep18;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Grids, DBGrids, EnumForm4Sel, Mask, ToolEdit,
  ExtCtrls;

type
  TReport18Form = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CstQuery: TQuery;
    MainQuery: TQuery;
    IdCstQuery: TQuery;
    ActTrQuery: TQuery;
    Panel3: TPanel;
    CstAddButton: TButton;
    CstCombo: TComboEdit;
    CstDelButton: TButton;
    Button4: TButton;
    GridCstQuery: TQuery;
    Panel4: TPanel;
    CstStringGrid: TStringGrid;
    Panel6: TPanel;
    Button2: TButton;
    Button1: TButton;
    Label5: TLabel;
    Splitter1: TSplitter;
    Label1: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    CheckBox: TCheckBox;
    Splitter2: TSplitter;
    NaklQuery: TQuery;
    ButtonSelPer: TButton;
    RSMtrQuery: TQuery;
    Panel5: TPanel;
    Splitter3: TSplitter;
    Label3: TLabel;
    PdrCombo: TComboEdit;
    PdrQuery: TQuery;
    TaxCheckBox: TCheckBox;
    Label4: TLabel;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CstAddButtonClick(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CstDelButtonClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Splitter1Moved(Sender: TObject);
    procedure PdrAddButtonClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure ButtonSelPerClick(Sender: TObject);
    procedure PdrComboButtonClick(Sender: TObject);
    procedure PdrComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
     i : Integer;
     LISTForm : TLIST_4SELECTForm;
    { Public declarations }
  end;

var
  Report18Form: TReport18Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.DFM}

procedure TReport18Form.FormCreate(Sender: TObject);
begin
        i:=0;
{        CstQuery.Close;
        CstQuery.Open;
        While not CstQuery.Eof do
        begin
           CstComboBox.Items.Add(CstQuery.FieldByName('NAME').AsString);
           CstQuery.Next;
        end;}
        CstStringGrid.Cells[0,0]:='Наименование заказчиков';
        BegDateEdit.text := datetostr(now);
        EndDateEdit.text := datetostr(now);
        ListForm := TLIST_4SELECTForm.create(self);
        CstStringGrid.DefaultColWidth := CstStringGrid.Width-4;
end;

procedure TReport18Form.CstAddButtonClick(Sender: TObject);
Var j : Integer;
begin
      IdCstQuery.Close;
      IdCstQuery.ParamByName('NAME').AsString:=CstCombo.Text;
      IdCstQuery.Open;

      If not IdCstQuery.Eof Then
      begin
        i:=i+1;

        //Для того чтобы выделить 'Наименование' приходится
        //изночально забивать 2 строки. Поэтому добавляя 1-го
        //заказчика, новую строку не добавляем
        If i<>1 Then
           CstStringGrid.RowCount:=CstStringGrid.RowCount+1;

        //если включена детализация
        If CheckBox.Checked = True Then
        begin

            GridCstQuery.Close;
            GridCstQuery.SQL.Clear;

            GridCstQuery.SQL.Add('Select c.name, a.name ');
            GridCstQuery.SQL.Add('From Spr_Cst a, DH_Order b, Spr_Cst c, DH_Rqst d, ');
            GridCstQuery.SQL.Add('     Spr_Chrt e, DH_PR f, DT_PR g ');
            GridCstQuery.SQL.Add('Where f.date_in >= :date_beg and ');
            GridCstQuery.SQL.Add('      f.date_in <= :date_end and ');
            GridCstQuery.SQL.Add('      f.PR_EXEC = 1        and ');
            GridCstQuery.SQL.Add('      g.ID_PRMTR = f.ID    and ');
            GridCstQuery.SQL.Add('      b.ID = g.ID_ORD      and ');
            GridCstQuery.SQL.Add('      d.ID = b.ID_RQST     and ');
            GridCstQuery.SQL.Add('      c.id = d.id_cst      and ');
            GridCstQuery.SQL.Add('      a.id = c.parentid    and ');
            GridCstQuery.SQL.Add('      e.ID = b.ID_CHRT     and ');
            GridCstQuery.SQL.Add('      (e.VID_CHRT = 0 or e.VID_CHRT is NULL) and ');
            GridCstQuery.SQL.Add('      a.name = :NAME_CST');
            GridCstQuery.SQL.Add('Union ');

            GridCstQuery.SQL.Add('Select c.name, a.name ');
            GridCstQuery.SQL.Add('From Spr_Cst a, DH_Order b, Spr_Cst c, DH_Rqst d, ');
            GridCstQuery.SQL.Add('     Spr_Chrt e, DH_RS f, DT_RS g ');
            GridCstQuery.SQL.Add('Where f.date_in >= :date_beg and ');
            GridCstQuery.SQL.Add('      f.date_in <= :date_end and ');
            GridCstQuery.SQL.Add('      f.PR_EXEC = 1        and ');
            GridCstQuery.SQL.Add('      g.ID_RSMTR = f.ID    and ');
            GridCstQuery.SQL.Add('      b.ID = g.ID_ORD      and ');
            GridCstQuery.SQL.Add('      d.ID = b.ID_RQST     and ');
            GridCstQuery.SQL.Add('      c.id = d.id_cst      and ');
            GridCstQuery.SQL.Add('      a.id = c.parentid    and ');
            GridCstQuery.SQL.Add('      e.ID = b.ID_CHRT     and ');
            GridCstQuery.SQL.Add('      e.VID_CHRT = 1 and ');
            GridCstQuery.SQL.Add('      a.name = :NAME_CST');

            GridCstQuery.SQL.Add('Order by 2, 1 ');

            GridCstQuery.ParamByName('NAME_CST').AsString:=CstCombo.Text;
            GridCstQuery.ParamByName('date_beg').AsString:=BegDateEdit.Text;
            GridCstQuery.ParamByName('date_end').AsString:=EndDateEdit.Text;
            GridCstQuery.Open;

            For j := i  To i-1+GridCstQuery.RecordCount Do  //-1 - предприятие которое включает остальные
            begin
                If (j<>1) Then CstStringGrid.RowCount:=CstStringGrid.RowCount+1;
                CstStringGrid.Cells[0,j]:=GridCstQuery.FieldByName('NAME').AsString;
                GridCstQuery.Next;
            end;
            i:=i-1+GridCstQuery.RecordCount;

        end
         else
             CstStringGrid.Cells[0,i]:=CstCombo.Text;

      end
       else
          ShowMessage('Заказчик '+CstCombo.Text+' не найден');

//      ShowMessage(IntToStr(i));

end;

//процедура удаления организации из списка
//i - количество организаций
//CstStringGrid.RowCount=i+1
//Когда нет ни одной организации i=0 ,а CstStringGrid.RowCount = 2
procedure TReport18Form.CstDelButtonClick(Sender: TObject);
Var myRect: TGridRect;
    j: integer;
begin
        myRect:=CstStringGrid.Selection;
        if i<=myRect.Bottom Then
        begin
            If myRect.Top<=1 Then
            begin
                CstStringGrid.RowCount:=2;
                CstStringGrid.Cells[0,1]:='';
            end
            else CstStringGrid.RowCount:=myRect.Top;

            i:=myRect.Top-1;
        end
        else
            For j:=myRect.Top to i do
            begin
               If myRect.Bottom+(j-myRect.Top+1)<=i  Then
               begin
                 CstStringGrid.Cells[0,j]:=
                   CstStringGrid.Cells[0,myRect.Bottom+(j-myRect.Top+1)];
               end
               else
               begin
                 CstStringGrid.RowCount:=CstStringGrid.RowCount-1;
                 i:=i-1;
               end;
            end;
end;


procedure TReport18Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport18Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport18Form.Button1Click(Sender: TObject);
begin
        Close;
end;

procedure TReport18Form.Button2Click(Sender: TObject);
Var PdrMass : array [1..7,1..2] of String;
       Form : TShowPrintForm;
     PrForm : TProcessForm;
    h,k,n,m : Integer;
       sstr : String;
    Newsstr : String;
   F_Number : String;
   P_Number : String;
All_F_Number : String;
All_P_Number : String;
Total_F_Number : String;
Total_P_Number : String;
RS_Total_Mtr : Real;
PR_Total_Mtr : Real;
      StrCst : String;  //Производства в которые входят заказчики подразделения
   CstMasStr : String;  //Массив производств введенных вручную      
        Nakl : Real;
        Act  : Real;
begin

       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);
       StrCst:='';
       F_Number:='0';
       P_Number:='0';
       All_F_Number:='0';
       All_P_Number:='0';
       Total_F_Number:='0';
       Total_P_Number:='0';
       RS_Total_Mtr := 0;
       PR_Total_Mtr := 0;


       RSMtrQuery.Close;
       RSMtrQuery.SQL.Clear;
       RSMtrQuery.SQL.Add('Select h.id, b.id_pdr, sum(c.nvalue) As Price_Mtr ');
       RSMtrQuery.SQL.Add('From DH_Order b, DH_Rqst d,                   ');
       RSMtrQuery.SQL.Add('     Spr_Chrt e, DH_RS f, DT_RS g, Spr_Cst h, ');
       RSMtrQuery.SQL.Add('     DT_Order3 c                 ');
       RSMtrQuery.SQL.Add('Where f.date_in >= :BEG_DATE and ');
       RSMtrQuery.SQL.Add('      f.date_in <= :END_DATE and ');
       RSMtrQuery.SQL.Add('      f.PR_EXEC = 1          and ');
       RSMtrQuery.SQL.Add('      g.ID_RSMTR = f.ID      and ');
       RSMtrQuery.SQL.Add('      b.ID = g.ID_ORD        and ');
       RSMtrQuery.SQL.Add('      d.ID = b.ID_RQST       and ');
       RSMtrQuery.SQL.Add('      c.ID_RQST = b.ID       and ');
       RSMtrQuery.SQL.Add('      c.ID_CALC = 1          and ');
       RSMtrQuery.SQL.Add('      h.id = d.id_cst        and ');
       RSMtrQuery.SQL.Add('      h.id = :ID_CST         and ');
       RSMtrQuery.SQL.Add('      e.ID = b.ID_CHRT       and ');
       RSMtrQuery.SQL.Add('      e.VID_CHRT = 1             ');
       If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
       begin
         If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
            RSMtrQuery.SQL.Add('   and b.id_pdr = :id_pdr ')
          else
              RSMtrQuery.SQL.Add('   and b.id_pdr in (4802, 4803, 4804, 4805) ');
       end;       
       RSMtrQuery.SQL.Add('Group by h.id, b.id_pdr          ');


       If GridCstQuery.Active Then
           GridCstQuery.First;
       h:=0;

       //обнуляю счетчик 'Итого' по каждому призводству
       For n:=1 to 7 do
       begin
          PdrMass[n,1] := '0';
          PdrMass[n,2] := '0';
       end;

       k:=164;

     // формирование строк
     with Form.Editor.lines do
      begin

        clear;

       sstr:='';
       Add(RepeatLine('-', k));
       Add('');
       Add('');
       Add(CentrLine('О т ч е т',k));
       If (PdrCombo.Text <> '') and (PDRQuery.active) Then sstr := CentrLine('По выполненным работам (услугам) по '
          + Trim(PdrCombo.Text) + ' в руб.',k)
        else
            sstr := CentrLine('По выполненным работам (услугам) по '
                    + GetSystemParams('Service') + ' в руб.',k);
       Add(sstr);
       Add(CentrLine('с '+BegDateEdit.Text+ ' по '+ EndDateEdit.Text,k));
       Add('');

       sstr:='';
       Add(RepeatLine('-',k));
       add('                                        |             |             |                                      в том числе                                  | Результат |');
       add('           Наименование фирмы           | Планируемый | Фактическое |-----------------------------------------------------------------------------------|    (+/-)  |');
       add('                                        |   выпуск    | выполнение  | Химическое  | Зап.части к | Зап.части к | Зап.части к | Итого обору-|  Ремонтные  |  к плану  |');
       add('                                        |             |             | оборудова-  | общему маши | энергетичес | бумагодела- | дование и   |   работы    |  по смете |');
       add('                                        |             |             | ние и зап.  | ностроитель | кому обору- | тельному    | зап. части к|             |           |');
       add('                                        |             |             | части к нему| ному оборуд | дованию     | оборудован  | нему        |             |           |');

       Add(RepeatLine('-',k));
       PrForm.Show;

       If not GridCstQuery.Active Then
       begin

          CstMasStr := '(';
          For n:=1 to CstStringGrid.RowCount-2 do  //цикл по заказчикам для шапки
             CstMasStr:=CstMasStr+''''+CstStringGrid.Cells[0,n] + ''''+', ';

          CstMasStr := CstMasStr + ''''+CstStringGrid.Cells[0,CstStringGrid.RowCount-1]+''''+')';

          GridCstQuery.Close;
          GridCstQuery.SQL.Clear;

          GridCstQuery.SQL.Add('Select c.name, a.name ');
          GridCstQuery.SQL.Add('From Spr_Cst a, DH_Order b, Spr_Cst c, DH_Rqst d, ');
          GridCstQuery.SQL.Add('     Spr_Chrt e, DH_PR f, DT_PR g ');
          GridCstQuery.SQL.Add('Where f.date_in >= :date_beg and ');
          GridCstQuery.SQL.Add('      f.date_in <= :date_end and ');
          GridCstQuery.SQL.Add('      f.PR_EXEC = 1        and ');
          GridCstQuery.SQL.Add('      g.ID_PRMTR = f.ID    and ');
          GridCstQuery.SQL.Add('      b.ID = g.ID_ORD      and ');
          GridCstQuery.SQL.Add('      d.ID = b.ID_RQST     and ');
          GridCstQuery.SQL.Add('      c.id = d.id_cst      and ');
          GridCstQuery.SQL.Add('      a.id = c.parentid    and ');
          GridCstQuery.SQL.Add('      e.ID = b.ID_CHRT     and ');
          GridCstQuery.SQL.Add('      (e.VID_CHRT = 0 or e.VID_CHRT is NULL) and ');
          GridCstQuery.SQL.Add('      c.name in '+CstMasStr);
          If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
          begin
             If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
               GridCstQuery.SQL.Add('   and b.id_pdr = :id_pdr ')
              else
                 GridCstQuery.SQL.Add('   and b.id_pdr in (4802, 4803, 4804, 4805) ');
          end;

          GridCstQuery.SQL.Add('Union ');

          GridCstQuery.SQL.Add('Select c.name, a.name ');
          GridCstQuery.SQL.Add('From Spr_Cst a, DH_Order b, Spr_Cst c, DH_Rqst d, ');
          GridCstQuery.SQL.Add('     Spr_Chrt e, DH_RS f, DT_RS g ');
          GridCstQuery.SQL.Add('Where f.date_in >= :date_beg and ');
          GridCstQuery.SQL.Add('      f.date_in <= :date_end and ');
          GridCstQuery.SQL.Add('      f.PR_EXEC = 1        and ');
          GridCstQuery.SQL.Add('      g.ID_RSMTR = f.ID    and ');
          GridCstQuery.SQL.Add('      b.ID = g.ID_ORD      and ');
          GridCstQuery.SQL.Add('      d.ID = b.ID_RQST     and ');
          GridCstQuery.SQL.Add('      c.id = d.id_cst      and ');
          GridCstQuery.SQL.Add('      a.id = c.parentid    and ');
          GridCstQuery.SQL.Add('      e.ID = b.ID_CHRT     and ');
          GridCstQuery.SQL.Add('      e.VID_CHRT = 1 and ');
          GridCstQuery.SQL.Add('      c.name in '+CstMasStr);
          If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
          begin
             If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
               GridCstQuery.SQL.Add('   and b.id_pdr = :id_pdr ')
              else
                 GridCstQuery.SQL.Add('   and b.id_pdr in (4802, 4803, 4804, 4805) ');
          end;

          GridCstQuery.SQL.Add('Order by 2, 1 ');

          GridCstQuery.ParamByName('date_beg').AsString := BegDateEdit.Text;
          GridCstQuery.ParamByName('date_end').AsString := EndDateEdit.Text;
          If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
            If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
              GridCstQuery.ParamByName('id_pdr').AsInteger := PDRQuery.FieldByName('id').AsInteger;
          GridCstQuery.Open;

          i := GridCstQuery.RecordCount;
       end;

//       ShowMessage('i = '+IntToStr(i));
//       ShowMessage('RecordCount = '+IntToStr(GridCstQuery.RecordCount));
       //CstStringGrid.RowCount-1 = '-1' первое поле 'Наименование'
//       For m:=1 to GridCstQuery.RecordCount do //цикл по заказчикам
       For m:=1 to i do //цикл по заказчикам
       begin

         PrForm.ProgressBar.Position:=(m+1)*100 div i;

         IdCstQuery.Close;
         If GridCstQuery.Active Then
         begin
             IdCstQuery.ParamByName('NAME').AsString:=GridCstQuery.FieldByName('NAME').AsString //CstStringGrid.Cells[0,m];
         end
          else
          begin
               IdCstQuery.ParamByName('NAME').AsString:=CstStringGrid.Cells[0,m];
          end;     
         IdCstQuery.Open;

         //Если включена детализация заказчиков по подразделениям производств
         If CheckBox.Checked = True Then
         begin
            sstr:='';
            If (GridCstQuery.Active) and (StrCst <> GridCstQuery.FieldByName('NAME_1').AsString) Then
            begin
               add(LeftLine(GridCstQuery.FieldByName('NAME_1').AsString, 50));
               StrCst:=GridCstQuery.FieldByName('NAME_1').AsString;
            end;
            sstr:='  '+LeftLine(CstStringGrid.Cells[0,m],38)+' ';
         end
          else
             If (GridCstQuery.Active) and (StrCst <> GridCstQuery.FieldByName('NAME_1').AsString) Then
             begin
                 h:=h+1;
                 sstr:=LeftLine(GridCstQuery.FieldByName('NAME_1').AsString,40)+' '; //LeftLine(CstStringGrid.Cells[0,m],40)+' ';
                 StrCst:=GridCstQuery.FieldByName('NAME_1').AsString;
             end;

         Newsstr:='';
         For n:=1 to 4 do //цикл по статьям  смотри Spr_Stat
         begin

           MainQuery.Close;
           MainQuery.ParamByName('stat').AsInteger:=n; //смотри Spr_Stat
           MainQuery.ParamByName('id_cst').AsInteger:=IdCstQuery.FieldByName('ID').AsInteger;
           MainQuery.ParamByName('beg_date').AsString:=BegDateEdit.Text;
           MainQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
           If TaxCheckBox.Checked = True Then
               MainQuery.ParamByName('tax').AsInteger:=0
            else
                  MainQuery.ParamByName('tax').AsInteger:=1;

           If (PdrCombo.Text <> '') and (PDRQuery.active) Then
           begin
             If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
             begin
               MainQuery.ParamByName('id_pdr').AsInteger:=PdrQuery.FieldByName('ID').AsInteger;
               MainQuery.ParamByName('code_pdr').AsString:=''
             end
              else
              begin
                MainQuery.ParamByName('id_pdr').AsInteger:=0;
                MainQuery.ParamByName('code_pdr').AsInteger:=PdrQuery.FieldByName('ID').AsInteger;
              end
           end
            else
            begin
               MainQuery.ParamByName('id_pdr').AsInteger:=0;
               MainQuery.ParamByName('code_pdr').AsString:='';
            end;

{ShowMessage('stat = '+IntToStr(n)+'  id_cst = '+IdCstQuery.FieldByName('ID').AsString+
           '  beg_date = '+BegDateEdit.Text+
           '  end_date = '+EndDateEdit.Text+
           '  tax = '+ MainQuery.ParamByName('tax').AsString+
           '  code_pdr = '+ MainQuery.ParamByName('code_pdr').AsString); }
           MainQuery.Open;

           P_Number:=FormatFloat( '0.000',StrToFloat(P_Number)+MainQuery.FieldByName('Number_P').AsFloat);
           F_Number:=FormatFloat( '0.000',StrToFloat(F_Number)+MainQuery.FieldByName('Number_F').AsFloat);
           All_P_Number:=FormatFloat( '0.000',StrToFloat(All_P_Number)+MainQuery.FieldByName('Number_P').AsFloat);
           All_F_Number:=FormatFloat( '0.000',StrToFloat(All_F_Number)+MainQuery.FieldByName('Number_F').AsFloat);
           Total_P_Number:=FormatFloat( '0.000',StrToFloat(Total_P_Number)+MainQuery.FieldByName('Number_P').AsFloat);
           Total_F_Number:=FormatFloat( '0.000',StrToFloat(Total_F_Number)+MainQuery.FieldByName('Number_F').AsFloat);


           If CheckBox.Checked = True Then
               Newsstr:=Newsstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('Price').AsFloat),13)+' ';

           PdrMass[n,1]:=FormatFloat( '0.00',StrToFloat(PdrMass[n,1])+MainQuery.FieldByName('Price').AsFloat);
           PdrMass[n,2]:=FormatFloat( '0.00',StrToFloat(PdrMass[n,2])+MainQuery.FieldByName('Price').AsFloat);

           PR_Total_Mtr := PR_Total_Mtr + MainQuery.FieldByName('Price_Mtr').AsFloat;

{ShowMessage('n = '+IntToStr(n)+ '   PdrMass[n,1] = '+ PdrMass[n,1]+
            '   PdrMass[n,2] = '+ PdrMass[n,2]); }
         end;

         //Выбираем стоимость материалов потраченных на ремонт
         RSMtrQuery.Close;
         RSMtrQuery.ParamByName('beg_date').AsString:=BegDateEdit.Text;
         RSMtrQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
         RSMtrQuery.ParamByName('id_cst').AsInteger:=IdCstQuery.FieldByName('ID').AsInteger;
         If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
           If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
             RSMtrQuery.ParamByName('id_pdr').AsInteger:=PDRQuery.FieldByName('id').AsInteger;

         RSMtrQuery.Open;

//         If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
//            If (RSMtrQuery.FieldByName('id_pdr').AsInteger = PDRQuery.FieldByName('id').AsInteger) Then
               RS_Total_Mtr := RS_Total_Mtr + RSMtrQuery.FieldByName('Price_Mtr').AsFloat;

{         If CheckBox.Checked = True Then
             sstr:=sstr+RightLine(FormatFloat( '0.000',StrToFloat(P_Number)),13)+' '+
                        RightLine(FormatFloat( '0.000',StrToFloat(F_Number)),13)+' '+Newsstr;
         F_Number:='0';
         P_Number:='0';}

         //зап. части
         NaklQuery.Close;
         NaklQuery.ParamByName('beg_date').AsString:=BegDateEdit.Text;
         NaklQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
         If GridCstQuery.Active Then
             NaklQuery.ParamByName('NAME_CST').AsString:=GridCstQuery.FieldByName('NAME').AsString //CstStringGrid.Cells[0,m];
          else
               NaklQuery.ParamByName('NAME_CST').AsString:=CstStringGrid.Cells[0,m];

         If TaxCheckBox.Checked = True Then
             NaklQuery.ParamByName('tax').AsInteger:=0
          else
                NaklQuery.ParamByName('tax').AsInteger:=1;

         If ((PdrCombo.Text <> '') and (PDRQuery.active))  Then
         begin
           If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
           begin
             NaklQuery.ParamByName('id_pdr').AsInteger := PdrQuery.FieldByName('ID').AsInteger;
             NaklQuery.ParamByName('code_pdr').AsString := '';
           end
            else
            begin
              NaklQuery.ParamByName('id_pdr').AsInteger := 0;
              NaklQuery.ParamByName('code_pdr').AsString := '30-20';
            end
         end
          else
          begin
               NaklQuery.ParamByName('id_pdr').AsInteger := 0;
               NaklQuery.ParamByName('code_pdr').AsString := '';
          end;

         Nakl := 0;

//ShowMessage('PdrMass[5,1] =  '+PdrMass[5,1]);
         NaklQuery.Open;
         Nakl:=NaklQuery.FieldByName('Price').AsFloat;
//ShowMessage('Nakl =  '+NaklQuery.FieldByName('Price').AsString);

         If CheckBox.Checked = True Then
            Newsstr:=Newsstr+RightLine(FormatFloat( '0.00',Nakl),13)+' ';
         PdrMass[5,1]:=FormatFloat( '0.00',StrToFloat(PdrMass[5,1])+Nakl);
         PdrMass[5,2]:=FormatFloat( '0.00',StrToFloat(PdrMass[5,2])+Nakl);
{ShowMessage('name_cst = '+GridCstQuery.FieldByName('NAME').AsString+
            '  tax = '+ MainQuery.ParamByName('tax').AsString+
            '  code_pdr = '+NaklQuery.ParamByName('code_pdr').AsString+
            '  id_pdr = '+NaklQuery.ParamByName('id_pdr').AsString+
            '  PdrMass[5,1] = '+PdrMass[5,1]);
}
         //ремонт
         ActTrQuery.Close;
         ActTrQuery.ParamByName('beg_date').AsString:=BegDateEdit.Text;
         ActTrQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
         If GridCstQuery.Active Then
             ActTrQuery.ParamByName('NAME_CST').AsString:=GridCstQuery.FieldByName('NAME').AsString //CstStringGrid.Cells[0,m];
          else
               ActTrQuery.ParamByName('NAME_CST').AsString:=CstStringGrid.Cells[0,m];

         If TaxCheckBox.Checked = True Then
             ActTrQuery.ParamByName('tax').AsInteger:=0
          else
                ActTrQuery.ParamByName('tax').AsInteger:=1;

         If ((PdrCombo.Text <> '') and (PDRQuery.active))  Then
         begin
           If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
           begin
             ActTrQuery.ParamByName('id_pdr').AsInteger := PdrQuery.FieldByName('ID').AsInteger;
             ActTrQuery.ParamByName('code_pdr').AsString := '';
           end
            else
            begin
              ActTrQuery.ParamByName('id_pdr').AsInteger := 0;
              ActTrQuery.ParamByName('code_pdr').AsString := '30-20';
            end
         end
          else
          begin
               ActTrQuery.ParamByName('id_pdr').AsInteger := 0;
               ActTrQuery.ParamByName('code_pdr').AsString := '';
          end;

         Act := 0;

         ActTrQuery.Open;
         Act:=ActTrQuery.FieldByName('Price').AsFloat;

         If CheckBox.Checked = True Then
            Newsstr:=Newsstr+RightLine(FormatFloat( '0.00',Act),13)+' ';
         PdrMass[6,1]:=FormatFloat( '0.00',StrToFloat(PdrMass[6,1])+Act);
         PdrMass[6,2]:=FormatFloat( '0.00',StrToFloat(PdrMass[6,2])+Act);

{ShowMessage('n = '+IntToStr(n)+ '   PdrMass[5,1] = '+ PdrMass[5,1]+
            '   PdrMass[5,2] = '+ PdrMass[5,2]+
            '   PdrMass[6,1] = '+ PdrMass[6,1]+
            '   PdrMass[6,2] = '+ PdrMass[6,2]);  }

         If CheckBox.Checked = True Then
             sstr:=sstr+ //RightLine(FormatFloat( '0.00',StrToFloat(P_Number)),13)+' '+
                        RepeatLine(' ', 14)+
                        RightLine(FormatFloat( '0.00',Nakl+Act),13)+' '+Newsstr;
         F_Number:='0';
         P_Number:='0';


         If CheckBox.Checked = True Then
         begin
            Add(sstr);
            If (GridCstQuery.Active) Then
            begin
               GridCstQuery.Next;
               If (StrCst <> GridCstQuery.FieldByName('NAME_1').AsString) or GridCstQuery.Eof Then
               begin
                  add(RepeatLine('.',k));
                  sstr:=RepeatLine(' ', 41);
//                  sstr:=sstr+RightLine(All_P_Number,13)+' '+RightLine(All_F_Number,13)+' ';
                  sstr:=sstr+ //RightLine(All_P_Number,13)+' '+
                             RepeatLine(' ', 14)+
                             RightLine(FormatFloat( '0.00',StrToFloat(PdrMass[5,1])+StrToFloat(PdrMass[6,1])),13)+' ';
                  All_P_Number:='0';
                  All_F_Number:='0';
                  For n:=1 to 4 do
                  begin
                     sstr:=sstr+RightLine(PdrMass[n,1],13)+' ';
                     PdrMass[n,1]:='0';
                  end;
                  sstr:=sstr+RightLine(PdrMass[5,1],13)+' ';
                  PdrMass[5,1]:='0';
                  sstr:=sstr+RightLine(PdrMass[6,1],13)+' ';
                  PdrMass[6,1]:='0';
                  add(sstr);
               end;
            end;
         end
          else //иначе только сами производства
          begin
//            sstr:=RepeatLine(' ', 41);
            If (GridCstQuery.Active) Then
            begin
               GridCstQuery.Next;
               If (StrCst <> GridCstQuery.FieldByName('NAME_1').AsString) or GridCstQuery.Eof Then
               begin
//                  sstr:=sstr+RightLine(Total_P_Number,13)+' '+RightLine(Total_F_Number,13)+' ';
                  sstr:=sstr+//RightLine(Total_P_Number,13)+' '+
                             RepeatLine(' ', 14)+
                             RightLine(FormatFloat( '0.00',StrToFloat(PdrMass[5,1])+StrToFloat(PdrMass[6,1])), 13)+' ';
//ShowMessage('PdrMass[5,1] =  '+PdrMass[5,1] +'    PdrMass[6,1] = '+PdrMass[6,1] );
                  P_Number:='0';
                  F_Number:='0';
                  For n:=1 to 4 do
                  begin
                     sstr:=sstr+RightLine(PdrMass[n,1],13)+' ';
                     PdrMass[n,1]:='0';
                  end;
                  sstr:=sstr+RightLine(PdrMass[5,1],13)+' ';
                  PdrMass[5,1]:='0';
                  sstr:=sstr+RightLine(PdrMass[6,1],13)+' ';
                  PdrMass[6,1]:='0';
                  add(sstr);
                  sstr:='';
               end
            end
             else
             begin //при не автоматическом наборе заказчиков
                  sstr:=sstr+LeftLine(CstStringGrid.Cells[0,m],40)+' ';
//                  sstr:=sstr+RightLine(Total_P_Number,13)+' '+RightLine(Total_F_Number,13)+' ';
                  sstr:=sstr+//RightLine(Total_P_Number,13)+' '+
                             RepeatLine(' ', 14)+
                             RightLine(FormatFloat( '0.00',StrToFloat(PdrMass[5,1]) + StrToFloat(PdrMass[6,1])), 13)+' ';
                  P_Number:='0';
                  F_Number:='0';
                  For n:=1 to 4 do
                  begin
                     sstr:=sstr+RightLine(PdrMass[n,1],13)+' ';
                     PdrMass[n,1]:='0';
                  end;
                  sstr:=sstr+RightLine(PdrMass[5,1],13)+' ';
                  PdrMass[5,1]:='0';
                  sstr:=sstr+RightLine(PdrMass[6,1],13)+' ';
                  PdrMass[6,1]:='0';
                  add(sstr);
                  sstr:='';
             end;
{            add(sstr);
            sstr:='';}
          end;

       end;
       Add(RepeatLine('-',k));
       sstr:=RightLine('Всего:',40)+ ' ';
//       sstr:=sstr+RightLine(Total_P_Number, 13)+' '+RightLine(Total_F_Number, 13)+' ';
       sstr:=sstr+//RightLine(Total_P_Number, 13)+' '+
                  RepeatLine(' ', 14)+
                  RightLine(FormatFloat( '0.00',StrToFloat(PdrMass[5,2])+StrToFloat(PdrMass[6,2])), 13)+' ';
       For n:=1 to 4 do
       begin
          sstr:=sstr+RightLine(PdrMass[n,2],13)+' ';
//          All:=All+StrToFloat(PdrMass[n,2]);
       end;
       sstr:=sstr+RightLine(PdrMass[5,2],13)+' ';
       sstr:=sstr+RightLine(PdrMass[6,2],13)+' ';
//       sstr:=sstr+RightLine(FormatFloat( '0.00',All),17);
       Add(sstr);
       Add(RepeatLine('-',k));
       Add('');
       Add('');
       Add(RightLine('В том числе по материалам по изготовлению: ' + FormatFloat( '0.00', PR_Total_Mtr), k));
       Add(RightLine('В том числе по материалам по ремонту: ' + FormatFloat( '0.00', RS_Total_Mtr), k));
       Add(RightLine('Всего по материалам: ' + FormatFloat( '0.00', PR_Total_Mtr + RS_Total_Mtr), k));
       Add('');
       Add('');
       Add('');
       Add('    Начальник Производства РМП АЦБК ______________________________'+ GetSystemParams('Manager'));
       Add('');
       Add('');
       Add('');
       Add('    Ведущий Эклномист РМП АЦБК ___________________________________'+ GetSystemParams('Economist'));

    end;


      PrForm.Destroy;

      Form.Caption := 'Статистический отчет';
      Form.Editor.show;
      Form.show;

end;


procedure TReport18Form.Button4Click(Sender: TObject);
Var
  PrForm : TProcessForm;
  StrCst : String;
  IntCst : Integer;
begin
      // форма для вывода
      // владелец - программа, а не dll
      PrForm  := TProcessForm.create(Application);

      StrCst := '';
      CstStringGrid.RowCount:=2;

      GridCstQuery.Close;
      GridCstQuery.SQL.Clear;

      GridCstQuery.SQL.Add('Select c.name, a.name ');
      GridCstQuery.SQL.Add('From Spr_Cst a, DH_Order b, Spr_Cst c, DH_Rqst d, ');
      GridCstQuery.SQL.Add('     Spr_Chrt e, DH_PR f, DT_PR g ');
      GridCstQuery.SQL.Add('Where f.date_in >= :date_beg and ');
      GridCstQuery.SQL.Add('      f.date_in <= :date_end and ');
      GridCstQuery.SQL.Add('      f.PR_EXEC = 1        and ');
      GridCstQuery.SQL.Add('      g.ID_PRMTR = f.ID    and ');
      GridCstQuery.SQL.Add('      b.ID = g.ID_ORD      and ');
      GridCstQuery.SQL.Add('      d.ID = b.ID_RQST     and ');
      GridCstQuery.SQL.Add('      c.id = d.id_cst      and ');
      GridCstQuery.SQL.Add('      a.id = c.parentid    and ');
      GridCstQuery.SQL.Add('      e.ID = b.ID_CHRT     and ');
      GridCstQuery.SQL.Add('      (e.VID_CHRT = 0 or e.VID_CHRT is NULL) ');
      If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
      begin
          If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
          begin
            GridCstQuery.SQL.Add('   and b.id_pdr = :id_pdr ')
          end  
           else
          begin
              GridCstQuery.SQL.Add('   and b.id_pdr in (4802, 4803, 4804, 4805) ');
          end;
      end;
      GridCstQuery.SQL.Add('Union ');

      GridCstQuery.SQL.Add('Select c.name, a.name ');
      GridCstQuery.SQL.Add('From Spr_Cst a, DH_Order b, Spr_Cst c, DH_Rqst d, ');
      GridCstQuery.SQL.Add('     Spr_Chrt e, DH_RS f, DT_RS g ');
      GridCstQuery.SQL.Add('Where f.date_in >= :date_beg and ');
      GridCstQuery.SQL.Add('      f.date_in <= :date_end and ');
      GridCstQuery.SQL.Add('      f.PR_EXEC = 1        and ');
      GridCstQuery.SQL.Add('      g.ID_RSMTR = f.ID    and ');
      GridCstQuery.SQL.Add('      b.ID = g.ID_ORD      and ');
      GridCstQuery.SQL.Add('      d.ID = b.ID_RQST     and ');
      GridCstQuery.SQL.Add('      c.id = d.id_cst      and ');
      GridCstQuery.SQL.Add('      a.id = c.parentid    and ');
      GridCstQuery.SQL.Add('      e.ID = b.ID_CHRT     and ');
      GridCstQuery.SQL.Add('      e.VID_CHRT = 1 ');
      If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
      begin
          If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
          begin
            GridCstQuery.SQL.Add('   and b.id_pdr = :id_pdr ')
          end
           else
          begin
              GridCstQuery.SQL.Add('   and b.id_pdr in (4802, 4803, 4804, 4805) ');
          end;
      end;

      //Если включена детализация заказчиков по подразделениям производств
//      If CheckBox.Checked = True Then GridCstQuery.SQL.Add('Order by 1 ')
      //иначе сами производства
//       else
      GridCstQuery.SQL.Add('Order by 2, 1 ');

      GridCstQuery.ParamByName('date_beg').AsString:=BegDateEdit.Text;
      GridCstQuery.ParamByName('date_end').AsString:=EndDateEdit.Text;
      If ((PdrCombo.Text <> '<Object not found>') and (PdrCombo.Text <> '') and (PDRQuery.active))  Then
        If (PDRQuery.FieldByName('code').AsString <> '30-20') Then
          GridCstQuery.ParamByName('id_pdr').AsInteger := PDRQuery.FieldByName('id').AsInteger;
      GridCstQuery.Open;

      i:=0;
      IntCst:=0;
      PrForm.Show;

      While not GridCstQuery.Eof do
      begin
        PrForm.ProgressBar.Position:=(i+1)*100 div GridCstQuery.RecordCount;
        i:=i+1;

           //Для того чтобы выделить 'Наименование' приходится
           //изночально забивать 2 строки. Поэтому добавляя 1-го
           //заказчика, новую строку не добавляем
           If (i<>1) Then
              CstStringGrid.RowCount:=CstStringGrid.RowCount+1;

           //Если включена детализация заказчиков по подразделениям производств
           If CheckBox.Checked = True Then
               CstStringGrid.Cells[0,i]:=GridCstQuery.FieldByName('NAME').AsString
            else  //иначе сами производства
            begin
               If StrCst <> GridCstQuery.FieldByName('NAME_1').AsString Then
               begin
                 IntCst := IntCst + 1;
                 CstStringGrid.Cells[0,IntCst]:=GridCstQuery.FieldByName('NAME_1').AsString;
                 StrCst := GridCstQuery.FieldByName('NAME_1').AsString;
               end
                else CstStringGrid.RowCount:=CstStringGrid.RowCount-1;
            end;    

           GridCstQuery.Next;
      end;
      PrForm.Destroy;

end;

procedure TReport18Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport18Form.Splitter1Moved(Sender: TObject);
begin
        CstStringGrid.DefaultColWidth := CstStringGrid.Width-4;
end;

procedure TReport18Form.PdrAddButtonClick(Sender: TObject);
begin
end;

//процедура удаления подразделения из списка
//i - количество подразделений
//ЗвкStringGrid.RowCount=i+1
//Когда нет ни одного подразделения i=0 ,а PdrStringGrid.RowCount = 2
procedure TReport18Form.CheckBoxClick(Sender: TObject);
begin
      CstStringGrid.RowCount:=2;
      CstStringGrid.Cells[0,1]:='';
      GridCstQuery.Close;
      i:=0;
end;

procedure TReport18Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

procedure TReport18Form.PdrComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_pdr',
                        'Справочник: Подразделения (Выбор)', 0);
end;

procedure TReport18Form.PdrComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PdrQuery, PdrCombo, key, Shift, 1) = false then
    PdrComboButtonClick(Sender);

end;

end.

