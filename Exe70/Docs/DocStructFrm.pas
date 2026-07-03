{***************************************************************
 *
 * Unit Name: DocStructFrm
 * Purpose  : форма показывает структуру подчиненности документов
 * Author   :
 * History  :
 *
 ****************************************************************}

unit DocStructFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables;

type
  TDOC_Structure_Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ButtonRQST: TButton;
    ButtonORDER: TButton;
    ButtonPR: TButton;
    ButtonRS: TButton;
    ButtonClose: TButton;
    FindQuery: TQuery;
    doc_RQST: TLabel;
    doc_ORDER: TLabel;
    doc_pr: TLabel;
    doc_rs: TLabel;
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonRQSTClick(Sender: TObject);
    procedure ButtonORDERClick(Sender: TObject);
    procedure ButtonPRClick(Sender: TObject);
    procedure ButtonRSClick(Sender: TObject);
    procedure OpenQuery;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function  Find_consistency(IdDoc: integer): tStringList;

  private
    { Private declarations }
  public

    IDRQST : integer; // ID за€вки
    IDOrder: integer; // ID заказа
    IDPr   : integer; // ID приходного документа
    IDRs   : integer; // ID расходного документа

  end;

var
  DOC_Structure_Form: TDOC_Structure_Form;


implementation

uses OrderEditForm,
     ReqEditForm,
     PRDocEditForm,
     RSDocEditForm,
     Main, Base;

{$R *.DFM}

procedure TDOC_Structure_Form.ButtonCloseClick(Sender: TObject);
begin
  close;
end;
{
    ќткрывает документ за€вку

}
procedure TDOC_Structure_Form.ButtonRQSTClick(Sender: TObject);
var DocForm : TDOC_RequestForm;
begin
  // открыть форму редактировани€ нового документа
  DocForm := TDOC_RequestForm.CreateN(self, IdRQST);
  DocForm.show;

end;
{
    ѕроцедура открыти€ документа «аказ

}
procedure TDOC_Structure_Form.ButtonORDERClick(Sender: TObject);
var DocForm : TDOC_ORDERForm;
    ParentNumber : integer;
    qTMPQuery : tQuery;
begin
 //
  // формирование и выполнение запроса дл€ нахождение номера документа-владельца
  qTMPQuery:= tQuery.Create(self);
  qTMPQuery.databasename := 'RMP';
  qTMPQuery.sql.add('select a.number from dh_rqst a, dh_order b');
  qTMPQuery.sql.add('where a.id = b.id_rqst and b.id = ' + inttostr(IdOrder));
  qTMPQuery.open;
  ParentNumber := qTMPQuery.Fields[0].asinteger;

  DocForm := TDOC_ORDERForm.CreateN(mainform, IdOrder, IDRQST, ParentNumber, nil);
  DocForm.show;

end;

{
      ѕроцедура открыти€ документа приходной накладной
      готовой продукции

}
procedure TDOC_Structure_Form.ButtonPRClick(Sender: TObject);
var DocForm: TDOC_PRForm;
begin
  if  IDPr <= 0 then exit;
  // открыть форму редактировани€ нового документа
  DocForm := TDOC_PRForm.CreateN(mainform, IDPR, nil);
  DocForm.show;
end;


{
    ѕроцедура открыти€ формы расходной накладной

}
procedure TDOC_Structure_Form.ButtonRSClick(Sender: TObject);
var DocForm: TDOC_RSForm;
begin
  if  IDRs <= 0 then exit;

  // открыть форму редактировани€ нового документа
  DocForm := TDOC_RSForm.CreateN(mainform, IDRS, 1, nil);
  DocForm.show;

end;



procedure TDOC_Structure_Form.FormCreate(Sender: TObject);
begin
    IDRQST := -1; // ID за€вки
    IDOrder:= -1; // ID заказа
    IDPr   := -1; // ID приходного документа
    IDRs   := -1; // ID расходного документа

end;



