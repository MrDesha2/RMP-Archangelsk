unit Planning_Form;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, DBCtrls, RXCtrls, Mask, ExtCtrls, ToolEdit, DateUtil;

type
  TPlanningForm = class(TForm)
    Query1: TQuery;
    Query2: TQuery;
    Query3: TQuery;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    OKButton: TButton;
    RESButton: TButton;
    CloseButton: TButton;
    GroupBox3: TGroupBox;
    RxCheckListBox: TRxCheckListBox;
    StaticText: TStaticText;
    PDRCombo: TComboEdit;
    qPDRQuery: TQuery;
    procedure OKButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure RxCheckListBoxClick(Sender: TObject);
    Procedure Start_zajav;
    Procedure Spos(j : integer);
    Procedure Start_chert;
    Procedure Zapolnenie_parametrov();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PDRComboButtonClick(Sender: TObject);
    procedure PDRComboKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
     aIDarray,
     aNarray   : array of integer;
     size      : integer;
  end;

var
  PlanningForm: TPlanningForm;
  n,m1,k,nn,m,qw           : Integer;
  d,c,qq,aNext,lz,iz,rd, x : array of integer;
       b,p,az,rp,rv,rx,ty  : array of real;
                   quo : array of array of real;
                  inom : array of integer;
                   rva : array of real;
                 ibase : array of integer;
  massn, massk, massm1 : array of integer;

implementation

uses libs, JRPLANFACTForm;

{$R *.DFM}


Procedure TPlanningForm.Start_zajav;
var i,j,h,s,kk : integer;
begin
      aNext[1]:=0; c[0]:=-1; s:=0; j:=0;
      //проходим по всем заявкам отобранным в процедуре Zapolnenie_parametrov()
      Query2.First;
      While not Query2.Eof do //1:n
      begin
             j:=j+1;
            //h, c[j] - приоритет заявок
            //h:=round(random*10); c[j]:=h;
            h := Query2.FieldByName('PR_URGEN').asinteger;
            c[j]:=h;
            //qq[j] - порядковый номер заказчика заказа j
            //qq[j]:=j mod k + 1;
 //           qq[j]:=PlanningForm.Query2.FieldByName('NUMBER').asfloat;

            {Сортировка заявок по срочности}
            if h>=c[s] then begin aNext[j]:=s; s:=j end
             else
             begin
                i:=s; kk:=aNext[i];
                while c[kk]>h do
                begin
                  i:=kk; kk:=aNext[kk]
                end;
                aNext[i]:=j; aNext[j]:=kk
             end;
            Query2.Next;
      end;
      aNext[0]:=s
end;


      { Ввод нормативов затрат станочного времени на изготовление детали
        квот станочного времени и ресурсов времени работы станочных групп}

// массив p[1..m1] заполняется количеством часов операций заказа j
// по каждой станочной группе; m1 - число станочных групп
Procedure TPlanningForm.Spos(j : integer);
var i : integer;
begin

      // заполняем массив p - временные затраты на заказ
      //m1 - число станочных групп
      for i:=1 to m1 do p[i]:=0;

      //по номеру заказа j находим список его операций и их время
      //по операции находим к какой группе она принадлежит
      //без учета выполненных операций
      //далее заполняем массив p[m1]
      Query3.Close;
      Query3.SQL.Clear;
      Query3.SQL.Add('Select a.ID_VOP, a.NTIME, c.ID');
      Query3.SQL.Add('From DT_Order1 a, DH_Order b, Spr_TpEq c, Spr_Vop d');
      Query3.SQL.Add('WHERE b.ID = :j and a.ID_ORDER = b.ID and ');
      Query3.SQL.Add('d.ID = a.ID_VOP and c.ID = d.ID_TPEQ ');
      Query3.SQL.Add('and d.ID not in (Select b.id_vop ');
      Query3.SQL.Add('                 From  DT_Order1 b, DT_Order2 c');
      Query3.SQL.Add('                 Where b.ID_ORDER = :j and c.ID_ORDER = :j');
      Query3.SQL.Add('                       and b.ID_VOP = c.ID_VOP)');
      Query3.ParamByName('j').Value := j;

      Query3.Open;
      Query3.First;
      While not Query3.Eof do
      begin
         p[Query3.FieldByName('ID').AsInteger]:=p[Query3.FieldByName('ID').AsInteger]+Query3.FieldByName('NTIME').asfloat;
         Query3.Next;
      end;
end;

Procedure TPlanningForm.Start_chert;
var i,j,s,q : integer;
    h    : real;
