//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManCtrls.pas                                            **
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

unit LangManCtrls;

{$WARNINGS OFF}
{$INCLUDE LM_Config.inc}
{$WARNINGS ON}

interface

uses
{$IFDEF DXE2}
     System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.ComCtrls;
{$ELSE}
     Classes, Controls, StdCtrls, ComCtrls;
{$ENDIF}

type
  TValuedLabel = class (TCustomLabel)
  private
    Space           : string;
    fValue          : TCaption;
    fValueName      : TCaption;
    fValueSeparator : string;
    fValueSpaces    : Byte;
  protected
    procedure SetCaption; virtual;
    procedure SetValue(Value: TCaption); virtual;
    procedure SetValueName(Name: TCaption); virtual;
    procedure SetValueSeparator(Separator: string); virtual;
    procedure SetValueSpaces(Spaces: byte); virtual;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Color nodefault;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
{$IF CompilerVersion > 18}
    property EllipsisPosition;
{$IFEND}
{$IF CompilerVersion > 19}
    property GlowSize; // Windows Vista only
{$IFEND}
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
{$IFDEF D2010}
    property Touch;
    property OnGesture;
{$ENDIF}
    property Transparent;
    property Layout;
    property Value: TCaption read fValue write SetValue;
    property ValueName: TCaption read fValueName write SetValueName;
    property ValueSeparator : string read fValueSeparator write SetValueSeparator;
    property ValueSpaces : byte read fValueSpaces write SetValueSpaces;
    property Visible;
    property WordWrap;
{$IFDEF DXE3}
    property StyleElements;
{$ENDIF}
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
{$IF CompilerVersion > 18}
    property OnMouseActivate;
{$IFEND}
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

procedure TValuedLabel.SetCaption;
begin
  Caption := fValueName + fValueSeparator + Space + fValue;
end;

procedure TValuedLabel.SetValue(Value: TCaption);
begin
  fValue := Value;
  SetCaption;
end;

procedure TValuedLabel.SetValueName(Name: TCaption);
begin
  fValueName := Name;
  SetCaption;
end;

procedure TValuedLabel.SetValueSeparator(Separator: string);
begin
  fValueSeparator := Separator;
  SetCaption;
end;

procedure TValuedLabel.SetValueSpaces(Spaces: Byte);
var I: byte;
begin
  fValueSpaces := Spaces;
  Space := '';
  if fValueSpaces > 0 then for I := 1 to fValueSpaces do Space := Space + ' ';
  SetCaption;
end;

end.
