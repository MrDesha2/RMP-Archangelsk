object DOCT_OPERForm: TDOCT_OPERForm
  Left = 311
  Top = 158
  HelpContext = 216
  BorderStyle = bsDialog
  Caption = #1054#1087#1077#1088#1072#1094#1080#1080' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 425
  ClientWidth = 545
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
  object PanelButton: TPanel
    Left = 0
    Top = 389
    Width = 545
    Height = 36
    Align = alBottom
    TabOrder = 1
    object CancelButton: TButton
      Left = 195
      Top = 7
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = CancelButtonClick
    end
    object OKButton: TButton
      Left = 16
      Top = 7
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object Button_Calc: TButton
      Left = 96
      Top = 7
      Width = 97
      Height = 25
      Caption = '&'#1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = Button_CalcClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 545
    Height = 389
    ActivePage = TabSheet_Oper
    Align = alClient
    MultiLine = True
    TabOrder = 0
    object TabSheet_Oper: TTabSheet
      Caption = #1054#1087#1077#1088#1072#1094#1080#1103
      object PanelFact: TPanel
        Left = 0
        Top = 228
        Width = 537
        Height = 133
        Align = alBottom
        TabOrder = 1
        object Label6: TLabel
          Left = 8
          Top = 13
          Width = 67
          Height = 13
          Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072':'
        end
        object Label7: TLabel
          Left = 8
          Top = 35
          Width = 85
          Height = 13
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
        end
        object Label8: TLabel
          Left = 232
          Top = 13
          Width = 74
          Height = 13
          Caption = #1042#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072':'
        end
        object Label9: TLabel
          Left = 232
          Top = 36
          Width = 92
          Height = 13
          Caption = #1042#1088#1077#1084#1103' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
        end
        object Label10: TLabel
          Left = 8
          Top = 58
          Width = 51
          Height = 13
          Caption = #1056#1072#1073#1086#1090#1085#1080#1082':'
        end
        object Label11: TLabel
          Left = 8
          Top = 80
          Width = 39
          Height = 13
          Caption = #1057#1090#1072#1085#1086#1082':'
        end
        object DateBEG: TDateEdit
          Left = 96
          Top = 8
          Width = 121
          Height = 21
          NumGlyphs = 2
          TabOrder = 0
          OnChange = AnyChange
        end
        object DateEND: TDateEdit
          Left = 96
          Top = 32
          Width = 121
          Height = 21
          NumGlyphs = 2
          TabOrder = 2
          OnChange = AnyChange
        end
        object WRKRCombo: TComboEdit
          Left = 96
          Top = 56
          Width = 329
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 4
          Tablename = 'SPR_WRKR'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1056#1072#1073#1086#1090#1085#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
          Query = qWRKRQuery1
          ID = -1
          OnButtonClick = WRKRComboButtonClick
          OnChange = AnyChange
          OnKeyDown = WRKRComboKeyDown
        end
        object EQPTCombo: TComboEdit
          Left = 96
          Top = 80
          Width = 329
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 5
          Tablename = 'SPR_eqpt'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
          Query = qEQPTQuery
          ID = -1
          OnButtonClick = EQPTComboButtonClick
          OnChange = AnyChange
          OnKeyDown = EQPTComboKeyDown
        end
        object TimeBEG: TDateTimePicker
          Left = 328
          Top = 8
          Width = 65
          Height = 21
          Date = 38510.000000000000000000
          Time = 38510.000000000000000000
          Kind = dtkTime
          TabOrder = 1
        end
        object TimeEND: TDateTimePicker
          Left = 328
          Top = 32
          Width = 65
          Height = 21
          Date = 38510.000000000000000000
          Time = 38510.000000000000000000
          Kind = dtkTime
          TabOrder = 3
        end
      end
      object PanelMain: TPanel
        Left = 0
        Top = 0
        Width = 537
        Height = 228
        Align = alClient
        TabOrder = 0
        object Label3: TLabel
          Left = 17
          Top = 27
          Width = 73
          Height = 13
          Caption = #1042#1080#1076' '#1086#1087#1077#1088#1072#1094#1080#1080':'
        end
        object Label1: TLabel
          Left = 305
          Top = 52
          Width = 98
          Height = 13
          Caption = #1055#1086#1088#1103#1076#1086#1082' '#1086#1087#1077#1088#1072#1094#1080#1080':'
          Visible = False
        end
        object Label2: TLabel
          Left = 17
          Top = 51
          Width = 162
          Height = 13
          Caption = #1042#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' / '#1074#1077#1089' '#1083#1080#1090#1100#1103':'
        end
        object Label4: TLabel
          Left = 17
          Top = 78
          Width = 89
          Height = 13
          Caption = #1056#1072#1079#1088#1103#1076' '#1088#1072#1073#1086#1095#1077#1075#1086':'
        end
        object Label5: TLabel
          Left = 17
          Top = 103
          Width = 58
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100':'
        end
        object LabelCalcInfo: TLabel
          Left = 16
          Top = 128
          Width = 106
          Height = 13
          Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100' '#1086#1087#1077#1088#1072#1094#1080#1080
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object RatingEdit: TRxSpinEdit
          Left = 128
          Top = 71
          Width = 121
          Height = 21
          MaxValue = 7.000000000000000000
          MaxLength = 20
          TabOrder = 3
          OnChange = AnyChange
        end
        object NumberEdit: TMaskEdit
          Left = 408
          Top = 48
          Width = 49
          Height = 21
          EditMask = '999999;1; '
          MaxLength = 6
          ReadOnly = True
          TabOrder = 2
          Text = '      '
          Visible = False
        end
        object PriceEdit: TCurrencyEdit
          Left = 128
          Top = 96
          Width = 121
          Height = 21
          AutoSize = False
          TabOrder = 4
          OnChange = AnyChange
        end
        object VOPCombo: TComboEdit
          Left = 128
          Top = 24
          Width = 329
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          TabOrder = 0
          Tablename = 'SPR_VOP'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1042#1080#1076#1099' '#1086#1087#1077#1088#1072#1094#1080#1081' ('#1042#1099#1073#1086#1088')'
          Query = qVOPQuery
          ID = -1
          OnButtonClick = VOPComboButtonClick
          OnChange = AnyChange
          OnKeyDown = VOPComboKeyDown
        end
        object NTimeEdit: TCurrencyEdit
          Left = 192
          Top = 48
          Width = 89
          Height = 21
          AutoSize = False
          DecimalPlaces = 3
          DisplayFormat = ',0.000'#39'.'#39';-,0.000'#39'.'#39
          TabOrder = 1
          OnChange = NTimeEditChange
          OnExit = NTimeEditExit
        end
        object CalcButton: TButton
          Left = 248
          Top = 96
          Width = 66
          Height = 21
          Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
          TabOrder = 5
          OnClick = CalcButtonClick
        end
      end
    end
    object TabSheet_calc: TTabSheet
      Caption = #1047#1072#1090#1088#1072#1090#1099
      ImageIndex = 1
      object SplitterCalc: TSplitter
        Left = 0
        Top = 261
        Width = 537
        Height = 5
        Cursor = crVSplit
        Align = alTop
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 537
        Height = 261
        Align = alTop
        TabOrder = 0
        object GroupBoxCalc: TGroupBox
          Left = 1
          Top = 1
          Width = 535
          Height = 259
          Align = alClient
          Caption = #1047#1072#1090#1088#1072#1090#1099
          TabOrder = 0
          object ToolBarCalc: TToolBar
            Left = 2
            Top = 15
            Width = 531
            Height = 24
            ButtonHeight = 25
            Caption = 'ToolBarCalc'
            Flat = True
            Images = DATA.EditImages
            TabOrder = 0
            object ButtonAddCalc: TToolButton
              Left = 0
              Top = 0
              Caption = 'ButtonAddCalc'
              ImageIndex = 0
              OnClick = ButtonAddCalcClick
            end
            object ButtonEditCalc: TToolButton
              Left = 23
              Top = 0
              Caption = 'ButtonEditCalc'
              ImageIndex = 1
              OnClick = ButtonEditCalcClick
            end
            object ButtonDelCalc: TToolButton
              Left = 46
              Top = 0
              Caption = 'ButtonDelCalc'
              ImageIndex = 2
              OnClick = ButtonDelCalcClick
            end
            object ButtonCaclUp: TToolButton
              Left = 69
              Top = 0
              Caption = 'ButtonCaclUp'
              ImageIndex = 3
              OnClick = ButtonCaclUpClick
            end
            object ButtonCaclDown: TToolButton
              Left = 92
              Top = 0
              Caption = 'ButtonCaclDown'
              ImageIndex = 4
              OnClick = ButtonCaclDownClick
            end
          end
          object GridCalc: TStringGrid
            Left = 2
            Top = 39
            Width = 531
            Height = 218
            Align = alClient
            ColCount = 4
            DefaultRowHeight = 17
            RowCount = 2
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
            TabOrder = 1
            OnDblClick = ButtonEditCalcClick
            OnKeyDown = GridCalcKeyDown
            ColWidths = (
              14
              40
              236
              127)
          end
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 266
        Width = 537
        Height = 95
        Align = alClient
        TabOrder = 1
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
      end
    end
    object TabSheet_MTR: TTabSheet
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099' '#1086#1087#1077#1088#1072#1094#1080#1080
      ImageIndex = 2
      object GridFactMtr: TStringGrid
        Left = 0
        Top = 25
        Width = 537
        Height = 336
        Align = alClient
        DefaultRowHeight = 17
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
        TabOrder = 0
        OnDblClick = ButtonEditFactMtClick
        OnKeyDown = GridFactMtrKeyDown
        ColWidths = (
          15
          50
          313
          106
          96)
      end
      object ToolBarMtFt: TToolBar
        Left = 0
        Top = 0
        Width = 537
        Height = 25
        Caption = 'ToolBarMtFt'
        Flat = True
        Images = DATA.EditImages
        TabOrder = 1
        object ButtonAddFactMt: TToolButton
          Left = 0
          Top = 0
          Caption = 'ButtonAddFactMt'
          ImageIndex = 0
          OnClick = ButtonAddFactMtClick
        end
        object ButtonEditFactMt: TToolButton
          Left = 23
          Top = 0
          Caption = 'ButtonEditFactMt'
          ImageIndex = 1
          OnClick = ButtonEditFactMtClick
        end
        object ButtonDelFactMt: TToolButton
          Left = 46
          Top = 0
          Caption = 'ButtonDelFactMt'
          ImageIndex = 2
          OnClick = ButtonDelFactMtClick
        end
        object ButtonUpFactMt: TToolButton
          Left = 69
          Top = 0
          Caption = 'ButtonUpFactMt'
          ImageIndex = 3
          OnClick = ButtonUpFactMtClick
        end
        object ButtonDownFactMt: TToolButton
          Left = 92
          Top = 0
          Caption = 'ButtonDownFactMt'
          ImageIndex = 4
          OnClick = ButtonDownFactMtClick
        end
      end
    end
    object TabSheet1: TTabSheet
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
      ImageIndex = 3
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 537
        Height = 25
        Caption = 'ToolBarMtFt'
        Flat = True
        Images = DATA.EditImages
        TabOrder = 0
        object ToolButtonAddEQPT: TToolButton
          Left = 0
          Top = 0
          Caption = 'ButtonAddFactMt'
          ImageIndex = 0
          OnClick = ToolButtonAddEQPTClick
        end
        object ToolButtonEditEQPT: TToolButton
          Left = 23
          Top = 0
          Caption = 'ButtonEditFactMt'
          ImageIndex = 1
          OnClick = ToolButtonEditEQPTClick
        end
        object ToolButtonDelEQPT: TToolButton
          Left = 46
          Top = 0
          Caption = 'ButtonDelFactMt'
          ImageIndex = 2
          OnClick = ToolButtonDelEQPTClick
        end
        object ButtonUpFactEQPT: TToolButton
          Left = 69
          Top = 0
          Caption = 'ButtonUpFactMt'
          ImageIndex = 3
          OnClick = ButtonUpFactEQPTClick
        end
        object ButtonDownFactEQPT: TToolButton
          Left = 92
          Top = 0
          Caption = 'ButtonDownFactMt'
          ImageIndex = 4
          OnClick = ButtonDownFactEQPTClick
        end
      end
      object GridFactEQPT: TStringGrid
        Left = 0
        Top = 25
        Width = 537
        Height = 336
        Align = alClient
        DefaultRowHeight = 17
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
        TabOrder = 1
        OnDblClick = ToolButtonEditEQPTClick
        OnKeyDown = GridFactEQPTKeyDown
        ColWidths = (
          15
          50
          313
          106
          96)
      end
    end
  end
  object qVOPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_vop'
      'where id = :id or code = :code')
    Left = 512
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
  object qWRKRQuery1: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_wrkr'
      'where id = :id or code = :code')
    Left = 512
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
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code')
    Left = 512
    Top = 88
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
  object qWRKRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      'From ADD_HANDL_OPERPLAN_PROC('
      '    :ID_ORDER,'
      '    :LINENO,'
      '    :DATE_FROM,'
      '    :DATE_TO,'
      '    :DINNER_FROM,'
      '    :DINNER_TO,'
      '    :WORK_FROM,'
      '    :WORK_TO)')
    Left = 508
    Top = 120
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_ORDER'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'LINENO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATE_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATE_TO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DINNER_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DINNER_TO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WORK_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WORK_TO'
        ParamType = ptUnknown
      end>
  end
end
