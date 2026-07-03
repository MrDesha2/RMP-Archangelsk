object LIST_TREE4SelectForm: TLIST_TREE4SelectForm
  Left = 212
  Top = 214
  Width = 692
  Height = 480
  HelpContext = 105
  ActiveControl = FormGrid
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 684
    Height = 30
    Align = alTop
    TabOrder = 0
    object EnumToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 682
      Height = 29
      Caption = 'EnumToolBar'
      Flat = True
      Images = MAINForm.MainImages
      TabOrder = 0
      object IsTreeButton: TToolButton
        Left = 0
        Top = 0
        Hint = #1055#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1074' '#1074#1080#1076#1077' '#1076#1077#1088#1077#1074#1072
        Caption = 'IsTreeButton'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = IsTreeButtonClick
      end
      object HelpButton: TToolButton
        Left = 23
        Top = 0
        Hint = #1055#1086#1084#1086#1097#1100
        Caption = 'HelpButton'
        ImageIndex = 6
        ParentShowHint = False
        ShowHint = True
        OnClick = HelpButtonClick
      end
      object Searchkey: TEdit
        Left = 46
        Top = 0
        Width = 248
        Height = 22
        Hint = #1053#1072#1081#1090#1080' '#1087#1086' '#1087#1086#1076#1089#1090#1088#1086#1082#1077
        CharCase = ecUpperCase
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnKeyPress = SearchkeyKeyPress
      end
      object FindButton: TButton
        Left = 294
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
      object SearchDownButton: TToolButton
        Left = 310
        Top = 0
        Hint = #1048#1089#1082#1072#1090#1100' '#1074#1085#1080#1079
        Caption = 'SearchDownButton'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = SearchDownButtonClick
      end
      object SearchUpButton: TToolButton
        Left = 333
        Top = 0
        Hint = #1048#1089#1082#1072#1090#1100' '#1074#1074#1077#1088#1093
        Caption = 'SearchUpButton'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = SearchUpButtonClick
      end
      object CodeSearchKey: TEdit
        Left = 356
        Top = 0
        Width = 121
        Height = 22
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
    Top = 416
    Width = 684
    Height = 37
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = CloseButtonClick
    end
    object OKButton: TButton
      Left = 96
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 1
      OnClick = OKButtonClick
    end
  end
  object CenterPanel: TPanel
    Left = 0
    Top = 30
    Width = 684
    Height = 386
    Align = alClient
    TabOrder = 2
    object Splitter: TSplitter
      Left = 195
      Top = 1
      Height = 384
    end
    object EnumTreeView: TTreeView
      Left = 1
      Top = 1
      Width = 194
      Height = 384
      Align = alLeft
      Images = DATA.TreeImages
      Indent = 19
      TabOrder = 0
      OnDblClick = EnumTreeViewDblClick
      OnExpanding = EnumTreeViewExpanding
      OnKeyDown = EnumTreeViewKeyDown
    end
    object FormGrid: TDBGridEh
      Left = 198
      Top = 1
      Width = 485
      Height = 384
      Align = alClient
      AutoFitColWidths = True
      DataSource = FormSource
      DrawMemoText = True
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
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      PopupMenu = TablePopupMenu
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnCellClick = FormGridCellClick
      OnColEnter = FormGridColEnter
      OnDblClick = FormGridDblClick
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
          Width = 20
        end
        item
          EditButtons = <>
          FieldName = 'CODE'
          Footers = <>
          Title.Caption = #1050#1086#1076
          Title.SortIndex = 1
          Title.SortMarker = smDownEh
          Title.TitleButton = True
          Width = 106
        end
        item
          EditButtons = <>
          FieldName = 'NAME'
          Footers = <>
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.TitleButton = True
          Width = 290
        end>
    end
  end
  object qTreeQuery: TQuery
    DatabaseName = 'RMP'
    Left = 529
    Top = 43
  end
  object TablePopupMenu: TPopupMenu
    Left = 312
    Top = 158
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
  end
  object FormSource: TDataSource
    DataSet = qFormQuery
    Left = 553
    Top = 43
  end
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    Left = 577
    Top = 43
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
  object qParentQuery: TQuery
    DatabaseName = 'RMP'
    Left = 601
    Top = 43
  end
end
