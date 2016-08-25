//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManVCLCompat.pas                                        **
//**                                                                         **
//**  Version:   2.6.6                                                       **
//**                                                                         **
//**  Date:      2016-05-11                                                  **
//**                                                                         **
//**  Author:    Ing. Tomas Halabala - REGULACE.ORG                          **
//**                                                                         **
//**  Notice:    This components set is free for personal use only.          **
//**             Comercial use is not allowed without author permission!     **
//**                                                                         **
//**             It is not permitted to use these components in application  **
//**             published under a different publisher name than what is     **
//**             registered with this copy. Transferring the license to      **
//**             another person or company is not possible.                  **
//**                                                                         **
//**             It is prohibited the distribution of any part or whole      **
//**             source code and use part or whole source code for           **
//**             the creation and distribution of any other component,       **
//**             distributed with or without source code.                    **
//**                                                                         **
//**  Licensee:  DZMITRY BRIKHANCHYK                                         **
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

unit LangManVCLCompat;

interface

uses Classes;

const DEFAULT_CHARSET = 1;
      UniApplication: Pointer = nil;

type
  TCollectionItem = record
    Caption: String;
    DisplayName, FileMask: string;   // TCustomFileDialog
    CommandLinkHint: String;         // TCustomTaskDialog
  end;

  TTaskDialogButtonItem = TCollectionItem;

  TCollectionItems = record
    Items: array of TCollectionItem;
    Count: Integer;
  end;

  TFileTypeItems = TCollectionItems;
  TTaskDialogButtons = TCollectionItems;

  TUniversal = class(TComponent)
  private
    StrTemp: string;
  public
    property Caption: String read StrTemp write StrTemp;
    property Text: String read StrTemp write StrTemp;
    property Title: String read StrTemp write StrTemp;
  end;

  TCustomFileDialog = class(TUniversal)
  private
    StrTemp: string;
    FTTemp: TFileTypeItems;
  public
    property FileNameLabel: String read StrTemp write StrTemp;
    property OKButtonLabel: String read StrTemp write StrTemp;
    property FileTypes: TFileTypeItems read FTTemp write FTTemp;
  end;

  TCustomTaskDialog = class(TUniversal)
  private
    StrTemp: String;
    BtnsTemp: TTaskDialogButtons;
  public
    property Buttons: TTaskDialogButtons read BtnsTemp write BtnsTemp;
    property ExpandButtonCaption: String read StrTemp write StrTemp;
    property ExpandedText: String read StrTemp write StrTemp;
    property FooterText: String read StrTemp write StrTemp;
    property RadioButton: TTaskDialogButtons read BtnsTemp write BtnsTemp;
    property VerificationText: String read StrTemp write StrTemp;
  end;

implementation

end.
