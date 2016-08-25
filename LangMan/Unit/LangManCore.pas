//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManCore.pas                                             **
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
//**  Licensee:  denis kakop                                                 **
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

unit LangManCore;

{$DEFINE LMCORE}
{$INCLUDE LM_Config.inc}

{$IFDEF NEXTGEN}
{$UNDEF FIREDAC_GUI}
{$ENDIF}

interface

uses Classes,

{$IFDEF MSWINDOWS}
  {$IFDEF DXE2}
     Winapi.Windows,
  {$ELSE}
     Windows,
  {$ENDIF}
{$ENDIF}

{$IFDEF DXE2}
  {$IFNDEF NEXTGEN}   // NOT DEF NEXTGEN
     System.Contnrs,
  {$ENDIF}
     System.Generics.Collections,
{$ELSE}
     Contnrs,
{$ENDIF}
     SysUtils, LangManSys;

type
{$IFDEF LMIMEX}
  EImportExport = class(Exception);
{$ENDIF}

{$IFDEF NEXTGEN}
  TLMComponentList = TObjectList<TComponent>;
{$ELSE}
  TLMComponentList = TComponentList;
{$ENDIF}

  TSpans = class;
  TLMList = class;
  TLangManCore = class;
  TLangFormLexicon = class;

  TEditorActions = (eaLoadLangForEdit, eaLoadLangForCreate, eaCreateLang, eaSaveLang);
  TEditorModes = (emClient, emIndexedLexicon, emSmartLexicon, emResources);
  TFlagReq = (fqCreator, fqEditor, fqDesignLang);

  TEditorSearch = (seItem, seSource, seOriginal);
  TEditorSearchMode = set of TEditorSearch;

  TFlagsList = class (TObject)
  private
{$IFDEF DXE2}
    Flags: TObjectList<TMemoryStream>;
{$ELSE}
    Flags: TObjectList;
{$ENDIF}
    function GetFlagStream(Index: Integer): TMemoryStream;
  public
    constructor Create;
    destructor Destroy; override;
    function Count: Integer;
    procedure ClearFlags;
    function NewFlag: TMemoryStream;
    function Present(FlagIndex: Integer): Boolean;
    property Flag[Index: Integer]: TMemoryStream read GetFlagStream;
  end;

  TLangCoreData = class (TObject)
  private
    LastSearch: String;
  public
    Languages        : TStringList;
    EditableLangs    : TStringList;
    LangCodes        : TStringList;
    FileNames        : TStringList;
    LangMenu         : TStringList;
    Flags            : TFlagsList;
    SpanClients      : TSpans;

    Engine           : TLangManCore;
    CurrentSuperiorLang : TLangIDs;
    DesignLangISO    : TISOCode;
    EditorISO        : TISOCode;
    EditorLang       : TLanguage;

    DataStruct       : TComponentStructure;
    DataLexicon      : TLexiconData;
    LangFormLexicon  : TLangFormLexicon;

{$IFDEF LMSMART}
    SmartLexicon     : TSmartLexiconData;
{$ENDIF}

    // Editor data
    EditorMode         : TEditorModes;
    SelectedClient     : Integer;
    PageFromClient     : Integer;
{$IFDEF NEXTGEN}
    EditorLex          : TArray<String>;
{$ELSE}
    EditorLex          : array of String;
{$ENDIF}

