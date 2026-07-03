object Report2Form: TReport2Form
  Left = 232
  Top = 289
  Width = 441
  Height = 214
  Caption = #1043#1088#1072#1092#1080#1082' '#1088#1072#1073#1086#1090#1099' '#1054#1058#1050
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label6: TLabel
    Left = 97
    Top = 17
    Width = 233
    Height = 29
    Caption = #1043#1088#1072#1092#1080#1082' '#1088#1072#1073#1086#1090#1099' '#1054#1058#1050
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 46
    Top = 64
    Width = 13
    Height = 24
    Caption = 'C'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 201
    Top = 64
    Width = 22
    Height = 24
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 73
    Top = 62
    Width = 118
    Height = 25
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 231
    Top = 62
    Width = 120
    Height = 25
    NumGlyphs = 2
    TabOrder = 1
  end
  object Button1: TButton
    Left = 122
    Top = 108
    Width = 104
    Height = 32
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 241
    Top = 108
    Width = 105
    Height = 32
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button2Click
  end
  object ButtonSelPer: TButton
    Left = 351
    Top = 62
    Width = 31
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonSelPerClick
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 312
    Top = 104
  end
end
