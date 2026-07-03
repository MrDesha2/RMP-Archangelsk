{
            Модуль REPEdit
   Описание:
       Модуль формы редактирования элемента справочника "Ремонты оборудования"
       Модуль вызывается из формы EQPTEdit.


}
unit REPEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, RXDBCtrl, Mask, ToolEdit;

type
  TENUM_REPForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DateBegin: TDateEdit;
    DateEnd: TDateEdit;
    Close_Buttom: TButton;
    OKButton: TButton;
    qQueryUpdate: TQuery;
    qQuery: TQuery;
    qORDERQuery: TQuery;
    Label4: TLabel;
    DatePPR: TDateEdit;
    DocOrderCombo: TComboEdit;
    procedure Close_ButtomClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKButtonClick(Sender: TObject);
    procedure DocOrderComboButtonClick(Sender: TObject);
    procedure DocOrderComboExit(Sender: TObject);
  private
    { Private declarations }
  public
    constructor createN(AOwner: TComponent; _ID, _OwnerID: integer;
               _TableName: string; generatorname: string; _TypeEdit: integer);
    destructor  Destroy; override;
  end;

var
  ENUM_REPForm: TENUM_REPForm;
   FormType: integer; // Тип формы при открытии 2 - для редактирования, 1 - для добавления;
         ID: integer; // Идентификатор элемента для редактирования
    ownerID: integer; // Идентификатор владельца
 sQueryText: string;  // текст запроса заполнения

implementation

uses CHRTEdit,
         Libs,
 JRORDERForm, Base;     // форма журнала заказов

{$R *.DFM}
//
//   Процедура закрытия формы
//
procedure TENUM_REPForm.Close_ButtomClick(Sender: TObject);
begin
  close;
end;
//
//   Процедура закрытия формы
//
procedure TENUM_REPForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;
//
//    Процедура при закрытии по ОК.
//   Описание
//     Выполняет транзакцию с таблицей.
procedure TENUM_REPForm.OKButtonClick(Sender: TObject);
begin

 
    qQueryUpdate.Close;
    qQueryUpdate.SQL.clear;
    qQueryUpdate.SQL.add(sQueryText);

  // если форма была для добавления
  if FormType = 1 then
    qQueryUpdate.ParamByName('ownerID').asinteger := ownerID
  else
    qQueryUpdate.ParamByName('ID').asinteger := ID;

    if (DATEBegin.text = '  .  .  ') or (DATEBegin.text = '  .  .    ')
     or (DATEEnd.text = '  .  .  ') or (DATEEnd.text = '  .  .    ')
     or (DatePPR.text = '  .  .  ') or (DatePPR.text = '  .  .    ') then
      begin
        MessageDlg('Даты заданы неверно', mtError, [mbOK], 0);
        exit;
      end;

  qQueryUpdate.ParamByName('DATE_Beg').value  := DATEBegin.text;
  qQueryUpdate.ParamByName('DATE_End').value  := DATEEnd.text;
  qQueryUpdate.ParamByName('Date_PPR').value  := DatePPR.text;

  // заказ
       if  (trim(DocOrderCombo.text) <> '') and qORDERQuery.active then

          qQueryUpdate.ParamByName('Id_order').asinteger  := qORDERQuery.FieldbyName('ID').asinteger

       else
           qQueryUpdate.ParamByName('Id_order').asinteger  := 0;

   try        
    data.RMPBase.StartTransaction;
     qQueryupdate.ExecSQL;
    data.RMPBase.Commit;
   except
    data.RMPBase.Rollback;
   end;


//  CHRT_EditForm.FormRefresh(2);
  close;
end;

//
//  Генератор создания формы редактирования элемента справочника "Ремонт оборудования"
//
constructor TENUM_REPForm.createN(AOwner: TComponent; _ID, _OwnerID: integer;
  _TableName, generatorname: string; _TypeEdit: integer);
