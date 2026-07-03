object Report27Form: TReport27Form
  Left = 566
  Top = 509
  Width = 530
  Height = 396
  Caption = #1054#1090#1095#1077#1090' '#1076#1083#1103' R/3 '#1087#1086' '#1085#1077#1079#1072#1074#1077#1088#1096#1077#1085#1082#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
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
  object Label1: TLabel
    Left = 14
    Top = 28
    Width = 484
    Height = 26
    Caption = #1054#1090#1095#1077#1090' R/3  '#1086' '#1085#1077#1079#1072#1074#1077#1088#1096#1077#1085#1085#1086#1084' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 74
    Top = 102
    Width = 9
    Height = 16
    Caption = #1057
  end
  object Label3: TLabel
    Left = 236
    Top = 102
    Width = 16
    Height = 16
    Caption = #1087#1086
  end
  object Label4: TLabel
    Left = 41
    Top = 145
    Width = 32
    Height = 16
    Caption = #1052#1042#1047':'
  end
  object Label5: TLabel
    Left = 41
    Top = 173
    Width = 44
    Height = 16
    Caption = #1054#1090#1073#1086#1088':'
  end
  object PdrCombo: TComboEdit
    Left = 89
    Top = 136
    Width = 336
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 0
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object BegDateEdit: TDateEdit
    Left = 89
    Top = 97
    Width = 138
    Height = 25
    ButtonWidth = 26
    NumGlyphs = 2
    TabOrder = 1
  end
  object EndDateEdit: TDateEdit
    Left = 276
    Top = 97
    Width = 118
    Height = 25
    ButtonWidth = 26
    NumGlyphs = 2
    TabOrder = 2
  end
  object OkButton: TButton
    Left = 142
    Top = 281
    Width = 92
    Height = 32
    Caption = #1054#1090#1095#1077#1090
    TabOrder = 3
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 250
    Top = 281
    Width = 92
    Height = 32
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object SelectCombo: TComboBox
    Left = 89
    Top = 168
    Width = 144
    Height = 24
    ItemHeight = 16
    TabOrder = 5
    Items.Strings = (
      #1042#1089#1077
      #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086
      #1059#1089#1083#1091#1075#1080)
  end
  object OperCheckBox: TCheckBox
    Left = 88
    Top = 200
    Width = 297
    Height = 17
    Hint = #1044#1077#1090#1072#1083#1080#1079#1080#1088#1091#1077#1090' '#1085#1077#1079#1072#1074#1077#1088#1096#1077#1085#1085#1086#1077' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' '#1087#1086' '#1086#1087#1077#1088#1072#1094#1080#1103#1084
    Caption = #1057' '#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1086#1081' '#1087#1086' '#1086#1087#1077#1088#1072#1094#1080#1103#1084
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = OperCheckBoxClick
  end
  object SmallCheckBox: TCheckBox
    Left = 88
    Top = 225
    Width = 297
    Height = 16
    Hint = #1044#1077#1090#1072#1083#1080#1079#1080#1088#1091#1077#1090' '#1085#1077#1079#1072#1074#1077#1088#1096#1077#1085#1085#1086#1077' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086' '#1087#1086' '#1086#1087#1077#1088#1072#1094#1080#1103#1084
    Caption = #1057#1074#1077#1088#1085#1091#1090#1099#1081' '#1086#1090#1095#1077#1090
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = SmallCheckBoxClick
  end
  object ButtonSelPer: TButton
    Left = 396
    Top = 94
    Width = 30
    Height = 26
    Caption = '...'
    TabOrder = 8
    OnClick = ButtonSelPerClick
  end
  object CheckBox1: TCheckBox
    Left = 89
    Top = 248
    Width = 336
    Height = 17
    Caption = #1042#1099#1074#1077#1089#1090#1080' '#1080#1090#1086#1075#1080' '#1087#1086' '#1085#1077#1087#1083#1072#1085#1086#1074#1099#1084' '#1079#1072#1082#1072#1079#1072#1084
    TabOrder = 9
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 448
    Top = 96
  end
  object XZQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.NVALUE'
      'From DT_Order4 a, DH_Order b'
      'Where b.id = :id and a.ID_ORDER = b.ID and '
      '          a.ID_CALC = :calc and a.LINE_OP = :lineno')
    Left = 448
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'calc'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'lineno'
        ParamType = ptUnknown
      end>
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 296
    Top = 120
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
  object MtrfQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select c.NAME, a.NUMBER'
      'From DT_Mtrf a, DH_Order b, Spr_NMNT c, DT_Order e'
      'Where b.id = :id and '
      '           e.id_order = b.id and'
      '           e.lineno = a.lineno and'
      '          a.ID_OPF = b.ID and '
      '          c.ID = a.ID_NMNT'
      '')
    Left = 448
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object NmntQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.NAME, a.CODE'
      'From Spr_Nmnt a, DH_Order b'
      'Where b.ID = :id and a.ID = b.ID_NMNT')
    Left = 448
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object NamePdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select NAME, ID, CODE'
      'From Spr_Pdr'
      'Where ID = :id')
    Left = 352
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object ZakQuery: TQuery
    DatabaseName = 'RMP'
    Left = 488
    Top = 96
  end
  object NumberQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select count(distinct b.ID) As Num, Sum(b.sum_doc) As SumDoc'
      'From DT_Order2 a, DH_Order b'
      'Where a.DATE_END>=:date_beg and'
      '            a.DATE_END<=:date_end and'
      '            b.ID = a.id_order     and'
      '            b.PR_EXEC = 2     and'
      '           b.weight_f = :Value')
    Left = 488
    Top = 128
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
      end
      item
        DataType = ftUnknown
        Name = 'Value'
        ParamType = ptUnknown
      end>
  end
end
