object ENUM_CHRTForm: TENUM_CHRTForm
  Left = 224
  Top = 167
  Width = 784
  Height = 563
  HelpContext = 112
  ActiveControl = OK_Button
  Caption = #1069#1083#1077#1084#1077#1085#1090':'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 488
    Width = 776
    Height = 41
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 184
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 2
      OnClick = Close_ButtomClick
    end
    object OK_Button: TButton
      Left = 96
      Top = 8
      Width = 83
      Height = 25
      Caption = '&'#1054#1050
      TabOrder = 1
      OnClick = OK_ButtomClick
    end
    object Save_Button: TButton
      Left = 16
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1087#1080#1089#1072#1090#1100
      TabOrder = 0
      OnClick = Save_ButtonClick
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 776
    Height = 488
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1072#1103
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 768
        Height = 241
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 7
          Top = 18
          Width = 74
          Height = 13
          Caption = #1050#1086#1076' '#1101#1083#1077#1084#1077#1085#1090#1072':'
        end
        object Label2: TLabel
          Left = 7
          Top = 42
          Width = 79
          Height = 13
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
        end
        object Label5: TLabel
          Left = 7
          Top = 67
          Width = 77
          Height = 13
          Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
        end
        object NMNTCode: TLabel
          Left = 440
          Top = 72
          Width = 57
          Height = 13
          Caption = 'NMNTCode'
        end
        object Label3: TLabel
          Left = 7
          Top = 91
          Width = 76
          Height = 13
          Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077':'
        end
        object Label4: TLabel
          Left = 7
          Top = 116
          Width = 42
          Height = 13
          Caption = #1052#1086#1076#1077#1083#1100':'
        end
        object Label6: TLabel
          Left = 7
          Top = 140
          Width = 80
          Height = 13
          Caption = #1042#1080#1076' '#1084#1072#1090#1077#1088#1080#1072#1083#1072':'
        end
        object Label8: TLabel
          Left = 6
          Top = 164
          Width = 54
          Height = 13
          Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090':'
        end
        object Label7: TLabel
          Left = 6
          Top = 188
          Width = 92
          Height = 13
          Caption = #1055#1088#1080#1079#1085#1072#1082' '#1095#1077#1088#1090#1077#1078#1072':'
        end
        object Label9: TLabel
          Left = 6
          Top = 212
          Width = 96
          Height = 13
          Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080':'
        end
        object Code: TEdit
          Left = 104
          Top = 16
          Width = 113
          Height = 21
          MaxLength = 18
          TabOrder = 0
          OnKeyDown = SetNextFocus
        end
        object _Name: TEdit
          Left = 104
          Top = 40
          Width = 329
          Height = 21
          MaxLength = 80
          TabOrder = 1
          OnKeyDown = SetNextFocus
        end
        object NMNTCombo: TComboEdit
          Left = 104
          Top = 66
          Width = 329
          Height = 21
          Hint = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          Tablename = 'SPR_NMNT'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' ('#1042#1099#1073#1086#1088')'
          Query = qNMNTQuery
          ID = -1
          CanSelectGroup = False
          OnButtonClick = NMNTComboButtonClick
          OnKeyDown = NMNTComboKeyDown
        end
        object EQPTCombo: TComboEdit
          Left = 104
          Top = 88
          Width = 329
          Height = 21
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          Tablename = 'SPR_EQPT'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
          Query = qEQPTQuery
          ID = -1
          CanSelectGroup = False
          OnButtonClick = EQPTComboButtonClick
          OnKeyDown = EQPTComboKeyDown
        end
        object MDLCombo: TComboEdit
          Left = 104
          Top = 112
          Width = 329
          Height = 21
          Hint = #1052#1086#1076#1077#1083#1080
          GlyphKind = gkEllipsis
          ButtonWidth = 20
          NumGlyphs = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          Tablename = 'SPR_MDL'
          TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1086#1076#1077#1083#1080' ('#1042#1099#1073#1086#1088')'
          Query = qMDLQuery
          ID = -1
          CanSelectGroup = False
          OnButtonClick = MDLComboButtonClick
          OnKeyDown = MDLComboKeyDown
        end
        object MtrVid: TComboBox
          Left = 104
          Top = 136
          Width = 329
          Height = 21
          ItemHeight = 13
          TabOrder = 5
          OnKeyDown = SetNextFocus
          Items.Strings = (
            #1043#1086#1090#1086#1074#1072#1103' '#1087#1088#1086#1076#1091#1082#1094#1080#1103
            #1054#1089#1085#1086#1074#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072', '#1085#1077' '#1090#1088#1077#1073#1091#1102#1097#1080#1077' '#1084#1086#1085#1090#1072#1078#1072
            #1054#1089#1085#1086#1074#1085#1099#1077' '#1089#1088#1077#1076#1089#1090#1074#1072', '#1090#1077#1088#1077#1073#1091#1102#1097#1080#1077' '#1084#1086#1085#1090#1072#1078#1072)
        end
        object Vid_Chrt: TComboBox
          Left = 103
          Top = 159
          Width = 329
          Height = 21
          ItemHeight = 13
          TabOrder = 6
          OnKeyDown = SetNextFocus
          Items.Strings = (
            #1048#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1077
            #1056#1077#1084#1086#1085#1090)
        end
        object Pr_chrt: TComboBox
          Left = 104
          Top = 184
          Width = 145
          Height = 21
          ItemHeight = 13
          TabOrder = 7
          Text = 'Pr_chrt'
          OnKeyDown = SetNextFocus
          Items.Strings = (
            '0 - '#1042#1085#1091#1090#1088#1077#1085#1085#1080#1081
            '1 - '#1042#1085#1077#1096#1085#1080#1081
            '2 - '#1048#1084#1087#1086#1088#1090
            '3 - '#1063#1091#1075#1091#1085
            '4 - '#1057#1090#1072#1083#1100
            '5 - '#1050'/'#1091#1087#1086#1088
            '6 - '#1041#1088#1086#1085#1079#1072
            '8 - '#1040#1083#1083#1102#1084#1080#1085#1080#1081)
        end
        object DateEdit_Reg: TDateEdit
          Left = 104
          Top = 208
          Width = 145
          Height = 21
          NumGlyphs = 2
          TabOrder = 8
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 241
        Width = 768
        Height = 219
        Align = alClient
        TabOrder = 1
        object Splitter2: TSplitter
          Left = 1
          Top = 1
          Width = 766
          Height = 3
          Align = alNone
        end
        object Splitter1: TSplitter
          Left = 1
          Top = 133
          Width = 766
          Height = 3
          Cursor = crVSplit
          Align = alBottom
        end
        object GroupBox2: TGroupBox
          Left = 1
          Top = 1
          Width = 766
          Height = 132
          Align = alClient
          Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1087#1086' '#1095#1077#1088#1090#1077#1078#1091
          TabOrder = 0
          object MemoInfo: TMemo
            Left = 2
            Top = 15
            Width = 762
            Height = 115
            Align = alClient
            Color = 10930928
            Lines.Strings = (
              '')
            ReadOnly = True
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
        object GroupBox3: TGroupBox
          Left = 1
          Top = 136
          Width = 766
          Height = 82
          Align = alBottom
          Caption = #1042#1074#1086#1076' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1087#1086' '#1095#1077#1088#1090#1077#1078#1091
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object MemoInfoEnter: TMemo
            Left = 2
            Top = 15
            Width = 762
            Height = 65
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
      ImageIndex = 1
      object Panel8: TPanel
        Left = 0
        Top = 0
        Width = 768
        Height = 25
        Align = alTop
        TabOrder = 0
        object ToolBarCH: TToolBar
          Left = 1
          Top = 1
          Width = 766
          Height = 29
          Caption = 'ToolBarCH'
          Flat = True
          Images = DATA.EditImages
          TabOrder = 0
          object TooButtonAdd: TToolButton
            Left = 0
            Top = 0
            Caption = 'TooButtonAdd'
            ImageIndex = 0
            OnClick = ButtonAddClick
          end
          object ToolButtonEdit: TToolButton
            Left = 23
            Top = 0
            Caption = 'ToolButtonEdit'
            ImageIndex = 1
            OnClick = ButtonEditClick
          end
          object ToolButtonDel: TToolButton
            Left = 46
            Top = 0
            Caption = 'ToolButtonDel'
            ImageIndex = 2
            OnClick = ButtonDelClick
          end
        end
      end
      object Panel9: TPanel
        Left = 0
        Top = 25
        Width = 768
        Height = 435
        Align = alClient
        TabOrder = 1
        object CHRCGrid: TDBGridEh
          Left = 1
          Top = 1
          Width = 766
          Height = 433
          Align = alClient
          AutoFitColWidths = True
          DataSource = SprChrCSource
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
          OnDblClick = ButtonEditClick
          OnKeyDown = CHRCGridKeyDown
          Columns = <
            item
              EditButtons = <>
              FieldName = 'NAME'
              Footers = <>
              Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 144
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
    object TabSheet3: TTabSheet
      Caption = #1054#1087#1077#1088#1072#1094#1080#1080
      ImageIndex = 2
      object SplitterOp: TSplitter
        Left = 0
        Top = 196
        Width = 768
        Height = 5
        Cursor = crVSplit
        Align = alBottom
      end
      object Panel2: TPanel
        Left = 0
        Top = 201
        Width = 768
        Height = 259
        Align = alBottom
        TabOrder = 0
        object OperatePageControl: TPageControl
          Left = 1
          Top = 1
          Width = 766
          Height = 257
          ActivePage = MaterialTabSheet
          Align = alClient
          TabOrder = 0
          object MaterialTabSheet: TTabSheet
            Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
            object NMNTGrid: TDBGridEh
              Left = 0
              Top = 27
              Width = 758
              Height = 202
              Align = alClient
              AutoFitColWidths = True
              DataSource = NMNTSource
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
              OnDblClick = Button6Click
              OnKeyDown = NMNTGridKeyDown
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'NUMBER'
                  Footers = <>
                  Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
                  Visible = False
                end
                item
                  EditButtons = <>
                  FieldName = 'NAME'
                  Footers = <>
                  Title.Caption = #1052#1072#1090#1077#1088#1080#1072#1083
                  Width = 186
                end
                item
                  EditButtons = <>
                  FieldName = 'PRICE'
                  Footers = <>
                  Title.Caption = #1062#1077#1085#1072
                end
                item
                  EditButtons = <>
                  FieldName = 'NAME_1'
                  Footers = <>
                  Title.Caption = #1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103
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
                  FieldName = 'HIGHT'
                  Footers = <>
                  Title.Caption = #1042#1099#1089#1086#1090#1072
                end
                item
                  EditButtons = <>
                  FieldName = 'WEIGHT_1'
                  Footers = <>
                  Title.Caption = #1042#1077#1089
                end>
            end
            object ToolBarMtr: TToolBar
              Left = 0
              Top = 0
              Width = 758
              Height = 27
              Caption = 'ToolBarMtr'
              Flat = True
              Images = DATA.EditImages
              TabOrder = 1
              object ToolButtonAddMtr: TToolButton
                Left = 0
                Top = 0
                Caption = 'ToolButtonAddMtr'
                ImageIndex = 0
                OnClick = ButtonAddMtrClick
              end
              object ToolButtonEditMtr: TToolButton
                Left = 23
                Top = 0
                Caption = 'ToolButtonEditMtr'
                ImageIndex = 1
                OnClick = Button6Click
              end
              object ToolButtonDelMtr: TToolButton
                Left = 46
                Top = 0
                Caption = 'ToolButtonDelMtr'
                ImageIndex = 2
                OnClick = ButtonDelMtrClick
              end
            end
          end
          object EQPTTabSheet: TTabSheet
            Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
            ImageIndex = 1
            object EQPTGrid: TDBGridEh
              Left = 0
              Top = 27
              Width = 758
              Height = 202
              Align = alClient
              AutoFitColWidths = True
              DataSource = EQPTDataSource
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
              OnDblClick = ToolButtonEditEQPTClick
              OnKeyDown = EQPTGridKeyDown
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'NAME'
                  Footers = <>
                  Title.Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
                  Width = 186
                end
                item
                  EditButtons = <>
                  FieldName = 'NAME_1'
                  Footers = <>
                  Title.Caption = #1045#1076'. '#1080#1079#1084#1077#1088#1077#1085#1080#1103
                  Width = 95
                end
                item
                  EditButtons = <>
                  FieldName = 'NUMBER'
                  Footers = <>
                  Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
                  Width = 99
                end>
            end
            object ToolBar1: TToolBar
              Left = 0
              Top = 0
              Width = 758
              Height = 27
              Caption = 'ToolBarMtr'
              Flat = True
              Images = DATA.EditImages
              TabOrder = 1
              object ToolButtonAddEQPT: TToolButton
                Left = 0
                Top = 0
                Caption = 'ToolButtonAddMtr'
                ImageIndex = 0
                OnClick = ToolButtonAddEQPTClick
              end
              object ToolButtonEditEQPT: TToolButton
                Left = 23
                Top = 0
                Caption = 'ToolButtonEditMtr'
                ImageIndex = 1
                OnClick = ToolButtonEditEQPTClick
              end
              object ToolButtonDelEQPT: TToolButton
                Left = 46
                Top = 0
                Caption = 'ToolButtonDelMtr'
                ImageIndex = 2
                OnClick = ToolButtonDelEQPTClick
              end
            end
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 768
        Height = 196
        Align = alClient
        TabOrder = 1
        object Panel4: TPanel
          Left = 1
          Top = 1
          Width = 766
          Height = 26
          Align = alTop
          TabOrder = 0
          object ToolBarOP: TToolBar
            Left = 1
            Top = 1
            Width = 764
            Height = 29
            Caption = 'ToolBarOP'
            Flat = True
            Images = DATA.EditImages
            TabOrder = 0
            object ToolButtonAddOp: TToolButton
              Left = 0
              Top = 0
              Caption = 'ToolButtonAddOp'
              ImageIndex = 0
              OnClick = ButtonAddOpClick
            end
            object ToolButtonEditOp: TToolButton
              Left = 23
              Top = 0
              Caption = 'ToolButtonEditOp'
              ImageIndex = 1
              OnClick = ButtonEditOpClick
            end
            object ToolButtonDelOp: TToolButton
              Left = 46
              Top = 0
              Caption = 'ToolButtonDelOp'
              ImageIndex = 2
              OnClick = ButtonDelOpClick
            end
            object ToolButtonUp: TToolButton
              Left = 69
              Top = 0
              Caption = 'ToolButtonUp'
              ImageIndex = 3
              OnClick = ToolButtonUpClick
            end
            object ToolButtonDown: TToolButton
              Left = 92
              Top = 0
              Caption = 'ToolButtonDown'
              ImageIndex = 4
              OnClick = ToolButtonDownClick
            end
          end
        end
        object Panel5: TPanel
          Left = 1
          Top = 27
          Width = 766
          Height = 168
          Align = alClient
          TabOrder = 1
          object GroupBox1: TGroupBox
            Left = 1
            Top = 1
            Width = 764
            Height = 166
            Align = alClient
            Caption = #1054#1087#1077#1088#1072#1094#1080#1080
            TabOrder = 0
            object OpGrid: TDBGridEh
              Left = 2
              Top = 15
              Width = 760
              Height = 149
              Align = alClient
              AutoFitColWidths = True
              DataSource = OPSource
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
              OnDblClick = ButtonEditOpClick
              OnKeyDown = OPGridKeyDown
              Columns = <
                item
                  EditButtons = <>
                  FieldName = 'Number'
                  Footers = <>
                  Title.Caption = #1053#1086#1084#1077#1088
                end
                item
                  EditButtons = <>
                  FieldName = 'NAME'
                  Footers = <>
                  Title.Caption = #1054#1087#1077#1088#1072#1094#1080#1103
                end
                item
                  EditButtons = <>
                  FieldName = 'rating'
                  Footers = <>
                  Title.Caption = #1056#1072#1079#1088#1103#1076' '#1088#1072#1073#1086#1095#1077#1075#1086
                end
                item
                  EditButtons = <>
                  FieldName = 'price'
                  Footers = <>
                  Title.Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100
                end
                item
                  EditButtons = <>
                  FieldName = 'ntime'
                  Footers = <>
                  Title.Caption = #1042#1088#1077#1084#1103
                end>
            end
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
    Left = 624
    Top = 48
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
    Left = 592
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
  object SprChrCSource: TDataSource
    DataSet = qCHRCQuery
    Left = 532
  end
  object qCHRCQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select b.id, a.name, b.nsize, b.kind'
      'from spr_vchr a, spr_chrc b  '
      'where a.ID = b.id_VID and ID_CHRT =:id')
    Left = 564
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
    object qCHRCQueryID: TIntegerField
      FieldName = 'ID'
    end
    object qCHRCQueryNAME: TStringField
      FieldName = 'NAME'
      FixedChar = True
      Size = 15
    end
    object qCHRCQueryNSIZE: TFloatField
      FieldName = 'NSIZE'
      Precision = 3
    end
    object qCHRCQueryKIND: TStringField
      FieldName = 'KIND'
      FixedChar = True
      Size = 10
    end
  end
  object OPSource: TDataSource
    DataSet = qOpQuery
    Left = 534
    Top = 34
  end
  object NMNTSource: TDataSource
    DataSet = qNMNTTableQuery
    Left = 534
    Top = 74
  end
  object qOpQuery: TQuery
    AfterScroll = qOpQueryAfterScroll
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select a.name, b.number, b.rating, b.price, b.id, b.ntime / 1000' +
        ' as ntime'
      
        'from spr_vop a, spr_opch b where b.id_vop = a.id and b.id_chrt =' +
        ' :ID'
      'order by b.number')
    Left = 566
    Top = 34
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object qNMNTTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select  (select name from spr_nmnt where id = b.id_nmnt) as name' +
        ','
      'b.NUMBER, cast(b.price as numeric(15,2)) as price,'
      '(select name from spr_ediz where id = b.id_ediz),'
      'b.id, b.lenght, b.width, '
      'b.hight, cast(b.weight as decimal(15,3))  as weight_1'
      'from  spr_MTCH b'
      'where b.id_opch =:ID')
    Left = 566
    Top = 74
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object GenIDQuery: TQuery
    DatabaseName = 'RMP'
    Left = 660
    Top = 48
  end
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid,  name, code'
      'from spr_eqpt'
      'where id = :id  or code = :code')
    Left = 580
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
  object qMDLQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_mdl'
      'where id = :id  or code = :code')
    Left = 580
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
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_nmnt'
      'where id = :id  or code = :code')
    Left = 580
    Top = 131
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
  object qEQPTTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select eqpt.name, b.NUMBER, ediz.name,'
      'b.id'
      'from spr_eqpt eqpt, spr_eqptchrt b, spr_ediz ediz'
      'where eqpt.id = b.id_eqpt'
      'and b.id_ediz = ediz.id'
      'and b.id_opch = :ID')
    Left = 566
    Top = 106
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
  end
  object EQPTDataSource: TDataSource
    DataSet = qEQPTTableQuery
    Left = 534
    Top = 106
  end
end
