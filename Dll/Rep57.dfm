object Report57Form: TReport57Form
  Left = 634
  Top = 395
  Width = 597
  Height = 301
  Caption = #1054#1090#1095#1105#1090' '#1087#1086' '#1076#1074#1080#1078#1077#1085#1080#1102' '#1079#1072#1082#1072#1079#1086#1074' '#1074' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
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
  object Label5: TLabel
    Left = 52
    Top = 115
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
  object Label2: TLabel
    Left = 40
    Top = 32
    Width = 519
    Height = 29
    Caption = #1054#1090#1095#1105#1090' '#1087#1086' '#1076#1074#1080#1078#1077#1085#1080#1102' '#1079#1072#1082#1072#1079#1086#1074' '#1074' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 56
    Top = 86
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
  object Label1: TLabel
    Left = 48
    Top = 166
    Width = 145
    Height = 24
    Caption = #1041#1077#1079' '#1076#1074#1080#1078#1077#1085#1080#1103' c'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object PdrCombo: TComboEdit
    Left = 201
    Top = 124
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
  object ButtonOK: TButton
    Left = 206
    Top = 207
    Width = 112
    Height = 33
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 3
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 342
    Top = 207
    Width = 113
    Height = 33
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = ButtonNOClick
  end
  object CstCombo: TComboEdit
    Left = 201
    Top = 85
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
  object BegDateEdit: TDateEdit
    Left = 201
    Top = 166
    Width = 160
    Height = 25
    NumGlyphs = 2
    TabOrder = 2
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 488
    Top = 125
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
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.CODE, a.Name'
      'From Spr_Nmnt a, Jr_Plan b, DH_Order c'
      'Where b.period = :period and'
      '      c.id = b.id_order  and'
      '      a.id = c.id_nmnt')
    Left = 80
    Top = 216
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
    Left = 488
    Top = 88
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
