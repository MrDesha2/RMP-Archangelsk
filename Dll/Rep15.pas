{***************************************************************
 *
 * Модуль   : Rep15
 * Описание : Отчет о выполненных работах
 * Авторы   : Косицын Дмитрий, Соколов Владислав
 * История  : 2004
 *
 ****************************************************************}

unit Rep15;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Grids, DBGrids, EnumForm4Sel, Mask, ToolEdit,
  ExtCtrls;

type
  TReport15Form = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    CstQuery: TQuery;
    MainQuery: TQuery;
    IdCstQuery: TQuery;
    IdPdrQuery: TQuery;
    ActTrQuery: TQuery;
    Panel3: TPanel;
    CstAddButton: TButton;
    CstCombo: TComboEdit;
    CstDelButton: TButton;
    Button4: TButton;
    GridCstQuery: TQuery;
    Panel4: TPanel;
    CstStringGrid: TStringGrid;
    PdrStringGrid: TStringGrid;
    Panel5: TPanel;
    PdrAddButton: TButton;
    PdrComboEdit: TComboEdit;
    PdrDelButton: TButton;
    Panel6: TPanel;
    ReportButton: TButton;
    Button2: TButton;
    Button1: TButton;
    Label5: TLabel;
    Label6: TLabel;
    qPDRQuery: TQuery;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Button7: TButton;
    GridPdrQuery: TQuery;
    Label1: TLabel;
    BegDateEdit: TDateEdit;
    Label2: TLabel;
    EndDateEdit: TDateEdit;
    CheckBox: TCheckBox;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    ButtonSetPeriod: TButton;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CstAddButtonClick(Sender: TObject);
    procedure ReportButtonClick(Sender: TObject);
    procedure CstComboButtonClick(Sender: TObject);
    procedure CstComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CstDelButtonClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PdrComboEditButtonClick(Sender: TObject);
    procedure PdrComboEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button7Click(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure PdrAddButtonClick(Sender: TObject);
    procedure PdrDelButtonClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure ButtonSetPeriodClick(Sender: TObject);
  private
    { Private declarations }
  public
     i : Integer;
     LISTForm : TLIST_4SELECTForm;
    { Public declarations }
  end;

var
  Report15Form: TReport15Form;

implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods;

{$R *.DFM}

procedure TReport15Form.FormCreate(Sender: TObject);
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
        PdrStringGrid.Cells[0,0]:='Наименование подразделений';
        BegDateEdit.text := datetostr(now);
        EndDateEdit.text := datetostr(now);
        ListForm := TLIST_4SELECTForm.create(self);
        CstStringGrid.DefaultColWidth := CstStringGrid.Width-4;
        PdrStringGrid.DefaultColWidth := PdrStringGrid.Width-4;
end;

procedure TReport15Form.CstAddButtonClick(Sender: TObject);
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

//            showmessage(IntToStr(GridCstQuery.RecordCount));
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
end;

//процедура удаления организации из списка
//i - количество организаций
//CstStringGrid.RowCount=i+1
//Когда нет ни одной организации i=0 ,а CstStringGrid.RowCount = 2
procedure TReport15Form.CstDelButtonClick(Sender: TObject);
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

procedure TReport15Form.ReportButtonClick(Sender: TObject);
Var PdrMass : array of array of String;
       Form : TShowPrintForm;
     PrForm : TProcessForm;
  h,i,k,n,m : Integer;
       sstr : String;
        All : Real;
      Total : String;
     StrCst : String;  //Производства в которые входят заказчики подразделения
  CstMasStr : String;  //Массив производств введенных вручную 
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);
       StrCst:='';
       If GridCstQuery.Active Then
             GridCstQuery.First;
       h:=0;
       Total:='0';

       SetLength(PdrMass,PdrStringGrid.RowCount,4);
       For n:=1 to PdrStringGrid.RowCount-1 do
       begin
          IdPdrQuery.Close;
          IdPdrQuery.ParamByName('name').AsString:=PdrStringGrid.Cells[0,n];
          IdPdrQuery.Open;
          PdrMass[n,1] := IdPdrQuery.FieldByName('CODE').AsString;
       end;

       //обнуляю счетчик 'Итого' по каждому призводству
       For n:=1 to PdrStringGrid.RowCount-1 do
       begin
          PdrMass[n,2] := '0';
          PdrMass[n,3] := '0';
       end;

       k:=51+(PdrStringGrid.RowCount-1)*15+17+2;
     // формирование строк
     with Form.Editor.lines do
      begin

        clear;

       Add(RepeatLine('-', k));
       Add('');
       Add('');
       Add(CentrLine('О т ч е т',k));
       Add(CentrLine('По выполненным работам (материалам) по '
         + GetSystemParams('Service')
         + ' в руб.',k));
       Add(CentrLine('с '+BegDateEdit.Text+ ' по '+ EndDateEdit.Text,k));
       Add('');

       Add(RepeatLine('-',k));
       sstr:='';
       sstr:='Заказчики:';
       sstr:=sstr+RepeatLine(' ', 43);
       For n:=1 to PdrStringGrid.RowCount-1 do  //цикл по подразделениям для шапки
          sstr:=sstr+CentrLine(PdrMass[n,1],14)+':';

       sstr:=sstr+CentrLine('Итого',17);
       Add(sstr);

       Add(RepeatLine('-',k));
       //CstStringGrid.RowCount-1 = '-1' первое поле 'Наименование'
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
          GridCstQuery.SQL.Add('      a.name in '+CstMasStr);
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
          GridCstQuery.SQL.Add('      a.name in '+CstMasStr);

          GridCstQuery.SQL.Add('Order by 2, 1 ');

          GridCstQuery.ParamByName('date_beg').AsString:=BegDateEdit.Text;
          GridCstQuery.ParamByName('date_end').AsString:=EndDateEdit.Text;
          GridCstQuery.Open;
       end;

       i := GridCstQuery.RecordCount;
       For m:=1 to i do //цикл по заказчикам
       begin
         PrForm.ProgressBar.Position:=(m*(PdrStringGrid.RowCount-1)+1)*100 div
              (CstStringGrid.RowCount-1)*(PdrStringGrid.RowCount-1);
         IdCstQuery.Close;
         IdCstQuery.ParamByName('NAME').AsString:=GridCstQuery.FieldByName('NAME').AsString; //CstStringGrid.Cells[0,m];
         IdCstQuery.Open;

         //Если включена детализация заказчиков по подразделениям производств
         If CheckBox.Checked = True Then
         begin
            Total:='0';
            sstr:='';
            If StrCst <> GridCstQuery.FieldByName('NAME_1').AsString Then
                add(LeftLine(GridCstQuery.FieldByName('NAME_1').AsString, 50));
            sstr:='  '+LeftLine(CstStringGrid.Cells[0,m],50)+' ';
            StrCst:=GridCstQuery.FieldByName('NAME_1').AsString;
         end
          else
             If StrCst <> GridCstQuery.FieldByName('NAME_1').AsString Then
             begin
                 h:=h+1;
                 sstr:=LeftLine(CstStringGrid.Cells[0,h],52)+' ';
                 StrCst:=GridCstQuery.FieldByName('NAME_1').AsString;
             end;

         For n:=1 to PdrStringGrid.RowCount-1 do //цикл по подразделениям
         begin
           IdPdrQuery.Close;
           IdPdrQuery.ParamByName('name').AsString:=PdrStringGrid.Cells[0,n];
           IdPdrQuery.Open;
           MainQuery.Close;
           MainQuery.ParamByName('calc').AsInteger:=1; //статья в калькуляции МАТЕРИАЛЫ
           MainQuery.ParamByName('id_pdr').AsInteger:=IdPdrQuery.FieldByName('ID').AsInteger;
           MainQuery.ParamByName('id_cst').AsInteger:=IdCstQuery.FieldByName('ID').AsInteger;
           MainQuery.ParamByName('beg_date').AsString:=BegDateEdit.Text;
           MainQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
           MainQuery.Open;

           If CheckBox.Checked = True Then
                sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('Price').AsFloat),14)+' ';

           Total:=FormatFloat( '0.00',StrToFloat(Total)+MainQuery.FieldByName('Price').AsFloat);
           PdrMass[n,2]:=FormatFloat( '0.00',StrToFloat(PdrMass[n,2])+MainQuery.FieldByName('Price').AsFloat);
           PdrMass[n,3]:=FormatFloat( '0.00',StrToFloat(PdrMass[n,3])+MainQuery.FieldByName('Price').AsFloat);
         end;

         //Если включена детализация заказчиков по подразделениям производств
         If CheckBox.Checked = True Then
         begin
            sstr:=sstr+RightLine(Total,17);
            Add(sstr);
            GridCstQuery.Next;
            If (StrCst <> GridCstQuery.FieldByName('NAME_1').AsString) or GridCstQuery.Eof Then
            begin
               add(RepeatLine('.',k));
               sstr:=RepeatLine(' ', 53);
               All:=0;
               For n:=1 to PdrStringGrid.RowCount-1 do
               begin
                  sstr:=sstr+RightLine(PdrMass[n,2],14)+' ';
                  All:=All+StrToFloat(PdrMass[n,2]);
                  PdrMass[n,2]:='0';
               end;
               add(sstr+RightLine(FormatFloat( '0.00',All),17));
            end;
         end
          else //иначе только сами производства
          begin
            GridCstQuery.Next;
            If (StrCst <> GridCstQuery.FieldByName('NAME_1').AsString) or GridCstQuery.Eof Then
            begin
               All:=0;
               For n:=1 to PdrStringGrid.RowCount-1 do
               begin
                  sstr:=sstr+RightLine(PdrMass[n,2],14)+' ';
                  All:=All+StrToFloat(PdrMass[n,2]);
                  PdrMass[n,2]:='0';
               end;
               add(sstr+RightLine(FormatFloat( '0.00',All),17));
            end;
          end;
       end;
       Add(RepeatLine('-',k));
       All:=0;
       sstr:=RightLine('Всего:',52)+ ' ';
       For n:=1 to PdrStringGrid.RowCount-1 do
       begin
          sstr:=sstr+RightLine(PdrMass[n,3],14)+' ';
          All:=All+StrToFloat(PdrMass[n,3]);
       end;
       sstr:=sstr+RightLine(FormatFloat( '0.00',All),17);
       Add(sstr);
       Add(RepeatLine('-',k));
    end;


      PrForm.Destroy;

      Form.Caption := 'Бухгалтерский отчет';
      Form.Editor.show;
      Form.show;

