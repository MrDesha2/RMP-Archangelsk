object Report31Form: TReport31Form
  Left = 252
  Top = 176
  Width = 342
  Height = 215
  Caption = #1044#1080#1085#1072#1084#1080#1082#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 36
    Top = 13
    Width = 214
    Height = 16
    Caption = #1044#1080#1085#1072#1084#1080#1082#1072' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1081
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 128
    Top = 51
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
  object Label3: TLabel
    Left = 11
    Top = 51
    Width = 7
    Height = 16
    Caption = #1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 27
    Top = 52
    Width = 97
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 156
    Top = 52
    Width = 98
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 1
  end
  object CloseButton: TButton
    Left = 137
    Top = 85
    Width = 78
    Height = 26
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = CloseButtonClick
  end
  object OkButton: TButton
    Left = 52
    Top = 85
    Width = 79
    Height = 26
    Caption = '&'#1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 3
    OnClick = OkButtonClick
  end
  object ButtonSelPer: TButton
    Left = 254
    Top = 51
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonSelPerClick
  end
  object Query: TQuery
    AutoRefresh = True
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select date_end, count(date_end)'
      'From DT_Order2'
      'Where date_end>='#39'01.01.03'#39' and date_end<='#39'01.01.04'#39
      'Group By date_end')
    Left = 272
    Top = 111
  end
end
