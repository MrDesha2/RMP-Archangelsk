object Trance_Form: TTrance_Form
  Left = 215
  Top = 154
  BorderStyle = bsDialog
  ClientHeight = 127
  ClientWidth = 408
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 32
    Width = 101
    Height = 13
    Caption = #1055#1077#1088#1077#1085#1077#1089#1090#1080' '#1101#1083#1077#1084#1077#1085#1090
  end
  object Label2: TLabel
    Left = 48
    Top = 56
    Width = 42
    Height = 13
    Caption = #1074' '#1075#1088#1091#1087#1087#1091
  end
  object ElemName: TLabel
    Left = 160
    Top = 32
    Width = 3
    Height = 13
  end
  object Values: TComboBox
    Left = 160
    Top = 56
    Width = 233
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'Values'
  end
  object OkButton: TButton
    Left = 48
    Top = 96
    Width = 75
    Height = 25
    Caption = #1054#1050
    TabOrder = 1
    OnClick = OkButtonClick
  end
  object CancelButton: TButton
    Left = 136
    Top = 96
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 2
    OnClick = CancelButtonClick
  end
  object FormSource: TDataSource
    DataSet = qQuery
    Left = 312
    Top = 96
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 344
    Top = 96
  end
end
