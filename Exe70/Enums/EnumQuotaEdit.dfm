object ENUM_QUOTACST: TENUM_QUOTACST
  Left = 276
  Top = 265
  Width = 403
  Height = 191
  HelpContext = 100
  Caption = #1050#1074#1086#1090#1099' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '#1085#1072' '#1089#1090#1072#1085#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object CSTName: TLabel
    Left = 9
    Top = 15
    Width = 90
    Height = 16
    Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103':'
  end
  object Label1: TLabel
    Left = 9
    Top = 41
    Width = 106
    Height = 16
    Caption = #1043#1088#1091#1087#1087#1072' '#1089#1090#1072#1085#1082#1086#1074':'
  end
  object Label2: TLabel
    Left = 9
    Top = 65
    Width = 44
    Height = 16
    Caption = #1051#1080#1084#1080#1090':'
  end
  object OKButton: TButton
    Left = 32
    Top = 128
    Width = 75
    Height = 25
    Caption = '&'#1054#1050
    TabOrder = 0
    OnClick = OKButtonClick
  end
  object Cancel_Button: TButton
    Left = 112
    Top = 128
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = Cancel_ButtonClick
  end
  object TPEQCombo: TComboEdit
    Left = 122
    Top = 30
    Width = 312
    Height = 25
    Enabled = False
    GlyphKind = gkEllipsis
    ButtonWidth = 25
    NumGlyphs = 1
    TabOrder = 2
    Tablename = 'SPR_TPEQ'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1058#1080#1087#1099' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
    Query = qTPEQQuery
    ID = 0
    CanSelectGroup = False
    OnButtonClick = TPEQComboButtonClick
    OnKeyDown = TPEQComboKeyDown
  end
  object NSizeEdit: TMaskEdit
    Left = 122
    Top = 62
    Width = 108
    Height = 21
    EditMask = '999999;1; '
    MaxLength = 6
    TabOrder = 3
    Text = '      '
  end
  object qTPEQQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_tpeq'
      'where id = :id or code = :code'
      '    and isfolder = 1')
    Left = 320
    Top = 112
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
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into quotaCst'
      'values (:id_cst, :nsize, :id_tpeq)')
    Left = 296
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_cst'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'nsize'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_tpeq'
        ParamType = ptUnknown
      end>
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update qoutaCst'
      'set  nsize = :nsize, id_tpeq = :id_tpeq'
      'where'
      '  ID_cst =  :ID')
    Left = 328
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'nsize'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_tpeq'
        ParamType = ptUnknown
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
end
