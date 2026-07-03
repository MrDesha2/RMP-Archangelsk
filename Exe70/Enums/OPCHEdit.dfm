object ENUM_OPCHForm: TENUM_OPCHForm
  Left = 220
  Top = 181
  Width = 467
  Height = 180
  HelpContext = 100
  Caption = #1054#1087#1077#1088#1072#1094#1080#1103' '#1095#1077#1088#1090#1077#1078#1072
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
  object Label3: TLabel
    Left = 18
    Top = 7
    Width = 73
    Height = 13
    Caption = #1042#1080#1076' '#1086#1087#1077#1088#1072#1094#1080#1080':'
  end
  object Label1: TLabel
    Left = 194
    Top = 127
    Width = 98
    Height = 13
    Caption = #1055#1086#1088#1103#1076#1086#1082' '#1086#1087#1077#1088#1072#1094#1080#1080':'
    Visible = False
  end
  object Label2: TLabel
    Left = 18
    Top = 36
    Width = 130
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' / '#1074#1077#1089':'
  end
  object Label4: TLabel
    Left = 18
    Top = 56
    Width = 89
    Height = 13
    Caption = #1056#1072#1079#1088#1103#1076' '#1088#1072#1073#1086#1095#1077#1075#1086':'
  end
  object Label5: TLabel
    Left = 18
    Top = 78
    Width = 58
    Height = 13
    Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100':'
  end
  object Close_Buttom: TButton
    Left = 104
    Top = 117
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 6
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 24
    Top = 117
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 5
    OnClick = OKButtonClick
  end
  object NumberEdit: TEdit
    Left = 336
    Top = 123
    Width = 120
    Height = 21
    TabOrder = 1
    Text = '_Number'
    Visible = False
  end
  object RatingEdit: TRxSpinEdit
    Left = 160
    Top = 54
    Width = 121
    Height = 23
    MaxValue = 7.000000000000000000
    MaxLength = 20
    TabOrder = 3
  end
  object VOPCombo: TComboEdit
    Left = 128
    Top = 5
    Width = 328
    Height = 20
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 0
    Tablename = 'SPR_VOP'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1086#1087#1077#1088#1072#1094#1080#1081' ('#1042#1099#1073#1086#1088')'
    Query = qVOPQuery
    OnButtonClick = VOPComboButtonClick
    OnKeyDown = VOPComboKeyDown
  end
  object PriceEdit: TCurrencyEdit
    Left = 160
    Top = 77
    Width = 120
    Height = 20
    AutoSize = False
    TabOrder = 4
  end
  object NTimeEdit: TCurrencyEdit
    Left = 160
    Top = 33
    Width = 120
    Height = 20
    Hint = 
      #1044#1083#1103' '#1086#1087#1077#1088#1072#1094#1080#1081' '#1080#1079#1075#1086#1090#1086#1083#1074#1077#1085#1080#1103' '#1080' '#1088#1077#1084#1086#1085#1090#1072#13#10#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103' '#1087#1088#1086#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' ' +
      #1074#1088#1077#1084#1103#13#10#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1080'. '#1044#1083#1103' '#1083#1080#1090#1077#1081#1085#1086#1075#1086#13#10#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072' '#1087#1088#1086#1089#1090 +
      #1072#1074#1083#1103#1077#1090#1089#1103' '#1074#1077#1089#13#10#1074#1099#1087#1083#1072#1074#1083#1103#1077#1084#1099#1093' '#1084#1086#1076#1077#1083#1077#1081'.'
    AutoSize = False
    DecimalPlaces = 3
    DisplayFormat = ',0.000'#39'.'#39';-,0.00'#39'.'#39
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 584
    Top = 48
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
    Left = 552
    Top = 48
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
  object qVOPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_vop'
      'where id = :id or code = :code')
    Left = 576
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
end
