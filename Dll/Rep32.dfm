object Report32Form: TReport32Form
  Left = 217
  Top = 218
  Width = 373
  Height = 226
  Caption = #1042#1099#1088#1072#1073#1086#1090#1082#1072' '#1087#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 48
    Top = 9
    Width = 271
    Height = 24
    Caption = #1042#1099#1088#1072#1073#1086#1090#1082#1072' '#1087#1086' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 174
    Top = 41
    Width = 22
    Height = 24
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 30
    Top = 41
    Width = 10
    Height = 24
    Caption = #1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 49
    Top = 41
    Width = 120
    Height = 25
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 201
    Top = 41
    Width = 120
    Height = 25
    NumGlyphs = 2
    TabOrder = 1
  end
  object ComboBox: TComboBox
    Left = 49
    Top = 73
    Width = 272
    Height = 24
    ItemHeight = 16
    TabOrder = 2
    Text = #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102' '#1080' '#1091#1089#1083#1091#1075#1072#1084
    Items.Strings = (
      #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102' '#1080' '#1091#1089#1083#1091#1075#1072#1084
      #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102
      #1087#1086' '#1091#1089#1083#1091#1075#1072#1084)
  end
  object OkButton: TButton
    Left = 57
    Top = 113
    Width = 88
    Height = 32
    Caption = '&'#1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 3
    OnClick = OkButtonClick
  end
  object CloseButton: TButton
    Left = 153
    Top = 113
    Width = 88
    Height = 32
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = CloseButtonClick
  end
  object ButtonSelPer: TButton
    Left = 322
    Top = 38
    Width = 31
    Height = 26
    Caption = '...'
    TabOrder = 5
    OnClick = ButtonSelPerClick
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      'From REPORT_32_PROCEDURE(:job, :beg_date, :end_date)')
    Left = 272
    Top = 111
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'job'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'beg_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'end_date'
        ParamType = ptUnknown
      end>
  end
end
