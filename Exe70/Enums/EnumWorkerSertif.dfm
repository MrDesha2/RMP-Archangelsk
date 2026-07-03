object ENUM_WORKERSERTFORM: TENUM_WORKERSERTFORM
  Left = 223
  Top = 197
  Width = 530
  Height = 452
  HelpContext = 100
  BorderIcons = [biSystemMenu]
  Caption = #1040#1090#1090#1077#1089#1090#1072#1094#1080#1103' '#1088#1072#1073#1086#1090#1085#1080#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 380
    Width = 522
    Height = 45
    Align = alBottom
    TabOrder = 0
    object Close_Buttom: TButton
      Left = 96
      Top = 12
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = Close_ButtomClick
    end
    object OK_Buttom: TButton
      Left = 16
      Top = 12
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = OK_ButtomClick
    end
    object spr_accesstype: TComboEdit
      Left = 424
      Top = 8
      Width = 41
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 2
      Tablename = 'spr_accesstype'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1058#1080#1087#1099' '#1076#1086#1089#1090#1091#1087#1072' ('#1042#1099#1073#1086#1088')'
      Query = qSelACCESSTYPEQuery
      ID = -1
      Visible = False
      OnButtonClick = SertificateComboButtonClick
      OnKeyDown = SertificateComboKeyDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 522
    Height = 380
    Align = alClient
    TabOrder = 1
    object LabelPlan: TLabel
      Left = 16
      Top = 40
      Width = 139
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1072#1090#1090#1077#1089#1090#1072#1094#1080#1080':'
    end
    object Enum_label: TLabel
      Left = 16
      Top = 16
      Width = 93
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1087#1088#1086#1090#1086#1082#1086#1083#1072':'
    end
    object Label1: TLabel
      Left = 16
      Top = 64
      Width = 99
      Height = 13
      Caption = #1044#1072#1090#1072' '#1087#1088#1086#1093#1086#1078#1076#1077#1085#1080#1103':'
    end
    object Label2: TLabel
      Left = 16
      Top = 88
      Width = 116
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1091#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1103':'
    end
    object Label3: TLabel
      Left = 16
      Top = 112
      Width = 78
      Height = 13
      Caption = #1057#1088#1086#1082' '#1076#1077#1081#1089#1090#1074#1080#1103':'
    end
    object SertificateCombo: TComboEdit
      Left = 160
      Top = 37
      Width = 297
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 1
      Tablename = 'SPR_SERTIFICATE'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1040#1090#1090#1077#1089#1090#1072#1094#1080#1103' ('#1042#1099#1073#1086#1088')'
      Query = qSertQuery
      ID = -1
      OnButtonClick = SertificateComboButtonClick
      OnKeyDown = SertificateComboKeyDown
    end
    object Protokol_number: TEdit
      Left = 160
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object SERTIFICATE_DATA: TDateEdit
      Left = 160
      Top = 58
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 2
    end
    object Number: TEdit
      Left = 160
      Top = 80
      Width = 297
      Height = 21
      MaxLength = 20
      TabOrder = 3
    end
    object EXPARE_DATE: TDateEdit
      Left = 160
      Top = 104
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 4
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 127
      Width = 520
      Height = 89
      Align = alBottom
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
      TabOrder = 5
      object Info: TMemo
        Left = 2
        Top = 15
        Width = 516
        Height = 72
        Align = alClient
        TabOrder = 0
      end
    end
    object GroupBox2: TGroupBox
      Left = 528
      Top = 8
      Width = 57
      Height = 56
      Caption = #1058#1080#1087' '#1076#1086#1087#1091#1089#1082#1072
      TabOrder = 6
      Visible = False
      object Access_type: TMemo
        Left = 2
        Top = 15
        Width = 53
        Height = 39
        Align = alClient
        TabOrder = 0
      end
    end
    object PanelGrid: TPanel
      Left = 1
      Top = 216
      Width = 520
      Height = 163
      Align = alBottom
      TabOrder = 7
      object ToolBar3: TToolBar
        Left = 1
        Top = 1
        Width = 518
        Height = 24
        Caption = 'ToolBarCh'
        Flat = True
        Images = DATA.EditImages
        TabOrder = 0
        object ToolAddDup: TToolButton
          Left = 0
          Top = 0
          Caption = 'ToolButton1'
          ImageIndex = 0
          OnClick = ToolAddDupClick
        end
        object ToolEditDup: TToolButton
          Left = 23
          Top = 0
          Caption = 'ToolButtonEditCh'
          ImageIndex = 1
          OnClick = ToolEditDupClick
        end
        object ToolDelDup: TToolButton
          Left = 46
          Top = 0
          Caption = 'ToolButtonDelCh'
          ImageIndex = 2
          OnClick = ToolDelDupClick
        end
      end
      object Grid: TDBGridEh
        Left = 1
        Top = 25
        Width = 518
        Height = 137
        Align = alClient
        AutoFitColWidths = True
        DataSource = DataSource
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
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            ButtonStyle = cbsNone
            EditButtons = <>
            FieldName = 'Code'
            Footers = <>
            Title.Caption = #1050#1086#1076' '#1076#1086#1087#1091#1089#1082#1072
            Width = 113
          end
          item
            ButtonStyle = cbsEllipsis
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            Title.Caption = #1044#1086#1087#1091#1089#1082
            Width = 318
            OnEditButtonClick = GridColumns1EditButtonClick
          end>
      end
    end
  end
  object qSertQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_sertificate'
      'where id = :id or code = :code')
    Left = 424
    Top = 64
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftFloat
        Name = 'CODE'
        ParamType = ptUnknown
        Value = '0'
      end>
  end
  object StoredProc: TStoredProc
    DatabaseName = 'RMP'
    SessionName = 'Default'
    StoredProcName = 'ADD_SPR_WRKRSERTIFICATE'
    Left = 456
    Top = 64
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PROTOCOL_NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_SERTIFICATE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'SERTIFICATE_DATE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'EXPARE_DATE'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'ACCESS_TYPE'
        ParamType = ptInput
      end>
  end
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 456
    Top = 96
  end
  object qACCESSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select acc.id, acctype.code, acctype.name, acc.lineno, acc.id_ac' +
        'cesstype'
      'from spr_sertificateaccess acc, spr_accesstype acctype'
      'where '
      'acc.id_wrkr = :id_wrkr and'
      'acc.wrkr_lineno = :lineno and'
      'acc.id_accesstype = acctype.id')
    Left = 456
    Top = 232
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_wrkr'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'lineno'
        ParamType = ptUnknown
      end>
  end
  object DataSource: TDataSource
    DataSet = qACCESSQuery
    Left = 488
    Top = 232
  end
  object qDelQuery: TQuery
    DatabaseName = 'RMP'
    Left = 456
    Top = 256
  end
  object qSelACCESSTYPEQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select * from spr_accesstype'
      'where id = :id or code = :code')
    Left = 456
    Top = 380
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'code'
        ParamType = ptUnknown
      end>
  end
  object qUPDATEACCESSQuery: TQuery
    DatabaseName = 'RMP'
    Left = 456
    Top = 272
  end
end
