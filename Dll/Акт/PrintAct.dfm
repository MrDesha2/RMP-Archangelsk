object PrintActForm: TPrintActForm
  Left = 335
  Top = 208
  Width = 337
  Height = 138
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
    Left = 72
    Top = 24
    Width = 166
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1072#1082#1090#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1088#1072#1073#1086#1090
  end
  object Button2: TButton
    Left = 128
    Top = 48
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
  end
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.numdoc, a.date_in, b.name, e.name, b.is_instr, b.code,'
      'e.code,  g.vid_chrt,'
      
        '(select g.Name  From Spr_Cst g Where g.id = b.parentid) As Paren' +
        'tCustomer'
      
        'from dh_rs a, spr_cst b, dt_rs c, dh_order d, spr_pdr e, dh_rqst' +
        ' f, spr_chrt g'
      'where a.id = :iddoc and'
      '      c.id_rsmtr = a.id and'
      '      c.id_ord   = d.id and'
      '      d.id_rqst  = f.id and'
      '      f.id_cst   = b.id and'
      '      f.id_pdr   = e.id and'
      '      g.id       = d.id_chrt')
    Left = 8
    Top = 8
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
      'select a.lineno, b.name, b.code, e.name, e.code,'
      ' a.number, a.price, a.nsum, k.name, sum(m.ntime) As ntime, '
      'h.number as numorder, n.code, d.number_f, d.id'
      'from dt_rs a, dh_rs c, dh_order d, spr_chrt e,'
      '(((dh_order h left join spr_eqpt b on h.id_eqpt  = b.id)'
      'left join spr_nmnt k on h.id_nmnt = k.id)'
      'left join dt_order2 m on h.id = m.id_order)'
      'left join spr_ediz n on k.id_ediz = n.id'
      'where c.id       = :iddoc and'
      '      a.id_rsmtr = c.id and'
      '      a.id_ord   = d.id and'
      '      h.id       = d.id and'
      '      d.id_chrt  = e.id'
      'Group By a.lineno, b.name, b.code, e.name, e.code,'
      ' a.number, a.price, a.nsum, k.name, h.number, n.code,'
      'd.number_f, d.id')
    Left = 8
    Top = 40
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
      'select a.name, d.price, d.number, f.code, c.id'
      
        'from spr_nmnt a, dh_rs b, dh_order c, dt_mtrf d, dt_rs e, spr_ed' +
        'iz f'
      'where b.id = :iddoc and'
      '      e.id_rsmtr = b.id and'
      '      e.id_ord   = c.id and'
      '      d.id_opf   = c.id and'
      '      d.id_nmnt  = a.id and'
      '       f.id = a.id_ediz     ')
    Left = 8
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object NDSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(Nvalue) As NValue'
      'From dt_order4 a'
      'Where a.id_order = :id and a.id_calc = 11')
    Left = 40
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
