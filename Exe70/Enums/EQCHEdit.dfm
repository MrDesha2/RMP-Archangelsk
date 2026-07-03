object ENUM_EQCHForm: TENUM_EQCHForm
  Left = 266
  Top = 230
  Width = 506
  Height = 162
  HelpContext = 100
  Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090' '#1086#1087#1077#1088#1072#1094#1080#1080' '#1095#1077#1088#1090#1077#1078#1072
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
    Width = 64
    Height = 13
    Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090':'
  end
  object Label1: TLabel
    Left = 14
    Top = 35
    Width = 62
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
  end
  object Label2: TLabel
    Left = 14
    Top = 57
    Width = 105
    Height = 13
    Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
  end
  object Close_Buttom: TButton
    Left = 102
    Top = 102
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 22
    Top = 102
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object EQPTCombo: TComboEdit
    Left = 128
    Top = 10
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 0
    Tablename = 'SPR_EQPT'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
    Query = qEQPTQuery
    OnButtonClick = EQPTComboButtonClick
    OnKeyDown = EQPTComboKeyDown
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
    Left = 272
    Top = 88
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
    Left = 304
    Top = 88
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
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name , code, id_ediz'
      'from spr_eqpt'
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
end
