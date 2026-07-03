object DOC_RQSTEQPTForm: TDOC_RQSTEQPTForm
  Left = 247
  Top = 174
  Width = 668
  Height = 465
  HelpContext = 220
  Caption = #1047#1072#1103#1074#1072' '#1087#1086' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1091
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 13
    Top = 89
    Width = 61
    Height = 13
    Caption = #1055#1086#1089#1090#1072#1074#1097#1080#1082':'
  end
  object Panel1: TPanel
    Left = 0
    Top = 389
    Width = 660
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
    object EQPTCombo: TComboEdit
      Left = 341
      Top = 5
      Width = 44
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 3
      Tablename = 'spr_eqpt'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1054#1073#1086#1088#1091#1076#1086#1074#1072#1085#1080#1077' ('#1042#1099#1073#1086#1088')'
      Query = qEQPTQuery
      ID = -1
      CanSelectGroup = False
      Text = '<Object not found>'
      Visible = False
      OnButtonClick = WRKRComboButtonClick
      OnKeyDown = WRKRComboKeyDown
    end
    object EDIZCombo: TComboEdit
      Left = 389
      Top = 5
      Width = 44
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 4
      Tablename = 'spr_ediz'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1045#1076#1080#1085#1080#1094#1099' '#1080#1079#1084#1077#1088#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
      Query = qEDIZQuery
      ID = -1
      CanSelectGroup = False
      Text = '<Object not found>'
      Visible = False
      OnButtonClick = WRKRComboButtonClick
      OnKeyDown = WRKRComboKeyDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 660
    Height = 201
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 47
      Top = 8
      Width = 368
      Height = 24
      Caption = #1047#1072#1103#1074#1082#1072' '#1085#1072' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090' '#8470'                '#1086#1090
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
      Width = 83
      Height = 13
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077':'
    end
    object Label5: TLabel
      Left = 13
      Top = 65
      Width = 51
      Height = 13
      Caption = #1056#1072#1073#1086#1090#1085#1080#1082':'
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
      Width = 658
      Height = 80
      Align = alBottom
      Caption = #1044#1086#1087#1086#1083#1085#1077#1085#1080#1077':'
      TabOrder = 3
      object Info: TRichEdit
        Left = 2
        Top = 15
        Width = 654
        Height = 63
        Align = alClient
        TabOrder = 0
      end
    end
    object DocNum: TMaskEdit
      Left = 308
      Top = 10
      Width = 66
      Height = 21
      EditMask = '999999999;1; '
      MaxLength = 9
      TabOrder = 0
      Text = '         '
    end
    object PDRCombo: TComboEdit
      Left = 109
      Top = 40
      Width = 329
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 20
      NumGlyphs = 1
      TabOrder = 2
      Tablename = 'SPR_PDR'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' ('#1042#1099#1073#1086#1088')'
      Query = qPDRQuery
      ID = -1
      CanSelectGroup = False
      Text = '<Object not found>'
      OnButtonClick = PDRComboButtonClick
      OnKeyDown = PDRComboKeyDown
    end
    object RadioGroup1: TRadioGroup
      Left = 440
      Top = 35
      Width = 145
      Height = 65
      TabOrder = 4
    end
    object Type_doc: TRadioButton
      Left = 448
      Top = 48
      Width = 113
      Height = 17
      Caption = #1053#1072' '#1089#1082#1083#1072#1076
      TabOrder = 5
    end
    object Type_doc2: TRadioButton
      Left = 448
      Top = 72
      Width = 113
      Height = 17
      Caption = #1053#1072' '#1087#1086#1089#1090#1072#1074#1082#1091
      TabOrder = 6
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 201
    Width = 660
    Height = 188
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 658
      Height = 26
      Align = alTop
      TabOrder = 0
      object ToolBar1: TToolBar
        Left = 1
        Top = 1
        Width = 656
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
      Width = 658
      Height = 160
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
          FieldName = 'Lineno'
          Footers = <>
          ReadOnly = True
          Title.Alignment = taCenter
          Title.Caption = #1057#1090#1088#1086#1082#1072
        end
        item
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'NAME_EQPT'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
          Width = 195
          OnEditButtonClick = GridColumns1EditButtonClick
        end
        item
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'NAME_EDIZ'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #1045#1076'. '#1080#1079#1084'.'
          Width = 174
          OnEditButtonClick = GridColumns2EditButtonClick
        end
        item
          EditButtons = <>
          FieldName = 'Quantity'
          Footers = <>
          Title.Alignment = taCenter
          Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          Width = 152
        end>
    end
  end
  object WRKRCombo: TComboEdit
    Left = 109
    Top = 64
    Width = 329
    Height = 21
    GlyphKind = gkEllipsis
    ButtonWidth = 20
    NumGlyphs = 1
    TabOrder = 3
    Tablename = 'spr_wrkr'
    TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1056#1072#1073#1086#1090#1085#1080#1082#1080' ('#1042#1099#1073#1086#1088')'
    Query = qWRKRQuery
    ID = -1
    CanSelectGroup = False
    Text = '<Object not found>'
    OnButtonClick = WRKRComboButtonClick
    OnKeyDown = WRKRComboKeyDown
  end
  object qTableQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select doc.lineno, eqpt.name as name_eqpt, '
      
        '       (select name from spr_ediz where id = doc.id_ediz) as nam' +
        'e_ediz,'
      '       doc.number as quantity, doc.id_eqpt as id_eqpt,'
      '       doc.id_ediz as id_ediz'
      ''
      'from dt_rqst_eqpt doc, spr_eqpt eqpt'
      'where doc.id_doc = :iddoc and'
      '           eqpt.id    = doc.id_eqpt '
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
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name , code'
      'from spr_pdr'
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
    StoredProcName = 'ADD_DT_RQST_EQPT_PROC'
    Left = 696
    Top = 193
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_DOC'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end
      item
        DataType = ftFloat
        Name = 'NUMBER'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EDIZ'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATEDOC'
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
  object AddStoredProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'ADD_DH_RQST_EQPT_INSUPD_PROC'
    Left = 696
    Top = 224
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
        Name = 'ID_PDR'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_IN'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
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
  object qWRKRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name , code'
      'from spr_wrkr'
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
  object qEDIZQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name , code'
      'from spr_ediz'
      'where id = :id or code = :code')
    Left = 440
    Top = 376
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
  object qEQPTQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, parentid, name, code'
      'from spr_eqpt'
      'where id = :id or code = :code')
    Left = 472
    Top = 376
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
  object LogicQuery: TQuery
    DatabaseName = 'RMP'
    Left = 520
    Top = 265
  end
end