{$IFDEF DXE2}
    ClientGroups       : TObjectList<TComponent>;
{$ELSE}
    ClientGroups       : TComponentList;
{$ENDIF}
    DesignedList       : TIndexedItems;
    WorkIndexes        : TWordList;
    SourceIndexes      : TWordList;
    WorkStruct         : TComponentStructure;
    SourceStruct       : TComponentStructure;
    WorkLexicon        : TIndexedItems;
    SourceLexicon      : TLexiconData;
{$IFDEF LMSMART}
    WorkGlobalLexicon  : TNamedItems;
    WorkSmartLexicon   : TNamedItems;
    SourceSmartLexicon : TSmartLexiconData;
{$ENDIF}

    constructor Create(OwnedEngine: TLangManCore); virtual;
    destructor Destroy; override;
    function LangsDir: String;
    function EditorAction(act: TEditorActions; Param: String = ''): Boolean;
    function GetFile(ISOorLangName: String): TFileName; overload;
    function GetFile(LanguageIndex: Integer): TFileName; overload;
    function GetCode(LanguageName: String): String; overload;
    function GetCode(LanguageIndex: Integer): String; overload;
    function Exists(ISOorLangName: String): Boolean;
    function Flag(ISOorLangName: String): TMemoryStream; overload;
    function Flag(LanguageIndex: Integer): TMemoryStream; overload;
    procedure NewLanguage;
    procedure Clear;
    procedure ClearWorkData;
    procedure CompleteSourceData;
    function PrepareForEditor: String;
    function LoadGroups(List: TStrings): Boolean;
    procedure LoadObjects(List: TStrings);
    procedure NewEditorPage(ObjectName: String; LMAdditionNames: array of String);
    function ChangeEditorClient(ClientIndex: Integer): TEditorModes;
    procedure StoreEditorPage;
    procedure StoreGroup; virtual;
    procedure StoreChanges; virtual;
{$IFDEF LMIMEX}
 {$IFDEF LMSMART}
    procedure ExportLanguage(FileName, LangName: string; LangISO: TISOCode);
 {$ENDIF}
    function AddTranslate(Designed, Translated: String; OverwritingAllowed: Boolean = false): Integer;
{$ENDIF}
    function EditorExecute(EMode: Integer): TLanguage; virtual; abstract;
    procedure AddEditorRow(PropertyName, Value: String); virtual; abstract;
    function GetEditorRow(Row: Integer): String; virtual; abstract;
    function EditorOpened: Boolean; virtual; abstract;
    procedure EditorSelect(Row, Start, Len: Integer; Column: TEditorSearch); virtual; abstract;
    function SearchWord(const Searched: String; StartRow: Integer; Mode: TEditorSearchMode): Boolean;
{$IFDEF LMSMART}
    procedure LoadNewWorkGlobals;
    procedure StoreNewGlobals;
    function GetGlobalSource(LocStr: String): String;
    function GetGlobalTranslate(LocStr: String): String;
    function EditorItemIsGlobal(Row: Integer; out WorkIndex: Integer): Boolean;
{$ENDIF}
    function AllowedGlobals: Boolean;
    function GetEditorRowsCount: Integer;
    function ChangeableEditorItem(Row: Integer): Boolean;
    function ClientName(ClientIndex: Integer = -1): String;
    function GetItemColor(ItemDescent: Word; NoTrans: Boolean): Longword; overload;
    function GetItemColor(ItemDescent: Word; ItemContent, Original: String): Longword; overload;
    function GetItemColor(EditorIndex: Integer; ObjectName, CurrentString: String): Longword; overload;
    function GetColorHint(Color: Longword): String;
    procedure RememberCell(Content: String; WorkIndex: Integer; Descent: Word; SaveNewGlobals: Boolean = false);
    function SwitchEditorItem(EditorItem: Integer; Content: String; var AllowNoTrans: Boolean; out NewText: String): Boolean;
    function GetOriginalForEditorItem(EditorItem: Integer): String;
    function GetSourceForEditorItem(EditorItem: Integer): String;
    function SelectEditorItem(EditorItem: Integer; SameLocStr: TWordList; out SourceColor: Longword): String;
    function IsUntranslated(ClientName, ObjectName: String): Boolean;
  end;

  TLangManCore = class(TComponent)
  private
    DesignTimeAdjustment   : Integer;
    IsFullyCreated         : Boolean;
    IsMultiEngine          : Boolean;
    LastAutoLangName       : String;

    fCurrentLanguage       : TLanguage;
    fCurrentLangISO        : TISOcode;
    fDesignLanguage        : TLanguage;
    fDefaultLanguage       : String;
    fDesignLangISOCode     : String;
    fLangSubdir            : String;
    fLangFileExt           : String;
    fLangFileSign          : String;
    fLangFileEncoding      : TLFEncoding;
    fCookieEnabled         : boolean;
    fCookieLifeDays        : Double;
    fCookieName            : String;
    fAllowEditInternalLangs: boolean;
    fLangEditorVisible     : boolean;
    fLangCreatorVisible    : boolean;
    fIncludeLangMan        : boolean;
    fLangMenuFlags         : boolean;
    fHideCopyright         : boolean;
    fLangResources         : TStringList;

    fOnChangeLangQuery     : TContinueQuery;
    fOnChangeLanguage      : TNotifyEvent;
    fOnBeforeEdit          : TNotifyEvent;
    fOnAfterEdit           : TNotifyEvent;

    function EngineLoaded: Boolean;
    function GetCurrentLangISO: String;
    procedure SetDesignLangISOCode(Input: string);
    procedure SetDesignLang(Input: TLanguage);
    function GetDefaultLanguage: String;
    procedure SetDefaultLanguage(Input: String);
    procedure SetLangFileExt(Input: string);
    procedure SetLangFileSign(Sign: string);
    function GetLangCreatorVisible: Boolean;
    procedure SetLangCreatorVisible(Enable: boolean);
    function GetLangEditorVisible: Boolean;
    procedure SetLangEditorVisible(Enable: boolean);
    procedure SetIncludeLangMan(Input: boolean);
    procedure SetLangResources(ResLangs: TStringList);
    procedure SetLangResourcesAllowEdit(Enable: boolean);
    function GetCookieLifeDays: Double;
    procedure SetCookieLifeDays(CookieLifeTime: Double);
    function GetCurrentLanguage: String;
    procedure SetCurrentLanguage(LangNameOrISO: String);
    function GetCookieName: String;
    function CheckLangDir: Boolean;
    function LoadLangFromFile(LangName: TLanguage; Options: TLLFOptions; AntiLoop: TLanguage = ''): boolean;
    function TranslateLangForm(ToLang: TLanguage; Code: TISOCode; ForceTranslate: Boolean): boolean;
    function LangManCommands(Command: String): TLanguage;
    procedure SaveLanguageFile(LangName, SuperiorLang, FileName: string; LangISO: TISOCode);
{$IFDEF LMIMEX}
 {$IFDEF LMSMART}
    procedure ExportLanguage(FileName, LangName: String; LangISO: TISOCode);
 {$ENDIF}
{$ENDIF}
    function GetFileNameForNew(RecommendedName: String): String;
    function ResourceLangToFile(LangIndex: Integer): Boolean;
  protected
    IsInitialized : Boolean;
    LData         : TLangCoreData;

    function GetDefaultCookieID: String; virtual;
    procedure SetCookieName(CName: String); virtual;
    procedure CookieNameChanged; virtual;
    procedure SetLangSubdir(Input: string); virtual;
    procedure SetLangMenuFlags(Input: boolean); virtual;
    procedure SetName(const NewEngineName: TComponentName); override;
    procedure RememberLanguage(LangID: String); virtual;
    function GetInitLanguage: String; virtual;
    function EditorDisabled: Boolean; virtual;
    function ReCreateLangMenus: Boolean; virtual;
    procedure RefreshLangList(GUIComponent: TComponent; LangIndex: Integer); virtual; abstract;
    procedure RefreshLangLists; virtual;
    function LangFilesPath: String; virtual; abstract;
    procedure LoadFlagIcon(FlagStream: TMemoryStream; reqFlag: TFlagReq); virtual; abstract;
    function EngineInit(LoadDefault: Boolean = true): Boolean; virtual;
    function IsWebSession: Boolean; virtual;
    procedure RegisterClient(ClientComponent: TComponent; var EngineHandle: TLangManCore); virtual;
    procedure UnregisterClient(ClientComponent: TComponent); virtual;
    procedure FindLangFiles;
    procedure Loaded; override;
    property CookieEnabled: Boolean read fCookieEnabled write fCookieEnabled default True;
    property CookieLifeDays: Double read GetCookieLifeDays write SetCookieLifeDays;
    property CookieName: String read GetCookieName write SetCookieName;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Translate(ISOorLangName: String): TLanguage;
    function TranslateString(Str: String; Lexicon: TLMList = nil; ItemNr: Integer = -1): String;
    procedure AssignLanguagesList(TargetList: TStrings);
    function GetLanguageFile(ISOorLangName: String): TFileName; overload;
    function GetLanguageFile(LanguageIndex: Integer): TFileName; overload;
    function GetISOCode(LanguageName: String): String; overload;
    function GetISOCode(LanguageIndex: Integer): String; overload;
    function LangExists(ISOorLangName: String): Boolean;
    function FlagImage(ISOorLangName: String): TMemoryStream; overload;
    function FlagImage(LanguageIndex: Integer): TMemoryStream; overload; virtual;
    function EditorCanBeShown: Boolean;
    procedure ShowLangEditor;
    procedure ShowLangCreator;
{$IFDEF LMIMEX}
    function ImportFromFile(FileName: String; ToCurrentLanguage: Boolean): Integer;
 {$IFDEF LMSMART}
    procedure ExportToFile(FileName: String);
    function GlobalToOriginal(GlobalStr: String): String;
    function GlobalToLink(GlobalStr: String): String;
 {$ENDIF}
{$ENDIF}
    procedure RefreshLangControl(LangManGUIControl: TComponent);
    property CurrentLanguage: String read GetCurrentLanguage write SetCurrentLanguage;
    property CurrentLanguageISO: String read GetCurrentLangISO write SetCurrentLanguage;
    property LangMenuFlags: boolean read fLangMenuFlags write SetLangMenuFlags default True;
  published
    property DesignLangISOCode: String read fDesignLangISOCode write SetDesignLangISOCode;
    property DesignLanguageName: TLanguage read fDesignLanguage write SetDesignLang;
    property DefaultLanguage: String read GetDefaultLanguage write SetDefaultLanguage;
    property LangSubdirectory: String read fLangSubdir write SetLangSubdir;
    property LangFileExtension: String read fLangFileExt write SetLangFileExt;
    property LangFileSignature: String read fLangFileSign write SetLangFileSign;
{$IF CompilerVersion > 19}
    property LangFileEncoding: TLFEncoding read fLangFileEncoding write fLangFileEncoding default Unicode;
{$IFEND}
{$IFDEF LMPRO}
    property HideCopyright: Boolean read fHideCopyright write fHideCopyright default false;
{$ENDIF}
    property LangCreatorVisible: boolean read GetLangCreatorVisible write SetLangCreatorVisible default True;
    property LangEditorVisible: boolean read GetLangEditorVisible write SetLangEditorVisible default True;
    property TranslateLangMan: boolean read fIncludeLangMan write SetIncludeLangMan default False;
    property LangResources: TStringList read fLangResources write SetLangResources;
    property LangResourcesAllowEdit: Boolean read fAllowEditInternalLangs write SetLangResourcesAllowEdit default False;
    property OnChangeLangQuery: TContinueQuery read fOnChangeLangQuery write fOnChangeLangQuery;
    property OnChangeLanguage: TNotifyEvent read fOnChangeLanguage write fOnChangeLanguage;
    property OnBeforeEdit: TNotifyEvent read fOnBeforeEdit write fOnBeforeEdit;
    property OnAfterEdit: TNotifyEvent read fOnAfterEdit write fOnAfterEdit;
  end;

  TLangManComponent = class (TComponent)
  private
    LMComponentLanguage: TLanguage;
    fLangManEngine : TLangManCore;
    fConnectedGlobal : Boolean;
    fOnChangeLanguage: TNotifyEvent;
    procedure SetLangManEngine(LangMan: TLangManCore);
    procedure SetConnectedGlobal(Connect: Boolean);
  protected
    procedure Init; virtual;
    procedure PrepareForDesignTimeEdit; virtual;
    procedure ChangeLanguage(Sender: TObject); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    property GlobalLexicon: Boolean read fConnectedGlobal write SetConnectedGlobal default False;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property LangManEngine: TLangManCore read fLangManEngine write SetLangManEngine;
    property OnChangeLanguage: TNotifyEvent read fOnChangeLanguage write fOnChangeLanguage;
  end;

  TIntegratedLangManHandler = class (TComponent)
  strict private
    Integrator: TLMComponentList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetIntegrator(Master: TLangManComponent);
    function GetIntegrator: TLangManComponent;
  end;

  TLangManCPC = class (TLangManComponent)
  private
    DesignStruct  : TComponentStructure;
    LanguageOwner : String;
    fAfterCreate  : boolean;    // sestavení jazykového seznamu až po volání metody OnCreate formuláøe
    ObjMap        : TStringList;
{$IFDEF DATABASES}
 {$IFNDEF NEXTGEN}
    procedure ChangeStructTableProducerColumns(Component: TComponent; PropertyType : Word; fchInit: boolean);
 {$ENDIF}
{$ENDIF}
  protected
    OwnerOnCreate : TNotifyEvent;
    CSInitialized : boolean;

    function TransProp(Prop: TStringProperties): Boolean; overload; virtual;
    function TransProp(Prop: TTStringsProperties): Boolean; overload; virtual;
    function TransProp(Prop: TStructuredProperties): Boolean; overload; virtual;
    function TransProp(Prop: TOtherProperties): Boolean; overload; virtual;

    function  IsWebClient: Boolean; virtual;
    procedure InitWebClient; virtual;
    procedure Init; override;
    procedure InitForm(AOwner: TObject); virtual;

    function ObjectAddress(Obj: TObject; const Tag: String = ''): String;
    function GetLanguageOwnerName: String;
    function GetLanguageComponentOwner(Component: TComponent): String;

    procedure CreateStructItem(Component: TComponent; PropertyType: Word; Input: String; Addr: String = ''); overload;
    procedure CreateStructItem(ComponentName: String; Component: TComponent; PropertyType: Word; Input, Addr: string); overload;
    function StructItem(ComponentName, OwnerName: string; PropertyType: Word; Addr: string = ''): string;

    function NotLinkedToAction(PropertyType : Word; const CompStr, ActionStr: string): Boolean; virtual;
    function ChangeStructItem(Component: TComponent; PropertyType : Word; InitText: string; fchInit: boolean; ActionString: string = ''): string;
    function ChangeStructItemEx(Component: TComponent; PropertyType : Word; InitText: string; fchInit: boolean; PresetAddr: string = ''): string;
    procedure ChangeStructStrings(Component: TComponent; PropertyType : Word; Data: TStrings; fchInit: boolean);
    procedure ChangeStructStringsEx(Component: TComponent; PropertyType : Word; Data: TStrings; fchInit: boolean; PresetAddr: string);

    function ChangeStructFilter(Component: TComponent; PropertyType : Word; InitFilter: string; fchInit: boolean): string;

    procedure ChangeStrings(Component: TComponent; fchInit: boolean); virtual;
    procedure ControlChanges(fchInit: boolean); virtual; abstract;
    procedure UpdateClientStruct(TranslateItems: Boolean);
    function BackToDesignedState: String;
    procedure TransParamsChanged;
    procedure ChangeLanguage(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AddComponent(Component: TComponent; Name: string; Translate: boolean): Boolean; virtual;
    procedure RecreateTransStruct; virtual;
    procedure TranslateComponent(Component: TComponent; Name: string = ''); virtual;
    procedure Translate; virtual;
  {$IFDEF LMPRO}
    procedure TranslateAs(FormName: String);
  {$ENDIF}
  published
    property InitAfterCreateForm: boolean read fAfterCreate write fAfterCreate default false;
  end;

  TLMList = class( TLangManComponent )
  protected
    function GetItem(Index: Integer): string; virtual; abstract;
    function MaxIndex: Integer; virtual; abstract;
    function IsDefined(Index: Integer): boolean; overload; virtual; abstract;
    function IsDefined(LocStr: String): boolean; overload; virtual; abstract;
    function GetLocStr(Index: Integer): String; virtual; abstract;
  end;

  TLexiconSlave = procedure of object;

  TLexicon = class( TLMList )
  private
{$IFDEF NEXTGEN}
    Slaves: TArray<TLexiconSlave>;
{$ELSE}
    Slaves: array of TLexiconSlave;
{$ENDIF}
  protected
    procedure ChangeLanguage(Sender: TObject); override;
    function GetLink(Index: Integer): string; virtual;
    function CompleteString(const Str: string): string; virtual;
    function IsDef(Index: Integer): boolean;   // only for lexicon helper
    property Link [Index: Integer]: string read GetLink;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TCustomDesignedLexicon = class (TLexicon)
  private
    fItems: TStringList;
    procedure SetItems(Value: TStringList);
  protected
    function GetItem(Index: Integer): string; override;
    function MaxIndex: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetLocStr(Index: Integer): String; override;
    function IsDefined(Index: Integer): boolean; overload; override;
    function IsDefined(LocStr: String): boolean; overload; override;
    function CreateItem(Text: string): Integer;
    function CompleteString(const Str: string): string; override;
    property Item [Index: Integer]: string read GetItem;
    property Link;
  published
{$IFDEF LMSMART}
    property GlobalLexicon;
{$ENDIF}
    property Items : TStringList read fItems write SetItems;
  end;

  TCustomProgrammableLexicon = class (TLexicon)
  private
    fIndexedItems: TIndexedItems;
    fOnInitialization: TNotifyEvent;
    procedure SetOnInitialization(Event: TNotifyEvent);
  protected
    function GetItem(Index: Integer): string; override;
    function MaxIndex: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DefineItem(ItemNr: Word; Text: string);
    function GetLocStr(Index: Integer): String; override;
    function IsDefined(Index: Integer): boolean; overload; override;
    function IsDefined(LocStr: String): boolean; overload; override;
    function CompleteString(const Str: string): string; override;
    property Item [Index: Integer]: string read GetItem;
    property Link;
  published
{$IFDEF LMSMART}
    property GlobalLexicon;
{$ENDIF}
    property OnInitialization: TNotifyEvent read fOnInitialization write SetOnInitialization;
  end;

  TLangFormLexicon = class ( TCustomProgrammableLexicon )
  private
    fIntLang: TLangIDs;
  public
    procedure LoadLang(StringArray: TInternalLangDefs);
    function InternalLanguages(Lang: TLanguage; Code: TISOCode; LoadDefs: Boolean = true): boolean;
    constructor Create(AOwner: TComponent); override;
    function GetItem(Index: Integer): string; override;
    property InternalLanguage: TLangIDs read fIntLang;
  end;

  TLangManStrings = class(TStringList)
  private
    Controlled: TStrings;
    AssignedLexicon: TLexicon;
  public
    constructor Create(ControlledStrings: TStrings; Lexicon: TLexicon); virtual;
    destructor Destroy; override;
    function Add(const S: string): Integer; override;
    function AddObject(const S: string; AObject: TObject): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure InsertObject(Index: Integer; const S: string; AObject: TObject); override;
    procedure CustomSort(Compare: TStringListSortCompare); override;
    procedure Translate;
  end;

  TSpans = class (TObject)
  public
    Components : TLMComponentList;
    constructor Create;
    destructor Destroy; override;
    procedure RegisterClient(Client: TComponent);
    procedure UnregisterClient(Client: TComponent);
    procedure CallClientProcs;
    procedure InitClients;
    procedure InitToLanguage(InitLanguage: TLanguage; IsDesignLang: Boolean);
    procedure PrepareForDesignTimeEdit;
    function GetClientByStructLine(const StructItem: TFullStructLine): TLangManCPC;
    function GetListByName(const ListName: String): TLMList;
    function SpanName(Index: Integer): String;
    function IsRegistered(const StructItem: TFullStructLine): Boolean; overload;
    function IsRegistered(const ByName: String): Boolean; overload;
  end;

{$IFDEF LMULT}
{$I LMInline}
{$ENDIF}

{$IFDEF LMSMART}
{$I LMResHack}
{$ENDIF}

function GetSpanComponentName(SpanComponent: TComponent): String;
function EngineAdjustment(Engine: TLangManCore; AdjID: Integer): Boolean;
procedure SetClientEngine(ClientComponent: TComponent; NewEngine: TLangManCore; var EngineHandle: TLangManCore);
procedure RegisterLexSlave(Lex: TLexicon; SlaveProc: TLexiconSlave);
procedure UnregisterLexSlave(Lex: TLexicon; SlaveProc: TLexiconSlave);

implementation

{$DEFINE COREIMPL}

uses LangManISO,

{$IFDEF FIREDAC_GUI}
     FireDAC.Comp.UI,
{$ENDIF}

{$IFDEF DXE3}
     System.Actions,
{$ENDIF}

{$IFDEF DXE2}
 {$IFDEF DATABASES}
  {$IFNDEF NEXTGEN}
     Web.DBWeb,
  {$ENDIF}
 {$ENDIF}
     System.Types;
{$ELSE}
 {$IFDEF DATABASES}
     DBWeb,
 {$ENDIF}
     Types;
{$ENDIF}

var LangManMulti: TStringList;

function GetSpanComponentName(SpanComponent: TComponent): String;
begin
  if Assigned(SpanComponent) then begin
    if SpanComponent is TLangManCPC then begin
      Result := (SpanComponent as TLangManCPC).GetLanguageOwnerName;
    end else if SpanComponent is TLMList then begin
      Result := GetLexiconName(SpanComponent);
    end else Result := SpanComponent.Name;
  end else Result := '';
end;

function EngineAdjustment(Engine: TLangManCore; AdjID: Integer): Boolean;
begin
  if DesignTime AND (Engine <> nil) then begin
    Result := Engine.DesignTimeAdjustment <> AdjID;
    Engine.DesignTimeAdjustment := AdjID;
  end else Result := false;
end;

procedure SetClientEngine(ClientComponent: TComponent; NewEngine: TLangManCore; var EngineHandle: TLangManCore);
begin
  if NewEngine <> EngineHandle then begin
    if Assigned(EngineHandle) AND (EngineHandle.Owner <> ClientComponent.Owner) then EngineHandle.RemoveFreeNotification(ClientComponent);
    if Assigned(NewEngine) then begin
      NewEngine.RegisterClient(ClientComponent, EngineHandle);
      if NOT (csLoading in (ClientComponent.ComponentState + NewEngine.ComponentState))
        then NewEngine.RefreshLangControl(ClientComponent);
    end else begin
      if Assigned(EngineHandle) then EngineHandle.UnregisterClient(ClientComponent);
      EngineHandle := nil;
    end;
    if Assigned(EngineHandle) AND (EngineHandle.Owner <> ClientComponent.Owner) then EngineHandle.FreeNotification(ClientComponent);
  end;
end;

//+****************************************************************************
//+*  LangMan core data class                                                **
//+****************************************************************************

constructor TLangCoreData.Create(OwnedEngine: TLangManCore);
begin
  SpanClients     := TSpans.Create;
  Languages       := TStringList.Create;
  LangCodes       := TStringList.Create;
  FileNames       := TStringList.Create;
  LangMenu        := TStringList.Create;
  EditableLangs   := TStringList.Create;
  Flags           := TFlagsList.Create;

  DataStruct      := TComponentStructure.Create;
  DataLexicon     := TLexiconData.Create;
{$IFDEF LMSMART}
  SmartLexicon    := TSmartLexiconData.Create;
{$ENDIF}
  Engine          := OwnedEngine;

  Languages.CaseSensitive := false;
  LangCodes.CaseSensitive := false;

  SelectedClient := -1;
  PageFromClient := -1;
{$IFDEF DXE2}
  ClientGroups := TObjectList<TComponent>.Create(false);
{$ELSE}
  ClientGroups := TComponentList.Create;
{$ENDIF}
  DesignedList := TIndexedItems.Create('');
  WorkIndexes := TWordList.Create;
  SourceIndexes := TWordList.Create;
  WorkStruct := TComponentStructure.Create;
  SourceStruct := TComponentStructure.Create;
  SourceLexicon := TLexiconData.Create;
  WorkLexicon := TIndexedItems.Create('Temp lexicon');
{$IFDEF LMSMART}
  WorkGlobalLexicon := TNamedItems.Create('');
  WorkSmartLexicon := TNamedItems.Create('Smart');
  SourceSmartLexicon := TSmartLexiconData.Create;
{$ENDIF}
end;

destructor TLangCoreData.Destroy;
begin
  FreeAndNil(Languages);
  FreeAndNil(LangCodes);
  FreeAndNil(FileNames);
  FreeAndNil(LangMenu);
  FreeAndNil(EditableLangs);
  FreeAndNil(Flags);

  FreeAndNil(DataStruct);
  FreeAndNil(DataLexicon);
{$IFDEF LMSMART}
  FreeAndNil(SmartLexicon);
{$ENDIF}
  FreeAndNil(SpanClients);

  FreeAndNil(ClientGroups);
  FreeAndNil(DesignedList);
  FreeAndNil(WorkIndexes);
  FreeAndNil(SourceIndexes);
  FreeAndNil(WorkStruct);
  FreeAndNil(SourceStruct);
  FreeAndNil(SourceLexicon);
  FreeAndNil(WorkLexicon);
{$IFDEF LMSMART}
  FreeAndNil(WorkGlobalLexicon);
  FreeAndNil(WorkSmartLexicon);
  FreeAndNil(SourceSmartLexicon);
{$ENDIF}

  Engine := nil;
  inherited Destroy;
end;

function TLangCoreData.LangsDir: String;
begin
  Result := Engine.LangFilesPath;
end;

function TLangCoreData.EditorAction(act: TEditorActions; Param: String = ''): Boolean;
var LangIndex: Integer;
begin
  Result := false;
  case act of
    eaLoadLangForEdit: begin
      LangIndex := Languages.IndexOf(Param);
      if LangIndex >= 0 then begin
        if NOT FileExists(FileNames.Strings[LangIndex]) then begin
          // edit language from resources
          if NOT Engine.ResourceLangToFile(LangIndex) then Exit;
        end;
      end;
      Result := Engine.LoadLangFromFile(Param, [lloCreateSource, lloMarkOld, lloLoadFlag]);
    end;
    eaLoadLangForCreate: begin
      Result := Engine.LoadLangFromFile(Param, [lloLoadSuperior]);
    end;
    eaCreateLang: begin
      Engine.fCurrentLanguage := EditorLang;
      Engine.fCurrentLangISO := EditorISO;
      IsISO1(Engine.fCurrentLangISO);
      Result := true;
    end;
    eaSaveLang: begin
      Engine.SaveLanguageFile(EditorLang, CurrentSuperiorLang.Name, Param, EditorISO);
      Result := true;
    end;
  end;
end;

function TLangCoreData.GetFile(ISOorLangName: String): TFileName;
var LangIndex: Integer;
begin
  LangIndex := LangCodes.IndexOf(ISOorLangName);
  if LangIndex < 0 then LangIndex := Languages.IndexOf(ISOorLangName);
  if LangIndex >= 0 then Result := FileNames.Strings[LangIndex]
                    else Result := '';
end;

function TLangCoreData.GetFile(LanguageIndex: Integer): TFileName;
begin
  if (LanguageIndex >= 0) AND (LanguageIndex < FileNames.Count) then Result := FileNames.Strings[LanguageIndex]
                                                                else Result := '';
end;

function TLangCoreData.GetCode(LanguageName: String): String;
var LangIndex: Integer;
begin
  LangIndex := Languages.IndexOf(LanguageName);
  if LangIndex >= 0 then Result := LangCodes.Strings[LangIndex]
                    else Result := '';
end;

function TLangCoreData.GetCode(LanguageIndex: Integer): String;
begin
  if (LanguageIndex >= 0) AND (LanguageIndex < LangCodes.Count) then Result := LangCodes.Strings[LanguageIndex]
                                                                else Result := '';
end;

function TLangCoreData.Exists(ISOorLangName: String): Boolean;
var LangIndex: Integer;
begin
  LangIndex := LangCodes.IndexOf(ISOorLangName);
  if LangIndex < 0 then LangIndex := Languages.IndexOf(ISOorLangName);
  Result := LangIndex >= 0;
end;

function TLangCoreData.Flag(ISOorLangName: String): TMemoryStream;
var LangIndex: Integer;
begin
  LangIndex := LangCodes.IndexOf(ISOorLangName);
  if LangIndex < 0 then LangIndex := Languages.IndexOf(ISOorLangName);
  if LangIndex >= 0 then Result := Flags.Flag[LangIndex]
                    else Result := nil;
end;

function TLangCoreData.Flag(LanguageIndex: Integer): TMemoryStream;
begin
  if (LanguageIndex >= 0) AND (LanguageIndex < Flags.Count) then Result := Flags.Flag[LanguageIndex]
                                                            else Result := nil;
end;

procedure TLangCoreData.NewLanguage;
begin
  DataStruct.NewLanguage;
  DataLexicon.NewLanguage;
{$IFDEF LMSMART}
  SmartLexicon.NewLanguage;
{$ENDIF}
end;

procedure TLangCoreData.Clear;
begin
  DataStruct.Clear;
  DataLexicon.Clear;
{$IFDEF LMSMART}
  SmartLexicon.Clear;
{$ENDIF}
  CurrentSuperiorLang.Name := '';
  CurrentSuperiorLang.Code := '';
end;

procedure TLangCoreData.ClearWorkData;
begin
  SetLength(EditorLex, 0);
  EditorLex := nil;
  SelectedClient := -1;
  PageFromClient := -1;
  ClientGroups.OwnsObjects := false;
  ClientGroups.Clear;
  WorkIndexes.Clear;
  SourceIndexes.Clear;
  DesignedList.Clear;
  WorkStruct.Clear;
  SourceStruct.Clear;
  WorkLexicon.Clear;
  SourceLexicon.Clear;
{$IFDEF LMSMART}
  WorkGlobalLexicon.Clear;
  WorkSmartLexicon.Clear;
  SourceSmartLexicon.Clear;
{$ENDIF}
end;

procedure TLangCoreData.CompleteSourceData;
var SI,OI,Index: Integer;
    Client: TLangManCPC;
    DataLine: TSimpleStructLine;
    LMList: TLMList;
    BufStr, LexName: String;
begin
  DataLine.Descent := DESCENT_UNIFY;
  SourceStruct.Clear;
  SourceLexicon.Clear;
{$IFDEF LMSMART}
  SourceSmartLexicon.Clear;
  if SmartLexicon.ItemsCount > 0 then begin
    for OI := 0 to SmartLexicon.MaxItemNr do begin
      BufStr := SmartLexicon.GetLocStr(OI);
      DataLine.Translation := SmartLexicon.ReadItem(OI, DataLine.Descent);
      SourceSmartLexicon.AddItem(BufStr, DataLine.Translation, DataLine.Descent);
    end;
  end;
{$ENDIF}
  if SpanClients.Components.Count > 0 then begin
    for SI := 0 to SpanClients.Components.Count - 1 do begin
      if SpanClients.Components.Items[SI] is TLangManCPC then begin
        Client := TLangManCPC(SpanClients.Components.Items[SI]);
        if Client.DesignStruct.Count > 0 then begin
          for OI := 0 to Client.DesignStruct.Count - 1 do begin
            DataLine := Client.DesignStruct.GetSimple(OI);
            Index := DataStruct.Find(DataLine.LineID);
            if (Index >= 0) then begin
              DataLine.Changeable := DataStruct.Changeable[Index] AND (NOT ca_OLD);
              DataLine.Descent := DataStruct.Descent[Index] AND DESCENT_MASK;
              BufStr := DataStruct.Translation[Index];
{$IFDEF LMSMART}
              if (DataLine.Descent > 0) AND Client.GlobalLexicon then begin
                Index := SmartLexicon.FindTranslate(DataLine.Translation, DataLine.Descent);
                if Index >= 0 then begin
                  BufStr := SmartLexicon.ReadItem(Index, DataLine.Descent);
                  DataLine.Descent := DataLine.Descent OR GLOBAL_DESCENT_FLAG;
                end;
              end;
{$ENDIF}
              if BufStr <> '' then DataLine.Translation := BufStr;
            end;
            SourceStruct.AddLine(DataLine);
          end;
        end;
      end;
      if SpanClients.Components.Items[SI] is TLMList then begin
        LMList := TLMList(SpanClients.Components.Items[SI]);
        LexName := GetLexiconName(LMList);
{$IFDEF LMSMART}
        if (LMList is TCustomResourcesTranslator)
 {$IFDEF LMULT}
           OR (LMList is TCustomInlineLexicon)
 {$ENDIF}
         then begin
          SourceSmartLexicon.NewLexicon(LexName);
          if LMList.MaxIndex >= 0 then begin
            for OI := 0 to LMList.MaxIndex do begin
              BufStr := LMList.GetLocStr(OI);
              DataLine.Translation := SmartLexicon.ReadItem(LexName, BufStr, DataLine.Descent);
              if (DataLine.Descent > 0) AND LMList.GlobalLexicon then begin
                Index := SmartLexicon.FindTranslate(BufStr, DataLine.Descent);
                if Index >= 0 then begin
                  DataLine.Translation := SmartLexicon.ReadItem(Index, DataLine.Descent);
                  DataLine.Descent :=  DataLine.Descent OR GLOBAL_DESCENT_FLAG;
                end;
              end;
              if DataLine.Translation = '' then SourceSmartLexicon.AddItem(LexName, BufStr, BufStr, DESIGN_DESCENT)
                                           else SourceSmartLexicon.AddItem(LexName, BufStr, DataLine.Translation, DataLine.Descent);
            end;
          end;
          Continue;
        end;
{$ENDIF}
        SourceLexicon.NewLexicon(LexName);
        if LMList.MaxIndex >= 0 then begin
          for OI := 0 to LMList.MaxIndex do begin
            if LMList.IsDefined(OI) then begin
              DataLine.Descent := DESIGN_DESCENT;
              BufStr := LMList.GetLocStr(OI);
              DataLine.Translation := BufStr;
              if DataLexicon.IsIncluded(LexName, OI) then DataLine.Translation := DataLexicon.ReadItem(LexName, OI, DataLine.Descent);
{$IFDEF LMSMART}
              if (DataLine.Descent > 0) AND LMList.GlobalLexicon then begin
                Index := SmartLexicon.FindTranslate(BufStr, DataLine.Descent);
                if Index >= 0 then begin
                  DataLine.Translation := SmartLexicon.ReadItem(Index, DataLine.Descent);
                  DataLine.Descent :=  DataLine.Descent OR GLOBAL_DESCENT_FLAG;
                end;
              end;
{$ENDIF}
              SourceLexicon.WriteItem(LexName, OI, DataLine.Translation, DataLine.Descent);
            end;
          end;
        end;
      end;
    end;
  end;
  DataStruct.Clear;
  DataLexicon.Clear;
{$IFDEF LMSMART}
  SmartLexicon.Clear;
{$ENDIF}
end;

function TLangCoreData.PrepareForEditor: String;
var I: Integer;
begin
  ClearWorkData;
  EditorMode := emIndexedLexicon;
  SetLength(EditorLex, LANGMANLANG_ITEMS+1);
  for I := 0 to LANGMANLANG_ITEMS do EditorLex[I] := LangFormLexicon.Item[I];
  Result := 'LangMan ver.' + LANGMAN_VERSION + '  Copyright (c) 2009-' + LANGMAN_VERSION_YEAR + ' by ' + AUTHOR;
end;

function TLangCoreData.LoadGroups(List: TStrings): Boolean;
var SpanIndex: Integer;
    LangManLex: TComponent;

  function AddGroup(GroupClient: TComponent): Integer;
  var CName: String;
  begin
    CName := GetSpanComponentName(GroupClient);
    if List.IndexOf(CName) < 0 then begin
      Result := List.Add(CName);
      ClientGroups.Add(GroupClient);
    end else Result := -1;
  end;

begin
  Result := false;
  ClientGroups.Clear;
  LangManLex := nil;
  List.Clear;
  if SpanClients.Components.Count > 0 then begin
    for SpanIndex := 0 to SpanClients.Components.Count - 1 do begin
      if SpanClients.Components.Items[SpanIndex] is TLangManCPC then begin
        AddGroup(SpanClients.Components.Items[SpanIndex]);
      end else if SpanClients.Components.Items[SpanIndex] is TLMList then begin
        if (SpanClients.Components.Items[SpanIndex] is TLangFormLexicon) then begin
          if Engine.TranslateLangMan AND (NOT LangFormLexicon.InternalLanguages(EditorLang, EditorISO, false))
            then LangManLex := SpanClients.Components.Items[SpanIndex];
        end else AddGroup(SpanClients.Components.Items[SpanIndex]);
      end;
    end;
    if LangManLex <> nil then AddGroup(LangManLex);  // LangMan na konec seznamu skupin
    Result := true;
  end;
end;

procedure TLangCoreData.LoadObjects(List: TStrings);
var OI: Integer;
    ObjName: String;
{$IFDEF LMSMART}
    ResTr: TCustomResourcesTranslator;
{$ENDIF}
begin
  List.Clear;
  if EditorMode = emClient then begin
    if WorkStruct.Count > 0 then begin
      for OI := 0 to WorkStruct.Count - 1 do begin
        ObjName := WorkStruct.ComponentName[OI];
        if (List.IndexOf(ObjName) < 0) then List.Add(ObjName);
      end;
    end;
{$IFDEF LMSMART}
  end else if EditorMode = emResources then begin
    ResTr := TCustomResourcesTranslator(ClientGroups.Items[SelectedClient]);
    if ResTr.List.UnsortedItemsExists then List.Add(ResTr.UnitList.GetNameEx(0));
    for OI := 1 to ResTr.UnitList.Count - 1 do List.Add(ResTr.UnitList.GetNameEx(OI));
{$ENDIF}
  end;
end;

procedure TLangCoreData.NewEditorPage(ObjectName: String; LMAdditionNames: array of String);
var II, SourceIndex: Integer;
    PropertyDesc: String;
{$IFDEF LMSMART}
    ItemDesc, LocStr: String;
    ResTr: TCustomResourcesTranslator;
    UnitNr: Integer;
{$ENDIF}
begin
  LastSearch := '';
  WorkIndexes.Clear;
  SourceIndexes.Clear;
  case EditorMode of
    emClient: begin
      if WorkStruct.Count > 0 then begin
        for II := 0 to WorkStruct.Count - 1 do begin
          if (ObjectName = '') OR (WorkStruct.ComponentName[II] = ObjectName) then begin
            WorkIndexes.AddWord(II);
            SourceIndex := SourceStruct.Find(II, WorkStruct);
            SourceIndexes.AddWord(SourceIndex);
            if ObjectName = '' then PropertyDesc := WorkStruct.ComponentName[II] + '.'
                               else PropertyDesc := '';
            PropertyDesc := PropertyDesc + WorkStruct.GetPropertyName(II, LMAdditionNames);

            if (WorkStruct.Changeable[II] and ca_YES) = ca_YES then begin
{$IFDEF LMSMART}
              if WorkStruct.IsGlobal(II) then begin
                AddEditorRow(PropertyDesc, GetGlobalTranslate(DesignedList.Get(II)));
              end else
{$ENDIF}
                AddEditorRow(PropertyDesc, WorkStruct.Translation[II]);
            end else begin
              AddEditorRow(PropertyDesc, SourceStruct.Translation[SourceIndex]);
//ntp                                    DesignedList.Get(II));
            end;
          end;
        end;
      end;
    end;

    emIndexedLexicon: begin
      for II := 0 to WorkLexicon.MaxIndex do begin
        if WorkLexicon.IsIncluded(II) then begin
          WorkIndexes.AddWord(II);
{$IFDEF LMSMART}
          if WorkLexicon.IsGlobal(II) then begin
            AddEditorRow('Item[' + IntToStr(II) + ']', GetGlobalTranslate(DesignedList.Get(II)));
          end else
{$ENDIF}
            AddEditorRow('Item[' + IntToStr(II) + ']', WorkLexicon.Get(II));
        end;
      end;
    end;

{$IFDEF LMSMART}
    emSmartLexicon: begin
      if WorkSmartLexicon.Count > 0 then begin
        for II := 0 to WorkSmartLexicon.MaxIndex do begin
          LocStr := WorkSmartLexicon.GetLocStr(II);
          ItemDesc := LocStr;
          ReplaceChars(ItemDesc, '=', '~');  // LangListEditor.Strings.NameValueSeparator = '='
          if WorkSmartLexicon.IsGlobal(II)
            then AddEditorRow('[' + #39 + ItemDesc + #39 + ']', GetGlobalTranslate(LocStr))
            else AddEditorRow('[' + #39 + ItemDesc + #39 + ']', WorkSmartLexicon.Get(II));
        end;
      end;
    end;

    emResources: begin
      if WorkSmartLexicon.Count > 0 then begin
        ResTr := TCustomResourcesTranslator(ClientGroups.Items[SelectedClient]);
        UnitNr := ResTr.UnitList.IndexOfName(ObjectName);
        if UnitNr >= 0 then begin
          for II := 0 to ResTr.List.Count - 1 do begin
            // Indexy WorkSmartLexicon a ResourcesTranslator nebudou odpovidat,
            //  pokud bude v ResourcesList vice stejnych DesignStrings, protoze
            //  se vlozi do SourceSmartLexicon a WorkSmartLexicon pouze jednou!
            //  Indexy mezi SourceSmartLexicon a WorkSmartLexicon by odpovidat mely.
            if ResTr.List.Info[II].UnitId = UnitNr then begin
              LocStr := ResTr.GetLocStr(II);
              SourceIndex := WorkSmartLexicon.Find(LocStr);
              if (SourceIndex >= 0) AND (WorkIndexes.IndexOfWord(SourceIndex) < 0) then begin
                // Resource Strings with duplicated DesignForm shall not be added
                WorkIndexes.AddWord(SourceIndex);
                ItemDesc := ResTr.List.Strings[II];
                ReplaceChars(ItemDesc, '=', '~');  // LangListEditor.Strings.NameValueSeparator = '='
                EncodeSpecialChars(ItemDesc);
                if WorkSmartLexicon.IsGlobal(SourceIndex)
                  then AddEditorRow(ItemDesc, GetGlobalTranslate(LocStr))
                  else AddEditorRow(ItemDesc, WorkSmartLexicon.Get(SourceIndex));
              end;
            end;
          end;
        end;
      end;
    end;
{$ENDIF}
  end;
  PageFromClient := SelectedClient;
end;

function TLangCoreData.ChangeEditorClient(ClientIndex: Integer): TEditorModes;
var LI, SI: Integer;
    LMList: TLMList;
    LocStr, LexName: String;
    LangDescent: Word;
{$IFDEF LMSMART}
    Translated, OLang: String;
    List: TResourcesList;
{$ENDIF}
begin
  StoreChanges;
  WorkLexicon.Clear;
  WorkStruct.Clear;
  DesignedList.Clear;
{$IFDEF LMSMART}
  WorkSmartLexicon.Clear;
{$ENDIF}

  Result := emIndexedLexicon;
  if ClientIndex < ClientGroups.Count then SelectedClient := ClientIndex
                                      else SelectedClient := -1;
  try
    if SelectedClient >= 0 then begin
      // Load Client items
      if ClientGroups.Items[SelectedClient] is TLangManCPC then begin
        Result := emClient;
        WorkStruct.Assign((ClientGroups.Items[SelectedClient] as TLangManCPC).DesignStruct);
        if WorkStruct.Count > 0 then begin
            for LI := 0 to WorkStruct.Count - 1 do begin
              DesignedList.Add(LI, WorkStruct.Translation[LI]);
              SI := DataStruct.Find(LI, WorkStruct);
              if SI >= 0 then WorkStruct.SetupLineBy(LI, SI, DataStruct, ca_CHANGED)
                         else begin
{$IFDEF LMSMART}
                if AllowedGlobals then SI := WorkGlobalLexicon.Find(WorkStruct.Translation[LI],
                                                                    TEMPORARY_GLOBAL_ITEM_DESCENT);  // no TEMPORARY_GLOBAL_ITEM_DESCENT find
                if SI >= 0 then begin
                  WorkStruct.Translation[LI] := WorkGlobalLexicon.Get(SI);
                  WorkStruct.Descent[LI] := GLOBAL_DESCENT_FLAG;
                end else begin
{$ENDIF}
                  SI := SourceStruct.Find(LI, WorkStruct);
                  if SI >= 0 then WorkStruct.SetupLineBy(LI, SI, SourceStruct);
{$IFDEF LMSMART}
                end;
{$ENDIF}
              end;
            end;
        end;
      end else begin
        LMList := TLMList(ClientGroups.Items[SelectedClient]);
        LexName := GetLexiconName(LMList);
{$IFDEF LMSMART}
        List := nil;
        if (LMList is TCustomResourcesTranslator) then begin
          Result := emResources;
          OLang := (LMList as TCustomResourcesTranslator).OriginalLanguage;
          if (Olang <> '') then begin
            if (CompareText(OLang, EditorLang) = 0) OR
               (IsISO1(OLang) AND (OLang = Engine.fCurrentLangISO)) then begin
              List := (LMList as TCustomResourcesTranslator).List;
            end;
          end;
        end;
 {$IFDEF LMULT}
        if (LMList is TCustomInlineLexicon) then Result := emSmartLexicon;
 {$ENDIF}
        if Result <> emIndexedLexicon then begin
          if LMList.MaxIndex >= 0 then begin
            for LI := 0 to LMList.MaxIndex do begin
              LocStr := LMList.GetLocStr(LI);
              Translated := LocStr;
              LangDescent := DESIGN_DESCENT;
              SI := SmartLexicon.FindTranslate(LexName, LocStr, LangDescent);
              if SI >= 0 then begin
                Translated := SmartLexicon.ReadItem(LexName, SI, LangDescent);
              end else begin
                if AllowedGlobals then begin
                  SI := WorkGlobalLexicon.Find(LocStr, TEMPORARY_GLOBAL_ITEM_DESCENT);  // no TEMPORARY_GLOBAL_ITEM_DESCENT find
                  if SI >= 0 then begin
                    Translated := WorkGlobalLexicon.Get(SI);
                    LangDescent := GLOBAL_DESCENT_FLAG;
                  end else if List <> nil then begin
                    SI := 0;
                    Translated := List.Strings[LI];
                    EncodeSpecialChars(Translated);
                    if Translated <> LocStr then begin
                      WorkGlobalLexicon.Add(LocStr, Translated, NEW_GLOBAL_ITEM_DESCENT);
                      LangDescent := GLOBAL_DESCENT_FLAG;
                    end else LangDescent := AUTO_LOADED_FROM_GLOBALS;
                  end;
                end else if List <> nil then begin
                  SI := 0;
                  Translated := List.Strings[LI];
                  EncodeSpecialChars(Translated);
                  LangDescent := AUTO_LOADED_FROM_GLOBALS;
                end;
                if SI < 0 then begin
                  SI := SourceSmartLexicon.FindTranslate(LexName, LocStr);
                  if SI >= 0 then Translated := SourceSmartLexicon.ReadItem(LexName, SI, LangDescent);
                end;
              end;
              WorkSmartLexicon.Add(LocStr, Translated, LangDescent);
            end;
          end;
        end else
{$ENDIF}
         if LMList.MaxIndex >= 0 then begin
          for LI := 0 to LMList.MaxIndex do begin
            if LMList.IsDefined(LI) then begin
              LocStr := LMList.GetLocStr(LI);
              DesignedList.Add(LI, LocStr);
              if DataLexicon.IsIncluded(LexName, LI) then begin
                LocStr := DataLexicon.ReadItem(LexName, LI, LangDescent);
              end else begin
{$IFDEF LMSMART}
                SI := -1;
                if AllowedGlobals then SI := WorkGlobalLexicon.Find(LocStr, TEMPORARY_GLOBAL_ITEM_DESCENT);  // no TEMPORARY_GLOBAL_ITEM_DESCENT find
                if SI >= 0 then begin
                  LocStr := WorkGlobalLexicon.Get(SI);
                  LangDescent := GLOBAL_DESCENT_FLAG;
                end else
{$ENDIF}
                  if SourceLexicon.IsIncluded(LexName, LI) then begin
                    LocStr := SourceLexicon.ReadItem(LexName, LI, LangDescent);
                  end else LangDescent := DESIGN_DESCENT;
              end;
              WorkLexicon.Add(LI, LocStr, LangDescent);
            end;
          end;
        end;
      end;
    end;
  finally
    EditorMode := Result;
  end;
end;

procedure TLangCoreData.StoreEditorPage;
var II, WI, SI: Integer;
    Changed, Descent, SourceDescent: Word;
    Content, CName: String;
    ItemChanged: Boolean;
begin
  if (SelectedClient >= 0) AND (PageFromClient = SelectedClient) then case EditorMode of
    emClient: begin
      if (WorkStruct.Count > 0) and (WorkIndexes.Count > 0) then begin
        for II := 0 to WorkIndexes.Count - 1 do begin
          WI := WorkIndexes.GetWord(II);
          Descent := WorkStruct.Descent[WI];
          Changed := WorkStruct.Changeable[WI];
          Content := GetEditorRow(II);
          SI := SourceIndexes.GetWord(II);
          ItemChanged := Content <> SourceStruct.Translation[SI];
          if (Content = '') OR ((Descent AND GLOBAL_DESCENT_FLAG) <> 0) then begin
            Changed := Changed AND (NOT ca_CHANGED);
          end else begin
            if ((Descent AND DESCENT_MASK) = 0) OR
               (((Changed XOR SourceStruct.Changeable[SI]) AND ca_YES) = ca_YES) then begin
              Changed := Changed OR ca_CHANGED;
            end else begin
              if ItemChanged OR (Content <> WorkStruct.Translation[WI]) OR
                 SourceStruct.IsGlobal(SI)
                then Changed := Changed OR ca_CHANGED
                else Changed := Changed AND (NOT ca_CHANGED);
            end;
          end;
          WorkStruct.Changeable[WI] := Changed;
          RememberCell(Content, WI, Descent, ItemChanged OR (NOT SourceStruct.IsGlobal(SI)));
        end;
      end;
    end;

    emIndexedLexicon: begin
      CName := ClientName;
      if (WorkIndexes.Count > 0) then begin
        for II := 0 to WorkIndexes.Count - 1 do begin
          WI := WorkIndexes.GetWord(II);
          Descent := WorkLexicon.LangDescent[WI];
          Content := GetEditorRow(II);
          ItemChanged := Content <> SourceLexicon.ReadItem(CName, WI, SourceDescent);
          if (Descent AND GLOBAL_DESCENT_FLAG) <> 0 then WorkLexicon.Write(WI, '')
                                                    else begin
            if ((Descent AND DESCENT_MASK) > 0) AND
               (NOT ItemChanged) AND
               ((SourceDescent AND GLOBAL_DESCENT_FLAG) = 0) AND
               (Content = WorkLexicon.Get(WI)) then Content := '';
          end;
          RememberCell(Content, WI, Descent, ItemChanged OR ((SourceDescent AND GLOBAL_DESCENT_FLAG) = 0));
        end;
      end;
    end;

{$IFDEF LMSMART}
    emSmartLexicon: begin
        CName := ClientName;
        for II := 0 to WorkSmartLexicon.Count - 1 do begin
          Descent := WorkSmartLexicon.LangDescent[II];
          Content := GetEditorRow(II);
          ItemChanged := Content <> SourceSmartLexicon.ReadItem(CName, II, SourceDescent);
          if (Descent AND GLOBAL_DESCENT_FLAG) <> 0 then WorkSmartLexicon.Write(II, '')
                                                    else begin
            if ((Descent AND DESCENT_MASK) > 0) AND
               (NOT ItemChanged) AND
               ((SourceDescent AND GLOBAL_DESCENT_FLAG) = 0) AND
               (Content = WorkSmartLexicon.Get(II)) then Content := '';
          end;
          RememberCell(Content, II, Descent, ItemChanged OR ((SourceDescent AND GLOBAL_DESCENT_FLAG) = 0));
        end;
    end;

    emResources: begin
        CName := ClientName;
        for II := 0 to WorkIndexes.Count - 1 do begin
          WI := WorkIndexes.GetWord(II);
          Content := GetEditorRow(II);
          ItemChanged := Content <> SourceSmartLexicon.ReadItem(CName, WI, SourceDescent);
          RememberCell(Content, WI, WorkSmartLexicon.LangDescent[WI], ItemChanged OR ((SourceDescent AND GLOBAL_DESCENT_FLAG) = 0));
        end;
    end;
{$ENDIF}
  end;
end;

procedure TLangCoreData.StoreGroup;
var II, SI: Integer;
    LexName: string;
{$IFDEF LMSMART}
    Content, LocStr: String;
    Descent, SourceDescent: Word;
{$ENDIF}
begin
    if (SelectedClient >= 0) AND (PageFromClient = SelectedClient) then begin
      case EditorMode of
        emClient: begin
          if WorkStruct.Count > 0 then begin
            for II := 0 to WorkStruct.Count - 1 do begin
              SI := DataStruct.Find(II, WorkStruct);
              if ca_CHANGED = (WorkStruct.Changeable[II] and ca_CHANGED) then begin
                if SI >= 0 then DataStruct.SetupLineBy(SI, II, WorkStruct)
                           else DataStruct.Copy(II, WorkStruct);
              end else if SI >= 0 then DataStruct.DeleteLine(SI);
            end;
          end;
        end;

        emIndexedLexicon: begin
          if WorkLexicon.Count > 0 then begin
            LexName := ClientName;
            DataLexicon.NewLexicon(LexName);
            for II := 0 to WorkLexicon.MaxIndex do begin
              if WorkLexicon.IsIncluded(II) then begin
                if (WorkLexicon.Get(II) <> '')
                  then DataLexicon.WriteItem(LexName, II, WorkLexicon.Get(II))
                  else DataLexicon.RemoveItem(LexName, II);
              end;
            end;
          end;
        end;

{$IFDEF LMSMART}
        emSmartLexicon: begin
          if WorkSmartLexicon.Count > 0 then begin
            LexName := ClientName;
            SmartLexicon.NewLexicon(LexName);
            for II := 0 to WorkSmartLexicon.MaxIndex do begin
              LocStr := WorkSmartLexicon.GetLocStr(II);
              Content := WorkSmartLexicon.Get(II);
              if Content <> '' then SmartLexicon.WriteItem(LexName, LocStr, Content)
                               else SmartLexicon.RemoveItem(LexName, LocStr);
            end;
          end;
        end;

        emResources: begin
          if WorkSmartLexicon.Count > 0 then begin
            LexName := ClientName;
            SmartLexicon.NewLexicon(LexName);
            for II := 0 to WorkSmartLexicon.MaxIndex do begin
              Descent := WorkSmartLexicon.LangDescent[II];
              LocStr := WorkSmartLexicon.GetLocStr(II);
              if (Descent AND GLOBAL_DESCENT_FLAG) <> 0 then SmartLexicon.RemoveItem(LexName, LocStr)
                                                        else begin
                Content := WorkSmartLexicon.Get(II);
                if ((Content = '') OR ((Descent AND DESCENT_MASK) > 0) AND
   (Content = SourceSmartLexicon.ReadItem(LexName, II, SourceDescent)) AND
                         ((SourceDescent AND GLOBAL_DESCENT_FLAG) = 0))
                  then SmartLexicon.RemoveItem(LexName, LocStr)
                  else SmartLexicon.WriteItem(LexName, LocStr, Content);
              end;
            end;
          end;
        end;
{$ENDIF}
      end;
    end;
end;

procedure TLangCoreData.StoreChanges;
begin
  StoreEditorPage;
  StoreGroup;
end;

function TLangCoreData.SearchWord(const Searched: String; StartRow: Integer; Mode: TEditorSearchMode): Boolean;
var slc, lcbuf: String;
    I, SearchStop, SearchReset: Integer;

  function SearchInString(substr, str: String; SearchCol: TEditorSearch): Boolean;
  var found: Integer;
  begin
    Result := false;
    if (substr = '') OR (Length(str) < Length(substr)) then Exit;
{$IFDEF NEXTGEN}
    found := str.IndexOf(substr);
{$ELSE}
    found := Pos(substr, str) - 1;
{$ENDIF}
    if found >= 0 then begin
      EditorSelect(I, found, Length(substr), SearchCol);
      Result := true;
    end;
  end;

begin
  Result := false;
  SearchReset := GetEditorRowsCount;
  if (SearchReset > 0) AND (Searched <> '') then begin
    slc := LangManSys.LowerCase(Searched);
    I := StartRow;
    if I < 0 then I := 0;
    if LastSearch = Searched then Inc(I);
    if I >= SearchReset then I := 0;
    SearchStop := I;
    repeat
      if seItem in Mode then begin
        lcbuf := GetEditorRow(I);
        Result := SearchInString(Searched, lcbuf, seItem);
        if Result then Break;
        Result := SearchInString(slc, LangManSys.LowerCase(lcbuf), seItem);
        if Result then Break;
      end;
      if seSource in Mode then begin
        lcbuf := GetSourceForEditorItem(I);
        Result := SearchInString(Searched, lcbuf, seSource);
        if Result then Break;
        Result := SearchInString(slc, LangManSys.LowerCase(lcbuf), seSource);
        if Result then Break;
      end;
      if (seOriginal in Mode) AND
         ((NOT (seSource in Mode)) OR
          (CurrentSuperiorLang.Name <> Engine.DesignLanguageName)) then begin
        lcbuf := GetOriginalForEditorItem(I);
        Result := SearchInString(Searched, lcbuf, seOriginal);
        if Result then Break;
        Result := SearchInString(slc, LangManSys.LowerCase(lcbuf), seOriginal);
      end;
      Inc(I);
      if I >= SearchReset then I := 0;
    until Result OR (I = SearchStop);
  end;
  LastSearch := Searched;
end;

function TLangCoreData.AllowedGlobals: Boolean;
begin
{$IFDEF LMSMART}
  if (SelectedClient >= 0) AND
     (ClientGroups.Count > SelectedClient) AND
     (ClientGroups.Items[SelectedClient] is TLangManComponent)
    then Result := (ClientGroups.Items[SelectedClient] as TLangManComponent).GlobalLexicon
    else
{$ENDIF}
         Result := false;
end;

function TLangCoreData.GetEditorRowsCount: Integer;
begin
  Result := WorkIndexes.Count;
{$IFDEF LMSMART}
  if (EditorMode <> emResources) AND (WorkSmartLexicon.Count > Result)
    then Result := WorkSmartLexicon.Count;
{$ENDIF}
end;

function TLangCoreData.ChangeableEditorItem(Row: Integer): Boolean;
var SIndex: Integer;
begin
  SIndex := -1;
  if (Row >= 0) AND (Row < WorkIndexes.Count) then SIndex := WorkIndexes.GetWord(Row);
  if (SIndex >= 0) AND (SIndex < WorkStruct.Count) then begin
    Result := ((WorkStruct.Changeable[SIndex] AND ca_YES) = ca_YES);
  end else Result := true;
end;

function TLangCoreData.ClientName(ClientIndex: Integer = -1): String;
begin
  Result := '';
  if ClientIndex < 0 then ClientIndex := SelectedClient;
  if ClientIndex < ClientGroups.Count then Result := GetSpanComponentName(ClientGroups.Items[ClientIndex]);
end;

function TLangCoreData.GetItemColor(ItemDescent: Word; NoTrans: Boolean): Longword;
begin
  if ItemDescent = DESIGN_DESCENT then Result := CL_DESIGNED_FORM
                                  else begin
    if ItemDescent < DESIGN_DESCENT then begin
      if NoTrans then Result := CL_NOTRANS
                 else Result := CL_UNCHANGED_LOCAL;
    end else Result := CL_UNCHANGED_GLOBAL;
  end;
end;

function TLangCoreData.GetItemColor(ItemDescent: Word; ItemContent, Original: String): Longword;
begin
  if (ItemContent = '') then begin
    if (ItemDescent AND DESCENT_MASK) = 0 then begin
      if (ItemDescent AND GLOBAL_DESCENT_FLAG) <> 0 then Result := CL_GLOBAL_REMOVED_ITEM
                                                    else Result := CL_REMOVED_ITEM;
    end else begin
      if ItemDescent <= DESIGN_DESCENT then Result := CL_NONE_LOCAL
                                       else Result := CL_NONE_GLOBAL;
    end;
  end else begin
    if ((ItemDescent AND DESCENT_MASK) = 0) OR (ItemContent <> Original) then begin
      if ItemDescent <= DESIGN_DESCENT then begin
        if Original = '' then Result := CL_OLDITEM  // obsolete
                         else Result := CL_TRANSLATED_LOCAL;
      end else Result := CL_TRANSLATED_GLOBAL;
    end else begin
      if ItemDescent = DESIGN_DESCENT then Result := CL_DESIGNED_FORM
                                      else begin
        if ItemDescent < DESIGN_DESCENT then Result := CL_UNCHANGED_LOCAL
                                        else Result := CL_UNCHANGED_GLOBAL;
      end;
    end;
  end;
end;

function TLangCoreData.GetItemColor(EditorIndex: Integer; ObjectName, CurrentString: String): Longword;
var ChangeableBuf, Descent, SrcDescent: Word;
    WorkIndex: Integer;
    SourceString: String;
begin
  Result := CL_NONE;
  if PageFromClient <> SelectedClient then Exit;
  case EditorMode of
    emClient: begin
      if (WorkStruct.Count > 0) and (SourceIndexes.Count > 0) then begin
        WorkIndex := WorkIndexes.GetWord(EditorIndex);
        ChangeableBuf := WorkStruct.Changeable[WorkIndex];
        if (ca_OLD = (ChangeableBuf and ca_OLD)) then begin
          if (CurrentString <> WorkStruct.Translation[WorkIndex]) then begin
            WorkStruct.Changeable[WorkIndex] := ChangeableBuf and (NOT ca_OLD);
            Result := CL_TRANSLATED_LOCAL;
          end else Result := CL_OLDTRANS;
        end else begin
          if (ChangeableBuf AND ca_YES) = ca_YES then begin
            Descent := WorkStruct.Descent[WorkIndex];
            WorkIndex := SourceIndexes.GetWord(EditorIndex);

{$IFDEF LMSMART}
            if (Descent AND GLOBAL_DESCENT_FLAG) > (SourceStruct.Descent[WorkIndex] AND GLOBAL_DESCENT_FLAG)
              then Result := GetItemColor(Descent, CurrentString, GetGlobalSource(DesignedList.Get(WorkIndex)))
              else
{$ENDIF}
                   Result := GetItemColor(Descent, CurrentString, SourceStruct.Translation[WorkIndex]);

          end else Result := CL_NOTRANS;
        end;
      end;
    end;

    emIndexedLexicon: begin
      if (WorkIndexes.Count > 0) then begin
        WorkIndex := WorkIndexes.GetWord(EditorIndex);
        Descent := WorkLexicon.LangDescent[WorkIndex];
        SourceString := SourceLexicon.ReadItem(ObjectName, WorkIndex, SrcDescent);
{$IFDEF LMSMART}
        if (Descent AND GLOBAL_DESCENT_FLAG) > (SrcDescent AND GLOBAL_DESCENT_FLAG)
          then SourceString := GetGlobalSource(DesignedList.Get(WorkIndex));
{$ENDIF}
        Result := GetItemColor(Descent, CurrentString, SourceString);
      end;
    end;

{$IFDEF LMSMART}
    emSmartLexicon, emResources: begin
      if (EditorMode = emSmartLexicon) OR (WorkIndexes.Count > EditorIndex) then begin
        if EditorMode = emResources then WorkIndex := WorkIndexes.GetWord(EditorIndex)
                                    else WorkIndex := EditorIndex;

        Descent := WorkSmartLexicon.LangDescent[WorkIndex];
        SourceString := SourceSmartLexicon.ReadItem(ObjectName, WorkIndex, SrcDescent);
        if (Descent AND GLOBAL_DESCENT_FLAG) > (SrcDescent AND GLOBAL_DESCENT_FLAG)
          then SourceString := GetGlobalSource(SourceSmartLexicon.GetLocStr(ObjectName, WorkIndex));
        Result := GetItemColor(Descent, CurrentString, SourceString);
      end;
    end;
{$ENDIF}
  end;
end;

function TLangCoreData.GetColorHint(Color: Longword): String;
var LegendItem: Integer;
begin
  case Color of
    CL_DESIGNED_FORM: LegendItem := 1;
    CL_UNCHANGED_LOCAL: LegendItem := 2;
    CL_UNCHANGED_GLOBAL: LegendItem := 3;
    CL_TRANSLATED_LOCAL: LegendItem := 4;
    CL_TRANSLATED_GLOBAL: LegendItem := 5;
    CL_REMOVED_ITEM: LegendItem := 6;
    CL_GLOBAL_REMOVED_ITEM: LegendItem := 18;
    CL_OLDTRANS: LegendItem := 7;
    CL_NOTRANS: LegendItem := 8;
    CL_NONE, CL_NONE_LOCAL, CL_NONE_GLOBAL: LegendItem := 9;
    else LegendItem := -1;
  end;
  if LegendItem > 0 then Result := EditorLex[30 + LegendItem]
                    else Result := '';
end;

procedure TLangCoreData.RememberCell(Content: string; WorkIndex: Integer; Descent: Word; SaveNewGlobals: Boolean = false);
begin
  if (Descent AND GLOBAL_DESCENT_FLAG) = 0 then begin
    case EditorMode of
      emClient: WorkStruct.Translation[WorkIndex] := Content;
      emIndexedLexicon: WorkLexicon.Write(WorkIndex, Content, Descent);
{$IFDEF LMSMART}
      emSmartLexicon,
      emResources: WorkSmartLexicon.Write(WorkIndex, Content, Descent);
{$ENDIF}
    end;
  end else begin
{$IFDEF LMSMART}
    case EditorMode of
      emClient,
      emIndexedLexicon: WorkGlobalLexicon.SaveChangedGlobalItem(DesignedList.Get(WorkIndex), Content, SaveNewGlobals);
      emSmartLexicon,
      emResources: WorkGlobalLexicon.SaveChangedGlobalItem(WorkSmartLexicon.GetLocStr(WorkIndex), Content, SaveNewGlobals);
    end;
{$ENDIF}
  end;
end;

function TLangCoreData.SwitchEditorItem(EditorItem: Integer; Content: String; var AllowNoTrans: Boolean; out NewText: String): Boolean;
var WorkIndex: Integer;
    Changed, Descent: Word;
begin
  Result := false;
  case EditorMode of
    emClient: begin
      WorkIndex := WorkIndexes.GetWord(EditorItem);
      Changed := WorkStruct.Changeable[WorkIndex];
      Descent := WorkStruct.Descent[WorkIndex];
      if (Changed AND ca_YES) = ca_NO then begin
        Changed := ca_YES;
        WorkStruct.Changeable[WorkIndex] := Changed;
        AllowNoTrans := false;
      end else begin
        RememberCell(Content, WorkIndex, Descent);
        // switch
        if AllowNoTrans OR (AllowedGlobals = false) then begin
          Changed := ca_NO;
          WorkStruct.Changeable[WorkIndex] := Changed;
          NewText := SourceStruct.Translation[SourceIndexes.GetWord(EditorItem)];
        end else AllowNoTrans := true;
        if AllowedGlobals then begin
          Descent := Descent XOR GLOBAL_DESCENT_FLAG;
          WorkStruct.Descent[WorkIndex] := Descent;
        end;
      end;
      if Changed > ca_NO then begin
{$IFDEF LMSMART}
        if (Descent AND GLOBAL_DESCENT_FLAG) <> 0 then begin
          NewText := GetGlobalTranslate(DesignedList.Get(WorkIndex));
          if NewText = '' then begin
            NewText := Content;
            if NewText = SourceStruct.Translation[SourceIndexes.GetWord(EditorItem)] then NewText := '';
          end;
        end else begin
{$ENDIF}
          NewText := WorkStruct.Translation[WorkIndex];
          if NewText = '' then NewText := SourceStruct.Translation[SourceIndexes.GetWord(EditorItem)];
{$IFDEF LMSMART}
        end;
{$ENDIF}
      end;
      Result := true;
    end;

{$IFDEF LMSMART}
    emIndexedLexicon: begin
      if AllowedGlobals then begin
        WorkIndex := WorkIndexes.GetWord(EditorItem);
        Descent := WorkLexicon.LangDescent[WorkIndex];
        RememberCell(Content, WorkIndex, Descent);
        // switch
        Descent := Descent XOR GLOBAL_DESCENT_FLAG;
        WorkLexicon.LangDescent[WorkIndex] := Descent;
        if (Descent AND GLOBAL_DESCENT_FLAG) <> 0 then begin
          NewText := GetGlobalTranslate(DesignedList.Get(WorkIndex));
          if NewText = '' then begin
            NewText := Content;
            if NewText = SourceLexicon.ReadItem(ClientName, WorkIndex) then NewText := '';
          end;
        end else begin
          NewText := WorkLexicon.Get(WorkIndex);
          if NewText = '' then NewText := SourceLexicon.ReadItem(ClientName, WorkIndex);
        end;
        Result := true;
      end;
    end;

    emSmartLexicon, emResources: begin
      if AllowedGlobals then begin
        if EditorMode = emResources then WorkIndex := WorkIndexes.GetWord(EditorItem)
                                    else WorkIndex := EditorItem;

        Descent := WorkSmartLexicon.LangDescent[WorkIndex];
        RememberCell(Content, WorkIndex, Descent);
        // switch
        Descent := Descent XOR GLOBAL_DESCENT_FLAG;
        WorkSmartLexicon.LangDescent[WorkIndex] := Descent;
        if (Descent AND GLOBAL_DESCENT_FLAG) <> 0 then begin
          NewText := GetGlobalTranslate(WorkSmartLexicon.GetLocStr(WorkIndex));
          if NewText = '' then begin
            NewText := Content;
            if NewText = SourceSmartLexicon.ReadItem(ClientName, WorkIndex) then NewText := '';
          end;
        end else begin
          NewText := WorkSmartLexicon.Get(WorkIndex);
          if NewText = '' then NewText := SourceSmartLexicon.ReadItem(ClientName, WorkIndex);
        end;
        Result := true;
      end;
    end;
{$ENDIF}
  end;
end;

function TLangCoreData.GetOriginalForEditorItem(EditorItem: Integer): String;
begin
  Result := '';
  case EditorMode of
    emClient: Result := DesignedList.Get(WorkIndexes.GetWord(EditorItem));
    emIndexedLexicon: Result := DesignedList.Get(WorkIndexes.GetWord(EditorItem));
{$IFDEF LMSMART}
    emSmartLexicon: Result := WorkSmartLexicon.GetLocStr(EditorItem);
    emResources: Result := WorkSmartLexicon.GetLocStr(WorkIndexes.GetWord(EditorItem));
{$ENDIF}
  end;
end;

function TLangCoreData.GetSourceForEditorItem(EditorItem: Integer): String;
begin
  Result := '';
  case EditorMode of
    emClient: Result := SourceStruct.Translation[SourceIndexes.GetWord(EditorItem)];
    emIndexedLexicon: Result := SourceLexicon.ReadItem(ClientName, WorkIndexes.GetWord(EditorItem));
{$IFDEF LMSMART}
    emSmartLexicon: Result := SourceSmartLexicon.ReadItem(ClientName, EditorItem);
    emResources: Result := SourceSmartLexicon.ReadItem(ClientName, Integer(WorkIndexes.GetWord(EditorItem)));
{$ENDIF}
  end;
end;

function TLangCoreData.SelectEditorItem(EditorItem: Integer; SameLocStr: TWordList; out SourceColor: Longword): String;
var NoTrans: Boolean;
    Descent: Word;
    SourceIndex: Integer;
{$IFDEF LMSMART}
    SI: Integer;
    CName, LocStr: String;
{$ENDIF}

  procedure IndexedSameLocStr;
  var SI: Integer;
      LocStr: String;
  begin
    if Assigned(SameLocStr) then begin
      SameLocStr.Clear;
      if AllowedGlobals then begin
        LocStr := DesignedList.Get(WorkIndexes.GetWord(EditorItem));
        for SI := 0 to WorkIndexes.Count - 1 do if EditorItem <> SI then begin
          if LocStr = DesignedList.Get(WorkIndexes.GetWord(SI)) then SameLocStr.AddWord(SI);
        end;
      end;
    end;
  end;

begin
  LastSearch := '';
  Descent := 0;
  NoTrans := true;
  Result := '';
  case EditorMode of
    emClient: begin
      // source string
      SourceIndex := SourceIndexes.GetWord(EditorItem);
      Result := SourceStruct.Translation[SourceIndex];
      Descent := SourceStruct.Descent[SourceIndex];
      NoTrans := (SourceStruct.Changeable[SourceIndex] AND ca_YES) = ca_NO;
      // SameLocStr
      IndexedSameLocStr;
    end;

    emIndexedLexicon: begin
      // source string
      Result := SourceLexicon.ReadItem(ClientName, WorkIndexes.GetWord(EditorItem), Descent);
      NoTrans := false;
      // SameLocStr
      IndexedSameLocStr;
    end;

{$IFDEF LMSMART}
    emSmartLexicon, emResources: begin
      // source string
      CName := ClientName;
      if EditorMode = emResources then SI := WorkIndexes.GetWord(EditorItem)
                                  else SI := EditorItem;

      Result := SourceSmartLexicon.ReadItem(CName, SI, Descent);
      NoTrans := false;
      // SameLocStr
      if Assigned(SameLocStr) then begin
        SameLocStr.Clear;
        if AllowedGlobals then begin
          LocStr := SourceSmartLexicon.GetLocStr(CName, SI);
          for SI := 0 to GetEditorRowsCount - 1 do if EditorItem <> SI then begin
            if EditorMode = emResources then begin
              if LocStr = SourceSmartLexicon.GetLocStr(CName, WorkIndexes.GetWord(SI))
                then SameLocStr.AddWord(SI);
            end else begin
              if LocStr = SourceSmartLexicon.GetLocStr(CName, SI)
                then SameLocStr.AddWord(SI);
            end;
          end;
        end;
      end;
    end;
{$ENDIF}
  end;
  SourceColor := GetItemColor(Descent, NoTrans);
end;

function TLangCoreData.IsUntranslated(ClientName, ObjectName: String): Boolean;
var II: Integer;
    Source, Current: String;
{$IFDEF LMSMART}
    UnitNr: Integer;
    ResTr: TCustomResourcesTranslator;
{$ENDIF}

{$IFDEF LMSMART}
  procedure GlobalItem;
  var GI: Integer;
  begin
    GI := WorkGlobalLexicon.Find(Source, TEMPORARY_GLOBAL_ITEM_DESCENT);  // no TEMPORARY_GLOBAL_ITEM_DESCENT find
    if GI >= 0 then begin
      // Pozn.: pokud se polozka nachazi ve WorkGlobalLexiconu, je automaticky klasifikovana
      //  jako prelozena (pokud Current <> ''), protoze musi byt descent <= 1
      Current := WorkGlobalLexicon.Get(GI);
      Source := '';
//viz poznamka      GI := SourceSmartLexicon.FindTranslate(Source);
//      if GI >= 0 then Source := SourceSmartLexicon.ReadItem(Source);
    end else Current := '';
  end;
{$ENDIF}

begin
  Result := false;
  case EditorMode of
    emClient: begin
      if WorkStruct.Count > 0 then begin
        for II := 0 to WorkStruct.Count - 1 do begin
          if ((ObjectName = '') OR (WorkStruct.ComponentName[II] = ObjectName)) and
             ((WorkStruct.Changeable[II] and ca_YES) = ca_YES) then begin

            if (ca_OLD = (WorkStruct.Changeable[II] and ca_OLD)) then begin
              Result := true;
              Exit;
            end;

{$IFDEF LMSMART}
            if WorkStruct.IsGlobal(II) then begin
              Source := DesignedList.Get(II);
              GlobalItem;
            end else begin
{$ENDIF}
              if (WorkStruct.Descent[II] AND DESCENT_MASK) = 0 then Continue;
              Current := WorkStruct.Translation[II];
              Source := SourceStruct.GetString(II, WorkStruct);
{$IFDEF LMSMART}
            end;
{$ENDIF}
            if (Current = '') OR (Source = Current) then begin
              Result := true;
              Exit;
            end;
          end;
        end;
      end;
    end;

    emIndexedLexicon: begin
      for II := 0 to WorkLexicon.MaxIndex do begin
        if WorkLexicon.IsIncluded(II) then begin
{$IFDEF LMSMART}
          if WorkLexicon.IsGlobal(II) then begin
            Source := DesignedList.Get(II);
            GlobalItem;
          end else begin
{$ENDIF}
            if (WorkLexicon.LangDescent[II] AND DESCENT_MASK) = 0 then Continue;
            Current := WorkLexicon.Get(II);
            Source := SourceLexicon.ReadItem(ClientName, II);

{$IFDEF LMSMART}
          end;
{$ENDIF}
          if (Current = '') OR (Source = Current) then begin
            Result := true;
            Exit;
          end;
        end;
      end;
    end;

{$IFDEF LMSMART}
    emSmartLexicon: begin
      for II := 0 to WorkSmartLexicon.Count - 1 do begin
        if WorkSmartLexicon.IsGlobal(II) then begin
          Source := WorkSmartLexicon.GetLocStr(II);
          GlobalItem;
        end else begin
          if (WorkSmartLexicon.LangDescent[II] AND DESCENT_MASK) = 0 then Continue;
          Current := WorkSmartLexicon.Get(II);
          Source := SourceSmartLexicon.ReadItem(ClientName, II);
        end;
        if (Current = '') OR (Source = Current) then begin
          Result := true;
          Exit;
        end;
      end;
    end;

    emResources: begin
      ResTr := TCustomResourcesTranslator(ClientGroups.Items[SelectedClient]);
      UnitNr := ResTr.UnitList.IndexOfName(ObjectName);
      if UnitNr >= 0 then begin
        for II := 0 to WorkSmartLexicon.Count - 1 do begin
          // Pokud se bude shodovat nekolik DesignStrings ResourceTranslatoru, nebudou
          // odpovidat indexy translatoru s polozkami v SourceSmartLexicon a WorkSmartLexicon.
          // Indexy mezi SourceSmartLexicon a WorkSmartLexicon by odpovidat mely.
          if ResTr.FindItem(UnitNr, WorkSmartLexicon.GetLocStr(II)) then begin
            if WorkSmartLexicon.IsGlobal(II) then begin
              Source := WorkSmartLexicon.GetLocStr(II);
              GlobalItem;
            end else begin
              if (WorkSmartLexicon.LangDescent[II] AND DESCENT_MASK) = 0 then Continue;
              Current := WorkSmartLexicon.Get(II);
              Source := SourceSmartLexicon.ReadItem(ClientName, II);
            end;
            if (Current = '') OR (Source = Current) then begin
              Result := true;
              Exit;
            end;
          end;
        end;
      end;
    end;
{$ENDIF}
  end;
end;

//+****************************************************************************
//+*  LangMan Flag List                                                      **
//+****************************************************************************

constructor TFlagsList.Create;
begin
  inherited Create;
{$IFDEF DXE2}
  Flags := TObjectList<TMemoryStream>.Create(true);
{$ELSE}
  Flags := TObjectList.Create;
{$ENDIF}
  Flags.OwnsObjects := true;
end;
destructor TFlagsList.Destroy;
begin
  Flags.Free;
  inherited Destroy;
end;
function TFlagsList.GetFlagStream(Index: Integer): TMemoryStream;
begin
  if Index < Count then begin
    Result := TMemoryStream(Flags.Items[Index]);
    Result.Position := 0;
  end else repeat
    Result := NewFlag;
  until Index < Count;
end;
function TFlagsList.Count: Integer;
begin
  Result := Flags.Count;
end;
procedure TFlagsList.ClearFlags;
begin
  Flags.Clear;
end;
function TFlagsList.NewFlag: TMemoryStream;
begin
  Result := TMemoryStream.Create;
  Flags.Add(Result);
end;
function TFlagsList.Present(FlagIndex: Integer): Boolean;
begin
  Result := false;
  if (FlagIndex >= 0) AND (FlagIndex < Flags.Count) then begin
    if (Flags.Items[FlagIndex] as TMemoryStream).Size > 10 then Result := true;
  end;
end;

//+****************************************************************************
//+*  TLangManCore methods                                                   **
//+****************************************************************************

function TLangManCore.EngineLoaded: Boolean;
begin
  Result := IsFullyCreated AND (NOT ((csLoading in ComponentState) OR (csReading in ComponentState)));
end;

function TLangManCore.GetCurrentLangISO: String;
begin
  IsISO1(fCurrentLangISO);
  Result := fCurrentLangISO;
end;

procedure TLangManCore.SetDesignLangISOCode(Input: string);
var OldISO: TISOCode;
begin
  OldISO := fDesignLangISOCode;
  with LData do begin
    DesignLangISO := Input;
    IsISO1(DesignLangISO);
    if DesignTime then fDesignLangISOCode := Input
                  else fDesignLangISOCode := DesignLangISO;
    if LangCodes.Count > 0 then LangCodes.Strings[0] := DesignLangISO;
    if (fCurrentLanguage = fDesignLanguage) then fCurrentLangISO := DesignLangISO;
  end;
  if (Length(Input) > 3) AND (LastAutoLangName = fDesignLanguage) then begin
    LastAutoLangName := SeparateLangName(Input);
    SetDesignLang(LastAutoLangName);
  end;
  if (OldISO <> fDesignLangISOCode) then begin
    TranslateLangForm(fCurrentLanguage, fCurrentLangISO, true);
    if IsInitialized AND (LangEditorVisible OR LangCreatorVisible) then RecreateLangMenus;
  end;
end;

procedure TLangManCore.SetDesignLang(Input: TLanguage);
var NewName, OldName: TLanguage;
begin
  if Input <> '' then NewName := Input
                 else NewName := DEFAULT_DESIGN_LANGUAGE;
  OldName := fDesignLanguage;
  fDesignLanguage := NewName;
  if fCurrentLanguage = OldName then begin
    fCurrentLanguage := NewName;
    fCurrentLangISO := LData.DesignLangISO;
  end;
  if fDefaultLanguage = OldName then fDefaultLanguage := NewName;
  if OldName <> NewName then begin
    TranslateLangForm(fCurrentLanguage, fCurrentLangISO, true);
    FindLangFiles;
  end;
end;

function TLangManCore.GetDefaultLanguage: String;
begin
  if DesignTime then begin
    DT_EngineOptions.Subdir := fLangSubdir;
    DT_EngineOptions.DesignLang := fDesignLanguage;
    DT_EngineOptions.LangFileExt := fLangFileExt;
    DT_EngineOptions.LangFileSign := fLangFileSign;
  end;
  Result := fDefaultLanguage;
end;

procedure TLangManCore.SetDefaultLanguage(Input: String);
begin
  if fDefaultLanguage <> Input then begin
    if IsInitialized AND (NOT DesignTime) AND (fDefaultLanguage <> '') AND
       ((fCurrentLanguage = fDefaultLanguage) OR
        (fCurrentLangISO = fDefaultLanguage)) then begin
      fDefaultLanguage := Input;
      Translate(Input);
    end else fDefaultLanguage := Input;
  end;
end;

procedure TLangManCore.SetLangSubdir(Input: string);
begin
  if fLangSubdir <> Input then begin
    fLangSubdir := Trim(Input);
    FindLangFiles;
  end;
end;

procedure TLangManCore.SetLangFileExt(Input: string);
begin
  if fLangFileExt <> Input then begin
    if Input <> '' then begin
      fLangFileExt := Input;
{$IFDEF NEXTGEN}
      if Input[0] <> '.' then
{$ELSE}
      if Input[1] <> '.' then
{$ENDIF}
        fLangFileExt := '.' + Input
    end else fLangFileExt := '';
    FindLangFiles;
  end;
end;

procedure TLangManCore.SetLangFileSign(Sign: string);
begin
  if fLangFileSign <> Sign then begin
    fLangFileSign := Sign;
    FindLangFiles;
  end;
end;

function TLangManCore.GetLangCreatorVisible: Boolean;
begin
  if EditorDisabled AND NOT DesignTime then Result := false
                                       else Result := fLangCreatorVisible;
end;

procedure TLangManCore.SetLangCreatorVisible(Enable: Boolean);
begin
  if fLangCreatorVisible <> Enable then begin
    fLangCreatorVisible := Enable;
    if NOT EditorDisabled then ReCreateLangMenus;
  end;
end;

function TLangManCore.GetLangEditorVisible: Boolean;
begin
  if EditorDisabled AND NOT DesignTime then Result := false
                                       else Result := fLangEditorVisible;
end;

procedure TLangManCore.SetLangEditorVisible(Enable: Boolean);
begin
  if fLangEditorVisible <> Enable then begin
    fLangEditorVisible := Enable;
    if NOT EditorDisabled then ReCreateLangMenus;
  end;
end;

procedure TLangManCore.SetIncludeLangMan(Input: Boolean);
begin
  fIncludeLangMan := Input;
end;

procedure TLangManCore.SetLangMenuFlags(Input: Boolean);
begin
  fLangMenuFlags := Input;
end;

procedure TLangManCore.SetLangResources(ResLangs: TStringList);
begin
  fLangResources.Assign(ResLangs);
  FindLangFiles;
end;

procedure TLangManCore.SetLangResourcesAllowEdit(Enable: Boolean);
var CurrentLI: Integer;
    CurrentFile: String;
begin
  if fAllowEditInternalLangs <> Enable then begin
    fAllowEditInternalLangs := Enable;
    if EngineLoaded then begin
      CurrentLI := LData.Languages.IndexOf(fCurrentLanguage);
      if CurrentLI >= 0 then CurrentFile := LData.FileNames.Strings[CurrentLI];
      FindLangFiles;
      if IsInitialized then begin
        if CurrentLI >= 0 then CurrentLI := LData.Languages.IndexOf(fCurrentLanguage);
        if CurrentLI >= 0 then begin
          if CurrentFile <> LData.FileNames.Strings[CurrentLI] then begin
            Translate(fCurrentLanguage);
          end;
        end;
      end;
    end;
  end;
end;

function TLangManCore.GetCookieLifeDays: Double;
begin
  if CookieEnabled AND (fCookieLifeDays <= 0) then Result := DEFAULT_COOKIE_LIFEDAYS
                                              else Result := fCookieLifeDays;
end;

procedure TLangManCore.SetCookieLifeDays(CookieLifeTime: Double);
begin
  if CookieLifeTime = DEFAULT_COOKIE_LIFEDAYS then CookieLifeTime := 0;
  if fCookieLifeDays <> CookieLifeTime then begin
    fCookieLifeDays := CookieLifeTime;
    RememberLanguage(fCurrentLanguage);
  end;
end;

function TLangManCore.GetCurrentLanguage: String;
begin
  if DesignTime then Result := fDesignLanguage
                else Result := fCurrentLanguage;
end;

procedure TLangManCore.SetCurrentLanguage(LangNameOrISO: String);
begin
  if (LangNameOrISO <> GetCurrentLangISO) AND
     (LangNameOrISO <> fCurrentLanguage) then Translate(LangNameOrISO);
end;

function TLangManCore.GetDefaultCookieID: String;
begin
  Result := Name;
  if Assigned(Owner) then Result := Result + '&' + Owner.Name;
end;

function TLangManCore.GetCookieName: String;
begin
  if (fCookieName = '') AND CookieEnabled then Result := GetDefaultCookieID
                                          else Result := fCookieName;
end;

procedure TLangManCore.SetCookieName(CName: string);
begin
  if CName = GetDefaultCookieID then CName := '';
  if CName <> fCookieName then begin
    fCookieName := CName;
    CookieNameChanged;
  end;
end;

procedure TLangManCore.CookieNameChanged;
begin
end;

procedure TLangManCore.RememberLanguage(LangID: String);
begin
end;

function TLangManCore.GetInitLanguage: String;
begin
  // this virtual method: returns application default language name or ISO code
  Result := fDefaultLanguage;
end;

function TLangManCore.EditorDisabled: Boolean;
begin
  Result := IsMultiEngine;
end;

function TLangManCore.CheckLangDir: Boolean;
var LangDir: String;
begin
  Result := true;
  LangDir := LangFilesPath;
  if LangDir <> '' then begin
{$IFDEF DXE2}
    if NOT SysUtils.DirectoryExists(LangDir) then begin
      if (LangDir <> '') then Result := SysUtils.ForceDirectories(LangDir)
                         else Result := false;
{$ELSE}
    if NOT DirectoryExists(LangDir) then begin
      if (LangDir <> '') then Result := ForceDirectories(LangDir)  //CreateDir(LangDir);
                         else Result := false;
{$ENDIF}
      if NOT Result then raise Exception.Create(LData.LangFormLexicon.Item[29]);
    end;
  end;
end;

function TLangManCore.ReCreateLangMenus: Boolean;
var MenuItem: Integer;
begin
  Result := EngineLoaded;
  if DesignTime then Result := Result AND IsInitialized;
  if Result then with LData do begin
    LangMenu.Clear;
    LangMenu.Assign(Languages);
    if IsInitialized then begin
      if LangCreatorVisible then begin
        MenuItem := LangMenu.Add(LangFormLexicon.Item[CREATOR_LANGITEM]);
        if MenuItem >= Flags.Count then LoadFlagIcon(Flags.Flag[MenuItem], fqCreator);
      end;
      if LangEditorVisible AND EditorCanBeShown then begin
        MenuItem := LangMenu.Add(LangFormLexicon.Item[EDITOR_LANGITEM]);
        if MenuItem >= Flags.Count then LoadFlagIcon(Flags.Flag[MenuItem], fqEditor);
      end;
    end;
  end;
end;

procedure TLangManCore.RefreshLangLists;
var ClientIndex, LangIndex: Integer;
begin
  LangIndex := LData.Languages.IndexOf(CurrentLanguage);
  with LData.SpanClients do if Components.Count > 0 then begin
    for ClientIndex := 0 to Components.Count - 1 do begin
      if NOT (csLoading in Components.Items[ClientIndex].ComponentState) then begin
        RefreshLangList(Components.Items[ClientIndex], LangIndex);
      end;
    end;
  end;
end;

procedure TLangManCore.FindLangFiles;
var SearchRec: TSearchRec;
    FindResult: Integer;
    LResStream: TResourceStream;
    LangDir: String;

  procedure RegisterLang(LangFile: string; Lang: TLangIDs; Editable: Boolean);
  var LangExist: Integer;
  begin
    if (Lang.Name <> '') then with LData do begin
      LangExist := Languages.IndexOf(Lang.Name);
      if LangExist > 0 then begin
        if (NOT FileExists(FileNames.Strings[LangExist])) and
            fAllowEditInternalLangs and
           (fLangResources.IndexOf(FileNames.Strings[LangExist]) >= 0) then begin
          FileNames.Strings[LangExist] := LangFile;
          if (Lang.Code <> '') then LangCodes.Strings[LangExist] := Lang.Code;
          if LoadedFlag then Flags.Flag[LangExist].LoadFromStream(GetFlag);
        end;
      end else begin
        FileNames.Add(LangFile);
        Languages.Add(Lang.Name);
        LangCodes.Add(Lang.Code);
        if Editable then EditableLangs.Add(Lang.Name);
        if LoadedFlag then Flags.NewFlag.LoadFromStream(GetFlag)
                      else Flags.NewFlag;
      end;
    end;
  end;

begin
  if EngineLoaded then with LData do begin
    //DataStruct.Clear;  //REM od v1.1.7 -> jazykovy soubor zustava nacteny v pameti
                         // kvuli dynamickym formularum a runtime volani Translate
                         // aby nebylo zapotrebi znovu nacitat jazyk ze souboru
    Languages.Clear;
    FileNames.Clear;
    LangCodes.Clear;
    EditableLangs.Clear;
    Flags.ClearFlags;
    Languages.Add(fDesignLanguage);
    FileNames.Add(fDesignLanguage);
    LangCodes.Add(DesignLangISO);
    LoadFlagIcon(Flags.NewFlag, fqDesignLang);
    if fLangResources.Count > 0 then begin
     for FindResult := 0 to fLangResources.Count - 1 do begin
      // load langs from resources
      try
        LResStream := TResourceStream.Create(HInstance, fLangResources.Strings[FindResult], RT_RCDATA);
        try
          RegisterLang(fLangResources.Strings[FindResult], GetLangIDs(LResStream, '[' + fLangFileSign + ']', true), fAllowEditInternalLangs);
        finally
          LResStream.Free;
        end;
      except
        on Exception do if NOT DesignTime then fLangResources.Delete(FindResult);
      end;
     end;
    end;
    LangDir := LangFilesPath;
    if (LangDir <> '') then begin
      FindResult := FindFirst(LangDir + '*.*',faAnyFile,SearchRec);
      try
        while FindResult = 0 do begin
          if ExtractFileExt(LangManSys.LowerCase(SearchRec.Name)) = LangManSys.LowerCase(fLangFileExt) then begin
            RegisterLang(LangDir + SearchRec.Name, GetLangIDs(LangDir + SearchRec.Name, '[' + fLangFileSign + ']', true), true);
          end;
          FindResult := FindNext(SearchRec);
        end;
      finally
        FindClose(SearchRec);
      end;
    end;
    ReCreateLangMenus;
  end;
end;

procedure TLangManCore.Loaded;
begin
  inherited Loaded;
  TranslateLangForm(fCurrentLanguage, fCurrentLangISO, false);
  FindLangFiles;
  if csDesigning in ComponentState then EngineInit(false);
end;

{$HINTS OFF}

function TLangManCore.LoadLangFromFile(LangName: TLanguage; Options: TLLFOptions; AntiLoop: TLanguage = ''): boolean;
var LangIndex, SI, FPos: Integer;
    LangSource: TStringList;
    LangResource: TResourceStream;
    Bufstr, LexiconName, iso: String;
    Bufint: Integer;
    Data  : TFullStructLine;
{$IFDEF LMSMART}
    TranStr: String;
{$ENDIF}

  procedure ClearLangDatas; // switch to Design Language
  begin
    LData.Clear;
    EraseFlag;
    iso := '';
    if (lloLoadSuperior in Options) then begin
      LData.CurrentSuperiorLang.Name := fDesignLanguage;
      LData.CurrentSuperiorLang.Code := LData.DesignLangISO;
    end else begin
      fCurrentLanguage := fDesignLanguage;
      fCurrentLangISO := LData.DesignLangISO;
    end;
    if fIncludeLangMan then begin
      if NOT LData.LangFormLexicon.InternalLanguages(fDesignLanguage, LData.DesignLangISO)
        then LData.LangFormLexicon.LoadLang(ENGLISH_LANGMAN);
    end;
  end;

  function CompileSourceAfterLoadSuperiorLanguage(LangDef: string): boolean;
  var SuperiorIndex: Integer;
      SuperiorLanguage: string;

    function LoopDetected: boolean;
    begin
      Result := Pos('-' + SuperiorLanguage + '-', AntiLoop) > 0;
    end;

  begin
    Result := false;
    SuperiorIndex := -1;
    SuperiorLanguage := GetDescriptor(LangDef,SUPERIOR_LANGUAGE_DESCRIPTOR);
    if SuperiorLanguage <> '' then SuperiorIndex := LData.Languages.IndexOf(SuperiorLanguage);
    if (SuperiorIndex < 0) OR LoopDetected then SuperiorLanguage := fDesignLanguage;
    if AntiLoop = '' then begin  // první naèítaný jazyk
      LoadLangFromFile(SuperiorLanguage, [lloLoadSuperior], '-' + LangName + '-');
      Result := lloCreateSource in Options;
    end else begin               // rekurzivní naèítání
      LoadLangFromFile(SuperiorLanguage, [lloLoadSuperior], AntiLoop + LangName + '-');
    end;
    LData.NewLanguage;
  end;

  function CheckLineStructure: boolean;
  begin
    Result := false;
    Data.Descent := 0;
    Data.Translation := ReadEncodedFromQuotes(Bufstr);
    if (BufInt >= 0) then begin
      Data.PropertyID := BufInt;
      Data.CompName := GetDescriptor(Bufstr, COMPONENT_DESCRIPTOR);
      if Data.CompName = '' then Exit;
      Data.OwnerName := GetDescriptor(Bufstr, OWNER_DESCRIPTOR);
      if Pos(NOTRANS_DESCRIPTOR,Bufstr) > 0 then Data.Changeable := ca_NO
                                            else Data.Changeable := ca_YES;
      Data.ItemAddr := GetDescriptor(Bufstr, ITEM_DESCRIPTOR);
      if Pos(OLD_ITEM_DESCRIPTOR,Bufstr) > 0
        then Data.Changeable := Data.Changeable OR ca_OLD
        else if (lloMarkOld in Options) and
                (NOT LData.SpanClients.IsRegistered(Data)) and
                (NOT DesignTime)
               then Data.Changeable := Data.Changeable + ca_OLD;
      Result := true;
    end;
  end;

begin
  Result := false;
  ClearLangDatas;
  LangIndex := LData.Languages.IndexOf(LangName);
  if (LangIndex > 0) then with LData do begin
    try
      LangSource := TStringList.Create;
      LangSource.LineBreak := #13#10;
      LangSource.NameValueSeparator := cTAB;
      try
        if FileExists(FileNames.Strings[LangIndex]) then begin
          LangSource.LoadFromFile(FileNames.Strings[LangIndex]);
        end else begin
          if LangResources.IndexOf(FileNames.Strings[LangIndex]) >= 0 then begin
            LangResource := TResourceStream.Create(HInstance,FileNames.Strings[LangIndex],RT_RCDATA);
            try
              LangSource.LoadFromStream(LangResource);
            finally
              LangResource.Free;
            end;
          end else Abort;
        end;
        if LangSource.Count > 0 then begin
          if Trim(LangSource.Strings[0]) <> '[' + fLangFileSign + ']' then Abort;
          FPos := 1;
          while NOT EoFile(LangSource, FPos) do begin
            Bufstr := LangSource.Strings[FPos];
            Inc(FPos);
            if Pos(LANGUAGE_DESCRIPTOR,Bufstr) > 0 then begin
              iso := GetDescriptor(Bufstr, LANGUAGE_ISO_CODE_DESCRIPTOR);
              IsISO1(iso);
              if CompileSourceAfterLoadSuperiorLanguage(Bufstr) then CompleteSourceData;
              // misto pro kontrolu verze souboru (po pripadnych budoucich zmenach ve formatu)
              Bufstr := ExtrahovatZUvozovek(Bufstr);
              if Bufstr = LangName then Break;
            end;
          end;
          while NOT EoFile(LangSource, FPos) DO begin
            if NOT FileReadInt(LangSource,Bufint,FPos) then begin
              Inc(FPos);
              Continue;
            end;
            Bufstr := LangSource.ValueFromIndex[FPos];
            Inc(FPos);
            if (Length(Bufstr) > 2) then begin
{$IFDEF NEXTGEN}
              if (Bufstr[0] <> UVOZOVKA) AND (Bufstr.IndexOf(LEXICON_SEPARATOR) >= 0) then Break;
{$ELSE}
              if (Bufstr[1] <> UVOZOVKA) AND (Pos(LEXICON_SEPARATOR,Bufstr) > 0) then Break;
{$ENDIF}
              if CheckLineStructure then begin
                if (NOT (lloCreateSource in Options)) then begin
                  SI := DataStruct.Find(Data);
                  if SI >= 0 then begin
                    if (Data.Changeable and ca_YES) = ca_NO then Data.Translation := DataStruct.Translation[SI];
                    DataStruct.SetupLine(SI, Data.Translation, Data.Descent, Data.Changeable);
                  end else DataStruct.AddLine(Data);
                end else DataStruct.AddLine(Data);
              end;
            end;
          end;
          LexiconName := '';
          while NOT EoFile(LangSource, FPos) DO begin
            if NOT FileReadInt(LangSource,Bufint,FPos) then begin
              Inc(FPos);
              Continue;
            end;
            Bufstr := LangSource.ValueFromIndex[FPos];
            Inc(FPos);
            if (Length(Bufstr) > 2) then begin
{$IFDEF NEXTGEN}
             if (Bufstr[0] <> UVOZOVKA) then begin
{$ELSE}
             if (Bufstr[1] <> UVOZOVKA) then begin
{$ENDIF}
              if Pos(SMART_SEPARATOR,Bufstr) > 0 then Break;
              if Pos(LANGMAN_DESCRIPTOR,Bufstr) > 0 then begin
                LexiconName := GetLexiconName(LangFormLexicon);
                if LexiconName <> '' then DataLexicon.NewLexicon(LexiconName)
                                     else Abort;
                Continue;
              end;
              if Pos(LEXICON_DESCRIPTOR,Bufstr) > 0 then begin
                LexiconName := GetDescriptor(Bufstr, LEXICON_DESCRIPTOR);
                if LexiconName <> '' then DataLexicon.NewLexicon(LexiconName)
                                     else Abort;
                Continue;
              end;
             end;
             Bufstr := ReadEncodedFromQuotes(Bufstr);
             if (BufInt >= 0) and (Bufstr <> '') then begin
              if LexiconName <> '' then DataLexicon.WriteItem(LexiconName, BufInt, Bufstr);
             end;
            end;
          end;
          LexiconName := '';
          while NOT EoFile(LangSource, FPos) DO begin
            if NOT FileReadInt(LangSource,Bufint,FPos) then begin
              Inc(FPos);
              Continue;
            end;
            Bufstr := LangSource.ValueFromIndex[FPos];
            Inc(FPos);
            if (Length(Bufstr) > 2) then begin
{$IFDEF NEXTGEN}
             if (Bufstr[0] <> UVOZOVKA) then begin
{$ELSE}
             if (Bufstr[1] <> UVOZOVKA) then begin
{$ENDIF}
              if Pos(FLAG_ICON_DESCRIPTOR,Bufstr) > 0 then Break;
{$IFDEF LMSMART}
              if Pos(LEXICON_DESCRIPTOR,Bufstr) > 0 then begin
                LexiconName := GetDescriptor(Bufstr, LEXICON_DESCRIPTOR);
                if LexiconName <> '' then SmartLexicon.NewLexicon(LexiconName)
                                     else Abort;
                Continue;
              end;
{$ENDIF}
             end;
{$IFDEF LMSMART}
             Bufstr := ReadEncodedFromQuotes(Bufstr);
             if Bufstr <> '' then while NOT EoFile(LangSource, FPos) do begin
              if NOT FileReadInt(LangSource,SI,FPos) then begin
                Inc(FPos);
                Continue;
              end;
              if SI <> Bufint then Break;
              TranStr := ReadEncodedFromQuotes(LangSource.ValueFromIndex[FPos]);
              if (TranStr = '') then Break;
              SmartLexicon.AddItem(LexiconName, Bufstr, TranStr);
              Inc(FPos);
              Break;
             end;
{$ENDIF}
            end;
          end;
          // LangFormLexicon Items
          if LangFormLexicon.InternalLanguages(LangName, iso, fIncludeLangMan) then begin
            // jsou nacteny, tedy z DataLexicon se vymazou (vnitrni preklad ma prednost)
            DataLexicon.DeleteLexicon(GetLexiconName(LangFormLexicon));
            if (iso = '') AND fIncludeLangMan then iso := LangFormLexicon.InternalLanguage.Code;  // Doplneni ISO kodu
          end;
          // Ikona se cte pouze pri nacitani pro editaci
          if lloLoadFlag in Options then LoadFlag(LangSource, FPos);
          Result := true;
          if lloLoadSuperior in Options then begin
            CurrentSuperiorLang.Name := LangName;
            CurrentSuperiorLang.Code := iso;
          end else begin
            fCurrentLanguage := LangName;
            fCurrentLangISO := iso;
            if CurrentSuperiorLang.Name = '' then begin
              CurrentSuperiorLang.Name := fDesignLanguage;
              CurrentSuperiorLang.Code := DesignLangISO;
            end;
          end;
        end;
      finally
        LangSource.Free;
      end;
    except
      on Exception do ClearLangDatas;
    end;
  end else Result := LangIndex = 0;
end;

{$HINTS ON}

function TLangManCore.TranslateLangForm(ToLang: TLanguage; Code: TISOCode; ForceTranslate: Boolean): boolean;
begin
  Result := false;
  if EngineLoaded AND (ForceTranslate OR (NOT fIncludeLangMan)) then begin
    if ToLang = '' then ToLang := fCurrentLanguage;
    if ToLang <> '' then Result := LData.LangFormLexicon.InternalLanguages(ToLang, Code);
    if NOT Result then begin
      if (fDefaultLanguage <> ToLang) and
         (fDefaultLanguage <> '') and
         LData.LangFormLexicon.InternalLanguages(fDefaultLanguage, fDefaultLanguage) then Exit;
      if (fDesignLanguage <> ToLang) and
         (fDesignLanguage <> '') and
         LData.LangFormLexicon.InternalLanguages(fDesignLanguage, LData.DesignLangISO) then begin
        if NOT DesignTime then DesignLangISOCode := LData.LangFormLexicon.InternalLanguage.Code;
        Exit;
      end;
      LData.LangFormLexicon.LoadLang(ENGLISH_LANGMAN);
    end;
  end;
end;

function TLangManCore.LangManCommands(Command: String): TLanguage;
var LMC, SelectedLangIndex: Integer;
    LangBeforeEdit: String;
begin
  LMC := -1;
  if NOT EditorDisabled then begin
    if (Command = LData.LangFormLexicon.Item[CREATOR_LANGITEM]) AND CheckLangDir
      then LMC := 0  // Add Language
      else if (Command = LData.LangFormLexicon.Item[EDITOR_LANGITEM]) and
              EditorCanBeShown then LMC := 1;  // Language Editor
  end;

{$IFDEF ANDROID}
  if LMC >= 0 then raise Exception.Create('Language Editor is not supported on Android device');
{$ENDIF}

  if LMC < 0 then begin
    SelectedLangIndex := LData.LangCodes.IndexOf(Command);
    if SelectedLangIndex >= 0 then Result := LData.Languages.Strings[SelectedLangIndex]
                              else Result := Command;
  end else begin
    LangBeforeEdit := CurrentLanguage;
{$IFDEF LMDESI}
    if DesignTime then LData.SpanClients.PrepareForDesignTimeEdit;
{$ENDIF}
    if Assigned(fOnBeforeEdit) then fOnBeforeEdit(Self);
    Result := LData.EditorExecute(LMC);
    FindLangFiles;   // nacteni noveho jazyka, kodu nebo jen zmenene vlajky nebo ISO kodu
    SelectedLangIndex := LData.Languages.IndexOf(Result);
    if SelectedLangIndex < 0 then Result := LangBeforeEdit;
    if Assigned(fOnAfterEdit) then fOnAfterEdit(Self);
  end;
end;

procedure TLangManCore.SaveLanguageFile(LangName, SuperiorLang, FileName: string; LangISO: TISOCode);
var LFile: TStringList;
    I, LI: Integer;
    LexName, LineBuf: string;

  function LineFormatter(Data: TFullStructLine): string;
  begin
    with Data do begin
      Result := IntToStr(PropertyID) + cTAB;
      if (Changeable and ca_YES) = ca_YES then Result := Result + UVOZOVKA + Translation + UVOZOVKA
                                          else Result := Result + NOTRANS_DESCRIPTOR;
      Result := Result + cTAB + COMPONENT_DESCRIPTOR + CompName + STREDNIK +
                         cTAB + OWNER_DESCRIPTOR + OwnerName + STREDNIK;
      if ItemAddr <> '' then Result := Result + cTAB + ITEM_DESCRIPTOR + ItemAddr + STREDNIK;
      if (Changeable and ca_OLD) = ca_OLD then Result := Result + cTAB + OLD_ITEM_DESCRIPTOR;
    end;
  end;

begin
  if CheckLangDir and (LangName <> '') and (FileName <> '') then begin
      LFile := TStringList.Create;
      LFile.LineBreak := #13#10;
      try
        LFile.Add('[' + fLangFileSign + ']');
        LineBuf := '0' + cTAB + LANGUAGE_DESCRIPTOR + UVOZOVKA + LangName + UVOZOVKA;
        if IsISO1(LangISO) then LineBuf := LineBuf + cTAB + LANGUAGE_ISO_CODE_DESCRIPTOR + LangISO + STREDNIK;
        if (SuperiorLang <> '') then LineBuf := LineBuf + cTAB + SUPERIOR_LANGUAGE_DESCRIPTOR + SuperiorLang + STREDNIK;
        LFile.Add(LineBuf + cTAB + LANGUAGE_FILEVERSION_DESCRIPTOR + LANGUAGE_FILE_VERSION + STREDNIK);
        with LData do begin
          for I := 0 to DataStruct.Count - 1 do LFile.Add(LineFormatter(DataStruct.GetFull(I)));
          LFile.Add('0' + cTAB + LEXICON_SEPARATOR);
          if (DataLexicon.LexiconCount > 0) then begin
            for LI := 0 to DataLexicon.LexiconCount - 1 do begin
              LexName := DataLexicon.LexiconName(LI);
              if DataLexicon.ItemsCount(LexName) > 0 then begin
                LineBuf := '0' + cTAB + LEXICON_DESCRIPTOR + LexName + STREDNIK;
                if LexName = GetLexiconName(LangFormLexicon)
                  then LineBuf := LineBuf + cTAB + LANGMAN_DESCRIPTOR;
                LFile.Add(LineBuf);
                for I := 0 to DataLexicon.MaxItemNr(LexName) do begin
                  if DataLexicon.IsIncluded(LexName,I) and
                     (DataLexicon.ReadItem(LexName,I) <> '') then
                    LFile.Add(IntToStr(I) + cTAB + UVOZOVKA + DataLexicon.ReadItem(LexName,I) + UVOZOVKA);
                end;
              end;
            end;
          end;
          LFile.Add('0' + cTAB + SMART_SEPARATOR);
{$IFDEF LMSMART}
          if SmartLexicon.ItemsCount > 0 then begin
            for I := 0 to SmartLexicon.MaxItemNr do begin
              LFile.Add(IntToStr(I) + cTAB + UVOZOVKA + SmartLexicon.GetLocStr(I) + UVOZOVKA);
              LFile.Add(IntToStr(I) + cTAB + UVOZOVKA + SmartLexicon.ReadItem(I) + UVOZOVKA);
            end;
          end;
          if (SmartLexicon.LexiconCount > 0) then begin
            for LI := 0 to SmartLexicon.LexiconCount - 1 do begin
              LexName := SmartLexicon.LexiconName(LI);
              if SmartLexicon.ItemsCount(LexName) > 0 then begin
                LFile.Add('0' + cTAB + LEXICON_DESCRIPTOR + LexName + STREDNIK);
                for I := 0 to SmartLexicon.MaxItemNr(LexName) do begin
                  LFile.Add(IntToStr(I) + cTAB + UVOZOVKA + SmartLexicon.GetLocStr(LexName, I) + UVOZOVKA);
                  LFile.Add(IntToStr(I) + cTAB + UVOZOVKA + SmartLexicon.ReadItem(LexName, I) + UVOZOVKA);
                end;
              end;
            end;
          end;
{$ENDIF}
        end;
        if LoadedFlag then SaveFlag(LFile);
      {$IF CompilerVersion > 19}
        case fLangFileEncoding of
          Unicode: LFile.SaveToFile(FileName, TEncoding.Unicode);
          BigEndianUnicode: LFile.SaveToFile(FileName, TEncoding.BigEndianUnicode);
          UTF8: LFile.SaveToFile(FileName, TEncoding.UTF8);
          else LFile.SaveToFile(FileName);
        end;
      {$ELSE}
        LFile.SaveToFile(FileName);
      {$IFEND}
      finally
        LFile.Free;
      end;
  end;
end;

function TLangManCore.GetFileNameForNew(RecommendedName: String): String;
var StrBuf: String;
    DupliNr: Integer;
begin
  if ExtractFileExt(LangManSys.LowerCase(RecommendedName)) = LangManSys.LowerCase(fLangFileExt)
    then StrBuf := LangFilesPath + RecommendedName
    else StrBuf := LangFilesPath + RecommendedName + fLangFileExt;
  DupliNr := 1;
  Result := StrBuf;
  while FileExists(Result) do begin
    Inc(DupliNr);
    if Length(fLangFileExt) > 0 then Result := Copy(StrBuf, 1, Length(StrBuf) - Length(fLangFileExt)) + IntToStr(DupliNr) + fLangFileExt
                                else Result := StrBuf + IntToStr(DupliNr);
  end;
end;

function TLangManCore.ResourceLangToFile(LangIndex: Integer): Boolean;
var LResStream: TResourceStream;
    ResID: Integer;
    ResName: TFileName;
begin
  Result := false;
  if fLangResources.Count > 0 then begin
    ResName := LData.FileNames.Strings[LangIndex];
    ResID := fLangResources.IndexOf(ResName);
    if ResID >= 0 then begin
      // load language from resources
      try
        if CheckLangDir then begin
          LResStream := TResourceStream.Create(HInstance, fLangResources.Strings[ResID], RT_RCDATA);
          try
            LData.FileNames.Strings[LangIndex] := GetFileNameForNew(ResName);
            LResStream.SaveToFile(LData.FileNames.Strings[LangIndex]);
          finally
            LResStream.Free;
          end;
          Result := true;
        end;
      except
        on Exception do ; // Ignore
      end;
    end;
  end;
end;

procedure TLangManCore.RegisterClient(ClientComponent: TComponent; var EngineHandle: TLangManCore);
begin
  if Self <> EngineHandle then begin
    if Assigned(EngineHandle) then EngineHandle.UnregisterClient(ClientComponent);
    EngineHandle := Self;
    LData.SpanClients.RegisterClient(ClientComponent);
  end;
end;

procedure TLangManCore.UnregisterClient(ClientComponent: TComponent);
begin
  LData.SpanClients.UnregisterClient(ClientComponent);
end;

procedure TLangManCore.SetName(const NewEngineName: TComponentName);
var EngineID: String;
begin
  inherited SetName(NewEngineName);

  if IsMultiEngine then begin

    if NOT Assigned(Owner) then Exit;
    if (NewEngineName = '') OR (Owner.Name = '') then Exit;

    EngineID := NewEngineName + '&' + Owner.Name;
    if LangManMulti.IndexOf(EngineID) < 0 then begin
      if IsWebSession then Exit;
      LangManMulti.Add(EngineID);
      IsMultiEngine := false;
      FindLangFiles;
    end;
  end;
end;

function TLangManCore.EngineInit(LoadDefault: Boolean = true): Boolean;
var OpenInLang: String;
begin
  Result := DesignTime;
  if NOT IsInitialized then begin
    IsInitialized := true;
    LData.SpanClients.InitClients;
    if (NOT Result) then begin
      if LoadDefault then begin
        OpenInLang := GetInitLanguage;
        if (OpenInLang <> fDesignLanguage) AND (OpenInLang <> LData.DesignLangISO) then begin
          Translate(OpenInLang);
          Result := true;
        end;
      end;
      if (NOT Result) AND (LangEditorVisible OR LangCreatorVisible) then RecreateLangMenus;
    end else RecreateLangMenus;
  end else LData.SpanClients.InitClients;
  LData.SpanClients.InitToLanguage(CurrentLanguage, CurrentLanguage = fDesignLanguage);
end;

function TLangManCore.IsWebSession: Boolean;
begin
  Result := false;
end;

constructor TLangManCore.Create(AOwner: TComponent);
begin
  LastAutoLangName := DEFAULT_DESIGN_LANGUAGE;
  IsInitialized   := false;
  IsFullyCreated  := false;
  inherited Create(AOwner);
  fLangMenuFlags  := true;
  fHideCopyright  := false;
  fLangResources  := TStringList.Create;
  LData.LangFormLexicon := TLangFormLexicon.Create(Self);
  IsMultiEngine   := NOT DesignTime;
  if LData.Languages.Count = 0 then begin
    fDesignLangISOCode := '';
    LData.DesignLangISO := '';
    SetDesignLang('');
  end;
  fLangSubdir := '';
  SetLangFileExt('lng');
  fLangFileSign := 'LANGUAGE_FILE';
  SetLangCreatorVisible(True);
  SetLangEditorVisible(True);
  fIncludeLangMan := False;
  fCookieLifeDays := 0;
  fCookieEnabled := True;
  fLangFileEncoding := Unicode;
  SetLangResourcesAllowEdit(False);
  IsFullyCreated := true;
  if EngineLoaded then begin
    TranslateLangForm(fDesignLanguage, fDesignLangISOCode, false);
    FindLangFiles;
    if DesignTime then EngineInit(false);
  end;
  DesignTimeAdjustment := -1;
end;

destructor TLangManCore.Destroy;
begin
  FreeAndNil(fLangResources);
  LData.LangFormLexicon.Free;
  inherited Destroy;
end;

function TLangManCore.Translate(ISOorLangName: String): TLanguage;
var Lang: TLanguage;
    Continue: Boolean;
begin
  Continue := true;
  if DesignTime then FindLangFiles
                else if Assigned(fOnChangeLangQuery) then fOnChangeLangQuery(Self, Continue);
  if Continue then begin
    EngineInit(false);
    Lang := LangManCommands(ISOorLangName);
    if DesignTime then Lang := fDesignLanguage;
    if (LData.Languages.IndexOf(Lang) >= 0) then begin
      LoadLangFromFile(Lang, []);
      TranslateLangForm(fCurrentLanguage, fCurrentLangISO, false);
      if NOT DesignTime then begin
        LData.SpanClients.CallClientProcs;
        RememberLanguage(fCurrentLanguage);
        if Assigned(fOnChangeLanguage) then fOnChangeLanguage(Self);
        ReCreateLangMenus;
      end;
    end else ReCreateLangMenus;
  end else ReCreateLangMenus;
  Result := fCurrentLanguage;
end;

{$IFNDEF LMSMART}
function TLangManCore.TranslateString(Str: String; Lexicon: TLMList = nil; ItemNr: Integer = -1): String;
begin
  if NOT IsInitialized then EngineInit;
  Result := LData.DataLexicon.ReadItem(GetLexiconName(Lexicon), ItemNr);
  if Result = '' then Result := Str;
  DecodeSpecialChars(Result);
end;
{$ENDIF}

procedure TLangManCore.AssignLanguagesList(TargetList: TStrings);
begin
  if Assigned(TargetList) then TargetList.Assign(LData.Languages);
end;

function TLangManCore.GetLanguageFile(ISOorLangName: String): TFileName;
begin
  Result := LData.GetFile(ISOorLangName);
end;
function TLangManCore.GetLanguageFile(LanguageIndex: Integer): TFileName;
begin
  Result := LData.GetFile(LanguageIndex);
end;
function TLangManCore.GetISOCode(LanguageName: String): String;
begin
  Result := LData.GetCode(LanguageName);
end;
function TLangManCore.GetISOCode(LanguageIndex: Integer): String;
begin
  Result := LData.GetCode(LanguageIndex);
end;
function TLangManCore.LangExists(ISOorLangName: String): Boolean;
begin
  Result := LData.Exists(ISOorLangName);
end;
function TLangManCore.FlagImage(ISOorLangName: String): TMemoryStream;
begin
  Result := LData.Flag(ISOorLangName);
end;
function TLangManCore.FlagImage(LanguageIndex: Integer): TMemoryStream;
begin
  Result := LData.Flag(LanguageIndex);
end;

function TLangManCore.EditorCanBeShown: Boolean;
begin
  Result := LData.EditableLangs.Count > 0;
end;

procedure TLangManCore.ShowLangEditor;
begin
  Translate(LData.LangFormLexicon.Item[EDITOR_LANGITEM]);
end;
procedure TLangManCore.ShowLangCreator;
begin
  Translate(LData.LangFormLexicon.Item[CREATOR_LANGITEM]);
end;

procedure TLangManCore.RefreshLangControl(LangManGUIControl: TComponent);
begin
  if LangManGUIControl <> nil then
    RefreshLangList(LangManGUIControl, LData.Languages.IndexOf(CurrentLanguage));
end;

{$IFDEF LMIMEX}
{$I LMImportExport}
{$ENDIF}
{$IFDEF LMSMART}
{$I LMVocTrans}
{$I LMResHack}
{$ENDIF}
{$IFDEF LMULT}
{$I LMInline}
{$ENDIF}
{$IFDEF LMPRO}
{$I LMMDI}
{$ENDIF}

//+****************************************************************************
//+*  TLangManComponent methods                                              **
//+****************************************************************************

procedure TLangManComponent.SetLangManEngine(LangMan: TLangManCore);
begin
  if fLangManEngine <> LangMan then begin
    LMComponentLanguage := '';
    if Assigned(fLangManEngine) AND (fLangManEngine.Owner <> Owner) then fLangManEngine.RemoveFreeNotification(Self);
    if (fLangManEngine = nil) then begin
      fLangManEngine := LangMan;
      if NOT (csLoading in ComponentState) then Init;  // Inicializace dynamicky vytvorene komponenty (i LMList)
                                                       //  plati i pro DesignTime kvuli Ribbons
    end else begin
      fLangManEngine.LData.SpanClients.UnregisterClient(Self);
      fLangManEngine := LangMan;
    end;
    if Assigned(fLangManEngine) AND (fLangManEngine.Owner <> Owner) then fLangManEngine.FreeNotification(Self);
    if LangMan <> nil then begin
      fLangManEngine.LData.SpanClients.RegisterClient(Self);
      if NOT (csLoading in (ComponentState + LangMan.ComponentState)) then ChangeLanguage(Self);
    end else begin
      if NOT (csLoading in ComponentState) then ChangeLanguage(Self); // odebrani lexikonu za behu programu
    end;
  end;
end;

procedure TLangManComponent.SetConnectedGlobal(Connect: Boolean);
begin
{$IFNDEF LMSMART}
  Connect := false;
{$ENDIF}
  if Connect <> fConnectedGlobal then begin
    fConnectedGlobal := Connect;
    if (NOT DesignTime) AND (NOT (csLoading in ComponentState)) AND
       (fLangManEngine <> nil) AND (fLangManEngine.IsInitialized) then ChangeLanguage(Self);
  end;
end;

procedure TLangManComponent.Init;
begin
end;

procedure TLangManComponent.PrepareForDesignTimeEdit;
begin
end;

procedure TLangManComponent.ChangeLanguage(Sender: TObject);
begin
  if DesignTime then Exit;
  if Assigned(fLangManEngine) then LMComponentLanguage := fLangManEngine.CurrentLanguage
                              else LMComponentLanguage := '';
  if Assigned(fOnChangeLanguage) then fOnChangeLanguage(Self);
end;

procedure TLangManComponent.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) AND (AComponent = fLangManEngine) then begin
    fLangManEngine := nil;
    LMComponentLanguage := '';
  end;
end;

constructor TLangManComponent.Create(AOwner: TComponent);
begin
  fLangManEngine := nil;
  inherited Create(AOwner);
  fConnectedGlobal := false;
end;

destructor TLangManComponent.Destroy;
begin
  if Assigned(fLangManEngine) AND Assigned(fLangManEngine.LData)
    then fLangManEngine.LData.SpanClients.UnregisterClient(Self);
  inherited Destroy;
end;

//+****************************************************************************
//+*  TIntegratedLangManHandler methods                                      **
//+****************************************************************************

constructor TIntegratedLangManHandler.Create(AOwner: TComponent);
begin
  Integrator := nil;
  inherited Create(AOwner);
end;

destructor TIntegratedLangManHandler.Destroy;
begin
  inherited Destroy;
  FreeAndNil(Integrator);
end;

procedure TIntegratedLangManHandler.SetIntegrator(Master: TLangManComponent);
begin
  if Master = nil then Exit;
  if Integrator = nil then begin
    Integrator := TLMComponentList.Create;
    Integrator.OwnsObjects := false;
  end;
  Integrator.Clear;
  Integrator.Add(Master);
end;

function TIntegratedLangManHandler.GetIntegrator: TLangManComponent;
begin
  Result := nil;
  if Integrator.Count > 0 then Result := TLangManComponent(Integrator.Items[0]);
end;

//+****************************************************************************
//+*  LangMan Cross Platform Client                                          **
//+****************************************************************************

function TLangManCPC.TransProp(Prop: TStringProperties): Boolean;
begin
  Result := true;
end;

function TLangManCPC.TransProp(Prop: TTStringsProperties): Boolean;
begin
  Result := true;
end;

function TLangManCPC.TransProp(Prop: TStructuredProperties): Boolean;
begin
  Result := true;
end;

function TLangManCPC.TransProp(Prop: TOtherProperties): Boolean;
begin
  Result := true;
end;

{$IFDEF DATABASES}
 {$IFNDEF NEXTGEN}
procedure TLangManCPC.ChangeStructTableProducerColumns(Component: TComponent; PropertyType: Word; fchInit: Boolean);
var Cols: THTMLTableColumns;
    Bufstr: string;
    CI: Integer;
begin
  Cols := (Component as TDSTableProducer).Columns;
  if Cols.Count > 0 then for CI := 0 to Cols.Count - 1 do begin
    if fchInit then CreateStructItem(Component,PropertyType,Cols.Items[CI].Title.Caption,NestedProperty(CreateAddr(CI),pnCaption))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedProperty(CreateAddr(CI),pnCaption));
      if Bufstr <> '' then Cols.Items[CI].Title.Caption := Bufstr;
    end;
  end;
end;
 {$ENDIF}
{$ENDIF}

function TLangManCPC.IsWebClient: Boolean;
begin
  Result := false;
end;

procedure TLangManCPC.InitWebClient;
begin
end;

procedure TLangManCPC.Init;
begin
  inherited Init;
  if NOT CSInitialized then begin
    CSInitialized := true;  // musi byt pred ControlChanges(true); kvuli moznemu zacykleni
    ControlChanges(true);
    if IsWebClient then InitWebClient;
  end else begin
{$IFDEF LMDESI}
    if DesignTime then RecreateTransStruct; // automaticke prevytvoreni struktury pri navrhu formulare
{$ENDIF}
  end;
end;

procedure TLangManCPC.InitForm(AOwner: TObject);
begin
  if fAfterCreate and Assigned(OwnerOnCreate) then OwnerOnCreate(Self);
  if Assigned(fLangManEngine) then fLangManEngine.EngineInit;
  if (NOT fAfterCreate) and Assigned(OwnerOnCreate) then OwnerOnCreate(Self);
end;

function TLangManCPC.ObjectAddress(Obj: TObject; const Tag: String = ''): String;
var ObjPos: Integer;
begin
  ObjPos := ObjMap.IndexOfObject(Obj);
  if ObjPos >= 0 then Result := ObjMap.Strings[ObjPos]
                 else begin
    Result := CreateAddr(Tag);
    if Result <> '' then ObjMap.AddObject(Result, Obj);
  end;
end;

function TLangManCPC.GetLanguageOwnerName: String;
begin
  if LanguageOwner = '' then Result := Owner.Name
                        else Result := LanguageOwner;
end;

function TLangManCPC.GetLanguageComponentOwner(Component: TComponent): String;
begin
  if (Component.Owner = Owner) then Result := GetLanguageOwnerName
                               else begin
    if (Component.Owner = nil) then Result := ''
                               else Result := Component.Owner.Name;
  end;
end;

procedure TLangManCPC.CreateStructItem(Component: TComponent; PropertyType: Word; Input: String; Addr: String = '');
begin
  DesignStruct.AddTextProperty(Component.Name, GetLanguageComponentOwner(Component), PropertyType, Input, Addr);
end;

procedure TLangManCPC.CreateStructItem(ComponentName: String; Component: TComponent; PropertyType: Word; Input, Addr: string);
begin
  DesignStruct.AddTextProperty(ComponentName, GetLanguageComponentOwner(Component), PropertyType, Input, Addr);
end;

{$IFNDEF LMSMART}
function TLangManCPC.StructItem(ComponentName, OwnerName: string; PropertyType: Word; Addr: string = ''): string;
var SI: Integer;
begin
  if fLangManEngine = nil then begin
    Result := DesignStruct.GetString(ComponentName, OwnerName, PropertyType, Addr);
  end else begin
    Result := '';
    SI := fLangManEngine.LData.DataStruct.Find(ComponentName,OwnerName,PropertyType,Addr);
    if SI >= 0 then begin
      if NOT fLangManEngine.LData.DataStruct.ValidItem(SI) then ;//ntp Exit;
      Result := fLangManEngine.LData.DataStruct.Translation[SI];
    end;
    if (Result = '') then Result := DesignStruct.GetString(ComponentName,OwnerName,PropertyType,Addr);
  end;
  DecodeSpecialChars(Result);
end;
{$ENDIF}

function TLangManCPC.NotLinkedToAction(PropertyType : Word; const CompStr, ActionStr: string): Boolean;
begin
  Result := CompStr <> ActionStr;
end;

function TLangManCPC.ChangeStructItem(Component: TComponent; PropertyType : Word; InitText: string; fchInit: boolean; ActionString: string = ''): string;
var Bufstr: string;
begin
  if fchInit then begin
    if (InitText <> Component.Name) and NotLinkedToAction(PropertyType, InitText, ActionString) then begin
      CreateStructItem(Component, PropertyType, InitText);
    end;
    Result := InitText;
  end else begin
    Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType);
    if Bufstr <> '' then Result := Bufstr
                    else Result := InitText;
  end;
