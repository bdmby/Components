//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManSys.pas                                              **
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

unit LangManSys;

{$DEFINE LM_SYSTEM}
{$INCLUDE LM_Config.inc}

interface

uses Classes,
{$IFDEF DXE2}
     System.Generics.Collections,
{$ELSE}
     Contnrs,
{$ENDIF}
     SysUtils;

//+****************************************************************************
//+*  LangMan Constants definitions                                          **
//+****************************************************************************

const
  LANGMAN_VERSION = '2.6';
  LANGMAN_VERSION_YEAR = '2016';
  LANGMAN_IDE_VCL_GROUP_NAME =  'Language Manager';
  LANGMAN_IDE_FMX_GROUP_NAME =  'Language Manager';
  LANGMAN_IDE_Uni_GROUP_NAME =  'Language Manager';
  DEFAULT_DESIGN_LANGUAGE = 'Design language';
  LANGMAN_IDE_EDITOR_CMD =  'Languages Editor';

  BLOCK_TEXT = -797;                        // key Tag value to block translation Text
  BLOCK_TEXT_TAG = 'Do not translate Text';
  BLOCK_TXT_OTHERS = -790;                  // key Tag value to block translation properties other than Text
  BLOCK_TXT_OTHERS_TAG = 'Translate Text only';
  BLOCK_HINT = -798;                        // key Tag value to block translation Hint
  BLOCK_HINT_TAG = 'Do not translate Hint'; // key Tag value to block translation Hint
  BLOCK_OTHERS = -789;                      // key Tag value to block translation other properties (not Hint)
  BLOCK_OTHERS_TAG = 'Translate Hint only'; // key Tag value to block translation other properties (not Hint)
  BLOCK_TRANSLATE = -799;                   // key Tag value to block translation all properties
  BLOCK_TRANSLATE_TAG = 'Do not translate'; // key Tag value to block translation all properties
  UNBLOCK_TAG = '> Reset <';

  UVOZOVKA = '"';       // Znak uvozující jazykový řetězec v jazykovém souboru
  STREDNIK = ';';       // Znak ukoncujici definici descriptoru
  TECKA = '.';          // Znak oddelujici nazev vlastnosti od indexu
  CARKA = ',';          // Znak oddelujici urovne adresy polozky
  ALTDOT = ':';         // Znak zastupujici v nazvu vlastnosti tecku
  LINK_IDENT = '«';     // Identifikacni znak odkazu na retezec Lexiconu
  STYLE_IDENT = '¬';    // Identifikacni znak definice stylu
  NR_IDENT = '#';       // Identifikacni znak ciselneho typu odkazu
  SR_IDENT_ST = '"';    // Uvozujici znak retezcoveho typu odkazu
  SR_LINK_END = '"»';   // Zakoncovaci znak retezcoveho odkazu
  BAD_LINK = '???';     // Zastupny symbol pri neplatnem odkazu
  OWNER_BEGINS = '@';   // Oddelovaci znak v identifikacnim retezci jazykove polozky
  PROPER_BEGINS = '#';  // Oddelovaci znak v identifikacnim retezci jazykove polozky
  ADDR_BEGINS = '[';    // Oddelovaci znak v identifikacnim retezci jazykove polozky
  DESCRIPTOR = '%';
  LANGUAGE_FILE_VERSION = 'THLF1';
  LANGUAGE_DESCRIPTOR =             DESCRIPTOR + 'LANGUAGE_NAME=';
  SUPERIOR_LANGUAGE_DESCRIPTOR =    DESCRIPTOR + 'SUPERIOR_LANGUAGE=';
  REF_LANG_DESCRIPTOR =             DESCRIPTOR + 'REF_LANG=';
  LANGUAGE_FILEVERSION_DESCRIPTOR = DESCRIPTOR + 'FILEVER=';
  LANGUAGE_ISO_CODE_DESCRIPTOR =    DESCRIPTOR + 'CODE=';
  OWNER_DESCRIPTOR =                DESCRIPTOR + 'OWNER=';
  COMPONENT_DESCRIPTOR =            DESCRIPTOR + 'COMPONENT=';
  ITEM_DESCRIPTOR =                 DESCRIPTOR + 'ITEM=';
  NOTRANS_DESCRIPTOR =              DESCRIPTOR + 'NOTRANS';
  OLD_ITEM_DESCRIPTOR =             DESCRIPTOR + 'OLD';
  LEXICON_SEPARATOR =               DESCRIPTOR + 'LEXICON_STRINGS';
  LEXICON_DESCRIPTOR =              DESCRIPTOR + 'LEXICON_NAME=';
  SMART_SEPARATOR =                 DESCRIPTOR + 'SMART_STRINGS';
  KEY_DESCRIPTOR =                  DESCRIPTOR + 'KEY=';
  FLAG_ICON_DESCRIPTOR =            DESCRIPTOR + 'FLAG_ICON';
  LANGMAN_DESCRIPTOR =              DESCRIPTOR + 'LANGMAN';
  cTAB = Char(#9);
  RID_INLINELEX = 'INLINE_LEXICON';
  ca_CHANGED = $4;
  ca_OLD = $2;
  ca_YES = $1;
  ca_NO  = $0;
  ODSAZENI = 5;
  CL_DESIGNED_FORM = $03F1F8;
  CL_REMOVED_ITEM = $2222CA;
  CL_GLOBAL_REMOVED_ITEM = $1111EE;
  CL_NONE_LOCAL = $5AA02C;
  CL_NONE_GLOBAL = $A0892C;
  CL_UNCHANGED_LOCAL = $28FFD4;
  CL_UNCHANGED_GLOBAL = $FFE580;
  CL_TRANSLATED_LOCAL = $00E922;
  CL_TRANSLATED_GLOBAL = $FF6600;
  CL_OLDTRANS = $FF55DD; // $0C7D02;
  CL_OLDITEM = $4C6C4C;
  CL_NOTRANS = $AFC6F9;
  CL_NONE = $7C7C7C;
  SGN_WIDTH = 5;
  SGN_MARGIN = 4;
  RESERVED_PROPS = 127;
  NOTDEF_SUBPROP = 499;
  EXT_NAMES_START = 500;
  ADDIT_NAMES_START = 1000;
  DEFAULT_COOKIE_LIFEDAYS = 400.5;
  // Descent item flags and masks
  FIND_ALL_DESCENTS = 512;
  GLOBAL_DESCENT_FLAG = 256;
  DESCENT_UNIFY = 403;
  DESCENT_MASK = 255;
  DESIGN_DESCENT = 255;
  MAX_DESCENT = 254;
  AUTO_LOADED_FROM_GLOBALS = 1;
  NEW_GLOBAL_ITEM_DESCENT = 1;
  TEMPORARY_GLOBAL_ITEM_DESCENT = 2;

  LANGMANLANG_ITEMS = 49;
  CREATOR_LANGITEM = 1;
  EDITOR_LANGITEM = 2;

type
  TInternalLangDefs = array[-2..LANGMANLANG_ITEMS] of string;

const
  // Built-in languages for Language Manager
  CZECH_LANGMAN: TInternalLangDefs = ('Čeština', 'cs',
  'Editor jazyků','> Přidat jazyk <','> Upravit jazyk <','Zvolte referenční jazyk','Jazyk',
  'Referenční jazyk','Referenční řetězec','Položka','Překlad','',
  'Skupina','Objekt','Založit nový jazyk pod uvedeným názvem','',
  'Skupina jazykových dat','Zpět - na nepřeložený objekt + Shift',
  'Další - nepřeložený objekt + Shift','Chyba při načítání jazyka. Jazykový soubor nelze načíst.',
  'Název nového jazyka','již v programu existuje! Zvolte jiný název.','Jazykové soubory',
  'Soubor nového jazyka','Chyba při ukládání jazykového souboru!',
  'Nebyl nalezen žádný nepřeložený objekt.','Opravdu chcete odejít bez uložení změn?',
  'Klikněte pro změnu vlajky. Pravým tlačítkem odebrat.','Import vlajky jazyka',
  'Opravdu chcete vymazat vlajku jazyka?','Uložit','Chybná cesta k jazykovým souborům!',
  'Přepnout stav položky (Klik nebo Ctrl+Šipka vlevo)',
  'Vnitřní jazyk návrhu', 'Zdrojový překlad', 'Globální zdrojový překlad',
  'Přeloženo', 'Globální překlad', 'Zrušení překladu',
  'Obnovený překlad', 'Ponechat zdrojový překlad', 'Neplatný překlad',
  'Export jazyka', 'LangMan export/import',
  'Výchozí jazyk aplikace nemůže být exportován',
  'Vyberte soubor k importu', 'Tento soubor nelze importovat', 'Import',
  'Jazykové soubory FireMonkey','Textové soubory',
  'Odstraněn globální překlad', 'Importováno %s položek');
  SLOVAK_LANGMAN: TInternalLangDefs = ('Slovenčina', 'sk',
  'Editor jazykov','> Pridať jazyk <','> Opraviť jazyk <','Vyberte referenčný jazyk','Jazyk',
  'Referenčný jazyk','Referenčný reťazec','Položka','Preklad','',
  'Skupina','Objekt','Založiť nový jazyk s uvedeným názvom','',
  'Skupina jazykových dát','Späť - na nepreložený objekt + Shift',
  'Ďalej - na nepreložený objekt + Shift','Chyba pri načítání jazykového súboru',
  'Názov nového jazyka','už v programe existuje! Zvoľte iný názov.','Jazykové súbory',
  'Súbor nového jazyka','Chyba pri zápise do jazykového súboru!',
  'Nebol nájdený nepreložený objekt.','Naozaj chcete odísť bez uloženia zmien?',
  'Kliknite pre zmenu vlajky. Pravým tlačítkom zrušiť.','Import vlajky jazyka',
  'Skutočne chcete vymazať vlajku jazyka?','Uložiť','Chybná cesta k jazykovým súborom!',
  'Prepnúť stav položky (Klik alebo Ctrl + šípka vľavo)',
  'Vnútorný jazyk návrhu', 'Zdrojový preklad', 'Globálny zdrojový preklad',
  'Preložené', 'Globálny preklad', 'Zrušenie prekladu',
  'Obnovený preklad', 'Zachovať zdrojový preklad', 'Neplatný preklad',
  'Export jazyka', 'LangMan export/import',
  'Východzí jazyk programu nie je možné exportovať',
  'Vyberte súbor pre import', 'Tento súbor sa nedá importovať', 'Import',
  'Jazykové súbory FireMonkey','Textové súbory',
  'Odstránený globálny preklad', 'Importovaných %s položiek');
  ENGLISH_LANGMAN: TInternalLangDefs = ('English', 'en',
  'Language Editor','> Add <','> Edit <','Choose source language','Language',
  'Source language','Source string','Property / Item','Translation','',
  'Group','Object','Create new language','',
  'Group of language data','Back - to untranslated object + Shift',
  'Next - untranslated object + Shift','Read error from language file',
  'New language name','already exists! Enter another name.','Language files',
  'New language file name','Saving of language file fail!',
  'Not found any untranslated object.','Close without saving changes?',
  'Click for change flag. Right button for remove.','Import language flag',
  'Do you really want to remove flag?','Save','Wrong path to language files!',
  'Toggle item status (Click or Ctrl + Left Arrow)',
  'Internal language', 'Source translation', 'Global source translation',
  'Translated', 'Global translation', 'Cancel translation',
  'Restored translation', 'Keep source translation', 'Invalid translation',
  'Export language', 'LangMan export/import',
  'The design language of the application can not be exported',
  'Select the file to import', 'This file can not be imported', 'Import',
  'FireMonkey Lang Files','Text files',
  'Global translation removed', '%s items has been imported');
  ITALIAN_LANGMAN: TInternalLangDefs = ('Italiano', 'it',
  'Editor di lingue','> Aggiungere lingua <','> Modificare lingua <', 'Scegliere lingua di riferimento','Lingua',
  'Lingua di riferimento','Catena di riferimento','Voce','Traduzione','',
  'Gruppo','Oggetto','Creare nuova lingua sotto il seguente nome','',
  'Gruppo dei dati linguistici','Indietro -  sull' + #39 + 'oggetto non tradotto + Shift',
  'Prossimo - oggetto non tradotto + Shift','Errore durante caricamento. File di lingua impossibile da caricare',
  'Nome della nuova lingua','già esistente nel programma. Scegliere nuovo nome.','File lingue',
  'File nuova lingua','Errore durante il salvataggio del file lingua.',
  'Non è stato trovato alcun oggetto non tradotto.','Sicuro di uscire senza salvare?',
  'Cliccare per cambiare la bandiera. Togliere con pulsante destro.','Import bandiera della lingua',
  'Sicuro di cancellare la bandiera della lingua?','Salvare','Percorso errato ai file di lingue.',
  'Cambire lo stato della voce. (Click oppure Ctrl+Freccia sinistra)',
  'Lingua originale della proposta', 'Traduzione di riferimento', 'Traduzione di riferimento globale',
  'Tradotto', 'Traduzione globale', 'Cancellazione della traduzione',
  'Traduzione rinnovata', 'Mantenere la traduzione di riferimento', 'Traduzione non valida',
  'Export di lingua', 'LangMan export/import',
  'Lingua originale dell' + #39 + 'applicazione non può essere esportata',
  'Scegli file destinato all' + #39 + 'import', 'Impossibile importare questo file', 'Import',
  'File linguistici FireMonkey','File di testo',
  'Traduzione globale rimosso', '%s voci sono stati importati');

type
//+****************************************************************************
//+*  LangMan translation definitions - not for custom changes!              **
//+*                                                                         **
//+*     For custom upgrade is reserved LM***Additions unit !!               **
//+*                                                                         **
//+****************************************************************************

  //trans String properties list (New property add as last. Max 32 items!)
  TStringProperties = (pnCaption = 0, pnHint, pnTextHint, pnEditLabelHint,
                       pnEditLabelCaption, pnText, pnTitle, pnValueName,
                       pnHelpKeyword, pnBalloonHint, pnBalloonTitle,
                       pnSimpleText, pnFileNameLabel, pnOkButtonLabel,
                       pnExpandButtonCaption, pnExpandedText, pnFooterText,
                       pnVerificationText, pnDialogCaption, pnHeaderTitle, pnPrompt);

  //trans TString properties list (New property add as last. Max 32 items!)
  TTStringsProperties = (pnLines = 0, pnItems, pnTitleCaptions, pnTabs, pnPages,
                         pnSections, pnHeader, pnFooter, pnInsertList, pnItemList,
                         pnAutoCompleteList);

  //trans Structured properties list (New property add as last. Max 32 items!)
  TStructuredProperties = (pnPanels = 0, pnBands, pnButtonCategories,
                           pnGrpButtonItems, pnTreeItems, pnListColumns,
                           pnListGroups, pnListItems, pnHeaderSections,
                           pnDBGridTitleCaptions, pnOutlineItems,
                           pnTabProducerColumns, pnFileTypes, pnButtons,
                           pnRadioButtons, pnMessages, pnKeyCaptions);

  //trans Other properties list (New property add as last. Max 32 items!)
  TOtherProperties = (pnFilter = 0,
                      {$IFDEF RAVE} cnRvProject, cnRvSystem, cnRvRender, pnPDF_DocInfo
                      {$ELSE} RvProject_DISABLED, RvSystem_DISABLED, RvRender_DISABLED, RAVE_IS_DISABLED {$ENDIF},
                      {$IFDEF TEECHART} cnTChart {$ELSE} TeeChart_IS_DISABLED {$ENDIF},
                      cnTActionManager, cnTGestureManager,
                      {$IFDEF RIBBONS}
                      cnTScreenTipItem,
                      {$ELSE}
                      cnTScreenTipItem_UNSUPP,
                      {$ENDIF}
                      {$IFDEF LM_UNIGUI} cpnScreenMask, cnTUniCalendarPanel, pnDateFormat,
                        pnTimeFormat, pnWebOptions
                      {$ELSE} ScreenMask_UNSUPP, UniCalendar_UNSUPP, DateFormat_UNSUPP,
                        TimeFormat_UNSUPP, WebOptions_UNSUPP
                      {$ENDIF}
                     );

  //trans Subnames for structured properties
  TExtPropertyName = (epnHeader = EXT_NAMES_START, epnFooter, epnBottomDescription,
                      epnSubsetTitle, epnSubtitle, epnTopDescription,
                      epnCommandLinkHint, epnAuthor, epnCreator, epnKeyWords,
                      epnProducer, epnSubject, epnDisplayMessage, epnName,
                      epnCustomText, epnDetail, epnDescription, epnTextPrompt,
                      epnFormat, epnOthers, epnServerMessages,
                      epnExtent);


const
  AUTHOR = 'REGULACE.ORG - Ing. Tomáš Halabala';
  //trans Comply with TxxxProperties
  PropertyName : array[0..RESERVED_PROPS] of string = ('Caption','Hint','TextHint',
                                                       'EditLabel.Hint','EditLabel.Caption',
                                                       'Text','Title','ValueName',
                                                       'HelpKeyword','BalloonHint',
                                                       'BalloonTitle','SimpleText',
                                                       'FileNameLabel','OkButtonLabel',
                                                       'ExpandButtonCaption',
                                                       'ExpandedText','FooterText',
                                                       'VerificationText','DialogCaption',
                                                       'HeaderTitle','Prompt','','',
                                                       '','','','','','','','','',
                                                       'Lines','Items','TitleCaptions',
                                                       'Tabs','Pages','Sections',
                                                       'Header','Footer','InsertList',
                                                       'ItemList','AutoCompleteList',
                                                       '','','',
                                                       '','','','','','','','',
                                                       '','','','','','','','',
                                                       '','',
                                                       'Panels','Bands','Category',
                                                       'Items','Items','Columns',
                                                       'Groups','Items','Sections',
                                                       'Columns','Items',
                                                       'Columns','FileTypes',
                                                       'Buttons','RadioButtons',
                                                       'Messages','KeyCaptions',
                                                       '','',
                                                       '','','','','','','','',
                                                       '','','','','',
                                                       'Filter','RV','RV',
                                                       'DisplayName','DocInfo',
                                                       'TCH',''{TActionClientItem},
                                                       'Gestures', 'ScreenTip',
                                                       'ScreenMask',''{CalendarPanel},
                                                       'DateFormat','TimeFormat',
                                                       'WebOptions',
                                                       '','','','','','','','',
                                                       '','','','','','','','',
                                                       '','');
  //trans Compy with TExtPropertyName
  ExtPropertyName: array[EXT_NAMES_START..Ord(epnExtent)] of string = ('Header',
                                                                       'Footer',
                                                                       'BottomDescription',
                                                                       'SubsetTitle',
                                                                       'SubTitle',
                                                                       'TopDescription',
                                                                       'CommandLinkHint',
                                                                       'Author',
                                                                       'Creator',
                                                                       'KeyWords',
                                                                       'Producer',
                                                                       'Subject',
                                                                       'DisplayMessage',
                                                                       'Name',
                                                                       'CustomText',
                                                                       'Detail',
                                                                       'Description',
                                                                       'TextPrompt',
                                                                       'Format',
                                                                       '',
                                                                       'ServerMessages',
                                                                       // sem pridavat EPN
                                                                       'Unknown');


//+**************************************************************************
//+*  LangMan System types                                                 **
//+**************************************************************************
type
  TLFEncoding = (Unicode = 0, BigEndianUnicode, UTF8, ANSI);
  TLLFOptions = set of (lloCreateSource, lloMarkOld, lloLoadFlag, lloLoadSuperior);

  TContinueQuery = procedure (Sender: TObject; var Continue: Boolean) of object;

{$IFDEF NEXTGEN}
  AnsiChar      = Char;
  ByteChar      = Byte;
  PAnsiChar     = TArray<Byte>;
  AnsiString    = TArray<Byte>;
{$ELSE}
  ByteChar      = AnsiChar;
{$ENDIF}
  TLanguage     = String;
  TISOCode      = String;
  TLangIDs      = record
    Name : TLanguage;
    Code : TISOCode;
  end;
  TPriority     = array[0..1] of TClass;

  TFullStructLine = record
    CompName    : string;
    OwnerName   : string;
    Translation : string;
    ItemAddr    : string;
    PropertyID  : Word;
    Descent     : Word;
    Changeable  : Word;
  end;

  TSimpleStructLine = record
    LineID      : string;
    Translation : string;
    Descent     : word;
    Changeable  : word;
  end;

  TDT_EOpt      = record
    Subdir      : string;
    DesignLang  : string;
    LangFileExt : string;
    LangFileSign: string;
  end;

//+****************************************************************************
//+*  LangMan System classes                                                 **
//+****************************************************************************
type
  TItemAddressList = class(TStringList)
  public
    procedure AddWord(value : Word);
    function GetWord(Index : Integer): Word;
    function IndexOfWord(value : Word): Integer;
    procedure RewriteWord(Index: Integer; Value: Word);
    procedure Inherit(Index: Integer);
    procedure InheritAll;
  end;

{$IF CompilerVersion > 19}
  TWordList = class(TObject)
  private
    FCount: Integer;
{$IFDEF NEXTGEN}
    Words: TArray<Word>;
{$ELSE}
    Words: array of Word;
{$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Assign(source: TWordList);
    procedure AddWord(value : Word);
    function GetWord(Index : Integer): Word;
    function IndexOfWord(value : Word): Integer;
    procedure RewriteWord(Index: Integer; Value: Word);
    procedure Delete(Index: Integer);
    procedure Inherit(Index: Integer);
    procedure InheritAll;
    property Count: Integer read FCount;
  end;
{$ELSE}
  TWordList = TItemAddressList;
{$IFEND}

  TStructItem = class( TObject )
  public
    Translation : String;
    Descent     : Word;
    Changeable  : Word;
    constructor Create(ItemTranslation: String; LangDescent, ItemChangeable: Word);
  end;

  TNamedObjectList = class( TStringList )
  protected
    procedure ReplaceObject(Index: Integer; Obj: TObject);
  public
    constructor CreateNamedList;
{$IF CompilerVersion < 20}
    destructor Destroy; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
{$IFEND}
  end;

  TComponentStructure = class(TObject)
  private
    LastFoundIndex: Integer;
    Lines : TNamedObjectList;
    function ExtractCompName(var PIDstr: PChar): String;
    function ExtractOwnerName(var PIDstr: PChar): String;
    function ExtractProperty(var PIDstr: PChar): String;
    function ExtractAddress(var PIDstr: PChar): String;
    function Info(LineIndex: Integer): TStructItem;
    function GetFoundTranslation: String;
    function GetTranslation(Index: Integer): String;
    function GetDescent(Index: Integer): Word;
    function GetChangeable(Index: Integer): Word;
    function GetPropertyID(Index: Integer): Word;
    function GetComponentName(Index: Integer): String;
    procedure SetFoundTranslation(NewTranslation: String);
    procedure SetTranslation(Index: Integer; NewTranslation: String);
    procedure SetDescent(Index: Integer; NewDescent: Word);
    procedure SetChangeable(Index: Integer; NewStatus: Word);
    function BlindLineID(const CompName, OwnerName: string; PropertyType: Word; const Addr: string): String; overload;
    function BlindLineID(const LineData: TFullStructLine): String; overload;
  public
    constructor Create;
    destructor Destroy; override;
    function SwitchLanguageOwner(Current, New: String): Boolean;
    function Find(const LineID: String): Integer; overload;
    function Find(const LineIndex: Integer; const ByStruct: TComponentStructure): Integer; overload;
    function Find(const LineData: TFullStructLine): Integer; overload;
    function Find(const CompName, OwnerName: string; PropertyType: Word; const Addr: string): Integer; overload;
    function Count: Integer;
    function LineID(Index: Integer): String;
    function GetSimple(Index: Integer): TSimpleStructLine;
    function GetFull(Index: Integer): TFullStructLine;
    function GetPropertyName(ItemIndex: Integer; LMAdditionNames: array of String): string;
    function GetString(const CompName, OwnerName: string; PropertyType: Word; const Addr: string = ''): String; overload;
    function GetString(const LineIndex: Integer; const ByStruct: TComponentStructure): String; overload;
    function ValidItem(Index: Integer): Boolean;
    function IsGlobal(Index: Integer): Boolean;
    procedure Clear;
    procedure NewLanguage;
    procedure Assign(Struct: TComponentStructure);
    procedure AddLine(InputData: TFullStructLine); overload;
    procedure AddLine(InputData: TSimpleStructLine); overload;
    procedure AddTextProperty(const ComponentName, OwnerName: String; PropertyType: Word; const Input, Addr: string);
    procedure Copy(Index: Integer; From: TComponentStructure);
    procedure SetupLine(LineIndex: Integer; Translation: String; Descent, Changeable: Word);
    procedure SetupLineBy(LineIndex, SourceLine: Integer; ByStruct: TComponentStructure; const Mark: Word = 0);
    procedure DeleteLine(Index: Integer);
    property FoundItem: String read GetFoundTranslation write SetFoundTranslation;
    property Translation[Index: Integer]: String read GetTranslation write SetTranslation;
    property Descent[Index: Integer]: Word read GetDescent write SetDescent;
    property Changeable[Index: Integer]: Word read GetChangeable write SetChangeable;
    property PropertyID[Index: Integer]: Word read GetPropertyID;
    property ComponentName[Index: Integer]: String read GetComponentName;
  end;

  TIndexedItems = class (TObject)
  private
    MaxAddress : Word;
{$IFDEF NEXTGEN}
    ItemPointer : TArray<Word>;
{$ELSE}
    ItemPointer : array of Word;
{$ENDIF}
    Items : TStringList;
    Descent : TWordList;
    function GetLangDescent(ItemNr: Integer): Word;
    procedure SetLangDescent(ItemNr: Integer; NewDescent: Word);
  public
    ListName : String;
    constructor Create(Name: string);
    destructor Destroy; override;
    function Count: Word;
    function MaxIndex: Word;
    function Get(ItemNr: Word): string;
    function IsIncluded(ItemNr: Word): Boolean;
    function IsGlobal(ItemNr: Word): Boolean;
    function IndexOf(const text: String): Integer;
    procedure Add(ItemNr: Word; Text: string; LangDescent: Word = 0);
    procedure Write(ItemNr: Word; Text: string; LangDescent: Word = 0);
    procedure Change(ItemNr: Word; Text: string);
    procedure Remove(ItemNr: Word);
    procedure Clear;
    procedure NewLanguage;
    property LangDescent[ItemNr: Integer]: Word read GetLangDescent write SetLangDescent;
  end;

  TLexiconData = class (TObject)
  private
    OpenedLexiconName : string;
    OpenedLexiconIndex: Integer;
{$IFDEF DXE2}
    LexiconsDatas     : TObjectList<TIndexedItems>;
{$ELSE}
    LexiconsDatas     : TObjectList;
{$ENDIF}
    LexiconsNames     : TStringList;
    function OpenLexicon(Name: string): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewLexicon(Name: string);
    procedure DeleteLexicon(LexName: string);
    procedure WriteItem(LexName: string; ItemNumber: Integer; Text: string; LangDescent: Word = 0);
    procedure ChangeItem(LexName: string; ItemNumber: Integer; Text: string);
    procedure RemoveItem(LexName: string; ItemNumber: Integer);
    function ReadItem(LexName: string; ItemNumber: Integer): string; overload;
    function ReadItem(LexName: string; ItemNumber: Integer; out LangDescent: Word): string; overload;
    procedure Clear;
    procedure NewLanguage;
    function LexiconCount: Word;
    function ItemsCount(LexName: string): Word;
    function LexiconName(Index: Integer): string;
    function MaxItemNr(LexName: string): Integer;
    function IsIncluded(LexName: string; ItemNumber: Integer): Boolean;
    function LexiconExists(LexName: string): Boolean;
  end;

//+****************************************************************************
//+*  LangMan System variables declarations                                  **
//+****************************************************************************

var DesignTime: Boolean = false;
    _ProjectPath, _EditComponentName: String;
    DT_EngineOptions: TDT_EOpt;

//+****************************************************************************
{$IFDEF LMULT}
{$I LMInline}
{$ENDIF}

{$IFDEF LMSMART}
{$I LMVocabularyItf}
{$ENDIF}
//+****************************************************************************
//+*  LangMan System functions declarations                                  **
//+****************************************************************************

function LowerCase(const str: String): String;
function LastChar(text: string): Char;
function GetLangDir(AppPath, Subdir: string): String;
function GetDescriptor(retezec, Descriptor: string): string;
function GetDescriptorEx(retezec, Descriptor: string; var EndChar: PChar): string;
function ReadLexiconOwner(retezec, Descriptor: string): string;
function ExtrahovatZUvozovek(retezec: string): string;
function ReadEncodedFromQuotes(str: string): string;
function EoStream(Stream: TStream): Boolean;
function EoFile(StringsFile: TStrings; CurLine: Integer): Boolean;
function StreamReadLn(Stream: TStream): string;
function StreamReadInt(Stream: TStream; var Value: Integer): Boolean;
function FileReadInt(StringsFile: TStrings; var Value: Integer; CurLine: Integer): Boolean;
{$IF CompilerVersion > 19}
function GetLangFileEncoding(LangFileName: String): TEncoding;
{$IFEND}
function GetLangIDs(LangFile, FileSign: string; LoadFlagOrder: Boolean): TLangIDs; overload;
function GetLangIDs(LStream: TResourceStream; FileSign: string; LoadFlagOrder: Boolean): TLangIDs; overload;
function GetEnvLangCode(LineTooLongRes: String): String;
function IsISO1(var ISOcode: TISOCode): Boolean;
function CheckPriorityAbsorption(Component: TComponent; InterestClass: TClass; PriorityArray: array of TPriority): boolean;
function ContainChars(str: string): boolean;
function ContaintWrappChar(str: String): Boolean;
procedure ReplaceChars(var Str: string; ReplaceChar, ReplaceAs: Char);
procedure DecodeSpecialChars(var Str: string);
function EncodeSpecialChar(const CharValue: Integer): String;
function EncodeChars(var Str: string; const iChar: Integer): Boolean;
function EncodeSpecialChars(var Str: string): Boolean;
function TepTranslation(input: String; AllowSpecials: Boolean): String;
function ChangeDescValue(TextLine, Descriptor, NewValue: string; EndChar: PChar): string;
function GetLexiconName(Lexicon: TComponent): string;
function GetDefaultGroup(GroupsList: TStrings): Integer;
function GetNameFromArrays(Index: Word; LMAdditionNames: array of String): string;
function PropIndex(Prop: TStringProperties): Word; overload;
function PropIndex(Prop: TTStringsProperties): Word; overload;
function PropIndex(Prop: TStructuredProperties): Word; overload;
function PropIndex(Prop: TOtherProperties): Word; overload;
function PropIndex(Prop: TExtPropertyName): Word; overload;
function AsPropertyName(Input: string): string;
function CreateAddr(Nr: Integer): string; overload;
function CreateAddr(const Text: String): string; overload;
function NestedAddr(const Addr: string; SubAddr: Integer): string; overload;
function NestedAddr(const Addr, SubAddr: string): string; overload;
function NestedProperty(Addr: string; Prop: TStringProperties): string; overload;
function NestedProperty(Addr: string; Prop: TTStringsProperties): string; overload;
function NestedProperty(Addr: string; Prop: TStructuredProperties): string; overload;
function NestedProperty(Addr: string; Prop: TOtherProperties): string; overload;
function NestedProperty(Addr: string; ExtProp: TExtPropertyName): string; overload;
function NestedProperty(Addr: string; Name: String): string; overload;
procedure DivertBack;
procedure Make(Buf: TMemoryStream; const inp: String);
procedure SaveFlag(LangFile: TStrings);
procedure LoadFlag(LangFile: TStrings; CurLine: Integer); overload;
procedure LoadFlag(LStream: TStream); overload;
procedure EraseFlag;
function LoadedFlag: Boolean;
function GetFlag: TMemoryStream;
function Czech(Lang: TLanguage): boolean;
function Slovak(Lang: TLanguage): boolean;
function English(Lang: TLanguage): boolean;

implementation

{$IFDEF DXE2}
uses System.Types,
{$ELSE}
uses Types,
{$ENDIF}

     LangManISO;

//+****************************************************************************
//+*  LangMan Methods of classes                                             **
//+****************************************************************************

procedure TItemAddressList.AddWord(value : Word);
begin
  Add(IntToStr(value));
end;
function TItemAddressList.GetWord(Index : Integer): Word;
begin
  Result := StrToIntDef(Get(Index),0);
end;
function TItemAddressList.IndexOfWord(value : Word): Integer;
begin
  Result := IndexOf(IntToStr(value));
end;
procedure TItemAddressList.RewriteWord(Index: Integer; Value: Word);
begin
  if Index < Count then Strings[Index] := IntToStr(Value);
end;
procedure TItemAddressList.Inherit(Index: Integer);
var Buf: Word;
begin
  if Index < Count then begin
    Buf := GetWord(Index);
    if Buf < MAX_DESCENT then begin
      Inc(Buf);
      Strings[Index] := IntToStr(Buf);
    end;
  end;
end;
procedure TItemAddressList.InheritAll;
var I: Integer;
begin
  if Count > 0 then begin
    for I := 0 to Count - 1 do Inherit(I);
  end;
end;

{$IF CompilerVersion > 19}
constructor TWordList.Create;
begin
  FCount := 0;
  SetLength(Words, 32);
end;
destructor TWordList.Destroy;
begin
  Words := nil;
  Inherited;
end;
procedure TWordList.Clear;
begin
  FCount := 0;
  if Length(Words) > 1024 then SetLength(Words, 32);
end;
procedure TWordList.Assign(source: TWordList);
var I: Integer;
begin
  FCount := source.Count;
  if (Length(Words) > (1024 + FCount)) OR (Length(Words) < FCount) then SetLength(Words, FCount + 32);
  for I := 0 to FCount - 1 do Words[I] := source.Words[I];
end;
procedure TWordList.AddWord(value : Word);
begin
  if FCount >= Length(Words) then SetLength(Words, FCount + 64);
  Words[FCount] := value;
  Inc(FCount);
end;
function TWordList.GetWord(Index : Integer): Word;
begin
  if Index < FCount then Result := Words[Index]
                    else Result := 0;
end;
function TWordList.IndexOfWord(value : Word): Integer;
var I: Integer;
begin
  Result := -1;
  if FCount > 0 then for I := 0 to FCount - 1 do begin
    if Words[I] = value then begin
      Result := I;
      Break;
    end;
  end;
end;
procedure TWordList.RewriteWord(Index: Integer; Value: Word);
begin
  if Index < FCount then Words[Index] := Value;
end;
procedure TWordList.Delete(Index: Integer);
var I: Integer;
begin
  if (Index >= 0) AND (Index < FCount) then begin
    Dec(FCount);
    while Index < FCount do begin
      I := Index + 1;
      Words[Index] := Words[I];
      Index := I;
    end;
  end;
end;
procedure TWordList.Inherit(Index: Integer);
begin
  if Index < FCount then begin
    if Words[Index] < MAX_DESCENT then Inc(Words[Index]);
  end;
end;
procedure TWordList.InheritAll;
var I: Integer;
begin
  if FCount > 0 then for I := 0 to FCount - 1 do Inherit(I);
end;
{$IFEND}

//+****************************************************************************

constructor TStructItem.Create(ItemTranslation: String; LangDescent, ItemChangeable: Word);
begin
  Translation := ItemTranslation;
  Descent     := LangDescent;
  Changeable  := ItemChangeable;
end;

//+****************************************************************************

constructor TNamedObjectList.CreateNamedList;
begin
  inherited Create;
{$IF CompilerVersion > 19}
  OwnsObjects := true;
{$IFEND}
  CaseSensitive := true;
  Sorted := true;
  Duplicates := dupIgnore;
end;

{$IF CompilerVersion < 20}
destructor TNamedObjectList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TNamedObjectList.Clear;
var I: Integer;
begin
  for I := 0 to Count - 1 do Objects[I].Free;
  inherited Clear;
end;

procedure TNamedObjectList.Delete(Index: Integer);
begin
  Objects[Index].Free;
  inherited Delete(Index);
end;
{$IFEND}

procedure TNamedObjectList.ReplaceObject(Index: Integer; Obj: TObject);
var ItObj: TObject;
begin
  ItObj := Objects[Index];
  if ItObj <> nil then ItObj.Free;
  Pointer(ItObj) := nil;
  Objects[Index] := Obj;
end;

//+****************************************************************************

function TComponentStructure.ExtractCompName(var PIDstr: PChar): String;
begin
  Result := '';
  while (PIDstr^ <> #0) AND (PIDstr^ <> OWNER_BEGINS) do begin
    Result := Result + PIDstr^;
    Inc(PIDstr);
  end;
end;
function TComponentStructure.ExtractOwnerName(var PIDstr: PChar): String;
begin
  Result := '';
  while (PIDstr^ <> #0) AND (PIDstr^ <> OWNER_BEGINS) do Inc(PIDstr);
  Inc(PIDstr);
  while (PIDstr^ <> #0) AND (PIDstr^ <> PROPER_BEGINS) do begin
    Result := Result + PIDstr^;
    Inc(PIDstr);
  end;
end;
function TComponentStructure.ExtractProperty(var PIDstr: PChar): String;
begin
  Result := '';
  while (PIDstr^ <> #0) AND (PIDstr^ <> PROPER_BEGINS) do Inc(PIDstr);
  Inc(PIDstr);
  while (PIDstr^ <> #0) AND (PIDstr^ <> ADDR_BEGINS) do begin
    Result := Result + PIDstr^;
    Inc(PIDstr);
  end;
end;
function TComponentStructure.ExtractAddress(var PIDstr: PChar): String;
begin
  Result := '';
  while (PIDstr^ <> #0) AND (PIDstr^ <> ADDR_BEGINS) do Inc(PIDstr);
  Inc(PIDstr);
  while (PIDstr^ <> #0) do begin
    Result := Result + PIDstr^;
    Inc(PIDstr);
  end;
end;
function TComponentStructure.Info(LineIndex: Integer): TStructItem;
begin
  Result := TStructItem(Lines.Objects[LineIndex]);
end;
function TComponentStructure.GetFoundTranslation: String;
begin
  if LastFoundIndex >= 0 then Result := Info(LastFoundIndex).Translation
                         else Result := '';
end;
procedure TComponentStructure.SetFoundTranslation(NewTranslation: string);
begin
  if LastFoundIndex >= 0 then Info(LastFoundIndex).Translation := NewTranslation;
end;
function TComponentStructure.GetTranslation(Index: Integer): String;
begin
  Result := Info(Index).Translation;
end;
procedure TComponentStructure.SetTranslation(Index: Integer; NewTranslation: String);
begin
  Info(Index).Translation := NewTranslation;
end;
function TComponentStructure.GetDescent(Index: Integer): Word;
begin
  Result := Info(Index).Descent;
end;
procedure TComponentStructure.SetDescent(Index: Integer; NewDescent: Word);
begin
  Info(Index).Descent := NewDescent;
end;
function TComponentStructure.GetChangeable(Index: Integer): Word;
begin
  Result := Info(Index).Changeable;
end;
procedure TComponentStructure.SetChangeable(Index: Integer; NewStatus: Word);
begin
  Info(Index).Changeable := NewStatus;
end;
function TComponentStructure.GetPropertyID(Index: Integer): Word;
var PLine: PChar;
begin
  PLine := PChar(Lines.Strings[Index]);
  Result := StrToInt(ExtractProperty(PLine));
end;
function TComponentStructure.GetComponentName(Index: Integer): String;
var PLine: PChar;
begin
  PLine := PChar(Lines.Strings[Index]);
  Result := ExtractCompName(PLine);
end;
function TComponentStructure.BlindLineID(const CompName, OwnerName: string; PropertyType: Word; const Addr: string): String;
begin
  Result := CompName + OWNER_BEGINS + OwnerName + PROPER_BEGINS + IntToStr(PropertyType) + ADDR_BEGINS + Addr;
end;
function TComponentStructure.BlindLineID(const LineData: TFullStructLine): String;
begin
  with LineData do Result := CompName + OWNER_BEGINS + OwnerName + PROPER_BEGINS + IntToStr(PropertyID) + ADDR_BEGINS + ItemAddr;
end;
constructor TComponentStructure.Create;
begin
  Lines := TNamedObjectList.CreateNamedList;
end;
destructor  TComponentStructure.Destroy;
begin
  Lines.Free;
  Inherited;
end;
function TComponentStructure.SwitchLanguageOwner(Current: string; New: string): Boolean;
var si: Integer;
    CompName, CurrentOwner: String;
    PLine: PChar;
begin
  Result := false;
  if Lines.Count > 0 then begin
    Lines.Sorted := false;
    for si := 0 to Lines.Count - 1 do begin
      PLine := PChar(Lines.Strings[si]);
      CompName := ExtractCompName(PLine);
      CurrentOwner := ExtractOwnerName(PLine);
      if (CurrentOwner = Current) AND (PLine^ = PROPER_BEGINS) then begin
        Lines.Strings[si] := CompName + OWNER_BEGINS + New + String(PLine);
        Result := true;
      end;
    end;
    Lines.Sorted := true;
  end;
end;
function TComponentStructure.Find(const LineID: String): Integer;
begin
  LastFoundIndex := Lines.IndexOf(LineID);
  Result := LastFoundIndex;
end;
function TComponentStructure.Find(const LineIndex: Integer; const ByStruct: TComponentStructure): Integer;
begin
  if LineIndex < ByStruct.Lines.Count then LastFoundIndex := Lines.IndexOf(ByStruct.Lines.Strings[LineIndex])
                                      else LastFoundIndex := -1;
  Result := LastFoundIndex;
end;
function TComponentStructure.Find(const LineData: TFullStructLine): Integer;
begin
  LastFoundIndex := Lines.IndexOf(BlindLineID(LineData));
  Result := LastFoundIndex;
end;
function TComponentStructure.Find(const CompName, OwnerName: string; PropertyType: Word; const Addr: string): Integer;
begin
  LastFoundIndex := Lines.IndexOf(BlindLineID(CompName, OwnerName, PropertyType, Addr));
  Result := LastFoundIndex;
end;
function TComponentStructure.Count: Integer;
begin
  Result := Lines.Count;
end;
function TComponentStructure.LineID(Index: Integer): String;
begin
  if (Index < 0) OR (Index >= Lines.Count) then Result := ''
                                           else Result := Lines.Strings[Index];
end;
function TComponentStructure.GetSimple(Index: Integer): TSimpleStructLine;
var ItemInfo: TStructItem;
begin
  if (Index >= 0) and (Index < Lines.Count) then begin
    Result.LineID := Lines.Strings[Index];
    ItemInfo := Info(Index);
    Result.Translation := ItemInfo.Translation;
    Result.Descent := ItemInfo.Descent;
    Result.Changeable := ItemInfo.Changeable;
  end else begin
    Result.LineID := '';
    Result.Translation := '';
    Result.Descent := DESIGN_DESCENT;
    Result.Changeable := 0;
  end;
end;
function TComponentStructure.GetFull(Index: Integer): TFullStructLine;
var PLine: PChar;
    ItemInfo: TStructItem;
begin
  if (Index >= 0) and (Index < Lines.Count) then begin
    PLine := PChar(Lines.Strings[Index]);
    Result.CompName := ExtractCompName(PLine);
    Result.OwnerName := ExtractOwnerName(PLine);
    Result.PropertyID := StrToIntDef(ExtractProperty(PLine), Ord(epnExtent));
    Result.ItemAddr := ExtractAddress(PLine);
    ItemInfo := Info(Index);
    Result.Translation := ItemInfo.Translation;
    Result.Descent := ItemInfo.Descent;
    Result.Changeable := ItemInfo.Changeable;
  end else begin
    Result.CompName := '';
    Result.OwnerName := '';
    Result.ItemAddr := '';
    Result.Translation := '';
    Result.PropertyID := Ord(epnExtent);
    Result.Descent := DESIGN_DESCENT;
    Result.Changeable := ca_NO;
  end;
end;
function TComponentStructure.GetPropertyName(ItemIndex: Integer; LMAdditionNames: array of String): string;
const LOW_ADDR_LIMIT = -32000;
var PLine: PChar;
    Lvl, LvlAddr, ItemAddr: Integer;
    Rec: String;
begin
  PLine := PChar(Lines.Strings[ItemIndex]);
  Result := GetNameFromArrays(StrToIntDef(ExtractProperty(PLine), Ord(epnExtent)), LMAdditionNames);
  while (PLine^ <> #0) AND (PLine^ <> ADDR_BEGINS) do Inc(PLine);
  if (PLine^ = #0) then Exit;
  Inc(PLine);
  Lvl := 0;
  repeat
    // Level address
    Rec := '';
    while (PLine^ <> #0) AND (PLine^ <> TECKA) AND (PLine^ <> CARKA) do begin
      Rec := Rec + PLine^;
      Inc(PLine);
    end;
    LvlAddr := StrToIntDef(Rec, LOW_ADDR_LIMIT);
    if (PLine^ = TECKA) then begin
      Inc(PLine);
      Rec := '';
      while (PLine^ <> #0) AND (PLine^ <> CARKA) do begin
        Rec := Rec + PLine^;
        Inc(PLine);
      end;
      ItemAddr := StrToIntDef(Rec, NOTDEF_SUBPROP);
    end else ItemAddr := NOTDEF_SUBPROP;
    if PLine^ = CARKA then Inc(PLine);

    // Property name
    if (ItemAddr = NOTDEF_SUBPROP) then begin
      if ContainChars(Rec) then begin
        if LvlAddr > LOW_ADDR_LIMIT then Result := Result + '[' + IntToStr(LvlAddr) + '].'
                                    else if Result <> '' then Result := Result + '.';
        ReplaceChars(Rec, ALTDOT, '.');
        ReplaceChars(Rec, '=', ' ');     // LangListEditor.Strings.NameValueSeparator = '='
        Result := Result + Rec;
      end else if LvlAddr > LOW_ADDR_LIMIT then begin
        if (Lvl = 0) AND (PLine^ = #0) then Result := Result + '.Item[' + IntToStr(LvlAddr) + ']'
                                       else begin
                                         Result := Result + '[' + IntToStr(LvlAddr) + ']';
                                         if Lvl = 0 then Result := Result + '.Item';
                                       end;
      end;
    end else begin
      if LvlAddr > LOW_ADDR_LIMIT then Result := Result + '[' + IntToStr(LvlAddr) + '].'
                                  else if Result <> '' then Result := Result + '.';
      if ItemAddr < Ord(epnExtent) then Result := Result + GetNameFromArrays(ItemAddr, LMAdditionNames)
                                   else Result := Result + GetNameFromArrays(Ord(epnExtent), LMAdditionNames);
    end;
  until PLine^ = #0;
end;
function TComponentStructure.GetString(const CompName, OwnerName: string; PropertyType: Word; const Addr: string = ''): String;
var I: Integer;
begin
  I := Lines.IndexOf(BlindLineID(CompName, OwnerName, PropertyType, Addr));
  if I >= 0 then Result := Info(I).Translation
            else Result := '';
end;
function TComponentStructure.GetString(const LineIndex: Integer; const ByStruct: TComponentStructure): String;
var li: Integer;
begin
  if LineIndex < ByStruct.Lines.Count then begin
    li := Lines.IndexOf(ByStruct.Lines.Strings[LineIndex]);
    if li >= 0 then Result := Info(li).Translation
               else Result := '';
  end else Result := '';
end;
function TComponentStructure.ValidItem(Index: Integer): Boolean;
var Chan: Word;
    ItemInfo: TStructItem;
begin
  ItemInfo := Info(Index);
  Chan := ItemInfo.Changeable;
  Result := (Chan AND ca_YES) = ca_YES;
  ItemInfo.Changeable := Chan AND (NOT ca_OLD);
end;
function TComponentStructure.IsGlobal(Index: Integer): Boolean;
begin
  Result := (Info(Index).Descent AND GLOBAL_DESCENT_FLAG) = GLOBAL_DESCENT_FLAG;
end;
procedure TComponentStructure.Clear;
begin
  Lines.Clear;
end;
procedure TComponentStructure.NewLanguage;
var li: Integer;
    ItemInfo: TStructItem;
begin
  for li := 0 to Lines.Count - 1 do begin
    ItemInfo := Info(li);
    if ItemInfo.Descent < MAX_DESCENT then Inc(ItemInfo.Descent);
  end;
end;
procedure TComponentStructure.Assign(Struct: TComponentStructure);
var Index: Integer;
begin
  Clear;
  if Struct.Lines.Count > 0 then begin
    for Index := 0 to Struct.Lines.Count - 1 do Copy(Index, Struct);
  end;
end;
procedure TComponentStructure.AddLine(InputData: TFullStructLine);
var LineNr: Integer;
begin
  with InputData do begin
    LineNr := Lines.AddObject(BlindLineID(InputData), nil);
    if LineNr >= 0 then Lines.ReplaceObject(LineNr, TStructItem.Create(Translation, Descent, Changeable));
  end;
end;
procedure TComponentStructure.AddLine(InputData: TSimpleStructLine);
var LineNr: Integer;
begin
  with InputData do begin
    LineNr := Lines.AddObject(LineID, nil);
    if LineNr >= 0 then Lines.ReplaceObject(LineNr, TStructItem.Create(Translation, Descent, Changeable));
  end;
end;
procedure TComponentStructure.AddTextProperty(const ComponentName, OwnerName: String; PropertyType: Word; const Input, Addr: string);
var encoded: String;
    LineNr: Integer;
begin
  if ContainChars(Input) then begin
    encoded := Input;
    EncodeSpecialChars(encoded);
    LineNr := Lines.AddObject(BlindLineID(ComponentName, OwnerName, PropertyType, Addr), nil);
    if LineNr >= 0 then Lines.ReplaceObject(LineNr, TStructItem.Create(encoded, DESIGN_DESCENT, ca_YES));
  end;
end;
procedure TComponentStructure.Copy(Index: Integer; From: TComponentStructure);
begin
  AddLine(From.GetSimple(Index));
end;
procedure TComponentStructure.SetupLine(LineIndex: Integer; Translation: String; Descent, Changeable: Word);
var ItemInfo: TStructItem;
begin
  ItemInfo := Info(LineIndex);
  ItemInfo.Translation := Translation;
  ItemInfo.Descent := Descent;
  ItemInfo.Changeable := Changeable;
end;
procedure TComponentStructure.SetupLineBy(LineIndex, SourceLine: Integer; ByStruct: TComponentStructure; const Mark: Word = 0);
var SelfInfo, SourceInfo: TStructItem;
begin
  if (Cardinal(LineIndex) < Cardinal(Lines.Count)) AND
     (Cardinal(SourceLine) < Cardinal(ByStruct.Lines.Count)) then begin
    SelfInfo := Info(LineIndex);
    SourceInfo := ByStruct.Info(SourceLine);
    SelfInfo.Translation := SourceInfo.Translation;
    SelfInfo.Descent := SourceInfo.Descent;
    SelfInfo.Changeable := SourceInfo.Changeable OR Mark;
  end;
end;
procedure TComponentStructure.DeleteLine(Index: Integer);
begin
  Lines.Delete(Index);
end;

function TIndexedItems.GetLangDescent(ItemNr: Integer): Word;
begin
  if ItemNr <= MaxAddress then Result := Descent.GetWord(ItemPointer[ItemNr])
                          else Result := DESIGN_DESCENT;
end;
procedure TIndexedItems.SetLangDescent(ItemNr: Integer; NewDescent: Word);
begin
  if ItemNr <= MaxAddress then Descent.RewriteWord(ItemPointer[ItemNr], NewDescent);
end;
constructor TIndexedItems.Create(Name: string);
begin
  MaxAddress := 0;
  ItemPointer := nil;
  SetLength(ItemPointer,32);
  ItemPointer[0] := 0;
  Descent := TWordList.Create;
  Descent.AddWord(DESIGN_DESCENT);
  Items := TStringList.Create;
  Items.Add('');
  ListName := Name;
end;
destructor TIndexedItems.Destroy;
begin
  ItemPointer := nil;
  Items.Free;
  Descent.Free;
  Inherited;
end;
function TIndexedItems.Count: Word;
begin
  Result := Items.Count - 1;
end;
function TIndexedItems.MaxIndex: Word;
begin
  Result := MaxAddress;
end;
function TIndexedItems.Get(ItemNr: Word): string; // Pro -1 je ItemNr 65535
begin
  if ItemNr <= MaxAddress then Result := Items.Strings[ItemPointer[ItemNr]]
                          else Result := '';
end;
function TIndexedItems.IsIncluded(ItemNr: Word): boolean;
begin
  if (ItemNr <= MaxAddress) then Result := ItemPointer[ItemNr] <> 0
                            else Result := false;
end;
function TIndexedItems.IsGlobal(ItemNr: Word): Boolean;
begin
  if ItemNr <= MaxAddress then Result := (Descent.GetWord(ItemPointer[ItemNr]) ANd GLOBAL_DESCENT_FLAG) <> 0
                          else Result := false;
end;
function TIndexedItems.IndexOf(const text: String): Integer;
var PosInList, I: Integer;
begin
  Result := -1;
  if text = '' then Exit;
  PosInList := Items.IndexOf(text);
  if PosInList > 0 then begin   // 0 je ''
    for I := 0 to MaxAddress do if ItemPointer[I] = PosInList then begin
      Result := I;
      Exit;
    end;
  end;
end;
procedure TIndexedItems.Add(ItemNr: Word; Text: string; LangDescent: Word = 0);
begin
  if ItemNr > High(ItemPointer) then SetLength(ItemPointer,ItemNr+64);
  while ItemNr > MaxAddress do begin
    Inc(MaxAddress);
    ItemPointer[MaxAddress] := 0;
  end;
  ItemPointer[ItemNr] := Items.Add(Text);
  Descent.AddWord(LangDescent);
end;
procedure TIndexedItems.Write(ItemNr: Word; Text: string; LangDescent: Word = 0);
begin
  if IsIncluded(ItemNr) then begin
    Items.Strings[ItemPointer[ItemNr]] := Text;
    Descent.RewriteWord(ItemPointer[ItemNr], LangDescent);
  end else Add(ItemNr, Text, LangDescent);
end;
procedure TIndexedItems.Change(ItemNr: Word; Text: string);
begin
  if IsIncluded(ItemNr) then Items.Strings[ItemPointer[ItemNr]] := Text;
end;
procedure TIndexedItems.Remove(ItemNr: Word);
begin
  if (ItemNr <= MaxAddress) then begin
    Items.Strings[ItemPointer[ItemNr]] := '';
    Descent.RewriteWord(ItemPointer[ItemNr], DESIGN_DESCENT);
    ItemPointer[ItemNr] := 0;
  end;
end;
procedure TIndexedItems.Clear;
begin
  MaxAddress := 0;
  if Length(ItemPointer) > 1024 then SetLength(ItemPointer, 32);
  ItemPointer[0] := 0;
  Items.Clear;
  Items.Add('');
  Descent.Clear;
  Descent.AddWord(DESIGN_DESCENT);
end;
procedure TIndexedItems.NewLanguage;
begin
  Descent.InheritAll;
end;

constructor TLexiconData.Create;
begin
  OpenedLexiconName := '';
  OpenedLexiconIndex := -2;
{$IFDEF DXE2}
  LexiconsDatas := TObjectList<TIndexedItems>.Create(true);
{$ELSE}
  LexiconsDatas := TObjectList.Create;
{$ENDIF}
  LexiconsNames := TStringList.Create;
end;
destructor TLexiconData.Destroy;
begin
  LexiconsDatas.Free;
  LexiconsNames.Free;
  inherited;
end;
function TLexiconData.OpenLexicon(Name: string): boolean;
begin
  if Name = '' then Result := false
               else begin
    if Name <> OpenedLexiconName then begin
      OpenedLexiconIndex := LexiconsNames.IndexOf(Name);
      if OpenedLexiconIndex >= 0 then OpenedLexiconName := Name
                                 else OpenedLexiconName := '';
    end;
    Result := OpenedLexiconIndex >= 0;
  end;
end;
procedure TLexiconData.NewLexicon(Name: string);
begin
  if LexiconsNames.IndexOf(Name) < 0 then begin
    OpenedLexiconIndex := LexiconsDatas.Add(TIndexedItems.Create(Name));
    if LexiconsNames.Add(Name) = OpenedLexiconIndex then OpenedLexiconName := Name
                                                    else begin
      OpenedLexiconIndex := -2;
      OpenedLexiconName := '';
    end;
  end else OpenLexicon(Name);
end;
procedure TLexiconData.DeleteLexicon(LexName: string);
var LexIndex: Integer;
begin
  LexIndex := LexiconsNames.IndexOf(LexName);
  if LexIndex >= 0 then begin
    if OpenedLexiconName = LexName then begin
      OpenedLexiconIndex := -2;
      OpenedLexiconName := '';
    end;
    LexiconsDatas.Delete(LexIndex);
    LexiconsNames.Delete(LexIndex);
  end;
end;
procedure TLexiconData.WriteItem(LexName: string; ItemNumber: Integer; Text: string; LangDescent: Word = 0);
begin
  if OpenLexicon(LexName)
    then (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).Write(ItemNumber,Text,LangDescent);
end;
procedure TLexiconData.ChangeItem(LexName: string; ItemNumber: Integer; Text: string);
begin
  if OpenLexicon(LexName)
    then (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).Change(ItemNumber,Text);
end;
procedure TLexiconData.RemoveItem(LexName: string; ItemNumber: Integer);
begin
  if OpenLexicon(LexName)
    then (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).Remove(ItemNumber);
end;
function TLexiconData.ReadItem(LexName: string; ItemNumber: Integer): string;
begin
  if OpenLexicon(LexName)
    then Result := (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).Get(ItemNumber)
    else Result := '';
end;
function TLexiconData.ReadItem(LexName: string; ItemNumber: Integer; out LangDescent: Word): string;
begin
  if OpenLexicon(LexName) then begin
    LangDescent := (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).LangDescent[ItemNumber];
    Result := (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).Get(ItemNumber);
  end else begin
    LangDescent := DESIGN_DESCENT;
    Result := '';
  end;
end;
procedure TLexiconData.Clear;
begin
  OpenedLexiconName := '';
  OpenedLexiconIndex := -2;
  LexiconsDatas.Clear;
  LexiconsNames.Clear;
end;
procedure TLexiconData.NewLanguage;
var I: Integer;
begin
  if LexiconsDatas.Count > 0 then begin
    for I := 0 to LexiconsDatas.Count - 1 do begin
      (LexiconsDatas.Items[I] as TIndexedItems).NewLanguage;
    end;
  end;
end;
function TLexiconData.LexiconCount: Word;
begin
  Result := LexiconsNames.Count;
end;
function TLexiconData.ItemsCount(LexName: string): Word;
begin
  if OpenLexicon(LexName)
    then Result := (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).Count
    else Result := 0;
end;
function TLexiconData.LexiconName(Index: Integer): string;
begin
  Result := LexiconsNames.Strings[Index];
end;
function TLexiconData.MaxItemNr(LexName: string): Integer;
begin
  if OpenLexicon(LexName)
    then Result := (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).MaxIndex
    else Result := -1;
end;
function TLexiconData.IsIncluded(LexName: string; ItemNumber: Integer): Boolean;
begin
  if OpenLexicon(LexName)
    then Result := (LexiconsDatas.Items[OpenedLexiconIndex] as TIndexedItems).IsIncluded(ItemNumber)
    else Result := false;
end;
function TLexiconData.LexiconExists(LexName: string): Boolean;
begin
  Result := LexiconsNames.IndexOf(LexName) >= 0;
end;

//+****************************************************************************
//+*  LangMan System functions definitions                                   **
//+****************************************************************************

function LowerCase(const str: String): String;
begin
{$IFDEF NEXTGEN}
  Result := str.ToLower;
{$ELSE}
{$IFDEF DXE2}
  Result := System.SysUtils.LowerCase(str);
{$ELSE}
  Result := SysUtils.LowerCase(str);
{$ENDIF}
{$ENDIF}
end;

function LastChar(text: string): Char;
begin
{$IFDEF NEXTGEN}
  Result := text.Chars[High(text)];
{$ELSE}
  Result := text[Length(text)];
{$ENDIF}
end;


function CorrectPath(path: string): String;
var si: integer;
    oddb: Boolean;
begin
  Result := '';
  oddb := false;
{$IFDEF NEXTGEN}
  for si := Low(path) to High(path) do begin
{$ELSE}
  for si := 1 to Length(path) do begin
{$ENDIF}
    if (path[si] = '/') OR (path[si] = '\') then begin
{      if oddb then Continue
              else} oddb := true;

{$IFDEF MSWINDOWS}
      Result := Result + '\';
{$ELSE}
      Result := Result + '/';
{$ENDIF}
    end else begin
      oddb := false;
      Result := Result + path[si];
    end;
  end;
  if (oddb = false) AND (Result <> '') then begin
{$IFDEF MSWINDOWS}
    Result := Result + '\';
{$ELSE}
    Result := Result + '/';
{$ENDIF}
  end;
end;

function GetLangDir(AppPath, Subdir: String): String;
var LangFilesPath: string;
begin
  LangFilesPath := AppPath + Subdir;
{$IFDEF POSIX}
  if (Subdir <> '') then begin
{$IFDEF NEXTGEN}
    if (Subdir[0] = '/') then LangFilesPath := Subdir;
{$ELSE}
    if (Subdir[1] = '/') then LangFilesPath := Subdir;
{$ENDIF}
  end;
{$ENDIF}
{$IFDEF MSWINDOWS}
  if (ExtractFileDrive(Subdir) <> '') OR (Pos('\\', Subdir) = 1) then LangFilesPath := Subdir
                                                                 else if (Subdir <> '') then begin
    if (Subdir[1] = '\') or (Subdir[1] = '/') then LangFilesPath := AppPath + Copy(Subdir, 2, Length(Subdir)-1);
  end;
{$ENDIF}
  Result := CorrectPath(LangFilesPath);
end;

function GetDescriptor(retezec, Descriptor: string): string;
var Bufstr: string;
    Len   : Integer;
begin
  Len := Pos(Descriptor,retezec);
  if Len > 0 then begin
    Len := Len + Length(Descriptor);
    Bufstr := Copy(retezec,Len,(Length(retezec)-Len)+1);
    Result := Copy(Bufstr,1,Pos(STREDNIK,Bufstr)-1);
  end else Result := '';
end;

function GetDescriptorEx(retezec, Descriptor: string; var EndChar: PChar): string;
var DotPos: Integer;
begin
  Result := GetDescriptor(retezec,Descriptor);
  DotPos := Pos(TECKA,Result);
  if DotPos > 0 then begin
    EndChar := TECKA;
    Result := Copy(Result, 1, DotPos - 1);
  end else EndChar := STREDNIK;
end;

function ReadLexiconOwner(retezec, Descriptor: string): string;
var Bufstr: string;
    Len   : Integer;
begin
  Len := Pos(Descriptor,retezec);
  if Len > 0 then begin
    Len := Len + Length(Descriptor);
    Bufstr := Copy(retezec,Len,(Length(retezec)-Len)+1);
    Result := Copy(Bufstr,1,Pos(TECKA,Bufstr)-1);
  end else Result := '';
end;

function ExtrahovatZUvozovek(retezec: string): string;
var bufstr: string;
    UvozIndex: Integer;

  function GetLastPos(substr:string; firstpos:integer; source:string): integer;
  var bufsubstr: string;
  begin
    if firstpos > 0 then begin
      bufsubstr := Copy(source,firstpos+1,Length(source)-firstpos);
      Result := firstpos + GetLastPos(substr,Pos(substr,bufsubstr),bufsubstr);
    end else Result := 0;
  end;

begin
  UvozIndex := Pos(UVOZOVKA,retezec);
  if (UvozIndex > 0) and (UvozIndex < Length(retezec)) then begin
    bufstr := Copy(retezec,UvozIndex + 1,Length(retezec) - UvozIndex);
    Result := Copy(bufstr,1,GetLastPos(UVOZOVKA,Pos(UVOZOVKA,bufstr),bufstr) - 1);
  end else Result := '';
end;

function ReadEncodedFromQuotes(str: string): string;
begin
  Result := ExtrahovatZUvozovek(str);
  EncodeSpecialChars(Result);
end;

function EoStream(Stream: TStream): Boolean;
begin
  Result := Stream.Position >= Stream.Size;
end;

function EoFile(StringsFile: TStrings; CurLine: Integer): Boolean;
begin
  Result := StringsFile.Count <= CurLine;
end;

function StreamReadLn(Stream: TStream): string;
var Znak: AnsiChar;
    EndLine: Boolean;
begin
  Result := '';
  EndLine := false;
  if EoStream(Stream) then Exit;
  repeat
    Stream.ReadBuffer (Znak,1);
    if (Ord(Znak) = 13) or (Ord(Znak) = 10) then begin
      EndLine := true;
      if EoStream(Stream) then Exit
                          else Continue;
    end;
    if EndLine then begin
      Stream.Position := Stream.Position - 1;
      Exit;
    end;
    Result := Result + Char(Znak);
  until EoStream(Stream);
end;

function StreamReadInt(Stream: TStream; var Value: Integer): Boolean;
var Znak: AnsiChar;
    WaitForSeparator: Boolean;
begin
  Result := false;
  if EoStream(Stream) then Exit;
  WaitForSeparator := false;
  Value := 0;
  repeat
    Stream.ReadBuffer(Znak,1);
    if (NOT WaitForSeparator) and (Ord(Znak) >= Ord('0')) and (Ord(Znak) <= Ord('9')) then begin
      Value := (10 * Value) + (Ord(Znak) - Ord('0'));
      Result := true;
      if EoStream(Stream) then Exit
                          else Continue;
    end;
    if (Ord(Znak) = 13) or (Ord(Znak) = 10) then begin
      Stream.Position := Stream.Position - 1;
      Exit;
    end;
    if (Znak = ' ') or (Ord(Znak) = 9) then begin
      if Result then Exit
                else WaitForSeparator := false;
    end else begin
      Result := false;
      WaitForSeparator := true;
      Value := 0;
    end;
  until EoStream(Stream);
end;

function FileReadInt(StringsFile: TStrings; var Value: Integer; CurLine: Integer): Boolean;
var NumberString: String;
begin
  NumberString := StringsFile.Names[CurLine];
  if NumberString <> '' then Result := TryStrToInt(NumberString, Value)
                        else Result := false;
end;

{$IF CompilerVersion > 19}
function GetLangFileEncoding(LangFileName: String): TEncoding;
var LangFileStream: TFileStream;
    FileSign: LongWord;
begin
  try
    LangFileStream := TFileStream.Create(LangFileName, fmOpenRead);
    try
      if LangFileStream.Read(FileSign, 4) <> 4 then Result := nil
                                               else case FileSign of
        $005BFEFF: Result := TEncoding.Unicode;
        $5B00FFFE: Result := TEncoding.BigEndianUnicode;
        $5BBFBBEF: Result := TEncoding.UTF8;
        else if (FileSign AND $FF) = $5B then Result := TEncoding.Default
                                         else Result := nil;
      end;
    finally
      LangFileStream.Free;
    end;
  except
    on Exception do Result := nil;
  end;
end;
{$IFEND}

function ReadLangIDs(LFile: TStrings; FileSgn: String; LoadFlagOrder: Boolean): TLangIDs;
var FPos: Integer;
    LineBuf: String;
begin
  if (LFile.Count < 3) OR (Trim(LFile.Strings[0]) <> FileSgn) then begin
    Result.Name := '';
    Result.Code := '';
  end else begin
    FPos := 1;
    while NOT EoFile(LFile, FPos) DO begin
      LineBuf := LFile.ValueFromIndex[FPos];
      Inc(FPos);
      if Pos(LANGUAGE_DESCRIPTOR, LineBuf) > 0 then begin
        Result.Code := GetDescriptor(LineBuf, LANGUAGE_ISO_CODE_DESCRIPTOR);
        LineBuf := ExtrahovatZUvozovek(LineBuf);
        if LineBuf <> '' then begin
          Result.Name := LineBuf;
          Break;
        end;
      end;
    end;
    IsISO1(Result.Code);
    if LoadFlagOrder then begin
      EraseFlag;
      while NOT EoFile(LFile, FPos) do begin
        LineBuf := LFile.ValueFromIndex[FPos];
        Inc(FPos);
        if Length(LineBuf) > 2 then begin
{$IFDEF NEXTGEN}
          if (LineBuf[0] <> UVOZOVKA) AND (LineBuf.IndexOf(FLAG_ICON_DESCRIPTOR) >= 0) then begin
{$ELSE}
          if (LineBuf[1] <> UVOZOVKA) AND (Pos(FLAG_ICON_DESCRIPTOR, LineBuf) > 0) then begin
{$ENDIF}
            LoadFlag(LFile, FPos);
            Break;
          end;
        end;
      end;
    end;
  end;
end;

function GetLangIDs(LangFile, FileSign: string; LoadFlagOrder: Boolean): TLangIDs; overload;
var LFile: TStringList;
begin
  Result.Name := '';
  Result.Code := '';
  if FileExists(LangFile) then begin
    try
      LFile := TStringList.Create;
      try
        LFile.NameValueSeparator := cTAB;
        LFile.LoadFromFile(LangFile);
        Result := ReadLangIDs(LFile, FileSign, LoadFlagOrder);
      finally
        LFile.Free;
      end;
    except
      on Exception do begin
        Result.Name := '';
        Result.Code := '';
      end;
    end;
  end;
end;

function GetLangIDs(LStream: TResourceStream; FileSign: string; LoadFlagOrder: Boolean): TLangIDs; overload;
var LFile: TStringList;
begin
  Result.Name := '';
  Result.Code := '';
  if LStream.Size > 0 then begin
    LStream.Position := 0;
    try
      LFile := TStringList.Create;
      try
        LFile.NameValueSeparator := cTAB;
        LFile.LoadFromStream(LStream);
        Result := ReadLangIDs(LFile, FileSign, LoadFlagOrder);
      finally
        LFile.Free;
      end;
    except
      on Exception do begin
        Result.Name := '';
        Result.Code := '';
      end;
    end;
  end;
end;

function GetEnvLangCode(LineTooLongRes: String): String;
begin
  if LineTooLongRes = 'Line too long' then Result := 'en'
                                      else
    if LineTooLongRes = 'Zeile zu lang' then Result := 'de'
                                        else
      if LineTooLongRes = 'Ligne trop longue' then Result := 'fr'
                                              else
        if LineTooLongRes = '行が長すぎます' then Result := 'ja'
                                             else Result := '';
end;

function IsISO1(var ISOcode: TISOCode): Boolean;
begin
  Result := false;
  if ISOCode = '' then Exit;
  ISOCode := Trim(ISOCode);
  if ISOCode = '' then Exit;
  ISOCode := LowerCase(ISOCode);
  if Length(ISOCode) >= 2 then begin
{$IFDEF NEXTGEN}
    ISOCode := ISOCode.Substring(0, 2);
    if ((ISOCode[0] >= 'a') AND (ISOCode[1] >= 'a') AND (ISOCode[0] <= 'z') AND (ISOCode[1] <= 'z') AND (ISOCode <> UNDEFINED_LANG_CODE)) then begin
{$ELSE}
    ISOCode := Copy(ISOCode,1,2);
    if ((ISOCode[1] >= 'a') AND (ISOCode[2] >= 'a') AND (ISOCode[1] <= 'z') AND (ISOCode[2] <= 'z') AND (ISOCode <> UNDEFINED_LANG_CODE)) then begin
{$ENDIF}
      Result := true;
    end else ISOCode := '';
  end else if Length(ISOCode) < 2 then ISOCode := '';
end;

function FindOwnerClass(ComponentClass, SearchedClass : TClass): boolean;
begin
  if ComponentClass = nil then Result := false
                          else if ComponentClass = SearchedClass
                                 then Result := true
                                 else Result := FindOwnerClass(ComponentClass.ClassParent,SearchedClass);
end;

function CheckPriorityAbsorption(Component: TComponent; InterestClass: TClass; PriorityArray: array of TPriority): boolean;
var PriorityIndex: Word;
begin
  Result := false;
  for PriorityIndex := 0 to (SizeOf(PriorityArray) div SizeOf(TPriority)) - 1
    do if (Component is PriorityArray[PriorityIndex,1]) and
          (InterestClass = PriorityArray[PriorityIndex,0])
          then begin
            Result := true;
            Exit;
          end;
end;

function ContainChars(str: string): boolean;
var I, H: Integer;
begin
{$IFDEF NEXTGEN}
  I := Low(str);
  H := High(str);
{$ELSE}
  I := 1;
  H := Length(str);
{$ENDIF}
  while I <= H do begin
    if str[I] >= 'A' then Break;
    Inc(I);
  end;
  Result := (I <= H);
end;

function ContaintWrappChar(str: String): Boolean;
var I, L: Integer;
begin
  Result := false;
{$IFDEF NEXTGEN}
  I := Low(str);
  L := High(str);
{$ELSE}
  I := 1;
  L := Length(str);
{$ENDIF}
  while I <= L do begin
    if (str[I] = #13) OR (str[I] = #10) then begin
      Result := true;
      Exit;
    end;
    Inc(I);
  end;
end;

Procedure ReplaceChars(var Str: string; ReplaceChar, ReplaceAs: Char);
{$IFNDEF NEXTGEN}
var CharPos: Integer;
{$ENDIF}
begin
{$IFDEF NEXTGEN}
  Str := Str.Replace(ReplaceChar, ReplaceAs);
{$ELSE}
  CharPos := Pos(ReplaceChar, Str);
  while CharPos > 0 do begin
    Str[CharPos] := ReplaceAs;
    CharPos := Pos(ReplaceChar, Str);
  end;
{$ENDIF}
end;

procedure DecodeSpecialChars(var Str: string);
var si, SEnd, PartStart, PartLength, ChVal, Ch: Integer;
    input, decoded: String;
begin
  input := Str;
{$IFDEF NEXTGEN}
  PartStart := 0;
  si := 0;
  SEnd := High(Str);
  while si <= SEnd do begin
    if (input.Chars[si] = #39) AND (si < (SEnd + 1)) then begin
      PartLength := si - PartStart;
      Inc(si);
      if input.Chars[si] = ' ' then Inc(si);  // dovoluje jednu mezeru mezi ' a #
      while (input.Chars[si] = '#') do begin
        if si < SEnd then Inc(si)
                     else Break;
        ChVal := Ord(input.Chars[si]) - Ord('0');
        if (ChVal >= 0) AND (ChVal <= 9) then begin
          Inc(si);
          while si <= SEnd do begin
            Ch := Ord(input.Chars[si]) - Ord('0');
            if (Ch >= 0) AND (Ch <= 9) then begin
              ChVal := (ChVal * 10) + Ch;
              Inc(si);
              if ChVal > $FFFF then Break;
            end else begin
              if input.Chars[si] = ' ' then Inc(si);
              if input.Chars[si] = #39 then Inc(si); // musi byt na samostatnych radcich kvuli posloupnosti obou znaku
              Break;
            end;
          end;
          if ChVal <= $FFFF then begin
            decoded := input.Substring(PartStart, PartLength) + Char(ChVal);
            if PartStart = 0 then Str := decoded
                             else Str := Str + decoded;
            PartStart := si;
            PartLength := 0;
          end else Break;
        end else Break;
      end;
      Continue;
    end;
    Inc(si);
  end;
  if (PartStart > 0) then Str := Str + input.Substring(PartStart);
{$ELSE}
  PartStart := 1;
  si := 1;
  SEnd := Length(Str);
  while si <= SEnd do begin
    if (input[si] = #39) AND (si < (SEnd + 1)) then begin
      PartLength := si - PartStart;
      Inc(si);
      if input[si] = ' ' then Inc(si);  // dovoluje jednu mezeru mezi ' a #
      while (input[si] = '#') do begin
        if si < SEnd then Inc(si)
                     else Break;
        ChVal := Ord(input[si]) - Ord('0');
        if (ChVal >= 0) AND (ChVal <= 9) then begin
          Inc(si);
          while si <= SEnd do begin
            Ch := Ord(input[si]) - Ord('0');
            if (Ch >= 0) AND (Ch <= 9) then begin
              ChVal := (ChVal * 10) + Ch;
              Inc(si);
              if ChVal > $FFFF then Break;
            end else begin
              if input[si] = ' ' then Inc(si);
              if input[si] = #39 then Inc(si); // musi byt na samostatnych radcich kvuli posloupnosti obou znaku
              Break;
            end;
          end;
          if ChVal <= $FFFF then begin
            decoded := Copy(input, PartStart, PartLength) + Char(ChVal);
            if PartStart = 1 then Str := decoded
                             else Str := Str + decoded;
            PartStart := si;
            PartLength := 0;
          end else Break;
        end else Break;
      end;
      Continue;
    end;
    Inc(si);
  end;
  if (PartStart > 1) then Str := Str + Copy(input, PartStart, si - PartStart);
{$ENDIF}
end;

function EncodeSpecialChar(const CharValue: Integer): String;
begin
  Result := #39 + '#' + IntToStr(CharValue) + #39;
end;

function EncodeChars(var Str: string; const iChar: Integer): Boolean;
var si, SEnd, PartStart, SCh: Integer;
    input, encoded: String;
begin
  input := Str;
{$IFDEF NEXTGEN}
  PartStart := 0;
  si := 0;
  SEnd := High(Str);
  while si <= SEnd do begin
    SCh := Ord(input.Chars[si]);
    if SCh = iChar then begin
      encoded := input.Substring(PartStart, si - PartStart) + EncodeSpecialChar(SCh);
      if PartStart = 0 then Str := encoded
                       else Str := Str + encoded;
      Inc(si);
      PartStart := si;
    end else Inc(si);
  end;
  Result := (PartStart > 0);
  if Result then Str := Str + input.Substring(PartStart);
{$ELSE}
  PartStart := 1;
  si := 1;
  SEnd := Length(Str);
  while si <= SEnd do begin
    SCh := Ord(input[si]);
    if SCh = iChar then begin
      encoded := Copy(input, PartStart, si - PartStart) + EncodeSpecialChar(SCh);
      if PartStart = 1 then Str := encoded
                       else Str := Str + encoded;
      Inc(si);
      PartStart := si;
    end else Inc(si);
  end;
  Result := (PartStart > 1);
  if Result then Str := Str + Copy(input, PartStart, si - PartStart);
{$ENDIF}
end;

function EncodeSpecialChars(var Str: string): Boolean;
var si, SEnd, PartStart, SCh: Integer;
    input, encoded: String;
begin
  input := Str;
{$IFDEF NEXTGEN}
  PartStart := 0;
  si := 0;
  SEnd := High(Str);
  while si <= SEnd do begin
    SCh := Ord(input.Chars[si]);
    if SCh < 32 then begin
      encoded := input.Substring(PartStart, si - PartStart);
      if SCh <> 0 then encoded := encoded + EncodeSpecialChar(SCh);
      if PartStart = 0 then Str := encoded
                       else Str := Str + encoded;
      Inc(si);
      PartStart := si;
    end else Inc(si);
  end;
  Result := (PartStart > 0);
  if Result then Str := Str + input.Substring(PartStart);
{$ELSE}
  PartStart := 1;
  si := 1;
  SEnd := Length(Str);
  while si <= SEnd do begin
    SCh := Ord(input[si]);
    if SCh < 32 then begin
      encoded := Copy(input, PartStart, si - PartStart);
      if SCh <> 0 then encoded := encoded + EncodeSpecialChar(SCh);
      if PartStart = 1 then Str := encoded
                       else Str := Str + encoded;
      Inc(si);
      PartStart := si;
    end else Inc(si);
  end;
  Result := (PartStart > 1);
  if Result then Str := Str + Copy(input, PartStart, si - PartStart);
{$ENDIF}
end;

function TepTranslation(input: String; AllowSpecials: Boolean): String;
var si, Len, StrTrim: Integer;
begin
  if input = '' then begin
    Result := '';
    Exit;
  end;
{$IFDEF NEXTGEN}
  // Left Trim
  Len := High(input);
  si := 0;
  StrTrim := -1;
  while (si <= Len) AND (input.Chars[si] <= ' ') do begin
    if (input.Chars[si] < ' ') then StrTrim := si;
    Inc(si);
  end;
  Inc(StrTrim);
  if StrTrim > 0 then begin
    if StrTrim > Len then Result := ''
                     else Result := input.Substring(StrTrim);
  end else Result := input;
  // Right Trim
  si := High(Result);
  StrTrim := -1;
  while (si >= 0) AND (Result.Chars[si] <= ' ') do begin
    if (Result.Chars[si] < ' ') then StrTrim := si;
    Dec(si);
  end;
  if StrTrim >= 0 then Result := Result.Substring(0, StrTrim);
  if NOT AllowSpecials then Result := Result.Replace(#13#10, ' ').Replace(#10, ' ');
{$ELSE}
  // Left Trim
  Len := Length(input);
  si := 1;
  StrTrim := 0;
  while (si <= Len) AND (input[si] <= ' ') do begin
    if (input[si] < ' ') then StrTrim := si;
    Inc(si);
  end;
  if StrTrim > 0 then Result := Copy(input, StrTrim + 1, Len - StrTrim)
                 else Result := input;
  // Right Trim
  si := Length(Result);
  StrTrim := 0;
  while (si > 0) AND (Result[si] <= ' ') do begin
    if (Result[si] < ' ') then StrTrim := si;
    Dec(si);
  end;
  if StrTrim > 0 then Result := Copy(Result, 1, StrTrim - 1);
  if NOT AllowSpecials then begin
    // Replace CRLF
    for si := 1 to Length(Result) do begin
      if Result[si] = #13 then Result[si] := ' ';
      if Result[si] = #10 then Result[si] := ' ';
    end;
  end;
{$ENDIF}
  if AllowSpecials then EncodeSpecialChars(Result);
end;

function ChangeDescValue(TextLine, Descriptor, NewValue: string; EndChar: PChar): string;
var DescPos: Integer;
begin
  DescPos := Pos(Descriptor, TextLine);
  if DescPos > 0 then begin
    Result := Copy(TextLine, 1, DescPos + Length(Descriptor) - 1) +
              NewValue +
              String(StrPos(StrPos(PChar(TextLine),PChar(Descriptor)),EndChar));
  end else Result := TextLine;
end;

function GetLexiconName(Lexicon: TComponent): string;
begin
  if Assigned(Lexicon) AND Assigned(Lexicon.Owner) then begin
    if Lexicon.Name = '' then Result := Lexicon.Owner.Name
                         else Result := Lexicon.Owner.Name + TECKA + Lexicon.Name;
  end else Result := '';
end;

function GetDefaultGroup(GroupsList: TStrings): Integer;
begin
  if DesignTime AND (_EditComponentName <> '') then begin
    Result := GroupsList.IndexOf(_EditComponentName);
    if Result < 0 then Result := 0;
  end else Result := 0;
end;

function GetNameFromArrays(Index: Word; LMAdditionNames: array of String): string;
begin
  if Index >= ADDIT_NAMES_START then begin
    if (Index - ADDIT_NAMES_START) < (SizeOf(LMAdditionNames) div SizeOf(String))
      then Result := LMAdditionNames[Index - ADDIT_NAMES_START]
      else Result := ExtPropertyName[Ord(epnExtent)];
  end else if Index >= EXT_NAMES_START then begin
    if Index > Ord(epnExtent) then Result := ExtPropertyName[Ord(epnExtent)]
                              else Result := ExtPropertyName[Index];
  end else begin
    if Index <= RESERVED_PROPS then Result := PropertyName[Index]
                               else Result := ExtPropertyName[Ord(epnExtent)];
  end;
end;

function PropIndex(Prop: TStringProperties): Word; overload;
begin
  Result := Ord(Prop);
end;

function PropIndex(Prop: TTStringsProperties): Word; overload;
begin
  Result := Ord(Prop) + 32;
end;

function PropIndex(Prop: TStructuredProperties): Word; overload;
begin
  Result := Ord(Prop) + 64;
end;

function PropIndex(Prop: TOtherProperties): Word; overload;
begin
  Result := Ord(Prop) + 96;
end;

function PropIndex(Prop: TExtPropertyName): Word; overload;
begin
  Result := Ord(Prop);
end;

function AsPropertyName(Input: String): string;
begin
  Result := Input;
  ReplaceChars(Result, TECKA, ALTDOT);
  ReplaceChars(Result, CARKA, ' ');
  ReplaceChars(Result, STREDNIK, ' ');
  ReplaceChars(Result, UVOZOVKA, ' ');
end;

function CreateAddr(Nr: Integer): string;
begin
  Result := IntToStr(Nr);
end;

function CreateAddr(const Text: String): string;
var si: Integer;
begin
  Result := '';
  if Text <> '' then begin
{$IFDEF NEXTGEN}
    for si := Low(Text) to High(Text) do
      if (Text.Chars[si] >= 'A') then Result := Result + Text.Chars[si]
                                 else begin
        if (Text.Chars[si] >= '0') AND (Text.Chars[si] <= '9') then begin
          if Result = '' then Result := '_' + Text.Chars[si]
                         else Result := Result + Text.Chars[si];
        end;
      end;
{$ELSE}
    for si := 1 to Length(Text) do
      if (Text[si] >= 'A') then Result := Result + Text[si]
                           else begin
        if (Text[si] >= '0') AND (Text[si] <= '9') then begin
          if Result = '' then Result := '_' + Text[si]
                         else Result := Result + Text[si];
        end;
      end;
{$ENDIF}
  end;
end;

function NestedAddr(const Addr: string; SubAddr: Integer): string;
begin
  Result := Addr + CARKA + IntToStr(SubAddr);
end;

function NestedAddr(const Addr, SubAddr: string): string;
begin
  Result := Addr + CARKA + SubAddr;
end;

function NestedProperty(Addr: string; Prop: TStringProperties): string;
begin
  Result := Addr + TECKA + IntToStr(PropIndex(Prop));
end;

function NestedProperty(Addr: string; Prop: TTStringsProperties): string;
begin
  Result := Addr + TECKA + IntToStr(PropIndex(Prop));
end;

function NestedProperty(Addr: string; Prop: TStructuredProperties): string;
begin
  Result := Addr + TECKA + IntToStr(PropIndex(Prop));
end;

function NestedProperty(Addr: string; Prop: TOtherProperties): string;
begin
  Result := Addr + TECKA + IntToStr(PropIndex(Prop));
end;

function NestedProperty(Addr: string; ExtProp: TExtPropertyName): string;
begin
  Result := Addr + TECKA + IntToStr(PropIndex(ExtProp));
end;

function NestedProperty(Addr: string; Name: String): string;
begin
  Result := Addr + TECKA + Name;
end;

procedure DivertBack;  // Compat.proc
begin
end;

procedure Make(Buf: TMemoryStream; const inp: String);
{$IFNDEF ANDROID}
var ps, Len: Integer;
    data: Byte;
    freeChar: ByteChar;

  procedure GetVal;
  begin
    if (data <> $20) AND (data < $38) then begin
      if data = $26 then data := 0
                    else begin
{$IFDEF NEXTGEN}
        data := (Ord(inp.Chars[ps]) - $28) + (16 * (data - $28));
{$ELSE}
        data := (Ord(inp[ps]) - $28) + (16 * (data - $28));
{$ENDIF}
        Inc(ps);
      end;
    end;
  end;

  procedure NextFree;
  var BufPos, BufSize: Integer;
      PBuf: PAnsiChar;
  begin
    BufPos := Buf.Position;
    BufSize := Buf.Size;
    PBuf := Buf.Memory;
    if (BufPos < BufSize) AND (PBuf[BufPos] <> freeChar) then begin
      repeat
        Inc(BufPos);
      until (BufPos >= BufSize) OR (PBuf[BufPos] = freeChar);
      Buf.Position := BufPos;
    end;
  end;

  procedure Place;
  var ic, rpt, tps, i, BufPos: Integer;
      PBuf: PAnsiChar;
      newfree: Boolean;
      valp: Byte;
  begin
    ic := data - $20;
{$IFDEF NEXTGEN}
    rpt := Ord(inp.Chars[ps]);
{$ELSE}
    rpt := Ord(inp[ps]);
{$ENDIF}
    if rpt > $27 then Dec(rpt, $27)
                 else begin
      Dec(rpt, $21);
      i := 1;
      while rpt > 0 do begin
        i := i * 88;
        Dec(rpt);
      end;
      rpt := 87;
      repeat
        Inc(ps);
{$IFDEF NEXTGEN}
        valp := Ord(inp.Chars[ps]);
{$ELSE}
        valp := Ord(inp[ps]);
{$ENDIF}
        if valp = $26 then valp := 0
                      else Dec(valp, $27);
        rpt := rpt + (i * valp);
        i := i div 88;
      until i = 0;
    end;
{$IFDEF NEXTGEN}
    data := Ord(inp.Chars[ps+1]);
{$ELSE}
    data := Ord(inp[ps+1]);
{$ENDIF}
    Inc(ps, 2);
    GetVal;
    if ic = 1 then begin
      repeat
        Buf.Write(data, 1);
        NextFree;
        Dec(rpt);
      until rpt <= 0;
    end else begin
      if Ord(freeChar) = data then begin
        Inc(freeChar);
        BufPos := Buf.Position;
        tps := Buf.Size - BufPos;
        if tps > 1 then begin
          if tps > 3 then tps := 3;
          PBuf := Buf.Memory;
          repeat
            newfree := true;
            for i := BufPos + 1 to BufPos + tps do begin
              if PBuf[i] = freeChar then begin
                Inc(freeChar);
                newfree := false;
              end;
            end;
          until newfree;
          for i := BufPos + 1 to Buf.Size - 1 do begin
            if Ord(PBuf[i]) = data then PBuf[i] := freeChar;
          end;
        end;
      end;
      tps := Buf.Position;
      Buf.Position := tps + 1;
      NextFree;
      repeat
        for i := 1 to ic - 1 do begin
          if Buf.Position < (Buf.Size - 1) then begin
            Buf.Position := Buf.Position + 1;
            NextFree;
          end else Buf.Write(freeChar, 1);
        end;
        Buf.Write(data, 1);
        NextFree;
        Dec(rpt);
      until rpt <= 0;
      Buf.Position := tps;
    end;
  end;
{$ENDIF}

begin
  Buf.Clear;
{$IFNDEF ANDROID}
 {$IFDEF NEXTGEN}
  freeChar := $D0;
  ps := 0;
  Len := High(inp);
 {$ELSE}
  freeChar := '_';
  ps := 1;
  Len := Length(inp);
 {$ENDIF}
  while ps <= Len do begin
 {$IFDEF NEXTGEN}
    data := Ord(inp.Chars[ps]);
 {$ELSE}
    data := Ord(inp[ps]);
 {$ENDIF}
    Inc(ps);
    if data <> $20 then begin
      if (data < $26) then Place
                      else GetVal;
    end;
    Buf.Write(data, 1);
    NextFree;
  end;
  Buf.Position := 0;
{$ENDIF}
end;

var FlagStream: TMemoryStream;

procedure SaveFlag(LangFile: TStrings);
var ReadCount, Line: Integer;
{$IFDEF NEXTGEN}
    StrBuffer: TArray<Byte>;
    Buffer: TArray<Byte>;
{$ELSE}
    StrBuffer: AnsiString;
    Buffer: array[0..49] of Byte;
{$ENDIF}
begin
  LangFile.Add('0' + cTAB + FLAG_ICON_DESCRIPTOR);
  FlagStream.Position := 0;
  Line := 0;
  repeat
{$IFDEF NEXTGEN}
    try
      SetLength(Buffer, 50);
      ReadCount := FlagStream.Read(Buffer, Length(Buffer));
      SetLength(StrBuffer, 2*ReadCount);
      BinToHex( Buffer, 0, StrBuffer, 0, ReadCount);
    finally
      Buffer := nil;
      StrBuffer := nil;
    end;
{$ELSE}
    ReadCount := FlagStream.Read(Buffer,SizeOf(Buffer));
    SetLength(StrBuffer,2*ReadCount);
    BinToHex(@Buffer, PAnsiChar(StrBuffer), ReadCount);
{$ENDIF}
    {$WARNINGS OFF}
    LangFile.Add(IntToStr(Line) + cTAB + String(StrBuffer));
    {$WARNINGS ON}
    Inc(Line);
  until ReadCount < SizeOf(Buffer);
end;

function Hex2Bin(const HexStr: String; var Binout: array of Byte; maxlen: Integer): Integer;
var I, HexLen, val, hval: Integer;
begin
  Result := 0;
{$IFDEF NEXTGEN}
  I := 0;
  HexLen := Length(HexStr);
  if (2 * maxlen) < HexLen then HexLen := maxlen * 2;
  Dec(HexLen);
{$ELSE}
  I := 1;
  HexLen := Length(HexStr);
  if (2 * maxlen) < HexLen then HexLen := maxlen * 2;
{$ENDIF}
  while (I <= HexLen) do begin
    hval := Ord(HexStr[I]) - Ord('0');
    if hval > 9 then Dec(hval, 7);
    if hval > 15 then Dec(hval, $20);
    if (hval < 0) OR (hval > 15) then Break;
    val := hval shl 4;
    Inc(I);
    hval := Ord(HexStr[I]) - Ord('0');
    if hval > 9 then Dec(hval, 7);
    if hval > 15 then Dec(hval, $20);
    if (hval < 0) OR (hval > 15) then Break;
    Binout[Result] := val OR hval;
    Inc(Result);
    Inc(I);
  end;
end;

{$HINTS OFF}
procedure LoadFlag(LangFile: TStrings; CurLine: Integer); overload;
var ConvertBytes, FPos: Integer;
    Buffer: TBytes;
begin
  FlagStream.Clear;
  try
    FPos := CurLine;
    try
      SetLength(Buffer, 256);
      while NOT EoFile(LangFile, FPos) do begin
        ConvertBytes := Hex2Bin(LangFile.ValueFromIndex[FPos], Buffer, 256);
        if ConvertBytes > 0 then FlagStream.Write(Buffer[0], ConvertBytes);
        Inc(FPos);
      end;
    finally
      Buffer := nil;
    end;
    FlagStream.Position := 0;
  except
    on Exception do FlagStream.Clear;
  end;
end;
{$HINTS ON}
procedure LoadFlag(LStream: TStream);
var ConvertBytes: Integer;
    Buffer: TBytes;
    TabBuf: Byte;
begin
  FlagStream.Clear;
  try
    try
      SetLength(Buffer, 256);
    while NOT EoStream(LStream) do begin
      repeat
        LStream.ReadBuffer(TabBuf, 1);
        if EoStream(LStream) then Abort;
      until TabBuf = 9;
      ConvertBytes := Hex2Bin(StreamReadLn(LStream), Buffer, 256);
      if ConvertBytes > 0 then FlagStream.Write(Buffer[0], ConvertBytes);
    end;
    finally
      Buffer := nil;
    end;
    FlagStream.Position := 0;
  except
    on Exception do FlagStream.Clear;
  end;
end;

procedure EraseFlag;
begin
  FlagStream.Clear;
end;

function LoadedFlag: Boolean;
begin
  Result := FlagStream.Size > 0;
end;

function GetFlag: TMemoryStream;
begin
  FlagStream.Position := 0;
  Result := FlagStream;
end;

function Czech(Lang: TLanguage): boolean;
var LangName: String;
begin
  LangName := LowerCase(Lang);
  Result := (Lang = 'Čeština') or (LangName = 'čeština') or (Lang = 'ČEŠTINA') or
            (Lang = 'Česky') or (LangName = 'česky') or (Lang = 'ČESKY') or
            (Lang = 'Český jazyk') or (LangName = 'český jazyk') or
            (Lang = 'Czech') or (LangName = 'czech') or (Lang = 'CZECH') or
            (Pos('schechisch',LangName) > 0) or (LangName = 'ceco') or
            (LangName = 'checo');
end;

function Slovak(Lang: TLanguage): boolean;
var LangName: String;
begin
  LangName := LowerCase(Lang);
  Result := (Pos('loven',LangName) > 0) or (Pos('lovak',LangName) > 0) or
            (Pos('lowak',LangName) > 0) or (Pos('lovaq',LangName) > 0) or
            (Pos('lovac',LangName) > 0);
end;

function English(Lang: TLanguage): boolean;
var LangName: String;
begin
  LangName := LowerCase(Lang);
  Result := (Pos('nglič',LangName) > 0) or (Pos('NGLIČ',Lang) > 0) or
            (Pos('nglish',LangName) > 0) or (Pos('nglic',LangName) > 0) or
            (Pos('nglisch',LangName) > 0) or (Pos('ritisch',LangName) > 0) or
            (Pos('nglais',LangName) > 0) or (Pos('britan',LangName) > 0) or
            (Pos('nglés',LangName) > 0) or (Pos('NGLÉS',Lang) > 0) or
            (Pos('ngles',LangName) > 0);
end;


{$IFDEF LMSMART}
{$I LMVocabularyImp}
{$ENDIF}

initialization
  FlagStream := TMemoryStream.Create;
  _EditComponentName := '';
finalization
  FlagStream.Free;
end.

