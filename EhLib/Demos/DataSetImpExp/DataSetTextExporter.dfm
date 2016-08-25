object frDataSetExporter: TfrDataSetExporter
  Left = 0
  Top = 0
  Width = 794
  Height = 571
  TabOrder = 0
  DesignSize = (
    794
    571)
  object Label2: TLabel
    Left = 8
    Top = 79
    Width = 80
    Height = 13
    Caption = #1060#1086#1088#1084#1072#1090' '#1092#1072#1081#1083#1072':'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 794
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox1: TPaintBox
      Left = 0
      Top = 0
      Width = 794
      Height = 36
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      OnPaint = PaintBox1Paint
    end
    object Label1: TLabel
      Left = 41
      Top = 7
      Width = 211
      Height = 23
      Caption = 'DataSet Text Exporter'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Button1: TButton
    Left = 3
    Top = 42
    Width = 178
    Height = 25
    Caption = 'Export to DBMemo'
    TabOrder = 1
    OnClick = Button1Click
  end
  object PageControl1: TPageControl
    Left = 348
    Top = 100
    Width = 436
    Height = 458
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Src Data'
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 428
        Height = 430
        Align = alClient
        DataSource = MainDataModule.DataSource1
        DrawGraphicData = True
        DrawMemoText = True
        DynProps = <>
        IndicatorOptions = [gioShowRowIndicatorEh]
        TabOrder = 0
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Result Data'
      ImageIndex = 1
      object DBMemoEh1: TDBMemoEh
        Left = 0
        Top = 0
        Width = 428
        Height = 430
        Lines.Strings = (
          '')
        ScrollBars = ssBoth
        Align = alClient
        AutoSize = False
        DynProps = <>
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Visible = True
        WantReturns = True
        WordWrap = False
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Adv properties'
      ImageIndex = 2
      object cbUseFormatExportValueEvent: TDBCheckBoxEh
        Left = 16
        Top = 16
        Width = 377
        Height = 17
        Caption = 'Use OnFormatExportValue Event'
        DynProps = <>
        TabOrder = 0
      end
    end
  end
  object Button2: TButton
    Left = 348
    Top = 42
    Width = 121
    Height = 25
    Caption = 'ShowImpExpListEditor'
    TabOrder = 3
  end
  object rbDelim: TRadioButton
    Left = 91
    Top = 79
    Width = 113
    Height = 17
    Caption = #1057' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1103#1084#1080
    Checked = True
    TabOrder = 4
    TabStop = True
    OnClick = rbDelimClick
  end
  object rbFixSize: TRadioButton
    Left = 91
    Top = 98
    Width = 153
    Height = 17
    Caption = #1060#1080#1082#1089#1080#1088#1086#1074#1072#1085#1085#1086#1081' '#1096#1080#1088#1080#1085#1099
    TabOrder = 5
    OnClick = rbFixSizeClick
  end
  object cbxCodePage: TDBComboBoxEh
    Left = 115
    Top = 125
    Width = 206
    Height = 21
    ControlLabel.Width = 93
    ControlLabel.Height = 13
    ControlLabel.Caption = #1050#1086#1076#1086#1074#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072
    ControlLabel.Visible = True
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      'UTF8'
      'UTF7'
      'Unicode'
      'BigEndianUnicode'
      'ANSI'
      'ASCII')
    TabOrder = 6
    Text = 'UTF8'
    Visible = True
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 229
    Width = 327
    Height = 124
    Caption = ' '#1044#1072#1090#1072', '#1074#1088#1077#1084#1103', '#1095#1080#1089#1083#1072' '
    TabOrder = 7
    object cbbDateFormat: TDBComboBoxEh
      Left = 169
      Top = 18
      Width = 90
      Height = 21
      ControlLabel.Width = 147
      ControlLabel.Height = 13
      ControlLabel.Caption = #1060#1086#1088#1084#1072#1090' '#1080' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1076#1072#1090#1099
      ControlLabel.Layout = tlCenter
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        'DD/MM/YYYY'
        'MM/DD/YYYY'
        'YYYY/MM/DD')
      TabOrder = 0
      Text = 'DD/MM/YYYY'
      Visible = True
    end
    object cbbDateSep: TDBComboBoxEh
      Left = 265
      Top = 18
      Width = 53
      Height = 21
      ControlLabel.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1076#1072#1090#1099
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        '/'
        '.'
        '-'
        ',')
      TabOrder = 1
      Text = '/'
      Visible = True
    end
    object cbbTimeSep: TDBComboBoxEh
      Left = 265
      Top = 46
      Width = 53
      Height = 21
      ControlLabel.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1074#1088#1077#1084#1077#1085#1080
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        ':'
        '-')
      TabOrder = 2
      Text = ':'
      Visible = True
    end
    object cbbDecSep: TDBComboBoxEh
      Left = 169
      Top = 95
      Width = 53
      Height = 21
      ControlLabel.Width = 131
      ControlLabel.Height = 13
      ControlLabel.Caption = #1044#1077#1089#1103#1090#1080#1095#1085#1099#1081' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        ','
        '.')
      TabOrder = 3
      Text = ','
      Visible = True
    end
    object cbbTimeFormat: TDBComboBoxEh
      Left = 169
      Top = 46
      Width = 90
      Height = 21
      ControlLabel.Width = 166
      ControlLabel.Height = 13
      ControlLabel.Caption = #1060#1086#1088#1084#1072#1090' '#1080' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1074#1088#1077#1084#1077#1085#1080
      ControlLabel.Transparent = True
      ControlLabel.Visible = True
      ControlLabelLocation.Position = lpLeftTextBaselineEh
      DynProps = <>
      EditButtons = <>
      Items.Strings = (
        'HH:MM'
        'HH:MM:SS')
      TabOrder = 4
      Text = 'HH:MM:SS'
      Visible = True
    end
    object cbUseTimeWithDate: TDBCheckBoxEh
      Left = 91
      Top = 72
      Width = 227
      Height = 17
      Alignment = taLeftJustify
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1074#1088#1077#1084#1103' '#1089#1086#1074#1084#1077#1089#1090#1085#1086' '#1089' '#1076#1072#1090#1086#1081
      Checked = True
      DynProps = <>
      State = cbChecked
      TabOrder = 5
    end
  end
  object DBEditEh1: TDBEditEh
    Left = 395
    Top = 73
    Width = 389
    Height = 21
    ControlLabel.Width = 45
    ControlLabel.Height = 13
    ControlLabel.Caption = 'File name'
    ControlLabel.Visible = True
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    Anchors = [akLeft, akTop, akRight]
    DynProps = <>
    EditButtons = <
      item
        Style = ebsEllipsisEh
        OnClick = DBEditEh1EditButtons0Click
      end>
    TabOrder = 8
    Text = 'DBEditEh1'
    Visible = True
  end
  object cbIncludeFieldNames: TDBCheckBoxEh
    Left = 19
    Top = 152
    Width = 301
    Height = 17
    Alignment = taLeftJustify
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100' '#1080#1084#1077#1085#1072' '#1087#1086#1083#1077#1081' '#1074' '#1087#1077#1088#1074#1086#1081' '#1089#1090#1088#1086#1082#1077
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 9
  end
  object cbxTextQuoteChar: TDBComboBoxEh
    Left = 200
    Top = 202
    Width = 121
    Height = 21
    ControlLabel.Width = 108
    ControlLabel.Height = 13
    ControlLabel.Caption = #1054#1075#1088#1072#1085#1080#1095#1080#1090#1077#1083#1100' '#1090#1077#1082#1089#1090#1072
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 181
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      '"'
      #39)
    TabOrder = 10
    Text = '"'
    Visible = True
  end
  object cbxFieldsDelimiter: TDBComboBoxEh
    Left = 200
    Top = 175
    Width = 121
    Height = 21
    ControlLabel.Width = 99
    ControlLabel.Height = 13
    ControlLabel.Caption = #1056#1072#1079#1076#1077#1083#1080#1090#1077#1083#1100' '#1087#1086#1083#1077#1081
    ControlLabel.Visible = True
    ControlLabelLocation.LabelSpacingBound = sbFarBoundEh
    ControlLabelLocation.Spacing = 181
    ControlLabelLocation.Position = lpLeftTextBaselineEh
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      ','
      ';'
      '|'
      '<Tab>')
    TabOrder = 11
    Text = ';'
    Visible = True
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 359
    Width = 327
    Height = 199
    Anchors = [akLeft, akTop, akBottom]
    Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1086#1083#1077#1081' '
    TabOrder = 12
    DesignSize = (
      327
      199)
    object bResetFielsMapTable: TButton
      Left = 10
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Reset'
      TabOrder = 0
      OnClick = bResetFielsMapTableClick
    end
    object bCleaFielsMapTable: TButton
      Left = 91
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Clear'
      TabOrder = 1
      OnClick = bCleaFielsMapTableClick
    end
    object gridFieldsMap: TDBGridEh
      Left = 7
      Top = 55
      Width = 314
      Height = 139
      AllowedSelections = [gstRecordBookmarks]
      Anchors = [akLeft, akTop, akRight, akBottom]
      ColumnDefValues.Title.ToolTips = True
      ColumnDefValues.ToolTips = True
      DataSource = dsFixSetParams
      DynProps = <>
      HorzScrollBar.ExtraPanel.Visible = True
      HorzScrollBar.Height = 20
      IndicatorOptions = [gioShowRowIndicatorEh]
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Columns = <
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'DataSetFieldName'
          Footers = <>
          Width = 106
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldName'
          Footers = <>
          Width = 92
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldPos'
          Footers = <>
          Width = 46
        end
        item
          DynProps = <>
          EditButtons = <>
          FieldName = 'FileFieldLen'
          Footers = <>
          Width = 45
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object dbTableName: TDBComboBoxEh
    Left = 210
    Top = 46
    Width = 121
    Height = 21
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      'Orders'
      'FishFact')
    LimitTextToListValues = True
    TabOrder = 13
    Text = 'Orders'
    Visible = True
    OnChange = dbTableNameChange
  end
  object eTimeLong: TDBEditEh
    Left = 663
    Top = 42
    Width = 121
    Height = 21
    Anchors = [akTop, akRight]
    DynProps = <>
    EditButtons = <>
    TabOrder = 14
    Text = '0'
    Visible = True
  end
  object dsFixSetParams: TDataSource
    DataSet = mtFieldsMap
    Top = 65486
  end
  object mtFieldsMap: TMemTableEh
    Active = True
    Params = <>
    Top = 65486
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object DataSetFieldName: TMTStringDataFieldEh
          FieldName = 'DataSetFieldName'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
        end
        object FileFieldName: TMTStringDataFieldEh
          FieldName = 'FileFieldName'
          StringDataType = fdtWideStringEh
          DisplayWidth = 20
        end
        object FileFieldPos: TMTNumericDataFieldEh
          FieldName = 'FileFieldPos'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
        object FileFieldLen: TMTNumericDataFieldEh
          FieldName = 'FileFieldLen'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
  object CompoManEh1: TCompoManEh
    Left = 504
    Top = 65528
    VisibleComponentListPos = (
      'dsFixSetParams,176,472'
      'mtFieldsMap,88,472'
      'SaveTextFileDialog1,520,56'
      'DataSetTextExporterEh1,272,72')
  end
  object DataSetTextExporterEh1: TDataSetTextExporterEh
    Encoding = AutoDetect
    ValueDelimiter = ';'
    LineBreak = #13#10
    QuoteChar = '"'
    ValueSeparationStyle = vssDelimiterSeparatedEh
    FieldsMap = <>
    IsExportFieldNames = False
    ExportValueAsDisplayText = False
    Top = 65486
  end
  object SaveTextFileDialog1: TSaveDialog
    Top = 65486
  end
end
