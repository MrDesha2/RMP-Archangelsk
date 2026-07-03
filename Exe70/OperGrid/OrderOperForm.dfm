object ORDER_OperForm: TORDER_OperForm
  Left = 376
  Top = 307
  BorderStyle = bsSingle
  Caption = #1042#1088#1103#1084#1103' '#1085#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1086#1074
  ClientHeight = 278
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 245
    Width = 270
    Height = 33
    Align = alBottom
    TabOrder = 0
    object Button1: TButton
      Left = 13
      Top = 7
      Width = 61
      Height = 20
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1079#1072#1082#1072#1079
      Caption = '&'#1054#1090#1082#1088#1099#1090#1100
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = DBGridEh1DblClick
    end
    object ButtonClose: TButton
      Left = 163
      Top = 7
      Width = 60
      Height = 20
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
      BiDiMode = bdLeftToRight
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = ButtonCloseClick
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 270
    Height = 245
    Align = alClient
    DataSource = DataSourceOrder
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -10
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGridEh1DblClick
    Columns = <
      item
        EditButtons = <>
        FieldName = 'NUMBER'
        Footers = <>
        Title.Caption = #1053#1086#1084#1077#1088' '#1079#1072#1082#1072#1079#1072
        Width = 104
      end
      item
        DisplayFormat = '0.00'
        EditButtons = <>
        FieldName = 'NTIME'
        Footers = <>
        Title.Caption = #1042#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099
        Width = 115
      end>
  end
  object QueryOrder: TQuery
    Active = True
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.number, a.ntime/1000/24  as ntime'
      'From dt_order2 a, dh_order b'
      'where a.id_wrkr  = 2 and'
      '      a.id_order = b.id and'
      '      a.date_beg = (Select max(c.date_beg)'
      '                   From dt_order2 c'
      '                    Where c.id_wrkr = 2)'
      'Order by 1')
    Left = 16
    Top = 56
  end
  object DataSourceOrder: TDataSource
    DataSet = QueryOrder
    Left = 56
    Top = 56
  end
  object QueryInfoOrder: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'Select a.number as number_rqst, a.date_in as date_in_rqst, a.dat' +
        'e_out as date_out_rqst,'
      
        '       b.number as number_order, b.date_in as date_in_order, b.d' +
        'ate_out as date_out_order, b.number_p,'
      
        '       c.name as name_cst, d.name as name_pdr, e.name as name_nm' +
        'nt, f.name as name_chrt'
      
        'From DH_Rqst a,  DH_Order b, Spr_Cst c, Spr_Pdr d, Spr_Nmnt e, S' +
        'pr_Chrt f'
      'Where b.id = :id and'
      '      a.id = b.id_rqst and'
      '      c.id = a.id_cst  and'
      '      d.id = b.id_pdr  and'
      '      e.id = b.id_nmnt and'
      '      f.id = b.id_chrt')
    Left = 16
    Top = 88
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
