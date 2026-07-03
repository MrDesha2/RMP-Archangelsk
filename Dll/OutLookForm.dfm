object OutLook_Form: TOutLook_Form
  Left = 359
  Top = 178
  Width = 502
  Height = 234
  Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1086#1090#1095#1105#1090
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Name: TLabel
    Left = 26
    Top = 65
    Width = 29
    Height = 13
    Caption = #1050#1086#1084#1091':'
  end
  object Sabject: TLabel
    Left = 26
    Top = 91
    Width = 30
    Height = 13
    Caption = #1058#1077#1084#1072':'
  end
  object AdressEdit: TEdit
    Left = 65
    Top = 65
    Width = 391
    Height = 21
    Hint = #1040#1076#1088#1077#1089' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1103' '#1087#1080#1089#1100#1084#1072'-'#1086#1090#1095#1105#1090#1072' '
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object SubjectEdit: TEdit
    Left = 65
    Top = 91
    Width = 391
    Height = 21
    Hint = #1058#1077#1084#1072' '#1087#1080#1089#1100#1084#1072
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object ButtonSend: TButton
    Left = 65
    Top = 7
    Width = 98
    Height = 46
    Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1086#1090#1095#1105#1090' '#1072#1076#1088#1077#1089#1072#1090#1091
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1087#1086#1095#1090#1091
    TabOrder = 2
    OnClick = ButtonSendClick
  end
  object ButtonClose: TButton
    Left = 376
    Top = 137
    Width = 75
    Height = 32
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = ButtonCloseClick
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    OnInitializeISO = IdMessage1InitializeISO
    Left = 360
    Top = 24
  end
end
