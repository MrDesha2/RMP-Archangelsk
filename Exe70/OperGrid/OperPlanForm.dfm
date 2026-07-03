object OperPlan_Form: TOperPlan_Form
  Left = 369
  Top = 288
  Width = 478
  Height = 478
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #1054#1087#1077#1088#1072#1090#1080#1074#1085#1086#1077' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter: TSplitter
    Left = 0
    Top = 242
    Width = 470
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel1: TPanel
    Left = 0
    Top = 396
    Width = 470
    Height = 48
    Align = alBottom
    TabOrder = 0
    object BeginButton: TButton
      Left = 20
      Top = 13
      Width = 85
      Height = 27
      Caption = '&'#1055#1091#1089#1082
      TabOrder = 0
      OnClick = BeginButtonClick
    end
    object CloseButton: TButton
      Left = 111
      Top = 13
      Width = 85
      Height = 27
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = CloseButtonClick
    end
    object StopButton: TButton
      Left = 202
      Top = 13
      Width = 85
      Height = 27
      Caption = '&'#1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 2
      OnClick = StopButtonClick
    end
    object DelButton: TButton
      Left = 345
      Top = 13
      Width = 85
      Height = 27
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100' '#1087#1083#1072#1085
      TabOrder = 3
      OnClick = DelButtonClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 470
    Height = 242
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 20
      Top = 59
      Width = 142
      Height = 13
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 306
      Top = 59
      Width = 36
      Height = 13
      Caption = #1042#1088#1077#1084#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 20
      Top = 91
      Width = 160
      Height = 13
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 306
      Top = 91
      Width = 36
      Height = 13
      Caption = #1042#1088#1077#1084#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DinnerLabelFrom: TLabel
      Left = 33
      Top = 170
      Width = 75
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1086#1073#1077#1076#1072' '#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DinnerLabelTo: TLabel
      Left = 202
      Top = 169
      Width = 12
      Height = 13
      Caption = #1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 20
      Top = 124
      Width = 84
      Height = 13
      Caption = #1056#1072#1073#1086#1095#1080#1081'  '#1076#1077#1085#1100'  '#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 202
      Top = 124
      Width = 12
      Height = 13
      Caption = #1087#1086
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 20
      Top = 26
      Width = 83
      Height = 13
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DateTimeBeg: TDateTimePicker
      Left = 351
      Top = 55
      Width = 79
      Height = 21
      Date = 0.724261481482244600
      Time = 0.724261481482244600
      Kind = dtkTime
      TabOrder = 0
    end
    object DateTimeEnd: TDateTimePicker
      Left = 351
      Top = 88
      Width = 79
      Height = 21
      Date = 38538.724261481480000000
      Time = 38538.724261481480000000
      Kind = dtkTime
      TabOrder = 1
    end
    object DinnerCheckBox: TCheckBox
      Left = 20
      Top = 150
      Width = 247
      Height = 13
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1074#1088#1077#1084#1103' '#1086#1073#1077#1076#1072
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      OnClick = DinnerCheckBoxClick
    end
    object DinnerDateTimeFrom: TDateTimePicker
      Left = 117
      Top = 166
      Width = 79
      Height = 21
      Date = 38538.500000000000000000
      Time = 38538.500000000000000000
      Kind = dtkTime
      TabOrder = 3
    end
    object DinnerDateTimeTo: TDateTimePicker
      Left = 221
      Top = 166
      Width = 79
      Height = 21
      Date = 38538.541666666660000000
      Time = 38538.541666666660000000
      Kind = dtkTime
      TabOrder = 4
    end
    object WorkDateTimeBeg: TDateTimePicker
      Left = 117
      Top = 120
      Width = 79
      Height = 21
      Date = 38538.500000000000000000
      Time = 38538.500000000000000000
      Kind = dtkTime
      TabOrder = 5
    end
    object WorkDateTimeEnd: TDateTimePicker
      Left = 221
      Top = 120
      Width = 79
      Height = 21
      Date = 38538.500000000000000000
      Time = 38538.500000000000000000
      Kind = dtkTime
      TabOrder = 6
    end
    object OperCheckBox: TCheckBox
      Left = 20
      Top = 195
      Width = 280
      Height = 14
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1087#1088#1080#1086#1088#1080#1090#1077#1090#1085#1099#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
      TabOrder = 7
      OnClick = OperCheckBoxClick
    end
    object DateBeg: TDateEdit
      Left = 189
      Top = 55
      Width = 104
      Height = 21
      ButtonWidth = 16
      NumGlyphs = 2
      TabOrder = 8
    end
    object DateEnd: TDateEdit
      Left = 189
      Top = 87
      Width = 104
      Height = 20
      ButtonWidth = 16
      NumGlyphs = 2
      TabOrder = 9
    end
    object PdrCombo: TComboEdit
      Left = 120
      Top = 24
      Width = 305
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 10
      Tablename = 'spr_pdr'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1042#1047' ('#1042#1099#1073#1086#1088')'
      Query = qPDRQuery
      ID = -1
      OnButtonClick = PdrComboButtonClick
      OnKeyDown = PdrComboKeyDown
    end
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 383
    Width = 470
    Height = 13
    Align = alBottom
    TabOrder = 2
  end
  object OperCheckListBox: TRxCheckListBox
    Left = 0
    Top = 245
    Width = 470
    Height = 138
    Align = alBottom
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 3
    InternalVersion = 202
  end
  object OrderQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.id, a.pr_exec, a.pr_urgen, a.date_out,'
      '               a.number, a.id_chrt'
      '        From DH_Order a, JR_PLAN b'
      '        Where b.period = :PERIOD and'
      '              a.id = b.id_order and'
      '              a.pr_exec in (1,2)'
      '        Order by 2 desc, 4, 3')
    Left = 416
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'PERIOD'
        ParamType = ptUnknown
      end>
  end
  object VOPQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select b.id, b.name, a.lineno, a.ntime'
      '            From DT_Order1 a, Spr_Vop b'
      '            Where a.id_order = :TMP_ID and'
      '                  b.id = a.ID_VOP'
      '            Order by 3')
    Left = 448
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'TMP_ID'
        ParamType = ptUnknown
      end>
  end
  object CommitQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      
        'From ADD_OPERPLAN_PROC(:DATE_FROM, :DATE_TO, :TMP_ID, :TMP_ID_CH' +
        'RT, :TMP_ID_VOP, :LINENO_VOP, :TMP_NTIME, :DINNER_FROM, :DINNER_' +
        'TO, :WORK_FROM, :WORK_TO)')
    Left = 480
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'DATE_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DATE_TO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TMP_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TMP_ID_CHRT'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TMP_ID_VOP'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'LINENO_VOP'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'TMP_NTIME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DINNER_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'DINNER_TO'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WORK_FROM'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WORK_TO'
        ParamType = ptUnknown
      end>
  end
  object UpdateStoredProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'UPDATE_OPER_PROC'
    Left = 512
    Top = 160
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINENO_VOP'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_END'
        ParamType = ptInput
      end>
  end
  object OperQuery: TQuery
    DatabaseName = 'RMP'
    Left = 416
    Top = 192
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, code, name'
      'from spr_pdr where id = :id  or code = :code')
    Left = 432
    Top = 16
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
  object DelPlanStoredProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'DEL_PLAN_PROC'
    Left = 448
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PERIOD'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_END'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end>
  end
  object CreateTableStoredProc: TStoredProc
    DatabaseName = 'RMP'
    Left = 480
    Top = 192
  end
end