begin
      lz[0]:=0; s:=0;
      // Обнуляем массив b - ресурсы времени станочных групп
      // Обнуляем массив quo - квоты станочных групп
      // m1 - число станочных групп, k - количество подразделений
      // по каждой станочной группе достаем квоты каждого производства на эту группу
      for i:=1 to m1 do
      begin
         Query3.SQL.Clear;
         Query3.Close;
         Query3.SQL.Add('SELECT NTIME');
         Query3.SQL.Add('FROM Spr_TpEq');
         Query3.SQL.Add('WHERE ID = :id');
         Query3.ParamByName('id').Value := massm1[i];
         Query3.Open;
         b[i] := Query3.FieldByName('NTIME').AsInteger;
         for q:=1 to k do
         begin
            Query3.SQL.Clear;
            Query3.Close;
            Query3.SQL.Add('Select NSIZE');
            Query3.SQL.Add('From QuotaCst');
            Query3.SQL.Add('WHERE ID_CST = :cst and ID_TPEQ = :tpeq');
            Query3.ParamByName('cst').Value := massk[q];
            Query3.ParamByName('tpeq').Value := massm1[i];
            Query3.Open;
            quo[i,q]:=Query3.FieldByName('NSIZE').AsInteger
         end;
      end;

      for j:=1 to n do
      begin
   //Нормативы затрат времени по заявке j формирует
   // процедура spos(j) в массиве p[1..m1]
   //в массиве mass[1..n] - находятся настоящие номера (ID) заказов
         spos(massn[j]);
         for i:=1 to m1 do
            if p[i]>=0.09 then
            begin
               inc(s);
       {      Aadd(iz); Aadd(az);               пополнение массивов    }
   //iz[s] - номер станкa, требуемого для изготовления детали (Real)
   //d[j] - объем заявок в штуках
   //az[s] - норматив затрат станочного времени на изготовление одной детали (Real)
   //qq[j] - порядковый номер заказчика
   //quo[m1,k] - квотa станочных норм (Real),
   //m1- число станочных групп, k - количество подразделений
               iz[s]:=i; h:=p[i]*d[j]; az[s]:=p[i];
//               quo[i,qq[j]]:=quo[i,qq[j]]+h;
               quo[i,0]:=quo[i,0]+h
            end;
            //lz[j] - разграничителей массива столбцов (Integer),
            lz[j]:=s
       end;

   //m1- число станочных групп, k - количество подразделений
   //quo[m1,k] - квотa станочных норм (Real),
   //b[i]  = ресурс на станок i
       for i:=1 to m1 do
          if quo[i,0]>0 then
          begin
//             b[i]:=quo[i,0];  //сумма часов работы i-го типа станков
             b[0]:=b[0]+quo[i,0];
          end;

end;


{*****************************  Процедуры расчета объемного плана }
                                   {Расчет на основании квот}
Procedure Plan1;
var i,j,s,t,w,r,bz : integer;
    h              : real;
    y              : array of array of real;
    yy             : array of real;
begin

      Setlength(yy, m1+1);
      Setlength(y, m1+1, k+1);

      //b[i]  = ресурс на станок i 
      //yy[i] = нераспределенный остаток , сначало онравен ресурсу
      //y = остаток квоты
      for i:=1 to m1 do
      begin
         yy[i]:=b[i];
         for s:=1 to k do
            y[i,s]:=quo[i,s]
      end;

      for j:=1 to n do
         x[j]:=0;

      j:=aNext[0];
      while j>0 do
      begin
         r:=qq[j]; w:=d[j];
         for s:=lz[j-1]+1 to lz[j] do
         begin
            //число деталей на которое хватает квоты
            t:=round(y[iz[s],r]/az[s]-0.45);
            if t<w then w:=t
         end;

         //включение в план на столько деталей на которое хватает квоты
         for s:=lz[j-1]+1 to lz[j] do
         begin
            bz:=iz[s]; h:=az[s]*w;
            y[bz,r]:=y[bz,r]-h;
            yy[bz]:=yy[bz]-h
         end;
         x[j]:=x[j]+w;
         j:=aNext[j]
      end;

      //тоже что выше но из остатка общего ресурса
      j:=aNext[0];
      while j>0 do
      begin
//         r:=qq[j];
         if x[j]<d[j] then
         begin
            w:=d[j]-x[j];
            for s:=lz[j-1]+1 to lz[j] do
            begin
               t:=round(yy[iz[s]]/az[s]+0.45);
               if t<w then w:=t
            end;

            for s:=lz[j-1]+1 to lz[j] do
               yy[iz[s]]:=yy[iz[s]]-az[s]*w;
            x[j]:=x[j]+w;
         end;
         j:=aNext[j];
      end;

//блок вывода параметров
{            For i:=0 to m1+k+n do
              For j:=0 to 20 do
                OutPlanningForm.StringGrid1.Cells[i,j]:='';

            OutPlanningForm.StringGrid1.RowCount:=100;
            OutPlanningForm.StringGrid1.ColCount:=100;
            OutPlanningForm.StringGrid1.Cells[0,1]:='Потребность производства в деталях:';
            OutPlanningForm.StringGrid1.ColWidths[0]:=StrLen('Потребность производства в деталях:')*8;
            h:=0; w:=0; s:=0; r:=0;
            for i:=1 to m1 do
            h:=h+yy[i];
            for j:=1 to n do
               OutPlanningForm.StringGrid1.Cells[j,1]:=IntToStr(d[j]);
            OutPlanningForm.StringGrid1.Cells[0,2]:='Рекомендуемый план на основе квот:';
            s:=0;
            for j:=1 to n do
            begin
               i:=x[j]; r:=r+d[j];
               OutPlanningForm.StringGrid1.Cells[j,2]:=IntToStr(i);
               s:=s+i*c[j]; w:=w+i;
            end;
            OutPlanningForm.StringGrid1.Cells[0,3]:='Выработка деталей:';
            OutPlanningForm.StringGrid1.Cells[1,3]:=IntToStr(w);
            OutPlanningForm.StringGrid1.Cells[2,1]:='='+FloatToStr(100.0*w/r)+'%';
            OutPlanningForm.StringGrid1.Cells[0,4]:='С учетом приоритетов';
            OutPlanningForm.StringGrid1.Cells[1,4]:=IntToStr(s);
            OutPlanningForm.StringGrid1.Cells[0,5]:='Простой оборудования';
            OutPlanningForm.StringGrid1.Cells[1,5]:=FloatToStr(h)+'час.';
            OutPlanningForm.StringGrid1.Cells[0,6]:='Загрузка';
            OutPlanningForm.StringGrid1.Cells[1,6]:=FloatToStr(100.0*(b[0]-h)/b[0])+'%';
            OutPlanningForm.ShowModal; }