end;

function TLangManCPC.ChangeStructItemEx(Component: TComponent; PropertyType: Word; InitText: string; fchInit: Boolean; PresetAddr: string = ''): string;
var Bufstr: string;
begin
  if fchInit then begin
    CreateStructItem(Component, PropertyType, InitText, PresetAddr);
    Result := InitText;
  end else begin
    Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, PresetAddr);
    if Bufstr <> '' then Result := Bufstr
                    else Result := InitText;
  end;
end;

procedure TLangManCPC.ChangeStructStrings(Component: TComponent; PropertyType : Word; Data: TStrings; fchInit: boolean);
var Bufstr: string;
    II: Integer;
begin
  if Data.Count > 0 then for II := 0 to Data.Count - 1 do
    if fchInit then CreateStructItem(Component, PropertyType, Data.Strings[II], CreateAddr(II))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, CreateAddr(II));
      if Bufstr <> '' then Data.Strings[II] := Bufstr;
    end;
end;

procedure TLangManCPC.ChangeStructStringsEx(Component: TComponent; PropertyType: Word; Data: TStrings; fchInit: Boolean; PresetAddr: string);
var Bufstr: string;
    II: Integer;
begin
  if Data.Count > 0 then for II := 0 to Data.Count - 1 do
    if fchInit then CreateStructItem(Component, PropertyType, Data.Strings[II], NestedAddr(PresetAddr,II))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedAddr(PresetAddr,II));
      if Bufstr <> '' then Data.Strings[II] := Bufstr;
    end;
