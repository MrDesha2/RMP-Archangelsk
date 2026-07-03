object Report17Form: TReport17Form
  Left = 192
  Top = 121
  Width = 537
  Height = 231
  Caption = #1054#1090#1095#1077#1090' '#1087#1083#1072#1085'-'#1092#1072#1082#1090' '
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
  object Label3: TLabel
    Left = 82
    Top = 102
    Width = 77
    Height = 24
    Caption = #1059#1095#1072#1089#1090#1086#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 73
    Top = 16
    Width = 411
    Height = 26
    Caption = #1055#1083#1072#1085'-'#1092#1072#1082#1090' '#1087#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1084' '#1079#1072#1082#1072#1079#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PDRCombo: TComboEdit
    Left = 167
    Top = 101
    Width = 287
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 0
    Text = '<Object not found>'
    OnButtonClick = PDRComboButtonClick
    OnKeyDown = PDRComboKeyDown
  end
  object OKButton: TButton
    Left = 208
    Top = 146
    Width = 92
    Height = 31
    Caption = #1054'k'
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 311
    Top = 146
    Width = 93
    Height = 31
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object MonthComboBox: TComboBox
    Left = 201
    Top = 64
    Width = 176
    Height = 24
    ItemHeight = 16
    TabOrder = 3
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 468
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
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select * '
      'From REPORT_17_PROCEDURE(:ID_PDR, :NMONTH)'
      'Order by NAME_PDR, NAME_CST')
    Left = 456
    Top = 144
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_PDR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'NMONTH'
        ParamType = ptUnknown
      end>
  end
end
