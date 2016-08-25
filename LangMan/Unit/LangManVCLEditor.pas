//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManVCLEditor.pas                                        **
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

unit LangManVCLEditor;

{$DEFINE LMMANAGER}
{$INCLUDE LM_Config.inc}

interface

uses Classes, Contnrs,
{$IFDEF DXE2}
     Winapi.Windows, Winapi.Messages, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, 
	 Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Grids, Vcl.ValEdit, 
	 Vcl.Graphics, Vcl.ImgList, Vcl.ExtDlgs, Vcl.Imaging.jpeg,
{$ELSE}
     Windows, Messages, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, 
	 Buttons, Grids, ValEdit, Graphics, ImgList, ExtDlgs, jpeg,
{$ENDIF}
     SysUtils, LangManCore, LangManSys;

type
  TColSizingArrow = record
    Dpi, Space, LeftStart, LeftArrowStart, LineWidth, ArrowWidth, PanelCenterOffset: Integer;
  end;

  TVCLLangData = class;

  TLanguageManager = class(TForm)
    LangFilesPanel: TPanel;
    CopyPanel: TPanel;
    SaveDialog: TSaveDialog;
    LangListEditor: TValueListEditor;
    BotPanel: TPanel;
    RightBtnPanel: TPanel;
    GroupCombo: TComboBox;
    LGroup: TLabel;
    ILeft: TImage;
    IRight: TImage;
    ObjectCombo: TComboBox;
    LItem: TLabel;
    LObject: TLabel;
    TopPanel: TPanel;
    LRefLangLabel: TLabel;
    LRefTextLabel: TLabel;
    LRefText: TLabel;
    LRefLang: TLabel;
    BtnPanel: TPanel;
    Split: TPanel;
    SplitPanel: TPanel;
    Splitter: TSplitter;
    OpenPictureDialog: TOpenPictureDialog;
    Icons: TImageList;
    ImgPan: TPanel;
    LLanguage: TLabel;
    LangCombo: TComboBox;
    FinishBtn: TBitBtn;
    FlagImage: TImage;
    Image: TImage;
    SourceIcon: TShape;
    ISOTitle: TLabel;
    ISOCombo: TComboBox;
    AddLangButton: TSpeedButton;
    ExportBtn: TSpeedButton;
    ImportBtn: TSpeedButton;
    FindBtn: TBitBtn;
    FindEdit: TEdit;
    ConGlobalIcon: TImage;
    LangEdit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure LangListEditorSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FinishBtnClick(Sender: TObject);
    procedure ILeftMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IRightMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure ObjectComboChange(Sender: TObject);
    procedure LangListEditorDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure LangListEditorStringsChange(Sender: TObject);
    procedure SplitterMoved(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LangListEditorKeyPress(Sender: TObject; var Key: Char);
    procedure FlagImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LangListEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SplitterPaint(Sender: TObject);
    procedure LangListEditorMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LangListEditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LangListEditorGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure ISOComboSelect(Sender: TObject);
    procedure ClearHint(Sender: TObject);
    procedure LangListEditorMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure LangListEditorMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormResize(Sender: TObject);
    procedure LangEditChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FindEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FindBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FindBtnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FindBtnClick(Sender: TObject);
  private
    LData              : TVCLLangData;
    SameLocStr         : TWordList;
    DrawRow            : Integer;
    SelectedRow        : Integer;
    DrawRect           : TRect;
    AllowNoTrans       : Boolean;
    NoEditorDisable    : Boolean;
    EnableEditEvent    : Boolean;
    EditMode           : Boolean;
    LangModify         : Boolean;
    ColSizingArrow     : TColSizingArrow;
    LastNameFromISO    : String;
    NewLangFile        : String;
{$IFDEF LMSMART}
    procedure ItemEditing;
{$ENDIF}
    procedure DrawSig(Sender: TObject);
    procedure PrepareDraw(Row: Integer; Rect: TRect);
    procedure CalcArrow;
    procedure ClickToItemButton(ItemNr: Integer);
//    procedure PaintLegendSymbol(LabelComp: TLabel; Colors: array of TColor);
    procedure MoveImage;
    procedure EditStart;
    procedure TranslateObject;
    procedure LItemAktualize;
    procedure EnableItemButtons;
    procedure DisableItemButtons;
{$IFDEF LMIMEX}
    function GetImportFilter: String;
    procedure ImportCommand(Sender: TObject);
 {$IFDEF LMSMART}
    procedure ExportBegin(LangName: String);
    procedure ExportCommand(Sender: TObject);
 {$ENDIF}
{$ENDIF}
  end;

  TValueListEditorFree = class(TValueListEditor)
  public
    property EditList;
  end;

  TVCLLangData = class (TLangCoreData)
  private
    procedure LangFormSelectLang(AOwner: TObject);
    procedure CreateLanguage(AOwner: TObject);
    procedure ChangeGroup(AOwner: TObject);
  public
    Editor: TLanguageManager;
    constructor Create(OwnedEngine: TLangManCore); override;
    destructor Destroy; override;
    procedure AddEditorRow(PropertyName, Value: String); override;
    function GetEditorRow(Row: Integer): String; override;
    function EditorExecute(EMode: Integer): TLanguage; override;
    function EditorOpened: Boolean; override;
    procedure EditorSelect(Row, Start, Len: Integer; Column: TEditorSearch); override;
    procedure StoreChanges; override;
  end;

procedure LoadFlagPicture(FlagImage: TPicture);
procedure AdaptFlagImage(Flag: TPicture);

implementation

{$R *.dfm}

uses LangManISO, LMVCLAdditions
{$IFDEF DXE2},
     System.Types, System.UITypes
{$ENDIF};

procedure LoadFlagPicture(FlagImage: TPicture);
var FlagStream: TMemoryStream;
begin
  FlagStream := GetFlag;
  try
    FlagImage.Bitmap.SaveToStream(FlagStream);
    FlagStream.Position := 0;
  except
    on Exception do FlagStream.Clear;
  end;
end;

procedure AdaptFlagImage(Flag: TPicture);
var Bitmap: TBitmap;
const AskW = 16; // Pozadovane rozmery ciloveho obrazku
      AskH = 16;

  function DestRect: TRect;
  var Wdth, Hght: Integer;
      Ratio: Double;
  begin
    Wdth := Flag.Width;
    Hght := Flag.Height;
    if ((Wdth > AskW) or (Hght > AskH)) then begin
      if (Wdth > 0) and (Hght > 0) then begin
        Ratio := Wdth / Hght;
        if Wdth > Hght then begin
          Wdth := AskW;
          Hght := Trunc(AskW / Ratio);
          if Hght > AskH then begin
            Hght := AskH;
            Wdth := Trunc(AskH * Ratio);
          end;
        end else begin
          Hght := AskH;
          Wdth := Trunc(AskH * Ratio);
          if Wdth > AskW then begin
            Wdth := AskW;
            Hght := Trunc(AskW / Ratio);
          end;
        end;
      end else begin
        Wdth := AskW;
        Hght := AskH;
      end;
    end;
    with Result do begin
      Left := 0;
      Top := 0;
      Right := Wdth;
      Bottom := Hght;
    end;
    OffsetRect(Result, (AskW - Wdth) div 2, ((AskH - Hght) div 2) + Ord(0 < (AskH - Hght)));
  end;

begin
  Bitmap := TBitmap.Create;
  with Bitmap do begin
{$IF CompilerVersion > 19}
    SetSize(AskW,AskH);
{$ELSE}
    Height := askH;
    Width := AskW;
{$IFEND}
    Transparent := true;
    TransparentColor := clWhite;
    Canvas.Pen.Color := clWhite;
    Canvas.FillRect(Rect(0,0,AskW,AskH));
    Canvas.StretchDraw(DestRect, Flag.Graphic);
  end;
  Flag.Bitmap.Assign(Bitmap);
  Bitmap.Free;
end;

{$IFDEF LMSMART}
{$I LMVocTrans}
{$ENDIF}
{$IFDEF LMIMEX}
{$I LMImportExport}
{$ENDIF}

procedure TLanguageManager.DrawSig(Sender: TObject);
begin
  if (DrawRow > 0) AND (DrawRow < LangListEditor.RowCount) then begin
    LangListEditor.Canvas.Brush.Color := LData.GetItemColor(DrawRow-1, GroupCombo.Text, TepTranslation(LangListEditor.Cells[1,DrawRow], false));
    DrawRow := -1;
    LangListEditor.Canvas.FillRect(DrawRect);
  end;
end;

procedure TLanguageManager.PrepareDraw(Row: Integer; Rect: TRect);
begin
  DrawRect.BottomRight := Point(Rect.Right - SGN_MARGIN,Rect.Bottom - SGN_MARGIN);
  DrawRect.TopLeft := Point(Rect.Right - SGN_MARGIN - SGN_WIDTH,Rect.Top + SGN_MARGIN);
  DrawRow := Row;
end;

procedure TLanguageManager.CalcArrow;
const SpaceWidthFactor = 0.16;
      LineWidthFactor = 0.25;
      GridBorderWidth = 3;
begin
  with ColSizingArrow do begin
    ArrowWidth := Splitter.Width;
    Dpi := PixelsPerInch;
    if Dpi <> 96 then PanelCenterOffset := ((ArrowWidth + 1) div 2) - Round((GridBorderWidth * PixelsPerInch / 96))
                 else PanelCenterOffset := ((ArrowWidth + 1) div 2) - GridBorderWidth;
    Space := Round(SpaceWidthFactor * ArrowWidth);
    ArrowWidth := ArrowWidth - Space;
    LeftArrowStart := ArrowWidth AND 1;
    LeftStart := LeftArrowStart + (ArrowWidth div 2) - 1;
    ArrowWidth := Splitter.Height;
    LineWidth := Round(LineWidthFactor * ArrowWidth);
    ArrowWidth := (ArrowWidth - LineWidth) div 2;
    LeftArrowStart := LeftArrowStart + ArrowWidth + ((LineWidth + 1) div 2);
  end;
end;

procedure TLanguageManager.ClickToItemButton(ItemNr: Integer);
var NewText: String;
    SelOK: Boolean;
begin
  if SelectedRow <> (ItemNr+1) then AllowNoTrans := false;
  if LData.SwitchEditorItem(ItemNr, TepTranslation(LangListEditor.Cells[1, ItemNr+1], true), AllowNoTrans, NewText) then begin
    LangListEditor.Cells[1, ItemNr+1] := NewText;
//    if  then LangListEditor.ItemProps[ItemNr+1].ReadOnly := ;
    LangModify := true;
  end;
  SelectedRow := ItemNr + 1;
  if LangListEditor.Row = SelectedRow then LangListEditorSelectCell(nil, 2, SelectedRow, SelOK)
                                      else LangListEditor.Row := SelectedRow;
  LangListEditorStringsChange(nil);
end;

{
procedure TLanguageManager.PaintLegendSymbol(LabelComp: TLabel; Colors: array of TColor);
var ci, LeftSym: Integer;
begin
  LeftSym := LabelComp.Left - 5;
  for ci := 0 to High(Colors) do begin
    LeftSym := LeftSym - SGN_MARGIN - SGN_WIDTH;
    LegendPaint.Canvas.Brush.Color := Colors[ci];
    with LabelComp do LegendPaint.Canvas.FillRect(Rect(LeftSym, Top + 1, LeftSym + SGN_WIDTH, Top + Font.Size + 1));
  end;
end;
}

procedure TLanguageManager.MoveImage;
const IMG_BOTTOM_BCKGND = 40;
      IMG_UP_START = 300;
      IMG_UP_END = 600;
begin
  if ImgPan.Height < IMG_UP_START then begin
    Image.Top := IMG_BOTTOM_BCKGND + ImgPan.Height - Image.Height;
  end else if ImgPan.Height < IMG_UP_END then begin
    Image.Top := Round(IMG_BOTTOM_BCKGND * (1 - ((ImgPan.Height - IMG_UP_START) / (IMG_UP_END - IMG_UP_START)))) + ImgPan.Height - Image.Height;
  end else begin
    Image.Top := ImgPan.Height - Image.Height;
  end;
end;

procedure TLanguageManager.EditStart;
begin
  // BiDiMode
//*  if RTLLanguage(LData.EditorISO) then
  AddLangButton.Visible := false;
  LangFilesPanel.Enabled := true;
  ISOCombo.Enabled := ISOCombo.Text = '';
  FinishBtn.Visible := true;
  LangListEditor.Enabled := true;
  if LData.CurrentSuperiorLang.Code <> '' then LRefLang.Caption := LData.CurrentSuperiorLang.Name + ' (' + LData.CurrentSuperiorLang.Code + ')'
                                          else LRefLang.Caption := LData.CurrentSuperiorLang.Name;
  GroupCombo.OnChange := LData.ChangeGroup;
  if GroupCombo.Items.Count > 0 then begin
    GroupCombo.ItemIndex := GetDefaultGroup(GroupCombo.Items);
    GroupCombo.OnChange(Self);
  end;
  try
    if LoadedFlag then FlagImage.Picture.Bitmap.LoadFromStream(GetFlag)  // do verze 1.3 zde bylo Graphics misto Bitmap (XE3 problem)
                  else Icons.GetBitmap(0, FlagImage.Picture.Bitmap);
  finally
    FlagImage.Visible := true;
  end;
{$IFDEF LMIMEX}
  ImportBtn.Visible := true;
  ExportBtn.Visible := true;
 {$IFNDEF LMSMART}
  ExportBtn.Enabled := false;
 {$ENDIF}
{$ENDIF}
end;

procedure TLanguageManager.TranslateObject;
var Err: Boolean;
begin
  EnableEditEvent := false;
  AllowNoTrans := false;
  SameLocStr.Clear;
  LRefText.Caption := '';
  SourceIcon.Visible := false;
  LangListEditor.Strings.Clear;
  LangListEditor.EditorMode := LData.EditorMode <> emClient;
  LData.NewEditorPage(ObjectCombo.Text, AdditionPropertiesNames);
  LangListEditor.SetFocus;
  LangListEditorSelectCell(Self, 2, 1, Err);
  EnableEditEvent := true;
end;

procedure TLanguageManager.SplitterMoved(Sender: TObject);
begin
  LangListEditor.DefaultColWidth := SplitPanel.Width + ColSizingArrow.PanelCenterOffset;
end;

procedure TLanguageManager.SplitterPaint(Sender: TObject);
const IconColor = clGrayText;
var x, y, mirror, aw, yw: Integer;
begin
  with ColSizingArrow do begin
    if Dpi <> PixelsPerInch then CalcArrow;
    with Splitter.Canvas do begin
      x := LeftStart;
      mirror := x + Space + 1;
      aw := (2*ArrowWidth) + LineWidth - 1;
      for y := 0 to aw do begin
        Pixels[x, y] := IconColor;
        Pixels[mirror, y] := IconColor;
      end;
      repeat
        Dec(x);
        Inc(mirror);
        for y := ArrowWidth to ArrowWidth + LineWidth - 1 do begin
          Pixels[x, y] := IconColor;
          Pixels[mirror, y] := IconColor;
        end;
      until x <= LeftArrowStart;
      yw := 0;
      repeat
        Dec(x);
        Inc(mirror);
        for y := yw to aw do begin
          Pixels[x, y] := IconColor;
          Pixels[mirror, y] := IconColor;
        end;
        Inc(yw);
        Dec(aw);
      until yw > aw;
    end;
  end;
end;

procedure TLanguageManager.LItemAktualize;
begin
  if (ObjectCombo.Items.Count > 0) and (ObjectCombo.ItemIndex >= 0) then begin
    LItem.Caption := IntToStr(ObjectCombo.ItemIndex + 1) + ' / ' +
                     IntToStr(ObjectCombo.Items.Count);
  end else LItem.Caption := '-/-';
  ObjectCombo.Hint := ObjectCombo.Text;
end;

procedure TLanguageManager.EnableItemButtons;
begin
{$IFDEF DXE3}
  LangListEditor.Options := LangListEditor.Options + [goFixedColClick];
{$ENDIF}
end;

procedure TLanguageManager.DisableItemButtons;
begin
{$IFDEF DXE3}
  LangListEditor.Options := LangListEditor.Options - [goFixedColClick];
{$ENDIF}
end;

procedure TLanguageManager.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := (NOT LangModify) or (MessageDlg(LData.EditorLex[24], mtConfirmation,[mbYES,mbNO], 0) = mrYES);
end;

procedure TLanguageManager.FormCreate(Sender: TObject);
var code_index: Integer;
begin
{$IFDEF DXE3}
  ImgPan.StyleElements := [];
  LLanguage.StyleElements := [];
  ISOTitle.StyleElements := [];
  FindEdit.StyleElements := FindEdit.StyleElements - [seFont];
{$ENDIF}
  CalcArrow;
//  Color := $009A5A12; //$8E4E0A;
  ImgPan.Color := $6B3500;
  DrawRow := -1;
  SameLocStr := TWordList.Create;
  // ISO 639-1
  ISOCombo.Clear;
  for code_index := 0 to ISO_CODES_COUNT - 1 do ISOCombo.Items.Add(ISO_639_1[code_index]);
end;

procedure TLanguageManager.FormDestroy(Sender: TObject);
begin
  SameLocStr.Free;
end;

procedure TLanguageManager.FormResize(Sender: TObject);
begin
  MoveImage;
end;

procedure TLanguageManager.FormShow(Sender: TObject);
begin
  LastNameFromISO := '';
  ISOTitle.Transparent := true;
  LangModify := false;
  EnableEditEvent := false;
  SameLocStr.Clear;
  if Scaled AND (PixelsPerInch <> 96) then begin
    LangListEditor.DefaultRowHeight := Round(PixelsPerInch * LangListEditor.DefaultRowHeight / 96);
  end;
  LangListEditor.Canvas.OnChanging := DrawSig;
  SplitPanel.Width := LangListEditor.DefaultColWidth - ColSizingArrow.PanelCenterOffset;
  if (LangCombo.Items.Count = 1) then begin
    LangCombo.ItemIndex := 0;
    LangCombo.OnChange(Self);
  end;
  // Image Size
  Image.Width := Image.Picture.Graphic.Width;
  Image.Height := Image.Picture.Graphic.Height;
  if ImgPan.Width > Image.Width then begin
    Image.Height := Round(Image.Height * ImgPan.Width / Image.Width);
    Image.Width := ImgPan.Width;
    Image.Left := 0;
  end else begin
    // Image left
    Image.Left := (ImgPan.Width - Image.Width) div 2;
  end;
  MoveImage;  // Image top
end;

procedure TLanguageManager.ILeftMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Eofject, FindUntranslated: Boolean;
begin
  Eofject := false;
  FindUntranslated := ssShift in Shift;
  repeat
    if (ObjectCombo.Enabled) and (ObjectCombo.ItemIndex > 0) then begin
      ObjectCombo.ItemIndex := ObjectCombo.ItemIndex - 1;
      if NOT FindUntranslated then ObjectCombo.OnChange(Self);
    end else if (GroupCombo.ItemIndex > 0) then begin
      GroupCombo.ItemIndex := GroupCombo.ItemIndex - 1;
      GroupCombo.OnChange(Self);
      if ObjectCombo.Enabled then begin
        ObjectCombo.ItemIndex := ObjectCombo.Items.Count - 1;
        if NOT FindUntranslated then ObjectCombo.OnChange(Self);
      end;
    end else Eofject := true;
  until (NOT FindUntranslated) or Eofject or LData.IsUntranslated(GroupCombo.Text, ObjectCombo.Text);
  if FindUntranslated then begin
    if Eofject then MessageDlg(LData.EditorLex[23], mtInformation, [mbOK], 0);
    if ObjectCombo.Enabled then ObjectCombo.OnChange(Self);
  end;
end;

procedure TLanguageManager.IRightMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Eofject, FindUntranslated: Boolean;
begin
  Eofject := false;
  FindUntranslated := ssShift in Shift;
  repeat
    if (ObjectCombo.Items.Count > 0) and (ObjectCombo.Enabled) and
       (ObjectCombo.ItemIndex < (ObjectCombo.Items.Count - 1)) then begin

      ObjectCombo.ItemIndex := ObjectCombo.ItemIndex + 1;
      if NOT FindUntranslated then ObjectCombo.OnChange(Self);
    end else if (GroupCombo.Items.Count > 0) and
                (GroupCombo.ItemIndex < (GroupCombo.Items.Count - 1)) then begin

      GroupCombo.ItemIndex := GroupCombo.ItemIndex + 1;
      GroupCombo.OnChange(Self);
    end else Eofject := true;
  until (NOT FindUntranslated) or Eofject or LData.IsUntranslated(GroupCombo.Text, ObjectCombo.Text);
  if FindUntranslated then begin
    if Eofject then MessageDlg(LData.EditorLex[23], mtInformation, [mbOK], 0);
    if (ObjectCombo.Items.Count > 0) and (ObjectCombo.Enabled) and
       (LData.EditorMode in [emClient, emResources]) then ObjectCombo.OnChange(Self);
  end;
end;

procedure TLanguageManager.ISOComboSelect(Sender: TObject);
var NewLanguageName: String;
begin
  NewLanguageName := ISOCombo.Text;
  if (EditMode = false) AND ((LangEdit.Text = '') OR (LangEdit.Text = LastNameFromISO)) AND
     ISOCombo.Enabled AND (NewLanguageName <> '') then begin
    LastNameFromISO := SeparateLangName(NewLanguageName);
    LangEdit.Text := LastNameFromISO;
    LangEditChange(nil);
  end;
end;

procedure TLanguageManager.ClearHint(Sender: TObject);
begin
  LangListEditor.ShowHint := false;
  LangListEditor.Hint := '';
end;

procedure TLanguageManager.LangEditChange(Sender: TObject);
begin
  AddLangButton.Visible := LangEdit.Visible AND (Length(LangEdit.Text) > 2);
end;

procedure TLanguageManager.LangListEditorDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (ARow > 0) and (ARow < LangListEditor.RowCount) and (ACol = 0) then begin
    PrepareDraw(ARow,Rect);
  end else DrawRow := -1;
end;

procedure TLanguageManager.LangListEditorGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: string);
begin
  if (LData.EditorMode = emClient) AND (NoEditorDisable = false) AND (NOT LData.ChangeableEditorItem(ARow-1)) then begin
    TValueListEditorFree(LangListEditor).EditList.EditText := Value; // Untranslated;
    LangListEditor.EditorMode := false;
  end;
  NoEditorDisable := false;
