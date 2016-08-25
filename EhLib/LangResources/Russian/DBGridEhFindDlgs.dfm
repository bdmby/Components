object DBGridEhFindDlg: TDBGridEhFindDlg
  Left = 236
  Top = 110
  BorderStyle = bsDialog
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 153
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 12
    Width = 47
    Height = 13
    Caption = '&'#1054#1073#1088#1072#1079#1077#1094':'
  end
  object Label2: TLabel
    Left = 10
    Top = 35
    Width = 44
    Height = 13
    Caption = '&'#1055#1086#1080#1089#1082' '#1074':'
  end
  object cbMatchType: TLabel
    Left = 10
    Top = 57
    Width = 64
    Height = 13
    Caption = '&'#1057#1086#1074#1087#1072#1076#1077#1085#1080#1077':'
  end
  object Label3: TLabel
    Left = 10
    Top = 82
    Width = 54
    Height = 13
    Caption = #1055#1088#1086#1089'&'#1084#1086#1090#1088':'
  end
  object Label4: TLabel
    Left = 9
    Top = 129
    Width = 88
    Height = 13
    Caption = #1048#1089#1082#1072#1090#1100' '#1074' '#1076#1077#1088#1077#1074#1077':'
  end
  object cbText: TDBComboBoxEh
    Left = 88
    Top = 9
    Width = 316
    Height = 21
    DynProps = <>
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 0
    Text = 'cbText'
    Visible = True
    OnChange = cbTextChange
  end
  object bFind: TButton
    Left = 412
    Top = 9
    Width = 86
    Height = 24
    Caption = #1053#1072'&'#1081#1090#1080' '#1076#1072#1083#1077#1077
    TabOrder = 6
    OnClick = bFindClick
  end
  object bCancel: TButton
    Left = 412
    Top = 38
    Width = 86
    Height = 24
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 7
    OnClick = bCancelClick
  end
  object cbFindIn: TDBComboBoxEh
    Left = 88
    Top = 31
    Width = 193
    Height = 21
    DynProps = <>
    DropDownBox.Rows = 17
    DropDownBox.Sizable = True
    EditButtons = <>
    TabOrder = 1
    Text = 'cbFindIn'
    Visible = True
    OnChange = cbFindInChange
  end
  object cbMatchinType: TDBComboBoxEh
    Left = 88
    Top = 55
    Width = 145
    Height = 21
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      #1057' '#1083#1102#1073#1086#1081' '#1095#1072#1089#1090#1080' '#1087#1086#1083#1103
      #1055#1086#1083#1103' '#1094#1077#1083#1080#1082#1086#1084
      #1057' '#1085#1072#1095#1072#1083#1072' '#1087#1086#1083#1103)
    KeyItems.Strings = (
      #1057' '#1083#1102#1073#1086#1081' '#1095#1072#1089#1090#1080' '#1087#1086#1083#1103
      #1055#1086#1083#1103' '#1094#1077#1083#1080#1082#1086#1084
      #1057' '#1085#1072#1095#1072#1083#1072' '#1087#1086#1083#1103)
    TabOrder = 2
    Text = #1057' '#1083#1102#1073#1086#1081' '#1095#1072#1089#1090#1080' '#1087#1086#1083#1103
    Visible = True
  end
  object cbFindDirection: TDBComboBoxEh
    Left = 88
    Top = 79
    Width = 145
    Height = 21
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      #1042#1074#1077#1088#1093
      #1042#1085#1080#1079
      #1042#1089#1077)
    KeyItems.Strings = (
      #1042#1074#1077#1088#1093
      #1042#1085#1080#1079
      #1042#1089#1077)
    TabOrder = 3
    Text = #1042#1089#1077
    Visible = True
    OnChange = cbTextChange
  end
  object cbCharCase: TDBCheckBoxEh
    Left = 88
    Top = 105
    Width = 145
    Height = 14
    Caption = #1057' '#1091#1095#1077#1090#1086#1084' '#1088#1077'&'#1075#1080#1089#1090#1088#1072
    DynProps = <>
    TabOrder = 4
  end
  object cbUseFormat: TDBCheckBoxEh
    Left = 260
    Top = 105
    Width = 144
    Height = 14
    Caption = #1057' '#1091'&'#1095#1077#1090#1086#1084' '#1092#1086#1088#1084#1072#1090#1072
    Checked = True
    DynProps = <>
    State = cbChecked
    TabOrder = 5
  end
  object dbcTreeFindRange: TDBComboBoxEh
    Left = 121
    Top = 125
    Width = 152
    Height = 21
    DynProps = <>
    EditButtons = <>
    Items.Strings = (
      #1042#1086' '#1074#1089#1077#1093' '#1074#1077#1090#1074#1103#1093
      #1042' '#1088#1072#1089#1082#1088#1099#1090#1099#1093' '#1074#1077#1090#1074#1103#1093
      #1042' '#1090#1077#1082#1091#1097#1077#1084' '#1091#1088#1086#1074#1085#1077
      #1042' '#1090#1077#1082#1091#1097#1077#1081' '#1074#1077#1090#1082#1077)
    KeyItems.Strings = (
      #1042#1086' '#1074#1089#1077#1093' '#1074#1077#1090#1074#1103#1093
      #1042' '#1088#1072#1089#1082#1088#1099#1090#1099#1093' '#1074#1077#1090#1074#1103#1093
      #1042' '#1090#1077#1082#1091#1097#1077#1084' '#1091#1088#1086#1074#1085#1077
      #1042' '#1090#1077#1082#1091#1097#1077#1081' '#1074#1077#1090#1082#1077)
    TabOrder = 8
    Text = #1042#1086' '#1074#1089#1077#1093' '#1074#1077#1090#1074#1103#1093
    Visible = True
    OnChange = cbTextChange
  end
end
