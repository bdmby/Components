//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManComp.pas                                             **
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

unit LangManComp;

{$DEFINE LMCOMP}
{$WARNINGS OFF}
{$INCLUDE LM_Config.inc}

interface

uses LangManVCLCompat, 

{$IFDEF DXE2}
     Winapi.Windows, Winapi.Messages, Vcl.Forms, Vcl.Stdctrls, Vcl.Controls, 
     Vcl.Menus, Vcl.Graphics, Vcl.ImgList, Vcl.ComCtrls, Vcl.Extctrls,
     Vcl.FileCtrl, Vcl.Dialogs,

     Vcl.CategoryButtons, Vcl.ButtonGroup,
     Vcl.Touch.GestureCtrls,

     {$IFDEF DATABASES}
     Vcl.DBCtrls, Vcl.DBGrids,
     {$ENDIF}

     {$IFDEF RIBBONS}
     Vcl.ScreenTips,
     {$ENDIF}

     {$IFDEF WIN3_1}
     Vcl.Outline, Vcl.Samples.DirOutLn,
     {$ENDIF}
{$ELSE}
     Windows, Messages, Forms, Stdctrls, Controls, Menus, Graphics,
     ImgList, ComCtrls, Extctrls, FileCtrl, Dialogs,

     {$IF CompilerVersion > 18}
     CategoryButtons, ButtonGroup,
     {$IFEND}

     {$IFDEF D2010}
     GestureCtrls,
     {$ENDIF}

     {$IFDEF DATABASES}
     DBCtrls, DBGrids,
     {$ENDIF}

     {$IFDEF RIBBONS}
     ScreenTips,
     {$ENDIF}

     {$IFDEF WIN3_1}
     Outline, DirOutLn,
     {$ENDIF}
{$ENDIF}

     SysUtils, Classes, Contnrs,
     LangManSys, LangManCore, LangManCtrls, LangManVCLEditor, LMVCLAdditions;

{$WARNINGS ON}

const
  AllVCLStringProperties = [pnCaption, pnHint,
{$IF CompilerVersion > 19}
                            pnTextHint,
{$IFEND}
{$IF CompilerVersion > 18}
                            pnEditLabelHint, pnEditLabelCaption,
                            pnBalloonHint, pnBalloonTitle,
{$IFEND}
                            pnText, pnTitle, pnValueName, pnHelpKeyword,
                            pnSimpleText, pnFileNameLabel, pnOkButtonLabel,
{$IF CompilerVersion > 17}
                            pnExpandButtonCaption, pnExpandedText, pnFooterText,
                            pnVerificationText,
{$IFEND}
{$IFDEF FIREDAC_GUI}
                            pnPrompt,
{$ENDIF}
                            pnDialogCaption, pnHeaderTitle];

  //trans Properties from TStringProperties where are default allowed for translate
  TranslateStringPropertiesDefault = AllVCLStringProperties - [pnHelpKeyword, pnSimpleText];

  HINT_PROPERTIES = [pnHint, pnTextHint, pnEditLabelHint, pnBalloonHint];

  AllVCLTStringsProperties = [pnLines, pnItems, pnTitleCaptions, pnTabs, pnPages,
{$IFDEF DATABASES}
                              pnHeader, pnFooter,
{$ENDIF}
{$IFDEF SYNEDIT}
                              pnInsertList, pnItemList, pnAutoCompleteList,
{$ENDIF}
                              pnSections];

  //trans Properties from TTStringsProperties where are default allowed for translate
  TranslateTStringsPropertiesDefault = [pnLines, pnItems, pnTitleCaptions, pnTabs,
                                        pnPages,
{$IFDEF DATABASES}
                                        pnHeader, pnFooter,
{$ENDIF}
                                        pnSections];

  AllVCLStructuredProperties = [pnPanels, pnBands,
{$IF CompilerVersion > 18}
                                pnButtonCategories, pnGrpButtonItems,
{$IFEND}
{$IF CompilerVersion > 19}
                                pnListGroups,
{$IFEND}
                                pnTreeItems, pnListColumns, pnListItems,
                                pnHeaderSections,
{$IFDEF DATABASES}
                                pnDBGridTitleCaptions,
{$ENDIF}
{$IFDEF WIN3_1}
                                pnOutlineItems,
{$ENDIF}
                                pnTabProducerColumns,
{$IF CompilerVersion > 17}
                                pnButtons, pnRadioButtons,
{$IFEND}
{$IFDEF LM_UNIGUI}
                                pnMessages,
{$ENDIF}
{$IFDEF D2010}
                                pnKeyCaptions,
{$ENDIF}
                                pnFileTypes];

  //trans Properties from TStructuredProperties where are default allowed for translate
  TranslateStructuredPropertiesDefault = AllVCLStructuredProperties - [pnPanels,
                                                                       pnTreeItems,
                                                                       pnListItems];


  AllVCLOtherProperties = [pnFilter, cnTActionManager
{$IFDEF RAVE}
                           , cnRvProject, cnRvSystem, cnRvRender, pnPDF_DocInfo
{$ENDIF}
{$IFDEF TEECHART}
                           , cnTChart
{$ENDIF}
{$IFDEF D2010}
                           , cnTGestureManager
{$ENDIF}
{$IFDEF RIBBONS}
                           , cnTScreenTipItem
{$ENDIF}
{$IFDEF LM_UNIGUI}
                           , cpnScreenMask, cnTUniCalendarPanel, pnDateFormat,
                           pnTimeFormat
{$IFDEF DATABASES}
                           , pnWebOptions
{$ENDIF}
{$ENDIF}
                          ];

  //trans Properties from TOtherProperties where are default allowed for translate
  TranslateOtherPropertiesDefault = AllVCLOtherProperties - [cnTGestureManager];

type
  TFlagAssignAs = (fasNone, fasBitmap, fasIcon);

  TTranslateStringProperties = set of TStringProperties;
  TTranslateTStringsProperties = set of TTStringsProperties;
  TTranslateStructuredProperties = set of TStructuredProperties;
  TTranslateOtherProperties = set of TOtherProperties;

