object ENUM_CSTForm: TENUM_CSTForm
  Left = 259
  Top = 178
  Width = 571
  Height = 356
  HelpContext = 114
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object PanelButton: TPanel
    Left = 0
    Top = 259
    Width = 553
    Height = 52
    Align = alBottom
    TabOrder = 0
    object OKButton: TButton
      Left = 12
      Top = 12
      Width = 93
      Height = 31
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = OK_ButtomClick
    end
    object Close_Buttom: TButton
      Left = 110
      Top = 12
      Width = 92
      Height = 31
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = Close_ButtomClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 553
    Height = 259
    Align = alClient
    TabOrder = 1
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 551
      Height = 257
      ActivePage = TabSheetMain
      Align = alClient
      TabOrder = 0
      object TabSheetMain: TTabSheet
        Caption = #1054#1089#1085#1086#1074#1085#1072#1103
        object Label1: TLabel
          Left = 22
          Top = 20
          Width = 94
          Height = 16
          Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
        end
        object Label2: TLabel
          Left = 18
          Top = 49
          Width = 102
          Height = 16
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        end
        object Label5: TLabel
          Left = 41
          Top = 178
          Width = 79
          Height = 16
          Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072':'
        end
        object Code: TEdit
          Left = 129
          Top = 20
          Width = 139
          Height = 21
          MaxLength = 8
          TabOrder = 0
        end
        object _Name: TEdit
          Left = 129
          Top = 49
          Width = 405
          Height = 21
          MaxLength = 50
          TabOrder = 1
        end
        object RadioGroupType: TRadioGroup
          Left = 10
          Top = 79
          Width = 267
          Height = 90
          Caption = #1058#1080#1087' '#1079#1072#1082#1072#1079#1095#1080#1082#1072
          TabOrder = 2
        end
        object IS_INT2: TRadioButton
          Left = 20
          Top = 138
          Width = 198
          Height = 21
          Caption = #1047#1072#1082#1072#1079' R/3'
          TabOrder = 3
        end
        object IS_INT1: TRadioButton
          Left = 20
          Top = 118
          Width = 198
          Height = 21
          Caption = #1042#1085#1077#1096#1085#1103#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
          TabOrder = 4
        end
        object IS_INT: TRadioButton
          Left = 20
          Top = 98
          Width = 198
          Height = 21
          Caption = #1042#1085#1091#1090#1088#1077#1085#1085#1077#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          TabOrder = 5
        end
        object ID_Stat: TComboEdit
          Left = 129
          Top = 172
          Width = 405
          Height = 26
          GlyphKind = gkEllipsis
          ButtonWidth = 25
          NumGlyphs = 1
          TabOrder = 6
          Tablename = 'spr_stat'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
          Query = qStatQuery
          ID = 0
          CanSelectGroup = False
          OnButtonClick = ID_StatButtonClick
          OnKeyDown = ID_StatKeyDown
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1050#1074#1086#1090#1099
        ImageIndex = 1
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 543
          Height = 31
          Align = alTop
          TabOrder = 0
          object ToolBar: TToolBar
            Left = 1
            Top = 1
            Width = 541
            Height = 26
            Caption = 'QuotaToolBar'
            Flat = True
            Images = DATA.EditImages
            TabOrder = 0
            object ToolButtonEdit: TToolButton
              Left = 0
              Top = 0
              Caption = 'ToolButtonEdit'
              ImageIndex = 1
              OnClick = ToolButtonEditClick
            end
            object ToolButtonDel: TToolButton
              Left = 23
              Top = 0
              Caption = 'ToolButtonDel'
              ImageIndex = 2
              OnClick = ToolButtonDelClick
            end
            object ButtonFill: TButton
              Left = 46
              Top = 0
              Width = 196
              Height = 22
              Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
              TabOrder = 0
              OnClick = ButtonFillClick
            end
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 31
          Width = 543
          Height = 195
          Align = alClient
          TabOrder = 1
          object CHRCGrid: TDBGridEh
            Left = 1
            Top = 1
            Width = 541
            Height = 193
            Align = alClient
            AutoFitColWidths = True
            DataSource = SprQuotaSource
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
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -15
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            OnDblClick = ToolButtonEditClick
            OnKeyDown = CHRCGridKeyDown
            Columns = <
              item
                EditButtons = <>
                FieldName = 'name'
                Footers = <>
                Title.Caption = #1058#1080#1087' '#1089#1090#1072#1085#1082#1086#1074
                Width = 79
              end
              item
                EditButtons = <>
                FieldName = 'nsize'
                Footers = <>
                Title.Caption = #1050#1074#1086#1090#1072
                Width = 79
              end>
          end
        end
      end
    end
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_pdr'
      
        'values (GEN_ID(SPR_PDR_GEN,1), :parentID, :isfolder , :code, :na' +
        'me , :maxtime)')
    Left = 528
    Top = 304
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
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 560
    Top = 304
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
  object qQuotaQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.name, b.nsize, b.id_tpeq'
      'from spr_tpeq a, quotacst b  '
      'where b.ID_cst =:id'
      ' and             a.id =b.id_tpeq')
    Left = 500
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object SprQuotaSource: TDataSource
    DataSet = qQuotaQuery
    Left = 468
    Top = 8
  end
  object qStatQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_stat'
      'where id = :id or code =:code')
    Left = 448
    Top = 144
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
end