end;

procedure TReport15Form.CstComboButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, CSTQuery, CSTCombo, 'select id, code, name from spr_cst',
                        'Справочник: Организации (Выбор)', 0);

end;

procedure TReport15Form.CstComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(CSTQuery, CSTCombo, key, Shift, 1) = false then
    CSTComboButtonClick(Sender);

end;

procedure TReport15Form.Button1Click(Sender: TObject);
begin
        Close;
end;

procedure TReport15Form.Button2Click(Sender: TObject);
Var PdrMass : array of array of String;
       Form : TShowPrintForm;
     PrForm : TProcessForm;
    h,k,n,m : Integer;
       sstr : String;
        All : Real;
      Total : String;
     StrCst : String;  //Производства в которые входят заказчики подразделения
begin
       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);
       StrCst:='';
       GridCstQuery.First;
       h:=0;
       Total:='0';

       SetLength(PdrMass,PdrStringGrid.RowCount,4);
       For n:=1 to PdrStringGrid.RowCount-1 do
       begin
          IdPdrQuery.Close;
          IdPdrQuery.ParamByName('name').AsString:=PdrStringGrid.Cells[0,n];
          IdPdrQuery.Open;
          PdrMass[n,1] := IdPdrQuery.FieldByName('CODE').AsString;
       end;

       //обнуляю счетчик 'Итого' по каждому призводству
       For n:=1 to PdrStringGrid.RowCount-1 do
       begin
          PdrMass[n,2] := '0';
          PdrMass[n,3] := '0';
       end;

       k:=51+(PdrStringGrid.RowCount-1)*15+17+2;

     // формирование строк
     with Form.Editor.lines do
      begin

        clear;

       Add(RepeatLine('-', k));
       Add('');
       Add('');
       Add(CentrLine('О т ч е т',k));
       Add(CentrLine('По выполненным работам (услугам) по '
            + GetSystemParams('Service')
            + ' в руб.',k));
       Add(CentrLine('с '+BegDateEdit.Text+ ' по '+ EndDateEdit.Text,k));
       Add('');

       Add(RepeatLine('-',k));
       sstr:='';
       sstr:='Заказчики:';
       sstr:=sstr+RepeatLine(' ', 43);
       For n:=1 to PdrStringGrid.RowCount-1 do  //цикл по подразделениям для шапки
          sstr:=sstr+CentrLine(PdrMass[n,1],14)+':';

       sstr:=sstr+CentrLine('Итого',17);
       Add(sstr);

       Add(RepeatLine('-',k));
       //CstStringGrid.RowCount-1 = '-1' первое поле 'Наименование'
       For m:=1 to GridCstQuery.RecordCount do //цикл по заказчикам
       begin
         PrForm.ProgressBar.Position:=(m*(PdrStringGrid.RowCount-1)+1)*100 div
              (CstStringGrid.RowCount-1)*(PdrStringGrid.RowCount-1);
         IdCstQuery.Close;
         IdCstQuery.ParamByName('NAME').AsString:=GridCstQuery.FieldByName('NAME').AsString; //CstStringGrid.Cells[0,m];
         IdCstQuery.Open;

         //Если включена детализация заказчиков по подразделениям производств
         If CheckBox.Checked = True Then
         begin
            Total:='0';
            sstr:='';
            If StrCst <> GridCstQuery.FieldByName('NAME_1').AsString Then
                add(LeftLine(GridCstQuery.FieldByName('NAME_1').AsString, 50));
            sstr:='  '+LeftLine(CstStringGrid.Cells[0,m],50)+' ';
            StrCst:=GridCstQuery.FieldByName('NAME_1').AsString;
         end
          else
             If StrCst <> GridCstQuery.FieldByName('NAME_1').AsString Then
             begin
                 h:=h+1;
                 sstr:=LeftLine(CstStringGrid.Cells[0,h],52)+' ';
                 StrCst:=GridCstQuery.FieldByName('NAME_1').AsString;
             end;

         For n:=1 to PdrStringGrid.RowCount-1 do //цикл по подразделениям
         begin
           IdPdrQuery.Close;
           IdPdrQuery.ParamByName('name').AsString:=PdrStringGrid.Cells[0,n];
           IdPdrQuery.Open;

           MainQuery.Close;
           MainQuery.ParamByName('calc').AsInteger:=10; //12 -  статья в калькуляции ВСЕГО
           MainQuery.ParamByName('id_pdr').AsInteger:=IdPdrQuery.FieldByName('ID').AsInteger;
           MainQuery.ParamByName('id_cst').AsInteger:=IdCstQuery.FieldByName('ID').AsInteger;
           MainQuery.ParamByName('beg_date').AsString:=BegDateEdit.Text;
           MainQuery.ParamByName('end_date').AsString:=EndDateEdit.Text;
           MainQuery.Open;

           If CheckBox.Checked = True Then
               sstr:=sstr+RightLine(FormatFloat( '0.00',MainQuery.FieldByName('Price').AsFloat),14)+' ';

           PdrMass[n,2]:=FormatFloat( '0.00',StrToFloat(PdrMass[n,2])+MainQuery.FieldByName('Price').AsFloat);
           PdrMass[n,3]:=FormatFloat( '0.00',StrToFloat(PdrMass[n,3])+MainQuery.FieldByName('Price').AsFloat);
           Total:=FormatFloat( '0.00',StrToFloat(Total)+MainQuery.FieldByName('Price').AsFloat);
         end;

         If CheckBox.Checked = True Then
         begin
            sstr:=sstr+RightLine(Total,17);
            Add(sstr);
            GridCstQuery.Next;
            If (StrCst <> GridCstQuery.FieldByName('NAME_1').AsString) or GridCstQuery.Eof Then
            begin
               add(RepeatLine('.',k));
               sstr:=RepeatLine(' ', 53);
               All:=0;
               For n:=1 to PdrStringGrid.RowCount-1 do
               begin
                  sstr:=sstr+RightLine(PdrMass[n,2],14)+' ';
                  All:=All+StrToFloat(PdrMass[n,2]);
                  PdrMass[n,2]:='0';
               end;
               add(sstr+RightLine(FormatFloat( '0.00',All),17));
            end;
         end
          else //иначе только сами производства
          begin
            GridCstQuery.Next;
            If (StrCst <> GridCstQuery.FieldByName('NAME_1').AsString) or GridCstQuery.Eof Then
            begin
               All:=0;
               For n:=1 to PdrStringGrid.RowCount-1 do
               begin
                  sstr:=sstr+RightLine(PdrMass[n,2],14)+' ';
                  All:=All+StrToFloat(PdrMass[n,2]);
                  PdrMass[n,2]:='0';
               end;
               add(sstr+RightLine(FormatFloat( '0.00',All),17));
            end;
          end;

       end;
       Add(RepeatLine('-',k));
       All:=0;
       sstr:=RightLine('Всего:',52)+ ' ';
       For n:=1 to PdrStringGrid.RowCount-1 do
       begin
          sstr:=sstr+RightLine(PdrMass[n,3],14)+' ';
          All:=All+StrToFloat(PdrMass[n,3]);
       end;
       sstr:=sstr+RightLine(FormatFloat( '0.00',All),17);
       Add(sstr);
       Add(RepeatLine('-',k));
    end;


      PrForm.Destroy;

      Form.Caption := 'Бухгалтерский отчет';
      Form.Editor.show;
      Form.show;

