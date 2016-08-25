{******************************************}
{                                          }
{             FastReport 4                 }
{        Converter from QuickReport        }
{                                          }
{         Copyright (c) 2007-2008          }
{             by Serg Puhoff               }
{            Fast Reports Inc.             }
{                                          }
{                                          }
{******************************************}

//
// Using:
//   conv := TConverterQr2Fr.Create;
//   conv.Source := QuickRep1;
//   conv.Target := FReport;
//   conv.Convert;
//   FReport.SaveToFile('converted_fromQR.fr3');
//

unit ConverterQR2FR;

interface

uses frxClass, QuickRpt;

type
  TConverterQr2Fr = class
  private
    FTarget: TfrxReport;
    FSource: TQuickRep;
  protected
    procedure CreateMainBands;
    procedure CreateCustomBand(const ABand: TQRCustomband);
    procedure AddObjects(const ABand: TQRCustomband; const Band: TfrxBand);
  public
    property Source: TQuickRep read FSource write FSource;
    property Target: TfrxReport read FTarget write FTarget;

    procedure Convert;
  end;

implementation

uses SysUtils, Controls, QrPrntr, Classes, QRCtrls, frxRich;


{ TConverterQr2Fr }

procedure TConverterQr2Fr.AddObjects(const ABand: TQRCustomband;
  const Band: TfrxBand);
var
  i: integer;

  Memo: TfrxMemoView;
  Rich: TfrxRichView;
  Shape: TfrxShapeView;
  Image: TfrxPictureView;

  Lbl: TQRCustomLabel;
  Rt: TQRRichText;
  Sh: TQRShape;
  Img: TQRImage;
begin
  for i:= 0 to ABand.ControlCount - 1 do

    if ABand.Controls[i] is TQRCustomLabel then
    begin
      Lbl := ABand.Controls[i] as TQRCustomLabel;
      Memo := TfrxMemoView.Create(Band);
      Memo.CreateUniqueName;
      if Lbl.Caption = '' then
        Memo.Memo.Text := Lbl.Lines.Text
      else
        Memo.Memo.Text := Lbl.Caption;
      Memo.Font.Assign(Lbl.Font);  
      Memo.SetBounds(Lbl.Left, Lbl.Top, Lbl.Width, Lbl.Height);
    end

    else

    if ABand.Controls[i] is TQRRichText then
    begin
      Rt := ABand.Controls[i] as TQRRichText;
      Rich := TfrxRichView.Create(Band);
      Rich.RichEdit.Lines.Assign(Rt.Lines);
      Rich.CreateUniqueName;
      Rich.RichEdit.Font.Assign(Rt.Font);
      Rich.Color := Rt.Color;
      Rich.SetBounds(Rt.Left, Rt.Top, Rt.Width, Rt.Height);
    end

    else

    if ABand.Controls[i] is TQRShape then
    begin
      Sh := ABand.Controls[i] as TQRShape;
      Shape := TfrxShapeView.Create(Band);
      Shape.CreateUniqueName;
      case Sh.Shape of
        qrsRectangle: Shape.Shape := skRectangle;
        qrsCircle: Shape.Shape := skEllipse;
        qrsRoundRect: Shape.Shape := skRoundRectangle;
      end;
      Shape.SetBounds(Sh.Left, Sh.Top, Sh.Width, Sh.Height);
    end

    else

    if ABand.Controls[i] is TQRImage then
    begin
      Img := ABand.Controls[i] as TQRImage;
      Image := TfrxPictureView.Create(Band);
      Image.CreateUniqueName;
      Image.Picture.Assign(Img.Picture);
      Image.SetBounds(Img.Left, Img.Top, Img.Width, Img.Height);
    end;

end;

procedure TConverterQr2Fr.Convert;
begin
  if not Assigned(Source) then
    raise Exception.Create('Source not assigned');
  if not Assigned(Target) then
    raise Exception.Create('Target not assigned');

  Target.Clear;
  CreateMainBands;
end;

procedure TConverterQr2Fr.CreateCustomBand(const ABand: TQRCustomBand);
var
  Band: TfrxBand;
begin
  if ABand.BandType = rbPageHeader then
    Band := TfrxPageHeader.Create(Target.Pages[0])
  else
  if ABand.BandType = rbPageFooter then
    Band := TfrxPageFooter.Create(Target.Pages[0])
  else
  if ABand.BandType = rbTitle then
    Band := TfrxHeader.Create(Target.Pages[0])
  else
  if ABand.BandType = rbChild then
    Band := TfrxChild.Create(Target.Pages[0])
  else
  if ABand.BandType = rbColumnHeader then
    Band := TfrxColumnHeader.Create(Target.Pages[0])
  else
  if ABand.BandType = rbGroupHeader then
    Band := TfrxGroupHeader.Create(Target.Pages[0])
  else
  if ABand.BandType = rbGroupFooter then
    Band := TfrxGroupFooter.Create(Target.Pages[0])
  else
  if ABand.BandType = rbDetail then
    Band := TfrxDetailData.Create(Target.Pages[0])
  else
    Exit;

  Band.CreateUniqueName;

  Band.Top := ABand.Top;
  Band.Height := ABand.Height;

  AddObjects(ABand, Band);
end;

procedure TConverterQr2Fr.CreateMainBands;
var
  Page: TfrxReportPage;
  i: integer;
begin
  Page := TfrxReportPage.Create(Target);
  Page.CreateUniqueName;
  Page.SetDefaults;

  for i := 0 to Source.BandList.Count - 1 do
    CreateCustomBand(TQRCustomBand(Source.BandList[i]));
end;
end.
