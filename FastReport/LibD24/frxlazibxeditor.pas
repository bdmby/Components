unit frxLazIBXEditor;

{$I frx.inc}

interface

implementation

uses
  Classes, SysUtils, Forms, Dialogs, frxLazIBXComponents, frxCustomDB,
  frxDsgnIntf, frxRes, IBDatabase, IBTable, Variants ;

type
  TfrxDatabaseNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    function Edit: Boolean; override;
  end;

  TfrxDatabaseProperty = class(TfrxComponentProperty)
  public
    function GetValue: String; override;
  end;

  TfrxTableNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
    procedure SetValue(const Value: String); override;
  end;

  TfrxIndexNameProperty = class(TfrxStringProperty)
  public
    function GetAttributes: TfrxPropertyAttributes; override;
    procedure GetValues; override;
  end;

  { TfrxDatabaseNameProperty }

  function TfrxDatabaseNameProperty.GetAttributes: TfrxPropertyAttributes;
  begin
    Result := [paDialog];
  end;

  function TfrxDatabaseNameProperty.Edit: Boolean;
  var
    SaveConnected: Boolean;
  begin
    with TOpenDialog.Create(nil) do
    begin
      InitialDir := GetCurrentDir;
      Filter := frxResources.Get('ftDB') + ' (*.fdb)|*.fdb|' +
        frxResources.Get('ftAllFiles') + ' (*.*)|*.*';
      Result := Execute;
      if Result then
        with TfrxLazIBXDatabase(Component).Database do
        begin
          SaveConnected := Connected;
          Connected := False;
          DatabaseName := FileName;
          Connected := SaveConnected;
        end;
      Free;
    end;
  end;

  { TfrxDatabaseProperty }

function TfrxDatabaseProperty.GetValue: String;
var
  db: TfrxLazIBXDatabase;
begin
  db := TfrxLazIBXDatabase(GetOrdValue);
  if db = nil then
  begin
    if (LazIBXComponents <> nil) and (LazIBXComponents.DefaultDatabase <> nil) then
      Result := LazIBXComponents.DefaultDatabase.Name
    else
      Result := frxResources.Get('prNotAssigned');
  end
  else
    Result := inherited GetValue;
end;


  { TfrxTableNameProperty }

function TfrxTableNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList, paSortList];
end;

procedure TfrxTableNameProperty.GetValues;
begin
  inherited;
  with TfrxLazIBXTable(Component).Table do
    if Database <> nil then
      DataBase.GetTableNames(Values, False);
end;

procedure TfrxTableNameProperty.SetValue(const Value: String);
begin
  inherited;
  Designer.UpdateDataTree;
end;


  { TfrxIndexProperty }

function TfrxIndexNameProperty.GetAttributes: TfrxPropertyAttributes;
begin
  Result := [paMultiSelect, paValueList];
end;

procedure TfrxIndexNameProperty.GetValues;
var
  i: Integer;
begin
  inherited;
  try
    with TfrxLazIBXTable(Component).Table do
      if (TableName <> '') and (IndexDefs <> nil) then
      begin
        IndexDefs.Update;
        for i := 0 to IndexDefs.Count - 1 do
          if IndexDefs[i].Name <> '' then
            Values.Add(IndexDefs[i].Name);
      end;
  except
  end;
end;

initialization
  frxPropertyEditors.Register(TypeInfo(String), TfrxLazIBXDataBase, 'DatabaseName',
    TfrxDataBaseNameProperty);
  frxPropertyEditors.Register(TypeInfo(TfrxLazIBXDatabase), TfrxLazIBXTable, 'Database',
    TfrxDatabaseProperty);
  frxPropertyEditors.Register(TypeInfo(TfrxLazIBXDatabase), TfrxLazIBXQuery, 'Database',
    TfrxDatabaseProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxLazIBXTable, 'TableName',
    TfrxTableNameProperty);
  frxPropertyEditors.Register(TypeInfo(String), TfrxLazIBXTable, 'IndexName',
    TfrxIndexNameProperty);

end.