end;


procedure TReport15Form.Button4Click(Sender: TObject);
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

      //Если включена детализация заказчиков по подразделениям производств
//      If CheckBox.Checked = True Then GridCstQuery.SQL.Add('Order by 1 ')
      //иначе сами производства
//       else
      GridCstQuery.SQL.Add('Order by 2, 1 ');

      GridCstQuery.ParamByName('date_beg').AsString:=BegDateEdit.Text;
      GridCstQuery.ParamByName('date_end').AsString:=EndDateEdit.Text;
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

procedure TReport15Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport15Form.PdrComboEditButtonClick(Sender: TObject);
begin
  SelectFromTable(ListForm, qPDRQuery, PDRComboEdit, 'select id, code, name from spr_pdr',
                        'Справочник: МВЗ (Выбор)', 0);

end;

procedure TReport15Form.PdrComboEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(qPDRQuery, PDRComboEdit, key, Shift, 1) = false then
    PDRComboEditButtonClick(Sender);

end;

procedure TReport15Form.Button7Click(Sender: TObject);
Var
//    Form : TShowPrintForm;
  PrForm : TProcessForm;

begin
      // форма для вывода
      // владелец - программа, а не dll
//      Form    := TShowPrintForm.create(_Owner);
      PrForm  := TProcessForm.create(Application);
      PdrStringGrid.RowCount:=2;

      GridPdrQuery.Close;
      GridPdrQuery.ParamByName('date_beg').AsString:=BegDateEdit.Text;
      GridPdrQuery.ParamByName('date_end').AsString:=EndDateEdit.Text;
      GridPdrQuery.Open;

      i:=0;
      PrForm.Show;

      While not GridPdrQuery.Eof do
      begin
        PrForm.ProgressBar.Position:=(i+1)*100 div GridPdrQuery.RecordCount;
        i:=i+1;

           //Для того чтобы выделить 'Наименование' приходится
           //изночально забивать 2 строки. Поэтому добавляя 1-го
           //заказчика, новую строку не добавляем
           If i<>1 Then
              PdrStringGrid.RowCount:=PdrStringGrid.RowCount+1;

           PdrStringGrid.Cells[0,i]:=GridPdrQuery.FieldByName('NAME').AsString;
           GridPdrQuery.Next;
      end;

      PrForm.Destroy;

