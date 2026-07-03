object ENUM_VCHRForm: TENUM_VCHRForm
  Left = 202
  Top = 130
  Width = 354
  Height = 141
  HelpContext = 100
  Caption = #1069#1083#1077#1084#1077#1085#1090
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
    Left = 5
    Top = 8
    Width = 74
    Height = 13
    Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
  end
  object Label2: TLabel
    Left = 5
    Top = 31
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label3: TLabel
    Left = 5
    Top = 55
    Width = 105
    Height = 13
    Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
  end
  object Code: TEdit
    Left = 97
    Top = 5
    Width = 113
    Height = 21
    MaxLength = 6
    TabOrder = 0
  end
  object _Name: TEdit
    Left = 97
    Top = 28
    Width = 242
    Height = 21
    MaxLength = 15
    TabOrder = 1
  end
  object Close_Buttom: TButton
    Left = 112
    Top = 80
    Width = 75
    Height = 26
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 32
    Top = 80
    Width = 75
    Height = 26
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object EDIZCombo: TComboEdit
    Left = 123
    Top = 52
    Width = 216
    Height = 20
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 2
    Tablename = 'SPR_EDIZ'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
    Query = qEDIZQuery
    OnButtonClick = EDIZComboButtonClick
    OnKeyDown = EDIZComboKeyDown
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 472
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
    Left = 400
    Top = 88
  end
  object qEDIZQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_EDIZ'
      'where id = :id or code = :code')
    Left = 400
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
end
