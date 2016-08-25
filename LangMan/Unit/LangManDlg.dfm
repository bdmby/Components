object StringsEditor: TStringsEditor
  Left = 226
  Top = 123
  ActiveControl = ValueListEditor
  BorderIcons = [biSystemMenu]
  Caption = 'LangMan - String List Editor'
  ClientHeight = 314
  ClientWidth = 435
  Color = clBtnFace
  Constraints.MinHeight = 304
  Constraints.MinWidth = 437
  ParentFont = True
  OldCreateOrder = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 435
    Height = 271
    Align = alClient
    TabOrder = 0
    object ValueListEditor: TValueListEditor
      Left = 1
      Top = 25
      Width = 433
      Height = 245
      Align = alClient
      DefaultColWidth = 50
      DefaultRowHeight = 16
      FixedCols = 1
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goEditing, goTabs, goAlwaysShowEditor, goThumbTracking]
      ScrollBars = ssVertical
      TabOrder = 0
      TitleCaptions.Strings = (
        'Item Nr.'
        'Strings')
      OnKeyDown = ValueListEditorKeyDown
      OnKeyUp = ValueListEditorKeyUp
      OnMouseDown = ValueListEditorMouseDown
      OnStringsChange = ValueListEditorStringsChange
      ColWidths = (
        50
        377)
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 433
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        433
        24)
      object LItemsCountLabel: TLabel
        Left = 10
        Top = 5
        Width = 31
        Height = 13
        Caption = 'Items:'
      end
      object LItemsCount: TLabel
        Left = 47
        Top = 5
        Width = 6
        Height = 13
        Caption = '0'
      end
      object FindEdit: TEdit
        Left = 232
        Top = 2
        Width = 200
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = FindEditChange
        OnKeyDown = FindEditKeyDown
      end
      object FindBtn: TBitBtn
        Left = 207
        Top = 1
        Width = 24
        Height = 23
        Hint = 'Find next (F3)'
        Default = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000130B0000130B000000000000000000008A8A8A8A8A8A
          8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A9E94
          898E745C9C928B9E9F9F8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
          8A8A8A8A8A8A8A8A8A8A8AEEE6DC7D470D703C03522000B0A79F8A8A8A8A8A8A
          8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8AF1E9E18650118049
          0B7D460B6A3700A792808A8A8A8A8A8A8A8A8A8A8A8AE9E5E1E1CBACD2B38ADC
          C6A9C2BEB68A8A8A8D5613864F0D824C0C7C44048D5D29B3AFAC8A8A8A8A8A8A
          8A8A8ACFA75AB9820AAC6C00965400904F009054038F550A8D540E8A520F8249
          05A17643E7E3DE8A8A8A8A8A8A8A8A8AE1C486C18900D9B775D9D4CBBAB7B3D3
          CDC3C098638F51009158118C540DA57A43E1DDD88A8A8A8A8A8A8A8A8AF2D9B1
          E1C48CECE2CE8A8A8A8A8A8A8A8A8A8A8A8A8A8A8ACAB59A8E5100966018DFD9
          D48A8A8A8A8A8A8A8A8AB4ADA2D4A85FE1C5988A8A8A8A8A8A8A8A8A8A8A8A8A
          8A8A8A8A8A8A8A8AC09963925403EAE4DD8A8A8A8A8A8A8A8A8AE1CFB1D2A04F
          DDD6CB8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8AD3CDC3925000DDC7
          A98A8A8A8A8A8A8A8A8ADAC197D19B43D3D6DB8A8A8A8A8A8A8A8A8A8A8A8A8A
          8A8A8A8A8A8A8A8ABBB8B4955100D3B58A8A8A8A8A8A8A8A8A8ADDC8A3CC902B
          DDD5C88A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8AD5CFC59E5D00E1CC
          AB8A8A8A8A8A8A8A8A8AB2A999C78514D9AB618A8A8A8A8A8A8A8A8A8A8A8A8A
          8A8A8A8A8A8A8A8ACFA666B07205ECE6E18A8A8A8A8A8A8A8A8A8A8A8ADDAF61
          C9891DE5CDA88A8A8A8A8A8A8A8A8A8A8A8A8A8A8ADCC7A2C48E0BD5B05D8A8A
          8A8A8A8A8A8A8A8A8A8A8A8A8AF0ECE5CD8D21C9891DD8AB61D9D2C4D3D6DBDA
          D3C8E6CD9BE4C982CD9F29FEFDFC8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A
          EFEAE3DCAF62C88514CD8F2BD19B42D3A14FD9AE61EDD9B0F4F1EF8A8A8A8A8A
          8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8AB2A999DDC8A3DAC297DE
          CCADCCC5B9B6B7B98A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A8A}
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = FindBtnClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 271
    Width = 435
    Height = 43
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 1
    ExplicitTop = 276
    DesignSize = (
      435
      43)
    object OKButton: TButton
      Left = 263
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
    end
    object CancelButton: TButton
      Left = 352
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object ExportBtn: TButton
      Left = 83
      Top = 10
      Width = 60
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Export'
      TabOrder = 3
      OnClick = FileSave
    end
    object ImportBtn: TButton
      Left = 10
      Top = 10
      Width = 60
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Import'
      TabOrder = 2
      OnClick = FileOpen
    end
  end
  object OpenDialog: TOpenDialog
    HelpContext = 27040
    DefaultExt = 'TXT'
    Filter = 'All files [*.*]|*.*'
    Options = [ofHideReadOnly, ofShowHelp, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Import string list from file'
    Left = 312
    Top = 179
  end
  object SaveDialog: TSaveDialog
    HelpContext = 27050
    Filter = 'All files [*.*]|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofPathMustExist, ofEnableSizing]
    Title = 'Export string list to file'
    Left = 378
    Top = 179
  end
end