end;

    {Определение выводимого из базиса элемента}

procedure New(m,inm,isg,j0 : integer; var a: real; var q : integer);
var  i,k,jm,s : integer;
     //rh,
     rdjj  : real;
begin
      k:=inm-1;
      for i:=1 to k do
         if inom[i]<0 then
         begin
            s:=round(rva[i]);
            a:=rp[s]; rp[s]:=0.0
         end
          else
          begin
             jm:=inom[i];
             rp[jm]:=rp[jm]+a*rva[i]
          end;

      if j0>0 then a:=isg*rd[j0] else a:=10000.0;
      q:=0;

      if isg>=0 then
      begin
         for i:=1 to m do
            if rp[i]>=0.0001 then
            begin
               if rx[i]<rp[i]*a then
               begin
                  a:=rx[i]/rp[i];
                  q:=i
               end
            end
             else
                if rp[i]<=-0.0001 then
                  if ibase[i]>0 then
                  begin
                     rdjj:=rd[ibase[i]];
                     if rdjj-rx[i]+rp[i]*a<0.0 then
                     begin
                        a:=(rx[i]-rdjj)/rp[i];
                        q:=-i
                     end
                  end
      end
       else
       begin
          for i:=1 to m do
             if rp[i]>=0.0001 then
             begin
                if ibase[i]>0 then
                begin
                  rdjj:=rd[ibase[i]];
                  if rd[ibase[i]]-rx[i]<rp[i]*a then
                  begin
                     a:=(rdjj-rx[i])/rp[i];
                     q:=-i
                  end;
                end;  
             end
              else
                 if rp[i]<=-0.0001 then
                   if (rx[i]<-rp[i]*a) then
                   begin
                      a:=-rx[i]/rp[i];
                      q:=i
                   end
       end
end;

                     { Проверка оптимальности текущего базисного плана }
            { Задача с распределением квоты по одному наименованию станка }
procedure opt41(var j0,isg,c0: integer);
var rmax,h,h1    : real;
    i,j,s,t    : integer;

begin
      j0:=0; rmax:=0.0001;
      for j:=1 to n do
      begin
         h:=c[j]; h1:=0;
         for s:=lz[j-1]+1 to lz[j] do
         begin
            t:=iz[s];
            h:=h-rp[t]*az[s];
            if qw=t then h1:=az[s]
         end;
         h:=h-h1*rp[m1+qq[j]];
         if rd[j]>=0.0 then
         begin
            if h>rmax then
            begin
               j0:=j;
               isg:=1;
               rmax:=h
            end
         end
          else
          if -h>rmax then
          begin
             j0:=j;
             isg:=-1;
             rmax:=-h
          end
      end;

      for i:=1 to m do
         if -rp[i]>rmax then
         begin
            j0:=-i;
            isg:=1;
            rmax:=-rp[i]
         end;

         if j0<>0 then
         begin
            for i:=1 to m do
               rp[i]:=0;
            if j0<0 then
            begin
               c0:=0;
               rp[-j0]:=1
            end
             else
             begin
                c0:=c[j0]; h1:=0;
                for s:=lz[j0-1]+1 to lz[j0] do
                begin
                   t:=iz[s];
                   rp[t]:=az[s];
                   if qw=t then h1:=az[s];
                end;
                rp[m1+qq[j0]]:=h1;
             end
         end
end;

{ Мультипликативный симплекс со сжатием столбцов
   и алг.учетом верхней границы переменных
  Результаты расчета: 1) Оптимальный план x[1..n]
     2) Двойственные преременные rp[1..m]     }

procedure Plan41;
label  100,  800;
var  i,j,j0,jm,q,r,c0    : integer;
     isg,jq,inm,inmax    : integer;
     a, rh               : real;
begin
      // it:=0;
      inmax:=2000-m; inm:=1;
      for i:=1 to n do
         rd[i]:=d[i];

      for i:=1 to m1 do
      begin
         rx[i]:=b[i];
         rv[i]:=0;
         ibase[i]:=-i
      end;

      for i:=m1+1 to m do         ///Ошибка
      begin

         rx[i]:=quo[qw,i-m1]; 
         rv[i]:=0;
         ibase[i]:=-i
      end;

//100:  inc(it);

100: for i:=1 to m do
         rp[i]:=rv[i];
      a:=0.0;

      for i:=inm-1 downto 1 do
      begin
         jm:=inom[i];
         if jm<0  then
         begin
            jm:=round(rva[i]);
            rp[jm]:=a;
            a:=0.0
         end
          else a:=a+rp[jm]*rva[i]
      end;

      opt41(j0,isg,c0);
      if j0=0 then goto 800;
      New(m,inm,isg,j0,a,q);
      if q<0 then
      begin
         q:=-q;
         jq:=ibase[q];
         rd[jq]:=-rd[jq]
      end;
      rh:=a*isg;
      for i:=1 to m do
         rx[i]:=rx[i]-rh*rp[i];

      if (q=0) or (isg<0) then rd[j0]:=-rd[j0];
      if q=0 then goto 100;
      if isg<0 then a:=rd[j0]-a;
      rv[q]:=c0; ibase[q]:=j0;
      rx[q]:=a; rva[inm]:=q;
      a:=-1.0/rp[q];
      rp[q]:=-1.0; r:=inm+1;
      for i:=1 to m do
         if abs(rp[i])>0.00001 then
         begin
            inom[r]:=i;
            rva[r]:=rp[i]*a;
            r:=r+1
         end;

      inom[inm]:=-r; inm:=r;
      if inm<inmax then goto 100;

      { расшифровка ответа и вывод его }
