object Report29Form: TReport29Form
  Left = 382
  Top = 139
  Width = 638
  Height = 664
  Caption = #1048#1085#1074#1077#1085#1090#1072#1088#1080#1079#1072#1094#1080#1086#1085#1085#1072#1103' '#1086#1087#1080#1089#1100
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
  object Splitter1: TSplitter
    Left = 0
    Top = 185
    Width = 630
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 244
    Width = 630
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Splitter3: TSplitter
    Left = 0
    Top = 327
    Width = 630
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Splitter4: TSplitter
    Left = 0
    Top = 577
    Width = 630
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object Splitter5: TSplitter
    Left = 0
    Top = 450
    Width = 630
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 630
    Height = 185
    Align = alTop
    TabOrder = 0
    object Label6: TLabel
      Left = 151
      Top = 7
      Width = 253
      Height = 24
      Caption = #1048#1085#1074#1077#1085#1090#1072#1088#1080#1079#1072#1094#1080#1086#1085#1085#1072#1103' '#1086#1087#1080#1089#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 138
      Top = 27
      Width = 287
      Height = 24
      Caption = #1085#1077#1079#1072#1074#1077#1088#1096#1077#1085#1085#1086#1075#1086' '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 215
      Top = 59
      Width = 21
      Height = 24
      Caption = #1085#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 63
      Top = 93
      Width = 63
      Height = 16
      Caption = #1047#1072#1082#1072#1079#1095#1080#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 23
      Top = 114
      Width = 104
      Height = 32
      Caption = #1054#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object EndDateEdit: TDateEdit
      Left = 239
      Top = 63
      Width = 99
      Height = 21
      ButtonWidth = 16
      NumGlyphs = 2
      TabOrder = 0
    end
    object CstCombo: TComboEdit
      Left = 133
      Top = 88
      Width = 292
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 1
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = CstComboButtonClick
      OnKeyDown = CstComboKeyDown
    end
    object PdrCombo: TComboEdit
      Left = 133
      Top = 118
      Width = 292
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 2
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = PdrComboButtonClick
      OnKeyDown = PdrComboKeyDown
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 188
    Width = 630
    Height = 56
    Align = alTop
    TabOrder = 1
    object Label3: TLabel
      Left = 32
      Top = 16
      Width = 66
      Height = 16
      Caption = #1055#1088#1080#1082#1072#1079' '#8470
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 192
      Top = 16
      Width = 15
      Height = 16
      Caption = #1086#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object OrderEdit: TEdit
      Left = 112
      Top = 16
      Width = 73
      Height = 21
      TabOrder = 0
    end
    object OrderDateEdit: TDateEdit
      Left = 215
      Top = 16
      Width = 99
      Height = 21
      ButtonWidth = 16
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 247
    Width = 630
    Height = 80
    Align = alTop
    TabOrder = 2
    object Label8: TLabel
      Left = 8
      Top = 16
      Width = 217
      Height = 16
      Caption = #1052#1072#1090#1077#1088#1080#1072#1083#1100#1085#1086' '#1086#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077'('#1099#1077')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object ResponsibleCombo2: TComboEdit
      Left = 229
      Top = 40
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 0
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = ResponsibleCombo2ButtonClick
      OnKeyDown = ResponsibleCombo2KeyDown
    end
    object ResponsibleCombo1: TComboEdit
      Left = 229
      Top = 16
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 1
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = ResponsibleCombo1ButtonClick
      OnKeyDown = ResponsibleCombo1KeyDown
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 330
    Width = 630
    Height = 120
    Align = alTop
    TabOrder = 3
    object Label9: TLabel
      Left = 8
      Top = 16
      Width = 163
      Height = 16
      Caption = #1055#1088#1077#1076#1089#1077#1076#1072#1090#1077#1083#1100' '#1082#1086#1084#1080#1089#1089#1080#1080':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 12
      Top = 40
      Width = 110
      Height = 16
      Caption = #1063#1083#1077#1085#1099' '#1082#1086#1084#1080#1089#1089#1080#1080':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 170
      Top = 44
      Width = 9
      Height = 13
      Caption = '1.'
    end
    object Label12: TLabel
      Left = 170
      Top = 68
      Width = 9
      Height = 13
      Caption = '2.'
    end
    object Label13: TLabel
      Left = 170
      Top = 92
      Width = 9
      Height = 13
      Caption = '3.'
    end
    object presidentCombo: TComboEdit
      Left = 181
      Top = 16
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 0
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = presidentComboButtonClick
      OnKeyDown = presidentComboKeyDown
    end
    object MemberCombo1: TComboEdit
      Left = 181
      Top = 40
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 1
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = MemberCombo1ButtonClick
      OnKeyDown = MemberCombo1KeyDown
    end
    object MemberCombo2: TComboEdit
      Left = 181
      Top = 64
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 2
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = MemberCombo2ButtonClick
      OnKeyDown = MemberCombo2KeyDown
    end
    object MemberCombo3: TComboEdit
      Left = 181
      Top = 88
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 3
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = MemberCombo3ButtonClick
      OnKeyDown = MemberCombo3KeyDown
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 453
    Width = 630
    Height = 124
    Align = alClient
    TabOrder = 4
    object Label14: TLabel
      Left = 8
      Top = 16
      Width = 319
      Height = 16
      Caption = #1051#1080#1094#1086'('#1072'), '#1086#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1077'('#1099#1077') '#1079#1072' '#1089#1086#1093#1088#1072#1085#1085#1086#1089#1090#1100' '#1058#1052#1062':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 170
      Top = 44
      Width = 9
      Height = 13
      Caption = '1.'
    end
    object Label16: TLabel
      Left = 170
      Top = 68
      Width = 9
      Height = 13
      Caption = '2.'
    end
    object Label17: TLabel
      Left = 170
      Top = 92
      Width = 9
      Height = 13
      Caption = '3.'
    end
    object StockmanCombo1: TComboEdit
      Left = 181
      Top = 40
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 0
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = StockmanCombo1ButtonClick
      OnKeyDown = StockmanCombo1KeyDown
    end
    object StockmanCombo2: TComboEdit
      Left = 181
      Top = 64
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 1
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = StockmanCombo2ButtonClick
      OnKeyDown = StockmanCombo2KeyDown
    end
    object StockmanCombo3: TComboEdit
      Left = 181
      Top = 88
      Width = 356
      Height = 21
      GlyphKind = gkEllipsis
      ButtonWidth = 16
      NumGlyphs = 1
      TabOrder = 2
      ID = -1
      Text = '<Object not found>'
      OnButtonClick = StockmanCombo3ButtonClick
      OnKeyDown = StockmanCombo3KeyDown
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 580
    Width = 630
    Height = 50
    Align = alBottom
    TabOrder = 5
    object ButtonOK: TButton
      Left = 204
      Top = 16
      Width = 91
      Height = 26
      Caption = '&'#1055#1077#1095#1072#1090#1100
      TabOrder = 0
      OnClick = ButtonOKClick
    end
    object ButtonNO: TButton
      Left = 306
      Top = 16
      Width = 92
      Height = 26
      Cancel = True
      Caption = '&'#1054#1090#1084#1077#1085#1072
      TabOrder = 1
      OnClick = ButtonNOClick
    end
  end
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      'From REPORT_29_PROCEDURE(:id_pdr, :id_cst, :date_out)'
      'Order By Code_Pdr, Number_Rqst, Number_Order')
    Left = 440
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id_pdr'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_cst'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date_out'
        ParamType = ptUnknown
      end>
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 424
    Top = 168
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
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code'
      '')
    Left = 424
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
  object WrkrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from Spr_Wrkr'
      'where id = :id or code = :code')
    Left = 576
    Top = 204
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
