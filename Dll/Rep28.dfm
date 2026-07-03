object Report28Form: TReport28Form
  Left = 247
  Top = 163
  Width = 546
  Height = 444
  Caption = #1054#1073#1086#1088#1086#1090#1085#1072#1103' '#1074#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1089#1082#1083#1072#1076#1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF008888
    8888888888888888888888888888888888888888777777777888888888888888
    8888888877777777777788888888888888888888000000000777888888888888
    8888888811111000000788888888888888888888B11111100007778888888888
    888888888B113311100077888888888777778888881113311100077888888887
    7007788888B111333110077888888887B1107788888B11113110007788888887
    B11007888888B111331100778888888BB111077888888111133100078888888B
    1111007788881111113110078888888B1131100778111111113110078888888B
    1131110071111111113110078888888B1131111011111111113110078888888B
    11331111111111111331000778888888B1133111111111111311000777888888
    B1113111111111111131100077788888BB113311111111111113100007778888
    8B1113311111111111131100007788888BB11113311331111111311000078888
    88BB1111333313111111131100008888888BBB11111113111111113110008888
    88888BBB1111113111111131100088888888888BBBBBBB131111111311008888
    8888888888888B13111111113110888888888888888888B13111111113118888
    888888888888888B1311111113118888888888888888888B1131111111318888
    8888888888888888B13111111113888888888888888888888B13111111110000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000}
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 371
    Width = 538
    Height = 39
    Align = alBottom
    TabOrder = 0
    object ButtonDo: TButton
      Left = 30
      Top = 7
      Width = 91
      Height = 25
      Caption = #1057'&'#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = ButtonDoClick
    end
    object ButtonCancel: TButton
      Left = 127
      Top = 6
      Width = 92
      Height = 26
      Cancel = True
      Caption = '&'#1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = ButtonCancelClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 538
    Height = 269
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 110
      Top = 70
      Width = 7
      Height = 13
      Caption = #1057
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 234
      Top = 70
      Width = 12
      Height = 13
      Caption = #1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 96
      Top = 16
      Width = 297
      Height = 24
      Caption = #1054#1073#1086#1088#1086#1090#1085#1072#1103' '#1074#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1089#1082#1083#1072#1076#1091
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 33
      Top = 100
      Width = 77
      Height = 13
      Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
    end
    object Label4: TLabel
      Left = 79
      Top = 124
      Width = 34
      Height = 13
      Caption = #1057#1082#1083#1072#1076':'
    end
    object Label6: TLabel
      Left = 62
      Top = 147
      Width = 51
      Height = 13
      Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    end
    object BegDateEdit: TDateEdit
      Left = 120
      Top = 66
      Width = 98
      Height = 21
      ButtonWidth = 16
      NumGlyphs = 2
      TabOrder = 0
    end
    object EndDateEdit: TDateEdit
      Left = 250
      Top = 66
      Width = 98
      Height = 21
      ButtonWidth = 16
      NumGlyphs = 2
      TabOrder = 1
    end
    object NMNTCombo: TComboEdit
      Left = 120
      Top = 96
      Width = 297
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 21
      NumGlyphs = 1
      TabOrder = 2
      ID = -1
      CanSelectGroup = False
      Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
      OnButtonClick = NMNTComboButtonClick
      OnKeyDown = NMNTComboKeyDown
    end
    object WRHSCombo: TComboEdit
      Left = 120
      Top = 120
      Width = 297
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 21
      NumGlyphs = 1
      TabOrder = 3
      ID = -1
      CanSelectGroup = False
      Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
      OnButtonClick = WRHSComboButtonClick
      OnKeyDown = WRHSComboKeyDown
    end
    object ButtonSetPer: TButton
      Left = 352
      Top = 65
      Width = 25
      Height = 21
      Caption = '...'
      TabOrder = 4
      OnClick = ButtonSetPerClick
    end
    object CSTCombo: TComboEdit
      Left = 120
      Top = 143
      Width = 297
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 21
      NumGlyphs = 1
      TabOrder = 5
      ID = -1
      CanSelectGroup = False
      Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
      OnButtonClick = CSTComboButtonClick
      OnKeyDown = CSTComboKeyDown
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 269
    Width = 538
    Height = 102
    Align = alBottom
    TabOrder = 2
    object CheckAdd: TCheckBox
      Left = 11
      Top = 78
      Width = 157
      Height = 17
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1072#1103' '#1076#1083#1103' '#1051#1062
      TabOrder = 0
    end
    object RadioGroup: TRadioGroup
      Left = 9
      Top = 3
      Width = 400
      Height = 70
      Caption = #1042#1080#1076' '#1086#1090#1095#1077#1090#1072
      TabOrder = 1
    end
    object RadioButton2: TRadioButton
      Left = 19
      Top = 35
      Width = 161
      Height = 17
      Caption = #1054#1073#1086#1088#1086#1090#1085#1072#1103' '#1074#1077#1076#1086#1084#1086#1089#1090#1100
      TabOrder = 2
      OnClick = RadioButton2Click
    end
    object RadioButton1: TRadioButton
      Left = 19
      Top = 19
      Width = 177
      Height = 17
      Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1089#1082#1083#1072#1076#1089#1082#1086#1075#1086' '#1091#1095#1077#1090#1072
      Checked = True
      TabOrder = 3
      TabStop = True
      OnClick = RadioButton2Click
    end
    object Panel3: TPanel
      Left = 215
      Top = 15
      Width = 160
      Height = 39
      BevelOuter = bvNone
      TabOrder = 4
      object RadioMTR: TRadioButton
        Left = 8
        Top = 8
        Width = 113
        Height = 17
        Caption = #1055#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object RadioProd: TRadioButton
        Left = 8
        Top = 24
        Width = 137
        Height = 17
        Caption = #1055#1086' '#1075#1086#1090#1086#1074#1086#1081' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
        TabOrder = 1
      end
    end
    object CheckDetail: TCheckBox
      Left = 40
      Top = 51
      Width = 97
      Height = 17
      Caption = #1044#1077#1090#1072#1083#1100#1085#1086
      Enabled = False
      TabOrder = 5
    end
  end
  object qWRHSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select name, id'
      'from spr_wrhs'
      'where id= :id or code = :code')
    Left = 465
    Top = 40
    ParamData = <
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'code'
        ParamType = ptUnknown
      end>
  end
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select name, id, code'
      'from spr_nmnt'
      'where id= :id or code = :code'
      '')
    Left = 497
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
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select *'
      'from REPORT_BALANCE_PROCEDURE(:typedoc,'
      ' :id_nmnt, :datebeg, :dateend, :id_wrhs) '
      'order by code, datedoc, numdoc')
    Left = 464
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'typedoc'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_nmnt'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'datebeg'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dateend'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_wrhs'
        ParamType = ptUnknown
      end>
  end
  object qCSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select name, id, code'
      'from spr_cst'
      'where id= :id or code = :code'
      '')
    Left = 497
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
end
