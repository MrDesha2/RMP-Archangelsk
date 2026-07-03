object Report24Form: TReport24Form
  Left = 481
  Top = 306
  Width = 516
  Height = 407
  Caption = #1086#1090#1095#1077#1090' '#1087#1086' '#1088#1072#1089#1093#1086#1076#1091' '#1086#1089#1085#1086#1074#1085#1099#1093' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
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
    Left = 25
    Top = 16
    Width = 471
    Height = 29
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1088#1072#1089#1093#1086#1076#1091' '#1086#1089#1085#1086#1074#1085#1099#1093' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074' '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 130
    Top = 96
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
    Left = 283
    Top = 96
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
    Left = 70
    Top = 132
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
    Left = 10
    Top = 159
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
  object Label6: TLabel
    Left = 96
    Top = 48
    Width = 318
    Height = 29
    Caption = #1074' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' '#1087#1086' '#1079#1072#1082#1072#1079#1072#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 160
    Top = 101
    Width = 119
    Height = 26
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 313
    Top = 101
    Width = 119
    Height = 26
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 166
    Top = 305
    Width = 112
    Height = 32
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 2
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 302
    Top = 305
    Width = 113
    Height = 32
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = ButtonNOClick
  end
  object CstCombo: TComboEdit
    Left = 160
    Top = 132
    Width = 302
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 4
    ID = -1
    CanSelectGroup = False
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 160
    Top = 164
    Width = 300
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
    Left = 160
    Top = 207
    Width = 272
    Height = 90
    Caption = #1060#1086#1088#1084#1072
    TabOrder = 6
  end
  object RMPRadioButtonPlan: TRadioButton
    Left = 177
    Top = 247
    Width = 179
    Height = 16
    Caption = #1076#1083#1103' '#1056#1052#1055' ('#1087#1083#1072#1085')'
    TabOrder = 7
  end
  object BuhRadioButton: TRadioButton
    Left = 177
    Top = 267
    Width = 152
    Height = 16
    Caption = #1076#1083#1103' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
    TabOrder = 8
  end
  object ButtonSelPer: TButton
    Left = 430
    Top = 100
    Width = 30
    Height = 26
    Caption = '...'
    TabOrder = 9
    OnClick = ButtonSelPerClick
  end
  object RmpRadioButtonFact: TRadioButton
    Left = 177
    Top = 226
    Width = 169
    Height = 21
    Caption = #1076#1083#1103' '#1056#1052#1055' ('#1092#1072#1082#1090')'
    Checked = True
    TabOrder = 10
    TabStop = True
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 376
    Top = 224
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
    Left = 368
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
    SQL.Strings = (
      'Select * '
      'From REPORT_22_PROCEDURE(:DATE_BEG, :DATE_END, :ID_CST, :ID_PDR)'
      'Order by NUMBER_ORDER, NUMBER_RQST, NUMDOC, CODE')
    Left = 80
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATE_BEG'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATE_END'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_CST'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_PDR'
        ParamType = ptUnknown
      end>
  end
end
