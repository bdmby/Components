{ --------------------------------------------------------------------------- }
{ AnyDAC FastReport v 4.0 enduser components                                  }
{                                                                             }
{ (c)opyright DA-SOFT Technologies 2004-2013.                                 }
{ All rights reserved.                                                        }
{                                                                             }
{ Initially created by: Serega Glazyrin <glserega@mezonplus.ru>               }
{ Extended by: Francisco Armando Duenas Rodriguez <fduenas@gmxsoftware.com>   }
{ --------------------------------------------------------------------------- }
{$I frx.inc}

unit frxFDComponents;

interface

uses
  Windows, Classes, SysUtils, frxClass, frxCustomDB, DB, FireDAC.DatS,
  FireDAC.Comp.Client, FireDAC.Stan.Option, FireDAC.Comp.DataSet
{$IFDEF Delphi6}
, Variants
{$ENDIF}
{$IFDEF QBUILDER}
, fqbClass
{$ENDIF};

type
  TfrxFDComponents = class(TfrxDBComponents)
  private
    FDefaultDatabase: TFDConnection;
    FOldComponents: TfrxFDComponents;
    FDesignTimeExpr: Boolean;
    procedure SetDefaultDatabase(const AValue: TFDConnection);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDescription: String; override;
  published
    property DefaultDatabase: TFDConnection read FDefaultDatabase write SetDefaultDatabase;
    // whether or not to calc expressions at design-time
    property DesignTimeExpr: Boolean read FDesignTimeExpr write FDesignTimeExpr
      stored False default False;
  end;

  TfrxFDDatabase = class(TfrxCustomDatabase)
  private
    FDatabase: TFDConnection;
    function GetDriverName: string;
    procedure SetDriverName(const AValue: string);
    function GetConnectionDefName: string;
    procedure SetConnectionDefName(const AValue: string);
  protected
    procedure SetConnected(AValue: Boolean); override;
    procedure SetDatabaseName(const AValue: String); override;
    procedure SetLoginPrompt(AValue: Boolean); override;
    procedure SetParams(AValue: TStrings); override;
    function GetConnected: Boolean; override;
    function GetDatabaseName: String; override;
    function GetLoginPrompt: Boolean; override;
    function GetParams: TStrings; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    procedure SetLogin(const ALogin, APassword: String); override;
    function ToString: WideString; override;
    procedure FromString(const AConnection: WideString); override;
    property Database: TFDConnection read FDatabase;
  published
    property ConnectionDefName: string read GetConnectionDefName write SetConnectionDefName;
    property DriverName: string read GetDriverName write SetDriverName;
    property DatabaseName;
    property Params;
    property LoginPrompt;
    property Connected;
  end;

  TfrxFDQuery = class(TfrxCustomQuery)
  private
    FDatabase: TfrxFDDatabase;
    FQuery: TFDQuery;
    procedure SetDatabase(const AValue: TfrxFDDatabase);
    function GetUniDirectional: boolean;
    procedure SetUniDirectional(const AValue: boolean);
    procedure DoMasterSetValues(ASender: TFDDataSet);
  protected
    FLocked: Boolean;
    FStrings: TStrings;
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure OnChangeSQL(Sender: TObject); override;
    procedure SetMaster(const AValue: TDataSource); override;
    procedure SetMasterFields(const AValue: String); override;
    procedure SetSQL(AValue: TStrings); override;
    function GetSQL: TStrings; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; AFlags: Word); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    procedure FetchParams; virtual;
    procedure UpdateParams; override;
{$IFDEF QBUILDER}
    function QBEngine: TfqbEngine; override;
{$ENDIF}
    property Query: TFDQuery read FQuery;
  published
    property SQL;
    property Database: TfrxFDDatabase read FDatabase write SetDatabase;
    property UniDirectional: Boolean read GetUniDirectional write SetUniDirectional default False;
    property MasterFields;
  end;

  TfrxFDTable = class(TfrxCustomTable)
  private
    FDatabase: TfrxFDDatabase;
    FTable: TFDTable;
    procedure SetDatabase(const AValue: TfrxFDDatabase);
    function GetCatalogName: String;
    function GetSchemaName: String;
    procedure SetCatalogName(const AValue: String);
    procedure SetSchemaName(const AValue: String);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure SetMaster(const AValue: TDataSource); override;
    procedure SetMasterFields(const AValue: String); override;
    procedure SetIndexFieldNames(const AValue: String); override;
    procedure SetIndexName(const AValue: String); override;
    procedure SetTableName(const AValue: String); override;
    function GetIndexFieldNames: String; override;
    function GetIndexName: String; override;
    function GetTableName: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; AFlags: Word); override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    property Table: TFDTable read FTable;
  published
    property Database: TfrxFDDatabase read FDatabase write SetDatabase;
    property CatalogName: String read GetCatalogName write SetCatalogName;
    property SchemaName: String read GetSchemaName write SetSchemaName;
  end;

  TfrxCustomStoredProc = class(TfrxCustomDataset)
  private
    FParams: TfrxParams;
    FSaveOnBeforeOpen: TDataSetNotifyEvent;
    FSaveOnAfterOpen: TDataSetNotifyEvent;
    procedure ReadParamData(AReader: TReader);
    procedure WriteParamData(AWriter: TWriter);
    procedure SetParams(AValue: TfrxParams);
  protected
    procedure DefineProperties(AFiler: TFiler); override;
    function GetStoredProcName: string; virtual;
    procedure SetStoredProcName(const AValue: string); virtual;
    procedure TriggerOnBeforeOpen(ADataSet: TDataSet); virtual;
    procedure TriggerOnAfterOpen(ADataSet: TDataSet); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ExecProc; virtual;
    procedure UpdateParams; virtual;
    procedure Prepare; virtual;
    procedure FetchParams; virtual;
    function ParamByName(const AValue: String): TfrxParamItem;
  published
    property Params: TfrxParams read FParams write SetParams;
    property StoredProcName: string read GetStoredProcName write SetStoredProcName; {added by fduenas}
  end;

  TfrxFDStoredProc = class(TfrxCustomStoredProc)
  private
    FDatabase: TfrxFDDatabase;
    FStoredProc: TFDStoredProc;
	// added for Master-Detail relationship
    procedure DoMasterSetValues(ASender: TFDDataSet);
    procedure SetDatabase(const AValue: TfrxFDDatabase);
    function GetPackageName: String;
    procedure SetPackageName(const AValue: String);
    function GetCatalogName: String;
    function GetSchemaName: String;
    procedure SetCatalogName(const AValue: String);
    procedure SetSchemaName(const AValue: String);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    function GetStoredProcName: string; override;
    procedure SetStoredProcName(const AValue: string); override;
    // added for Master-Detail RelationShip
    procedure SetMaster(const AValue: TDataSource); override;
    procedure TriggerOnAfterOpen(ADataSet: TDataSet); override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; AFlags: Word); override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    procedure ExecProc; override;
    procedure Prepare; override;
    procedure UpdateParams; override;
    procedure FetchParams; override;
    property StoredProc: TFDStoredProc read FStoredProc;
  published
    property Database: TfrxFDDatabase read FDatabase write SetDatabase;
    property CatalogName: String read GetCatalogName write SetCatalogName;
    property SchemaName: String read GetSchemaName write SetSchemaName;
    property PackageName: String read GetPackageName write SetPackageName;
  end;

