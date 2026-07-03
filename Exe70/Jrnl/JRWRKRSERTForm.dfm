object JR_WRKRSERTForm: TJR_WRKRSERTForm
  Left = 265
  Top = 279
  Width = 952
  Height = 656
  Caption = #1040#1090#1090#1077#1089#1090#1072#1094#1080#1103' '#1088#1072#1073#1086#1090#1085#1080#1082#1086#1074' '#1056#1052#1055
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 353
    Top = 34
    Height = 534
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 944
    Height = 34
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 302
      Height = 26
      AutoSize = True
      Caption = 'JRImageList'
      Images = MAINForm.JRImageList
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 2
        Caption = 'ToolButton1'
        ImageIndex = 11
        OnClick = ToolButton1Click
      end
      object ToolButton2: TToolButton
        Left = 23
        Top = 2
        Width = 8
        Caption = 'ToolButton2'
        ImageIndex = 9
        Style = tbsSeparator
      end
      object Searchkey: TEdit
        Left = 31
        Top = 2
        Width = 205
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyPress = SearchkeyKeyPress
      end
      object FindButton: TButton
        Left = 236
        Top = 2
        Width = 16
        Height = 22
        Hint = #1053#1072#1081#1090#1080
        Caption = '...'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = FindButtonClick
      end
      object ToolButton7: TToolButton
        Left = 252
        Top = 2
        Hint = #1055#1086#1080#1089#1082#13#10#1074#1085#1080#1079
        Caption = 'ToolButton7'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton7Click
      end
      object ToolButton8: TToolButton
        Left = 275
        Top = 2
        Hint = #1055#1086#1080#1089#1082#13#10#1074#1074#1077#1088#1093
        Caption = 'ToolButton8'
        ImageIndex = 8
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton8Click
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 34
    Width = 353
    Height = 534
    Align = alLeft
    TabOrder = 1
    object WrkrDBGridEh: TDBGridEh
      Left = 1
      Top = 1
      Width = 351
      Height = 532
      Align = alClient
      AutoFitColWidths = True
      DataSource = WrkrDataSource
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = WrkrDBGridEhDblClick
      OnTitleBtnClick = WrkrDBGridEhTitleBtnClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'CODE'
          Footers = <>
          Title.Caption = #1058#1072#1073#1077#1083#1100#1085#1099#1081' '#8470
          Title.TitleButton = True
        end
        item
          EditButtons = <>
          FieldName = 'NAME'
          Footers = <>
          Title.Caption = #1060#1072#1084#1080#1083#1080#1103' '#1048'.'#1054'.'
          Title.TitleButton = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 568
    Width = 944
    Height = 54
    Align = alBottom
    TabOrder = 2
    object Button1: TButton
      Left = 24
      Top = 8
      Width = 97
      Height = 33
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = Button1Click
      OnKeyDown = Button1KeyDown
    end
  end
  object Panel3: TPanel
    Left = 356
    Top = 34
    Width = 588
    Height = 534
    Align = alClient
    TabOrder = 3
    object Splitter2: TSplitter
      Left = 1
      Top = 249
      Width = 586
      Height = 3
      Cursor = crVSplit
      Align = alTop
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 586
      Height = 248
      Align = alTop
      TabOrder = 0
      object Panel6: TPanel
        Left = 1
        Top = 1
        Width = 584
        Height = 16
        Align = alTop
        Caption = #1040#1090#1090#1077#1089#1090#1072#1094#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object SertDBGridEh: TDBGridEh
        Left = 1
        Top = 17
        Width = 584
        Height = 230
        Align = alClient
        DataSource = SertDataSource
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = WrkrDBGridEhDblClick
        OnTitleBtnClick = SertDBGridEhTitleBtnClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'PROTOCOL_NUMBER'
            Footers = <>
            Title.Caption = #8470' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
            Title.TitleButton = True
          end
          item
            EditButtons = <>
            FieldName = 'NAME'
            Footers = <>
            Title.Caption = #1042#1080#1076' '#1072#1090#1090#1077#1089#1090#1072#1094#1080#1080
            Title.TitleButton = True
          end
          item
            EditButtons = <>
            FieldName = 'SERTIFICATE_DATE'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1087#1086#1083#1091#1095#1077#1085#1080#1103
            Title.TitleButton = True
          end
          item
            EditButtons = <>
            FieldName = 'EXPARE_DATE'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
            Title.TitleButton = True
          end>
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 252
      Width = 586
      Height = 281
      Align = alClient
      TabOrder = 1
      object Panel7: TPanel
        Left = 1
        Top = 1
        Width = 584
        Height = 16
        Align = alTop
        Caption = #1044#1086#1087#1091#1089#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object AccessDBGridEh: TDBGridEh
        Left = 1
        Top = 17
        Width = 584
        Height = 263
        Align = alClient
        DataSource = AccessDataSource
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = WrkrDBGridEhDblClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'NAME'
            Footers = <>
            Title.Caption = #1042#1080#1076' '#1076#1086#1087#1091#1089#1082#1072
          end>
      end
    end
  end
  object WrkrQuery: TQuery
    Active = True
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select * From Spr_Wrkr')
    Left = 48
    Top = 90
  end
  object SertQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'Select a.protocol_number, b.name,  a.sertificate_date,  a.expare' +
        '_date,'
      'a.lineno, a.number, a.id_Wrkr'
      'From spr_workersertificate a, spr_sertificate b'
      'Where a.id_wrkr = :id and a.id_sertificate = b.id'
      'Order By 1')
    Left = 589
    Top = 91
    ParamData = <
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptUnknown
        Value = '2'
      end>
  end
  object AccessQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.name'
      
        'From spr_sertificateaccess a, spr_accesstype b, spr_workersertif' +
        'icate c'
      'Where a.id_wrkr = :id and'
      '      c.lineno  = :lineno and'
      '      a.wrkr_lineno = c.lineno and'
      '      c.id_wrkr = a.id_wrkr and'
      '      b.id = a.id_accesstype'
      'Order By 1')
    Left = 589
    Top = 350
    ParamData = <
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'lineno'
        ParamType = ptUnknown
      end>
  end
  object WrkrDataSource: TDataSource
    DataSet = WrkrQuery
    OnDataChange = WrkrDataSourceDataChange
    Left = 88
    Top = 90
  end
  object SertDataSource: TDataSource
    DataSet = SertQuery
    OnDataChange = SertDataSourceDataChange
    Left = 629
    Top = 91
  end
  object AccessDataSource: TDataSource
    DataSet = AccessQuery
    Left = 629
    Top = 350
  end
end
