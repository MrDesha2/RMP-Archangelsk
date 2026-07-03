object Report55Form: TReport55Form
  Left = 270
  Top = 245
  Width = 571
  Height = 459
  Caption = #1059#1095#1105#1090' '#1090#1088#1091#1076#1086#1105#1084#1082#1086#1089#1090#1080' '#1085#1077#1087#1083#1072#1085#1086#1074#1099#1093' '#1088#1072#1073#1086#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label4: TLabel
    Left = 32
    Top = 158
    Width = 82
    Height = 24
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 28
    Top = 187
    Width = 143
    Height = 48
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 200
    Top = 40
    Width = 231
    Height = 29
    Caption = #1059#1095#1105#1090' '#1090#1088#1091#1076#1086#1105#1084#1082#1086#1089#1090#1080' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 208
    Top = 72
    Width = 215
    Height = 29
    Caption = #1085#1077#1087#1083#1072#1085#1086#1074#1099#1093' '#1088#1072#1073#1086#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 147
    Top = 120
    Width = 13
    Height = 24
    Caption = 'C'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 302
    Top = 120
    Width = 22
    Height = 24
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object CstCombo: TComboEdit
    Left = 177
    Top = 157
    Width = 277
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 25
    NumGlyphs = 1
    TabOrder = 0
    ID = -1
    CanSelectGroup = False
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 177
    Top = 196
    Width = 277
    Height = 28
    GlyphKind = gkEllipsis
    ButtonWidth = 25
    NumGlyphs = 1
    TabOrder = 1
    ID = -1
    CanSelectGroup = False
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object BegDateEdit: TDateEdit
    Left = 174
    Top = 118
    Width = 118
    Height = 25
    NumGlyphs = 2
    TabOrder = 2
  end
  object EndDateEdit: TDateEdit
    Left = 333
    Top = 118
    Width = 119
    Height = 25
    NumGlyphs = 2
    TabOrder = 3
  end
  object ButtonSelPer: TButton
    Left = 454
    Top = 118
    Width = 30
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonSelPerClick
  end
  object ButtonOK: TButton
    Left = 190
    Top = 311
    Width = 112
    Height = 33
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 5
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 326
    Top = 311
    Width = 113
    Height = 33
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = ButtonNOClick
  end
  object RadioGroup1: TRadioGroup
    Left = 176
    Top = 240
    Width = 273
    Height = 57
    Caption = #1058#1080#1087' '#1086#1090#1095#1105#1090#1072
    TabOrder = 7
  end
  object CompactRadioButton: TRadioButton
    Left = 184
    Top = 264
    Width = 89
    Height = 17
    Caption = #1057#1078#1072#1090#1099#1081
    Checked = True
    TabOrder = 8
    TabStop = True
  end
  object FullRadioButton: TRadioButton
    Left = 288
    Top = 264
    Width = 113
    Height = 17
    Caption = #1056#1072#1079#1074#1105#1088#1085#1091#1090#1099#1081
    TabOrder = 9
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.CODE, a.Name'
      'From Spr_Nmnt a, Jr_Plan b, DH_Order c'
      'Where b.period = :period and'
      '      c.id = b.id_order  and'
      '      a.id = c.id_nmnt')
    Left = 56
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'period'
        ParamType = ptUnknown
      end>
  end
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code'
      '')
    Left = 464
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
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 464
    Top = 197
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
