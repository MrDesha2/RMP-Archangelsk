object DOCT_EQPTForm: TDOCT_EQPTForm
  Left = 255
  Top = 167
  HelpContext = 217
  BorderStyle = bsDialog
  Caption = '-'
  ClientHeight = 157
  ClientWidth = 421
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
    Width = 421
    Height = 118
    Align = alClient
    TabOrder = 0
    object Label3: TLabel
      Left = 14
      Top = 27
      Width = 64
      Height = 13
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090':'
    end
    object Label2: TLabel
      Left = 15
      Top = 77
      Width = 62
      Height = 13
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
    end
    object EdizLabel: TLabel
      Left = 14
      Top = 52
      Width = 105
      Height = 13
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
    end
    object EQPTCombo: TComboEdit
      Left = 96
      Top = 24
      Width = 282
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'SPR_EQPT'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
      Query = qEQPTQuery
      ID = 0
      CanSelectGroup = False
      OnButtonClick = EQPTComboButtonClick
      OnChange = EQPTComboChange
      OnKeyDown = EQPTComboKeyDown
    end
    object Number: TCurrencyEdit
      Left = 136
      Top = 70
      Width = 119
      Height = 20
      AutoSize = False
      DecimalPlaces = 3
      DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
      TabOrder = 2
      OnChange = EQPTComboChange
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
      ID = 0
      CanSelectGroup = False
      OnButtonClick = EDIZComboButtonClick
      OnKeyDown = EDIZComboKeyDown
    end
    object NumberEdit: TMaskEdit
      Left = 288
      Top = 73
      Width = 80
      Height = 21
      EditMask = '999999;1; '
      MaxLength = 6
      ReadOnly = True
      TabOrder = 3
      Text = '      '
      Visible = False
    end
  end
  object PanelButton: TPanel
    Left = 0
    Top = 118
    Width = 421
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
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code'
      '')
    Left = 384
    Top = 24
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
    Left = 384
    Top = 48
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
