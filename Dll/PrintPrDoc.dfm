object PrintPRDocForm: TPrintPRDocForm
  Left = 309
  Top = 288
  Width = 352
  Height = 166
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
    Width = 149
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1087#1088#1080#1093#1086#1076#1085#1086#1081' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
  end
  object Button2: TButton
    Left = 152
    Top = 48
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = Button2Click
  end
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.numdoc, a.date_in, b.name, b.code, e.code, e.name,'
      'f.name, k.vid_chrt, f.code, h.code'
      'from dh_pr a, spr_cst b, dh_order c, dh_rqst d, spr_pdr e, '
      'spr_wrhs f, dt_pr g, spr_chrt k, spr_plant h'
      'where a.id = :iddoc and'
      '      g.id_prmtr = a.id and'
      '      g.id_ord   = c.id and'
      '      c.id_rqst  = d.id and'
      '      d.id_cst   = b.id and'
      '      e.id       = d.id_pdr and'
      '      f.id       = a.id_wrhs and'
      '      k.id       = c.id_chrt  and'
      '      h.id       = c.id_plant')
    Left = 16
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
      
        'select a.lineno, e.name, b.code, e.name, e.code, a.number, a.pri' +
        'ce, a.nsum,'
      ' d.number as numorder, d.number_f, d.id, b.id As Nmnt'
      'from dt_pr a, spr_nmnt b, dh_pr c, dh_order d, spr_chrt e'
      'where c.id       = :iddoc and'
      '      a.id_prmtr = c.id and'
      '      d.id       = a.id_ord and'
      '      a.id_nmnt  = b.id and'
      '      e.id       = d.id_chrt')
    Left = 16
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
      'select a.name, d.price, d.number, c.id'
      'from spr_nmnt a, dh_pr b, dh_order c, dt_mtrf d, dt_pr e'
      'where b.id = :iddoc and'
      '      e.id_prmtr = b.id and'
      '      e.id_ord   = c.id and'
      '      d.id_opf   = c.id and'
      '      d.id_nmnt  = a.id')
    Left = 16
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object CexSebQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(NVALUE) As NValue'
      'From DT_Order3'
      'Where ID_rqst = :ORD_ID and ID_CALC = 6')
    Left = 56
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ORD_ID'
        ParamType = ptUnknown
      end>
  end
  object EdizQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.Code'
      'From Spr_Ediz a, Spr_Nmnt b'
      'Where b.id = :id and a.id = b.id_ediz')
    Left = 88
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
