object Param_Form: TParam_Form
  Left = 303
  Top = 188
  Width = 391
  Height = 424
  HelpContext = 510
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label15: TLabel
    Left = 8
    Top = 89
    Width = 95
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1083#1091#1078#1073#1099':'
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 383
    Height = 347
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1057#1080#1089#1090#1077#1084#1072
      object Label11: TLabel
        Left = 8
        Top = 200
        Width = 88
        Height = 13
        Caption = #1060#1072#1081#1083' '#1085#1072#1089#1090#1088#1086#1081#1082#1080':'
      end
      object FileINI: TLabel
        Left = 106
        Top = 200
        Width = 30
        Height = 13
        Caption = 'INI file'
      end
      object LabelUserName: TLabel
        Left = 8
        Top = 224
        Width = 22
        Height = 13
        Caption = 'User'
      end
      object GroupBox: TGroupBox
        Left = 0
        Top = 0
        Width = 375
        Height = 129
        Align = alTop
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083#1099' '#1078#1091#1088#1085#1072#1083#1086#1074
        TabOrder = 0
        object Label1: TLabel
          Left = 11
          Top = 24
          Width = 109
          Height = 13
          Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1078#1091#1088#1085#1072#1083#1072' '#1089':'
        end
        object Label2: TLabel
          Left = 228
          Top = 24
          Width = 15
          Height = 13
          Caption = #1087#1086':'
        end
        object Label3: TLabel
          Left = 12
          Top = 43
          Width = 108
          Height = 26
          Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1083#1072#1085#1086#1074#1086#1075#1086' '#1078#1091#1088#1085#1072#1083#1072':'
          WordWrap = True
        end
        object Label4: TLabel
          Left = 12
          Top = 70
          Width = 155
          Height = 26
          Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1086#1075#1086' '#1078#1091#1088#1085#1072#1083#1072':'
          WordWrap = True
        end
        object Label5: TLabel
          Left = 14
          Top = 98
          Width = 71
          Height = 13
          Caption = #1056#1072#1073#1086#1095#1072#1103' '#1076#1072#1090#1072':'
        end
        object DateFromEdit: TDateEdit
          Left = 128
          Top = 21
          Width = 97
          Height = 21
          NumGlyphs = 2
          TabOrder = 0
          OnChange = DateFromEditChange
        end
        object DateToEdit: TDateEdit
          Left = 249
          Top = 21
          Width = 96
          Height = 21
          NumGlyphs = 2
          TabOrder = 1
          OnChange = DateFromEditChange
        end
        object BoxPlanPeriod: TComboBox
          Left = 171
          Top = 48
          Width = 191
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
          OnChange = BoxPlanPeriodChange
        end
        object BoxFactPeriod: TComboBox
          Left = 171
          Top = 72
          Width = 191
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
          OnChange = BoxPlanPeriodChange
        end
        object WorkDateEdit: TDateEdit
          Left = 171
          Top = 95
          Width = 105
          Height = 21
          NumGlyphs = 2
          TabOrder = 4
          OnChange = DateFromEditChange
        end
      end
      object SelPeriodButton: TButton
        Left = 344
        Top = 20
        Width = 21
        Height = 21
        Caption = '...'
        TabOrder = 1
        OnClick = SelPeriodButtonClick
      end
      object OPENALLFORMMAXIMIZED: TCheckBox
        Left = 8
        Top = 176
        Width = 185
        Height = 17
        Caption = #1054#1090#1082#1088#1099#1074#1072#1090#1100' '#1086#1082#1085#1072' '#1085#1072' '#1084#1072#1082#1089#1080#1084#1091#1084
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 137
        Width = 375
        Height = 182
        Align = alClient
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        TabOrder = 0
        object Label6: TLabel
          Left = 8
          Top = 14
          Width = 77
          Height = 26
          Caption = #1057#1082#1083#1072#1076' '#1075#1086#1090#1086#1074#1086#1081' '#13#10#1087#1088#1086#1076#1091#1082#1094#1080#1080':'
        end
        object Label7: TLabel
          Left = 8
          Top = 45
          Width = 105
          Height = 13
          Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
        end
        object Label8: TLabel
          Left = 8
          Top = 72
          Width = 108
          Height = 13
          Caption = #1047#1072#1074#1086#1076' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102':'
        end
        object Label9: TLabel
          Left = 8
          Top = 99
          Width = 101
          Height = 13
          Caption = #1052#1042#1055' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102':'
        end
        object Label10: TLabel
          Left = 8
          Top = 126
          Width = 100
          Height = 13
          Caption = #1057#1095#1077#1090' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102':'
        end
        object Label12: TLabel
          Left = 8
          Top = 148
          Width = 113
          Height = 26
          Caption = #1057#1090#1072#1090#1100#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102':'
          WordWrap = True
        end
        object WRHSCombo: TComboEdit
          Left = 136
          Top = 16
          Width = 233
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 0
          Tablename = 'SPR_WRHS'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1077#1089#1090#1072' '#1093#1088#1072#1085#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
          Query = qWRHSQuery
          ID = -1
          OnButtonClick = WRHSComboButtonClick
          OnKeyDown = WRHSComboKeyDown
        end
        object EDIZCombo: TComboEdit
          Left = 136
          Top = 42
          Width = 233
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 1
          Tablename = 'SPR_EDIZ'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
          Query = qEDIZQuery
          ID = -1
          OnButtonClick = EDIZComboButtonClick
          OnKeyDown = EDIZComboKeyDown
        end
        object PlantCombo: TComboEdit
          Left = 136
          Top = 68
          Width = 232
          Height = 22
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 2
          Tablename = 'SPR_PLANT'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1047#1072#1074#1086#1076#1099' ('#1042#1099#1073#1086#1088')'
          Query = qPlantQuery
          ID = -1
          OnButtonClick = PlantComboButtonClick
          OnKeyDown = PlantComboKeyDown
        end
        object MVPCombo: TComboEdit
          Left = 136
          Top = 95
          Width = 232
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 3
          Tablename = 'SPR_MVP'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1055' ('#1042#1099#1073#1086#1088')'
          Query = qMVPQuery
          ID = -1
          OnButtonClick = MVPComboButtonClick
          OnKeyDown = MVPComboKeyDown
        end
        object CountCombo: TComboEdit
          Left = 136
          Top = 121
          Width = 232
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 4
          Tablename = 'SPR_COUNT'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1057#1095#1077#1090#1072' ('#1042#1099#1073#1086#1088')'
          Query = qCountQuery
          ID = -1
          OnButtonClick = CountComboButtonClick
          OnKeyDown = CountComboKeyDown
        end
        object StatCombo: TComboEdit
          Left = 136
          Top = 148
          Width = 232
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 5
          Tablename = 'SPR_STAT'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1057#1090#1072#1090#1100#1080' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
          Query = qStatQuery
          ID = -1
          OnButtonClick = StatComboButtonClick
          OnKeyDown = StatComboKeyDown
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 375
        Height = 137
        Align = alTop
        Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
        TabOrder = 1
        object Label13: TLabel
          Left = 8
          Top = 16
          Width = 121
          Height = 13
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080':'
        end
        object Label14: TLabel
          Left = 8
          Top = 41
          Width = 95
          Height = 13
          Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1083#1091#1078#1073#1099':'
        end
        object Label16: TLabel
          Left = 8
          Top = 65
          Width = 93
          Height = 13
          Caption = #1043#1083#1072#1074#1085#1099#1081' '#1084#1077#1093#1072#1085#1080#1082':'
        end
        object Label17: TLabel
          Left = 8
          Top = 89
          Width = 132
          Height = 13
          Caption = #1053#1072#1095#1072#1083#1100#1085#1080#1082' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072':'
        end
        object Label18: TLabel
          Left = 8
          Top = 113
          Width = 59
          Height = 13
          Caption = #1069#1082#1086#1085#1086#1084#1080#1089#1090':'
        end
        object EditEnt: TEdit
          Left = 140
          Top = 13
          Width = 220
          Height = 21
          TabOrder = 0
        end
        object EditServ: TEdit
          Left = 140
          Top = 37
          Width = 220
          Height = 21
          TabOrder = 1
        end
        object EditEcon: TEdit
          Left = 140
          Top = 108
          Width = 220
          Height = 21
          TabOrder = 2
        end
        object EditManager: TEdit
          Left = 140
          Top = 85
          Width = 220
          Height = 21
          TabOrder = 3
        end
        object EditMech: TEdit
          Left = 140
          Top = 60
          Width = 220
          Height = 21
          TabOrder = 4
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1055#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077
      ImageIndex = 2
      object Label19: TLabel
        Left = 12
        Top = 28
        Width = 84
        Height = 13
        Caption = #1056#1072#1073#1086#1095#1080#1081'  '#1076#1077#1085#1100'  '#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 194
        Top = 28
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
      object DinnerLabelFrom: TLabel
        Left = 12
        Top = 58
        Width = 84
        Height = 13
        Caption = #1042#1088#1077#1084#1103'   '#1086#1073#1077#1076#1072'  '#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DinnerLabelTo: TLabel
        Left = 194
        Top = 57
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
      object WorkDateTimeBeg: TDateTimePicker
        Left = 109
        Top = 24
        Width = 79
        Height = 21
        Date = 38538.000000000000000000
        Time = 38538.000000000000000000
        Kind = dtkTime
        TabOrder = 0
      end
      object WorkDateTimeEnd: TDateTimePicker
        Left = 213
        Top = 24
        Width = 79
        Height = 21
        Date = 38538.000000000000000000
        Time = 38538.000000000000000000
        Kind = dtkTime
        TabOrder = 1
      end
      object DinnerDateTimeFrom: TDateTimePicker
        Left = 109
        Top = 54
        Width = 79
        Height = 21
        Date = 38538.000000000000000000
        Time = 38538.000000000000000000
        Kind = dtkTime
        TabOrder = 2
      end
      object DinnerDateTimeTo: TDateTimePicker
        Left = 213
        Top = 54
        Width = 79
        Height = 21
        Date = 38538.000000000000000000
        Time = 38538.000000000000000000
        Kind = dtkTime
        TabOrder = 3
      end
    end
  end
  object PanelBot: TPanel
    Left = 0
    Top = 347
    Width = 383
    Height = 43
    Align = alBottom
    TabOrder = 1
    object OKButton: TButton
      Left = 15
      Top = 9
      Width = 74
      Height = 26
      Caption = 'OK'
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object CancelButton: TButton
      Left = 94
      Top = 9
      Width = 76
      Height = 26
      Cancel = True
      Caption = '&'#1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = CancelButtonClick
    end
  end
  object qWRHSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrhs '
      'where id = :id or code = :code')
    Left = 480
    Top = 32
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
  object qEDIZQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_ediz'
      'where id = :id or code = :code')
    Left = 480
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
  object qPlantQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_plant'
      'where id = :id or code = :code')
    Left = 480
    Top = 160
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
  object qMVPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_mvp'
      'where id = :id or code = :code')
    Left = 480
    Top = 64
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
  object qCountQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_count'
      'where id = :id or code = :code')
    Left = 480
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
  object qStatQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_stat'
      'where id = :id or code = :code')
    Left = 480
    Top = 192
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