{$IFDEF QBUILDER}
  TfrxEngineFD = class(TfqbEngine)
  private
    FQuery: TFDQuery;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ReadTableList(ATableList: TStrings); override;
    procedure ReadFieldList(const ATableName: string; var AFieldList: TfqbFieldList); override;
    function ResultDataSet: TDataSet; override;
    procedure SetSQL(const AValue: string); override;
  end;
{$ENDIF}

var
  GFDComponents: TfrxFDComponents;

implementation

{$R *.res}

uses
  Dialogs, StrUtils,
  frxFDRTTI,
{$IFNDEF NO_EDITORS}
  frxFDEditor,
{$ENDIF}
  frxDsgnIntf, frxUtils, frxRes,
  FireDAC.Stan.Param, FireDAC.Stan.Def, FireDAC.Stan.Util,
  FireDAC.Phys;

type
  TfrxHackFDDataSet = Class(TFDDataSet);

{-------------------------------------------------------------------------------}
{ TfrxFDComponents                                                              }
{-------------------------------------------------------------------------------}
constructor TfrxFDComponents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOldComponents := GFDComponents;
  FDesignTimeExpr := True;
  GFDComponents := Self;
end;

{-------------------------------------------------------------------------------}
destructor TfrxFDComponents.Destroy;
begin
  if GFDComponents = Self then
    GFDComponents := FOldComponents;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDComponents.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FDefaultDatabase) and (Operation = opRemove) then
    FDefaultDatabase := nil;
end;

{-------------------------------------------------------------------------------}
function TfrxFDComponents.GetDescription: String;
begin
  Result := 'FD';
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDComponents.SetDefaultDatabase(const AValue: TFDConnection);
begin
  if FDefaultDatabase <> AValue then begin
    if FDefaultDatabase <> nil then
      FDefaultDatabase.RemoveFreeNotification(Self);
    FDefaultDatabase := AValue;
    if FDefaultDatabase <> nil then
      FDefaultDatabase.FreeNotification(Self);
  end;
end;

{-------------------------------------------------------------------------------}
{ TfrxFDDatabase                                                                }
{-------------------------------------------------------------------------------}
constructor TfrxFDDatabase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDatabase := TFDConnection.Create(nil);
  Component := FDatabase;
end;

{-------------------------------------------------------------------------------}
destructor TfrxFDDatabase.Destroy;
begin
  // FDatabase.Free;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TfrxFDDatabase.GetDescription: String;
begin
  Result := 'FD Database';
end;

