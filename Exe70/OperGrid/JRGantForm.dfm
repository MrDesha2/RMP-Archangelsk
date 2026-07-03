object JR_GantForm: TJR_GantForm
  Left = 101
  Top = 161
  Width = 862
  Height = 542
  Caption = #1044#1080#1072#1075#1088#1072#1084#1084#1072' '#1043#1072#1085#1090#1072
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
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 0
    Top = 282
    Width = 854
    Height = 2
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel1: TPanel
    Left = 0
    Top = 460
    Width = 854
    Height = 42
    Align = alBottom
    TabOrder = 0
    object ButtonClose: TButton
      Left = 926
      Top = 6
      Width = 92
      Height = 31
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 0
      OnClick = ButtonCloseClick
    end
  end
  object OperGrid: TDBGridEh
    Left = 0
    Top = 284
    Width = 854
    Height = 176
    Align = alBottom
    DataSource = OperDataSource
    DragCursor = crMultiDrag
    DragKind = dkDock
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -13
    FooterFont.Name = 'MS Sans Serif'
    FooterFont.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = OperGridCellClick
    OnDragOver = OperGridDragOver
    OnMouseDown = OperGridMouseDown
    Columns = <
      item
        EditButtons = <>
        FieldName = 'LINENO'
        Footers = <>
        Title.Caption = #8470' '#1086#1087#1077#1088#1072#1094#1080#1080
      end
      item
        EditButtons = <>
        FieldName = 'NAMEOP'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
      end
      item
        EditButtons = <>
        FieldName = 'NTIME'
        Footers = <>
        Title.Caption = #1042#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
        Width = 257
      end>
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 854
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 2
  end
  object GantGrid: TStringGrid
    Left = 0
    Top = 29
    Width = 854
    Height = 253
    Align = alClient
    BiDiMode = bdLeftToRight
    ColCount = 24
    Ctl3D = False
    FixedCols = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goTabs, goAlwaysShowEditor]
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    OnClick = GantGridClick
    OnDblClick = GantGridDblClick
    OnDragOver = GantGridDragOver
    OnEndDrag = GantGridEndDrag
    OnKeyDown = GantGridKeyDown
    OnMouseMove = GantGridMouseMove
    OnRowMoved = GantGridRowMoved
    OnTopLeftChanged = GantGridTopLeftChanged
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
  end
  object GantOperQuery: TQuery
    AfterScroll = GantOperQueryAfterScroll
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      'From BROWSE_GANTOPER_PROC(9698)')
    Left = 776
    Top = 480
  end
  object OperDataSource: TDataSource
    DataSet = GantOperQuery
    Left = 808
    Top = 480
  end
  object WEVQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      'From Wrkr_Eqpt_Vop_Proc(:wrkr, :eqpt, :vop)')
    Left = 776
    Top = 512
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'wrkr'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'eqpt'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'vop'
        ParamType = ptUnknown
      end>
  end
  object DateTimeQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      
        'From Wrkr_Eqpt_Busy_Proc(:wrkr_id, :eqpt_id, :date_in, :date_out' +
        ')'
      '')
    Left = 776
    Top = 544
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'wrkr_id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'eqpt_id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date_in'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date_out'
        ParamType = ptUnknown
      end>
  end
  object UpdateOrd1StoredProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'UPDATE_ORDER1_PROC'
    Left = 808
    Top = 512
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_ORDER'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ID_CHRT'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ID_VOP'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftDateTime
        Name = 'DATE_BEG'
        ParamType = ptInput
        Value = 0d
      end
      item
        DataType = ftDateTime
        Name = 'DATE_END'
        ParamType = ptInput
        Value = 0d
      end
      item
        DataType = ftString
        Name = 'TIME_BEG'
        ParamType = ptInput
        Value = ''
      end
      item
        DataType = ftString
        Name = 'TIME_END'
        ParamType = ptInput
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
        Value = 0
      end>
  end
  object HintQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select * '
      
        'From INFO_OPER_PROC(:BEG_DATE, :END_DATE, :BEG_TIME, :END_TIME, ' +
        ':WRKR_ID, :EQPT_ID)')
    Left = 808
    Top = 544
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'BEG_DATE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'END_DATE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'BEG_TIME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'END_TIME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WRKR_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EQPT_ID'
        ParamType = ptUnknown
      end>
  end
  object InfoOperQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      
        'From INFO_OPER_PROC(:BEG_DATE, :END_DATE, :BEG_TIME, :END_TIME, ' +
        ':WRKR_ID, :EQPT_ID)')
    Left = 840
    Top = 480
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'BEG_DATE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'END_DATE'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'BEG_TIME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'END_TIME'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'WRKR_ID'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'EQPT_ID'
        ParamType = ptUnknown
      end>
  end
end
