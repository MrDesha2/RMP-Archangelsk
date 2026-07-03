object ENUM_PLANENUMRELForm: TENUM_PLANENUMRELForm
  Left = 223
  Top = 197
  Width = 483
  Height = 172
  HelpContext = 100
  ActiveControl = OK_Buttom
  BorderIcons = [biSystemMenu]
  Caption = #1055#1083#1072#1085#1086#1074#1099#1077' '#1076#1072#1085#1085#1099#1077'. '#1057#1074#1103#1079#1100' '#1101#1083#1077#1084#1077#1085#1090#1086#1074
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
  object LabelPlan: TLabel
    Left = 16
    Top = 48
    Width = 106
    Height = 13
    Caption = #1042#1080#1076' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080':'
  end
  object Enum_label: TLabel
    Left = 16
    Top = 16
    Width = 112
    Height = 13
    Caption = #1069#1083#1077#1084#1077#1085#1090' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
  end
  object Close_Buttom: TButton
    Left = 96
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 1
    OnClick = Close_ButtomClick
  end
  object OK_Buttom: TButton
    Left = 16
    Top = 104
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 0
    OnClick = OK_ButtomClick
  end
  object VIDCombo: tMyComboEdit
    Left = 128
    Top = 45
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 2
    OnButtonClick = VIDComboButtonClick
    OnKeyDown = VIDComboKeyDown
  end
  object qVIDQuery: TQuery
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
  object MainStorProc: TStoredProc
    DatabaseName = 'RMP'
    Left = 424
    Top = 96
  end
end
