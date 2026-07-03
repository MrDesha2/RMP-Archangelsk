object Inf_OperForm: TInf_OperForm
  Left = 281
  Top = 82
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1086#1087#1077#1088#1072#1094#1080#1080
  ClientHeight = 375
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 319
    Width = 433
    Height = 56
    Align = alBottom
    TabOrder = 0
    object Label4: TLabel
      Left = 233
      Top = 32
      Width = 41
      Height = 16
      Caption = 'Label4'
    end
    object SaveButton: TButton
      Left = 16
      Top = 16
      Width = 89
      Height = 33
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = SaveButtonClick
    end
    object Button2: TButton
      Left = 112
      Top = 16
      Width = 89
      Height = 33
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 433
    Height = 319
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1042#1077#1088#1084#1103' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1086#1087#1077#1088#1072#1094#1080#1080
      object Label3: TLabel
        Left = 16
        Top = 25
        Width = 395
        Height = 24
        Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 16
        Top = 80
        Width = 315
        Height = 24
        Caption = #1042#1088#1077#1084#1103' '#1085#1072#1095#1072#1083#1072' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1086#1087#1077#1088#1072#1094#1080#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 144
        Width = 364
        Height = 24
        Caption = #1042#1088#1077#1084#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1086#1073#1088#1072#1073#1086#1090#1082#1080' '#1086#1087#1077#1088#1072#1094#1080#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -18
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object BegDateEdit: TDateEdit
        Left = 16
        Top = 112
        Width = 121
        Height = 23
        NumGlyphs = 2
        TabOrder = 0
      end
      object EndDateEdit: TDateEdit
        Left = 16
        Top = 176
        Width = 121
        Height = 23
        NumGlyphs = 2
        TabOrder = 1
      end
      object TimeEdit: TEdit
        Left = 16
        Top = 48
        Width = 121
        Height = 21
        BiDiMode = bdLeftToRight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '0'
      end
      object TimeBEG: TMaskEdit
        Left = 142
        Top = 112
        Width = 116
        Height = 21
        BiDiMode = bdRightToLeft
        EditMask = '!90:00;1; '
        MaxLength = 5
        ParentBiDiMode = False
        TabOrder = 3
        Text = '  :  '
      end
      object TimeEnd: TMaskEdit
        Left = 142
        Top = 176
        Width = 116
        Height = 21
        BiDiMode = bdRightToLeft
        EditMask = '!90:00;1; '
        MaxLength = 5
        ParentBiDiMode = False
        TabOrder = 4
        Text = '  :  '
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1086#1087#1077#1088#1072#1094#1080#1080
      ImageIndex = 1
      object Memo: TMemo
        Left = 0
        Top = 0
        Width = 423
        Height = 284
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Courier'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object TimeQuery: TQuery
    DatabaseName = 'RMP'
    Left = 300
    Top = 251
  end
  object UpdateOrd1StoredProc: TStoredProc
    DatabaseName = 'RMP'
    StoredProcName = 'UPDATE_ORDER1_PROC'
    Left = 300
    Top = 283
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ID_ORDER'
        ParamType = ptInput
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ID_CHRT'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_VOP'
        ParamType = ptInput
      end
      item
        DataType = ftSmallint
        Name = 'LINENO'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftDateTime
        Name = 'DATE_END'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TIME_BEG'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TIME_END'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_WRKR'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID_EQPT'
        ParamType = ptInput
      end>
  end
  object OldOperQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.lineno, b.name, '
      '(Select c.date_end '
      '  From DT_Order2 c '
      '  Where c.id_order = a.id_order and '
      '  c.id_vop = a.id_vop) As Date_end'
      'From DT_Order1 a, Spr_Vop b'
      'Where a.id_order = :id and'
      '      a.lineno < :line      and'
      '      b.id = a.id_vop')
    Left = 300
    Top = 315
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'line'
        ParamType = ptUnknown
      end>
  end
end
