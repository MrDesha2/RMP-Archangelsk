object CalendarForm: TCalendarForm
  Left = 192
  Top = 160
  BorderStyle = bsToolWindow
  Caption = #1050#1072#1083#1077#1085#1076#1072#1088#1100
  ClientHeight = 271
  ClientWidth = 351
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 216
    Top = 64
    Width = 92
    Height = 13
    Caption = #1047#1085#1072#1095#1077#1085#1080#1077' '#1087#1086' '#1076#1072#1090#1077':'
  end
  object MonthInfo: TLabel
    Left = 216
    Top = 88
    Width = 3
    Height = 13
  end
  object CalPanel: TPanel
    Left = 22
    Top = 16
    Width = 186
    Height = 208
    TabOrder = 0
    object PanelTop: TPanel
      Left = 1
      Top = 1
      Width = 184
      Height = 41
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object ButtonYearMin: TButton
        Left = 6
        Top = 11
        Width = 18
        Height = 22
        Caption = '<<'
        TabOrder = 0
        OnClick = ButtonYearMinClick
      end
      object ButtonMonthMin: TButton
        Left = 23
        Top = 11
        Width = 18
        Height = 22
        Caption = '<'
        TabOrder = 1
        OnClick = ButtonMonthMinClick
      end
      object ButtonMonthPlus: TButton
        Left = 143
        Top = 11
        Width = 18
        Height = 22
        Caption = '>'
        TabOrder = 2
        OnClick = ButtonMonthMinClick
      end
      object ButtonYearPlus: TButton
        Left = 160
        Top = 11
        Width = 17
        Height = 22
        Caption = '>>'
        TabOrder = 3
        OnClick = ButtonYearMinClick
      end
    end
    object PanelBot: TPanel
      Left = 1
      Top = 42
      Width = 184
      Height = 165
      Align = alClient
      TabOrder = 1
      object Label1: TLabel
        Left = 8
        Top = 2
        Width = 170
        Height = 13
        Caption = #1055#1085'  '#1042#1090'   '#1057#1088'   '#1063#1090'   '#1055#1090'   '#1057#1073'  '#1042#1089
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mPanel9: TPanel
        Left = 30
        Top = 41
        Width = 25
        Height = 24
        Caption = '9'
        PopupMenu = PopupMenu
        TabOrder = 0
        OnClick = mPanelClick
      end
      object mPanel8: TPanel
        Left = 5
        Top = 41
        Width = 25
        Height = 24
        Caption = '8'
        PopupMenu = PopupMenu
        TabOrder = 1
        OnClick = mPanelClick
      end
      object mPanel7: TPanel
        Left = 155
        Top = 17
        Width = 25
        Height = 24
        Caption = '7'
        PopupMenu = PopupMenu
        TabOrder = 2
        OnClick = mPanelClick
      end
      object mPanel6: TPanel
        Left = 130
        Top = 17
        Width = 25
        Height = 24
        Caption = '6'
        PopupMenu = PopupMenu
        TabOrder = 3
        OnClick = mPanelClick
      end
      object mPanel5: TPanel
        Left = 105
        Top = 17
        Width = 25
        Height = 24
        Caption = '5'
        PopupMenu = PopupMenu
        TabOrder = 4
        OnClick = mPanelClick
      end
      object mPanel42: TPanel
        Left = 155
        Top = 137
        Width = 25
        Height = 24
        Caption = '42'
        PopupMenu = PopupMenu
        TabOrder = 5
        OnClick = mPanelClick
      end
      object mPanel41: TPanel
        Left = 130
        Top = 137
        Width = 25
        Height = 24
        Caption = '41'
        PopupMenu = PopupMenu
        TabOrder = 6
        OnClick = mPanelClick
      end
      object mPanel40: TPanel
        Left = 105
        Top = 137
        Width = 25
        Height = 24
        Caption = '40'
        PopupMenu = PopupMenu
        TabOrder = 7
        OnClick = mPanelClick
      end
      object mPanel4: TPanel
        Left = 80
        Top = 17
        Width = 25
        Height = 24
        Caption = '4'
        PopupMenu = PopupMenu
        TabOrder = 8
        OnClick = mPanelClick
      end
      object mPanel39: TPanel
        Left = 80
        Top = 137
        Width = 25
        Height = 24
        Caption = '39'
        PopupMenu = PopupMenu
        TabOrder = 9
        OnClick = mPanelClick
      end
      object mPanel38: TPanel
        Left = 55
        Top = 137
        Width = 25
        Height = 24
        Caption = '38'
        PopupMenu = PopupMenu
        TabOrder = 10
        OnClick = mPanelClick
      end
      object mPanel37: TPanel
        Left = 30
        Top = 137
        Width = 25
        Height = 24
        Caption = '37'
        PopupMenu = PopupMenu
        TabOrder = 11
        OnClick = mPanelClick
      end
      object mPanel36: TPanel
        Left = 5
        Top = 137
        Width = 25
        Height = 24
        Caption = '36'
        PopupMenu = PopupMenu
        TabOrder = 12
        OnClick = mPanelClick
      end
      object mPanel35: TPanel
        Left = 155
        Top = 113
        Width = 25
        Height = 24
        Caption = '35'
        PopupMenu = PopupMenu
        TabOrder = 13
        OnClick = mPanelClick
      end
      object mPanel34: TPanel
        Left = 130
        Top = 113
        Width = 25
        Height = 24
        Caption = '34'
        PopupMenu = PopupMenu
        TabOrder = 14
        OnClick = mPanelClick
      end
      object mPanel33: TPanel
        Left = 105
        Top = 113
        Width = 25
        Height = 24
        Caption = '33'
        PopupMenu = PopupMenu
        TabOrder = 15
        OnClick = mPanelClick
      end
      object mPanel32: TPanel
        Left = 80
        Top = 113
        Width = 25
        Height = 24
        Caption = '32'
        PopupMenu = PopupMenu
        TabOrder = 16
        OnClick = mPanelClick
      end
      object mPanel31: TPanel
        Left = 55
        Top = 113
        Width = 25
        Height = 24
        Caption = '31'
        PopupMenu = PopupMenu
        TabOrder = 17
        OnClick = mPanelClick
      end
      object mPanel30: TPanel
        Left = 30
        Top = 113
        Width = 25
        Height = 24
        Caption = '30'
        PopupMenu = PopupMenu
        TabOrder = 18
        OnClick = mPanelClick
      end
      object mPanel3: TPanel
        Left = 55
        Top = 17
        Width = 25
        Height = 24
        Caption = '3'
        PopupMenu = PopupMenu
        TabOrder = 19
        OnClick = mPanelClick
      end
      object mPanel29: TPanel
        Left = 5
        Top = 113
        Width = 25
        Height = 24
        Caption = '29'
        PopupMenu = PopupMenu
        TabOrder = 20
        OnClick = mPanelClick
      end
      object mPanel28: TPanel
        Left = 155
        Top = 89
        Width = 25
        Height = 24
        Caption = '28'
        PopupMenu = PopupMenu
        TabOrder = 21
        OnClick = mPanelClick
      end
      object mPanel27: TPanel
        Left = 130
        Top = 89
        Width = 25
        Height = 24
        Caption = '27'
        PopupMenu = PopupMenu
        TabOrder = 22
        OnClick = mPanelClick
      end
      object mPanel26: TPanel
        Left = 105
        Top = 89
        Width = 25
        Height = 24
        Caption = '26'
        PopupMenu = PopupMenu
        TabOrder = 23
        OnClick = mPanelClick
      end
      object mPanel25: TPanel
        Left = 80
        Top = 89
        Width = 25
        Height = 24
        Caption = '25'
        PopupMenu = PopupMenu
        TabOrder = 24
        OnClick = mPanelClick
      end
      object mPanel24: TPanel
        Left = 55
        Top = 89
        Width = 25
        Height = 24
        Caption = '24'
        PopupMenu = PopupMenu
        TabOrder = 25
        OnClick = mPanelClick
      end
      object mPanel23: TPanel
        Left = 30
        Top = 89
        Width = 25
        Height = 24
        Caption = '23'
        PopupMenu = PopupMenu
        TabOrder = 26
        OnClick = mPanelClick
      end
      object mPanel22: TPanel
        Left = 5
        Top = 89
        Width = 25
        Height = 24
        Caption = '22'
        PopupMenu = PopupMenu
        TabOrder = 27
        OnClick = mPanelClick
      end
      object mPanel21: TPanel
        Left = 155
        Top = 65
        Width = 25
        Height = 24
        Caption = '21'
        PopupMenu = PopupMenu
        TabOrder = 28
        OnClick = mPanelClick
      end
      object mPanel20: TPanel
        Left = 130
        Top = 65
        Width = 25
        Height = 24
        Caption = '20'
        PopupMenu = PopupMenu
        TabOrder = 29
        OnClick = mPanelClick
      end
      object mPanel2: TPanel
        Left = 30
        Top = 17
        Width = 25
        Height = 24
        Caption = '2'
        PopupMenu = PopupMenu
        TabOrder = 30
        OnClick = mPanelClick
      end
      object mPanel19: TPanel
        Left = 105
        Top = 65
        Width = 25
        Height = 24
        Caption = '19'
        PopupMenu = PopupMenu
        TabOrder = 31
        OnClick = mPanelClick
      end
      object mPanel18: TPanel
        Left = 80
        Top = 65
        Width = 25
        Height = 24
        Caption = '18'
        PopupMenu = PopupMenu
        TabOrder = 32
        OnClick = mPanelClick
      end
      object mPanel17: TPanel
        Left = 55
        Top = 65
        Width = 25
        Height = 24
        Caption = '17'
        PopupMenu = PopupMenu
        TabOrder = 33
        OnClick = mPanelClick
      end
      object mPanel16: TPanel
        Left = 30
        Top = 65
        Width = 25
        Height = 24
        Caption = '16'
        PopupMenu = PopupMenu
        TabOrder = 34
        OnClick = mPanelClick
      end
      object mPanel15: TPanel
        Left = 5
        Top = 65
        Width = 25
        Height = 24
        Caption = '15'
        PopupMenu = PopupMenu
        TabOrder = 35
        OnClick = mPanelClick
      end
      object mPanel14: TPanel
        Left = 155
        Top = 41
        Width = 25
        Height = 24
        Caption = '14'
        PopupMenu = PopupMenu
        TabOrder = 36
        OnClick = mPanelClick
      end
      object mPanel13: TPanel
        Left = 130
        Top = 41
        Width = 25
        Height = 24
        Caption = '13'
        PopupMenu = PopupMenu
        TabOrder = 37
        OnClick = mPanelClick
      end
      object mPanel12: TPanel
        Left = 105
        Top = 41
        Width = 25
        Height = 24
        Caption = '12'
        PopupMenu = PopupMenu
        TabOrder = 38
        OnClick = mPanelClick
      end
      object mPanel11: TPanel
        Left = 80
        Top = 41
        Width = 25
        Height = 24
        Caption = '11'
        PopupMenu = PopupMenu
        TabOrder = 39
        OnClick = mPanelClick
      end
      object mPanel10: TPanel
        Left = 55
        Top = 41
        Width = 25
        Height = 24
        Caption = '10'
        PopupMenu = PopupMenu
        TabOrder = 40
        OnClick = mPanelClick
      end
      object mPanel1: TPanel
        Left = 5
        Top = 17
        Width = 25
        Height = 24
        Caption = '1'
        PopupMenu = PopupMenu
        TabOrder = 41
        OnClick = mPanelClick
      end
    end
  end
  object EditDay: TMaskEdit
    Left = 312
    Top = 61
    Width = 25
    Height = 21
    EditMask = '99;1; '
    MaxLength = 2
    TabOrder = 1
    Text = '  '
    OnExit = EditDayExit
  end
  object ButtonSave: TButton
    Left = 24
    Top = 232
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 2
    OnClick = ButtonSaveClick
  end
  object ButtonClose: TButton
    Left = 104
    Top = 232
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = ButtonCloseClick
  end
  object PopupMenu: TPopupMenu
    Left = 232
    Top = 16
    object BegMonth: TMenuItem
      Caption = #1053#1072#1095#1072#1083#1086' '#1084#1077#1089#1103#1094#1072
      OnClick = EndMonthClick
    end
    object EndMonth: TMenuItem
      Caption = #1050#1086#1085#1077#1094' '#1084#1077#1089#1103#1094#1072
      OnClick = EndMonthClick
    end
    object BegYear: TMenuItem
      Caption = #1053#1072#1095#1072#1083#1086' '#1075#1086#1076#1072
      OnClick = BegYearClick
    end
    object EndYear: TMenuItem
      Caption = #1050#1086#1085#1077#1094' '#1075#1086#1076#1072
      OnClick = BegYearClick
    end
    object Curdate: TMenuItem
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1076#1072#1090#1072
      OnClick = CurdateClick
    end
  end
  object StoredProc: TStoredProc
    DatabaseName = 'RMP'
    SessionName = 'Default'
    StoredProcName = 'CREATE_CALENDAR'
    Left = 264
    Top = 16
    ParamData = <
      item
        DataType = ftDateTime
        Name = 'DAYDATE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'DAYVALUE'
        ParamType = ptInput
      end>
  end
  object Table: TTable
    DatabaseName = 'RMP'
    TableName = 'CL_MAIN'
    Left = 296
    Top = 16
  end
end
