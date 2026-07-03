object JR_GantForm: TJR_GantForm
  Left = 237
  Top = 209
  Width = 717
  Height = 472
  Caption = #1044#1080#1072#1075#1088#1072#1084#1084#1072' '#1043#1072#1085#1090#1072
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
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 259
    Width = 709
    Height = 2
    Cursor = crVSplit
    Align = alBottom
  end
  object Panel1: TPanel
    Left = 0
    Top = 405
    Width = 709
    Height = 33
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 319
      Top = 13
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 618
      Top = 13
      Width = 32
      Height = 13
      Caption = 'Label2'
    end
  end
  object OperGrid: TDBGridEh
    Left = 0
    Top = 261
    Width = 709
    Height = 144
    Align = alBottom
    DataSource = OperDataSource
    DragCursor = crDefault
    DragKind = dkDock
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
    OnCellClick = OperGridCellClick
    OnDragOver = OperGridDragOver
    OnMouseDown = OperGridMouseDown
    OnMouseMove = OperGridMouseMove
    Columns = <
      item
        EditButtons = <>
        FieldName = 'LINENO'
        Footers = <>
        Title.Caption = #8470' '#1086#1087#1077#1088#1072#1094#1080#1080
        Width = 52
      end
      item
        EditButtons = <>
        FieldName = 'NAMEOP'
        Footers = <>
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1087#1077#1088#1072#1094#1080#1080
        Width = 52
      end
      item
        EditButtons = <>
        FieldName = 'NTIME'
        Footers = <>
        Title.Caption = #1042#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
        Width = 209
      end>
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 709
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 2
  end
  object GantGrid: TStringGrid
    Left = 0
    Top = 29
    Width = 709
    Height = 230
    Align = alClient
    BiDiMode = bdLeftToRight
    ColCount = 24
    Ctl3D = False
    FixedCols = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goTabs, goAlwaysShowEditor]
    ParentBiDiMode = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 3
    OnClick = GantGridClick
    OnDragOver = GantGridDragOver
    OnEndDrag = GantGridEndDrag
    OnMouseMove = GantGridMouseMove
    OnMouseUp = GantGridMouseUp
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
end
