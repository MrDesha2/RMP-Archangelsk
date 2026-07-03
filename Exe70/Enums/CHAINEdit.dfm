object ENUM_CHAINForm: TENUM_CHAINForm
  Left = 289
  Top = 176
  Width = 449
  Height = 150
  Caption = #1053#1072#1089#1083#1077#1076#1086#1074#1072#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 9
    Top = 35
    Width = 54
    Height = 13
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088':'
  end
  object Label1: TLabel
    Left = 9
    Top = 51
    Width = 86
    Height = 26
    Caption = #1040#1083#1100#1090#1077#1088#1085#1072#1090#1080#1074#1085#1086#1077' '#13#10#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077':'
  end
  object LabelEQPT: TLabel
    Left = 8
    Top = 8
    Width = 3
    Height = 13
  end
  object OK_Button: TButton
    Left = 232
    Top = 88
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = OK_ButtonClick
  end
  object Close_Button: TButton
    Left = 312
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = Close_ButtonClick
  end
  object VCHRCombo: TComboEdit
    Left = 96
    Top = 30
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 0
    Tablename = 'SPR_VCHR'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
    Query = qVCHRQuery
    OnButtonClick = VCHRComboButtonClick
    OnKeyDown = VCHRComboKeyDown
  end
  object EqptCombo: TComboEdit
    Left = 96
    Top = 54
    Width = 329
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 1
    Tablename = 'SPR_EQPT'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
    Query = qEQPTQuery
    OnButtonClick = EqptComboButtonClick
    OnKeyDown = EqptComboKeyDown
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 488
    Top = 8
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    Left = 456
    Top = 8
  end
  object qVCHRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_vchr'
      'where id = :id or code = :code')
    Left = 456
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
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code')
    Left = 486
    Top = 42
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'code'
        ParamType = ptUnknown
      end>
  end
end
