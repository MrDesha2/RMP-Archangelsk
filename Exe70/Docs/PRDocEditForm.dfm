object DOC_PRForm: TDOC_PRForm
  Left = 247
  Top = 174
  Width = 719
  Height = 516
  HelpContext = 220
  Caption = #1055#1088#1080#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103
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
    Top = 440
    Width = 711
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
      OnClick = PrintButtonClick
    end
    object Button1: TButton
      Left = 248
      Top = 8
      Width = 75
      Height = 25
      Caption = '&'#1055#1077#1095#1072#1090#1100'_2'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 711
    Height = 201
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 40
      Top = 8
      Width = 363
      Height = 24
      Caption = #1055#1088#1080#1093#1086#1076#1085#1072#1103' '#1085#1072#1082#1083#1072#1076#1085#1072#1103' '#8470'                '#1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 10
      Top = 43
      Width = 94
      Height = 13
      Caption = #1057#1082#1083#1072#1076'-'#1087#1086#1083#1091#1095#1072#1090#1077#1083#1100':'
    end
    object Label3: TLabel
      Left = 13
      Top = 65
      Width = 61
      Height = 13
      Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
    end
    object Label4: TLabel
      Left = 440
      Top = 40
      Width = 92
      Height = 13
      Caption = #1055#1088#1080#1079#1085#1072#1082' '#1095#1077#1088#1090#1077#1078#1072':'
    end
    object DateDoc: TDateEdit
      Left = 415
      Top = 12
      Width = 121
      Height = 21
      DefaultToday = True
      NumGlyphs = 2
      TabOrder = 1
      OnChange = DateDocChange
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 88
      Width = 709
      Height = 112
      Align = alBottom
      Caption = #1044#1086#1087#1086#1083#1085#1077#1085#1080#1077':'
      TabOrder = 4
      object Info: TRichEdit
        Left = 2
        Top = 15
        Width = 705
        Height = 95
        Align = alClient
        TabOrder = 0
      end
    end
    object DocNum: TMaskEdit
      Left = 288
      Top = 12
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
      CanSelectGroup = False
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
      CanSelectGroup = False
      Text = '<Object not found>'
      OnButtonClick = CSTComboButtonClick
      OnKeyDown = CSTComboKeyDown
    end
    object PR_CHRTCombo: TComboBox
      Left = 536
      Top = 40
      Width = 113
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        #1048#1079#1075#1086#1090#1086#1074#1083#1077#1085#1080#1077
        #1056#1077#1084#1086#1085#1090)
    end
    object PR_EXEC: TCheckBox
      Left = 442
      Top = 72
      Width = 79
      Height = 13
      Caption = #1055#1086#1076#1087#1080#1089#1072#1085#1072
      TabOrder = 6
    end
    object ButtonCheckPrice: TButton
      Left = 536
      Top = 64
      Width = 113
      Height = 25
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1094#1077#1085#1099
      TabOrder = 7
      OnClick = ButtonCheckPriceClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 201
    Width = 711
    Height = 239
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 709
      Height = 26
      Align = alTop
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 707
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
      Width = 709
      Height = 211
      Align = alClient
      ColCount = 7
      DefaultRowHeight = 17
      RowCount = 2
      GridLineWidth = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 1
      OnDblClick = ToolButtonEditClick
      OnKeyDown = GridTableKeyDown
      ColWidths = (
        20
        66
        210
        127
        69
        64
        84)
      RowHeights = (
        17
        17)
    end
  end
  object qTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select doc.lineno, nmnt.name as nmnt, ed.name as ediz,'
      '       doc.number, doc.price, doc.nsum, nmnt.id as id_nmnt,'
      '       ed.id as id_ediz, doc.id_ord as id_ord,'
      
        '       (select ord.number from dh_order ord where ord.id = doc.i' +
        'd_ord) as numdoc,'
      '       doc.lenght, doc.width, doc.hight, doc.weight,'
      '       0 as id_pdr, 0 as name_pdr'
      ''
      'from dt_pr doc, spr_nmnt nmnt, spr_ediz ed'
      'where doc.id_prmtr = :IDDoc and'
      '           nmnt.id    = doc.id_nmnt and'
      '           ed.id      = doc.id_ediz'
      ''
      'order by doc.lineno')
    Left = 696
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDDoc'
        ParamType = ptUnknown
      end>
  end
  object qWRHSQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
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
  object StorProcAdd: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DH_PR_PROC'
    Left = 697
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
        DataType = ftInteger
        Name = 'PR_CHRT'
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
    StoredProcName = 'UPDATE_DH_PR_PROC'
    Left = 698
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
        DataType = ftBlob
        Name = 'INFO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PR_CHRT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PR_EXEC'
        ParamType = ptInput
      end>
  end
  object StorProcTable: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DT_PR_PROC'
    Left = 696
    Top = 225
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_PRMTR'
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
        Name = 'ID_WRHS'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_ORD'
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
end
