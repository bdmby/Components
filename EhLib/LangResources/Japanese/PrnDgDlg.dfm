object fPrnDBGridEHSetupDialog: TfPrnDBGridEHSetupDialog
  Left = 331
  Top = 112
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'ページ設定'
  ClientHeight = 185
  ClientWidth = 368
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS UI Gothic'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = fPrnDBGridEHSetupDialogShow
  PixelsPerInch = 96
  TextHeight = 12
  object gbPrintFields: TGroupBox
    Left = 8
    Top = 6
    Width = 149
    Height = 130
    Caption = '余白(&M)'
    TabOrder = 0
    object Label5: TLabel
      Left = 14
      Top = 26
      Width = 31
      Height = 12
      Caption = '上 (&T)'
    end
    object Label6: TLabel
      Left = 14
      Top = 51
      Width = 32
      Height = 12
      Caption = '下 (&B)'
    end
    object Label7: TLabel
      Left = 14
      Top = 77
      Width = 30
      Height = 12
      Caption = '左 (&L)'
    end
    object Label8: TLabel
      Left = 14
      Top = 102
      Width = 32
      Height = 12
      Caption = '右 (&R)'
    end
    object seUpMargin: TEdit
      Left = 62
      Top = 24
      Width = 70
      Height = 20
      TabOrder = 0
      Text = '0'
      OnExit = seMarginExit
    end
    object seLowMargin: TEdit
      Left = 62
      Top = 49
      Width = 70
      Height = 20
      TabOrder = 1
      Text = '0'
      OnExit = seMarginExit
    end
    object seLeftMargin: TEdit
      Left = 62
      Top = 73
      Width = 70
      Height = 20
      TabOrder = 2
      Text = '0'
      OnExit = seMarginExit
    end
    object seRightMargin: TEdit
      Left = 62
      Top = 98
      Width = 70
      Height = 20
      TabOrder = 3
      Text = '0'
      OnExit = seMarginExit
    end
  end
  object ePrintFont: TEdit
    Left = 174
    Top = 115
    Width = 161
    Height = 20
    TabOrder = 6
    Text = 'ePrintFont'
  end
  object cbAutoStretch: TCheckBox
    Left = 174
    Top = 92
    Width = 87
    Height = 17
    Alignment = taLeftJustify
    Caption = '行高さ伸縮(&S)'
    TabOrder = 4
  end
  object bPrinterSetupDialog: TButton
    Left = 9
    Top = 151
    Width = 92
    Height = 25
    Caption = 'プリンター設定(&P)'
    TabOrder = 8
    OnClick = bPrinterSetupDialogClick
  end
  object bPrintFont: TButton
    Left = 336
    Top = 115
    Width = 23
    Height = 21
    Caption = '...'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = bPrintFontClick
  end
  object bOk: TButton
    Left = 191
    Top = 151
    Width = 80
    Height = 26
    Caption = '確認(&O)'
    Default = True
    ModalResult = 1
    TabOrder = 9
  end
  object bCancel: TButton
    Left = 279
    Top = 151
    Width = 80
    Height = 26
    Cancel = True
    Caption = '取消(&C)'
    ModalResult = 2
    TabOrder = 10
  end
  object cbColored: TCheckBox
    Left = 300
    Top = 92
    Width = 57
    Height = 17
    Alignment = taLeftJustify
    Caption = 'カラー(&C)'
    TabOrder = 5
  end
  object rgFitingType: TRadioGroup
    Left = 172
    Top = 6
    Width = 185
    Height = 55
    Enabled = False
    ItemIndex = 0
    Items.Strings = (
      '全グリッド(&g)'
      'カラム幅調整(&h)')
    TabOrder = 2
  end
  object cbFitWidthToPage: TCheckBox
    Left = 184
    Top = 4
    Width = 69
    Height = 17
    Alignment = taLeftJustify
    Caption = '幅調整(&F)'
    TabOrder = 1
    OnClick = cbFitWidthToPageClick
  end
  object cbOptimalColWidths: TCheckBox
    Left = 244
    Top = 68
    Width = 113
    Height = 17
    Alignment = taLeftJustify
    Caption = '最適化カラム幅(&w)'
    TabOrder = 3
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'ＭＳ ゴシック'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 153
    Top = 147
  end
  object PrinterSetupDialog1: TPrinterSetupDialog
    Left = 122
    Top = 148
  end
end
