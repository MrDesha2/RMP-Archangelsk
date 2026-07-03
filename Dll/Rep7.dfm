object Report7Form: TReport7Form
  Left = 192
  Top = 132
  Width = 423
  Height = 282
  Caption = #1055#1083#1072#1085' '#1087#1086' '#1083#1080#1090#1100#1102
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
    Left = 105
    Top = 17
    Width = 217
    Height = 36
    Caption = #1055#1083#1072#1085' '#1087#1086' '#1083#1080#1090#1100#1102
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 9
    Top = 137
    Width = 63
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
  end
  object Label3: TLabel
    Left = 193
    Top = 57
    Width = 28
    Height = 29
    Caption = #1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object MonthComboBox: TComboBox
    Left = 121
    Top = 97
    Width = 176
    Height = 24
    ItemHeight = 16
    TabOrder = 0
  end
  object Button1: TButton
    Left = 114
    Top = 181
    Width = 96
    Height = 32
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 219
    Top = 181
    Width = 96
    Height = 32
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = Button2Click
  end
  object CstCombo: TComboEdit
    Left = 81
    Top = 137
    Width = 272
    Height = 25
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 3
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      'From REPORT_7_PROCEDURE(:id_cst, :period)'
      ''
      '')
    Left = 336
    Top = 200
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_cst'
        ParamType = ptUnknown
      end
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
    Left = 368
    Top = 136
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
