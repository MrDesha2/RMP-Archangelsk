object JR_PLANFACTForm: TJR_PLANFACTForm
  Left = 216
  Top = 220
  Width = 701
  Height = 447
  HelpContext = 351
  Caption = #1052#1077#1089#1103#1095#1085#1099#1081' '#1078#1091#1088#1085#1072#1083' '#1079#1072#1082#1072#1079#1086#1074
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
  PixelsPerInch = 96
  TextHeight = 13
  object pBotPanel: TPanel
    Left = 0
    Top = 352
    Width = 693
    Height = 41
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
  object pTopPanel: TPanel
    Left = 0
    Top = 0
    Width = 693
    Height = 26
    Align = alTop
    TabOrder = 2
    object ToolBar: TToolBar
      Left = 1
      Top = 1
      Width = 691
      Height = 29
      ButtonWidth = 25
      Caption = 'FormToolBar'
      Flat = True
      Images = MAINForm.JRImageList
      TabOrder = 0
      object ToolButtonAdd: TToolButton
        Left = 0
        Top = 0
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079
        Caption = 'ToolButtonAdd'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonAddClick
      end
      object ToolButtonEdit: TToolButton
        Left = 25
        Top = 0
        Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1082#1072#1079
        Caption = 'ToolButtonEdit'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonEditClick
      end
      object ToolButtonDel: TToolButton
        Left = 50
        Top = 0
        Hint = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1082#1072#1079
        Caption = 'ToolButtonDel'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButtonDelClick
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
        OnClick = ChangePeriodClick
      end
      object PlanButton: TToolButton
        Left = 270
        Top = 0
        Hint = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
        Caption = 'PlanButton'
        DropdownMenu = ButtonMenu
        ImageIndex = 10
        ParentShowHint = False
        ShowHint = True
        Style = tbsDropDown
        OnClick = PlanButtonClick
      end
      object Searchkey: TEdit
        Left = 308
        Top = 0
        Width = 205
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 1
        OnKeyPress = SearchkeyKeyPress
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
        OnClick = ToolButton1Click
      end
      object ToolButton3: TToolButton
        Left = 554
        Top = 0
        Caption = 'ToolFindUp'
        ImageIndex = 8
        OnClick = ToolButton3Click
      end
    end
  end
  object pMainPanel: TPanel
    Left = 0
    Top = 26
    Width = 693
    Height = 326
    Align = alClient
    TabOrder = 0
    object FormGrid: TDBGridEh
      Left = 1
      Top = 1
      Width = 691
      Height = 324
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
      PopupMenu = PopupMenuTable
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = [fsBold]
      OnDblClick = ToolButtonEditClick
      OnKeyDown = FormGridKeyDown
      OnTitleBtnClick = FormGridTitleBtnClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'Number'
          Footers = <>
          Title.Caption = #1053#1086#1084#1077#1088
          Title.TitleButton = True
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'Date_in'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
          Title.TitleButton = True
          Width = 112
        end
        item
          Alignment = taCenter
          EditButtons = <>
          FieldName = 'Date_out'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          Title.TitleButton = True
          Width = 137
        end
        item
          EditButtons = <>
          FieldName = 'name_pdr'
          Footers = <>
          Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'-'#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100
          Title.TitleButton = True
          Width = 147
        end
        item
          EditButtons = <>
          FieldName = 'pr_exec'
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
          Width = 87
        end
        item
          EditButtons = <>
          FieldName = 'CHRT_NAME'
          Footers = <>
          Title.Caption = #1063#1077#1088#1090#1077#1078
          Width = 78
        end
        item
          EditButtons = <>
          FieldName = 'CHRT_CODE'
          Footers = <>
          Title.Caption = #1050#1086#1076' '#1095#1077#1088#1090#1077#1078#1072
        end>
    end
  end
  object FormSource: TDataSource
    DataSet = qFormQuery
    Left = 640
    Top = 50
  end
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select a.number, a.date_in, a.date_out,  a.id, b.id, c.name, d.i' +
        'd, a.id_rqst'
      'from dh_order a, jr_plan b, spr_pdr c, dh_rqst d'
      'where     a.id = b.id_order and'
      '        a.id_pdr = c.id and '
      '        b.period = :period and'
      '       a.id_rqst = d.id'
      ''
      'order by a.date_in')
    Left = 640
    Top = 82
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'period'
        ParamType = ptUnknown
      end>
  end
  object qDelQuery: TQuery
    DatabaseName = 'RMP'
    Left = 641
    Top = 114
  end
  object qAddQuery: TQuery
    DatabaseName = 'RMP'
    Left = 640
    Top = 146
  end
  object Proc_change_period_plan: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'CHANGE_PERIOD_PLAN'
    Left = 640
    Top = 210
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PERIOD'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NEW_PERIOD'
        ParamType = ptInput
      end>
  end
  object Proc_change_period_prod: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'CHANGE_PERIOD_PROD'
    Left = 640
    Top = 178
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PERIOD'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NEW_PERIOD'
        ParamType = ptInput
      end>
  end
  object CreatePlan_Proc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'CREATE_PLAN'
    Left = 640
    Top = 242
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_ORDER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CLEAR_PERIOD'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PERIOD'
        ParamType = ptInput
      end>
  end
  object ButtonMenu: TPopupMenu
    TrackButton = tbLeftButton
    Left = 296
    Top = 90
    object MakePlan: TMenuItem
      Caption = #1054#1073#1098#1077#1084#1085#1086#1077' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077
      OnClick = PlanButtonClick
    end
    object MakeRS_MTR_DOCS: TMenuItem
      Caption = #1055#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086#1090#1088#1077#1073#1085#1086#1089#1090#1077#1081' '#1074' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1093
      OnClick = MakeRS_MTR_DOCSClick
    end
    object MenuClearAll: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1078#1091#1088#1085#1072#1083
      OnClick = MenuClearAllClick
    end
  end
  object PopupMenuTable: TPopupMenu
    Images = MAINForm.JRImageList
    Left = 184
    Top = 114
    object PopupAdd: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1078#1091#1088#1085#1072#1083
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1078#1091#1088#1085#1072#1083
      ImageIndex = 0
      OnClick = ToolButtonAddClick
    end
    object PopupEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 1
      OnClick = ToolButtonEditClick
    end
    object PopupDel: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1078#1091#1088#1085#1072#1083#1072
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1078#1091#1088#1085#1072#1083#1072
      ImageIndex = 2
      OnClick = ToolButtonDelClick
    end
    object PopupFilt: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1073#1086#1088
      Hint = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1073#1086#1088
      ImageIndex = 6
      OnClick = ToolButtonFilterClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object PopupNewPeriod: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1077#1088#1080#1086#1076
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1077#1088#1080#1086#1076
      ImageIndex = 9
      OnClick = ChangePeriodClick
    end
    object N1231: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = #1054#1073#1098#1077#1084#1085#1086#1077' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077
      Hint = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1087#1083#1072#1085
      OnClick = PlanButtonClick
    end
    object N2: TMenuItem
      Caption = #1055#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086#1090#1088#1077#1073#1085#1086#1089#1090#1080' '#1074' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1093
      Hint = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1089#1093#1086#1076#1085#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
      OnClick = MakeRS_MTR_DOCSClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MenuByWidth: TMenuItem
      Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
      Checked = True
      OnClick = MainMenuByWidClick
    end
  end
  object MainMenu: TMainMenu
    Images = MAINForm.JRImageList
    Left = 216
    Top = 113
    object MenuItem1: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      GroupIndex = 1
      object MainMenuAdd: TMenuItem
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        ImageIndex = 0
        ShortCut = 45
        OnClick = ToolButtonAddClick
      end
      object MainMenuEdit: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
        ImageIndex = 1
        OnClick = ToolButtonEditClick
      end
      object MainMenuDel: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1080#1079' '#1078#1091#1088#1085#1072#1083#1072
        ImageIndex = 2
        ShortCut = 46
        OnClick = ToolButtonDelClick
      end
      object MainMenuInt: TMenuItem
        Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1077#1088#1080#1086#1076
        ImageIndex = 3
        OnClick = ChangePeriodClick
      end
      object MainMenuFiltr: TMenuItem
        Caption = #1060#1080#1083#1100#1090#1088
        ImageIndex = 6
        ShortCut = 115
        OnClick = ToolButtonFilterClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N5: TMenuItem
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        ShortCut = 116
        OnClick = N5Click
      end
      object MainMenuByWid: TMenuItem
        Caption = #1055#1086' '#1096#1080#1088#1080#1085#1077
        Checked = True
        OnClick = MainMenuByWidClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object N8: TMenuItem
        Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1087#1083#1072#1085
        OnClick = PlanButtonClick
      end
      object N9: TMenuItem
        Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1088#1072#1089#1093#1086#1076#1085#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        OnClick = MakeRS_MTR_DOCSClick
      end
      object Columns: TMenuItem
        Caption = #1050#1086#1083#1086#1085#1082#1080
        object TMenuItem
        end
      end
      object N10: TMenuItem
        Caption = #1042#1074#1077#1089#1090#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1080
        object N11: TMenuItem
          Caption = #1063#1077#1088#1090#1077#1078
          OnClick = N11Click
        end
      end
    end
  end
end
