{-----------------------------------------------------------------------------
 Unit Name: ENUMModelINC
 Author:    Desha
 Purpose:
 History:

    Модуль редактирования прибыли модели.
    Форма вызывается из формы редактирования элемента справочника модели.
-----------------------------------------------------------------------------}


unit ENUMModelINC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, ToolEdit, CurrEdit, StdCtrls, ExtCtrls, ComCtrls, RXSpin,
  DB, DBTables, Grids, DBGridEh, ToolWin;

type
  TENUM_MODELINCEdit = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    ButtonOK: TButton;
    ButtonClose: TButton;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    INCREMENT_NAME: TEdit;
    INCREMENT_NUMBER: TCurrencyEdit;
    ToolBarCh: TToolBar;
    ToolAddChar: TToolButton;
    ToolEditChar: TToolButton;
    ToolDelChar: TToolButton;
    CHEQGrid: TDBGridEh;
    qCHMODELQuery: TQuery;
    DataSourceModel: TDataSource;
    qQuery: TQuery;
    qQueryUpdate: TQuery;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ToolAddCharClick(Sender: TObject);
    procedure ToolEditCharClick(Sender: TObject);
    procedure ToolDelCharClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _ID, _OwnerID: integer;
               _TableName: string; generatorname: string; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_MODELINCEdit: TENUM_MODELINCEdit;
   FormType: integer; // Тип формы при открытии 2 - для редактирования, 1 - для добавления;
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
 sQueryText: string;  // текст запроса заполнения
   newrecord: boolean;

implementation

uses Base, libs,
  CHAREdit;

{$R *.dfm}

{-----------------------------------------------------------------------------
  Procedure: TENUM_MODELINCEdit.ButtonCloseClick
  Author:    Desha
  Date:      18-ноя-2005
  Arguments: Sender: TObject
  Result:    None
-----------------------------------------------------------------------------}
procedure TENUM_MODELINCEdit.ButtonCloseClick(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

{-----------------------------------------------------------------------------
  Procedure: TENUM_MODELINCEdit.createN
  Author:    Desha
  Date:      18-ноя-2005
  Конструктор формы
  Arguments: AOwner: TComponent;
   _ID, - ид записи
   _OwnerID: владелец- справочник "Модели"
   _TableName, - имя таблицы для редактирования
   generatorname: string; - имя генератора
   _TypeEdit: integer - тип редактирования 1- добавление, 2 - редактирование
  Result:    None
-----------------------------------------------------------------------------}
constructor TENUM_MODELINCEdit.createN(AOwner: TComponent; _ID,
  _OwnerID: integer; _TableName, generatorname: string;
  _TypeEdit: integer);
begin
  inherited Create(AOwner);;
  ID := _Id;                // Идентификатор элемента для редактирования
  OwnerID := _ownerID;      // Идентификатор владельца
  // если это добавление элемента
  FormType := _typeEdit;

  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into ' + _tablename +
        '(ID, ID_MODEL, LINENO, INCREMENT_NUMBER, INCREMENT_NAME) ' +
        ' values (GEN_ID(' + GeneratorName + ',1), :ID_MODEL, :LINENO, ' +
        '  :INCREMENT_NUMBER, :INCREMENT_NAME)';
       newrecord := true;
    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin
       // проверка на разрешение редактирования
       ButtonOK.Enabled := check_user_grand(uppercase(_tablename), 'U', true);

       sQueryText := 'update ' + _tablename +
        '  SET LINENO = :LINENO, ' +
        ' INCREMENT_NUMBER = :INCREMENT_NUMBER, ' +
        ' INCREMENT_NAME = :INCREMENT_NAME ' +
        '  where (id = :id)';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from ' + _tablename);
       qQuery.sql.add('where ID = :ID');
       qQuery.ParamByName('ID').asinteger := _Id;
       qQuery.open;
       INCREMENT_NAME.Text := qQuery.fieldbyname('INCREMENT_NAME').asstring;
       INCREMENT_NUMBER.Text := qQuery.fieldbyname('INCREMENT_NUMBER').asstring;

       newrecord := false;
       
    end;
  PageControl.ActivePageIndex := 0;
  qCHMODELQuery.Params[0].asinteger := id;
  qCHMODELQuery.Open;
  
end;

destructor TENUM_MODELINCEdit.Destroy;
begin

  inherited;
end;

procedure TENUM_MODELINCEdit.ButtonOKClick(Sender: TObject);
begin


    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

  // если форма была для добавления
  if FormType = 1 then
    qQueryUpdate.ParamByName('ID_MODEL').asinteger := ownerID
  else
    qQueryUpdate.ParamByName('ID').asinteger := ID;

    qQueryUpdate.ParamByName('LINENO').asinteger     := 0;
    qQueryUpdate.ParamByName('INCREMENT_NUMBER').asinteger := INCREMENT_NUMBER.AsInteger;
    qQueryUpdate.ParamByName('INCREMENT_NAME').AsString    := INCREMENT_NAME.Text;

   try
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;

   ModalResult := mrOK;

end;

procedure TENUM_MODELINCEdit.ToolAddCharClick(Sender: TObject);
var EditCHAR: tform;
begin
  // Добавление характеристики возможно только для сохраненных элементов
  if ID < 0 then
   begin
     showmessage('Элемент не записан.');
     exit;
   end;

  EditCHAR := TENUM_CHEQForm.CreateN(Application, 0, ID,
     'spr_modelincremcharacter', 'GEN_SPR_MODELINCREMCHARACTER_ID', 1, 2);
  EditChar.Caption := 'Добавление характеристики прибыли модели';
  if EditCHAR.showmodal = mrOK then
     if not newrecord then

         refreshquery( qCHMODELQuery)
     else
      begin

         qCHMODELQuery.close;
         qCHMODELQuery.ParamByName('id').asinteger := ID;
         qCHMODELQuery.open;

      end;

end;

procedure TENUM_MODELINCEdit.ToolEditCharClick(Sender: TObject);
var EditCHAR: tform;
    _id : integer;
begin
  // Если справочник характеристик не пустой, то можно редактировать
  if qCHMODELQuery.eof then
     exit;
  // Нахождение ID элемента справочника
  _id := qCHMODELQuery.FieldByName('ID').asinteger;
  EditCHAR := TENUM_CHEQForm.CreateN(Application, _Id, ID,
    'spr_modelincremcharacter',
    'GEN_SPR_MODELINCREMCHARACTER_ID', 2, 2);

  if EditCHAR.showmodal = mrOK then
         refreshquery( qCHMODELQuery);



end;

procedure TENUM_MODELINCEdit.ToolDelCharClick(Sender: TObject);
begin
  // Проверка: есть ли что удалять
  if qCHMODELQuery.eof then
    exit;

 if messagedlg('Удалить запись ' + qCHMODELQuery.FieldByName('Name').asstring + '?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then

  with data.qDELQuery do
    begin

     close;
     sql.clear;
     sql.add('delete from spr_modelincremcharacter where id = ' + qCHMODELQuery.FieldByName('ID').asstring);
      data.RMPBase.StartTransaction;
       ExecSQL;
      data.RMPBase.Commit;

    end;

   refreshquery( qCHMODELQuery);

end;

end.
