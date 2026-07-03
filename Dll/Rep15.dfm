object Report15Form: TReport15Form
  Left = 192
  Top = 158
  Width = 696
  Height = 770
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
    Height = 687
    MinSize = 10
    OnMoved = Splitter1Moved
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 49
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label3: TLabel
      Left = 192
      Top = 0
      Width = 306
      Height = 26
      Caption = #1054#1090#1095#1077#1090' '#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1088#1072#1073#1086#1090#1072#1093
    end
    object Label4: TLabel
      Left = 288
      Top = 24
      Width = 139
      Height = 16
      Caption = #1041#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1080#1081' '#1086#1090#1095#1077#1090
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
    Width = 399
    Height = 687
    Align = alClient
    TabOrder = 1
    object Splitter3: TSplitter
      Left = 1
      Top = 170
      Width = 397
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object Splitter4: TSplitter
      Left = 1
      Top = 482
      Width = 397
      Height = 1
      Cursor = crVSplit
      Align = alBottom
    end
    object Panel3: TPanel
      Left = 1
      Top = 172
      Width = 397
      Height = 310
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
        Width = 234
        Height = 25
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
    end
    object Panel5: TPanel
      Left = 1
      Top = 483
      Width = 397
      Height = 203
      Align = alBottom
      TabOrder = 1
      object Label6: TLabel
        Left = 13
        Top = 13
        Width = 189
        Height = 13
        Caption = #1057#1086#1089#1090#1072#1074#1083#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1081':'
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
      object PdrComboEdit: TComboEdit
        Left = 7
        Top = 34
        Width = 234
        Height = 25
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
        OnButtonClick = PdrComboEditButtonClick
        OnKeyDown = PdrComboEditKeyDown
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
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 397
      Height = 169
      Align = alTop
      TabOrder = 2
      object Label1: TLabel
        Left = 9
        Top = 28
        Width = 7
        Height = 13
        Caption = #1057
      end
      object Label2: TLabel
        Left = 132
        Top = 28
        Width = 12
        Height = 13
        Caption = #1087#1086
      end
      object ReportButton: TButton
        Left = 17
        Top = 60
        Width = 224
        Height = 25
        Hint = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' '#1041#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1086#1075#1086' '#1086#1090#1095#1077#1090#1072
        Caption = #1054#1090#1095#1077#1090' '#1087#1086' &'#1084#1072#1090#1077#1088#1080#1072#1083#1072#1084
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = ReportButtonClick
      end
      object Button2: TButton
        Left = 17
        Top = 93
        Width = 224
        Height = 25
        Hint = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103' '#1041#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1086#1075#1086' '#1086#1090#1095#1077#1090#1072
        Caption = '&'#1054#1090#1095#1077#1090' '#1087#1086' '#1091#1089#1083#1091#1075#1072#1084
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 17
        Top = 125
        Width = 224
        Height = 25
        Cancel = True
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100
        TabOrder = 4
        OnClick = Button1Click
      end
      object BegDateEdit: TDateEdit
        Left = 23
        Top = 22
        Width = 106
        Height = 21
        ButtonWidth = 21
        NumGlyphs = 2
        TabOrder = 0
      end
      object EndDateEdit: TDateEdit
        Left = 152
        Top = 22
        Width = 104
        Height = 21
        ButtonWidth = 21
        NumGlyphs = 2
        TabOrder = 1
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 49
    Width = 287
    Height = 687
    Align = alLeft
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 1
      Top = 430
      Width = 285
      Height = 1
      Cursor = crVSplit
      Align = alBottom
      MinSize = 10
    end
    object CstStringGrid: TStringGrid
      Left = 1
      Top = 1
      Width = 285
      Height = 429
      Hint = 
        #1057#1087#1080#1089#1086#1082' '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' ('#1079#1072#1082#1072#1079#1095#1080#1082#1086#1074') '#1076#1083#1103' '#13#10#1082#1086#1090#1086#1088#1099#1093' '#1075#1086#1090#1086#1074#1080#1090#1089#1103' '#1073#1091#1093#1075#1072#1083#1090#1077 +
        #1088#1089#1082#1080#1081' '#1086#1090#1095#1077#1090
      Align = alClient
      ColCount = 1
      DefaultColWidth = 300
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goRowMoving]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ColWidths = (
        344)
    end
    object PdrStringGrid: TStringGrid
      Left = 1
      Top = 431
      Width = 285
      Height = 255
      Hint = 
        #1057#1087#1080#1089#1086#1082' '#1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1081' '#1087#1086' '#13#10#1082#1086#1090#1086#1088#1099#1084' '#1092#1086#1088#1084#1080#1088#1091#1077#1090#1089#1103' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1089#1082#1080#1081' '#1086#1090#1095#1077 +
        #1090
      Align = alBottom
      ColCount = 1
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSizing, goColSizing, goRowMoving]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      ColWidths = (
        342)
    end
  end
  object ButtonSetPeriod: TButton
    Left = 545
    Top = 71
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 3
    OnClick = ButtonSetPeriodClick
  end
  object CstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_cst'
      'where id = :id or code = :code')
    Left = 656
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
      
        'From REPORT_15_PROCEDURE(:calc, :id_pdr, :id_cst, :beg_date, :en' +
        'd_date)'
      '')
    Left = 600
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'calc'
        ParamType = ptUnknown
      end
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
        Name = 'beg_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'end_date'
        ParamType = ptUnknown
      end>
  end
  object IdCstQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select ID'
      'From Spr_Cst'
      'Where NAME = :name')
    Left = 632
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'name'
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
    Left = 632
    Top = 288
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'name'
        ParamType = ptUnknown
      end>
  end
  object ActTrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select Sum(a.Sum_Doc) As Price'
      'From Dh_Order a, Dh_Rqst b'
      'Where b.ID_CST = :id_cst and b.ID_PDR = :id_pdr and  '
      
        '              a.DATE_OUT>=:beg_date and a.DATE_OUT<=:end_date an' +
        'd'
      '              a.ID_RQST = b.ID'
      ''
      '')
    Left = 600
    Top = 288
    ParamData = <
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
        Name = 'beg_date'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'end_date'
        ParamType = ptUnknown
      end>
  end
  object GridCstQuery: TQuery
    DatabaseName = 'RMP'
    Left = 270
    Top = 68
  end
  object qPDRQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name'
      'from spr_pdr'
      'where id = :id or code = :code')
    Left = 660
    Top = 528
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
  object GridPdrQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select c.code, c.name'
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
      'Select c.code, c.name'
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
