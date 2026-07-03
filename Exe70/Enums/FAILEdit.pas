{-----------------------------------------------------------------------------
 Unit Name: FAILEdit
 Author:    Косицын Дмитрий
 Purpose:   Модуль формы редактирования элемента справочника "Причина отказа оборудования"
            Вызывается из формы редактиорования элемента справочника "Оборудование"
 History:   2005
-----------------------------------------------------------------------------}


unit FAILEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DB, DBTables, Grids, DBGridEh;

type
  TENUM_FAILEdit = class(TForm)
    Label1: TLabel;
    CodeEdit: TMaskEdit;
    Label2: TLabel;
    OK_Button: TButton;
    Close_Button: TButton;
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    NameEdit: TMemo;
    procedure OK_ButtonClick(Sender: TObject);
    procedure Close_ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _OwnerID, _ID: integer; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_FAILEdit: TENUM_FAILEdit;
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
   FormType: integer; // Тип формы при открытии 2 - для редактирования, 1 - для добавления;
 sQueryText: string;  // текст запроса заполнения

implementation

uses    Libs, Base;


{$R *.DFM}



//
//  Генератор создания формы редактирования элемента справочника "Ремонт оборудования"
//
constructor TENUM_FAILEdit.createN(AOwner: TComponent;  _OwnerID, _ID: integer; _TypeEdit: integer);
begin
  inherited Create(AOwner);;


  ID      := _Id;           // Номер строки отказа
  OwnerID := _ownerID;      // Идентификатор владельца
  // если это добавление элемента
  FormType := _typeEdit;

  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into spr_fail ' +
        ' values (:Code, :Name, :ID_REP) ';
       with qQuery do
         begin
           close;
           sql.Clear;
           sql.add('select max(code) from spr_fail where id_rep = ' + inttostr(ownerid));
           open;
         end;
       if qQuery.Fields[0].asinteger = 0 then
        CodeEdit.text := '1'
        else
         CodeEdit.text :=  inttostr(qQuery.Fields[0].asinteger + 1);
    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin
       // проверка на разрешение редактирования
       Ok_Button.Enabled := check_user_grand(uppercase('spr_fail'), 'U', true);

       sQueryText := 'update spr_fail ' +
        ' set code = :code, name = :name ' +
        ' where code = :code and id_rep = :id_rep';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from spr_fail');
       qQuery.sql.add('where code = :code and id_rep = :id_rep');
       qQuery.ParamByName('code').asinteger := _Id;
       qQuery.ParamByName('id_rep').asinteger := OwnerID;
       qQuery.open;

       CodeEdit.Text := qQuery.Fieldbyname('Code').asstring;
       NameEdit.Text := qQuery.Fieldbyname('Name').asstring;

    end;


end;
//
//     Деструктор формы
//
destructor TENUM_FAILEdit.Destroy;
begin
  inherited;
end;


procedure TENUM_FAILEdit.OK_ButtonClick(Sender: TObject);
begin

//    if (ChechUniqueCode('spr_fail', 'code', trim(CodeEdit.text), ID) > 0)  then
//
//      begin
//        showmessage('Код не уникальный!');
//        abort;
//      end;

    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

    qQueryUpdate.ParamByName('Code').asinteger   := strtoint(codeedit.Text);
    qQueryUpdate.ParamByName('ID_REP').asinteger := ownerID;

    qQueryUpdate.ParamByName('Name').value  := NameEdit.text;

   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

     ModalResult := mrOK;

  
end;

procedure TENUM_FAILEdit.Close_ButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TENUM_FAILEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
