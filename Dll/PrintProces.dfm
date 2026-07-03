object ProcessForm: TProcessForm
  Left = 397
  Top = 247
  AutoScroll = False
  BorderIcons = []
  Caption = 'Выполняется обработка'
  ClientHeight = 74
  ClientWidth = 210
  Color = 10930928
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar: TProgressBar
    Left = 26
    Top = 26
    Width = 157
    Height = 14
    Min = 0
    Max = 100
    TabOrder = 0
  end
end