{-----------------------------------------------------------------------------
  ѕроцедура: TDOC_Structure_Form.FindRQST
  ƒата:      30-апр-2004
  јргументы: IdDoc: integer - ID документа заказ
  ¬озврат:   tStringList, в котором указаны ID, номер и дата документов:
             за€вка, заказ, приход, расход. 
  ќписание:  —труктуры подчиненности доков на основании заказа
-----------------------------------------------------------------------------}

function TDOC_Structure_Form.Find_consistency(IdDoc: integer): tStringList;
var qQuery : tQuery;
    List   : tStringList;
begin
  qQuery := tQuery.Create(data);
  qQuery.DatabaseName := 'RMP';
  List := tstringList.Create;

  with qQuery do
    begin
      sql.clear;
      // нахождение реквизитов за€вки.
      sql.add('select a.number, a.date_in, b.number, b.date_in, a.id');
      sql.add('from dh_rqst a, dh_order b');
      sql.add('where a.id = b.id_rqst and b.id = ' + inttostr(IdDoc));
      open;

      if not qQuery.Eof then
        begin
          List.Add(qQuery.Fields[4].asstring); // ID за€вки
          List.Add(qQuery.Fields[0].asstring); // номер за€вки
          List.Add(qQuery.Fields[1].asstring); // дата за€вки
          List.Add(inttostr(IdDoc));           // ID заказа
          List.Add(qQuery.Fields[2].asstring); // номер заказа
          List.Add(qQuery.Fields[3].asstring); // дата заказа

        end
      else
        begin
          List.Add('-1');         // ID за€вки
          List.Add('Ќе найдена'); // номер за€вки
          List.Add('');           // дата за€вки
          List.Add('-1');         // ID заказа
          List.Add('Ќе найден');  // номер заказа
          List.Add('');           // дата заказа

        end;

      // найдем приход на склад готовой продукции

      sql.clear;
      sql.add('select a.numdoc, a.date_in, a.id');
      sql.add('from dh_pr a, dt_pr b');
      sql.add('where a.id = b.id_prmtr and b.id_ord = ' + inttostr(IdDoc));
      open;

      if not eof then
        begin
          List.Add(qQuery.Fields[2].asstring); // ID дока
          List.Add(qQuery.Fields[0].asstring); // номер дока
          List.Add(qQuery.Fields[1].asstring); // дата дока
        end
      else
        begin
          List.Add('-1');            // ID дока
          List.Add('нет документа'); // номер заказа
          List.Add('');              // дата заказа
        end;

      // найдем расход со склада готовой продукции
      sql.clear;
      sql.add('select a.numdoc, a.date_in, a.id');
      sql.add('from dh_rs a, dt_rs b');
      sql.add('where a.id = b.id_rsmtr and b.id_ord = ' + inttostr(IdDoc));
      open;

      if not eof then
        begin
          List.Add(qQuery.Fields[2].asstring); // ID дока
          List.Add(qQuery.Fields[0].asstring); // номер дока
          List.Add(qQuery.Fields[1].asstring); // дата дока

        end
      else
        begin
          List.Add('-1');            // ID дока
          List.Add('нет документа'); // номер заказа
          List.Add('');              // дата заказа
        end;


    end;
    result := List;

end;

{

     ѕроцедура формировани€ запросов дл€ нахождени€ документов
     структуры подчиненности

}
procedure TDOC_Structure_Form.OpenQuery;
var List : tStringList;
begin

      List := Find_consistency(Idorder);

      doc_RQST.Caption := 'є ' + List[1] + ' от ' + List[2];

      doc_ORDER.Caption := 'є ' + List[4] + ' от ' + List[5];

      doc_pr.Caption := 'є ' + List[7] + ' от ' + List[8];

      doc_rs.Caption := 'є ' + List[10] + ' от ' + List[11];

      IDRQST := strtoint(List[0]);
      IDPr   := strtoint(List[6]);
      IDRs   := strtoint(List[9]);
      Caption := '—труктура подчиненности заказа ' + List[4];
      
end;

procedure TDOC_Structure_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

end.
