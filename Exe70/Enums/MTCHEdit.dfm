object ENUM_MTCHForm: TENUM_MTCHForm
  Left = 266
  Top = 230
  Width = 472
  Height = 273
  HelpContext = 100
  Caption = #1052#1072#1090#1077#1088#1080#1072#1083' '#1086#1087#1077#1088#1072#1094#1080#1080' '#1095#1077#1088#1090#1077#1078#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 14
    Top = 11
    Width = 53
    Height = 13
    Caption = #1052#1072#1090#1077#1088#1080#1072#1083':'
  end
  object Label1: TLabel
    Left = 13
    Top = 37
    Width = 62
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
  end
  object Label5: TLabel
    Left = 13
    Top = 79
    Width = 58
    Height = 13
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100':'
  end
  object Label2: TLabel
    Left = 11
    Top = 57
    Width = 105
    Height = 13
    Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
  end
  object Label9: TLabel
    Left = 31
    Top = 103
    Width = 77
    Height = 13
    Caption = #1042#1080#1076' '#1079#1072#1075#1086#1090#1086#1074#1082#1080':'
  end
  object Close_Buttom: TButton
    Left = 94
    Top = 198
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 8
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 14
    Top = 198
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 7
    OnClick = OKButtonClick
  end
  object NMNTCombo: TComboEdit
    Left = 128
    Top = 10
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 0
    Tablename = 'SPR_NMNT'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' ('#1042#1099#1073#1086#1088')'
    Query = qNMNTQuery
    OnButtonClick = NMNTComboButtonClick
    OnKeyDown = NMNTComboKeyDown
  end
  object EDIZCombo: TComboEdit
    Left = 128
    Top = 54
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 2
    Tablename = 'SPR_EDIZ'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
    Query = qEDIZQuery
    OnButtonClick = EDIZComboButtonClick
    OnKeyDown = EDIZComboKeyDown
  end
  object GroupBox1: TGroupBox
    Left = 12
    Top = 120
    Width = 421
    Height = 76
    Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
    TabOrder = 6
    object Label4: TLabel
      Left = 13
      Top = 19
      Width = 36
      Height = 13
      Caption = #1044#1083#1080#1085#1072':'
    end
    object Label6: TLabel
      Left = 13
      Top = 41
      Width = 42
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072':'
    end
    object Label7: TLabel
      Left = 247
      Top = 22
      Width = 41
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072':'
    end
    object Label8: TLabel
      Left = 248
      Top = 41
      Width = 22
      Height = 13
      Caption = #1042#1077#1089':'
    end
    object WeiEdit: TCurrencyEdit
      Left = 302
      Top = 38
      Width = 98
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000;-,0.000'
      TabOrder = 0
    end
    object HigEdit: TCurrencyEdit
      Left = 302
      Top = 14
      Width = 98
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000;-,0.000'
      TabOrder = 1
    end
    object WidEdit: TCurrencyEdit
      Left = 70
      Top = 38
      Width = 98
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000;-,0.000'
      TabOrder = 2
    end
    object LenEdit: TCurrencyEdit
      Left = 70
      Top = 14
      Width = 98
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000;-,0.000'
      TabOrder = 3
    end
  end
  object PriceEdit: TCurrencyEdit
    Left = 128
    Top = 76
    Width = 120
    Height = 20
    AutoSize = False
    TabOrder = 3
  end
  object STRGCombo: TComboEdit
    Left = 128
    Top = 98
    Width = 329
    Height = 21
    Hint = #1052#1086#1076#1077#1083#1080
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Tablename = 'SPR_STRG'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1079#1072#1075#1086#1090#1086#1074#1086#1082' ('#1042#1099#1073#1086#1088')'
    Query = qSTRGQuery
    OnButtonClick = STRGComboButtonClick
    OnKeyDown = STRGComboKeyDown
  end
  object ButtonRecalc: TButton
    Left = 248
    Top = 76
    Width = 88
    Height = 21
    Caption = #1055#1077#1088#1077#1089#1095#1077#1090
    TabOrder = 4
    OnClick = ButtonRecalcClick
  end
  object NumberEdit: TCurrencyEdit
    Left = 128
    Top = 32
    Width = 120
    Height = 20
    AutoSize = False
    DecimalPlaces = 3
    DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
    TabOrder = 1
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      '       HIGHT = :HIGHT, LENGHT = :LENGHT,'
      '       WIDTH = :WIDTH, WEIGHT = :WEIGHT '
      'where'
      '  ID =  :ID')
    Left = 504
    Top = 104
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
        DataType = ftUnknown
        Name = 'HIGHT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'LENGHT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WIDTH'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WEIGHT'
        ParamType = ptUnknown
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
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_pdr'
      
        'values (GEN_ID(SPR_PDR_GEN,1), :parentID, :isfolder , :code, :na' +
        'me , :maxtime)')
    Left = 504
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'parentID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'isfolder'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'Code'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftString
        Name = 'Name'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'MaxTime'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name , code, id_ediz'
      'from spr_nmnt'
      'where id = :id or code = :code')
    Left = 464
    Top = 8
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
      'select id,name, code'
      'from spr_ediz'
      'where id = :id or code = :code'
      '')
    Left = 464
    Top = 48
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
  object qSTRGQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_strg'
      'where id = :id  or code = :code')
    Left = 468
    Top = 96
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