{-------------------------------------------------------------------------------}
function TfrxFDDatabase.GetConnectionDefName: string;
begin
  Result := FDatabase.ConnectionDefName;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDDatabase.SetConnectionDefName(const AValue: string);
begin
  FDatabase.ConnectionDefName := AValue;
end;

{-------------------------------------------------------------------------------}
function TfrxFDDatabase.GetDriverName: string;
begin
  Result := FDatabase.DriverName;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDDatabase.SetDriverName(const AValue: string);
begin
  FDatabase.DriverName := AValue;
end;

{-------------------------------------------------------------------------------}
function TfrxFDDatabase.GetDatabaseName: String;
begin
{$IFDEF DELPHI21}
  Result := FDatabase.ResultConnectionDef.Params.Database;
{$ELSE}
  Result := FDatabase.ResultConnectionDef.Database;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDDatabase.SetDatabaseName(const AValue: String);
begin
{$IFDEF DELPHI21}
  FDatabase.ResultConnectionDef.Params.Database := AValue;
{$ELSE}
  FDatabase.ResultConnectionDef.Database := AValue;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TfrxFDDatabase.GetParams: TStrings;
begin
  Result := FDatabase.Params;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDDatabase.SetParams(AValue: TStrings);
begin
{$IFDEF DELPHI21}
  FDatabase.Params.Assign(AValue);
{$ELSE}
  FDatabase.Params := AValue;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TfrxFDDatabase.GetLoginPrompt: Boolean;
begin
  Result := FDatabase.LoginPrompt;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDDatabase.SetLoginPrompt(AValue: Boolean);
begin
  FDatabase.LoginPrompt := AValue;
end;

{-------------------------------------------------------------------------------}
function TfrxFDDatabase.GetConnected: Boolean;
begin
  Result := FDatabase.Connected;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDDatabase.SetConnected(AValue: Boolean);
begin
  BeforeConnect(AValue);
  FDatabase.Connected := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDDatabase.SetLogin(const ALogin, APassword: String);
begin
{$IFDEF DELPHI21}
  FDatabase.ResultConnectionDef.Params.UserName := ALogin;
  FDatabase.ResultConnectionDef.Params.Password := APassword;
{$ELSE}
  FDatabase.ResultConnectionDef.UserName := ALogin;
  FDatabase.ResultConnectionDef.Password := APassword;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDDatabase.FromString(const AConnection: WideString);
begin
  FDatabase.ResultConnectionDef.ParseString(AConnection);
end;

{-------------------------------------------------------------------------------}
function TfrxFDDatabase.ToString: WideString;
begin
  Result := FDatabase.ResultConnectionDef.BuildString();
end;

{-------------------------------------------------------------------------------}
{ TfrxFDQuery                                                                   }
{-------------------------------------------------------------------------------}
procedure frxParamsToFDParams(ADataSet: TfrxCustomDataset; AFrxParams: TfrxParams;
  AFDParams: TFDParams; AMasterDetail: boolean=false);
var
  i, j, iFld: Integer;
  oFDParam: TFDParam;
  oFrxParam: TfrxParamItem;
  oMasterFields: TStringList;
  lSkip, lDesignTime: Boolean;
  oQuery: TFDQuery;
  sExpr: String;
  vRes: Variant;
  ds: TFDRdbmsDataSet;

  function CanExpandEscape(AReport: TfrxReport; AExpr: String;
    out ARes: Variant): Boolean;
  var
    sVar: String;
    i: Integer;
    lIsVar: Boolean;
  begin
    Result := oQuery.Connection <> nil;
    if Result then begin
      sVar := AExpr;
      // 1st iteration of check
      lIsVar := (sVar[1] = '<') and (sVar[Length(sVar)] = '>');
      if lIsVar then begin
        i := AReport.Variables.IndexOf(Copy(sVar, 2, Length(sVar) - 2));
        Result := i <> -1;
        if Result then
          sVar := VarToStr(AReport.Variables.Items[i].Value)
        else
          Exit;
      end;
      // 2nd iteration
      Result := (Length(sVar) >= 5) and (sVar[1] = '{') and
                (sVar[Length(sVar)] = '}') and not(FDInSet(sVar[2], ['0' .. '9']));
      if Result then begin
        oQuery.SQL.Text := 'SELECT ' + sVar;
        try
          oQuery.Open;
        except
          Result := False;
        end;
        Result := Result and (oQuery.RecordCount = 1);
        if Result then
          ARes := oQuery.Fields[0].Value;
      end;
    end;
  end;

