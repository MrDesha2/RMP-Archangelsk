object DOC_RSForm: TDOC_RSForm
  Left = 200
  Top = 163
  Width = 718
  Height = 539
  HelpContext = 230
  Caption = #1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
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
    Top = 464
    Width = 710
    Height = 41
    Align = alBottom
    TabOrder = 3
    object ClostButton: TButton
      Left = 88
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = ClostButtonClick
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
    object PrintBill: TButton
      Left = 168
      Top = 8
      Width = 129
      Height = 25
      Caption = '&'#1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
      TabOrder = 2
      OnClick = PrintBillClick
    end
    object ActBill: TButton
      Left = 304
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1040#1082#1090
      TabOrder = 3
      OnClick = ActBillClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 710
    Height = 201
    Align = alTop
    TabOrder = 1
    object Type_doc_Label: TLabel
      Left = 8
      Top = 16
      Width = 209
      Height = 20
      Caption = #1056#1072#1089#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' '#8470
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 80
      Width = 101
      Height = 13
      Caption = #1057#1082#1083#1072#1076'-'#1086#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100':'
    end
    object Label3: TLabel
      Left = 12
      Top = 56
      Width = 62
      Height = 13
      Caption = #1055#1086#1083#1091#1095#1072#1090#1077#1083#1100':'
    end
    object Label4: TLabel
      Left = 392
      Top = 12
      Width = 21
      Height = 20
      Caption = #1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DateDoc: TDateEdit
      Left = 415
      Top = 12
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 0
      OnChange = DateDocChange
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 96
      Width = 708
      Height = 104
      Align = alBottom
      Caption = #1044#1086#1087#1086#1083#1085#1077#1085#1080#1077':'
      TabOrder = 7
      object INFO: TRichEdit
        Left = 2
        Top = 15
        Width = 704
        Height = 87
        Align = alClient
        TabOrder = 0
      end
    end
    object CSTCombo: TComboEdit
      Left = 115
      Top = 52
      Width = 368
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 4
      Tablename = 'spr_cst'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1055#1086#1083#1091#1095#1072#1090#1077#1083#1080' ('#1042#1099#1073#1086#1088')'
      Query = qCSTQuery
      ID = -1
      CanSelectGroup = False
      Text = '<Object not found>'
      OnButtonClick = CSTComboButtonClick
      OnKeyDown = CSTComboKeyDown
    end
    object WRHSCombo: TComboEdit
      Left = 115
      Top = 76
      Width = 368
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 5
      Tablename = 'spr_wrhs'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1052#1077#1089#1090#1072' '#1093#1088#1072#1085#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
      Query = qWRHSQuery
      ID = -1
      CanSelectGroup = False
      Text = '<Object not found>'
      OnButtonClick = WRHSComboButtonClick
      OnKeyDown = WRHSComboKeyDown
    end
    object IS_ready: TCheckBox
      Left = 488
      Top = 79
      Width = 81
      Height = 17
      Caption = #1055#1086#1076#1087#1080#1089#1072#1085#1072
      TabOrder = 6
    end
    object Type_doc: TRadioGroup
      Left = 542
      Top = 8
      Width = 163
      Height = 57
      Caption = #1058#1080#1087' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      TabOrder = 1
    end
    object Type_doc1: TRadioButton
      Left = 552
      Top = 24
      Width = 113
      Height = 17
      Caption = #1056#1072#1089#1093#1086#1076#1085#1072#1103
      TabOrder = 2
      OnClick = Type_doc1Click
    end
    object Type_doc2: TRadioButton
      Left = 552
      Top = 40
      Width = 145
      Height = 17
      Caption = #1040#1082#1090' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1088#1072#1073#1086#1090
      TabOrder = 3
      OnClick = Type_doc1Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 201
    Width = 710
    Height = 263
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 708
      Height = 26
      Align = alTop
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 706
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
    object GridTable: TStringGrid
      Left = 1
      Top = 27
      Width = 708
      Height = 235
      Align = alClient
      ColCount = 8
      DefaultRowHeight = 17
      RowCount = 2
      GridLineWidth = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 1
      OnDblClick = ToolButtonEditClick
      OnKeyDown = GridTableKeyDown
      ColWidths = (
        20
        62
        226
        110
        90
        64
        64
        64)
    end
  end
  object DocNum: TMaskEdit
    Left = 320
    Top = 12
    Width = 68
    Height = 21
    EditMask = '9999999999;1; '
    MaxLength = 10
    TabOrder = 0
    Text = '          '
  end
  object TableSource: TDataSource
    DataSet = qTableQuery
    Left = 728
    Top = 48
  end
  object qTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select doc.lineno, nmnt.name as nmnt, ed.name as ediz,'
      '           doc.number, doc.price, doc.nsum, nmnt.id as id_nmnt,'
      '           ed.id as id_ediz, doc.id_ord, '
      
        '           (select ord.number from dh_order ord where ord.id = d' +
        'oc.id_ord) as numdoc,'
      '          doc.lenght, doc.width, doc.hight, doc.weight,'
      '          0 as id_pdr, 0 as name_pdr'
      ''
      'from dt_rs doc, spr_nmnt nmnt, spr_ediz ed'
      'where doc.id_rsmtr = :iddoc and'
      '           nmnt.id      = doc.id_nmnt and'
      '           ed.id      = doc.id_ediz '
      ''
      'order by lineno           ')
    Left = 760
    Top = 48
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDDoc'
        ParamType = ptUnknown
      end>
  end
  object WRHSSource: TDataSource
    DataSet = qWRHSQuery
    Left = 728
    Top = 112
  end
  object qWRHSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_wrhs'
      'where id= :id or code = :code'
      '')
    Left = 761
    Top = 112
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
      'select id, parentid, name, parentid, code '
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 761
    Top = 144
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
  object CSTSource: TDataSource
    DataSet = qCSTQuery
    Left = 729
    Top = 144
  end
  object StorProcAdd: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DH_RS_PROC'
    Left = 729
    Top = 168
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
        Name = 'ID_WRHS'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
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
        Name = 'TYPE_DOC'
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
  object StorProcUpdate: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'UPDATE_DH_RS_PROC'
    Left = 730
    Top = 197
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
        Name = 'ID_WRHS'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
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
        Name = 'TYPE_DOC'
        ParamType = ptInput
      end>
  end
  object StorProcTable: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DT_RS_PROC'
    Left = 728
    Top = 225
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_RS'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATEDOC'
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
        DataType = ftInteger
        Name = 'ID_ORD'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRHS'
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
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    Left = 680
    Top = 64
  end
end
