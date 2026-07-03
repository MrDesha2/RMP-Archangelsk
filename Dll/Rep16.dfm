object Report16Form: TReport16Form
  Left = 190
  Top = 160
  Width = 481
  Height = 342
  Caption = #1054#1090#1095#1077#1090' '#1076#1083#1103' R/3'
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
    Left = 54
    Top = 20
    Width = 385
    Height = 26
    Caption = #1054#1090#1095#1077#1090' R/3  '#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1091#1089#1083#1091#1075#1072#1093
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 74
    Top = 94
    Width = 9
    Height = 16
    Caption = #1057
  end
  object Label3: TLabel
    Left = 217
    Top = 94
    Width = 16
    Height = 16
    Caption = #1087#1086
  end
  object Label4: TLabel
    Left = 41
    Top = 137
    Width = 32
    Height = 16
    Caption = #1052#1042#1047':'
  end
  object Label5: TLabel
    Left = 41
    Top = 165
    Width = 44
    Height = 16
    Caption = #1054#1090#1073#1086#1088':'
  end
  object PdrCombo: TComboEdit
    Left = 89
    Top = 128
    Width = 336
    Height = 25
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
    Top = 89
    Width = 129
    Height = 25
    ButtonWidth = 26
    NumGlyphs = 2
    TabOrder = 1
  end
  object EndDateEdit: TDateEdit
    Left = 246
    Top = 89
    Width = 149
    Height = 25
    ButtonWidth = 26
    NumGlyphs = 2
    TabOrder = 2
  end
  object OkButton: TButton
    Left = 142
    Top = 249
    Width = 92
    Height = 32
    Caption = #1054#1090#1095#1077#1090
    TabOrder = 3
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 250
    Top = 249
    Width = 92
    Height = 32
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object SelectCombo: TComboBox
    Left = 89
    Top = 160
    Width = 144
    Height = 24
    ItemHeight = 16
    TabOrder = 5
    Items.Strings = (
      #1042#1089#1077
      #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1086
      #1059#1089#1083#1091#1075#1080)
  end
  object CheckBox: TCheckBox
    Left = 89
    Top = 192
    Width = 240
    Height = 17
    Caption = #1057#1074#1077#1088#1085#1091#1090#1099#1081' '#1086#1090#1095#1077#1090
    TabOrder = 6
  end
  object ButtonSelPer: TButton
    Left = 394
    Top = 89
    Width = 31
    Height = 25
    Caption = '...'
    TabOrder = 7
    OnClick = ButtonSelPerClick
  end
  object CheckBox1: TCheckBox
    Left = 89
    Top = 217
    Width = 336
    Height = 16
    Caption = #1042#1099#1074#1077#1089#1090#1080' '#1080#1090#1086#1075#1080' '#1087#1086' '#1085#1077#1087#1083#1072#1085#1086#1074#1099#1084' '#1079#1072#1082#1072#1079#1072#1084
    TabOrder = 8
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 352
    Top = 120
  end
  object XZQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(a.NVALUE) as NVALUE'
      'From DT_Order4 a, DH_Order b'
      'Where b.id = :ID and a.ID_ORDER = b.ID and'
      '             a.ID_CALC = :calc and'
      '              a.LINE_OP in (Select LINENO'
      '                                          From DT_ORDER2'
      
        '                                          Where DATE_END >= :beg' +
        '_date and'
      
        '                                                       DATE_END ' +
        '<=  :end_date  and'
      
        '                                                       ID_ORDER ' +
        '= :id'
      '                                        )')
    Left = 448
    Top = 120
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
        Name = 'beg_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'end_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 296
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
  object MtrfQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select c.NAME, a.NUMBER'
      'From DT_Mtrf a, DH_Order b, Spr_NMNT c'
      'Where b.id = :id and a.ID_OPF = b.ID and c.ID = a.ID_NMNT'
      '')
    Left = 416
    Top = 120
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
    Left = 384
    Top = 120
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
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object SaldoQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select sum(c.nvalue) As nValue'
      'From DT_Order4 c'
      'Where'
      'c.id_order = :id and'
      'c.id_calc = :st  and'
      'c.line_op in (Select b.lineno'
      '                        From DT_Order2 b'
      '                        Where b.id_order = :id and'
      '                                      b.date_end < :end_date)')
    Left = 392
    Top = 152
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'st'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'end_date'
        ParamType = ptUnknown
      end>
  end
  object NumberQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      '')
    Left = 424
    Top = 152
  end
end