800:  for j:=1 to n do
         if rd[j]<0 then x[j]:=d[j]
          else x[j]:=0;

      a:=0; //rh:=0; h:=0;
      for i:=1 to m do
         if ibase[i]>0 then x[ibase[i]]:=round(rx[i])
          else a:=a+rx[i];


//блок вывода параметров
 {           For i:=0 to m1+k+n do
              For j:=0 to 20 do
                OutPlanningForm.StringGrid1.Cells[i,j]:='';

            OutPlanningForm.StringGrid1.RowCount:=100;
            OutPlanningForm.StringGrid1.ColCount:=100;
            OutPlanningForm.StringGrid1.Cells[0,1]:='Расчет на основе линейной оптимизации (с учетом приоритетов):';
            OutPlanningForm.StringGrid1.ColWidths[0]:=StrLen('Расчет на основе линейной оптимизации (с учетом приоритетов):')*8;
            for j:=1 to n do
            begin
                k:=x[j];
                OutPlanningForm.StringGrid1.Cells[j,1]:=IntToStr(k);
                i:=i+k*c[j]; jj:=jj+k; q:=q+d[j]
            end;
            OutPlanningForm.StringGrid1.Cells[0,3]:='Выработка деталей:';
            OutPlanningForm.StringGrid1.Cells[1,3]:=IntToStr(jj);
            OutPlanningForm.StringGrid1.Cells[2,1]:='='+FloatToStr(100.0*jj/q)+'%';
            OutPlanningForm.StringGrid1.Cells[0,4]:='С учетом приоритетов';
            OutPlanningForm.StringGrid1.Cells[1,4]:=IntToStr(i);
            OutPlanningForm.StringGrid1.Cells[0,5]:='Простой оборудования';
            OutPlanningForm.StringGrid1.Cells[1,5]:=FloatToStr(a)+'час.';
            OutPlanningForm.StringGrid1.Cells[0,6]:='Загрузка';
            OutPlanningForm.StringGrid1.Cells[1,6]:=FloatToStr(100.0*(b[0]-a)/b[0])+'%';
            OutPlanningForm.StringGrid1.Cells[0,7]:='Оценка единицы станочного времени:';
            for i:=1 to m1 do
               OutPlanningForm.StringGrid1.Cells[0,7]:=FloatToStr(rp[i]);
            OutPlanningForm.ShowModal;
                              }

end;

procedure opt42(var j0,isg,c0: integer);
var rmax,h : real;
     i,j,s : integer;
begin
      j0:=0; rmax:=0.0001;
      for j:=1 to n do
         if rd[j]>0 then
         begin
            h:=c[j];
            for s:=lz[j-1]+1 to lz[j] do
               h:=h-rp[iz[s]]*az[s];
               if rd[j]>=0.0 then
               begin
                  if h>rmax then
                  begin
                     j0:=j;
                     isg:=1;
                     rmax:=h
                  end
               end
                else
                   if -h>rmax then
                   begin
                      j0:=j;
                      isg:=-1;
                      rmax:=-h
                   end
         end;

         for i:=1 to m do
            if -rp[i]>rmax then
            begin
               j0:=-i;
               isg:=1;
               rmax:=-rp[i]
            end;

         if j0<>0 then
         begin
            for i:=1 to m do
               rp[i]:=0;
            if j0<0 then
            begin
               c0:=0;
               rp[-j0]:=1
            end
             else
             begin
                c0:=c[j0];
                for s:=lz[j0-1]+1 to lz[j0] do
                   rp[iz[s]]:=az[s]
             end
         end
end;


procedure Plan42;
label  100,  800;
var  i,j,j0,jm,k,q,r,s,c0    : integer;
     isg,jq,inm,inmax        : integer;
     a, rh                   : real;
begin
      inmax:=1000-m; inm:=1; isg:=1; { формирование начального плана }
      for i:=1 to m do
      begin
         rx[i]:=b[i];
         rv[i]:=0;
         ibase[i]:=-i
      end;

      for i:=1 to n do
      begin
         k:=x[i];
         rd[i]:=d[i]-k;
         for s:=lz[i-1]+1 to lz[i] do
            rx[iz[s]]:=rx[iz[s]]-az[s]*k
      end;

      for i:=1 to m do
         if rx[i]<0 then rx[i]:=0;



100: for i:=1 to m do
         rp[i]:=rv[i];
      a:=0.0;

      for i:=inm-1 downto 1 do
      begin
         jm:=inom[i];
         if jm<0  then
         begin
            jm:=round(rva[i]);
            rp[jm]:=a;
            a:=0.0
         end
          else a:=a+rp[jm]*rva[i]
      end;

      opt42(j0,isg,c0);
      if j0=0 then goto 800;
      New(m,inm,isg,j0,a,q);
      if q<0 then
      begin
         q:=-q; jq:=ibase[q]; rd[jq]:=-rd[jq]
      end;

      rh:=a*isg;
      for i:=1 to m do
         rx[i]:=rx[i]-rh*rp[i];

      if (q=0) or (isg<0) then rd[j0]:=-rd[j0];
      if q=0 then goto 100;
      if isg<0 then a:=rd[j0]-a;
      rv[q]:=c0; ibase[q]:=j0;
      rx[q]:=a; rva[inm]:=q;
      a:=-1.0/rp[q];
      rp[q]:=-1.0; r:=inm+1;

      for i:=1 to m do
         if abs(rp[i])>0.00001 then
         begin
            inom[r]:=i;
            rva[r]:=rp[i]*a;
            r:=r+1
         end;

      inom[inm]:=-r; inm:=r;
      if inm<inmax then goto 100;

         { расшифровка ответа и вывод его }
