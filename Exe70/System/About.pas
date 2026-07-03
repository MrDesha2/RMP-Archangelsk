unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    Panel1: TPanel;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    Image1: TImage;
    BaseInfo: TLabel;
    Label1: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation


uses
 ShellAPI,
Base;

{$R *.DFM}

procedure TAboutBox.OKButtonClick(Sender: TObject);
begin
  close;
end;

procedure TAboutBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
var
  DBPath: string;
  ParamList: TStringList;
  str   : string;
begin

  { get the actual location of the database from the alias,
    the path is needed for the reports -- assumes alias is defined }
  ParamList := TStringList.Create;
  try
    data.RMPBase.Session.GetAliasParams(data.RMPBase.AliasName, ParamList);
    if data.RMPBase.IsSQLBased then
      DBPath := ParamList.Values['SERVER NAME']
    else
      DBPath := ParamList.Values['PATH'];
     str := 'Имя базы данных: ' + DBPath;

     BaseInfo.caption := str;
  finally
    ParamList.Free;
  end;


end;

procedure TAboutBox.Label1Click(Sender: TObject);
begin
//   WinExec(pchar('http://pmasc.karelia.ru'),1);
   ShellExecute (self.Handle, nil, 'http://pmasc.karelia.ru', nil, nil, SW_RESTORE);
end;

end.

