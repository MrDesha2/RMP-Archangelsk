object Report19Form: TReport19Form
  Left = 237
  Top = 193
  Width = 481
  Height = 256
  Caption = #1040#1085#1072#1083#1080#1079' '#1087#1086#1074#1090#1086#1088#1103#1077#1084#1086#1089#1090#1080' '#1094#1077#1085
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
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 48
    Top = 16
    Width = 397
    Height = 36
    Caption = #1040#1085#1072#1083#1080#1079' '#1087#1086#1074#1090#1086#1088#1103#1077#1084#1086#1089#1090#1080' '#1094#1077#1085
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -30
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 160
    Top = 64
    Width = 136
    Height = 32
    Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 89
    Top = 112
    Width = 13
    Height = 25
    Caption = #1057
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 240
    Top = 112
    Width = 22
    Height = 25
    Caption = #1087#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object BegDateEdit: TDateEdit
    Left = 112
    Top = 112
    Width = 121
    Height = 26
    NumGlyphs = 2
    TabOrder = 0
  end
  object EndDateEdit: TDateEdit
    Left = 272
    Top = 112
    Width = 121
    Height = 26
    NumGlyphs = 2
    TabOrder = 1
  end
  object Button1: TButton
    Left = 160
    Top = 160
    Width = 92
    Height = 31
    Caption = '&'#1055#1077#1095#1072#1090#1100
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 256
    Top = 160
    Width = 92
    Height = 31
    Cancel = True
    Caption = '&'#1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = Button2Click
  end
  object ButtonSelPer: TButton
    Left = 398
    Top = 112
    Width = 30
    Height = 26
    Caption = '...'
    TabOrder = 4
    OnClick = ButtonSelPerClick
  end
  object Query: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select a.NUMBER, d.NUMBER, a.SUM_DOC, c.CODE, a.NUMBER_F,'
      'a.DATE_OUT, b.DATE_OUT'
      'From DH_Order a, DH_Order b, Spr_Chrt c, DH_Rqst d'
      'Where a.ID_CHRT=b.ID_CHRT    and'
      '      a.SUM_DOC <> b.SUM_DOC and '
      '      c.ID = a.ID_CHRT                        and'
      '    a.NUMBER_F > 0                  and'
      '    b.NUMBER_F > 0                     and'
      '      (c.VID_CHRT = 0 or c.VID_CHRT is NULL) and'
      '      a.SUM_DOC <> 0                        and  '
      '      b.SUM_DOC <> 0                        and'
      '      d.ID = a.ID_RQST                       and'
      '      b.PR_EXEC = 3                            and'
      '      a.PR_EXEC = 3                            and'
      '      a.DATE_OUT >= :date_beg     and'
      '      a.DATE_OUT <= :date_end     and'
      '      b.DATE_OUT >= :date_beg     and'
      '      b.DATE_OUT <= :date_end     '
      'Group by a.NUMBER, d.NUMBER, a.SUM_DOC, c.CODE, a.NUMBER_F,'
      'a.DATE_OUT, b.DATE_OUT'
      'Order by 4,1')
    Left = 416
    Top = 104
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
