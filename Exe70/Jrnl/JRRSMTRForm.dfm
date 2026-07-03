object JR_RSMTRForm: TJR_RSMTRForm
  Left = 327
  Top = 201
  Width = 580
  Height = 476
  HelpContext = 345
  Caption = #1046#1091#1088#1085#1072#1083' '#1088#1072#1089#1093#1086#1076#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBot: TPanel
    Left = 0
    Top = 387
    Width = 572
    Height = 35
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 28
      Top = 5
      Width = 75
      Height = 25
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = CloseButtonClick
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 572
    Height = 33
    Align = alTop
    TabOrder = 2
    object ToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 570
      Height = 29
      Caption = 'ToolBar'
      Flat = True
      Images = MAINForm.JRImageList
      TabOrder = 0
      object AddButton: TToolButton
        Left = 0
        Top = 0
        Caption = 'AddButton'
        ImageIndex = 0
        OnClick = AddButtonClick
      end
      object EditButton: TToolButton
        Left = 23
        Top = 0
        Caption = 'EditButton'
        ImageIndex = 1
        OnClick = EditButtonClick
      end
      object DelButton: TToolButton
        Left = 46
        Top = 0
        Caption = 'DelButton'
        ImageIndex = 2
        OnClick = DelButtonClick
      end
      object IntButton: TToolButton
        Left = 69
        Top = 0
        Caption = 'IntButton'
        ImageIndex = 3
        OnClick = IntButtonClick
      end
      object ButtonFilter: TToolButton
        Left = 92
        Top = 0
        Caption = 'ButtonFilter'
        ImageIndex = 6
        OnClick = ButtonFilterClick
      end
      object HelpButton: TToolButton
        Left = 115
        Top = 0
        Caption = 'HelpButton'
        ImageIndex = 5
        OnClick = HelpButtonClick
      end
      object Searchkey: TEdit
        Left = 138
        Top = 0
        Width = 160
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyPress = SearchkeyKeyPress
      end
      object FindButton: TButton
        Left = 298
        Top = 0
        Width = 16
        Height = 22
        Hint = #1053#1072#1081#1090#1080
        Caption = '...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = FindButtonClick
      end
      object ToolButtonFindDown: TToolButton
        Left = 314
        Top = 0
        Caption = 'ToolButtonFindDown'
        ImageIndex = 7
        OnClick = ToolButtonFindDownClick
      end
      object ToolButtonFindUp: TToolButton
        Left = 337
        Top = 0
        Caption = 'ToolButtonFindUp'
        ImageIndex = 8
        OnClick = ToolButtonFindUpClick
      end
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 33
    Width = 572
    Height = 354
    Align = alClient
    TabOrder = 0
    object FormGrid: TDBGridEh
      Left = 1
      Top = 1
      Width = 570
      Height = 352
      Align = alClient
      AutoFitColWidths = True
      DataSource = FormOrderSource
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
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      PopupMenu = TableMenu
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      TitleLines = 1
      OnDblClick = EditButtonClick
      OnKeyDown = FormGridKeyDown
      OnTitleBtnClick = FormGridTitleBtnClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'NUMDOC'
          Footers = <>
          Title.Caption = #1053#1086#1084#1077#1088
          Title.TitleButton = True
          Width = 75
        end
        item
          Alignment = taCenter
          ButtonStyle = cbsNone
          EditButtons = <>
          FieldName = 'DATE_IN'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Title.TitleButton = True
          Width = 119
        end
        item
          EditButtons = <>
          FieldName = 'name_wrhs'
          Footers = <>
          Title.Caption = #1057#1082#1083#1072#1076'-'#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100
          Width = 151
        end
        item
          EditButtons = <>
          FieldName = 'name_cst'
          Footers = <>
          Title.Caption = #1055#1086#1083#1091#1095#1072#1090#1077#1083#1100
          Width = 226
        end>
    end
  end
  object FormOrderSource: TDataSource
    DataSet = DATA.JRRSMPRFormQuery
    Left = 672
    Top = 33
  end
  object Stored_del_Proc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'DEL_RS_MTR_PROC'
    Left = 704
    Top = 65
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IDDOC'
        ParamType = ptInput
      end>
  end
  object TableMenu: TPopupMenu
    Images = MAINForm.JRImageList
    Left = 144
    Top = 145
    object MenuAdd: TMenuItem
      Caption = #1053#1086#1074#1099#1081
      Hint = #1053#1086#1074#1099#1081
      ImageIndex = 0
      OnClick = AddButtonClick
    end
    object MenuEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnClick = EditButtonClick
    end
    object MenuDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnClick = DelButtonClick
    end
    object Separator: TMenuItem
      Caption = '-'
    end
    object MenuSetInt: TMenuItem
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
      Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
      ImageIndex = 3
      OnClick = IntButtonClick
    end
    object MenuSort: TMenuItem
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      object MenuSortByDate: TMenuItem
        Caption = #1055#1086' '#1076#1072#1090#1077
        OnClick = MenuSortByDateClick
      end
      object MenuSotrByDoc: TMenuItem
        Caption = #1055#1086' '#1074#1080#1076#1091' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        OnClick = MenuSotrByDocClick
      end
    end
    object MenuRefresh: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
      OnClick = MenuRefreshClick
    end
    object MenuByWidth: TMenuItem
      Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
      Checked = True
      Hint = #1055#1086' '#1096#1080#1088#1080#1085#1077
      OnClick = MenuByWidthClick
    end
  end
  object ActionList: TActionList
    Left = 640
    Top = 30
    object acFindNext: TAction
      Caption = 'acFindNext'
      ShortCut = 32882
      OnExecute = ToolButtonFindDownClick
    end
    object acFindPrior: TAction
      Caption = 'acFindPrior'
      ShortCut = 32881
      OnExecute = ToolButtonFindUpClick
    end
    object acFind: TAction
      Caption = 'acFind'
      ShortCut = 114
      OnExecute = FindButtonClick
    end
  end
  object MainMenu: TMainMenu
    Images = MAINForm.JRImageList
    Left = 248
    Top = 177
    object N2: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      GroupIndex = 1
      object MainMenuAdd: TMenuItem
        Caption = #1053#1086#1074#1099#1081
        ImageIndex = 0
        ShortCut = 45
        OnClick = AddButtonClick
      end
      object MainMenuEdit: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        ImageIndex = 1
        OnClick = EditButtonClick
      end
      object MainMenuDel: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        ImageIndex = 2
        ShortCut = 46
        OnClick = DelButtonClick
      end
      object MainMenuInt: TMenuItem
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1078#1091#1088#1085#1072#1083#1072
        ImageIndex = 3
        ShortCut = 114
        OnClick = IntButtonClick
      end
      object MainMenuFiltr: TMenuItem
        Caption = #1060#1080#1083#1100#1090#1088
        ImageIndex = 6
        ShortCut = 115
        OnClick = ButtonFilterClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object MainMenuRefresh: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ShortCut = 116
        OnClick = MenuRefreshClick
      end
      object MainMenuByWid: TMenuItem
        Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
        Checked = True
        OnClick = MenuByWidthClick
      end
      object Columns: TMenuItem
        Caption = #1050#1086#1083#1086#1085#1082#1080
        object TMenuItem
        end
      end
    end
  end
end