//+****************************************************************************
//+*  LangMan Component classes                                              **
//+****************************************************************************

  TDesignedLexicon = class( TCustomDesignedLexicon );
  TProgrammableLexicon = class( TCustomProgrammableLexicon );

  TLangManEngine = class( TLangManCore )
  private
    fLanguageMenu         : TMenuItem;
    fDesignLangFlag       : TPicture;
    ApplicationOnActivate : TNotifyEvent;

    procedure SetLanguageMenu(MenuItem: TMenuItem);
    procedure SetDesignLangFlag(FlagImage: TPicture);

  protected
    FlagsList             : TImageList;

    procedure SetLangMenuFlags(Input: boolean); override;
    function ReCreateLangMenus: Boolean; override;
    procedure RefreshLangList(GUIComponent: TComponent; LangIndex: Integer); override;
    function LangFilesPath: String; override;
    procedure LoadFlagIcon(FlagStream: TMemoryStream; reqFlag: TFlagReq); override;

    procedure DesignLangFlagChanged(Sender: TObject);
    procedure LangMenuClick(Sender: TObject);
    procedure ChangeLangMenu(MenuItem: TMenuItem); virtual;
    function EditorDisabled: Boolean; override;
    procedure ApplicationRun(AOwner: TObject);

    procedure UnregisterClient(ClientComponent: TComponent); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function AssignFlag(Pict: TPicture; FlagIndex: Integer): TFlagAssignAs;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property LangMenuFlags;
    property LanguageMenu: TMenuItem read fLanguageMenu write SetLanguageMenu;
    property DesignLangFlag: TPicture read fDesignLangFlag write SetDesignLangFlag;
  end;

  TAdditionSet = set of TAdditionProperties;

  TLangManClient = class( TLangManCPC )
  private
    fTransStringProp     : TTranslateStringProperties;
    CmpTransStringProp   : TTranslateStringProperties;
    fTransTStringsProp   : TTranslateTStringsProperties;
    CmpTransTStringsProp : TTranslateTStringsProperties;
    fTransStructuredProp : TTranslateStructuredProperties;
    CmpTransStructuredProp : TTranslateStructuredProperties;
    fTransOtherProp      : TTranslateOtherProperties;
    CmpTransOtherProp    : TTranslateOtherProperties;
    fTransAdditions      : TAdditionSet;

    procedure UnsupportedWarning;
    procedure SetTransStringProp(Input: TTranslateStringProperties);
    procedure SetTransTStringsProp(Input: TTranslateTStringsProperties);
    procedure SetTransStructuredProp(Input: TTranslateStructuredProperties);
    procedure SetTransOtherProp(Input: TTranslateOtherProperties);
    procedure SetTransAdditions(Input: TAdditionSet);

    procedure ChangeActionClientItems(Component: TComponent; fchInit: boolean);
    procedure ChangeStructPanels(Component: TComponent; PropertyType : Word; Data: TStatusPanels; fchInit: boolean);
    procedure ChangeStructBands(Component: TComponent; PropertyType : Word; Data: TCoolBands; fchInit: boolean);
  {$IF CompilerVersion > 18}
    procedure ChangeStructCategories(Component: TComponent; PropertyType : Word; Data: TButtonCategories; fchInit: boolean);
    procedure ChangeStructButtonsGrp(Component: TComponent; PropertyType : Word; Data: TGrpButtonItems; fchInit: boolean);
  {$IFEND}
    procedure ChangeStructTreeNodes(Component: TComponent; PropertyType : Word; Data: TTreeNodes; fchInit: boolean);
    procedure ChangeStructListColumns(Component: TComponent; PropertyType : Word; Data: TListColumns; fchInit: boolean);
  {$IF CompilerVersion > 19}
    procedure ChangeStructListGroups(Component: TComponent; PropertyType : Word; Data: TListGroups; fchInit: boolean);
  {$IFEND}
    procedure ChangeStructListItems(Component: TComponent; PropertyType : Word; Data: TListItems; fchInit: boolean);
    procedure ChangeStructHeaderSections(Component: TComponent; PropertyType : Word; Data: THeaderSections; fchInit: boolean);
  {$IFDEF DATABASES}
    procedure ChangeStructDBTitleCaptions(Component: TComponent; PropertyType : Word; Data: TDBGridColumns; fchInit: boolean);
  {$ENDIF}
  {$IFDEF WIN3_1}
    procedure ChangeStructOutlineItems(Component: TComponent; PropertyType : Word; Outline: TCustomOutline; fchInit: boolean);
  {$ENDIF}
  {$IFDEF D2010}
    procedure ChangeKeyCaptions(Component: TComponent; PropertyType: Word; fchInit: boolean);
    procedure ChangeGestureNames(Component: TComponent; PropertyType: Word; Gestures: TGestureArray; GesturesTotal: Integer; fchInit: boolean);
  {$ENDIF}
    procedure ChangeStructFileTypes(Component: TComponent; PropertyType: Word; Data: TFileTypeItems; fchInit: boolean);
  {$IF CompilerVersion > 17}
    procedure ChangeStructTaskDlgButtons(Component: TComponent; PropertyType: Word; Data: TTaskDialogButtons; fchInit: boolean);
  {$IFEND}
  {$IFDEF RAVE}
    procedure ChangeStructRaveProject(Component: TComponent; PropertyType : Word; fchInit: boolean);
    procedure ChangeStructRaveSystem(Component: TComponent; PropertyType : Word; fchInit: boolean);
  {$ENDIF}
  {$IFDEF TEECHART}
    procedure ChangeStructCustomAxes(Component: TComponent; PropertyType : Word; Data: TCollection; fchInit: boolean; PresetAddr: string);
  {$ENDIF}
  {$IFDEF RIBBONS}
    procedure ChangeScreenTip(Component: TComponent; PropertyType: Word; ScreenTip: TScreenTipItem; fchInit: Boolean; SubItem: Integer = -1);
    procedure RibbonClient(Component: TComponent; fchInit: boolean);
  {$ENDIF}
  protected
    function TransProp(Prop: TStringProperties): Boolean; overload; override;
    function TransProp(Prop: TTStringsProperties): Boolean; overload; override;
    function TransProp(Prop: TStructuredProperties): Boolean; overload; override;
    function TransProp(Prop: TOtherProperties): Boolean; overload; override;
    function PriorityAbsorption(Component: TComponent; InterestClass: TClass): boolean; virtual;
    function TransComp(Component: TComponent; ChClass: TClass): Boolean; virtual;
    function TransCompProp(Component: TComponent; ChClass: TClass; Prop: TStringProperties): Boolean; overload;
    function TransCompProp(Component: TComponent; ChClass: TClass; Prop: TTStringsProperties): Boolean; overload;
    function TransCompProp(Component: TComponent; ChClass: TClass; Prop: TStructuredProperties): Boolean; overload;
    function TransCompProp(Component: TComponent; ChClass: TClass; Prop: TOtherProperties): Boolean; overload;

    function NotLinkedToAction(PropertyType : Word; const CompStr, ActionStr: string): Boolean; override;
    procedure ChangeStrings(Component: TComponent; fchInit: boolean); override;
    procedure ControlChanges(fchInit: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    function AddComponent(Component: TComponent; Name: string; Translate: boolean): Boolean; override;
    procedure TranslateComponent(Component: TComponent; Name: string = ''); override;
  published
{$IFDEF LMSMART}
    property GlobalLexicon;
{$ENDIF}
    property TransStringProp: TTranslateStringProperties read fTransStringProp write SetTransStringProp default TranslateStringPropertiesDefault;
    property TransTStringsProp: TTranslateTStringsProperties read fTransTStringsProp write SetTransTStringsProp default TranslateTStringsPropertiesDefault;
    property TransStructuredProp: TTranslateStructuredProperties read fTransStructuredProp write SetTransStructuredProp default TranslateStructuredPropertiesDefault;
    property TransOtherProp: TTranslateOtherProperties read fTransOtherProp write SetTransOtherProp default TranslateOtherPropertiesDefault;
    property TransAdditions: TAdditionSet read fTransAdditions write SetTransAdditions default DefaultEnabled;
  end;

  // New in v.1.2.0 21.1.2012
  TLMStringStyle = record
    Color: TColor;
    Font: TFontName;
    Charset: TFontCharset;
    Style: TFontStyles;
    Size: Integer;
    Pitch: TFontPitch;
  end;
  TLMStringStyles = array of TLMStringStyle;

  // New in v.1.2.0 21.1.2012
  TLangManRichEdit = class(TCustomRichEdit)
{$IFNDEF LMCPP}
{$IFDEF DXE2}
  strict private
    class constructor Create;
{$ENDIF}
{$IFDEF DXE3}
    class destructor Destroy;
{$ENDIF}
{$ENDIF}
  private
    LMLines: TStringList;
    fAssignedLexicon: TLexicon;
    fAutoFont: Boolean;
    AutoFontSetup: Boolean;
    Styles: TLMStringStyles;
    procedure LexiconAssign(Lexicon: TLexicon);
    procedure SetupFont(Style: ShortInt);
    function WriteFormattedText(const Text: String; WrittingPosition: Integer): Integer;
    function GetLineStart(LineIndex: Integer): Integer;
    function SelLine(LineIndex: Integer; IncludeCRLF: Boolean = false): Boolean;
    function GetAutoFont: Boolean;
    function GetLink(Index: Integer): String;
    procedure SetAutoFont(const Value: Boolean);
{$IFDEF LMULT}
    function GetSLink(LocStr: String): string;
{$ENDIF}
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override; //ReadOnly:= true;
    destructor Destroy; override;
    procedure AssignStyles(LMStringStyles: TLMStringStyles);
    procedure ClearStyles;
    function GetStyles: TLMStringStyles;
    function StylesCount: Integer;
    function SetStyle(Style: TFontStyles; Size: Integer = 0; Color: TColor = clDefault; FontName: TFontName = ''; Charset: TFontCharset = DEFAULT_CHARSET; Pitch: TFontPitch = fpDefault; StyleIndex: ShortInt = -1): Integer;
    function Format(const Text: String; StyleIndex: ShortInt): String;
    procedure Write(const Text: String; StyleIndex: ShortInt = -1);
    procedure WriteLn(const Text: String; StyleIndex: ShortInt = -1);
    procedure NextLine;
    procedure Clear; override;
    function LinesCount: Integer;
    function ReadLineText(LineIndex: Integer): String;
    function ReadLineFText(LineIndex: Integer): String;
    procedure DeleteLine(LineIndex: Integer);
    procedure RewriteLine(LineIndex: Integer; const Text: String; StyleIndex: ShortInt = -1);
    procedure InsertLine(LineIndex: Integer; const Text: String; StyleIndex: ShortInt = -1);
    procedure Translate;
{$IF CompilerVersion > 19}
    procedure LoadFromFile(const SourceFile: TFileName); overload;
    procedure LoadFromFile(const SourceFile: TFileName; Encoding: TEncoding); overload;
    procedure LoadFromStream(SourceStream: TStream); overload;
    procedure LoadFromStream(SourceStream: TStream; Encoding: TEncoding); overload;
    procedure SaveRichTextToFile(const DestinationFile: TFileName); overload;
    procedure SaveRichTextToFile(const DestinationFile: TFileName; Encoding: TEncoding); overload;
    procedure SaveRichTextToStream(DestinationStream: TStream); overload;
    procedure SaveRichTextToStream(DestinationStream: TStream; Encoding: TEncoding); overload;
    procedure SaveEncodedFormToFile(const DestinationFile: TFileName); overload;
    procedure SaveEncodedFormToFile(const DestinationFile: TFileName; Encoding: TEncoding); overload;
    procedure SaveEncodedFormToStream(DestinationStream: TStream); overload;
    procedure SaveEncodedFormToStream(DestinationStream: TStream; Encoding: TEncoding); overload;
{$ELSE}
    procedure LoadFromFile(const SourceFile: TFileName);
    procedure LoadFromStream(SourceStream: TStream);
    procedure SaveRichTextToFile(const DestinationFile: TFileName);
    procedure SaveRichTextToStream(DestinationStream: TStream);
    procedure SaveEncodedFormToFile(const DestinationFile: TFileName);
    procedure SaveEncodedFormToStream(DestinationStream: TStream);
{$IFEND}
{$IFDEF LMULT}
    property SLink [LocalizableString: String]: string read GetSLink;
{$ENDIF}
    property Link [Index: Integer]: string read GetLink;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AssignedLexicon: TLexicon read fAssignedLexicon write LexiconAssign;
    property AutoFont: Boolean read GetAutoFont write SetAutoFont default True;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property HideScrollBars;
    property ImeMode;
    property ImeName;
    property Constraints;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PlainText;
    property PopupMenu;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
{$IFDEF D2010}
    property Touch;
    property OnGesture;
{$ENDIF}
    property Visible;
    property WantTabs;
    property WantReturns;
    property WordWrap default False;
{$IFDEF DXE3}
    property StyleElements;
{$ENDIF}
    property OnChange;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnProtectChange;
    property OnResizeRequest;
    property OnSaveClipboard;
    property OnSelectionChange;
    property OnStartDock;
    property OnStartDrag;
{$IF CompilerVersion > 18}
    property OnMouseActivate;
    property OnClick;
    property OnDblClick;
    property OnMouseEnter;
    property OnMouseLeave;
{$IFEND}
  end;

  TLangComboStyle = (scDropDownList, scOwnerDrawFixed, scOwnerDrawVariable);

  TLangCombo = class (TCustomComboBox)
{$IFNDEF LMCPP}
{$IFDEF DXE2}
  strict private
    class constructor Create;
{$ENDIF}
{$IFDEF DXE3}
    class destructor Destroy;
{$ENDIF}
{$ENDIF}
  private
    fLangManEngine : TLangManEngine;
    fOnChangeLanguage: TNotifyEvent;
    procedure SetLangManEngine(LangMan: TLangManEngine);
    function GetStyleCombo: TLangComboStyle;
    procedure SetStyleCombo(Input: TLangComboStyle);
    procedure ChangeLanguage(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LangManEngine: TLangManEngine read fLangManEngine write SetLangManEngine;
    property StyleCombo: TLangComboStyle read GetStyleCombo write SetStyleCombo;
    property Align;
    property Anchors;
    property AutoCloseUp default False;
    property AutoComplete default True;
  {$IF CompilerVersion > 18}
    property AutoCompleteDelay default 500;
  {$IFEND}
  {$IF CompilerVersion > 19}
    property ParentDoubleBuffered;
  {$IFEND}
    property AutoDropDown default False;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
{$IFDEF D2010}
    property Touch;
    property OnGesture;
{$ENDIF}
    property Visible;
{$IFDEF DXE3}
    property StyleElements;
{$ENDIF}
    property OnChangeLanguage: TNotifyEvent read fOnChangeLanguage write fOnChangeLanguage;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
  {$IF CompilerVersion > 18}
    property OnMouseEnter;
    property OnMouseLeave;
  {$IFEND}
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
  end;

  TLangFlagsCombo = class(TCustomComboBoxEx)
{$IFNDEF LMCPP}
{$IFDEF DXE2}
  strict private
    class constructor Create;
{$ENDIF}
{$IFDEF DXE3}
    class destructor Destroy;
{$ENDIF}
{$ENDIF}
  private
    fLangManEngine : TLangManEngine;
    fOnChangeLanguage: TNotifyEvent;
    procedure SetLangManEngine(LangMan: TLangManEngine);
    procedure ChangeLanguage(Sender: TObject);
  protected
    function GetItemHt: Integer; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LangManEngine: TLangManEngine read fLangManEngine write SetLangManEngine;
    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
//    property ItemHeight;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
  {$IF CompilerVersion > 19}
    property ParentDoubleBuffered;
  {$IFEND}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
{$IFDEF D2010}
    property Touch;
    property OnGesture;
{$ENDIF}
    property Visible;
    property OnChangeLanguage: TNotifyEvent read fOnChangeLanguage write fOnChangeLanguage;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseMove;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
    property DropDownCount;
  end;

  TLangFlag = class(TImage)
  private
    fLangManEngine : TLangManEngine;
    procedure SetLangManEngine(LangMan: TLangManEngine);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LangManEngine: TLangManEngine read fLangManEngine write SetLangManEngine;
    property Transparent default true;
    property Center default true;
    property Picture stored false;
  end;

{$IFDEF LMSMART}
{$I LMResHack}
{$ENDIF}

{$IFDEF LMULT}
{$I LMInline}
{$ENDIF}

 function HaveHint(Component: TPersistent): Boolean;

 procedure RegisterProperty(Component: TComponent; PropertyValue: String; PropertyID: TAdditionProperties; ItemAddr: String = ''); overload;
 procedure RegisterProperty(Component: TComponent; PropertyValue: String; PropertyID: TStringProperties; ItemAddr: String = ''); overload;
 procedure RegisterProperty(Component: TComponent; PropertyValue: String; PropertyID: TTStringsProperties; ItemAddr: String = ''); overload;
 procedure RegisterProperty(Component: TComponent; PropertyValue: String; PropertyID: TStructuredProperties; ItemAddr: String = ''); overload;
 procedure RegisterProperty(Component: TComponent; PropertyValue: String; PropertyID: TOtherProperties; ItemAddr: String = ''); overload;

 function TranslateProperty(Component: TComponent; PropertyValue: String; PropertyID: TAdditionProperties; ItemAddr: String = ''): String; overload;
 function TranslateProperty(Component: TComponent; PropertyValue: String; PropertyID: TStringProperties; ItemAddr: String = ''): String; overload;
 function TranslateProperty(Component: TComponent; PropertyValue: String; PropertyID: TTStringsProperties; ItemAddr: String = ''): String; overload;
 function TranslateProperty(Component: TComponent; PropertyValue: String; PropertyID: TStructuredProperties; ItemAddr: String = ''): String; overload;
 function TranslateProperty(Component: TComponent; PropertyValue: String; PropertyID: TOtherProperties; ItemAddr: String = ''): String; overload;

implementation

uses Types,
{$IFDEF DATABASES}
{$IFDEF INTERBASE}
{$IFDEF DXE6}
     IBX.IBFilterDialog,
{$ELSE}
     IBFilterDialog,
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$IFDEF DXE2}
     Winapi.RichEdit, Vcl.Buttons, Vcl.ValEdit,
     Vcl.ActnList, Vcl.Tabs, Vcl.StdActns, Vcl.ExtActns, Vcl.Themes,

     System.UITypes,

     {$IFDEF DXE3}
     System.Actions,
     {$ENDIF}
     Vcl.ActnMan, Vcl.CustomizeDlg,

     Vcl.Touch.Keyboard, Vcl.Touch.GestureMgr

     {$IFDEF RIBBONS},
     Vcl.Ribbon, Vcl.RibbonActnCtrls, Vcl.RibbonConsts
     {$ENDIF}

     {$IFDEF WIN3_1},
     Vcl.TabNotBk
     {$ENDIF}

     {$IFDEF TEECHART},
     VCLTee.Chart, VCLTee.TeEngine
     {$ENDIF}

{$ELSE}
     RichEdit, Buttons, ValEdit, ActnList, Tabs, StdActns, ExtActns,

     ActnMan, CustomizeDlg

     {$IFDEF RIBBONS},
     Ribbon, RibbonActnCtrls, RibbonConsts
     {$ENDIF}

     {$IFDEF WIN3_1},
     TabNotBk
     {$ENDIF}

     {$IFDEF TEECHART},
     Chart, TeEngine
     {$ENDIF}

     {$IFDEF D2010},
     Keyboard,
     GestureMgr
     {$ENDIF}

{$ENDIF}

     {$IFDEF RAVE},
     RpRave, RpSystem, RpFiler, RpRender, RpRenderPDF, RvClass, RvProj, RvCsStd
     {$ENDIF}
     {$IFDEF SYNEDIT},
       SynEditExport,
       SynEditHighlighter,
       SynEditAutoComplete,   // musi byt pred SynCompletionProposal kvuli duplicite TSynAutoComplete
       SynCompletionProposal,
       SynEditPrint
     {$ENDIF};

const
  LMCTR16 =  'BM+.(+!,&+.!)&*0!)&$()(!,&()"*&)0!)&(+!(&$()+#((3!2&!)77!)45!)55!)54!,52!)51!)24!)20!)51!,52!)53!)55!)46!)2/*.)5)/*/**)7!(*1*0!)+-!)<A!(?<98*, )5*3*/*++/+.+-!)9!(+.!)+-+,!(*3*2*+ #()4+**,4.343/"(74737*6,5675656.#(77#(7*647.75717-6-565/57' +
             '$(515+6-55$(6)5.5)635164545,6)5)4370616+71666.0+0)/77.7*65373-3+5+424/6*54525-4745222)120.0(vup!(mjkm!(f020-0.212-2*4*3430"(7473060200!)4/7-7(66525-5(424,4*$(56!(556)564,3531/7zu4/#(3420"(5.07351,6)44210(}w4)313+47434.!)5,!)77!)/7"(74736' +
             '4606.!)6763!(6/5(414-"(11107*420+510*#(&5/0.774+M2-2*1567606.07!(06!/772(1211!)7/"(74!*73666/6-CGP6/4-03#(4(v&{(-7-34[2+2)2(m!(l!)6.!2771)1(060)!(0(xyz0001022-223+55350.3)h&3-r(*5,13@4+4)372+2,2-!(2627!)36!2774(343.7745/76)23Y532-S3*x*)2' +
             '3l(625o(720k(5441/G6+3(`572*M675/3)!2773)232+4)0)*+1/S#(&12X16_(*2*g(72)f)(2(d(3#(12Y"(&X1/I&4323~!27726212*25l)-0+=#)&0-B06O1/]#((31.[1+X(.0/D#)&0.C~+(3616t!2773.3+3(5533073713m4-2)t13l+)0*E#(()0.K02R(3301+f4,2*w4)10q504/3*!277!(46473.3' +
             '135263*3/2-3(34352*0,n*3#(&v82/s93-324)22263,3)3-314)4*4,!877!)7+20243(271)nd*+#(&i*42,p8141311!)62!A7733364)4-2/00~?)50,I)43301W242321!D775+!(5,3*27252/2)"(172-143.3)25!)3-!/77';

  LMETR16 =  'BM+.(+!,&+.!)&*0!)&$()(!,&()"*&)0!)&(+!(&$()+#((3!2&!)77!)45!)55!)52!)5.!,5-!)22!)2/!)50!,52!)53!)55!)46!)2/*.)5)/*/**)7!(*1*0!)++!)9?!(=8+/+.*+)7)4*2*.**+/+.+-!)9!(+.!)+-+,!(*3*2*+ #()4+**,4.343/"(747367#(6)537(526+505*313*273,3)264+363' +
             '05,4740#(7*626-6.6)7065")6-7.555-47#(71626,666.0+0)/77.7*65353+3)474.4+2-2)17xwvu$(oj~y030,}121)022*1*014035305-5(4447404,"(7473060200!)4/7-7(66505+46404*4(2,!(2+!)7-0.0,0*smg01/7z222*16424,4+262.171.1(0-4/37315(444/!)5,!)77!)/7"(74736)5' +
             '553!)6,31!(30!)3,+/+.+,1)030.2(131/!)4/5+!(5*5/5,5(77717.1,!(1+!/772(1211!)72!)7+!)4/l!(k!)H*/*.*-!)2726!(23!)5(!)72y!(x!)7+!2771/"(1.1,!(1-!)x!)m!)j!)<!(8+/!)3+!)5,37!(34!)61!>77!)6+!)0(!)g!)*1!))5"(0706!)z!)60!A77!)5(!)s!)c!)00!)[!)3*!' +
             ')50!D77!)21!)55!)2+!)*0!)Z!)4,!)55!D77!)24!)3(!)+)!)*-!)}!)5*!D77!)4-!)56!)07!)*.!)*4!)27!)57!D77!)3.!)52!)/7!)*,!)]!)6)!G77!)3-!)6(!)0-!)d!)4+!J77!)4.!)3)!)34!)35';

  {$IFDEF DATABASES} DBPC = 3; {$ELSE} DBPC = 0; {$ENDIF}
  {$IFDEF WIN3_1} WIN31 = 1; {$ELSE} WIN31 = 0; {$ENDIF}
  {$IF CompilerVersion > 18} CLB = 1; {$ELSE} CLB = 0; {$IFEND}
  {$IFDEF D2010} U210 = 1; {$ELSE} U210 = 0; {$ENDIF}

  // Classes priority: Second class of pair have higher priority (Tøídu s indexem 0 pøebíjí tøída s indexem 1)
  PriorityArray: array[0..6 + CLB + DBPC + WIN31 + U210] of TPriority =
                                             ((TCustomLabel,TValuedLabel),
                                              (TCustomEdit,TCustomMemo),
                                              (TCustomCombo,TLangCombo),
                                              (TCustomCombo,TLangFlagsCombo),
                                              (TCustomCombo,TColorBox),
                                             {$IF CompilerVersion > 18}
                                              (TCustomListBox,TColorListBox),
                                             {$IFEND}
                                             {$IFDEF D2010}
                                              (TCustomListView,TCustomGestureListView),
                                             {$ENDIF}
                                              (TCustomMemo,TCustomRichEdit),
                                              (TCustomCombo,TFilterComboBox)
                                             {$IFDEF DATABASES},
                                              (TCustomLabel,TDBText),
                                              (TCustomEdit,TDBEdit),
                                              (TCustomMemo,TDBMemo)
                                             {$ENDIF}
                                             {$IFDEF WIN3_1},
                                              (TCustomOutLine,TDirectoryOutline)
                                             {$ENDIF}
                                              );


var ActiveClient: TLangManClient;

function HaveHint(Component: TPersistent): Boolean;
begin
  Result := Component is TControl;
  if NOT Result then Result := Component is TMenuItem;
  if NOT Result then Result := Component is TCustomAction;
{$IF CompilerVersion > 18}
  if NOT Result then Result := Component is TCustomTrayIcon;
{$IFEND}
end;

//+****************************************************************************
//+*  LangManEngine Component methods                                        **
//+****************************************************************************

procedure TLangManEngine.SetLanguageMenu(MenuItem: TMenuItem);
begin
  if MenuItem <> fLanguageMenu then begin
    if Assigned(fLanguageMenu) then begin
      if Owner <> fLanguageMenu.Owner then fLanguageMenu.RemoveFreeNotification(Self);
      fLanguageMenu.SubMenuImages := nil;
    end;
    fLanguageMenu := MenuItem;
    if Assigned(fLanguageMenu) then begin
      if Owner <> fLanguageMenu.Owner then fLanguageMenu.FreeNotification(Self);
      ChangeLangMenu(fLanguageMenu);
    end;
  end;
end;

procedure TLangManEngine.SetLangMenuFlags(Input: Boolean);
var before: Boolean;
begin
  before := LangMenuFlags;
  inherited SetLangMenuFlags(Input);
  if (Input <> before) AND Assigned(fLanguageMenu) then ChangeLangMenu(fLanguageMenu);
end;

procedure TLangManEngine.SetDesignLangFlag(FlagImage: TPicture);
begin
  fDesignLangFlag.Assign(FlagImage);
  FindLangFiles;
end;

function TLangManEngine.ReCreateLangMenus: Boolean;
var Flag: TPicture;
    FI: Integer;
begin
  Result := inherited ReCreateLangMenus;
  if Result then begin
    // Load flag icons to FlagsList
    FlagsList.Clear;
    if LData.Flags.Count > 0 then begin
      Flag := TPicture.Create;
      try
        for FI := 0 to LData.Flags.Count - 1 do begin
          case AssignFlag(Flag, FI) of
            fasBitmap: FlagsList.AddMasked(Flag.Bitmap, clWhite);
            fasIcon: FlagsList.AddIcon(Flag.Icon);
          end;
          if FI >= FlagsList.Count then begin
            Flag.Bitmap.SetSize(FlagsList.Width, FlagsList.Height);
            Flag.Bitmap.Canvas.Brush.Color := clWhite;
            Flag.Bitmap.Canvas.FillRect(Rect(0, 0, FlagsList.Width, FlagsList.Height));
            FlagsList.AddMasked(Flag.Bitmap, clWhite);
          end;
        end;
      finally
        Flag.Free;
      end;
    end;
    // Main Menu
    if Assigned(fLanguageMenu) then ChangeLangMenu(fLanguageMenu);
    RefreshLangLists;
  end;
end;

procedure TLangManEngine.RefreshLangList(GUIComponent: TComponent; LangIndex: Integer);
var LI: Integer;
begin
  if GUIComponent is TLangCombo then begin
    (GUIComponent as TLangCombo).Items.Assign(LData.LangMenu);
    (GUIComponent as TLangCombo).ItemIndex := LangIndex;
    (GUIComponent as TLangCombo).Invalidate;
    Exit;
  end;

  if GUIComponent is TLangFlagsCombo then begin
    with (GUIComponent as TLangFlagsCombo) do begin
      Images := FlagsList;
      with LData do begin
        for LI := 0 to LangMenu.Count - 1 do begin
          if (LI + 1) > ItemsEx.Count then begin
            ItemsEx.AddItem(LangMenu.Strings[LI], LI, LI, -1, -1, nil);
          end else with ItemsEx.ComboItems[LI] do begin
            Caption := LangMenu.Strings[LI];
            ImageIndex := LI;
            SelectedImageIndex := LI;
            OverlayImageIndex := -1;
            Indent := -1;
            Data := nil;
          end;
        end;
        LI := LangMenu.Count;
      end;
      while LI < ItemsEx.Count do ItemsEx.Delete(LI);
      ItemIndex := Items.IndexOf(CurrentLanguage);
      Invalidate;
    end;
    Exit;
  end;

  if GUIComponent is TLangFlag then begin
    if AssignFlag((GUIComponent as TLangFlag).Picture, LangIndex) = fasNone
      then (GUIComponent as TLangFlag).Picture := nil;
    Exit;
  end;

  // dalsi LangMan komponenty prepinajici jazyk

end;

function TLangManEngine.LangFilesPath: String;
begin
  if DesignTime then Result := GetLangDir(_ProjectPath, LangSubdirectory)
                else Result := GetLangDir(ExtractFilePath(Application.ExeName), LangSubdirectory);
end;

procedure TLangManEngine.LoadFlagIcon(FlagStream: TMemoryStream; reqFlag: TFlagReq);
begin
  case reqFlag of
    fqDesignLang: begin
      if fDesignLangFlag.Graphic is TBitmap then fDesignLangFlag.Bitmap.SaveToStream(FlagStream)
                                            else begin
        if fDesignLangFlag.Graphic is TIcon then fDesignLangFlag.Icon.SaveToStream(FlagStream)
                                            else FlagStream.Clear;
      end;
    end;
    fqCreator: Make(FlagStream, LMCTR16);
    fqEditor: Make(FlagStream, LMETR16);
  end;
end;

procedure TLangManEngine.DesignLangFlagChanged(Sender: TObject);
begin
  fDesignLangFlag.OnChange := nil;
  AdaptFlagImage(fDesignLangFlag);
  FindLangFiles;
  fDesignLangFlag.OnChange := DesignLangFlagChanged;
end;

procedure TLangManEngine.LangMenuClick(Sender: TObject);
var SelLang: String;
begin
  if Sender is TMenuItem then begin
    SelLang := StripHotKey((Sender as TMenuItem).Caption);
    if SelLang <> CurrentLanguage then Translate(SelLang);
  end;
end;

procedure TLangManEngine.ChangeLangMenu(MenuItem: TMenuItem);
var LangIndex: Integer;

  function CreateMenuItem(LangName: string; FlagIndex: Integer): TMenuItem;
  begin
    Result := TMenuItem.Create(MenuItem);
    with Result do begin
      Caption := LangName;
      AutoCheck := true;
      RadioItem := true;
      Checked := LangName = CurrentLanguage;
      if LangMenuFlags then ImageIndex := FlagIndex;
      if NOT DesignTime then OnClick := LangMenuClick;
    end;
  end;

begin
  if DesignTime then Exit;
  if MenuItem <> nil then begin
    for LangIndex := 0 to LData.LangMenu.Count - 1 do begin
      if LangIndex < MenuItem.Count then begin
        with MenuItem.Items[LangIndex] do begin
          Caption := LData.LangMenu.Strings[LangIndex];
          AutoCheck := true;
          RadioItem := true;
          Checked := LData.LangMenu.Strings[LangIndex] = CurrentLanguage;
          if LangMenuFlags then ImageIndex := LangIndex;
          if NOT DesignTime then OnClick := LangMenuClick;
        end;
      end else MenuItem.Add(CreateMenuItem(LData.LangMenu.Strings[LangIndex], LangIndex));
    end;
    while LData.LangMenu.Count < MenuItem.Count do MenuItem.Delete(LData.LangMenu.Count);
    MenuItem.SubMenuImages := FlagsList;
  end;
end;

function TLangManEngine.EditorDisabled: Boolean;
begin
  Result := inherited EditorDisabled OR IsWebSession;
end;

procedure TLangManEngine.ApplicationRun(AOwner: TObject);
begin
  EngineInit;
  Application.OnActivate := ApplicationOnActivate;
  if Assigned(ApplicationOnActivate) then ApplicationOnActivate(AOwner);
end;

procedure TLangManEngine.UnregisterClient(ClientComponent: TComponent);
begin
  inherited UnregisterClient(ClientComponent);

  if ClientComponent is TLangCombo then begin
    (ClientComponent as TLangCombo).Clear;
    (ClientComponent as TLangCombo).Invalidate;
  end;

  if ClientComponent is TLangFlagsCombo then begin
    (ClientComponent as TLangFlagsCombo).Clear;
    (ClientComponent as TLangFlagsCombo).Invalidate;
    (ClientComponent as TLangFlagsCombo).Images := nil;
  end;

  // dalsi LangMan komponenty prepinajici jazyk
end;

procedure TLangManEngine.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) AND (AComponent = fLanguageMenu) then fLanguageMenu := nil;
end;

