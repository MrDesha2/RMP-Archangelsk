object ENUM_FAILEdit: TENUM_FAILEdit
  Left = 232
  Top = 224
  Width = 444
  Height = 185
  Caption = #1055#1088#1080#1095#1080#1085#1099' '#1086#1090#1082#1072#1079#1086#1074' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 45
    Top = 30
    Width = 22
    Height = 13
    Caption = #1050#1086#1076':'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 46
    Height = 13
    Caption = #1055#1088#1080#1095#1080#1085#1072':'
  end
  object CodeEdit: TMaskEdit
    Left = 72
    Top = 24
    Width = 71
    Height = 21
    Enabled = False
    EditMask = '!99999;1; '
    MaxLength = 5
    TabOrder = 0
    Text = '     '
  end
  object OK_Button: TButton
    Left = 160
    Top = 112
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = OK_ButtonClick
  end
  object Close_Button: TButton
    Left = 240
    Top = 112
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = Close_ButtonClick
  end
  object NameEdit: TMemo
    Left = 72
    Top = 48
    Width = 345
    Height = 49
    MaxLength = 60
    TabOrder = 1
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 368
    Top = 8
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    Left = 400
    Top = 8
  end
end
