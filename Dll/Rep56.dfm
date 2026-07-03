object Report56Form: TReport56Form
  Left = 602
  Top = 325
  Width = 607
  Height = 467
  Caption = 
    #1054#1090#1095#1105#1090' '#1087#1086' '#1090#1088#1091#1076#1086#1105#1084#1082#1086#1089#1090#1080' '#1088#1072#1073#1086#1090', '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1062#1052#1054', '#1076#1083#1103' '#1089#1084#1077#1078#1085#1099#1093' '#1091#1095#1072#1089#1090#1082 +
    #1086#1074
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
    Left = 56
    Top = 48
    Width = 520
    Height = 29
    Caption = #1054#1090#1095#1105#1090' '#1087#1086' '#1090#1088#1091#1076#1086#1105#1084#1082#1086#1089#1090#1080' '#1088#1072#1073#1086#1090', '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 120
    Top = 80
    Width = 388
    Height = 29
    Caption = #1062#1052#1054', '#1076#1083#1103' '#1089#1084#1077#1078#1085#1099#1093' '#1091#1095#1072#1089#1090#1082#1086#1074' '#1056#1052#1055
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
  object Label7: TLabel
    Left = 28
    Top = 237
    Width = 139
    Height = 24
    Caption = #1055#1088#1080#1079#1085#1072#1082' '#1079#1072#1082#1072#1079#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label8: TLabel
    Left = 28
    Top = 269
    Width = 58
    Height = 24
    Caption = #1054#1090#1073#1086#1088
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object CstCombo: TComboEdit
    Left = 177
    Top = 157
    Width = 277
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 25
    NumGlyphs = 1
    TabOrder = 3
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
    TabOrder = 4
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
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 333
    Top = 118
    Width = 119
    Height = 25
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonSelPer: TButton
    Left = 454
    Top = 118
    Width = 30
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelPerClick
  end
  object ButtonOK: TButton
    Left = 190
    Top = 375
    Width = 112
    Height = 33
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 10
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 326
    Top = 375
    Width = 113
    Height = 33
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 11
    OnClick = ButtonNOClick
  end
  object ComboBoxFlag: TComboBox
    Left = 176
    Top = 240
    Width = 277
    Height = 24
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 5
    Text = #1042#1089#1077
    Items.Strings = (
      #1042#1089#1077
      #1055#1083#1072#1085#1086#1074#1099#1077
      #1043#1086#1076#1086#1074#1099#1077
      #1042#1085#1077#1087#1083#1072#1085#1086#1074#1099#1077)
  end
  object ComboBoxSelection: TComboBox
    Left = 176
    Top = 272
    Width = 277
    Height = 24
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 6
    Text = #1042#1089#1077
    Items.Strings = (
      #1042#1089#1077
      #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
      #1042#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099)
  end
  object RadioGroup1: TRadioGroup
    Left = 176
    Top = 304
    Width = 273
    Height = 57
    Caption = #1058#1080#1087' '#1086#1090#1095#1105#1090#1072
    TabOrder = 7
  end
  object FullRadioButton: TRadioButton
    Left = 304
    Top = 328
    Width = 113
    Height = 17
    Caption = #1056#1072#1079#1074#1105#1088#1085#1091#1090#1099#1081
    TabOrder = 9
  end
  object CompactRadioButton: TRadioButton
    Left = 200
    Top = 328
    Width = 89
    Height = 17
    Caption = #1057#1078#1072#1090#1099#1081
    Checked = True
    TabOrder = 8
    TabStop = True
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
    Top = 88
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