function TLangManEngine.AssignFlag(Pict: TPicture; FlagIndex: Integer): TFlagAssignAs;
var FS: TMemoryStream;
const BMhdr: Word = $4D42;
begin
  Result := fasNone;
  if LData.Flags.Present(FlagIndex) then begin
    try
      FS := LData.Flags.Flag[FlagIndex];
      if CompareMem(FS.Memory, @BMhdr, 2) then begin
        Pict.Bitmap.LoadFromStream(FS);
        Result := fasBitmap;
      end else begin
        Pict.Icon.LoadFromStream(FS);
        Result := fasIcon;
      end;
    except
      on Exception do Result := fasNone;
    end;
  end;
end;

constructor TLangManEngine.Create(AOwner: TComponent);
begin
  LData := TVCLLangData.Create(Self);
  FlagsList := TImageList.Create(nil);
  fDesignLangFlag := TPicture.Create;
  fDesignLangFlag.OnChange := DesignLangFlagChanged;
  inherited Create(AOwner);
  if NOT DesignTime then begin
    ApplicationOnActivate := Application.OnActivate;
    Application.OnActivate := ApplicationRun;
  end;
end;

destructor TLangManEngine.Destroy;
begin
  if NOT DesignTime then Application.OnActivate := ApplicationOnActivate;
  if Assigned(fLanguageMenu) then fLanguageMenu.Clear;
  FreeAndNil(fDesignLangFlag);
  inherited Destroy;
  FreeAndNil(LData);
  FreeAndNil(FlagsList);
end;

//+****************************************************************************
//+*  LangManClient Component methods                                        **
//+****************************************************************************

{$IFDEF D2010}
type
  TGesturePreviewHelper = class helper for TCustomGesturePreview
  public
    procedure RefreshLegendTextFromResource;
  end;

procedure TGesturePreviewHelper.RefreshLegendTextFromResource;
begin
  if NOT (csLoading in ComponentState) then UpdatePosition;
end;
{$ENDIF}

{$IFDEF RIBBONS}
{$I LMRibbons}
{$ENDIF}

procedure TLangManClient.UnsupportedWarning;
begin
  if DesignTime AND (NOT (csLoading in ComponentState))
    then MessageDlg('Unsupported option', mtInformation, [mbOK], 0);
end;

procedure TLangManClient.SetTransStringProp(Input: TTranslateStringProperties);
begin
  if Input <> fTransStringProp then begin
    fTransStringProp := Input * AllVCLStringProperties;
    if (Input <> fTransStringProp) then UnsupportedWarning;
    TransParamsChanged;
  end;
end;

procedure TLangManClient.SetTransTStringsProp(Input: TTranslateTStringsProperties);
begin
  if Input <> fTransTStringsProp then begin
    fTransTStringsProp := Input * AllVCLTStringsProperties;
    if (Input <> fTransTStringsProp) then UnsupportedWarning;
    TransParamsChanged;
  end;
end;

procedure TLangManClient.SetTransStructuredProp(Input: TTranslateStructuredProperties);
begin
  if Input <> fTransStructuredProp then begin
    fTransStructuredProp := Input * AllVCLStructuredProperties;
    if (Input <> fTransStructuredProp) then UnsupportedWarning;
    TransParamsChanged;
  end;
end;

procedure TLangManClient.SetTransOtherProp(Input: TTranslateOtherProperties);
begin
  if Input <> fTransOtherProp then begin
    fTransOtherProp := Input * AllVCLOtherProperties;
    if (Input <> fTransOtherProp) then UnsupportedWarning;
    TransParamsChanged;
  end;
end;

procedure TLangManClient.SetTransAdditions(Input: TAdditionSet);
begin
  if Input <> fTransAdditions then begin
    fTransAdditions := Input;
    TransParamsChanged;
  end;
end;

function TLangManClient.TransProp(Prop: TStringProperties): Boolean;
begin
  Result := (Prop in CmpTransStringProp);
end;

function TLangManClient.TransProp(Prop: TTStringsProperties): Boolean;
begin
  Result := (Prop in CmpTransTStringsProp);
end;

function TLangManClient.TransProp(Prop: TStructuredProperties): Boolean;
begin
  Result := (Prop in CmpTransStructuredProp);
end;

function TLangManClient.TransProp(Prop: TOtherProperties): Boolean;
begin
  Result := (Prop in CmpTransOtherProp);
end;

function TLangManClient.PriorityAbsorption(Component: TComponent; InterestClass: TClass): boolean;
begin
  Result := CheckPriorityAbsorption(Component, InterestClass, PriorityArray);
end;

function TLangManClient.TransComp(Component: TComponent; ChClass: TClass): Boolean;
begin
  Result := (Component is ChClass) and
            (NOT PriorityAbsorption(Component, ChClass));
end;

function TLangManClient.TransCompProp(Component: TComponent; ChClass: TClass; Prop: TStringProperties): Boolean;
begin
  Result := (Component is ChClass) and
            (Prop in CmpTransStringProp) and
            (NOT PriorityAbsorption(Component, ChClass));
end;

function TLangManClient.TransCompProp(Component: TComponent; ChClass: TClass; Prop: TTStringsProperties): Boolean;
begin
  Result := (Component is ChClass) and
            (Prop in CmpTransTStringsProp) and
            (NOT PriorityAbsorption(Component, ChClass));
end;

function TLangManClient.TransCompProp(Component: TComponent; ChClass: TClass; Prop: TStructuredProperties): Boolean;
begin
  Result := (Component is ChClass) and
            (Prop in CmpTransStructuredProp) and
            (NOT PriorityAbsorption(Component, ChClass));
end;

function TLangManClient.TransCompProp(Component: TComponent; ChClass: TClass; Prop: TOtherProperties): Boolean;
begin
  Result := (Component is ChClass) and
            (Prop in CmpTransOtherProp) and
            (NOT PriorityAbsorption(Component, ChClass));
end;

procedure TLangManClient.ChangeActionClientItems(Component: TComponent; fchInit: boolean);
var I: Integer;
    ManagerName: String;

  procedure ChangeActionClient(Client: TActionClient; AutoHotKeys: Boolean = false);
  var ClientItem: TActionClientItem;
      CI: Integer;
      ActionString, Addr, Bufstr: String;
  begin
    for CI := 0 to Client.ContextItems.Count - 1 do ChangeActionClient(Client.ContextItems.Items[CI] as TActionClient, Client.ContextItems.AutoHotKeys);
    if Client.HasItems then begin
      for CI := 0 to Client.Items.Count - 1 do ChangeActionClient(Client.Items.Items[CI] as TActionClient, Client.Items.AutoHotKeys);
    end;
    if Client is TActionClientItem then begin
      ClientItem := TActionClientItem(Client);
      Addr := ObjectAddress(ClientItem, ClientItem.Caption);
      if Addr <> '' then begin
        Addr := NestedAddr(Addr, 'Caption');
        if fchInit then begin
          if Assigned(ClientItem.Action) AND (ClientItem.Action is TCustomAction)
            then ActionString := (ClientItem.Action as TCustomAction).Caption
            else ActionString := '';
          if (ClientItem.Caption <> ActionString) AND (StripHotKey(ClientItem.Caption) <> ActionString) then begin
            CreateStructItem(ManagerName, Component, PropIndex(cnTActionManager), ClientItem.Caption, Addr);
          end;
        end else begin
          Bufstr := StructItem(ManagerName, GetLanguageComponentOwner(Component), PropIndex(cnTActionManager), Addr);
          if Bufstr <> '' then ClientItem.Caption := Bufstr;
        end;
      end;
    end;
  end;

begin
  ManagerName := Component.Name;
  for I := 0 to (Component as TCustomActionManager).ActionBars.Count - 1 do
    ChangeActionClient((Component as TCustomActionManager).ActionBars.Items[I] as TActionClient);
end;

procedure TLangManClient.ChangeStructPanels(Component: TComponent; PropertyType: Word; Data: TStatusPanels; fchInit: Boolean);
var Bufstr, Addr: string;
    PI: Integer;
begin
  if Data.Count > 0 then for PI := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(PI);
    if fchInit then CreateStructItem(Component,PropertyType,Data.Items[PI].Text,NestedProperty(Addr,pnText))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedProperty(Addr,pnText));
      if Bufstr <> '' then Data.Items[PI].Text := Bufstr;
    end;
  end;
end;

procedure TLangManClient.ChangeStructBands(Component: TComponent; PropertyType: Word; Data: TCoolBands; fchInit: Boolean);
var Bufstr, Addr: string;
    CB: Integer;
begin
  if Data.Count > 0 then for CB := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(CB);
    if fchInit then CreateStructItem(Component,PropertyType,Data.Items[CB].Text,NestedProperty(Addr,pnText))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedProperty(Addr,pnText));
      if Bufstr <> '' then Data.Items[CB].Text := Bufstr;
    end;
  end;
end;


{$IF CompilerVersion > 18}
procedure TLangManClient.ChangeStructCategories(Component: TComponent; PropertyType: Word; Data: TButtonCategories; fchInit: Boolean);
var Bufstr, Addr, AddrS: string;
    CI,II: Integer;
begin
  if Data.Count > 0 then for CI := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(CI);
//    if (pnCaption in fPropertiesOptions) then begin
      if fchInit then CreateStructItem(Component,PropertyType,Data.Items[CI].Caption,NestedProperty(Addr,pnCaption))
                 else begin
        Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedProperty(Addr,pnCaption));
        if Bufstr <> '' then Data.Items[CI].Caption := Bufstr;
      end;
//    end;
    if Data.Items[CI].Items.Count > 0 then for II := 0 to Data.Items[CI].Items.Count - 1 do begin
      AddrS := NestedAddr(Addr,II);
      if fchInit then begin
        if NOT ((Data.Items[CI].Items.Items[II].Action is TCustomAction) and
                ((Data.Items[CI].Items.Items[II].Action as TCustomAction).Caption =
                 Data.Items[CI].Items.Items[II].Caption))
          then CreateStructItem(Component,PropertyType,
                                Data.Items[CI].Items.Items[II].Caption,
                                NestedProperty(AddrS,pnCaption))
      end else begin
        Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType,
                             NestedProperty(AddrS,pnCaption));
        if Bufstr <> '' then Data.Items[CI].Items.Items[II].Caption := Bufstr;
      end;
      if (pnHint in CmpTransStringProp) then begin
        if fchInit then begin
          if NOT ((Data.Items[CI].Items.Items[II].Action is TCustomAction) and
                  ((Data.Items[CI].Items.Items[II].Action as TCustomAction).Hint =
                   Data.Items[CI].Items.Items[II].Hint))
            then CreateStructItem(Component,PropertyType,
                                  Data.Items[CI].Items.Items[II].Hint,
                                  NestedProperty(AddrS,pnHint))
        end else begin
          Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType,
                               NestedProperty(AddrS,pnHint));
          if Bufstr <> '' then Data.Items[CI].Items.Items[II].Hint := Bufstr;
        end;
      end;
    end;
  end;
