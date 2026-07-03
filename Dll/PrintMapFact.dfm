object PrintMapFactForm: TPrintMapFactForm
  Left = 244
  Top = 206
  Width = 434
  Height = 189
  Caption = 'PrintMapFactForm'
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
    Left = 176
    Top = 16
    Width = 209
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1081' '#1084#1072#1088#1090#1096#1088#1091#1090#1085#1086#1081' '#1082#1072#1088#1090#1099
  end
  object Button2: TButton
    Left = 200
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
  end
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'Select a.number, a.date_in, b.name, c.code || '#39' ('#39' || c.name || ' +
        #39')'#39' As name,'
      'e.name, a.pr_urgen, a.number_f, e.code, '
      'g.code || '#39'  ('#39' || g.name || '#39')'#39' As name, f.number'
      'from dh_order a, spr_pdr b, spr_chrt c, dh_rqst f, spr_cst g,'
      'dh_order d left join spr_nmnt e on d.id_nmnt = e.id'
      'where a.id = :iddoc and'
      '      a.id_pdr = b.id and'
      '      a.id_chrt= c.id and'
      '      d.id=a.id and'
      '     f.id=a.id_rqst and'
      '     g.id=f.id_cst'
      '')
    Left = 16
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object ChrcQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.NSIZE, a.KIND'
      'From Spr_Chrc a, DH_Order b, Spr_Chrt c'
      'Where b.ID = :id                 and '
      '            c.ID = b.ID_Chrt     and'
      '            a.ID_CHRT = c.ID')
    Left = 48
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object FactTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select b.lineno, c.name, b.rating, b.ntime'
      'from dh_order a, dt_order2 b, spr_vop c'
      'where a.id = :iddoc and'
      '      b.id_order = a.id and'
      '      c.id       = b.id_vop '
      'order by b.lineno descending')
    Left = 16
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object FactMTRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.name, d.price, d.number'
      'from spr_nmnt a,  dt_mtrf d'
      'where d.id_opf   = :iddoc and'
      '      d.id_nmnt  = a.id')
    Left = 16
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object MtrfQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.lenght, b.hight, b.width, b.weight, c.name'
      
        'From DH_Order a, DT_Mtrf b Left Join Spr_Strg c on c.id = b.id_s' +
        'trg'
      'Where a.id = :id and b.id_opf = a.id'
      '')
    Left = 48
    Top = 56
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object qTransQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select a.name, d.cost, d.number'
      'from spr_eqpt a,  dt_transfact d'
      'where d.id_opf   = :id and'
      '      d.id_eqpt = a.id')
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