end;

function TLangManCPC.ChangeStructFilter(Component: TComponent; PropertyType: Word; InitFilter: string; fchInit: Boolean): string;
var FilterBuf, FilterName, FilterMask, Addr: string;
    BarPos: Integer;
begin
  Result := '';
  FilterBuf := InitFilter;
  BarPos := AnsiPos('|', FilterBuf);
  while BarPos > 0 do begin
    FilterName := Copy(FilterBuf, 1, BarPos - 1);
    Delete(FilterBuf, 1, BarPos);
    BarPos := AnsiPos('|', FilterBuf);
    if BarPos > 0 then begin
      FilterMask := Copy(FilterBuf, 1, BarPos - 1);
      Delete(FilterBuf, 1, BarPos);
    end else begin
      FilterMask := FilterBuf;
      FilterBuf := '';
    end;
    BarPos := AnsiPos('|', FilterBuf);
    Addr := AsPropertyName('[' + FilterMask + ']');
    if Addr <> '' then begin
      if fchInit then CreateStructItem(Component, PropertyType, FilterName, Addr)
                 else begin
        Addr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, Addr);
        if Addr <> '' then begin
          if Result = '' then Result := Addr + '|' + FilterMask
                         else Result := Result + '|' + Addr + '|' + FilterMask;

        end else begin
          if Result = '' then Result := FilterName + '|' + FilterMask
                         else Result := Result + '|' + FilterName + '|' + FilterMask;
        end;
      end;
    end;
  end;
  if fchInit then Result := InitFilter;