end;

procedure TLangManClient.ChangeStructButtonsGrp(Component: TComponent; PropertyType: Word; Data: TGrpButtonItems; fchInit: Boolean);
var Bufstr, Addr: string;
    BI: Integer;
begin
  if Data.Count > 0 then for BI := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(BI);
    if fchInit then begin
      if NOT ((Data.Items[BI].Action is TCustomAction) and
              ((Data.Items[BI].Action as TCustomAction).Caption = Data.Items[BI].Caption))
        then CreateStructItem(Component,PropertyType,
                              Data.Items[BI].Caption,
                              NestedProperty(Addr,pnCaption))
    end else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType,
                           NestedProperty(Addr,pnCaption));
      if Bufstr <> '' then Data.Items[BI].Caption := Bufstr;
    end;
    if (pnHint in CmpTransStringProp) then begin
      if fchInit then begin
        if NOT ((Data.Items[BI].Action is TCustomAction) and
                ((Data.Items[BI].Action as TCustomAction).Hint = Data.Items[BI].Hint))
          then CreateStructItem(Component,PropertyType,
                                Data.Items[BI].Hint,
                                NestedProperty(Addr,pnHint))
      end else begin
        Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType,
                             NestedProperty(Addr,pnHint));
        if Bufstr <> '' then Data.Items[BI].Hint := Bufstr;
      end;
    end;
  end;
end;
{$IFEND}

procedure TLangManClient.ChangeStructTreeNodes(Component: TComponent; PropertyType: Word; Data: TTreeNodes; fchInit: Boolean);
var TN, TNI: Integer;

  procedure TreeNode(NestedData: TTreeNode; Addr: string);
  var Bufstr: string;
      TNN: Integer;
  begin
    if fchInit then CreateStructItem(Component,PropertyType,NestedData.Text,Addr)
               else begin
      BufStr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType,Addr);
      if BufStr <> '' then NestedData.Text := Bufstr;
    end;
    if NestedData.Count > 0
      then for TNN := 0 to NestedData.Count - 1 do TreeNode(NestedData.Item[TNN],NestedAddr(Addr,TNN));
  end;

begin
  TNI := 0;
  if Data.Count > 0 then for TN := 0 to Data.Count - 1 do begin
    if Data.Item[TN].Level = 0 then begin
      TreeNode(Data.Item[TN],CreateAddr(TNI));
      Inc(TNI);
    end;
  end;
end;

procedure TLangManClient.ChangeStructListColumns(Component: TComponent; PropertyType: Word; Data: TListColumns; fchInit: Boolean);
var Bufstr, Addr: string;
    CI: Integer;
begin
  if Data.Count > 0 then for CI := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(CI);
    if fchInit then CreateStructItem(Component, PropertyType,
                                     Data.Items[CI].Caption,
                                     NestedProperty(Addr,pnCaption))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component),
                           PropertyType, NestedProperty(Addr,pnCaption));
      if Bufstr <> '' then Data.Items[CI].Caption := Bufstr;
    end;
  end;
end;

{$IF CompilerVersion > 19}
procedure TLangManClient.ChangeStructListGroups(Component: TComponent; PropertyType: Word; Data: TListGroups; fchInit: Boolean);
var Bufstr, Addr: string;
    GI: Integer;
begin
  if Data.Count > 0 then for GI := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(GI);
    if fchInit then begin
      CreateStructItem(Component,PropertyType,Data.Items[GI].Header,NestedProperty(Addr,epnHeader));
      CreateStructItem(Component,PropertyType,Data.Items[GI].Footer,NestedProperty(Addr,epnFooter));
      CreateStructItem(Component,PropertyType,Data.Items[GI].Subtitle,NestedProperty(Addr,epnSubtitle));
  {$IF CompilerVersion < 22}
      CreateStructItem(Component,PropertyType,Data.Items[GI].BottomDescription,NestedProperty(Addr,epnBottomDescription));
      CreateStructItem(Component,PropertyType,Data.Items[GI].SubsetTitle,NestedProperty(Addr,epnSubsetTitle));
      CreateStructItem(Component,PropertyType,Data.Items[GI].TopDescription,NestedProperty(Addr,epnTopDescription));
  {$IFEND}
    end else begin
      Bufstr := StructItem(Component.Name,GetLanguageComponentOwner(Component),PropertyType,NestedProperty(Addr,epnHeader));
      if Bufstr <> '' then Data.Items[GI].Header := Bufstr;
      Bufstr := StructItem(Component.Name,GetLanguageComponentOwner(Component),PropertyType,NestedProperty(Addr,epnFooter));
      if Bufstr <> '' then Data.Items[GI].Footer := Bufstr;
      Bufstr := StructItem(Component.Name,GetLanguageComponentOwner(Component),PropertyType,NestedProperty(Addr,epnSubtitle));
      if Bufstr <> '' then Data.Items[GI].Subtitle := Bufstr;
  {$IF CompilerVersion < 22}
      Bufstr := StructItem(Component.Name,GetLanguageComponentOwner(Component),PropertyType,NestedProperty(Addr,epnBottomDescription));
      if Bufstr <> '' then Data.Items[GI].BottomDescription := Bufstr;
      Bufstr := StructItem(Component.Name,GetLanguageComponentOwner(Component),PropertyType,NestedProperty(Addr,epnSubsetTitle));
      if Bufstr <> '' then Data.Items[GI].SubsetTitle := Bufstr;
      Bufstr := StructItem(Component.Name,GetLanguageComponentOwner(Component),PropertyType,NestedProperty(Addr,epnTopDescription));
      if Bufstr <> '' then Data.Items[GI].TopDescription := Bufstr;
  {$IFEND}
    end;
  end;
end;
{$IFEND}

procedure TLangManClient.ChangeStructListItems(Component: TComponent; PropertyType: Word; Data: TListItems; fchInit: Boolean);
var LI, SLI : Integer;
    BufStr, Addr: string;
begin
  if Data.Count > 0 then for LI := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(LI);
    if fchInit then CreateStructItem(Component,PropertyType,Data.Item[LI].Caption,NestedProperty(Addr,pnCaption))
               else begin
      BufStr := StructItem(Component.Name,GetLanguageComponentOwner(Component),PropertyType,NestedProperty(Addr,pnCaption));
      if BufStr <> '' then Data.Item[LI].Caption := Bufstr;
    end;
    if Data.Item[LI].SubItems.Count > 0
     then for SLI := 0 to Data.Item[LI].SubItems.Count - 1 do begin
      if fchInit then CreateStructItem(Component,PropertyType,Data.Item[LI].SubItems.Strings[SLI],NestedAddr(Addr,SLI))
                 else begin
        BufStr := StructItem(Component.Name,GetLanguageComponentOwner(Component),PropertyType,NestedAddr(Addr,SLI));
        if BufStr <> '' then Data.Item[LI].SubItems.Strings[SLI] := Bufstr;
      end;
    end;
  end;
end;

procedure TLangManClient.ChangeStructHeaderSections(Component: TComponent; PropertyType: Word; Data: THeaderSections; fchInit: Boolean);
var Bufstr, Addr: string;
    SI: Integer;
begin
  if Data.Count > 0 then for SI := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(SI);
    if fchInit then CreateStructItem(Component,PropertyType,
                                     Data.Items[SI].Text,
                                     NestedProperty(Addr,pnText))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component),
                           PropertyType, NestedProperty(Addr,pnText));
      if Bufstr <> '' then Data.Items[SI].Text := Bufstr;
    end;
  end;
end;

{$IFDEF DATABASES}
procedure TLangManClient.ChangeStructDBTitleCaptions(Component: TComponent; PropertyType: Word; Data: TDBGridColumns; fchInit: Boolean);
var Bufstr: string;
    TI: Integer;
begin
  if Data.Count > 0 then for TI := 0 to Data.Count - 1 do begin
    if fchInit then CreateStructItem(Component,PropertyType,Data.Items[TI].Title.Caption,CreateAddr(TI))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, CreateAddr(TI));
      if Bufstr <> '' then Data.Items[TI].Title.Caption := Bufstr;
    end;
  end;
end;
{$ENDIF}
{$IFDEF WIN3_1}
procedure TLangManClient.ChangeStructOutlineItems(Component: TComponent; PropertyType: Word; Outline: TCustomOutline; fchInit: Boolean);
var Bufstr: string;
    OI: Integer;
begin
  if Outline.ItemCount > 0 then for OI := 1 to Outline.ItemCount do begin
    if fchInit then CreateStructItem(Component,PropertyType,Outline.Items[OI].Text,CreateAddr(OI))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, CreateAddr(OI));
      if Bufstr <> '' then Outline.Items[OI].Text := Bufstr;
    end;
  end;
end;
{$ENDIF}

{$IFDEF D2010}
procedure TLangManClient.ChangeKeyCaptions(Component: TComponent; PropertyType: Word; fchInit: boolean);
var KB: TCustomTouchKeyboard;
    CI: Integer;
    Bufstr: String;
    KBChanged: Boolean;
begin
  KB := Component as TCustomTouchKeyboard;
  KBChanged := false;
  if KB.CaptionOverrides.Count > 0 then begin
    for CI := 0 to KB.CaptionOverrides.Count - 1 do begin
      if fchInit then CreateStructItem(Component,
                                       PropertyType,
                                       KB.CaptionOverrides.Items[CI].Value,
                                       KB.CaptionOverrides.Items[CI].Name)
                 else begin
        Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, KB.CaptionOverrides.Items[CI].Name);
        if (Bufstr <> '') AND (Bufstr <> KB.CaptionOverrides.Items[CI].Value) then begin
          KB.CaptionOverrides.SetCaption(KB.CaptionOverrides.Items[CI].Name, Bufstr);
          KBChanged := true;
        end;
      end;
    end;
    if KBChanged then KB.Invalidate;
  end;
end;

procedure TLangManClient.ChangeGestureNames(Component: TComponent; PropertyType: Word; Gestures: TGestureArray; GesturesTotal: Integer; fchInit: boolean);
var GI: Integer;
    Bufstr: String;
begin
  if GesturesTotal > 0 then begin
    for GI := 0 to GesturesTotal - 1 do begin
      if fchInit then CreateStructItem(Component, PropertyType, Gestures[GI].Name, NestedProperty(CreateAddr(Ord(Gestures[GI].GestureID)), epnName))
                 else begin
        Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedProperty(CreateAddr(Ord(Gestures[GI].GestureID)), epnName));
        if Bufstr <> '' then Gestures[GI].Name := Bufstr;
      end;
    end;
  end;
end;
{$ENDIF}

procedure TLangManClient.ChangeStructFileTypes(Component: TComponent; PropertyType: Word; Data: TFileTypeItems; fchInit: Boolean);
var Bufstr, Addr: String;
    FTI: Integer;
begin
  if Data.Count > 0 then for FTI := 0 to Data.Count - 1 do begin
    Addr := AsPropertyName('[' + Data.Items[FTI].FileMask + ']');
    if Addr <> '' then begin
      if fchInit then CreateStructItem(Component, PropertyType, Data.Items[FTI].DisplayName, Addr)
                 else begin
        Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, Addr);
        if Bufstr <> '' then Data.Items[FTI].DisplayName := Bufstr;
      end;
    end;
  end;
end;

{$IF CompilerVersion > 17}
procedure TLangManClient.ChangeStructTaskDlgButtons(Component: TComponent; PropertyType: Word; Data: TTaskDialogButtons; fchInit: Boolean);
var Bufstr, Addr: String;
    BI: Integer;
begin
  if Data.Count > 0 then for BI := 0 to Data.Count - 1 do begin
    Addr := CreateAddr(BI);
    if fchInit then begin
      CreateStructItem(Component, PropertyType, Data.Items[BI].Caption, NestedProperty(Addr, pnCaption));
      if Data.Items[BI] is TTaskDialogButtonItem then CreateStructItem(Component, PropertyType, (Data.Items[BI] as TTaskDialogButtonItem).CommandLinkHint, NestedProperty(Addr, epnCommandLinkHint));
    end else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedProperty(Addr, pnCaption));
      if Bufstr <> '' then Data.Items[BI].Caption := Bufstr;
      if Data.Items[BI] is TTaskDialogButtonItem then begin
        Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedProperty(Addr, epnCommandLinkHint));
        if Bufstr <> '' then (Data.Items[BI] as TTaskDialogButtonItem).CommandLinkHint := Bufstr;
      end;
    end;
  end;
end;
{$IFEND}

