object Report10Form: TReport10Form
  Left = 283
  Top = 293
  Width = 476
  Height = 371
  Caption = #1055#1083#1072#1085' '#1088#1072#1073#1086#1090
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
    Left = 166
    Top = 14
    Width = 127
    Height = 26
    Caption = #1055#1083#1072#1085' '#1088#1072#1073#1086#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 25
    Top = 71
    Width = 240
    Height = 89
    Caption = #1055#1077#1088#1080#1086#1076
    TabOrder = 0
    object MonthComboBox: TComboBox
      Left = 39
      Top = 25
      Width = 178
      Height = 24
      ItemHeight = 16
      TabOrder = 0
    end
  end
  object CancelButton: TButton
    Left = 50
    Top = 292
    Width = 375
    Height = 30
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object RadioGroup1: TRadioGroup
    Left = 267
    Top = 71
    Width = 185
    Height = 89
    Caption = #1060#1086#1088#1084#1072
    TabOrder = 1
  end
  object RadioButton1: TRadioButton
    Left = 283
    Top = 105
    Width = 137
    Height = 16
    Caption = #1076#1083#1103' '#1089#1074#1077#1088#1082#1080
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object RadioButton2: TRadioButton
    Left = 283
    Top = 128
    Width = 137
    Height = 17
    Caption = #1076#1083#1103' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1103
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 25
    Top = 160
    Width = 427
    Height = 121
    Caption = #1059#1095#1072#1089#1090#1086#1082
    TabOrder = 5
    object PDRCombo: TComboEdit
      Left = 7
      Top = 23
      Width = 250
      Height = 26
      GlyphKind = gkEllipsis
      ButtonWidth = 25
      NumGlyphs = 1
      TabOrder = 0
      ID = -1
      CanSelectGroup = False
      Text = '<Object not found>'
      OnButtonClick = PDRComboButtonClick
      OnKeyDown = PDRComboKeyDown
    end
    object ButtonOther: TButton
      Left = 73
      Top = 66
      Width = 101
      Height = 31
      Caption = #1054#1050
      TabOrder = 1
      OnClick = ButtonOtherClick
    end
    object OKButton: TButton
      Left = 267
      Top = 18
      Width = 142
      Height = 31
      Caption = #1060#1086#1088#1084#1072' '#1094#1077#1093#1072' '#1062#1052#1054
      TabOrder = 2
      OnClick = OKButtonClick
    end
    object ButtonCCR: TButton
      Left = 267
      Top = 50
      Width = 142
      Height = 31
      Caption = #1060#1086#1088#1084#1072' '#1076#1083#1103' '#1062#1062#1056
      TabOrder = 3
      OnClick = ButtonCCRClick
    end
    object ButtonCCR_2: TButton
      Left = 267
      Top = 82
      Width = 142
      Height = 31
      Caption = #1060#1086#1088#1084#1072' '#1076#1083#1103' '#1059#1052#1057
      TabOrder = 4
      OnClick = ButtonCCR_2Click
    end
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 376
    Top = 96
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
  object MainQueryAll: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.NUMBER, b.ID, b.NUMBER, c.NAME, c.ID, e.CODE, '
      'b.NUMBER_P, b.NUMBER_F, e.NAME , b.WEIGHT_F, c.PARENTID,'
      'b.DATE_OUT'
      ''
      
        'From DH_Rqst a, DH_Order b, Spr_Cst c, Spr_Pdr n, Spr_Chrt e, JR' +
        '_PLAN f'
      ''
      'Where n.id                = :pdr and '
      '             b.ID_PDR    = n.ID and '
      '             b.ID_RQST =a.ID and '
      '             f.ID_ORDER = b.ID and'
      '             c.ID                = a.ID_CST and '
      '             e.ID                = b.ID_Chrt and             '
      '             f.PERIOD       = :month'
      ''
      'Order by 11,  4')
    Left = 416
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'pdr'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'month'
        ParamType = ptUnknown
      end>
  end
  object MtchQueryCMO: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select e.NAME, d.HIGHT, d.LENGHT, d.WIDTH, d.WEIGHT'
      'From DH_Order a, Spr_Chrt b, Spr_Opch c, Spr_Mtch d, Spr_Nmnt e'
      'Where a.ID = :id and b.ID = a.ID_CHRT and c.ID_CHRT = b.ID and'
      'd.ID_OPCH = c.ID and e.ID = d.ID_NMNT')
    Left = 496
    Top = 101
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object TimeOperQueryCMO: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(g.NTIME)/1000 as AllTime'
      'From DH_Order b, Spr_Chrt e, Spr_Opch g'
      'Where b.ID = :id and e.ID = b.ID_Chrt and g.ID_CHRT = e.ID and'
      'g.ID_VOP in (Select ID'
      '             From Spr_Vop'
      '             Where PARENTID = :parentid)')
    Left = 456
    Top = 101
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'parentid'
        ParamType = ptUnknown
      end>
  end
  object MainQueryCMO: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.ID, a.NUMBER, b.NUMBER, c.CODE, c.NAME, c.id,'
      'e.CODE, b.DATE_OUT, b.NUMBER_P, e.NAME, c.PARENTID'
      ''
      'From DH_RQST a, DH_Order b, Spr_Cst c,'
      'Spr_Chrt e, JR_PLAN f'
      'Where  f.PERIOD = :month and b.ID = f.ID_ORDER'
      'and a.ID = b.ID_RQST and b.ID_PDR = :pdr'
      'and c.ID = a.ID_CST  and e.ID = b.ID_Chrt '
      ''
      'Group by b.ID, a.NUMBER, b.NUMBER, c.CODE, c.NAME, c.id,'
      'e.CODE, b.DATE_OUT, b.NUMBER_P, e.NAME, c.PARENTID'
      'Order by 11, 5')
    Left = 416
    Top = 100
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'month'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pdr'
        ParamType = ptUnknown
      end>
  end
  object MainQueryCCR: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'Select b.ID, a.NUMBER, b.NUMBER, '#39'('#39'||c.CODE||'#39')  '#39'||c.NAME as N' +
        'AME, c.id,'
      'e.CODE, b.NUMBER_P, e.NAME, c.parentid'
      ''
      'From DH_RQST a, DH_Order b, Spr_Cst c, Spr_Chrt e, JR_Plan f'
      ''
      'Where f.PERIOD = :month and b.ID = f.ID_ORDER and '
      'a.ID = b.ID_RQST '
      'and b.ID_PDR = :pdr and c.ID = a.ID_CST '
      'and e.ID = b.ID_Chrt '
      ''
      'Order by 9, 4'
      '')
    Left = 416
    Top = 126
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'month'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pdr'
        ParamType = ptUnknown
      end>
  end
  object TimeOperQueryCCR: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(g.NTIME/1000) as AllTime'
      'From DH_Order b, DT_ORDER1 g, JR_Plan f'
      'Where b.ID = :id and '
      'f.PERIOD = :month and b.ID = f.ID_ORDER '
      'and g.ID_ORDER = b.ID '
      'and g.ID_VOP in (Select ID'
      '                 From Spr_Vop'
      '                 Where PARENTID = :parentid)')
    Left = 456
    Top = 125
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'month'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'parentid'
        ParamType = ptUnknown
      end>
  end
  object MainQueryMS: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.ID, a.NUMBER, b.NUMBER, c.NAME, c.ID, e.CODE, '
      'b.NUMBER_P, b.DATE_IN, e.NAME, b.NUMBER_F, c.parentid'
      ''
      'From DH_RQST a, DH_Order b, Spr_Cst c,  '
      'Spr_Chrt e, JR_Plan f'
      ''
      'Where f.PERIOD = :month and b.ID = f.ID_ORDER '
      'and a.ID = b.ID_RQST '
      'and b.ID_PDR = :pdr and c.ID = a.ID_CST  '
      'and e.ID = b.ID_Chrt'
      ''
      'Group by b.ID, a.NUMBER, b.NUMBER, c.NAME,  c.id, e.CODE,  '
      'b.NUMBER_P, b.DATE_IN, e.NAME, b.NUMBER_F, c.parentid'
      'Order by 11, 4')
    Left = 416
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'month'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'pdr'
        ParamType = ptUnknown
      end>
  end
  object TimeOperQueryMS: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(g.NTIME/1000) as AllTime'
      'From DH_Order b, DT_ORDER2 g'
      'Where b.ID = :id '
      'and g.ID_ORDER = b.ID ')
    Left = 456
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object FailQueryMS: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.NAME'
      'From Spr_Rep a, Spr_Fail b, JR_Plan f '
      'Where a.ID_ORDER = :id and '
      'f.PERIOD =  :date  and a.ID_ORDER = f.ID_ORDER'
      'and b.ID_REP = a.ID')
    Left = 496
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date'
        ParamType = ptUnknown
      end>
  end
  object NmntAllQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select d.NAME, d.ID'
      'From  DH_Order b, Spr_Nmnt d'
      'Where b.ID = :id and'
      '              d.ID = b.ID_NMNT ')
    Left = 456
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object Order1AllQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(g.NTIME)/1000 As TIME_P'
      'From DH_Order b, DT_Order1 g'
      'Where b.ID = :id and'
      '              g.ID_ORDER = b.ID')
    Left = 496
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object Order2AllQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(f.NTIME/1000) As Time_F'
      'From DH_Order b, DT_Order2 f'
      'Where b.ID = :id and'
      '              f.ID_ORDER = b.ID')
    Left = 536
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object EdizAllQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select m.CODE'
      'From Spr_Nmnt d, Spr_Ediz m'
      'Where d.ID = :id  and '
      '              m.ID = d.ID_EDIZ ')
    Left = 576
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object NmntQueryMS: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select d.NAME, d.ID'
      'From  DH_Order b, Spr_Nmnt d'
      'Where b.ID = :id and'
      '              d.ID = b.ID_NMNT '
      '')
    Left = 536
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object Order1QueryMS: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(f.NTIME/1000) As SumPTime'
      'From DH_Order b, DT_Order1 f'
      'Where b.ID = :id and '
      '               f.ID_ORDER = b.ID')
    Left = 576
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object NmntQueryCMO: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select d.NAME, d.ID'
      'From  DH_Order b, Spr_Nmnt d'
      'Where b.ID = :id and'
      '              d.ID = b.ID_NMNT ')
    Left = 536
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object StrgQueryCMO: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select f.NAME'
      'From DH_Order b, Spr_Chrt e, Spr_Strg f'
      'Where b.ID = :id and '
      '              e.ID = b.ID_Chrt and '
      '               f.ID = e.ID_STRG')
    Left = 576
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object OpchQueryCMO: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'Select Sum(g.NTIME)/1000 As SumTime, Sum(g.PRICE)/100 As SumPric' +
        'e'
      'From DH_Order b, Spr_Chrt e, Spr_Opch g'
      'Where b.ID = :id and '
      '              e.ID = b.ID_Chrt and '
      '              g.ID_CHRT = e.ID')
    Left = 616
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object NmntQueryCCR: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select d.NAME, d.ID'
      'From  DH_Order b, Spr_Nmnt d'
      'Where b.ID = :id and'
      '              d.ID = b.ID_NMNT ')
    Left = 496
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object Order1QueryCCR: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(f.NTIME/1000)*b.NUMBER_P As SumPTime'
      'From DH_Order b, DT_Order1 f'
      'Where b.ID = :id and'
      '                f.ID_ORDER = b.ID'
      'Group by b.NUMBER_P')
    Left = 536
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object Order2QueryCCR: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(g.NTIME/1000)*b.NUMBER_F As SumFTime'
      'From DH_Order b, DT_Order2 g'
      'Where b.ID = :id and'
      '                g.ID_ORDER = b.ID'
      'Group By b.NUMBER_F')
    Left = 576
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object MonthAllQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select min(period)'
      'From Jr_plan'
      'Where id_order=:id')
    Left = 616
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object CstAllQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select ID, NAME'
      'From Spr_Cst'
      'Where ID = :id')
    Left = 648
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
