unit frxLazIBXComponents;

{$I frx.inc}


interface

uses
  Classes, SysUtils,  frxClass, frxCustomDB, DB,
  IBDatabase, IBTable, IBQuery, Variants, LResources;

type

  { TfrxLazIBXComponents }

  TfrxLazIBXComponents = class(TfrxDBComponents)
  private
    FDefaultDatabase: TIBDatabase;
    FOldComponents: TfrxLazIBXComponents;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetDefaultDatabase(Value: TIBDatabase);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetDescription: String; override;
  published
    property DefaultDatabase: TIBDatabase read FDefaultDatabase write SetDefaultDatabase;
  end;

  { TfrxLazIBXDatabase }

  TfrxLazIBXDatabase = class(TfrxCustomDatabase)
  private
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
    function GetSQLDialect: Integer;
    procedure SetSQLDialect(const Value: Integer);
  protected
    procedure SetConnected(Value: Boolean); override;
    procedure SetDatabaseName(const Value: String); override;
    procedure SetLoginPrompt(Value: Boolean); override;
    procedure SetParams(Value: TStrings); override;
    function GetConnected: Boolean; override;
    function GetDatabaseName: String; override;
    function GetLoginPrompt: Boolean; override;
    function GetParams: TStrings; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    procedure SetLogin(const Login, Password: String); override;
    property Database: TIBDatabase read FDatabase;
  published
    property DatabaseName;
    property LoginPrompt;
    property Params;
    property SQLDialect: Integer read GetSQLDialect write SetSQLDialect;
    property Connected;
  end;

  { TfrxLazIBXTable }

  TfrxLazIBXTable = class(TfrxCustomTable)
  private
    FDatabase: TfrxLazIBXDatabase;
    FTable: TIBTable;
    procedure SetDatabase(const Value: TfrxLazIBXDatabase);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetMaster(const Value: TDataSource); override;
    procedure SetMasterFields(const Value: String); override;
    procedure SetIndexFieldNames(const Value: String); override;
    procedure SetIndexName(const Value: String); override;
    procedure SetTableName(const Value: String); override;
    function GetIndexFieldNames: String; override;
    function GetIndexName: String; override;
    function GetTableName: String; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    property Table: TIBTable read FTable;
  published
    property Database: TfrxLazIBXDatabase read FDatabase write SetDatabase;
  end;

  { TfrxLazIBXQuery }

  TfrxLazIBXQuery = class(TfrxCustomQuery)
  private
    FDatabase: TfrxLazIBXDatabase;
    FQuery: TIBQuery;
    procedure SetDatabase(const Value: TfrxLazIBXDatabase);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetMaster(const Value: TDataSource); override;
    procedure SetSQL(Value: TStrings); override;
    function GetSQL: TStrings; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor DesignCreate(AOwner: TComponent; Flags: Word); override;
    class function GetDescription: String; override;
    procedure BeforeStartReport; override;
    procedure UpdateParams; override;
{$IFDEF QBUILDER}
    function QBEngine: TfqbEngine; override;
{$ENDIF}
    property Query: TIBQuery read FQuery;
  published
    property Database: TfrxLazIBXDatabase read FDatabase write SetDatabase;
  end;

var
  LazIBXComponents: TfrxLazIBXComponents;

procedure Register;


implementation

uses
  frxLazIBXRTTI,
{$IFNDEF NO_EDITORS}
  frxLazIBXEditor,
{$ENDIF}
  frxDsgnIntf, frxRes;

procedure Register;
begin
   RegisterComponents('Fast Report 5',[TfrxLazIBXComponents]);
end;

{ TfrxLazIBXQuery }

procedure TfrxLazIBXQuery.SetDatabase(const Value: TfrxLazIBXDatabase);
begin
  FDatabase := Value;

  if Value <> nil then
  begin
    FQuery.Database := Value.Database;
    FQuery.Transaction := Value.FTransaction;
  end
  else if LazIBXComponents <> nil then
    FQuery.Database := LazIBXComponents.DefaultDatabase
  else
    FQuery.Database := nil;
  DBConnected := FQuery.Database <> nil;
