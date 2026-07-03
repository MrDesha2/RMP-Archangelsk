unit EnumAccesstypeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables;

type
  TENUM_ACCESSTYPEForm = class(TForm)
    CodeLabel: TLabel;
    Label1: TLabel;
    CODEEdit: TEdit;
    NameEdit: TEdit;
    OKButton: TButton;
    ButtonClose: TButton;
    qQueryUpdate: TQuery;
    qQuery: TQuery;
    procedure FormShow(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ENUM_ACCESSTYPEForm: TENUM_ACCESSTYPEForm;
  EditType : integer;
  IsFolder : integer;
  ParentID : integer;
  ID       : integer;
  EnumEdit : TForm;
  newrecord: boolean;

implementation

uses Main, Base, libs;

{$R *.dfm}

procedure TENUM_ACCESSTYPEForm.FormShow(Sender: TObject);
begin
   ParentID := MainForm.ParentID;
  if MainForm.IsFolder = 1 then {Добавление элемента}
    begin

       NameEdit.text  := 'Новый элемент';
       Caption     := 'Новый элемент';

       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('SELECT GEN_ID(SPR_ACCESSTYPE_CODE, 1) FROM RDB$DATABASE');
       qQueryupdate.open;
       CodeEdit.Text   := qQueryupdate.Fields[0].AsString;


       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into SPR_ACCESSTYPE');
       qQueryupdate.SQL.add('(ID, parentid, isfolder, code, name)');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_ACCESS_GEN,1), :parentID, 0, :code, :name)');
       EditType := 0;
       newrecord := true;

    end
  else
   if mainForm.isFolder = 2 then {Добавление новой группы}
     begin
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('SELECT GEN_ID(SPR_ACCESSTYPE_CODE, 1) FROM RDB$DATABASE');
       qQueryupdate.open;
       CodeEdit.Text   := qQueryupdate.Fields[0].AsString;

       NameEdit.text  := 'Новая группа';
       Caption     := 'Справочник "Типы допуска": Новая группа';
       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('insert into SPR_ACCESSTYPE');
       qQueryupdate.SQL.add('(ID, parentid, isfolder, code, name)');
       qQueryUpdate.sql.add('values (GEN_ID(SPR_ACCESS_GEN,1), :parentid, 1, :code, :name)');
       EditType := 0;
       newrecord := true;

     end
  else {редактирование элемента}
    if mainForm.isFolder = 3 then
     begin
        // проверка на разрешение редактирования
        OkButton.Enabled := check_user_grand('SPR_ACCESSTYPE', 'U', true);

       qQuery.SQL.Clear;
       qQuery.SQL.Add('select * from SPR_ACCESSTYPE');
       qQuery.SQL.Add('where ID = :ID');
       qQuery.ParamByName('ID').AsInteger := MainForm.ID;
       qQuery.Open;

       qQueryupdate.SQL.Clear;
       qQueryupdate.SQL.add('  UPDATE SPR_ACCESSTYPE');
       qQueryupdate.SQL.add('SET PARENTID = :PARENTID, CODE = :CODE, NAME = :NAME');
       qQueryupdate.SQL.add('WHERE (ID = :ID)');

       // заполнение информации по полям
       codeEdit.Text   := qQuery.fieldByName('Code').AsString;    //  Код
       nameedit.text   := qQuery.fieldByName('Name').AsString;    //  Наименование
       Id              := qQuery.fieldByName('ID').AsInteger;      // идентификатор

       EditType := 1;   //режим редактирования - редактирование

       Caption := 'Элемент: ' + nameedit.text;
       newrecord := false;

     end;

end;

procedure TENUM_ACCESSTYPEForm.ButtonCloseClick(Sender: TObject);
begin
  close;
end;

procedure TENUM_ACCESSTYPEForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TENUM_ACCESSTYPEForm.OKButtonClick(Sender: TObject);
begin
  if EditType = 0 then // это добавление записи
  else
      qQueryupdate.ParamByName('ID').asinteger       := ID;


    if (ChechUniqueCode('spr_accesstype', 'code', trim(CodeEdit.text), ID) > 0)  then

      begin
        showmessage('Код не уникальный!');
        abort;
      end;

  if CodeEdit.text = '' then
    begin
      showmessage('Код не заполнен.');
      exit;
    end;
  if NameEdit.Text = '' then
    begin
      showmessage('ФИО не заполнено.');
      exit;
    end;


  qQueryupdate.ParamByName('Code').value    := CodeEdit.text;
  qQueryupdate.ParamByName('Name').value    := NameEdit.Text;
  qQueryupdate.ParamByName('Parentid').asinteger := Parentid;

   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    MessageDlg('Ошибка при сохранении данных.', mtWarning, [mbOK], 0);
    data.RMPBase.Rollback;
   end;

  ID := findIDbyCode('spr_wrkr', trim(CodeEdit.text));
  MainForm.ID := ID;


  ModalResult := mrOK;

end;

end.
