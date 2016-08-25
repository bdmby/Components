//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManDep.inc                                              **
//**                                                                         **
//**  Version:   2.6.6                                                       **
//**                                                                         **
//**  Date:      2016-05-11                                                  **
//**                                                                         **
//**  Author:    Ing. Tomas Halabala - REGULACE.ORG                          **
//**                                                                         **
//**  Disclaimer:THIS SOFTWARE AND ANY RELATED DOCUMENTATION IS PROVIDED     **
//**             "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED      **
//**             OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED         **
//**             WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR     **
//**             PURPOSE, OR NONINFRINGEMENT. AUTHOR DOES NOT WARRANT,       **
//**             GUARANTEE, OR MAKE ANY REPRESENTATIONS REGARDING THE USE,   **
//**             OR THE RESULTS OF THE USE, OF THE SOFTWARE IN TERMS OF      **
//**             CORRECTNESS, ACCURACY, RELIABILITY, OR OTHERWISE.           **
//**             THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE           **
//**             OF THE SOFTWARE REMAINS WITH YOU.                           **
//**                                                                         **
//**  Copyright: Copyright (c) 2009-2016 Ing.Tomas Halabala                  **
//**                                                                         **
//**  E-mail:    tomas.halabala@regulace.org                                 **
//**                                                                         **
//**  Website:   http://www.regulace.org                                     **
//**                                                                         **
//*****************************************************************************


{$I LICENSE.RTF}
{$IFNDEF LMREG}
{$IF DEFINED(VER130) OR DEFINED(VER140) OR DEFINED(VER150) OR DEFINED(VER170) OR DEFINED(VER180) OR DEFINED(VER185) OR DEFINED(VER200) OR DEFINED(VER210)}
{$IFDEF VER210}
{$DEFINE D2010}
{$ENDIF}
{$ELSE}
{$DEFINE D2010}
{$DEFINE DXE}
{$IFDEF VER220}
{$ELSE}
{$DEFINE DXE2}
{$IFDEF VER230}
{$ELSE}
{$DEFINE DXE3}
{$IFDEF VER240}
{$ELSE}
{$DEFINE DXE4}
{$LEGACYIFEND ON}
{$IFDEF VER250}
{$ELSE}
{$DEFINE DXE5}
{$IFDEF VER260}
{$ELSE}
{$DEFINE DXE6}
{$IFDEF VER270}
{$ELSE}
{$DEFINE DXE7}
{$IFDEF VER280}
{$ELSE}
{$DEFINE DXE8}
{$IFDEF VER290}
{$ELSE}
{$DEFINE DX10}
{$IFDEF VER300}
{$ELSE}
{$DEFINE DX101}
{$IFDEF VER310}
{$ELSE}
{$DEFINE DX11}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$IFEND}
{$IFDEF LMULT}
{$DEFINE LMPREM}
{$DEFINE LMSMART}
{$ENDIF}
{$IFDEF LMPREM}
{$DEFINE LMPRO}
{$DEFINE LMIMEX}
{$DEFINE LMDESI}
{$ENDIF}
{$DEFINE LMCPP}
{$ENDIF}
