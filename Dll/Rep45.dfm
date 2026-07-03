object Report45Form: TReport45Form
  Left = 192
  Top = 114
  Width = 466
  Height = 230
  Caption = 'Report45Form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
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
  object Label6: TLabel
    Left = 101
    Top = 17
    Width = 387
    Height = 29
    Caption = #1059#1095#1077#1090' '#1087#1088#1080#1093#1086#1076#1072' '#1080' '#1088#1072#1089#1093#1086#1076#1072' '#1084#1086#1076#1077#1083#1077#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 123
    Top = 64
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
  object Label3: TLabel
    Left = 278
    Top = 64
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
  object Label10: TLabel
    Left = 53
    Top = 94
    Width = 76
    Height = 24
    Caption = #1052#1086#1076#1077#1083#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 64
    Top = 130
    Width = 59
    Height = 24
    Caption = #1057#1082#1083#1072#1076':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 150
    Top = 62
    Width = 118
    Height = 25
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 309
    Top = 62
    Width = 119
    Height = 25
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonSelPer: TButton
    Left = 430
    Top = 62
    Width = 30
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelPerClick
  end
  object MdlCombo: TComboEdit
    Left = 130
    Top = 91
    Width = 335
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = MdlComboButtonClick
    OnKeyDown = MdlComboKeyDown
  end
  object PrintButton: TButton
    Left = 176
    Top = 175
    Width = 103
    Height = 32
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 4
    OnClick = PrintButtonClick
  end
  object CloseButton: TButton
    Left = 295
    Top = 175
    Width = 105
    Height = 32
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = CloseButtonClick
  end
  object WrhsCombo: TComboEdit
    Left = 130
    Top = 128
    Width = 335
    Height = 27
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 6
    ID = -1
    CanSelectGroup = False
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
    Left = 376
    Top = 64
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
    Left = 336
    Top = 128
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
