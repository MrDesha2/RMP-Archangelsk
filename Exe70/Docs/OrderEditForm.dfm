object DOC_ORDERForm: TDOC_ORDERForm
  Left = 463
  Top = 285
  Width = 639
  Height = 551
  HelpContext = 215
  Caption = #1044#1086#1082#1091#1084#1077#1085#1090' "'#1047#1072#1082#1072#1079'"'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pBotPanel: TPanel
    Left = 0
    Top = 472
    Width = 623
    Height = 41
    Align = alBottom
    TabOrder = 0
    object OKButton: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = ButtonClickOK
    end
    object CloseButton: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = ButtonClickClose
    end
    object PrintMapButton: TButton
      Left = 170
      Top = 8
      Width = 175
      Height = 25
      Hint = #1055#1077#1095#1072#1090#1100' '#1084#1072#1088#1096#1088#1091#1090#1085#1086#1081' '#1082#1072#1088#1090#1099
      Caption = '&'#1055#1083#1072#1085#1086#1074#1072#1103' '#1084#1072#1088#1096#1088#1091#1090#1085#1072#1103' '#1082#1072#1088#1090#1072
      TabOrder = 2
      OnClick = PrintMapButtonClick
    end
    object PrintMapFactButton: TButton
      Left = 354
      Top = 8
      Width = 175
      Height = 25
      Hint = #1055#1077#1095#1072#1090#1100' '#1084#1072#1088#1096#1088#1091#1090#1085#1086#1081' '#1082#1072#1088#1090#1099
      Caption = '&'#1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103' '#1084#1072#1088#1096#1088#1091#1090#1085#1072#1103' '#1082#1072#1088#1090#1072
      TabOrder = 3
      OnClick = PrintMapFactButtonClick
    end
  end
  object pTopPanel: TPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 65
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 49
      Top = 18
      Width = 85
      Height = 24
      Caption = #1047#1072#1082#1072#1079' '#8470
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label17: TLabel
      Left = 217
      Top = 18
      Width = 180
      Height = 24
      Caption = #1076#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object OrderNumber: TMaskEdit
      Left = 136
      Top = 21
      Width = 68
      Height = 21
      TabOrder = 0
    end
    object DateIn: TDateEdit
      Left = 400
      Top = 21
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object pMainPanel: TPanel
    Left = 0
    Top = 65
    Width = 623
    Height = 407
    Align = alClient
    TabOrder = 2
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 621
      Height = 405
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ActivePage = SheetMain
      Align = alClient
      TabOrder = 0
      object SheetMain: TTabSheet
        Caption = #1054#1089#1085#1086#1074#1085#1072#1103
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 40
          Height = 13
          Caption = #1047#1072#1103#1074#1082#1072':'
        end
        object LabelCustomer: TLabel
          Left = 40
          Top = 24
          Width = 48
          Height = 13
          Caption = #1047#1072#1082#1072#1079#1095#1080#1082
        end
        object LabelCHRTName: TLabel
          Left = 9
          Top = 90
          Width = 42
          Height = 13
          Caption = #1063#1077#1088#1090#1077#1078':'
        end
        object Label8: TLabel
          Left = 9
          Top = 43
          Width = 34
          Height = 13
          Caption = #1047#1072#1074#1086#1076':'
        end
        object Label3: TLabel
          Left = 9
          Top = 68
          Width = 83
          Height = 13
          Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
        end
        object Label4: TLabel
          Left = 9
          Top = 112
          Width = 77
          Height = 13
          Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
        end
        object Label7: TLabel
          Left = 9
          Top = 161
          Width = 95
          Height = 13
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' ('#1087#1083#1072#1085'):'
        end
        object Label13: TLabel
          Left = 9
          Top = 184
          Width = 86
          Height = 13
          Caption = #1055#1088#1080#1079#1085#1072#1082' '#1079#1072#1082#1072#1079#1072':'
        end
        object Label5: TLabel
          Left = 9
          Top = 207
          Width = 56
          Height = 13
          Caption = #1057#1088#1086#1095#1085#1086#1089#1090#1100':'
        end
        object Label6: TLabel
          Left = 8
          Top = 232
          Width = 85
          Height = 13
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
        end
        object Label11: TLabel
          Left = 205
          Top = 162
          Width = 96
          Height = 13
          Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' ('#1092#1072#1082#1090'):'
        end
        object Label9: TLabel
          Left = 9
          Top = 138
          Width = 76
          Height = 13
          Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077':'
        end
        object Vid_Chrt: TLabel
          Left = 444
          Top = 94
          Width = 39
          Height = 13
          Caption = 'Vid_chrt'
        end
        object Label15: TLabel
          Left = 8
          Top = 256
          Width = 97
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1079#1072#1082#1072#1079#1072':'
        end
        object Sum_Doc: TLabel
          Left = 112
          Top = 256
          Width = 47
          Height = 13
          Caption = 'Sum_Doc'
        end
        object Label16: TLabel
          Left = 8
          Top = 278
          Width = 59
          Height = 13
          Caption = #1042#1080#1076' '#1079#1072#1090#1088#1072#1090':'
        end
        object Label18: TLabel
          Left = 280
          Top = 184
          Width = 22
          Height = 13
          Caption = #1042#1077#1089':'
        end
        object RQSTCombo: TMaskEdit
          Left = 112
          Top = 0
          Width = 121
          Height = 21
          Enabled = False
          EditMask = '9999999999;1; '
          MaxLength = 10
          TabOrder = 0
          Text = '          '
        end
        object RadioGroup1: TRadioGroup
          Left = 464
          Top = 2
          Width = 141
          Height = 87
          Caption = #1055#1088#1080#1079#1085#1072#1082' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
          TabOrder = 12
        end
        object PR_EXEC: TRadioButton
          Left = 480
          Top = 18
          Width = 109
          Height = 17
          Caption = #1053#1077' '#1074#1099#1087#1086#1083#1085#1077#1085
          TabOrder = 13
        end
        object PR_EXEC1: TRadioButton
          Left = 480
          Top = 42
          Width = 109
          Height = 17
          Caption = #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
          TabOrder = 14
        end
        object PR_EXEC2: TRadioButton
          Left = 480
          Top = 66
          Width = 109
          Height = 17
          Caption = #1047#1072#1082#1088#1099#1090
          TabOrder = 15
        end
        object PR_URGEN: TRxSpinEdit
          Left = 112
          Top = 202
          Width = 65
          Height = 21
          MaxValue = 6.000000000000000000
          TabOrder = 9
          OnChange = ValueChange
          OnClick = ValueChange
        end
        object DateOut: TDateEdit
          Left = 112
          Top = 225
          Width = 121
          Height = 24
          NumGlyphs = 2
          TabOrder = 10
        end
        object PlantCombo: TComboEdit
          Left = 112
          Top = 42
          Width = 328
          Height = 21
          Hint = #1047#1072#1074#1086#1076
          HelpContext = 101
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          Tablename = 'spr_plant'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1047#1072#1074#1086#1076#1099' ('#1042#1099#1073#1086#1088')'
          Query = qPlantQuery
          ID = -1
          CanSelectGroup = False
          Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
          OnButtonClick = PlantComboButtonClick
          OnChange = ValueChange
          OnKeyDown = PlantComboKeyDown
        end
        object PDRCombo: TComboEdit
          Left = 112
          Top = 66
          Width = 329
          Height = 20
          Hint = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          HelpContext = 101
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Tablename = 'spr_pdr'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
          Query = qPDRQuery
          ID = -1
          CanSelectGroup = False
          Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
          OnButtonClick = PDRComboButtonClick
          OnChange = ValueChange
          OnKeyDown = PDRComboKeyDown
        end
        object NMNTCombo: TComboEdit
          Left = 112
          Top = 112
          Width = 329
          Height = 21
          Hint = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
          HelpContext = 101
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Tablename = 'spr_nmnt'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' ('#1042#1099#1073#1086#1088')'
          Query = qNMNTQuery
          ID = -1
          CanSelectGroup = False
          Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
          OnButtonClick = NMNTComboButtonClick
          OnChange = ValueChange
          OnKeyDown = NMNTComboKeyDown
        end
        object EQPTCombo: TComboEdit
          Left = 112
          Top = 135
          Width = 329
          Height = 21
          Hint = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077':'
          HelpContext = 101
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          Tablename = 'spr_eqpt'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' ('#1042#1099#1073#1086#1088')'
          Query = qEQPTQuery
          ID = -1
          CanSelectGroup = False
          Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
          OnButtonClick = EQPTComboButtonClick
          OnChange = ValueChange
          OnKeyDown = EQPTComboKeyDown
        end
        object CHRTCombo: TComboEdit
          Left = 112
          Top = 89
          Width = 329
          Height = 21
          Hint = #1063#1077#1088#1090#1077#1078
          HelpContext = 101
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Tablename = 'spr_chrt'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1063#1077#1088#1090#1077#1078' ('#1042#1099#1073#1086#1088')'
          Query = qCHRTQuery
          ID = -1
          CanSelectGroup = False
          Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
          OnButtonClick = CHRTComboButtonClick
          OnChange = CHRTComboChange
          OnKeyDown = CHRTComboKeyDown
        end
        object IDCostCombo: TComboEdit
          Left = 112
          Top = 274
          Width = 328
          Height = 21
          HelpContext = 101
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 11
          Tablename = 'spr_pdr'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076' '#1079#1072#1090#1088#1072#1090' ('#1042#1099#1073#1086#1088')'
          Query = qIDCostQuery
          ID = -1
          CanSelectGroup = False
          Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
          OnButtonClick = IDCostComboButtonClick
          OnChange = ValueChange
          OnKeyDown = IDCostComboKeyDown
        end
        object PR_ORDER: TComboBox
          Left = 112
          Top = 180
          Width = 145
          Height = 21
          ItemHeight = 13
          TabOrder = 8
          OnChange = ValueChange
          Items.Strings = (
            #1055#1083#1072#1085#1086#1074#1099#1081
            #1043#1086#1076#1086#1074#1086#1081
            #1042#1085#1077#1087#1083#1072#1085#1086#1074#1099#1081)
        end
        object Number_F: TCurrencyEdit
          Left = 312
          Top = 157
          Width = 121
          Height = 21
          AutoSize = False
          DisplayFormat = ',0.000;-,0.000'
          TabOrder = 7
          OnChange = ValueChange
        end
        object Number_P: TCurrencyEdit
          Left = 112
          Top = 157
          Width = 89
          Height = 21
          AutoSize = False
          DisplayFormat = ',0.000;-,0.000'
          TabOrder = 6
          OnChange = ValueChange
        end
        object WeightEdit: TCurrencyEdit
          Left = 312
          Top = 180
          Width = 103
          Height = 21
          Hint = #1042#1077#1089' '#1087#1086' '#1092#1072#1082#1090#1091
          AutoSize = False
          DecimalPlaces = 3
          DisplayFormat = ',0.000'#39#39';-,0.000'#39#39
          TabOrder = 16
        end
        object ButtonRecalcWeight: TButton
          Left = 415
          Top = 181
          Width = 24
          Height = 19
          Hint = #1055#1077#1088#1077#1089#1095#1080#1090#1072#1090#1100' '#1074#1077#1089' '#1087#1086' '#13#10#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1081' '#1086#1087#1077#1088#1072#1094#1080#1080
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 17
          OnClick = ButtonRecalcWeightClick
        end
        object ChangeRQSTButton: TButton
          Left = 232
          Top = 0
          Width = 33
          Height = 25
          Caption = '>>'
          TabOrder = 18
          Visible = False
          OnClick = ChangeRQSTButtonClick
        end
      end
      object SheetPlan: TTabSheet
        Caption = #1055#1083#1072#1085#1086#1074#1099#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
        ImageIndex = 1
        object SplitterPlan: TSplitter
          Left = 0
          Top = 223
          Width = 613
          Height = 4
          Cursor = crVSplit
          Align = alBottom
        end
        object pMTRPlanPanel: TPanel
          Left = 0
          Top = 227
          Width = 613
          Height = 150
          Align = alBottom
          TabOrder = 0
          object PlanPageControl: TPageControl
            Left = 1
            Top = 1
            Width = 611
            Height = 148
            ActivePage = TabSheetPlanMat
            Align = alClient
            TabOrder = 0
            object TabSheetPlanMat: TTabSheet
              Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
              object ToolBarMtPl: TToolBar
                Left = 0
                Top = 0
                Width = 675
                Height = 24
                Caption = 'ToolBarMtPl'
                Flat = True
                Images = DATA.EditImages
                TabOrder = 0
                object ButtonAddPlMat: TToolButton
                  Left = 0
                  Top = 0
                  Hint = #1053#1086#1074#1099#1081
                  Caption = 'ButtonAddPlMat'
                  ImageIndex = 0
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonAddPlMatClick
                end
                object ButtonEditPlMat: TToolButton
                  Left = 23
                  Top = 0
                  Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                  Caption = 'ButtonEditPlMat'
                  ImageIndex = 1
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonEditPlMatClick
                end
                object ButtonDelPlMat: TToolButton
                  Left = 46
                  Top = 0
                  Hint = #1059#1076#1072#1083#1080#1090#1100
                  Caption = 'ButtonDelPlMat'
                  ImageIndex = 2
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonDelPlMatClick
                end
                object ButtonUpPlMat: TToolButton
                  Left = 69
                  Top = 0
                  Hint = #1042#1074#1077#1088#1093
                  Caption = 'ButtonUpPlMat'
                  ImageIndex = 3
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = ButtonUpPlMatClick
                end
                object ButtonDownPlMat: TToolButton
                  Left = 92
                  Top = 0
                  Hint = #1042#1085#1080#1079
                  Caption = 'ButtonDownPlMat'
                  ImageIndex = 4
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = ButtonDownPlMatClick
                end
                object ShowAllPlanMtr: TToolButton
                  Left = 115
                  Top = 0
                  Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1089#1077
                  ImageIndex = 5
                  Style = tbsCheck
                  OnClick = ShowAllPlanMtrClick
                end
              end
              object GridMTRPlan: TStringGrid
                Left = 0
                Top = 24
                Width = 675
                Height = 96
                Align = alClient
                BorderStyle = bsNone
                ColCount = 6
                DefaultRowHeight = 17
                RowCount = 2
                GridLineWidth = 0
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
                TabOrder = 1
                OnDblClick = ButtonEditPlMatClick
                OnKeyDown = GridMTRPlanKeyDown
                ColWidths = (
                  14
                  63
                  253
                  110
                  106
                  64)
              end
            end
            object TabSheetPlanTool: TTabSheet
              Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
              ImageIndex = 1
              object ToolBar1: TToolBar
                Left = 0
                Top = 0
                Width = 675
                Height = 24
                Caption = 'ToolBarMtPl'
                Flat = True
                Images = DATA.EditImages
                TabOrder = 0
                object ButtonAddPlEQPT: TToolButton
                  Left = 0
                  Top = 0
                  Hint = #1053#1086#1074#1099#1081
                  Caption = 'ButtonAddPlEQPT'
                  ImageIndex = 0
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonAddPlEQPTClick
                end
                object ButtonEditPlEQPT: TToolButton
                  Left = 23
                  Top = 0
                  Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                  Caption = 'ButtonEditPlEQPT'
                  ImageIndex = 1
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonEditPlMatClick
                end
                object ToolButton3: TToolButton
                  Left = 46
                  Top = 0
                  Hint = #1059#1076#1072#1083#1080#1090#1100
                  Caption = 'ButtonDelPlMat'
                  ImageIndex = 2
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonDelPlMatClick
                end
                object ButtonUpPlEQPT: TToolButton
                  Left = 69
                  Top = 0
                  Hint = #1042#1074#1077#1088#1093
                  Caption = 'ButtonUpPlEQPT'
                  ImageIndex = 3
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = ButtonUpPlEQPTClick
                end
                object ButtonDownPlEQPT: TToolButton
                  Left = 92
                  Top = 0
                  Hint = #1042#1085#1080#1079
                  Caption = 'ButtonDownPlEQPT'
                  ImageIndex = 4
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = ButtonDownPlEQPTClick
                end
                object ShowAllPlanEQPT: TToolButton
                  Left = 115
                  Top = 0
                  Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1089#1077
                  ImageIndex = 5
                  Style = tbsCheck
                  OnClick = ShowAllPlanEQPTClick
                end
              end
              object GridEQPTPlan: TStringGrid
                Left = 0
                Top = 24
                Width = 675
                Height = 96
                Align = alClient
                BorderStyle = bsNone
                DefaultRowHeight = 17
                RowCount = 2
                GridLineWidth = 0
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
                TabOrder = 1
                OnDblClick = ButtonEditPlMatClick
                OnKeyDown = GridMTRPlanKeyDown
                ColWidths = (
                  14
                  63
                  253
                  110
                  106)
              end
            end
            object TabSheetPlanTransport: TTabSheet
              Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              ImageIndex = 2
              object GridTransportPlan: TStringGrid
                Left = 0
                Top = 24
                Width = 675
                Height = 96
                Align = alClient
                BorderStyle = bsNone
                ColCount = 6
                DefaultRowHeight = 17
                RowCount = 2
                GridLineWidth = 0
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
                TabOrder = 0
                OnDblClick = ButtonEditPlMatClick
                OnKeyDown = GridMTRPlanKeyDown
                ColWidths = (
                  14
                  63
                  253
                  110
                  106
                  64)
              end
              object ToolBar4: TToolBar
                Left = 0
                Top = 0
                Width = 675
                Height = 24
                Caption = 'ToolBarMtPl'
                Flat = True
                Images = DATA.EditImages
                TabOrder = 1
                object ToolButton11: TToolButton
                  Left = 0
                  Top = 0
                  Hint = #1053#1086#1074#1099#1081
                  Caption = 'ButtonAddPlEQPT'
                  ImageIndex = 0
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonAddPlEQPTClick
                end
                object ToolButton12: TToolButton
                  Left = 23
                  Top = 0
                  Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                  Caption = 'ButtonEditPlEQPT'
                  ImageIndex = 1
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonEditPlMatClick
                end
                object ToolButton13: TToolButton
                  Left = 46
                  Top = 0
                  Hint = #1059#1076#1072#1083#1080#1090#1100
                  Caption = 'ButtonDelPlMat'
                  ImageIndex = 2
                  ParentShowHint = False
                  ShowHint = True
                  Visible = False
                  OnClick = ButtonDelPlMatClick
                end
                object ButtonUpPlTransport: TToolButton
                  Left = 69
                  Top = 0
                  Hint = #1042#1074#1077#1088#1093
                  Caption = 'ButtonUpPlEQPT'
                  ImageIndex = 3
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = ButtonUpPlTransportClick
                end
                object ButtonDownPlTransport: TToolButton
                  Left = 92
                  Top = 0
                  Hint = #1042#1085#1080#1079
                  Caption = 'ButtonDownPlEQPT'
                  ImageIndex = 4
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = ButtonDownPlTransportClick
                end
                object ShowAllPlanTransport: TToolButton
                  Left = 115
                  Top = 0
                  Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1089#1077
                  ImageIndex = 5
                  Style = tbsCheck
                  OnClick = ShowAllPlanTransportClick
                end
              end
            end
          end
        end
        object pOperPlanPanel: TPanel
          Left = 0
          Top = 0
          Width = 613
          Height = 223
          Align = alClient
          TabOrder = 1
          object GroupBoxOpPlan: TGroupBox
            Left = 1
            Top = 1
            Width = 683
            Height = 251
            Align = alClient
            Caption = #1055#1083#1072#1085#1086#1074#1099#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
            TabOrder = 0
            object Grid_OperPlan: TStringGrid
              Left = 2
              Top = 40
              Width = 679
              Height = 209
              Align = alClient
              BorderStyle = bsNone
              ColCount = 6
              DefaultRowHeight = 17
              RowCount = 2
              GridLineWidth = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
              TabOrder = 1
              OnDblClick = ButtonEditPlOpClick
              OnKeyDown = Grid_OperPlanKeyDown
              OnSelectCell = Grid_OperPlanSelectCell
              ColWidths = (
                15
                67
                250
                162
                99
                64)
            end
            object ToolBarOpPl: TToolBar
              Left = 2
              Top = 15
              Width = 679
              Height = 25
              Caption = 'ToolBarOpPl'
              Flat = True
              Images = DATA.EditImages
              TabOrder = 0
              object ButtonAddPlanOp: TToolButton
                Left = 0
                Top = 0
                Hint = #1053#1086#1074#1099#1081
                Caption = 'ButtonAddPlanOp'
                ImageIndex = 0
                ParentShowHint = False
                ShowHint = True
                OnClick = ButtonAddPlanOpClick
              end
              object ButtonEditPlOp: TToolButton
                Left = 23
                Top = 0
                Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                Caption = 'ButtonEditPlOp'
                ImageIndex = 1
                ParentShowHint = False
                ShowHint = True
                OnClick = ButtonEditPlOpClick
              end
              object ButtonDelPlOp: TToolButton
                Left = 46
                Top = 0
                Hint = #1059#1076#1072#1083#1080#1090#1100
                Caption = 'ButtonDelPlOp'
                ImageIndex = 2
                ParentShowHint = False
                ShowHint = True
                OnClick = ButtonDelPlOpClick
              end
              object ButtonUpPlOp: TToolButton
                Left = 69
                Top = 0
                Hint = #1042#1074#1077#1088#1093
                Caption = 'ButtonUpPlOp'
                ImageIndex = 3
                ParentShowHint = False
                ShowHint = True
                OnClick = ButtonUpPlOpClick
              end
              object ButtonDownPlOp: TToolButton
                Left = 92
                Top = 0
                Hint = #1042#1085#1080#1079
                Caption = 'ButtonDownPlOp'
                ImageIndex = 4
                ParentShowHint = False
                ShowHint = True
                OnClick = ButtonDownPlOpClick
              end
              object ButtonFill: TButton
                Left = 115
                Top = 0
                Width = 229
                Height = 22
                Hint = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1087#1083#1072#1085#1086#1074#1099#1077#13#10#1086#1087#1077#1088#1072#1094#1080#1080' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
                Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1086#1087#1077#1088#1072#1094#1080#1080' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
                OnClick = ButtonFillClick
              end
            end
          end
        end
      end
      object SheetFact: TTabSheet
        Caption = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
        ImageIndex = 2
        object SplitterFact: TSplitter
          Left = 0
          Top = 225
          Width = 613
          Height = 2
          Cursor = crVSplit
          Align = alBottom
        end
        object pMTRFactPanel: TPanel
          Left = 0
          Top = 227
          Width = 613
          Height = 150
          Align = alBottom
          TabOrder = 0
          object PageControlFact: TPageControl
            Left = 1
            Top = 1
            Width = 611
            Height = 148
            ActivePage = TabSheetFactMat
            Align = alClient
            TabOrder = 0
            object TabSheetFactMat: TTabSheet
              Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
              object ToolBarMtFt: TToolBar
                Left = 0
                Top = 0
                Width = 675
                Height = 25
                Caption = 'ToolBarMtFt'
                Flat = True
                Images = DATA.EditImages
                TabOrder = 0
                object ButtonAddFactMt: TToolButton
                  Left = 0
                  Top = 0
                  Hint = #1053#1086#1074#1099#1081
                  Caption = 'ButtonAddFactMt'
                  ImageIndex = 0
                  Visible = False
                  OnClick = ButtonAddFactMtClick
                end
                object ButtonEditFactMt: TToolButton
                  Left = 23
                  Top = 0
                  Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                  Caption = 'ButtonEditFactMt'
                  ImageIndex = 1
                  Visible = False
                  OnClick = ButtonEditFactMtClick
                end
                object ButtonDelFactMt: TToolButton
                  Left = 46
                  Top = 0
                  Hint = #1059#1076#1072#1083#1080#1090#1100
                  Caption = 'ButtonDelFactMt'
                  ImageIndex = 2
                  Visible = False
                  OnClick = ButtonDelFactMtClick
                end
                object ButtonUpFactMt: TToolButton
                  Left = 69
                  Top = 0
                  Hint = #1042#1074#1077#1088#1093
                  Caption = 'ButtonUpFactMt'
                  ImageIndex = 3
                  OnClick = ButtonUpFactMtClick
                end
                object ButtonDownFactMt: TToolButton
                  Left = 92
                  Top = 0
                  Hint = #1042#1085#1080#1079
                  Caption = 'ButtonDownFactMt'
                  ImageIndex = 4
                  OnClick = ButtonDownFactMtClick
                end
                object ShowAllFactMtr: TToolButton
                  Left = 115
                  Top = 0
                  ImageIndex = 5
                  Style = tbsCheck
                  OnClick = ShowAllFactMtrClick
                end
              end
              object GridFactMtr: TStringGrid
                Left = 0
                Top = 25
                Width = 675
                Height = 95
                Align = alClient
                BorderStyle = bsNone
                ColCount = 6
                DefaultRowHeight = 17
                RowCount = 2
                GridLineWidth = 0
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
                TabOrder = 1
                OnDblClick = ButtonEditFactMtClick
                OnKeyDown = GridFactMtrKeyDown
                ColWidths = (
                  15
                  50
                  313
                  106
                  96
                  64)
              end
            end
            object TabSheetFactTool: TTabSheet
              Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
              ImageIndex = 1
              object ToolBar2: TToolBar
                Left = 0
                Top = 0
                Width = 675
                Height = 25
                Caption = 'ToolBarMtFt'
                Flat = True
                Images = DATA.EditImages
                TabOrder = 0
                object ToolButton7: TToolButton
                  Left = 0
                  Top = 0
                  Hint = #1053#1086#1074#1099#1081
                  Caption = 'ButtonAddFactMt'
                  ImageIndex = 0
                  Visible = False
                  OnClick = ButtonAddFactMtClick
                end
                object ToolButton8: TToolButton
                  Left = 23
                  Top = 0
                  Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                  Caption = 'ButtonEditFactMt'
                  ImageIndex = 1
                  Visible = False
                  OnClick = ButtonEditFactMtClick
                end
                object ToolButton9: TToolButton
                  Left = 46
                  Top = 0
                  Hint = #1059#1076#1072#1083#1080#1090#1100
                  Caption = 'ButtonDelFactMt'
                  ImageIndex = 2
                  Visible = False
                  OnClick = ButtonDelFactMtClick
                end
                object ButtonUpFactEQPT: TToolButton
                  Left = 69
                  Top = 0
                  Hint = #1042#1074#1077#1088#1093
                  Caption = 'ButtonUpFactEQPT'
                  ImageIndex = 3
                  OnClick = ButtonUpFactEQPTClick
                end
                object ButtonDownFactEQPT: TToolButton
                  Left = 92
                  Top = 0
                  Hint = #1042#1085#1080#1079
                  Caption = 'ButtonDownFactEQPT'
                  ImageIndex = 4
                  OnClick = ButtonDownFactEQPTClick
                end
                object ShowAllFactEQPT: TToolButton
                  Left = 115
                  Top = 0
                  ImageIndex = 5
                  Style = tbsCheck
                  OnClick = ShowAllFactEQPTClick
                end
              end
              object GridEQPTFact: TStringGrid
                Left = 0
                Top = 25
                Width = 675
                Height = 95
                Align = alClient
                BorderStyle = bsNone
                DefaultRowHeight = 17
                RowCount = 2
                GridLineWidth = 0
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
                TabOrder = 1
                OnDblClick = ButtonEditFactMtClick
                OnKeyDown = GridFactMtrKeyDown
                ColWidths = (
                  15
                  50
                  313
                  106
                  96)
              end
            end
            object TabSheet1: TTabSheet
              Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
              ImageIndex = 2
              object ToolBar3: TToolBar
                Left = 0
                Top = 0
                Width = 675
                Height = 25
                Caption = 'ToolBarMtFt'
                Flat = True
                Images = DATA.EditImages
                TabOrder = 0
                object ToolButton1: TToolButton
                  Left = 0
                  Top = 0
                  Hint = #1053#1086#1074#1099#1081
                  Caption = 'ButtonAddFactMt'
                  ImageIndex = 0
                  Visible = False
                  OnClick = ButtonAddFactMtClick
                end
                object ToolButton2: TToolButton
                  Left = 23
                  Top = 0
                  Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                  Caption = 'ButtonEditFactMt'
                  ImageIndex = 1
                  Visible = False
                  OnClick = ButtonEditFactMtClick
                end
                object ToolButton4: TToolButton
                  Left = 46
                  Top = 0
                  Hint = #1059#1076#1072#1083#1080#1090#1100
                  Caption = 'ButtonDelFactMt'
                  ImageIndex = 2
                  Visible = False
                  OnClick = ButtonDelFactMtClick
                end
                object ButtonUpFactTransport: TToolButton
                  Left = 69
                  Top = 0
                  Hint = #1042#1074#1077#1088#1093
                  Caption = 'ButtonUpFactEQPT'
                  ImageIndex = 3
                  OnClick = ButtonUpFactTransportClick
                end
                object ButtonDownFactTransport: TToolButton
                  Left = 92
                  Top = 0
                  Hint = #1042#1085#1080#1079
                  Caption = 'ButtonDownFactEQPT'
                  ImageIndex = 4
                  OnClick = ButtonDownFactTransportClick
                end
                object ShowAllFactTransport: TToolButton
                  Left = 115
                  Top = 0
                  ImageIndex = 5
                  Style = tbsCheck
                  OnClick = ShowAllFactTransportClick
                end
              end
              object GridTransportFact: TStringGrid
                Left = 0
                Top = 25
                Width = 675
                Height = 95
                Align = alClient
                BorderStyle = bsNone
                ColCount = 6
                DefaultRowHeight = 17
                RowCount = 2
                GridLineWidth = 0
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
                TabOrder = 1
                OnDblClick = ButtonEditFactMtClick
                OnKeyDown = GridFactMtrKeyDown
                ColWidths = (
                  15
                  50
                  313
                  106
                  96
                  64)
              end
            end
          end
        end
        object pOperFactPanel: TPanel
          Left = 0
          Top = 0
          Width = 613
          Height = 225
          Align = alClient
          TabOrder = 1
          object GroupBoxOpFact: TGroupBox
            Left = 1
            Top = 1
            Width = 683
            Height = 252
            Align = alClient
            Caption = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
            TabOrder = 0
            object ToolBarOpFt: TToolBar
              Left = 2
              Top = 15
              Width = 679
              Height = 24
              Caption = 'ToolBarOpFt'
              Flat = True
              Images = DATA.EditImages
              TabOrder = 0
              object ButtonAddFactOp: TToolButton
                Left = 0
                Top = 0
                Hint = #1053#1086#1074#1099#1081
                Caption = 'ButtonAddFactOp'
                ImageIndex = 0
                OnClick = ButtonAddFactOpClick
              end
              object ButtonEditFactOp: TToolButton
                Left = 23
                Top = 0
                Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                Caption = 'ButtonEditFactOp'
                ImageIndex = 1
                OnClick = ButtonEditFactOpClick
              end
              object ButtonDelFactOp: TToolButton
                Left = 46
                Top = 0
                Caption = 'ButtonDelFactOp'
                ImageIndex = 2
                OnClick = ButtonDelFactOpClick
              end
              object ButtonUpFactOp: TToolButton
                Left = 69
                Top = 0
                Hint = #1042#1074#1077#1088#1093
                Caption = 'ButtonUpFactOp'
                ImageIndex = 3
                OnClick = ButtonUpFactOpClick
              end
              object ButtonDownFactOp: TToolButton
                Left = 92
                Top = 0
                Hint = #1042#1085#1080#1079
                Caption = 'ButtonDownFactOp'
                ImageIndex = 4
                OnClick = ButtonDownFactOpClick
              end
            end
            object Grid_operFact: TStringGrid
              Left = 2
              Top = 39
              Width = 679
              Height = 211
              Align = alClient
              BorderStyle = bsNone
              ColCount = 6
              DefaultRowHeight = 17
              RowCount = 2
              GridLineWidth = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
              TabOrder = 1
              OnDblClick = ButtonEditFactOpClick
              OnKeyDown = Grid_OperFactKeyDown
              OnSelectCell = Grid_OperFactSelectCell
              ColWidths = (
                15
                67
                250
                162
                99
                64)
            end
          end
        end
      end
      object SheetCalc: TTabSheet
        Caption = #1047#1072#1090#1088#1072#1090#1099
        ImageIndex = 3
        object SplitterCalc: TSplitter
          Left = 0
          Top = 230
          Width = 685
          Height = 4
          Cursor = crVSplit
          Align = alTop
        end
        object PanelInfo: TPanel
          Left = 0
          Top = 234
          Width = 685
          Height = 173
          Align = alClient
          TabOrder = 0
          object CalcINFO: TLabel
            Left = 15
            Top = 47
            Width = 58
            Height = 13
            Caption = ' CALC INFO'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object ErrorCalcLabel: TLabel
            Left = 15
            Top = 72
            Width = 27
            Height = 13
            Caption = 'Errors'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object PrintCalctButton: TButton
            Left = 112
            Top = 11
            Width = 129
            Height = 25
            Hint = #1055#1077#1095#1072#1090#1072#1090#1100' '#1082#1072#1083#1100#1082#1091#1083#1103#1094#1080#1102
            Caption = '&'#1050#1072#1083#1100#1082#1091#1083#1103#1094#1080#1103
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = ButtonClickPrintCalct
          end
          object CalcButton: TButton
            Left = 8
            Top = 11
            Width = 105
            Height = 25
            Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
            TabOrder = 1
            OnClick = ButtonClickCalc
          end
        end
        object PanelCalc: TPanel
          Left = 0
          Top = 0
          Width = 685
          Height = 230
          Align = alTop
          TabOrder = 1
          object GroupBoxCalc: TGroupBox
            Left = 1
            Top = 1
            Width = 683
            Height = 228
            Align = alClient
            Caption = #1047#1072#1090#1088#1072#1090#1099
            TabOrder = 0
            object ToolBarCalc: TToolBar
              Left = 2
              Top = 15
              Width = 679
              Height = 24
              ButtonHeight = 25
              Caption = 'ToolBarCalc'
              Flat = True
              Images = DATA.EditImages
              TabOrder = 0
              object ButtonAddCalc: TToolButton
                Left = 0
                Top = 0
                Hint = #1053#1086#1074#1099#1081
                Caption = 'ButtonAddCalc'
                ImageIndex = 0
                OnClick = ButtonAddCalcClick
              end
              object ButtonEditCalc: TToolButton
                Left = 23
                Top = 0
                Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
                Caption = 'ButtonEditCalc'
                ImageIndex = 1
                OnClick = ButtonEditCalcClick
              end
              object ButtonDelCalc: TToolButton
                Left = 46
                Top = 0
                Hint = #1059#1076#1072#1083#1080#1090#1100
                Caption = 'ButtonDelCalc'
                ImageIndex = 2
                OnClick = ButtonDelCalcClick
              end
              object ButtonCalcUp: TToolButton
                Left = 69
                Top = 0
                Hint = #1042#1074#1077#1088#1093
                Caption = 'ButtonCalcUp'
                ImageIndex = 3
                OnClick = ButtonCalcUpClick
              end
              object ButtonCalcDown: TToolButton
                Left = 92
                Top = 0
                Hint = #1042#1085#1080#1079
                Caption = 'ButtonCalcDown'
                ImageIndex = 4
                OnClick = ButtonCalcDownClick
              end
            end
            object GridCalc: TStringGrid
              Left = 2
              Top = 39
              Width = 679
              Height = 187
              Align = alClient
              BorderStyle = bsNone
              ColCount = 4
              DefaultRowHeight = 17
              RowCount = 2
              GridLineWidth = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
              TabOrder = 1
              OnDblClick = ButtonEditCalcClick
              OnKeyDown = GridCalcKeyDown
              ColWidths = (
                14
                67
                320
                64)
            end
          end
        end
      end
      object SheetOher: TTabSheet
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1086
        ImageIndex = 4
        object Splitter2: TSplitter
          Left = 0
          Top = 85
          Width = 613
          Height = 3
          Cursor = crVSplit
          Align = alTop
        end
        object Panel1: TPanel
          Left = 0
          Top = 88
          Width = 613
          Height = 289
          Align = alClient
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 1
            Top = 111
            Width = 611
            Height = 3
            Cursor = crVSplit
            Align = alBottom
          end
          object GroupBox: TGroupBox
            Left = 1
            Top = 1
            Width = 611
            Height = 110
            Align = alClient
            Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
            TabOrder = 0
            object InfoView: TRichEdit
              Left = 2
              Top = 15
              Width = 607
              Height = 93
              Align = alClient
              Color = 10930928
              ReadOnly = True
              ScrollBars = ssBoth
              TabOrder = 0
            end
          end
          object GroupBox1: TGroupBox
            Left = 1
            Top = 114
            Width = 611
            Height = 174
            Align = alBottom
            Caption = #1042#1074#1086#1076' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            object info: TRichEdit
              Left = 2
              Top = 15
              Width = 491
              Height = 157
              Align = alClient
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
              ScrollBars = ssBoth
              TabOrder = 0
            end
          end
        end
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 613
          Height = 85
          Align = alTop
          TabOrder = 1
          object Label14: TLabel
            Left = 15
            Top = 60
            Width = 61
            Height = 13
            Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072':'
          end
          object Label12: TLabel
            Left = 16
            Top = 38
            Width = 27
            Height = 13
            Caption = #1052#1042#1055':'
          end
          object Label10: TLabel
            Left = 16
            Top = 16
            Width = 26
            Height = 13
            Caption = #1057#1095#1077#1090':'
          end
          object StatCombo: TComboEdit
            Left = 88
            Top = 56
            Width = 329
            Height = 21
            HelpContext = 101
            GlyphKind = gkEllipsis
            ButtonWidth = 20
            NumGlyphs = 1
            TabOrder = 0
            Tablename = 'spr_stat'
            TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1057#1090#1072#1090#1080#1089#1090#1080#1082#1072' ('#1042#1099#1073#1086#1088')'
            Query = qStatQuery
            ID = -1
            CanSelectGroup = False
            Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
            OnButtonClick = StatComboButtonClick
            OnChange = ValueChange
            OnKeyDown = StatComboKeyDown
          end
          object MVPCombo: TComboEdit
            Left = 88
            Top = 32
            Width = 329
            Height = 21
            HelpContext = 101
            GlyphKind = gkEllipsis
            ButtonWidth = 20
            NumGlyphs = 1
            TabOrder = 1
            Tablename = 'spr_mvp'
            TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1055' ('#1042#1099#1073#1086#1088')'
            Query = qMVPQuery
            ID = -1
            CanSelectGroup = False
            Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
            OnButtonClick = MVPComboButtonClick
            OnChange = ValueChange
            OnKeyDown = MVPComboKeyDown
          end
          object CountCombo: TComboEdit
            Left = 88
            Top = 8
            Width = 329
            Height = 21
            HelpContext = 101
            GlyphKind = gkEllipsis
            ButtonWidth = 20
            NumGlyphs = 1
            TabOrder = 2
            Tablename = 'spr_count'
            TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1057#1095#1077#1090' ('#1042#1099#1073#1086#1088')'
            Query = qCountQuery
            ID = -1
            CanSelectGroup = False
            Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
            OnButtonClick = CountComboButtonClick
            OnChange = ValueChange
            OnKeyDown = CountComboKeyDown
          end
        end
      end
    end
  end
  object qPlantQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_plant'
      'where id = :id  or code = :code')
    Left = 885
    Top = 258
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
      'select id, parentid, code, name'
      'from spr_pdr where id = :id  or code = :code')
    Left = 885
    Top = 290
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
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_nmnt'
      'where id = :id or code = :code')
    Left = 885
    Top = 322
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
  object qCountQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_count'
      'where id = :id or code = :code')
    Left = 885
    Top = 356
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
  object qMVPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_mvp'
      'where id = :id or code = :code'
      ''
      '')
    Left = 885
    Top = 388
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
  object qStatQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_stat'
      'where id = :id  or code = :code')
    Left = 885
    Top = 420
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
  object qORDERQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno, b.name, a.rating, a.ntime, a.price, a.id'
      'from dt_order1 a, spr_vop b'
      'where a.id_order = :iddoc and'
      '                     b.id = a.id_vop '
      'order by a.lineno')
    Left = 856
    Top = 56
    ParamData = <
      item
        DataType = ftString
        Name = 'iddoc'
        ParamType = ptUnknown
        Value = '1'
      end>
  end
  object ORDERSource: TDataSource
    DataSet = qORDERQuery
    Left = 824
    Top = 56
  end
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id  or code = :code')
    Left = 885
    Top = 226
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
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    Left = 864
    Top = 88
  end
  object qORDERPlanQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select ord.lineno, vop.name, ord.rating, ord.ntime / 1000 as nti' +
        'me,'
      
        'ord.price, ord.id, ord.id_vop, ord.DATE_BEG, ord.DATE_END, ord.T' +
        'IME_BEG,'
      'ord.TIME_END, ord.ID_WRKR, ord.ID_EQPT,'
      '(select name from spr_wrkr where id = ord.id_wrkr) as wrkr_name,'
      '(select name from spr_eqpt where id = ord.id_eqpt) as eqpt_name'
      ''
      'from spr_vop vop, dt_order1 ord'
      ''
      'where ord.id_order = :iddoc and'
      '      vop.id       = ord.id_vop'
      'order by ord.lineno')
    Left = 880
    Top = 16
    ParamData = <
      item
        DataType = ftString
        Name = 'iddoc'
        ParamType = ptUnknown
        Value = '1'
      end>
  end
  object qMTRPlanQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno, b.name, a.number, a.price, a.id_opp, a.id_nmnt,'
      
        '             a.hight, a.LENGHT, a.WIDTH, a.WEIGHT, a.ID_STRG, a.' +
        'ID_EDIZ,'
      
        '        (select c.name from spr_strg c where c.id = a.id_strg) a' +
        's STRG_NAME,'
      
        '        (select d.name from spr_ediz d where d.id = a.id_ediz) a' +
        's EDIZ_NAME'
      ''
      'from dt_mtrp a, spr_nmnt b'
      'where '
      '       a.id_opp = :idopp and'
      '       a.lineopp = :lineopp and  '
      '       b.id         = a.id_nmnt'
      'order by a.lineno'
      '')
    Left = 880
    Top = 49
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idopp'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'lineopp'
        ParamType = ptUnknown
      end>
  end
  object qORDERFactQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno,'
      '          (select name from spr_vop where id = a.id_vop),'
      '          a.date_beg, a.date_end,'
      '          (select name from spr_wrkr where id = a.id_wrkr),'
      '          (select name from spr_eqpt where id = a.id_eqpt),'
      '          a.ntime / 1000 as ntime, a.price,'
      
        '          a.id, a.id_vop, a.id_wrkr, a.id_eqpt, a.rating, a.time' +
        '_beg, a.time_end'
      'from dt_order2 a'
      'where a.id_order = :iddoc'
      'order by a.lineno')
    Left = 879
    Top = 78
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDDOC'
        ParamType = ptUnknown
      end>
  end
  object qMTRFactQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno, b.name, a.number, a.price, a.id_opf, a.id_nmnt,'
      
        '        a.hight, a.LENGHT, a.WIDTH, a.WEIGHT, a.ID_STRG, a.ID_ED' +
        'IZ,'
      
        '        (select c.name from spr_strg c where c.id = a.id_strg) a' +
        's STRG_NAME,'
      
        '        (select d.name from spr_ediz d where d.id = a.id_ediz) a' +
        's EDIZ_NAME'
      ''
      'from dt_mtrf a, spr_nmnt b'
      'where '
      '       a.id_opf = :idopf and'
      '       a.lineopf = :line_opf and'
      '       b.id         = a.id_nmnt'
      'order by a.lineno')
    Left = 885
    Top = 106
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idopf'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'line_opf'
        ParamType = ptUnknown
      end>
  end
  object qCostQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno, b.name, a.nvalue, a.id_calc'
      'from dt_order3 a, spr_calc b'
      'where '
      '       a.id_rqst = :iddoc and'
      '       b.id         = a.id_calc'
      'order by a.lineno'
      '')
    Left = 885
    Top = 130
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object StorProcOrderAdd: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_ORDER_PROC'
    Left = 877
    Top = 450
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_RQST'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_NMNT'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'PR_URGEN'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PR_EXEC'
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
        DataType = ftSmallint
        Name = 'WEIGHT_F'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER_P'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER_F'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_STAT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_MVP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PLANT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_COUNT'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CHRT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'SUM_DOC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_COST'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'WEIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDDOC'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'NUMDOC'
        ParamType = ptOutput
      end>
  end
  object StorProcPlanOp: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_ORDER_1_PROC'
    Left = 909
    Top = 450
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_ORDER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CHRT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_VOP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NTIME'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'RATING'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PRICE'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATE_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DATE_END'
        ParamType = ptInput
      end
      item
        DataType = ftTime
        Name = 'TIME_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftTime
        Name = 'TIME_END'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end>
  end
  object StorProcPlanMTR: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_MTR_PLAN_PROC'
    Left = 909
    Top = 482
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_OPP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINEOPP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_NMNT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PRICE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'HIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LENGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'WIDTH'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'WEIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_STRG'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end>
  end
  object qCHRTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, id_NMNT, code, vid_chrt, id_OBRD'
      'from spr_chrt'
      'where id = :id  or code = :code')
    Left = 917
    Top = 226
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
  object StorProcFactOp: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_ORDER_2_PROC'
    Left = 941
    Top = 450
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_ORDER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CHRT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_VOP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NTIME'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'RATING'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PRICE'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_END'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TIME_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TIME_END'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PERIOD'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PR_EXEC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NEED_INPUT_PROD'
        ParamType = ptInput
      end>
  end
  object StorProcFactMTR: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_MTP_FACT_PROC'
    Left = 941
    Top = 482
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_OPF'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINEOPF'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_NMNT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PRICE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'HIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LENGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'WIDTH'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'WEIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_STRG'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end>
  end
  object StorProcCalc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_ORDER_3_PROC'
    Left = 909
    Top = 506
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'ID_CALC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NVALUE'
        ParamType = ptInput
      end>
  end
  object StorProcOrderUpdate: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'UPDATE_ORDER_PROC'
    Left = 877
    Top = 482
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
        DataType = ftInteger
        Name = 'ID_RQST'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_NMNT'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'PR_URGEN'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PR_EXEC'
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
        DataType = ftSmallint
        Name = 'WEIGHT_F'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER_P'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER_F'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_STAT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_MVP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PLANT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_COUNT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CHRT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PERIOD'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'SUM_DOC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_COST'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'WEIGHT'
        ParamType = ptInput
      end>
  end
  object qTMPQuery: TQuery
    DatabaseName = 'RMP'
    Left = 880
    Top = 160
  end
  object qIDCostQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr where id = :id  or code = :code')
    Left = 917
    Top = 258
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
  object qOperCostQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.line_op, a.lineno, a.id_calc, b.name, a.nvalue'
      'from dt_order4 a, spr_calc b'
      'where a.id_order = :id and a.id_calc  = b.id and'
      '           a.line_op = :line_op'
      'order by lineno')
    Left = 917
    Top = 290
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'line_op'
        ParamType = ptUnknown
      end>
  end
  object StorProcOperCalc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_ORDER_4_PROC'
    Left = 941
    Top = 507
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_ORDER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINE_OP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CALC'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NVALUE'
        ParamType = ptInput
      end>
  end
  object qEQPTPlanQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno, eqpt.name, a.number, a.id_opp, a.id_eqpt,'
      '        a.ID_EDIZ,'
      
        '        (select d.name from spr_ediz d where d.id = a.id_ediz) a' +
        's EDIZ_NAME'
      ''
      'from dt_eqptplan a, spr_eqpt eqpt'
      'where '
      '       a.id_opp  = :idopp and'
      '       a.lineopp = :lineopp and  '
      '       eqpt.id     = a.id_eqpt'
      'order by a.lineno'
      '')
    Left = 912
    Top = 49
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idopp'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'lineopp'
        ParamType = ptUnknown
      end>
  end
  object qEQPTFACTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno, eqpt.name, a.number, a.id_opf, a.id_eqpt,'
      '        a.ID_EDIZ,'
      
        '        (select d.name from spr_ediz d where d.id = a.id_ediz) a' +
        's EDIZ_NAME'
      ''
      'from dt_eqptfact a, spr_eqpt eqpt'
      'where '
      '       a.id_opf = :idopf and'
      '       a.lineopf = :lineopf and'
      '       eqpt.id   = a.id_eqpt'
      'order by a.lineno')
    Left = 917
    Top = 106
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idopf'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'lineopf'
        ParamType = ptUnknown
      end>
  end
  object ADD_EQPT_FACT_PROC: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_EQPT_FACT_PROC'
    Left = 973
    Top = 482
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_OPF'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINEOPF'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end>
  end
  object ADD_EQPT_PLAN_PROC: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_EQPT_PLAN_PROC'
    Left = 973
    Top = 450
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_OPP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINEOPP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end>
  end
  object qTransportPlanQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno, eqpt.name, a.number, a.id_opp, a.id_eqpt,'
      '        a.ID_EDIZ, '
      
        '        (select d.name from spr_ediz d where d.id = a.id_ediz) a' +
        's EDIZ_NAME,'
      '        a.cost'
      'from dt_transplan a, spr_eqpt eqpt'
      'where '
      '       a.id_opp  = :idopp and'
      '       a.lineopp = :lineopp and  '
      '       eqpt.id     = a.id_eqpt'
      'order by a.lineno'
      '')
    Left = 920
    Top = 17
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idopp'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'lineopp'
        ParamType = ptUnknown
      end>
  end
  object qTransportFactQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.lineno, eqpt.name, a.number, a.id_opf, a.id_eqpt,'
      '        a.ID_EDIZ, '
      
        '        (select d.name from spr_ediz d where d.id = a.id_ediz) a' +
        's EDIZ_NAME,'
      '        a.cost'
      'from dt_transfact a, spr_eqpt eqpt'
      'where '
      '       a.id_opf = :idopf and'
      '       a.lineopf = :lineopf and'
      '       eqpt.id   = a.id_eqpt'
      'order by a.lineno')
    Left = 949
    Top = 18
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'idopf'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'lineopf'
        ParamType = ptUnknown
      end>
  end
  object ADD_TRANSPORT_PLAN_PROC: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_TRANSPORT_PLAN_PROC'
    Left = 973
    Top = 386
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_OPP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINEOPP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'COST'
        ParamType = ptInput
      end>
  end
  object ADD_TRANSPORT_FACT_PROC: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_TRANSPORT_FACT_PROC'
    Left = 973
    Top = 418
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_OPF'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINEOPF'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'COST'
        ParamType = ptInput
      end>
  end
  object ActionList: TActionList
    Left = 541
    Top = 18
    object ChangeRecDoc: TAction
      Caption = 'ChangeRecDoc'
      ShortCut = 49219
      SecondaryShortCuts.Strings = (
        'Ctrl+Alt+'#1057)
      OnExecute = ChangeRecDocExecute
    end
  end
end
