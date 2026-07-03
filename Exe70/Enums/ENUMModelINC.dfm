object ENUM_MODELINCEdit: TENUM_MODELINCEdit
  Left = 192
  Top = 153
  Width = 536
  Height = 289
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1088#1080#1073#1099#1083#1080' '#1084#1086#1076#1077#1083#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 528
    Height = 216
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1072#1103
      object Label1: TLabel
        Left = 40
        Top = 24
        Width = 79
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      end
      object Label2: TLabel
        Left = 40
        Top = 48
        Width = 62
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086':'
      end
      object INCREMENT_NAME: TEdit
        Left = 127
        Top = 23
        Width = 330
        Height = 21
        TabOrder = 0
      end
      object INCREMENT_NUMBER: TCurrencyEdit
        Left = 128
        Top = 48
        Width = 121
        Height = 21
        AutoSize = False
        TabOrder = 1
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1061#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
      ImageIndex = 1
      object ToolBarCh: TToolBar
        Left = 0
        Top = 0
        Width = 520
        Height = 24
        Caption = 'ToolBarCh'
        Flat = True
        Images = DATA.EditImages
        TabOrder = 0
        object ToolAddChar: TToolButton
          Left = 0
          Top = 0
          Caption = 'ToolAddChar'
          ImageIndex = 0
          OnClick = ToolAddCharClick
        end
        object ToolEditChar: TToolButton
          Left = 23
          Top = 0
          Caption = 'ToolEditChar'
          ImageIndex = 1
          OnClick = ToolEditCharClick
        end
        object ToolDelChar: TToolButton
          Left = 46
          Top = 0
          Caption = 'ToolDelChar'
          ImageIndex = 2
          OnClick = ToolDelCharClick
        end
      end
      object CHEQGrid: TDBGridEh
        Left = 0
        Top = 24
        Width = 520
        Height = 164
        Align = alClient
        AutoFitColWidths = True
        DataSource = DataSourceModel
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        OnDblClick = ToolEditCharClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'NAME'
            Footers = <>
            Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 157
          end
          item
            DisplayFormat = ',0.000;-,0.000'
            EditButtons = <>
            FieldName = 'NSIZE'
            Footers = <>
            Title.Caption = #1056#1072#1079#1084#1077#1088
            Width = 124
          end
          item
            EditButtons = <>
            FieldName = 'KIND'
            Footers = <>
            Title.Caption = #1058#1080#1087
            Width = 109
          end>
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 216
    Width = 528
    Height = 46
    Align = alBottom
    TabOrder = 1
    object ButtonOK: TButton
      Left = 296
      Top = 16
      Width = 75
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 0
      OnClick = ButtonOKClick
    end
    object ButtonClose: TButton
      Left = 376
      Top = 16
      Width = 75
      Height = 25
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = ButtonCloseClick
    end
  end
  object qCHMODELQuery: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'select b.id, a.name, b.nsize, b.kind '
      'from spr_vchr a, SPR_MODELINCREMCHARACTER b '
      'where a.ID = b.id_VID and b.ID_MODELINC= :id'
      'order by name')
    Left = 360
    Top = 32
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end>
  end
  object DataSourceModel: TDataSource
    DataSet = qCHMODELQuery
    Left = 397
    Top = 33
  end
  object qQuery: TQuery
    DatabaseName = 'RMP'
    Left = 512
    Top = 88
  end
  object qQueryUpdate: TQuery
    DatabaseName = 'RMP'
    SQL.Strings = (
      'update spr_pdr '
      'set CODE = :code, NAME = :name , MAX_TIME = :maxtime'
      'where'
      '  ID =  :ID')
    Left = 512
    Top = 56
    ParamData = <
      item
        DataType = ftFloat
        Name = 'CODE'
        ParamType = ptUnknown
        Value = '0'
      end
      item
        DataType = ftString
        Name = 'NAME'
        ParamType = ptUnknown
        Value = ''
      end
      item
        DataType = ftInteger
        Name = 'MAXTIME'
        ParamType = ptUnknown
        Value = 0
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptUnknown
        Value = 0
      end>
  end
end