end;

procedure TLanguageManager.FindBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Searched: String;
    mode: TEditorSearchMode;
begin
  if Button = mbLeft then begin
    Searched := FindEdit.Text;
    if Searched = '' then FindEdit.SetFocus
                     else begin
      mode := [seItem];
      if ssCtrl in Shift then mode := mode + [seSource];
      if ssShift in Shift then mode := mode + [seOriginal];
      if NOT LData.SearchWord(Searched, SelectedRow - 1, mode) then Beep;
    end;
  end;
end;

procedure TLanguageManager.FindBtnClick(Sender: TObject);
begin
  if FindEdit.Focused then FindBtnMouseUp(nil, mbLeft, [], 0, 0);
end;

procedure TLanguageManager.FindBtnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) OR (Key = VK_F3) then FindBtnMouseUp(nil, mbLeft, Shift, 0, 0);
end;

procedure TLanguageManager.FindEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) OR (Key = VK_F3) then FindBtnMouseUp(nil, mbLeft, Shift, 0, 0);
end;

procedure TLanguageManager.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = VK_RETURN) AND FindEdit.Focused) OR (Key = VK_F3) then FindBtnMouseUp(nil, mbLeft, Shift, 0, 0);
  if ((Key = Ord('F')) OR (Key = Ord('f'))) AND (ssCtrl in Shift) then begin
    FindEdit.SetFocus;
    FindEdit.SelectAll;
  end;
