object DOC_REQUESTForm: TDOC_REQUESTForm
  Left = 124
  Top = 96
  Width = 703
  Height = 491
  HelpContext = 210
  Caption = #1047#1072#1103#1074#1082#1072':'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 695
    Height = 193
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 128
      Top = 16
      Width = 204
      Height = 24
      Caption = #1047#1072#1103#1074#1082#1072' '#8470'              '#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 51
      Width = 94
      Height = 13
      Caption = #1044#1072#1090#1072' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103':'
    end
    object Label3: TLabel
      Left = 24
      Top = 75
      Width = 83
      Height = 13
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object Label4: TLabel
      Left = 24
      Top = 98
      Width = 51
      Height = 13
      Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    end
    object Date_In: TDateEdit
      Left = 336
      Top = 16
      Width = 105
      Height = 21
      NumGlyphs = 2
      TabOrder = 1
    end
    object Date_Out: TDateEdit
      Left = 127
      Top = 48
      Width = 114
      Height = 21
      NumGlyphs = 2
      TabOrder = 2
      OnChange = ValueChange
    end
    object GroupBox: TGroupBox
      Left = 3
      Top = 113
      Width = 681
      Height = 69
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      TabOrder = 8
      object INFO: TRichEdit
        Left = 2
        Top = 15
        Width = 677
        Height = 52
        Align = alClient
        TabOrder = 0
      end
    end
    object RadioGroup: TRadioGroup
      Left = 482
      Top = 40
      Width = 201
      Height = 73
      Caption = #1055#1088#1080#1079#1085#1072#1082' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
      TabOrder = 9
    end
    object PR_EXEC: TRadioButton
      Left = 488
      Top = 56
      Width = 113
      Height = 17
      Caption = #1053#1077' '#1074#1099#1087#1086#1083#1085#1077#1085#1072
      TabOrder = 5
      OnClick = ValueChange
    end
    object PR_EXEC1: TRadioButton
      Left = 488
      Top = 72
      Width = 113
      Height = 17
      Caption = #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
      TabOrder = 6
      OnClick = ValueChange
    end
    object PR_EXEC2: TRadioButton
      Left = 488
      Top = 88
      Width = 113
      Height = 17
      Caption = #1047#1072#1082#1088#1099#1090#1072
      TabOrder = 7
      OnClick = ValueChange
    end
    object RequestNumber: TMaskEdit
      Left = 232
      Top = 16
      Width = 68
      Height = 21
      EditMask = '9999999999;1; '
      MaxLength = 10
      TabOrder = 0
      Text = '          '
    end
    object PDR_Combo: TComboEdit
      Left = 128
      Top = 69
      Width = 329
      Height = 21
      ClickKey = 16397
      GlyphKind = gkEllipsis
      NumGlyphs = 1
      TabOrder = 3
      Tablename = 'spr_pdr'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
      Query = qPDRQuery
      OnButtonClick = PDR_ComboButtonClick
      OnKeyDown = PDR_ComboKeyDown
    end
    object CST_Combo: TComboEdit
      Left = 128
      Top = 93
      Width = 329
      Height = 21
      ClickKey = 16397
      GlyphKind = gkEllipsis
      NumGlyphs = 1
      TabOrder = 4
      Tablename = 'spr_cst'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' ('#1042#1099#1073#1086#1088')'
      Query = qCSTQuery
      OnButtonClick = CST_ComboButtonClick
      OnKeyDown = CST_ComboKeyDown
    end
    object CheckStatusBut: TButton
      Left = 608
      Top = 56
      Width = 65
      Height = 49
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1089#1090#1072#1090#1091#1089
      TabOrder = 10
      WordWrap = True
      OnClick = CheckStatusButClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 409
    Width = 695
    Height = 36
    Align = alBottom
    TabOrder = 1
    object OKButton: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object CloseButton: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = CloseButtonClick
    end
    object RefreshButton: TButton
      Left = 514
      Top = 7
      Width = 75
      Height = 25
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      TabOrder = 2
      OnClick = RefreshButtonClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 193
    Width = 695
    Height = 216
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 693
      Height = 26
      Align = alTop
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 691
        Height = 25
        Caption = 'DocToolBar'
        Images = MAINForm.JRImageList
        TabOrder = 0
        object AddButton: TToolButton
          Left = 0
          Top = 2
          Caption = 'AddButton'
          ImageIndex = 0
          OnClick = AddButtonClick
        end
        object EditButton: TToolButton
          Left = 23
          Top = 2
          Caption = 'EditButton'
          ImageIndex = 1
          OnClick = EditButtonClick
        end
        object DelButton: TToolButton
          Left = 46
          Top = 2
          Caption = 'DelButton'
          ImageIndex = 2
          OnClick = DelButtonClick
        end
      end
    end
    object OrderGrid: TDBGridEh
      Left = 1
      Top = 27
      Width = 693
      Height = 188
      Align = alClient
      AutoFitColWidths = True
      DataSource = FormTableSource
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PopupMenu
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = EditButtonClick
      OnKeyDown = OrderGridKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'Number'
          Footers = <>
          Title.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
          Width = 79
        end
        item
          EditButtons = <>
          FieldName = 'Date_in'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103
          Width = 252
        end
        item
          EditButtons = <>
          FieldName = 'Name'
          Footers = <>
          Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          Width = 171
        end
        item
          EditButtons = <>
          FieldName = 'Name_1'
          Footers = <>
          Title.Caption = #1063#1077#1088#1090#1077#1078
          Width = 140
        end
        item
          EditButtons = <>
          FieldName = 'Pr_exec'
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
          Width = 115
        end>
    end
  end
  object qCheckStatusQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select pr_exec'
      'from dh_order ord'
      'where id_rqst = :iddoc')
    Left = 736
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object FormTableSource: TDataSource
    DataSet = FormTableQuery
    Left = 792
    Top = 40
  end
  object FormTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select a.id, a.id_rqst, a.number, b.name, c.name, a.date_in, a.p' +
        'r_exec '
      'from dh_order a, spr_pdr b, spr_chrt c'
      'where a.id_rqst = :id and'
      '           b.id = a.id_pdr and'
      '           a.id_chrt = c.id')
    Left = 768
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object RQSTProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_RQST_PROC'
    Left = 768
    Top = 96
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_IN'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_OUT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CST'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PR_EXEC'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDDOC'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'NEWNUMDOC'
        ParamType = ptOutput
      end>
  end
  object DELProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'DEL_RQST_PROC'
    Left = 768
    Top = 128
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IDDOC'
        ParamType = ptInput
      end>
  end
  object UPDATEProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'UPDATE_RQST_PROC'
    Left = 768
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IDDOC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_IN'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_OUT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CST'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'PR_EXEC'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end>
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select  id ,parentid,  name,code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 736
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'code'
        ParamType = ptUnknown
      end>
  end
  object PDRSource: TDataSource
    DataSet = qPDRQuery
    Left = 760
    Top = 40
  end
  object qCSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id,parentid, name, code'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 736
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'code'
        ParamType = ptUnknown
      end>
  end
  object CSTSource: TDataSource
    DataSet = qCSTQuery
    Left = 760
    Top = 72
  end
  object MainMenu: TMainMenu
    Images = MAINForm.JRImageList
    Left = 736
    Top = 97
    object N1: TMenuItem
      Caption = #1044#1077#1081#1089#1090#1074#1080#1103
      GroupIndex = 1
      object MenuNewOrd: TMenuItem
        Caption = #1053#1086#1074#1099#1081' '#1079#1072#1082#1072#1079
        ImageIndex = 0
        ShortCut = 45
        OnClick = AddButtonClick
      end
      object MenuEditOrd: TMenuItem
        Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1082#1072#1079
        ImageIndex = 1
        OnClick = EditButtonClick
      end
      object MenuDelOrd: TMenuItem
        Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1082#1072#1079
        ImageIndex = 2
        ShortCut = 46
        OnClick = DelButtonClick
      end
    end
  end
  object PopupMenu: TPopupMenu
    Images = MAINForm.JRImageList
    Left = 736
    Top = 128
    object SubNewOrd: TMenuItem
      Caption = #1053#1086#1074#1099#1081' '#1079#1072#1082#1072#1079
      ImageIndex = 0
      ShortCut = 45
      OnClick = AddButtonClick
    end
    object SubEditOrd: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1079#1072#1082#1072#1079
      ImageIndex = 1
      ShortCut = 13
      OnClick = EditButtonClick
    end
    object SubDelOrd: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1079#1072#1082#1072#1079
      ImageIndex = 2
      ShortCut = 46
      OnClick = DelButtonClick
    end
  end
end
