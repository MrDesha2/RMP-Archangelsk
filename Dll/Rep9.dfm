object Report9Form: TReport9Form
  Left = 206
  Top = 215
  Width = 447
  Height = 359
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1084' '#1088#1072#1073#1086#1090#1072#1084
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
    Left = 49
    Top = 20
    Width = 324
    Height = 24
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1084' '#1088#1072#1073#1086#1090#1072#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 20
    Top = 106
    Width = 57
    Height = 16
    Caption = #1059#1095#1072#1089#1090#1086#1082':'
  end
  object Label2: TLabel
    Left = 73
    Top = 73
    Width = 9
    Height = 16
    Caption = 'C'
  end
  object Label4: TLabel
    Left = 218
    Top = 71
    Width = 16
    Height = 16
    Caption = #1087#1086
  end
  object Label5: TLabel
    Left = 20
    Top = 138
    Width = 66
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
  end
  object Label6: TLabel
    Left = 7
    Top = 161
    Width = 78
    Height = 16
    Caption = #1058#1080#1087' '#1079#1072#1082#1072#1079#1072':'
  end
  object PDRCombo: TComboEdit
    Left = 89
    Top = 101
    Width = 316
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 2
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = PDRComboButtonClick
    OnKeyDown = PDRComboKeyDown
  end
  object OKButton: TButton
    Left = 134
    Top = 267
    Width = 92
    Height = 31
    Caption = #1054'k'
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 238
    Top = 267
    Width = 92
    Height = 31
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = CancelButtonClick
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
    Left = 256
    Top = 70
    Width = 119
    Height = 26
    NumGlyphs = 2
    TabOrder = 1
  end
  object CSTCombo: TComboEdit
    Left = 89
    Top = 129
    Width = 316
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = CSTComboButtonClick
    OnKeyDown = CSTComboKeyDown
  end
  object RadioGroup1: TRadioGroup
    Left = 89
    Top = 190
    Width = 321
    Height = 72
    Caption = #1057#1073#1086#1088' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086
    TabOrder = 8
  end
  object RadioButton2: TRadioButton
    Left = 96
    Top = 238
    Width = 304
    Height = 17
    Caption = #1058#1088#1077#1073#1086#1074#1072#1085#1080#1103'-'#1085#1072#1082#1083#1072#1076#1085#1099#1077' + '#1040#1082#1090#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = RadioButton2Click
  end
  object RadioButton1: TRadioButton
    Left = 96
    Top = 214
    Width = 304
    Height = 16
    Caption = #1055#1088#1080#1077#1084#1086'-'#1089#1076#1072#1090#1086#1095#1085#1099#1077' '#1085#1072#1082#1083#1072#1076#1085#1099#1077' + '#1040#1082#1090#1099
    Checked = True
    TabOrder = 7
    TabStop = True
    OnClick = RadioButton1Click
  end
  object ButtonSelPer: TButton
    Left = 374
    Top = 71
    Width = 31
    Height = 26
    Caption = '...'
    TabOrder = 9
    OnClick = ButtonSelPerClick
  end
  object Type_Zak_ComboBox: TComboBox
    Left = 89
    Top = 158
    Width = 316
    Height = 24
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 10
    Text = #1057#1074#1086#1076#1085#1099#1081
    Items.Strings = (
      #1057#1074#1086#1076#1085#1099#1081
      #1055#1083#1072#1085#1086#1074#1099#1077' '#1079#1072#1082#1072#1079#1099
      #1043#1086#1076#1086#1074#1099#1077' '#1079#1072#1082#1072#1079#1099
      #1042#1085#1077#1087#1083#1072#1085#1086#1074#1099#1077' '#1079#1072#1082#1072#1079#1099)
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 356
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
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.CODE, a.NAME, Sum(d.PRICE) As Fakt'
      'From Spr_Cst a, DH_Order b, DH_Rqst c, '
      'DT_Order2 d,  Spr_Pdr f'
      'Where d.DATE_END>=:date_beg and '
      'd.DATE_END<=:date_end and b.ID=d.ID_ORDER and '
      'c.ID = b.ID_RQST  and '
      'a.ID = c.ID_CST and f.ID = c.ID_PDR'
      ''
      'Group by a.CODE, a.NAME, f.NAME'
      'Order by 3')
    Left = 8
    Top = 256
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
      'Where b.ID = :id and d.ID_RQST = b.ID and d.ID_CALC = 1'
      '')
    Left = 40
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object qCSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 356
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
  object AktQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(a.PRICE*c.NUMBER_F) As Price'
      'From DT_RS a, Spr_Chrt b, DH_Order c'
      'Where c.ID = :id and a.ID_ORD = c.ID and b.ID = c.ID_CHRT'
      'and b.VID_CHRT = :vid')
    Left = 72
    Top = 256
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
  object TimeQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.id, a.NUMBER_F, sum(b.ntime)/1000 as nTime'
      'From Dh_Order a, DT_Order2 b'
      'Where a.id = b.id_order and a.id = :id'
      'Group by a.id, a.NUMBER_F')
    Left = 104
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object TimePlanQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.id, a.NUMBER_F, sum(b.ntime)/1000 as nTime'
      'From Dh_Order a, DT_Order1 b'
      'Where a.id = b.id_order and a.id = :id'
      'Group by a.id, a.NUMBER_F')
    Left = 104
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
