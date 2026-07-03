object Report26Form: TReport26Form
  Left = 380
  Top = 237
  Width = 437
  Height = 376
  HelpContext = 400
  Caption = #1051#1080#1084#1080#1090#1085#1086'-'#1079#1072#1073#1086#1088#1085#1072#1103' '#1082#1072#1088#1090#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 429
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 80
      Top = 4
      Width = 292
      Height = 29
      Caption = #1051#1080#1084#1080#1090#1085#1086'-'#1079#1072#1073#1086#1088#1085#1072#1103' '#1082#1072#1088#1090#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -25
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object PlanPageControl: TPageControl
    Left = 0
    Top = 41
    Width = 429
    Height = 295
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1055#1083#1072#1085#1086#1074#1072#1103
      object Label2: TLabel
        Left = 9
        Top = 55
        Width = 67
        Height = 16
        Caption = #1085#1072' '#1087#1077#1088#1080#1086#1076
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 7
        Top = 80
        Width = 63
        Height = 16
        Caption = #1047#1072#1082#1072#1079#1095#1080#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 7
        Top = 105
        Width = 104
        Height = 32
        Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object MonthComboBox: TComboBox
        Left = 133
        Top = 48
        Width = 176
        Height = 24
        ItemHeight = 16
        TabOrder = 0
      end
      object PlanCstCombo: TComboEdit
        Left = 135
        Top = 80
        Width = 272
        Height = 27
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        TabOrder = 1
        Text = '<Object not found>'
        OnButtonClick = PlanCstComboButtonClick
        OnKeyDown = PlanCstComboKeyDown
      end
      object PlanPdrCombo: TComboEdit
        Left = 135
        Top = 113
        Width = 272
        Height = 26
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        TabOrder = 2
        Text = '<Object not found>'
        OnButtonClick = PlanPdrComboButtonClick
        OnKeyDown = PlanPdrComboKeyDown
      end
      object PlanButtonOK: TButton
        Left = 73
        Top = 197
        Width = 112
        Height = 33
        Caption = '&'#1055#1077#1095#1072#1090#1100
        TabOrder = 3
        OnClick = PlanButtonOKClick
      end
      object PlanButtonNO: TButton
        Left = 208
        Top = 197
        Width = 113
        Height = 33
        Cancel = True
        Caption = '&'#1054#1090#1084#1077#1085#1072
        TabOrder = 4
        OnClick = PlanButtonNOClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1072#1103
      ImageIndex = 1
      object Label6: TLabel
        Left = 5
        Top = 95
        Width = 63
        Height = 16
        Caption = #1047#1072#1082#1072#1079#1095#1080#1082
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 5
        Top = 119
        Width = 104
        Height = 32
        Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label9: TLabel
        Left = 43
        Top = 55
        Width = 9
        Height = 16
        Caption = #1057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 194
        Top = 55
        Width = 16
        Height = 16
        Caption = #1087#1086
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 25
        Top = 16
        Width = 338
        Height = 26
        Caption = #1087#1086' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1085#1099#1084' '#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -23
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object FactButtonOK: TButton
        Left = 100
        Top = 177
        Width = 113
        Height = 33
        Caption = '&'#1055#1077#1095#1072#1090#1100
        TabOrder = 0
        OnClick = FactButtonOKClick
      end
      object FactButtonNO: TButton
        Left = 236
        Top = 177
        Width = 112
        Height = 33
        Cancel = True
        Caption = '&'#1054#1090#1084#1077#1085#1072
        TabOrder = 1
        OnClick = PlanButtonNOClick
      end
      object FactCstCombo: TComboEdit
        Left = 110
        Top = 89
        Width = 273
        Height = 25
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        TabOrder = 2
        Text = '<Object not found>'
        OnButtonClick = FactCstComboButtonClick
        OnKeyDown = FactCstComboKeyDown
      end
      object FactPdrCombo: TComboEdit
        Left = 110
        Top = 126
        Width = 273
        Height = 25
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        TabOrder = 3
        Text = '<Object not found>'
        OnButtonClick = FactPdrComboButtonClick
        OnKeyDown = FactPdrComboKeyDown
      end
      object BegDateEdit: TDateEdit
        Left = 62
        Top = 53
        Width = 121
        Height = 26
        NumGlyphs = 2
        TabOrder = 4
      end
      object EndDateEdit: TDateEdit
        Left = 222
        Top = 53
        Width = 121
        Height = 26
        NumGlyphs = 2
        TabOrder = 5
      end
      object ButtonSelPer: TButton
        Left = 351
        Top = 50
        Width = 31
        Height = 26
        Caption = '...'
        TabOrder = 6
        OnClick = ButtonSelPerClick
      end
    end
  end
  object PlanMainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 24
    Top = 160
  end
  object PlanTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select d.number, b.number, a.number, b.date_in'
      'From DT_Mtrp a, DH_Order b, JR_Plan c, DH_Rqst d'
      'Where c.period = :period and'
      'b.id = c.id_order and'
      'a.id_opp = b.id and'
      'a.id_nmnt = :id and'
      'd.id = b.id_rqst'
      'Order By 1,2')
    Left = 24
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'period'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 368
    Top = 208
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
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code'
      '')
    Left = 368
    Top = 168
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
  object FactMainQuery: TQuery
    DatabaseName = 'RMP'
    Left = 24
    Top = 240
  end
  object FactTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select d.number, b.number, a.number, b.date_in'
      'From DT_Mtrf a, DH_Order b, DT_Order2 c, DH_Rqst d'
      'Where c.date_end >= :begdate and'
      'c.date_end <= :enddate and'
      'b.id = c.id_order and'
      'a.id_opf = b.id and'
      'a.id_nmnt = :id and'
      'd.id = b.id_rqst and'
      'a.Lineno = c.lineno'
      'Order By 1,2')
    Left = 24
    Top = 272
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'begdate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'enddate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object SumFactQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select SUM(a.number) as SumFact'
      'From DT_Mtrf a, DH_Order b, DT_Order2 c'
      'Where c.date_end >= :begdate and'
      'c.date_end <= :enddate and'
      'b.id = c.id_order and'
      'a.id_opf = b.id and'
      'a.id_nmnt = :id and'
      'a.Lineno = c.lineno'
      '')
    Left = 25
    Top = 322
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'begdate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'enddate'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object SumPlanQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(a.number)  as SumPlan'
      ' From DT_Mtrp a, DH_Order b, JR_Plan c'
      ' Where c.period >= :begperiod and c.period <= :endperiod and'
      ' b.id = c.id_order and'
      ' a.id_opp = b.id and'
      ' a.id_nmnt = :id')
    Left = 60
    Top = 322
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'begperiod'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'endperiod'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
end
