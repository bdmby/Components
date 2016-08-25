//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManDlg.pas                                              **
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

unit LangManDlg;

{$INCLUDE LM_Config.inc}

interface

{$IFDEF WIN32}

uses Classes,
{$IFDEF DXE2}
     Winapi.Windows, Vcl.Graphics, Vcl.Forms, Vcl.Controls, Vcl.Buttons, 
	 Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus, 
	 Vcl.Grids, Vcl.ValEdit, Vcl.ActnPopup,
{$ELSE}
     Windows, Graphics, Forms, Controls, Buttons, Dialogs, StdCtrls, 
	 ExtCtrls, ComCtrls, Menus, Grids, ValEdit, ActnPopup,
{$ENDIF}
     DesignEditors, DesignIntf;

type
  TStringsEditor = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    OKButton: TButton;
    CancelButton: TButton;
    ExportBtn: TButton;
    ImportBtn: TButton;
    ValueListEditor: TValueListEditor;
    Panel3: TPanel;
    LItemsCountLabel: TLabel;
    LItemsCount: TLabel;
    FindEdit: TEdit;
    FindBtn: TBitBtn;
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ValueListEditorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ValueListEditorStringsChange(Sender: TObject);
    procedure ValueListEditorKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FindEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FindBtnClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FindEditChange(Sender: TObject);
    procedure ValueListEditorMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    Items: TStringList;
    DelRow: Integer;
    ClearNot: boolean;
    SearchChanged: Boolean;
    LexiconMode: boolean;
    procedure UpdateStatus;
    procedure Select(Row, Start, Len: Integer);
    procedure EditorUpdate;
  protected
    function GetLines: TStrings; virtual;
    procedure SetLines(const Value: TStrings); virtual;
    procedure RefreshEditor(SelItem: Boolean; Nr: Integer); virtual;
  public
    procedure ManageLexicon;
    property Lines: TStrings read GetLines write SetLines;
  end;

  TStringsProperty = class(TClassProperty)
  protected
    function EditDialog: TStringsEditor; virtual;
    function GetStrings: TStrings; virtual;
    procedure SetStrings(const Value: TStrings); virtual;
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TLexiconStringsProperty = class(TStringsProperty)
    function EditDialog: TStringsEditor; override;
  end;

  TNamedRowsProperty = class(TLexiconStringsProperty)
    function EditDialog: TStringsEditor; override;
  end;

  TValueListEditorFree = class(TValueListEditor)
  public
    property EditList;
  end;

{$IF CompilerVersion > 16}
var NotifierID, pgID: Integer;
    Lib: TBitmap;

procedure LangManIntegration(const Lic, LMi, Ltt: String; LMnreg: Boolean; const Cop, iLic: String);
{$IFEND}

{$ENDIF}

implementation

{$IFDEF WIN32}

{$R *.dfm}

uses SysUtils, 
{$IFDEF DXE2}
	 Winapi.Messages,
{$ELSE}     
	 Messages, 
{$ENDIF}	 
	 DesignConst, LangManSys, ToolsAPI, TypInfo;

const TO_ITEM = true;
      TO_ROW = false;

var StoredWidth, StoredHeight, StoredLeft, StoredTop, StoredRow: Integer;


function TStringsProperty.EditDialog: TStringsEditor;
begin
  Result := TStringsEditor.Create(Application);
end;

function TStringsProperty.GetStrings: TStrings;
begin
  Result := TStrings(GetOrdValue);
end;

procedure TStringsProperty.SetStrings(const Value: TStrings);
begin
  SetOrdValue(Longint(Value));
end;

function TStringsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

procedure TStringsProperty.Edit;
begin
  with EditDialog do try
    Lines := GetStrings;
    if ShowModal = mrOK then SetStrings(Lines);
  finally
    Free;
  end;
end;

function TLexiconStringsProperty.EditDialog: TStringsEditor;
begin
  Result := inherited EditDialog;
  Result.ManageLexicon;
end;

function TNamedRowsProperty.EditDialog: TStringsEditor;
begin
  Result := inherited EditDialog;
  Result.Caption := 'Rows Editor';
end;

procedure TStringsEditor.FileOpen(Sender: TObject);
begin
  if OpenDialog.Execute then begin
    StoredRow := 1;
    Lines.LoadFromFile(OpenDialog.FileName);
    EditorUpdate;
  end;
end;

procedure TStringsEditor.FileSave(Sender: TObject);
begin
  SaveDialog.FileName := OpenDialog.FileName;
  if SaveDialog.Execute then Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TStringsEditor.FindBtnClick(Sender: TObject);
var lc, nc, lcbuf: String;
    I, found, SearchStop, SearchReset: Integer;
