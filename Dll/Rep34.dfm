object Report34Form: TReport34Form
  Left = 265
  Top = 224
  Width = 498
  Height = 230
  Caption = #1042#1099#1088#1072#1073#1086#1090#1082#1072' '#1087#1086' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
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
    Left = 85
    Top = 20
    Width = 82
    Height = 16
    Caption = #1042#1099#1088#1072#1073#1086#1090#1082#1072' '#1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 278
    Top = 20
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
  object Label4: TLabel
    Left = 57
    Top = 46
    Width = 48
    Height = 13
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 37
    Top = 72
    Width = 67
    Height = 13
    Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 176
    Top = 20
    Width = 98
    Height = 22
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 299
    Top = 20
    Width = 98
    Height = 22
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 1
  end
  object CstCombo: TComboEdit
    Left = 117
    Top = 46
    Width = 297
    Height = 22
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 2
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 117
    Top = 72
    Width = 297
    Height = 22
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object CloseButton: TButton
    Left = 254
    Top = 131
    Width = 72
    Height = 26
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = CloseButtonClick
  end
  object OkButton: TButton
    Left = 176
    Top = 131
    Width = 72
    Height = 26
    Caption = '&'#1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 5
    OnClick = OkButtonClick
  end
  object ComboBox: TComboBox
    Left = 117
    Top = 98
    Width = 221
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102' '#1080' '#1091#1089#1083#1091#1075#1072#1084
    Items.Strings = (
      #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102' '#1080' '#1091#1089#1083#1091#1075#1072#1084
      #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102
      #1087#1086' '#1091#1089#1083#1091#1075#1072#1084)
  end
  object ButtonSelPer: TButton
    Left = 397
    Top = 20
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 7
    OnClick = ButtonSelPerClick
  end
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where (id = :id or code = :code) '
      '')
    Left = 416
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
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where (id = :id or code = :code) ')
    Left = 416
    Top = 72
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
      
        'From REPORT_34_PROCEDURE(:job, :pdr_id, :cst_id, :beg_date, :end' +
        '_date)')
    Left = 384
    Top = 119
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'job'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pdr_id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'cst_id'
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
      end>
  end
end