end;

procedure TLangManCPC.ChangeStrings(Component: TComponent; fchInit: boolean);
begin
{$IFDEF FIREDAC_GUI}
  if Component is TFDGUIxComponent then begin
    if TransProp(pnCaption) then begin
      if Component is TFDGUIxErrorDialog then begin
        (Component as TFDGUIxErrorDialog).Caption := ChangeStructItem(Component, PropIndex(pnCaption), (Component as TFDGUIxErrorDialog).Caption, fchInit);
      end;
      if Component is TFDGUIxLoginDialog then begin
        (Component as TFDGUIxLoginDialog).Caption := ChangeStructItem(Component, PropIndex(pnCaption), (Component as TFDGUIxLoginDialog).Caption, fchInit);
      end;
      if Component is TFDGUIxScriptDialog then begin
        (Component as TFDGUIxScriptDialog).Caption := ChangeStructItem(Component, PropIndex(pnCaption), (Component as TFDGUIxScriptDialog).Caption, fchInit);
      end;
    end;
    if Component is TFDGUIxAsyncExecuteDialog then begin
      if TransProp(pnCaption) then (Component as TFDGUIxAsyncExecuteDialog).Caption := ChangeStructItem(Component, PropIndex(pnCaption), (Component as TFDGUIxAsyncExecuteDialog).Caption, fchInit);
      if TransProp(pnPrompt) then (Component as TFDGUIxAsyncExecuteDialog).Prompt := ChangeStructItem(Component, PropIndex(pnPrompt), (Component as TFDGUIxAsyncExecuteDialog).Prompt, fchInit);
    end;
  end;
{$ENDIF}
{$IFDEF DATABASES}
 {$IFNDEF NEXTGEN}
  // TDSTableProducer .Caption, .Header, .Footer, .Columns >ALL
  if Component is TDSTableProducer then begin
    if TransProp(pnCaption) then
      (Component as TDSTableProducer).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TDSTableProducer).Caption,fchInit);
    if TransProp(pnHeader) then
      ChangeStructStrings(Component,PropIndex(pnHeader),(Component as TDSTableProducer).Header,fchInit);
    if TransProp(pnFooter) then
      ChangeStructStrings(Component,PropIndex(pnFooter),(Component as TDSTableProducer).Footer,fchInit);
    if TransProp(pnTabProducerColumns) then
      ChangeStructTableProducerColumns(Component,PropIndex(pnTabProducerColumns),fchInit);
  end;
 {$ENDIF}
{$ENDIF}

