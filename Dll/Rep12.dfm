object Report12Form: TReport12Form
  Left = 454
  Top = 178
  Width = 552
  Height = 604
  Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1075#1086#1076#1086#1074#1086#1084#1091' '#1078#1091#1088#1085#1072#1083#1091
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 121
    Top = 20
    Width = 329
    Height = 24
    Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1087#1086' '#1075#1086#1076#1086#1074#1086#1084#1091' '#1078#1091#1088#1085#1072#1083#1091
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 81
    Top = 199
    Width = 63
    Height = 24
    Caption = #1054#1090#1073#1086#1088':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 9
    Top = 223
    Width = 144
    Height = 24
    Caption = #1055#1088#1080#1079#1085#1072#1082' '#1079#1072#1082#1072#1079#1072':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 70
    Top = 254
    Width = 73
    Height = 24
    Caption = #1063#1077#1088#1090#1077#1078':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 62
    Top = 284
    Width = 87
    Height = 24
    Caption = #1047#1072#1082#1072#1079#1095#1080#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 70
    Top = 313
    Width = 77
    Height = 24
    Caption = #1059#1095#1072#1089#1090#1086#1082':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 159
    Top = 343
    Width = 89
    Height = 24
    Caption = #8470' '#1047#1072#1103#1074#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 298
    Top = 343
    Width = 87
    Height = 24
    Caption = #8470' '#1047#1072#1082#1072#1079#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 292
    Top = 366
    Width = 5
    Height = 24
    Caption = '/'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 80
    Top = 48
    Width = 417
    Height = 129
    Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100'  '#1087#1086' '#1087#1077#1088#1080#1086#1076#1091
    TabOrder = 0
    object Label2: TLabel
      Left = 14
      Top = 79
      Width = 13
      Height = 24
      Caption = 'C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 194
      Top = 79
      Width = 22
      Height = 24
      Caption = #1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -18
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object PerInRadioButton: TRadioButton
      Left = 11
      Top = 27
      Width = 246
      Height = 17
      Caption = #1055#1086' '#1076#1072#1090#1077' '#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = PerInRadioButtonClick
    end
    object PerOutRadioButton: TRadioButton
      Left = 11
      Top = 48
      Width = 310
      Height = 17
      Caption = #1055#1086' '#1076#1072#1090#1077' '#1087#1083#1072#1085#1086#1074#1086#1075#1086' '#1079#1072#1074#1077#1088#1096#1077#1080#1103' '#1079#1072#1082#1072#1079#1086#1074
      TabOrder = 1
      OnClick = PerOutRadioButtonClick
    end
    object BegDateEdit: TDateEdit
      Left = 41
      Top = 78
      Width = 149
      Height = 24
      NumGlyphs = 2
      TabOrder = 2
    end
    object EndDateEdit: TDateEdit
      Left = 218
      Top = 78
      Width = 149
      Height = 24
      NumGlyphs = 2
      TabOrder = 3
    end
    object ButtonSelPer: TButton
      Left = 373
      Top = 75
      Width = 31
      Height = 26
      Caption = '...'
      TabOrder = 4
      OnClick = ButtonSelPerClick
    end
  end
  object ReviewComboBox: TComboBox
    Left = 158
    Top = 194
    Width = 216
    Height = 24
    ItemHeight = 16
    TabOrder = 1
    Text = #1042#1089#1077' '#1079#1072#1082#1072#1079#1099
    Items.Strings = (
      #1042#1089#1077' '#1079#1072#1082#1072#1079#1099
      #1042#1099#1087#1086#1083#1085#1077#1085#1085#1099#1077
      #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
      #1053#1077' '#1079#1072#1087#1091#1097#1077#1085#1085#1099#1077)
  end
  object FeatComboBox: TComboBox
    Left = 158
    Top = 222
    Width = 216
    Height = 24
    ItemHeight = 16
    TabOrder = 2
    Items.Strings = (
      #1041#1077#1079' '#1087#1088#1080#1079#1085#1072#1082#1072
      #1055#1083#1072#1085#1086#1074#1099#1077
      #1043#1086#1076#1086#1074#1099#1077
      #1042#1085#1077#1087#1083#1072#1085#1086#1074#1099#1077)
  end
  object ChrtCombo: TComboEdit
    Left = 158
    Top = 249
    Width = 323
    Height = 25
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 3
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = ChrtComboButtonClick
    OnKeyDown = ChrtComboKeyDown
  end
  object CstCombo: TComboEdit
    Left = 158
    Top = 278
    Width = 323
    Height = 27
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 4
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = CSTComboButtonClick
    OnKeyDown = CSTComboKeyDown
  end
  object PdrCombo: TComboEdit
    Left = 158
    Top = 308
    Width = 323
    Height = 26
    GlyphKind = gkEllipsis
    ButtonWidth = 26
    NumGlyphs = 1
    TabOrder = 5
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = PdrComboButtonClick
    OnKeyDown = PdrComboKeyDown
  end
  object OrderEdit: TEdit
    Left = 303
    Top = 366
    Width = 128
    Height = 24
    TabOrder = 6
  end
  object RqstEdit: TEdit
    Left = 159
    Top = 366
    Width = 128
    Height = 24
    TabOrder = 7
  end
  object RadioGroup1: TRadioGroup
    Left = 160
    Top = 390
    Width = 273
    Height = 73
    Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1082#1072
    TabOrder = 8
  end
  object CstRadioButton: TRadioButton
    Left = 169
    Top = 416
    Width = 256
    Height = 17
    Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1079#1072#1082#1072#1079#1095#1080#1082#1072#1084
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    TabStop = True
    OnClick = CstRadioButtonClick
  end
  object NmntRadioButton: TRadioButton
    Left = 169
    Top = 438
    Width = 248
    Height = 17
    Caption = #1043#1088#1091#1087#1087#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084
    TabOrder = 10
    OnClick = NmntRadioButtonClick
  end
  object OutMemoBox: TCheckBox
    Left = 162
    Top = 466
    Width = 255
    Height = 21
    Caption = #1042#1099#1074#1086#1076#1080#1090#1100' '#1082#1086#1084#1077#1085#1090#1072#1088#1080#1080' '#1079#1072#1082#1072#1079#1086#1074
    TabOrder = 11
    OnClick = OutMemoBoxClick
  end
  object Button1: TButton
    Left = 158
    Top = 491
    Width = 323
    Height = 25
    Caption = #1055#1077#1095#1072#1090#1100' '#1052#1072#1088#1096#1088#1091#1090#1085#1099#1093' '#1082#1072#1088#1090
    TabOrder = 12
    OnClick = Button1Click
  end
  object OKButton: TButton
    Left = 201
    Top = 521
    Width = 93
    Height = 30
    Caption = 'Ok'
    TabOrder = 13
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 305
    Top = 521
    Width = 91
    Height = 30
    Cancel = True
    Caption = 'Close'
    TabOrder = 14
    OnClick = CancelButtonClick
  end
  object qCSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 476
    Top = 212
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
  object qPdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 476
    Top = 240
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
  object qMainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'Select  f.number ,a.number, a.date_in, b.name, c.code || '#39' ('#39' ||' +
        ' c.name || '#39')'#39' As name,'
      'e.name, a.pr_urgen, a.number_p, e.code,'
      'g.code || '#39'  ('#39' || g.name || '#39')'#39' As name'
      'from dh_order a, spr_pdr b, spr_chrt c, dh_rqst f, spr_cst g,'
      'dh_order d left join spr_nmnt e on d.id_nmnt = e.id'
      'where a.id = :iddoc and'
      '      a.id_pdr = b.id and'
      '      a.id_chrt= c.id and'
      '      d.id=a.id and'
      '     f.id=a.id_rqst and'
      '     g.id=f.id_cst'
      'Order By 1, 2')
    Left = 504
    Top = 208
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
      'select b.lineno, c.name, b.rating, b.ntime'
      'from dh_order a, dt_order1 b, spr_vop c'
      'where a.id = :iddoc and'
      '      b.id_order = a.id and'
      '      c.id       = b.id_vop '
      'order by b.lineno')
    Left = 504
    Top = 240
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
      'select a.name, d.price, d.number'
      'from spr_nmnt a,  dt_mtrp d'
      'where d.id_opp   = :iddoc and'
      '      d.id_nmnt  = a.id')
    Left = 504
    Top = 272
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
    Left = 536
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object ChrtQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_chrt'
      'where id = :id or code = :code')
    Left = 476
    Top = 184
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
  object MtrpQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.lenght, b.hight, b.width, b.weight, c.name'
      
        'From DH_Order a, DT_Mtrp b Left Join Spr_Strg c on c.id = b.id_s' +
        'trg'
      'Where a.id = :id and b.id_opp = a.id')
    Left = 504
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object Query: TQuery
    DatabaseName = 'RMP'
    Left = 477
  end
  object Order2Query: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(f.NTIME)/1000 As Time_F'
      'From Dh_Order a, DT_Order2  f'
      'Where a.ID = :id and f.ID_ORDER = a.ID')
    Left = 476
    Top = 62
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object Order1Query: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(g.NTIME)/1000 As Time_P'
      'From Dh_Order a, DT_Order1  g'
      'Where a.ID = :id and g.ID_ORDER = a.ID')
    Left = 476
    Top = 31
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object OrderPriceQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      '      Select Sum(NVALUE) As FAKT_TOTAL_PRICE'
      '      From DT_Order4'
      '      Where ID_ORDER = :ID_ORDER and ID_CALC = 12'
      '      ')
    Left = 512
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID_ORDER'
        ParamType = ptUnknown
      end>
  end
end
