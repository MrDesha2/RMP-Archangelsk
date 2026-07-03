object Report20Form: TReport20Form
  Left = 242
  Top = 221
  Width = 541
  Height = 321
  Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1085#1077#1079#1072#1074#1077#1088#1096#1077#1085#1085#1086#1075#1086' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
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
    Left = 25
    Top = 25
    Width = 500
    Height = 29
    Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1085#1077#1079#1072#1074#1077#1088#1096#1077#1085#1085#1086#1075#1086' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 192
    Top = 73
    Width = 24
    Height = 26
    Caption = #1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 90
    Top = 105
    Width = 82
    Height = 24
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 31
    Top = 126
    Width = 143
    Height = 48
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object EndDateEdit: TDateEdit
    Left = 230
    Top = 78
    Width = 121
    Height = 25
    NumGlyphs = 2
    TabOrder = 0
  end
  object ButtonOK: TButton
    Left = 149
    Top = 197
    Width = 112
    Height = 33
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 284
    Top = 197
    Width = 114
    Height = 33
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = ButtonNOClick
  end
  object CstCombo: TComboEdit
    Left = 180
    Top = 108
    Width = 280
    Height = 26
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 3
    Text = '<Object not found>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 180
    Top = 135
    Width = 280
    Height = 26
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 4
    Text = '<Object not found>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object CheckBox: TCheckBox
    Left = 181
    Top = 174
    Width = 192
    Height = 17
    Caption = #1056#1072#1089#1087#1080#1089#1072#1090#1100' '#1087#1086' '#1089#1090#1072#1090#1100#1103#1084
    TabOrder = 5
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 32
    Top = 120
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 424
    Top = 184
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
    Left = 424
    Top = 136
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
  object CalcOperQuery: TQuery
    DatabaseName = 'RMP'
    Left = 32
    Top = 152
  end
  object CalcPMatrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.NUMBER, a.PRICE, b.PRICE'
      'From DT_Mtrp a, Spr_Nmnt b'
      'Where a.id_opp = :id and b.id = a.id_nmnt')
    Left = 32
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object ItemQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select  b.nvalue, a.is_int'
      'from spr_calc a, spr_clcmvz b, spr_pdr c'
      'where a.id = b.id_calc and'
      '      b.id_pdr = c.id  and'
      '      a.code = :code  and '
      '      b.id_pdr =  (select c.id'
      
        '                             from dh_order a, dh_rqst b, spr_pdr' +
        ' c'
      '                             where a.id = :idorder and'
      '                                          a.id_rqst = b.id and'
      '                                          c.id = b.id_pdr)'
      ''
      '')
    Left = 32
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'idorder'
        ParamType = ptUnknown
      end>
  end
end