end;

procedure TReport15Form.Splitter1Moved(Sender: TObject);
begin
        CstStringGrid.DefaultColWidth := CstStringGrid.Width-4;
        PdrStringGrid.DefaultColWidth := PdrStringGrid.Width-4;
end;

procedure TReport15Form.PdrAddButtonClick(Sender: TObject);
begin
      IdPdrQuery.Close;
      IdPdrQuery.ParamByName('NAME').AsString:=PdrComboEdit.Text;
      IdPdrQuery.Open;

      If not IdPdrQuery.Eof Then
      begin
        i:=i+1;

        //Для того чтобы выделить 'Наименование' приходится
        //изночально забивать 2 строки. Поэтому добавляя 1-го
        //заказчика, новую строку не добавляем
        If i<>1 Then
           PdrStringGrid.RowCount:=PdrStringGrid.RowCount+1;

        PdrStringGrid.Cells[0,i]:=PdrComboEdit.Text;
      end
      else
        ShowMessage('Заказчик '+CstCombo.Text+' не найден');
end;

//процедура удаления подразделения из списка
//i - количество подразделений
//ЗвкStringGrid.RowCount=i+1
//Когда нет ни одного подразделения i=0 ,а PdrStringGrid.RowCount = 2
procedure TReport15Form.PdrDelButtonClick(Sender: TObject);
Var myRect: TGridRect;
    j: integer;
begin
        myRect:=PdrStringGrid.Selection;
        if i<=myRect.Bottom Then
        begin
            If myRect.Top<=1 Then
            begin
                PdrStringGrid.RowCount:=2;
                PdrStringGrid.Cells[0,1]:='';
            end
            else PdrStringGrid.RowCount:=myRect.Top;

            i:=myRect.Top-1;
        end
        else
            For j:=myRect.Top to i do
            begin
               If myRect.Bottom+(j-myRect.Top+1)<=i  Then
               begin
                 PdrStringGrid.Cells[0,j]:=
                   PdrStringGrid.Cells[0,myRect.Bottom+(j-myRect.Top+1)];
               end
               else
               begin
                 PdrStringGrid.RowCount:=PdrStringGrid.RowCount-1;
                 i:=i-1;
               end;
            end;
end;

procedure TReport15Form.CheckBoxClick(Sender: TObject);
begin
      CstStringGrid.RowCount:=2;
      CstStringGrid.Cells[0,1]:='';
      GridCstQuery.Close;
      i:=0;
end;

procedure TReport15Form.ButtonSetPeriodClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);


end;

end.