begin
  ds := nil;
  if ADataSet is TfrxFDQuery then
    ds := TfrxFDQuery(ADataSet).FQuery
  else if ADataSet is TfrxFDStoredProc then
    ds := TfrxFDStoredProc(ADataSet).FStoredProc;
  if ds = nil then Exit;
  lDesignTime := (ADataSet.IsLoading or ADataSet.IsDesigning);
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := ds.Connection;
  oQuery.ResourceOptions.EscapeExpand := True;
  try
    for i := 0 to AFDParams.Count - 1 do begin
      oFDParam := AFDParams[i];
      j := AFrxParams.IndexOf(oFDParam.Name);
      if j <> -1 then begin
        oFrxParam := AFrxParams[j];
        oFDParam.Clear;
        oFDParam.DataType := oFrxParam.DataType;
        oFDParam.Bound := lDesignTime;

        if AMasterDetail and (ADataSet is TfrxFDQuery) then begin
          oMasterFields := TStringList.Create;
          try
            oMasterFields.Delimiter := ';';
            oMasterFields.DelimitedText := ds.MasterFields;
            lSkip := False;
            for iFld := 0 to oMasterFields.Count - 1 do begin
              lSkip := {$IFDEF AnyDAC_NOLOCALE_META} FDCompareText {$ELSE} AnsiCompareText {$ENDIF}
                (oFDParam.Name, oMasterFields[iFld]) = 0;
              if lSkip then
                Break;
            end;
            if lSkip then
              Continue;
          finally
            oMasterFields.Free;
          end;
        end;

        sExpr := oFrxParam.Expression;
        if Trim(sExpr) <> '' then
        begin
          if ADataSet.Report <> nil then
            if CanExpandEscape(ADataSet.Report, sExpr, vRes) then
              oFrxParam.Value := vRes
            else if not (ADataSet.IsLoading or ADataSet.IsDesigning) then
            begin
              ADataSet.Report.CurObject := ADataSet.Name;
              oFrxParam.Value := ADataSet.Report.Calc(oFrxParam.Expression);
            end
            else
            begin
              if oFDParam.DataType in [ftString, ftWideString, ftFixedWideChar, ftWideMemo, ftFmtMemo, ftMemo] then
                oFrxParam.Value := ''
              else if oFDParam.DataType in [ftVariant, ftInteger, ftWord, ftLargeint, ftTimeStamp, ftFMTBcd, ftOraTimeStamp, ftLongWord, ftShortint, ftByte, ftExtended, ftSingle] then
                oFrxParam.Value := 0
              else
                oFrxParam.Value := Unassigned;
            end
           // else
           //   oFrxParam.Value := sExpr;
        end;

        if not VarIsEmpty(oFrxParam.Value) then
        begin
          oFDParam.Bound := True;
          oFDParam.Value := oFrxParam.Value;
        end;
      end;
    end;
  finally
    oQuery.Free;
  end;
end;

{-------------------------------------------------------------------------------}
{
 function used to recreate a TFrxParams collection from a TFDParams collection
 useful when borrowing TFDparams from any TFDQuery and TFDStoredProc objects after assigning
 a new SQL Text that can contain parameters (:paramName1, :paramName2, :paramNameN)
}

procedure frxFDParamsToParams(ADataSet: TfrxCustomDataSet; AFDParams: TFDParams;
  AfrxParams: TfrxParams; AIgnoreDuplicates: Boolean = True; AMasterDataSet: TDataset=nil );
var
  i, j: Integer;
  NewParams: TfrxParams;
begin
  if AfrxParams = nil then
    Exit;
  { create new TfrxParams object and copy all params to it }
  NewParams := TfrxParams.Create;
  try
    for i := 0 to AFDParams.Count - 1 do
      if not ((NewParams.IndexOf(AFDParams[i].Name) <> -1) and AIgnoreDuplicates) then
        with NewParams.Add do begin
          Name := AFDParams[i].Name;
          j := AfrxParams.IndexOf(Name);
          DataType := AFDParams.Items[i].DataType;
          if assigned( AMasterDataSet ) and
             assigned( AMasterDataSet.FindField(Name) ) and
             (DataType = ftUnknown) then
             DataType := AMasterDataSet.FindField(Name).DataType;

          if j <> -1 then begin
            Value := AfrxParams.Items[j].Value;
            Expression := AfrxParams.Items[j].Expression;
          end
          else
            Value := AFDParams.Items[i].Value;
        end;
    AfrxParams.Clear;
    AfrxParams.Assign(NewParams);
  finally
    NewParams.Free;
  end;
end;

{-------------------------------------------------------------------------------}
{
 function borrow only values from any TFDparams to TfrxParams
  used normally when calling TfrxFDStoredProc.ExecProc and the stored
  procedure returns values by Parameters )
}

procedure frxFDParamValuesToParams(ADataSet: TfrxCustomDataSet; AFDParams: TFDParams;
  AfrxParams: TfrxParams; AOnlyOutputParams: Boolean = False);
var
  i, j: Integer;
begin
  if AfrxParams = nil then
    Exit;
  for i := 0 to AFDParams.Count - 1 do
    if not AOnlyOutputParams or
       (AFDParams[i].ParamType in [ptInputOutput, ptOutput]) then begin
      j := AfrxParams.IndexOf(AFDParams[i].Name);
      if j > -1 then begin
        AfrxParams.Items[j].DataType := AFDParams.Items[i].DataType;
        AfrxParams.Items[j].Value := AFDParams.Items[i].Value;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
{ Code to assign current Master field values for Master-Detail Relationship }

