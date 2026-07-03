object PlanningForm: TPlanningForm
  Left = 314
  Top = 136
  Width = 463
  Height = 561
  HelpContext = 351
  Caption = #1055#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 455
    Height = 55
    Align = alBottom
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 104
      Height = 53
      Align = alLeft
      Caption = #1054#1098#1077#1084' '#1087#1072#1084#1103#1090#1080':'
      TabOrder = 0
      object Edit1: TEdit
        Left = 20
        Top = 21
        Width = 65
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        TabOrder = 0
        Text = '5000'
        OnChange = Edit1Change
        OnExit = FormActivate
      end
    end
    object GroupBox2: TGroupBox
      Left = 105
      Top = 1
      Width = 260
      Height = 53
      Align = alLeft
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
      TabOrder = 1
      object PDRCombo: TComboEdit
        Left = 3
        Top = 17
        Width = 254
        Height = 20
        GlyphKind = gkEllipsis
        ButtonWidth = 20
        NumGlyphs = 1
        TabOrder = 0
        Tablename = 'spr_pdr'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
        Query = qPDRQuery
        ID = -1
        OnButtonClick = PDRComboButtonClick
        OnKeyDown = PDRComboKeyDown
      end
    end
  end
  object Panel2: TPanel
    Left = 360
    Top = 0
    Width = 95
    Height = 424
    Align = alRight
    TabOrder = 1
    object OKButton: TButton
      Left = 5
      Top = 13
      Width = 82
      Height = 20
      Caption = '&'#1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object RESButton: TButton
      Left = 5
      Top = 65
      Width = 82
      Height = 20
      Caption = '&Results'
      TabOrder = 1
      Visible = False
    end
    object CloseButton: TButton
      Left = 5
      Top = 39
      Width = 82
      Height = 20
      Caption = '&'#1042#1099#1093#1086#1076
      TabOrder = 2
      OnClick = CloseButtonClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 424
    Width = 455
    Height = 48
    Align = alBottom
    Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090' '#1089#1090#1072#1085#1086#1095#1085#1086#1081' '#1075#1088#1091#1087#1087#1099':'
    TabOrder = 2
    DesignSize = (
      455
      48)
    object StaticText: TStaticText
      Left = 8
      Top = 22
      Width = 354
      Height = 16
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight, akBottom]
      AutoSize = False
      BorderStyle = sbsSunken
      Caption = #1054#1090#1084#1077#1095#1077#1085#1085#1086#1081' '#1075#1088#1091#1087#1087#1099' '#1085#1077#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 0
    end
  end
  object RxCheckListBox: TRxCheckListBox
    Left = 0
    Top = 0
    Width = 360
    Height = 424
    CheckKind = ckRadioButtons
    Align = alClient
    ItemHeight = 13
    TabOrder = 3
    OnClick = RxCheckListBoxClick
    InternalVersion = 202
  end
  object Query1: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select name'
      'From Spr_Pdr')
    Left = 384
    Top = 128
  end
  object Query2: TQuery
    DatabaseName = 'RMP'
    Left = 384
    Top = 160
  end
  object Query3: TQuery
    DatabaseName = 'RMP'
    Left = 384
    Top = 192
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_pdr where id = :id  or code = :code')
    Left = 384
    Top = 224
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
end