800:  for j:=1 to n do
         if rd[j]<0 then x[j]:=x[j]+rd[j];
      a:=0;// rh:=0; h:=0;
      for i:=1 to m do
      //в массиве rx[i] может быть сделано и пол детали, но так как
      // происходит округление то получается целая деталь!!!
         if ibase[i]>0 then x[ibase[i]]:=x[ibase[i]]+round(rx[i])
          else a:=a+rx[i];
end;

procedure Plan4;
begin
      m:=m1+k;
      Plan41;
      m:=m1;
      Plan42
end;

procedure TPlanningForm.OKButtonClick(Sender: TObject);
var j,i : integer;
begin
        if qPDRQuery.FieldByName('ID').asinteger = 0 then
          begin
            MessageDlg('Подразделение(участок) не выбран!', mtInformation, [mbOK], 0);
            abort;
          end;


        Zapolnenie_parametrov;

        //если количество заказов  = 0
        if n = 0 Then
           Exit;
        //поиск отмеченной станочной группы в окошке "Приоритет станочной группы:"
        j:=0;
        While ((j<=m1) and (RxCheckListBox.Checked[j] <> True)) do
           j:=j+1;
        If j<=m1 then
        begin
           Query3.SQL.Clear;
           Query3.Close;
           Query3.SQL.Add('SELECT ID');
           Query3.SQL.Add('FROM SPR_TpEq');
           Query3.SQL.Add('WHERE NAME = :name');
           Query3.ParamByName('name').Value := RxCheckListBox.Items.Strings[j];
           Query3.Open;
           i:=0;
           
           While (massm1[i]<>Query3.FieldByName('ID').AsInteger) and (i<=m1) do i:=i+1;

           qw := i; //отмеченная станочная группа
        end;

        //запуск планирования
         Plan1();
         Plan4();

        SetLength(aIDarray, n + 1);
        SetLength(aNarray,  n + 1);
        for j := 0 to n do
          begin
            aIDarray[ j ] := massn [ j ];
            aNarray [ j ] := x [ j ];
          end;
        size := n;  


        ModalResult := mrOK;

end;


procedure TPlanningForm.CloseButtonClick(Sender: TObject);
begin
         SetLength(d,0);
         SetLength(x,0);
         SetLength(c,0);
         SetLength(qq,0);
         SetLength(anext,0);
         SetLength(rd,0);

         SetLength(b,0);
         SetLength(lz,0);
         SetLength(p,0);
         SetLength(rp,0);
         SetLength(rv,0);
         SetLength(rx,0);
         SetLength(ty,0);

         SetLength(quo,0,0);

         SetLength(iz,0);
         SetLength(az,0);

         SetLength(inom,0);
         SetLength(rva,0);

         SetLength(ibase,0);

         SetLength(massn,0);
         SetLength(massm1,0);
         SetLength(massk,0);



         ModalResult := mrCancel;
end;

procedure TPlanningForm.DBLookupComboBox1Click(Sender: TObject);
begin
       Query1.Active := True;

end;

Procedure TPlanningForm.Zapolnenie_parametrov();
var nn1,i : integer;
  Ind_Cst : array of integer;
Date_Plan : TDateTime;
      tmp : String;