procedure frxDoMasterSetValues(ADetailDataSet: TFDDataSet);
var
  i: Integer;
  oParam: TFDParam;
  oField: TField;
begin
  with ADetailDataSet do begin
    if (MasterSource = nil) or (MasterLink = nil) then
	    Exit;
    for i := 0 to MasterLink.Fields.Count - 1 do begin
      oField := TField(MasterLink.Fields[i]);
      oParam := FindParam(oField.FieldName);
      if oParam <> nil then
        oParam.AssignFieldValue(oField, oField.Value);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
constructor TfrxFDQuery.Create(AOwner: TComponent);
begin
  FLocked := false;
  FStrings := TStringList.Create;
  try
    FQuery := TFDQuery.Create(nil);
  except
    FQuery := nil;
  end;
  if FQuery <> nil then
    FQuery.OnMasterSetValues := DoMasterSetValues;
  Dataset := FQuery;
  SetDatabase(nil);
  inherited Create(AOwner);
  if FQuery = nil then
    raise Exception.Create('DataSet is nil.');
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.DoMasterSetValues(ASender: TFDDataSet);
begin
  if FQuery = nil then Exit;
  frxParamsToFDParams(Self, Params, FQuery.Params, true);
  // Code to assign current Master field values for Master-Detail Relationship
  frxDoMasterSetValues(FQuery);
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.FetchParams;
begin
 if FQuery = nil then Exit;
 frxFDParamsToParams(Self, FQuery.Params, Params, IgnoreDupParams);
end;

{-------------------------------------------------------------------------------}
constructor TfrxFDQuery.DesignCreate(AOwner: TComponent; AFlags: Word);
var
  i: Integer;
  l: TList;
begin
  inherited DesignCreate(AOwner, AFlags);
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
    if TObject(l[i]) is TfrxFDDatabase then begin
      SetDatabase(TfrxFDDatabase(l[i]));
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
destructor TfrxFDQuery.Destroy;
begin
 FStrings.Clear;
 FreeAndNil(FStrings);
 inherited Destroy;
end;

{-------------------------------------------------------------------------------}
class function TfrxFDQuery.GetDescription: String;
begin
  Result := 'FD Query';
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (AComponent = FDatabase) then
    SetDatabase(nil);
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.OnChangeSQL(Sender: TObject);
var
  i, ind: Integer;
  Param: TfrxParamItem;
  QParam: TFDParam;
begin
  if FQuery = nil then Exit;
  // code borrowed from TfrxFDOquery component
  if not FLocked then begin
    // needed to update parameters
    FQuery.SQL.Text := '';
    FQuery.SQL.Assign(FStrings);

    frxParamsToFDParams(Self, Params, FQuery.Params);
    inherited;
    // fill datatype automatically, if possible
    for i := 0 to FQuery.Params.Count - 1 do
    begin

     QParam := FQuery.Params[i];
     ind := Params.IndexOf(QParam.Name);

     if ind <> -1 then
     begin
      Param := Params[ind];

      if (Param.DataType = ftUnknown) and Self.IsDesigning then
      begin
       if assigned( self.Master ) and assigned( self.Master.DataSet ) then
       begin
        if (not Self.Master.DataSet.Active) and
           (Self.Master.DataSet.FieldCount=0) and
           ( Self.Master.FieldAliases.IndexOfName(QParam.Name) > -1 )  then
            Self.Master.DataSet.Active := true;
        if  assigned( Self.Master.DataSet.FindField(QParam.Name) ) then
        begin
         Param.DataType := self.master.DataSet.FindField(QParam.Name).DataType;
         QParam.DataType := self.master.DataSet.FindField(QParam.Name).DataType;
        end;
       end;
      end;

      if (Param.DataType = ftUnknown) and (QParam.DataType <> ftUnknown) then
          Param.DataType := QParam.DataType;

     end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.SetDatabase(const AValue: TfrxFDDatabase);
begin
  if FQuery = nil then Exit;
  FDatabase := AValue;
  if AValue <> nil then
    FQuery.Connection := AValue.Database
  else if GFDComponents <> nil then
    FQuery.Connection := GFDComponents.DefaultDatabase
  else
    FQuery.Connection := nil;
  DBConnected := FQuery.Connection <> nil;
end;

{-------------------------------------------------------------------------------}
function TfrxFDQuery.GetSQL: TStrings;
begin
  Result := FStrings;
  if FQuery = nil then Exit;
  FLocked := True;
  try
    FStrings.Assign(FQuery.SQL);
  finally
    FLocked := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.SetSQL(AValue: TStrings);
begin
  FQuery.SQL.Assign(AValue);
  FStrings.Assign(FQuery.SQL);
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.SetMaster(const AValue: TDataSource);
begin
  if FQuery = nil then Exit;
  FQuery.MasterSource := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.SetMasterFields(const AValue: String);
