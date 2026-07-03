unit Rep52;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TReport52Form = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  Report52Form: TReport52Form;
implementation
uses PrintFrm, printlibs,
         Libs, PrintProces, GetPeriods, Rep18, Rep_18;

{$R *.dfm}


procedure TReport52Form.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TReport52Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := caFree;
end;

procedure TReport52Form.Button1Click(Sender: TObject);
var ParentForm: TForm;
begin
     Report18Form              := TReport18Form.Create(ParentForm);
     Report18Form.show;
end;

procedure TReport52Form.Button2Click(Sender: TObject);
var ParentForm: TForm;
begin
     Report_18Form              := TReport_18Form.Create(ParentForm);
     Report_18Form.show;
end;

end.
