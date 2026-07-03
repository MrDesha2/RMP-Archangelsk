object Report59Form: TReport59Form
  Left = 303
  Top = 232
  Width = 592
  Height = 627
  Caption = #1050#1086#1085#1090#1088#1086#1083#1100' '#1079#1072' '#1093#1086#1076#1086#1084' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
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
    Left = 98
    Top = 23
    Width = 280
    Height = 20
    Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1075#1086#1076#1086#1074#1086#1084#1091' '#1078#1091#1088#1085#1072#1083#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 66
    Top = 168
    Width = 44
    Height = 16
    Caption = #1054#1090#1073#1086#1088':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 7
    Top = 188
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
  object Label7: TLabel
    Left = 57
    Top = 213
    Width = 52
    Height = 16
    Caption = #1063#1077#1088#1090#1077#1078':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 50
    Top = 237
    Width = 66
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 57
    Top = 261
    Width = 57
    Height = 16
    Caption = #1059#1095#1072#1089#1090#1086#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 129
    Top = 285
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
  object Label11: TLabel
    Left = 242
    Top = 285
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
  object Label10: TLabel
    Left = 237
    Top = 304
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
  object GroupBox1: TGroupBox
    Left = 65
    Top = 46
    Width = 339
    Height = 104
    Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100'  '#1087#1086' '#1087#1077#1088#1080#1086#1076#1091
    TabOrder = 0
    object Label2: TLabel
      Left = 11
      Top = 64
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
      Left = 158
      Top = 64
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
    object PerInRadioButton: TRadioButton
      Left = 9
      Top = 22
      Width = 200
      Height = 14
      Caption = #1055#1086' '#1076#1072#1090#1077' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = PerInRadioButtonClick
    end
    object PerOutRadioButton: TRadioButton
      Left = 9
      Top = 39
      Width = 252
      Height = 14
      Caption = #1055#1086' '#1076#1072#1090#1077' '#1087#1083#1072#1085#1086#1074#1086#1075#1086' '#1079#1072#1074#1077#1088#1096#1077#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
      TabOrder = 1
      OnClick = PerOutRadioButtonClick
    end
    object BegDateEdit: TDateEdit
      Left = 33
      Top = 63
      Width = 121
      Height = 20
      ButtonWidth = 16
      NumGlyphs = 2
      TabOrder = 2
    end
    object EndDateEdit: TDateEdit
      Left = 177
      Top = 63
      Width = 121
      Height = 20
      ButtonWidth = 16
      NumGlyphs = 2
      TabOrder = 3
    end
    object ButtonSelPer: TButton
      Left = 303
      Top = 61
      Width = 25
      Height = 21
      Caption = '...'
      TabOrder = 4
      OnClick = ButtonSelPerClick
    end
  end
  object ReviewComboBox: TComboBox
    Left = 128
    Top = 164
    Width = 176
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = #1042#1089#1077' '#1079#1072#1082#1072#1079#1099
    Items.Strings = (
      #1042#1089#1077' '#1079#1072#1082#1072#1079#1099
      #1042#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077
      #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
      #1053#1077' '#1079#1072#1087#1091#1097#1077#1085#1085#1099#1077)
  end
  object FeatComboBox: TComboBox
    Left = 128
    Top = 187
    Width = 176
    Height = 21
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 2
    Text = #1041#1077#1079' '#1087#1088#1080#1079#1085#1072#1082#1072
    OnChange = FeatComboBoxChange
    Items.Strings = (
      #1041#1077#1079' '#1087#1088#1080#1079#1085#1072#1082#1072
      #1055#1083#1072#1085#1086#1074#1099#1077
      #1043#1086#1076#1086#1074#1099#1077
      #1042#1085#1077#1087#1083#1072#1085#1086#1074#1099#1077)
  end
  object ChrtCombo: TComboEdit
    Left = 128
    Top = 209
    Width = 263
    Height = 20
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = ChrtComboButtonClick
    OnKeyDown = ChrtComboKeyDown
  end
  object CstCombo: TComboEdit
    Left = 128
    Top = 232
    Width = 263
    Height = 22
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 4
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 128
    Top = 257
    Width = 263
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object OrderEdit: TEdit
    Left = 246
    Top = 304
    Width = 104
    Height = 21
    TabOrder = 6
  end
  object RqstEdit: TEdit
    Left = 129
    Top = 304
    Width = 104
    Height = 21
    TabOrder = 7
  end
  object RadioGroup1: TRadioGroup
    Left = 130
    Top = 323
    Width = 222
    Height = 60
    Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1082#1072
    TabOrder = 8
  end
  object CstRadioButton: TRadioButton
    Left = 137
    Top = 345
    Width = 208
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1079#1072#1082#1072#1079#1095#1080#1082#1072#1084
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    TabStop = True
    OnClick = CstRadioButtonClick
  end
  object NmntRadioButton: TRadioButton
    Left = 137
    Top = 362
    Width = 202
    Height = 14
    Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084
    TabOrder = 10
    OnClick = NmntRadioButtonClick
  end
  object OutMemoBox: TCheckBox
    Left = 132
    Top = 385
    Width = 207
    Height = 17
    Caption = #1042#1099#1074#1086#1076#1080#1090#1100' '#1082#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1079#1072#1082#1072#1079#1086#1074
    TabOrder = 11
    OnClick = OutMemoBoxClick
  end
  object OKButton: TButton
    Left = 163
    Top = 410
    Width = 76
    Height = 25
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 12
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 248
    Top = 410
    Width = 74
    Height = 25
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 13
    OnClick = CancelButtonClick
  end
  object qCSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 476
    Top = 220
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
  object qPdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 476
    Top = 248
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
  object qChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 476
    Top = 192
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
    Left = 477
    Top = 8
  end
end
