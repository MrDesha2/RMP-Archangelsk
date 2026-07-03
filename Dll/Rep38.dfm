object Report38Form: TReport38Form
  Left = 276
  Top = 211
  Width = 542
  Height = 334
  Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 152
    Top = 14
    Width = 201
    Height = 24
    Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 121
    Top = 52
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
    Left = 239
    Top = 52
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
  object Label10: TLabel
    Left = 21
    Top = 130
    Width = 66
    Height = 16
    Caption = #1056#1072#1073#1086#1090#1085#1080#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 21
    Top = 104
    Width = 109
    Height = 16
    Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 21
    Top = 78
    Width = 91
    Height = 16
    Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 21
    Top = 156
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
    Left = 135
    Top = 50
    Width = 96
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 263
    Top = 50
    Width = 98
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonSelPer: TButton
    Left = 361
    Top = 50
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelPerClick
  end
  object Button1: TButton
    Left = 178
    Top = 195
    Width = 84
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 275
    Top = 195
    Width = 85
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = Button2Click
  end
  object WrkrCombo: TComboEdit
    Left = 135
    Top = 126
    Width = 271
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = WrkrComboButtonClick
    OnKeyDown = WrkrComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 135
    Top = 102
    Width = 271
    Height = 22
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 6
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object NumDocEdit: TEdit
    Left = 135
    Top = 78
    Width = 98
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object EqptCombo: TComboEdit
    Left = 135
    Top = 152
    Width = 271
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 8
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = EqptComboButtonClick
    OnKeyDown = EqptComboKeyDown
  end
  object WrkrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrkr'
      'where id = :id or code = :code'
      '')
    Left = 496
    Top = 152
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
    Left = 400
    Top = 16
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code'
      '')
    Left = 496
    Top = 120
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
  object EqptQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code'
      '')
    Left = 496
    Top = 184
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
end