end;

procedure TLanguageManager.LangListEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 // if (Key = VK_RIGHT) AND (Shift = []) then SendMessage(TValueListEditorFree(LangListEditor).EditList.Handle, EM_SETSEL, -1, -1);
  if (Key = VK_LEFT) AND (Shift = [ssCtrl]) then ClickToItemButton(LangListEditor.Row - 1);
  if LangListEditor.EditorMode AND ((Key = VK_DELETE) OR (Key = VK_BACK)) then LangModify := true;
  if (Key = VK_DOWN) AND ((SelectedRow = (LangListEditor.RowCount - 1)) OR (LangListEditor.RowCount <= 1)) then begin
    IRightMouseDown(Self, mbLeft, Shift, 0, 0);
    Key := 0;
  end;
  if (Key = VK_UP) AND (SelectedRow <= 1) then begin
    if (Shift = []) AND ((GroupCombo.ItemIndex > 0) OR (ObjectCombo.Enabled AND (ObjectCombo.ItemIndex > 0))) then begin
      ILeftMouseDown(Self, mbLeft, Shift, 0, 0);
      if LangListEditor.RowCount > 2 then LangListEditor.Row := LangListEditor.RowCount - 1;
      Key := 0;
    end;
  end;
  if (Key = VK_F3) then FindBtnMouseUp(nil, mbLeft, Shift, 0, 0);
  if ((Key = Ord('F')) OR (Key = Ord('f'))) AND (ssCtrl in Shift) then begin
    FindEdit.SetFocus;
    FindEdit.SelectAll;
  end;
