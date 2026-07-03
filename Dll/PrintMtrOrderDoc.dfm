object PrintMTROrderDocForm: TPrintMTROrderDocForm
  Left = 226
  Top = 211
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
    Width = 150
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100' '#1079#1072#1082#1072#1079#1072' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099
  end
  object Label2: TLabel
    Left = 88
    Top = 48
    Width = 11
    Height = 13
    Caption = 'ID'
  end
  object Button2: TButton
    Left = 144
    Top = 88
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = Button2Click
  end
  object EditId: TEdit
    Left = 104
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'SELECT doc.NUMDOC, doc.DATEDOC, cst.name as cst_name,'
      '  (select name from spr_pdr where id = doc.id_pdr) as pdr_name'
      'FROM DH_MTRORDER doc, spr_cst cst'
      'where doc.id = :iddoc'
      '   and doc.id_cst = cst.id')
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
      'SELECT doc.lineno, nmnt.code, nmnt.name,'
      
        '  (select code from spr_ediz where id = doc.id_ediz) as name_edi' +
        'z,'
      '  doc.number'
      ''
      'FROM dt_mtrorder doc, spr_nmnt nmnt'
      'where  doc.id = :iddoc'
      '   and doc.id_nmnt = nmnt.id'
      ''
      'order by lineno')
    Left = 16
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
end
