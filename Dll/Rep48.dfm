object Report48Form: TReport48Form
  Left = 333
  Top = 267
  Width = 465
  Height = 274
  Caption = #1054#1090#1095#1077#1090' '#1086#1073' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1080' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
  object Label1: TLabel
    Left = 42
    Top = 20
    Width = 337
    Height = 24
    Caption = #1054#1090#1095#1077#1090' '#1086#1073' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1080' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 109
    Top = 65
    Width = 13
    Height = 24
    Caption = #1057
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 232
    Top = 65
    Width = 22
    Height = 24
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 60
    Top = 94
    Width = 63
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 19
    Top = 116
    Width = 105
    Height = 32
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 16
    Top = 152
    Width = 110
    Height = 16
    Caption = #1055#1088#1080#1079#1085#1072#1082' '#1079#1072#1082#1072#1079#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 126
    Top = 69
    Width = 99
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 256
    Top = 69
    Width = 99
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonOK: TButton
    Left = 141
    Top = 193
    Width = 92
    Height = 27
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 2
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 252
    Top = 193
    Width = 91
    Height = 27
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = ButtonNOClick
  end
  object CstCombo: TComboEdit
    Left = 135
    Top = 92
    Width = 246
    Height = 21
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
    Left = 135
    Top = 120
    Width = 245
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 16
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object ButtonSelPer: TButton
    Left = 355
    Top = 68
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 6
    OnClick = ButtonSelPerClick
  end
  object ComboBox: TComboBox
    Left = 136
    Top = 148
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = #1042#1089#1077' '#1079#1072#1082#1072#1079#1099
    Items.Strings = (
      #1042#1089#1077' '#1079#1072#1082#1072#1079#1099
      #1053#1077' '#1074#1099#1087#1086#1083#1085#1077#1085
      #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
      #1047#1072#1082#1088#1099#1090)
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 392
    Top = 128
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
    Left = 392
    Top = 96
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
  object FaktMtrfQuery: TQuery
    DatabaseName = 'RMP'
    Left = 16
    Top = 192
  end
  object PlanMtrpQuery: TQuery
    DatabaseName = 'RMP'
    Left = 16
    Top = 224
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
