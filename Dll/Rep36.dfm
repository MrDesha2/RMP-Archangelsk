object Report36Form: TReport36Form
  Left = 358
  Top = 162
  Width = 323
  Height = 226
  Caption = #1059#1095#1077#1090' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 66
    Top = 7
    Width = 177
    Height = 24
    Caption = #1059#1095#1077#1090' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 18
    Top = 40
    Width = 9
    Height = 16
    Caption = #1057
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 135
    Top = 40
    Width = 16
    Height = 16
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 33
    Top = 40
    Width = 98
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 157
    Top = 40
    Width = 97
    Height = 21
    ButtonWidth = 16
    NumGlyphs = 2
    TabOrder = 1
  end
  object ButtonSelPer: TButton
    Left = 253
    Top = 39
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelPerClick
  end
  object JobComboBox: TComboBox
    Left = 33
    Top = 88
    Width = 221
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    Text = #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102' '#1080' '#1091#1089#1083#1091#1075#1072#1084
    Items.Strings = (
      #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102' '#1080' '#1091#1089#1083#1091#1075#1072#1084
      #1087#1086' '#1080#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1102
      #1087#1086' '#1091#1089#1083#1091#1075#1072#1084)
  end
  object OkButton: TButton
    Left = 59
    Top = 130
    Width = 78
    Height = 25
    Caption = '&'#1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 4
    OnClick = OkButtonClick
  end
  object CloseButton: TButton
    Left = 144
    Top = 130
    Width = 78
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 5
    OnClick = CloseButtonClick
  end
  object VidComboBox: TComboBox
    Left = 33
    Top = 65
    Width = 221
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = #1042#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
    Items.Strings = (
      #1042#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
      #1053#1077#1079#1072#1074#1077#1088#1096#1077#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099)
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      'From REPORT_36_PROCEDURE(:vid, :job, :beg_date, :end_date)')
    Left = 296
    Top = 146
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'vid'
        ParamType = ptUnknown
      end
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
