object FilterForm: TFilterForm
  Left = 363
  Top = 189
  Width = 544
  Height = 502
  BorderIcons = [biSystemMenu]
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1092#1080#1083#1100#1090#1088#1072' '#1078#1091#1088#1085#1072#1083#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 526
    Height = 222
    Align = alClient
    AutoSize = True
    TabOrder = 0
    object Label1: TLabel
      Left = 1
      Top = 21
      Width = 109
      Height = 16
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object Label2: TLabel
      Left = 2
      Top = 49
      Width = 66
      Height = 16
      Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    end
    object Label3: TLabel
      Left = 5
      Top = 75
      Width = 143
      Height = 16
      Caption = #1055#1088#1080#1079#1085#1072#1082' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103':'
    end
    object PDRCombo: TComboEdit
      Left = 111
      Top = 16
      Width = 303
      Height = 25
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'spr_pdr'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
      Query = qPDRQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = PDRComboButtonClick
      OnKeyDown = PDRComboKeyDown
    end
    object CSTCombo: TComboEdit
      Left = 111
      Top = 46
      Width = 303
      Height = 24
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 1
      Tablename = 'spr_cst'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' ('#1042#1099#1073#1086#1088')'
      Query = qCSTQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = CSTComboButtonClick
      OnKeyDown = CSTComboKeyDown
    end
    object Pr_execEdit: TRxSpinEdit
      Left = 170
      Top = 73
      Width = 120
      Height = 21
      MaxValue = 3.000000000000000000
      TabOrder = 2
      OnChange = Pr_execEditChange
    end
    object Pr_execCombo: TComboBox
      Left = 295
      Top = 73
      Width = 139
      Height = 24
      ItemHeight = 16
      TabOrder = 3
    end
    object chOnlyPositive: TCheckBox
      Left = 10
      Top = 98
      Width = 424
      Height = 21
      Caption = #1058#1086#1083#1100#1082#1086' '#1087#1086#1083#1086#1078#1080#1090#1077#1083#1100#1085#1099#1081' '#1086#1089#1090#1072#1090#1086#1082' '#1087#1086' '#1078#1091#1088#1085#1072#1083#1091' '#1079#1072#1082#1072#1079#1086#1074
      TabOrder = 4
      Visible = False
    end
    object OperCheckBox: TCheckBox
      Left = 10
      Top = 128
      Width = 359
      Height = 17
      Caption = #1053#1072#1083#1080#1095#1080#1077' '#1085#1077#1085#1086#1088#1084#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1086#1087#1077#1088#1072#1094#1080#1081
      TabOrder = 5
      Visible = False
    end
  end
  object PanelCHRT: TPanel
    Left = 0
    Top = 387
    Width = 526
    Height = 27
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    Visible = False
    object Label4: TLabel
      Left = 26
      Top = 4
      Width = 52
      Height = 16
      Caption = #1063#1077#1088#1090#1077#1078':'
    end
    object CHRTCombo: TComboEdit
      Left = 133
      Top = 1
      Width = 303
      Height = 25
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'spr_chrt'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1063#1077#1088#1090#1077#1078#1080' ('#1042#1099#1073#1086#1088')'
      Query = qCHRTQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = CHRTComboButtonClick
      OnKeyDown = CHRTComboKeyDown
    end
  end
  object PanelBtn: TPanel
    Left = 0
    Top = 414
    Width = 526
    Height = 43
    Align = alBottom
    TabOrder = 2
    object CancelButton: TButton
      Left = 170
      Top = 11
      Width = 146
      Height = 26
      Cancel = True
      Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100' '#1086#1090#1073#1086#1088
      TabOrder = 1
      OnClick = CancelButtonClick
    end
    object OKButton: TButton
      Left = 14
      Top = 11
      Width = 145
      Height = 26
      Caption = '&'#1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1073#1086#1088
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object CloseButton: TButton
      Left = 327
      Top = 11
      Width = 147
      Height = 26
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100' '#1092#1086#1088#1084#1091
      TabOrder = 2
      OnClick = CloseButtonClick
    end
  end
  object PanelWRHS: TPanel
    Left = 0
    Top = 331
    Width = 526
    Height = 56
    Align = alBottom
    AutoSize = True
    TabOrder = 3
    Visible = False
    object Label5: TLabel
      Left = 26
      Top = 4
      Width = 43
      Height = 16
      Caption = #1057#1082#1083#1072#1076':'
    end
    object Label9: TLabel
      Left = 25
      Top = 34
      Width = 100
      Height = 16
      Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
    end
    object WRHSCombo: TComboEdit
      Left = 133
      Top = 1
      Width = 303
      Height = 25
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'spr_WRHS'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1077#1089#1090#1072' '#1093#1088#1072#1085#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
      Query = qWRHSQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = WRHSComboButtonClick
      OnKeyDown = WRHSComboKeyDown
    end
    object NMNTCombo: TComboEdit
      Left = 133
      Top = 31
      Width = 303
      Height = 24
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 1
      Tablename = 'spr_NMNT'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' ('#1042#1099#1073#1086#1088')'
      Query = qNMNTQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = NMNTComboButtonClick
      OnKeyDown = NMNTComboKeyDown
    end
  end
  object PanelOperFltr: TPanel
    Left = 0
    Top = 251
    Width = 526
    Height = 80
    Align = alBottom
    AutoSize = True
    TabOrder = 4
    object Label6: TLabel
      Left = 30
      Top = 5
      Width = 101
      Height = 16
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077':'
    end
    object Label7: TLabel
      Left = 30
      Top = 30
      Width = 90
      Height = 16
      Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100':'
    end
    object Label8: TLabel
      Left = 30
      Top = 53
      Width = 95
      Height = 16
      Caption = #1042#1080#1076' '#1086#1087#1077#1088#1072#1094#1080#1080':'
    end
    object EQPTCombo: TComboEdit
      Left = 133
      Top = 1
      Width = 303
      Height = 25
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'spr_eqpt'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' "'#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077'"'
      Query = qEQPTQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = EQPTComboButtonClick
      OnKeyDown = EQPTComboKeyDown
    end
    object WRKRCombo: TComboEdit
      Left = 133
      Top = 27
      Width = 303
      Height = 25
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 1
      Tablename = 'spr_WRKR'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1056#1072#1073#1086#1090#1085#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
      Query = qWRKRQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = WRKRComboButtonClick
      OnKeyDown = WRKRComboKeyDown
    end
    object VOPCombo: TComboEdit
      Left = 133
      Top = 54
      Width = 303
      Height = 25
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 2
      Tablename = 'spr_VOP'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1056#1072#1073#1086#1090#1085#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
      Query = qVOPQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = VOPComboButtonClick
      OnKeyDown = VOPComboKeyDown
    end
  end
  object PanelDate: TPanel
    Left = 0
    Top = 222
    Width = 526
    Height = 29
    Align = alBottom
    AutoSize = True
    TabOrder = 5
    Visible = False
    object Label10: TLabel
      Left = 10
      Top = 7
      Width = 250
      Height = 16
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103'                                           '#1087#1086
    end
    object FromDateEdit: TDateEdit
      Left = 118
      Top = 2
      Width = 149
      Height = 26
      ButtonWidth = 25
      NumGlyphs = 2
      TabOrder = 0
    end
    object ToDateEdit: TDateEdit
      Left = 286
      Top = 2
      Width = 148
      Height = 26
      ButtonWidth = 25
      NumGlyphs = 2
      TabOrder = 1
    end
    object Button1: TButton
      Left = 433
      Top = 1
      Width = 26
      Height = 26
      Caption = '...'
      TabOrder = 2
      OnClick = Button1Click
    end
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_pdr where id = :id  or code = :code')
    Left = 467
    Top = 10
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
      'select id, parentid, code, name'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 464
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'code'
        ParamType = ptUnknown
      end>
  end
  object qCHRTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 480
    Top = 216
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
  object qWRHSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_wrhs'
      'where id = :id or code = :code')
    Left = 480
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
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code,name'
      'from spr_eqpt'
      'where id = :id or code = :code')
    Left = 472
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
  object qWRKRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, code, name'
      'from spr_wrkr'
      'where id = :id or code = :code')
    Left = 472
    Top = 144
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
  object qVOPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_vop'
      'where id = :id or code = :code')
    Left = 504
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
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_nmnt'
      'where id = :id or code = :code')
    Left = 512
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
end