{$IFDEF RAVE}
procedure TLangManClient.ChangeStructRaveProject(Component: TComponent; PropertyType: Word; fchInit: Boolean);
var ProjMan: TRaveProjectManager;
    RegPages: TList;
    Report: TRaveReport;
    RI, PI: Integer;

  procedure TranslateRavePage(Page: TRavePage; RegName: string);
  var RaveText: TRaveText;
      RaveMemo: TRaveMemo;
      Addr, Bufstr, LinesIn, LinesOut, LineBuf: string;
      CI, LineIndex, EnterPos: Integer;
  begin
    if RegPages.IndexOf(Page) >= 0 then Exit
                                   else RegPages.Add(Page);
    for CI := 0 to Page.ComponentCount - 1 do begin
      if Page.Components[CI].ClassType = TRaveText then begin
        RaveText := Page.Components[CI] as TRaveText;
        Addr := RaveText.Name + ALTDOT + GetNameFromArrays(PropIndex(pnText), []);
        if fchInit then begin
          if RaveText.Text <> RaveText.Name then begin
            CreateStructItem(RegName + TECKA + Page.Name,
                             Component,
                             PropertyType,
                             RaveText.Text,
                             Addr);
          end;
        end else begin
          Bufstr := StructItem(RegName + TECKA + Page.Name, GetLanguageComponentOwner(Component),PropertyType,Addr);
          if Bufstr <> '' then RaveText.Text := Bufstr;
        end;
      end else if (Page.Components[CI].ClassType = TRaveMemo) and TransProp(pnLines) then begin
        RaveMemo := Page.Components[CI] as TRaveMemo;
        Addr := RaveMemo.Name + ALTDOT + GetNameFromArrays(PropIndex(pnLines), []);
        LinesIn := RaveMemo.Text;
        LineIndex := 0;
        LinesOut := '';
        repeat
          EnterPos := Pos(#13,LinesIn);
          if EnterPos > 0 then begin
            LineBuf := Copy(LinesIn,1,EnterPos-1);
            LinesIn := Copy(LinesIn, EnterPos + 2, Length(LinesIn) - (EnterPos + 1));
          end else LineBuf := LinesIn;
          if fchInit then begin
            CreateStructItem(RegName + TECKA + Page.Name,
                             Component,
                             PropertyType,
                             LineBuf,
                             NestedAddr(Addr,LineIndex));
          end else begin
            Bufstr := StructItem(RegName + TECKA + Page.Name,GetLanguageComponentOwner(Component),PropertyType,NestedAddr(Addr,LineIndex));
            if Bufstr <> '' then LineBuf := Bufstr;
          end;
          if EnterPos > 0 then LinesOut := LinesOut + LineBuf + #13#10
                          else LinesOut := LinesOut + LineBuf;
          Inc(LineIndex);
        until EnterPos <= 0;
        RaveMemo.Text := LinesOut;
      end;
    end;
  end;

begin
                              //StoreRAV (spatne) -> ReportName od verze 2.0.9
//no  if ((Component as TRVProject).ReportName <> '') or FileExists((Component as TRVProject).ProjectFile) then begin
  if NOT DesignTime then begin  // pripadna nahrada
    try
      (Component as TRVProject).Open;
    except
      on Exception do Exit;
    end;
    if (Component as TRVProject).Active then begin
      RegPages := TList.Create;
      ProjMan := (Component as TRVProject).ProjMan;
      if ProjMan.GlobalPageList.Count > 0 then begin
        for PI := 0 to ProjMan.GlobalPageList.Count - 1 do begin
          TranslateRavePage(ProjMan.GlobalPageList.Items[PI],Component.Name);
        end;
      end;
      if ProjMan.ReportList.Count > 0 then for RI := 0 to ProjMan.ReportList.Count - 1 do begin
        Report := ProjMan.ReportList.Items[RI];
        if Report.LoadedPageCount > 0 then
          for PI := 0 to Report.LoadedPageCount - 1 do
            TranslateRavePage(Report.LoadedPage[PI],NestedProperty(Component.Name,Report.Name));
      end;
      RegPages.Free;
    end;
  end;
end;

procedure TLangManClient.ChangeStructRaveSystem(Component: TComponent; PropertyType: Word; fchInit: Boolean);
var RvSystem: TRvSystem;
begin
  RvSystem := Component as TRvSystem;
  RvSystem.SystemFiler.StatusFormat := ChangeStructItemEx(Component,PropertyType,RvSystem.SystemFiler.StatusFormat,fchInit,'Filer' + ALTDOT + 'StatusFormat');
  ChangeStructStringsEx(Component,PropertyType,RvSystem.SystemFiler.StatusText,fchInit,'Filer' + ALTDOT + 'StatusText');
  RvSystem.SystemPrinter.StatusFormat := ChangeStructItemEx(Component,PropertyType,RvSystem.SystemPrinter.StatusFormat,fchInit,'Printer' + ALTDOT + 'StatusFormat');
  ChangeStructStringsEx(Component,PropertyType,RvSystem.SystemPrinter.StatusText,fchInit,'Printer' + ALTDOT + 'StatusText');
  RvSystem.SystemPrinter.Title := ChangeStructItemEx(Component,PropertyType,RvSystem.SystemPrinter.Title,fchInit,'Printer' + ALTDOT + 'Title');
  RvSystem.TitlePreview := ChangeStructItemEx(Component,PropertyType,RvSystem.TitlePreview,fchInit,'TitlePreview');
  RvSystem.TitleSetup := ChangeStructItemEx(Component,PropertyType,RvSystem.TitleSetup,fchInit,'TitleSetup');
  RvSystem.TitleStatus := ChangeStructItemEx(Component,PropertyType,RvSystem.TitleStatus,fchInit,'TitleStatus');
end;
{$ENDIF}

{$IFDEF TEECHART}
procedure TLangManClient.ChangeStructCustomAxes(Component: TComponent; PropertyType: Word; Data: TCollection; fchInit: Boolean; PresetAddr: string);
var CAI: Integer;
    Bufstr: string;
begin
  if Data.Count > 0 then for CAI := 0 to Data.Count - 1 do begin
    if fchInit then CreateStructItem(Component, PropertyType, (Data.Items[CAI] as TChartAxis).Title.Caption, NestedAddr(PresetAddr,CAI))
               else begin
      Bufstr := StructItem(Component.Name, GetLanguageComponentOwner(Component), PropertyType, NestedAddr(PresetAddr,CAI));
      if Bufstr <> '' then (Data.Items[CAI] as TChartAxis).Title.Caption := Bufstr;
    end;
  end;
end;
{$ENDIF}

function TLangManClient.NotLinkedToAction(PropertyType : Word; const CompStr, ActionStr: string): Boolean;
begin
  Result := inherited NotLinkedToAction(PropertyType, CompStr, ActionStr);
  if Result AND (PropertyType = PropIndex(pnCaption)) then begin
{$IF CompilerVersion > 19}  
    if SameCaption(CompStr, ActionStr) then Result := false;
{$ELSE}
    if AnsiSameCaption(CompStr, ActionStr) then Result := false;    
{$IFEND}
  end;
end;

//+****************************************************************************
//+******* Component autotranslation procedure begin **************************

procedure TLangManClient.ChangeStrings(Component: TComponent; fchInit: boolean);
var ActionString: string;

  function CheckTagSetup(TaggedComponent: TComponent): Boolean;
  begin
    Result := false;
    case TaggedComponent.Tag of
      BLOCK_TRANSLATE: Result := true;
      BLOCK_OTHERS: begin
        CmpTransStringProp := HINT_PROPERTIES * fTransStringProp;
        CmpTransTStringsProp := [];
        CmpTransStructuredProp := [];
        CmpTransOtherProp := [];
      end;
      BLOCK_TEXT: begin
        CmpTransStringProp := fTransStringProp - [pnText];
        CmpTransTStringsProp := fTransTStringsProp;
        CmpTransStructuredProp := fTransStructuredProp;
        CmpTransOtherProp := fTransOtherProp;
      end;
      BLOCK_TXT_OTHERS: begin
        CmpTransStringProp := [pnText];
        CmpTransTStringsProp := [];
        CmpTransStructuredProp := [];
        CmpTransOtherProp := [];
      end;
      BLOCK_HINT: begin
        CmpTransStringProp := fTransStringProp - HINT_PROPERTIES;
        CmpTransTStringsProp := fTransTStringsProp;
        CmpTransStructuredProp := fTransStructuredProp;
        CmpTransOtherProp := fTransOtherProp;
      end;
      else begin
        CmpTransStringProp := fTransStringProp;
        CmpTransTStringsProp := fTransTStringsProp;
        CmpTransStructuredProp := fTransStructuredProp;
        CmpTransOtherProp := fTransOtherProp;
      end;
    end;
  end;

begin
  //trans
  if Component.Name <> '' then try
    // Local component restrictions
    if CheckTagSetup(Component) then Exit;

    //+************************************************************************
    //+** Platform independent components *************************************
    //+************************************************************************

    inherited;

    //+************************************************************************
    //+** String Properties ***************************************************
    //+************************************************************************

    ActionString := '';
    if (Component is TControl) and ((Component as TControl).Action is TCustomAction) then ActionString := ((Component as TControl).Action as TCustomAction).Caption;

    // Caption group
    if TransProp(pnCaption) then begin

      if TransComp(Component, TMenuItem) then begin
       if ((Component as TMenuItem).Action is TCustomAction) then ActionString := ((Component as TMenuItem).Action as TCustomAction).Caption;
       (Component as TMenuItem).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TMenuItem).Caption,fchInit,ActionString);
      end else

       if TransComp(Component, TCustomLabel) then begin
         (Component as TCustomLabel).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TCustomLabel).Caption,fchInit,ActionString);
       end else

        if TransComp(Component, TButton) then begin
         (Component as TButton).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TButton).Caption,fchInit,ActionString);
        end else

         if TransComp(Component, TBitBtn) then begin
           (Component as TBitBtn).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TBitBtn).Caption,fchInit,ActionString);
         end else

          if TransComp(Component, TSpeedButton) then begin
            (Component as TSpeedButton).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TSpeedButton).Caption,fchInit,ActionString);
          end else

           if TransComp(Component, TStaticText) then begin
             (Component as TStaticText).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TStaticText).Caption,fchInit,ActionString);
           end else

            if TransComp(Component, TCheckBox) then begin
              (Component as TCheckBox).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TCheckBox).Caption,fchInit,ActionString);
            end else

             if TransComp(Component, TRadioButton) then begin
               (Component as TRadioButton).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TRadioButton).Caption,fchInit,ActionString);
             end else

              if TransComp(Component, TGroupBox) then begin
                (Component as TGroupBox).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TGroupBox).Caption,fchInit,ActionString);
              end else

               if TransComp(Component, TRadioGroup) then begin
                 (Component as TRadioGroup).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TRadioGroup).Caption,fchInit,ActionString);
               end else

                if TransComp(Component, TPanel) then begin
                  (Component as TPanel).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TPanel).Caption,fchInit,ActionString);
                end else

                 if TransComp(Component, TCustomAction) then begin
                   (Component as TCustomAction).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TCustomAction).Caption,fchInit);
                 end else

{$IF CompilerVersion > 18}
                  if TransComp(Component, TFlowPanel) then begin
                    (Component as TFlowPanel).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TFlowPanel).Caption,fchInit,ActionString);
                  end else

                   if TransComp(Component, TGridPanel) then begin
                     (Component as TGridPanel).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TGridPanel).Caption,fchInit,ActionString);
                   end else
{$IFEND}

{$IF CompilerVersion > 19}
                    if TransComp(Component, TCategoryPanel) then begin
                      (Component as TCategoryPanel).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TCategoryPanel).Caption,fchInit,ActionString);
                    end else
{$IFEND}

                     if TransComp(Component, TTabSheet) then begin
                       (Component as TTabSheet).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TTabSheet).Caption,fchInit,ActionString);
                     end else

                      if TransComp(Component, TToolButton) then begin
                        (Component as TToolButton).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TToolButton).Caption,fchInit,ActionString);
                      end else

                     {$IFDEF DATABASES}
                       if TransComp(Component, TDBCheckBox) then begin
                         (Component as TDBCheckBox).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TDBCheckBox).Caption,fchInit,ActionString);
                       end else

                        // TIBFilterDialog
                      {$IFDEF INTERBASE}
                        if TransComp(Component, TIBFilterDialog) then begin
                          (Component as TIBFilterDialog).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TIBFilterDialog).Caption,fchInit);
                        end else
                      {$ENDIF}
                     {$ENDIF}

{$IFDEF D2010}
                         if TransComp(Component, TCustomGestureRecorder) then begin
                           (Component as TCustomGestureRecorder).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TCustomGestureRecorder).Caption,fchInit);
                         end else
{$ENDIF}

                           if TransComp(Component, TCustomForm) then begin
                             (Component as TCustomForm).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TCustomForm).Caption,fchInit,ActionString);
                           end;

    end;

    // Text group
    if TransProp(pnText) then begin

      if TransComp(Component, TCustomEdit) then begin
        (Component as TCustomEdit).Text := ChangeStructItem(Component,PropIndex(pnText),(Component as TCustomEdit).Text,fchInit,ActionString);
      end else

       if TransComp(Component, TComboBox) then begin
         (Component as TComboBox).Text := ChangeStructItem(Component,PropIndex(pnText),(Component as TComboBox).Text,fchInit,ActionString);
       end else

        if TransComp(Component, TComboBoxEx) then begin
          (Component as TComboBoxEx).Text := ChangeStructItem(Component,PropIndex(pnText),(Component as TComboBoxEx).Text,fchInit,ActionString);
        end;

    end;

    // TValuedLabel.ValueName
    if TransCompProp(Component, TValuedLabel, pnValueName) then begin
      (Component as TValuedLabel).ValueName := ChangeStructItem(Component,PropIndex(pnValueName),(Component as TValuedLabel).ValueName,fchInit,ActionString);
    end;

    // TCustomStatusBar.SimpleText
    if TransCompProp(Component, TCustomStatusBar, pnSimpleText) then begin
      (Component as TCustomStatusBar).SimpleText := ChangeStructItem(Component,PropIndex(pnSimpleText),(Component as TCustomStatusBar).SimpleText,fchInit,ActionString);
    end;

    ActionString := '';  // Zde konci platnost puvodniho obsahu ActionString!

    // Hint group
    if TransProp(pnHint) then begin

      if TransComp(Component, TControl) then begin
        if ((Component as TControl).Action is TCustomAction) then ActionString := ((Component as TControl).Action as TCustomAction).Hint;
        (Component as TControl).Hint := ChangeStructItem(Component,PropIndex(pnHint),(Component as TControl).Hint,fchInit,ActionString);
      end else

       if TransComp(Component, TMenuItem) then begin
         if ((Component as TMenuItem).Action is TCustomAction) then ActionString := ((Component as TMenuItem).Action as TCustomAction).Hint;
         (Component as TMenuItem).Hint := ChangeStructItem(Component,PropIndex(pnHint),(Component as TMenuItem).Hint,fchInit,ActionString);
       end else

          if TransComp(Component, TCustomAction) then begin
            (Component as TCustomAction).Hint := ChangeStructItem(Component,PropIndex(pnHint),(Component as TCustomAction).Hint,fchInit);
          end;

    end;

{$IF CompilerVersion > 19}
    // TCustomEdit.TextHint
    if TransCompProp(Component, TCustomEdit, pnTextHint) then begin
      (Component as TCustomEdit).TextHint := ChangeStructItem(Component,PropIndex(pnTextHint),(Component as TCustomEdit).TextHint,fchInit);
    end;
{$IFEND}

    // HelpKeyword
    if TransCompProp(Component, TControl, pnHelpKeyword) then begin
      ActionString := '';
      if ((Component as TControl).Action is TCustomAction) then ActionString := ((Component as TControl).Action as TCustomAction).HelpKeyword;
      (Component as TControl).HelpKeyword := ChangeStructItem(Component,PropIndex(pnHelpKeyword),(Component as TControl).HelpKeyword,fchInit,ActionString);
{$IFNDEF DXE3}
    end else
      // od DXE3 je HelpKeyword v TContainedAction (implementovano v LangManCore)
      if TransCompProp(Component, TCustomAction, pnHelpKeyword) then begin
        (Component as TCustomAction).HelpKeyword := ChangeStructItem(Component,PropIndex(pnHelpKeyword),(Component as TCustomAction).HelpKeyword,fchInit);
{$ENDIF}
      end;

    // TOpenDialog.Title and Title of dilog actions: TFileOpen.Dialog, TFileSaveAs.Dialog, TFileRun.Dialog, TOpenPicture.Dilog, TSavePicture.Dialog
    //                                   + TSynCompletionProposal.Title
    if TransProp(pnTitle) then begin

    {$IFDEF SYNEDIT}
     if TransComp(Component, TSynBaseCompletionProposal) then begin
       (Component as TSynBaseCompletionProposal).Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TSynBaseCompletionProposal).Title,fchInit);
     end else
      if TransComp(Component, TSynEditPrint) then begin
        (Component as TSynEditPrint).Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TSynEditPrint).Title,fchInit);
      end else
    {$ENDIF}

      if TransComp(Component, TOpenDialog) then begin
        (Component as TOpenDialog).Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TOpenDialog).Title,fchInit);
      end else

       if TransComp(Component, TFileOpen) then begin
         (Component as TFileOpen).Dialog.Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TFileOpen).Dialog.Title,fchInit);
       end else

        if TransComp(Component, TFileSaveAs) then begin
          (Component as TFileSaveAs).Dialog.Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TFileSaveAs).Dialog.Title,fchInit);
        end else

         if TransComp(Component, TFileRun) then begin
           (Component as TFileRun).BrowseDlg.Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TFileRun).BrowseDlg.Title,fchInit);
         end else

          if TransComp(Component, TOpenPicture) then begin
            (Component as TOpenPicture).Dialog.Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TOpenPicture).Dialog.Title,fchInit);
          end else

           if TransComp(Component, TSavePicture) then begin
             (Component as TSavePicture).Dialog.Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TSavePicture).Dialog.Title,fchInit);
           end;
    end;

    // TBrowseForFolder.DialogCaption
    if TransCompProp(Component, TBrowseForFolder, pnDialogCaption) then begin
      (Component as TBrowseForFolder).DialogCaption := ChangeStructItem(Component,PropIndex(pnDialogCaption),(Component as TBrowseForFolder).DialogCaption,fchInit);
    end;

    // EditLabel .Caption, .Hint
{$IF CompilerVersion > 18}
    if TransComp(Component, TCustomLabeledEdit) then begin
      if CheckTagSetup((Component as TCustomLabeledEdit).EditLabel) then Exit;  // musi byt az za prekladem ostatnich vlastnosti jako .Text, .Hint atd.
      if TransProp(pnEditLabelCaption) then
        (Component as TCustomLabeledEdit).EditLabel.Caption := ChangeStructItem(Component,PropIndex(pnEditLabelCaption),(Component as TCustomLabeledEdit).EditLabel.Caption,fchInit,ActionString);
      if TransProp(pnEditLabelHint) then
        (Component as TCustomLabeledEdit).EditLabel.Hint := ChangeStructItem(Component,PropIndex(pnEditLabelHint),(Component as TCustomLabeledEdit).EditLabel.Hint,fchInit);
    end;
{$IFEND}

    //+************************************************************************
    //+** TStrings properties *************************************************
    //+************************************************************************

    // TCustomMemo.Lines
    if TransCompProp(Component, TCustomMemo, pnLines) then begin
      ChangeStructStrings(Component,PropIndex(pnLines),(Component as TCustomMemo).Lines,fchInit);
    end;

    // Items group
    if TransProp(pnItems) then begin

      if TransComp(Component, TCustomListBox) then begin
        ChangeStructStrings(Component,PropIndex(pnItems),(Component as TCustomListBox).Items,fchInit);
      end else

       if TransComp(Component, TCustomCombo) then begin
         ChangeStructStrings(Component,PropIndex(pnItems),(Component as TCustomCombo).Items,fchInit);
       end else

        if TransComp(Component, TRadioGroup) then begin
          ChangeStructStrings(Component,PropIndex(pnItems),(Component as TRadioGroup).Items,fchInit);
        end
         {$IFDEF DATABASES}
         else if TransComp(Component, TDBRadioGroup) then begin
           ChangeStructStrings(Component,PropIndex(pnItems),(Component as TDBRadioGroup).Items,fchInit);
         end
         {$ENDIF}
         ;

    end;

    // TitleCaptions (TValueListEditor)
    if TransCompProp(Component, TValueListEditor, pnTitleCaptions) then begin
      ChangeStructStrings(Component,PropIndex(pnTitleCaptions),(Component as TValueListEditor).TitleCaptions,fchInit);
      (Component as TValueListEditor).Invalidate;
    end;

    // Tabs group
    if TransProp(pnTabs) then begin

      if TransComp(Component, TTabSet) then begin
        ChangeStructStrings(Component,PropIndex(pnTabs),(Component as TTabSet).Tabs,fchInit);
      end else

       if TransComp(Component, TTabControl) then begin
         ChangeStructStrings(Component,PropIndex(pnTabs),(Component as TTabControl).Tabs,fchInit);
       end;

    end;

    // Pages group
    if TransProp(pnPages) then begin
     {$IFDEF WIN3_1}
      if TransComp(Component, TTabbedNotebook) then begin
        ChangeStructStrings(Component,PropIndex(pnPages),(Component as TTabbedNotebook).Pages,fchInit);
      end else
     {$ENDIF}

       if TransComp(Component, TNotebook) then begin
         ChangeStructStrings(Component,PropIndex(pnPages),(Component as TNotebook).Pages,fchInit);
       end;

    end;

    // THeader.Sections
    if TransCompProp(Component, THeader, pnSections) then begin
      ChangeStructStrings(Component,PropIndex(pnSections),(Component as THeader).Sections,fchInit);
    end;

   {$IFDEF SYNEDIT}
    // TSynBaseCompletionProposal.ItemList, .InsertList
    if TransComp(Component, TSynBaseCompletionProposal) then begin
      if TransProp(pnItemList) then ChangeStructStrings(Component,PropIndex(pnItemList),(Component as TSynBaseCompletionProposal).ItemList,fchInit);
      if TransProp(pnInsertList) then ChangeStructStrings(Component,PropIndex(pnInsertList),(Component as TSynBaseCompletionProposal).InsertList,fchInit);
    end;

    // TSynAutoComplete.AutoCompleteList
    if TransProp(pnAutoCompleteList) then begin
      if TransComp(Component, TCustomSynAutoComplete) then begin
        ChangeStructStrings(Component,PropIndex(pnAutoCompleteList),(Component as TCustomSynAutoComplete).AutoCompleteList,fchInit);
      end else

        if TransComp(Component, TSynAutoComplete) then begin
          ChangeStructStrings(Component,PropIndex(pnAutoCompleteList),(Component as TSynAutoComplete).AutoCompleteList,fchInit);
        end;
    end;
   {$ENDIF}

    //+************************************************************************
    //+** Structured properties ***********************************************
    //+************************************************************************

    // Panels (TStatusPanels)
    if TransCompProp(Component, TCustomStatusBar, pnPanels) then begin
      ChangeStructPanels(Component,PropIndex(pnPanels), (Component as TCustomStatusBar).Panels,fchInit);
    end;

    // Bands (TCoolBar)
    if TransCompProp(Component, TCoolBar, pnBands) then begin
      ChangeStructBands(Component,PropIndex(pnBands), (Component as TCoolBar).Bands,fchInit);
    end;

