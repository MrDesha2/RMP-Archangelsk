object Report35Form: TReport35Form
  Left = 235
  Top = 262
  Width = 400
  Height = 210
  Caption = #1054#1090#1095#1077#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 91
    Top = 26
    Width = 180
    Height = 20
    Caption = #1047#1072#1075#1088#1091#1079#1082#1072' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 50
    Top = 65
    Width = 9
    Height = 16
    Caption = 'C'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 176
    Top = 65
    Width = 16
    Height = 16
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 72
    Top = 63
    Width = 96
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 201
    Top = 63
    Width = 97
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 1
  end
  object Button1: TButton
    Left = 92
    Top = 107
    Width = 84
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 189
    Top = 107
    Width = 85
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button2Click
  end
  object ButtonSelPer: TButton
    Left = 299
    Top = 63
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonSelPerClick
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 352
    Top = 128
  end
end
