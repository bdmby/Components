//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LM_Config.inc                                               **
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

{$I LangManDep.inc}
{$IFNDEF LMREG}
{$IFDEF ENABLE_USER_NOTICE}
{$MESSAGE HINT 'LANGMAN NOTICE: If compiler notify a fatal error, put a comment on packages of components in LM_Config.inc which you have not installed'}
{$ENDIF}

// - Start of LM_Config -------------------------------------------------------

// Put a comment on LangMan features definitions which you want to disable
// -----------------------------------------------------------------------
// Advanced editor for TStrings properties
{$DEFINE ENABLE_TSTRINGS_EDITOR}
// Tag property editor for setting individual blocking translation
{$DEFINE ENABLE_TAG_EDITOR}

// Put a comment on packages of components which you have not installed
//  and remove comment from others
// ----------------------------------------------------------

// Enable translate database components
{$DEFINE DATABASES}
//{$DEFINE FIREDAC_GUI}

// Enable translate Ribbons and ScreenTips - since Delphi 2009 (supports only LangMan Ultimate)
//{$DEFINE RIBBONS}

// Enable translate components from group WIN 3.1
{$DEFINE WIN3_1}

// Enable translate TeeChart components
{$DEFINE TEECHART}
//{$DEFINE FMX_TEECHART}

// Enable translate SynEdit components
//{$DEFINE SYNEDIT}

// Enable UniGUI supporting (only LangMan Premium & Ultimate)
//{$DEFINE LM_UNIGUI}
//{$DEFINE UNIGUI_093_BETA_OR_OLDER}  // if your installed version is 0.93.x or older

// ALL NEXT SWITCH TO OFF FOR DELPHI XE3 or LATER
//   If necessary, move the necessary items before this definition
{$IFNDEF DXE3}  // automatically switch off for Delphi XE or later

// Enable translate Rave components include Pages in TRvProject
{$DEFINE RAVE} // automatically switched off for Delphi XE or later

// - End of LM_Config ---------------------------------------------------------
{$ENDIF}  // DXE3
{$ENDIF}

