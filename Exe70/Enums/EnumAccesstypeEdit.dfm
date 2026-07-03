object ENUM_ACCESSTYPEForm: TENUM_ACCESSTYPEForm
  Left = 425
  Top = 318
  BorderStyle = bsDialog
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1042#1080#1076#1099' '#1076#1086#1087#1091#1089#1082#1072
  ClientHeight = 142
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CodeLabel: TLabel
    Left = 16
    Top = 24
    Width = 63
    Height = 13
    Caption = #1050#1086#1076' '#1076#1086#1087#1091#1089#1082#1072
  end
  object Label1: TLabel
    Left = 16
    Top = 48
    Width = 97
    Height = 13
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077' '#1076#1086#1087#1091#1089#1082#1072':'
  end
  object CODEEdit: TEdit
    Left = 128
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object NameEdit: TEdit
    Left = 128
    Top = 44
    Width = 247
    Height = 43
    MaxLength = 100
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 72
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object ButtonClose: TButton
    Left = 152
    Top = 96
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Close'
    TabOrder = 3
    OnClick = ButtonCloseClick
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    Left = 352
    Top = 104
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 320
    Top = 104
  end
end
