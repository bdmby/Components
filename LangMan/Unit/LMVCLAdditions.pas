//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LMVCLAdditions.pas                                          **
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

unit LMVCLAdditions;

//*****************************************************************************
//**                                                                         **
//** Example for Component "TExample":                                       **
//**                                                                         **
//**  that contains one string property "Caption" and property "ExGroups"    **
//**                                                                         **
//**  ExGroups is declared as record:                                        **
//**  Type                                                                   **
//**    TExGroups = record                                                   **
//**      GroupName: string;                                                 **
//**      Items: TStrings;                                                   **
//**    end;                                                                 **
//**                                                                         **
//**  Addition of TExample component for translation - step by step          **
//**                                                                         **
//**  1) Declare addition property in TAdditionProperties.                   **
//**     Include item "adExGroups" before item "adCount"                     **
//**                                                                         **
//**   >> TAdditionProperties = (adExGroups, {OtherFutureNames,} adCount);   **
//**                                                                         **
//**  Note: For "Caption" property is possible use "pnCaption" from          **
//**        TStringProperties declared in LangManSys etc.                    **
//**                                                                         **
//**  2) If you want so as to default enable translation property ExGroups   **
//**     add "adExGroups" to "DefaultEnabled" set.                           **
//**                                                                         **
//**   >> DefaultEnabled = [adExGroups {, OtherDefaultEnabledProperties}]    **
//**                                                                         **
//**  3) Assign name for your addition property:                             **
//**                                                                         **
//**   >> AdditionPropertiesNames : array[0..Ord(adCount)] of String = (     **
//**        'ExGroups' {, YourOtherAdditionProperties}, 'Unknown');          **
//**                                                                         **
//**  4) Add unit with declaration of your component to uses statement.      **
//**                                                                         **
//**  5) Registration your component properties for translation              **
//**       in RegisterAdditions procedure                                    **
//**                                                                         **
//**   >> if Component is TExample then begin                                **
//**        RegisterProperty( Component,                                     **
//**                          (Component as TExample).Caption,               **
//**                          pnCaption);                                    **
//**        RegisterProperty( Component,                                     **
//**                          (Component as TExample).ExGroups.GroupName,    **
//**                          adExGroups,                                    **
//**                          'GroupName');                                  **
//**        for I := 0 to (Component as TExample).ExGroups.Items.Count do    **
//**          RegisterProperty(                                              **
//**                    Component,                                           **
//**                    (Component as TExample).ExGroups.Items.Strings[I],   **
//**                    adExGroups,                                          **
//**                    NestedAddr(NestedProperty('',pnItems), I) );         **
//**        Exit;                                                            **
//**      end;                                                               **
//**                                                                         **
//**  6) Translate your component properties in TranslateAdditions proc.     **
//**                                                                         **
//**   >> if Component is TExample then begin                                **
//**        (Component as TExample).Caption :=                               **
//**          TranslateProperty( Component,                                  **
//**                             (Component as TExample).Caption,            **
//**                             pnCaption );                                **
//**        (Component as TExample).ExGroups.GroupName :=                    **
//**         TranslateProperty( Component,                                   **
//**                           (Component as TExample).ExGroups.GroupName,   **
//**                           asExGroups,                                   **
//**                           'GroupName');                                 **
//**        for I := 0 to (Component as TExample).ExGroups.Items.Count do    **
//**         (Component as TExample).ExGroups.Items.Strings[I] :=            **
//**          TranslateProperty(                                             **
//**                     Component,                                          **
//**                     (Component as TExample).ExGroups.Items.Strings[I],  **
//**                     adExGroups,                                         **
//**                     NestedAddr(NestedProperty('',pnItems), I) );        **
//**        Exit;                                                            **
//**      end;                                                               **
//**                                                                         **
//*****************************************************************************

interface

uses Classes;

type
  // Addition properties list:
  TAdditionProperties = ({adYourComponentPropertyName,} adCount);

const
  DefaultEnabled = [{adYourComponentPropertyName}]; // Default enabled items of TAdditionProperties

  AdditionPropertiesNames : array[0..Ord(adCount)] of String = ({'YourComponentPropertyName',}'Unknown');

procedure RegisterAdditions(Component: TComponent);
procedure TranslateAdditions(Component: TComponent);

implementation

uses LangManComp, LangManSys
     {, YourComponentUnit};   // Add unit of your component

procedure RegisterAdditions(Component: TComponent); // called by LangMan while initialization
begin
  {
  if Component is TYourComponentClass then begin
    RegisterProperty( Component,
                      (Component as TYourComponentClass).YourStringProperty,
                      adYourComponentPropertyName
                     );
    Exit;
  end;
  }
end;

procedure TranslateAdditions(Component: TComponent); // called by LangMan while translate
begin
  {
  if Component is TYourComponentClass then begin
    (Component as TYourComponentClass).YourStringProperty := TranslateProperty(
                      Component,
                      (Component as TYourComponentClass).YourStringProperty,
                      adYourComponentPropertyName
                                                                               );
    Exit;
  end;
  }
end;

end.
