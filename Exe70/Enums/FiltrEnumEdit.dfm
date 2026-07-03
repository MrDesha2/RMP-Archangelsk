object FiltrEnumForm: TFiltrEnumForm
  Left = 450
  Top = 235
  Width = 640
  Height = 357
  BorderIcons = [biSystemMenu]
  Caption = #1059#1089#1090#1072#1085#1086#1074#1082#1072' '#1092#1080#1083#1090#1088#1072' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 266
    Width = 622
    Height = 46
    Align = alBottom
    TabOrder = 0
    object OkButton: TButton
      Left = 56
      Top = 8
      Width = 153
      Height = 33
      Caption = '&'#1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1086#1090#1073#1086#1088
      TabOrder = 0
      OnClick = OkButtonClick
    end
    object CancelButton: TButton
      Left = 240
      Top = 8
      Width = 153
      Height = 33
      Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100' '#1086#1090#1073#1086#1088
      TabOrder = 1
      OnClick = CancelButtonClick
    end
    object CloseButton: TButton
      Left = 432
      Top = 8
      Width = 153
      Height = 33
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100' '#1092#1086#1088#1084#1091
      TabOrder = 2
      OnClick = CloseButtonClick
    end
  end
  object ChrtPanel: TPanel
    Left = 0
    Top = 0
    Width = 622
    Height = 266
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 24
      Top = 164
      Width = 100
      Height = 16
      Caption = #1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072':'
    end
    object Label2: TLabel
      Left = 24
      Top = 51
      Width = 52
      Height = 16
      Caption = #1063#1077#1088#1090#1105#1078':'
    end
    object Label3: TLabel
      Left = 24
      Top = 107
      Width = 68
      Height = 16
      Caption = #1054#1087#1077#1088#1072#1094#1080#1103':'
    end
    object NmntChrtCombo: TComboEdit
      Left = 144
      Top = 160
      Width = 449
      Height = 25
      HelpContext = 101
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'spr_NMNT'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' ('#1042#1099#1073#1086#1088')'
      Query = qNMNTChrtQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = NmntChrtComboButtonClick
      OnKeyDown = NmntChrtComboKeyDown
    end
    object OperCheckBox: TCheckBox
      Left = 24
      Top = 208
      Width = 369
      Height = 17
      Caption = #1053#1072#1083#1080#1095#1080#1077' '#1085#1077#1085#1086#1088#1084#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1086#1087#1077#1088#1072#1094#1080#1081
      TabOrder = 1
    end
    object ChrtChrtCombo: TComboEdit
      Left = 144
      Top = 48
      Width = 449
      Height = 25
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 2
      Tablename = 'Spr_Chrt'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1063#1077#1088#1090#1105#1078' ('#1042#1099#1073#1086#1088')'
      Query = qChrtChrtQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = ChrtChrtComboButtonClick
      OnKeyDown = ChrtChrtComboKeyDown
    end
    object OperChrtCombo: TComboEdit
      Left = 144
      Top = 104
      Width = 449
      Height = 25
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 3
      Tablename = 'Spr_Vop'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1087#1077#1088#1072#1094#1080#1080' ('#1042#1099#1073#1086#1088')'
      Query = qOperChrtQuery
      ID = -1
      CanSelectGroup = False
      OnButtonClick = OperChrtComboButtonClick
      OnKeyDown = OperChrtComboKeyDown
    end
  end
  object qNMNTChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_nmnt'
      'where id = :id or code = :code')
    Left = 632
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptUnknown
        Value = -1
      end
      item
        DataType = ftInteger
        Name = 'code'
        ParamType = ptUnknown
        Value = -1
      end>
  end
  object qOperChrtQuery: TQuery
    Active = True
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_vop'
      'where id = :id or code = :code')
    Left = 632
    Top = 104
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptUnknown
        Value = -1
      end
      item
        DataType = ftInteger
        Name = 'code'
        ParamType = ptUnknown
        Value = -1
      end>
  end
  object qChrtChrtQuery: TQuery
    Active = True
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 632
    Top = 48
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptUnknown
        Value = -1
      end
      item
        DataType = ftInteger
        Name = 'code'
        ParamType = ptUnknown
        Value = -1
      end>
  end
end
