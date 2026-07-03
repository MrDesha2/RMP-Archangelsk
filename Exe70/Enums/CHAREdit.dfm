object ENUM_CHEQForm: TENUM_CHEQForm
  Left = 223
  Top = 197
  Width = 483
  Height = 172
  HelpContext = 100
  ActiveControl = OK_Buttom
  BorderIcons = [biSystemMenu]
  Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1072' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 106
    Height = 13
    Caption = #1042#1080#1076' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080':'
  end
  object Label2: TLabel
    Left = 16
    Top = 51
    Width = 42
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1088':'
  end
  object Label3: TLabel
    Left = 16
    Top = 76
    Width = 86
    Height = 13
    Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1072':'
  end
  object Close_Buttom: TButton
    Left = 96
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = Close_ButtomClick
  end
  object OK_Buttom: TButton
    Left = 16
    Top = 104
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = OK_ButtomClick
  end
  object NSizeEdit: TRxCalcEdit
    Left = 128
    Top = 48
    Width = 121
    Height = 21
    Alignment = taLeftJustify
    AutoSize = False
    NumGlyphs = 2
    TabOrder = 0
  end
  object KindEdit: TEdit
    Left = 128
    Top = 72
    Width = 121
    Height = 21
    MaxLength = 10
    TabOrder = 1
  end
  object VIDCombo: TComboEdit
    Left = 128
    Top = 21
    Width = 329
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 4
    Tablename = 'SPR_VCHR'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
    Query = qVIDQuery
    ID = 0
    OnButtonClick = VIDComboButtonClick
    OnKeyDown = VIDComboKeyDown
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 424
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
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_pdr'
      
        'values (GEN_ID(SPR_PDR_GEN,1), :parentID, :isfolder , :code, :na' +
        'me , :maxtime)')
    Left = 392
    Top = 64
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
  object qVIDQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_vchr'
      'where id = :id  or code = :code')
    Left = 416
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
  object qCheckQuery: TQuery
    DatabaseName = 'RMP'
    Left = 384
    Top = 104
  end
end
