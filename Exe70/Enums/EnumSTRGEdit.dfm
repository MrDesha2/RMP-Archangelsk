object ENUM_STRGForm: TENUM_STRGForm
  Left = 192
  Top = 145
  Width = 409
  Height = 205
  Caption = #1069#1083#1077#1084#1077#1085#1090':'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 74
    Height = 13
    Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 51
    Height = 13
    Caption = #1060#1086#1088#1084#1091#1083#1072':'
  end
  object Label4: TLabel
    Left = 16
    Top = 80
    Width = 289
    Height = 52
    Caption = 
      #1060#1086#1088#1084#1091#1083#1072' '#1076#1083#1103' '#1074#1099#1095#1080#1089#1083#1077#1085#1080#1103' '#1084#1072#1089#1089#1099' '#1084#1072#1090#1077#1088#1080#1072#1083#1072' ('#1079#1072#1075#1086#1090#1086#1074#1082#1080')'#13#10#1044#1086#1087#1091#1089#1082#1072#1102#1090#1089#1103' ' +
      #1089#1080#1084#1074#1086#1083#1099': '#39'+'#39','#39'-'#39', '#39'*'#39', '#39'/'#39'.'#13#10#1055#1077#1088#1077#1084#1077#1085#1085#1099#1077': L - '#1076#1083#1080#1085#1072', W - '#1096#1080#1088#1080#1085#1072', ' +
      'H - '#1074#1099#1089#1086#1090#1072','#13#10'RO - '#1087#1083#1086#1090#1085#1086#1089#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083#1072' '#1087#1086' '#1085#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1085#1086#1084#1091' '#1085#1086#1084#1077#1088#1091'.'
  end
  object Close_Buttom: TButton
    Left = 96
    Top = 137
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 16
    Top = 137
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object CodeEdit: TEdit
    Left = 112
    Top = 8
    Width = 121
    Height = 21
    MaxLength = 10
    TabOrder = 2
  end
  object NAMEEdit: TEdit
    Left = 112
    Top = 32
    Width = 121
    Height = 21
    MaxLength = 30
    TabOrder = 3
  end
  object FormulaEdit: TEdit
    Left = 112
    Top = 56
    Width = 273
    Height = 21
    MaxLength = 50
    TabOrder = 4
    Text = 'FormulaEdit'
  end
  object qQueryupdate: TQuery
    DatabaseName = 'RMP'
    Left = 504
    Top = 48
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 504
    Top = 80
  end
end
