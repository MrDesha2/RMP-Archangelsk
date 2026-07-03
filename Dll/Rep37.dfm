object Report37Form: TReport37Form
  Left = 236
  Top = 210
  Width = 445
  Height = 214
  Caption = #1040#1090#1090#1077#1089#1090#1072#1094#1080#1103' '#1088#1072#1073#1086#1095#1080#1093
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
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
  object Label1: TLabel
    Left = 90
    Top = 17
    Width = 231
    Height = 24
    Caption = #1059#1095#1077#1090' '#1072#1090#1090#1077#1089#1090#1072#1094#1080#1080' '#1088#1072#1073#1086#1095#1080#1093
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 78
    Top = 59
    Width = 9
    Height = 16
    Caption = #1057
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 195
    Top = 59
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
    Left = 47
    Top = 91
    Width = 34
    Height = 16
    Caption = #1060#1048#1054':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 7
    Top = 117
    Width = 79
    Height = 16
    Caption = #1040#1090#1090#1077#1089#1090#1072#1094#1080#1103':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 93
    Top = 59
    Width = 98
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 217
    Top = 59
    Width = 97
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonSelPer: TButton
    Left = 313
    Top = 59
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelPerClick
  end
  object Button2: TButton
    Left = 206
    Top = 141
    Width = 85
    Height = 26
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button1: TButton
    Left = 109
    Top = 141
    Width = 84
    Height = 26
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 4
    OnClick = Button1Click
  end
  object WrkrCombo: TComboEdit
    Left = 93
    Top = 87
    Width = 272
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = WrkrComboButtonClick
    OnKeyDown = WrkrComboKeyDown
  end
  object SertCombo: TComboEdit
    Left = 93
    Top = 113
    Width = 272
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 6
    ID = -1
    CanSelectGroup = False
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = SertComboButtonClick
    OnKeyDown = SertComboKeyDown
  end
  object WrkrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrkr'
      'where id = :id or code = :code'
      '')
    Left = 397
    Top = 40
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
  object SertQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_sertificate'
      'where id = :id or code = :code'
      '')
    Left = 397
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
    Left = 400
    Top = 104
  end
end
