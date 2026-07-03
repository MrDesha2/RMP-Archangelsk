object DOC_RSMODELForm: TDOC_RSMODELForm
  Left = 210
  Top = 171
  Width = 660
  Height = 465
  HelpContext = 220
  Caption = #1057#1087#1080#1089#1072#1085#1080#1077' '#1084#1086#1076#1077#1083#1077#1081
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 396
    Width = 652
    Height = 42
    Align = alBottom
    TabOrder = 0
    object Close: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = CloseClick
    end
    object OKButton: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = OKButtonClick
    end
    object PrintButton: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1055#1077#1095#1072#1090#1100
      TabOrder = 2
      Visible = False
      OnClick = PrintButtonClick
    end
    object ModelCombo: TComboEdit
      Left = 397
      Top = 5
      Width = 92
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 3
      Tablename = 'spr_mdl'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1086#1076#1077#1083#1080' ('#1042#1099#1073#1086#1088')'
      Query = qMODELQuery
      ID = -1
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 201
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 88
      Top = 8
      Width = 335
      Height = 24
      Caption = #1057#1087#1080#1089#1072#1085#1080#1077' '#1084#1086#1076#1077#1083#1077#1081' '#8470'                '#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelWRHS: TLabel
      Left = 10
      Top = 43
      Width = 94
      Height = 13
      Caption = #1057#1082#1083#1072#1076'-'#1087#1086#1083#1091#1095#1072#1090#1077#1083#1100':'
    end
    object LabelCST: TLabel
      Left = 10
      Top = 65
      Width = 83
      Height = 13
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object DateDoc: TDateEdit
      Left = 435
      Top = 10
      Width = 121
      Height = 21
      DefaultToday = True
      NumGlyphs = 2
      TabOrder = 1
      OnChange = DateDocChange
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 120
      Width = 650
      Height = 80
      Align = alBottom
      Caption = #1044#1086#1087#1086#1083#1085#1077#1085#1080#1077':'
      TabOrder = 4
      object Info: TRichEdit
        Left = 2
        Top = 15
        Width = 646
        Height = 63
        Align = alClient
        TabOrder = 0
      end
    end
    object DocNum: TMaskEdit
      Left = 308
      Top = 10
      Width = 68
      Height = 21
      EditMask = '9999999999;1; '
      MaxLength = 10
      TabOrder = 0
      Text = '          '
    end
    object WRHSCombo: TComboEdit
      Left = 109
      Top = 40
      Width = 329
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 2
      Tablename = 'SPR_WRHS'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1057#1082#1083#1072#1076#1099' ('#1042#1099#1073#1086#1088')'
      Query = qWRHSQuery
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = WRHSComboButtonClick
      OnKeyDown = WRHSComboKeyDown
    end
    object CSTCombo: TComboEdit
      Left = 109
      Top = 64
      Width = 329
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 3
      Tablename = 'spr_cst'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1055#1086#1089#1090#1072#1074#1097#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
      Query = qCSTQuery
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = CSTComboButtonClick
      OnKeyDown = CSTComboKeyDown
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 201
    Width = 652
    Height = 195
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 650
      Height = 26
      Align = alTop
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 648
        Height = 29
        Caption = 'ToolBar1'
        Flat = True
        Images = DATA.EditImages
        TabOrder = 0
        object ToolButtonAdd: TToolButton
          Left = 0
          Top = 0
          Caption = 'ToolButtonAdd'
          ImageIndex = 0
          OnClick = ToolButtonAddClick
        end
        object ToolButtonEdit: TToolButton
          Left = 23
          Top = 0
          Caption = 'ToolButtonEdit'
          ImageIndex = 1
          OnClick = ToolButtonEditClick
        end
        object ToolButtonDel: TToolButton
          Left = 46
          Top = 0
          Caption = 'ToolButtonDel'
          ImageIndex = 2
          OnClick = ToolButtonDelClick
        end
        object ToolButtonUp: TToolButton
          Left = 69
          Top = 0
          Caption = 'ToolButtonUp'
          ImageIndex = 3
          OnClick = ToolButtonUpClick
        end
        object ToolButtonDown: TToolButton
          Left = 92
          Top = 0
          Caption = 'ToolButtonDown'
          ImageIndex = 4
          OnClick = ToolButtonDownClick
        end
      end
    end
    object Grid: TDBGridEh
      Left = 1
      Top = 27
      Width = 650
      Height = 167
      Align = alClient
      AutoFitColWidths = True
      DataSource = DataSource
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnKeyDown = GridKeyDown
      Columns = <
        item
          EditButtons = <>
          FieldName = 'lineno'
          Footers = <>
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1088#1086#1082#1072
        end
        item
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'NAME'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #1052#1086#1076#1077#1083#1100
          Width = 346
          OnEditButtonClick = GridColumns1EditButtonClick
        end
        item
          EditButtons = <>
          FieldName = 'quantity'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Width = 145
        end>
    end
  end
  object qTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select doc.lineno, model.name,'
      '       doc.quantity, doc.id_model'
      ''
      'from dt_rs_model doc, spr_mdl model'
      'where doc.id_doc = :iddoc and'
      '           model.id     = doc.id_model'
      ''
      'order by doc.lineno')
    Left = 696
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'iddoc'
        ParamType = ptUnknown
      end>
  end
  object qWRHSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name , code'
      'from spr_wrhs '
      'where id = :id or code = :code')
    Left = 696
    Top = 104
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
  object qCSTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name , code'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 696
    Top = 136
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
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    SessionName = 'Default'
    Left = 696
    Top = 72
  end
  object StorProcTable: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DT_RS_MODEL_PROC'
    Left = 696
    Top = 193
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_DOC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_MODEL'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'QUANTITY'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATEDOC'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRHS'
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
  object qORDERQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, number'
      'from dh_order'
      'where id = :id or number = :number')
    Left = 736
    Top = 104
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'number'
        ParamType = ptUnknown
      end>
  end
  object qWRHS2Query: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name , code'
      'from spr_wrhs'
      'where id = :id or code = :code')
    Left = 736
    Top = 136
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
  object AddStoredProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_UPD_DH_RS_MODEL_PROC'
    Left = 736
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'NUMDOC'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_IN'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_CST'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRHS'
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
  object MemoryData: TRxMemoryData
    Active = True
    FieldDefs = <>
    Left = 513
    Top = 202
  end
  object DataSource: TDataSource
    DataSet = MemoryData
    Left = 546
    Top = 203
  end
  object qMODELQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name , code'
      'from spr_mdl'
      'where id = :id or code = :code')
    Left = 472
    Top = 396
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
