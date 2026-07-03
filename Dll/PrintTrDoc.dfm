object PrintTrDocForm: TPrintTrDocForm
  Left = 530
  Top = 291
  Width = 387
  Height = 203
  Caption = #1055#1077#1095#1072#1090#1100
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 64
    Width = 207
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' '#1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
  end
  object Button2: TButton
    Left = 120
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
  end
  object IDEdit: TMaskEdit
    Left = 128
    Top = 16
    Width = 65
    Height = 21
    EditMask = '99999;1; '
    MaxLength = 5
    TabOrder = 1
    Text = '     '
  end
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select rs.numdoc, rs.date_in, cst.name, cst.code, pdr.name, pdr.' +
        'code,'
      'wrhs.name, plant.code, wrhs.code'
      
        'from dh_rs rs, spr_cst cst, dt_rs dt, dh_order ord, spr_pdr pdr,' +
        ' dh_rqst rqst, spr_wrhs wrhs,'
      'spr_plant plant'
      'where rs.id = :iddoc and'
      '      dt.id_rsmtr = rs.id and'
      '      dt.id_ord   = ord.id and'
      '      ord.id_rqst = rqst.id and'
      '      rs.id_cst   = cst.id and'
      '      rqst.id_pdr = pdr.id and'
      '      wrhs.id     = rs.id_wrhs and'
      '      plant.id    = ord.id_plant')
    Left = 8
    Top = 16
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object qTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select a.lineno, b.name, b.code, e.name, e.code, a.number, a.pri' +
        'ce, a.nsum, '
      'd.number as numorder, d.number_f, d.id , b.id As Nmnt'
      'from dt_rs a, spr_nmnt b, dh_rs c, dh_order d, spr_chrt e'
      'where c.id       = :iddoc and'
      '      d.id       = a.id_ord and'
      '      a.id_rsmtr = c.id and'
      '      a.id_nmnt  = b.id and'
      '      e.id       = d.id_chrt')
    Left = 8
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object qMTRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.name, d.price, d.number, c.id'
      'from spr_nmnt a, dh_rs b, dh_order c, dt_mtrf d, dt_rs e'
      'where b.id = :iddoc and'
      '      e.id_rsmtr = b.id and '
      '      e.id_ord = c.id and'
      '      d.id_opf   = c.id and'
      '      d.id_nmnt  = a.id')
    Left = 8
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object EdizQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.Code'
      'From Spr_Ediz a, Spr_Nmnt b'
      'Where b.id = :id and a.id = b.id_ediz')
    Left = 48
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
