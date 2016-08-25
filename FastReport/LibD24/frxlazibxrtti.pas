unit frxLazIBXRTTI;

{$I frx.inc}

interface



implementation

uses
   Classes, Types, fs_iinterpreter, frxLazIBXComponents,
   fs_iibxrtti, Variants;

type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;


{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    with AddClass(TfrxLazIBXDatabase, 'TfrxCustomDatabase') do
      AddProperty('Database', 'TIBDatabase', GetProp, nil);
    with AddClass(TfrxLazIBXTable, 'TfrxCustomTable') do
      AddProperty('Table', 'TIBTable', GetProp, nil);
    with AddClass(TfrxLazIBXQuery, 'TfrxCustomQuery') do
    begin
      AddMethod('procedure ExecSQL', CallMethod);
      AddProperty('Query', 'TIBQuery', GetProp, nil);
    end;
  end;
end;

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;

  if ClassType = TfrxLazIBXQuery then
  begin
    if MethodName = 'EXECSQL' then
      TfrxLazIBXQuery(Instance).Query.ExecSQL
  end
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxLazIBXDatabase then
  begin
    if PropName = 'DATABASE' then
      Result := frxInteger(TfrxLazIBXDatabase(Instance).Database)
  end
  else if ClassType = TfrxLazIBXTable then
  begin
    if PropName = 'TABLE' then
      Result := frxInteger(TfrxLazIBXTable(Instance).Table)
  end
  else if ClassType = TfrxLazIBXQuery then
  begin
    if PropName = 'QUERY' then
      Result := frxInteger(TfrxLazIBXQuery(Instance).Query)
  end
end;


initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);


end.

