object ENUM_MVZForm: TENUM_MVZForm
  Left = 350
  Top = 308
  Width = 512
  Height = 217
  HelpContext = 115
  Caption = #1069#1083#1077#1084#1077#1085#1090':'
  Color = clBtnFace
  DefaultMonitor = dmDesktop
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
    Left = 16
    Top = 64
    Width = 180
    Height = 13
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103':'
  end
  object Label4: TLabel
    Left = 16
    Top = 92
    Width = 48
    Height = 13
    Caption = #1042#1080#1076' '#1052#1042#1047':'
  end
  object Label5: TLabel
    Left = 16
    Top = 116
    Width = 61
    Height = 13
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072':'
  end
  object Code: TEdit
    Left = 105
    Top = 16
    Width = 113
    Height = 21
    MaxLength = 10
    TabOrder = 0
  end
  object _Name: TEdit
    Left = 104
    Top = 40
    Width = 329
    Height = 21
    MaxLength = 40
    TabOrder = 1
  end
  object MaxTime: TEdit
    Left = 200
    Top = 64
    Width = 89
    Height = 21
    TabOrder = 2
  end
  object Close_Buttom: TButton
    Left = 96
    Top = 152
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 6
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 16
    Top = 152
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 5
    OnClick = OKButtonClick
  end
  object VIDPDR: TComboEdit
    Left = 104
    Top = 88
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 3
    Tablename = 'spr_vidpdr'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
    Query = qVIDPDRQuery
    OnButtonClick = VIDPDRButtonClick
    OnKeyDown = VIDPDRKeyDown
  end
  object ID_Stat: TComboEdit
    Left = 104
    Top = 112
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 4
    Tablename = 'spr_stat'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
    Query = qStatQuery
    OnButtonClick = ID_StatButtonClick
    OnKeyDown = ID_StatKeyDown
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_pdr'
      
        'values (GEN_ID(SPR_PDR_GEN,1), :parentID, :isfolder , :code, :na' +
        'me , :maxtime)')
    Left = 384
    Top = 112
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
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 416
    Top = 112
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
        ParamType = ptInput
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
  object qVIDPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_vidpdr'
      'where id = :id or code =:code')
    Left = 448
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
  object qStatQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_stat'
      'where id = :id or code =:code')
    Left = 448
    Top = 144
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
