object LIST_4SELECTForm: TLIST_4SELECTForm
  Left = 263
  Top = 174
  Width = 696
  Height = 466
  HelpContext = 100
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082':'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnActivate = FormActivate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 398
    Width = 688
    Height = 41
    Align = alBottom
    TabOrder = 1
    object OKButton: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object CancelButton: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
      OnClick = CancelButtonClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 33
    Align = alTop
    TabOrder = 2
    object EnumToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 686
      Height = 28
      Caption = 'EnumToolBar'
      Images = MAINForm.MainImages
      TabOrder = 0
      object Search_string: TEdit
        Left = 0
        Top = 2
        Width = 218
        Height = 22
        Hint = #1053#1072#1081#1090#1080' '#1087#1086' '#1087#1086#1076#1089#1090#1088#1086#1082#1077
        MaxLength = 50
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnKeyPress = Search_stringKeyPress
      end
      object SearchButton: TButton
        Left = 218
        Top = 2
        Width = 24
        Height = 22
        Hint = #1053#1072#1081#1090#1080
        Caption = '...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = SearchButtonClick
      end
      object DownButton: TToolButton
        Left = 242
        Top = 2
        Hint = #1048#1089#1082#1072#1090#1100' '#1074#1085#1080#1079
        Caption = 'DownButton'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = DownButtonClick
      end
      object UpButton: TToolButton
        Left = 265
        Top = 2
        Hint = #1048#1089#1082#1072#1090#1100' '#1074#1074#1077#1088#1093
        Caption = 'UpButton'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = UpButtonClick
      end
      object CodeSearchKey: TEdit
        Left = 288
        Top = 2
        Width = 121
        Height = 22
        Hint = #1055#1086#1079#1080#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1082#1086#1076#1091
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnKeyPress = CodeSearchKeyKeyPress
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 33
    Width = 688
    Height = 365
    Align = alClient
    TabOrder = 3
  end
  object FormGrid: TDBGridEh
    Left = 0
    Top = 33
    Width = 688
    Height = 365
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
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    PopupMenu = GridMenu
    TabOrder = 0
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
        Width = 221
      end
      item
        EditButtons = <>
        FieldName = 'NAME'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Title.TitleButton = True
        Width = 395
      end>
  end
  object FormSource: TDataSource
    DataSet = qFormQuery
    Left = 552
    Top = 73
  end
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    Left = 584
    Top = 73
  end
  object GridMenu: TPopupMenu
    Left = 216
    Top = 126
    object N2: TMenuItem
      Caption = #1055#1086' '#1082#1086#1076#1091
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1055#1086' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1102
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1041#1077#1079' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080
      OnClick = N4Click
    end
  end
  object Query: TQuery
    DatabaseName = 'RMP'
    Left = 480
    Top = 72
  end
  object ActionList: TActionList
    Left = 104
    Top = 134
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
      OnExecute = SearchButtonClick
    end
  end
end
