unit OutLookForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleServer, ComObj, ShellApi, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTP, IdCoderHeader, inifiles,
  httpsend, mimemess, mimepart, smtpsend, synachar, ssl_openssl;

type
  TOutLook_Form = class(TForm)
    AdressEdit: TEdit;
    Name: TLabel;
    SubjectEdit: TEdit;
    Sabject: TLabel;
    ButtonSend: TButton;
    ButtonClose: TButton;
    IdMessage1: TIdMessage;
    procedure ButtonSendClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure IdMessage1InitializeISO(var VTransferHeader: TTransfer;
      var VHeaderEncoding: Char; var VCharSet: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    lIniFile: tInifile;
  public
    MessageLines: TStrings;
    MessageText: string;
    SubjectText: string;
    MessageStream : TMemoryStream;
  end;

var
  OutLook_Form: TOutLook_Form;

implementation

uses PrintFrm, printlibs, ComCtrls;
{$R *.dfm}

procedure TOutLook_Form.ButtonSendClick(Sender: TObject);
Var  IdAttachment : TIdAttachment;
     TempFile: array[0..MAX_PATH - 1] of Char;
     TempPath: array[0..MAX_PATH - 1] of Char;
     f: TextFile;
     SMTP    : TIdSMTP;
     Adr, User : String;
     p, i    : Integer;
     Msg : TMimeMess; // сообщение
     mp, MIMEPart : TMimePart; // части сообщения (на будущее)
begin

    //Проверка правильности ввода получателя письма
    Adr := AnsiLowerCase(AdressEdit.Text);
    p := Pos('@', Adr);
    If p = 0 Then
    begin
        ShowMessage('Не правильно введён адрес получателя');
        Exit;
    end;

    User := Copy(Adr, 1, P - 1);
    For i := 1 to Length(User) do
    If not (User[i] in ['a'..'z', '0'..'9', '.', '-', '_']) Then
    begin
        ShowMessage('Не правильно введёнo имя получателя');
        Exit;
    end;

    GetTempPath(MAX_PATH, TempPath);
    GetTempFileName(TempPath, PChar('RMP'), 0, TempFile);
//    ShowMessage('TempFile = '+TempFile);
    AssignFile(f, TempFile);
    Rewrite(f);
    Write(f, MessageText);
    CloseFile(f);

    If (SubjectEdit.Text <> '') Then
    begin

       Msg := TMimeMess.Create; // создаем новое сообщение
       try
           IdealCharsets:=[CP1251];
           Msg.Header.CharsetCode:=CP1251;  // Установим кодировку  заголовков
       	  // Добавляем заголовки
           Msg.Header.Subject := SubjectEdit.Text;// тема сообщения
           Msg.Header.From := GetSystemParams('POST_USERNAME'); // имя и адрес отправителя
           Msg.Header.ToList.Add(AdressEdit.Text); // имя и адрес получателя

       	  // создаем корневой элемент
           mp := Msg.AddPartMultipart('mixed', nil);
           MIMEPart := Msg.AddPartMultipart('alternative', mp);

           Msg.AddPartText(MessageLines, MIMEPart);
       	  // Отправляем.
           Msg.AddPartBinary(MessageStream, SubjectText+'.txt', mp);

           // Кодируем и отправляем
           Msg.EncodeMessage;
           //smtpsend.AutoTLS := Ture; раскоментировано в библиотеке  SMTPSend.pas

           if smtpsend.SendToRaw(GetSystemParams('ADRESS_FROM'),AdressEdit.Text,GetSystemParams('Host'),Msg.Lines,GetSystemParams('POST_USERNAME'),GetSystemParams('POST_PASSWORD')) then
           ShowMessage('Письмо отправлено')
            else
              ShowMessage('Подключиться не удалось. Почта не отправленао');
        finally
            Msg.Free;
       end;
    end
     else
        ShowMessage('Не заполнена <Тема> письма!');  

{    If (SubjectEdit.Text <> '') Then
    begin
       SMTP := TIdSMTP.Create(Application);
       SMTP.Host:= GetSystemParams('Host'); //'smtp.mail.ru'; // smtp сервер
       SMTP.Port:= StrtoInt(GetSystemParams('Port')); //25;
       SMTP.ASCIIFilter:=true;
       SMTP.Username:= GetSystemParams('POST_USERNAME');   //'логин'
       SMTP.Password:=GetSystemParams('POST_PASSWORD'); //'пароль';

       GetTempPath(MAX_PATH, TempPath);
       GetTempFileName(TempPath, PChar('RMP'), 0, TempFile);
       AssignFile(f, TempFile);
       Rewrite(f);
       Write(f, MessageText);
       CloseFile(f);
       IdAttachment := TIdAttachment.Create(IdMessage1.MessageParts, TempFile);
       IdAttachment.FileName := SubjectText+'.txt';  //'attached.txt';

       IdMessage1.From.Name:=GetSystemParams('POST_USERNAME');     //'Имя отправителя'
       IdMessage1.From.Address:=GetSystemParams('ADRESS_FROM');  //'адрес отправителя'
       IdMessage1.Recipients.EMailAddresses:=AdressEdit.Text;   //'адрес получателя';     'svl@karelia.ru';   //
       IdMessage1.Subject:= SubjectEdit.Text;                    //'тема';

       With TIdText.Create(IdMessage1.MessageParts) do
       begin
          ContentType := 'text/plain; charset=windows-1251';
          Body.Text := MessageText;
       end;

       SMTP.Connect();
       if SMTP.Connected then
       begin
         SMTP.Send(IdMessage1);
         ShowMessage('Сообщение отправлено');
         lIniFile.WriteString('Config', 'Recipient', AdressEdit.Text);
         Close;
       end
        else
           ShowMessage('Подключиться не удалось. Почта не отправлена');

       IdAttachment.Free;
       SMTP.Disconnect();
       SMTP.Free;
    end
     else
        ShowMessage('Не заполнена <Тема> письма!');  }
end;

procedure TOutLook_Form.ButtonCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TOutLook_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
end;

procedure TOutLook_Form.IdMessage1InitializeISO(
  var VTransferHeader: TTransfer; var VHeaderEncoding: Char;
  var VCharSet: String);
begin
    VTransferHeader := bit7; // Бит на кодирование
    VHeaderEncoding := 'B'; // Тип кодировки: Q - QuotedPrintable, B - Base64
    VCharSet := 'windows-1251'; // Кодировка - кириллица Windows
end;

procedure TOutLook_Form.FormActivate(Sender: TObject);
var FileName : string;
begin
   FileName := ExtractFilePath(Application.EXEName) + 'rmp.ini';
   lIniFile := TIniFile.Create(FileName);
   AdressEdit.Text := lIniFile.ReadString('Config', 'Recipient', '');
end;

end.