begin
  nc := FindEdit.Text;
  if Length(nc) = 0 then begin
    FindEdit.SetFocus;
  end else begin
    found := 0;
    SearchReset := Items.Count;
    if SearchReset > 0 then begin
      lc := LowerCase(nc);
      I := ValueListEditor.Row;
      if SearchChanged then begin
        Dec(I);
        SearchChanged := false;
      end;
      if I >= SearchReset then I := 0;
      SearchStop := I;
      repeat
        lcbuf := Items.Strings[I];
        found := Pos(nc, lcbuf);
        if found > 0 then begin
          Select(I, found, Length(nc));
          Break;
        end;
        found := Pos(lc, LowerCase(lcbuf));
        if found > 0 then begin
          Select(I, found, Length(nc));
          Break;
        end;
        Inc(I);
        if I >= SearchReset then I := 0;
      until I = SearchStop;
    end;
    if found = 0 then Beep;
  end;
end;

procedure TStringsEditor.FindEditChange(Sender: TObject);
begin
  SearchChanged := true;
end;

procedure TStringsEditor.FindEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) OR (Key = VK_F3) then FindBtnClick(nil);
end;

procedure TStringsEditor.ValueListEditorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var SelectedItem: Integer;
begin
  with ValueListEditor do case Key of
    VK_RETURN: if LexiconMode then begin
                 if Cells[0,Row] <> '' then SelectedItem := StrToInt(Cells[0,Row])
                                       else SelectedItem := 0;
                 if (SelectedItem + 1) = Items.Count then Items.Add('');
                 RefreshEditor(TO_ITEM,SelectedItem + 1);
               end else begin
                 if Row = (RowCount-1) then begin
                   Items.Add('');
                   RefreshEditor(TO_ROW,Row+1);
                 end else Row := Row + 1;
               end;
    VK_DELETE,
    VK_BACK  : if (Cells[1,Row] = '') then DelRow := Row
                                      else DelRow := 0;
    VK_INSERT: if LexiconMode then begin
                 if Cells[0,Row] <> '' then SelectedItem := StrToInt(Cells[0,Row])
                                       else SelectedItem := 0;
                 if SelectedItem > 0 then RefreshEditor(TO_ITEM,SelectedItem - 1);
               end else begin
                 Items.Insert(Row-1,'');
                 RefreshEditor(TO_ROW,Row);
               end;
    VK_RIGHT: SendMessage(TValueListEditorFree(ValueListEditor).EditList.Handle, EM_SETSEL, -1, -1);
    VK_F3: FindBtnClick(nil);
    70: if (ssCtrl in Shift) then begin
      FindEdit.SetFocus;
      FindEdit.SelectAll;
    end;
    102: if (ssCtrl in Shift) then begin
      FindEdit.SetFocus;
      FindEdit.SelectAll;
    end;
  end;
end;

procedure TStringsEditor.ValueListEditorKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with ValueListEditor do case Key of
    VK_DELETE,
    VK_BACK  : if DelRow > 0 then begin
                 if NOT LexiconMode then Items.Delete(DelRow-1);
                 if (Row > 1) and (Key = VK_BACK) and (Row < (RowCount-1))
                   then RefreshEditor(TO_ROW,Row - 1)
                   else RefreshEditor(TO_ROW,Row);
               end;
  end;
end;

procedure TStringsEditor.ValueListEditorMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then SearchChanged := true;
end;

procedure TStringsEditor.ValueListEditorStringsChange(Sender: TObject);
begin
  with ValueListEditor do begin
    if (Row > 0) and (Row <= Items.Count) and
       ((Cells[1,Row] <> '') or (NOT ClearNot)) then begin
      if LexiconMode then if Cells[0,Row] = '' then Items.Strings[0] := Cells[1,Row]
                                               else Items.Strings[StrToInt(Cells[0,Row])] := Cells[1,Row]
                     else Items.Strings[Row-1] := Cells[1,Row];
      UpdateStatus;
    end;
  end;
end;

procedure TStringsEditor.UpdateStatus;
var II, ICount: Integer;
begin
  if (Items.Count = 1) and (Items.Strings[0] = '') then LItemsCount.Caption := '0'
                                                   else if LexiconMode then begin
    ICount := 0;
    for II := 0 to Items.Count - 1 do if Items.Strings[II] <> '' then Inc(ICount);
    LItemsCount.Caption := IntToStr(ICount);
  end else LItemsCount.Caption := IntToStr(Items.Count);
end;

procedure TStringsEditor.Select(Row, Start, Len: Integer);
begin
  ValueListEditor.SetFocus;
  ValueListEditor.Row := Row + 1;
  TValueListEditorFree(ValueListEditor).EditList.SelStart := Start - 1;
  TValueListEditorFree(ValueListEditor).EditList.SelLength := Len;
end;

