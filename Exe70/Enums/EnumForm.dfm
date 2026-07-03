object LIST_EDITForm: TLIST_EDITForm
  Left = 343
  Top = 176
  Width = 684
  Height = 480
  HelpContext = 100
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
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
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 393
    Width = 676
    Height = 41
    Align = alBottom
    TabOrder = 0
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
  object CenterPanel: TPanel
    Left = 0
    Top = 30
    Width = 676
    Height = 363
    Align = alClient
    TabOrder = 1
    object FormSplitter: TSplitter
      Left = 672
      Top = 1
      Height = 361
      Align = alRight
    end
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 676
    Height = 30
    Align = alTop
    TabOrder = 2
    object EnumToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 674
      Height = 29
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
      object EditButton: TToolButton
        Left = 23
        Top = 0
        Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1101#1083#1077#1084#1077#1085#1090
        Caption = 'EditButton'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = EditButtonClick
      end
      object DeleteButton: TToolButton
        Left = 46
        Top = 0
        Hint = #1059#1076#1072#1083#1080#1090#1100
        Caption = 'DeleteButton'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = DeleteButtonClick
      end
      object HelpButton: TToolButton
        Left = 69
        Top = 0
        Hint = #1055#1086#1084#1086#1097#1100
        Caption = 'HelpButton'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = HelpButtonClick
      end
      object Searchkey: TEdit
        Left = 92
        Top = 0
        Width = 240
        Height = 22
        Hint = #1055#1086#1080#1089#1082' '#1087#1086' '#1087#1086#1076#1089#1090#1088#1086#1082#1077
        CharCase = ecUpperCase
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnKeyPress = SearchkeyKeyPress
      end
      object FindButton: TButton
        Left = 332
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
      object DownButton: TToolButton
        Left = 348
        Top = 0
        Hint = #1055#1086#1080#1089#1082' '#1074#1085#1080#1079
        Caption = 'DownButton'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = DownButtonClick
      end
      object UpButton: TToolButton
        Left = 371
        Top = 0
        Hint = #1055#1086#1080#1089#1082' '#1074#1074#1077#1088#1093
        Caption = 'UpButton'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = UpButtonClick
      end
      object CodeSearchKey: TEdit
        Left = 394
        Top = 0
        Width = 121
        Height = 22
        Hint = #1058#1086#1095#1085#1099#1081' '#1087#1086#1080#1089#1082#13#10#1087#1086' '#1082#1086#1076#1091
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnKeyPress = CodeSearchKeyKeyPress
      end
    end
  end
  object FormGrid: TDBGridEh
    Left = 0
    Top = 30
    Width = 676
    Height = 363
    Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
    Align = alClient
    AutoFitColWidths = True
    DataSource = FormSource
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -11
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    PopupMenu = GridMenu
    ShowHint = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnCellClick = FormGridCellClick
    OnColEnter = FormGridColEnter
    OnDblClick = EditButtonClick
    OnDrawColumnCell = FormGridDrawColumnCell
    OnKeyDown = FormGridKeyDown
    OnKeyPress = FormGridKeyPress
    OnTitleBtnClick = FormGridTitleBtnClick
    Columns = <
      item
        EditButtons = <>
        FieldName = 'CODE'
        Footers = <>
        Title.Caption = #1050#1086#1076
        Title.SortIndex = 1
        Title.SortMarker = smDownEh
        Title.TitleButton = True
        Width = 143
      end
      item
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Title.TitleButton = True
        Width = 409
      end>
  end
  object Gen_IDQuery: TQuery
    DatabaseName = 'RMP'
    Left = 505
    Top = 51
  end
  object GridMenu: TPopupMenu
    Images = MAINForm.MainImages
    Left = 136
    Top = 94
    object MenuNew: TMenuItem
      Caption = #1053#1086#1074#1099#1081
      ImageIndex = 0
      OnClick = NewButtomClick
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
    object MenuSub: TMenuItem
      Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      object MenuSort1: TMenuItem
        Caption = #1055#1086' '#1082#1086#1076#1091
        OnClick = MenuSort1Click
      end
      object MenuSort2: TMenuItem
        Caption = #1055#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
        OnClick = MenuSort2Click
      end
      object MenuSort3: TMenuItem
        Caption = #1041#1077#1079' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
        OnClick = MenuSort3Click
      end
    end
    object MenuRef: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
      OnClick = MenuRefClick
    end
  end
  object qFormQuery: TQuery
    BeforePost = qFormQueryBeforePost
    AfterPost = qFormQueryAfterPost
    DatabaseName = 'RMP'
    RequestLive = True
    Left = 529
    Top = 51
  end
  object FormSource: TDataSource
    DataSet = qFormQuery
    Left = 561
    Top = 51
  end
  object ActionList: TActionList
    Left = 48
    Top = 94
    object acFindNext: TAction
      Caption = 'acFindNext'
      ShortCut = 32882
      OnExecute = DownButtonClick
    end
    object acFindPrior: TAction
      Caption = 'acFindPrior'
      ShortCut = 32881
      OnExecute = UpButtonClick
    end
    object acFind: TAction
      Caption = 'acFind'
      ShortCut = 114
      OnExecute = FindButtonClick
    end
  end
  object MainMenu: TMainMenu
    Images = MAINForm.MainImages
    Left = 136
    Top = 128
    object N8: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      GroupIndex = 1
      object MainMenuNew: TMenuItem
        Caption = #1053#1086#1074#1099#1081
        ImageIndex = 0
        ShortCut = 45
        OnClick = NewButtomClick
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
      object MainMenuSub: TMenuItem
        Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
        object MainMenuSort1: TMenuItem
          Caption = #1055#1086' '#1082#1086#1076#1091
          OnClick = MenuSort1Click
        end
        object MainMenuSort2: TMenuItem
          Caption = #1055#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
          OnClick = MenuSort2Click
        end
        object MainMenuSort3: TMenuItem
          Caption = #1041#1077#1079' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
          OnClick = MenuSort3Click
        end
      end
      object MainMenuRef: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ShortCut = 116
        OnClick = MenuRefClick
      end
    end
  end
end
