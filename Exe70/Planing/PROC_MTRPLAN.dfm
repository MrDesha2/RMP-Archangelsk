object PROC_MTR_PLANForm: TPROC_MTR_PLANForm
  Left = 253
  Top = 120
  Width = 558
  Height = 551
  Caption = #1055#1083#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
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
  object PanelBot: TPanel
    Left = 0
    Top = 474
    Width = 550
    Height = 50
    Align = alBottom
    TabOrder = 0
    object ButtonDo: TButton
      Left = 8
      Top = 16
      Width = 89
      Height = 25
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = ButtonDoClick
    end
    object ButtonCancel: TButton
      Left = 104
      Top = 16
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = ButtonCancelClick
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 550
    Height = 474
    Align = alClient
    TabOrder = 1
    object ToolBarMtFt: TToolBar
      Left = 1
      Top = 1
      Width = 548
      Height = 25
      Caption = 'ToolBarMtFt'
      Flat = True
      Images = MAINForm.MainImages
      TabOrder = 0
      object ButtonAddFactMt: TToolButton
        Left = 0
        Top = 0
        Hint = #1053#1086#1074#1099#1081
        Caption = 'ButtonAddFactMt'
        Enabled = False
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = True
      end
      object ButtonEditFactMt: TToolButton
        Left = 23
        Top = 0
        Caption = 'ButtonEditFactMt'
        Enabled = False
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
      end
      object ButtonDelFactMt: TToolButton
        Left = 46
        Top = 0
        Hint = #1059#1076#1072#1083#1080#1090#1100
        Caption = 'ButtonDelFactMt'
        ImageIndex = 3
        ParentShowHint = False
        ShowHint = True
        OnClick = ButtonDelFactMtClick
      end
      object ButtonUpFactMt: TToolButton
        Left = 69
        Top = 0
        Hint = #1042#1074#1077#1088#1093
        Caption = 'ButtonUpFactMt'
        ImageIndex = 28
        ParentShowHint = False
        ShowHint = True
        OnClick = ButtonUpFactMtClick
      end
      object ButtonDownFactMt: TToolButton
        Left = 92
        Top = 0
        Hint = #1042#1085#1080#1079
        Caption = 'ButtonDownFactMt'
        ImageIndex = 29
        ParentShowHint = False
        ShowHint = True
        OnClick = ButtonDownFactMtClick
      end
    end
    object Grid_Mtr: TStringGrid
      Left = 1
      Top = 57
      Width = 548
      Height = 374
      Align = alClient
      ColCount = 7
      DefaultRowHeight = 17
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 1
      ColWidths = (
        15
        37
        116
        112
        99
        64
        64)
    end
    object Panel1: TPanel
      Left = 1
      Top = 431
      Width = 548
      Height = 42
      Align = alBottom
      TabOrder = 2
      object Label1: TLabel
        Left = 24
        Top = 8
        Width = 42
        Height = 13
        Caption = #1053#1072' '#1076#1072#1090#1091':'
      end
      object DateEdit: TDateEdit
        Left = 72
        Top = 8
        Width = 121
        Height = 21
        NumGlyphs = 2
        TabOrder = 0
      end
      object ButtonRef: TButton
        Left = 216
        Top = 8
        Width = 75
        Height = 25
        Caption = #1054#1073#1085#1086#1074#1080#1090#1100
        TabOrder = 1
        OnClick = ButtonRefClick
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 26
      Width = 548
      Height = 31
      Align = alTop
      TabOrder = 3
      object Label4: TLabel
        Left = 17
        Top = 10
        Width = 53
        Height = 13
        Caption = #1052#1072#1090#1077#1088#1080#1072#1083':'
      end
      object NMNTCombo: TComboEdit
        Left = 96
        Top = 5
        Width = 281
        Height = 21
        HelpContext = 101
        ClickKey = 16397
        GlyphKind = gkEllipsis
        NumGlyphs = 1
        TabOrder = 0
        Tablename = 'spr_nmnt'
        TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1053#1086#1084#1077#1085#1082#1083#1072#1090#1091#1088#1072' ('#1042#1099#1073#1086#1088')'
        Query = qNMNTQuery
        Text = '<'#1054#1073#1098#1077#1082#1090' '#1085#1077' '#1085#1072#1081#1076#1077#1085'>'
        OnButtonClick = NMNTComboButtonClick
        OnKeyDown = NMNTComboKeyDown
      end
      object Button1: TButton
        Left = 376
        Top = 5
        Width = 21
        Height = 20
        Caption = 'X'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
  end
  object qSelQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'select mtr.name, mtr.id, mtr.code, ord2.number, ord.number, ord.' +
        'id'
      'from spr_nmnt mtr, dh_order ord, dt_mtrp ord2, jr_plan pln'
      'where'
      '    pln.period    =  :period and'
      '    pln.id_order  = ord.id and'
      '    ord2.id_opp   = pln.id_order and'
      '    ord2.id_nmnt  = mtr.id and'
      '    not mtr.id in'
      ''
      '(select mtr.id'
      'from dt_mtrf ord3'
      'where ord3.id_opf   = pln.id_order)'
      ''
      'order by ord.id')
    Left = 464
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'period'
        ParamType = ptUnknown
      end>
  end
  object StorProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DH_MTRORDER_PROC'
    Left = 464
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'NUMDOC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CST'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_IN'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATEEND'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PR_EXEC'
        ParamType = ptInput
      end
      item
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'IDDOC'
        ParamType = ptOutput
      end
      item
        DataType = ftInteger
        Name = 'NEWNUMDOC'
        ParamType = ptOutput
      end>
  end
  object StorProcTable: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DT_MTRORDER_PROC'
    Left = 464
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_NMNT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'PRICE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'LENG'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'HIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'WIDTH'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'WEIGHT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_ORD'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'ERROR'
        ParamType = ptOutput
      end
      item
        DataType = ftFloat
        Name = 'REM_VALUE'
        ParamType = ptOutput
      end>
  end
  object qNMNTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_nmnt'
      'where id = :id or code = :code')
    Left = 501
    Top = 50
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
end
