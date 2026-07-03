{

     Проект: АСУ РМП.

     Модуль формы печати документа.
     Вызывается из модулей печати.



}

unit PrintFrm;

interface

uses
//  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
 // StdCtrls, ComCtrls, ExtCtrls, ToolWin, ImgList;
   SysUtils, Windows, Messages, Classes, Graphics, Controls, Variants,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ClipBrd,
  ToolWin, ActnList, ImgList, StdActns, RXSlider, RpRenderCanvas,
  RpRenderPreview, RpDefine, RpRender, RpRenderText, Printers, OutLookForm, ComObj;

type
  TShowPrintForm = class(TForm)
    PrinterSetupDialog: TPrinterSetupDialog;
    ToolBar: TToolBar;
    ButtonOpen: TToolButton;
    ButtonPrint: TToolButton;
    ButtonPrintSetup: TToolButton;
    ButtonSave: TToolButton;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    MainPanel: TPanel;
    Editor: TRichEdit;
    ButtonExit: TToolButton;
    PrintDialog: TPrintDialog;
    StatusBar: TStatusBar;
    ToolbarImages: TImageList;
    ButtonSaveAs: TToolButton;
    FindDialog: TFindDialog;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    FindBut: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    ActionList: TActionList;
    EditCut: TEditCut;
    EditCopy: TEditCopy;
    EditPaste: TEditPaste;
    ButtonFont: TToolButton;
    FontCombo: TComboBox;
    PageSetupButton: TToolButton;
    PageSetupDialog: TPageSetupDialog;
    MainMenu: TMainMenu;
    MenuFile: TMenuItem;
    MenuButOpen: TMenuItem;
    MenuButSave: TMenuItem;
    MenuButSaveAs: TMenuItem;
    N12: TMenuItem;
    MenuButSetPrinter: TMenuItem;
    MenuButPageSetup: TMenuItem;
    MenuButPrint: TMenuItem;
    N16: TMenuItem;
    MenuEdit: TMenuItem;
    MenuButCopy: TMenuItem;
    MenuButCut: TMenuItem;
    MenuButPaste: TMenuItem;
    N22: TMenuItem;
    MenuButFont: TMenuItem;
    N24: TMenuItem;
    MenuButFind: TMenuItem;
    N3: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    EditUndo: TEditUndo;
    Undo1: TMenuItem;
    N8: TMenuItem;
    FontDialog: TFontDialog;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    MenuExport: TMenuItem;
    Save2WordDialog: TSaveDialog;
    procedure ButtonExitClick(Sender: TObject);
    procedure open(_RichEdit: TRichEdit);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonPrintClick(Sender: TObject);
    procedure SetFileName(const FileName: String);
    procedure FileSaveAs(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);
    procedure SetModified(Value: Boolean);
    procedure CheckFileSave;
    procedure PerformFileOpen(const AFileName: string);
    procedure FormCreate(Sender: TObject);
    procedure EditorSelectionChange(Sender: TObject);
    procedure EditorKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonSaveAsClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure UpdateCursorPos;
    procedure SetEditRect;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ButtonPrintSetupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonFindClick(Sender: TObject);
    procedure FindButClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure PrinterSetupDialogClose(Sender: TObject);
    procedure ButtonFontClick(Sender: TObject);
    function  CurrText: TTextAttributes;
    procedure FontComboChange(Sender: TObject);
    procedure PageSetupButtonClick(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure EditCopyExecute(Sender: TObject);
    procedure EditPasteExecute(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure EditUndoExecute(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure onshow;
    procedure ToolButton3Click(Sender: TObject);
    procedure MenuExportClick(Sender: TObject);

  private
    FFileName: string;
    CanModify: boolean;

  public
    { Public declarations }
  end;

var
  ShowPrintForm: TShowPrintForm;

implementation


uses RichEdit, ShellAPI;
const
  GutterWid = 6;
  SecretKey = ['z','Z','я','Я'];


resourcestring
  sSaveChanges = 'Сохранить изменения в файл %s?';
  sOverWrite = 'Переписать файл %s';
  sUntitled = 'Без имени';
  sModified = 'Изменен';
  sColRowInfo = 'Line: %3d   Col: %3d';



{$R *.DFM}

{
   Выход из формы.
}
procedure TShowPrintForm.ButtonExitClick(Sender: TObject);
begin
  if StatusBar.Panels[1].Text <> '' then
    CheckFileSave;

  close;
end;

procedure TShowPrintForm.SetModified(Value: Boolean);
begin

  if Value then StatusBar.Panels[1].Text := sModified
  else StatusBar.Panels[1].Text := '';

end;


{
   Процедура открытия формы.
   Вход:

}
procedure TShowPrintForm.open(_RichEdit: TRichEdit);
begin
   //

end;


procedure TShowPrintForm.SetFileName(const FileName: String);
begin
  FFileName := FileName;
  Caption := Format('Печатная форма %s', [ExtractFileName(FileName), Application.Title]);
end;


procedure TShowPrintForm.FileSaveAs(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    if FileExists(SaveDialog.FileName) then
      if MessageDlg(Format(sOverWrite, [SaveDialog.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;

        
    Editor.Lines.SaveToFile(SaveDialog.FileName);
    SetFileName(SaveDialog.FileName);
    Editor.Modified := False;
    SetModified(False);
  end;
end;



{

   Процедура сохранения файла
}

procedure TShowPrintForm.ButtonSaveClick(Sender: TObject);
begin
  if FFileName = sUntitled then
    FileSaveAs(Sender)
  else
  begin
    Editor.Lines.SaveToFile(FFileName);
    Editor.Modified := False;
  end;
end;

{

   Процедура сохранения файла
}

procedure TShowPrintForm.ButtonSaveAsClick(Sender: TObject);
begin
    FileSaveAs(Sender)
end;


{
   Процедура вывода на печать

}
procedure TShowPrintForm.ButtonPrintClick(Sender: TObject);
begin
  if PrintDialog.Execute then
    Editor.Print(FFileName);

end;

procedure TShowPrintForm.CheckFileSave;
var
  SaveResp: Integer;
begin

  SaveResp := MessageDlg(Format(sSaveChanges, [FFileName]),
    mtConfirmation, mbYesNoCancel, 0);
  case SaveResp of
    idYes: ButtonSaveClick(Self);
    idNo: {Nothing};
    idCancel: Abort;
  end;
end;

procedure TShowPrintForm.PerformFileOpen(const AFileName: string);
begin
  Editor.Lines.LoadFromFile(AFileName);
  SetFileName(AFileName);
  Editor.Modified := False;
  SetModified(False);
end;



{

   Процедура открытия файла

}
procedure TShowPrintForm.ButtonOpenClick(Sender: TObject);
begin
  CheckFileSave;
  if OpenDialog.Execute then
  begin
    PerformFileOpen(OpenDialog.FileName);
    Editor.ReadOnly := ofReadOnly in OpenDialog.Options;
  end;

end;
procedure TShowPrintForm.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    StatusBar.SimplePanel := True;
    StatusBar.SimpleText := Application.Hint;
  end
  else StatusBar.SimplePanel := False;
end;


{

  Процедуры при открытии формы

}
procedure TShowPrintForm.FormCreate(Sender: TObject);
begin
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  SetFileName(sUntitled);
//  Editor.Font.Size := 8;

  // нельзя редактировать
  CanModify := false;
  Editor.Visible := false;
  FontDialog.Font.Size := 8;
  FontCombo.ItemIndex  := 2;
  Editor.HideSelection := true;
  Printer.Orientation:= poPortrait;
end;


procedure TShowPrintForm.UpdateCursorPos;
var                                                
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(Editor.Handle, EM_EXLINEFROMCHAR, 0,
    Editor.SelStart);
  CharPos.X := (Editor.SelStart -
    SendMessage(Editor.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  StatusBar.Panels[0].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
end;


procedure TShowPrintForm.EditorSelectionChange(Sender: TObject);
begin
   UpdateCursorPos;

end;                                   

{

   Запрет редактирования формы

}
procedure TShowPrintForm.EditorKeyPress(Sender: TObject; var Key: Char);
begin

   if not CanModify then
     abort;

end;

procedure TShowPrintForm.SetEditRect;
var
  R: TRect;
begin
  with Editor do
  begin
    R := Rect(GutterWid, 0, ClientWidth-GutterWid, ClientHeight);
    SendMessage(Handle, EM_SETRECT, 0, Longint(@R));
  end;
end;


{
   Перерисовка окна формы

}


procedure TShowPrintForm.FormPaint(Sender: TObject);
begin
   SetEditRect;

end;
{
  Процедура при изменении размера формы

}
procedure TShowPrintForm.FormResize(Sender: TObject);
begin
  SetEditRect;
  EditorSelectionChange(Sender);

end;

procedure TShowPrintForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  OpenDialog.free;
  SaveDialog.free;
  FindDialog.free;
  PrinterSetupDialog.free;
  PrintDialog.free;

  action  := caFree;
end;

{
   Процедура изменения масштаба просмотра

}

{
   Обработка нажатия кнопки на форме

}
procedure TShowPrintForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);


begin

  if key = 27 then

    begin
      // проверка при закрытии
      if StatusBar.Panels[1].Text <> '' then
        CheckFileSave;


      close;
    end;


  // разрешение редактировать таблицу по секретной кнопке
  if (Shift = [ssAlt]) and (chr(key) in SecretKey) then

      if not CanModify then
        begin
          CanModify       := true;
          Editor.ReadOnly := false;
          Editor.Color    := clWhite;
          setModified(true);
          abort;
        end

      else
        begin
          CanModify       := false;
          Editor.ReadOnly := true;
          Editor.Color    := 10930928;
          abort;
        end



end;

procedure TShowPrintForm.ButtonPrintSetupClick(Sender: TObject);
begin
 PrinterSetupDialog.Execute;

end;

procedure TShowPrintForm.FormShow(Sender: TObject);
begin
 // Editor.Visible := true;

end;

{

   Поиск по подстроке

}
procedure TShowPrintForm.ButtonFindClick(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
begin

  with Editor do
  begin
    { begin the search after the current selection if there is one }
    { otherwise, begin at the start of the text }
    if SelLength <> 0 then

      StartPos := SelStart + SelLength
    else

      StartPos := 0;

    { ToEnd is the length from StartPos to the end of the text in the rich edit control }

    ToEnd := Length(Text) - StartPos;

    FoundAt := FindText(FindDialog.FindText, StartPos, ToEnd, [stMatchCase]);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(FindDialog.FindText);
    end;
  end;

end;

procedure TShowPrintForm.FindButClick(Sender: TObject);
begin
//  FindDialog.Position := Point(Editor.Left + Editor.Width, Editor.Top);
  Editor.HideSelection := false;
  FindDialog.Execute;

end;

procedure TShowPrintForm.N5Click(Sender: TObject);
begin
  editor.CutToClipboard;
end;

procedure TShowPrintForm.N6Click(Sender: TObject);
begin
  editor.CopyToClipboard;
end;

procedure TShowPrintForm.N7Click(Sender: TObject);
begin
  Editor.PasteFromClipboard;
end;

procedure TShowPrintForm.PrinterSetupDialogClose(Sender: TObject);
begin
        SetFocus;
end;

procedure TShowPrintForm.ButtonFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(Editor.SelAttributes);
  if FontDialog.Execute then
    CurrText.Assign(FontDialog.Font);
  with Editor do
    if CanFocus then
      SetFocus;
  FontCombo.Text:= IntToStr(FontDialog.Font.Size); // * 100 div 8);

  FontCombo.Update;
end;

function TShowPrintForm.CurrText: TTextAttributes;
begin
  if Editor.SelLength > 0 then Result := Editor.SelAttributes
  else Result := Editor.DefAttributes;
end;


{
   Процедура изменения масштаба просмотра

}
procedure TShowPrintForm.FontComboChange(Sender: TObject);
begin
     //если не ручной ввод
     if FontCombo.ItemIndex <> -1 Then
     begin
       Try
          Editor.Font.Size:= strtoint(FontCombo.text); // 8 * StrToInt(FontCombo.Text) div 100;
       except
           MessageDlg('Неправильный ввода размера шрифта', mtWarning , [mbYes], 0);
       end;    

       If Editor.Font.Size <= 0 Then
           Editor.Font.Size:=8;


       Editor.Update;
//       FontCombo.Text   := FontCombo.Text;
//       FontCombo.Update;
     end

end;

procedure TShowPrintForm.PageSetupButtonClick(Sender: TObject);
begin
  PageSetupDialog.Execute;
end;

procedure TShowPrintForm.EditCutExecute(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TShowPrintForm.EditCopyExecute(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TShowPrintForm.EditPasteExecute(Sender: TObject);
begin
   Editor.PasteFromClipboard;
end;

procedure TShowPrintForm.N10Click(Sender: TObject);
begin
  if MessageDlg('Закрыть программу?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     Application.Terminate;
end;

procedure TShowPrintForm.EditUndoExecute(Sender: TObject);
begin
    Editor.Undo;
end;

procedure TShowPrintForm.FindDialogFind(Sender: TObject);
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;

begin
  with Editor do
  begin
    { begin the search after the current selection if there is one }
    { otherwise, begin at the start of the text }
    if SelLength <> 0 then

      StartPos := SelStart + SelLength
    else

      StartPos := 0;

    { ToEnd is the length from StartPos to the end of the text in the rich edit control }

    ToEnd := Length(Text) - StartPos;

    FoundAt := FindText(FindDialog.FindText, StartPos, ToEnd, [stMatchCase]);
    if FoundAt <> -1 then
    begin
      SelStart := FoundAt;
      SelLength := Length(FindDialog.FindText);
      SetFocus;
    end;

  end;

end;

procedure TShowPrintForm.onshow;
begin
  Editor.Font.Size := 7;
  Editor.Update;
  Editor.Font.Size := 8;
  Editor.Update;

end;

procedure TShowPrintForm.ToolButton3Click(Sender: TObject);
var Outlook : TOutLook_Form;
begin
//   ShowMessage('Отправка электронных писем находится на стадии разработки');
// открыть форму редактирования параметров
  Outlook := TOutLook_Form.Create(Application);

  Outlook.MessageStream := TMemoryStream.Create;
  Editor.Lines.SaveToStream(Outlook.MessageStream);

  Outlook.MessageLines := Editor.Lines;
  Outlook.MessageText := Editor.Text;
  OutLook.SubjectText := Caption;
  Outlook.ShowModal;
  Outlook.Destroy;
end;
//
//  Процедура экспорта текста в формат Docx
//
//
procedure TShowPrintForm.MenuExportClick(Sender: TObject);
var
 oWord: OleVariant;
 oDoc: OleVariant;

 const wdFormatRTF = $00000006;
       wdFormatDocument = $00000000;              // текстовый формат Microsoft Windows.
       wdFormatDocumentDefault = 17;        // DOCX
begin
     //  Выбрать файл для записи
    if Save2WordDialog.Execute then
     begin
        // создать OLE объект
        try
          oWord := CreateOleObject('Word.Application');
        except
          MessageDlg('Приложение MS Word не установлено!', mtWarning , [mbYes], 0);
          Exit;
        end;

//        MessageDlg('Создали объект!', mtWarning , [mbYes], 0);

        oDoc  := oWord.Documents.Add;

        // копируем в ворд через буфер обмена
        try
          Editor.SelectAll;
          Editor.CopyToClipboard;
          oDoc  := oWord.ActiveDocument;
          oDoc.Range.Paste;

//          MessageDlg('Скопировал!', mtWarning , [mbYes], 0);

        except
          MessageDlg('Ошибка буфера обмена!', mtWarning , [mbYes], 0);
          Exit;
        end;


//        if ExtractFileExt(Save2WordDialog.FileName) = 'doc' then
         oDoc.SaveAs(Save2WordDialog.FileName, wdFormatDocument);             // DOC
//        else
//         oDoc.SaveAs(txtfilename, wdFormatDocumentDefault);      // DOCX
        oDoc.Close;
        oWord.DisplayAlerts := True;
        oWord.Quit;

        oDoc  := Unassigned;
        oWord := Unassigned;
//        oWord.ActiveDocument.Close(0, EmptyParam, EmptyParam);
//        oWord.Quit(EmptyParam, EmptyParam, EmptyParam);
//        oDoc  := VarNull;
//        oWord := VarNull;


           MessageDlg('Экспорт выполнен', mtWarning , [mbYes], 0);


     end;
end;

end.
