object ENUM_VOPForm: TENUM_VOPForm
  Left = 333
  Top = 256
  Width = 452
  Height = 247
  HelpContext = 100
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
    Left = 16
    Top = 16
    Width = 74
    Height = 13
    Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
  end
  object Label2: TLabel
    Left = 16
    Top = 40
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label3: TLabel
    Left = 17
    Top = 66
    Width = 60
    Height = 13
    Caption = #1058#1080#1087' '#1089#1090#1072#1085#1082#1072':'
  end
  object Label4: TLabel
    Left = 17
    Top = 92
    Width = 53
    Height = 13
    Caption = #1052#1042#1047' '#1056#1052#1055':'
  end
  object Code: TEdit
    Left = 105
    Top = 16
    Width = 113
    Height = 21
    MaxLength = 8
    TabOrder = 0
  end
  object _Name: TEdit
    Left = 105
    Top = 40
    Width = 329
    Height = 21
    MaxLength = 35
    TabOrder = 1
  end
  object Close_Buttom: TButton
    Left = 104
    Top = 183
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 6
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 24
    Top = 183
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 5
    OnClick = OKButtonClick
  end
  object TPEQcombo: TComboEdit
    Left = 104
    Top = 64
    Width = 331
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 2
    Tablename = 'SPR_TPEQ'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1058#1080#1087#1099' '#1089#1090#1072#1085#1082#1086#1074' ('#1042#1099#1073#1086#1088')'
    Query = qTPEQQuery
    OnButtonClick = TPEQcomboButtonClick
    OnKeyDown = TPEQcomboKeyDown
  end
  object PDRCombo: TComboEdit
    Left = 104
    Top = 88
    Width = 331
    Height = 21
    HelpContext = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 3
    Tablename = 'spr_pdr'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
    Query = qPDRQuery
    OnButtonClick = PDRComboButtonClick
    OnKeyDown = PDRComboKeyDown
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 112
    Width = 425
    Height = 65
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1086#1087#1077#1088#1072#1094#1080#1080
    TabOrder = 4
    object Label5: TLabel
      Left = 16
      Top = 16
      Width = 49
      Height = 13
      Caption = #1056#1072#1079#1088#1103#1076' 1:'
    end
    object Label6: TLabel
      Left = 16
      Top = 37
      Width = 49
      Height = 13
      Caption = #1056#1072#1079#1088#1103#1076' 2:'
    end
    object Label7: TLabel
      Left = 151
      Top = 16
      Width = 49
      Height = 13
      Caption = #1056#1072#1079#1088#1103#1076' 3:'
    end
    object Label8: TLabel
      Left = 151
      Top = 37
      Width = 49
      Height = 13
      Caption = #1056#1072#1079#1088#1103#1076' 4:'
    end
    object Label9: TLabel
      Left = 281
      Top = 16
      Width = 49
      Height = 13
      Caption = #1056#1072#1079#1088#1103#1076' 5:'
    end
    object Label10: TLabel
      Left = 281
      Top = 37
      Width = 49
      Height = 13
      Caption = #1056#1072#1079#1088#1103#1076' 6:'
    end
    object Rank_1: TCurrencyEdit
      Left = 72
      Top = 13
      Width = 73
      Height = 20
      AutoSize = False
      TabOrder = 0
    end
    object Rank_2: TCurrencyEdit
      Left = 72
      Top = 34
      Width = 73
      Height = 20
      AutoSize = False
      TabOrder = 1
    end
    object Rank_3: TCurrencyEdit
      Left = 199
      Top = 13
      Width = 73
      Height = 20
      AutoSize = False
      TabOrder = 2
    end
    object Rank_4: TCurrencyEdit
      Left = 199
      Top = 34
      Width = 73
      Height = 20
      AutoSize = False
      TabOrder = 3
    end
    object Rank_5: TCurrencyEdit
      Left = 333
      Top = 13
      Width = 73
      Height = 20
      AutoSize = False
      TabOrder = 4
    end
    object Rank_6: TCurrencyEdit
      Left = 333
      Top = 34
      Width = 73
      Height = 20
      AutoSize = False
      TabOrder = 5
    end
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_pdr'
      
        'values (GEN_ID(SPR_PDR_GEN,1), :parentID, :isfolder , :code, :na' +
        'me , :maxtime)')
    Left = 384
    Top = 72
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
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_vop '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime,'
      ', rank_ 1 = :rank_1,rank_ 2 =  :rank_2, rank_ 3 = :rank_3, '
      'rank_ 4 = :rank_4, rank_ 5 = :rank_5, rank_ 6 = :rank_6'
      'where'
      '  ID =  :ID')
    Left = 440
    Top = 16
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
        Name = 'rank_1'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'rank_2'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'rank_3'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'rank_4'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'rank_5'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'rank_6'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qTPEQQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid,  name, code'
      'from spr_tpeq'
      'where id = :id or code = :code')
    Left = 496
    Top = 40
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
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr where id = :id  or code = :code')
    Left = 389
    Top = 16
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
