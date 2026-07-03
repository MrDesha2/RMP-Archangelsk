object SetJRDate: TSetJRDate
  Left = 311
  Top = 236
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1080#1085#1090#1077#1088#1074#1072#1083' '#1078#1091#1088#1085#1072#1083#1072
  ClientHeight = 82
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 24
    Width = 115
    Height = 13
    Caption = #1057'                                '#1087#1086
  end
  object FromDate: TDateEdit
    Left = 73
    Top = 21
    Width = 81
    Height = 21
    NumGlyphs = 2
    TabOrder = 0
  end
  object ToDate: TDateEdit
    Left = 177
    Top = 21
    Width = 81
    Height = 21
    NumGlyphs = 2
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 72
    Top = 48
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 152
    Top = 48
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelButtonClick
  end
  object SelPeriod: TButton
    Left = 264
    Top = 21
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 4
    OnClick = SelPeriodClick
  end
end
