object DOC_MTROrderForm: TDOC_MTROrderForm
  Left = 232
  Top = 174
  Width = 790
  Height = 512
  HelpContext = 230
  Caption = #1047#1072#1082#1072#1079' '#1085#1072' '#1087#1086#1089#1090#1072#1074#1082#1091' '#1084#1072#1090#1077#1088#1080#1072#1083#1086#1074
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
    Top = 444
    Width = 782
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
    object ActBill: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1055#1077#1095#1072#1090#1100
      TabOrder = 2
      OnClick = ActBillClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 257
    Align = alTop
    TabOrder = 1
    object Type_doc_Label: TLabel
      Left = 120
      Top = 16
      Width = 197
      Height = 20
      Caption = #1047#1072#1082#1072#1079' '#1085#1072' '#1084#1072#1090#1077#1088#1080#1072#1083#1099' '#8470
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
      Width = 133
      Height = 13
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077'-'#1079#1072#1082#1072#1079#1095#1080#1082':'
    end
    object Label3: TLabel
      Left = 12
      Top = 56
      Width = 61
      Height = 13
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
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
    object Label1: TLabel
      Left = 8
      Top = 104
      Width = 70
      Height = 13
      Caption = #1054#1090#1075#1088#1091#1079#1080#1090#1100' '#1076#1086':'
    end
    object Label5: TLabel
      Left = 8
      Top = 128
      Width = 76
      Height = 13
      Caption = #1057#1090#1072#1090#1091#1089' '#1079#1072#1082#1072#1079#1072':'
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
      Top = 152
      Width = 780
      Height = 104
      Align = alBottom
      Caption = #1044#1086#1087#1086#1083#1085#1077#1085#1080#1077':'
      TabOrder = 3
      object INFO: TRichEdit
        Left = 2
        Top = 15
        Width = 776
        Height = 87
        Align = alClient
        TabOrder = 0
      end
    end
    object CSTCombo: TComboEdit
      Left = 145
      Top = 52
      Width = 368
      Height = 21
      ClickKey = 16397
      GlyphKind = gkEllipsis
      NumGlyphs = 1
      TabOrder = 1
      Tablename = 'spr_cst'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1055#1086#1083#1091#1095#1072#1090#1077#1083#1080' ('#1042#1099#1073#1086#1088')'
      Query = qCSTQuery
      Text = '<Object not found>'
      OnButtonClick = CSTComboButtonClick
      OnKeyDown = CSTComboKeyDown
    end
    object PDRCombo: TComboEdit
      Left = 145
      Top = 76
      Width = 368
      Height = 21
      ClickKey = 16397
      GlyphKind = gkEllipsis
      NumGlyphs = 1
      TabOrder = 2
      Tablename = 'spr_pdr'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
      Query = qPDRQuery
      Text = '<Object not found>'
      OnButtonClick = PDRComboButtonClick
      OnKeyDown = PDRComboKeyDown
    end
    object DateEnd: TDateEdit
      Left = 144
      Top = 98
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 4
    end
    object StatusBox: TComboBox
      Left = 144
      Top = 120
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        #1053#1077#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085
        #1042' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1077
        #1047#1072#1082#1088#1099#1090)
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 257
    Width = 782
    Height = 187
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 780
      Height = 26
      Align = alTop
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 778
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
      Width = 780
      Height = 159
      Align = alClient
      ColCount = 8
      DefaultRowHeight = 17
      RowCount = 2
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
      
        'select doc.lineno, nmnt.name as nmnt, ediz.name as ediz, doc.num' +
        'ber, '
      
        '          doc.price, doc.sumdoc as nsum, nmnt.id as id_nmnt,  ed' +
        'iz.id as id_ediz,'
      
        '          doc.lenght, doc.width, doc.hight, doc.weight, doc.id_o' +
        'rd, '
      
        '          (select ord.number from dh_order ord where ord.id = do' +
        'c.id_ord) as numdoc'
      ''
      'from dt_mtrorder doc, spr_nmnt nmnt, spr_ediz ediz'
      'where doc.id = :IDDoc and'
      '           nmnt.id      = doc.id_nmnt and'
      '           ediz.id      = doc.id_ediz '
      '    '
      ''
      'order by doc.lineno')
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
    DataSet = qPDRQuery
    Left = 728
    Top = 112
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_pdr'
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
      'select id, parentid, name, code '
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
    StoredProcName = 'ADD_DH_MTRORDER_PROC'
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
  object StorProcUpdate: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'UPDATE_DH_MTRORDER_PROC'
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
      end>
  end
  object StorProcTable: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DT_MTRORDER_PROC'
    Left = 728
    Top = 225
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
  object qFormQuery: TQuery
    DatabaseName = 'RMP'
    Left = 680
    Top = 64
  end
end
