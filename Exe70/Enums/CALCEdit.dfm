object ENUM_CALCForm: TENUM_CALCForm
  Left = 193
  Top = 183
  Width = 519
  Height = 378
  HelpContext = 119
  BorderIcons = [biSystemMenu]
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072' "'#1047#1072#1090#1088#1072#1090#1099'"'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 511
    Height = 306
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 0
    object PageControl: TPageControl
      Left = 2
      Top = 2
      Width = 507
      Height = 302
      ActivePage = TabSheetMain
      Align = alClient
      TabOrder = 0
      object TabSheetMain: TTabSheet
        Caption = #1054#1089#1085#1086#1074#1085#1072#1103
        object Label1: TLabel
          Left = 24
          Top = 14
          Width = 74
          Height = 13
          Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
        end
        object Label2: TLabel
          Left = 24
          Top = 40
          Width = 79
          Height = 13
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        end
        object Label3: TLabel
          Left = 24
          Top = 107
          Width = 51
          Height = 13
          Caption = #1042#1077#1083#1080#1095#1080#1085#1072':'
          Visible = False
        end
        object Label4: TLabel
          Left = 24
          Top = 84
          Width = 53
          Height = 13
          Caption = #1052#1042#1047' '#1056#1052#1055':'
          Visible = False
        end
        object NValue: TRxCalcEdit
          Left = 104
          Top = 102
          Width = 121
          Height = 21
          AutoSize = False
          MaxValue = 100000.000000000000000000
          NumGlyphs = 2
          TabOrder = 4
          Visible = False
        end
        object _Name: TEdit
          Left = 104
          Top = 36
          Width = 257
          Height = 21
          MaxLength = 25
          TabOrder = 1
        end
        object _Code: TEdit
          Left = 104
          Top = 14
          Width = 121
          Height = 21
          MaxLength = 4
          TabOrder = 0
        end
        object PDRCombo: TComboEdit
          Left = 104
          Top = 79
          Width = 33
          Height = 20
          ClickKey = 16397
          GlyphKind = gkEllipsis
          NumGlyphs = 1
          TabOrder = 3
          Tablename = 'spr_pdr'
          Query = qPDRQuery
          Visible = False
          OnButtonClick = PDRComboButtonClick
          OnKeyDown = PDRComboKeyDown
        end
        object is_int_calc: TCheckBox
          Left = 104
          Top = 63
          Width = 289
          Height = 12
          Caption = #1042#1080#1076' '#1079#1072#1090#1088#1072#1090' '#1091#1095#1080#1090#1099#1074#1072#1077#1090#1089#1103' '#1076#1083#1103' '#1074#1085#1091#1090#1088#1077#1085#1085#1080#1093' '#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074
          TabOrder = 2
        end
      end
      object TabSheetValues: TTabSheet
        Caption = #1042#1077#1083#1080#1095#1080#1085#1099' '#1087#1086' '#1052#1042#1047
        ImageIndex = 1
        object PanelTool: TPanel
          Left = 0
          Top = 0
          Width = 499
          Height = 25
          Align = alTop
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 0
          object ToolBar: TToolBar
            Left = 2
            Top = 2
            Width = 495
            Height = 27
            Caption = 'ToolBar'
            Flat = True
            Images = MAINForm.MainImages
            TabOrder = 0
            object ToolButtonAdd: TToolButton
              Left = 0
              Top = 0
              Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
              ImageIndex = 0
              OnClick = ToolButtonAddClick
            end
            object ToolButtonEdit: TToolButton
              Left = 23
              Top = 0
              Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
              ImageIndex = 2
              OnClick = ToolButtonEditClick
            end
            object ToolButtonDel: TToolButton
              Left = 46
              Top = 0
              Caption = #1059#1076#1072#1083#1077#1085#1080#1077
              ImageIndex = 3
              OnClick = ToolButtonDelClick
            end
          end
        end
        object PanelGrid: TPanel
          Left = 0
          Top = 25
          Width = 499
          Height = 249
          Align = alClient
          BevelInner = bvRaised
          BevelOuter = bvLowered
          TabOrder = 1
          object PDRValueGrid: TDBGridEh
            Left = 2
            Top = 2
            Width = 495
            Height = 245
            Align = alClient
            AutoFitColWidths = True
            DataSource = TableSource
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = DEFAULT_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -11
            FooterFont.Name = 'MS Sans Serif'
            FooterFont.Style = []
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnDblClick = ToolButtonEditClick
            OnKeyDown = PDRValueGridKeyDown
            Columns = <
              item
                EditButtons = <>
                FieldName = 'NAME'
                Footers = <>
                Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
                Width = 256
              end
              item
                EditButtons = <>
                FieldName = 'NVALUE'
                Footers = <>
                Title.Caption = #1042#1077#1083#1080#1095#1080#1085#1072
                Width = 95
              end>
          end
        end
      end
    end
  end
  object PanelBot: TPanel
    Left = 0
    Top = 306
    Width = 511
    Height = 45
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object OKButton: TButton
      Left = 8
      Top = 10
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object Close_Buttom: TButton
      Left = 88
      Top = 10
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = Close_ButtomClick
    end
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 392
    Top = 48
    ParamData = <
      item
        DataType = ftFloat
        Name = 'CODE'
        ParamType = ptUnknown
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'NAME'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'MAXTIME'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_calc'
      
        'values (GEN_ID(SPR_PDR_GEN,1), :parentID, :isfolder , :code, :na' +
        'me , :maxtime)')
    Left = 400
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'parentID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'isfolder'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'Code'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftString
        Name = 'Name'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'MaxTime'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_pdr where id = :id  or code = :code')
    Left = 421
    Top = 48
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
  object qTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.name, b.nvalue, b.id'
      'from spr_pdr a, spr_clcmvz b'
      'where a.id = b.id_pdr and'
      '           b.id_calc = :id')
    Left = 431
    Top = 93
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
    object qTableQueryNVALUE: TFloatField
      FieldName = 'NVALUE'
      DisplayFormat = '0.00'
    end
    object qTableQueryNAME: TStringField
      FieldName = 'NAME'
      FixedChar = True
      Size = 40
    end
    object qTableQueryID: TIntegerField
      FieldName = 'ID'
    end
  end
  object TableSource: TDataSource
    DataSet = qTableQuery
    Left = 390
    Top = 83
  end
end
