object DOCT_CALCForm: TDOCT_CALCForm
  Left = 243
  Top = 180
  HelpContext = 215
  BorderStyle = bsDialog
  Caption = #1047#1072#1090#1088#1072#1090#1099' '#1079#1072#1082#1072#1079#1072
  ClientHeight = 117
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PanelMain: TPanel
    Left = 0
    Top = 0
    Width = 467
    Height = 77
    Align = alClient
    TabOrder = 0
    object Label3: TLabel
      Left = 17
      Top = 27
      Width = 59
      Height = 13
      Caption = #1042#1080#1076' '#1079#1072#1090#1088#1072#1090':'
    end
    object Label5: TLabel
      Left = 17
      Top = 51
      Width = 58
      Height = 13
      Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100':'
    end
    object NValueEdit: TCurrencyEdit
      Left = 128
      Top = 48
      Width = 121
      Height = 21
      AutoSize = False
      CheckOnExit = True
      DisplayFormat = ',0.00'#1088#39'.'#39';-,0,00'#1088#39'.'#39
      TabOrder = 1
      OnChange = CALCComboChange
    end
    object CALCCombo: TComboEdit
      Left = 128
      Top = 24
      Width = 329
      Height = 21
      ClickKey = 16397
      GlyphKind = gkEllipsis
      NumGlyphs = 1
      TabOrder = 0
      Tablename = 'SPR_CALC'
      TableDescription = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082': '#1047#1072#1090#1088#1072#1090#1099' ('#1042#1099#1073#1086#1088')'
      Query = qCALCQuery
      OnButtonClick = CALCComboButtonClick
      OnKeyDown = CALCComboKeyDown
    end
  end
  object PanelButton: TPanel
    Left = 0
    Top = 77
    Width = 467
    Height = 40
    Align = alBottom
    TabOrder = 1
    object CloseButton: TButton
      Left = 88
      Top = 7
      Width = 75
      Height = 25
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = CloseButtonClick
    end
    object OKButton: TButton
      Left = 8
      Top = 7
      Width = 75
      Height = 25
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = OKButtonClick
    end
  end
  object qCALCQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select id, name, code'
      'from spr_calc'
      'where id = :id or code = :code'
      '')
    Left = 520
    Top = 24
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
