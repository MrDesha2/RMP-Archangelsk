object Report6Form: TReport6Form
  Left = 343
  Top = 215
  Width = 442
  Height = 336
  Caption = #1040#1085#1072#1083#1080#1079' '#1087#1086#1074#1090#1086#1088#1103#1077#1084#1086#1089#1090#1080' '#1085#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 39
    Top = 144
    Width = 63
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 7
    Top = 166
    Width = 104
    Height = 32
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label7: TLabel
    Left = 111
    Top = 98
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
  object Label8: TLabel
    Left = 220
    Top = 117
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
    Left = 228
    Top = 98
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
  object Label1: TLabel
    Left = 53
    Top = 196
    Width = 52
    Height = 16
    Caption = #1063#1077#1088#1090#1077#1078':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 10
    Top = 219
    Width = 100
    Height = 16
    Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 45
    Top = 12
    Width = 345
    Height = 24
    Caption = #1040#1085#1072#1083#1080#1079' '#1087#1086#1074#1090#1086#1088#1103#1077#1084#1086#1089#1090#1080' '#1085#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 111
    Top = 52
    Width = 53
    Height = 16
    Caption = #1055#1083#1072#1085' '#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object MonthComboBox: TComboBox
    Left = 111
    Top = 72
    Width = 143
    Height = 21
    ItemHeight = 13
    TabOrder = 0
  end
  object CstCombo: TComboEdit
    Left = 111
    Top = 141
    Width = 297
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 111
    Top = 165
    Width = 297
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 4
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object RqstEdit: TEdit
    Left = 111
    Top = 117
    Width = 105
    Height = 21
    TabOrder = 1
  end
  object OrderEdit: TEdit
    Left = 228
    Top = 117
    Width = 105
    Height = 21
    TabOrder = 2
  end
  object ChrtCombo: TComboEdit
    Left = 111
    Top = 190
    Width = 297
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = ChrtComboButtonClick
    OnKeyDown = ChrtComboKeyDown
  end
  object NMNTCombo: TComboEdit
    Left = 111
    Top = 216
    Width = 297
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 6
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = NMNTComboButtonClick
    OnKeyDown = NMNTComboKeyDown
  end
  object Button1: TButton
    Left = 129
    Top = 251
    Width = 84
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 7
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 218
    Top = 251
    Width = 85
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 8
    OnClick = Button2Click
  end
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code'
      '')
    Left = 424
    Top = 200
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
    Top = 256
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
  object ChrtToNmntQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select b.id, b.code, b.name'
      'from spr_chrt a Left Join spr_nmnt b on a.id_nmnt = b.id'
      'where a.id = :id'
      '')
    Left = 456
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object ChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 420
    Top = 312
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
  object NmntToChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select b.id, b.code, b.name'
      'from spr_nmnt a Left Join spr_chrt  b on a.id = b.id_nmnt'
      'where a.id = :id')
    Left = 456
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 296
    Top = 72
  end
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, code, name'
      'from spr_nmnt'
      'where id= :id or code = :code'
      '')
    Left = 425
    Top = 368
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
