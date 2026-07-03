unit EnumSTRGEdit;


{

           Модуль EnumSTRGEdit
   Описание: модуль формы работы с формой редактирования
      элемента справочника "Виды заготовок"
   Вызывается из модуля EnumEdit
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables;

type
  TENUM_STRGForm = class(TForm)
    Close_Buttom: TButton;
    OKButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CodeEdit: TEdit;
    NAMEEdit: TEdit;
    FormulaEdit: TEdit;
    Label4: TLabel;
    qQueryupdate: TQuery;
    qQuery: TQuery;
    procedure FormCreate(Sender: TObject);
    procedure Close_ButtomClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_STRGForm: TENUM_STRGForm;
    EditType : integer;
    ID       : integer;

implementation

uses Main, libs, Base;

{$R *.DFM}

procedure TENUM_STRGForm.FormCreate(Sender: TObject);
begin


  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin
       CodeEdit.Text  := '';
       NameEdit.text  := 'Новый элемент';
       Caption        := 'Новая элемент';
       FormulaEdit.Text:= '0';

       // нахождение максимального кода
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('select max(code) from spr_strg');
       qQueryupdate.open;
       codeEdit.text   := inttostr(qQueryupdate.fields[0].asinteger + 1);


       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into spr_strg');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_strg_GEN,1), :code, :name , :formula)');
       EditType := 0;

    end
  else {редактирование элемента}
     begin
       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand(uppercase('spr_strg'), 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from spr_strg');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;
       // заполнение информации по полям
       codeEdit.Text   := qQuery.fieldByName('Code').AsString;
       NameEdit.text      := qQuery.fieldByName('Name').AsString;
       FormulaEdit.Text:= qQuery.fieldByName('Formula').AsString;
       Id          := qQuery.fieldByName('ID').AsInteger;

       // формирование запроса для обновления
       qQueryUpdate.SQL.Clear;
       qQueryUpdate.SQL.Add('update spr_strg');
       qQueryUpdate.SQL.add('set CODE = :code, NAME = :name , Formula = :Formula');
       qQueryUpdate.SQL.add('where ID =  :ID');
       EditType := 1;
       Caption := 'Элемент: ' + NameEdit.text;

     end;


end;

procedure TENUM_STRGForm.Close_ButtomClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TENUM_STRGForm.OKButtonClick(Sender: TObject);
begin
  if EditType > 0 then
    qQueryUpdate.ParamByName('ID').asinteger      := ID;

    if (ChechUniqueCode('spr_strg', 'code', trim(CodeEdit.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;


  // заполнение параметров запроса
  qQueryupdate.ParamByName('Code').value    := CodeEdit.text;
  qQueryupdate.ParamByName('Name').value    := NameEdit.Text;

  if trim(FORMULAEdit.text) <> '' then
    qQueryupdate.ParamByName('FORMULA').value:= FORMULAEdit.text
  else
    qQueryupdate.ParamByName('FORMULA').asinteger := 0;

   try
    data.RMPBase.StartTransaction;
    qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

  ID := findIDbyCode('spr_strg', trim(CodeEdit.text));
  MainForm.ID := ID;

  ModalResult := mrOK;

end;

procedure TENUM_STRGForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