{$IFDEF DXE3}
  if Component is TContainedAction then begin
    if TransProp(pnHelpKeyword) then (Component as TContainedAction).HelpKeyword := ChangeStructItem(Component,PropIndex(pnHelpKeyword),(Component as TContainedAction).HelpKeyword,fchInit);
  end;
{$ENDIF}

end;

function TLangManCPC.BackToDesignedState: String;
var EngineBackup: TLangManCore;
begin
  Result := LMComponentLanguage;
  if Assigned(fLangManEngine) AND (fLangManEngine.DesignLanguageName = Result) then Result := '';
  if CSInitialized AND (Result <> '') AND (NOT DesignTime) then begin
    EngineBackup := fLangManEngine;
    fLangManEngine := nil;
    LMComponentLanguage := '';
    ControlChanges(false);  // back to Designing language
    fLangManEngine := EngineBackup;
    CSInitialized := false;
  end;
  DesignStruct.Clear;
end;

procedure TLangManCPC.TransParamsChanged;
begin
  if (NOT (csLoading in ComponentState)) AND (fLangManEngine <> nil) AND
     (fLangManEngine.IsInitialized) then RecreateTransStruct;
end;

procedure TLangManCPC.ChangeLanguage(Sender: TObject);
begin
  if (NOT DesignTime) then begin
    if (fLangManEngine = nil) then begin
      // pripadne odebrani enginu za behu programu
      BackToDesignedState;
      inherited ChangeLanguage(Sender);
    end else begin
      if Assigned(fLangManEngine) AND fLangManEngine.IsInitialized then begin
        if NOT CSInitialized then Init;
        if (DesignStruct.Count > 0) then ControlChanges(false);
        inherited ChangeLanguage(Sender);
      end;
    end;
  end;