end;

procedure TLanguageManager.LangListEditorKeyPress(Sender: TObject; var Key: Char);
begin
  if LangListEditor.EditorMode then LangModify := true;
end;

procedure TLanguageManager.LangListEditorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var MaxRow, iRow, iCol: Integer;
begin
  MaxRow := LangListEditor.RowCount - 1;
  if (MaxRow > 0) AND (X < LangListEditor.DefaultColWidth) AND (Y > LangListEditor.RowHeights[0]) then begin
    LangListEditor.MouseToCell(X, Y, iCol, iRow);
    if (iRow > 0) AND (iRow <= MaxRow) AND (iCol = 0) then begin
      if Button = mbLeft then ClickToItemButton(iRow - 1);
    end;
  end;
end;

procedure TLanguageManager.LangListEditorMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Shift <> [] then ClearHint(Sender)
                 else begin
    LangListEditor.ShowHint := false;
    if (X < LangListEditor.DefaultColWidth) then begin
      LangListEditor.Hint := LData.GetColorHint(LangListEditor.Canvas.Pixels[X, Y]);
      LangListEditor.ShowHint := LangListEditor.Hint <> '';
    end;
  end;
end;

procedure TLanguageManager.LangListEditorMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ClearHint(Sender);
end;

procedure TLanguageManager.LangListEditorMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  ClearHint(Sender);
end;