begin
  inherited Create(AOwner);;


  ID := _Id;                // Идентификатор элемента для редактирования
  OwnerID := _ownerID;      // Идентификатор владельца
  // если это добавление элемента
  FormType := _typeEdit;
//  DocOrderCombo.DataSource := data.EnumVOPSource;
//  qDocOrderQuery           := data.EnumVOPQuery;

  if _TypeEdit = 1 then
    begin
       sQueryText := 'insert into ' + _tablename +
        ' values (GEN_ID(' + GeneratorName + ',1), :OwnerID, :DATE_Beg, :DATE_End, :Date_PPR, :id_order) ';
       DateBegin.text := '0';
       DateEnd.text := '0';            
       DatePPR.text := '0';

    end

  else  // это редактирование элемента
   if _TypeEdit = 2 then
    begin
       // проверка на разрешение редактирования
       OkButton.Enabled := check_user_grand(uppercase(_tablename), 'U', true);

       sQueryText := 'update ' + _tablename +
        ' set DATE_Beg = :DATE_Beg, DATE_End = :DATE_End, Date_PPR = :Date_PPR, id_order = :id_order ' +
        ' where id = :id';

       qQuery.close;
       qQuery.sql.clear;
       qQuery.SQL.add('select * from ' + _tablename);
       qQuery.sql.add('where ID = :ID');
       qQuery.ParamByName('ID').asinteger := _Id;
       qQuery.open;
       // заполнение полей
       // заполнение поля "Документ"
        // Формирование запроса для нахождения ID заказа
        with  qORDERQuery do

           begin

            close;
            ParamByName('id').asinteger := qQuery.Fieldbyname('id_order').asinteger;
            ParamByName('Number').DataType := ftinteger;
            ParamByName('Number').clear;
            open;

           end;

       if qORDERQuery.active then
            DocOrderCombo.text := qORDERQuery.FieldbyName('Number').asstring;


       DateBegin.text  := qQuery.FieldByName('Date_Beg').asstring;
       DateEnd.text  := qQuery.FieldByName('Date_end').asstring;
       DatePPR.text  := qQuery.FieldByName('Date_PPR').asstring;

    end;


end;

//
//     Деструктор формы
//
destructor TENUM_REPForm.Destroy;
begin
  inherited;
end;

procedure TENUM_REPForm.DocOrderComboButtonClick(Sender: TObject);

var JR_Form    : TJR_ORDERForm;

begin

  // создание и открытие формы журнала заказов
  JR_Form := TJR_ORDERForm.Create(self);
  JR_Form.FormStyle := fsNormal;
  JR_Form.hide;

  JR_Form.FormActivate(self, 2);

  if trim(DocOrderCombo.text) <> '' then

    data.JROrderFormQuery.locate('Number',  strtoint(DocOrderCombo.text), [loCaseInsensitive]);

  if JR_Form.showmodal = mrOK then
    DocOrderCombo.text := inttostr(JR_Form.numdoc);

  qOrderQuery.close;
  qOrderQuery.ParamByName('ID').asinteger     := JR_Form.IDDoc;
  qOrderQuery.ParamByName('Number').asinteger := -1;
  qOrderQuery.open;

  JR_Form.close;


end;

procedure TENUM_REPForm.DocOrderComboExit(Sender: TObject);
begin

   // формирование запроса на поиск заказа с заданным номером
  qOrderQuery.close;
  qOrderQuery.ParamByName('ID').asinteger     := -1;

  if trim(DocOrderCombo.text) = '' then

    exit;


  if strlen(pchar(DocOrderCombo.text)) > 10 then exit;
  
  qOrderQuery.ParamByName('Number').asinteger := strToInt(trim(DocOrderCombo.text));
  qOrderQuery.open;


   // если заказ не найден, то ошибка
   if qOrderQuery.Eof then

     begin

        showmessage('Заказ с заданным номером не существует!');
        DocOrderCombo.text := '';
        DocOrderCombo.SetFocus;
     end
   else
    DocOrderCombo.text := qOrderQuery.FieldByName('Number').asstring;


end;

end.
