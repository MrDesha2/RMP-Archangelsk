unit PrintDgrm;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, DBTables, Series,
  TeeShape, GanttCh, BubbleCh, ArrowCha, DbChart, Menus, StdActns,
  ActnList, ImgList, ComCtrls, ToolWin, Mask;

type
  TPrintDiagram = class(TForm)
    DBChart: TDBChart;
    StatusBar: TStatusBar;
    ToolBar: TToolBar;
    ButtonOpen: TToolButton;
    ButtonSave: TToolButton;
    ButtonSaveAs: TToolButton;
    ButtonPrint: TToolButton;
    ButtonPrintSetup: TToolButton;
    PageSetupButton: TToolButton;
    ButtonExit: TToolButton;
    ButtonFont: TToolButton;
    FontCombo: TComboBox;
    ToolbarImages: TImageList;
    PrinterSetupDialog: TPrinterSetupDialog;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    PageSetupDialog: TPageSetupDialog;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    FontDialog: TFontDialog;
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
    N3: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    MenuEdit: TMenuItem;
    MenuButFont: TMenuItem;
    Image: TImage;
    N4: TMenuItem;
    D3: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    ButtonLeft: TToolButton;
    ButtonRight: TToolButton;
    procedure SetDgrm(Line : TChartSeriesClass);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonSaveAsClick(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure SetFileName(const FileName: String);
    procedure ButtonOpenClick(Sender: TObject);
    procedure CheckFileSave;
    procedure ButtonPrintClick(Sender: TObject);
    procedure ButtonPrintSetupClick(Sender: TObject);
    procedure PageSetupButtonClick(Sender: TObject);
    procedure ButtonExitClick(Sender: TObject);
    procedure FontComboChange(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure D3Click(Sender: TObject);
    procedure Color(Sender: TChartSeries; ValueIndex: Integer;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ButtonLeftClick(Sender: TObject);
    procedure ButtonRightClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
     FFileName: string;

    { Private declarations tchart}
  public
    { Public declarations }
  end;

var
  PrintDiagram: TPrintDiagram;

implementation
uses PrintFrm, printlibs,
     Libs, PrintProces;

// uses Rep31;

resourcestring
  sSaveChanges = 'Сохранить изменения в файл %s?';
  sOverWrite = 'Переписать файл %s';
  sUntitled = 'Без имени';
  sModified = 'Изменен';
  sColRowInfo = 'Line: %3d   Col: %3d';

{$R *.dfm}

procedure TPrintDiagram.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TPrintDiagram.FormCreate(Sender: TObject);
begin
  TeeEraseBack:=False; { try win95 + plus ! + drag window + resizing ! }
  Image.Align := alNone;
  Image.Visible := False;
  DBChart.Align := alClient;
  DBChart.Visible := True;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  SetFileName(sUntitled);
end;

procedure TPrintDiagram.SetDgrm(Line : TChartSeriesClass);
Var l : TChartSeries;
begin
         l:=@Line;
         l:= Line.Create(Self);
         l.ParentChart := DBChart;
         if (l.GetEditorClass = 'TBarSeriesEditor') or (l.GetEditorClass = 'TAreaSeriesEditor') or
            (l.GetEditorClass = 'TPieSeriesEditor') or (l.GetEditorClass = 'TChartShapeEditor') Then
         begin
             DBChart.Series[Dbchart.SeriesCount-1].OnClick := Color;
             DBChart.Series[Dbchart.SeriesCount-1].Cursor := crHandPoint;
         end;
         if (l.GetEditorClass = 'TPieSeriesEditor') Then
         begin
             ButtonLeft.Enabled  := True;
             ButtonRight.Enabled := True;
         end
end;

procedure TPrintDiagram.Color(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  With Sender do
       ValueColor[ValueIndex]:=EditColor(Self,ValueColor[ValueIndex]);
end;


procedure TPrintDiagram.ButtonSaveClick(Sender: TObject);
begin
  if FFileName = sUntitled then
  begin
    FileSaveAs(Sender)
  end  
  else
  begin

     if SaveDialog.FilterIndex = 1 Then
          DBChart.SaveToBitmapFile(SaveDialog.FileName)
      else
            DBChart.SaveToMetafile(SaveDialog.FileName);
  end;
end;

procedure TPrintDiagram.ButtonSaveAsClick(Sender: TObject);
begin
    FileSaveAs(Sender)
end;

procedure TPrintDiagram.SetFileName(const FileName: String);
begin
  FFileName := FileName;
  Caption := Format('Печатная форма %s', [ExtractFileName(FileName), Application.Title]);
end;


procedure TPrintDiagram.FileSaveAs(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    if FileExists(SaveDialog.FileName) then
      if MessageDlg(Format(sOverWrite, [SaveDialog.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;

    if SaveDialog.FilterIndex = 1 Then
        DBChart.SaveToBitmapFile(SaveDialog.FileName)
     else
         DBChart.SaveToMetafile(SaveDialog.FileName);

    SetFileName(SaveDialog.FileName);
  end;  
end;

procedure TPrintDiagram.ButtonOpenClick(Sender: TObject);
begin
  CheckFileSave;
  if OpenDialog.Execute then
  begin
    DBChart.Align := alNone;
    DbChart.Visible := False;
    Image.Picture.LoadFromFile(OpenDialog.FileName);
    Image.Align := alClient;
    Image.Visible := True;
    Image.Refresh;
  end;

end;

procedure TPrintDiagram.CheckFileSave;
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



procedure TPrintDiagram.ButtonPrintClick(Sender: TObject);
begin
  if PrintDialog.Execute then
    DBChart.Print;

end;

procedure TPrintDiagram.ButtonPrintSetupClick(Sender: TObject);
begin
 PrinterSetupDialog.Execute; 
end;

procedure TPrintDiagram.PageSetupButtonClick(Sender: TObject);
begin
  PageSetupDialog.Execute;

end;

procedure TPrintDiagram.ButtonExitClick(Sender: TObject);
begin
  if StatusBar.Panels[1].Text <> '' then
    CheckFileSave;

  close;

end;

procedure TPrintDiagram.FontComboChange(Sender: TObject);
begin
     //если не ручной ввод
     if FontCombo.ItemIndex <> -1 Then
     begin
       Try
          DBChart.Title.Font.Size:= strtoint(FontCombo.text); // 8 * StrToInt(FontCombo.Text) div 100;
       except
           MessageDlg('Неправильный ввода размера шрифта', mtWarning , [mbYes], 0);
       end;

       If DBChart.Title.Font.Size <= 0 Then
           DBChart.Title.Font.Size:=8;


       DBChart.Update;
       FontCombo.Text   := FontCombo.Text;
       FontCombo.Update;
     end

end;

procedure TPrintDiagram.N10Click(Sender: TObject);
begin
  if MessageDlg('Закрыть программу?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
     Application.Terminate;
end;

procedure TPrintDiagram.D3Click(Sender: TObject);
begin
  If (MainMenu.Items[1].Checked = True) or (Popupmenu.Items[2].Checked = True) Then
  begin
      MainMenu.Items[1].Checked:=False;
      Popupmenu.Items[2].Checked:=False;
      DBChart.View3D:=False
  end
   else
   begin
        MainMenu.Items[1].Checked:=True;
        Popupmenu.Items[2].Checked:=True;
        DBChart.View3D:=True;
   end;
  DBChart.Repaint;
  DBChart.Repaint;
end;

procedure TPrintDiagram.ButtonLeftClick(Sender: TObject);
begin
    (DBChart[0] as TPieSeries).Rotate(2);
end;

procedure TPrintDiagram.ButtonRightClick(Sender: TObject);
begin
    (DBChart[0] as TPieSeries).Rotate(358);
end;

procedure TPrintDiagram.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action  := caFree;
end;

end.
