
{******************************************}
{                                          }
{             FastReport v5.0              }
{         TeeChart Add-In Object           }
{                                          }
{         Copyright (c) 1998-2014          }
{         by Alexander Tzyganenko,         }
{            Fast Reports Inc.             }
{                                          }
{******************************************}

unit frxChart;

interface

{$I frx.inc}
{$I tee.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Menus, Controls, frxCollections,
  frxClass,
{$IFDEF DELPHI16}
  VCLTee.TeeProcs, VCLTee.TeEngine, VCLTee.Chart, VCLTee.Series, VCLTee.TeCanvas
{$ELSE}
  TeeProcs, TeEngine, Chart, Series, TeCanvas
{$ENDIF}
{$IFDEF DELPHI16}
 {$IFDEF TeeChartPro}, VCLTEE.TeeEdit{$IFNDEF TeeChart4}, VCLTEE.TeeEditCha{$ENDIF} {$ENDIF}
{$ELSE}
 {$IFDEF TeeChartPro}, TeeEdit{$IFNDEF TeeChart4}, TeeEditCha{$ENDIF} {$ENDIF}
{$ENDIF}
{$IFDEF Delphi6}
, Variants
{$ENDIF};


type
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxChartObject = class(TComponent);  // fake component
  TChartClass = class of TCustomChart;

  TfrxSeriesDataType = (dtDBData, dtBandData, dtFixedData);
  TfrxSeriesSortOrder = (soNone, soAscending, soDescending);
  TfrxSeriesXType = (xtText, xtNumber, xtDate);
  TSeriesClass = class of TChartSeries;
  TfrxChartSeries = (csLine, csArea, csPoint, csBar, csHorizBar,
    csPie, csGantt, csFastLine, csArrow, csBubble, csChartShape, csHorizArea,
    csHorizLine, csPolar, csRadar, csPolarBar, csGauge, csSmith, csPyramid,
    csDonut, csBezier, csCandle, csVolume, csPointFigure, csHistogram,
    csHorizHistogram, csErrorBar, csError, csHighLow, csFunnel, csBox,
    csHorizBox, csSurface, csContour, csWaterFall, csColorGrid, csVector3D,
    csTower, csTriSurface, csPoint3D, csBubble3D, csMyPoint, csBarJoin, csBar3D);


  TfrxSeriesItem = class(TfrxCollectionItem)
  private
    FDataBand: TfrxDataBand;
    FDataSet: TfrxDataSet;
    FDataSetName: String;
    FDataType: TfrxSeriesDataType;
    FSortOrder: TfrxSeriesSortOrder;
    FTopN: Integer;
    FTopNCaption: String;
    FSource1: String;
    FSource2: String;
    FSource3: String;
    FSource4: String;
    FSource5: String;
    FSource6: String;
    FXType: TfrxSeriesXType;
    FValues1: String;
    FValues2: String;
    FValues3: String;
    FValues4: String;
    FValues5: String;
    FValues6: String;
    Fsl1: TStringList;
    Fsl2: TStringList;
    Fsl3: TStringList;
    Fsl4: TStringList;
    Fsl5: TStringList;
    Fsl6: TStringList;
    procedure FillSeries(Series: TChartSeries);
    procedure SetDataSet(const Value: TfrxDataSet);
    procedure SetDataSetName(const Value: String);
    function GetDataSetName: String;
  protected
    function IsNameStored: Boolean; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property DataType: TfrxSeriesDataType read FDataType write FDataType;
    property DataBand: TfrxDataBand read FDataBand write FDataBand;
    property DataSet: TfrxDataSet read FDataSet write SetDataSet;
    property DataSetName: String read GetDataSetName write SetDataSetName;
    property SortOrder: TfrxSeriesSortOrder read FSortOrder write FSortOrder;
    property TopN: Integer read FTopN write FTopN;
    property TopNCaption: String read FTopNCaption write FTopNCaption;
    property XType: TfrxSeriesXType read FXType write FXType;

    { source expressions }
    property Source1: String read FSource1 write FSource1;
    property Source2: String read FSource2 write FSource2;
    property Source3: String read FSource3 write FSource3;
    property Source4: String read FSource4 write FSource4;
    property Source5: String read FSource5 write FSource5;
    property Source6: String read FSource6 write FSource6;

    { ready values. For internal use only. }
    property Values1: String read FValues1 write FValues1;
    property Values2: String read FValues2 write FValues2;
    property Values3: String read FValues3 write FValues3;
    property Values4: String read FValues4 write FValues4;
    property Values5: String read FValues5 write FValues5;
    property Values6: String read FValues6 write FValues6;

    { backward compatibility }
    property XSource: String read FSource1 write FSource1;
    property YSource: String read FSource2 write FSource2;
    property XValues: String read FValues1 write FValues1;
    property YValues: String read FValues2 write FValues2;
  end;

  TfrxSeriesData = class(TfrxCollection)
  private
    FReport: TfrxReport;
    function GetSeries(Index: Integer): TfrxSeriesItem;
  public
    constructor Create(Report: TfrxReport);
    function Add: TfrxSeriesItem;
    property Items[Index: Integer]: TfrxSeriesItem read GetSeries; default;
  end;


  TfrxChartView = class(TfrxView)
  private
    FChart: TCustomChart;
    FSeriesData: TfrxSeriesData;
    FIgnoreNulls: Boolean;
    FNotFillSeries: Boolean;
    FSavedColor: TColor;
    FHlIndex: Integer;
    FClickedVal1: String;
    FClickedVal2: String;
    FClickedVal3: String;
    FClickedVal4: String;
    FClickedVal5: String;
    FClickedVal6: String;
    FHighlightColor: TColor;
    //FChart: TCustomChart;
    procedure FillChart;
    procedure ReadData(Stream: TStream);
    procedure ReadData1(Reader: TReader);
    procedure ReadData2(Reader: TReader);
    procedure WriteData(Stream: TStream);
    procedure WriteData1(Writer: TWriter);
    procedure WriteData2(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateChart; virtual;
    class function GetChartClass: TChartClass; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoMouseMove(X, Y: Integer; Button: TMouseButton; Shift: TShiftState; var Refresh: Boolean); override;
    procedure DoMouseEnter(Sender: TfrxComponent; var Refresh: Boolean); override;
    procedure DoMouseLeave(Sender: TfrxComponent; var Refresh: Boolean); override;
    class function GetDescription: String; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure AfterPrint; override;
    procedure GetData; override;
    procedure BeforeStartReport; override;
    procedure OnNotify(Sender: TObject); override;
    procedure ClearSeries;
    procedure AddSeries(Series: TfrxChartSeries);

    property Chart: TCustomChart read FChart;
    property SeriesData: TfrxSeriesData read FSeriesData;
    property HighlightIndex: Integer read FHLIndex;
    property ClickedVal1: String read FClickedVal1;
    property ClickedVal2: String read FClickedVal2;
    property ClickedVal3: String read FClickedVal3;
    property ClickedVal4: String read FClickedVal4;
    property ClickedVal5: String read FClickedVal5;
    property ClickedVal6: String read FClickedVal6;
  published
    property IgnoreNulls: Boolean read FIgnoreNulls write FIgnoreNulls default False;
    property HighlightColor: TColor read FHighlightColor write FHighlightColor default clHotLight;
    property FillType;
    property Fill;
    property Cursor;
    property Frame;
    property TagStr;
    property URL;
  end;


implementation

uses
  frxChartHelpers, frxChartRTTI,
{$IFNDEF NO_EDITORS}
  frxChartEditor,
{$ENDIF}
  frxDsgnIntf, frxUtils, frxRes, Math;


{ TfrxSeriesItem }

procedure TfrxSeriesItem.SetDataSet(const Value: TfrxDataSet);
begin
  FDataSet := Value;
  if FDataSet = nil then
    FDataSetName := '' else
    FDataSetName := FDataSet.UserName;
end;

procedure TfrxSeriesItem.SetDataSetName(const Value: String);
begin
  FDataSetName := Value;
  if FDataSetName = '' then
    FDataSet := nil
  else  if TfrxSeriesData(Collection).FReport <> nil then
    FDataSet := TfrxSeriesData(Collection).FReport.FindDataSet(FDataSet, FDataSetName);
end;

function TfrxSeriesItem.GetDataSetName: String;
begin
  if FDataSet = nil then
    Result := FDataSetName else
    Result := FDataSet.UserName;
end;

function TfrxSeriesItem.IsNameStored: Boolean;
begin
  Result := True;
end;


constructor TfrxSeriesItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  Fsl1 := TStringList.Create;
  Fsl2 := TStringList.Create;
  Fsl3 := TStringList.Create;
  Fsl4 := TStringList.Create;
  Fsl5 := TStringList.Create;
  Fsl6 := TStringList.Create;
end;

destructor TfrxSeriesItem.Destroy;
begin
  Fsl1.Free;
  Fsl2.Free;
  Fsl3.Free;
  Fsl4.Free;
  Fsl5.Free;
  Fsl6.Free;

  inherited;
end;

procedure TfrxSeriesItem.FillSeries(Series: TChartSeries);
var
  i: Integer;
  v1, v2, v3, v4, v5, v6: String;
  Helper: TfrxSeriesHelper;

  procedure Sort;
  var
    i, idx, iStart, SortOrd: Integer;
    d, mMax: Double;
    s: String;
  begin
    if Fsl1.Count <> Fsl2.Count then exit;

   {bug fix, stringList sort all negative values as string }
    if FSortOrder = soAscending then  SortOrd := 1
    else SortOrd := -1;
    iStart := 0;

    while Fsl2.Count > iStart do
    begin
      idx := 0;
      mMax := MaxDouble * SortOrd;
      for i := iStart to Fsl2.Count - 1 do
      begin
        s := Fsl2[i];
        if not frxIsValidFloat(s) then d := 0
        else d := frxStrToFloat(s);
        if d * SortOrd < mMax * SortOrd then
        begin
          mMax := d;
          idx := i;
        end;
      end;
      Fsl1.Move(idx,iStart);
      Fsl2.Move(idx,iStart);
      if idx < Fsl3.Count then Fsl3.Move(idx, iStart);
      if idx < Fsl4.Count then Fsl4.Move(idx, iStart);
      if idx < Fsl5.Count then Fsl5.Move(idx, iStart);
      if idx < Fsl6.Count then Fsl6.Move(idx, iStart);
      inc(iStart);
    end;
  end;

  procedure MakeTopN;
  var
    i: Integer;
    d: Double;
  begin
    if Fsl1.Count <> Fsl2.Count then exit;
    { for future using
    if FSortOrder <> soNone then Sort;}

    FSortOrder := soDescending;
    Sort;
    d := 0;
    for i := Fsl2.Count - 1 downto FTopN - 1 do
    begin
      d := d + frxStrToFloat(Fsl2[i]);
      Fsl1.Delete(i);
      Fsl2.Delete(i);
      if i < Fsl3.Count then Fsl3.Delete(i);
      if i < Fsl4.Count then Fsl4.Delete(i);
      if i < Fsl5.Count then Fsl5.Delete(i);
      if i < Fsl6.Count then Fsl6.Delete(i);
    end;

    Fsl1.Add(FTopNCaption);
    Fsl2.Add(FloatToStr(d));
  end;

begin
  Fsl1.Clear;
  Fsl2.Clear;
  Fsl3.Clear;
  Fsl4.Clear;
  Fsl5.Clear;
  Fsl6.Clear;

  Series.Clear;

  v1 := FValues1;
  if (v1 <> '') and (v1[1] = ';') then
    Delete(v1, 1, 1);
  v2 := FValues2;
  if (v2 <> '') and (v2[1] = ';') then
    Delete(v2, 1, 1);
  v3 := FValues3;
  if (v3 <> '') and (v3[1] = ';') then
    Delete(v3, 1, 1);
  v4 := FValues4;
  if (v4 <> '') and (v4[1] = ';') then
    Delete(v4, 1, 1);
  v5 := FValues5;
  if (v5 <> '') and (v5[1] = ';') then
    Delete(v5, 1, 1);
  v6 := FValues6;
  if (v6 <> '') and (v6[1] = ';') then
    Delete(v6, 1, 1);

  frxSetCommaText(v1, Fsl1);
  frxSetCommaText(v2, Fsl2);
  frxSetCommaText(v3, Fsl3);
  frxSetCommaText(v4, Fsl4);
  frxSetCommaText(v5, Fsl5);
  frxSetCommaText(v6, Fsl6);

  Helper := frxFindSeriesHelper(Series);

  try
    if Fsl2.Count > 0 then
    begin
      if (FTopN > 0) and (FTopN < Fsl2.Count) then
        MakeTopN
      else if FSortOrder <> soNone then
        Sort;

      for i := 0 to Fsl2.Count - 1 do
      begin
        if i < Fsl1.Count then v1 := Fsl1[i] else v1 := '';
        if i < Fsl2.Count then v2 := Fsl2[i] else v2 := '';
        if i < Fsl3.Count then v3 := Fsl3[i] else v3 := '';
        if i < Fsl4.Count then v4 := Fsl4[i] else v4 := '';
        if i < Fsl5.Count then v5 := Fsl5[i] else v5 := '';
        if i < Fsl6.Count then v6 := Fsl6[i] else v6 := '';
        Helper.AddValues(Series, v1, v2, v3, v4, v5, v6, FXType);
      end;
    end;

  finally
    Helper.Free;
  end;
end;

{ TfrxSeriesData }

constructor TfrxSeriesData.Create(Report: TfrxReport);
begin
  inherited Create(TfrxSeriesItem);
  FReport := Report;
end;

function TfrxSeriesData.Add: TfrxSeriesItem;
begin
  Result := TfrxSeriesItem(inherited Add);
end;

function TfrxSeriesData.GetSeries(Index: Integer): TfrxSeriesItem;
begin
  Result := TfrxSeriesItem(inherited Items[Index]);
end;


{ TfrxChartView }

constructor TfrxChartView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CreateChart;
  FSeriesData := TfrxSeriesData.Create(Report);
  FHlIndex := -1;
end;

destructor TfrxChartView.Destroy;
begin
  FChart.Free;
  inherited Destroy;
  FSeriesData.Free;
end;

class function TfrxChartView.GetDescription: String;
begin
  Result := frxResources.Get('obChart');
end;

procedure TfrxChartView.Notification(AComponent: TComponent; Operation: TOperation);
var
  i: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    for i := 0 to FSeriesData.Count - 1 do
      if AComponent is TfrxDataSet then
      begin
        if FSeriesData[i].DataSet = AComponent then
          FSeriesData[i].DataSet := nil;
      end
      else if AComponent is TfrxBand then
      begin
        if FSeriesData[i].DataBand = AComponent then
          FSeriesData[i].DataBand := nil;
      end;
  end;
end;

class function TfrxChartView.GetChartClass: TChartClass;
begin
  Result := TChart;
end;

procedure TfrxChartView.CreateChart;
begin
  FChart := GetChartClass.Create(nil);
//  FChart := TChart.Create(nil);
  with FChart do
  begin
    Color := clWhite;
    BevelInner := bvNone;
    BevelOuter := bvNone;
//{$IFDEF DELPHI19}
//    if FChart.ParentWindow = 0 then
//      FChart.ParentWindow := frxParentForm.Handle;
//{$ENDIF}
    Name := 'Chart';
    Frame.Visible := False;
    View3DOptions.Rotation := 0;
    Title.Text.Text := '';
  end;

end;

procedure TfrxChartView.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('Chart', ReadData, WriteData, True);
  Filer.DefineProperty('ChartElevation', ReadData1, WriteData1, True);
  Filer.DefineProperty('SeriesData', ReadData2, WriteData2, True);
end;

procedure TfrxChartView.ReadData(Stream: TStream);
begin
  FChart.Free;
  CreateChart;
  Stream.ReadComponent(FChart);
end;

procedure TfrxChartView.WriteData(Stream: TStream);
begin
  Stream.WriteComponent(FChart);
end;

procedure TfrxChartView.ReadData1(Reader: TReader);
begin
  FChart.View3DOptions.Elevation := Reader.ReadInteger;
end;

procedure TfrxChartView.WriteData1(Writer: TWriter);
begin
  Writer.WriteInteger(FChart.View3DOptions.Elevation);
end;

procedure TfrxChartView.ReadData2(Reader: TReader);
begin
  frxReadCollection(FSeriesData, Reader, Self);
end;

procedure TfrxChartView.WriteData2(Writer: TWriter);
begin
  frxWriteCollection(FSeriesData, Writer, Self);
end;

procedure TfrxChartView.FillChart;
var
  i: Integer;
begin
  if FNotFillSeries then Exit;
  for i := 0 to FSeriesData.Count - 1 do
    FSeriesData[i].FillSeries(FChart.Series[i]);
end;

procedure TfrxChartView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  EMF: TMetafile;
  PrinterHandle: THandle;
  aScaleX, aScaleY: Extended;
  EMFCanvas: TMetafileCanvas;
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  DrawBackground;
  FillChart;
//  if Color = clTransparent then
//    FChart.Color := clWhite else
//    FChart.Color := Color;
  FChart.BufferedDisplay := True;
  PrinterHandle := GetDC(0);
  try
    GetDisplayScale(PrinterHandle, False, aScaleX, aScaleY);
  finally
    ReleaseDC(0, PrinterHandle);
  end;
  // EMF := FChart.TeeCreateMetafile(False, Rect(0, 0, Round(Width), Round(Height)));
  EMF := TMetafile.Create;

  try
    if aScaleX > 1 then aScaleX := 1;
    if aScaleY > 1 then aScaleY := 1;
    EMF.Width := Round(Width * aScaleX);
    EMF.Height := Round(Height * aScaleY);
    EMFCanvas := TMetafileCanvas.Create(EMF, 0);
    FChart.DrawToMetaCanvas(EMFCanvas, Rect(0, 0, Round(Width), Round(Height)));
    EMFCanvas.Free;
    // EMF.Transparent := True;
    Canvas.StretchDraw(Rect(FX, FY, FX1, FY1), EMF);
    // Canvas.CopyMode := cmSrcPaint;
    // Canvas.StretchDraw(Rect(FX, FY, FX1, FY1), EMF);
  finally
    EMF.Free;
    DrawFrame;
  end;
end;

procedure TfrxChartView.AfterPrint;
var
  i: Integer;
begin
  for i := 0 to FSeriesData.Count - 1 do
    with FSeriesData[i] do
    begin
      Values1 := '';
      Values2 := '';
      Values3 := '';
      Values4 := '';
      Values5 := '';
      Values6 := '';
    end;
end;

procedure TfrxChartView.GetData;
var
  i: Integer;
  function ConvertVarToStr(Val: Variant): String;
  begin
    if not FIgnoreNulls and VarIsNull(Val) then
      Result := '0'
    else
      Result := VarToStr(Val)
  end;
begin
  inherited;
  for i := 0 to FSeriesData.Count - 1 do
    with FSeriesData[i] do
      if (DataType = dtDBData) and (DataSet <> nil) then
      begin
        Values1 := '';
        Values2 := '';
        Values3 := '';
        Values4 := '';
        Values5 := '';
        Values6 := '';

        DataSet.First;
        while not DataSet.Eof do
        begin
          if Source1 <> '' then
            Values1 := Values1 + ';' + VarToStr(Report.Calc(Source1));
          if Source2 <> '' then
            Values2 := Values2 + ';' + ConvertVarToStr(Report.Calc(Source2));
          if Source3 <> '' then
            Values3 := Values3 + ';' + ConvertVarToStr(Report.Calc(Source3));
          if Source4 <> '' then
            Values4 := Values4 + ';' + ConvertVarToStr(Report.Calc(Source4));
          if Source5 <> '' then
            Values5 := Values5 + ';' + ConvertVarToStr(Report.Calc(Source5));
          if Source6 <> '' then
            Values6 := Values6 + ';' + ConvertVarToStr(Report.Calc(Source6));
          DataSet.Next;
        end;
      end
      else if DataType = dtFixedData then
      begin
        Values1 := Source1;
        Values2 := Source2;
        Values3 := Source3;
        Values4 := Source4;
        Values5 := Source5;
        Values6 := Source6;
      end
end;

procedure TfrxChartView.BeforeStartReport;
var
  i: Integer;
begin
  for i := 0 to FSeriesData.Count - 1 do
    with FSeriesData[i] do
    begin
      Values1 := '';
      Values2 := '';
      Values3 := '';
      Values4 := '';
      Values5 := '';
      Values6 := '';
    end;
  Report.Engine.NotifyList.Add(Self);
end;

procedure TfrxChartView.OnNotify(Sender: TObject);
var
  i: Integer;
  function ConvertVarToStr(Val: Variant): String;
  begin
    if FIgnoreNulls and VarIsNull(Val) then
      Result := '0'
    else
      Result := VarToStr(Val)
  end;
begin
  inherited;
  for i := 0 to FSeriesData.Count - 1 do
    with FSeriesData[i] do
      if (DataType = dtBandData) and (DataBand = Sender) then
      begin
        Report.CurObject := Self.Name;
        if Source1 <> '' then
          Values1 := Values1 + ';' + VarToStr(Report.Calc(Source1));
        if Source2 <> '' then
          Values2 := Values2 + ';' + ConvertVarToStr(Report.Calc(Source2));
        if Source3 <> '' then
          Values3 := Values3 + ';' + ConvertVarToStr(Report.Calc(Source3));
        if Source4 <> '' then
          Values4 := Values4 + ';' + ConvertVarToStr(Report.Calc(Source4));
        if Source5 <> '' then
          Values5 := Values5 + ';' + ConvertVarToStr(Report.Calc(Source5));
        if Source6 <> '' then
          Values6 := Values6 + ';' + ConvertVarToStr(Report.Calc(Source6));
      end;
end;

procedure TfrxChartView.AddSeries(Series: TfrxChartSeries);
var
  sc: TSeriesClass;
  s: TChartSeries;
  b: Boolean;
begin
  sc := frxChartSeries[Integer(Series)];
  s := TChartSeries(sc.NewInstance);
  s.Create(Chart);
  Chart.AddSeries(s);
  SeriesData.Add;

  with Chart do
  begin
    b := not (s is TPieSeries);
    View3DOptions.Orthogonal := b;
    AxisVisible := b;
    View3DWalls := b;
  end;
end;

procedure TfrxChartView.ClearSeries;
begin
  FChart.Free;
  CreateChart;
  SeriesData.Clear;
end;

procedure TfrxChartView.DoMouseMove(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var Refresh: Boolean);
var
  i: Integer;
begin
  if FChart.SeriesCount = 0 then Exit;
  if FChart.ParentWindow = 0 then
    FChart.ParentWindow := frxParentForm.Handle;
  i := FChart.Series[0].Clicked( Round((X - FX) / FScaleX),Round((Y - FY) / FScaleY));
  if (i <> -1) and (i = FHlIndex) then Exit;
  if FHlIndex <> -1 then
  begin
    FChart.Series[0].ValueColor[FHlIndex] := FSavedColor;
    FHlIndex := -1;
  end;
  if i <> - 1 then
  begin
    FSavedColor := FChart.Series[0].ValueColor[i];
    FChart.Series[0].ValueColor[i] := FHighlightColor;
    FHlIndex := i;
    if SeriesData[0].Fsl1.Count > i then
      FClickedVal1 := SeriesData[0].Fsl1[i];
    if SeriesData[0].Fsl2.Count > i then
      FClickedVal2 := SeriesData[0].Fsl2[i];
    if SeriesData[0].Fsl3.Count > i then
      FClickedVal3 := SeriesData[0].Fsl3[i];
    if SeriesData[0].Fsl4.Count > i then
      FClickedVal4 := SeriesData[0].Fsl4[i];
    if SeriesData[0].Fsl5.Count > i then
      FClickedVal5 := SeriesData[0].Fsl5[i];
    if SeriesData[0].Fsl6.Count > i then
      FClickedVal6 := SeriesData[0].Fsl6[i];
  end;
  Refresh := True;
end;

procedure TfrxChartView.DoMouseEnter(Sender: TfrxComponent;
  var Refresh: Boolean);
begin
  { don't update series for interactive Chart }
  FNotFillSeries := True;
end;

procedure TfrxChartView.DoMouseLeave(Sender: TfrxComponent;
  var Refresh: Boolean);
begin
  FNotFillSeries := False;
end;


initialization
{$IFNDEF TeeChartStd}
{$IFNDEF TeeChartStd7}
{$IFNDEF TeeChartStd8}
{$IFNDEF TeeChartStd9}
{$IFNDEF TeeChart4}
  RegisterTeeStandardSeries;
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxChartObject, TControl);
{$ENDIF}
  frxObjects.RegisterObject1(TfrxChartView, nil, '', '', 0, 25);

finalization
  frxObjects.UnRegister(TfrxChartView);

end.
