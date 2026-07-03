object JR_OPERForm: TJR_OPERForm
  Left = 193
  Top = 171
  Width = 765
  Height = 522
  Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1099#1081' '#1078#1091#1088#1085#1072#1083' '#1079#1072#1082#1072#1079#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object JROperGrid: TDBGridEh
    Left = 0
    Top = 29
    Width = 757
    Height = 399
    Align = alClient
    AutoFitColWidths = True
    DataSource = JROperDataSource
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -12
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentFont = False
    ParentShowHint = False
    PopupMenu = TableMenu
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDblClick = JROperGridDblClick
    OnKeyDown = JROperGridKeyDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'NUMBER'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
        Width = 111
      end
      item
        EditButtons = <>
        FieldName = 'OPER_NAME'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
        Width = 176
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'LINENO'
        Footers = <>
        Title.Caption = #8470' '#1086#1087#1077#1088#1072#1094#1080#1080
        Width = 81
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'DATE_IN'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
        Width = 83
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'TIME_IN'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1042#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072
        Width = 102
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'DATE_OUT'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1044#1072#1090#1072' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
        Width = 52
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'TIME_OUT'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1042#1088#1077#1084#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
        Width = 52
      end
      item
        EditButtons = <>
        FieldName = 'WRKR_NAME'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = #1060#1048#1054' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103
        Width = 52
      end>
  end
  object PanelBot: TPanel
    Left = 0
    Top = 428
    Width = 757
    Height = 40
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = CloseButtonClick
    end
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 757
    Height = 29
    ButtonWidth = 25
    Caption = 'FormToolBar'
    Flat = True
    Images = MAINForm.JRImageList
    TabOrder = 2
    object ToolButtonAdd: TToolButton
      Left = 0
      Top = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079
      Caption = 'ToolButtonAdd'
      Enabled = False
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButtonEdit: TToolButton
      Left = 25
      Top = 0
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1082#1072#1079
      Caption = 'ToolButtonEdit'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = JROperGridDblClick
    end
    object ToolButtonDel: TToolButton
      Left = 50
      Top = 0
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1082#1072#1079
      Caption = 'ToolButtonDel'
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButtonFilter: TToolButton
      Left = 75
      Top = 0
      Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1086#1090#1073#1086#1088#1072' '#1078#1091#1088#1085#1072#1083#1072
      Caption = 'ToolButtonFilter'
      ImageIndex = 6
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButtonFilterClick
    end
    object PeriodBox: TComboBox
      Left = 100
      Top = 0
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = PeriodBoxChange
    end
    object ToolButton2: TToolButton
      Left = 245
      Top = 0
      Hint = #1057#1084#1077#1085#1080#1090#1100' '#1087#1077#1088#1080#1086#1076
      Caption = 'ToolButton2'
      ImageIndex = 9
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton2Click
    end
    object PlanButton: TToolButton
      Left = 270
      Top = 0
      Hint = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      Caption = 'PlanButton'
      ImageIndex = 10
      ParentShowHint = False
      ShowHint = True
      Style = tbsDropDown
    end
    object Searchkey: TEdit
      Left = 308
      Top = 0
      Width = 205
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object FindButton: TButton
      Left = 513
      Top = 0
      Width = 16
      Height = 22
      Hint = #1053#1072#1081#1090#1080
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = FindButtonClick
    end
    object ToolButton1: TToolButton
      Left = 529
      Top = 0
      Caption = 'ToolFindDown'
      ImageIndex = 7
    end
    object ToolButton3: TToolButton
      Left = 554
      Top = 0
      Caption = 'ToolFindUp'
      ImageIndex = 8
    end
  end
  object ActionList: TActionList
    Left = 128
    Top = 150
    object acFindNext: TAction
      Caption = 'acFindNext'
      ShortCut = 32882
    end
    object acFindPrior: TAction
      Caption = 'acFindPrior'
      ShortCut = 32881
    end
    object acFind: TAction
      Caption = 'acFind'
      ShortCut = 114
    end
  end
  object TableMenu: TPopupMenu
    Images = MAINForm.JRImageList
    Left = 168
    Top = 152
    object MenuEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
    end
    object MenuDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuInt: TMenuItem
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083
      Hint = #1048#1085#1090#1077#1088#1074#1072#1083
      ImageIndex = 3
    end
    object MenuSel: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1073#1086#1088
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1073#1086#1088
      ImageIndex = 6
    end
    object MenuInsertSub: TMenuItem
      Caption = #1042#1074#1077#1089#1090#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
      Hint = #1042#1074#1077#1089#1090#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
      object MenuInsertOrder: TMenuItem
        Caption = #1047#1072#1082#1072#1079
        Hint = #1047#1072#1082#1072#1079
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MenuInsertWRHS: TMenuItem
        Caption = #1043#1086#1090#1086#1074#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
        Hint = #1043#1086#1090#1086#1074#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
      end
      object MenuInsertWRHSOut: TMenuItem
        Caption = #1056#1072#1089#1093#1086#1076#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
      end
    end
    object MenuRefresh: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
    end
    object MenuStucDoc: TMenuItem
      Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1087#1086#1076#1095#1080#1085#1077#1085#1085#1086#1089#1090#1080
      Hint = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1087#1086#1076#1095#1080#1085#1077#1085#1085#1086#1089#1090#1080
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MenuByWidth: TMenuItem
      Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
      Checked = True
      Hint = #1055#1086' '#1096#1080#1088#1080#1085#1077
    end
    object MenuMultiSelect: TMenuItem
      Caption = #1042#1099#1073#1080#1088#1072#1090#1100' '#1085#1077#1089#1082#1086#1083#1100#1082#1086' '#1089#1090#1088#1086#1082
      Checked = True
      Hint = #1042#1099#1073#1080#1088#1072#1090#1100' '#1085#1077#1089#1082#1086#1083#1100#1082#1086' '#1089#1090#1088#1086#1082
    end
  end
  object MainMenu: TMainMenu
    Images = MAINForm.JRImageList
    Left = 200
    Top = 152
    object N3: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      GroupIndex = 1
      object MainMenuEdit: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        ImageIndex = 1
      end
      object MainMenuDel: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        ImageIndex = 2
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MainMenuInt: TMenuItem
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083
        ImageIndex = 3
      end
      object MainMenuSel: TMenuItem
        Caption = #1054#1090#1073#1086#1088
        ImageIndex = 6
      end
      object MainMenuRefresh: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ShortCut = 116
        OnClick = MainMenuRefreshClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object MainMenuByWidth: TMenuItem
        Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
        Checked = True
      end
    end
  end
  object JROperQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select * '
      'from BROWSE_OPER_PROC(60,-1, -1)')
    Left = 320
    Top = 152
  end
  object JROperDataSource: TDataSource
    DataSet = JROperQuery
    Left = 352
    Top = 152
  end
end
