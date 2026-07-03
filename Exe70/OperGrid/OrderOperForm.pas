unit OrderOperForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, Grids, DBGrids, OROPEditForm, ExtCtrls, StdCtrls, ToolEdit,
  DBGridEh;

type
  TORDER_OperForm = class(TForm)
    QueryOrder: TQuery;
    DataSourceOrder: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    ButtonClose: TButton;
    DBGridEh1: TDBGridEh;
    QueryInfoOrder: TQuery;
    procedure ButtonCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    constructor CreateN(AOwner: TDOCT_OPERForm; Combo : TComboEdit);
    destructor Destroy; override;
  end;

var
  ORDER_OperForm: TORDER_OperForm;
  OROPForm : TDOCT_OPERForm;

implementation

{$R *.dfm}

constructor TORDER_OperForm.CreateN(AOwner: TDOCT_OPERForm; Combo : TComboEdit);
begin

  inherited Create(AOwner);
  OROPForm := AOwner;

//  QueryOrder.Handle := _QueryOrder.Handle;
  If (FormType < 3) Then
  begin
      QueryOrder.Close;
      QueryOrder.SQL.Clear;
      QueryOrder.SQL.Add('Select b.number, a.ntime/1000 as ntime, b.id');  //a.ntime/1000/24
      QueryOrder.SQL.Add('From dt_order1 a, dh_order b');
      QueryOrder.SQL.Add('where a.id_wrkr  = :id_wrkr and');
      QueryOrder.SQL.Add('      a.id_order = b.id and');
      QueryOrder.SQL.Add('      a.date_beg = (Select max(c.date_beg)');
      QueryOrder.SQL.Add('                    From DT_Order1 c');
      QueryOrder.SQL.Add('                    Where c.id_wrkr = :id_wrkr)');
      QueryOrder.SQL.Add('Order by 1');
      QueryOrder.ParamByName('id_wrkr').AsInteger := Combo.Query.fieldbyname('ID').AsInteger;
  end
   else
   begin
         QueryOrder.Close;
         QueryOrder.SQL.Clear;
         QueryOrder.SQL.Add('Select b.number, a.ntime/1000 as ntime, b.id');   //a.ntime/1000/24
         QueryOrder.SQL.Add('From dt_order2 a, dh_order b');
         QueryOrder.SQL.Add('where a.id_wrkr  = :id_wrkr and');
         QueryOrder.SQL.Add('      a.id_order = b.id and');
         QueryOrder.SQL.Add('      a.date_beg = (Select max(c.date_beg)');
         QueryOrder.SQL.Add('                    From DT_Order2 c');
         QueryOrder.SQL.Add('                    Where c.id_wrkr = :id_wrkr)');
         QueryOrder.SQL.Add('Order by 1');
         QueryOrder.ParamByName('id_wrkr').AsInteger := Combo.Query.fieldbyname('ID').AsInteger;
   end;

   QueryOrder.Open;
end;

destructor TORDER_OperForm.Destroy;
begin
  inherited;
end;


procedure TORDER_OperForm.ButtonCloseClick(Sender: TObject);
begin
  release;
end;

procedure TORDER_OperForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TORDER_OperForm.DBGridEh1DblClick(Sender: TObject);
begin
      QueryInfoOrder.Close;
      QueryInfoOrder.SQL.Clear;
      QueryInfoOrder.SQL.Add('Select a.number as number_rqst, a.date_in as date_in_rqst, a.date_out as date_out_rqst,');
      QueryInfoOrder.SQL.Add('       b.number as number_order, b.date_in as date_in_order, b.date_out as date_out_order, b.number_p,');
      QueryInfoOrder.SQL.Add('       c.name as name_cst, d.name as name_pdr, e.name as name_nmnt, f.name as name_chrt');
      QueryInfoOrder.SQL.Add('From DH_Rqst a,  DH_Order b, Spr_Cst c, Spr_Pdr d, Spr_Nmnt e, Spr_Chrt f');
      QueryInfoOrder.SQL.Add('Where b.id = :id       and');
      QueryInfoOrder.SQL.Add('      a.id = b.id_rqst and');
      QueryInfoOrder.SQL.Add('      c.id = a.id_cst  and');
      QueryInfoOrder.SQL.Add('      d.id = b.id_pdr  and');
      QueryInfoOrder.SQL.Add('      e.id = b.id_nmnt and');
      QueryInfoOrder.SQL.Add('      f.id = b.id_chrt');
      QueryInfoOrder.ParamByName('id').AsInteger := QueryOrder.FieldByName('ID').AsInteger;
      QueryInfoOrder.Open;

      If QueryInfoOrder.RecordCount >= 1 Then
         ShowMessage('Заявка №'+QueryInfoOrder.FieldByName('number_rqst').AsString +
         ' от '+ QueryInfoOrder.FieldByName('date_in_rqst').AsString + chr(10)+chr(13)+
         'Дата завершения заявки: ' + QueryInfoOrder.FieldByName('date_out_rqst').AsString + chr(10)+chr(13)+
         'Заказчик: ' + QueryInfoOrder.FieldByName('name_cst').AsString + chr(10)+chr(13)+
         'Подразделение: ' + QueryInfoOrder.FieldByName('name_pdr').AsString + chr(10)+chr(13)+
         chr(10)+chr(13)+
         'Заказ №' + QueryInfoOrder.FieldByName('number_order').AsString +
         ' от ' + QueryInfoOrder.FieldByName('date_in_order').AsString + chr(10)+chr(13)+
         'Дата завершения заказа: ' + QueryInfoOrder.FieldByName('date_out_order').AsString + chr(10)+chr(13)+
         'Чертёж: ' + QueryInfoOrder.FieldByName('name_chrt').AsString + chr(10)+chr(13)+
         'Номенклатура: ' + QueryInfoOrder.FieldByName('name_nmnt').AsString + chr(10)+chr(13)+
         'В количестве: ' + QueryInfoOrder.FieldByName('number_p').AsString);
         
end;

end.
