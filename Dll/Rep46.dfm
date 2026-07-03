object Report46Form: TReport46Form
  Left = 217
  Top = 232
  Width = 556
  Height = 439
  Caption = #1059#1095#1077#1090' '#1082#1072#1076#1088#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 268
    Top = 31
    Width = 126
    Height = 26
    Caption = #1059#1095#1077#1090' '#1082#1072#1076#1088#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 103
    Top = 92
    Width = 49
    Height = 24
    Caption = #1060#1048#1054':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 110
    Top = 122
    Width = 39
    Height = 24
    Caption = #1055#1086#1083':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 82
    Top = 151
    Width = 70
    Height = 24
    Caption = #1056#1072#1079#1088#1103#1076':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 50
    Top = 210
    Width = 106
    Height = 24
    Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 11
    Top = 240
    Width = 149
    Height = 24
    Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 21
    Top = 270
    Width = 139
    Height = 24
    Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 74
    Top = 299
    Width = 81
    Height = 24
    Caption = #1041#1088#1080#1075#1072#1076#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 62
    Top = 329
    Width = 95
    Height = 24
    Caption = #1054#1087#1077#1088#1072#1094#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 21
    Top = 181
    Width = 145
    Height = 24
    Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object WrkrCombo: TComboEdit
    Left = 148
    Top = 87
    Width = 395
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 0
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = WrkrComboButtonClick
    OnKeyDown = WrkrComboKeyDown
  end
  object Button1: TButton
    Left = 233
    Top = 439
    Width = 103
    Height = 32
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 352
    Top = 439
    Width = 105
    Height = 32
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = Button2Click
  end
  object SexCombo: TComboBox
    Left = 148
    Top = 118
    Width = 99
    Height = 24
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 3
    Text = '-'
    Items.Strings = (
      '-'
      #1052#1091#1078'.'
      #1046#1077#1085'.')
  end
  object RankCombo: TComboBox
    Left = 148
    Top = 148
    Width = 99
    Height = 24
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 4
    Text = '-'
    Items.Strings = (
      '-'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6')
  end
  object ProfCombo: TComboEdit
    Left = 148
    Top = 206
    Width = 395
    Height = 25
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = ProfComboButtonClick
    OnKeyDown = ProfComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 148
    Top = 235
    Width = 395
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 6
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object EqptCombo: TComboEdit
    Left = 148
    Top = 265
    Width = 395
    Height = 25
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 7
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = EqptComboButtonClick
    OnKeyDown = EqptComboKeyDown
  end
  object GroupCombo: TComboEdit
    Left = 148
    Top = 294
    Width = 395
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 8
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = GroupComboButtonClick
    OnKeyDown = GroupComboKeyDown
  end
  object OperCombo: TComboEdit
    Left = 148
    Top = 324
    Width = 395
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 9
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = OperComboButtonClick
    OnKeyDown = OperComboKeyDown
  end
  object EqptCheckBox: TCheckBox
    Left = 148
    Top = 364
    Width = 395
    Height = 21
    Caption = #1042#1099#1074#1077#1089#1090#1080' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1086#1077' '#1087#1088#1080' '#1088#1072#1073#1086#1090#1077' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
    TabOrder = 10
  end
  object OperCheckBox: TCheckBox
    Left = 148
    Top = 394
    Width = 395
    Height = 21
    Caption = #1042#1099#1074#1077#1089#1090#1080' '#1074#1099#1087#1086#1083#1085#1103#1077#1084#1099#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
    TabOrder = 11
  end
  object DateBernComboBox: TComboBox
    Left = 148
    Top = 177
    Width = 99
    Height = 24
    ItemHeight = 16
    TabOrder = 12
  end
  object WrkrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrkr'
      'where id = :id or code = :code')
    Left = 453
    Top = 64
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
  object ProfQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_prof'
      'where id = :id or code = :code')
    Left = 456
    Top = 136
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
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 456
    Top = 160
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
      'where id = :id or code = :code')
    Left = 456
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
  object GroupQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_brigade'
      'where id = :id or code = :code')
    Left = 456
    Top = 208
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
  object OperQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_vop'
      'where id = :id or code = :code')
    Left = 456
    Top = 232
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
    Left = 384
    Top = 352
  end
  object ViewEqptQuery: TQuery
    DatabaseName = 'RMP'
    Left = 456
    Top = 264
  end
  object ViewOperQuery: TQuery
    DatabaseName = 'RMP'
    Left = 456
    Top = 296
  end
end
