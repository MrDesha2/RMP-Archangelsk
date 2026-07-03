object MAINForm: TMAINForm
  Left = 353
  Top = 309
  Width = 755
  Height = 508
  HelpContext = 1
  Caption = 'PMASC: '#1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1088#1077#1076#1087#1088#1080#1103#1090#1080#1077#1084
  Color = clAppWorkSpace
  UseDockManager = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu
  OldCreateOrder = False
  WindowState = wsMaximized
  WindowMenu = MenuWin
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object MainStatusBar: TStatusBar
    Left = 0
    Top = 413
    Width = 737
    Height = 19
    AutoHint = True
    Panels = <
      item
        Text = 'Press F1 for help'
        Width = 250
      end
      item
        Width = 300
      end
      item
        Text = 'date'
        Width = 50
      end>
    PopupMenu = PopupMenuControlBar
  end
  object ControlBar: TControlBar
    Left = 0
    Top = 0
    Width = 737
    Height = 30
    Align = alTop
    AutoSize = True
    Color = clBtnFace
    ParentColor = False
    ParentShowHint = False
    PopupMenu = JR_RQSTEQPTForm.TableMenu
    ShowHint = True
    TabOrder = 1
    object ToolBar_ENUMS: TToolBar
      Left = 11
      Top = 2
      Width = 145
      Height = 22
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      DragKind = dkDock
      DragMode = dmAutomatic
      Flat = True
      Images = MainImages
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Transparent = True
      object Tool_CHRT: TToolButton
        Left = 0
        Top = 0
        Hint = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' "'#1063#1077#1088#1090#1077#1078#1080'"'
        Caption = 'Tool_CHRT'
        ImageIndex = 11
        OnClick = MenuEnumCHRTClick
      end
      object Tool_NMNT: TToolButton
        Left = 23
        Top = 0
        Hint = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' "'#1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072'"'
        Caption = 'Tool_NMNT'
        ImageIndex = 12
        OnClick = MenuEnumNMNTClick
      end
      object Tool_EQPT: TToolButton
        Left = 46
        Top = 0
        Hint = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' "'#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077'"'
        Caption = 'Tool_EQPT'
        ImageIndex = 9
        OnClick = MenuEnumEQPTClick
      end
      object Tool_Sep_1: TToolButton
        Left = 69
        Top = 0
        Width = 5
        Caption = 'Tool_Sep_1'
        ImageIndex = 11
        Style = tbsSeparator
      end
      object Tool_CST: TToolButton
        Left = 74
        Top = 0
        Hint = #1057#1087#1088#1072#1074#1086#1095#1085#1082#1080' "'#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080'"'
        Caption = 'Tool_CST'
        ImageIndex = 17
        OnClick = MenuEnumCSTClick
      end
      object Tool_PDR: TToolButton
        Left = 97
        Top = 0
        Hint = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' "'#1052#1042#1047'"'
        Caption = 'Tool_PDR'
        ImageIndex = 21
        OnClick = MenuEnumMVZClick
      end
      object Tool_wrkr: TToolButton
        Left = 120
        Top = 0
        Hint = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' "'#1056#1072#1073#1086#1090#1085#1080#1082#1080'"'
        Caption = 'Tool_wrkr'
        ImageIndex = 10
        OnClick = MenuEnumWRKRClick
      end
    end
    object ToolBar_Docs: TToolBar
      Left = 169
      Top = 2
      Width = 70
      Height = 22
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      DragKind = dkDock
      Flat = True
      Images = MainImages
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Transparent = True
      object Tool_RQST: TToolButton
        Left = 0
        Top = 0
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#13#10'"'#1047#1072#1103#1074#1082#1072'"'
        Caption = 'Tool_RQST'
        ImageIndex = 18
        OnClick = MenuRQSTDocClick
      end
      object Tool_PRDOC: TToolButton
        Left = 23
        Top = 0
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#13#10'"'#1055#1088#1080#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103'"'
        Caption = 'Tool_PRDOC'
        ImageIndex = 19
        OnClick = MenuPRDocClick
      end
      object Tool_RSDOC: TToolButton
        Left = 46
        Top = 0
        Hint = 
          #1057#1086#1079#1076#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' '#13#10'"'#1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103'" '#13#10'"'#1040#1082#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1088#1072#1073#1086 +
          #1090'"'
        Caption = 'Tool_RSDOC'
        ImageIndex = 20
        OnClick = MenuRSDocClick
      end
    end
    object ToolBar_JR: TToolBar
      Left = 252
      Top = 2
      Width = 95
      Height = 22
      Caption = #1046#1091#1088#1085#1072#1083#1099
      DockSite = True
      DragKind = dkDock
      Flat = True
      Images = MainImages
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Transparent = True
      object Tool_JRRQST: TToolButton
        Left = 0
        Top = 0
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083' '#13#10#1079#1072#1103#1074#1086#1082
        Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072#1103#1074#1086#1082
        ImageIndex = 13
        OnClick = MenuRQSTJrnClick
      end
      object Tool_JRORDER: TToolButton
        Left = 23
        Top = 0
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083#13#10#1079#1072#1082#1072#1079#1086#1074
        Caption = 'Tool_JRORDER'
        ImageIndex = 14
        OnClick = MenuORDRJrnClick
      end
      object Tool_JRPR: TToolButton
        Left = 46
        Top = 0
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083' '#13#10#1087#1088#1080#1093#1086#1076#1085#1099#1093' '#1085#1072#1082#1083#1072#1076#1085#1099#1093
        Caption = 'Tool_JRPR'
        ImageIndex = 15
        OnClick = MenuPRDocJrnClick
      end
      object Tool_JRRS: TToolButton
        Left = 69
        Top = 0
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083#13#10#1088#1072#1089#1093#1086#1076#1085#1099#1093' '#1085#1072#1082#1083#1072#1076#1085#1099#1093
        Caption = 'Tool_JRRS'
        ImageIndex = 16
        OnClick = MenuRSDocJrnClick
      end
    end
    object ToolBar_MTR: TToolBar
      Left = 360
      Top = 2
      Width = 95
      Height = 22
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
      DockSite = True
      DragKind = dkDock
      Flat = True
      Images = MainImages
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Transparent = True
      object ToolButtonAddMTR: TToolButton
        Left = 0
        Top = 0
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#13#10'"'#1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074'"'
        Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072#1103#1074#1086#1082
        ImageIndex = 23
        OnClick = MenuPRMTRClick
      end
      object ToolButton2: TToolButton
        Left = 23
        Top = 0
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#13#10'"'#1054#1090#1087#1091#1089#1082' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074'"'
        Caption = 'Tool_JRORDER'
        ImageIndex = 24
        OnClick = MenuRSMTRClick
      end
      object ToolButton3: TToolButton
        Left = 46
        Top = 0
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083#13#10'"'#1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074'"'
        Caption = 'Tool_JRPR'
        ImageIndex = 25
        OnClick = MenuPRMTRJRClick
      end
      object ToolButton4: TToolButton
        Left = 69
        Top = 0
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083#13#10'"'#1054#1090#1087#1091#1089#1082' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074'"'
        Caption = 'Tool_JRRS'
        ImageIndex = 26
        OnClick = MenuRSMTRJRClick
      end
    end
    object ToolBar_Custom: TToolBar
      Left = 580
      Top = 2
      Width = 76
      Height = 22
      Caption = #1057#1080#1089#1090#1077#1084#1085#1072#1103
      DragKind = dkDock
      Flat = True
      Images = MainImages
      TabOrder = 5
      object ToolButtonCalc: TToolButton
        Left = 0
        Top = 0
        Caption = 'ToolButtonCalc'
        ImageIndex = 30
        OnClick = CalculatorClick
      end
      object ToolButtonHelp: TToolButton
        Left = 23
        Top = 0
        Caption = 'ToolButtonHelp'
        ImageIndex = 32
        OnClick = MenuHelpHelpClick
      end
      object ToolButtonAbout: TToolButton
        Left = 46
        Top = 0
        Hint = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        Caption = 'ToolButtonAbout'
        ImageIndex = 31
        OnClick = MenoHelpAboutClick
      end
    end
    object ToolBar_Tool: TToolBar
      Left = 468
      Top = 2
      Width = 99
      Height = 22
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
      Flat = True
      Images = MainImages
      TabOrder = 4
      object ToolButtonAddEQPT: TToolButton
        Left = 0
        Top = 0
        Hint = #1053#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072'"'
        Caption = 'ToolButtonAddEQPT'
        ImageIndex = 38
        OnClick = MenuPREQPTClick
      end
      object ToolButtonDelEQPT: TToolButton
        Left = 23
        Top = 0
        Hint = #1057#1086#1079#1076#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1054#1090#1087#1091#1089#1082' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072'"'
        Caption = 'ToolButtonDelEQPT'
        ImageIndex = 37
        OnClick = MenuRSEQPTClick
      end
      object ToolButtonJRADDEQPT: TToolButton
        Left = 46
        Top = 0
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083' "'#1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072'"'
        Caption = 'ToolButtonJRADDEQPT'
        ImageIndex = 36
        OnClick = MenuJRPREQPTClick
      end
      object ToolButtonJRDELEQPT: TToolButton
        Left = 69
        Top = 0
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083' "'#1054#1090#1087#1091#1089#1082' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072'"'
        Caption = 'ToolButtonJRDELEQPT'
        ImageIndex = 35
        OnClick = MenuJRRSEQPTClick
      end
    end
  end
  object PanelMessage: TPanel
    Left = 0
    Top = 288
    Width = 737
    Height = 125
    Align = alBottom
    TabOrder = 2
    Visible = False
    object MessageWin: TMemo
      Left = 1
      Top = 1
      Width = 735
      Height = 123
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object MainMenu: TMainMenu
    Images = MainImages
    Left = 128
    Top = 216
    object MenuFile: TMenuItem
      Caption = #1060#1072#1081#1083
      Hint = #1060#1072#1081#1083
      object MenuClose: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        ShortCut = 16472
        OnClick = MenuCloseClick
      end
    end
    object MenuEnums: TMenuItem
      Caption = '&'#1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      GroupIndex = 3
      Hint = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      object MenuEnumNMNT: TMenuItem
        Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072
        Hint = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072
        ImageIndex = 12
        OnClick = MenuEnumNMNTClick
      end
      object MenuEnumCHRT: TMenuItem
        Caption = #1063#1077#1088#1090#1077#1078
        Hint = #1063#1077#1088#1090#1077#1078
        ImageIndex = 11
        OnClick = MenuEnumCHRTClick
      end
      object MenuEnumWRHS: TMenuItem
        Caption = #1057#1082#1083#1072#1076#1099
        Hint = #1057#1082#1083#1072#1076#1099
        OnClick = MenuEnumWRHSClick
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object MenuEnumEQPT: TMenuItem
        Caption = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
        Hint = #1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077
        ImageIndex = 9
        OnClick = MenuEnumEQPTClick
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object MenuEnumCST: TMenuItem
        Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
        Hint = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
        ImageIndex = 17
        OnClick = MenuEnumCSTClick
      end
      object MenuEnumMVZ: TMenuItem
        Caption = #1052#1042#1047
        Hint = #1052#1042#1047
        ImageIndex = 21
        OnClick = MenuEnumMVZClick
      end
      object MenuEnumWRKR: TMenuItem
        Caption = #1056#1072#1073#1086#1090#1085#1080#1082#1080
        Hint = #1056#1072#1073#1086#1090#1085#1080#1082#1080
        ImageIndex = 10
        OnClick = MenuEnumWRKRClick
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object MenuEnumMOD: TMenuItem
        Caption = #1052#1086#1076#1077#1083#1080
        Hint = #1052#1086#1076#1077#1083#1080
        OnClick = MenuEnumMODClick
      end
      object N26: TMenuItem
        Caption = '-'
      end
      object MenuEnumOther: TMenuItem
        Caption = #1055#1088#1086#1095#1080#1077
        Hint = #1055#1088#1086#1095#1080#1077
        object MenuEnumEDIZ: TMenuItem
          Caption = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
          Hint = #1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
          ImageIndex = 33
          OnClick = MenuEnumEDIZClick
        end
        object N27: TMenuItem
          Caption = '-'
        end
        object N16: TMenuItem
          Caption = #1052#1072#1089#1090#1077#1088' '#1056#1052#1055
          Hint = #1052#1072#1089#1090#1077#1088' '#1056#1052#1055
          object MenuEnumVHR: TMenuItem
            Caption = #1042#1080#1076#1099' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082
            Hint = #1042#1080#1076#1099' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082
            OnClick = MenuEnumVHRClick
          end
          object MenuEnumVOP: TMenuItem
            Caption = #1042#1080#1076#1099' '#1086#1087#1077#1088#1072#1094#1080#1081
            Hint = #1042#1080#1076#1099' '#1086#1087#1077#1088#1072#1094#1080#1081
            OnClick = MenuEnumVOPClick
          end
          object MenuEnumTPEQ: TMenuItem
            Caption = #1058#1080#1087#1099' '#1089#1090#1072#1085#1082#1086#1074
            Hint = #1058#1080#1087#1099' '#1089#1090#1072#1085#1082#1086#1074
            OnClick = MenuEnumTPEQClick
          end
          object MenuEnumSPRG: TMenuItem
            Caption = #1042#1080#1076#1099' '#1079#1072#1075#1086#1090#1086#1074#1086#1082
            Hint = #1042#1080#1076#1099' '#1079#1072#1075#1086#1090#1086#1074#1086#1082
            OnClick = MenuEnumSPRGClick
          end
        end
        object N29: TMenuItem
          Caption = #1055#1069#1057
          Hint = #1055#1069#1057
          object MenuEnumSTAT: TMenuItem
            Caption = #1057#1090#1072#1090#1100#1080' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080
            Hint = #1057#1090#1072#1090#1100#1080' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080
            OnClick = MenuEnumSTATClick
          end
          object MenuEnumCALC: TMenuItem
            Caption = #1047#1072#1090#1088#1072#1090#1099
            Hint = #1047#1072#1090#1088#1072#1090#1099
            OnClick = MenuEnumCALCClick
          end
          object MenuEnumMVP: TMenuItem
            Caption = #1052#1042#1055
            Hint = #1052#1042#1055
            OnClick = MenuEnumMVPClick
          end
          object MenuEnumCOUNT: TMenuItem
            Caption = #1057#1095#1077#1090#1072
            Hint = #1057#1095#1077#1090#1072
            OnClick = MenuEnumCOUNTClick
          end
        end
        object N28: TMenuItem
          Caption = #1050#1072#1076#1088#1086#1074#1099#1077
          Hint = #1050#1072#1076#1088#1086#1074#1099#1077
          object MenuEnumPROF: TMenuItem
            Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1080
            Hint = #1055#1088#1086#1092#1077#1089#1089#1080#1080
            OnClick = MenuEnumPROFClick
          end
          object MenuEnumPOST: TMenuItem
            Caption = #1044#1086#1078#1085#1086#1089#1090#1080
            Hint = #1044#1086#1078#1085#1086#1089#1090#1080
            OnClick = MenuEnumPOSTClick
          end
          object MenuEnumBrigade: TMenuItem
            Caption = #1041#1088#1080#1075#1072#1076#1099
            Hint = #1041#1088#1080#1075#1072#1076#1099
            OnClick = MenuEnumBrigadeClick
          end
          object N11: TMenuItem
            Caption = '-'
          end
          object MenuEnumSertificate: TMenuItem
            Caption = #1040#1090#1090#1077#1089#1090#1072#1090#1099
            Hint = #1057#1077#1088#1090#1080#1092#1080#1082#1072#1090#1099
            OnClick = MenuEnumSertificateClick
          end
          object MenuEnumACCESS: TMenuItem
            Caption = #1042#1080#1076#1099' '#1076#1086#1087#1091#1089#1082#1072
            Hint = #1042#1080#1076#1099' '#1076#1086#1087#1091#1089#1082#1072
            OnClick = MenuEnumACCESSClick
          end
        end
        object N30: TMenuItem
          Caption = '-'
        end
        object MenuEnumPLANT: TMenuItem
          Caption = #1047#1072#1074#1086#1076#1099
          Hint = #1047#1072#1074#1086#1076#1099
          ImageIndex = 34
          OnClick = MenuEnumPLANTClick
        end
        object MenuEnumVMVZ: TMenuItem
          Caption = #1042#1080#1076#1099' '#1052#1042#1047
          Hint = #1042#1080#1076#1099' '#1052#1042#1047
          OnClick = MenuEnumVMVZClick
        end
      end
      object N3: TMenuItem
        Caption = #1055#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077
        object MenuEnumCalend: TMenuItem
          Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1099#1081' '#1082#1072#1083#1077#1085#1076#1072#1088#1100
          OnClick = MenuEnumCalendClick
        end
      end
    end
    object MenuDocs: TMenuItem
      Caption = '&'#1044#1086#1082#1091#1084#1077#1085#1090#1099
      GroupIndex = 4
      Hint = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      object MenuRQSTDoc: TMenuItem
        Caption = #1047#1072#1103#1074#1082#1072
        Hint = #1042#1074#1077#1089#1090#1080' '#1085#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1047#1072#1103#1074#1082#1072'"'
        ImageIndex = 18
        OnClick = MenuRQSTDocClick
      end
      object N42: TMenuItem
        Caption = '-'
      end
      object MenuPRDoc: TMenuItem
        Caption = #1055#1088#1080#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' '#1075#1086#1090#1086#1074#1086#1081' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
        Hint = #1042#1074#1077#1089#1090#1080' '#1085#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1055#1088#1080#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103'"'
        ImageIndex = 19
        OnClick = MenuPRDocClick
      end
      object MenuRSDoc: TMenuItem
        Caption = #1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' '#1075#1086#1090#1086#1074#1086#1081' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
        Hint = #1042#1074#1077#1089#1090#1080' '#1085#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103'"'
        ImageIndex = 20
        OnClick = MenuRSDocClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object MenuPRMTR: TMenuItem
        Caption = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
        ImageIndex = 23
        OnClick = MenuPRMTRClick
      end
      object MenuRSMTR: TMenuItem
        Caption = #1054#1090#1087#1091#1089#1082' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
        ImageIndex = 24
        OnClick = MenuRSMTRClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object MenuMtrOrder: TMenuItem
        Caption = #1047#1072#1082#1072#1079' '#1085#1072' '#1087#1086#1089#1090#1072#1074#1082#1091' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
        Hint = #1047#1072#1082#1072#1079' '#1085#1072' '#1087#1086#1089#1090#1072#1074#1082#1091' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
        OnClick = MenuMtrOrderClick
      end
      object N7: TMenuItem
        Caption = #1059#1095#1077#1090' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
        object MenuPREQPT: TMenuItem
          Caption = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077
          Hint = #1053#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072'"'
          OnClick = MenuPREQPTClick
        end
        object MenuRSEQPT: TMenuItem
          Caption = #1042#1099#1073#1099#1090#1080#1077
          Hint = #1053#1086#1074#1099#1081' '#1076#1086#1082#1091#1084#1077#1085#1090' "'#1057#1087#1080#1089#1072#1085#1080#1077' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072'"'
          OnClick = MenuRSEQPTClick
        end
        object MenuRQSTEQPT: TMenuItem
          Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090
          OnClick = MenuRQSTEQPTClick
        end
      end
      object N10: TMenuItem
        Caption = #1059#1095#1077#1090' '#1084#1086#1076#1077#1083#1077#1081
        object MenuPRModelDoc: TMenuItem
          Caption = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1084#1086#1076#1077#1083#1077#1081
          Hint = #1055#1086#1089#1090#1091#1087#1083#1077#1085#1080#1077' '#1084#1086#1076#1077#1083#1077#1081
          OnClick = MenuPRModelDocClick
        end
        object MenuRSModelDoc: TMenuItem
          Caption = #1042#1099#1073#1099#1090#1080#1077' '#1084#1086#1076#1077#1083#1077#1081
          Hint = #1042#1099#1073#1099#1090#1080#1077' '#1084#1086#1076#1077#1083#1077#1081
          OnClick = MenuRSModelDocClick
        end
      end
    end
    object MenuJorn: TMenuItem
      Caption = #1046#1091#1088#1085#1072#1083#1099
      GroupIndex = 5
      Hint = #1046#1091#1088#1085#1072#1083#1099
      object MenuRQSTJrn: TMenuItem
        Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072#1103#1074#1086#1082
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' "'#1047#1072#1103#1074#1082#1080'"'
        ImageIndex = 13
        OnClick = MenuRQSTJrnClick
      end
      object MenuORDRJrn: TMenuItem
        Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072#1082#1072#1079#1086#1074
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083' '#1076#1086#1082#1091#1084#1077#1085#1090#1086#1074' "'#1047#1072#1082#1072#1079#1099'"'
        ImageIndex = 14
        OnClick = MenuORDRJrnClick
      end
      object N40: TMenuItem
        Caption = '-'
      end
      object MenuPlanJrn: TMenuItem
        Caption = #1055#1083#1072#1085#1086#1074#1099#1081' '#1078#1091#1088#1085#1072#1083' '#1079#1072#1082#1072#1079#1086#1074
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1083#1072#1085#1086#1074#1099#1081' '#1078#1091#1088#1085#1072#1083
        OnClick = MenuPlanJrnClick
      end
      object MenuProdJrn: TMenuItem
        Caption = #1055#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1099#1081' '#1078#1091#1088#1085#1072#1083' '#1079#1072#1082#1072#1079#1086#1074
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077#1085#1085#1099#1081' '#1078#1091#1088#1085#1072#1083
        OnClick = MenuProdJrnClick
      end
      object MenuOperJrn: TMenuItem
        Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1099#1081' '#1078#1091#1088#1085#1072#1083
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1086#1087#1077#1088#1072#1090#1080#1074#1085#1099#1081' '#1078#1091#1088#1085#1072#1083
        OnClick = MenuOperJrnClick
      end
      object MenuOpenGant: TMenuItem
        Caption = #1043#1072#1085#1090
        Visible = False
        OnClick = MenuOpenGantClick
      end
      object N46: TMenuItem
        Caption = '-'
      end
      object MenuPRDocJrn: TMenuItem
        Caption = #1046#1091#1088#1085#1072#1083' '#1091#1095#1077#1090#1072' '#1075#1086#1090#1086#1074#1086#1081' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083' '#1087#1088#1080#1093#1086#1076#1085#1099#1093' '#1085#1072#1082#1083#1072#1076#1085#1099#1093
        ImageIndex = 15
        OnClick = MenuPRDocJrnClick
      end
      object MenuRSDocJrn: TMenuItem
        Caption = #1046#1091#1088#1085#1072#1083' '#1086#1090#1087#1091#1089#1082#1072' '#1075#1086#1090#1086#1074#1086#1081' '#1087#1088#1086#1076#1091#1082#1094#1080#1080
        Hint = #1054#1090#1082#1088#1099#1090#1100' '#1078#1091#1088#1085#1072#1083' '#1088#1072#1089#1093#1086#1076#1085#1099#1093' '#1085#1072#1082#1083#1072#1076#1085#1099#1093
        ImageIndex = 16
        OnClick = MenuRSDocJrnClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object MenuPRMTRJR: TMenuItem
        Caption = #1046#1091#1088#1085#1072#1083' '#1087#1088#1080#1093#1086#1076#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
        ImageIndex = 25
        OnClick = MenuPRMTRJRClick
      end
      object MenuRSMTRJR: TMenuItem
        Caption = #1046#1091#1088#1085#1072#1083' '#1088#1072#1089#1093#1086#1076#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
        ImageIndex = 26
        OnClick = MenuRSMTRJRClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object MenuJRMtrOrder: TMenuItem
        Caption = #1047#1072#1082#1072#1079#1099' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
        Hint = #1047#1072#1082#1072#1079#1099' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
        OnClick = MenuJRMtrOrderClick
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object N14: TMenuItem
        Caption = #1059#1095#1077#1090' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
        object MenuJRPREQPT: TMenuItem
          Caption = #1046#1091#1088#1085#1072#1083' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1081' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
          Hint = #1046#1091#1088#1085#1072#1083' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1081' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
          OnClick = MenuJRPREQPTClick
        end
        object MenuJRRSEQPT: TMenuItem
          Caption = #1046#1091#1088#1085#1072#1083' '#1086#1090#1087#1091#1089#1082#1072' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
          Hint = #1046#1091#1088#1085#1072#1083' '#1074#1099#1073#1099#1090#1080#1103' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
          OnClick = MenuJRRSEQPTClick
        end
        object MenuJRRQSTEQPT: TMenuItem
          Caption = #1046#1091#1088#1085#1072#1083' '#1079#1072#1103#1074#1086#1082' '#1085#1072' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090
          OnClick = MenuJRRQSTEQPTClick
        end
        object N15: TMenuItem
          Caption = #1046#1091#1088#1085#1072#1083' '#1076#1074#1080#1078#1077#1085#1080#1103' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
          OnClick = N15Click
        end
        object MENUEqptToWrkr: TMenuItem
          Caption = #1046#1091#1088#1085#1072#1083' '#1074#1099#1076#1072#1095#1080' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
          OnClick = MENUEqptToWrkrClick
        end
      end
      object N17: TMenuItem
        Caption = #1059#1095#1077#1090' '#1084#1086#1076#1077#1083#1077#1081
        object MenuJRPrModel: TMenuItem
          Caption = #1046#1091#1088#1085#1072#1083' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1084#1086#1076#1077#1083#1077#1081
          Hint = #1046#1091#1088#1085#1072#1083' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1084#1086#1076#1077#1083#1077#1081
          OnClick = MenuJRPrModelClick
        end
        object MenuJRRSModel: TMenuItem
          Caption = #1046#1091#1088#1085#1072#1083' '#1086#1090#1087#1091#1089#1082#1072' '#1084#1086#1076#1077#1083#1077#1081
          Hint = #1046#1091#1088#1085#1072#1083' '#1074#1099#1073#1099#1090#1080#1103' '#1084#1086#1076#1077#1083#1077#1081
          OnClick = MenuJRRSModelClick
        end
      end
      object N18: TMenuItem
        Caption = '-'
      end
      object WrkrSert: TMenuItem
        Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1077#1088#1089#1086#1085#1072#1083#1086#1084
        OnClick = WrkrSertClick
      end
    end
    object MenuReports: TMenuItem
      Caption = '&'#1054#1090#1095#1077#1090#1099
      GroupIndex = 6
      Hint = #1054#1090#1095#1077#1090#1099
      object Print_Report_28: TMenuItem
        Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084
        OnClick = Print_Report_Click
      end
    end
    object MenuServis: TMenuItem
      Caption = '&'#1057#1077#1088#1074#1080#1089
      GroupIndex = 9
      Hint = #1057#1077#1088#1074#1080#1089
      object MenuParameters: TMenuItem
        Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        Hint = #1055#1072#1088#1072#1084#1077#1090#1088#1099
        OnClick = MenuParametersClick
      end
      object MenuDataChange: TMenuItem
        Caption = #1054#1073#1084#1077#1085' '#1076#1072#1085#1085#1099#1084#1080
        Visible = False
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Calculator: TMenuItem
        Caption = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
        ImageIndex = 30
        OnClick = CalculatorClick
      end
    end
    object MenuWin: TMenuItem
      Caption = '&'#1054#1082#1085#1072
      GroupIndex = 10
      Hint = #1054#1082#1085#1072
      object MenuTile: TMenuItem
        Caption = '&'#1063#1077#1088#1077#1087#1080#1094#1072
        Hint = #1063#1077#1088#1077#1087#1080#1094#1072
        OnClick = MenuTileClick
      end
      object K1: TMenuItem
        Caption = '&'#1050#1072#1089#1082#1072#1076
        Hint = #1050#1072#1089#1082#1072#1076
        OnClick = MenuCascadeClick
      end
      object MenuCloseAll: TMenuItem
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
        Hint = #1047#1072#1082#1088#1099#1090#1100' '#1074#1089#1077
        OnClick = MenuCloseallClick
      end
    end
    object MenuHelp: TMenuItem
      Caption = '&'#1055#1086#1084#1086#1097#1100
      GroupIndex = 11
      object MenuHelpHelp: TMenuItem
        Caption = #1055#1086#1084#1086#1097#1100
        Hint = #1055#1086#1084#1086#1097#1100
        ImageIndex = 32
        OnClick = MenuHelpHelpClick
      end
      object News: TMenuItem
        Caption = #1063#1090#1086' '#1085#1086#1074#1086#1075#1086'?'
        OnClick = NewsClick
      end
      object N55: TMenuItem
        Caption = '-'
      end
      object MenoHelpAbout: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        Hint = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
        ImageIndex = 31
        OnClick = MenoHelpAboutClick
      end
    end
  end
  object JRImageList: TImageList
    Left = 88
    Top = 252
    Bitmap = {
      494C01010C000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      000000000000000000007B7B7B00840000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000FF0000000000000000007B7B
      7B008400000084000000840000007B7B7B0000000000FF000000FF000000FF00
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000800000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000FF0000000000840000008400
      00008400000084000000840000000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000FF000000FF000000FF000000FF00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000080000000800000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      000084000000840000007B7B7B000000000000000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000080000000800000008000000080000000800000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      0000840000008400000000000000000000000000000000FFFF00FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000080000000800000FFFFFF00FFFFFF0000800000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      0000840000007B7B7B0000000000000000000000000000000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000800000FFFFFF00FFFFFF0000800000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      000084000000000000000000000000000000000000000000000000FFFF00FF00
      0000FF000000FF000000000000000000000000000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF00000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000800000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF0000000000FF0084000000840000008400
      00007B7B7B00000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF0000000000000000000000000000FFFFFF00FFFF
      FF0000800000FFFFFF00FFFFFF0000800000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF0000000000FF0084000000840000008400
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000000000000000000000000000000000FFFFFF00FFFF
      FF0000800000FFFFFF00FFFFFF000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000FF0084000000840000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00C0C0C0000080000000800000008000000080000000800000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000FF0084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000FF000000FF00000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000080000000800000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000FF00840000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF00000000FFFF0000000000000000000000000000000000000000000000
      000000FF000000FF000000FF000000FF000000FF000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000800000FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000FF0084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      000000FFFF000000000000000000000000000000000000000000000000000000
      000000FF000000FF000000FF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF00FF000000FF00000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000FF008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000008484000084
      840000FFFF00FF00FF0000FFFF0000FFFF00FF00FF00FF00FF00FF00FF000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484008400000084840000848400008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084840000FFFF0000008484000084
      8400FFFF0000FFFF000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000FF00840000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000848400FFFF0000848400008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF0000FFFF00000084840000FFFF0000FF
      FF0000FFFF00FFFF0000FF000000000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF008400000084000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000848400C6C6
      C600C6C6C600C6C6C600C6C6C600008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00000000000000848400FFFFFF00C6C6C6000084840084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF00000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00FFFF0000000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF0084000000840000007B7B7B000000
      0000000000000000000000000000000000000000000000FFFF0000848400C6C6
      C600008484000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00FF00FF000084840000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00C6C6C6008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      00008484000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000FF008400000084000000840000000000
      0000000000000000000000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000000000000000000000000000000000000000
      000000848400FFFFFF00C6C6C600000000008400000084840000848400008484
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000084840000FFFF00000084840000FFFF0000FFFF0000FF
      FF00FFFF00000084840000000000000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000FF008400000084000000840000007B7B
      7B00000000000000000000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000000000C6C6C600008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000848400008484000000
      0000FFFFFF00C6C6C60000848400000000000000000000000000840000008484
      0000848400000000000000000000000000000000000000000000000000000000
      00000000000084840000FFFF00000084840000FFFF0000FFFF0000FFFF0000FF
      FF00FFFF0000FFFF00000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000000000000000000000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000000000000000000000848400C6C6C6000084
      8400FFFFFF00C6C6C6000000000084000000840000000000000000000000FFFF
      0000848400008400000000000000000000000000000000000000000000000000
      000084840000FFFF00000084840000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00FFFF00000084840000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      00007B7B7B000000000000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000FFFF0000FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000000000000000000000848400C6C6C600FFFF
      FF00FFFFFF000084840000848400008484008484000000000000000000008400
      0000FFFF00008484000084000000000000000000000000000000000000008484
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF000000848400000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000840000000000000000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400C6C6C600FFFF
      FF00FFFFFF00C6C6C60000848400FFFF00008484000000000000000000008400
      0000FFFF00008484000084000000000000000000000000000000000000000000
      000084840000FFFF00000084840000FFFF0000FFFF0000FFFF0000FFFF00FFFF
      0000008484000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000840000007B7B7B0000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FF00FF000000
      0000000000000000000000000000000000000000000000848400C6C6C600C6C6
      C600C6C6C600000000008400000084840000FFFF00008484000084000000FFFF
      0000FFFF00008400000000000000000000000000000000000000000000008484
      0000FFFF0000FFFF000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008400
      00000084840000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000000000000000FF000000000084000000840000008400
      0000840000008400000000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000848400C6C6C6000084
      84000000000000000000000000008400000084840000FFFF0000FFFF00008484
      000084840000840000000000000000000000000000000000000084840000FFFF
      0000FFFF00008400000084000000840000008400000084000000840000008400
      00008484000000000000000000000000000000000000FF000000FF000000FF00
      00000000000000000000000000000000FF0000000000000000007B7B7B008400
      000084000000840000007B7B7B00000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00FF00FF00FF00FF0000FFFF00FF00FF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000000000000000000000000000000000000000000084840000848400008484
      0000848400008484000084840000848400008484000084840000848400008484
      000084840000000000000000000000000000FF000000FF000000FF0000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000840000008400000084000000000000000000000000FFFF00008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000007B7B7B0084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF000000000000000000000000000000000000FFFF00000000FF000000
      FF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000C6C6
      C60000000000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6
      C6000000000000000000000000000000000000000000C6C6C60000000000C6C6
      C60000000000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6
      C6000000000000000000000000000000000000000000C6C6C600000000000000
      FF000000FF00C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C6000000FF000000FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF0000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000008400
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF00008400000000FFFF0000FFFF000000FF000000
      FF00FFFF0000FFFF000000000000000000000000000000000000FFFF0000FFFF
      0000FFFF00000000FF000000FF00FFFF0000FFFF0000FFFF00000000FF000000
      FF00FFFF0000FFFF000000000000000000000000000000000000000000008400
      0000840000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFF00000000
      0000000000000000000084000000FF0000008400000000FFFF0000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000FFFF00000000
      000000000000000000000000FF0000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000840000008484
      0000840000008400000084000000840000008400000084000000840000008484
      0000840000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000FFFF0000C6C6
      C600C6C6C60084000000FF00000084000000FF000000FF00000000FFFF0000FF
      FF00C6C6C600C6C6C60000000000000000000000000000000000FFFF0000C6C6
      C600C6C6C600C6C6C600C6C6C6000000FF000000FF000000FF00C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000000000008400000084000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000840000000000000000000000000000000000000000FFFF0000FF
      FF00008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000FF000000FF000000FF000000FF000000FF000000FF0000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000000084840000FFFF
      0000848400008484000084840000848400008484000084840000848400008484
      0000FFFF0000840000000000000000000000000000000000000000FFFF0000FF
      FF0000FFFF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000008400
      0000FF000000FF000000FF000000FF000000FF000000FF00000084000000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000FFFF00000000FF000000FF000000FF000000FF00FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000840000008484
      0000840000008400000084000000840000008400000084000000840000008484
      00008400000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF0000000000000000000000FF00000000000000
      00000000000000000000C6C6C600000000000000000000000000000000008400
      0000840000000000000000000000000000000000000000000000000000008400
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000848400C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000084000000FF000000FF00
      000084000000FF000000FF000000FF000000FF000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000FF000000
      FF000000FF00C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000FF00C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000084
      84000000000000000000000000000000000084000000FF000000FF0000008400
      0000FF000000FF000000FF000000FF0000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0084000000840000008400000084000000840000008400
      000084000000840000008400000084000000FF000000FF00000084000000FF00
      0000FF000000FF000000FF000000840000008400000084000000840000008400
      0000840000008400000084000000840000000000000000000000000000008400
      0000840000008400000084000000840000008400000084000000840000000000
      FF00840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF0000FFFF0000FFFF0000848400000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF00000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000848400000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF0000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000BF7CFC00FFFF80038F78CC00F7FF8003
      C7608400F1FF8003C1418400F0FF8003E0018400F07F8003E0038400F01F8003
      F003C3FFF00F8003F007C11FF0078003F807E00FF0018003F80FE003F0038003
      FC0FF001F00F8003FC1FFC01F01F8003FE1FFF03F07F8003FE3FFF07F1FF8007
      FF3FFF0FF7FF800FFF7FFFFFFFFF801FFFFFFFFFFFFFFEFFF00FFFFFFFCFFE7F
      F00FFDFFFF07FC7FC00FFC0FFE03FC3F800FF80FFC01F83F8003F81FF001F81F
      8003F00FE001F01F8003F107FC03F00F800381C7F803E00F80038263E001E007
      80038061C001C007800F8061E007C003800F8403C0078283800F8E0380078EC1
      800FBF0F00071EF19FFFFFFFFFFF7EF9000380030003FFFF000300030003FFFF
      000300030003FFFF0003000300033FF900010001000177EDC001C001C00167ED
      8001C001C00140058001C001C0010001C000C000C0004001C000E000E0004005
      0000C000E00067ED00008000C00077FDE0000000C0003FF9E0000000E000FFFF
      E1FF01FFFFFFFFFFF1FF03FFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object MainImages: TImageList
    Left = 120
    Top = 252
    Bitmap = {
      494C010128002C00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000040000000B0000000010020000000000000B0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000000000000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000000000000000000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000FFFF0000FFFF
      0000FFFF00000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000000000000840000008400000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084840000FFFF0000008484000084
      8400FFFF0000FFFF000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000084000000840000008400000084
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFF0000FFFF00000084840000FFFF0000FF
      FF0000FFFF00FFFF0000FF000000000000000000000000000000000084000000
      840000FFFF00000000000000000000000000000000000000000084000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000000000000084000000840000008400000084
      0000008400000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000840000008400000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF00000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00FFFF0000000000000000000000000000000084000000
      840000FFFF00000000000000000000000000000000008400000084000000FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      84000000840000FFFF0000000000008400000084000000840000000000000084
      00000084000000000000000000000000000000000000C6C6C600C6C6C6000000
      84000000840000FFFF00840000008400000084000000C6C6C600000000008400
      0000840000000000FF000000FF00000000000000000000000000000000000000
      00008484000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000000000000000000000000000000084000000
      840000FFFF000000000000000000000000008400000084000000840000008400
      0000FFFF0000FFFF0000FFFF00000000000000000000C6C6C600C6C6C6000000
      84000000840000FFFF00008400000084000000840000C6C6C600000000000000
      0000008400000084000000000000000000000000000000000000000000000000
      0000000000000000000084000000840000000000000000FFFF00000000000000
      000084000000840000000000FF00000000000000000000000000000000000000
      0000000000000000000084840000FFFF00000084840000FFFF0000FFFF0000FF
      FF00FFFF00000084840000000000000000000000000000000000000084000000
      840000FFFF000000000000000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000008400000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000840000008400000084000000000000000000000000000000000000000000
      00000000000084840000FFFF00000084840000FFFF0000FFFF0000FFFF0000FF
      FF00FFFF0000FFFF000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000084000000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000FF000000
      FF000000FF008400000084000000840000000000000000000000000000000000
      000084840000FFFF00000084840000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00FFFF00000084840000000000C6C6C600C6C6C600000084000000
      840000FFFF00C6C6C600C6C6C600C6C6C60000FFFF0084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000FF000000
      FF000000FF000000FF0000840000008400000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000FF000000
      FF000000FF000000FF0084000000840000000000000000000000000000008484
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF000000848400000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF000000FF000000
      FF000000FF000000FF000000FF00008400000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF00840000000000000000000000000000000000
      000084840000FFFF00000084840000FFFF0000FFFF0000FFFF0000FFFF00FFFF
      0000008484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000008484
      0000FFFF0000FFFF000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF008400
      0000008484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF0000000000000000000000000084840000FFFF
      0000FFFF00008400000084000000840000008400000084000000840000008400
      0000848400000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000084840000848400008484
      0000848400008484000084840000848400008484000084840000848400008484
      0000848400000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000084848400FFFF0000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000008484000084840000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000C6C6C60000000000000000000000000084848400FFFF0000FFFF
      0000FFFF0000FFFF0000C6C6C600C6C6C600C6C6C600C6C6C600008484000084
      8400008484000084840000848400008484000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000008484000084840000FFFF0000FFFF0000FFFF00008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF00FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000000000000C6C6C60000000000000000000000000084848400FFFF00000084
      840000848400FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000848400FFFF
      0000FFFF0000FFFF000000848400008484000000000000000000000084000000
      840000FFFF00000000000000000000000000000000000000000000000000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000000084
      84000084840000FFFF0000FFFF0084000000840000000084840000FFFF000084
      8400000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFF0000FFFF
      000000000000C6C6C60000000000000000000000000084848400FFFF00000000
      000000000000FFFF0000008484000084840000848400FFFF0000008484000084
      8400008484000084840000848400008484000000000000000000000084000000
      840000FFFF00000000000000000000000000000000000000000000000000FFFF
      000084000000FFFF0000000000000000000084000000008484000084840000FF
      FF0000FFFF008400000084840000C6C6C600C6C6C600840000000084840000FF
      FF00008484000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FFFF
      000000000000C6C6C60000000000000000000000000084848400FFFF00000000
      000000000000FFFF0000000000000000000000000000FFFF0000008484000084
      8400008484000084840000848400008484000000000000000000000084000000
      840000FFFF00000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF
      00008400000084000000FFFF0000000000008400000000FFFF0000FFFF008400
      00008484000084840000848400008484000084840000C6C6C600840000000084
      840000FFFF000084840000000000000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000C6C6C6000000000000000000000000000000000084848400848484000000
      000000000000FFFF0000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000000000000000084000000
      840000FFFF000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000FFFF00008400000084000000840000008484
      0000848400008484000000FFFF00848400008484000084840000C6C6C6008400
      00000084840000FFFF0000848400000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084840000848400008484
      0000848400008484000000FFFF0084840000848400008484000084840000C6C6
      C600840000000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000000000000000000084000000FFFF0000C6C6
      C6008484000084840000848400008484000000FFFF0000FFFF00848400008484
      0000C6C6C6008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000008400
      000084000000840000000000000000000000000000000000000084000000FFFF
      0000C6C6C6008484000084840000848400008484000000FFFF0000FFFF0000FF
      FF0084840000C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000000000C6C6
      C600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000000000000000000000000000000084000000
      840000FFFF000000000000000000000000000000000000000000000000008400
      0000840000000000000000000000000000000000000000000000000000008400
      0000C6C6C600C6C6C6008484000000FFFF00848400008484000000FFFF0000FF
      FF008484000084840000C6C6C600000000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600000000000000000000000000C6C6C600C6C6C600000084000000
      840000FFFF00C6C6C600C6C6C600C6C6C600C6C6C60000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000084000000C6C6C600C6C6C6008484000000FFFF0000FFFF0000FFFF008484
      0000C6C6C600FFFF000084840000840000000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000C6C6C600000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000C6C6C600C6C6C6008484000084840000C6C6C600FFFF
      0000848400008400000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000C6C6C600000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      0000C6C6C6000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084000000C6C6C600C6C6C600C6C6C600848400008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000C6C6C600000000000000000000000000C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000000000C6C6C600000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000000000008484840084848400848484008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C60000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF00FFFFFF0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF00FFFFFF0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF00000000000000000000000000FFFF
      FF00000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF00FFFFFF0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF000000
      8400000084000000840000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF00FFFFFF0000000000FFFF
      FF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFFFF000000
      8400000084000000840000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000FFFF000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C60000FFFF00FFFFFF0084848400FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFFFF0000FFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF00000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600C6C6C600C6C6C60000FFFF00FFFFFF0000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFFFF0000FFFF00000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000FFFF00000000000000000000000000000000000000
      000000FFFF00000000000000000000000000000000000000000000FFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000FFFF00000000000000000000000000000000000000
      000000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00848484000000000000000000000000000000
      00000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C6000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000848400000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000FFFF0000FFFF000084840000000000000000000000000000000000FFFF
      00000000000000000000000000000000000000008400FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000FFFF0000FFFF000084840000000000C6C6C600C6C6C600C6C6C600FFFF
      0000FFFF0000C6C6C600C6C6C6000000000000008400FFFFFF00848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084000000FFFFFF00848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600FFFFFF00FFFFFF00C6C6
      C600C6C6C600C6C6C600FFFFFF00FFFFFF000000000000000000000000000000
      000000FFFF0000FFFF000084840000000000000000000000000000000000FFFF
      000084000000FFFF0000000000000000000000008400FFFFFF00848484008484
      840084848400848484000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000084000000FFFFFF00848484008484
      84008484840084848400FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF008484840084000000FF000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000FFFF0000FFFF000084840000000000FFFF0000FFFF0000FFFF0000FFFF
      00008400000084000000FFFF00000000000000008400FFFFFF00848484008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000000084000000FFFFFF00848484008484
      84008484840000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF00000000000000FFFFFF00C6C6C600C6C6C6008400
      000084848400C6C6C6008484840084000000C6C6C600FFFFFF00FFFFFF00C6C6
      C600C6C6C600C6C6C600FFFFFF00FFFFFF000000000000000000000000000000
      000000FFFF0000FFFF0000848400000000008400000084000000840000008400
      0000840000008400000084000000FFFF000000008400FFFFFF00848484008484
      84008484840000FFFF0000848400FFFFFF00FFFFFF00FFFFFF00848484000000
      FF000000FF00FFFFFF000000FF000000000084000000FFFFFF00848484008484
      84008484840000FFFF0000848400FFFFFF00FFFFFF00FFFFFF0084848400FF00
      0000FF000000FFFFFF00FF00000000000000FFFFFF00FFFFFF00FFFFFF008484
      8400C6C6C600FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000FFFF0000FFFF0000848400000000008400000084000000840000008400
      00008400000084000000840000008400000000008400FFFFFF00848484008484
      8400848484008484840000000000FFFFFF000000840000008400000084000000
      8400C6C6C600FFFFFF000000FF000000000084000000FFFFFF00848484008484
      8400848484008484840000000000FFFFFF008400000084000000840000008400
      0000C6C6C600FFFFFF00FF00000000000000FFFFFF00C6C6C600C6C6C6008400
      0000C6C6C600C6C6C600C6C6C60084000000C6C6C600FFFFFF00FFFFFF00C6C6
      C600C6C6C600C6C6C600FFFFFF00FFFFFF000000000000000000000000000000
      000000FFFF0000FFFF000084840000000000000000000000000000000000FF00
      00008400000084000000840000000000000000008400FFFFFF00848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000000084000000FFFFFF00848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FF0000008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000000FF
      FF0000FFFF0000FFFF0000FFFF0000848400C6C6C600C6C6C600C6C6C600FF00
      00008400000084000000000000000000000000008400FFFFFF00848484008484
      84008484840084848400FFFFFF00FFFFFF000000840000008400000084000000
      8400C6C6C600FFFFFF000000FF000000000084000000FFFFFF00848484008484
      84008484840084848400FFFFFF00FFFFFF008400000084000000840000008400
      0000C6C6C600FFFFFF00FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF00008484000000000000000000FF00
      00008400000000000000000000000000000000008400FFFFFF00848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000000084000000FFFFFF00848484008484
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000FFFF0000FF
      FF00008484000000000000FFFF0000FFFF0000848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C6000000000000008400FFFFFF00848484008484
      84008484840000000000FFFFFF00FFFFFF000000840000008400000084000000
      8400C6C6C600FFFFFF000000FF000000000084000000FFFFFF00848484008484
      84008484840000000000FFFFFF00FFFFFF008400000084000000840000008400
      0000C6C6C600FFFFFF00FF000000000000000000000000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000000000000000000000FFFF000084
      840000000000000000000000000000FFFF000084840000000000000000000000
      00000000000000000000000000000000000000008400FFFFFF00848484008484
      84008484840000FFFF0000848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF000000000084000000FFFFFF00848484008484
      84008484840000FFFF0000848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF00000000000000FFFFFF0000000000FFFFFF000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF0000000000FFFFFF000000000000000000000000000000000000FFFF000084
      840000000000000000000000000000FFFF00008484000000000000000000C6C6
      C600C6C6C600C6C6C60000000000000000000000840000008400848484008484
      8400848484008484840000000000FFFFFF000000840000008400000084000000
      8400C6C6C600FFFFFF000000FF00000000008400000084000000848484008484
      8400848484008484840000000000FFFFFF008400000084000000840000008400
      0000C6C6C600FFFFFF00FF0000000000000000000000FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF000000000000000000FFFFFF00000000000000000000000000000000000084
      8400000000000000000000000000008484000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600000000000000000000000000000084000000
      84008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000FF00000000000000000000000000840000008400
      00008484840084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FF00000000000000FFFFFF0000000000FFFFFF000000
      0000FFFFFF0000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000008400000084000000840000008400000084000000
      8400000084000000840000008400C6C6C6000000000000000000000000000000
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000C6C6C6000000000000000000FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000FF000000FF00000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      840084848400848484000000000000000000000000000084840084840000FFFF
      0000FFFF0000FFFF0000FFFF0000FF000000FF00000084848400FFFF0000FFFF
      0000FFFF0000FFFF000084840000848400000000000000000000000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000084848400000000000000
      0000000000000000000084848400C6C6C6000000000000848400FFFF00008484
      84008484840084848400FFFF0000FF000000FF00000084848400FFFF00008484
      84008484840084848400FFFF0000848400000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF000084840000000000000000000000000000000000000000000000FF000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60000000000000000008484
      8400000000008484840084848400C6C6C6000000000000848400FFFF0000C6C6
      C600FFFFFF0084848400FFFF0000FF000000FF00000084848400FFFF0000C6C6
      C600FFFFFF0084848400FFFF0000848400000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000848400000000000000000000000000000000000000FF000000FF000000
      FF0000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C60084848400848484008484
      8400848484008484840084848400C6C6C6000000000000848400FFFF0000C6C6
      C600C6C6C60084848400FFFF0000FF000000FF00000084848400FFFF0000C6C6
      C600C6C6C60084848400FFFF0000848400000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF00008484000000000000000000000000000000FF000000FF00000000000000
      FF0000000000000000000000000000000000C6C6C60000000000000000000000
      000000000000C6C6C60000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000848400FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000848400000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000848400000000000000000000000000000000000000000084000000FFFF
      00000000FF00000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600848484008484
      84008484840084848400C6C6C600C6C6C6000000000000848400FFFF00008484
      84008484840084848400FFFF0000848484008484840084848400FFFF00008484
      84008484840084848400FFFF00008484000000000000000000000000FF000000
      FF000000FF000000FF00000000000000FF000000FF000000FF00000000000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF0000848400000000000000000000000000000000008400000084000000FFFF
      0000000000000000FF000000000000000000C6C6C6000000000000000000C6C6
      C60000000000000000000000000000000000C6C6C60000000000000000000000
      000000000000C6C6C60000000000000000000000000000848400FFFF0000C6C6
      C600FFFFFF0084848400FFFF0000C6C6C600FFFFFF0084848400FFFF0000C6C6
      C600FFFFFF0084848400FFFF000084840000000000000000FF000000FF000000
      FF000000FF000000000000000000000000000000FF000000FF000000FF000000
      000000000000000000000000000000000000000000000000000000FFFF0000FF
      FF00008484000000000000000000000000008400000084000000840000008400
      0000FFFF0000FFFF0000FFFF000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600000000000084840084840000C6C6
      C600C6C6C60084848400FFFF0000C6C6C600C6C6C60084848400FFFF0000C6C6
      C600C6C6C600848484008484000084840000000000000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000840000008400000084000000840000008400
      000084000000840000008400000000000000C6C6C60000000000000000000000
      00000000000000000000C6C6C600000000000000000000000000000000000000
      0000C6C6C6000000000000000000000000000000000000848400848400008484
      0000848400008484000084840000848400008484000084840000848400008484
      000084840000848400008484000084840000000000000000FF000000FF000000
      FF0000000000000000000000000000000000000000000000FF000000FF000000
      FF000000000000000000000000000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000848400008484008400000084000000840000008400
      000084000000840000008400000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF0000000000000000000000000000FFFF0000FFFF00008484000000
      000000FFFF0000FFFF0000848400008484000000000084000000840000008400
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C6000000000000840000008400000084
      0000008400000084000000840000008400000084000000840000008400000084
      0000008400000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF00000000000000000000FFFF0000848400000000000000
      00000000000000FFFF0000848400008484000000000000000000840000008400
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C6000000000000000000000000000084
      0000008400000084000000840000008400000084000000840000008400000000
      0000000000008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF00000000000000000000FFFF0000848400000000000000
      00000000000000FFFF0000848400008484000000000000000000000000008400
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      00000000000000000000C6C6C6000000000000000000C6C6C600C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000084000000840000008400000084000000000000000000008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000848400000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6C600C6C6
      C60000000000C6C6C600C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000008400000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C60000000000C6C6C600C6C6C60000000000C6C6C60000000000C6C6C6000000
      00000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6C6C600C6C6C600C6C6C6008484
      8400848484008484840084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C6000000000000000000000000000000000000000000C6C6C600008484000084
      8400848484008484840084848400008484000084840000FFFF00C6C6C6000084
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400000000000000000000000000C6C6C600C6C6C600848484008484
      840084848400848484008484840084848400C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600008484000084
      8400000000000000000084848400008484000084840000848400C6C6C6000084
      840000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000000000000000000000000000000000000000000000000000FFFF
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00008484840000000000000000000000000000000000C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C6000000000000000000000000000000000000000000C6C6C600008484000084
      84000084840000848400008484000084840000FFFF0000FFFF00C6C6C6000084
      8400000000000000000000000000000000000000000000000000FFFF0000FFFF
      0000000000008484000084840000848400008484000084840000848400000000
      0000FFFF0000FFFF000000000000000000000000000000000000000000008484
      8400FFFF0000000000000000000000000000FFFF00000000000000000000FFFF
      000084848400000000000000000000000000C6C6C600C6C6C600848484008484
      840084848400848484008484840084848400C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C60000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000084
      8400000000000000000000000000000000000000000000000000FFFF00000000
      0000848400008484000084840000848400008484000084840000848400008484
      000000000000FFFF000000000000000000000000000000000000000000008484
      8400FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00008484840000000000000000000000000000000000C6C6C600848484000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000848400008484000084
      8400008484000084840000848400008484000084840000848400008484000084
      84000000000000000000000000000000000000000000FFFF0000000000008484
      0000000000008484000000000000848400008484000000000000000000008484
      00008484000000000000FFFF0000000000000000000000000000000000008484
      8400FFFF00000000000000000000FFFF0000000000000000000000000000FFFF
      000084848400000000000000000000000000C6C6C600C6C6C600C6C6C6008484
      8400848484008484840084848400C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84000000000000000000000000000000000000000000FFFF0000000000008484
      0000000000000000000000000000848400000000000084840000848400000000
      00008484000000000000FFFF0000000000000000000000000000000000008484
      8400FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      00008484840000000000000000000000000000000000C6C6C600C6C6C6000000
      0000000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      84008484840000000000000000000000000000000000FFFF0000000000008484
      0000000000008484000000000000848400000000000084840000848400000000
      00008484000000000000FFFF0000000000000000000000000000000000008484
      8400FFFF000000000000000000000000000000000000FFFF000000000000FFFF
      000084848400000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000848400008484
      0000848400008484000084840000848400008484000084840000848400008484
      00008484000000000000000000000000000000000000FFFF0000000000008484
      0000000000008484000000000000848400000000000084840000848400000000
      00008484000000000000FFFF0000000000000000000000000000000000008484
      8400FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      000084848400000000000000000000000000C6C6C60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6000000000000000000848400008484
      0000848400008484000084848400848484008484840084840000848400008484
      00008484000000000000000000000000000000000000FFFF0000000000008484
      0000848400000000000084840000848400008484000000000000000000008484
      00008484000000000000FFFF0000000000000000000000000000000000008484
      8400FFFF00000000000000000000FFFF00008484840084848400848484008484
      840084848400000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C6000000000000000000848400008484
      0000848400008484000000000000000000008484840084840000848400008484
      0000848400000000000000000000000000000000000000000000FFFF00000000
      0000848400008484000084840000848400008484000084840000848400008484
      000000000000FFFF000000000000000000000000000000000000000000008484
      8400FFFF0000FFFF0000FFFF0000FFFF000084848400C6C6C600C6C6C6008484
      84000000000000000000000000000000000000000000C6C6C60000000000C6C6
      C60000000000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6
      C60000000000C6C6C60000000000C6C6C6000000000000000000848400008484
      0000848400008484000084840000848400008484000084840000848400008484
      0000848400000000000000000000000000000000000000000000FFFF0000FFFF
      0000000000008484000084840000848400008484000084840000848400000000
      0000FFFF0000FFFF000000000000000000000000000000000000000000008484
      8400FFFF000000000000FFFF00000000000084848400C6C6C600848484000000
      00000000000000000000000000000000000000000000C6C6C60000000000C6C6
      C60000000000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6
      C60000000000C6C6C60000000000C6C6C6000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484000000000000000000000000000000000000000000FFFF
      0000FFFF0000000000000000000000000000000000000000000000000000FFFF
      0000FFFF00000000000000000000000000000000000000000000000000008484
      8400FFFF0000FFFF0000FFFF0000FFFF00008484840084848400000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000C6C6C600C6C6
      C60000000000C6C6C60000000000C6C6C6000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000C6C6
      C60000000000C6C6C60000000000C6C6C60000000000C6C6C60000000000C6C6
      C600C6C6C6000000000000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C6C6C60000000000C6C6
      C600C6C6C6000000000000000000C6C6C60000000000C6C6C60000000000C6C6
      C600C6C6C600C6C6C60000000000C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000084
      8400008484000000000000000000000000000000000084848400848484000000
      000000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF00000000000000000000000000000000000000C6C6
      C600000000000000000000000000C6C6C6000000000000000000C6C6C6000000
      00000000000000000000C6C6C600C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000008484008484
      8400000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FFFF0000FF0000000000000000848400008484000000
      0000C6C6C600C6C6C600848484000000000000FFFF0000FFFF0000000000FF00
      0000FF0000008400000000000000000000000000000000000000840000008400
      0000C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600840000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000084840000000000000000000084840000000000000000000084
      84000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFF000000000000FFFF00000000000000848400008484000000
      0000C6C6C600C6C6C600848484000000000000FFFF0000FFFF0000000000FF00
      0000FF0000008400000084000000000000000000000084000000840000008400
      0000000084000000840084848400848484008484840084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FFFF0000FFFF0000FF0000000000000000848400008484000000
      0000C6C6C600C6C6C600848484000000000000FFFF0000FFFF0000000000FF00
      0000FF0000008400000084000000000000008400000084000000840000000000
      FF000000FF0000008400C6C6C600C6C6C600C6C6C60084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000084840000000000008484000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000000000000000
      0000FF000000FFFF000000000000FFFF00000000000000000000FFFF00000000
      00000000000000000000FFFF0000FF0000000000000000848400008484000000
      0000C6C6C600C6C6C600848484000000000000FFFF0000FFFF0000000000FF00
      0000FF0000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000000084
      840000000000000000000000000000000000FF00000000000000000000000000
      0000FF000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FF0000000000000000848400008484000000
      0000C6C6C600C6C6C600848484000000000000FFFF0000FFFF0000000000FF00
      0000FF0000008400000084000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000840000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000084840000000000000000000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FF000000FFFF00000000000000000000000000000000000000000000FFFF
      00000000000000000000FFFF0000FF0000000000000000848400008484000000
      0000C6C6C600C6C6C600848484000000000000FFFF0000FFFF0000000000FF00
      0000FF0000008400000084000000000000000000000000000000000000008484
      8400FFFFFF00848484008484840084848400FFFFFF00FFFFFF00000000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000084840000000000000000008484
      840000000000000000000000000000000000000000000000000000000000FF00
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FF000000000000000000000000848400008484000000
      0000C6C6C600C6C6C600848484000000000000FFFF0000FFFF0000000000FF00
      0000FF0000008400000084000000000000000000000000000000000000008484
      8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840000000000000000000000000000000000000000000000000000000000FF00
      0000FFFF0000000000000000000000000000FFFF000000000000000000000000
      000000000000FFFF0000FF000000000000000000000000848400008484000000
      0000C6C6C600C6C6C6008484840084848400000000000000000000000000FF00
      0000FF0000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000008484000084840000000000000000008484
      840000000000000000000000000000000000000000000000000000000000FF00
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FF000000000000000000000000848400008484000000
      00000000000000000000848484008484840084848400C6C6C600000000000000
      0000FF0000008400000084000000000000000000000000000000000000000000
      000000000000848484008484840084848400848484008484840084848400FFFF
      FF00FFFFFF00C6C6C60084000000840000000000000000000000000000000000
      0000000000000000000000848400000000000084840000000000000000008484
      840000000000000000000000000000000000000000000000000000000000FF00
      0000FFFF000000000000000000000000000000000000FFFF0000000000000000
      000000000000FFFF0000FF000000000000000000000000848400008484000000
      000000000000C6C6C600C6C6C600848484008484840000000000C6C6C600FF00
      0000FF0000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00C6C6C600840000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000084
      8400848484008484840000000000000000000000000000000000FF000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FF00000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600C6C6C6008484840000000000C6C6C6000000
      0000000000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400848484008484
      840084848400FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000084840084848400000000000000000000000000FF000000FFFF
      000000000000000000000000000000000000FFFF000000000000000000000000
      0000FFFF0000FF000000FF000000FF00000000000000C6C6C600C6C6C600C6C6
      C600000000000000000000000000C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000084848400000000000000000000000000FF000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FF000000FF000000FF0000000000000000000000C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      000000000000000000008484840000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000000000000000000000000000C6C6
      C60084848400C6C6C60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      000000000000000000007B7B7B00840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000008400000084000000840000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF0000000000000000000000000000000000FF0000000000000000007B7B
      7B008400000084000000840000007B7B7B000000000000848400000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400000000000000000084848400C6C6C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000FF0000000000840000008400
      0000840000008400000084000000000000000084840000FFFF00008484000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484000000000084848400C6C6C6008484840000000000848484008484
      840084848400000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      000084000000840000007B7B7B0000000000848400000084840000FFFF000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400C6C6C60084848400C6C6C600C6C6C600C6C6C60084848400C6C6C600C6C6
      C60000000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      00008400000084000000000000000000000000000000848400000084840000FF
      FF00008484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600C6C6C600000000000000000000000000C6C6C600C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      0000840000007B7B7B0000000000000000000000000000000000848400000084
      840000FFFF000084840000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFF00000000000000000000C6C6C6000000000000000000C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF0000000000FF0084000000840000008400
      0000840000000000000000000000000000000000000000000000000000008484
      00000084840000FFFF0000848400000000008484840000000000000000008484
      8400000000008484840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008484840084848400C6C6
      C600FFFF000000000000FFFF0000FFFF0000FFFF000000000000C6C6C600C6C6
      C600848484008484840000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF0000000000FF0084000000840000008400
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000848400000084840000FFFF00008484000000000084848400000000008484
      8400000000000000000084848400000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000084848400000000008484840000000000000000008484840084848400C6C6
      C600FFFF000000000000FFFF0000FFFF0000FFFF000000000000C6C6C600C6C6
      C600848484008484840000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF0000000000FF0084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000848400000084840000FFFF000084840000848400000000000000
      0000848484008484840000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400FFFF00000000000000000000FFFF00000000000000000000C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000FF0084000000840000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848400000084840000FFFF000000000000000000C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400C6C6C600FFFF0000000000000000000000000000C6C6C600C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF0000000000FF0084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000084840000000000000000000084848400C6C6
      C600000000000084840000000000000000000000000000848400840000008400
      0000840000008400000000848400840000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000FF00840000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000C6C6C6008484
      8400008484000084840000000000000000000000000000000000008484008400
      0000840000000084840000000000000000008400000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600848484008484840084848400C6C6C600848484008484840084848400C6C6
      C600848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF0000000000FF0084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000008484840000000000C6C6C600848484000000
      0000008484000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000008400000084000000840000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000000000000000000000C6C6C6000000000000000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008484840000000000C6C6C60084000000000000000084
      8400000000000000000000000000000000000000000000000000000000008400
      0000840000000084840000000000000000000084840084000000008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF007B7B7B0000000000000000000000
      00000000000000000000000000000000000000848400C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400848484008484
      840084848400FFFFFF0000000000000000000000000000000000000000000000
      000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000FF008400000000000000000000000000
      00000000000000000000000000000000000000848400C6C6C600C6C6C60000FF
      FF0000FFFF0000FFFF0000FFFF00848484000000000000000000FF0000000000
      000000000000FFFFFF0000000000000000000000000000000000008484000084
      840000FFFF00FF00FF0000FFFF0000FFFF00FF00FF00FF00FF00FF00FF000084
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF0000000000FF00840000007B7B7B00000000000000
      00000000000000000000000000000000000000848400C6C6C600C6C6C60000FF
      FF00C6C6C600C6C6C600C6C6C6008484840000000000FF000000FF0000000000
      000000000000FFFFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000084
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000084840084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF008400000084000000000000000000
      00000000000000000000000000000000000000848400C6C6C600C6C6C60000FF
      FF0000FFFF0000FFFF0000FFFF0084848400FF000000FF000000FF0000000000
      000000000000C6C6C60000000000000000000000000000FFFF0000848400C6C6
      C600C6C6C600C6C6C600C6C6C600008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000000000000000000000
      00000000000000848400FFFFFF00FFFFFF000084840084000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF0000000000FF0084000000840000007B7B7B000000
      00000000000000000000000000000000000000848400C6C6C600C6C6C60000FF
      FF00C6C6C600C6C6C600C6C6C600FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000FFFF0000848400C6C6
      C600008484000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00FF00FF000084840000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000FF008400000084000000840000000000
      00000000000000000000000000000000000000848400C6C6C600C6C6C60000FF
      FF0000FFFF0000FFFF00FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000000000000000000000000000000000000000
      000000848400FFFFFF00FFFFFF00000000008400000084000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF0000000000FF008400000084000000840000007B7B
      7B000000000000000000000000000000000000848400C6C6C60000FFFF0000FF
      FF0000FFFF00FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000000000C6C6C600008484000084840000848400008484000084
      8400008484000084840000000000000000000000000000848400008484000000
      0000FFFFFF00FFFFFF0000848400000000000000000000000000840000008400
      000084000000000000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      00000000000000000000000000000000000000848400C6C6C60000FFFF00C6C6
      C600C6C6C600C6C6C600FF000000FF000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000FFFF0000848400C6C6
      C60000FFFF000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000000000000000000000848400FFFFFF000084
      8400FFFFFF00FFFFFF0000000000840000008400000000000000000000008400
      000084000000840000000000000000000000000000000000000000000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      00007B7B7B0000000000000000000000000000848400C6C6C60000FFFF0000FF
      FF0000FFFF0000FFFF00C6C6C600FF000000FF000000FF000000FF0000000000
      000000000000C6C6C60000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000FFFF0000FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000084840000000000000000000000000000848400FFFFFF00FFFF
      FF00FFFFFF000084840000848400008484008400000000000000000000008400
      0000840000008400000084000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      00008400000000000000000000000000000000848400C6C6C60000FFFF00C6C6
      C600C6C6C600C6C6C600C6C6C60084848400FF000000FF000000FF0000000000
      000000000000C6C6C60000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000848400840000008400000000000000000000008400
      0000840000008400000084000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF0000000000FF008400000084000000840000008400
      0000840000007B7B7B00000000000000000000848400C6C6C60000FFFF0000FF
      FF0000FFFF00C6C6C600C6C6C6008484840000000000FF000000FF0000000000
      000000000000C6C6C60000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00FF00FF000000
      0000000000000000000000000000000000000000000000848400FFFFFF00FFFF
      FF00FFFFFF000000000084000000840000008400000084000000840000008400
      00008400000084000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000000000000000FF000000000084000000840000008400
      0000840000008400000000000000000000000084840000FFFF00C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484000000000000000000FF0000000000
      000000000000C6C6C60000000000000000000000000000FFFF0000848400C6C6
      C60000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000848400FFFFFF000084
      8400000000000000000000000000840000008400000084000000840000008400
      00008400000084000000000000000000000000000000FF000000FF000000FF00
      00000000000000000000000000000000FF0000000000000000007B7B7B008400
      000084000000840000007B7B7B00000000000084840000848400008484000084
      8400008484000084840000848400008484000084840084848400848484008484
      8400848484008484840000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF00FF00FF00FF00FF0000FFFF00FF00FF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      000000000000000000000000000000000000FF000000FF000000FF0000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000840000008400000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00008484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000000000000000
      00000000000000000000000000000000FF000000000000000000000000000000
      0000000000007B7B7B0084000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF00000084000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000FF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF0000000000000000000000
      00000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF00848484000000000000000000000000000000000000000000000000000000
      000084000000FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0084848400008484000084840000000000000000000000000084000000FF00
      0000FF000000FF000000FF000000FF00000084000000FF000000FF000000FF00
      0000FFFFFF00FFFFFF00FFFFFF00000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF008484840000848400008484000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF00000084000000FF000000FF000000FF000000FF00
      0000FF000000FFFFFF00FFFFFF00000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0084848400008484000084840000000000FF000000FF000000FF000000FF00
      0000FF000000FF00000084000000FF000000FF000000FF000000FF000000FF00
      0000FF00000084000000FFFFFF00000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0084848400008484000084840000000000FF000000FF000000FF000000FF00
      0000FF00000084000000FF000000FF000000FF000000FF000000FF000000FF00
      0000FF0000008400000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0084848400008484000084840000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF00
      0000840000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0084848400008484000084840000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000FF0000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0084848400008484000084840000000000FF00000084000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF000000FF000000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000008484000084
      8400008484000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF008484840000848400008484000000000084000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF000000FF00000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000848400008484000084
      840000848400008484000084840000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000FF0000008400000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF000000FF000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000FF000000FF00
      0000FF000000FF00000084000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000B00000000100010000000000800500000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000C7FFE3FFE3FFFFFF000000000000FFCF
      C7FEE3DFE3DFFF07C7FEE39FE31FFE03C7FEE30FE30FFC01C7CEE307E247F001
      C78EE2278021E001C70080338031FC03C60080318031F803C7008038C000E001
      000EC000E000C001004EE000FF80E007006EFFC0FF80C007807EFFFFFFF18007
      C07FFFFFFFF10007FFFFFFFFFFF1FFFFFE3FE003003FC7FFF81FE00300000000
      E00FE0030000C7E78007E0030000C7E30003E0030000C7010001F0070000C700
      0000F80F8000C7000001FC1FE463C7E18001FC1FE463C7E3C001F80FE477C7E7
      E000F007FC67006FF000F007E463007FF803E0038477007FFC0FE0038C7F807F
      FE3FE0039C7FC07FFFFFE003F87FFFFF00000000FFFFFFFF000000008000FE3F
      000000000000FC1F000000000000FC1F000000000000FE7F000000000000FC3F
      000000000000FC3F000000000000FC3F000000000000FC1F000000000000F20F
      000000000000E107000000000000E187000000000000E007000000000000F00F
      000000000001F81F00000000FFFFFFFFF1FF1FFF1FFF0000F1EF07FF07FF0000
      F101000000000000F1E3000000000000F101000000000000F100000000000000
      F100000000000000F1E1000000000000E003000000000000C067000000000000
      C401000000000000CE7F000000000000CE63000000000000EEC1C000C0000000
      FFFFF000F0000000FFFFFFFFFFFF000000008000FFFFFFFF00008000FCFF0000
      00008000F8FFC7DE00008000F87FC78E00008000F07FC72E00008000E03FC7C6
      00008000C23FC78A00008000871FC700000080008F9F8200000080008F8F0000
      00008000FFC7108E00008000FFE338CE0000E001FFF338EE0000E007FFF1BBFE
      0000E61FFFF9FFFF0000F6A3FFFCFFFF0007FFFFFFFF00000003F81FF0030000
      0001E007E00300000001C003E003000000008001E003000000008001E0030000
      00000000E003000000000000E003000080000000E003000080000000E0030000
      80000000E003000080008001E007000080008001E00F0000C000C003E01F0000
      E000E007E03F0000F000F81FFFFF0000FFFFFFFFFFFFFFFFC79FE0018000C00F
      C38FC0008000C007C30F800080008003E30F000080000001E20F300080008000
      E20F70008000E000E00FF0008000E000E00FE0018000E000E08FE0018000F000
      E00FE0018000F800E10FE0018000FC00E103C0038000FE01F301C0008000FF01
      FF01C000C1FEFF81FF81E000E1FFFFFFBF7CFFFFFFFFF83F8F789FFFFF3FC827
      C7600FFFFF0F8003C14107FFFF0F0001E00107FFFF0F8003E00383FFFB4FC007
      F003C0FFE96F0001F007E063E0610001F807F021E2E10001F80FF800E3770001
      FC0FFC00E0AFC007FC1FFE03806F8003FE1FFF03C36F0001FE3FFE07F71F8003
      FF3FFC0FE31FC827FF7FFC3FF7FFF83FFFFFFFFFFFFFFEFFFFFFF00FFFFFFE7F
      0003F00FFDFFFC7F0003C00FFC0FFC3F0003800FF80FF83F00038003F81FF81F
      00018003F00FF01F00018003F107F00F0001800381C7E00F000180038263E007
      000380038061C0070003800F8061C0030003800F840382830003800F8E038EC1
      0003800FBF0F1EF1FFFF9FFFFFFF7EF9E007FFFFFFFFFFFFF00FFFFFFF80FFFF
      F00FFFFFFE00FFFFF00F8007F8001FFF000F8007E00101FF000080018001001F
      000080010001000000008001000100000000800100030000000080010007E000
      C0008001000FFF80F8008001001FFFFFFC00C001003FFFFFFC07FF01007FFFFF
      FC07FFFF00FFFFFFFC07FFFF01FFFFFF00000000000000000000000000000000
      000000000000}
  end
  object CalculatorDialog: TRxCalculator
    Title = #1050#1072#1083#1100#1082#1091#1083#1103#1090#1086#1088
    Left = 792
    Top = 104
  end
  object PopupMenuControlBar: TPopupMenu
    Left = 160
    Top = 216
    object IsEnumPanelShow: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Checked = True
      OnClick = IsPanelShowClick
    end
    object IsDocPanelShow: TMenuItem
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090#1099
      Checked = True
      OnClick = IsPanelShowClick
    end
    object IsJRPanelShow: TMenuItem
      Caption = #1046#1091#1088#1085#1072#1083#1099
      Checked = True
      OnClick = IsPanelShowClick
    end
    object IsMtrPanelShow: TMenuItem
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1099
      Checked = True
      OnClick = IsPanelShowClick
    end
    object IsSysPanelShow: TMenuItem
      Caption = #1057#1080#1089#1090#1077#1084#1085#1072#1103
      Checked = True
      OnClick = IsPanelShowClick
    end
    object IsToolPanelShow: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
      Checked = True
      OnClick = IsPanelShowClick
    end
    object IsMessWinShow: TMenuItem
      Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1086#1082#1085#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      OnClick = IsPanelShowClick
    end
  end
end