procedure TLanguageManager.LangListEditorSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var SourceIconColor: Longword;
    RowIndex: Integer;
begin
  ClearHint(Sender);
  if ARow <> SelectedRow then AllowNoTrans := false;
  if (LData.SelectedClient = LData.PageFromClient) and
     (ARow > 0) and
     (ARow < (LData.GetEditorRowsCount + 1)) then begin
    RowIndex := ARow - 1;
    if LData.EditorMode = emClient then begin
      // editor
      if LData.ChangeableEditorItem(RowIndex) then begin
        NoEditorDisable := true;
        LangListEditor.EditorMode := true;
        TValueListEditorFree(LangListEditor).EditList.SelectAll;
      end else LangListEditor.EditorMode := false;
    end;
    // Source Icon+Text
{$IFDEF LMSMART}
    LRefText.Caption := LData.SelectEditorItem(RowIndex, SameLocStr, SourceIconColor);
{$ELSE}
    LRefText.Caption := LData.SelectEditorItem(RowIndex, nil, SourceIconColor);
{$ENDIF}
    SourceIcon.Brush.Color := SourceIconColor;
    SourceIcon.Visible := true;
    SelectedRow := ARow;
  end else SelectedRow := 0;
end;

procedure TLanguageManager.LangListEditorStringsChange(Sender: TObject);
begin
  ClearHint(Sender);
  if Visible AND EnableEditEvent AND (SelectedRow > 0) then begin
    EnableEditEvent := false;
    try
      PrepareDraw(SelectedRow, LangListEditor.CellRect(0,SelectedRow));
      DrawSig(Sender);
{$IFDEF LMSMART}
      ItemEditing;
{$ENDIF}
    finally
      EnableEditEvent := true;
    end;
  end;
