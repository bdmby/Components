object Form1: TForm1
  Left = 192
  Top = 124
  Width = 513
  Height = 162
  Caption = 'SynPDF Export Demo '
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 452
    Height = 13
    Caption = 
      '1. Download SynPDF from http://synopse.info/files/pdf/synpdf.zip' +
      ' and unzip it to FR'#39's Lib folder'
  end
  object Label2: TLabel
    Left = 24
    Top = 32
    Width = 345
    Height = 13
    Caption = 
      '2. Copy frxExportSynPDF.dfm and frxExportSynPDF.pas to FR'#39's Lib ' +
      'folder'
  end
  object Button1: TButton
    Left = 208
    Top = 72
    Width = 89
    Height = 25
    Caption = 'Show Report'
    TabOrder = 0
    OnClick = Button1Click
  end
  object frxReport1: TfrxReport
    Version = '5.4.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42392.528252094900000000
    ReportOptions.LastChange = 42392.528252094900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 400
    Top = 16
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object frxRichObject1: TfrxRichObject
    Left = 448
    Top = 16
  end
end
