object Report4Form: TReport4Form
  Left = 250
  Top = 205
  Width = 533
  Height = 548
  Caption = #1054#1090#1095#1077#1090' '#1042#1099#1088#1072#1073#1086#1090#1082#1072' '#1087#1086' '#1073#1088#1080#1075#1072#1076#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
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
  object Label2: TLabel
    Left = 105
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
    Left = 231
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
  object Label6: TLabel
    Left = 130
    Top = 14
    Width = 204
    Height = 24
    Caption = #1042#1099#1088#1072#1073#1086#1090#1082#1072' '#1087#1086' '#1073#1088#1080#1075#1072#1076#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 89
    Top = 78
    Width = 34
    Height = 16
    Caption = #1060#1048#1054':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 66
    Top = 104
    Width = 58
    Height = 16
    Caption = #1041#1088#1080#1075#1072#1076#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 17
    Top = 130
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
  object Label5: TLabel
    Left = 55
    Top = 156
    Width = 66
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 55
    Top = 184
    Width = 68
    Height = 16
    Caption = #1054#1087#1077#1088#1072#1094#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 6
    Top = 207
    Width = 110
    Height = 16
    Caption = #1055#1088#1080#1079#1085#1072#1082' '#1079#1072#1082#1072#1079#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 127
    Top = 50
    Width = 96
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 255
    Top = 50
    Width = 98
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 1
  end
  object WrkrCombo: TComboEdit
    Left = 127
    Top = 74
    Width = 271
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = WrkrComboButtonClick
    OnKeyDown = WrkrComboKeyDown
  end
  object Button1: TButton
    Left = 146
    Top = 340
    Width = 85
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 13
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 244
    Top = 340
    Width = 84
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 14
    OnClick = Button2Click
  end
  object ButtonSelPer: TButton
    Left = 353
    Top = 50
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelPerClick
  end
  object BrigadeCombo: TComboEdit
    Left = 127
    Top = 100
    Width = 271
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 4
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = BrigadeComboButtonClick
    OnKeyDown = BrigadeComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 127
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
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object CstCombo: TComboEdit
    Left = 127
    Top = 152
    Width = 271
    Height = 23
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 6
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object VopCombo: TComboEdit
    Left = 127
    Top = 180
    Width = 271
    Height = 23
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 7
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = VopComboButtonClick
    OnKeyDown = VopComboKeyDown
  end
  object RadioGroup1: TRadioGroup
    Left = 127
    Top = 228
    Width = 271
    Height = 46
    Caption = #1042#1080#1076' '#1074#1099#1088#1072#1073#1086#1090#1082#1080
    TabOrder = 9
  end
  object RadioButtonPlan: TRadioButton
    Left = 165
    Top = 246
    Width = 73
    Height = 16
    Caption = #1055#1086' '#1087#1083#1072#1085#1091
    TabOrder = 10
  end
  object RadioButtonFact: TRadioButton
    Left = 253
    Top = 246
    Width = 113
    Height = 16
    Caption = #1055#1086' '#1092#1072#1082#1090#1091
    Checked = True
    TabOrder = 11
    TabStop = True
  end
  object FeatComboBox: TComboBox
    Left = 127
    Top = 206
    Width = 271
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 8
    Text = #1041#1077#1079' '#1087#1088#1080#1079#1085#1072#1082#1072
    Items.Strings = (
      #1041#1077#1079' '#1087#1088#1080#1079#1085#1072#1082#1072
      #1055#1083#1072#1085#1086#1074#1099#1077
      #1043#1086#1076#1086#1074#1099#1077
      #1042#1085#1077#1087#1083#1072#1085#1086#1074#1099#1077)
  end
  object GroupBox1: TGroupBox
    Left = 127
    Top = 280
    Width = 271
    Height = 46
    Caption = #1058#1080#1087' '#1086#1090#1095#1105#1090#1072
    TabOrder = 12
    object RadioButtonSmall: TRadioButton
      Left = 39
      Top = 20
      Width = 75
      Height = 13
      Caption = #1057#1078#1072#1090#1099#1081
      TabOrder = 0
    end
    object RadioButtonBig: TRadioButton
      Left = 127
      Top = 20
      Width = 92
      Height = 13
      Caption = #1056#1072#1079#1074#1105#1088#1085#1091#1090#1099#1081
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object WrkrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrkr'
      'where id = :id or code = :code'
      '')
    Left = 427
    Top = 88
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
    Left = 24
    Top = 24
  end
  object BrigadeQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_brigade'
      'where id = :id or code = :code'
      '')
    Left = 427
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
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code'
      '')
    Left = 427
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
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 427
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
  object VopQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_vop'
      'where id = :id or code = :code'
      '')
    Left = 427
    Top = 216
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
