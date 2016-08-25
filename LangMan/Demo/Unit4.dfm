object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'International Application'
  ClientHeight = 461
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 442
    Width = 481
    Height = 19
    AutoHint = True
    Panels = <
      item
        Width = 300
      end>
  end
  object Pages: TPageControl
    Left = 0
    Top = 0
    Width = 481
    Height = 442
    ActivePage = BasicsTab
    Align = alClient
    MultiLine = True
    TabOrder = 1
    TabPosition = tpLeft
    object BasicsTab: TTabSheet
      Caption = 'Basic Components'
      object GridPanel1: TGridPanel
        Left = 0
        Top = 0
        Width = 453
        Height = 161
        Align = alTop
        Caption = 'GridPanel1'
        ColumnCollection = <
          item
            Value = 50.000000000000000000
          end
          item
            Value = 50.000000000000000000
          end>
        ControlCollection = <
          item
            Column = 0
            Control = Label1
            Row = 0
          end
          item
            Column = 1
            Control = ComboBox1
            Row = 0
          end
          item
            Column = 0
            Control = Button1
            Row = 1
          end
          item
            Column = 1
            Control = LangFlagsCombo1
            Row = 1
          end
          item
            Column = 0
            Control = ValuedLabel1
            Row = 2
          end
          item
            Column = 1
            Control = ValuedLabel2
            Row = 2
          end>
        Padding.Left = 6
        Padding.Right = 6
        RowCollection = <
          item
            Value = 33.333333333333340000
          end
          item
            Value = 33.333333333333340000
          end
          item
            Value = 33.333333333333340000
          end>
        ShowCaption = False
        TabOrder = 0
        DesignSize = (
          453
          161)
        object Label1: TLabel
          Left = 88
          Top = 21
          Width = 56
          Height = 13
          Hint = 'Hello world!'
          Anchors = []
          Caption = 'Hello world!'
          ExplicitLeft = 46
          ExplicitTop = 20
        end
        object ComboBox1: TComboBox
          Left = 273
          Top = 17
          Width = 126
          Height = 21
          Hint = 'Options'
          Anchors = []
          TabOrder = 0
          Text = 'Default'
          Items.Strings = (
            'Option 1'
            'Option 2'
            'Option 3')
        end
        object Button1: TButton
          Left = 79
          Top = 68
          Width = 75
          Height = 25
          Hint = 'Internet'
          Anchors = []
          Caption = 'Internet'
          TabOrder = 1
        end
        object LangFlagsCombo1: TLangFlagsCombo
          Left = 273
          Top = 69
          Width = 126
          Height = 22
          LangManEngine = LangManEngine
          Anchors = []
          TabOrder = 2
        end
        object ValuedLabel1: TValuedLabel
          Left = 86
          Top = 127
          Width = 61
          Height = 13
          Hint = 'Program version'
          Anchors = []
          Value = '1.2'
          ValueName = 'Version'
          ValueSeparator = ':'
          ValueSpaces = 2
          ExplicitLeft = 66
          ExplicitTop = 126
        end
        object ValuedLabel2: TValuedLabel
          Left = 304
          Top = 127
          Width = 63
          Height = 13
          Hint = 'Demo ValuedLabel'
          Anchors = []
          Value = 'Value'
          ValueName = 'Name'
          ValueSeparator = ':'
          ValueSpaces = 2
          ExplicitLeft = 187
          ExplicitTop = 126
        end
      end
      object Chart1: TChart
        Left = 0
        Top = 161
        Width = 453
        Height = 273
        Foot.CustomPosition = True
        Foot.Left = 0
        Foot.Top = 0
        Title.Text.Strings = (
          'My graph')
        BottomAxis.LabelsFormat.TextAlignment = taCenter
        BottomAxis.Title.Caption = 'Date'
        DepthAxis.LabelsFormat.TextAlignment = taCenter
        DepthTopAxis.LabelsFormat.TextAlignment = taCenter
        LeftAxis.LabelsFormat.TextAlignment = taCenter
        LeftAxis.Title.Caption = 'Value'
        RightAxis.LabelsFormat.TextAlignment = taCenter
        TopAxis.LabelsFormat.TextAlignment = taCenter
        Zoom.Pen.Mode = pmNotXor
        Align = alClient
        TabOrder = 1
        DefaultCanvas = 'TGDIPlusCanvas'
        ColorPaletteIndex = 13
      end
    end
    object RichTab: TTabSheet
      Caption = 'Text Components'
      ImageIndex = 1
      DesignSize = (
        453
        434)
      object Memo1: TMemo
        Left = 0
        Top = 229
        Width = 453
        Height = 205
        Align = alBottom
        Lines.Strings = (
          '')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Rich: TLangManRichEdit
        Left = 0
        Top = 0
        Width = 453
        Height = 229
        Align = alClient
        AssignedLexicon = DesignedLexicon
        AutoFont = False
        Font.Charset = EASTEUROPE_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Times New Roman'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object ReportBtn: TButton
        Left = 296
        Top = 189
        Width = 138
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Generate Sample Report'
        TabOrder = 2
        OnClick = ReportBtnClick
      end
      object GDBtn: TButton
        Left = 360
        Top = 152
        Width = 75
        Height = 25
        Caption = 'Green Date'
        TabOrder = 3
        Visible = False
        OnClick = GDBtnClick
      end
    end
  end
  object ActionList1: TActionList
    Left = 112
    Top = 272
    object FileOpen1: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Dialog.Filter = 'All files (*.*)|*.*|My file (*.my)|*.my'
      Dialog.Title = 'Open My File'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
    end
    object FileSaveAs1: TFileSaveAs
      Category = 'File'
      Caption = 'Save &As...'
      Hint = 'Save As|Saves the active file with a new name'
      ImageIndex = 30
    end
    object FileExit1: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
  end
  object MainMenu1: TMainMenu
    Left = 232
    Top = 272
    object File1: TMenuItem
      Caption = 'File'
      object Open1: TMenuItem
        Action = FileOpen1
        ImageIndex = 0
      end
      object SaveAs1: TMenuItem
        Action = FileSaveAs1
      end
      object Exit1: TMenuItem
        Action = FileExit1
      end
    end
    object Language1: TMenuItem
      Caption = 'Language'
      object TMenuItem
        AutoCheck = True
        Caption = 'English'
        Checked = True
        ImageIndex = 0
        RadioItem = True
      end
      object TMenuItem
        AutoCheck = True
        Caption = '> Add <'
        ImageIndex = 1
        RadioItem = True
      end
    end
  end
  object LangManEngine: TLangManEngine
    DesignLangISOCode = 'en - English'
    DesignLanguageName = 'English'
    DefaultLanguage = 'English'
    LangSubdirectory = 'LANGS'
    LangFileExtension = '.lng'
    LangFileSignature = 'INT_APP_LANGUAGE_FILE'
    LangResources.Strings = (
      'CZECH'
      'CHINESE')
    LangResourcesAllowEdit = True
    LanguageMenu = Language1
    DesignLangFlag.Data = {
      07544269746D617036040000424D360400000000000036000000280000001000
      0000100000000100200000000000000400000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007373730073737300737373007373730073737300737373007373
      7300737373007373730073737300737373007373730073737300737373007373
      73002727CD001818BD000707AC000303A9000808AD001313B9002222C7003131
      D7003C3CE1003B3BE0002F2FD4002222C8001B1BC1001414B9000B0BB0007373
      7300ECECEC00DCDCDC00C5C5C500BABABA00BABABA00C1C1C100CECECE00DEDE
      DE00ECECEC00F1F1F100EAEAEA00DFDFDF00D4D4D400CECECE00C5C5C5007373
      73004545EA003737DC001D1DC3000A0AB0000303A9000707AC001111B6001F1F
      C5002F2FD4003A3ADF003B3BE0003131D7002525CB001C1CC2001515BA007373
      7300FDFDFD00FAFAFA00E1E1E100C9C9C900BCBCBC00B8B8B800BFBFBF00CBCB
      CB00DBDBDB00E9E9E900F1F1F100ECECEC00E1E1E100D6D6D600CECECE007373
      73008F353500A3484800963B3B007D222200680E0E005F04040060060600690E
      0E001C1CC2002C2CD1003838DD003B3BE0003333D8002727CC001E1EC4007373
      7300751A1A00EAEAEA00A1464600E6E6E60074191900BEBEBE005E0303006409
      0900C8C8C800D7D7D700E7E7E700F0F0F000EEEEEE00E3E3E300D7D7D7007373
      730061060600751A1A009A3F3F009A3F3F00822727006C111100600606005F04
      04000C0CB1001919BE002A2ACF003737DC003B3BE0003535DB002929CF007373
      73005B00000061060600DFDFDF009F444400EAEAEA00781D1D00BFBFBF005E03
      0300BBBBBB00C6C6C600D6D6D600E4E4E400EEEEEE00F0F0F000E6E6E6007373
      73005B0000005B0000006F151500953A3A009D424200872C2C006F1414006006
      06000303A9000A0AAF001616BC002626CB003434D9003C3CE1003737DD007373
      73005B000000B5B5B5005C010100DADADA009E434300F0F0F0007C212100670C
      0C00B8B8B800BABABA00C4C4C400D1D1D100E1E1E100EDEDED00F1F1F1007373
      73005B0000005B0000005B0000006A0F0F0090353500A04545008A2F2F007116
      16000707AC000303A9000909AE001414BA002424C9003232D8003C3CE100FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00}
    Left = 112
    Top = 328
  end
  object LangManClient: TLangManClient
    LangManEngine = LangManEngine
    InitAfterCreateForm = True
    GlobalLexicon = True
    TransStructuredProp = [pnBands, pnButtonCategories, pnGrpButtonItems, pnListColumns, pnListGroups, pnListItems, pnHeaderSections, pnDBGridTitleCaptions, pnOutlineItems, pnTabProducerColumns, pnFileTypes, pnButtons, pnRadioButtons]
    Left = 232
    Top = 328
  end
  object DesignedLexicon: TDesignedLexicon
    LangManEngine = LangManEngine
    GlobalLexicon = True
    Items.Strings = (
      'My string 1'
      'My string 2'
      'Heading'
      'Today is'
      'END'
      'You can change language')
    Left = 352
    Top = 328
  end
end