end;

constructor TLangManCPC.Create(AOwner: TComponent);
begin
  LanguageOwner := '';
  fLangManEngine := nil;
  inherited Create(AOwner);
  DesignStruct := TComponentStructure.Create;
  ObjMap := TStringList.Create;
  CSInitialized := false;
end;

destructor TLangManCPC.Destroy;
begin
  DesignStruct.Free;
  ObjMap.Free;
  inherited Destroy;
end;

function TLangManCPC.AddComponent(Component: TComponent; Name: string; Translate: boolean): Boolean;
begin
  if Component.Owner = Owner then begin
    if Name <> '' then Component.Name := Name;
    ChangeStrings(Component, true);
    if Translate AND Assigned(LangManEngine) then ChangeStrings(Component, false);
    Result := true;
  end else Result := false;
end;

procedure TLangManCPC.UpdateClientStruct(TranslateItems: Boolean);
begin

end;

procedure TLangManCPC.RecreateTransStruct;
begin
  // Pokud byl pred zavolanim teto metody aktivni jazyk DesignedLanguage provede se
  //  pouze nova inicializace, jinak se provede inicializace i s prelozenim.
  if (BackToDesignedState = '') OR DesignTime OR (fLangManEngine = nil) OR
     (NOT fLangManEngine.IsInitialized) then begin
    if CSInitialized then ControlChanges(true)
                     else Init;
  end else ChangeLanguage(Self);
