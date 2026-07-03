object ENUM_MODELBOX: TENUM_MODELBOX
  Left = 192
  Top = 153
  Width = 350
  Height = 303
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1103#1097#1080#1082#1072' '#1084#1086#1076#1077#1083#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    342
    276)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 73
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1103#1097#1080#1082#1072':'
  end
  object Label2: TLabel
    Left = 24
    Top = 40
    Width = 114
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1077#1088#1078#1085#1077#1081':'
  end
  object Label3: TLabel
    Left = 24
    Top = 64
    Width = 36
    Height = 13
    Caption = #1044#1083#1080#1085#1072':'
  end
  object Label4: TLabel
    Left = 24
    Top = 88
    Width = 42
    Height = 13
    Caption = #1064#1080#1088#1080#1085#1072':'
  end
  object Label5: TLabel
    Left = 24
    Top = 115
    Width = 41
    Height = 13
    Caption = #1042#1099#1089#1086#1090#1072':'
  end
  object Label6: TLabel
    Left = 24
    Top = 140
    Width = 96
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1072' '#1089#1083#1086#1078#1085#1086#1089#1090#1080':'
  end
  object Label7: TLabel
    Left = 24
    Top = 165
    Width = 153
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1090#1098#1077#1084#1085#1099#1093' '#1095#1072#1089#1090#1077#1081':'
  end
  object INGLUTINATION: TCheckBox
    Left = 32
    Top = 192
    Width = 97
    Height = 17
    Caption = #1042#1082#1083#1077#1080#1074#1072#1085#1080#1077
    TabOrder = 0
  end
  object CONGLUTINATION: TCheckBox
    Left = 184
    Top = 192
    Width = 97
    Height = 17
    Caption = #1057#1082#1083#1077#1080#1074#1072#1085#1080#1077
    TabOrder = 1
  end
  object ROD_NUMBER: TCurrencyEdit
    Left = 184
    Top = 40
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0'#39#39';-,0'#39#39
    TabOrder = 2
  end
  object LENGHT: TCurrencyEdit
    Left = 184
    Top = 64
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.000'#39#39';-,0.000'#39#39
    TabOrder = 3
  end
  object WIDTH: TCurrencyEdit
    Left = 184
    Top = 88
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.000'#39#39';-,0.000'#39#39
    TabOrder = 4
  end
  object HEIGHT: TCurrencyEdit
    Left = 184
    Top = 115
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0.000'#39#39';-,0.000'#39#39
    TabOrder = 5
  end
  object COMPLEXITY_GROUP: TRxSpinEdit
    Left = 184
    Top = 140
    Width = 121
    Height = 21
    MaxValue = 100.000000000000000000
    TabOrder = 6
  end
  object REMOVEBLEPART_NUMBER: TRxSpinEdit
    Left = 184
    Top = 165
    Width = 121
    Height = 21
    MaxLength = 100
    TabOrder = 7
  end
  object ButtonOK: TButton
    Left = 159
    Top = 229
    Width = 75
    Height = 24
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    TabOrder = 8
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 239
    Top = 229
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 9
    OnClick = ButtonCancelClick
  end
  object BOX_NUMBER: TCurrencyEdit
    Left = 184
    Top = 16
    Width = 121
    Height = 21
    AutoSize = False
    DisplayFormat = ',0'#39#39';-,0'#39#39
    TabOrder = 10
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 576
    Top = 56
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
    Left = 544
    Top = 56
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
end