end;

procedure TLanguageManager.ObjectComboChange(Sender: TObject);
begin
  LItemAktualize;
  if ObjectCombo.Items.Count > 0 then begin
    LData.StoreEditorPage;
    TranslateObject;
  end;
end;

procedure TLanguageManager.FinishBtnClick(Sender: TObject);
begin
  LangModify := false;
  ModalResult := mrOK;
end;

procedure TLanguageManager.FlagImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ssLeft in Shift then begin
    if OpenPictureDialog.Execute then begin
      FlagImage.Picture.LoadFromFile(OpenPictureDialog.FileName);
      AdaptFlagImage(FlagImage.Picture);
      LoadFlagPicture(FlagImage.Picture);
      LangModify := true;
    end;
  end else begin
    if MessageDlg(LData.EditorLex[27], mtConfirmation, [mbYES,mbNO], 0) = mrYES then begin
    {$IF CompilerVersion > 19}
      FlagImage.Picture.Bitmap.SetSize(0,0);
    {$ELSE}
      FlagImage.Picture.Bitmap.Height := 0;
      FlagImage.Picture.Bitmap.Width := 0;
    {$IFEND}
      Repaint;
      Icons.GetBitmap(0, FlagImage.Picture.Bitmap);
      EraseFlag;
      LangModify := true;
      FlagImage.Invalidate;
    end;
  end;
end;

//+****************************************************************************
//+*  TVCLLangData class methods                                             **
//+****************************************************************************

constructor TVCLLangData.Create(OwnedEngine: TLangManCore);
begin
  Editor := nil;
  inherited Create(OwnedEngine);
end;

destructor TVCLLangData.Destroy;
begin
  inherited Destroy;
  if Assigned(Editor) then FreeAndNil(Editor);
