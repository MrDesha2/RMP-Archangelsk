object JR_ORDERForm: TJR_ORDERForm
  Left = 191
  Top = 193
  Width = 800
  Height = 522
  HelpContext = 320
  ActiveControl = JROrderGrid
  Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072#1082#1072#1079#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDblClick = ToolButtonEditClick
  OnKeyDown = FormKeyDown
  PixelsPerInch = 120
  TextHeight = 16
  object PanelBot: TPanel
    Left = 0
    Top = 403
    Width = 782
    Height = 49
    Align = alBottom
    TabOrder = 3
    object CloseButton: TButton
      Left = 20
      Top = 10
      Width = 92
      Height = 31
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = CloseButtonClick
    end
    object OKButton: TButton
      Left = 118
      Top = 10
      Width = 92
      Height = 31
      Caption = '&'#1054#1050
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object RefreshButton: TButton
      Left = 847
      Top = 10
      Width = 92
      Height = 31
      Caption = #1054'&'#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 2
      OnClick = RefreshButtonClick
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 34
    Align = alTop
    TabOrder = 2
    object ToolBar1: TToolBar
      Left = 1
      Top = 1
      Width = 780
      Height = 29
      ButtonHeight = 24
      Caption = 'JR_OrderToolBar'
      Flat = True
      Images = MAINForm.JRImageList
      TabOrder = 0
      object ToolButtonAdd: TToolButton
        Left = 0
        Top = 0
        Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
        Caption = 'ToolButtonEdit'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonEditClick
      end
      object ToolButtonDel: TToolButton
        Left = 23
        Top = 0
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
        Caption = 'ToolButtonDel'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonDelClick
      end
      object ToolButtonInt: TToolButton
        Left = 46
        Top = 0
        Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
        Caption = 'ToolButtonInt'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonIntClick
      end
      object ToolButtonFilter: TToolButton
        Left = 69
        Top = 0
        Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1092#1080#1083#1100#1090#1088#1072
        Caption = 'ToolButton'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonFilterClick
      end
      object ToolButtonHelp: TToolButton
        Left = 92
        Top = 0
        Hint = #1055#1086#1084#1086#1097#1100
        Caption = 'ToolButtonHelp'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonHelpClick
      end
      object Searchkey: TEdit
        Left = 115
        Top = 0
        Width = 205
        Height = 24
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyPress = SearchkeyKeyPress
      end
      object FindButton: TButton
        Left = 320
        Top = 0
        Width = 16
        Height = 24
        Hint = #1053#1072#1081#1090#1080
        Caption = '...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = ToolFindDownClick
      end
      object ToolFindDown: TToolButton
        Left = 336
        Top = 0
        Hint = #1055#1086#1080#1089#1082#13#10#1074#1085#1080#1079
        Caption = 'ToolFindDown'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolFindDownClick
      end
      object ToolFindUp: TToolButton
        Left = 359
        Top = 0
        Hint = #1055#1086#1080#1089#1082' '#13#10#1074#1074#1077#1088#1093
        Caption = 'ToolFindUp'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolFindUpClick
      end
      object chUpdateJROrder: TCheckBox
        Left = 382
        Top = 0
        Width = 195
        Height = 24
        Hint = 
          #1055#1088#1080' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1080' '#1079#1072#1082#1072#1079#1072' '#13#10#1086#1073#1085#1086#1074#1083#1103#1090#1100' '#1078#1091#1088#1085#1072#1083' '#1079#1072#1082#1072#1079#1086#1074#13#10'('#1074#1083#1080#1103#1077#1090' '#1085#1072' '#1089#1082#1086 +
          #1088#1086#1089#1090#1100' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103')'
        Caption = #1054#1073#1085#1086#1074#1083#1103#1090#1100' '#1078#1091#1088#1085#1072#1083' '#1087#1088#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1080
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = chUpdateJROrderClick
      end
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 34
    Width = 782
    Height = 369
    Align = alClient
    TabOrder = 1
  end
  object JROrderGrid: TDBGridEh
    Left = 0
    Top = 34
    Width = 782
    Height = 369
    Align = alClient
    AutoFitColWidths = True
    DataSource = FormOrderSource
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -15
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
    TitleFont.Height = -15
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDblClick = ToolButtonEditClick
    OnKeyDown = JROrderGridKeyDown
    OnTitleBtnClick = JROrderGridTitleBtnClick
    Columns = <
      item
        EditButtons = <>
        FieldName = 'NUMBER'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
        Title.TitleButton = True
        Width = 60
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'DATE_IN'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
        Title.TitleButton = True
        Width = 91
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = 'DATE_OUT'
        Footers = <>
        Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
        Title.TitleButton = True
        Width = 111
      end
      item
        EditButtons = <>
        FieldName = 'NAME_PDR'
        Footers = <>
        Title.Caption = #1052#1042#1047' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
        Title.TitleButton = True
        Width = 168
      end
      item
        EditButtons = <>
        FieldName = 'NAME_PDR_1'
        Footers = <>
        Title.Caption = #1054#1090#1074#1077#1090#1089#1074#1077#1085#1085#1099#1081' '#1052#1042#1047
        Title.Hint = #1054#1090#1074#1077#1090#1089#1074#1077#1085#1085#1099#1081' '#1052#1042#1047
        Title.TitleButton = True
      end
      item
        EditButtons = <>
        FieldName = 'CODE_CHRT'
        Footers = <>
        Title.Caption = #1050#1086#1076' '#1095#1077#1088#1090#1077#1078#1072
        Title.TitleButton = True
        Width = 78
      end
      item
        EditButtons = <>
        FieldName = 'NAME_CHRT'
        Footers = <>
        Title.Caption = #1063#1077#1088#1090#1077#1078
        Title.TitleButton = True
        Width = 249
      end
      item
        EditButtons = <>
        FieldName = 'NAME_CST'
        Footers = <>
        Title.Caption = #1047#1072#1082#1072#1079#1095#1080#1082
        Title.TitleButton = True
        Width = 118
      end
      item
        EditButtons = <>
        FieldName = 'PR_EXEC'
        Footers = <>
        ImageList = DATA.Semaphor
        KeyList.Strings = (
          '1'
          '2'
          '3')
        PickList.Strings = (
          '0'
          '1'
          '2')
        Title.Caption = #1055#1088#1080#1079#1085#1072#1082' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
        Title.TitleButton = True
        Width = 84
      end
      item
        EditButtons = <>
        FieldName = 'VID_CHRT'
        Footers = <>
        ImageList = DATA.ImageListGalka
        KeyList.Strings = (
          '1')
        Title.Caption = #1056#1077#1084#1086#1085#1090
        Title.TitleButton = True
        Width = 79
      end
      item
        EditButtons = <>
        FieldName = 'is_have_doc'
        Footers = <>
        ImageList = DATA.ImageListGalka
        KeyList.Strings = (
          '1')
        Title.Caption = #1054#1090#1087#1091#1097#1077#1085
        Title.TitleButton = True
        Width = 78
      end
      item
        EditButtons = <>
        FieldName = 'NMNT_code'
        Footers = <>
        Title.Caption = #1053#1086#1084'. '#1085#1086#1084#1077#1088
        Title.TitleButton = True
        Width = 79
      end
      item
        EditButtons = <>
        FieldName = 'NMNT_NAME'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072
        Title.TitleButton = True
        Width = 79
      end
      item
        EditButtons = <>
        FieldName = 'REMAINDER'
        Footers = <>
        Title.Caption = #1054#1089#1090#1072#1090#1086#1082' '#1087#1086' '#1079#1072#1082#1072#1079#1091
        Width = 79
      end>
  end
  object FormOrderSource: TDataSource
    DataSet = DATA.JROrderFormQuery
    Left = 768
    Top = 57
  end
  object TableMenu: TPopupMenu
    Images = MAINForm.JRImageList
    Left = 168
    Top = 152
    object MenuEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnClick = ToolButtonEditClick
    end
    object MenuDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      ShortCut = 46
      OnClick = ToolButtonDelClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MenuInt: TMenuItem
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083
      Hint = #1048#1085#1090#1077#1088#1074#1072#1083
      ImageIndex = 3
      ShortCut = 114
      OnClick = ToolButtonIntClick
    end
    object MenuSel: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1073#1086#1088
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1073#1086#1088
      ImageIndex = 6
      ShortCut = 115
      OnClick = ToolButtonFilterClick
    end
    object MenuInsertSub: TMenuItem
      Caption = #1042#1074#1077#1089#1090#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
      Hint = #1042#1074#1077#1089#1090#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
      object MenuInsertOrder: TMenuItem
        Caption = #1047#1072#1082#1072#1079
        Hint = #1047#1072#1082#1072#1079
        OnClick = MenuInsertOrderClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MenuInsertWRHS: TMenuItem
        Caption = #1043#1086#1090#1086#1074#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
        Hint = #1043#1086#1090#1086#1074#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
        OnClick = MenuInsertSubClick
      end
      object MenuInsertWRHSOut: TMenuItem
        Caption = #1056#1072#1089#1093#1086#1076#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
        OnClick = MenuInsertWRHSOutClick
      end
      object N10: TMenuItem
        Caption = '-'
        Hint = '-'
      end
      object MenuCHRTUpdate: TMenuItem
        Caption = #1063#1077#1088#1090#1077#1078
        OnClick = MainMenuCHRTUpdateClick
      end
    end
    object MenuRefresh: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
      OnClick = RefreshButtonClick
    end
    object MenuStucDoc: TMenuItem
      Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1087#1086#1076#1095#1080#1085#1077#1085#1085#1086#1089#1090#1080
      Hint = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1087#1086#1076#1095#1080#1085#1077#1085#1085#1086#1089#1090#1080
      OnClick = MenuStucDocClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object MenuAddToPlan: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079' '#1074' '#1087#1083#1072#1085
      OnClick = MenuAddToPlanClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MenuByWidth: TMenuItem
      Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
      Checked = True
      Hint = #1055#1086' '#1096#1080#1088#1080#1085#1077
      OnClick = MenuByWidthClick
    end
    object MenuMultiSelect: TMenuItem
      Caption = #1042#1099#1073#1080#1088#1072#1090#1100' '#1085#1077#1089#1082#1086#1083#1100#1082#1086' '#1089#1090#1088#1086#1082
      Checked = True
      Hint = #1042#1099#1073#1080#1088#1072#1090#1100' '#1085#1077#1089#1082#1086#1083#1100#1082#1086' '#1089#1090#1088#1086#1082
      OnClick = MenuMultiSelectClick
    end
  end
  object StorProcOrderAdd: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_ORDER_PROC'
    Left = 877
    Top = 450
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_RQST'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_NMNT'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'PR_URGEN'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PR_EXEC'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_IN'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_OUT'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'WEIGHT_F'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER_P'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER_F'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_STAT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_MVP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PLANT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_COUNT'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CHRT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'SUM_DOC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_COST'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDDOC'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'NUMDOC'
        ParamType = ptOutput
      end>
  end
  object StorProcPlanOp: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_ORDER_1_PROC'
    Left = 909
    Top = 450
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_ORDER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CHRT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_VOP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NTIME'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'RATING'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PRICE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_END'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TIME_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TIME_END'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end>
  end
  object StorProcPlanMTR: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_MTR_PLAN_PROC'
    Left = 909
    Top = 482
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_OPP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINEOPP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_NMNT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PRICE'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'HIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'LENGHT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'WIDTH'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'WEIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_STRG'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end>
  end
  object ActionList: TActionList
    Left = 104
    Top = 134
    object acFindNext: TAction
      Caption = 'acFindNext'
      ShortCut = 32882
      OnExecute = ToolFindDownClick
    end
    object acFindPrior: TAction
      Caption = 'acFindPrior'
      ShortCut = 32881
      OnExecute = ToolFindUpClick
    end
    object acFind: TAction
      Caption = 'acFind'
      ShortCut = 114
      OnExecute = FindButtonClick
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
        OnClick = ToolButtonEditClick
      end
      object MainMenuDel: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        ImageIndex = 2
        ShortCut = 46
        OnClick = ToolButtonDelClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MainMenuInt: TMenuItem
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083
        ImageIndex = 3
        ShortCut = 114
        OnClick = ToolButtonIntClick
      end
      object MainMenuSel: TMenuItem
        Caption = #1054#1090#1073#1086#1088
        ImageIndex = 6
        ShortCut = 115
        OnClick = ToolButtonFilterClick
      end
      object N9: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ShortCut = 116
        OnClick = RefreshButtonClick
      end
      object N13: TMenuItem
        Caption = #1042#1074#1077#1089#1090#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
        object MainMenuInsertOrder: TMenuItem
          Caption = #1047#1072#1082#1072#1079
          OnClick = MenuInsertOrderClick
        end
        object N8: TMenuItem
          Caption = '-'
        end
        object MainMenuInsertWRHS: TMenuItem
          Caption = #1043#1086#1090#1086#1074#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
          OnClick = MenuInsertSubClick
        end
        object MainMenuInsertWRHSOut: TMenuItem
          Caption = #1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
          Hint = #1042#1074#1077#1089#1090#1080' '#1088#1072#1089#1093#1086#1076#1085#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090
          OnClick = MenuInsertWRHSOutClick
        end
        object N4: TMenuItem
          Caption = '-'
        end
        object MainMenuCHRTUpdate: TMenuItem
          Caption = #1063#1077#1088#1090#1077#1078
          Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1093' '#1095#1077#1088#1090#1077#1078#1072' '#1087#1086' '#1076#1072#1085#1085#1086#1084#1091' '#1079#1072#1082#1072#1079#1091
          OnClick = MainMenuCHRTUpdateClick
        end
      end
      object MainMenuStucDoc: TMenuItem
        Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1072' '#1087#1086#1076#1095#1080#1085#1077#1085#1085#1086#1089#1090#1080
        OnClick = MenuStucDocClick
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object MainMenuByWidth: TMenuItem
        Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
        Checked = True
        OnClick = MenuByWidthClick
      end
      object MainMenuMultiSelect: TMenuItem
        Caption = #1042#1099#1073#1080#1088#1072#1090#1100' '#1085#1077#1089#1082#1086#1083#1100#1082#1086' '#1089#1090#1088#1086#1082
        Checked = True
        OnClick = MenuMultiSelectClick
      end
      object Columns: TMenuItem
        Caption = #1050#1086#1083#1086#1085#1082#1080
        object TMenuItem
        end
      end
    end
  end
end