end;

procedure TfrxLazIBXQuery.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDatabase) then
    SetDatabase(nil);
end;

procedure TfrxLazIBXQuery.SetMaster(const Value: TDataSource);
begin
   FQuery.DataSource := Value;
end;

procedure TfrxLazIBXQuery.SetSQL(Value: TStrings);
begin
  FQuery.SQL := Value;
end;

function TfrxLazIBXQuery.GetSQL: TStrings;
begin
  Result := FQuery.SQL;
end;

constructor TfrxLazIBXQuery.Create(AOwner: TComponent);
begin
  FQuery := TIBQuery.Create(nil);
  Dataset := FQuery;
  SetDatabase(nil);
  inherited Create(AOwner);
end;

constructor TfrxLazIBXQuery.DesignCreate(AOwner: TComponent; Flags: Word);
var
  i: Integer;
  l: TList;
begin
  inherited;
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
    if TObject(l[i]) is TfrxLazIBXDatabase then
    begin
      SetDatabase(TfrxLazIBXDatabase(l[i]));
      break;
    end;
end;

class function TfrxLazIBXQuery.GetDescription: String;
begin
 Result := frxResources.Get('obIBXQ');
end;

procedure TfrxLazIBXQuery.BeforeStartReport;
begin
  SetDatabase(FDatabase);
end;

procedure TfrxLazIBXQuery.UpdateParams;
begin
  if Assigned(FQuery.Database) then
    frxParamsToTParams(Self, FQuery.Params);
end;

{ TfrxLazIBXDatabase }

function TfrxLazIBXDatabase.GetSQLDialect: Integer;
begin
   Result := FDatabase.SQLDialect;
end;

procedure TfrxLazIBXDatabase.SetSQLDialect(const Value: Integer);
begin
  FDatabase.SQLDialect := Value;
end;

procedure TfrxLazIBXDatabase.SetConnected(Value: Boolean);
begin
  BeforeConnect(Value);
  FDatabase.Connected := Value;
  FTransaction.Active := Value;
end;

procedure TfrxLazIBXDatabase.SetDatabaseName(const Value: String);
begin
  FDatabase.DatabaseName := Value;
end;

procedure TfrxLazIBXDatabase.SetLoginPrompt(Value: Boolean);
begin
  FDatabase.LoginPrompt := Value;
end;

procedure TfrxLazIBXDatabase.SetParams(Value: TStrings);
begin
   FDatabase.Params := Value;
end;

function TfrxLazIBXDatabase.GetConnected: Boolean;
begin
   Result := FDatabase.Connected;
end;

function TfrxLazIBXDatabase.GetDatabaseName: String;
begin
  Result := FDatabase.DatabaseName;
end;

function TfrxLazIBXDatabase.GetLoginPrompt: Boolean;
begin
  Result := FDatabase.LoginPrompt;
end;

function TfrxLazIBXDatabase.GetParams: TStrings;
begin
  Result := FDatabase.Params;
end;

constructor TfrxLazIBXDatabase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDatabase := TIBDatabase.Create(nil);
  FTransaction := TIBTransaction.Create(nil);
  FDatabase.DefaultTransaction := FTransaction;
  Component := FDatabase;
end;

destructor TfrxLazIBXDatabase.Destroy;
begin
  FTransaction.Free;
  inherited Destroy;
end;

class function TfrxLazIBXDatabase.GetDescription: String;
begin
  Result := frxResources.Get('obIBXDB');

end;

procedure TfrxLazIBXDatabase.SetLogin(const Login, Password: String);
begin
  Params.Text := 'user_name=' + Login + #13#10 + 'password=' + Password;
end;

{ TfrxLazIBXTable }

