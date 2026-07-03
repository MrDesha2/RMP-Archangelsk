{

     Модуль формы редактирования элемента справочника "Типы оборудования".
     Вызывается из модуля EnumTreeForm.


}


unit TPEQEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Mask, StdCtrls, Db, DBTables;

type
  TENUM_TPEQ = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Code: TEdit;
    _Name: TEdit;
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    Close_Buttom: TButton;
    OKButton: TButton;
    Label1: TLabel;
    NTimeEdit: TMaskEdit;
    procedure OKButtonClick(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_TPEQ: TENUM_TPEQ;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;
  EnumEdit : TForm;

implementation

uses Main, Base, libs;

{$R *.DFM}
{
   Процедура сохранения изменений по ОК

}
procedure TENUM_TPEQ.OKButtonClick(Sender: TObject);
begin
  // заполнение параметров запроса
  if EditType = 0 then
      qQueryupdate.ParamByName('ParentID').asinteger := ParentID
  else
     qQueryUpdate.ParamByName('ID').asinteger := ID;

    if (ChechUniqueCode('spr_tpeq', 'code', trim(Code.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;


  // код и наименование
  qQueryupdate.ParamByName('Code').value    := Code.text;
  qQueryupdate.ParamByName('Name').value    := _Name.Text;

  // элемент "Время выполнения"
  if trim(nTimeEdit.text) <> '' then
     qQueryupdate.ParamByName('ntime').asinteger := strToInt(trim(nTimeEdit.Text))
  else
     qQueryupdate.ParamByName('ntime').asinteger := 0;


  // выполнение запроса
   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

       ID := findIDbyCode('spr_tpeq', trim(code.text));
       MainForm.ID := ID;


  qquery.close;
  ModalResult := mrOK;

end;

{
   Процедура отмены изменений по Cancel

}
procedure TENUM_TPEQ.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;

end;
{
   Процедура при закрытии формы

}
procedure TENUM_TPEQ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action := caFree;
end;

{
    Процедура при открытии формы редактирования типа оборудования

}

procedure TENUM_TPEQ.FormShow(Sender: TObject);
var qTMPQuery :     tQuery;
begin


  ParentID := MainForm.ParentID;
  // установка значений для связи данных

  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin
        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_tpeq');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);

       _Name.text := 'Новый элемент';
       Caption     := 'Новая элемент';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_tpeq');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_tpeq_GEN,1), :parentID, 0, :code, :name, :ntime)');
       Caption := 'Новый элемент';
       EditType := 0;
    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin
        // формирование запроса для нахождения нового кода
       qTMPQuery             := TQuery.Create(self);
       qTMPQuery.DatabaseName:= data.RMPBase.databasename;
       qTMPQuery.sql.clear;
       qtmpquery.sql.add('select max(code) from spr_tpeq');
       qtmpquery.open;
       code.text  := inttostr(qtmpquery.Fields[0].asinteger + 1);

       _Name.text  := 'Новая группа';
       Caption     := 'Новая группа';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_tpeq');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_tpeq_GEN,1), :parentID, 1, :code, :name, :ntime)');
       EditType := 0;
     end
   else {редактирование элемента}
    if mainForm.isFolder = 3 then {Добавление новой группы}
     begin
       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand(uppercase('spr_tpeq'), 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_tpeq');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       code.Text   := qQuery.fieldByName('Code').AsString;
       _name.text  := qQuery.fieldByName('Name').AsString;

       nTimeEdit.text := qQuery.fieldByName('NTIME').AsString;

       ParentID    := qQuery.fieldByName('ParentID').AsInteger;
       Id          := qQuery.fieldByName('ID').AsInteger;

       // запрос для выполнения транзакции
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_tpeq');
       qQueryUpdate.SQL.add('set CODE = :code, NAME = :name, ntime = :ntime');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;
       Caption := 'Элемент: ' + _name.text;
     end;


end;

end.