{$IF CompilerVersion > 18}
    // Categories (TButtonCategories)
    if TransCompProp(Component, TCategoryButtons, pnButtonCategories) then begin
      ChangeStructCategories(Component,PropIndex(pnButtonCategories), (Component as TCategoryButtons).Categories,fchInit);
    end;

    // Items (TGrpButtonItems)
    if TransCompProp(Component, TButtonGroup, pnGrpButtonItems) then begin
      ChangeStructButtonsGrp(Component,PropIndex(pnGrpButtonItems), (Component as TButtonGroup).Items,fchInit);
    end;
{$IFEND}

    // Items (TTreeView)
    if TransCompProp(Component, TTreeView, pnTreeItems) then begin
      ChangeStructTreeNodes(Component,PropIndex(pnTreeItems), (Component as TTreeView).Items,fchInit);
    end;

    // TListView .Columns, .Groups
    if TransComp(Component, TListView) then begin
      if TransProp(pnListColumns) then
        ChangeStructListColumns(Component,PropIndex(pnListColumns), (Component as TListView).Columns,fchInit);
  {$IF CompilerVersion > 19}
      if TransProp(pnListGroups) then
        ChangeStructListGroups(Component,PropIndex(pnListGroups), (Component as TListView).Groups,fchInit);
  {$IFEND}
    end;

  {$IFDEF D2010}
    // TGestureListView .Columns, .Groups
    if TransComp(Component, TGestureListView) then begin
      if TransProp(pnListColumns) then
        ChangeStructListColumns(Component,PropIndex(pnListColumns), (Component as TGestureListView).Columns,fchInit);
      if TransProp(pnListGroups) then
        ChangeStructListGroups(Component,PropIndex(pnListGroups), (Component as TGestureListView).Groups,fchInit);
    end;
  {$ENDIF}

  {$IF CompilerVersion > 19}
    // Items (TCustomListView)
    if TransCompProp(Component, TCustomListView, pnListItems) then begin
      ChangeStructListItems(Component,PropIndex(pnListItems), (Component as TCustomListView).Items,fchInit);
    end;
  {$ELSE}
    // Items (TListView)
    if TransCompProp(Component, TListView, pnListItems) then begin
      ChangeStructListItems(Component,PropIndex(pnListItems), (Component as TListView).Items,fchInit);
    end;
  {$IFEND}

    // Sections (THeaderSections)
    if TransCompProp(Component, TCustomHeaderControl, pnHeaderSections) then begin
      ChangeStructHeaderSections(Component,PropIndex(pnHeaderSections), (Component as TCustomHeaderControl).Sections,fchInit);
    end;

  {$IFDEF DATABASES}
    // Columns (TDBGridColumns)
    if TransCompProp(Component, TDBGrid, pnDBGridTitleCaptions) then begin
      ChangeStructDBTitleCaptions(Component,PropIndex(pnDBGridTitleCaptions), (Component as TDBGrid).Columns,fchInit);
    end;
  {$ENDIF}
  {$IFDEF WIN3_1}
    // Lines (TOutline)
    if TransCompProp(Component, TCustomOutline, pnOutlineItems) then begin
      ChangeStructOutlineItems(Component,PropIndex(pnOutlineItems),Component as TCustomOutline,fchInit);
    end;
  {$ENDIF}

  {$IFDEF D2010}
    // KeyCaptions (Touch.Keyboard.TTouchKeyboard)
    if TransCompProp(Component, TCustomTouchKeyboard, pnKeyCaptions) then begin
      ChangeKeyCaptions(Component,PropIndex(pnKeyCaptions),fchInit);
    end;
  {$ENDIF}

    //+************************************************************************
    //+** Other properties ****************************************************
    //+************************************************************************

    // Filter group
    if TransProp(pnFilter) then begin

    {$IFDEF SYNEDIT}
     if TransComp(Component, TSynCustomHighlighter) then begin
       (Component as TSynCustomHighlighter).DefaultFilter := ChangeStructFilter(Component,PropIndex(pnFilter),(Component as TSynCustomHighlighter).DefaultFilter,fchInit);
     end else if TransComp(Component, TSynCustomExporter) then begin
       (Component as TSynCustomExporter).DefaultFilter := ChangeStructFilter(Component,PropIndex(pnFilter),(Component as TSynCustomExporter).DefaultFilter,fchInit);
     end else
    {$ENDIF}

      if TransComp(Component, TFilterComboBox) then begin
        (Component as TFilterComboBox).Filter := ChangeStructFilter(Component,PropIndex(pnFilter),(Component as TFilterComboBox).Filter,fchInit);
      end else

       if TransComp(Component, TOpenDialog) then begin
         (Component as TOpenDialog).Filter := ChangeStructFilter(Component,PropIndex(pnFilter),(Component as TOpenDialog).Filter,fchInit);
       end else

        if TransComp(Component, TFileOpen) then begin
          (Component as TFileOpen).Dialog.Filter := ChangeStructFilter(Component, PropIndex(pnFilter), (Component as TFileOpen).Dialog.Filter,fchInit);
        end else

         if TransComp(Component, TFileSaveAs) then begin
           (Component as TFileSaveAs).Dialog.Filter := ChangeStructFilter(Component, PropIndex(pnFilter), (Component as TFileSaveAs).Dialog.Filter,fchInit);
         end else

          if TransComp(Component, TFileRun) then begin
            (Component as TFileRun).BrowseDlg.Filter := ChangeStructFilter(Component, PropIndex(pnFilter), (Component as TFileRun).BrowseDlg.Filter,fchInit);
          end else

           if TransComp(Component, TOpenPicture) then begin
             (Component as TOpenPicture).Dialog.Filter := ChangeStructFilter(Component, PropIndex(pnFilter), (Component as TOpenPicture).Dialog.Filter,fchInit);
           end else

            if TransComp(Component, TSavePicture) then begin
              (Component as TSavePicture).Dialog.Filter := ChangeStructFilter(Component, PropIndex(pnFilter), (Component as TSavePicture).Dialog.Filter,fchInit);
            end;

    end;

  {$IFDEF RAVE}  // All from Rave >ALL
    // TRVProject
    if TransCompProp(Component, TRvProject, cnRvProject) then begin
      ChangeStructRaveProject(Component,PropIndex(cnRvProject),fchInit);
    end;
    // TRvSystem
    if TransCompProp(Component, TRvSystem, cnRvSystem) then begin
      ChangeStructRaveSystem(Component,PropIndex(cnRvSystem),fchInit);
    end;
    // TRvNDRWriter
    if TransCompProp(Component, TRvNDRWriter, cnRvSystem) then begin
      (Component as TRvNDRWriter).StatusFormat := ChangeStructItemEx(Component,PropIndex(cnRvSystem),(Component as TRvNDRWriter).StatusFormat,fchInit,'StatusFormat');
      ChangeStructStringsEx(Component,PropIndex(cnRvSystem),(Component as TRvNDRWriter).StatusText,fchInit,'StatusText');
      (Component as TRvNDRWriter).Title := ChangeStructItemEx(Component,PropIndex(cnRvSystem),(Component as TRvNDRWriter).Title,fchInit,'Title');
    end;
    // TRpRender
    if TransCompProp(Component, TRpRender, cnRvRender) then begin
      (Component as TRpRender).DisplayName := ChangeStructItem(Component,PropIndex(cnRvRender),(Component as TRpRender).DisplayName,fchInit);
    end;
    // TRvRenderPDF
    if TransCompProp(Component, TRvRenderPDF, pnPDF_DocInfo) then begin
      (Component as TRvRenderPDF).DocInfo.Author := ChangeStructItemEx(Component,PropIndex(pnPDF_DocInfo),(Component as TRvRenderPDF).DocInfo.Author,fchInit,NestedProperty('',epnAuthor));
      (Component as TRvRenderPDF).DocInfo.Creator := ChangeStructItemEx(Component,PropIndex(pnPDF_DocInfo),(Component as TRvRenderPDF).DocInfo.Creator,fchInit,NestedProperty('',epnCreator));
      (Component as TRvRenderPDF).DocInfo.KeyWords := ChangeStructItemEx(Component,PropIndex(pnPDF_DocInfo),(Component as TRvRenderPDF).DocInfo.KeyWords,fchInit,NestedProperty('',epnKeyWords));
      (Component as TRvRenderPDF).DocInfo.Producer := ChangeStructItemEx(Component,PropIndex(pnPDF_DocInfo),(Component as TRvRenderPDF).DocInfo.Producer,fchInit,NestedProperty('',epnProducer));
      (Component as TRvRenderPDF).DocInfo.Subject := ChangeStructItemEx(Component,PropIndex(pnPDF_DocInfo),(Component as TRvRenderPDF).DocInfo.Subject,fchInit,NestedProperty('',epnSubject));
      (Component as TRvRenderPDF).DocInfo.Title := ChangeStructItemEx(Component,PropIndex(pnPDF_DocInfo),(Component as TRvRenderPDF).DocInfo.Title,fchInit,NestedProperty('',pnTitle));
    end;
  {$ENDIF}

  {$IFDEF TEECHART}
    // TCustomChart >ALL
    if TransCompProp(Component, TCustomChart, cnTChart) then begin
      ChangeStructStringsEx(Component,PropIndex(cnTChart),(Component as TCustomChart).Title.Text,fchInit,'Title' + ALTDOT + 'Text');
      ChangeStructStringsEx(Component,PropIndex(cnTChart),(Component as TCustomChart).SubTitle.Text,fchInit,'SubTitle' + ALTDOT + 'Text');
      ChangeStructStringsEx(Component,PropIndex(cnTChart),(Component as TCustomChart).Foot.Text,fchInit,'Foot' + ALTDOT + 'Text');
      ChangeStructStringsEx(Component,PropIndex(cnTChart),(Component as TCustomChart).SubFoot.Text,fchInit,'SubFoot' + ALTDOT + 'Text');
      (Component as TCustomChart).BottomAxis.Title.Caption := ChangeStructItemEx(Component,PropIndex(cnTChart),(Component as TCustomChart).BottomAxis.Title.Caption,fchInit,'BottomAxis');
      (Component as TCustomChart).LeftAxis.Title.Caption := ChangeStructItemEx(Component,PropIndex(cnTChart),(Component as TCustomChart).LeftAxis.Title.Caption,fchInit,'LeftAxis');
      (Component as TCustomChart).TopAxis.Title.Caption := ChangeStructItemEx(Component,PropIndex(cnTChart),(Component as TCustomChart).TopAxis.Title.Caption,fchInit,'TopAxis');
      (Component as TCustomChart).RightAxis.Title.Caption := ChangeStructItemEx(Component,PropIndex(cnTChart),(Component as TCustomChart).RightAxis.Title.Caption,fchInit,'RightAxis');
      (Component as TCustomChart).DepthAxis.Title.Caption := ChangeStructItemEx(Component,PropIndex(cnTChart),(Component as TCustomChart).DepthAxis.Title.Caption,fchInit,'DepthAxis');
      (Component as TCustomChart).DepthTopAxis.Title.Caption := ChangeStructItemEx(Component,PropIndex(cnTChart),(Component as TCustomChart).DepthTopAxis.Title.Caption,fchInit,'DepthTopAxis');
      ChangeStructCustomAxes(Component, PropIndex(cnTChart), (Component as TCustomChart).CustomAxes, fchInit, 'CustomAxes');
      ChangeStructStringsEx(Component,PropIndex(cnTChart), (Component as TCustomChart).Legend.Title.Text,fchInit,'Legend' + ALTDOT + 'Title');
    end;
  {$ENDIF}

    if TransCompProp(Component, TCustomActionManager, cnTActionManager) then begin
      ChangeActionClientItems(Component, fchInit);
    end;

  {$IFDEF D2010}
    // TGestureManager  gestrue Names
    if TransCompProp(Component, TGestureManager, cnTGestureManager) then begin
//      ChangeGestureNames(Component,PropIndex(cnTGestureManager),(Component as TGestureManager).RegisteredGestures,(Component as TGestureManager).RegisteredGestureCount,fchInit);
      ChangeGestureNames(Component,PropIndex(cnTGestureManager),(Component as TGestureManager).CustomGestures,(Component as TGestureManager).CustomGestureCount,fchInit);
//as CustomGestures      ChangeGestureNames(Component,PropIndex(cnTGestureManager),(Component as TGestureManager).RecordedGestures,(Component as TGestureManager).RecordedGestureCount,fchInit);
    end;

{$IFDEF LMSMART}
    // TGesturePreview - translated through resourcestrings sStartPoint and sStartPoints
    if Component is TCustomGesturePreview then begin
      (Component as TCustomGesturePreview).RefreshLegendTextFromResource;
    end;
{$ENDIF}
  {$ENDIF}

    //+************************************************************************
    //+** Mix property types - Complete components ****************************
    //+************************************************************************

{$IF CompilerVersion > 18}
    // TCustomTrayIcon .Hint, .BalloonHint, .BalloonTitle >ALL
    if TransComp(Component, TCustomTrayIcon) then begin
      if TransProp(pnHint) then
        (Component as TCustomTrayIcon).Hint := ChangeStructItem(Component,PropIndex(pnHint),(Component as TCustomTrayIcon).Hint,fchInit);
      if TransProp(pnBalloonHint) then
        (Component as TCustomTrayIcon).BalloonHint := ChangeStructItem(Component,PropIndex(pnBalloonHint),(Component as TCustomTrayIcon).BalloonHint,fchInit);
      if TransProp(pnBalloonTitle) then
        (Component as TCustomTrayIcon).BalloonTitle := ChangeStructItem(Component,PropIndex(pnBalloonTitle),(Component as TCustomTrayIcon).BalloonTitle,fchInit);
    end;
{$IFEND}

    // TCustomFileDialog .FileNameLabel, .OKButtonLabel, .FileTypes >ALL
    if TransComp(Component, TCustomFileDialog) then begin
      if TransProp(pnFileNameLabel) then
        (Component as TCustomFileDialog).FileNameLabel := ChangeStructItem(Component,PropIndex(pnFileNameLabel),(Component as TCustomFileDialog).FileNameLabel,fchInit);
      if TransProp(pnOkButtonLabel) then
        (Component as TCustomFileDialog).OkButtonLabel := ChangeStructItem(Component,PropIndex(pnOkButtonLabel),(Component as TCustomFileDialog).OkButtonLabel,fchInit);
      if TransProp(pnTitle) then
        (Component as TCustomFileDialog).Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TCustomFileDialog).Title,fchInit);
      if TransProp(pnFileTypes) then
        ChangeStructFileTypes(Component,PropIndex(pnFileTypes),(Component as TCustomFileDialog).FileTypes,fchInit);
    end;

