object Report11Form: TReport11Form
  Left = 267
  Top = 232
  Width = 431
  Height = 344
  Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1075#1086#1076#1086#1074#1086#1084#1091' '#1078#1091#1088#1085#1072#1083#1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
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
    Left = 69
    Top = 20
    Width = 341
    Height = 25
    Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1075#1086#1076#1086#1074#1086#1084#1091' '#1078#1091#1088#1085#1072#1083#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 73
    Top = 73
    Width = 9
    Height = 16
    Caption = 'C'
  end
  object Label4: TLabel
    Left = 213
    Top = 71
    Width = 16
    Height = 16
    Caption = #1087#1086
  end
  object Label3: TLabel
    Left = 20
    Top = 106
    Width = 57
    Height = 16
    Caption = #1059#1095#1072#1089#1090#1086#1082':'
  end
  object Label5: TLabel
    Left = 20
    Top = 138
    Width = 66
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
  end
  object BegDateEdit: TDateEdit
    Left = 87
    Top = 70
    Width = 120
    Height = 26
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 231
    Top = 70
    Width = 119
    Height = 26
    NumGlyphs = 2
    TabOrder = 1
  end
  object PDRCombo: TComboEdit
    Left = 89
    Top = 101
    Width = 286
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 2
    Text = '<Object not found>'
    OnButtonClick = PDRComboButtonClick
    OnKeyDown = PDRComboKeyDown
  end
  object CSTCombo: TComboEdit
    Left = 89
    Top = 130
    Width = 286
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 3
    Text = '<Object not found>'
    OnButtonClick = CSTComboButtonClick
    OnKeyDown = CSTComboKeyDown
  end
  object OKButton: TButton
    Left = 129
    Top = 257
    Width = 93
    Height = 31
    Caption = #1054'k'
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 233
    Top = 257
    Width = 92
    Height = 31
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = CancelButtonClick
  end
  object RadioGroup1: TRadioGroup
    Left = 25
    Top = 160
    Width = 352
    Height = 73
    Caption = #1057#1073#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086
    TabOrder = 6
  end
  object RadioButton1: TRadioButton
    Left = 32
    Top = 185
    Width = 337
    Height = 16
    Caption = #1055#1088#1080#1077#1084#1086'-'#1089#1076#1072#1090#1086#1095#1085#1099#1077' '#1085#1072#1082#1083#1072#1076#1085#1099#1077' + '#1040#1082#1090#1099
    Checked = True
    TabOrder = 7
    TabStop = True
    OnClick = RadioButton1Click
  end
  object RadioButton2: TRadioButton
    Left = 32
    Top = 208
    Width = 337
    Height = 17
    Caption = #1058#1088#1077#1073#1086#1074#1072#1085#1080#1103'-'#1085#1072#1082#1083#1072#1076#1085#1099#1077' + '#1040#1082#1090#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = RadioButton2Click
  end
  object SelPeriod: TButton
    Left = 350
    Top = 70
    Width = 25
    Height = 26
    Caption = '...'
    TabOrder = 9
    OnClick = SelPeriodClick
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 348
    Top = 56
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
  object qCSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 348
    Top = 88
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
    SQL.Strings = (
      'Select a.CODE, a.NAME, '
      'From Spr_Cst a, DH_Order b, DH_Rqst c, DT_Order2 d, DT_Mtrf e'
      'Where d.DATE_END>=:date_beg and d.DATE_END<=:date_end and')
    Left = 32
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'date_beg'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date_end'
        ParamType = ptUnknown
      end>
  end
  object MtrfQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(d.NVALUE) As Matr'
      'From DH_Order b, DT_Order3 d'
      'Where b.ID = :id and d.ID_RQST = b.ID and d.ID_CALC = 1')
    Left = 72
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object AktQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(a.PRICE*c.NUMBER_F) As Price'
      'From DT_RS a, Spr_Chrt b, DH_Order c'
      'Where c.ID = :id and a.ID_ORD = c.ID and b.ID = c.ID_CHRT'
      'and b.VID_CHRT = :vid')
    Left = 112
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'vid'
        ParamType = ptUnknown
      end>
  end
end
