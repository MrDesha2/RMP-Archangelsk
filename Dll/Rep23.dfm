object Report23Form: TReport23Form
  Left = 316
  Top = 191
  Width = 475
  Height = 301
  Caption = #1055#1086#1090#1088#1077#1073#1085#1086#1089#1090#1080' '#1074' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1093
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 112
    Top = 32
    Width = 320
    Height = 29
    Caption = #1055#1086#1090#1088#1077#1073#1085#1086#1089#1090#1100' '#1074' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1093' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 140
    Top = 94
    Width = 24
    Height = 26
    Caption = #1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 32
    Top = 134
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
    Top = 158
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
  object ButtonOK: TButton
    Left = 182
    Top = 207
    Width = 112
    Height = 33
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 318
    Top = 207
    Width = 113
    Height = 33
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = ButtonNOClick
  end
  object CstCombo: TComboEdit
    Left = 161
    Top = 133
    Width = 277
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 25
    NumGlyphs = 1
    TabOrder = 2
    ID = -1
    CanSelectGroup = False
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 161
    Top = 167
    Width = 277
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 25
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    CanSelectGroup = False
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object MonthComboBox: TComboBox
    Left = 185
    Top = 96
    Width = 176
    Height = 24
    ItemHeight = 16
    TabOrder = 4
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.CODE, a.Name'
      'From Spr_Nmnt a, Jr_Plan b, DH_Order c'
      'Where b.period = :period and'
      '      c.id = b.id_order  and'
      '      a.id = c.id_nmnt')
    Left = 64
    Top = 128
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
    Left = 424
    Top = 152
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
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 424
    Top = 208
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
  object ProcQuery: TQuery
    DatabaseName = 'RMP'
    Left = 64
    Top = 168
  end
end
