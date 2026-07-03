object PrintRS_MTRDocForm: TPrintRS_MTRDocForm
  Left = 229
  Top = 252
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
    Left = 64
    Top = 16
    Width = 230
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1088#1072#1089#1093#1086#1076#1085#1086#1081' '#1085#1072#1082#1083#1072#1076#1085#1086#1081' '#1087#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084
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
      'select'
      
        '  rs.numdoc, rs.date_in, dt.lineno, wrhs.name as wrhs_name, cst.' +
        'name as cst_name,'
      
        '  nmnt.code as nmnt_code, nmnt.name as nmnt_name, dt.number, dt.' +
        'price, dt.nsum, ed.code as ediz_name,'
      
        '  (select ord.number from dh_order ord where dt.id_ord = id) as ' +
        'numorder'
      'from'
      '  dh_rs_mtr rs, dt_rs_mtr dt, spr_wrhs wrhs,'
      '  spr_cst cst, spr_nmnt nmnt, spr_ediz ed'
      ''
      'where'
      '  rs.id = :iddoc and'
      '  rs.id = dt.id_doc and'
      '  wrhs.id = rs.id_wrhs and'
      '  cst.id  = rs.id_cst and'
      '  nmnt.id = dt.id_nmnt and'
      '  ed.id = dt.id_ediz')
    Left = 16
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
end
