object ENUM_MLDForm: TENUM_MLDForm
  Left = 202
  Top = 163
  Width = 632
  Height = 398
  HelpContext = 117
  Caption = #1052#1086#1076#1077#1083#1080
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
  object Label6: TLabel
    Left = 41
    Top = 134
    Width = 153
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1090#1098#1077#1084#1085#1099#1093' '#1095#1072#1089#1090#1077#1081':'
  end
  object PanelBot: TPanel
    Left = 0
    Top = 327
    Width = 624
    Height = 44
    Align = alBottom
    TabOrder = 0
    object OKButton: TButton
      Left = 16
      Top = 11
      Width = 75
      Height = 25
      Caption = '&OK'
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object Close_button: TButton
      Left = 96
      Top = 11
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = Close_buttonClick
    end
    object MODELCombo: TComboEdit
      Left = 504
      Top = 7
      Width = 57
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 2
      Tablename = 'SPR_MDL'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1086#1076#1077#1083#1080' ('#1042#1099#1073#1086#1088')'
      Query = qModelQuery
      ID = -1
      Visible = False
      OnButtonClick = CHRTComboButtonClick
      OnKeyDown = CHRTComboKeyDown
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 327
    Align = alClient
    TabOrder = 1
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 622
      Height = 325
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = #1052#1086#1076#1077#1083#1100
        object Label1: TLabel
          Left = 41
          Top = 24
          Width = 22
          Height = 13
          Caption = #1050#1086#1076':'
        end
        object Label2: TLabel
          Left = 41
          Top = 46
          Width = 79
          Height = 13
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        end
        object Label3: TLabel
          Left = 41
          Top = 67
          Width = 42
          Height = 13
          Caption = #1063#1077#1088#1090#1077#1078':'
        end
        object Label4: TLabel
          Left = 41
          Top = 88
          Width = 63
          Height = 13
          Caption = #1042#1080#1076' '#1084#1086#1076#1077#1083#1080':'
        end
        object Label5: TLabel
          Left = 43
          Top = 111
          Width = 153
          Height = 13
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1090#1098#1077#1084#1085#1099#1093' '#1095#1072#1089#1090#1077#1081':'
        end
        object Label7: TLabel
          Left = 28
          Top = 132
          Width = 169
          Height = 13
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1077#1088#1078#1085#1077#1074#1099#1093' '#1103#1097#1080#1082#1086#1074':'
        end
        object Label8: TLabel
          Left = 81
          Top = 153
          Width = 115
          Height = 13
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1080#1073#1099#1083#1077#1081':'
        end
        object Label9: TLabel
          Left = 299
          Top = 149
          Width = 115
          Height = 13
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1096#1072#1073#1083#1086#1085#1086#1074':'
        end
        object Label10: TLabel
          Left = 55
          Top = 174
          Width = 140
          Height = 13
          Caption = #1043#1088#1091#1087#1087#1072' '#1089#1083#1086#1078#1085#1086#1089#1090#1080' '#1086#1090#1083#1080#1074#1082#1080':'
        end
        object Label11: TLabel
          Left = 276
          Top = 173
          Width = 137
          Height = 13
          Caption = #1043#1088#1091#1087#1087#1072' '#1089#1083#1086#1078#1085#1086#1089#1090#1080' '#1084#1086#1076#1077#1083#1080':'
        end
        object Label14: TLabel
          Left = 16
          Top = 200
          Width = 73
          Height = 13
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081':'
        end
        object CodeEdit: TEdit
          Left = 128
          Top = 16
          Width = 121
          Height = 21
          MaxLength = 20
          TabOrder = 0
        end
        object NameEdit: TEdit
          Left = 128
          Top = 40
          Width = 345
          Height = 21
          MaxLength = 80
          TabOrder = 1
        end
        object CHRTCombo: TComboEdit
          Left = 128
          Top = 63
          Width = 345
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 2
          Tablename = 'SPR_CHRT'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1063#1077#1088#1090#1077#1078#1080' ('#1042#1099#1073#1086#1088')'
          Query = qCHRTQuery
          ID = -1
          OnButtonClick = CHRTComboButtonClick
          OnKeyDown = CHRTComboKeyDown
        end
        object DRAWBACK_COUNT: TCurrencyEdit
          Left = 200
          Top = 106
          Width = 73
          Height = 21
          AutoSize = False
          DisplayFormat = ',0;-,0'
          MaxValue = 999.000000000000000000
          TabOrder = 3
        end
        object ModelKind: TComboBox
          Left = 128
          Top = 85
          Width = 145
          Height = 21
          ItemHeight = 13
          TabOrder = 4
        end
        object COREBOX_COUNT: TCurrencyEdit
          Left = 200
          Top = 127
          Width = 73
          Height = 21
          AutoSize = False
          DisplayFormat = ',0;-,0'
          MaxValue = 999.000000000000000000
          TabOrder = 5
        end
        object INCREASE_COUNT: TCurrencyEdit
          Left = 200
          Top = 148
          Width = 73
          Height = 21
          AutoSize = False
          DisplayFormat = ',0;-,0'
          MaxValue = 999.000000000000000000
          TabOrder = 6
        end
        object PATTERN_COUNT: TCurrencyEdit
          Left = 419
          Top = 148
          Width = 73
          Height = 21
          AutoSize = False
          DisplayFormat = ',0;-,0'
          MaxValue = 999.000000000000000000
          TabOrder = 7
        end
        object COMPLEXITYFORMING: TRxSpinEdit
          Left = 200
          Top = 170
          Width = 73
          Height = 21
          MaxValue = 10.000000000000000000
          TabOrder = 8
        end
        object COMPLEXITYMODEL: TRxSpinEdit
          Left = 419
          Top = 170
          Width = 73
          Height = 21
          MaxValue = 10.000000000000000000
          TabOrder = 9
        end
        object GroupBox1: TGroupBox
          Left = 0
          Top = 240
          Width = 614
          Height = 57
          Align = alBottom
          Caption = #1057#1082#1083#1072#1076' '#1084#1086#1076#1077#1083#1077#1081
          TabOrder = 10
          object Label12: TLabel
            Left = 24
            Top = 28
            Width = 47
            Height = 13
            Caption = #1057#1090#1077#1083#1083#1072#1078':'
          end
          object Label13: TLabel
            Left = 160
            Top = 27
            Width = 30
            Height = 13
            Caption = #1087#1086#1083#1082#1072
          end
          object ShelfEdit: TCurrencyEdit
            Left = 80
            Top = 24
            Width = 73
            Height = 21
            AutoSize = False
            DisplayFormat = ',0'#39#39';-,0'#39#39
            TabOrder = 0
          end
          object DeskEdit: TCurrencyEdit
            Left = 192
            Top = 24
            Width = 57
            Height = 21
            AutoSize = False
            DisplayFormat = ',0'#39#39';-,0'#39#39
            TabOrder = 1
          end
        end
        object INFO: TEdit
          Left = 94
          Top = 198
          Width = 397
          Height = 21
          MaxLength = 200
          TabOrder = 11
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
        ImageIndex = 1
        object ToolBarCh: TToolBar
          Left = 0
          Top = 0
          Width = 614
          Height = 24
          Caption = 'ToolBarCh'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ToolAddChar: TToolButton
            Left = 0
            Top = 0
            Caption = 'ToolAddChar'
            ImageIndex = 0
            OnClick = ToolAddCharClick
          end
          object ToolEditChar: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolEditChar'
            ImageIndex = 1
            OnClick = ToolEditCharClick
          end
          object ToolDelChar: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolDelChar'
            ImageIndex = 2
            OnClick = ToolDelCharClick
          end
        end
        object CHEQGrid: TDBGridEh
          Left = 0
          Top = 24
          Width = 614
          Height = 273
          Align = alClient
          AutoFitColWidths = True
          DataSource = DataSourceModel
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
          OnDblClick = ToolEditCharClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'NAME'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 157
            end
            item
              DisplayFormat = ',0.000;-,0.000'
              EditButtons = <>
              FieldName = 'NSIZE'
              Footers = <>
              Title.Caption = #1056#1072#1079#1084#1077#1088
              Width = 124
            end
            item
              EditButtons = <>
              FieldName = 'KIND'
              Footers = <>
              Title.Caption = #1058#1080#1087
              Width = 109
            end>
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1071#1097#1080#1082#1080
        ImageIndex = 2
        object ToolBar1: TToolBar
          Left = 0
          Top = 0
          Width = 614
          Height = 24
          Caption = 'ToolBarCh'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ToolAddBox: TToolButton
            Left = 0
            Top = 0
            Caption = 'ToolButton1'
            ImageIndex = 0
            OnClick = ToolAddBoxClick
          end
          object ToolEditBox: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolButtonEditCh'
            ImageIndex = 1
            OnClick = ToolEditBoxClick
          end
          object ToolDelBox: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolButtonDelCh'
            ImageIndex = 2
            OnClick = ToolDelBoxClick
          end
        end
        object DBGridBox: TDBGridEh
          Left = 0
          Top = 24
          Width = 614
          Height = 273
          Align = alClient
          AutoFitColWidths = True
          DataSource = DataSourceBox
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
          OnDblClick = ToolEditBoxClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'lineno'
              Footers = <>
              Title.Caption = #1053#1086#1084#1077#1088' '#1089#1090#1088#1086#1082#1080
              Visible = False
              Width = 126
            end
            item
              EditButtons = <>
              FieldName = 'BOX_NUMBER'
              Footers = <>
              Title.Caption = #1053#1086#1084#1077#1088' '#1103#1097#1080#1082#1072
              Width = 235
            end
            item
              EditButtons = <>
              FieldName = 'ROD_NUMBER'
              Footers = <>
              Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1089#1090#1077#1088#1078#1085#1077#1081
            end
            item
              EditButtons = <>
              FieldName = 'LENGHT'
              Footers = <>
              Title.Caption = #1044#1083#1080#1085#1072
            end
            item
              EditButtons = <>
              FieldName = 'WIDTH'
              Footers = <>
              Title.Caption = #1064#1080#1088#1080#1085#1072
            end
            item
              EditButtons = <>
              FieldName = 'HEIGHT'
              Footers = <>
              Title.Caption = #1042#1099#1089#1086#1090#1072
            end>
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1055#1088#1080#1073#1099#1083#1080
        ImageIndex = 3
        object ToolBar2: TToolBar
          Left = 0
          Top = 0
          Width = 614
          Height = 24
          Caption = 'ToolBarCh'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ToolAddInc: TToolButton
            Left = 0
            Top = 0
            Caption = 'ToolButton1'
            ImageIndex = 0
            OnClick = ToolAddIncClick
          end
          object ToolEditInc: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolButtonEditCh'
            ImageIndex = 1
            OnClick = ToolEditIncClick
          end
          object ToolDelInc: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolButtonDelCh'
            ImageIndex = 2
            OnClick = ToolDelIncClick
          end
        end
        object ChainGrid: TDBGridEh
          Left = 0
          Top = 24
          Width = 614
          Height = 273
          Align = alClient
          AutoFitColWidths = True
          DataSource = DataSourceInc
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
          OnDblClick = ToolEditIncClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'INCREMENT_NAME'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1080#1073#1099#1083#1080
              Width = 254
            end
            item
              EditButtons = <>
              FieldName = 'INCREMENT_NUMBER'
              Footers = <>
              Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1080#1073#1099#1083#1080
              Width = 201
            end>
        end
      end
      object TabSheet5: TTabSheet
        Caption = #1044#1091#1073#1083#1080#1082#1072#1090#1099
        ImageIndex = 4
        object ToolBar3: TToolBar
          Left = 0
          Top = 0
          Width = 614
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
        object DBGridEhDubs: TDBGridEh
          Left = 0
          Top = 24
          Width = 614
          Height = 273
          Align = alClient
          AutoFitColWidths = True
          DataSource = DataSourceDub
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
          OnEditButtonClick = ToolEditDupClick
          Columns = <
            item
              ButtonStyle = cbsEllipsis
              EditButtons = <>
              FieldName = 'Name'
              Footers = <>
              Title.Caption = #1047#1072#1084#1077#1085#1072
              Width = 414
            end>
        end
      end
    end
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 512
    Top = 88
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 512
    Top = 56
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
  object qCHRTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 480
    Top = 56
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
  object qCHMODELQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select b.id, a.name, b.nsize, b.kind '
      'from spr_vchr a, spr_modelcharacter b '
      'where a.ID = b.id_VID and b.ID_model = :id'
      'order by name')
    Left = 552
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object DataSourceModel: TDataSource
    DataSet = qCHMODELQuery
    Left = 581
    Top = 89
  end
  object qBoxQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select * from spr_modelboxes'
      'where id_model = :id')
    Left = 549
    Top = 121
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object DataSourceBox: TDataSource
    DataSet = qBoxQuery
    Left = 581
    Top = 121
  end
  object qINCQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select * from SPR_MODELINCRIMENT'
      'where id_model = :id')
    Left = 549
    Top = 161
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object DataSourceInc: TDataSource
    DataSet = qINCQuery
    Left = 581
    Top = 161
  end
  object qDubQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select dup.id, dup.ID_MODEL, mod.name'
      'from SPR_MODELDUPLICATE dup, spr_mdl mod'
      'where '
      'id_model = :id   and'
      'mod.id = dup.ID_MODELDUPLICATE ')
    Left = 549
    Top = 193
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object DataSourceDub: TDataSource
    DataSet = qDubQuery
    Left = 581
    Top = 193
  end
  object qModelQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_mdl'
      'where id = :id or code = :code')
    Left = 560
    Top = 328
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
  object qMODELTableQuery: TQuery
    DatabaseName = 'RMP'
    Left = 549
    Top = 225
  end
end
