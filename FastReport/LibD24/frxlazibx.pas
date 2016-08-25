{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit frxLazIBX;

interface

uses
  frxLazIBXComponents, frxLazIBXEditor, frxLazIBXRTTI, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('frxLazIBXComponents', @frxLazIBXComponents.Register);
end;

initialization
  RegisterPackage('frxLazIBX', @Register);
end.