{$IF CompilerVersion > 17}
    // TCustomTaskDialog .Buttons, .Caption, .ExpandButtonCaption, .ExpandedText,
    //                   .FooterText, .RadioButtons, .Text, .Title, .VerificationText >ALL
    if TransComp(Component, TCustomTaskDialog) then begin
      if TransProp(pnButtons) then
        ChangeStructTaskDlgButtons(Component,PropIndex(pnButtons),(Component as TCustomTaskDialog).Buttons,fchInit);
      if TransProp(pnCaption) then
        (Component as TCustomTaskDialog).Caption := ChangeStructItem(Component,PropIndex(pnCaption),(Component as TCustomTaskDialog).Caption,fchInit);
      if TransProp(pnExpandButtonCaption) then
        (Component as TCustomTaskDialog).ExpandButtonCaption := ChangeStructItem(Component,PropIndex(pnExpandButtonCaption),(Component as TCustomTaskDialog).ExpandButtonCaption,fchInit);
      if TransProp(pnExpandedText) then
        (Component as TCustomTaskDialog).ExpandedText := ChangeStructItem(Component,PropIndex(pnExpandedText),(Component as TCustomTaskDialog).ExpandedText,fchInit);
      if TransProp(pnFooterText) then
        (Component as TCustomTaskDialog).FooterText := ChangeStructItem(Component,PropIndex(pnFooterText),(Component as TCustomTaskDialog).FooterText,fchInit);
      if TransProp(pnRadioButtons) then
        ChangeStructTaskDlgButtons(Component,PropIndex(pnRadioButtons),(Component as TCustomTaskDialog).RadioButtons,fchInit);
      if TransProp(pnText) then
        (Component as TCustomTaskDialog).Text := ChangeStructItem(Component,PropIndex(pnText),(Component as TCustomTaskDialog).Text,fchInit);
      if TransProp(pnTitle) then
        (Component as TCustomTaskDialog).Title := ChangeStructItem(Component,PropIndex(pnTitle),(Component as TCustomTaskDialog).Title,fchInit);
      if TransProp(pnVerificationText) then
        (Component as TCustomTaskDialog).VerificationText := ChangeStructItem(Component,PropIndex(pnVerificationText),(Component as TCustomTaskDialog).VerificationText,fchInit);
    end;
{$IFEND}

{$IFDEF RIBBONS}
    RibbonClient(Component, fchInit);
{$ENDIF}

  except
    on E: Exception do begin
{$IFDEF LMDEBUG}
      ShowMessage('LangMan caught an exception during processing: ' + Component.Name +
                  #13#10 + 'Exception message: ' + E.Message);
{$ENDIF}
    end;
  end;
end;

constructor TLangManClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if (NOT DesignTime) and (AOwner is TComponent) then begin
    if AOwner is TForm then begin
      OwnerOnCreate := (AOwner as TForm).OnCreate;
      (AOwner as TForm).OnCreate := InitForm;
    end else begin
      if AOwner is TDataModule then begin
        OwnerOnCreate := (AOwner as TDataModule).OnCreate;
        (AOwner as TDataModule).OnCreate := InitForm;
      end;  // else Init;
    end;
  end;
  SetTransStringProp(TranslateStringPropertiesDefault);
  SetTransTStringsProp(TranslateTStringsPropertiesDefault);
  SetTransStructuredProp(TranslateStructuredPropertiesDefault);
  SetTransOtherProp(TranslateOtherPropertiesDefault);
  SetTransAdditions(DefaultEnabled);
end;

procedure TLangManClient.ControlChanges(fchInit: boolean);
var IComponent: integer;
    ParentControl: TComponent;
begin
  if (fchInit = false) AND DesignTime then Exit;
  ParentControl := Owner;
  if ParentControl = nil then Exit;
  if ParentControl is TForm then ChangeStrings(ParentControl, fchInit);
  if ParentControl.ComponentCount > 0 then begin
    ActiveClient := Self;
    for IComponent := 0 to ParentControl.ComponentCount - 1 do begin
      ChangeStrings(ParentControl.Components[IComponent],fchInit);
      if fchinit then RegisterAdditions(ParentControl.Components[IComponent])
                 else TranslateAdditions(ParentControl.Components[IComponent]);
    end;
  end;
end;

function TLangManClient.AddComponent(Component: TComponent; Name: string; Translate: boolean): Boolean;
begin
  Result := inherited AddComponent(Component, Name, Translate);
  if Result then begin
    ActiveClient := Self;
    RegisterAdditions(Component);
    if Translate then TranslateAdditions(Component);
  end;
end;

procedure TLangManClient.TranslateComponent(Component: TComponent; Name: string = '');
begin
  inherited TranslateComponent(Component, Name);
  if Component.Owner <> nil then TranslateAdditions(Component);
end;

//+****************************************************************************
//+*  TLangManRichEdit                                                       **
//+****************************************************************************

type
  TLexiconHelper = class helper for TLexicon
    function LinkToText(ItemIndex: Integer): String;
    function Link(Index: Integer): string;
  end;

{$IFDEF LMULT}
  TInlineLexiconHelper = class helper for TCustomInlineLexicon
    procedure LoadLocStringsHelper(CompName: String);
  end;

procedure TInlineLexiconHelper.LoadLocStringsHelper(CompName: String);
begin
  LoadLocStrings(CompName);
end;

{$ENDIF}

function TLexiconHelper.LinkToText(ItemIndex: Integer): String;
begin
  if NOT IsDef(ItemIndex) then Result := BAD_LINK
                          else Result := GetItem(ItemIndex);
end;

function TLexiconHelper.Link(Index: Integer): string;
begin
  Result := GetLink(Index);
end;

{$IFNDEF LMCPP}
{$IFDEF DXE2}
class constructor TLangManRichEdit.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TLangManRichEdit, TRichEditStyleHook);
end;
{$ENDIF}

{$IFDEF DXE3}
class destructor TLangManRichEdit.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TLangManRichEdit, TRichEditStyleHook);
end;
{$ENDIF}
{$ENDIF}

procedure TLangManRichEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) AND (AComponent = fAssignedLexicon) then begin
    fAssignedLexicon := nil;
    Translate;
  end;
end;

constructor TLangManRichEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ReadOnly := true;
  WordWrap := false;
  Styles := nil;
  LMLines := TStringList.Create;
  LMLines.Add('');
  fAutoFont := True;
  AutoFontSetup := false;
end;

destructor TLangManRichEdit.Destroy;
begin
  UnregisterLexSlave(fAssignedLexicon, Translate);
  LMLines.Free;
  Styles := nil;
  inherited Destroy;
end;

procedure TLangManRichEdit.LexiconAssign(Lexicon: TLexicon);
begin
  if fAssignedLexicon <> Lexicon then begin
    if Assigned(fAssignedLexicon) AND (Owner <> fAssignedLexicon.Owner) then fAssignedLexicon.RemoveFreeNotification(Self);
    UnregisterLexSlave(fAssignedLexicon, Translate);
    RegisterLexSlave(Lexicon, Translate);
    fAssignedLexicon := Lexicon;
    if Assigned(fAssignedLexicon) AND (Owner <> fAssignedLexicon.Owner) then fAssignedLexicon.FreeNotification(Self);
{$IFDEF LMULT}
    if Lexicon is TCustomInlineLexicon then (Lexicon as TCustomInlineLexicon).LoadLocStringsHelper(Name);
{$ENDIF}
    Translate;
  end;
end;

procedure TLangManRichEdit.SetupFont(Style: ShortInt);
begin
  if (Style < 0) OR (Style > High(Styles)) then begin
    SelAttributes := DefAttributes;
  end else begin
    SelAttributes.Style := Styles[Style].Style;
    if Styles[Style].Color = clDefault then SelAttributes.Color := DefAttributes.Color
                                          else SelAttributes.Color := Styles[Style].Color;
    if Styles[Style].Font = '' then SelAttributes.Name := DefAttributes.Name
                               else SelAttributes.Name := Styles[Style].Font;
    if Styles[Style].Charset = DEFAULT_CHARSET then SelAttributes.Charset := DefAttributes.Charset
                                               else SelAttributes.Charset := Styles[Style].Charset;
    if Styles[Style].Size = 0 then SelAttributes.Size := DefAttributes.Size
                              else SelAttributes.Size := Styles[Style].Size;
    if Styles[Style].Pitch = fpDefault then SelAttributes.Pitch := DefAttributes.Pitch
                                       else SelAttributes.Pitch := Styles[Style].Pitch;
  end;
end;

function TLangManRichEdit.WriteFormattedText(const Text: string; WrittingPosition: Integer): Integer;
var TxtLen, I, Nr, StackSize: Integer;
    Strbuf, LocStr: String;
    CurrentStyle: ShortInt;
    StyleStack: array[1..32] of ShortInt;

    function ReadNr: Boolean;
    var LinkLength: Integer;
    begin
      if (Text[I+1] = NR_IDENT) then begin
        Inc(I,2);
        Nr := 0;
        LinkLength := 3;
        repeat
          if (I < TxtLen) AND ((Ord(Text[I]) >= Ord('0')) AND (Ord(Text[I]) <= Ord('9'))) then begin
            Nr := (Nr * 10) + (Ord(Text[I]) - Ord('0'));
            Inc(LinkLength);
          end else begin
            I := I + 2 - LinkLength;
            Strbuf := Strbuf + LINK_IDENT;
            Result := false;
            Exit;
          end;
          Inc(I);
        until Text[I] = STREDNIK;
        Result := true;
      end else Result := false;
    end;

    function ReadLocStr: Boolean;
    begin
      if (Text[I+1] = SR_IDENT_ST) then begin
        Inc(I,2);
        while (I < TxtLen) AND
              ((Text[I] <> SR_LINK_END[1]) OR (Text[I+1] <> SR_LINK_END[2])) do begin
          LocStr := LocStr + Text[I];
          Inc(I);
        end;
        Result := I < TxtLen;
        if NOT Result then LocStr := '-';
      end else Result := false;
    end;

    procedure WriteBuf(Style: ShortInt);
    var SetStyle: ShortInt;
    begin
      SelText := Strbuf;
      Inc(Result, Length(Strbuf));
      Strbuf := '';
      SelStart := Result;
      SetStyle := -1;
      // nastaveni stylu
      if Style = -1 then begin
        if StackSize > 0 then begin
          // styl z vrchu haldy
          if StackSize <= 32 then SetStyle := StyleStack[StackSize];
          Dec(StackSize);
        end;
      end else begin
        // styl dle Style
        Inc(StackSize);
        if StackSize <= 32 then StyleStack[StackSize] := CurrentStyle;
        SetStyle := Style;
      end;
      CurrentStyle := SetStyle;
      SetupFont(SetStyle);
    end;

begin
  if NOT AutoFontSetup then begin
    AutoFontSetup := true;
    SetAutoFont(fAutoFont);
  end;
  TxtLen := Length(Text);
  LocStr := '';
  Result := WrittingPosition;
  if TxtLen > 0 then begin
    SelStart := WrittingPosition;
    I := 0;
    SelAttributes := DefAttributes;
    CurrentStyle := -1;
    StackSize := 0;
    Strbuf := '';
    repeat
      Inc(I);
      if (Text[I] = LINK_IDENT) AND (I < TxtLen) AND (ReadNr OR ReadLocStr) then begin
        if Assigned(AssignedLexicon) then begin
          if LocStr = '' then Strbuf := Strbuf + AssignedLexicon.LinkToText(Nr)
                         else begin
            if AssignedLexicon.LangManEngine <> nil
             then Strbuf := Strbuf + AssignedLexicon.LangManEngine.TranslateString(LocStr, AssignedLexicon)
             else begin
               DecodeSpecialChars(LocStr);
               Strbuf := Strbuf + LocStr;
             end;
            LocStr := '';
            Inc(I);
          end;
        end else Strbuf := Strbuf + BAD_LINK;
        Continue;
      end else begin
        if (Text[I] = STYLE_IDENT) AND (I < TxtLen) then begin
          if (Text[I+1] = STREDNIK) then begin
            WriteBuf(-1);
            Inc(I);
            Continue;
          end else begin
            if ReadNr then begin
              WriteBuf(Nr);
              Continue;
            end;
          end;
        end;
      end;
      if LocStr <> '' then Break; // v ReadLocStr se narazilo na konec Textu
      Strbuf := Strbuf + Text[I];
    until I >= TxtLen;
    if Strbuf <> '' then begin
      SelText := Strbuf;
      Inc(Result, Length(Strbuf));
    end;
  end;
end;

function TLangManRichEdit.GetLineStart(LineIndex: Integer): Integer;
var TextLength, LineNr: Integer;
    Content: String;
