object Report47Form: TReport47Form
  Left = 192
  Top = 110
  Width = 453
  Height = 194
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1074#1099#1076#1072#1085#1085#1086#1075#1086' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.numdoc, b.date_in, a.name, a.code,'
      
        '(Select '#39'('#39'||d.code||'#39') '#39'||d.name From Spr_Eqpt d Where d.id=c.i' +
        'd_eqpt) As Eqpt,'
      
        '(Select f.code From Spr_Ediz f Where f.id = c.id_ediz) As Ediz, ' +
        'c.number'
      'From Spr_Wrkr a, dh_rs_eqpt b, dt_rs_eqpt c'
      'Where a.id = :id_wrkr    and'
      '      b.type_doc = 0     and'
      '      b.id_wrkr = a.id   and'
      '      b.id = c.id_rseqpt and'
      '      b.date_in >= :DATE_BEG and'
      '      b.date_in <= :DATE_END'
      'Order By 2, 3')
    Left = 64
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_wrkr'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATE_BEG'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATE_END'
        ParamType = ptUnknown
      end>
  end
end