procedure TStringsEditor.EditorUpdate;
begin
  if Items.Count = 0 then Items.Add('');
  if (StoredRow > 0) and ((StoredRow-1) < Items.Count) and
     ((NOT LexiconMode) or (Items.Strings[StoredRow-1] <> ''))
    then RefreshEditor(TO_ROW,StoredRow)
    else RefreshEditor(TO_ROW,1);
end;

function TStringsEditor.GetLines: TStrings;
var li: Integer;
    encoded: String;
begin
  if (Items.Count = 1) and (Items.Strings[0] = '') then Items.Clear;
  if LexiconMode then for li := 0 to Items.Count - 1 do begin
    encoded := Items.Strings[li];
    if EncodeSpecialChars(encoded) then Items.Strings[li] := encoded;
  end;
  Result := Items;
end;

procedure TStringsEditor.SetLines(const Value: TStrings);
begin
  Items.Assign(Value);
  EditorUpdate;
end;

procedure TStringsEditor.RefreshEditor(SelItem: Boolean; Nr: Integer);
var II,RowInd,ItemRow: Integer;
begin
  ClearNot := true;
  ValueListEditor.Strings.Clear;
  ClearNot := false;
  RowInd := 0;
  ItemRow := 0;
  if Items.Count > 0 then begin
    for II := 0 to Items.Count - 1 do begin
      if (NOT LexiconMode) or (Items.Strings[II] <> '') or (SelItem and (II = Nr)) then begin
        Inc(RowInd);
        ValueListEditor.InsertRow(IntToStr(II),Items.Strings[II],true);
        if (SelItem and (II = Nr)) then ItemRow := RowInd;
      end;
    end;
  end else Items.Add('');
  if LexiconMode and (ValueListEditor.Cells[0,1] = '') then ValueListEditor.InsertRow('0','',true);
  if ItemRow > 0 then ValueListEditor.Row := ItemRow
                 else if Nr < ValueListEditor.RowCount
                        then ValueListEditor.Row := Nr
                        else ValueListEditor.Row := ValueListEditor.RowCount - 1;
  UpdateStatus;
end;

procedure TStringsEditor.ManageLexicon;
begin
  LexiconMode := true;
  Caption := 'LangMan - Lexicon Editor';
end;

procedure TStringsEditor.FormCreate(Sender: TObject);
begin
  Items := TStringList.Create;
  LexiconMode := false;
{$IF CompilerVersion > 19}
  FindEdit.TextHint := 'Search in strings';
{$IFEND}
end;

procedure TStringsEditor.FormDestroy(Sender: TObject);
begin
  StoredWidth := Width;
  StoredHeight := Height;
  StoredLeft := Left;
  StoredTop := Top;
  StoredRow := ValueListEditor.Row;
  Items.Free;
end;

procedure TStringsEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ((Key = VK_RETURN) AND FindEdit.Focused) OR (Key = VK_F3) then FindBtnClick(nil);
  if ((Key = Ord('F')) OR (Key = Ord('f'))) AND (ssCtrl in Shift) then begin
    FindEdit.SetFocus;
    FindEdit.SelectAll;
  end;
end;

procedure TStringsEditor.FormShow(Sender: TObject);
begin
  if Scaled AND (PixelsPerInch <> 96) then begin
    ValueListEditor.DefaultRowHeight := Round(PixelsPerInch * ValueListEditor.DefaultRowHeight / 96);
  end;
  if StoredWidth <> 0 then Width := StoredWidth;
  if StoredHeight <> 0 then Height := StoredHeight;
  if StoredLeft <> 0 then Left := StoredLeft
                     else Left := (Screen.Width - Width) div 2;
  if StoredTop <> 0 then Top := StoredTop
                    else Top := (Screen.Height - Height) div 2;
end;

{$IF CompilerVersion > 16}

procedure LangManIntegration(const Lic, LMi, Ltt: String; LMnreg: Boolean; const Cop, iLic: String);
var Li: TMemoryStream;
begin
  if pgID <> 0 then Exit;
  try
    Li := TMemoryStream.Create;
    Make(Li, Lic);
    Lib.LoadFromStream(Li);
    (SplashScreenServices as IOTASplashScreenServices).AddPluginBitmap(Ltt, Lib.Handle, LMnreg, iLic);
    Make(Li, LMi);
    Lib.LoadFromStream(Li);
    pgID := (BorlandIDEServices as IOTAAboutBoxServices).AddPluginInfo(Ltt, Cop, Lib.Handle, LMnreg, iLic);
  finally
    FreeAndNil(Li);
  end;
end;

Initialization
  NotifierID := -1;
  pgID := 0;
  Lib := TBitmap.Create;
Finalization
  if NotifierID <> -1 then (BorlandIDEServices as IOTAServices).RemoveNotifier(NotifierID);
  if pgID > 0 then (BorlandIDEServices as IOTAAboutBoxServices).RemovePluginInfo(pgID);
  FreeAndNil(Lib);
{$IFEND}
{$ENDIF}
end.
