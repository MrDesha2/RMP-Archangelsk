object Report5Form: TReport5Form
  Left = 294
  Top = 275
  Width = 564
  Height = 496
  Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1072#1088#1093#1080#1074#1091
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
  object Label6: TLabel
    Left = 131
    Top = 20
    Width = 195
    Height = 24
    Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1072#1088#1093#1080#1074#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 131
    Top = 59
    Width = 184
    Height = 16
    Caption = #1044#1072#1090#1072' '#1088#1072#1089#1093#1086#1076#1085#1086#1075#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 109
    Top = 85
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
    Left = 235
    Top = 85
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
  object Label7: TLabel
    Left = 131
    Top = 105
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
    Left = 239
    Top = 124
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
  object Label1: TLabel
    Left = 248
    Top = 105
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
  object Label4: TLabel
    Left = 59
    Top = 205
    Width = 42
    Height = 13
    Caption = #1063#1077#1088#1090#1077#1078':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 33
    Top = 229
    Width = 77
    Height = 13
    Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label10: TLabel
    Left = 54
    Top = 151
    Width = 48
    Height = 13
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label11: TLabel
    Left = 21
    Top = 173
    Width = 80
    Height = 26
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object BegDateEdit: TDateEdit
    Left = 131
    Top = 83
    Width = 96
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 259
    Top = 83
    Width = 98
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 1
  end
  object RqstEdit: TEdit
    Left = 131
    Top = 124
    Width = 104
    Height = 21
    TabOrder = 2
  end
  object OrderEdit: TEdit
    Left = 248
    Top = 124
    Width = 104
    Height = 21
    TabOrder = 3
  end
  object ChrtCombo: TComboEdit
    Left = 117
    Top = 201
    Width = 297
    Height = 20
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 6
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = ChrtComboButtonClick
    OnKeyDown = ChrtComboKeyDown
  end
  object NMNTCombo: TComboEdit
    Left = 117
    Top = 224
    Width = 297
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 7
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = NMNTComboButtonClick
    OnKeyDown = NMNTComboKeyDown
  end
  object Button1: TButton
    Left = 177
    Top = 329
    Width = 85
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 8
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 275
    Top = 329
    Width = 84
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 9
    OnClick = Button2Click
  end
  object CstCombo: TComboEdit
    Left = 117
    Top = 147
    Width = 297
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 4
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 117
    Top = 176
    Width = 297
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object ButtonSelPer: TButton
    Left = 362
    Top = 82
    Width = 26
    Height = 21
    Caption = '...'
    TabOrder = 10
    OnClick = ButtonSelPerClick
  end
  object RadioGroup1: TRadioGroup
    Left = 118
    Top = 254
    Width = 295
    Height = 59
    Caption = #1057#1073#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086
    TabOrder = 11
  end
  object RadioButton1: TRadioButton
    Left = 124
    Top = 271
    Width = 273
    Height = 13
    Caption = #1055#1088#1080#1077#1084#1086'-'#1089#1076#1072#1090#1086#1095#1085#1099#1077' '#1085#1072#1082#1083#1072#1076#1085#1099#1077' + '#1040#1082#1090#1099
    TabOrder = 12
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 124
    Top = 292
    Width = 274
    Height = 14
    Caption = #1058#1088#1077#1073#1086#1074#1072#1085#1080#1103'-'#1085#1072#1082#1083#1072#1076#1085#1099#1077' + '#1040#1082#1090#1099
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    TabStop = True
    OnClick = RadioButton2Click
  end
  object ChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 420
    Top = 310
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
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, code, name'
      'from spr_nmnt'
      'where id= :id or code = :code'
      '')
    Left = 417
    Top = 366
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
    Left = 448
    Top = 312
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object NmntToChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select b.id, b.code, b.name'
      'from spr_nmnt a Left Join spr_chrt  b on a.id = b.id_nmnt'
      'where a.id = :id')
    Left = 448
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
    Left = 432
    Top = 24
  end
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code'
      '')
    Left = 432
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
    Left = 432
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
end
