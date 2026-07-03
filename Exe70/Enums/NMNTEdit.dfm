object ENUM_NMNTForm: TENUM_NMNTForm
  Left = 222
  Top = 246
  Width = 542
  Height = 288
  HelpContext = 111
  Caption = #1069#1083#1077#1084#1077#1085#1090':'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 16
    Width = 74
    Height = 13
    Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
  end
  object Label2: TLabel
    Left = 13
    Top = 40
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label3: TLabel
    Left = 13
    Top = 64
    Width = 42
    Height = 13
    Caption = #1063#1077#1088#1090#1077#1078':'
  end
  object CHRT_Name: TLabel
    Left = 296
    Top = 64
    Width = 3
    Height = 13
  end
  object Label4: TLabel
    Left = 13
    Top = 88
    Width = 76
    Height = 13
    Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077':'
  end
  object Label5: TLabel
    Left = 296
    Top = 88
    Width = 3
    Height = 13
  end
  object Label6: TLabel
    Left = 13
    Top = 111
    Width = 91
    Height = 26
    Caption = #1041#1072#1079#1086#1074#1072#1103' '#1077#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
    WordWrap = True
  end
  object Label11: TLabel
    Left = 172
    Top = 162
    Width = 29
    Height = 13
    Caption = #1062#1077#1085#1072':'
  end
  object Label7: TLabel
    Left = 13
    Top = 140
    Width = 34
    Height = 13
    Caption = #1047#1072#1074#1086#1076':'
  end
  object Label8: TLabel
    Left = 140
    Top = 181
    Width = 58
    Height = 26
    Caption = #1055#1083#1086#1090#1085#1086#1089#1090#1100' '#1084#1072#1090#1077#1088#1080#1072#1083#1072':'
    WordWrap = True
  end
  object Label9: TLabel
    Left = 309
    Top = 160
    Width = 109
    Height = 13
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1079#1072#1087#1072#1089':'
  end
  object Label10: TLabel
    Left = 309
    Top = 184
    Width = 115
    Height = 13
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1081' '#1079#1072#1087#1072#1089':'
  end
  object Code: TEdit
    Left = 104
    Top = 16
    Width = 113
    Height = 21
    MaxLength = 8
    TabOrder = 0
  end
  object _Name: TEdit
    Left = 104
    Top = 40
    Width = 417
    Height = 21
    MaxLength = 50
    TabOrder = 1
  end
  object Close_Buttom: TButton
    Left = 88
    Top = 225
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 10
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 8
    Top = 225
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 9
    OnClick = OKButtonClick
  end
  object Group: TRadioGroup
    Left = 8
    Top = 156
    Width = 129
    Height = 65
    Caption = #1042#1080#1076' '#1085#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1099' '
    TabOrder = 8
  end
  object Is_build: TRadioButton
    Left = 16
    Top = 171
    Width = 113
    Height = 18
    Caption = #1048#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1077
    Checked = True
    TabOrder = 6
    TabStop = True
  end
  object Is_rep: TRadioButton
    Left = 16
    Top = 196
    Width = 113
    Height = 17
    Caption = #1056#1077#1084#1086#1085#1090
    TabOrder = 7
  end
  object CHRTCombo: TComboEdit
    Left = 104
    Top = 63
    Width = 417
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 2
    Tablename = 'SPR_CHRT'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1063#1077#1088#1090#1077#1078#1080' ('#1042#1099#1073#1086#1088')'
    Query = qCHRTQuery
    ID = -1
    CanSelectGroup = False
    OnButtonClick = CHRTComboButtonClick
    OnKeyDown = CHRTComboKeyDown
  end
  object EQPTCombo: TComboEdit
    Left = 104
    Top = 87
    Width = 417
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 3
    Tablename = 'SPR_EQPT'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
    Query = qEQPTQuery
    ID = -1
    CanSelectGroup = False
    OnButtonClick = EQPTComboButtonClick
    OnKeyDown = EQPTComboKeyDown
  end
  object EDIZCombo: TComboEdit
    Left = 128
    Top = 111
    Width = 393
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 4
    Tablename = 'SPR_EDIZ'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
    Query = qEDIZQuery
    ID = -1
    CanSelectGroup = False
    OnButtonClick = EDIZComboButtonClick
    OnKeyDown = EDIZComboKeyDown
  end
  object PlantCombo: TComboEdit
    Left = 128
    Top = 135
    Width = 393
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 5
    Tablename = 'SPR_Plant'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1047#1072#1074#1086#1076#1099' ('#1042#1099#1073#1086#1088')'
    Query = qPlantQuery
    ID = -1
    CanSelectGroup = False
    OnButtonClick = PlantComboButtonClick
    OnKeyDown = PlantComboKeyDown
  end
  object Price: TCurrencyEdit
    Left = 210
    Top = 158
    Width = 98
    Height = 20
    AutoSize = False
    TabOrder = 11
  end
  object PlotEdit: TCurrencyEdit
    Left = 210
    Top = 182
    Width = 98
    Height = 20
    AutoSize = False
    DecimalPlaces = 3
    DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
    TabOrder = 12
  end
  object Min_size: TCurrencyEdit
    Left = 424
    Top = 158
    Width = 98
    Height = 20
    AutoSize = False
    DecimalPlaces = 3
    DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
    TabOrder = 13
  end
  object Max_size: TCurrencyEdit
    Left = 424
    Top = 182
    Width = 98
    Height = 20
    AutoSize = False
    DecimalPlaces = 3
    DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
    TabOrder = 14
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 552
    Top = 8
    ParamData = <
      item
        DataType = ftFloat
        Name = 'CODE'
        ParamType = ptUnknown
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'NAME'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'MAXTIME'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 552
    Top = 40
  end
  object qCHRTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 544
    Top = 72
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
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code')
    Left = 544
    Top = 104
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
  object qEDIZQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_ediz'
      'where id = :id or code = :code')
    Left = 544
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
  object qPlantQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_plant'
      'where id = :id or code = :code')
    Left = 544
    Top = 168
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
