object DOCT_MTRForm: TDOCT_MTRForm
  Left = 255
  Top = 167
  HelpContext = 217
  BorderStyle = bsDialog
  Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 236
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 401
    Height = 197
    Align = alClient
    TabOrder = 0
    object Label3: TLabel
      Left = 6
      Top = 27
      Width = 80
      Height = 13
      Caption = #1042#1080#1076' '#1084#1072#1090#1077#1088#1080#1072#1083#1072':'
    end
    object Label2: TLabel
      Left = 6
      Top = 102
      Width = 62
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
    end
    object Label5: TLabel
      Left = 6
      Top = 121
      Width = 37
      Height = 13
      Caption = #1057#1091#1084#1084#1072':'
    end
    object Label6: TLabel
      Left = 8
      Top = 163
      Width = 42
      Height = 13
      Caption = #1064#1080#1088#1080#1085#1072':'
    end
    object Label7: TLabel
      Left = 165
      Top = 143
      Width = 41
      Height = 13
      Caption = #1042#1099#1089#1086#1090#1072':'
    end
    object Label9: TLabel
      Left = 166
      Top = 164
      Width = 22
      Height = 13
      Caption = #1042#1077#1089':'
    end
    object Label4: TLabel
      Left = 8
      Top = 143
      Width = 36
      Height = 13
      Caption = #1044#1083#1080#1085#1072':'
    end
    object EdizLabel: TLabel
      Left = 8
      Top = 48
      Width = 105
      Height = 13
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
    end
    object Label1: TLabel
      Left = 8
      Top = 72
      Width = 77
      Height = 13
      Caption = #1042#1080#1076' '#1079#1072#1075#1086#1090#1086#1074#1082#1080':'
    end
    object NumberEdit: TMaskEdit
      Left = 312
      Top = 142
      Width = 80
      Height = 21
      EditMask = '999999;1; '
      MaxLength = 6
      ReadOnly = True
      TabOrder = 3
      Text = '      '
      Visible = False
      OnChange = NMNTComboChange
    end
    object PriceEdit: TCurrencyEdit
      Left = 96
      Top = 118
      Width = 119
      Height = 20
      AutoSize = False
      TabOrder = 5
      OnChange = NMNTComboChange
    end
    object NMNTCombo: TComboEdit
      Left = 96
      Top = 24
      Width = 282
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
      OnButtonClick = NMNTComboButtonClick
      OnChange = NMNTComboChange
      OnKeyDown = NMNTComboKeyDown
    end
    object WeiEdit: TCurrencyEdit
      Left = 212
      Top = 164
      Width = 89
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000;-,0.000'
      TabOrder = 10
    end
    object RecalcButton: TButton
      Left = 214
      Top = 118
      Width = 96
      Height = 20
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100
      TabOrder = 6
      OnClick = RecalcButtonClick
    end
    object Number: TCurrencyEdit
      Left = 96
      Top = 94
      Width = 119
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
      TabOrder = 11
      OnChange = NMNTComboChange
    end
    object LenEdit: TCurrencyEdit
      Left = 63
      Top = 142
      Width = 89
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
      TabOrder = 7
      OnChange = NMNTComboChange
    end
    object WidEdit: TCurrencyEdit
      Left = 63
      Top = 163
      Width = 89
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
      TabOrder = 8
      OnChange = NMNTComboChange
    end
    object HigEdit: TCurrencyEdit
      Left = 212
      Top = 140
      Width = 89
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
      TabOrder = 9
      OnChange = NMNTComboChange
    end
    object EDIZCombo: TComboEdit
      Left = 136
      Top = 47
      Width = 242
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
      OnButtonClick = EDIZComboButtonClick
      OnKeyDown = EDIZComboKeyDown
    end
    object STRGCombo: TComboEdit
      Left = 136
      Top = 71
      Width = 242
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 2
      Tablename = 'SPR_STRG'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1079#1072#1075#1086#1090#1086#1074#1086#1082' ('#1042#1099#1073#1086#1088')'
      Query = qSTRGQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = STRGComboButtonClick
      OnKeyDown = STRGComboKeyDown
    end
    object CalcButton: TButton
      Left = 214
      Top = 94
      Width = 96
      Height = 20
      Caption = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100
      TabOrder = 4
    end
  end
  object PanelButton: TPanel
    Left = 0
    Top = 197
    Width = 401
    Height = 39
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 88
      Top = 7
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = CloseButtonClick
    end
    object OKButton: TButton
      Left = 8
      Top = 7
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = OKButtonClick
    end
  end
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_nmnt'
      'where id = :id or code = :code'
      '')
    Left = 600
    Top = 32
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
      'select id,  name, code'
      'from spr_ediz'
      'where id = :id or code = :code'
      '')
    Left = 568
    Top = 32
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
  object qSTRGQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id,  name, code'
      'from spr_strg'
      'where id = :id or code = :code'
      '')
    Left = 568
    Top = 64
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
