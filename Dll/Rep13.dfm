object Report13Form: TReport13Form
  Left = 193
  Top = 168
  Width = 373
  Height = 242
  Caption = #1054#1090#1095#1077#1090
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 128
    Top = 8
    Width = 122
    Height = 20
    Caption = #1060#1086#1088#1084#1072' '#1089#1074#1077#1088#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 55
    Top = 44
    Width = 7
    Height = 13
    Caption = 'C'
  end
  object Label3: TLabel
    Left = 161
    Top = 44
    Width = 12
    Height = 13
    Caption = #1087#1086
  end
  object Label4: TLabel
    Left = 13
    Top = 73
    Width = 36
    Height = 13
    Caption = #1057' '#1052#1042#1047':'
  end
  object Label5: TLabel
    Left = 13
    Top = 97
    Width = 15
    Height = 13
    Caption = #1087#1086':'
  end
  object BegDateEdit: TDateEdit
    Left = 68
    Top = 42
    Width = 93
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 181
    Top = 42
    Width = 92
    Height = 21
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 1
  end
  object PDRComboBeg: TComboEdit
    Left = 69
    Top = 69
    Width = 233
    Height = 21
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 2
    Text = '<Object not found>'
    OnButtonClick = PDRComboBegButtonClick
    OnKeyDown = PDRComboBegKeyDown
  end
  object PDRComboEnd: TComboEdit
    Left = 69
    Top = 93
    Width = 233
    Height = 21
    GlyphKind = gkEllipsis
    NumGlyphs = 1
    TabOrder = 3
    Text = '<Object not found>'
    OnButtonClick = PDRComboEndButtonClick
    OnKeyDown = PDRComboEndKeyDown
  end
  object OKButton: TButton
    Left = 120
    Top = 128
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CloseButton: TButton
    Left = 200
    Top = 128
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 5
    OnClick = CloseButtonClick
  end
  object ButtonSelPer: TButton
    Left = 276
    Top = 41
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 6
    OnClick = ButtonSelPerClick
  end
  object qPDRQueryBeg: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 361
    Top = 32
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
  object qPDRQueryEnd: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 361
    Top = 64
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
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.CODE, a.NAME, Sum(b.NUMBER_P) As NUMBER, '
      'Sum(b.NUMBER_P * c.PRICE) As Price'
      ''
      'From Spr_Pdr a, DH_Order b, DT_Order2 c'
      ''
      'Where c.DATE_END>=:date_beg and c.DATE_END<=:date_end and'
      'a.id = :pdr and b.ID = c.ID_ORDER and b.ID_PDR = a.ID'
      ''
      'Group by a.CODE, a.NAME'
      'Order by 1')
    Left = 360
    Top = 96
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'date_beg'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date_end'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pdr'
        ParamType = ptUnknown
      end>
  end
  object qSELQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select id'
      'From Spr_Pdr'
      'Order by 1')
    Left = 360
    Top = 128
  end
end