begin
  if FQuery = nil then Exit;
  FQuery.MasterFields := AValue;
end;

{-------------------------------------------------------------------------------}
function TfrxFDQuery.GetUniDirectional: boolean;
begin
  Result := False;
  if FQuery = nil then Exit;
  Result := FQuery.FetchOptions.Unidirectional;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.SetUniDirectional(const AValue: Boolean);
begin
  if FQuery = nil then Exit;
  FQuery.FetchOptions.Unidirectional := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.UpdateParams;
begin
  if FQuery = nil then Exit;
  frxParamsToFDParams(Self, Params, FQuery.Params, ASSIGNED(Master));
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDQuery.BeforeStartReport;
begin
  if FQuery = nil then Exit;
  SetDatabase(FDatabase);
end;

{-------------------------------------------------------------------------------}
{$IFDEF QBUILDER}
function TfrxFDQuery.QBEngine: TfqbEngine;
begin
  Result := TfrxEngineFD.Create(nil);
  TfrxEngineFD(Result).FQuery.Connection := FQuery.Connection;
  if (FQuery.Connection <> nil) and not FQuery.Connection.Connected then
    FQuery.Connection.Connected := True;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ TfrxFDTable                                                                   }
{-------------------------------------------------------------------------------}
constructor TfrxFDTable.Create(AOwner: TComponent);
begin
  try
    FTable := TFDTable.Create(nil);
  except
    FTable := nil;
  end;
  DataSet := FTable;
  SetDatabase(nil);
  inherited Create(AOwner);
  if FTable = nil then
    raise Exception.Create('DataSet is nil.');
end;

{-------------------------------------------------------------------------------}
constructor TfrxFDTable.DesignCreate(AOwner: TComponent; AFlags: Word);
var
  i: Integer;
  l: TList;
begin
  inherited DesignCreate(AOwner, AFlags);
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
    if TObject(l[i]) is TfrxFDDatabase then begin
      SetDatabase(TfrxFDDatabase(l[i]));
      break;
    end;
end;