begin

       Tmp :=IntToStr(JRPLANFACTForm.Period -
                     (JRPLANFACTForm.Period div 12) * 12 + 1 );
       If Length(Tmp) = 1 Then Tmp := '0'+Tmp;

       Date_Plan := StrToDate(IntToStr(DaysPerMonth(2000+JRPLANFACTForm.Period div 12, StrToInt(Tmp)))+ '.'+
                       Tmp+'.'+IntToStr(2000+JRPLANFACTForm.Period div 12));
                       
       TMP := DateToStr(Date_Plan);

       //Вычисление количества заказчиков нахадящихся в заказах
       Query3.SQL.Clear;
       Query3.Close;
       If (not qPDRQuery.active) or (PDRCombo.text = '') Then
       begin
          Query3.SQL.Add('SELECT count(DISTINCT a.ID_CST) as M');
          Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b');
          Query3.SQL.Add('WHERE a.ID = b.ID_RQST and b.NUMBER_P>0 ');
          Query3.SQL.Add('and CAST(b.PR_EXEC AS INTEGER) < 3');
          Query3.SQL.Add('and DATE_OUT <= :date');
       end
        else
        begin
           Query3.SQL.Add('SELECT count(DISTINCT a.ID_CST) as M');
           Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b, Spr_Pdr c');
           Query3.SQL.Add('WHERE c.ID = :id and b.ID_PDR = c.ID ');
           Query3.SQL.Add('and b.PR_EXEC< 3 ');
           Query3.SQL.Add('and a.ID = b.ID_RQST and b.NUMBER_P>0');
           Query3.SQL.Add('and DATE_OUT <= :date');
           Query3.ParamByName('id').AsInteger:=qPDRQuery.FieldByName('ID').asinteger;
        end;

       Query3.ParamByName('date').AsDate := Date_Plan;
       Query3.Open;

       //переменная к - количество заказчиков
       k := Query3.FieldByName('M').AsInteger;

       //заполнение массива massk номерами заказчиков
       //понадобится для расшифровки подразделений
       Query3.SQL.Clear;
       Query3.Close;
       If  (not qPDRQuery.Active) or (PDRCombo.text = '') Then
       begin
          Query3.SQL.Add('SELECT a.ID_CST');
          Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b');
          Query3.SQL.Add('WHERE a.ID = b.ID_RQST');
          Query3.SQL.Add('and CAST(b.PR_EXEC AS INTEGER) < 3 and b.NUMBER_P>0');
          Query3.SQL.Add('and DATE_OUT <= :date');
          Query3.SQL.Add('GROUP BY a.ID_CST');
       end
        else
        begin
           Query3.SQL.Add('SELECT a.ID_CST');
           Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b, Spr_Pdr c');
           Query3.SQL.Add('WHERE c.ID = :id and b.ID_PDR = c.ID ');
           Query3.SQL.Add('and CAST(b.PR_EXEC AS INTEGER) < 3 ');
           Query3.SQL.Add('and a.ID = b.ID_RQST and b.NUMBER_P>0');
           Query3.SQL.Add('and DATE_OUT <= :date');
           Query3.SQL.Add('GROUP BY a.ID_CST');

           Query3.ParamByName('id').AsInteger := qPDRQuery.FieldByName('ID').asinteger;
        end;

       Query3.ParamByName('date').AsDate := Date_Plan;
       Query3.Open;
       Query3.First;
       SetLength(massk,0);
       SetLength(massk,k+1);
       i:=1;
       While not Query3.Eof do
       begin
          massk[i] := Query3.FieldByName('ID_CST').AsInteger;
          i:=i+1;
          Query3.Next;
       end;

       //выделяю массив Ind_Cst содеражащий количество ячеек равное
       //максимальному ID в таблице Spr_Cst = заказчики
       Query3.SQL.Clear;
       Query3.Close;
       Query3.SQL.Add('SELECT MAX(ID) AS M');
       Query3.SQL.Add('FROM Spr_Cst');
       Query3.Open;
       SetLength(Ind_Cst, 0);
       SetLength(Ind_Cst, Query3.FieldByName('M').AsInteger);
       For i:=1 to k do
          Ind_Cst[massk[i]]:=i;

      //Вычисление количеста заказов
      //Если не выбрано по какому участку то считаетсч по всем участкам
      if (not qPDRQuery.active) or (PDRCombo.text = '') Then
      begin
         //меняем запрос с подщета количества заказов на вывод всех заказов
         Query2.SQL.Clear;
         Query2.Close;
         Query2.SQL.Add('SELECT a.ID, a.NUMBER_P, c.ID_CST, a.PR_URGEN');
         Query2.SQL.Add('FROM DH_Order a, DH_RQST c');
         Query2.SQL.Add('WHERE c.ID = a.ID_RQST');
         Query2.SQL.Add('CAST(a.PR_EXEC AS INTEGER)< 3 and a.NUMBER_P>0');
         Query2.SQL.Add('and a.DATE_OUT <= :date');

         Query2.ParamByName('date').AsDate := Date_Plan;
         Query2.Open;

         n := Query2.RecordCount; //переменная n - количество заказов
      end
       else
       begin
          //меняем запрос с подщета количества заказов по выбранному подразделению
          //на вывод всех заказов по выбранному подразделению
          Query2.SQL.Clear;
          Query2.Close;
          Query2.SQL.Add('SELECT a.ID, a.NUMBER_P, c.ID_CST, a.PR_URGEN');
          Query2.SQL.Add('FROM DH_Order a, SPR_PDR b, DH_RQST c');
          Query2.SQL.Add('WHERE b.ID = :id and a.ID_PDR = b.ID and c.ID = a.ID_RQST');
          Query2.SQL.Add('and CAST(a.PR_EXEC AS INTEGER) < 3 and a.NUMBER_P>0 ');
          Query2.SQL.Add('and a.DATE_OUT <= :date');

          Query2.ParamByName('date').AsDate := Date_Plan;
          Query2.ParamByName('id').AsInteger := qPDRQuery.FieldbyName('ID').asinteger;
          Query2.Open;

          n := Query2.RecordCount; //переменная n - количество заказов

          If n = 0 Then
          begin
                ShowMessage('Заказы предназначенные для подразделения: '+chr(10)+chr(13)+
                     PDRCombo.text +chr(10)+chr(13)+' не найдены!'+chr(10)+chr(13)+'Оптимизация не корректна!!!');
                Exit;

          end;
       end;

       //заполнение массива massn номерами заказов
       //понадобится для расшифровки заказов
       Query2.First;
       SetLength(massn,0);
       SetLength(massn,n+1);

       //d[i] - объем заказов i-го заказчика в штуках
       //d[i]:=(round(random*6)+2)*10;
       SetLength(d,0);
       SetLength(d,n+1);      //объем заявок в штуках d[1..n]

       SetLength(qq,0);
       SetLength(qq,n+1);     //порядковый номер заказчика от 1 до k qq[1..n]

       i:=1;
       While not Query2.Eof do
       begin
          massn[i]:=Query2.FieldByName('ID').AsInteger;
          d[i]:=Query2.FieldByName('NUMBER_P').AsInteger;
          if d[i] < 1 Then d[i] := 1;
          qq[i]:=Ind_Cst[Query2.FieldByName('ID_CST').AsInteger];
          i:=i+1;
          Query2.Next;
       end;

       SetLength(Ind_Cst, 0);

       //Вычисление количества станочных групп
       Query3.SQL.Clear;
       Query3.Close;
       Query3.SQL.Add('SELECT Count(ID) as M');
       Query3.SQL.Add('FROM Spr_TpEq');
       Query3.SQL.Add('WHERE PARENTID = 0 or PARENTID IS NULL');
       Query3.Open;
       //переменная m1 - количество станочных групп
       m1 := Query3.FieldByName('M').AsInteger;

       //заполнение массива massm1 номерами групп
       //понадобится для расшифровки групп
       Query3.SQL.Clear;
       Query3.Close;
       Query3.SQL.Add('SELECT ID');
       Query3.SQL.Add('FROM Spr_TpEq');
       Query3.SQL.Add('WHERE PARENTID = 0');
       Query3.Open;
       Query3.First;
       SetLength(massm1,0);
       SetLength(massm1,m1+1);
       i:=1;
       While not Query3.Eof do
       begin
          massm1[i]:=Query3.FieldByName('ID').AsInteger;
          i:=i+1;
          Query3.Next;
       end;

       //Вычисление количества заказчиков нахадящихся в заказах
{       Query3.SQL.Clear;
       Query3.Close;
       If (not qPDRQuery.active) or (PDRCombo.text = '') Then
       begin
          Query3.SQL.Add('SELECT count(DISTINCT a.ID_CST) as M');
          Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b');
          Query3.SQL.Add('WHERE a.ID = b.ID_RQST and b.NUMBER_P>0 ');
          Query3.SQL.Add('and CAST(b.PR_EXEC AS INTEGER) < 3');
       end
        else
        begin
           Query3.SQL.Add('SELECT count(DISTINCT a.ID_CST) as M');
           Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b, Spr_Pdr c');
           Query3.SQL.Add('WHERE c.ID = :id and b.ID_PDR = c.ID ');
           Query3.SQL.Add('and b.PR_EXEC< 3 ');
           Query3.SQL.Add('and a.ID = b.ID_RQST and b.NUMBER_P>0');
           Query3.ParamByName('id').AsInteger:=qPDRQuery.FieldByName('ID').asinteger;
        end;

       Query3.Open;
       //переменная к - количество заказчиков
       k := Query3.FieldByName('M').AsInteger;

       //заполнение массива massk номерами заказчиков
       //понадобится для расшифровки подразделений
       Query3.SQL.Clear;
       Query3.Close;
       If  (not qPDRQuery.Active) or (PDRCombo.text = '') Then
       begin
          Query3.SQL.Add('SELECT a.ID_CST');
          Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b');
          Query3.SQL.Add('WHERE a.ID = b.ID_RQST');
          Query3.SQL.Add('and CAST(b.PR_EXEC AS INTEGER) < 3 and b.NUMBER_P>0');
          Query3.SQL.Add('GROUP BY a.ID_CST');
       end
        else
        begin
           Query3.SQL.Add('SELECT a.ID_CST');
           Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b, Spr_Pdr c');
           Query3.SQL.Add('WHERE c.ID = ' +
             intToStr(qPDRQuery.FieldByName('ID').asinteger) + ' and b.ID_PDR = c.ID ');
           Query3.SQL.Add('and CAST(b.PR_EXEC AS INTEGER) < 3 ');
           Query3.SQL.Add('and a.ID = b.ID_RQST and b.NUMBER_P>0');
           Query3.SQL.Add('GROUP BY a.ID_CST');
        end;
       Query3.Open;
       Query3.First;
       SetLength(massk,0);
       SetLength(massk,k+1);
       i:=1;
       While not Query3.Eof do
       begin
          massk[i] := Query3.FieldByName('ID_CST').AsInteger;
          i:=i+1;
          Query3.Next;
       end;}

       //d[i] - объем заказов i-го заказчика в штуках
       //d[i]:=(round(random*6)+2)*10;
{       SetLength(d,0);
       SetLength(d,n+1);      //объем заявок в штуках d[1..n]

       For i:=1 to n do
       begin
           Query3.SQL.Clear;
           Query3.Close;
           Query3.SQL.Add('SELECT NUMBER_P as M');
           Query3.SQL.Add('FROM DH_ORDER');
           Query3.SQL.Add('WHERE ID = :n');
           Query3.ParamByName('n').Value := massn[i];
           Query3.Open;
           d[i]:=Query3.FieldByName('M').AsInteger;
       end;

       //выделяю массив Ind_Cst содеражащий количество ячеек равное
       //максимальному ID в таблице Spr_Cst = заказчики
       Query3.SQL.Clear;
       Query3.Close;
       Query3.SQL.Add('SELECT MAX(ID) AS M');
       Query3.SQL.Add('FROM Spr_Cst');
       Query3.Open;
       SetLength(Ind_Cst, 0);
       SetLength(Ind_Cst, Query3.FieldByName('M').AsInteger);
       For i:=1 to k do
          Ind_Cst[massk[i]]:=i;

       SetLength(qq,0);
       SetLength(qq,n+1);     //порядковый номер заказчика от 1 до k qq[1..n]

       For i:=1 to n do
       begin
          //заполнение массива qq номерами заказчиков
          //понадобится в планировании
          Query3.SQL.Clear;
          Query3.Close;
          Query3.SQL.Add('SELECT a.ID_CST');
          Query3.SQL.Add('FROM DH_RQST a, DH_ORDER b');   //PlanningForm.Query2 b
          Query3.SQL.Add('WHERE b.ID = :id and a.ID = b.ID_RQST');
          Query3.ParamByName('id').Value := massn[i];
          Query3.Open;
          qq[i]:=Ind_Cst[Query3.FieldByName('ID_CST').AsInteger];
       end;
       SetLength(Ind_Cst, 0); }

       //nn - дополнительная память под дополнительные переменные в симплексе
        If StrToInt(Edit1.Text) > 0 then
        begin
             nn:= StrtoInt(Edit1.Text);
        end
         else nn:=10000;

         nn1:=nn;
         m:=m1;

         SetLength(x,0);
         SetLength(c,0);
         SetLength(anext,0);
         SetLength(rd,0);

         SetLength(b,0);
         SetLength(lz,0);
         SetLength(p,0);
         SetLength(rp,0);
         SetLength(rv,0);
         SetLength(rx,0);
         SetLength(ty,0);

         SetLength(quo,0,0);

         SetLength(iz,0);
         SetLength(az,0);

         SetLength(inom,0);
         SetLength(rva,0);

         SetLength(ibase,0);


         SetLength(x,n+1);      //ответ - объемный план РМЗ x[1..n]
         SetLength(c,n+1);      //приоритетов заявок c[1..n]
         SetLength(aNext,n+1);  //цепной список заявок next[1..n]
         SetLength(rd,nn1+1);    //

         SetLength(b,m1+1);     //ресурсов времени работы станочных групп b[1..m1]
