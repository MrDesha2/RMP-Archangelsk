object ENUM_REPForm: TENUM_REPForm
  Left = 187
  Top = 147
  HelpContext = 100
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1088#1077#1084#1086#1085#1090#1072' '#1086#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1103
  ClientHeight = 160
  ClientWidth = 494
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 113
    Height = 13
    Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1088#1077#1084#1086#1085#1090#1072':'
  end
  object Label2: TLabel
    Left = 16
    Top = 47
    Width = 131
    Height = 13
    Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1088#1077#1084#1086#1085#1090#1072':'
  end
  object Label3: TLabel
    Left = 16
    Top = 94
    Width = 76
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072':'
  end
  object Label4: TLabel
    Left = 17
    Top = 71
    Width = 141
    Height = 13
    Caption = #1044#1072#1090#1072' '#1089#1083#1077#1076#1091#1102#1097#1077#1075#1086' '#1088#1077#1084#1086#1085#1090#1072':'
  end
  object DateBegin: TDateEdit
    Left = 160
    Top = 20
    Width = 121
    Height = 21
    NumGlyphs = 2
    TabOrder = 0
  end
  object DateEnd: TDateEdit
    Left = 160
    Top = 43
    Width = 121
    Height = 21
    NumGlyphs = 2
    TabOrder = 1
  end
  object Close_Buttom: TButton
    Left = 104
    Top = 132
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Close_ButtomClick
  end
  object OKButton: TButton
    Left = 24
    Top = 132
    Width = 75
    Height = 25
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object DatePPR: TDateEdit
    Left = 161
    Top = 67
    Width = 121
    Height = 21
    NumGlyphs = 2
    TabOrder = 4
  end
  object DocOrderCombo: TComboEdit
    Left = 160
    Top = 93
    Width = 329
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 5
    ID = 0
    OnButtonClick = DocOrderComboButtonClick
    OnExit = DocOrderComboExit
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 576
    Top = 56
    ParamData = <
      item
        DataType = ftFloat
        Name = 'CODE'
        ParamType = ptUnknown
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'NAME'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'MAXTIME'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    SQL.Strings = (
      'insert into spr_pdr'
      
        'values (GEN_ID(SPR_PDR_GEN,1), :parentID, :isfolder , :code, :na' +
        'me , :maxtime)')
    Left = 544
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'parentID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'isfolder'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'Code'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftString
        Name = 'Name'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'MaxTime'
        ParamType = ptUnknown
        Value = 0
      end>
  end
  object qORDERQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, number'
      'from dh_order'
      'where id = :id or number = :number')
    Left = 576
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'number'
        ParamType = ptUnknown
      end>
  end
end
