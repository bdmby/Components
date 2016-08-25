object SelectImpExpClassForm: TSelectImpExpClassForm
  Left = 222
  Top = 155
  Width = 290
  Height = 328
  Caption = 'Select Class'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    274
    290)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 250
    Width = 258
    Height = 2
    Anchors = [akLeft, akRight, akBottom]
  end
  object bOk: TButton
    Left = 110
    Top = 260
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object bCancel: TButton
    Left = 191
    Top = 260
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 8
    Top = 8
    Width = 257
    Height = 235
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 2
    OnClick = ListBox1Click
    OnKeyDown = ListBox1KeyDown
  end
end
