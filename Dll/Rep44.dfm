object Report44Form: TReport44Form
  Left = 192
  Top = 114
  Width = 495
  Height = 290
  Caption = #1054#1073#1086#1088#1086#1090#1085#1072#1103' '#1074#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1084#1086#1076#1077#1083#1103#1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 76
    Top = 14
    Width = 317
    Height = 24
    Caption = #1054#1073#1086#1088#1086#1090#1085#1072#1103' '#1074#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1084#1086#1076#1077#1083#1103#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 96
    Top = 52
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
    Left = 222
    Top = 52
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
  object Label10: TLabel
    Left = 44
    Top = 82
    Width = 53
    Height = 16
    Caption = #1052#1086#1076#1077#1083#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 52
    Top = 114
    Width = 43
    Height = 16
    Caption = #1057#1082#1083#1072#1076':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 118
    Top = 50
    Width = 96
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 246
    Top = 50
    Width = 98
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonSelPer: TButton
    Left = 345
    Top = 50
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelPerClick
  end
  object MdlCombo: TComboEdit
    Left = 106
    Top = 80
    Width = 272
    Height = 22
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = MdlComboButtonClick
    OnKeyDown = MdlComboKeyDown
  end
  object PrintButton: TButton
    Left = 127
    Top = 147
    Width = 84
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 4
    OnClick = PrintButtonClick
  end
  object CloseButton: TButton
    Left = 224
    Top = 147
    Width = 85
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = CloseButtonClick
  end
  object WrhsCombo: TComboEdit
    Left = 106
    Top = 112
    Width = 272
    Height = 22
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 6
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = WrhsComboButtonClick
    OnKeyDown = WrhsComboKeyDown
  end
  object MdlQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_mdl'
      'where id = :id or code = :code'
      '')
    Left = 384
    Top = 72
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
    Left = 344
    Top = 144
  end
  object WrhsQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrhs'
      'where id = :id or code = :code'
      '')
    Left = 384
    Top = 104
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
