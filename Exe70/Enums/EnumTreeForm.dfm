object LIST_TREEEDITForm: TLIST_TREEEDITForm
  Left = 215
  Top = 235
  Width = 692
  Height = 480
  HelpContext = 105
  ActiveControl = FormGrid
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
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
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 674
    Height = 37
    Align = alTop
    TabOrder = 0
    object EnumToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 672
      Height = 29
      ButtonHeight = 24
      Caption = 'EnumToolBar'
      Flat = True
      Images = MAINForm.MainImages
      TabOrder = 0
      object NewButtom: TToolButton
        Left = 0
        Top = 0
        Hint = #1053#1086#1074#1099#1081' '#1101#1083#1077#1084#1077#1085#1090
        Caption = 'NewButtom'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = NewButtomClick
      end
      object NewGroupButton: TToolButton
        Left = 23
        Top = 0
        Hint = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
        Caption = 'NewGroupButton'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = NewGroupButtonClick
      end
      object EditButton: TToolButton
        Left = 46
        Top = 0
        Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
        Caption = 'EditButton'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = EditButtonClick
      end
      object DeleteButton: TToolButton
        Left = 69
        Top = 0
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
        Caption = 'DeleteButton'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = DeleteButtonClick
      end
      object TranceButton: TToolButton
        Left = 92
        Top = 0
        Hint = #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1074' '#1075#1088#1091#1087#1087#1091
        Caption = 'TranceButton'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = TranceButtonClick
      end
      object IsTreeButton: TToolButton
        Left = 115
        Top = 0
        Hint = #1055#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1074' '#1074#1080#1076#1077' '#1076#1077#1088#1077#1074#1072
        Caption = 'IsTreeButton'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = IsTreeButtonClick
      end
      object ToolButtonFilter: TToolButton
        Left = 138
        Top = 0
        Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1092#1080#1083#1100#1090#1088#1072
        Caption = #1060#1080#1083#1100#1090#1088
        ImageIndex = 39
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonFilterClick
      end
      object HelpButton: TToolButton
        Left = 161
        Top = 0
        Hint = #1055#1086#1084#1086#1097#1100
        Caption = 'HelpButton'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = HelpButtonClick
      end
      object Searchkey: TEdit
        Left = 184
        Top = 0
        Width = 248
        Height = 24
        Hint = #1053#1072#1081#1090#1080' '#1087#1086' '#1087#1086#1076#1089#1090#1088#1086#1082#1077
        CharCase = ecUpperCase
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnKeyPress = SearchkeyKeyPress
      end
      object FindButton: TButton
        Left = 432
        Top = 0
        Width = 16
        Height = 24
        Hint = #1053#1072#1081#1090#1080
        Caption = '...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = FindButtonClick
      end
      object SearchDownButton: TToolButton
        Left = 448
        Top = 0
        Hint = #1048#1089#1082#1072#1090#1100' '#1074#1085#1080#1079
        Caption = 'SearchDownButton'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = SearchDownButtonClick
      end
      object SearchUpButton: TToolButton
        Left = 471
        Top = 0
        Hint = #1048#1089#1082#1072#1090#1100' '#1074#1074#1077#1088#1093
        Caption = 'SearchUpButton'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = SearchUpButtonClick
      end
      object CodeSearchKey: TEdit
        Left = 494
        Top = 0
        Width = 121
        Height = 24
        Hint = #1053#1072#1081#1090#1080' '#1087#1086' '#1090#1086#1095#1085#1086#1084#1091' '#1082#1086#1076#1091
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnKeyPress = CodeSearchKeyKeyPress
      end
    end
  end
  object BotPanel: TPanel
    Left = 0
    Top = 365
    Width = 674
    Height = 45
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 20
      Top = 10
      Width = 92
      Height = 31
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = CloseButtonClick
    end
  end
  object CenterPanel: TPanel
    Left = 0
    Top = 37
    Width = 674
    Height = 328
    Align = alClient
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 240
      Top = 1
      Width = 4
      Height = 326
    end
    object EnumTreeView: TTreeView
      Left = 1
      Top = 1
      Width = 239
      Height = 326
      Align = alLeft
      Images = DATA.TreeImages
      Indent = 19
      TabOrder = 0
      OnDblClick = EnumTreeViewDblClick
      OnDragDrop = EnumTreeViewDragDrop
      OnDragOver = EnumTreeViewDragOver
      OnExpanding = EnumTreeViewExpanding
      OnKeyDown = EnumTreeViewKeyDown
    end
    object FormGrid: TDBGridEh
      Left = 244
      Top = 1
      Width = 429
      Height = 326
      Align = alClient
      AutoFitColWidths = True
      DataSource = FormSource
      DrawMemoText = True
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
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      PopupMenu = TablePopupMenu
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnCellClick = FormGridCellClick
      OnColEnter = FormGridColEnter
      OnDblClick = EditButtonClick
      OnDrawColumnCell = FormGridDrawColumnCell
      OnKeyDown = FormGridKeyDown
      OnKeyPress = FormGridKeyPress
      OnMouseDown = FormGridMouseDown
      OnTitleBtnClick = FormGridTitleBtnClick
      Columns = <
        item
          Color = clActiveBorder
          EditButtons = <>
          FieldName = 'ISFOLDER'
          Footers = <>
          ImageList = DATA.TreeImages
          KeyList.Strings = (
            '0'
            '1')
          NotInKeyListIndex = 2
          Title.Caption = ' '
          Width = 25
        end
        item
          EditButtons = <>
          FieldName = 'CODE'
          Footers = <>
          Title.Caption = #1050#1086#1076
          Title.SortIndex = 1
          Title.SortMarker = smDownEh
          Title.TitleButton = True
          Width = 130
        end
        item
          EditButtons = <>
          FieldName = 'NAME'
          Footers = <>
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.TitleButton = True
          Width = 357
        end>
    end
  end
  object qTreeQuery: TQuery
    DatabaseName = 'RMP'
    Left = 513
    Top = 3
  end
  object TablePopupMenu: TPopupMenu
    Images = MAINForm.MainImages
    Left = 312
    Top = 158
    object MenuNew: TMenuItem
      Caption = #1053#1086#1074#1099#1081
      ImageIndex = 0
      OnClick = NewButtomClick
    end
    object MenuNewGroup: TMenuItem
      Caption = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
      ImageIndex = 1
      OnClick = NewGroupButtonClick
    end
    object MenuEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 2
      OnClick = EditButtonClick
    end
    object MenuDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 3
      OnClick = DeleteButtonClick
    end
    object MenuSep: TMenuItem
      Caption = '-'
    end
    object IsTreeButtonMenu: TMenuItem
      Caption = #1055#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1074' '#1076#1077#1088#1077#1074#1077
      OnClick = IsTreeButtonMenuClick
    end
    object MenuSub: TMenuItem
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
      object MenuSortCode: TMenuItem
        Caption = #1055#1086' '#1082#1086#1076#1091
        OnClick = MenuSortCodeClick
      end
      object MenuSortName: TMenuItem
        Caption = #1055#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
        OnClick = MenuSortNameClick
      end
      object MenuSortID: TMenuItem
        Caption = #1041#1077#1079' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
        OnClick = MenuSortIDClick
      end
    end
    object MenuIsGroup: TMenuItem
      Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      OnClick = MenuIsGroupClick
    end
    object MenuRef: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
      OnClick = MenuRefClick
    end
  end
  object FormSource: TDataSource
    DataSet = qFormQuery
    Left = 545
    Top = 3
  end
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    Left = 577
    Top = 3
  end
  object ActionList: TActionList
    Left = 104
    Top = 134
    object acFindNext: TAction
      Caption = 'acFindNext'
      ShortCut = 32882
      OnExecute = SearchDownButtonClick
    end
    object acFindPrior: TAction
      Caption = 'acFindPrior'
      ShortCut = 32881
      OnExecute = SearchUpButtonClick
    end
    object acFind: TAction
      Caption = 'acFind'
      ShortCut = 114
      OnExecute = FindButtonClick
    end
  end
  object MainMenu: TMainMenu
    Images = MAINForm.MainImages
    Left = 280
    Top = 158
    object N3: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      GroupIndex = 1
      object MainMenuAdd: TMenuItem
        Caption = #1053#1086#1074#1099#1081
        ImageIndex = 0
        ShortCut = 45
        OnClick = NewButtomClick
      end
      object MainMenuAddGroup: TMenuItem
        Caption = #1053#1086#1074#1072#1103' '#1075#1088#1091#1087#1087#1072
        ImageIndex = 1
        ShortCut = 8237
        OnClick = NewGroupButtonClick
      end
      object MainMenuEdit: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        ImageIndex = 2
        OnClick = EditButtonClick
      end
      object MainMenuDel: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        ImageIndex = 3
        ShortCut = 46
        OnClick = DeleteButtonClick
      end
      object MainMenuSep: TMenuItem
        Caption = '-'
      end
      object MainMenuSort: TMenuItem
        Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072
        object MainMenuSort1: TMenuItem
          Caption = #1055#1086' '#1082#1086#1076#1091
          OnClick = MenuSortCodeClick
        end
        object MainMenuSort2: TMenuItem
          Caption = #1055#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
          OnClick = MenuSortNameClick
        end
        object MainMenuSort3: TMenuItem
          Caption = #1041#1077#1079' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
          OnClick = MenuSortIDClick
        end
      end
      object MainMenuIsGroup: TMenuItem
        Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1090#1100' '#1074' '#1075#1088#1091#1087#1087#1091
        OnClick = MenuIsGroupClick
      end
      object MainmenuIsTree: TMenuItem
        Caption = #1042' '#1074#1080#1076#1077' '#1076#1077#1088#1077#1074#1072
        OnClick = MainmenuIsTreeClick
      end
      object MainMenuTranceEl: TMenuItem
        Caption = #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1074' '#1076#1088#1091#1075#1091#1102' '#1075#1088#1091#1087#1087#1091
        ImageIndex = 4
        OnClick = TranceButtonClick
      end
      object MainMenuRef: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ShortCut = 116
        OnClick = MenuRefClick
      end
    end
  end
  object qParentQuery: TQuery
    DatabaseName = 'RMP'
    Left = 609
    Top = 3
  end
end
