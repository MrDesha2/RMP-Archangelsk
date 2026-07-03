object ENUM_TPEQ: TENUM_TPEQ
  Left = 192
  Top = 116
  Width = 554
  Height = 198
  HelpContext = 100
  Caption = #1058#1080#1087#1099' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 16
    Top = 16
    Width = 74
    Height = 13
    Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
  end
  object Label3: TLabel
    Left = 16
    Top = 40
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label1: TLabel
    Left = 17
    Top = 66
    Width = 101
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103':'
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
    MaxLength = 40
    TabOrder = 1
  end
  object Close_Buttom: TButton
    Left = 96
    Top = 91
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 16
    Top = 91
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object NTimeEdit: TMaskEdit
    Left = 130
    Top = 62
    Width = 98
    Height = 21
    EditMask = '9999;1; '
    MaxLength = 4
    TabOrder = 2
    Text = '    '
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_tpeq'
      
        'values (GEN_ID(SPR_tpeq_GEN,1), :parentID, :isfolder , :code, :n' +
        'ame , :ntime)')
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
        DataType = ftUnknown
        Name = 'ntime'
        ParamType = ptUnknown
      end>
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_tpeq '
      'set CODE = :code, NAME = :name , NTIME = :ntime'
      'where'
      '  ID =  :ID')
    Left = 416
    Top = 72
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
        Name = 'ntime'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
end