end;

procedure TLangManCPC.TranslateComponent(Component: TComponent; Name: string = '');
begin
  if (Name <> '') then Component.Name := Name;
  if (Component.Owner <> nil) AND Assigned(LangManEngine) then ChangeStrings(Component, false);
end;

procedure TLangManCPC.Translate;
begin
  if Assigned(fLangManEngine) then begin
    if NOT fLangManEngine.EngineInit then ChangeLanguage(Self);
  end;
end;

//+****************************************************************************
//+*  TLexicon class                                                         **
//+****************************************************************************

constructor TLexicon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetLength(Slaves, 1);
  Slaves[0] := nil;
end;

destructor TLexicon.Destroy;
begin
  SetLength(Slaves, 0);
  Slaves := nil;
  inherited Destroy;
end;

procedure RegisterLexSlave(Lex: TLexicon; SlaveProc: TLexiconSlave);
var SI, SL: Integer;
begin
  if Assigned(Lex) AND Assigned(Lex.Slaves) then begin
    SL := Length(Lex.Slaves);
    if SL > 0 then for SI := 0 to SL-1 do if @Lex.Slaves[SI] = @SlaveProc then Exit;
    SetLength(Lex.Slaves, SL + 1);
    Lex.Slaves[SL] := SlaveProc;
  end;
end;

procedure UnregisterLexSlave(Lex: TLexicon; SlaveProc: TLexiconSlave);
var SI, SL: Integer;
begin
  if Assigned(Lex) AND Assigned(Lex.Slaves) then begin
    SL := Length(Lex.Slaves);
    if SL > 0 then for SI := 0 to SL-1 do if @Lex.Slaves[SI] = @SlaveProc then begin
      while (SI < (SL-1)) do Lex.Slaves[SI] := Lex.Slaves[SI+1];
      SetLength(Lex.Slaves, SL - 1);
    end;
  end;
end;

procedure TLexicon.ChangeLanguage(Sender: TObject);
var SlaveIndex: Integer;
begin
  if DesignTime then Exit;
  if Length(Slaves) > 0 then for SlaveIndex := 0 to Length(Slaves) - 1 do begin
    if Assigned(Slaves[SlaveIndex]) then Slaves[SlaveIndex];
  end;
  inherited ChangeLanguage(Sender);
end;

function TLexicon.GetLink(Index: Integer): string;
begin
  Result := LINK_IDENT + NR_IDENT + IntToStr(Index) + STREDNIK;
end;

function TLexicon.CompleteString(const Str: string): string;
var Index, SLength, ItemNr, LinkLength: Integer;
    LocStr: String;
begin
  Result := '';
  LocStr := '';
{$IFDEF NEXTGEN}
  SLength := Length(Str) - 1;
  Index := -1;
{$ELSE}
  SLength := Length(Str);
  Index := 0;
{$ENDIF}
  if SLength > 0 then begin
    repeat
      Inc(Index);
      if (Str[Index] = LINK_IDENT) and ((Index+2) < SLength) and
         ((Str[Index+1] = NR_IDENT) OR (Str[Index+1] = SR_IDENT_ST)) then begin
        Inc(Index,2);
        if Str[Index-1] = NR_IDENT then begin
          LinkLength := 3;
          ItemNr := 0;
          repeat
            if ((Ord(Str[Index]) >= Ord('0')) and (Ord(Str[Index]) <= Ord('9'))) then begin
              ItemNr := (ItemNr * 10) + (Ord(Str[Index]) - Ord('0'));
              Inc(LinkLength);
            end else begin
              Index := Index + 2 - LinkLength;
              Result := Result + LINK_IDENT;
              LinkLength := -1;
              Break;
            end;
            Inc(Index);
          until Str[Index] = STREDNIK;
          if LinkLength > 0 then begin
            if (ItemNr > MaxIndex) or (NOT IsDefined(ItemNr))
              then Result := Result + BAD_LINK
              else Result := Result + GetItem(ItemNr);
            Continue;
          end;
        end else begin
          while (Index < SLength) AND
{$IFDEF NEXTGEN}
                ((Str[Index] <> SR_LINK_END[0]) OR (Str[Index+1] <> SR_LINK_END[1])) do begin
{$ELSE}
                ((Str[Index] <> SR_LINK_END[1]) OR (Str[Index+1] <> SR_LINK_END[2])) do begin
{$ENDIF}
            LocStr := LocStr + Str[Index];
            Inc(Index);
          end;
          if Index = SLength then Exit;  // nenalezen SR_LINK_END
          if LocStr <> '' then begin
            if LangManEngine <> nil then Result := Result + LangManEngine.TranslateString(LocStr, Self)
                                    else begin
              DecodeSpecialChars(LocStr);
              Result := Result + LocStr;
            end;
            LocStr := '';
            Inc(Index);
            Continue;
          end;
        end;
      end;
      Result := Result + Str[Index];
    until Index >= SLength;
  end;
end;

function TLexicon.IsDef(Index: Integer): boolean;
begin
  Result := IsDefined(Index);
end;

//+****************************************************************************
//+*  TCustomDesignedLexicon methods                                         **
//+****************************************************************************

function TCustomDesignedLexicon.GetItem(Index: Integer): string;
begin
  if IsDefined(Index) then begin
    if LangManEngine <> nil then Result := LangManEngine.TranslateString(fItems.Strings[Index], Self, Index)
                            else begin
      Result := fItems.Strings[Index];
      DecodeSpecialChars(Result);
    end;
  end else Result := '';
end;

function TCustomDesignedLexicon.MaxIndex: Integer;
begin
  Result := fItems.Count - 1;
end;

function TCustomDesignedLexicon.IsDefined(Index: Integer): Boolean;
begin
  Result := false;
  if (Index < fItems.Count) then begin
    if fItems.Strings[Index] <> '' then Result := true;
  end;
end;

function TCustomDesignedLexicon.IsDefined(LocStr: string): Boolean;
begin
  Result := fItems.IndexOf(LocStr) >= 0;
end;

procedure TCustomDesignedLexicon.SetItems(Value: TStringList);
begin
  if Assigned(fItems) then fItems.Assign(Value)
                      else fItems := Value;
end;

constructor TCustomDesignedLexicon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fItems := TStringList.Create;
end;

destructor TCustomDesignedLexicon.Destroy;
begin
  fItems.Free;
  inherited Destroy;
end;

function TCustomDesignedLexicon.GetLocStr(Index: Integer): String;
begin
  if Index < fItems.Count then Result := fItems.Strings[Index]
                          else Result := '';
end;

function TCustomDesignedLexicon.CreateItem(Text: string): Integer;
begin
  EncodeSpecialChars(Text);
  Result := fItems.Add(Text);
end;

function TCustomDesignedLexicon.CompleteString(const Str: string): string;
begin
  Result := inherited CompleteString(Str);
end;

//+****************************************************************************
//+*  TCustomProgrammableLexicon methods                                     **
//+****************************************************************************

procedure TCustomProgrammableLexicon.SetOnInitialization(Event: TNotifyEvent);
begin
  fOnInitialization := Event;
  if Assigned(fOnInitialization) then fOnInitialization(Self);
end;

function TCustomProgrammableLexicon.GetItem(Index: Integer): string;
begin
  if IsDefined(Index) then begin
    if LangManEngine <> nil then Result := LangManEngine.TranslateString(fIndexedItems.Get(Index), Self, Index)
                            else begin
      Result := fIndexedItems.Get(Index);
      DecodeSpecialChars(Result);
    end;
  end else Result := '';
end;

function TCustomProgrammableLexicon.MaxIndex: Integer;
begin
  Result := fIndexedItems.MaxIndex;
end;

constructor TCustomProgrammableLexicon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fIndexedItems := TIndexedItems.Create(Self.Name);
end;

destructor TCustomProgrammableLexicon.Destroy;
begin
  fIndexedItems.Free;
  inherited Destroy;
end;

procedure TCustomProgrammableLexicon.DefineItem(ItemNr: Word; Text: string);
begin
  if Text <> '' then begin
    EncodeSpecialChars(Text);
    fIndexedItems.Write(ItemNr, Text);
  end;
end;

function TCustomProgrammableLexicon.GetLocStr(Index: Integer): String;
begin
  if fIndexedItems.IsIncluded(Index) then Result := fIndexedItems.Get(Index)
                                     else Result := '';
end;

function TCustomProgrammableLexicon.IsDefined(Index: Integer): Boolean;
begin
  Result := false;
  if fIndexedItems.IsIncluded(Index) then begin
    if fIndexedItems.Get(Index) <> '' then Result := true;
  end;
end;

function TCustomProgrammableLexicon.IsDefined(LocStr: string): Boolean;
begin
  Result := fIndexedItems.IndexOf(LocStr) >= 0;
end;

function TCustomProgrammableLexicon.CompleteString(const Str: string): string;
begin
  Result := inherited CompleteString(Str);
end;

//+****************************************************************************
//+*  TLangFormLexicon methods                                               **
//+****************************************************************************

procedure TLangFormLexicon.LoadLang(StringArray: TInternalLangDefs);
var LI: Word;
begin
  fIntLang.Name := StringArray[-2];
  fIntLang.Code := StringArray[-1];
  for LI := 0 to LANGMANLANG_ITEMS do DefineItem(LI, StringArray[LI]);
end;

function TLangFormLexicon.InternalLanguages(Lang: TLanguage; Code: TISOCode; LoadDefs: Boolean = true): boolean;
begin
  Result := false;
  if NOT IsISO1(Code) then begin
    if Slovak(Lang) then Code := 'sk';
    // other internal langs
    if Czech(Lang) then Code := 'cs';
    if English(Lang) then Code := 'en';
  end;
  if IsISO1(Code) then begin
    if Code = 'en' then begin
      Result := true;
      if LoadDefs then LoadLang(ENGLISH_LANGMAN);
      Exit;
    end;
    if Code = 'cs' then begin
      Result := true;
      if LoadDefs then LoadLang(CZECH_LANGMAN);
      Exit;
    end;
    if Code = 'sk' then begin
      Result := true;
      if LoadDefs then LoadLang(SLOVAK_LANGMAN);
      Exit;
    end;
    if Code = 'it' then begin
      Result := true;
      if LoadDefs then LoadLang(ITALIAN_LANGMAN);
      Exit;
    end;
    // other internal langs
  end;
end;

constructor TLangFormLexicon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  GlobalLexicon := false;
  LoadLang(ENGLISH_LANGMAN);
  LangManEngine := TLangManCore(AOwner);
end;

function TLangFormLexicon.GetItem(Index: Integer): string;
begin
  if IsDefined(Index) then begin
    if (fLangManEngine <> nil) and (fLangManEngine.fIncludeLangMan)
     then Result := fLangManEngine.TranslateString(fIndexedItems.Get(Index), Self, Index)
     else Result := fIndexedItems.Get(Index);
  end else Result := '';
end;

//+****************************************************************************
//+*  TLangManStrings Class                                                  **
//+****************************************************************************

constructor TLangManStrings.Create(ControlledStrings: TStrings; Lexicon: TLexicon);
begin
  if ControlledStrings = nil then raise Exception.Create('ControlledStrings must be assigned!');
  if Lexicon = nil then raise Exception.Create('Lexicon must be assigned!');
  inherited Create;
  AssignedLexicon := Lexicon;
  Assign(ControlledStrings);
  Controlled := ControlledStrings;
  RegisterLexSlave(AssignedLexicon, Translate);
end;

destructor TLangManStrings.Destroy;
begin
  UnregisterLexSlave(AssignedLexicon, Translate);
  inherited Destroy;
end;

function TLangManStrings.Add(const S: string): Integer;
begin
  Result := inherited Add(S);
end;

function TLangManStrings.AddObject(const S: string; AObject: TObject): Integer;
begin
  Result := inherited AddObject(S, AObject);
  if Assigned(Controlled) then Result := Controlled.AddObject(AssignedLexicon.CompleteString(S),AObject);
end;

procedure TLangManStrings.Clear;
begin
  inherited Clear;
  if Assigned(Controlled) then Controlled.Clear;
end;

procedure TLangManStrings.Delete(Index: Integer);
begin
  inherited Delete(Index);
  Translate;
end;

procedure TLangManStrings.Exchange(Index1, Index2: Integer);
begin
  inherited Exchange(Index1, Index2);
  Translate;
end;

procedure TLangManStrings.Insert(Index: Integer; const S: string);
begin
  inherited Insert(Index, S);
end;

procedure TLangManStrings.InsertObject(Index: Integer; const S: string; AObject: TObject);
begin
  inherited InsertObject(Index, S, AObject);
  Translate;
end;

procedure TLangManStrings.CustomSort(Compare: TStringListSortCompare);
begin
  inherited CustomSort(Compare);
  Translate;
end;

procedure TLangManStrings.Translate;
var Line: Integer;
begin
  if Assigned(Controlled) then begin
    Controlled.Clear;
    if Count > 0 then for Line := 0 to Count - 1 do begin
      Controlled.Add(AssignedLexicon.CompleteString(Strings[Line]));
    end;
  end;
end;

//+****************************************************************************
//+*  LangMan TSpans                                                         **
//+****************************************************************************

constructor TSpans.Create;
begin
  Components := TLMComponentList.Create;
  Components.OwnsObjects := false;
end;
destructor  TSpans.Destroy;
begin
  Components.Free;
  Inherited;
end;
procedure TSpans.RegisterClient(Client: TComponent);
begin
  if Client <> nil then Components.Add(Client);
end;
procedure TSpans.UnregisterClient(Client: TComponent);
var ClientIndex: Integer;
begin
  ClientIndex := Components.IndexOf(Client);
  if ClientIndex >= 0 then Components.Extract(Client);
end;
procedure TSpans.CallClientProcs;
var ClientIndex: Integer;
begin
  if Components.Count > 0 then begin
    for ClientIndex := 0 to Components.Count - 1 do
      if Components.Items[ClientIndex] is TLangManComponent then
        (Components.Items[ClientIndex] as TLangManComponent).ChangeLanguage(Self);
  end;
end;
procedure TSpans.InitClients;
var ClientIndex: Integer;
begin
  if Components.Count > 0 then begin
    for ClientIndex := 0 to Components.Count - 1 do
      if Components.Items[ClientIndex] is TLangManComponent
        then (Components.Items[ClientIndex] as TLangManComponent).Init;
  end;
end;
procedure TSpans.InitToLanguage(InitLanguage: TLanguage; IsDesignLang: Boolean);
var ClientIndex: Integer;
    LMComp: TLangManComponent;
begin
  if Components.Count > 0 then begin
    for ClientIndex := 0 to Components.Count - 1 do
      if Components.Items[ClientIndex] is TLangManComponent then begin
        LMComp := TLangManComponent(Components.Items[ClientIndex]);
        if InitLanguage <> LMComp.LMComponentLanguage then begin
          if IsDesignLang AND (LMComp.LMComponentLanguage = '')
            then LMComp.LMComponentLanguage := InitLanguage
            else LMComp.ChangeLanguage(Self);
        end;
      end;
  end;
end;
procedure TSpans.PrepareForDesignTimeEdit;
var ClientIndex: Integer;
begin
  for ClientIndex := 0 to Components.Count - 1 do begin
    if Components.Items[ClientIndex] is TLangManComponent then begin
      TLangManComponent(Components.Items[ClientIndex]).PrepareForDesignTimeEdit;
    end;
  end;
end;
function TSpans.GetClientByStructLine(const StructItem: TFullStructLine): TLangManCPC;
var ClientIndex, DotPos: Integer;
    Client: TLangManCPC;
begin
  Result := nil;
  if Components.Count > 0 then begin
    for ClientIndex := 0 to Components.Count - 1 do begin
      if Components.Items[ClientIndex] is TLangManCPC then begin
        Client := TLangManCPC(Components.Items[ClientIndex]);
        DotPos := Client.DesignStruct.Find(StructItem);
        if DotPos >= 0 then begin
          Result := Client;
          Exit;
        end;
      end;
    end;
  end;
end;
function TSpans.GetListByName(const ListName: String): TLMList;
var SpanIndex: Integer;
begin
  Result := nil;
  if Components.Count > 0 then begin
    for SpanIndex := 0 to Components.Count - 1 do begin
      if Components.Items[SpanIndex] is TLMList then begin
        if GetLexiconName(Components.Items[SpanIndex]) = ListName then begin
          Result := TLMList(Components.Items[SpanIndex]);
          Exit;
        end;
      end;
    end;
  end;
end;
function TSpans.SpanName(Index: Integer): String;
begin
  if (Index < 0) OR (Index >= Components.Count) then Result := ''
                                                else Result := GetSpanComponentName(Components.Items[Index]);
end;
function TSpans.IsRegistered(const StructItem: TFullStructLine): Boolean;
begin
  Result := nil <> GetClientByStructLine(StructItem);
end;
function TSpans.IsRegistered(const ByName: String): Boolean;
var SpanIndex: Integer;
begin
  Result := false;
  if Components.Count > 0 then begin
    for SpanIndex := 0 to Components.Count - 1 do begin
      if GetSpanComponentName(Components.Items[SpanIndex]) = ByName then begin
        Result := true;
        Exit;
      end;
    end;
  end;
end;

initialization
  LangManMulti := TStringList.Create;
finalization
  LangManMulti.Free;
  DivertBack;
end.