end;

procedure TVCLLangData.AddEditorRow(PropertyName, Value: String);
begin
  Editor.LangListEditor.InsertRow(PropertyName, Value, true);
end;

function TVCLLangData.GetEditorRow(Row: Integer): String;
begin
  Result := TepTranslation(Editor.LangListEditor.Cells[1, Row+1], true);
end;

function TVCLLangData.EditorExecute(EMode: Integer): TLanguage;
var FilterItem, Cop: String;

  function LangFileName: String;
  begin
    if EMode = 0 then Result := LangsDir + Editor.NewLangFile
                 else Result := FileNames.Strings[Editor.LangCombo.ItemIndex + 1]
  end;

begin
  Cop := PrepareForEditor;
  if NOT Assigned(Editor) then Editor := TLanguageManager.Create(nil);
  Editor.LData := Self;
  with Editor do begin
      // Init Editor
      EditMode := EMode = 1;
      CopyPanel.Caption := Cop;
      ISOCombo.Visible := false;
      ISOTitle.Visible := false;
      if EMode = 0 then begin
        LangCombo.Items.Assign(Languages);
        ISOCombo.ItemIndex := -1;
        ISOCombo.Text := '';
        ISOCombo.Enabled := true;
      end else begin
        LangCombo.Items.Assign(EditableLangs);
      end;
      LangCombo.ItemIndex := -1;
      LangCombo.Enabled := true;
      LangEdit.Enabled := true;
      LangEdit.Visible := false;
      LangEdit.Text := '';
      Caption := LangFormLexicon.Item[0];
      LLanguage.Caption := LangFormLexicon.Item[3+EMode] + ':';
      AddLangButton.Visible := false;
      FinishBtn.Visible := false;
      LRefLangLabel.Caption := LangFormLexicon.Item[5] + ' :';
      LRefLang.Left := LRefLangLabel.Width + LRefLangLabel.Left + 6;
      LRefTextLabel.Caption := LangFormLexicon.Item[6] + ' :';
      SourceIcon.Height := LRefText.Height - 2;
      SourceIcon.Width := SGN_WIDTH + 2 * SourceIcon.Pen.Width;
      SourceIcon.Left := LRefTextLabel.Width + LRefTextLabel.Left + 6;
      SourceIcon.Top := LRefText.Top + 2;
      SourceIcon.Visible := false;
      LRefText.Left := SourceIcon.Left + SourceIcon.Width + SGN_MARGIN;
      LRefText.Width := TopPanel.Width - LRefText.Left - 7;
      LRefLang.Caption := '';
      LRefText.Caption := '';
      LangFilesPanel.Enabled := false;
      LangListEditor.Enabled := false;
      LangListEditor.TitleCaptions.Strings[0] := LangFormLexicon.Item[7];
      LangListEditor.TitleCaptions.Strings[1] := LangFormLexicon.Item[8];
      LangListEditor.ShowHint := false;
      LangListEditor.Hint := LangFormLexicon.Item[30] + '|';
 //     Untranslated := LangFormLexicon.Item[9];
 //     DontTransBtn.Caption := LangFormLexicon.Item[9];
 //     DontTransBtn.Enabled := false;
      LGroup.Caption := LangFormLexicon.Item[10] + ':';
      LObject.Caption := LangFormLexicon.Item[11] + ':';
      AddLangButton.Hint := LangFormLexicon.Item[12];
 //     DontTransBtn.Hint := LangFormLexicon.Item[13];
      GroupCombo.Hint := LangFormLexicon.Item[14];
      ILeft.Hint := LangFormLexicon.Item[15];
      IRight.Hint := LangFormLexicon.Item[16];
      FilterItem := LangFormLexicon.Item[20];
      ReplaceChars(FilterItem, '|', ';');
      SaveDialog.Filter := FilterItem + ' (*' +
                           LowerCase(Engine.LangFileExtension) + ')|*' +
                           LowerCase(Engine.LangFileExtension);
      SaveDialog.Title := LangFormLexicon.Item[21];
      FlagImage.Hint := LangFormLexicon.Item[25];
      OpenPictureDialog.Title := LangFormLexicon.Item[26];
      FinishBtn.Caption := LangFormLexicon.Item[28];
      ImportBtn.Visible := false;
      ExportBtn.Visible := false;
      ImportBtn.Hint := LangFormLexicon.Item[45];
      ExportBtn.Hint := LangFormLexicon.Item[40];
  {$IFDEF LMIMEX}
      ImportBtn.OnClick := ImportCommand;
   {$IFDEF LMSMART}
      ExportBtn.OnClick := ExportCommand;
   {$ENDIF}
  {$ENDIF}
      ConGlobalIcon.Visible := false;
      LItem.Caption := '-/-';
      FlagImage.Visible := false;
      LangCombo.OnChange := LangFormSelectLang;
{$IFDEF LMPRO}
    if Engine.HideCopyright AND (NOT DesignTime) then CopyPanel.Height := 0;
{$ENDIF}
{$IFDEF DXE3}
      if Application.IsMetropolisUI then begin
        //*
      end;
{$ENDIF}

      // Show editor
      if ShowModal = mrOK then begin
        StoreChanges;
{$IFDEF LMSMART}
        StoreNewGlobals;
{$ENDIF}
        EditorISO := ISOCombo.Text;
        Result := EditorLang;
        try
          EditorAction(eaSaveLang, LangFileName);
        except
          on Exception do MessageDlg(EditorLex[22], mtError, [mbOK], 0);
        end;
      end else Result := '';
      // Frees editor
      LData.ClearWorkData;
      FreeAndNil(Editor);
  end;
