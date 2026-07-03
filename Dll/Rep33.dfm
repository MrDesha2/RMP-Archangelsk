object Report33Form: TReport33Form
  Left = 192
  Top = 121
  Width = 618
  Height = 388
  Caption = 'Report33Form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 100
    Top = 28
    Width = 420
    Height = 26
    Caption = 'Оборотная ведомость по литейному цеху'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 155
    Top = 76
    Width = 14
    Height = 26
    Caption = 'С'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 308
    Top = 76
    Width = 24
    Height = 26
    Caption = 'по'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 41
    Top = 123
    Width = 100
    Height = 16
    Caption = 'Номенклатура:'
  end
  object Label4: TLabel
    Left = 97
    Top = 153
    Width = 43
    Height = 16
    Caption = 'Склад:'
  end
  object BegDateEdit: TDateEdit
    Left = 177
    Top = 81
    Width = 121
    Height = 25
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 337
    Top = 81
    Width = 121
    Height = 25
    NumGlyphs = 2
    TabOrder = 1
  end
  object NMNTCombo: TComboEdit
    Left = 148
    Top = 118
    Width = 365
    Height = 26
    ClickKey = 16397
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 2
    Text = '<Объект не найден>'
    OnButtonClick = NMNTComboButtonClick
    OnKeyDown = NMNTComboKeyDown
  end
  object WRHSCombo: TComboEdit
    Left = 148
    Top = 148
    Width = 365
    Height = 26
    ClickKey = 16397
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 3
    Text = '<Объект не найден>'
    OnButtonClick = WRHSComboButtonClick
    OnKeyDown = WRHSComboKeyDown
  end
  object RadioGroup: TRadioGroup
    Left = 143
    Top = 187
    Width = 307
    Height = 70
    Caption = 'Вид отчета'
    TabOrder = 4
  end
  object RadioButton1: TRadioButton
    Left = 161
    Top = 207
    Width = 218
    Height = 21
    Caption = 'Карточка складу литья'
    TabOrder = 5
  end
  object RadioButton2: TRadioButton
    Left = 161
    Top = 226
    Width = 198
    Height = 21
    Caption = 'Оборотная ведомость'
    TabOrder = 6
  end
  object ButtonDo: TButton
    Left = 184
    Top = 266
    Width = 113
    Height = 31
    Caption = 'С&формировать'
    TabOrder = 7
    OnClick = ButtonDoClick
  end
  object ButtonCancel: TButton
    Left = 304
    Top = 265
    Width = 113
    Height = 31
    Caption = '&Отмена'
    TabOrder = 8
    OnClick = ButtonCancelClick
  end
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select *'
      'from REPORT_BALANCE_PROCEDURE(:typedoc,'
      ' :id_nmnt, :datebeg, :dateend, :id_wrhs) ')
    Left = 464
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'typedoc'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_nmnt'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'datebeg'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'dateend'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_wrhs'
        ParamType = ptUnknown
      end>
  end
  object qWRHSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select name, id'
      'from spr_wrhs'
      'where id= :id or code = :code')
    Left = 521
    Top = 120
    ParamData = <
      item
        DataType = ftString
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'code'
        ParamType = ptUnknown
      end>
  end
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select name, id, code'
      'from spr_nmnt'
      'where id= :id or code = :code'
      '')
    Left = 553
    Top = 120
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
