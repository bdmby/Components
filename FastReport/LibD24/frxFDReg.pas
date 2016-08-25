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

unit frxFDReg;

interface

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes
{$IFNDEF Delphi6}
, DsgnIntf
{$ELSE}
, DesignIntf, DesignEditors
{$ENDIF}
, frxFDComponents;

procedure Register;
begin
  RegisterComponents('FastReport 5.0', [TfrxFDComponents]);
end;

end.
