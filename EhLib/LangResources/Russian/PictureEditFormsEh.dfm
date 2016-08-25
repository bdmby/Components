object PictureEditorDialog: TPictureEditorDialog
  Left = 232
  Top = 143
  Anchors = [akLeft, akBottom]
  BorderIcons = [biSystemMenu]
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1081
  ClientHeight = 338
  ClientWidth = 392
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    392
    338)
  PixelsPerInch = 96
  TextHeight = 13
  object OKButton: TButton
    Left = 308
    Top = 12
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Left = 308
    Top = 41
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 289
    Height = 324
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    DesignSize = (
      289
      324)
    object ImageShape: TShape
      Left = 8
      Top = 8
      Width = 274
      Height = 275
      Anchors = [akLeft, akTop, akRight]
    end
    object Load: TButton
      Left = 8
      Top = 290
      Width = 80
      Height = 23
      Anchors = [akLeft, akBottom]
      Caption = '&'#1048#1079' '#1092#1072#1081#1083#1072
      TabOrder = 0
      OnClick = LoadClick
    end
    object Save: TButton
      Left = 105
      Top = 290
      Width = 80
      Height = 23
      Anchors = [akLeft, akBottom]
      Caption = '&'#1042' '#1092#1072#1081#1083
      TabOrder = 1
      OnClick = SaveClick
    end
    object Clear: TButton
      Left = 202
      Top = 290
      Width = 80
      Height = 23
      Anchors = [akLeft, akBottom]
      Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100
      TabOrder = 2
      OnClick = ClearClick
    end
  end
  object bCut: TButton
    Left = 308
    Top = 86
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = #1042#1099#1088#1077#1079#1072#1090#1100
    TabOrder = 3
    OnClick = bCutClick
  end
  object bCopy: TButton
    Left = 308
    Top = 113
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 4
    OnClick = bCopyClick
  end
  object bPaste: TButton
    Left = 308
    Top = 140
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = #1042#1089#1090#1072#1074#1080#1090#1100
    TabOrder = 5
    OnClick = bPasteClick
  end
  object bZoomIn: TButton
    Left = 308
    Top = 182
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100
    TabOrder = 6
    OnClick = bZoomInClick
  end
  object bZoomOut: TButton
    Left = 308
    Top = 209
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = #1059#1089#1077#1085#1100#1096#1080#1090#1100
    TabOrder = 7
    OnClick = bZoomOutClick
  end
  object bReset: TButton
    Left = 308
    Top = 236
    Width = 75
    Height = 23
    Anchors = [akTop, akRight]
    Caption = #1048#1089#1093'. '#1088#1072#1079#1084'.'
    TabOrder = 8
    OnClick = bResetClick
  end
  object OpenDialog: TOpenPictureDialog
    Left = 140
    Top = 20
  end
  object SaveDialog: TSavePictureDialog
    Filter = 
      'All (*.bmp;*.ico;*.emf;*.wmf)|*.bmp;*.ico;*.emf;*.wmf|Bitmaps (*' +
      '.bmp)|*.bmp|Icons (*.ico)|*.ico|Enhanced Metafiles (*.emf)|*.emf' +
      '|Metafiles (*.wmf)|*.wmf'
    Options = [ofOverwritePrompt, ofEnableSizing]
    Left = 140
    Top = 76
  end
end
