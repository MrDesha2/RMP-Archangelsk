object DOC_EQPT: TDOC_EQPT
  Left = 274
  Top = 203
  Width = 498
  Height = 206
  HelpContext = 221
  Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBot: TPanel
    Left = 0
    Top = 142
    Width = 490
    Height = 37
    Align = alBottom
    TabOrder = 0
    object OKButton: TButton
      Left = 288
      Top = 7
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object CloseButton: TButton
      Left = 368
      Top = 7
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = CloseButtonClick
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 490
    Height = 142
    Align = alClient
    TabOrder = 1
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 62
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
    end
    object Label2: TLabel
      Left = 16
      Top = 40
      Width = 105
      Height = 13
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
    end
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 64
      Height = 13
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090':'
    end
    object EQPTCombo: TComboEdit
      Left = 136
      Top = 8
      Width = 321
      Height = 21
      ClickKey = 16397
      GlyphKind = gkEllipsis
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'SPR_EQPT'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
      Query = qEQPTQuery
      Text = '<Object not found>'
      OnButtonClick = EQPTComboButtonClick
      OnKeyDown = EQPTComboKeyDown
    end
    object EDIZCombo: TComboEdit
      Left = 136
      Top = 32
      Width = 321
      Height = 21
      ClickKey = 16397
      GlyphKind = gkEllipsis
      NumGlyphs = 1
      TabOrder = 1
      Tablename = 'SPR_EDIZ'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
      Query = qEDIZQuery
      Text = '<Object not found>'
      OnButtonClick = EDIZComboButtonClick
      OnKeyDown = EDIZComboKeyDown
    end
    object NUMBER: TCurrencyEdit
      Left = 136
      Top = 56
      Width = 121
      Height = 21
      AutoSize = False
      CheckOnExit = True
      DecimalPlaces = 3
      DisplayFormat = ',0.000;-,0.000'
      FormatOnEditing = True
      TabOrder = 2
    end
  end
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code')
    Left = 432
    Top = 72
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
  object qEDIZQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_ediz'
      'where id = :id or code = :code')
    Left = 432
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
end
