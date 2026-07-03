object Report21Form: TReport21Form
  Left = 233
  Top = 186
  Width = 512
  Height = 314
  Caption = #1054#1090#1095#1077#1090' '#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080' '#1087#1083#1072#1085#1072
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
    Left = 57
    Top = 25
    Width = 322
    Height = 29
    Caption = #1054#1090#1095#1077#1090' '#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1080' '#1087#1083#1072#1085#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 192
    Top = 57
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
    Left = 69
    Top = 118
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
    Left = 11
    Top = 143
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
  object ButtonOK: TButton
    Left = 162
    Top = 218
    Width = 112
    Height = 32
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 297
    Top = 218
    Width = 113
    Height = 32
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = ButtonNOClick
  end
  object CstCombo: TComboEdit
    Left = 164
    Top = 117
    Width = 274
    Height = 26
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 2
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 164
    Top = 148
    Width = 274
    Height = 26
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 3
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object MonthComboBox: TComboBox
    Left = 164
    Top = 89
    Width = 176
    Height = 24
    ItemHeight = 16
    TabOrder = 4
  end
  object CheckBox: TCheckBox
    Left = 163
    Top = 187
    Width = 193
    Height = 17
    Caption = #1056#1072#1089#1087#1080#1089#1072#1090#1100' '#1087#1086' '#1089#1090#1072#1090#1100#1103#1084
    TabOrder = 5
  end
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code'
      '')
    Left = 368
    Top = 152
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
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 368
    Top = 200
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
      'Select *'
      'From REPORT_21_PROCEDURE(:pdr, :cst, :period)')
    Left = 24
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pdr'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cst'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'period'
        ParamType = ptUnknown
      end>
  end
  object CalcOperQuery: TQuery
    DatabaseName = 'RMP'
    Left = 24
    Top = 160
  end
  object CalcPMatrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.NUMBER, a.PRICE, b.PRICE'
      'From DT_Mtrp a, Spr_Nmnt b'
      'Where a.id_opp = :id and b.id = a.id_nmnt')
    Left = 24
    Top = 192
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
      '      b.id_pdr =  :pdr'
      '')
    Left = 24
    Top = 224
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pdr'
        ParamType = ptUnknown
      end>
  end
  object CalcFMatrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.NUMBER, a.PRICE, b.PRICE'
      'From DT_MtrF a, Spr_Nmnt b'
      'Where a.id_opf = :id and b.id = a.id_nmnt'
      '')
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
