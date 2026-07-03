object JR_RQSTForm: TJR_RQSTForm
  Left = 163
  Top = 116
  Width = 828
  Height = 590
  HelpContext = 310
  Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072#1103#1074#1086#1082
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
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 0
    Top = 268
    Width = 820
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object PanelBot: TPanel
    Left = 0
    Top = 494
    Width = 820
    Height = 42
    Align = alBottom
    TabOrder = 2
    object CloseButton: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = CloseButtonClick
    end
    object RefreshButton: TButton
      Left = 648
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054'&'#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 1
      OnClick = RefreshButtonClick
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 820
    Height = 28
    Align = alTop
    TabOrder = 3
    object JRToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 818
      Height = 24
      Caption = 'JRToolBar'
      EdgeInner = esLowered
      EdgeOuter = esNone
      Flat = True
      Images = MAINForm.JRImageList
      TabOrder = 0
      object ToolButtonAdd: TToolButton
        Left = 0
        Top = 0
        Hint = #1053#1086#1074#1072#1103' '#1079#1072#1103#1074#1082#1072
        Caption = 'ToolButtonAdd'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonAddClick
      end
      object ToolButtonEdit: TToolButton
        Left = 23
        Top = 0
        Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1103#1074#1082#1091
        Caption = 'ToolButtonEdit'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = JRRQSTGridDblClick
      end
      object ToolButtonDel: TToolButton
        Left = 46
        Top = 0
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1103#1074#1082#1091
        Caption = 'ToolButtonDel'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonDelClick
      end
      object ToolButtonSetInt: TToolButton
        Left = 69
        Top = 0
        Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1078#1091#1088#1085#1072#1083#1072
        Caption = 'ToolButtonSetInt'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonSetIntClick
      end
      object ToolButtonSetView: TToolButton
        Left = 92
        Top = 0
        Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1079#1072#1082#1072#1079#1099
        Caption = 'ToolButtonSetView'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        Style = tbsCheck
        OnClick = ToolButtonSetViewClick
      end
      object ToolButtonSetFilter: TToolButton
        Left = 115
        Top = 0
        Caption = 'ToolButtonSetFilter'
        ImageIndex = 6
        OnClick = ToolButtonSetFilterClick
      end
      object ToolButtonHelp: TToolButton
        Left = 138
        Top = 0
        Hint = #1055#1086#1084#1086#1097#1100
        Caption = 'ToolButtonHelp'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonHelpClick
      end
      object Searchkey: TEdit
        Left = 161
        Top = 0
        Width = 263
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyPress = SearchkeyKeyPress
      end
      object FindButton: TButton
        Left = 424
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
        Left = 440
        Top = 0
        Caption = 'ToolButtonFindDown'
        ImageIndex = 7
        OnClick = ToolButtonFindDownClick
      end
      object ToolButtonFindUp: TToolButton
        Left = 463
        Top = 0
        Caption = 'ToolButtonFindUp'
        ImageIndex = 8
        OnClick = ToolButtonFindUpClick
      end
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 28
    Width = 820
    Height = 240
    Align = alClient
    TabOrder = 0
    object JRRQSTGrid: TDBGridEh
      Left = 1
      Top = 1
      Width = 818
      Height = 238
      Align = alClient
      AutoFitColWidths = True
      DataSource = FormRQSTSourse
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
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDblClick = JRRQSTGridDblClick
      OnKeyDown = JRRQSTGridKeyDown
      OnTitleBtnClick = JRRQSTGridTitleBtnClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'NUMBER'
          Footers = <>
          Title.Caption = #1053#1086#1084#1077#1088
          Title.TitleButton = True
          Width = 72
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'DATE_IN'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
          Title.TitleButton = True
          Width = 104
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'DATE_OUT'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          Title.TitleButton = True
          Width = 90
        end
        item
          EditButtons = <>
          FieldName = 'NAME_CST'
          Footers = <>
          Title.Caption = #1047#1072#1082#1072#1079#1095#1080#1082
          Width = 180
        end
        item
          EditButtons = <>
          FieldName = 'NAME_PDR'
          Footers = <>
          Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          Width = 179
        end
        item
          Checkboxes = False
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
          Width = 117
        end>
    end
  end
  object PanelTable: TPanel
    Left = 0
    Top = 271
    Width = 820
    Height = 223
    Align = alBottom
    TabOrder = 1
    object PanelTop2: TPanel
      Left = 1
      Top = 1
      Width = 818
      Height = 25
      Align = alTop
      TabOrder = 1
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 816
        Height = 24
        Caption = 'ToolBar1'
        Flat = True
        Images = MAINForm.JRImageList
        TabOrder = 0
        object ToolButton6: TToolButton
          Left = 0
          Top = 0
          Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1082#1072#1079
          Caption = 'ToolButton6'
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = True
          OnClick = JROrderGridDblClick
        end
        object ToolButton7: TToolButton
          Left = 23
          Top = 0
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1082#1072#1079
          Caption = 'ToolButton7'
          ImageIndex = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = ToolButton7Click
        end
        object ToolButton9: TToolButton
          Left = 46
          Top = 0
          Hint = #1055#1086#1084#1086#1097#1100
          Caption = 'ToolButton9'
          ImageIndex = 5
          ParentShowHint = False
          ShowHint = True
        end
        object SearchKeyOrder: TEdit
          Left = 69
          Top = 0
          Width = 160
          Height = 22
          CharCase = ecUpperCase
          TabOrder = 0
          OnKeyPress = SearchKeyOrderKeyPress
        end
        object FindOrderButton: TButton
          Left = 229
          Top = 0
          Width = 16
          Height = 22
          Hint = #1053#1072#1081#1090#1080
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = FindOrderButtonClick
        end
        object ToolFindOrDown: TToolButton
          Left = 245
          Top = 0
          Caption = 'ToolFindOrDown'
          ImageIndex = 7
          OnClick = ToolFindOrDownClick
        end
        object ToolFindOrUp: TToolButton
          Left = 268
          Top = 0
          Caption = 'ToolFindOrUp'
          ImageIndex = 8
          OnClick = ToolFindOrUpClick
        end
      end
    end
    object JROrderGrid: TDBGridEh
      Left = 1
      Top = 26
      Width = 818
      Height = 196
      Align = alClient
      AutoFitColWidths = True
      DataSource = FormOrderSource
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
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDblClick = JROrderGridDblClick
      OnKeyDown = JROrderGridKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'NUMBER'
          Footers = <>
          Title.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
          Width = 86
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'DATE_IN'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
          Width = 86
        end
        item
          EditButtons = <>
          FieldName = 'NAME_PDR'
          Footers = <>
          Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          Width = 342
        end
        item
          EditButtons = <>
          FieldName = 'NAME_CHRT'
          Footers = <>
          Title.Caption = #1063#1077#1088#1090#1077#1078
          Width = 235
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
          Width = 120
        end>
    end
  end
  object FormRQSTSourse: TDataSource
    DataSet = DATA.JRRQSTFormQuery
    Left = 849
    Top = 107
  end
  object FormOrderSource: TDataSource
    DataSet = DATA.JRRQSTFormOrderQuery
    Left = 848
    Top = 137
  end
  object TableMenu: TPopupMenu
    Images = MAINForm.JRImageList
    Left = 128
    Top = 116
    object N1: TMenuItem
      Caption = #1053#1086#1074#1099#1081
      Hint = #1053#1086#1074#1099#1081
      ImageIndex = 0
      OnClick = ToolButtonAddClick
    end
    object MenuEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnClick = JRRQSTGridDblClick
    end
    object MenuDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 2
      OnClick = ToolButtonDelClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MenuSel: TMenuItem
      Caption = #1054#1090#1073#1086#1088
      Hint = #1054#1090#1073#1086#1088
      ImageIndex = 6
      OnClick = ToolButtonSetFilterClick
    end
    object MenuInt: TMenuItem
      Caption = #1048#1085#1090#1077#1088#1074#1072#1083
      Hint = #1048#1085#1090#1077#1088#1074#1072#1083
      ImageIndex = 3
      OnClick = ToolButtonSetIntClick
    end
    object MenuOrd: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1079#1072#1082#1072#1079#1099
      Checked = True
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1079#1072#1082#1072#1079#1099
      OnClick = MenuOrdClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MenuRefresh: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100
      ShortCut = 116
      OnClick = RefreshButtonClick
    end
    object MenuByWidth: TMenuItem
      Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
      Checked = True
      Hint = #1055#1086' '#1096#1080#1088#1080#1085#1077
      OnClick = MenuByWidthClick
    end
  end
  object ActionList: TActionList
    Left = 80
    Top = 94
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
    object MenuItem1: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      GroupIndex = 1
      object MainMenuAdd: TMenuItem
        Caption = #1053#1086#1074#1099#1081
        ImageIndex = 0
        ShortCut = 45
        OnClick = ToolButtonAddClick
      end
      object MainMenuEdit: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        ImageIndex = 1
        OnClick = JRRQSTGridDblClick
      end
      object MainMenuDel: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100
        ImageIndex = 2
        ShortCut = 46
        OnClick = ToolButtonDelClick
      end
      object MainMenuInt: TMenuItem
        Caption = #1048#1085#1090#1077#1088#1074#1072#1083' '#1078#1091#1088#1085#1072#1083#1072
        ImageIndex = 3
        ShortCut = 114
        OnClick = ToolButtonSetIntClick
      end
      object MainMenuFiltr: TMenuItem
        Caption = #1060#1080#1083#1100#1090#1088
        ImageIndex = 6
        ShortCut = 115
        OnClick = ToolButtonSetFilterClick
      end
      object MainMenuSetView: TMenuItem
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1079#1072#1082#1072#1079#1099
        Checked = True
        OnClick = MenuOrdClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N5: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ShortCut = 116
        OnClick = RefreshButtonClick
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
