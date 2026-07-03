object Report22Form: TReport22Form
  Left = 243
  Top = 194
  Width = 520
  Height = 377
  Caption = #1054#1090#1095#1077#1090' '#1086#1073' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1080' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
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
    Left = 52
    Top = 25
    Width = 440
    Height = 29
    Caption = #1054#1090#1095#1077#1090' '#1086#1073' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1080' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 134
    Top = 80
    Width = 14
    Height = 26
    Caption = #1057
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 286
    Top = 80
    Width = 24
    Height = 26
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 74
    Top = 116
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
    Left = 14
    Top = 143
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
  object BegDateEdit: TDateEdit
    Left = 155
    Top = 85
    Width = 122
    Height = 26
    ButtonWidth = 21
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 315
    Top = 85
    Width = 122
    Height = 26
    ButtonWidth = 21
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 174
    Top = 267
    Width = 113
    Height = 33
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 2
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 310
    Top = 267
    Width = 112
    Height = 33
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = ButtonNOClick
  end
  object CstCombo: TComboEdit
    Left = 166
    Top = 113
    Width = 303
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 25
    NumGlyphs = 1
    TabOrder = 4
    ID = -1
    CanSelectGroup = False
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 166
    Top = 148
    Width = 302
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object RadioGroup1: TRadioGroup
    Left = 167
    Top = 180
    Width = 274
    Height = 77
    Caption = #1060#1086#1088#1084#1072
    TabOrder = 6
  end
  object RMPRadioButton: TRadioButton
    Left = 186
    Top = 203
    Width = 119
    Height = 17
    Caption = #1076#1083#1103' '#1056#1052#1055
    Checked = True
    TabOrder = 7
    TabStop = True
  end
  object BuhRadioButton: TRadioButton
    Left = 186
    Top = 223
    Width = 167
    Height = 17
    Caption = #1076#1083#1103' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
    TabOrder = 8
  end
  object ButtonSelPer: TButton
    Left = 437
    Top = 84
    Width = 31
    Height = 26
    Caption = '...'
    TabOrder = 9
    OnClick = ButtonSelPerClick
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 416
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
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code'
      '')
    Left = 416
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
  object MtchQuery: TQuery
    DatabaseName = 'RMP'
    Left = 16
    Top = 224
  end
  object FaktMtrfQuery: TQuery
    DatabaseName = 'RMP'
    Left = 16
    Top = 192
  end
  object PlanMtrpQuery: TQuery
    DatabaseName = 'RMP'
    Left = 16
    Top = 256
  end
  object EdizQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.CODE'
      'From Spr_Ediz a, Spr_Nmnt b'
      'Where b.ID = :id and a.ID = b.ID_EDIZ')
    Left = 56
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
