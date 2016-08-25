{ --------------------------------------------------------------------------- }
{ FireDAC FastReport v 4.0 enduser components                                  }
{                                                                             }
{ (c)opyright DA-SOFT Technologies 2004-2013.                                 }
{ All rights reserved.                                                        }
{                                                                             }
{ Initially created by: Serega Glazyrin <glserega@mezonplus.ru>               }
{ Extended by: Francisco Armando Duenas Rodriguez <fduenas@gmxsoftware.com>   }
{ --------------------------------------------------------------------------- }
{$I frx.inc}

unit frxFDRTTI;

interface

implementation

uses
  Windows, Classes, Types, SysUtils, Forms, Variants,
  FireDAC.DatS, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  fs_iinterpreter, fs_idbrtti, frxFDComponents;

type
  TfrxFDFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass;
      const MethodName: String; Caller: TfsMethodHelper): Variant;
    function GetProp(Instance: TObject; ClassType: TClass;
      const PropName: String): Variant;
  public
    constructor Create(AScript: TfsScript); override;
  end;

{-------------------------------------------------------------------------------}
constructor TfrxFDFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do begin
    AddClass(TFDManager, 'TComponent');
    AddClass(TFDConnection, 'TComponent');
    AddClass(TFDDataSet, 'TDataSet');
    AddClass(TFDAdaptedDataSet, 'TFDDataSet');
    AddClass(TFDRdbmsDataSet, 'TFDAdaptedDataSet');

    with AddClass(TFDQuery, 'TFDRdbmsDataSet') do begin
      AddMethod('procedure ExecSQL', CallMethod);
      AddMethod('function ParamByName(const Value: string): TParam', CallMethod);
      AddMethod('procedure Prepare', CallMethod);
      AddProperty('ParamCount', 'Word', GetProp, nil);
    end;
    with AddClass(TFDStoredProc, 'TFDRdbmsDataSet') do begin
      AddMethod('procedure ExecProc', CallMethod);
      AddMethod('function ParamByName(const Value: string): TParam', CallMethod);
      AddMethod('procedure Prepare', CallMethod);
      AddProperty('ParamCount', 'Word', GetProp, nil);
    end;

    with AddClass(TfrxFDDatabase, 'TfrxCustomDatabase') do
      AddProperty('Database', 'TFDConnection', GetProp, nil);
    //AddClass(TfrxADTable, 'TfrxCustomTable');

    with AddClass(TfrxFDQuery, 'TfrxCustomQuery') do begin
      AddMethod('procedure ExecSQL', CallMethod);
      AddProperty('Query', 'TFDQuery', GetProp, nil);
    end;

    with AddClass(TfrxCustomStoredProc, 'TfrxCustomDataset') do begin
     AddMethod('procedure ExecProc', CallMethod);
     AddMethod('procedure FetchParams', CallMethod);
     AddMethod('function ParamByName(const AValue: String): TfrxParamItem', CallMethod);
     AddMethod('procedure Prepare', CallMethod);
     AddMethod('procedure UpdateParams', CallMethod);
    end;

    with AddClass(TfrxFDStoredProc, 'TfrxCustomStoredProc') do begin
      AddProperty('StoredProc', 'TFDStoredProc', GetProp, nil);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TfrxFDFunctions.CallMethod(Instance: TObject; ClassType: TClass;
  const MethodName: String; Caller: TfsMethodHelper): Variant;
begin
  Result := 0;

  if ClassType = TFDQuery then begin
    if MethodName = 'EXECSQL' then
      TFDQuery(Instance).ExecSQL
    else if MethodName = 'PARAMBYNAME' then
      Result := frxInteger(TFDQuery(Instance).ParamByName(Caller.Params[0]))
    else if MethodName = 'PREPARE' then
      TFDQuery(Instance).Prepare;
  end
  else if ClassType = TFDStoredProc then begin
    if MethodName = 'EXECPROC' then
      TFDStoredProc(Instance).ExecProc
    else if MethodName = 'PARAMBYNAME' then
      Result := frxInteger(TFDStoredProc(Instance).ParamByName(Caller.Params[0]))
    else if MethodName = 'PREPARE' then
      TFDStoredProc(Instance).Prepare;
  end
  else if ClassType = TfrxFDQuery then begin
    if MethodName = 'EXECSQL' then
       TfrxFDQuery(Instance).Query.ExecSQL
    else if MethodName = 'FETCHPARAMS' then
      TfrxFDQuery(Instance).FetchParams;
  end
  else if ClassType = TfrxCustomStoredProc then begin
    if MethodName = 'EXECPROC' then
      TfrxCustomStoredProc(Instance).ExecProc
    else if MethodName = 'FETCHPARAMS' then
      TfrxCustomStoredProc(Instance).FetchParams
    else if MethodName = 'PARAMBYNAME' then
      Result := frxInteger(TfrxCustomStoredProc(Instance).ParamByName(Caller.Params[0]))
    else if MethodName = 'PREPARE' then
      TfrxCustomStoredProc(Instance).Prepare
    else if MethodName = 'UPDATEPARAMS' then
      TfrxCustomStoredProc(Instance).FetchParams;
  end
end;

{-------------------------------------------------------------------------------}
function TfrxFDFunctions.GetProp(Instance: TObject; ClassType: TClass;
  const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TFDQuery then begin
    if PropName = 'PARAMCOUNT' then
      Result := TFDQuery(Instance).ParamCount;
  end
  else if ClassType = TFDStoredProc then begin
    if PropName = 'PARAMCOUNT' then
      Result := TFDStoredProc(Instance).ParamCount;
  end
  else if ClassType = TfrxFDDatabase then begin
    if PropName = 'DATABASE' then
      Result := frxInteger(TfrxFDDatabase(Instance).Database);
  end
  else if ClassType = TfrxFDQuery then begin
    if PropName = 'QUERY' then
      Result := frxInteger(TfrxFDQuery(Instance).Query);
  end
  else if ClassType = TfrxFDStoredProc then begin
    if PropName = 'STOREDPROC' then
      Result := frxInteger(TfrxFDStoredProc(Instance).StoredProc);
  end;
end;

{-------------------------------------------------------------------------------}
initialization
  fsRTTIModules.Add(TfrxFDFunctions);

finalization
  fsRTTIModules.Remove(TfrxFDFunctions);

end.
