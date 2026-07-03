object Report49Form: TReport49Form
  Left = 416
  Top = 332
  Width = 493
  Height = 245
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
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
    Left = 76
    Top = 5
    Width = 300
    Height = 24
    Caption = #1057#1082#1083#1072#1076#1089#1082#1072#1103' '#1082#1072#1088#1090#1086#1095#1082#1072' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 98
    Top = 46
    Width = 13
    Height = 24
    Caption = #1057
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 222
    Top = 46
    Width = 22
    Height = 24
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 29
    Top = 88
    Width = 83
    Height = 16
    Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 122
    Top = 50
    Width = 97
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 246
    Top = 50
    Width = 97
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonSelPer: TButton
    Left = 341
    Top = 49
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelPerClick
  end
  object ButtonOK: TButton
    Left = 143
    Top = 128
    Width = 91
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 3
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 253
    Top = 128
    Width = 92
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = ButtonNOClick
  end
  object EqptCombo: TComboEdit
    Left = 122
    Top = 86
    Width = 271
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = EqptComboButtonClick
    OnKeyDown = EqptComboKeyDown
  end
  object EqptQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code'
      '')
    Left = 408
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'code'
        ParamType = ptUnknown
      end>
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 408
    Top = 120
  end
end