{-------------------------------------------------------------------------------}
class function TfrxFDTable.GetDescription: String;
begin
  Result := 'FD Table';
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.Notification(AComponent: TComponent; AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (AComponent = FDatabase) then
    SetDatabase(nil);
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.SetDatabase(const AValue: TfrxFDDatabase);
begin
  if FTable = nil then Exit;
  FDatabase := AValue;
  if AValue <> nil then
    FTable.Connection := AValue.Database
  else if GFDComponents <> nil then
    FTable.Connection := GFDComponents.DefaultDatabase
  else
    FTable.Connection := nil;
  DBConnected := FTable.Connection <> nil;
end;

{-------------------------------------------------------------------------------}
function TfrxFDTable.GetIndexFieldNames: String;
begin
  if FTable = nil then Exit;
  Result := FTable.IndexFieldNames;
end;

{-------------------------------------------------------------------------------}
function TfrxFDTable.GetIndexName: String;
begin
  if FTable = nil then Exit;
  Result := FTable.IndexName;
end;

{-------------------------------------------------------------------------------}
function TfrxFDTable.GetCatalogName: String;
begin
  if FTable = nil then Exit;
  Result := FTable.CatalogName;
end;

{-------------------------------------------------------------------------------}
function TfrxFDTable.GetSchemaName: String;
begin
  if FTable = nil then Exit;
  Result := FTable.SchemaName;
end;

{-------------------------------------------------------------------------------}
function TfrxFDTable.GetTableName: String;
begin
  if FTable = nil then Exit;
  Result := FTable.TableName;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.SetIndexFieldNames(const AValue: String);
begin
  if FTable = nil then Exit;
  FTable.IndexFieldNames := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.SetIndexName(const AValue: String);
begin
  if FTable = nil then Exit;
  FTable.IndexName := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.SetCatalogName(const AValue: String);
begin
  if FTable = nil then Exit;
  FTable.CatalogName := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.SetSchemaName(const AValue: String);
begin
  if FTable = nil then Exit;
  FTable.SchemaName := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.SetTableName(const AValue: String);
begin
  if FTable = nil then Exit;
  FTable.TableName := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.SetMaster(const AValue: TDataSource);
begin
  if FTable = nil then Exit;
  FTable.MasterSource := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.SetMasterFields(const AValue: String);
begin
  if FTable = nil then Exit;
  FTable.MasterFields := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDTable.BeforeStartReport;
begin
  if FTable = nil then Exit;
  SetDatabase(FDatabase);
end;

{-------------------------------------------------------------------------------}
{ TfrxCustomStoredProc                                                          }
{-------------------------------------------------------------------------------}
constructor TfrxCustomStoredProc.Create(AOwner: TComponent);
begin
  FParams := TfrxParams.Create;
  inherited Create(AOwner);
  if DataSet <> nil then
  begin
    FSaveOnBeforeOpen := DataSet.BeforeOpen;
    FSaveOnAfterOpen := DataSet.AfterOpen;
    DataSet.BeforeOpen := TriggerOnBeforeOpen;
  end;
end;

{-------------------------------------------------------------------------------}
destructor TfrxCustomStoredProc.Destroy;
begin
  FParams.Free;
  if DataSet <> nil then
    DataSet.BeforeOpen := FSaveOnBeforeOpen;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.ExecProc;
begin
 // Do nothing, code Should be added on inherited Classes;
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.DefineProperties(AFiler: TFiler);
begin
  inherited DefineProperties(AFiler);
  AFiler.DefineProperty('Parameters', ReadParamData, WriteParamData, True);
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.ReadParamData(AReader: TReader);
begin
  frxReadCollection(FParams, AReader, Self);
  UpdateParams;
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.WriteParamData(AWriter: TWriter);
begin
  frxWriteCollection(FParams, AWriter, Self);
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.TriggerOnAfterOpen(ADataSet: TDataSet);
begin
 if Assigned(FSaveOnAfterOpen) then
    FSaveOnAfterOpen(DataSet);
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.TriggerOnBeforeOpen(ADataSet: TDataSet);
begin
  UpdateParams;
  if Assigned(FSaveOnBeforeOpen) then
    FSaveOnBeforeOpen(DataSet);
end;

{-------------------------------------------------------------------------------}
function TfrxCustomStoredProc.ParamByName(const AValue: String): TfrxParamItem;
begin
  Result := FParams.Find(AValue);
  if Result = nil then
    raise Exception.Create('Parameter "' + AValue + '" not found');
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.Prepare;
begin
  // Do nothing, code Should be added on inherited Classes;
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.FetchParams;
begin
  // Do nothing, code Should be added on inherited Classes;
end;

{-------------------------------------------------------------------------------}
function TfrxCustomStoredProc.GetStoredProcName: string;
begin
  // Do nothing, code Should be added on inherited Classes;
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.SetParams(AValue: TfrxParams);
begin
  FParams.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.SetStoredProcName(const AValue: string);
begin
  // Do nothing, code Should be added on inherited Classes;
end;

{-------------------------------------------------------------------------------}
procedure TfrxCustomStoredProc.UpdateParams;
begin
  // Do nothing, code Should be added on inherited Classes;
end;

{-------------------------------------------------------------------------------}
{ TfrxFDStoredProc                                                              }
{-------------------------------------------------------------------------------}
constructor TfrxFDStoredProc.Create(AOwner: TComponent);
begin
  try
    FStoredProc := TFDStoredProc.Create(nil);
  except
    FStoredProc := nil;
  end;
  if FStoredProc <> nil then
    FStoredProc.OnMasterSetValues := DoMasterSetValues;
  Dataset := FStoredProc;
  SetDatabase(nil);
  inherited Create(AOwner);
  if FStoredProc = nil then
    raise Exception.Create('DataSet is nil.');
end;

{-------------------------------------------------------------------------------}
constructor TfrxFDStoredProc.DesignCreate(AOwner: TComponent; AFlags: Word);
var
  i: Integer;
  l: TList;
begin
  inherited DesignCreate(AOwner, AFlags);
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
    if TObject(l[i]) is TfrxFDDatabase then begin
      SetDatabase(TfrxFDDatabase(l[i]));
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.DoMasterSetValues(ASender: TFDDataSet);
begin
  if FStoredProc = nil then Exit;
  // Code to assign current Master field values for Master-Detail Relationship
  frxDoMasterSetValues( FStoredProc );
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.ExecProc;
begin
  if FStoredProc = nil then Exit;
  UpdateParams;
  FStoredProc.ExecProc;
  frxFDParamValuesToParams(Self, FStoredProc.Params, Params, True);
end;

{-------------------------------------------------------------------------------}
class function TfrxFDStoredProc.GetDescription: String;
begin
  Result := 'FD StoredProc';
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited Notification(AComponent, AOperation);
  if (AOperation = opRemove) and (AComponent = FDatabase) then
    SetDatabase(nil);
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.Prepare;
begin
  if FStoredProc = nil then Exit;
  FetchParams;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.FetchParams;
begin
  if FStoredProc = nil then Exit;
  if csDesigning in ComponentState then
    Exit;
  FStoredProc.Unprepare;
  if (StoredProcName <> '') and (FStoredProc.Connection <> nil) then
    FStoredProc.Prepare;
  if (StoredProcName = '') or FStoredProc.Prepared then
    frxFDParamsToParams(Self, FStoredProc.Params, FParams, True);
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.SetCatalogName(const AValue: String);
begin
  if FStoredProc = nil then Exit;
  FStoredProc.CatalogName := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.SetSchemaName(const AValue: String);
begin
  if FStoredProc = nil then Exit;
  FStoredProc.SchemaName := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.TriggerOnAfterOpen(ADataSet: TDataSet);
begin
  if FStoredProc = nil then Exit;
  // copy Values from Output Type TFDParams to TfrxParams, only for SP that return values
  frxFDParamValuesToParams(Self, FStoredProc.Params, Params, true);
  inherited;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.SetDatabase(const AValue: TfrxFDDatabase);
begin
  if FStoredProc = nil then Exit;
  FDatabase := AValue;
  if AValue <> nil then
    FStoredProc.Connection := AValue.Database
  else if GFDComponents <> nil then
    FStoredProc.Connection := GFDComponents.DefaultDatabase
  else
    FStoredProc.Connection := nil;
  if (AValue <> nil) and (AValue.Connected) then
    FetchParams;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.SetMaster(const AValue: TDataSource);
begin
  if FStoredProc = nil then Exit;
  FStoredProc.MasterSource := AValue;
end;

{-------------------------------------------------------------------------------}
function TfrxFDStoredProc.GetPackageName: String;
begin
  if FStoredProc = nil then Exit;
  Result := FStoredProc.PackageName;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.SetPackageName(const AValue: String);
begin
  if FStoredProc = nil then Exit;
  FStoredProc.PackageName := AValue;
end;

{-------------------------------------------------------------------------------}
function TfrxFDStoredProc.GetCatalogName: String;
begin
  if FStoredProc = nil then Exit;
  Result := FStoredProc.CatalogName;
end;

{-------------------------------------------------------------------------------}
function TfrxFDStoredProc.GetSchemaName: String;
begin
  if FStoredProc = nil then Exit;
  Result := FStoredProc.SchemaName;
end;

{-------------------------------------------------------------------------------}
function TfrxFDStoredProc.GetStoredProcName: string;
begin
  Result := FStoredProc.StoredProcName;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.SetStoredProcName(const AValue: string);
begin
  FStoredProc.StoredProcName := AValue;
  FetchParams;
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.UpdateParams;
begin
  if FStoredProc = nil then Exit;
  frxParamsToFDParams(Self, Params, FStoredProc.Params);
end;

{-------------------------------------------------------------------------------}
procedure TfrxFDStoredProc.BeforeStartReport;
begin
  if FStoredProc = nil then Exit;
  inherited BeforeStartReport;
  SetDatabase(FDatabase);
end;

{-------------------------------------------------------------------------------}
{ TfrxEngineFD                                                                  }
{-------------------------------------------------------------------------------}
{$IFDEF QBUILDER}
constructor TfrxEngineFD.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FQuery := TFDQuery.Create(nil);
end;

{-------------------------------------------------------------------------------}
destructor TfrxEngineFD.Destroy;
begin
  FreeAndNil(FQuery);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TfrxEngineFD.ReadFieldList(const ATableName: string;
  var AFieldList: TfqbFieldList);
var
  oTab: TFDTable;
  oDefs: TFieldDefs;
  i: Integer;
  oQBField: TfqbField;
begin
  AFieldList.Clear;
  oTab := TFDTable.Create(Self);
  oTab.Connection := FQuery.Connection;
  oTab.TableName := ATableName;
  oDefs := oTab.FieldDefs;
  try
    try
      oTab.Active := True;
      oQBField := TfqbField(AFieldList.Add);
      oQBField.FieldName := '*';
      for i := 0 to oDefs.Count - 1 do begin
        oQBField := TfqbField(AFieldList.Add);
        oQBField.FieldName := oDefs.Items[i].Name;
        oQBField.FieldType := Ord(oDefs.Items[i].DataType)
      end;
    except
    end;
  finally
    oTab.Free;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TfrxEngineFD.ReadTableList(ATableList: TStrings);
begin
  ATableList.Clear;
  FQuery.Connection.GetTableNames(FQuery.ConnectionName, '', '', ATableList);
end;

{-------------------------------------------------------------------------------}
function TfrxEngineFD.ResultDataSet: TDataSet;
begin
  Result := FQuery;
end;

{-------------------------------------------------------------------------------}
procedure TfrxEngineFD.SetSQL(const AValue: string);
begin
  FQuery.SQL.Text := AValue;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
initialization
  frxObjects.RegisterObject1(TfrxFDDataBase, nil, '', {$IFDEF DB_CAT}'DATABASES'{$ELSE}''{$ENDIF}, 0, 37);
  frxObjects.RegisterObject1(TfrxFDTable, nil, '', {$IFDEF DB_CAT}'QUERIES'{$ELSE}''{$ENDIF}, 0, 38);
  frxObjects.RegisterObject1(TfrxFDQuery, nil, '', {$IFDEF DB_CAT}'QUERIES'{$ELSE}''{$ENDIF}, 0, 39);
  frxObjects.RegisterObject1(TfrxFDStoredProc, nil, '', {$IFDEF DB_CAT}'QUERIES'{$ELSE}''{$ENDIF}, 0, 39);
finalization
  frxObjects.UnRegister(TfrxFDDataBase);
  frxObjects.UnRegister(TfrxFDTable);
  frxObjects.UnRegister(TfrxFDQuery);
  frxObjects.UnRegister(TfrxFDStoredProc);
end.
