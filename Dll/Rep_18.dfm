object Report_18Form: TReport_18Form
  Left = 305
  Top = 194
  Width = 707
  Height = 626
  Caption = #1054#1090#1095#1077#1090' '#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1088#1072#1073#1086#1090#1072#1093
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
  object Splitter1: TSplitter
    Left = 287
    Top = 49
    Width = 2
    Height = 543
    MinSize = 10
    OnMoved = Splitter1Moved
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 699
    Height = 49
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label4: TLabel
      Left = 216
      Top = 0
      Width = 306
      Height = 26
      Caption = #1054#1090#1095#1077#1090' '#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1088#1072#1073#1086#1090#1072#1093
    end
    object Label6: TLabel
      Left = 296
      Top = 24
      Width = 148
      Height = 16
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1080#1081' '#1086#1090#1095#1077#1090
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 289
    Top = 49
    Width = 410
    Height = 543
    Align = alClient
    TabOrder = 1
    object Splitter2: TSplitter
      Left = 1
      Top = 183
      Width = 408
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter3: TSplitter
      Left = 1
      Top = 389
      Width = 408
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object Panel3: TPanel
      Left = 1
      Top = 185
      Width = 408
      Height = 204
      Align = alClient
      TabOrder = 0
      object Label5: TLabel
        Left = 13
        Top = 13
        Width = 170
        Height = 13
        Caption = #1057#1086#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072' '#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074':'
      end
      object CstAddButton: TButton
        Left = 10
        Top = 73
        Width = 108
        Height = 25
        Hint = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1074' '#1090#1072#1073#1083#1080#1094#1091' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' ('#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074')'
        Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = CstAddButtonClick
      end
      object CstCombo: TComboEdit
        Left = 7
        Top = 34
        Width = 226
        Height = 21
        Hint = #1042#1099#1073#1086#1088' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' ('#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074')'
        GlyphKind = gkEllipsis
        ButtonWidth = 21
        NumGlyphs = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ID = -1
        CanSelectGroup = False
        Text = '<Object not found>'
        OnButtonClick = CstComboButtonClick
        OnKeyDown = CstComboKeyDown
      end
      object CstDelButton: TButton
        Left = 131
        Top = 73
        Width = 102
        Height = 25
        Hint = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1074' '#1090#1072#1073#1083#1080#1094#1091' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' ('#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074')'
        Caption = '&'#1059#1076#1072#1083#1080#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = CstDelButtonClick
      end
      object Button4: TButton
        Left = 10
        Top = 106
        Width = 224
        Height = 25
        Caption = '&'#1044#1086#1073#1072#1074#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
        TabOrder = 3
        OnClick = Button4Click
      end
      object CheckBox: TCheckBox
        Left = 13
        Top = 137
        Width = 228
        Height = 13
        Caption = #1044#1077#1090#1072#1083#1080#1079#1072#1094#1080#1103' '#1087#1086'  '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103#1084
        TabOrder = 4
        OnClick = CheckBoxClick
      end
      object TaxCheckBox: TCheckBox
        Left = 13
        Top = 160
        Width = 252
        Height = 17
        Caption = #1042#1099#1074#1086#1076#1080#1090#1100' '#1089' '#1053#1044#1057' '#1087#1086' '#1074#1085#1077#1096#1085#1080#1084' '#1079#1072#1082#1072#1079#1095#1080#1082#1072#1084
        TabOrder = 5
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 408
      Height = 182
      Align = alTop
      TabOrder = 1
      object Label1: TLabel
        Left = 9
        Top = 28
        Width = 7
        Height = 13
        Caption = #1057
      end
      object Label2: TLabel
        Left = 144
        Top = 28
        Width = 12
        Height = 13
        Caption = #1087#1086
      end
      object Button2: TButton
        Left = 17
        Top = 54
        Width = 280
        Height = 25
        Hint = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' '#1041#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1086#1075#1086' '#1086#1090#1095#1077#1090#1072
        Caption = #1054#1090#1095#1077#1090' '#1087#1086' &'#1091#1089#1083#1091#1075#1072#1084
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 17
        Top = 118
        Width = 280
        Height = 25
        Cancel = True
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100
        TabOrder = 3
        OnClick = Button1Click
      end
      object BegDateEdit: TDateEdit
        Left = 23
        Top = 22
        Width = 110
        Height = 21
        ButtonWidth = 21
        NumGlyphs = 2
        TabOrder = 0
      end
      object EndDateEdit: TDateEdit
        Left = 163
        Top = 22
        Width = 110
        Height = 21
        ButtonWidth = 21
        NumGlyphs = 2
        TabOrder = 1
      end
      object ButtonSelPer: TButton
        Left = 275
        Top = 21
        Width = 25
        Height = 21
        Caption = '...'
        TabOrder = 4
        OnClick = ButtonSelPerClick
      end
      object Button3: TButton
        Left = 17
        Top = 86
        Width = 280
        Height = 25
        Hint = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' '#1041#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1086#1075#1086' '#1086#1090#1095#1077#1090#1072
        Caption = #1054#1090#1095#1077#1090' '#1087#1086' &'#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = Button2Click
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 392
      Width = 408
      Height = 150
      Align = alBottom
      TabOrder = 2
      object Label3: TLabel
        Left = 13
        Top = 13
        Width = 26
        Height = 13
        Caption = #1052#1042#1047':'
      end
      object PdrCombo: TComboEdit
        Left = 15
        Top = 33
        Width = 234
        Height = 21
        Hint = #1042#1099#1073#1086#1088' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' ('#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074')'
        GlyphKind = gkEllipsis
        ButtonWidth = 21
        NumGlyphs = 1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ID = -1
        CanSelectGroup = False
        Text = '<Object not found>'
        OnButtonClick = PdrComboButtonClick
        OnKeyDown = PdrComboKeyDown
      end
      object PdrAddButton: TButton
        Left = 10
        Top = 73
        Width = 108
        Height = 25
        Hint = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1074' '#1090#1072#1073#1083#1080#1094#1091' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' ('#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074')'
        Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = PdrAddButtonClick
      end
      object PdrDelButton: TButton
        Left = 131
        Top = 73
        Width = 102
        Height = 25
        Hint = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1074' '#1090#1072#1073#1083#1080#1094#1091' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' ('#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074')'
        Caption = '&'#1059#1076#1072#1083#1080#1090#1100
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = PdrDelButtonClick
      end
      object Button7: TButton
        Left = 10
        Top = 109
        Width = 224
        Height = 25
        Caption = '&'#1044#1086#1073#1072#1074#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080
        TabOrder = 3
        OnClick = Button7Click
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 49
    Width = 287
    Height = 543
    Align = alLeft
    TabOrder = 2
    object Splitter4: TSplitter
      Left = 1
      Top = 309
      Width = 285
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object CstStringGrid: TStringGrid
      Left = 1
      Top = 1
      Width = 285
      Height = 308
      Hint = 
        #1057#1087#1080#1089#1086#1082' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' ('#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074') '#1076#1083#1103' '#13#10#1082#1086#1090#1086#1088#1099#1093' '#1075#1086#1090#1086#1074#1080#1090#1089#1103' '#1073#1091#1093#1075#1072#1083#1090#1077 +
        #1088#1089#1082#1080#1081' '#1086#1090#1095#1077#1090
      Align = alClient
      ColCount = 2
      DefaultColWidth = 300
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goRowMoving]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ColWidths = (
        344
        300)
    end
    object PdrStringGrid: TStringGrid
      Left = 1
      Top = 312
      Width = 285
      Height = 230
      Hint = 
        #1057#1087#1080#1089#1086#1082' '#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1081' '#1087#1086' '#13#10#1082#1086#1090#1086#1088#1099#1084' '#1092#1086#1088#1084#1080#1088#1091#1077#1090#1089#1103' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1080#1081' '#1086#1090#1095#1077 +
        #1090
      Align = alBottom
      ColCount = 2
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goRowMoving]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      ColWidths = (
        342
        64)
    end
  end
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 640
    Top = 328
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
  object MainQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      
        'From REPORT18_PROCEDURE(:stat, :id_cst, :id_pdr, :code_pdr, :beg' +
        '_date, :end_date, :tax, :chert)'
      '')
    Left = 664
    Top = 128
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'stat'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_cst'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'id_pdr'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'code_pdr'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'beg_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'end_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'tax'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'chert'
        ParamType = ptUnknown
      end>
  end
  object IdCstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select ID'
      'From Spr_Cst'
      'Where  ID = :id')
    Left = 664
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object ActTrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      
        'From REPORT18_PROCEDURE_ACT(:NAME_CST, :ID_PDR, :CODE_PDR, :BEG_' +
        'DATE, :END_DATE, :TAX)')
    Left = 608
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NAME_CST'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_PDR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CODE_PDR'
        ParamType = ptUnknown
      end
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
        Name = 'TAX'
        ParamType = ptUnknown
      end>
  end
  object GridCstQuery: TQuery
    DatabaseName = 'RMP'
    Left = 246
    Top = 60
  end
  object NaklQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select *'
      
        'From REPORT18_PROCEDURE_NAKL(:NAME_CST, :ID_PDR, :CODE_PDR, :BEG' +
        '_DATE, :END_DATE, :TAX)')
    Left = 640
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'NAME_CST'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'ID_PDR'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'CODE_PDR'
        ParamType = ptUnknown
      end
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
        Name = 'TAX'
        ParamType = ptUnknown
      end>
  end
  object RSMtrQuery: TQuery
    DatabaseName = 'RMP'
    Left = 665
    Top = 193
  end
  object PdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_pdr'
      'where id = :id or code = :code'
      '')
    Left = 562
    Top = 458
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
  object IdPdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select ID, CODE'
      'From Spr_Pdr'
      'Where  NAME = :name'
      '')
    Left = 624
    Top = 192
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'name'
        ParamType = ptUnknown
      end>
  end
  object GridPdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select distinct c.code, c.name, c.id'
      'From DH_Order b, Spr_Pdr c, DH_Rqst d,'
      '     Spr_Chrt e, DH_PR f, DT_PR g'
      'Where f.date_in >= :date_beg and'
      '      f.date_in <= :date_end and'
      '      f.PR_EXEC = 1        and'
      '      g.ID_PRMTR = f.ID    and'
      '      b.ID = g.ID_ORD      and'
      '      d.ID = b.ID_RQST     and'
      '      c.id = d.id_pdr      and'
      '      e.ID = b.ID_CHRT     and'
      '      (e.VID_CHRT = 0 or e.VID_CHRT is NULL)'
      'Union'
      'Select distinct c.code, c.name, c.id'
      'From DH_Order b, Spr_Pdr c, DH_Rqst d,'
      '     Spr_Chrt e, DH_RS f, DT_RS g'
      'Where f.date_in >= :date_beg and'
      '      f.date_in <= :date_end and'
      '      f.PR_EXEC = 1        and'
      '      g.ID_RSMTR = f.ID    and'
      '      b.ID = g.ID_ORD      and'
      '      d.ID = b.ID_RQST     and'
      '      c.id = d.id_pdr      and'
      '      e.ID = b.ID_CHRT     and'
      '      e.VID_CHRT = 1'
      'Order by  1')
    Left = 288
    Top = 444
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'date_beg'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date_end'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date_beg'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'date_end'
        ParamType = ptUnknown
      end>
  end
end
