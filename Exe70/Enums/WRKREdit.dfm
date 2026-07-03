object ENUM_WRKRForm: TENUM_WRKRForm
  Left = 313
  Top = 161
  Width = 666
  Height = 514
  HelpContext = 116
  Caption = #1069#1083#1077#1084#1077#1085#1090':'
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
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 658
    Height = 441
    ActivePage = SheetMain
    Align = alClient
    TabOrder = 0
    object SheetMain: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1072#1103
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 95
        Height = 13
        Caption = #1058#1072#1073#1077#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088':'
      end
      object Label2: TLabel
        Left = 16
        Top = 40
        Width = 30
        Height = 13
        Caption = #1060#1048#1054':'
      end
      object Label3: TLabel
        Left = 16
        Top = 64
        Width = 70
        Height = 13
        Caption = #1044#1072#1090#1072' '#1087#1088#1080#1077#1084#1072':'
      end
      object Label4: TLabel
        Left = 16
        Top = 116
        Width = 40
        Height = 13
        Caption = #1056#1072#1079#1088#1103#1076':'
      end
      object Label5: TLabel
        Left = 16
        Top = 92
        Width = 71
        Height = 13
        Caption = #1054#1082#1083#1072#1076'/'#1090#1072#1088#1080#1092':'
      end
      object Label6: TLabel
        Left = 271
        Top = 66
        Width = 23
        Height = 13
        Caption = #1055#1086#1083':'
      end
      object Label7: TLabel
        Left = 345
        Top = 67
        Width = 82
        Height = 13
        Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103':'
      end
      object Label8: TLabel
        Left = 16
        Top = 143
        Width = 61
        Height = 13
        Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1103':'
      end
      object Label9: TLabel
        Left = 16
        Top = 165
        Width = 61
        Height = 13
        Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
      end
      object Label10: TLabel
        Left = 16
        Top = 187
        Width = 83
        Height = 13
        Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
      end
      object Label11: TLabel
        Left = 16
        Top = 209
        Width = 39
        Height = 13
        Caption = #1057#1090#1072#1085#1086#1082':'
      end
      object Label12: TLabel
        Left = 16
        Top = 231
        Width = 45
        Height = 13
        Caption = #1041#1088#1080#1075#1072#1076#1072':'
      end
      object Label13: TLabel
        Left = 252
        Top = 93
        Width = 40
        Height = 13
        Caption = #1054#1087#1083#1072#1090#1072':'
      end
      object Label16: TLabel
        Left = 16
        Top = 256
        Width = 34
        Height = 13
        Caption = #1040#1076#1088#1077#1089':'
      end
      object Label17: TLabel
        Left = 16
        Top = 276
        Width = 57
        Height = 13
        Caption = #1058#1077#1083#1077#1092#1086#1085' 1:'
      end
      object Label18: TLabel
        Left = 270
        Top = 278
        Width = 57
        Height = 13
        Caption = #1058#1077#1083#1077#1092#1086#1085' 2:'
      end
      object Label14: TLabel
        Left = 334
        Top = 21
        Width = 38
        Height = 13
        Caption = #1059#1074#1086#1083#1077#1085
      end
      object Code: TEdit
        Left = 136
        Top = 16
        Width = 113
        Height = 21
        MaxLength = 8
        TabOrder = 0
      end
      object _Name: TEdit
        Left = 136
        Top = 40
        Width = 361
        Height = 21
        MaxLength = 120
        TabOrder = 1
      end
      object Date_In: TDateEdit
        Left = 136
        Top = 64
        Width = 113
        Height = 21
        NumGlyphs = 2
        TabOrder = 2
      end
      object Raiting: TRxSpinEdit
        Left = 136
        Top = 112
        Width = 49
        Height = 21
        MaxValue = 20.000000000000000000
        TabOrder = 3
      end
      object Sex: TComboBox
        Left = 297
        Top = 64
        Width = 40
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Text = #1055#1086#1083
        Items.Strings = (
          #1052
          #1046)
      end
      object Date_BIR: TDateEdit
        Left = 432
        Top = 63
        Width = 97
        Height = 21
        NumGlyphs = 2
        TabOrder = 5
      end
      object Payment: TComboBox
        Left = 304
        Top = 88
        Width = 225
        Height = 21
        ItemHeight = 13
        TabOrder = 6
        Text = #1042#1080#1076' '#1086#1087#1083#1072#1090#1099
        Items.Strings = (
          #1055#1086#1074#1088#1077#1084#1077#1085#1085#1072#1103' '#1087#1086' '#1086#1082#1083#1072#1076#1091
          #1055#1086#1074#1088#1077#1084#1077#1085#1085#1072#1103' '#1087#1086' '#1090#1072#1088#1080#1092#1091
          #1057#1076#1077#1083#1100#1085#1072#1103)
      end
      object PROFCombo: TComboEdit
        Left = 135
        Top = 135
        Width = 361
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 7
        Tablename = 'SPR_PROF'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1055#1088#1086#1092#1077#1089#1089#1080#1103' ('#1042#1099#1073#1086#1088')'
        Query = qPROFQuery
        ID = -1
        CanSelectGroup = False
        OnButtonClick = PROFComboButtonClick
        OnKeyDown = PROFComboKeyDown
      end
      object PostCombo: TComboEdit
        Left = 135
        Top = 158
        Width = 361
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 8
        Tablename = 'SPR_POST'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1044#1086#1083#1078#1085#1086#1089#1090#1080' ('#1042#1099#1073#1086#1088')'
        Query = qPOSTQuery
        ID = -1
        CanSelectGroup = False
        OnButtonClick = PostComboButtonClick
        OnKeyDown = PostComboKeyDown
      end
      object PDRCombo: TComboEdit
        Left = 135
        Top = 182
        Width = 361
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 9
        Tablename = 'SPR_PDR'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
        Query = qPDRQuery
        ID = -1
        CanSelectGroup = False
        OnButtonClick = PDRComboButtonClick
        OnKeyDown = PDRComboKeyDown
      end
      object EQPTCombo: TComboEdit
        Left = 135
        Top = 205
        Width = 361
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 10
        Tablename = 'SPR_EQPT'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1057#1090#1072#1085#1082#1080' ('#1042#1099#1073#1086#1088')'
        Query = qEQPTQuery
        ID = -1
        CanSelectGroup = False
        OnButtonClick = EQPTComboButtonClick
        OnKeyDown = EQPTComboKeyDown
      end
      object BOSSCombo: TComboEdit
        Left = 135
        Top = 229
        Width = 361
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 11
        Tablename = 'SPR_BRIGADE'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1056#1072#1073#1086#1090#1085#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
        Query = qBOSSQuery
        ID = -1
        CanSelectGroup = False
        OnButtonClick = BOSSComboButtonClick
        OnKeyDown = BOSSComboKeyDown
      end
      object Salary: TCurrencyEdit
        Left = 136
        Top = 88
        Width = 81
        Height = 21
        AutoSize = False
        TabOrder = 12
      end
      object Address: TEdit
        Left = 135
        Top = 250
        Width = 362
        Height = 21
        TabOrder = 13
      end
      object Phone_1: TMaskEdit
        Left = 136
        Top = 272
        Width = 118
        Height = 21
        EditMask = '!9999999999999;1; '
        MaxLength = 13
        TabOrder = 14
        Text = '             '
      end
      object Phone_2: TMaskEdit
        Left = 336
        Top = 272
        Width = 118
        Height = 21
        EditMask = '!9999999999999;1; '
        MaxLength = 13
        TabOrder = 15
        Text = '             '
      end
      object Panel4: TPanel
        Left = 0
        Top = 294
        Width = 650
        Height = 119
        Align = alBottom
        TabOrder = 16
        object GroupBox1: TGroupBox
          Left = 1
          Top = 1
          Width = 648
          Height = 117
          Align = alClient
          Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          TabOrder = 0
          object INFO: TMemo
            Left = 2
            Top = 15
            Width = 644
            Height = 100
            Align = alClient
            TabOrder = 0
          end
        end
      end
      object VOPCombo: TComboEdit
        Left = 480
        Top = 281
        Width = 41
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 17
        Tablename = 'spr_vop'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1086#1087#1077#1088#1072#1094#1080#1081' ('#1042#1099#1073#1086#1088')'
        Query = qSelectVOPQuery
        ID = -1
        CanSelectGroup = False
        Visible = False
        OnButtonClick = PDRComboButtonClick
        OnKeyDown = PDRComboKeyDown
      end
      object ComboEdit1: TComboEdit
        Left = 528
        Top = 281
        Width = 41
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 18
        Tablename = 'spr_vop'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
        Query = qSelectEQPTQuery
        ID = -1
        CanSelectGroup = False
        Visible = False
        OnButtonClick = PDRComboButtonClick
        OnKeyDown = PDRComboKeyDown
      end
      object DismissDateEdit: TDateEdit
        Left = 384
        Top = 16
        Width = 113
        Height = 21
        NumGlyphs = 2
        TabOrder = 19
      end
    end
    object SheetVOP: TTabSheet
      Caption = #1054#1087#1077#1088#1072#1094#1080#1080
      ImageIndex = 1
      object PanelBotVP: TPanel
        Left = 0
        Top = 0
        Width = 650
        Height = 25
        Align = alTop
        TabOrder = 0
        object ToolBarCH: TToolBar
          Left = 1
          Top = 1
          Width = 568
          Height = 29
          Caption = 'ToolBarCH'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ButtonAddVOP: TToolButton
            Left = 0
            Top = 0
            Caption = 'ButtonAddVOP'
            ImageIndex = 0
            OnClick = ButtonAddVOPClick
          end
          object ButtonEditVOP: TToolButton
            Left = 23
            Top = 0
            Caption = 'ButtonEditVOP'
            ImageIndex = 1
            OnClick = ButtonEditVOPClick
          end
          object ButtonDelVOP: TToolButton
            Left = 46
            Top = 0
            Caption = 'ButtonDelVOP'
            ImageIndex = 2
            OnClick = ButtonDelVOPClick
          end
        end
      end
      object PanelVOP: TPanel
        Left = 0
        Top = 25
        Width = 650
        Height = 388
        Align = alClient
        TabOrder = 1
        object VOPGrid: TDBGridEh
          Left = 1
          Top = 1
          Width = 648
          Height = 386
          Align = alClient
          AutoFitColWidths = True
          DataSource = DataSourceOp
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
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          OnEditButtonClick = ButtonEditVOPClick
          OnKeyDown = VOPGridKeyDown
          Columns = <
            item
              ButtonStyle = cbsEllipsis
              EditButtons = <>
              FieldName = 'NAME'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
              Width = 317
            end>
        end
      end
    end
    object SheetEQPT: TTabSheet
      Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
      ImageIndex = 2
      object PanelBotEQ: TPanel
        Left = 0
        Top = 0
        Width = 650
        Height = 25
        Align = alTop
        TabOrder = 0
        object ToolBar1: TToolBar
          Left = 1
          Top = 1
          Width = 568
          Height = 29
          Caption = 'ToolBarCH'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ButtonAddEQPT: TToolButton
            Left = 0
            Top = 0
            Caption = 'TooButtonAdd'
            ImageIndex = 0
            OnClick = ButtonAddEQPTClick
          end
          object ButtonEditEQPT: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolButtonEdit'
            ImageIndex = 1
            OnClick = ButtonEditEQPTClick
          end
          object ButtonDelEqpt: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolButtonDel'
            ImageIndex = 2
            OnClick = ButtonDelEqptClick
          end
        end
      end
      object PanelEQ: TPanel
        Left = 0
        Top = 25
        Width = 650
        Height = 388
        Align = alClient
        TabOrder = 1
        object EQPTGrid: TDBGridEh
          Left = 1
          Top = 1
          Width = 648
          Height = 386
          Align = alClient
          AutoFitColWidths = True
          DataSource = DataSourceEQ
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
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          OnEditButtonClick = ButtonEditEQPTClick
          OnKeyDown = EQPTGridKeyDown
          Columns = <
            item
              ButtonStyle = cbsEllipsis
              EditButtons = <>
              FieldName = 'NAME'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
              Width = 405
            end>
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1040#1090#1090#1077#1089#1090#1072#1094#1080#1103
      ImageIndex = 3
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 650
        Height = 25
        Align = alTop
        TabOrder = 0
        object Label19: TLabel
          Left = 13
          Top = 5
          Width = 152
          Height = 13
          Caption = #1055#1088#1086#1093#1086#1078#1076#1077#1085#1080#1077' '#1072#1090#1090#1077#1089#1090#1072#1094#1080#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 50
        Width = 650
        Height = 363
        Align = alClient
        TabOrder = 1
        object SertificateGrid: TDBGridEh
          Left = 1
          Top = 1
          Width = 648
          Height = 361
          Align = alClient
          AutoFitColWidths = True
          DataSource = DataSourceSertificate
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
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          OnDblClick = ButtonEditAttClick
          OnKeyDown = SertificateGridKeyDown
          Columns = <
            item
              EditButtons = <>
              FieldName = 'PROTOCOL_NUMBER'
              Footers = <>
              Title.Caption = #8470' '#1087#1088#1086#1090#1086#1082'.'
              Width = 71
            end
            item
              EditButtons = <>
              FieldName = 'NUMBER'
              Footers = <>
              Title.Caption = #8470' '#1091#1076#1086#1089#1090'-'#1103
              Width = 68
            end
            item
              EditButtons = <>
              FieldName = 'NAME'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 245
            end
            item
              EditButtons = <>
              FieldName = 'SERTIFICATE_DATE'
              Footers = <>
              Title.Caption = #1044'.'#1087#1088#1086#1093#1086#1078#1076'.'
              Width = 74
            end
            item
              EditButtons = <>
              FieldName = 'EXPARE_DATE'
              Footers = <>
              Title.Caption = #1044'.'#1086#1082#1086#1085#1095#1072#1085'.'
              Width = 70
            end>
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 25
        Width = 650
        Height = 25
        Align = alTop
        TabOrder = 2
        object ToolBar2: TToolBar
          Left = 1
          Top = 1
          Width = 648
          Height = 29
          Caption = 'ToolBarCH'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ButtonAddAtt: TToolButton
            Left = 0
            Top = 0
            Caption = 'TooButtonAdd'
            ImageIndex = 0
            OnClick = ButtonAddAttClick
          end
          object ButtonEditAtt: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolButtonEdit'
            ImageIndex = 1
            OnClick = ButtonEditAttClick
          end
          object ButtonDelAdd: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolButtonDel'
            ImageIndex = 2
            OnClick = ButtonDelAddClick
          end
        end
      end
    end
  end
  object PanelBot: TPanel
    Left = 0
    Top = 441
    Width = 658
    Height = 39
    Align = alBottom
    TabOrder = 1
    object Close_Buttom: TButton
      Left = 96
      Top = 6
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = Close_ButtomClick
    end
    object OKButton: TButton
      Left = 16
      Top = 6
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
      OnClick = OKButtonClick
    end
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name'
      'where'
      '  ID =  :ID')
    Left = 384
    Top = 264
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CODE'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftString
        Name = 'NAME'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qPROFQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_prof'
      'where id = :id or code = :code')
    Left = 560
    Top = 128
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
  object qPOSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_post'
      'where id = :id or code = :code')
    Left = 560
    Top = 160
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
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 560
    Top = 192
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
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code')
    Left = 560
    Top = 224
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
  object qBOSSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_brigade'
      'where id = :id or code = :code')
    Left = 560
    Top = 256
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
  object qVOPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select wrvp.id, vop.name, wrvp.id_vop'
      'from spr_vop vop, spr_wrvop wrvp'
      'where wrvp.id_wrkr = :id and'
      '           vop.id = wrvp.id_vop'
      'order by vop.id')
    Left = 590
    Top = 130
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object qEQQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select wreq.id, eqpt.name, wreq.id_eqpt'
      'from spr_eqpt eqpt, spr_wreq wreq'
      'where wreq.id_wrkr = :id and'
      '           eqpt.id = wreq.id_eqpt'
      'order by eqpt.id')
    Left = 590
    Top = 162
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object DataSourceOp: TDataSource
    DataSet = qVOPQuery
    Left = 620
    Top = 130
  end
  object DataSourceEQ: TDataSource
    DataSet = qEQQuery
    Left = 620
    Top = 162
  end
  object qVOPStoredProc: TStoredProc
    DatabaseName = 'RMP'
    SessionName = 'Default'
    StoredProcName = 'ADD_SPR_WRKRVOP_PROC'
    Left = 596
    Top = 226
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'RES'
        ParamType = ptOutput
      end>
  end
  object qEQPTStoredProc: TStoredProc
    DatabaseName = 'RMP'
    SessionName = 'Default'
    StoredProcName = 'ADD_SPR_WRKREQPT_PROC'
    Left = 628
    Top = 226
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'RES'
        ParamType = ptOutput
      end>
  end
  object DataSourceSertificate: TDataSource
    DataSet = qSertificateQuery
    Left = 620
    Top = 194
  end
  object qSertificateQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select sert.id_wrkr, sert.lineno, sert.PROTOCOL_NUMBER, spr.name' +
        ',  sert.SERTIFICATE_DATE,'
      '       sert.NUMBER,  sert.EXPARE_DATE'
      'from SPR_WORKERSERTIFICATE sert, spr_sertificate spr'
      'where sert.id_sertificate = spr.id and'
      '      sert.id_wrkr = :id_wrkr')
    Left = 588
    Top = 194
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_wrkr'
        ParamType = ptUnknown
      end>
  end
  object UpdateStoredProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_SPR_WORKER_PROC'
    Left = 452
    Top = 264
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CODE'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'NAME'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_INT'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'RATING'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'SALARY'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'SEX'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_BIR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PROF'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PAY'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'BRIGADE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_POST'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ADDRESS'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PHONE_1'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PHONE_2'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DISMISS'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PARENTID'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'ISFOLDER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NEW_ID'
        ParamType = ptOutput
      end>
  end
  object qUpdateVOPQuery: TQuery
    DatabaseName = 'RMP'
    Left = 461
    Top = 361
  end
  object qSelectVOPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_vop'
      'where id = :id or code = :code')
    Left = 428
    Top = 360
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
  object qSelectEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code')
    Left = 516
    Top = 360
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
  object qUpdateEQPTQuery: TQuery
    DatabaseName = 'RMP'
    Left = 549
    Top = 361
  end
end
