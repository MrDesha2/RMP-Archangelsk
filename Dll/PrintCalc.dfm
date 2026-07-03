object PrintCalcForm: TPrintCalcForm
  Left = 232
  Top = 145
  Width = 379
  Height = 180
  Caption = #1055#1077#1095#1072#1090#1100
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
    Left = 104
    Top = 24
    Width = 160
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1088#1072#1089#1095#1077#1090#1072' '#1089#1077#1073#1077#1089#1090#1086#1080#1084#1086#1089#1090#1080
  end
  object Button2: TButton
    Left = 152
    Top = 48
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
  end
  object qMTRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.name, d.price'
      'from spr_nmnt a, dh_order c, dt_mtrf d'
      'where c.id = :iddoc and'
      '      d.id_opf   = c.id and'
      '      d.id_nmnt  = a.id')
    Left = 8
    Top = 56
    ParamData = <
      item
        DataType = ftString
        Name = 'iddoc'
        ParamType = ptUnknown
        Value = '11'
      end>
  end
  object qQueryCalc: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.LINENO, b.NAME, a.NVALUE, d.code , c.number_f'
      'From DT_ORDER3 a, Spr_Calc b, DH_Order c, Spr_Chrt d'
      
        'Where c.ID = :iddoc and a.ID_RQST = c.ID and b.ID = a.ID_CALC an' +
        'd '
      'd.ID = c.ID_CHRT'
      'order by a.lineno descending ')
    Left = 8
    Top = 16
    ParamData = <
      item
        DataType = ftString
        Name = 'iddoc'
        ParamType = ptUnknown
        Value = '11'
      end>
  end
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select c.name, d.name, e.code || '#39' ('#39' || e.name || '#39')'#39' As name,'
      'a.date_out, a.number'
      'from dh_order a, dh_rqst b, spr_cst c, spr_nmnt d, spr_chrt e'
      'where a.id_rqst = b.id and'
      '      b.id_cst  = c.id and'
      '      a.id_nmnt = d.id and'
      '      a.id_chrt = e.id and '
      '      a.id = :iddoc ')
    Left = 8
    Top = 88
    ParamData = <
      item
        DataType = ftString
        Name = 'iddoc'
        ParamType = ptUnknown
        Value = '11'
      end>
  end
end
