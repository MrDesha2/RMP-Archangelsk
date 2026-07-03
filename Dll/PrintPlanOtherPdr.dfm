object FormPlanOtherPdr: TFormPlanOtherPdr
  Left = 192
  Top = 121
  Width = 282
  Height = 356
  Caption = 'План отчет'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 24
    Top = 16
    Width = 225
    Height = 97
    Caption = 'Период'
    TabOrder = 0
    object Label1: TLabel
      Left = 7
      Top = 43
      Width = 71
      Height = 16
      Caption = 'На период'
    end
    object DateEdit: TDateEdit
      Left = 88
      Top = 40
      Width = 129
      Height = 21
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 24
    Top = 120
    Width = 225
    Height = 105
    Caption = 'Участок'
    TabOrder = 1
    object PdrComboBox: TComboBox
      Left = 16
      Top = 40
      Width = 193
      Height = 24
      ItemHeight = 16
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 40
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Оk'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 144
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Отмена'
    TabOrder = 3
    OnClick = Button2Click
  end
  object DataSource: TDataSource
    DataSet = Query
    Left = 72
    Top = 264
  end
  object Query: TQuery
    Active = True
    DatabaseName = 'RMP'
    SQL.Strings = (
      
        'Select a.NUMBER, b.NUMBER, c.NAME, d.NAME, e.CODE, m.NAME, b.NUM' +
        'BER_P, b.NUMBER_F,'
      'Sum(f.NTIME) As Time_F, Sum(g.NTIME) As TIME_P'
      
        'From DH_Rqst a, DH_Order b, Spr_Cst c, Spr_Nmnt d, Spr_Chrt e, S' +
        'pr_Ediz m,'
      'DH_Order h left join DT_Order1 g on g.ID_ORDER = h.ID, '
      'DH_Order k left join DT_Order2 f on f.ID_ORDER = k.ID '
      'Where a.ID = b.ID_RQST and c.ID = a.ID_CST and'
      'd.ID = b.ID_NMNT and e.ID = b.ID_Chrt and'
      'm.ID = d.ID_EDIZ  and (g.ID_ORDER = b.ID or f.ID_ORDER = b.ID)'
      
        'Group by a.NUMBER, b.NUMBER, c.NAME, d.NAME, e.CODE, m.NAME, b.N' +
        'UMBER_P, b.NUMBER_F')
    Left = 40
    Top = 264
  end
  object BDEPipeline: TppBDEPipeline
    DataSource = DataSource
    UserName = 'BDEPipeline'
    Left = 104
    Top = 264
    object BDEPipelineppField1: TppField
      Alignment = taRightJustify
      FieldAlias = 'NUMBER'
      FieldName = 'NUMBER'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 0
      Position = 0
    end
    object BDEPipelineppField2: TppField
      Alignment = taRightJustify
      FieldAlias = 'NUMBER_1'
      FieldName = 'NUMBER_1'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 1
    end
    object BDEPipelineppField3: TppField
      FieldAlias = 'NAME'
      FieldName = 'NAME'
      FieldLength = 50
      DisplayWidth = 50
      Position = 2
    end
    object BDEPipelineppField4: TppField
      FieldAlias = 'NAME_1'
      FieldName = 'NAME_1'
      FieldLength = 50
      DisplayWidth = 50
      Position = 3
    end
    object BDEPipelineppField5: TppField
      FieldAlias = 'CODE'
      FieldName = 'CODE'
      FieldLength = 14
      DisplayWidth = 14
      Position = 4
    end
    object BDEPipelineppField6: TppField
      FieldAlias = 'NAME_2'
      FieldName = 'NAME_2'
      FieldLength = 30
      DisplayWidth = 30
      Position = 5
    end
    object BDEPipelineppField7: TppField
      Alignment = taRightJustify
      FieldAlias = 'NUMBER_P'
      FieldName = 'NUMBER_P'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 6
    end
    object BDEPipelineppField8: TppField
      Alignment = taRightJustify
      FieldAlias = 'NUMBER_F'
      FieldName = 'NUMBER_F'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 7
    end
    object BDEPipelineppField9: TppField
      Alignment = taRightJustify
      FieldAlias = 'TIME_F'
      FieldName = 'TIME_F'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 8
    end
    object BDEPipelineppField10: TppField
      Alignment = taRightJustify
      FieldAlias = 'TIME_P'
      FieldName = 'TIME_P'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 9
    end
  end
  object Report: TppReport
    AutoStop = False
    DataPipeline = BDEPipeline
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.Orientation = poLandscape
    PrinterSetup.PaperName = 'A4 210 x 297 мм'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 6350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 6350
    PrinterSetup.mmPaperHeight = 210000
    PrinterSetup.mmPaperWidth = 297000
    PrinterSetup.PaperSize = 9
    DeviceType = 'Screen'
    Left = 136
    Top = 264
    Version = '6.02'
    mmColumnWidth = 0
    DataPipelineName = 'BDEPipeline'
    object ppTitleBand1: TppTitleBand
      mmBottomOffset = 0
      mmHeight = 38523
      mmPrintPosition = 0
      object ppLabel1: TppLabel
        UserName = 'Label1'
        AutoSize = False
        Caption = 'Утверждаю'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 209550
        mmTop = 2117
        mmWidth = 18415
        BandType = 1
      end
      object ppLabel2: TppLabel
        UserName = 'Label2'
        AutoSize = False
        Caption = 'Гл. механик ОАО "АЦБК"'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 209762
        mmTop = 6773
        mmWidth = 40217
        BandType = 1
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = '"             "_____________200    г.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 209762
        mmTop = 13335
        mmWidth = 49530
        BandType = 1
      end
      object TitleLabel1: TppLabel
        UserName = 'TitleLabel1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5080
        mmLeft = 140759
        mmTop = 21802
        mmWidth = 17780
        BandType = 1
      end
      object TitleLabel2: TppLabel
        UserName = 'TitleLabel2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 12
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 5080
        mmLeft = 140759
        mmTop = 28363
        mmWidth = 17780
        BandType = 1
      end
    end
    object ppHeaderBand1: TppHeaderBand
      mmBottomOffset = 0
      mmHeight = 19473
      mmPrintPosition = 0
      object ppShape2: TppShape
        UserName = 'Shape2'
        mmHeight = 15452
        mmLeft = 217170
        mmTop = 635
        mmWidth = 34925
        BandType = 0
      end
      object ppShape14: TppShape
        UserName = 'Shape14'
        mmHeight = 6138
        mmLeft = 217170
        mmTop = 9948
        mmWidth = 18203
        BandType = 0
      end
      object ppShape15: TppShape
        UserName = 'Shape15'
        mmHeight = 6138
        mmLeft = 235162
        mmTop = 9948
        mmWidth = 16933
        BandType = 0
      end
      object ppShape4: TppShape
        UserName = 'Shape4'
        mmHeight = 15452
        mmLeft = 150284
        mmTop = 635
        mmWidth = 32597
        BandType = 0
      end
      object ppShape12: TppShape
        UserName = 'Shape12'
        mmHeight = 6138
        mmLeft = 166159
        mmTop = 9948
        mmWidth = 16722
        BandType = 0
      end
      object ppShape13: TppShape
        UserName = 'Shape13'
        mmHeight = 6138
        mmLeft = 150284
        mmTop = 9948
        mmWidth = 16087
        BandType = 0
      end
      object ppShape3: TppShape
        UserName = 'Shape3'
        mmHeight = 15452
        mmLeft = 182669
        mmTop = 635
        mmWidth = 34713
        BandType = 0
      end
      object ppShape10: TppShape
        UserName = 'Shape10'
        mmHeight = 6138
        mmLeft = 182669
        mmTop = 9948
        mmWidth = 18627
        BandType = 0
      end
      object ppShape11: TppShape
        UserName = 'Shape11'
        mmHeight = 6138
        mmLeft = 201084
        mmTop = 9948
        mmWidth = 16298
        BandType = 0
      end
      object ppShape9: TppShape
        UserName = 'Shape9'
        mmHeight = 15452
        mmLeft = 6562
        mmTop = 635
        mmWidth = 18627
        BandType = 0
      end
      object ppShape8: TppShape
        UserName = 'Shape8'
        mmHeight = 15452
        mmLeft = 24977
        mmTop = 635
        mmWidth = 44027
        BandType = 0
      end
      object ppShape7: TppShape
        UserName = 'Shape7'
        mmHeight = 15452
        mmLeft = 68792
        mmTop = 635
        mmWidth = 40640
        BandType = 0
      end
      object ppShape6: TppShape
        UserName = 'Shape6'
        mmHeight = 15452
        mmLeft = 109220
        mmTop = 635
        mmWidth = 28998
        BandType = 0
      end
      object ppShape5: TppShape
        UserName = 'Shape5'
        mmHeight = 15452
        mmLeft = 137795
        mmTop = 635
        mmWidth = 12700
        BandType = 0
      end
      object ppShape1: TppShape
        UserName = 'Shape1'
        mmHeight = 15451
        mmLeft = 251884
        mmTop = 635
        mmWidth = 26882
        BandType = 0
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        AutoSize = False
        Caption = '№ заявки     \             № заказа'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 13970
        mmLeft = 7408
        mmTop = 1693
        mmWidth = 16510
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        AutoSize = False
        Caption = 'Заказчик'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 39158
        mmTop = 1270
        mmWidth = 14605
        BandType = 0
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        AutoSize = False
        Caption = 'Наименование детали, узла, работ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 9313
        mmLeft = 69638
        mmTop = 1270
        mmWidth = 38523
        BandType = 0
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        AutoSize = False
        Caption = 'Номер чертежа'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 110702
        mmTop = 1693
        mmWidth = 26035
        BandType = 0
      end
      object ppLabel10: TppLabel
        UserName = 'Label10'
        AutoSize = False
        Caption = 'Един. изм.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8890
        mmLeft = 140124
        mmTop = 1482
        mmWidth = 9102
        BandType = 0
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        AutoSize = False
        Caption = 'Кол-во'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 160655
        mmTop = 1482
        mmWidth = 11642
        BandType = 0
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        AutoSize = False
        Caption = 'Плановая норма времени'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8890
        mmLeft = 183727
        mmTop = 1270
        mmWidth = 32597
        BandType = 0
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        Caption = 'на единицу'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 183727
        mmTop = 10584
        mmWidth = 17357
        BandType = 0
      end
      object ppLabel14: TppLabel
        UserName = 'Label14'
        Caption = 'на партию'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 4233
        mmLeft = 201084
        mmTop = 10583
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel15: TppLabel
        UserName = 'Label15'
        AutoSize = False
        Caption = 'Фактическая норма времени'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        WordWrap = True
        mmHeight = 8890
        mmLeft = 218017
        mmTop = 1270
        mmWidth = 33232
        BandType = 0
      end
      object ppLabel16: TppLabel
        UserName = 'Label16'
        AutoSize = False
        Caption = 'на единицу'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 218017
        mmTop = 10584
        mmWidth = 17356
        BandType = 0
      end
      object ppLabel17: TppLabel
        UserName = 'Label17'
        AutoSize = False
        Caption = 'на партию'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 236009
        mmTop = 10584
        mmWidth = 15240
        BandType = 0
      end
      object ppLabel18: TppLabel
        UserName = 'Label18'
        AutoSize = False
        Caption = 'Примечание'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 256117
        mmTop = 1270
        mmWidth = 19262
        BandType = 0
      end
      object ppLabel21: TppLabel
        UserName = 'Label21'
        Caption = 'по плану'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 151977
        mmTop = 10584
        mmWidth = 13123
        BandType = 0
      end
      object ppLabel22: TppLabel
        UserName = 'Label22'
        Caption = 'по факту'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4233
        mmLeft = 168023
        mmTop = 10584
        mmWidth = 13208
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      mmBottomOffset = 0
      mmHeight = 9525
      mmPrintPosition = 0
      object OrderVariable: TppVariable
        UserName = 'OrderVariable'
        AutoSize = False
        CalcOrder = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        mmHeight = 3175
        mmLeft = 7197
        mmTop = 847
        mmWidth = 16933
        BandType = 4
      end
      object CstDBText: TppDBText
        UserName = 'CstDBText'
        DataField = 'NAME'
        DataPipeline = BDEPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        WordWrap = True
        DataPipelineName = 'BDEPipeline'
        mmHeight = 7408
        mmLeft = 25188
        mmTop = 847
        mmWidth = 42757
        BandType = 4
      end
      object NmntDBText: TppDBText
        UserName = 'NmntDBText'
        DataField = 'NAME_1'
        DataPipeline = BDEPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        WordWrap = True
        DataPipelineName = 'BDEPipeline'
        mmHeight = 7408
        mmLeft = 69215
        mmTop = 847
        mmWidth = 40217
        BandType = 4
      end
      object ChrtDBText: TppDBText
        UserName = 'ChrtDBText'
        DataField = 'CODE'
        DataPipeline = BDEPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'BDEPipeline'
        mmHeight = 3175
        mmLeft = 110067
        mmTop = 1058
        mmWidth = 27728
        BandType = 4
      end
      object EdizmDBText: TppDBText
        UserName = 'EdizmDBText'
        DataField = 'NAME_2'
        DataPipeline = BDEPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        Transparent = True
        DataPipelineName = 'BDEPipeline'
        mmHeight = 3175
        mmLeft = 138642
        mmTop = 1058
        mmWidth = 11853
        BandType = 4
      end
      object KolvoFDBText: TppDBText
        UserName = 'KolvoFDBText'
        DataField = 'NUMBER_F'
        DataPipeline = BDEPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'BDEPipeline'
        mmHeight = 3175
        mmLeft = 166794
        mmTop = 846
        mmWidth = 15875
        BandType = 4
      end
      object AllPTimeVariable: TppVariable
        UserName = 'AllPTimeVariable'
        AutoSize = False
        CalcOrder = 1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 201507
        mmTop = 846
        mmWidth = 14817
        BandType = 4
      end
      object AllFTimeVariable: TppVariable
        UserName = 'AllFTimeVariable'
        AutoSize = False
        CalcOrder = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3175
        mmLeft = 236432
        mmTop = 846
        mmWidth = 14605
        BandType = 4
      end
      object KolvoPDBText: TppDBText
        UserName = 'KolvoPDBText'
        DataField = 'NUMBER_P'
        DataPipeline = BDEPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'BDEPipeline'
        mmHeight = 3175
        mmLeft = 151342
        mmTop = 1058
        mmWidth = 14605
        BandType = 4
      end
      object PTimeDBText: TppDBText
        UserName = 'PTimeDBText'
        DataField = 'TIME_P'
        DataPipeline = BDEPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'BDEPipeline'
        mmHeight = 3175
        mmLeft = 184362
        mmTop = 846
        mmWidth = 15875
        BandType = 4
      end
      object FTimeDBText: TppDBText
        UserName = 'FTimeDBText'
        DataField = 'TIME_F'
        DataPipeline = BDEPipeline
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 8
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        DataPipelineName = 'BDEPipeline'
        mmHeight = 3175
        mmLeft = 218652
        mmTop = 847
        mmWidth = 16510
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 12488
      mmPrintPosition = 0
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        mmHeight = 3810
        mmLeft = 253577
        mmTop = 6985
        mmWidth = 21802
        BandType = 8
      end
    end
    object ppSummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 23707
      mmPrintPosition = 0
      object ppLabel19: TppLabel
        UserName = 'Label19'
        AutoSize = False
        Caption = 'Начальник РМП'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 10160
        mmTop = 5927
        mmWidth = 29633
        BandType = 7
      end
      object ppLabel20: TppLabel
        UserName = 'Label20'
        AutoSize = False
        Caption = 'Начальник цеха (участка)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Times New Roman'
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4233
        mmLeft = 9948
        mmTop = 12700
        mmWidth = 43180
        BandType = 7
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        Weight = 0.75
        mmHeight = 1905
        mmLeft = 6562
        mmTop = 2117
        mmWidth = 274532
        BandType = 7
      end
    end
    object raCodeModule1: TraCodeModule
      ProgramStream = {
        01060F5472614576656E7448616E646C65720B50726F6772616D4E616D650613
        4F726465725661726961626C654F6E43616C630B50726F6772616D5479706507
        0B747450726F63656475726506536F75726365069770726F636564757265204F
        726465725661726961626C654F6E43616C63287661722056616C75653A205661
        7269616E74293B0D0A626567696E0D0A0D0A202056616C7565203A3D20496E74
        546F53747228424445506970656C696E655B274E554D424552275D292B275C27
        2B496E74546F53747228424445506970656C696E655B274E554D4245525F3127
        5D290D0A0D0A656E643B0D0A0D436F6D706F6E656E744E616D65060D4F726465
        725661726961626C65094576656E744E616D6506064F6E43616C63074576656E
        74494402210001060F5472614576656E7448616E646C65720B50726F6772616D
        4E616D650616416C6C5054696D655661726961626C654F6E43616C630B50726F
        6772616D54797065070B747450726F63656475726506536F7572636506837072
        6F63656475726520416C6C5054696D655661726961626C654F6E43616C632876
        61722056616C75653A2056617269616E74293B0D0A626567696E0D0A0D0A2020
        56616C7565203A3D20424445506970656C696E655B2754494D455F50275D2A20
        424445506970656C696E655B274E554D4245525F50275D0D0A0D0A656E643B0D
        0A0D436F6D706F6E656E744E616D650610416C6C5054696D655661726961626C
        65094576656E744E616D6506064F6E43616C63074576656E7449440221000106
        0F5472614576656E7448616E646C65720B50726F6772616D4E616D650616416C
        6C4654696D655661726961626C654F6E43616C630B50726F6772616D54797065
        070B747450726F63656475726506536F75726365068370726F63656475726520
        416C6C4654696D655661726961626C654F6E43616C63287661722056616C7565
        3A2056617269616E74293B0D0A626567696E0D0A0D0A202056616C7565203A3D
        20424445506970656C696E655B2754494D455F46275D2A20424445506970656C
        696E655B274E554D4245525F46275D0D0A0D0A656E643B0D0A0D436F6D706F6E
        656E744E616D650610416C6C4654696D655661726961626C65094576656E744E
        616D6506064F6E43616C63074576656E74494402210000}
    end
  end
  object PdrQuery: TQuery
    Active = True
    DatabaseName = 'RMP'
    SQL.Strings = (
      'Select NAME'
      'From Spr_Pdr')
    Left = 168
    Top = 264
  end
end
