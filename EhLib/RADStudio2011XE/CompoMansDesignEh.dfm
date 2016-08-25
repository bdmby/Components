object CompoListEditor: TCompoListEditor
  Left = 0
  Top = 0
  Width = 647
  Height = 340
  Caption = 'Form2'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 631
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 47
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 0
    object tbHide: TToolButton
      Left = 0
      Top = 2
      Caption = 'Hide'
      ImageIndex = 4
      OnClick = tbHideClick
    end
    object tbShow: TToolButton
      Left = 47
      Top = 2
      Caption = 'Show'
      ImageIndex = 5
      OnClick = tbShowClick
    end
    object ToolButton3: TToolButton
      Left = 94
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
      Visible = False
    end
    object tbHideAll: TToolButton
      Left = 102
      Top = 2
      Caption = 'Hide All'
      ImageIndex = 3
      Visible = False
      OnClick = tbHideAllClick
    end
    object tbShowAll: TToolButton
      Left = 149
      Top = 2
      Caption = 'Show All'
      ImageIndex = 2
      Visible = False
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 29
    Width = 631
    Height = 273
    Align = alClient
    AllowedSelections = [gstRecordBookmarks]
    AutoFitColWidths = True
    DataSource = DataSource1
    DynProps = <>
    EditActions = [geaSelectAllEh]
    IndicatorOptions = []
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghColumnResize, dghColumnMove, dghExtendVertLines]
    ReadOnly = True
    SortLocal = True
    STFilter.Local = True
    STFilter.Location = stflInTitleFilterEh
    STFilter.Visible = True
    TabOrder = 1
    OnApplyFilter = DBGridEh1ApplyFilter
    OnContextPopup = DBGridEh1ContextPopup
    OnSelectionChanged = DBGridEh1SelectionChanged
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CompName'
        Footers = <>
        Title.Caption = 'Name'
        Width = 125
        OnGetCellParams = DBGridEh1Columns0GetCellParams
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CompTypeName'
        Footers = <>
        Title.Caption = 'Type'
        Width = 129
        OnGetCellParams = DBGridEh1Columns0GetCellParams
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'PositionStr'
        Footers = <>
        Width = 74
        OnGetCellParams = DBGridEh1Columns0GetCellParams
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DataSource1: TDataSource
    DataSet = MemTableEh1
    OnDataChange = DataSource1DataChange
    Left = 136
    Top = 160
  end
  object MemTableEh1: TMemTableEh
    Params = <>
    Left = 176
    Top = 192
    object MemTableEh1CompName: TStringField
      FieldName = 'CompName'
      Size = 255
    end
    object MemTableEh1RefComp: TRefObjectField
      FieldName = 'RefComp'
    end
    object MemTableEh1PositionStr: TStringField
      FieldName = 'PositionStr'
    end
    object MemTableEh1OldPositionsX: TIntegerField
      FieldName = 'OldPositionsX'
    end
    object MemTableEh1OldPositionsY: TIntegerField
      FieldName = 'OldPositionsY'
    end
    object MemTableEh1CompTypeName: TStringField
      FieldName = 'CompTypeName'
      Size = 255
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object CompName: TMTStringDataFieldEh
          FieldName = 'CompName'
          StringDataType = fdtStringEh
          DisplayWidth = 100
          Size = 255
        end
        object CompTypeName: TMTStringDataFieldEh
          FieldName = 'CompTypeName'
          StringDataType = fdtStringEh
          DisplayWidth = 100
          Size = 255
        end
        object RefComp: TMTRefObjectFieldEh
          FieldName = 'RefComp'
          DisplayWidth = 10
        end
        object PositionStr: TMTStringDataFieldEh
          FieldName = 'PositionStr'
          StringDataType = fdtStringEh
          DisplayWidth = 20
        end
        object OldPositionsX: TMTNumericDataFieldEh
          FieldName = 'OldPositionsX'
          NumericDataType = fdtIntegerEh
          AutoIncrement = False
          DisplayWidth = 20
          currency = False
          Precision = 15
        end
        object OldPositionsY: TMTNumericDataFieldEh
          FieldName = 'OldPositionsY'
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
end
