object Report25Form: TReport25Form
  Left = 192
  Top = 121
  Width = 557
  Height = 367
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1087#1083#1072#1085#1086#1074#1086#1081' '#1082#1072#1083#1100#1082#1091#1083#1103#1094#1080#1080' '#1079#1072#1082#1072#1079#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 48
    Top = 25
    Width = 479
    Height = 29
    Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1087#1083#1072#1085#1086#1074#1086#1081' '#1082#1072#1083#1100#1082#1091#1083#1103#1094#1080#1080' '#1079#1072#1082#1072#1079#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 73
    Top = 116
    Width = 63
    Height = 16
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 33
    Top = 139
    Width = 104
    Height = 32
    Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 112
    Top = 73
    Width = 9
    Height = 16
    Caption = #1057
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 265
    Top = 73
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
  object Label2: TLabel
    Left = 266
    Top = 191
    Width = 69
    Height = 16
    Caption = '/'#8470' '#1047#1072#1082#1072#1079#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 69
    Top = 192
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
  object ButtonOK: TButton
    Left = 144
    Top = 226
    Width = 113
    Height = 34
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object ButtonNO: TButton
    Left = 281
    Top = 226
    Width = 112
    Height = 34
    Cancel = True
    Caption = '&'#1054#1090#1084#1077#1085#1072
    TabOrder = 1
    OnClick = ButtonNOClick
  end
  object CstCombo: TComboEdit
    Left = 137
    Top = 108
    Width = 272
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 2
    ID = 0
    CanSelectGroup = False
    OnButtonClick = CstComboButtonClick
    OnKeyDown = CstComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 137
    Top = 146
    Width = 272
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 3
    ID = 0
    CanSelectGroup = False
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object BegDateEdit: TDateEdit
    Left = 134
    Top = 78
    Width = 121
    Height = 25
    ButtonWidth = 25
    NumGlyphs = 2
    TabOrder = 4
  end
  object EndDateEdit: TDateEdit
    Left = 294
    Top = 78
    Width = 121
    Height = 25
    ButtonWidth = 25
    NumGlyphs = 2
    TabOrder = 5
  end
  object RqstEdit: TEdit
    Left = 137
    Top = 185
    Width = 91
    Height = 21
    TabOrder = 6
  end
  object OrderEdit: TEdit
    Left = 350
    Top = 185
    Width = 94
    Height = 21
    TabOrder = 7
  end
  object LabelButton: TButton
    Left = 137
    Top = 267
    Width = 272
    Height = 32
    Hint = 
      #1044#1083#1103' '#1074#1099#1074#1086#1076#1072' '#1071#1088#1083#1099#1082#1072' '#1079#1072#1087#1086#1083#1085#1080#1090#1077' '#1083#1102#1073#1086#1077' '#1087#1086#1083#1077'. '#13#10#1044#1072#1090#1099' '#1087#1088#1080' '#1074#1099#1074#1086#1076#1077' '#1071#1088#1083#1099#1082#1072 +
      ' '#1076#1072#1090#1099' '#1085#1077' '#1091#1095#1080#1090#1099#1074#1072#1102#1090#1089#1103
    Caption = '&'#1071#1088#1083#1099#1082
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    OnClick = LabelButtonClick
  end
  object ButtonSelPer: TButton
    Left = 416
    Top = 76
    Width = 31
    Height = 26
    Caption = '...'
    TabOrder = 9
    OnClick = ButtonSelPerClick
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 424
    Top = 168
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
    Top = 128
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
      
        'From REPORT_25_PROCEDURE(:pdr, :cst, :begdate, :enddate, :rqst, ' +
        ':order)'
      '')
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
        Name = 'begdate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'enddate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'rqst'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'order'
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
      'select a.name, d.price As price_mtrp, a.price As price_spr'
      'from spr_nmnt a, dh_order c, dt_mtrp d'
      'where c.number = :number and'
      '      d.id_opp   = c.id and'
      '      d.id_nmnt  = a.id'
      '')
    Left = 24
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'number'
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
        Name = 'idorder'
        ParamType = ptUnknown
      end>
  end
  object LabelQuery: TQuery
    DatabaseName = 'RMP'
    Left = 88
    Top = 264
  end
  object SizeQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select c.name, b.nsize, b.kind, e.code'
      'From Dh_order d, Spr_chrt a, Spr_chrc b, Spr_Vchr c, spr_ediz e'
      'Where d.id = :id and d.id_chrt = a.id and'
      'a.id =b.id_chrt and b.id_vid = c.id and e.id = c.ed_izm')
    Left = 88
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object LitQuery: TQuery
    DatabaseName = 'RMP'
    Left = 88
    Top = 328
  end
end