procedure TfrxLazIBXTable.SetDatabase(const Value: TfrxLazIBXDatabase);
begin
  FDatabase := Value;
  if Value <> nil then
    FTable.Database := Value.Database
  else if lazIBXComponents <> nil then
    FTable.Database := LazIBXComponents.DefaultDatabase
  else
    FTable.Database := nil;
  DBConnected := FTable.Database <> nil;
end;

procedure TfrxLazIBXTable.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FDatabase) then
    SetDatabase(nil);
end;

procedure TfrxLazIBXTable.SetMaster(const Value: TDataSource);
begin
  FTable.MasterSource := Value;
end;

procedure TfrxLazIBXTable.SetMasterFields(const Value: String);
begin
  FTable.MasterFields := Value;
end;

procedure TfrxLazIBXTable.SetIndexFieldNames(const Value: String);
begin
  FTable.IndexFieldNames := Value;
end;

procedure TfrxLazIBXTable.SetIndexName(const Value: String);
begin
   FTable.IndexName := Value;
end;

procedure TfrxLazIBXTable.SetTableName(const Value: String);
begin
  FTable.TableName := Value;
end;

function TfrxLazIBXTable.GetIndexFieldNames: String;
begin
  Result := FTable.IndexFieldNames;
end;

function TfrxLazIBXTable.GetIndexName: String;
begin
  Result := FTable.IndexName;
end;

function TfrxLazIBXTable.GetTableName: String;
begin
  Result := FTable.TableName;
end;

constructor TfrxLazIBXTable.Create(AOwner: TComponent);
begin
  FTable := TIBTable.Create(nil);
  DataSet := FTable;
  SetDatabase(nil);
  inherited Create(AOwner);
end;

constructor TfrxLazIBXTable.DesignCreate(AOwner: TComponent; Flags: Word);
var
  i: Integer;
  l: TList;
begin
  inherited;
  l := Report.AllObjects;
  for i := 0 to l.Count - 1 do
    if TObject(l[i]) is TfrxLazIBXDatabase then
    begin
      SetDatabase(TfrxLazIBXDatabase(l[i]));
      break;
    end;
end;

class function TfrxLazIBXTable.GetDescription: String;
begin
   Result := frxResources.Get('obIBXTb');
end;

procedure TfrxLazIBXTable.BeforeStartReport;
begin
  SetDatabase(FDatabase);
end;



{ TfrxLazIBXComponents }

procedure TfrxLazIBXComponents.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FDefaultDatabase) and (Operation = opRemove) then
    FDefaultDatabase := nil;
end;

procedure TfrxLazIBXComponents.SetDefaultDatabase(Value: TIBDatabase);
begin
  if (Value <> nil) then
    Value.FreeNotification(Self);

  if FDefaultDatabase <> nil then
      FDefaultDatabase.RemoveFreeNotification(Self);

  FDefaultDatabase := Value;
end;

constructor TfrxLazIBXComponents.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOldComponents := LazIBXComponents;
  LazIBXComponents := Self;
end;

destructor TfrxLazIBXComponents.Destroy;
begin
  if LazIBXComponents = Self then
    LazIBXComponents := FOldComponents;
  inherited Destroy;
end;

function TfrxLazIBXComponents.GetDescription: String;
begin
  Result:='LazIBX';
end;


initialization
  {$INCLUDE frxLazIBXComponents.lrs}
  frxObjects.RegisterObject1(TfrxLazIBXDataBase, nil, '', {$IFDEF DB_CAT}'DATABASES'{$ELSE}''{$ENDIF}, 0, 60);
  frxObjects.RegisterObject1(TfrxLazIBXTable, nil, '', {$IFDEF DB_CAT}'TABLES'{$ELSE}''{$ENDIF}, 0, 61);
  frxObjects.RegisterObject1(TfrxLazIBXQuery, nil, '', {$IFDEF DB_CAT}'QUERIES'{$ELSE}''{$ENDIF}, 0, 62);

finalization
  frxObjects.UnRegister(TfrxlazIBXDataBase);
  frxObjects.UnRegister(TfrxLazIBXTable);
  frxObjects.UnRegister(TfrxLazIBXQuery);



end.