//         SetLength(lz,m1+1);    //разграничителей массива столбцов lz[0..m1]
         SetLength(lz,n+1);    //разграничителей массива столбцов lz[0..n]

         Query3.SQL.Clear;
         Query3.Close;
         Query3.SQL.Add('SELECT Max(ID) As ID');
         Query3.SQL.Add('From Spr_TpEq ');
         Query3.Open;

         SetLength(p,Query3.FieldByName('ID').AsInteger+1); //количество часов в заявке на станочную группу
         SetLength(rp,nn1+1);
         SetLength(rv,nn1+1);
         SetLength(rx,nn1+1);
         SetLength(ty,nn1+1);

         SetLength(quo,m1+1,k+1); //квот станочных норм quo[1..m1,1..k]

         SetLength(iz,nn+1);    //номеров станков, требуемых для изготовления
                                //детали заявки iz[0..nn]
         SetLength(az,nn+1);    //нормативов затрат станочного времени на
                                //изготовление одной детали заявки az[0..nn]

         SetLength(inom,nn1);  //Новые массивы: 1) Для записи мультипликаторов
         SetLength(rva,nn1+1);   //inom[1..inmax] rva[1..inmax] inmax определяет
                                //размер области записи мультипликаторов

         SetLength(ibase,nn1+1); //Для записи текущего базисного плана [0..m]?????

         Start_zajav();
         Start_chert();
