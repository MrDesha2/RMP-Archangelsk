unit SetDate;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit;

type
  TSetJRDate = class(TForm)
    Label1: TLabel;
    FromDate: TDateEdit;
    ToDate: TDateEdit;
    OKButton: TButton;
    CancelButton: TButton;
    SelPeriod: TButton;
    procedure OKButtonClick(Sender: TObject);
    function  GetFromDate: TDateTime;
    procedure SetFromDate(NewDate: TDateTime);
    procedure SetToDate(NewDate: TDateTime);
    function  GetToDate: TDateTime;
    procedure CancelButtonClick(Sender: TObject);
    procedure SelPeriodClick(Sender: TObject);
  private
    { Private declarations }
  public
    property _FromDate: TDateTime read GetFromDate write SetFromDate;
    property _ToDate: TDateTime read GetToDate write SetToDate;
  end;

var
  SetJRDate: TSetJRDate;
implementation
uses JRRQSTForm, GetPeriods;
{$R *.DFM}
{
  Процедура нажатия кнопки ОК
}
procedure TSetJRDate.OKButtonClick(Sender: TObject);
begin
  try
    if (_ToDate <> 0) and (_ToDate < _FromDate) then
    begin
      ShowMessage('Дата начала не может быть больше даты окончания');
      ModalResult := mrNone;
    end
    else ModalResult := mrOk;
  except
    ShowMessage('Интервал указан не верно');
    ModalResult := mrNone;
  end;
end;

function TSetJRDate.GetFromDate: TDateTime;
begin
  if FromDate.Text = '' then Result := 0
  else Result := StrToDate(FromDate.Text);
end;

procedure TSetJRDate.SetFromDate(NewDate: TDateTime);
begin
  FromDate.Text := DateToStr(NewDate);
end;

procedure TSetJRDate.SetToDate(NewDate: TDateTime);
begin
  ToDate.Text := DateToStr(NewDate);
end;

function TSetJRDate.GetToDate: TDateTime;
begin
  if ToDate.Text = '' then Result := 0
  else Result := StrToDate(ToDate.Text);
end;



procedure TSetJRDate.CancelButtonClick(Sender: TObject);
begin
   ModalResult := mrCancel;

end;

{-----------------------------------------------------------------------------
  Процедура: TSetJRDate.SelPeriodClick
  Описание:
  Вход:  Sender: TObject
  Выход: None
-----------------------------------------------------------------------------}
procedure TSetJRDate.SelPeriodClick(Sender: TObject);
var _d1, _d2 : tdatetime;
begin
   _d1 := _FromDate;
   _d2 := _ToDate;
   GetPeriod(_d1, _d2);
   _FromDate := _d1;
   _ToDate   := _d2;
end;

end.
