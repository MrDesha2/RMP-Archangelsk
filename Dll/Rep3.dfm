object Report3Form: TReport3Form
  Left = 310
  Top = 240
  Width = 448
  Height = 384
  Caption = #1054#1090#1095#1077#1090
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
  object Label9: TLabel
    Left = 46
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
    Left = 24
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
    Left = 150
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
    Left = 46
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
    Left = 154
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
    Left = 163
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
    Left = 8
    Top = 160
    Width = 42
    Height = 13
    Caption = #1063#1077#1088#1090#1077#1078':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 7
    Top = 187
    Width = 77
    Height = 13
    Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 46
    Top = 26
    Width = 308
    Height = 20
    Caption = #1055#1083#1072#1085#1080#1088#1091#1077#1084#1099#1081' '#1087#1077#1088#1080#1086#1076' '#1074#1099#1087#1086#1083#1077#1085#1080#1103' '#1079#1072#1082#1072#1079#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 46
    Top = 83
    Width = 96
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 175
    Top = 83
    Width = 97
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 1
  end
  object RqstEdit: TEdit
    Left = 46
    Top = 124
    Width = 104
    Height = 21
    TabOrder = 2
  end
  object OrderEdit: TEdit
    Left = 163
    Top = 124
    Width = 104
    Height = 21
    TabOrder = 3
  end
  object ChrtCombo: TComboEdit
    Left = 86
    Top = 155
    Width = 297
    Height = 21
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 4
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = ChrtComboButtonClick
    OnKeyDown = ChrtComboKeyDown
  end
  object NMNTCombo: TComboEdit
    Left = 86
    Top = 182
    Width = 297
    Height = 21
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 5
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = NMNTComboButtonClick
    OnKeyDown = NMNTComboKeyDown
  end
  object Button1: TButton
    Left = 130
    Top = 279
    Width = 85
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 227
    Top = 279
    Width = 85
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 7
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 78
    Top = 210
    Width = 260
    Height = 59
    Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1081
    TabOrder = 8
    object RadioButtonPlan: TRadioButton
      Left = 13
      Top = 20
      Width = 92
      Height = 13
      Caption = #1087#1086' '#1087#1083#1072#1085#1091
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonFakt: TRadioButton
      Left = 13
      Top = 39
      Width = 92
      Height = 14
      Caption = #1087#1086' '#1092#1072#1082#1090#1091
      TabOrder = 1
    end
  end
  object ButtonSelPer: TButton
    Left = 270
    Top = 82
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 9
    OnClick = ButtonSelPerClick
  end
  object ChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 420
    Top = 198
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
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
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
    Top = 254
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
    Left = 448
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 424
    Top = 144
  end
end
