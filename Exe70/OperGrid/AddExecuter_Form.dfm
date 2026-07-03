object AddExecuterForm: TAddExecuterForm
  Left = 535
  Top = 227
  Width = 783
  Height = 556
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1080#1089#1087#1086#1083#1085#1080#1090#1077#1083#1103' '#1086#1087#1077#1088#1072#1094#1080#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object FormGrid: TDBGridEh
    Left = 0
    Top = 29
    Width = 765
    Height = 430
    Hint = #1057#1074#1086#1073#1086#1076#1085#1086#1077' '#1074#1088#1077#1084#1103' '#1076#1083#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1080
    Align = alClient
    AutoFitColWidths = True
    DataSource = FormSource
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
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -15
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDblClick = FormGridDblClick
    Columns = <
      item
        EditButtons = <>
        FieldName = 'CODE_WRKR'
        Footers = <>
        Title.Caption = #1058#1072#1073#1077#1083#1100#1085#1099#1081' '#8470
        Width = 110
      end
      item
        EditButtons = <>
        FieldName = 'NAME_WRKR'
        Footers = <>
        Title.Caption = #1060#1072#1084#1080#1083#1080#1103' '#1048'.'#1054'.'
        Width = 206
      end
      item
        EditButtons = <>
        FieldName = 'CODE_EQPT'
        Footers = <>
        Title.Caption = #1048#1085#1074#1077#1085#1090#1072#1088#1085#1099#1081' '#8470
        Width = 128
      end
      item
        EditButtons = <>
        FieldName = 'NAME_EQPT'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1103
        Width = 214
      end
      item
        EditButtons = <>
        FieldName = 'DATE_BEG'
        Footers = <>
        Title.Caption = #1053#1072#1095#1072#1083#1086' '#1088#1072#1073#1086#1090#1099
        Width = 124
      end
      item
        EditButtons = <>
        FieldName = 'DATE_END'
        Footers = <>
        Title.Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077' '#1088#1072#1073#1086#1090#1099
        Width = 145
      end>
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 459
    Width = 765
    Height = 50
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 128
      Top = 10
      Width = 92
      Height = 31
      Caption = '&'#1054#1090#1084#1077#1085#1072
      TabOrder = 0
      OnClick = CloseButtonClick
    end
    object Button1: TButton
      Left = 20
      Top = 10
      Width = 92
      Height = 31
      Caption = #1054'&K'
      TabOrder = 1
      OnClick = FormGridDblClick
    end
  end
  object EnumToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 765
    Height = 29
    ButtonHeight = 24
    Caption = 'EnumToolBar'
    Flat = True
    Images = MAINForm.MainImages
    TabOrder = 2
    object NewButtom: TToolButton
      Left = 0
      Top = 0
      Hint = #1053#1086#1074#1099#1081' '#1101#1083#1077#1084#1077#1085#1090
      Caption = 'NewButtom'
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
    end
    object ToolButton1: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton1'
      ImageIndex = 9
      Style = tbsSeparator
    end
    object Searchkey: TEdit
      Left = 31
      Top = 0
      Width = 240
      Height = 24
      Hint = #1055#1086#1080#1089#1082' '#1087#1086' '#1087#1086#1076#1089#1090#1088#1086#1082#1077
      CharCase = ecUpperCase
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object FindButton: TButton
      Left = 271
      Top = 0
      Width = 16
      Height = 24
      Hint = #1053#1072#1081#1090#1080
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object DownButton: TToolButton
      Left = 287
      Top = 0
      Hint = #1055#1086#1080#1089#1082' '#1074#1085#1080#1079
      Caption = 'DownButton'
      ImageIndex = 7
      ParentShowHint = False
      ShowHint = True
    end
    object UpButton: TToolButton
      Left = 310
      Top = 0
      Hint = #1055#1086#1080#1089#1082' '#1074#1074#1077#1088#1093
      Caption = 'UpButton'
      ImageIndex = 8
      ParentShowHint = False
      ShowHint = True
    end
    object CodeSearchKey: TEdit
      Left = 333
      Top = 0
      Width = 121
      Height = 24
      Hint = #1058#1086#1095#1085#1099#1081' '#1087#1086#1080#1089#1082#13#10#1087#1086' '#1082#1086#1076#1091
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    RequestLive = True
    SQL.Strings = (
      'Select *'
      'From ADD_HANDL_OPERPLAN_PROC ('
      '    :ID_ORDER INTEGER,'
      '    :LINENO INTEGER,'
      '    :DATE_FROM DATE,'
      '    :DATE_TO DATE,'
      '    :DINNER_FROM DATE,'
      '    :DINNER_TO DATE,'
      '    :WORK_FROM DATE,'
      '    :WORK_TO DATE)')
    Left = 529
    Top = 51
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_ORDER'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'LINENO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATE_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATE_TO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DINNER_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DINNER_TO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WORK_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WORK_TO'
        ParamType = ptUnknown
      end>
  end
  object FormSource: TDataSource
    DataSet = qFormQuery
    Left = 561
    Top = 51
  end
end
