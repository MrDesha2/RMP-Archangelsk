object ENUM_BRIGADEForm: TENUM_BRIGADEForm
  Left = 172
  Top = 286
  Width = 458
  Height = 185
  HelpContext = 118
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 74
    Height = 13
    Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
  end
  object Label2: TLabel
    Left = 16
    Top = 42
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label3: TLabel
    Left = 17
    Top = 67
    Width = 51
    Height = 13
    Caption = #1041#1088#1080#1075#1072#1076#1080#1088':'
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
    Width = 329
    Height = 21
    MaxLength = 30
    TabOrder = 1
  end
  object Close_Buttom: TButton
    Left = 112
    Top = 113
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 32
    Top = 113
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object WRKRCombo: TComboEdit
    Left = 104
    Top = 62
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 2
    Tablename = 'SPR_WRKR'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1056#1072#1073#1086#1090#1085#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
    Query = qWRKRQuery
    OnButtonClick = WRKRComboButtonClick
    OnKeyDown = WRKRComboKeyDown
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_brigade'
      'set CODE = :code, NAME = :name , id_wrkr = :id_wrkr'
      'where'
      '  ID =  :ID')
    Left = 496
    Top = 64
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
        DataType = ftUnknown
        Name = 'id_wrkr'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qWRKRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrkr'
      'where id = :id or code = :code')
    Left = 512
    Top = 24
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
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 400
    Top = 104
  end
end
