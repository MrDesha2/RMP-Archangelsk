object JR_EQPTRSPRForm: TJR_EQPTRSPRForm
  Left = 199
  Top = 173
  Width = 944
  Height = 666
  Caption = #1044#1074#1080#1078#1077#1085#1080#1077' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 329
    Top = 34
    Height = 544
  end
  object Panel1: TPanel
    Left = 0
    Top = 34
    Width = 329
    Height = 544
    Align = alLeft
    TabOrder = 0
    object EqptDBGridEh: TDBGridEh
      Left = 1
      Top = 1
      Width = 327
      Height = 542
      Align = alClient
      AutoFitColWidths = True
      DataSource = EqptDataSource
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
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = EqptDBGridEhDblClick
      OnTitleBtnClick = EqptDBGridEhTitleBtnClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'CODE'
          Footers = <>
          Title.Alignment = taRightJustify
          Title.Caption = #1048#1085#1074'. '#1085#1086#1084#1077#1088
          Title.TitleButton = True
        end
        item
          EditButtons = <>
          FieldName = 'NAME'
          Footers = <>
          Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Title.TitleButton = True
          Width = 230
        end>
    end
  end
  object RightPanel: TPanel
    Left = 332
    Top = 34
    Width = 604
    Height = 544
    Align = alClient
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 1
      Top = 249
      Width = 602
      Height = 4
      Cursor = crVSplit
      Align = alTop
    end
    object PREqptPanel: TPanel
      Left = 1
      Top = 1
      Width = 602
      Height = 248
      Align = alTop
      TabOrder = 0
      object PREqptDBGridEh: TDBGridEh
        Left = 1
        Top = 17
        Width = 600
        Height = 183
        Align = alClient
        DataSource = PRDataSource
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = PREqptDBGridEhDblClick
        OnDrawColumnCell = PREqptDBGridEhDrawColumnCell
        Columns = <
          item
            EditButtons = <>
            FieldName = 'NUMDOC'
            Footers = <>
            Title.Alignment = taRightJustify
            Title.Caption = #8470' '#1076#1086#1082'.'
            Width = 71
          end
          item
            EditButtons = <>
            FieldName = 'DATE_IN'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1044#1072#1090#1072' '#1076#1086#1082'.'
            Width = 57
          end
          item
            EditButtons = <>
            FieldName = 'NUMBER'
            Footers = <>
            Title.Alignment = taRightJustify
            Title.Caption = #1050#1086#1083'-'#1074#1086
            Width = 42
          end
          item
            EditButtons = <>
            FieldName = 'CODE_EDIZ'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1045#1076'.'#1080#1079#1084'.'
            Width = 44
          end
          item
            EditButtons = <>
            FieldName = 'TYPE_DOC'
            Footers = <>
            Title.Caption = #1042#1080#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          end
          item
            EditButtons = <>
            FieldName = 'NAME_WRHS'
            Footers = <>
            Title.Caption = #1057#1082#1083#1072#1076
          end
          item
            EditButtons = <>
            FieldName = 'CELL'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1052#1077#1089#1090#1086' '#1093#1088#1072#1085#1077#1085#1080#1103
            Width = 85
          end
          item
            EditButtons = <>
            FieldName = 'NAME_WRKR'
            Footers = <>
            Title.Caption = #1056#1072#1073#1086#1090#1085#1080#1082
            Width = 161
          end
          item
            EditButtons = <>
            FieldName = 'NAME_CST'
            Footers = <>
            Title.Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
          end
          item
            EditButtons = <>
            FieldName = 'INFO'
            Footers = <>
            Title.Caption = #1055#1088#1080#1084'.'
            Width = 135
          end>
      end
      object PRPanel: TPanel
        Left = 1
        Top = 1
        Width = 600
        Height = 16
        Align = alTop
        Caption = #1055#1088#1080#1093#1086#1076#1085#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 1
        Top = 200
        Width = 600
        Height = 47
        Align = alBottom
        TabOrder = 2
        object Label_Eqpt_In_Vozvr: TLabel
          Left = 8
          Top = 0
          Width = 139
          Height = 13
          Caption = #1042#1086#1079#1074#1088#1072#1097#1077#1085#1086' '#1089'   .  .  '#1087#1086'   .  .  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label_Eqpt_In_Post: TLabel
          Left = 8
          Top = 16
          Width = 129
          Height = 13
          Caption = #1055#1086#1089#1090#1091#1087#1080#1083#1086' '#1089'   .  .  '#1087#1086'   .  .  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label_Eqpt_In_Total: TLabel
          Left = 8
          Top = 32
          Width = 36
          Height = 13
          Caption = #1048#1090#1086#1075#1086
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object RSEqptPanel: TPanel
      Left = 1
      Top = 253
      Width = 602
      Height = 290
      Align = alClient
      TabOrder = 1
      object RSEqptDBGridEh: TDBGridEh
        Left = 1
        Top = 17
        Width = 600
        Height = 225
        Align = alClient
        DataSource = RSDataSource
        Flat = True
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDblClick = RSEqptDBGridEhDblClick
        OnDrawColumnCell = RSEqptDBGridEhDrawColumnCell
        Columns = <
          item
            Alignment = taRightJustify
            EditButtons = <>
            FieldName = 'NUMDOC'
            Footers = <>
            Title.Caption = #8470' '#1076#1086#1082'.'
            Width = 58
          end
          item
            EditButtons = <>
            FieldName = 'DATE_IN'
            Footers = <>
            Title.Caption = #1044#1072#1090#1072' '#1076#1086#1082'.'
            Width = 63
          end
          item
            EditButtons = <>
            FieldName = 'NUMBER'
            Footers = <>
            Title.Caption = #1050#1086#1083'-'#1074#1086
            Width = 47
          end
          item
            EditButtons = <>
            FieldName = 'CODE_EDIZ'
            Footers = <>
            Title.Caption = #1045#1076'. '#1080#1079#1084'.'
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'TYPE_DOC'
            Footers = <>
            Title.Caption = #1042#1080#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          end
          item
            EditButtons = <>
            FieldName = 'NAME_WRHS'
            Footers = <>
            Title.Caption = #1057#1082#1083#1072#1076
          end
          item
            EditButtons = <>
            FieldName = 'CELL'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #1052#1077#1089#1090#1086' '#1093#1088#1072#1085#1077#1085#1080#1103
            Width = 86
          end
          item
            EditButtons = <>
            FieldName = 'NAME_WRKR'
            Footers = <>
            Title.Caption = #1056#1072#1073#1086#1090#1085#1080#1082
            Width = 201
          end
          item
            EditButtons = <>
            FieldName = 'NAME_CST'
            Footers = <>
            Title.Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082
          end
          item
            EditButtons = <>
            FieldName = 'INFO'
            Footers = <>
            Title.Caption = #1055#1088#1080#1084'.'
            Width = 148
          end>
      end
      object RSPanel: TPanel
        Left = 1
        Top = 1
        Width = 600
        Height = 16
        Align = alTop
        Caption = #1056#1072#1089#1093#1086#1076#1085#1099#1077' '#1076#1086#1082#1091#1084#1077#1085#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object Panel3: TPanel
        Left = 1
        Top = 242
        Width = 600
        Height = 47
        Align = alBottom
        TabOrder = 2
        object Label_Eqpt_Out_Vyd: TLabel
          Left = 8
          Top = 0
          Width = 114
          Height = 13
          Caption = #1042#1099#1076#1072#1085#1086' '#1089'   .  .  '#1087#1086'   .  .  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label_Eqpt_Out_Spis: TLabel
          Left = 8
          Top = 16
          Width = 118
          Height = 13
          Caption = #1057#1087#1080#1089#1072#1085#1086' '#1089'   .  .  '#1087#1086'   .  .  '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label_Eqpt_Out_Total: TLabel
          Left = 8
          Top = 32
          Width = 36
          Height = 13
          Caption = #1048#1090#1086#1075#1086
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 578
    Width = 936
    Height = 54
    Align = alBottom
    TabOrder = 2
    object TotalLabel: TLabel
      Left = 816
      Top = 16
      Width = 49
      Height = 16
      Caption = #1048#1090#1086#1075#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 24
      Top = 8
      Width = 97
      Height = 33
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object EQPT_RS_Button: TButton
      Left = 128
      Top = 8
      Width = 97
      Height = 33
      Caption = '&'#1058#1088#1077#1073#1086#1074#1072#1085#1080#1077'- '#1085#1072#1082#1083#1072#1076#1085#1072#1103
      TabOrder = 1
      WordWrap = True
      OnClick = EQPT_RS_ButtonClick
    end
    object Wrkr_Card_Button: TButton
      Left = 232
      Top = 8
      Width = 97
      Height = 33
      Caption = '&'#1050#1072#1088#1090#1086#1095#1082#1072
      TabOrder = 2
      WordWrap = True
      OnClick = Wrkr_Card_ButtonClick
    end
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 936
    Height = 34
    Align = alTop
    AutoSize = True
    TabOrder = 3
    object ToolBar1: TToolBar
      Left = 11
      Top = 2
      Width = 102
      Height = 26
      AutoSize = True
      Caption = 'ToolBar1'
      Images = MAINForm.MainImages
      TabOrder = 0
      object PREqptToolButton: TToolButton
        Left = 0
        Top = 2
        Caption = 'PREqptToolButton'
        ImageIndex = 36
        Style = tbsCheck
        OnMouseDown = PREqptToolButtonMouseDown
      end
      object RSEqptToolButton: TToolButton
        Left = 23
        Top = 2
        Caption = 'RSEqptToolButton'
        ImageIndex = 35
        Style = tbsCheck
        OnMouseDown = RSEqptToolButtonMouseDown
      end
      object ToolButton5: TToolButton
        Left = 46
        Top = 2
        Width = 8
        Caption = 'ToolButton5'
        ImageIndex = 39
        Style = tbsSeparator
      end
      object PR_Doc_ToolButton: TToolButton
        Left = 54
        Top = 2
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077'"'
        Caption = 'PR_Doc_ToolButton'
        ImageIndex = 38
        ParentShowHint = False
        ShowHint = True
        OnClick = PR_Doc_ToolButtonClick
      end
      object RS_Doc_ToolButton: TToolButton
        Left = 77
        Top = 2
        Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1056#1072#1089#1093#1086#1076'"'
        Caption = 'RS_Doc_ToolButton'
        ImageIndex = 37
        ParentShowHint = False
        ShowHint = True
        OnClick = RS_Doc_ToolButtonClick
      end
    end
    object ToolBar2: TToolBar
      Left = 126
      Top = 2
      Width = 323
      Height = 26
      AutoSize = True
      Caption = 'JRImageList'
      Images = MAINForm.JRImageList
      TabOrder = 1
      object refresh_button: TToolButton
        Left = 0
        Top = 2
        Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
        Caption = 'refresh_button'
        ImageIndex = 11
        ParentShowHint = False
        ShowHint = True
        OnClick = refresh_buttonClick
      end
      object Date_Filter_ToolButton: TToolButton
        Left = 23
        Top = 2
        Hint = #1048#1085#1090#1077#1088#1074#1072#1083' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1055#1088#1080#1093#1086#1076#1085#1099#1093', '#1056#1072#1089#1093#1086#1076#1085#1099#1093' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074
        Caption = 'Date_Filter_ToolButton'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = Date_Filter_ToolButtonClick
      end
      object Searchkey: TEdit
        Left = 46
        Top = 2
        Width = 205
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 0
        OnKeyPress = SearchkeyKeyPress
      end
      object FindButton: TButton
        Left = 251
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
        Left = 267
        Top = 2
        Hint = #1055#1086#1080#1089#1082#13#10#1074#1085#1080#1079
        Caption = 'ToolButton7'
        ImageIndex = 7
        ParentShowHint = False
        ShowHint = True
        OnClick = ToolButton7Click
      end
      object ToolButton8: TToolButton
        Left = 290
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
  object EqptQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.code, a.name, a.id, a.parentid, Sum(b.Number) as NSum'
      'From Spr_Eqpt a, St_Eqpt b '
      'Where a.isfolder = 0 and b.ID_Eqpt = a.ID '
      'Group By a.code, a.name, a.id, a.parentid')
    Left = 120
    Top = 77
  end
  object PREqptQuery: TQuery
    DatabaseName = 'RMP'
    Left = 357
    Top = 54
  end
  object RSEqptQuery: TQuery
    DatabaseName = 'RMP'
    Left = 365
    Top = 345
  end
  object EqptDataSource: TDataSource
    DataSet = EqptQuery
    OnDataChange = EqptDataSourceDataChange
    Left = 160
    Top = 77
  end
  object PRDataSource: TDataSource
    DataSet = PREqptQuery
    Left = 389
    Top = 54
  end
  object RSDataSource: TDataSource
    DataSet = RSEqptQuery
    Left = 397
    Top = 345
  end
  object EdizQuery: TQuery
    DatabaseName = 'RMP'
    Left = 120
    Top = 122
  end
end
