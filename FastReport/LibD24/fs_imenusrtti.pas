{**********************************************}
{                                              }
{              FastScript v1.9                 }
{                  Menus                       }
{                                              }
{         Copyright (c) 1998-2007              }
{           by Fast Reports Inc.               }
{                                              }
{ Copyright (c) 2006 by �������� ����          }
{ Copyright (c) 2006-2007 by Stalker SoftWare  }
{                                              }
{**********************************************}

unit fs_imenusrtti;

interface

{$I fs.inc}

uses
  SysUtils, Classes, Menus, fs_iinterpreter, fs_ievents, ImgList{$IFDEF DELPHI16}, Controls{$ENDIF}
{$IFDEF Delphi6}
, Types  , Variants
{$ENDIF};

type
{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}

  TfsMenusRTTI = class(TComponent); // fake component

implementation

type
  TFunctions = class(TfsRTTIModule)
  private
    function CallMethod(Instance: TObject; ClassType: TClass; const MethodName:
      string; Caller: TfsMethodHelper): Variant;
    function GetProp(Instance: TObject; ClassType: TClass; const PropName:
      string): Variant;
    procedure SetProp(Instance: TObject; ClassType: TClass; const PropName:
      string; Value: Variant);
  public
    constructor Create(AScript: TfsScript); override;
  end;

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);

  with AScript do
  begin

    AddType('TPopupAlignment', fvtInt);

    AddClass(TCustomImageList, 'TComponent');

    with AddClass(TMenuItem, 'TComponent') do
    begin
      AddMethod('procedure Add(Item: TMenuItem)', CallMethod);
      AddMethod('procedure Clear', CallMethod);
      AddMethod('procedure Delete(Index: Integer)', CallMethod);
      AddMethod('procedure Insert(Index: Integer; Item: TMenuItem)',
        CallMethod);
      AddMethod('procedure Remove(Item: TMenuItem)', CallMethod);
      AddMethod('function GetParentMenu: TMenu', CallMethod);
      AddEvent('OnClick', TfsNotifyEvent);
      AddProperty('Count', 'Integer', GetProp);
      AddDefaultProperty('Items', 'Integer', 'TMenuItem', CallMethod, True);
    end; { with }

    with AddClass(TMenu, 'TComponent') do
      AddIndexProperty('Items', 'Integer', 'TMenuItem', CallMethod, True);

    with AddClass(TPopupMenu, 'TMenu') do
    begin
      AddEvent('OnPopup', TfsNotifyEvent);
      AddMethod('procedure Popup(X, Y: Extended)', CallMethod);
      AddProperty('PopupComponent', 'TComponent', GetProp, SetProp);
      AddProperty('Images', 'TCustomImageList', GetProp, SetProp);
    end; { with }

  end; { with }

end; { Create }

function TFunctions.CallMethod(Instance: TObject; ClassType: TClass; const
  MethodName: string; Caller: TfsMethodHelper): Variant;
var
  oMenuItem: TMenuItem;
begin
  Result := 0;

  if ClassType = TMenuItem then
  begin

    oMenuItem := TMenuItem(Instance);

    if MethodName = 'ADD' then
      oMenuItem.Add(TMenuItem(frxInteger(Caller.Params[0])))
{$IFDEF Delphi5}
    else if MethodName = 'CLEAR' then
      oMenuItem.Clear
{$ENDIF}
    else if MethodName = 'DELETE' then
      oMenuItem.Delete(Caller.Params[0])
    else if MethodName = 'INSERT' then
      oMenuItem.Insert(Caller.Params[0], TMenuItem(frxInteger(Caller.Params[1])))
    else if MethodName = 'REMOVE' then
      oMenuItem.Remove(TMenuItem(frxInteger(Caller.Params[0])))
    else if MethodName = 'ITEMS.GET' then
      Result := frxInteger(oMenuItem.Items[Caller.Params[0]])
    else if MethodName = 'GETPARENTMENU' then
      Result := frxInteger(oMenuItem.GetParentMenu());

  end
  else if ClassType = TMenu then
  begin

    if MethodName = 'ITEMS.GET' then
      Result := frxInteger(TMenu(Instance).Items[Caller.Params[0]])

  end
  else if ClassType = TPopupMenu then
  begin

    if MethodName = 'POPUP' then
      TPopupMenu(Instance).Popup(Caller.Params[0], Caller.Params[1]);

  end; { if }

end; { CallMethod }

function TFunctions.GetProp(Instance: TObject; ClassType: TClass; const
  PropName: string): Variant;
begin
  Result := 0;

  if ClassType = TMenuItem then
  begin

    if PropName = 'COUNT' then
      Result := TMenuItem(Instance).Count;

  end
  else if ClassType = TPopupMenu then
  begin

    if PropName = 'POPUPCOMPONENT' then
      Result := frxInteger(TPopupMenu(Instance).PopupComponent)
    else if PropName = 'IMAGES' then
      Result := frxInteger(TPopupMenu(Instance).Images)

  end; { if }

end; { GetProp }

procedure TFunctions.SetProp(Instance: TObject; ClassType: TClass; const
  PropName: string; Value: Variant);
begin
  if ClassType = TPopupMenu then
  begin
    if PropName = 'IMAGES' then
      TPopupMenu(Instance).Images := TCustomImageList(frxInteger(Value))
    else if PropName = 'POPUPCOMPONENT' then
      TPopupMenu(Instance).PopupComponent := TComponent(frxInteger(Value))

  end; { if }

end; { SetProp }

initialization
{$IFDEF Delphi16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfsMenusRTTI, TControl);
{$ENDIF}
  fsRTTIModules.Add(TFunctions);


finalization
  fsRTTIModules.Remove(TFunctions);

end.