end;

procedure TVCLLangData.LangFormSelectLang(AOwner: TObject);
begin
  with Editor do begin
    ISOTitle.Visible := true;
    ISOCombo.Visible := true;
    if EditMode then begin
      if EditorAction(eaLoadLangForEdit, LangCombo.Text) then begin
        ISOCombo.Text := Engine.CurrentLanguageISO;
        LangCombo.OnChange := nil;
        LangCombo.Enabled := false;
        EditorLang := LangCombo.Text;
        EditorISO := ISOCombo.Text;
        if LoadGroups(GroupCombo.Items) then begin
{$IFDEF LMSMART}
          // Nacteni pracovnich polozek globalniho lexikonu zvoleneho jazyka
          //  (pouze Descent=0, prototze SmartLexicon by v tuto chvili nemel obsahovat polozky s Descent > 0)
          WorkGlobalLexicon.AssignGlobals(SmartLexicon);
{$ENDIF}
          EditStart;
        end;
      end else begin
        MessageDlg(EditorLex[17],mtError,[mbOK],0);
        LangCombo.ItemIndex := -1;
        Close;
      end;
    end else begin
      if EditorAction(eaLoadLangForCreate, LangCombo.Text) then begin
        LLanguage.Caption := EditorLex[18] + ':';
        NewLanguage;
        CompleteSourceData;
        LangCombo.Visible := false;
        LangEdit.Visible := true;
        LangEdit.SetFocus;
        AddLangButton.OnClick := CreateLanguage;
      end else begin
        MessageDlg(EditorLex[17], mtError, [mbOK],0);
        LangCombo.ItemIndex := -1;
      end;
    end;
  end;
end;

procedure TVCLLangData.CreateLanguage(AOwner: TObject);
begin
  with Editor do begin
    if LangEdit.Text <> '' then begin
      if Languages.IndexOf(LangEdit.Text) < 0 then begin
        SaveDialog.InitialDir := LangsDir;
        if SaveDialog.Execute then begin
          NewLangFile := ChangeFileExt(ExtractFileName(SaveDialog.FileName), LangManSys.LowerCase(Engine.LangFileExtension));
          if (NewLangFile = '') then Exit;
          LLanguage.Caption := EditorLex[4] + ':';
          LangEdit.Enabled := false;
          EditorLang := LangEdit.Text;
          EditorISO := ISOCombo.Text;
          if LoadGroups(GroupCombo.Items) then begin
            EditorAction(eaCreateLang);  // ClientGroups must be loaded (in LoadGroups)
            EditStart;
          end;
          LangModify := true;
        end else Close;
      end else MessageDlg(LangEdit.Text + ' ' + EditorLex[19],mtWarning,[mbOK],0);
    end;
  end;
end;

function TVCLLangData.EditorOpened: Boolean;
begin
  if Assigned(Editor) then Result := Editor.Visible
                      else Result := false;
end;

procedure TVCLLangData.EditorSelect(Row, Start, Len: Integer; Column: TEditorSearch);
begin
  with Editor do begin
    LangListEditor.SetFocus;
    LangListEditor.Row := Row + 1;
    if LangListEditor.EditorMode AND (seItem = Column) then begin
      TValueListEditorFree(LangListEditor).EditList.SelStart := Start;
      TValueListEditorFree(LangListEditor).EditList.SelLength := Len;
    end;
  end;
end;

procedure TVCLLangData.StoreChanges;
begin
  Editor.EnableEditEvent := false;
  inherited;
end;

procedure TVCLLangData.ChangeGroup(AOwner: TObject);
var EMode: TEditorModes;
begin
  with Editor do begin
    EMode := ChangeEditorClient(GroupCombo.ItemIndex);
    if EMode in [emClient, emResources] then begin
      LoadObjects(ObjectCombo.Items);
      if ObjectCombo.Items.Count > 0 then ObjectCombo.ItemIndex := 0;
      LItemAktualize;
      LObject.Enabled := true;
      LItem.Enabled := true;
      ObjectCombo.Enabled := true;
//      DontTransBtn.Enabled := true;
      if (EMode = emClient) OR AllowedGlobals then EnableItemButtons
                                              else DisableItemButtons;
    end else begin
      ObjectCombo.ItemIndex := -1;
      LItem.Caption := '-/-';
      LObject.Enabled := false;
      LItem.Enabled := false;
      ObjectCombo.Enabled := false;
//      DontTransBtn.Enabled := false;
      if AllowedGlobals then EnableItemButtons
                        else DisableItemButtons;
    end;
    ConGlobalIcon.Visible := AllowedGlobals;
    TranslateObject;
  end;
end;

end.

