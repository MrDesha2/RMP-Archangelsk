object DOC_NMNT: TDOC_NMNT
  Left = 274
  Top = 203
  Width = 473
  Height = 334
  HelpContext = 221
  Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
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
    Top = 263
    Width = 465
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
  object PanelChrt: TPanel
    Left = 0
    Top = 199
    Width = 465
    Height = 64
    Align = alBottom
    TabOrder = 1
    object GroupBox: TGroupBox
      Left = 1
      Top = 1
      Width = 463
      Height = 62
      Align = alClient
      Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
      TabOrder = 0
      object Label9: TLabel
        Left = 171
        Top = 37
        Width = 22
        Height = 13
        Caption = #1042#1077#1089':'
      end
      object Label7: TLabel
        Left = 162
        Top = 16
        Width = 41
        Height = 13
        Caption = #1042#1099#1089#1086#1090#1072':'
      end
      object Label6: TLabel
        Left = 5
        Top = 16
        Width = 36
        Height = 13
        Caption = #1044#1083#1080#1085#1072':'
      end
      object Label8: TLabel
        Left = 5
        Top = 37
        Width = 42
        Height = 13
        Caption = #1064#1080#1088#1080#1085#1072':'
      end
      object WeiEdit: TCurrencyEdit
        Left = 217
        Top = 34
        Width = 89
        Height = 20
        AutoSize = False
        DecimalPlaces = 3
        DisplayFormat = ',0.000;-,0.000'
        TabOrder = 3
      end
      object HigEdit: TCurrencyEdit
        Left = 217
        Top = 11
        Width = 89
        Height = 20
        AutoSize = False
        DecimalPlaces = 3
        DisplayFormat = ',0.000;-,0.000'
        TabOrder = 2
      end
      object LenEdit: TCurrencyEdit
        Left = 60
        Top = 11
        Width = 89
        Height = 20
        AutoSize = False
        DecimalPlaces = 3
        DisplayFormat = ',0.000;-,0.000'
        TabOrder = 0
      end
      object WidEdit: TCurrencyEdit
        Left = 60
        Top = 34
        Width = 89
        Height = 20
        AutoSize = False
        DecimalPlaces = 3
        DisplayFormat = ',0.000;-,0.000'
        TabOrder = 1
      end
    end
  end
  object PanelOrd: TPanel
    Left = 0
    Top = 135
    Width = 465
    Height = 64
    Align = alBottom
    TabOrder = 2
    object LabelOrder: TLabel
      Left = 8
      Top = 6
      Width = 309
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079' ('#1087#1088#1086#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1090#1086#1083#1100#1082#1086' '#1087#1088#1080' '#1087#1086#1079#1072#1082#1072#1079#1085#1086#1084' '#1091#1095#1077#1090#1077'):'
    end
    object LabelPDR: TLabel
      Left = 8
      Top = 24
      Width = 129
      Height = 26
      Caption = #1052#1042#1047' ('#1087#1088#1086#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1087#1088#1080' '#1087#1086#1079#1072#1082#1072#1079#1085#1086#1084' '#1091#1095#1077#1090#1077'):'
      WordWrap = True
    end
    object NumDoc: TComboEdit
      Left = 324
      Top = 4
      Width = 103
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 0
      ID = -1
      CanSelectGroup = False
      OnButtonClick = NumDocButtonClick
      OnExit = NumDocExit
    end
    object PDRCombo: TComboEdit
      Left = 160
      Top = 27
      Width = 267
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 1
      Tablename = 'spr_pdr'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
      Query = qPDRQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = PDRComboButtonClick
      OnKeyDown = PDRComboKeyDown
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 465
    Height = 135
    Align = alClient
    TabOrder = 3
    object Label5: TLabel
      Left = 16
      Top = 112
      Width = 58
      Height = 13
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100':'
    end
    object Label4: TLabel
      Left = 16
      Top = 88
      Width = 29
      Height = 13
      Caption = #1062#1077#1085#1072':'
    end
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
      Width = 77
      Height = 13
      Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
    end
    object NMNTCombo: TComboEdit
      Left = 136
      Top = 8
      Width = 321
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'SPR_NMNT'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' ('#1042#1099#1073#1086#1088')'
      Query = qNMNTQuery
      ID = -1
      CanSelectGroup = False
      Text = '<Object not found>'
      OnButtonClick = NMNTComboButtonClick
      OnKeyDown = NMNTComboKeyDown
    end
    object EDIZCombo: TComboEdit
      Left = 136
      Top = 32
      Width = 321
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 1
      Tablename = 'SPR_EDIZ'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
      Query = qEDIZQuery
      ID = -1
      CanSelectGroup = False
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
    object PRICE: TCurrencyEdit
      Left = 136
      Top = 80
      Width = 121
      Height = 21
      AutoSize = False
      TabOrder = 3
      OnChange = OnChange
    end
    object NSUM: TCurrencyEdit
      Left = 136
      Top = 104
      Width = 121
      Height = 21
      AutoSize = False
      TabOrder = 4
    end
    object RecalcButton: TButton
      Left = 256
      Top = 104
      Width = 75
      Height = 21
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100
      TabOrder = 5
      OnClick = RecalcButtonClick
    end
  end
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_nmnt'
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
  object qORDERQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, number'
      'from dh_order'
      'where id = :id or number = :number')
    Left = 432
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'number'
        ParamType = ptUnknown
      end>
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 431
    Top = 168
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
