object Report8Form: TReport8Form
  Left = 432
  Top = 387
  Width = 466
  Height = 310
  Caption = #1056#1077#1077#1089#1090#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
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
    Left = 93
    Top = 16
    Width = 167
    Height = 20
    Caption = #1056#1077#1077#1089#1090#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 176
    Top = 52
    Width = 12
    Height = 13
    Caption = #1087#1086
  end
  object Label2: TLabel
    Left = 50
    Top = 52
    Width = 7
    Height = 13
    Caption = 'C'
  end
  object Label4: TLabel
    Left = 18
    Top = 158
    Width = 85
    Height = 13
    Caption = #1042#1080#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074':'
  end
  object Label5: TLabel
    Left = 22
    Top = 86
    Width = 45
    Height = 13
    Caption = #1059#1095#1072#1089#1090#1086#1082':'
  end
  object Label6: TLabel
    Left = 16
    Top = 110
    Width = 51
    Height = 13
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
  end
  object Label7: TLabel
    Left = 32
    Top = 134
    Width = 34
    Height = 13
    Caption = #1057#1082#1083#1072#1076':'
  end
  object OKButton: TButton
    Left = 99
    Top = 243
    Width = 76
    Height = 25
    Caption = 'O&k'
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 177
    Top = 243
    Width = 76
    Height = 25
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object RollComboBox: TComboBox
    Left = 130
    Top = 154
    Width = 169
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = #1040#1082#1090#1099
    Items.Strings = (
      #1040#1082#1090#1099
      #1058#1088#1077#1073#1086#1074#1072#1085#1080#1103'-'#1085#1072#1082#1083#1072#1076#1085#1099#1077
      #1055#1088#1080#1077#1084#1086'-'#1089#1076#1072#1090#1086#1095#1085#1099#1077' '#1085#1072#1082#1083#1072#1076#1085#1099#1077)
  end
  object EndDateEdit: TDateEdit
    Left = 201
    Top = 50
    Width = 97
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 0
  end
  object BegDateEdit: TDateEdit
    Left = 72
    Top = 50
    Width = 96
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 1
  end
  object PDRCombo: TComboEdit
    Left = 72
    Top = 82
    Width = 255
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = PDRComboButtonClick
    OnKeyDown = PDRComboKeyDown
  end
  object RadioButton1: TRadioButton
    Left = 73
    Top = 186
    Width = 98
    Height = 14
    Caption = #1055#1086#1076#1087#1080#1089#1072#1085#1099
    Checked = True
    TabOrder = 6
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 183
    Top = 186
    Width = 98
    Height = 14
    Caption = #1053#1077' '#1087#1086#1076#1087#1080#1089#1072#1085#1099
    TabOrder = 7
  end
  object ButtonSelPer: TButton
    Left = 300
    Top = 50
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 8
    OnClick = ButtonSelPerClick
  end
  object ViewCheckBox: TCheckBox
    Left = 73
    Top = 211
    Width = 217
    Height = 17
    Caption = #1042#1099#1074#1077#1089#1090#1080' '#1089#1091#1084#1084#1091' '#1087#1086' '#1076#1086#1082#1091#1084#1077#1085#1090#1091
    TabOrder = 9
  end
  object CstCombo: TComboEdit
    Left = 72
    Top = 106
    Width = 255
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 10
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object WrhsCombo: TComboEdit
    Left = 72
    Top = 130
    Width = 255
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 11
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = WrhsComboButtonClick
    OnKeyDown = WrhsComboKeyDown
  end
  object Query: TQuery
    DatabaseName = 'RMP'
    Left = 367
    Top = 25
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 364
    Top = 80
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
  object qCstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 364
    Top = 112
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
  object qWrhsQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrhs'
      'where id = :id or code = :code')
    Left = 364
    Top = 144
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
