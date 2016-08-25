object CompChildrenEditor: TCompChildrenEditor
  Left = 264
  Top = 151
  Width = 303
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
    Width = 287
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 63
    Caption = 'ToolBar1'
    ShowCaptions = True
    TabOrder = 0
    object tbAdd: TToolButton
      Left = 0
      Top = 2
      Caption = 'Add'
      ImageIndex = 0
      OnClick = tbAddClick
    end
    object tlDel: TToolButton
      Left = 63
      Top = 2
      Caption = 'Del'
      ImageIndex = 1
      OnClick = tlDelClick
    end
    object ToolButton3: TToolButton
      Left = 126
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object tbMoveUp: TToolButton
      Left = 134
      Top = 2
      Caption = 'Move Up'
      ImageIndex = 2
      OnClick = tbMoveUpClick
    end
    object tbMoveDOwn: TToolButton
      Left = 197
      Top = 2
      Caption = 'Move Down'
      ImageIndex = 3
      OnClick = tbMoveDOwnClick
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 29
    Width = 287
    Height = 273
    Align = alClient
    AutoFitColWidths = True
    DataSource = DataSource1
    DynProps = <>
    IndicatorOptions = []
    Options = [dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'CompName'
        Footers = <>
        Width = 100
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
    Left = 144
    Top = 168
    object MemTableEh1CompName: TStringField
      FieldName = 'CompName'
      Size = 255
    end
    object MemTableEh1RefComp: TRefObjectField
      FieldName = 'RefComp'
    end
    object MemTableData: TMemTableDataEh
      object DataStruct: TMTDataStructEh
        object CompName: TMTStringDataFieldEh
          FieldName = 'CompName'
          StringDataType = fdtStringEh
          DisplayWidth = 100
          Size = 255
        end
        object RefComp: TMTRefObjectFieldEh
          FieldName = 'RefComp'
          DisplayWidth = 10
        end
      end
      object RecordsList: TRecordsListEh
      end
    end
  end
end
