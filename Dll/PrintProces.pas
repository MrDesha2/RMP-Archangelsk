unit PrintProces;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls;

type
  TProcessForm = class(TForm)
    ProgressBar: TProgressBar;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProcessForm: TProcessForm;

implementation
uses Libs;

{$R *.DFM}

procedure TProcessForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
        If (Key = VK_ESCAPE) Then
           ESC_Key := True;

end;

end.
