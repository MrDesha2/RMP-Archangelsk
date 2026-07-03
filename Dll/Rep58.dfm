object Report58Form: TReport58Form
  Left = 531
  Top = 257
  Width = 621
  Height = 532
  Caption = #1054#1090#1095#1105#1090' '#1090#1088#1091#1076#1086#1105#1084#1082#1086#1089#1090#1080' '#1088#1072#1073#1086#1090' '#1087#1086' '#1090#1080#1087#1072#1084' '#1088#1077#1084#1086#1085#1090#1080#1088#1091#1077#1084#1086#1075#1086' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
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
  object Label4: TLabel
    Left = 41
    Top = 128
    Width = 63
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 38
    Top = 152
    Width = 105
    Height = 32
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 111
    Top = 39
    Width = 334
    Height = 24
    Caption = #1054#1090#1095#1105#1090' '#1090#1088#1091#1076#1086#1105#1084#1082#1086#1089#1090#1080' '#1088#1072#1073#1086#1090' '#1087#1086' '#1090#1080#1087#1072#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 134
    Top = 65
    Width = 287
    Height = 24
    Caption = #1088#1077#1084#1086#1085#1090#1080#1088#1091#1077#1084#1086#1075#1086' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 156
    Top = 98
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
  object Label6: TLabel
    Left = 282
    Top = 98
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
  object Label7: TLabel
    Left = 38
    Top = 222
    Width = 107
    Height = 16
    Caption = #1055#1088#1080#1079#1085#1072#1082' '#1079#1072#1082#1072#1079#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label8: TLabel
    Left = 38
    Top = 244
    Width = 41
    Height = 16
    Caption = #1054#1090#1073#1086#1088
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label9: TLabel
    Left = 41
    Top = 191
    Width = 123
    Height = 16
    Caption = #1058#1080#1087' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object CstCombo: TComboEdit
    Left = 180
    Top = 128
    Width = 225
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 0
    ID = -1
    CanSelectGroup = False
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 180
    Top = 159
    Width = 225
    Height = 23
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 1
    ID = -1
    CanSelectGroup = False
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object BegDateEdit: TDateEdit
    Left = 178
    Top = 96
    Width = 96
    Height = 20
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 2
  end
  object EndDateEdit: TDateEdit
    Left = 307
    Top = 96
    Width = 97
    Height = 20
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 3
  end
  object ButtonSelPer: TButton
    Left = 405
    Top = 96
    Width = 25
    Height = 20
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonSelPerClick
  end
  object ButtonOK: TButton
    Left = 191
    Top = 330
    Width = 91
    Height = 27
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 5
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 301
    Top = 330
    Width = 92
    Height = 27
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = ButtonNOClick
  end
  object ComboBoxFlag: TComboBox
    Left = 180
    Top = 220
    Width = 225
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = #1042#1089#1077
    Items.Strings = (
      #1042#1089#1077
      #1055#1083#1072#1085#1086#1074#1099#1077
      #1043#1086#1076#1086#1074#1099#1077
      #1042#1085#1077#1087#1083#1072#1085#1086#1074#1099#1077)
  end
  object ComboBoxSelection: TComboBox
    Left = 180
    Top = 246
    Width = 225
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 8
    Text = #1042#1089#1077
    Items.Strings = (
      #1042#1089#1077
      #1042#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
      #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
      #1053#1077' '#1079#1072#1087#1091#1097#1077#1085#1085#1099#1077)
  end
  object RadioGroup1: TRadioGroup
    Left = 180
    Top = 272
    Width = 221
    Height = 47
    Caption = #1058#1080#1087' '#1086#1090#1095#1105#1090#1072
    TabOrder = 9
  end
  object FullRadioButton: TRadioButton
    Left = 284
    Top = 292
    Width = 91
    Height = 14
    Caption = #1056#1072#1079#1074#1105#1088#1085#1091#1090#1099#1081
    TabOrder = 10
  end
  object CompactRadioButton: TRadioButton
    Left = 199
    Top = 292
    Width = 72
    Height = 14
    Caption = #1057#1078#1072#1090#1099#1081
    Checked = True
    TabOrder = 11
    TabStop = True
  end
  object EqptCombo: TComboEdit
    Left = 180
    Top = 190
    Width = 225
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 12
    ID = -1
    CanSelectGroup = False
    OnButtonClick = EqptComboButtonClick
    OnKeyDown = EqptComboKeyDown
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 101
    Top = 88
  end
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code'
      '')
    Left = 509
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
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 509
    Top = 197
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
      'select id, name'
      'from spr_Eqpt'
      'where id = :id or code = :code'
      '')
    Left = 509
    Top = 229
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