begin
  Result := 0;
  LineNr := 0;
  if LineNr < LineIndex then begin
    Content := Text;
    TextLength := Length(Content);
    if TextLength = 0 then Exit;
    repeat
      Inc(Result);
      while (Content[Result] <> #10) do begin
        if Result >= TextLength then begin
          Dec(Result, LineNr);
          Exit;
        end;
        Inc(Result);
      end;
      Inc(LineNr);
    until LineNr >= LineIndex;
    Dec(Result, LineNr);
  end;
end;

function TLangManRichEdit.SelLine(LineIndex: Integer; IncludeCRLF: Boolean = false): Boolean;
var TextLength, LineNr, LineStart, LineEnd: Integer;
    Content: String;
begin
  Result := false;
  if LineIndex < 0 then Exit;
  TextLength := GetTextLen;
  if TextLength = 0 then begin
    if LineIndex = 0 then begin
      SelStart := 0;
      Result := true;
    end;
    Exit;
  end;
  LineStart := 0;
  LineNr := 0;
  Content := Text;
  while LineNr < LineIndex do begin
    Inc(LineStart);
    while (Content[LineStart] <> #10) do begin
      if LineStart >= TextLength then Exit;
      Inc(LineStart);
    end;
    Inc(LineNr);
  end;
  SelStart := LineStart - LineNr;
  if LineStart >= TextLength then begin
    Result := true;
  end else begin
    LineEnd := LineStart + 1;
    while Content[LineEnd] <> #13 do begin
      if LineEnd >= TextLength then begin
        SelLength := LineEnd - LineStart;
        Result := true;
        Exit;
      end;
      Inc(LineEnd);
    end;
    if IncludeCRLF then SelLength := LineEnd - LineStart
                   else SelLength := (LineEnd - LineStart) - 1;
    Result := true;
  end;
end;

function TLangManRichEdit.GetAutoFont;
begin
  if DesignTime then Result := fAutoFont
                else Result := (SendMessage(Handle, EM_GETLANGOPTIONS, 0, 0) AND IMF_AUTOFONT) = IMF_AUTOFONT;
end;

function TLangManRichEdit.GetLink(Index: Integer): String;
begin
  if Assigned(AssignedLexicon) then Result := AssignedLexicon.Link(Index)
                               else Result := LINK_IDENT + NR_IDENT + IntToStr(Index) + STREDNIK;
end;

procedure TLangManRichEdit.SetAutoFont(const Value: Boolean);
begin
  fAutoFont := Value;
  if Value then SendMessage(Handle, EM_SETLANGOPTIONS, 0, SendMessage(Handle, EM_GETLANGOPTIONS, 0, 0) OR IMF_AUTOFONT)
           else SendMessage(Handle, EM_SETLANGOPTIONS, 0, SendMessage(Handle, EM_GETLANGOPTIONS, 0, 0) AND (NOT IMF_AUTOFONT));
  if AutoFontSetup then Translate;
end;

{$IFDEF LMULT}

function TLangManRichEdit.GetSLink(LocStr: String): string;
begin
  if Assigned(AssignedLexicon) AND (AssignedLexicon is TCustomInlineLexicon) then begin
    Result := (AssignedLexicon as TCustomInlineLexicon).SLink[LocStr];
  end else if LocStr <> '' then begin
    EncodeSpecialChars(LocStr);
    Result := LINK_IDENT + SR_IDENT_ST + LocStr + SR_LINK_END;
  end else Result := '';
end;

{$ENDIF}

procedure TLangManRichEdit.AssignStyles(LMStringStyles: TLMStringStyles);
begin
  Styles := nil;
  Styles := LMStringStyles;
  Translate;
end;

procedure TLangManRichEdit.ClearStyles;
begin
  Styles := nil;
  Translate;
end;

function TLangManRichEdit.GetStyles: TLMStringStyles;
begin
  Result := Styles;
end;

function TLangManRichEdit.StylesCount: Integer;
begin
  Result := Length(Styles);
end;

function TLangManRichEdit.SetStyle(Style: TFontStyles; Size: Integer = 0; Color: TColor = clDefault; FontName: TFontName = ''; Charset: TFontCharset = DEFAULT_CHARSET; Pitch: TFontPitch = fpDefault; StyleIndex: ShortInt = -1): Integer;
var StylesCount: Integer;
    StyleEdit: Boolean;
begin
  StyleEdit := false;
  StylesCount := Length(Styles);
  if StyleIndex < 0 then begin
    SetLength(Styles, StylesCount + 1);
    Result := StylesCount;
  end else begin
    if StyleIndex > High(Styles) then begin
      SetLength(Styles, StyleIndex + 1);
      while StylesCount < StyleIndex do begin
        Styles[StylesCount].Color := clDefault;
        Styles[StylesCount].Font := '';
        Styles[StylesCount].Charset := DEFAULT_CHARSET;
        Styles[StylesCount].Style := [];
        Styles[StylesCount].Size := 0;
        Styles[StylesCount].Pitch := fpDefault;
        Inc(StylesCount);
      end;
    end else StyleEdit := true;
    Result := StyleIndex;
  end;
  Styles[Result].Color := Color;
  Styles[Result].Font := FontName;
  Styles[Result].Charset := Charset;
  Styles[Result].Style := Style;
  Styles[Result].Size := Size;
  Styles[Result].Pitch := Pitch;
  if StyleEdit then Translate;
end;

function TLangManRichEdit.Format(const Text: String; StyleIndex: ShortInt): String;
begin
  if StyleIndex >= 0 then Result := STYLE_IDENT + NR_IDENT + IntToStr(StyleIndex) + STREDNIK + Text + STYLE_IDENT + STREDNIK
                     else Result := Text;
end;

procedure TLangManRichEdit.Write(const Text: String; StyleIndex: ShortInt = -1);
var FText: String;
begin
  if StyleIndex >= 0 then begin
    FText := Format(Text, StyleIndex);
    LMLines.Strings[LMLines.Count-1] := LMLines.Strings[LMLines.Count-1] + FText;
    WriteFormattedText(FText, GetTextLen);
  end else begin
    LMLines.Strings[LMLines.Count-1] := LMLines.Strings[LMLines.Count-1] + Text;
    WriteFormattedText(Text, GetTextLen);
  end;
end;

procedure TLangManRichEdit.WriteLn(const Text: String; StyleIndex: ShortInt = -1);
begin
  Write(Text, StyleIndex);
  NextLine;
end;

procedure TLangManRichEdit.NextLine;
begin
  SelStart := GetTextLen;
  SelText := #13#10;
  LMLines.Add('');
end;

procedure TLangManRichEdit.Clear;
begin
  LMLines.Clear;
  LMLines.Add('');
//  Lines.Clear;
  inherited;
end;

function TLangManRichEdit.LinesCount: Integer;
begin
  Result := LMLines.Count;
end;

function TLangManRichEdit.ReadLineText(LineIndex: Integer): String;
begin
  if WordWrap then begin
    if SelLine(LineIndex) then Result := GetSelText
                          else Result := '';
  end else begin
    if LineIndex < 0 then Result := ''
                     else Result := Lines.Strings[LineIndex];
  end;
end;

function TLangManRichEdit.ReadLineFText(LineIndex: Integer): String;
begin
  if (LineIndex >= 0) AND (LineIndex < LMLines.Count) then Result := LMLines.Strings[LineIndex]
                                                      else Result := '';
end;

procedure TLangManRichEdit.DeleteLine(LineIndex: Integer);
begin
  if LineIndex < 0 then Exit;
  if WordWrap then begin
    if SelLine(LineIndex, true) then begin
      SelText := '';
      LMLines.Delete(LineIndex);
    end;
  end else begin
    Lines.Delete(LineIndex);
    LMLines.Delete(LineIndex);
  end;
end;

procedure TLangManRichEdit.RewriteLine(LineIndex: Integer; const Text: String; StyleIndex: ShortInt = -1);
var FLine: String;
{$IF CompilerVersion > 19}
    LineStart: Integer;
{$IFEND}    
begin
  if LineIndex < 0 then Exit;
  FLine := Format(Text, StyleIndex);

{$IF CompilerVersion > 19}
  if WordWrap then begin
    if SelLine(LineIndex) then begin
      SelText := '';
      WriteFormattedText(FLine, SelStart);
    end else Exit;
  end else begin
    LineStart := SendMessage(Handle, EM_LINEINDEX, LineIndex, 0);
    if LineStart >= 0 then begin
      SendMessage(Handle, EM_SETSEL, LineStart, LineStart + SendMessage(Handle, EM_LINELENGTH, LineStart, 0));
      SendTextMessage(Handle, EM_REPLACESEL, 0, '');
      WriteFormattedText(FLine + #13#10, LineStart);
    end;
  end;
{$ELSE}
  if SelLine(LineIndex) then begin
    SelText := '';
    WriteFormattedText(FLine, SelStart);
  end else Exit;
{$IFEND}

  LMLines.Strings[LineIndex] := FLine;
end;

procedure TLangManRichEdit.InsertLine(LineIndex: Integer; const Text: String; StyleIndex: ShortInt = -1);
var FLine: String;
    LineStart, LineLength: Integer;
begin
  if LineIndex < 0 then Exit;
  FLine := Format(Text, StyleIndex);
  if WordWrap then begin
    if LineIndex > LMLines.Count then Exit;
    if LineIndex = LMLines.Count then WriteFormattedText(#13#10 + FLine, GetTextLen)
                                 else WriteFormattedText(FLine + #13#10, GetLineStart(LineIndex));
  end else begin
    LineStart := SendMessage(Handle, EM_LINEINDEX, LineIndex, 0);
    if LineStart >= 0 then begin
      WriteFormattedText(FLine + #13#10, LineStart);
    end else begin
      LineStart := SendMessage(Handle, EM_LINEINDEX, LineIndex - 1, 0);
      if LineStart < 0 then Exit;
      LineLength := SendMessage(Handle, EM_LINELENGTH, LineStart, 0);
      if LineLength = 0 then Exit;
      WriteFormattedText(#13#10 + FLine, LineStart + LineLength);
    end;
  end;
  LMLines.Insert(LineIndex, FLine);
end;

procedure TLangManRichEdit.Translate;
var LineIndex, TotalLength, LinesCount: Integer;
begin
  inherited Clear;
  SetupFont(-1);
  LinesCount := LMLines.Count;
  if LinesCount > 0 then begin
    TotalLength := WriteFormattedText(LMLines.Strings[0], 0);
    LineIndex := 1;
    while LineIndex < LinesCount do begin
      SelStart := TotalLength;
      SelText := #13#10;
      TotalLength := WriteFormattedText(LMLines.Strings[LineIndex], TotalLength + 2);
      Inc(LineIndex);
    end;
  end;
end;

procedure TLangManRichEdit.LoadFromFile(const SourceFile: TFileName);
begin
  LMLines.LoadFromFile(SourceFile);
  Translate;
end;

procedure TLangManRichEdit.LoadFromStream(SourceStream: TStream);
begin
  LMLines.LoadFromStream(SourceStream);
  Translate;
end;

procedure TLangManRichEdit.SaveRichTextToFile(const DestinationFile: TFileName);
begin
  Lines.SaveToFile(DestinationFile);
end;

procedure TLangManRichEdit.SaveRichTextToStream(DestinationStream: TStream);
begin
  Lines.SaveToStream(DestinationStream);
end;

procedure TLangManRichEdit.SaveEncodedFormToFile(const DestinationFile: TFileName);
begin
  LMLines.SaveToFile(DestinationFile);
end;

procedure TLangManRichEdit.SaveEncodedFormToStream(DestinationStream: TStream);
begin
  LMLines.SaveToStream(DestinationStream);
end;

{$IF CompilerVersion > 19}

procedure TLangManRichEdit.LoadFromFile(const SourceFile: TFileName; Encoding: TEncoding);
begin
  LMLines.LoadFromFile(SourceFile, Encoding);
  Translate;
end;

procedure TLangManRichEdit.LoadFromStream(SourceStream: TStream; Encoding: TEncoding);
begin
  LMLines.LoadFromStream(SourceStream, Encoding);
  Translate;
end;

procedure TLangManRichEdit.SaveRichTextToFile(const DestinationFile: TFileName; Encoding: TEncoding);
begin
  Lines.SaveToFile(DestinationFile, Encoding);
end;

procedure TLangManRichEdit.SaveRichTextToStream(DestinationStream: TStream; Encoding: TEncoding);
begin
  Lines.SaveToStream(DestinationStream, Encoding);
end;

procedure TLangManRichEdit.SaveEncodedFormToFile(const DestinationFile: TFileName; Encoding: TEncoding);
begin
  LMLines.SaveToFile(DestinationFile, Encoding);
end;

procedure TLangManRichEdit.SaveEncodedFormToStream(DestinationStream: TStream; Encoding: TEncoding);
begin
  LMLines.SaveToStream(DestinationStream, Encoding);
end;

{$IFEND}

//+****************************************************************************
//+*  LangMan LangCombo methods                                              **
//+****************************************************************************

{$IFNDEF LMCPP}
{$IFDEF DXE2}
class constructor TLangCombo.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TLangCombo, TComboBoxStyleHook);
end;
{$ENDIF}

{$IFDEF DXE3}
class destructor TLangCombo.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TLangCombo, TComboBoxStyleHook);
end;
{$ENDIF}
{$ENDIF}

procedure TLangCombo.SetLangManEngine(LangMan: TLangManEngine);
begin
  Items.Clear;
  SetClientEngine(Self, LangMan, TLangManCore(fLangManEngine));
end;

function TLangCombo.GetStyleCombo: TLangComboStyle;
begin
  case Style of
    csDropDownList: Result := scDropDownList;
    csOwnerDrawFixed: Result := scOwnerDrawFixed;
    csOwnerDrawVariable: Result := scOwnerDrawVariable;
    else begin
      Style := csDropDownList;
      Result := scDropDownList;
    end;
  end;
end;

procedure TLangCombo.SetStyleCombo(Input: TLangComboStyle);
begin
  case Input of
    scDropDownList: Style := csDropDownList;
    scOwnerDrawFixed: Style := csOwnerDrawFixed;
    scOwnerDrawVariable: Style := csOwnerDrawVariable;
    else Style := csDropDownList;
  end;
end;

procedure TLangCombo.ChangeLanguage(Sender: TObject);
begin
  if fLangManEngine <> nil then begin
    if (ItemIndex >= 0) and
       (Text <> fLangManEngine.CurrentLanguage) then begin
      fLangManEngine.Translate(Text);
      if Assigned(fOnChangeLanguage) then fOnChangeLanguage(Self);
    end;
  end;
end;

procedure TLangCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) AND (AComponent = fLangManEngine) then LangManEngine := nil;
end;

procedure TLangCombo.Loaded;
begin
  inherited Loaded;
  if Assigned(LangManEngine) then LangManEngine.RefreshLangControl(Self);
end;

constructor TLangCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csDropDownList;
  OnChange := ChangeLanguage;
end;

{$IFNDEF LMCPP}
{$IFDEF DXE2}
class constructor TLangFlagsCombo.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TLangFlagsCombo, TComboBoxExStyleHook);
end;
{$ENDIF}

{$IFDEF DXE3}
class destructor TLangFlagsCombo.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TLangFlagsCombo, TComboBoxExStyleHook);
end;
{$ENDIF}
{$ENDIF}

function TLangFlagsCombo.GetItemHt: Integer;
begin
  Result := Height - 6;
end;

procedure TLangFlagsCombo.SetLangManEngine(LangMan: TLangManEngine);
begin
  ItemsEx.Clear;
  SetClientEngine(Self, LangMan, TLangManCore(fLangManEngine));
end;

procedure TLangFlagsCombo.ChangeLanguage(Sender: TObject);
begin
  if fLangManEngine <> nil then begin
    if (ItemIndex >= 0) and
       (ItemsEx.Items[ItemIndex].Caption <> fLangManEngine.CurrentLanguage) then begin
      fLangManEngine.Translate(ItemsEx.Items[ItemIndex].Caption);
      if Assigned(fOnChangeLanguage) then fOnChangeLanguage(Self);
    end;
  end;
end;

procedure TLangFlagsCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) AND (AComponent = fLangManEngine) then LangManEngine := nil;
end;

procedure TLangFlagsCombo.Loaded;
begin
  inherited Loaded;
  if Assigned(LangManEngine) then LangManEngine.RefreshLangControl(Self);
end;

constructor TLangFlagsCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csExDropDownList;
  OnChange := ChangeLanguage;
end;

//+****************************************************************************
//+*  LangMan TLangFlag methods                                              **
//+****************************************************************************

procedure TLangFlag.SetLangManEngine(LangMan: TLangManEngine);
begin
  Picture := nil;
  SetClientEngine(Self, LangMan, TLangManCore(fLangManEngine));
end;

procedure TLangFlag.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) AND (AComponent = fLangManEngine) then LangManEngine := nil;
end;

procedure TLangFlag.Loaded;
begin
  inherited Loaded;
  if Assigned(LangManEngine) then LangManEngine.RefreshLangControl(Self);
end;

constructor TLangFlag.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Transparent := true;
  Center := true;
end;

//+****************************************************************************
//+*  LangMan Component additions engine                                     **
//+****************************************************************************

procedure RegisterProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TAdditionProperties; ItemAddr: String = '');
begin
  if (PropertyID in ActiveClient.TransAdditions) and ((ItemAddr <> '') or (Component.Name <> PropertyValue))
    then ActiveClient.CreateStructItem(
                                       Component,
                                       Ord(PropertyID) + ADDIT_NAMES_START,
                                       PropertyValue,
                                       ItemAddr
                                       );
end;

procedure RegisterProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TStringProperties; ItemAddr: String = '');
begin
  if (PropertyID in ActiveClient.TransStringProp) and ((ItemAddr <> '') or (Component.Name <> PropertyValue))
    then ActiveClient.CreateStructItem(
                                       Component,
                                       PropIndex(PropertyID),
                                       PropertyValue,
                                       ItemAddr
                                       );
end;

procedure RegisterProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TTStringsProperties; ItemAddr: String = '');
begin
  if (PropertyID in ActiveClient.TransTStringsProp) and ((ItemAddr <> '') or (Component.Name <> PropertyValue))
    then ActiveClient.CreateStructItem(
                                       Component,
                                       PropIndex(PropertyID),
                                       PropertyValue,
                                       ItemAddr
                                       );
end;

procedure RegisterProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TStructuredProperties; ItemAddr: String = '');
begin
  if (PropertyID in ActiveClient.TransStructuredProp) and ((ItemAddr <> '') or (Component.Name <> PropertyValue))
    then ActiveClient.CreateStructItem(
                                       Component,
                                       PropIndex(PropertyID),
                                       PropertyValue,
                                       ItemAddr
                                       );
end;

procedure RegisterProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TOtherProperties; ItemAddr: String = '');
begin
  if (PropertyID in ActiveClient.TransOtherProp) and ((ItemAddr <> '') or (Component.Name <> PropertyValue))
    then ActiveClient.CreateStructItem(
                                       Component,
                                       PropIndex(PropertyID),
                                       PropertyValue,
                                       ItemAddr
                                       );
end;

function TranslateProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TAdditionProperties; ItemAddr: String = ''): String;
var Bufstr: String;
begin
  if (PropertyID in ActiveClient.TransAdditions) then begin
    Bufstr := ActiveClient.StructItem(
                                      Component.Name,
                                      Component.Owner.Name,
                                      Ord(PropertyID) + ADDIT_NAMES_START,
                                      ItemAddr
                                      );
    if Bufstr <> '' then Result := Bufstr
                    else Result := PropertyValue;
  end else Result := PropertyValue;
end;

function TranslateProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TStringProperties; ItemAddr: String = ''): String;
var Bufstr: String;
begin
  if (PropertyID in ActiveClient.TransStringProp) then begin
    Bufstr := ActiveClient.StructItem(
                                      Component.Name,
                                      Component.Owner.Name,
                                      PropIndex(PropertyID),
                                      ItemAddr
                                      );
    if Bufstr <> '' then Result := Bufstr
                    else Result := PropertyValue;
  end else Result := PropertyValue;
end;

function TranslateProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TTStringsProperties; ItemAddr: String = ''): String;
var Bufstr: String;
begin
  if (PropertyID in ActiveClient.TransTStringsProp) then begin
    Bufstr := ActiveClient.StructItem(
                                      Component.Name,
                                      Component.Owner.Name,
                                      PropIndex(PropertyID),
                                      ItemAddr
                                      );
    if Bufstr <> '' then Result := Bufstr
                    else Result := PropertyValue;
  end else Result := PropertyValue;
end;

function TranslateProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TStructuredProperties; ItemAddr: String = ''): String;
var Bufstr: String;
begin
  if (PropertyID in ActiveClient.TransStructuredProp) then begin
    Bufstr := ActiveClient.StructItem(
                                      Component.Name,
                                      Component.Owner.Name,
                                      PropIndex(PropertyID),
                                      ItemAddr
                                      );
    if Bufstr <> '' then Result := Bufstr
                    else Result := PropertyValue;
  end else Result := PropertyValue;
end;

function TranslateProperty(Component: TComponent; PropertyValue: String;
                           PropertyID: TOtherProperties; ItemAddr: String = ''): String;
var Bufstr: String;
begin
  if (PropertyID in ActiveClient.TransOtherProp) then begin
    Bufstr := ActiveClient.StructItem(
                                      Component.Name,
                                      Component.Owner.Name,
                                      PropIndex(PropertyID),
                                      ItemAddr
                                      );
    if Bufstr <> '' then Result := Bufstr
                    else Result := PropertyValue;
  end else Result := PropertyValue;
end;

end.
