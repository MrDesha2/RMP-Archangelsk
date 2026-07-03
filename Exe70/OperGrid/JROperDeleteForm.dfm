object JR_OPERDELETEForm: TJR_OPERDELETEForm
  Left = 244
  Top = 205
  Width = 388
  Height = 253
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 380
    Height = 166
    Align = alClient
    TabOrder = 0
    object Title1Label: TLabel
      Left = 16
      Top = 24
      Width = 342
      Height = 20
      Caption = #1054#1095#1080#1089#1090#1082#1072' '#1074#1088#1077#1084#1077#1085#1080' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Title2Label: TLabel
      Left = 96
      Top = 40
      Width = 95
      Height = 24
      Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Title3Label: TLabel
      Left = 24
      Top = 64
      Width = 70
      Height = 20
      Caption = #1059#1095#1072#1089#1090#1082#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object BegDateEdit: TDateEdit
      Left = 80
      Top = 88
      Width = 121
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
    end
    object EndDateEdit: TDateEdit
      Left = 80
      Top = 120
      Width = 120
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
    end
    object TimeBEG: TDateTimePicker
      Left = 208
      Top = 88
      Width = 97
      Height = 24
      Date = 38510.000000000000000000
      Time = 38510.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Kind = dtkTime
      ParentFont = False
      TabOrder = 1
    end
    object TimeEND: TDateTimePicker
      Left = 208
      Top = 120
      Width = 97
      Height = 24
      Date = 38510.000000000000000000
      Time = 38510.000000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Kind = dtkTime
      ParentFont = False
      TabOrder = 3
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 166
    Width = 380
    Height = 53
    Align = alBottom
    TabOrder = 1
    object DelButton: TButton
      Left = 24
      Top = 8
      Width = 89
      Height = 33
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      TabOrder = 0
      OnClick = DelButtonClick
    end
    object CloseButton: TButton
      Left = 120
      Top = 8
      Width = 89
      Height = 33
      Caption = '&'#1054#1090#1084#1077#1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = CloseButtonClick
    end
  end
  object MaxMinTimeQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      'From Spr_Ediz'
      '')
    Left = 320
    Top = 80
  end
  object DelPlanStoredProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'DEL_PLAN_PROC'
    Left = 320
    Top = 112
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PERIOD'
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
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end>
  end
end
