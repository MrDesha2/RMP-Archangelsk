object Report61Form: TReport61Form
  Left = 320
  Top = 308
  Width = 585
  Height = 362
  Caption = 'Report61Form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 74
    Top = 23
    Width = 451
    Height = 20
    Caption = #1053#1077#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099' '#1079#1072#1087#1091#1097#1077#1085#1085#1099#1077' '#1074' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 39
    Top = 100
    Width = 110
    Height = 16
    Caption = #1055#1088#1080#1079#1085#1072#1082' '#1079#1072#1082#1072#1079#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 89
    Top = 125
    Width = 52
    Height = 16
    Caption = #1063#1077#1088#1090#1077#1078':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 82
    Top = 149
    Width = 66
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 89
    Top = 173
    Width = 57
    Height = 16
    Caption = #1059#1095#1072#1089#1090#1086#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 161
    Top = 197
    Width = 64
    Height = 16
    Caption = #8470' '#1047#1072#1103#1074#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 274
    Top = 197
    Width = 65
    Height = 16
    Caption = #8470' '#1047#1072#1082#1072#1079#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 269
    Top = 216
    Width = 4
    Height = 16
    Caption = '/'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 139
    Top = 64
    Width = 9
    Height = 16
    Caption = 'C'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 286
    Top = 64
    Width = 16
    Height = 16
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object FeatComboBox: TComboBox
    Left = 160
    Top = 99
    Width = 176
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 0
    Text = #1041#1077#1079' '#1087#1088#1080#1079#1085#1072#1082#1072
    Items.Strings = (
      #1041#1077#1079' '#1087#1088#1080#1079#1085#1072#1082#1072
      #1055#1083#1072#1085#1086#1074#1099#1077
      #1043#1086#1076#1086#1074#1099#1077
      #1042#1085#1077#1087#1083#1072#1085#1086#1074#1099#1077)
  end
  object ChrtCombo: TComboEdit
    Left = 160
    Top = 121
    Width = 263
    Height = 20
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 1
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = ChrtComboButtonClick
    OnKeyDown = ChrtComboKeyDown
  end
  object CstCombo: TComboEdit
    Left = 160
    Top = 144
    Width = 263
    Height = 22
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 2
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 160
    Top = 169
    Width = 263
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object RqstEdit: TEdit
    Left = 161
    Top = 216
    Width = 104
    Height = 21
    TabOrder = 4
  end
  object OrderEdit: TEdit
    Left = 278
    Top = 216
    Width = 104
    Height = 21
    TabOrder = 5
  end
  object BegDateEdit: TDateEdit
    Left = 161
    Top = 63
    Width = 121
    Height = 20
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 6
  end
  object EndDateEdit: TDateEdit
    Left = 305
    Top = 63
    Width = 121
    Height = 20
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 7
  end
  object ButtonSelPer: TButton
    Left = 431
    Top = 61
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 8
    OnClick = ButtonSelPerClick
  end
  object OKButton: TButton
    Left = 195
    Top = 258
    Width = 76
    Height = 25
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 9
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 280
    Top = 258
    Width = 74
    Height = 25
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 10
    OnClick = CancelButtonClick
  end
  object qChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 508
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
  object qCSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 508
    Top = 132
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
  object qPdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 508
    Top = 160
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
  object Query: TQuery
    DatabaseName = 'RMP'
    Left = 493
    Top = 48
  end
end
