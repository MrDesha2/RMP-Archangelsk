object JR_MTROrderForm: TJR_MTROrderForm
  Left = 228
  Top = 185
  Width = 767
  Height = 475
  HelpContext = 330
  Caption = #1046#1091#1088#1085#1072#1083' '#1091#1095#1077#1090#1072' '#1079#1072#1082#1072#1079#1086#1074' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
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
    Top = 386
    Width = 759
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
    Width = 759
    Height = 25
    Align = alTop
    TabOrder = 2
    object ToolBar1: TToolBar
      Left = 1
      Top = 1
      Width = 757
      Height = 28
      Caption = 'ToolBar1'
      Flat = True
      Images = MAINForm.JRImageList
      TabOrder = 0
      object ButtonAdd: TToolButton
        Left = 0
        Top = 0
        Hint = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1084#1085#1090#1072
        Caption = 'ButtonAdd'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = ButtonAddClick
      end
      object ButtonEdit: TToolButton
        Left = 23
        Top = 0
        Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Caption = 'ButtonEdit'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = ButtonEditClick
      end
      object ButtonDel: TToolButton
        Left = 46
        Top = 0
        Hint = #1059#1076#1072#1083#1077#1085#1080#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
        Caption = 'ButtonDel'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ButtonDelClick
      end
      object ButtonInt: TToolButton
        Left = 69
        Top = 0
        Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
        Caption = 'ButtonInt'
        ImageIndex = 3
        OnClick = ButtonIntClick
      end
      object ButtonFilter: TToolButton
        Left = 92
        Top = 0
        Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
        Caption = 'ButtonFilter'
        ImageIndex = 6
        OnClick = ButtonFilterClick
      end
      object ToolButtonHelp: TToolButton
        Left = 115
        Top = 0
        Caption = 'ToolButtonHelp'
        ImageIndex = 5
        OnClick = ToolButtonHelpClick
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
    Top = 25
    Width = 759
    Height = 361
    Align = alClient
    TabOrder = 0
    object FormGrid: TDBGridEh
      Left = 1
      Top = 1
      Width = 757
      Height = 359
      Align = alClient
      AutoFitColWidths = True
      DataSource = FormOrderSource
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = TableMenu
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = ButtonEditClick
      OnKeyDown = FormGridKeyDown
      OnTitleBtnClick = FormGridTitleBtnClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'NUMDOC'
          Footers = <>
          Title.Caption = #1053#1086#1084#1077#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Title.TitleButton = True
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'DATEdoc'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Title.TitleButton = True
          Width = 89
        end
        item
          EditButtons = <>
          FieldName = 'DATEEND'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1074#1082#1080
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
        end
        item
          EditButtons = <>
          FieldName = 'PR_EXEC'
          Footers = <>
          KeyList.Strings = (
            '0'
            '1'
            '2')
          PickList.Strings = (
            #1053#1077#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085
            #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
            #1047#1072#1082#1088#1099#1090)
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -11
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
        end
        item
          EditButtons = <>
          FieldName = 'NAME_CST'
          Footers = <>
          Title.Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 211
        end
        item
          EditButtons = <>
          FieldName = 'NAME_PDR'
          Footers = <>
          Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'-'#1079#1072#1082#1072#1079#1095#1080#1082
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -12
          Title.Font.Name = 'MS Sans Serif'
          Title.Font.Style = [fsBold]
          Width = 270
        end>
    end
  end
  object FormOrderSource: TDataSource
    DataSet = DATA.JRMTROrderQuery
    Left = 672
    Top = 33
  end
  object Stored_Del_Proc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'DEL_MTRORDER_PROC'
    Left = 704
    Top = 65
  end
  object TableMenu: TPopupMenu
    Images = MAINForm.JRImageList
    Left = 280
    Top = 177
    object MenuAdd: TMenuItem
      Caption = #1053#1086#1074#1099#1081
      Hint = #1053#1086#1074#1099#1081
      ImageIndex = 0
      OnClick = ButtonAddClick
    end
    object MenuDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnClick = ButtonDelClick
    end
    object MenuEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnClick = ButtonEditClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MenuSetInt: TMenuItem
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
      Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
      ImageIndex = 3
      OnClick = ButtonIntClick
    end
    object MenuAddAnother: TMenuItem
      Caption = #1042#1074#1077#1089#1090#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
      Hint = #1042#1074#1077#1089#1090#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
    end
    object N1: TMenuItem
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      object MenuSortByDate: TMenuItem
        Caption = #1055#1086' '#1076#1072#1090#1077
        OnClick = MenuSortByDateClick
      end
      object MenuSortByDate1: TMenuItem
        Caption = #1055#1086' '#1085#1086#1084#1077#1088#1091
        OnClick = MenuSortByDate1Click
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
    Left = 104
    Top = 134
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
        OnClick = ButtonAddClick
      end
      object MainMenuEdit: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        ImageIndex = 1
        ShortCut = 13
        OnClick = ButtonEditClick
      end
      object MainMenuDel: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        ImageIndex = 2
        ShortCut = 46
        OnClick = ButtonDelClick
      end
      object MainMenuInt: TMenuItem
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1078#1091#1088#1085#1072#1083#1072
        ImageIndex = 3
        OnClick = ButtonIntClick
      end
      object MainMenuFiltr: TMenuItem
        Caption = #1060#1080#1083#1100#1090#1088
        ImageIndex = 6
        OnClick = ButtonFilterClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object MainMenuRefrech: TMenuItem
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
