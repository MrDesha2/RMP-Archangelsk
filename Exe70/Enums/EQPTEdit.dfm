object ENUM_EQPTForm: TENUM_EQPTForm
  Left = 341
  Top = 179
  Width = 745
  Height = 498
  HelpContext = 113
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072':'
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
  object Panel1: TPanel
    Left = 0
    Top = 422
    Width = 737
    Height = 42
    Align = alBottom
    TabOrder = 0
    object OK_Button: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1054#1050
      TabOrder = 0
      OnClick = OK_ButtonClick
    end
    object CloseButton: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = CloseButtonClick
    end
    object Save_Button: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 2
      OnClick = Save_ButtonClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 737
    Height = 422
    ActivePage = TabSheetMain
    Align = alClient
    TabOrder = 1
    object TabSheetMain: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1072#1103
      object Label1: TLabel
        Left = 5
        Top = 19
        Width = 74
        Height = 13
        Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
      end
      object Label2: TLabel
        Left = 5
        Top = 43
        Width = 79
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      end
      object Label3: TLabel
        Left = 5
        Top = 68
        Width = 83
        Height = 13
        Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
      end
      object Label4: TLabel
        Left = 5
        Top = 93
        Width = 60
        Height = 13
        Caption = #1058#1080#1087' '#1089#1090#1072#1085#1082#1072':'
      end
      object Label5: TLabel
        Left = 5
        Top = 115
        Width = 106
        Height = 13
        Caption = #1047#1072#1074#1086#1076'-'#1080#1079#1075#1086#1090#1086#1074#1080#1090#1077#1083#1100':'
      end
      object Label6: TLabel
        Left = 8
        Top = 142
        Width = 113
        Height = 13
        Caption = #1053#1072#1095#1072#1083#1086' '#1101#1082#1089#1087#1083#1091#1072#1090#1072#1094#1080#1080':'
      end
      object Label7: TLabel
        Left = 8
        Top = 165
        Width = 80
        Height = 13
        Caption = #1044#1072#1090#1072' '#1089#1087#1080#1089#1072#1085#1080#1103':'
      end
      object Label8: TLabel
        Left = 5
        Top = 190
        Width = 96
        Height = 13
        Caption = #1058#1080#1087' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103':'
      end
      object Label9: TLabel
        Left = 6
        Top = 214
        Width = 26
        Height = 13
        Caption = #1043#1086#1089#1090':'
      end
      object Label10: TLabel
        Left = 264
        Top = 19
        Width = 37
        Height = 13
        Caption = #1057#1090#1072#1090#1091#1089':'
      end
      object Label11: TLabel
        Left = 6
        Top = 257
        Width = 81
        Height = 13
        Caption = #1040#1082#1090' '#1086' '#1089#1087#1080#1089#1072#1085#1080#1080':'
      end
      object Label12: TLabel
        Left = 254
        Top = 138
        Width = 165
        Height = 13
        Caption = #1057#1088#1086#1082' '#1087#1086#1083#1077#1079#1085#1086#1075#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103':'
      end
      object Label13: TLabel
        Left = 5
        Top = 280
        Width = 109
        Height = 13
        Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1079#1072#1087#1072#1089':'
      end
      object Label14: TLabel
        Left = 191
        Top = 281
        Width = 115
        Height = 13
        Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1099#1081' '#1079#1072#1087#1072#1089':'
      end
      object Label16: TLabel
        Left = 6
        Top = 235
        Width = 36
        Height = 13
        Caption = #1052#1072#1088#1082#1072':'
      end
      object Label17: TLabel
        Left = 6
        Top = 303
        Width = 105
        Height = 13
        Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103':'
      end
      object Label15: TLabel
        Left = 254
        Top = 160
        Width = 79
        Height = 13
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1084'/'#1095':'
      end
      object Code: TEdit
        Left = 104
        Top = 16
        Width = 113
        Height = 21
        MaxLength = 8
        TabOrder = 0
      end
      object _Name: TEdit
        Left = 104
        Top = 40
        Width = 377
        Height = 21
        MaxLength = 60
        TabOrder = 1
      end
      object BUILDER: TEdit
        Left = 128
        Top = 112
        Width = 353
        Height = 21
        TabOrder = 4
      end
      object BeginDate: TDateEdit
        Left = 128
        Top = 136
        Width = 121
        Height = 21
        NumGlyphs = 2
        TabOrder = 5
      end
      object EndDate: TDateEdit
        Left = 128
        Top = 160
        Width = 121
        Height = 21
        NumGlyphs = 2
        TabOrder = 6
      end
      object PDRCombo: TComboEdit
        Left = 104
        Top = 65
        Width = 377
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 2
        Tablename = 'spr_pdr'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
        Query = qPDRQuery
        ID = -1
        CanSelectGroup = False
        OnButtonClick = PDRComboButtonClick
        OnKeyDown = PDRComboKeyDown
      end
      object TYPEID: TComboEdit
        Left = 104
        Top = 89
        Width = 377
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 3
        Tablename = 'SPR_TPEQ'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1058#1080#1087#1099' '#1089#1090#1072#1085#1082#1072' ('#1042#1099#1073#1086#1088')'
        Query = qTYPEQuery
        ID = -1
        CanSelectGroup = False
        OnButtonClick = TYPEIDButtonClick
        OnKeyDown = TYPEIDKeyDown
      end
      object TypeEQPTCombo: TComboBox
        Left = 104
        Top = 184
        Width = 145
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 7
        Text = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
        Items.Strings = (
          #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
          #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
          #1054#1089#1085#1072#1089#1090#1082#1072)
      end
      object GostEdit: TEdit
        Left = 104
        Top = 208
        Width = 377
        Height = 21
        MaxLength = 50
        TabOrder = 8
      end
      object StatusCombo: TComboBox
        Left = 312
        Top = 16
        Width = 169
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 9
        Text = #1040#1082#1090#1080#1074#1085#1099#1081
        Items.Strings = (
          #1040#1082#1090#1080#1074#1085#1099#1081
          #1057#1087#1080#1089#1072#1085' '#1087#1086' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1080#1080
          #1057#1087#1080#1089#1072#1085' '#1089#1086' '#1089#1082#1083#1072#1076#1072)
      end
      object ACTEdit: TEdit
        Left = 104
        Top = 252
        Width = 377
        Height = 21
        MaxLength = 20
        TabOrder = 10
      end
      object UsefuLifeEdit: TCurrencyEdit
        Left = 424
        Top = 136
        Width = 57
        Height = 21
        AutoSize = False
        DisplayFormat = ',0.'#39'.'#39';-,0.'#39'.'#39
        TabOrder = 11
      end
      object MinValue: TCurrencyEdit
        Left = 128
        Top = 276
        Width = 49
        Height = 21
        AutoSize = False
        DisplayFormat = ',0.'#39'.'#39';-,0.'#39'.'#39
        TabOrder = 12
      end
      object MaxValue: TCurrencyEdit
        Left = 312
        Top = 276
        Width = 49
        Height = 21
        AutoSize = False
        DisplayFormat = ',0.'#39'.'#39';-,0.'#39'.'#39
        TabOrder = 13
      end
      object MarkEdit: TEdit
        Left = 104
        Top = 230
        Width = 377
        Height = 21
        MaxLength = 20
        TabOrder = 14
      end
      object EDIZCombo: TComboEdit
        Left = 128
        Top = 297
        Width = 353
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 15
        Tablename = 'spr_ediz'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1081' ('#1042#1099#1073#1086#1088')'
        Query = qEDIZQuery
        ID = -1
        CanSelectGroup = False
        OnButtonClick = EDIZComboButtonClick
        OnKeyDown = EDIZComboKeyDown
      end
      object VOPCombo: TComboEdit
        Left = 440
        Top = 321
        Width = 41
        Height = 21
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 16
        Tablename = 'spr_vop'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1086#1087#1077#1088#1072#1094#1080#1081' ('#1042#1099#1073#1086#1088')'
        Query = qSelectVOPQuery
        ID = -1
        CanSelectGroup = False
        Visible = False
        OnButtonClick = PDRComboButtonClick
        OnKeyDown = PDRComboKeyDown
      end
      object CostEdit: TCurrencyEdit
        Left = 336
        Top = 160
        Width = 145
        Height = 21
        AutoSize = False
        TabOrder = 17
      end
    end
    object TabSheetCHRT: TTabSheet
      Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 729
        Height = 25
        Align = alTop
        TabOrder = 0
        object ToolBarCh: TToolBar
          Left = 1
          Top = 1
          Width = 727
          Height = 29
          Caption = 'ToolBarCh'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ToolButton1: TToolButton
            Left = 0
            Top = 0
            Caption = 'ToolButton1'
            ImageIndex = 0
            OnClick = ButtonAddChClick
          end
          object ToolButtonEditCh: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolButtonEditCh'
            ImageIndex = 1
            OnClick = ButtonEditChClick
          end
          object ToolButtonDelCh: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolButtonDelCh'
            ImageIndex = 2
            OnClick = ButtonDelChClick
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 25
        Width = 729
        Height = 376
        Align = alClient
        TabOrder = 1
        object CHEQGrid: TDBGridEh
          Left = 1
          Top = 1
          Width = 727
          Height = 374
          Align = alClient
          AutoFitColWidths = True
          DataSource = CHEQSource
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
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          OnDblClick = ButtonEditChClick
          OnKeyDown = CHEQGridKeyDown
          Columns = <
            item
              EditButtons = <>
              FieldName = 'NAME'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            end
            item
              DisplayFormat = ',0.000;-,0.000'
              EditButtons = <>
              FieldName = 'NSIZE'
              Footers = <>
              Title.Caption = #1056#1072#1079#1084#1077#1088
            end
            item
              EditButtons = <>
              FieldName = 'KIND'
              Footers = <>
              Title.Caption = #1058#1080#1087
            end>
        end
      end
    end
    object TabSheetRep: TTabSheet
      Caption = #1056#1077#1084#1086#1085#1090#1099
      ImageIndex = 2
      object Splitter: TSplitter
        Left = 0
        Top = 270
        Width = 729
        Height = 4
        Cursor = crVSplit
        Align = alBottom
      end
      object Panel4: TPanel
        Left = 0
        Top = 274
        Width = 729
        Height = 127
        Align = alBottom
        TabOrder = 0
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 727
          Height = 25
          Align = alTop
          TabOrder = 0
          object ToolBarFail: TToolBar
            Left = 1
            Top = 1
            Width = 725
            Height = 29
            Caption = 'ToolBarFail'
            Flat = True
            Images = DATA.EditImages
            TabOrder = 0
            object ToolButtonAddFail: TToolButton
              Left = 0
              Top = 0
              Caption = 'ToolButtonAddFail'
              ImageIndex = 0
              OnClick = ButtonAddFailClick
            end
            object ToolButtonEditFail: TToolButton
              Left = 23
              Top = 0
              Caption = 'ToolButtonEditFail'
              ImageIndex = 1
              OnClick = ToolButtonEditFailClick
            end
            object ToolButtonDelFail: TToolButton
              Left = 46
              Top = 0
              Caption = 'ToolButtonDelFail'
              ImageIndex = 2
              OnClick = ButtonDelFailClick
            end
          end
        end
        object GroupBox2: TGroupBox
          Left = 1
          Top = 26
          Width = 727
          Height = 100
          Align = alClient
          Caption = #1055#1088#1080#1095#1080#1085#1099' '#1086#1090#1082#1072#1079#1086#1074
          TabOrder = 1
          object FailGrid: TDBGridEh
            Left = 2
            Top = 15
            Width = 723
            Height = 83
            Align = alClient
            AutoFitColWidths = True
            DataSource = FAILSource
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
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            OnDblClick = ToolButtonEditFailClick
            OnKeyDown = FailGridKeyDown
            Columns = <
              item
                EditButtons = <>
                FieldName = 'Code'
                Footers = <>
                Title.Caption = #1053#1086#1084#1077#1088
                Width = 50
              end
              item
                EditButtons = <>
                FieldName = 'Name'
                Footers = <>
                Title.Caption = #1055#1088#1080#1095#1080#1085#1072
                Width = 390
              end>
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 729
        Height = 270
        Align = alClient
        TabOrder = 1
        object Panel6: TPanel
          Left = 1
          Top = 1
          Width = 727
          Height = 25
          Align = alTop
          TabOrder = 0
          object ToolBarRep: TToolBar
            Left = 1
            Top = 1
            Width = 725
            Height = 25
            Caption = 'ToolBarRep'
            Flat = True
            Images = DATA.EditImages
            TabOrder = 0
            object ToolButtonAddRep: TToolButton
              Left = 0
              Top = 0
              Caption = 'ToolButtonAddRep'
              ImageIndex = 0
              OnClick = ButtonAddRepClick
            end
            object ToolButtonEditRep: TToolButton
              Left = 23
              Top = 0
              Caption = 'ToolButtonEditRep'
              ImageIndex = 1
              OnClick = ButtonEditRepClick
            end
            object ToolButtonDelRep: TToolButton
              Left = 46
              Top = 0
              Caption = 'ToolButtonDelRep'
              ImageIndex = 2
              OnClick = ButtonDelRepClick
            end
          end
        end
        object GroupBox1: TGroupBox
          Left = 1
          Top = 26
          Width = 727
          Height = 243
          Align = alClient
          Caption = #1056#1077#1084#1086#1085#1090#1099
          TabOrder = 1
          object RepGrid: TDBGridEh
            Left = 2
            Top = 15
            Width = 723
            Height = 226
            Align = alClient
            AutoFitColWidths = True
            DataSource = REPSource
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
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = [fsBold]
            OnDblClick = ButtonEditRepClick
            OnKeyDown = RepGridKeyDown
            Columns = <
              item
                EditButtons = <>
                FieldName = 'date_beg'
                Footers = <>
                Title.Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
                Width = 88
              end
              item
                EditButtons = <>
                FieldName = 'date_end'
                Footers = <>
                Title.Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
                Width = 150
              end>
          end
        end
      end
    end
    object TabSheetChange: TTabSheet
      Caption = #1047#1072#1084#1077#1085#1072
      ImageIndex = 3
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 729
        Height = 25
        Align = alTop
        TabOrder = 0
        object ToolBarChain: TToolBar
          Left = 1
          Top = 1
          Width = 727
          Height = 29
          Caption = 'ToolBarChain'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ToolButtonAddChain: TToolButton
            Left = 0
            Top = 0
            Caption = 'ToolButtonAddChain'
            ImageIndex = 0
            OnClick = ButtonAddChainClick
          end
          object ToolButtonEditChain: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolButtonEditChain'
            ImageIndex = 1
            OnClick = ToolButtonEditChainClick
          end
          object ToolButtonDelChain: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolButtonDelChain'
            ImageIndex = 2
            OnClick = ToolButtonDelChainClick
          end
        end
      end
      object ChainGrid: TDBGridEh
        Left = 0
        Top = 25
        Width = 729
        Height = 376
        Align = alClient
        AutoFitColWidths = True
        DataSource = CHAINSource
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
        OnDblClick = ToolButtonEditChainClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'Name'
            Footers = <>
            Title.Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1072
            Width = 101
          end
          item
            EditButtons = <>
            FieldName = 'code'
            Footers = <>
            Title.Caption = #1050#1086#1076' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
            Width = 151
          end
          item
            EditButtons = <>
            FieldName = 'Name_1'
            Footers = <>
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 169
          end>
      end
    end
    object TabSheetVOP: TTabSheet
      Caption = #1054#1087#1077#1088#1072#1094#1080#1080
      ImageIndex = 4
      object PanelVOPBot: TPanel
        Left = 0
        Top = 0
        Width = 729
        Height = 25
        Align = alTop
        TabOrder = 0
        object ToolBar1: TToolBar
          Left = 1
          Top = 1
          Width = 727
          Height = 29
          Caption = 'ToolBarCh'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object ToolButtonVOPAdd: TToolButton
            Left = 0
            Top = 0
            Caption = 'ToolButton1'
            ImageIndex = 0
            OnClick = ToolButtonVOPAddClick
          end
          object ToolButtonVOPEdit: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolButtonEditCh'
            ImageIndex = 1
            OnClick = ToolButtonVOPEditClick
          end
          object ToolButtonVOPDel: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolButtonDelCh'
            ImageIndex = 2
            OnClick = ToolButtonVOPDelClick
          end
        end
      end
      object PanelVOP: TPanel
        Left = 0
        Top = 25
        Width = 729
        Height = 369
        Align = alClient
        TabOrder = 1
        object VOPGrid: TDBGridEh
          Left = 1
          Top = 1
          Width = 727
          Height = 367
          Align = alClient
          AutoFitColWidths = True
          DataSource = VOPSource
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
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = [fsBold]
          OnEditButtonClick = ToolButtonVOPEditClick
          OnKeyDown = VOPGridKeyDown
          Columns = <
            item
              ButtonStyle = cbsEllipsis
              EditButtons = <>
              FieldName = 'NAME'
              Footers = <>
              Title.Caption = #1054#1087#1077#1088#1072#1094#1080#1080' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
              Width = 296
              OnEditButtonClick = VOPGridColumns0EditButtonClick
            end>
        end
      end
    end
  end
  object CHEQSource: TDataSource
    DataSet = qCHEQQuery
    Left = 588
    Top = 24
  end
  object REPSource: TDataSource
    DataSet = qRepQuery
    Left = 588
    Top = 56
  end
  object FAILSource: TDataSource
    DataSet = qFAILQuery
    Left = 588
    Top = 88
  end
  object qRepQuery: TQuery
    AfterScroll = qRepQueryAfterScroll
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.date_beg, a.date_end, b.id, a.id'
      'from spr_rep a, spr_eqpt b where b.id = a.id_eqpt and b.id = :ID'
      'order by date_beg')
    Left = 620
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object qCHEQQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select b.id, a.name, b.nsize, b.kind '
      
        'from spr_vchr a, spr_cheq b  where a.ID = b.id_VID and b.ID_eqpt' +
        ' = :id'
      'order by name')
    Left = 620
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
    object qCHEQQueryID: TIntegerField
      FieldName = 'ID'
    end
    object qCHEQQueryNAME: TStringField
      FieldName = 'NAME'
      FixedChar = True
      Size = 15
    end
    object qCHEQQueryNSIZE: TFloatField
      FieldName = 'NSIZE'
      Precision = 3
    end
    object qCHEQQueryKIND: TStringField
      FieldName = 'KIND'
      FixedChar = True
      Size = 10
    end
  end
  object qFAILQuery: TQuery
    BeforePost = qFAILQueryBeforePost
    AfterPost = qFAILQueryAfterPost
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select * '
      'from spr_fail '
      'where id_rep = :ID'
      'order by code')
    Left = 620
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_pdr'
      
        'values (GEN_ID(SPR_EQPT_GEN,1), :parentID, :isfolder , :code, :n' +
        'ame , :maxtime)')
    Left = 456
    Top = 8
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
  object qQueryupdate: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_pdr'
      
        'values (GEN_ID(SPR_EQPT_GEN,1), :parentID, :isfolder , :code, :n' +
        'ame , :maxtime)')
    Left = 408
    Top = 8
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
  object CHAINSource: TDataSource
    DataSet = qChainQuery
    Left = 588
    Top = 155
  end
  object qChainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select c.id, a.name, b.code, b.name'
      'from spr_vchr a, spr_eqpt b, spr_chain c'
      'where a.id = c.id_vid and '
      '           b.id = c.nextideq and'
      '           c.id_eqpt = :id'
      'order by name')
    Left = 620
    Top = 155
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object genIDQuery: TQuery
    DatabaseName = 'RMP'
    Left = 619
    Top = 184
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 700
    Top = 24
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
  object qTYPEQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_tpeq'
      'where id = :id or code = :code')
    Left = 700
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
  object qVOPStoredProc: TStoredProc
    DatabaseName = 'RMP'
    SessionName = 'Default'
    StoredProcName = 'ADD_SPR_EQPTVOP_PROC'
    Left = 620
    Top = 221
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
  object VOPSource: TDataSource
    DataSet = qVOPQuery
    Left = 588
    Top = 221
  end
  object qVOPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select eqvp.id, vop.name, eqvp.id_vop'
      'from spr_vop vop, spr_eqvop eqvp'
      'where eqvp.id_eqpt = :id and'
      '           vop.id = eqvp.id_vop'
      'order by vop.id')
    Left = 652
    Top = 221
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object qVIDQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 424
    Top = 64
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
  object qEDIZQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_ediz'
      'where id = :id or code = :code')
    Left = 456
    Top = 64
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
  object qSelectVOPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_vop'
      'where id = :id or code = :code')
    Left = 588
    Top = 312
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
  object qUpdateVOPQuery: TQuery
    DatabaseName = 'RMP'
    Left = 621
    Top = 313
  end
end
