object ENUM_CLCPDRForm: TENUM_CLCPDRForm
  Left = 305
  Top = 223
  Width = 371
  Height = 153
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1079#1072#1090#1088#1072#1090' '#1087#1086' '#1052#1042#1047':'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PDRName: TLabel
    Left = 8
    Top = 17
    Width = 51
    Height = 13
    Caption = 'PDRName'
  end
  object Label4: TLabel
    Left = 8
    Top = 44
    Width = 53
    Height = 13
    Caption = #1052#1042#1047' '#1056#1052#1055':'
  end
  object Label3: TLabel
    Left = 8
    Top = 67
    Width = 51
    Height = 13
    Caption = #1042#1077#1083#1080#1095#1080#1085#1072':'
  end
  object Label1: TLabel
    Left = 185
    Top = 66
    Width = 10
    Height = 13
    Caption = '%'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PDRCombo: TComboEdit
    Left = 64
    Top = 39
    Width = 297
    Height = 20
    ClickKey = 16397
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 0
    Tablename = 'spr_pdr'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
    Query = qPDRQuery
    OnButtonClick = PDRComboButtonClick
    OnKeyDown = PDRComboKeyDown
  end
  object NValue: TRxCalcEdit
    Left = 64
    Top = 62
    Width = 121
    Height = 21
    Alignment = taLeftJustify
    AutoSize = False
    MaxValue = 100000.000000000000000000
    NumGlyphs = 2
    TabOrder = 1
  end
  object OKButton: TButton
    Left = 64
    Top = 96
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object Close_Button: TButton
    Left = 144
    Top = 96
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = Close_ButtonClick
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_pdr where id = :id  or code = :code')
    Left = 370
    Top = 26
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
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    Left = 369
    Top = 56
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select * from spr_clcmvz'
      'where id = :id')
    Left = 368
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
