object DOC_Structure_Form: TDOC_Structure_Form
  Left = 287
  Top = 238
  BorderStyle = bsDialog
  Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1087#1086#1076#1095#1080#1085#1077#1085#1085#1086#1089#1090#1080
  ClientHeight = 161
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 40
    Height = 13
    Caption = #1047#1072#1103#1074#1082#1072':'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 34
    Height = 13
    Caption = #1047#1072#1082#1072#1079':'
  end
  object Label3: TLabel
    Left = 16
    Top = 72
    Width = 111
    Height = 13
    Caption = #1055#1088#1080#1093#1086#1076#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090':'
  end
  object Label4: TLabel
    Left = 16
    Top = 96
    Width = 110
    Height = 13
    Caption = #1056#1072#1089#1093#1086#1076#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090':'
  end
  object doc_RQST: TLabel
    Left = 88
    Top = 24
    Width = 63
    Height = 13
    Caption = 'doc_RQST'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    OnClick = ButtonRQSTClick
  end
  object doc_ORDER: TLabel
    Left = 88
    Top = 48
    Width = 73
    Height = 13
    Caption = 'doc_ORDER'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    OnClick = ButtonORDERClick
  end
  object doc_pr: TLabel
    Left = 136
    Top = 72
    Width = 40
    Height = 13
    Caption = 'doc_pr'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    OnClick = ButtonPRClick
  end
  object doc_rs: TLabel
    Left = 136
    Top = 96
    Width = 39
    Height = 13
    Caption = 'doc_rs'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    OnClick = ButtonRSClick
  end
  object ButtonRQST: TButton
    Left = 312
    Top = 24
    Width = 75
    Height = 17
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = ButtonRQSTClick
  end
  object ButtonORDER: TButton
    Left = 312
    Top = 48
    Width = 75
    Height = 17
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 1
    OnClick = ButtonORDERClick
  end
  object ButtonPR: TButton
    Left = 312
    Top = 72
    Width = 75
    Height = 17
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = ButtonPRClick
  end
  object ButtonRS: TButton
    Left = 312
    Top = 96
    Width = 75
    Height = 17
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = ButtonRSClick
  end
  object ButtonClose: TButton
    Left = 312
    Top = 120
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = ButtonCloseClick
  end
  object FindQuery: TQuery
    DatabaseName = 'RMP'
    Left = 280
    Top = 8
  end
end
