{

        Анализ повторяемости цен

}

unit Rep19;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Db, EnumForm4Sel, DBTables;

type
  TReport19Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BegDateEdit: TDateEdit;
    EndDateEdit: TDateEdit;
    Button1: TButton;
    Button2: TButton;
    Query: TQuery;
    ButtonSelPer: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSelPerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     TrOstVar : Real;
       OstVar : Integer;
       TrFVar : Real;

     LISTForm : TLIST_4SELECTForm;
  end;

var
  Report19Form: TReport19Form;

implementation
uses PrintFrm,
    printlibs,
         Libs,
  PrintProces,
   GetPeriods;

{$R *.DFM}

procedure TReport19Form.Button1Click(Sender: TObject);
Var  j,i : Integer;
     Tmp : Integer;
    Code : String;            // Код чертежа
    Form : TShowPrintForm;    // форма печати
  PrForm : TProcessForm;      // форма прогрессора
   Price : Real;              // цена 1 детали заказа

begin
       // форма для вывода
       // владелец - программа, а не dll
       Form    := TShowPrintForm.create(Application);
       PrForm  := TProcessForm.create(Application);

       if (BegDateEdit.Text = '  .  .  ') or (EndDateEdit.Text = '  .  .  ') then
       begin
          MessageDlg('Даты не определены!', mtWarning , [mbYes], 0);
          Exit;
       end;

       Query.ParamByName('date_beg').AsString := BegDateEdit.Text;
       Query.ParamByName('date_end').AsString := EndDateEdit.Text;
       Query.Close;
       Query.Open;

       If Query.Eof Then
       begin
          MessageDlg('Повтор цен не обнаружен!', mtWarning , [mbYes], 0);
          Exit;
       end
       else
        begin
           i:=0;
           PrForm.Show;

           // формирование строк
           with Form.Editor.lines do
           begin

             clear;
             Add('');
             Add(RepeatLine('-',66));
             Add(CentrLine('Анализ повторяемости цен', 66));
             Add(CentrLine('За период с '+BegDateEdit.Text+ ' по '+
                                          EndDateEdit.Text, 66));
             Add('');
             Add('');
             Add(RepeatLine('-',66));
             Add(':  Код чертежа   :  №№ Заявки/Заказ  :    Цена     :     Дата     :');
             Add(':                :                   :             :  выполнения  :');
             Add(RepeatLine('-',66));

             Query.First;
             While not Query.Eof do
             begin
                PrForm.ProgressBar.Position:=(i+1)*100 div Query.RecordCount;

{                If (Query.FieldByName('SUM_DOC').AsFloat > 0) Then
                     Price:=Query.FieldByName('SUM_DOC').AsFloat / Query.FieldByName('NUMBER_F').AsFloat
                 else
                       Price:=Query.FieldByName('SUM_DOC').AsFloat;

                Add(':'+LeftLine(Query.FieldByName('CODE').AsString, 16)+':'+
                    RightLine(Query.FieldByName('NUMBER_1').AsString+'/'+
                              Query.FieldByName('NUMBER').AsString, 19)+':'+
                    RightLine(FormatFloat( '0.00',Price), 13)+':'+
                    CentrLine(Query.FieldByName('DATE_OUT').AsString, 14)+':');

                Code := Query.FieldByName('CODE').AsString;
                //вывод второго чертежа где есть повтор
                Query.Next;}

                Code  := Query.FieldByName('CODE').AsString;
                Price := Query.FieldByName('SUM_DOC').AsFloat / Query.FieldByName('NUMBER_F').AsFloat;

                //вывод второго чертежа где есть повтор
                Query.Next;
                tmp := 0;
                j:=-1;

                While (Code = Query.FieldByName('CODE').AsString) and
                      (not Query.Eof) do
                begin
                   j:=j-1;
                   If FormatFloat( '0.00',Price) <>
                      FormatFloat( '0.00',(Query.FieldByName('SUM_DOC').AsFloat / Query.FieldByName('NUMBER_F').AsFloat)) Then
                   begin
                        Tmp := Tmp + 1;
                   end;     
                   Query.Next;
                end;

                If Tmp > 0 Then
                begin

                    If Query.Eof Then Query.MoveBy(j+1)
                     else Query.MoveBy(j);

                    While (Code = Query.FieldByName('CODE').AsString) and
                          (not Query.Eof) do
                    begin
                       PrForm.ProgressBar.Position:=(i+1)*100 div Query.RecordCount;
                       i:=i+1;
                       Add(':'+LeftLine(Query.FieldByName('CODE').AsString, 16)+':'+
                           RightLine(Query.FieldByName('NUMBER_1').AsString+'/'+
                                     Query.FieldByName('NUMBER').AsString, 19)+':'+
                           RightLine(FormatFloat( '0.00',Query.FieldByName('SUM_DOC').AsFloat/ Query.FieldByName('NUMBER_F').AsFloat), 13)+':'+
                           CentrLine(Query.FieldByName('DATE_OUT').AsString, 14)+':');

                       //вывод следующих чертежей где есть повтор
                       Query.Next;
                    end;
                    Add(RepeatLine('.',66));
                end;

             end;
           end;
        end;

       PrForm.Destroy;

       Form.Caption := 'Форма отчета анализа повторяемости цен';
       Form.Editor.show;
       Form.show;

end;

procedure TReport19Form.FormCreate(Sender: TObject);
begin
  BegDateEdit.text := datetostr(now);
  EndDateEdit.text := datetostr(now);
  ListForm := TLIST_4SELECTForm.create(self);
end;

procedure TReport19Form.Button2Click(Sender: TObject);
begin
        Close;
end;

procedure TReport19Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport19Form.ButtonSelPerClick(Sender: TObject);
var _d1, _d2: tdatetime;
begin
   _d1 := strtodate(BegDateEdit.Text);
   _d2 := strtodate(EndDateEdit.text);
   GetPeriod(_d1, _d2);
   BegDateEdit.Text := datetostr(_d1);
   EndDateEdit.text := datetostr(_d2);

end;

end.