end;

{

    При изменении значения поля "МВЗ" перезаполняются начальные данные

}



procedure TPlanningForm.Edit1Change(Sender: TObject);
begin
        If Edit1.Text <> '' Then
        //попытка перевести строку в тип int, если это не удается выдаем сообщение
        try
           StrToInt(Edit1.Text);
        except
          ShowMessage('Объем памяти должен быть больше 0 и меньше 2147483647');
        end;
end;

procedure TPlanningForm.RxCheckListBoxClick(Sender: TObject);
Var j : Integer;
begin
        //поиск отмеченной станочной группы в окошке "Приоритет станочной группы:"
        j:=0;
        While ((j<=RxCheckListBox.Items.Count) and (RxCheckListBox.Checked[j] <> True)) do
           j:=j+1;
        If j<=RxCheckListBox.Items.Count then
           StaticText.Caption:=RxCheckListBox.Items.Strings[j] //отмеченная станочная группа
         else
           StaticText.Caption:='Отмеченной группы нет'; //не отмеченная станочная группа
end;


//Выбираем все станочные группы и даем возможность отметить заказчику станочную
//группу имеющую наибольштй приоритет
procedure TPlanningForm.FormActivate(Sender: TObject);
begin
        Query3.SQL.Clear;
        Query3.Close;
        Query3.SQL.Add('SELECT NAME');
        Query3.SQL.Add('FROM SPR_TpEq'); //PlanningForm.Query2 b
        Query3.Open;
        RxCheckListBox.Clear;
        While not Query3.Eof do
        begin
           RxCheckListBox.Items.Add(Query3.FieldByName('NAME').AsString);
           Query3.Next;
        end;

        RxCheckListBox.Checked[0] := true;
        StaticText.Caption:=RxCheckListBox.Items.Strings[0];

       qPDRquery.ParamByName('CODE').asInteger := -1;
       qPDRquery.ParamByName('ID').asInteger   := -1;
       qPDRQuery.open;

       size := 0;

//        Zapolnenie_parametrov;


end;





procedure TPlanningForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;


{
   Процедура выбора значения из справочника "МВЗ"

}
procedure TPlanningForm.PDRComboButtonClick(Sender: TObject);
begin
  SelectFromTable(PDRCombo);

end;

procedure TPlanningForm.PDRComboKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if checkIfExistCode(PDRCombo, key, Shift) = false then
     PDRComboButtonClick(Sender);


end;

end.






