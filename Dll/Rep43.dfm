object Report43Form: TReport43Form
  Left = 183
  Top = 135
  Width = 1110
  Height = 812
  Caption = 'Report43Form'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label10: TLabel
    Left = 173
    Top = 121
    Width = 4
    Height = 16
    Caption = '/'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 65
    Top = 103
    Width = 64
    Height = 16
    Caption = #8470' '#1047#1072#1103#1074#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 183
    Top = 103
    Width = 65
    Height = 16
    Caption = #8470' '#1047#1072#1082#1072#1079#1072
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 66
    Top = 146
    Width = 90
    Height = 16
    Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 64
    Top = 24
    Width = 231
    Height = 20
    Caption = #1043#1088#1072#1092#1080#1082' '#1088#1072#1073#1086#1090#1099' '#1087#1086'  '#1047#1072#1082#1072#1079#1091'('#1072#1084')'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 133
    Top = 52
    Width = 71
    Height = 20
    Caption = #1042' '#1087#1077#1088#1080#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 182
    Top = 80
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
  object Label5: TLabel
    Left = 64
    Top = 80
    Width = 7
    Height = 16
    Caption = #1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object RqstEdit: TEdit
    Left = 65
    Top = 121
    Width = 104
    Height = 21
    TabOrder = 0
    OnExit = RqstEditExit
  end
  object OrderEdit: TEdit
    Left = 182
    Top = 121
    Width = 104
    Height = 21
    TabOrder = 1
    OnExit = OrderEditExit
  end
  object WrkrCombo: TComboEdit
    Left = 65
    Top = 164
    Width = 298
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 21
    NumGlyphs = 1
    TabOrder = 2
    ID = -1
    Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
    OnButtonClick = WrkrComboButtonClick
    OnExit = WrkrComboExit
    OnKeyDown = WrkrComboKeyDown
  end
  object OkButton: TButton
    Left = 136
    Top = 307
    Width = 72
    Height = 26
    Caption = '&'#1042#1099#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 3
    OnClick = OkButtonClick
  end
  object CloseButton: TButton
    Left = 214
    Top = 307
    Width = 72
    Height = 26
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = CloseButtonClick
  end
  object BegDateEdit: TDateEdit
    Left = 80
    Top = 76
    Width = 98
    Height = 22
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 5
  end
  object EndDateEdit: TDateEdit
    Left = 203
    Top = 76
    Width = 98
    Height = 22
    ButtonWidth = 17
    NumGlyphs = 2
    TabOrder = 6
  end
  object ButtonSelPer: TButton
    Left = 301
    Top = 76
    Width = 25
    Height = 21
    Caption = '...'
    TabOrder = 7
    OnClick = ButtonSelPerClick
  end
  object DBChart1: TDBChart
    Left = 80
    Top = 96
    Width = 929
    Height = 609
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    PrintProportional = False
    Title.Text.Strings = (
      'TDBChart')
    LeftAxis.ExactDateTime = False
    Legend.ColorWidth = 40
    Legend.TextStyle = ltsPlain
    TabOrder = 8
    object Series1: TGanttSeries
      ColorEachPoint = True
      Marks.ArrowLength = 0
      Marks.Visible = False
      DataSource = MainQuery
      SeriesColor = clRed
      Title = #1047#1072#1082#1072#1079#1072' 1'
      XLabelsSource = 'NUM_ORDER'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = True
      XValues.Name = 'Start'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      XValues.ValueSource = 'BEG_DATE'
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
      StartValues.DateTime = True
      StartValues.Name = 'Start'
      StartValues.Multiplier = 1.000000000000000000
      StartValues.Order = loAscending
      StartValues.ValueSource = 'BEG_DATE'
      EndValues.DateTime = True
      EndValues.Name = 'End'
      EndValues.Multiplier = 1.000000000000000000
      EndValues.Order = loNone
      EndValues.ValueSource = 'END_DATE'
      NextTask.DateTime = False
      NextTask.Name = 'NextTask'
      NextTask.Multiplier = 1.000000000000000000
      NextTask.Order = loNone
    end
    object Series2: TGanttSeries
      ColorEachPoint = True
      Marks.ArrowLength = 0
      Marks.Visible = False
      DataSource = MainQuery1
      SeriesColor = clGreen
      XLabelsSource = 'NUM_ORDER'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.DateTime = True
      XValues.Name = 'Start'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      XValues.ValueSource = 'BEG_DATE'
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
      StartValues.DateTime = True
      StartValues.Name = 'Start'
      StartValues.Multiplier = 1.000000000000000000
      StartValues.Order = loAscending
      StartValues.ValueSource = 'BEG_DATE'
      EndValues.DateTime = True
      EndValues.Name = 'End'
      EndValues.Multiplier = 1.000000000000000000
      EndValues.Order = loNone
      EndValues.ValueSource = 'END_DATE'
      NextTask.DateTime = False
      NextTask.Name = 'NextTask'
      NextTask.Multiplier = 1.000000000000000000
      NextTask.Order = loNone
    end
  end
  object GroupBox: TGroupBox
    Left = 64
    Top = 200
    Width = 297
    Height = 57
    Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090
    TabOrder = 9
    object PlanRadioButton: TRadioButton
      Left = 40
      Top = 24
      Width = 81
      Height = 17
      Caption = #1087#1086' '#1087#1083#1072#1085#1091
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = PlanRadioButtonClick
    end
    object FactRadioButton: TRadioButton
      Left = 144
      Top = 24
      Width = 113
      Height = 17
      Caption = #1087#1086' '#1092#1072#1082#1090#1091
      TabOrder = 1
      OnClick = FactRadioButtonClick
    end
  end
  object WrkrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_wrkr'
      'where id = :id or code = :code')
    Left = 371
    Top = 166
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
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select * '
      
        'From REPORT_43_PROCEDURE('#39'1.01.2006'#39', '#39'1.02.2006'#39', 0, 0, 18228, ' +
        ' 0)')
    Left = 368
    Top = 128
  end
  object MainQuery1: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select * '
      
        'From REPORT_43_PROCEDURE('#39'1.01.2006'#39', '#39'1.02.2006'#39', 341, 0, 0,  0' +
        ')')
    Left = 432
    Top = 56
  end
end
