// http://synopse.info/forum/viewtopic.php?pid=7965

unit frxExportSynPDF;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,

  frxClass,

  SynPdf;

type
  TfrxExportSynPdf = class(TForm)
    PageControl1: TPageControl;
    ExportPage: TTabSheet;
    OpenCB: TCheckBox;
    GroupQuality: TGroupBox;
    CompressedCB: TCheckBox;
    EmbeddedCB: TCheckBox;
    OutlineCB: TCheckBox;
    BackgrCB: TCheckBox;
    cbPDFA: TCheckBox;
    GroupPageRange: TGroupBox;
    DescrL: TLabel;
    AllRB: TRadioButton;
    CurPageRB: TRadioButton;
    PageNumbersRB: TRadioButton;
    PageNumbersE: TEdit;
    InfoPage: TTabSheet;
    DocInfoGB: TGroupBox;
    TitleL: TLabel;
    AuthorL: TLabel;
    SubjectL: TLabel;
    KeywordsL: TLabel;
    CreatorL: TLabel;
    TitleE: TEdit;
    AuthorE: TEdit;
    SubjectE: TEdit;
    KeywordsE: TEdit;
    CreatorE: TEdit;
    ViewerPage: TTabSheet;
    ViewerGB: TGroupBox;
    HideToolbarCB: TCheckBox;
    HideMenubarCB: TCheckBox;
    HideWindowUICB: TCheckBox;
    FitWindowCB: TCheckBox;
    CenterWindowCB: TCheckBox;
    OkB: TButton;
    CancelB: TButton;
    SaveDialog1: TSaveDialog;
    procedure PageNumbersEChange(Sender: TObject);
    procedure PageNumbersEKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  end;

  TfrxSynPDFExport = class(TfrxCustomExportFilter)
  private
    fPdfDocument: TPdfDocumentGDI;

    FMaxX: Integer;
    FMaxY: Integer;
    FMinX: Integer;
    FMinY: Integer;
    FYOffset: Integer;
    FDiv: Extended;

    FCompressed: Boolean;
    FEmbedded: Boolean;
    FOpenAfterExport: Boolean;
    FOutline: Boolean;
    FSubject: WideString;
    FAuthor: WideString;
    FBackground: Boolean;
    FCreator: WideString;
    FKeywords: WideString;
    FTitle: WideString;
    FFitWindow: Boolean;
    FHideMenubar: Boolean;
    FCenterWindow: Boolean;
    FHideWindowUI: Boolean;
    FHideToolbar: Boolean;
    fPDFA: Boolean;
    function GetPdfDocument: TPdfDocumentGDI;
  protected
    property PdfDocument: TPdfDocumentGDI read GetPdfDocument;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;

    function ShowModal: TModalResult; override;
    function Start: Boolean; override;
    procedure ExportObject(Obj: TfrxComponent); override;
    procedure Finish; override;
    procedure StartPage(Page: TfrxReportPage; Index: Integer); override;
    procedure FinishPage(Page: TfrxReportPage; Index: Integer); override;
  published
    property Compressed: Boolean read FCompressed write FCompressed default True;
    property EmbeddedFonts: Boolean read FEmbedded write FEmbedded default False;
    property OpenAfterExport: Boolean read FOpenAfterExport write FOpenAfterExport default True;
    property Outline: Boolean read FOutline write FOutline default False;
    property Background: Boolean read FBackground write FBackground default True;
    property PDFA: Boolean read fPDFA write fPDFA default False;

    property Title: WideString read FTitle write FTitle;
    property Author: WideString read FAuthor write FAuthor;
    property Subject: WideString read FSubject write FSubject;
    property Keywords: WideString read FKeywords write FKeywords;
    property Creator: WideString read FCreator write FCreator;

    property HideToolbar: Boolean read FHideToolbar write FHideToolbar default False;
    property HideMenubar: Boolean read FHideMenubar write FHideMenubar default False;
    property HideWindowUI: Boolean read FHideWindowUI write FHideWindowUI default False;
    property FitWindow: Boolean read FFitWindow write FFitWindow default False;
    property CenterWindow: Boolean read FCenterWindow write FCenterWindow default False;
  end;

implementation

uses
  frxUtils,
  frxRes,
  frxrcExports,

  Printers,
  ShellApi;

{$R *.dfm}

constructor TfrxSynPDFExport.Create(AOwner: TComponent);
begin
  inherited;
  fBackground := True;
  fCompressed := True;
  fOpenAfterExport := True;

  FMaxX := 0;
  FMaxY := 0;
  FMinX := 100;
  FMinY := 100;
  FYOffset := 0;
  FDiv := 1;
end;

destructor TfrxSynPDFExport.Destroy;
begin
  FreeAndNil(fPdfDocument);
  inherited;
end;

procedure TfrxSynPDFExport.Finish;
begin
  try
    if Stream <> nil then
      PdfDocument.SaveToStream(Stream)
    else
      PdfDocument.SaveToFile(FileName);
    if OpenAfterExport and not Assigned(Stream) then
      ShellExecute(GetDesktopWindow, 'open', PChar(FileName), nil, nil, SW_SHOW);
  finally
    FreeAndNil(fPdfDocument);
  end;
end;

procedure TfrxSynPDFExport.FinishPage(Page: TfrxReportPage; Index: Integer);
begin
  inherited;

end;

class function TfrxSynPDFExport.GetDescription: String;
begin
  Result := 'SynPDF Export';
end;

function TfrxSynPDFExport.GetPdfDocument: TPdfDocumentGDI;
begin
  if not Assigned(fPdfDocument) then
  begin
    fPdfDocument := TPdfDocumentGDI.Create;
    fPdfDocument.Info.Creator := Application.Name;
    fPdfDocument.Info.Author := Application.Name;
    fPdfDocument.ScreenLogPixels := 96;
  end;
  fPdfDocument.ForceNoBitmapReuse := True;
  result := fPdfDocument;
end;

function TfrxSynPDFExport.ShowModal: TModalResult;
var
  s: String;
begin
  if (Title = '') and Assigned(Report) then
    Title := Report.ReportOptions.Name;
  if not Assigned(Stream) then
  begin
    if Assigned(Report) then
      Outline := Report.PreviewOptions.OutlineVisible
    else
      Outline := True;
    with TfrxExportSynPdf.Create(nil) do
    begin
      OpenCB.Visible := not SlaveExport;
      if OverwritePrompt then
        SaveDialog1.Options := SaveDialog1.Options + [ofOverwritePrompt];
      if SlaveExport then
        FOpenAfterExport := False;

      if (FileName = '') and (not SlaveExport) then
      begin
        s := ChangeFileExt(ExtractFileName(frxUnixPath2WinPath(Report.FileName)), SaveDialog1.DefaultExt);
        SaveDialog1.FileName := s;
      end
      else
        SaveDialog1.FileName := FileName;

      OpenCB.Checked := OpenAfterExport;
      CompressedCB.Checked := Compressed;
      EmbeddedCB.Checked := EmbeddedFonts;

      OutlineCB.Checked := Outline;
      OutlineCB.Enabled := Outline;
      BackgrCB.Checked := Background;

      if PageNumbers <> '' then
      begin
        PageNumbersE.Text := PageNumbers;
        PageNumbersRB.Checked := True;
      end;

      cbPDFA.Checked := PDFA;

      TitleE.Text := Title;
      AuthorE.Text := Author;
      SubjectE.Text := Subject;
      KeywordsE.Text := Keywords;
      CreatorE.Text := Creator;

      FitWindowCB.Checked := FitWindow;
      HideMenubarCB.Checked := HideMenubar;
      CenterWindowCB.Checked := CenterWindow;
      HideWindowUICB.Checked := HideWindowUI;
      HideToolbarCB.Checked := HideToolbar;

      Result := ShowModal;
      if Result = mrOk then
      begin
        PageNumbers := '';
        CurPage := False;
        if CurPageRB.Checked then
          CurPage := True
        else if PageNumbersRB.Checked then
          PageNumbers := PageNumbersE.Text;

        OpenAfterExport := OpenCB.Checked;
        Compressed := CompressedCB.Checked;
        EmbeddedFonts := EmbeddedCB.Checked;
        Outline := OutlineCB.Checked;
        Background := BackgrCB.Checked;
        PDFA := cbPDFA.Checked;

        Title := TitleE.Text;
        Author := AuthorE.Text;
        Subject := SubjectE.Text;
        Keywords := KeywordsE.Text;
        Creator := CreatorE.Text;

        FitWindow := FitWindowCB.Checked;
        HideMenubar := HideMenubarCB.Checked;
        CenterWindow := CenterWindowCB.Checked;
        HideWindowUI := HideWindowUICB.Checked;
        HideToolbar := HideToolbarCB.Checked;

        if not SlaveExport then
        begin
          if DefaultPath <> '' then
            SaveDialog1.InitialDir := DefaultPath;
          if SaveDialog1.Execute then
            FileName := SaveDialog1.FileName
          else
            Result := mrCancel;
        end;
      end;
      Free;
    end;
  end else
    Result := mrOk;
end;

function TfrxSynPDFExport.Start: Boolean;
var
  vPdfViewerPreferences: TPdfViewerPreferences;
begin
  result := true;
  PdfDocument.NewDoc;
  PdfDocument.PDFA1 := PDFA;
  PdfDocument.Info.CreationDate := CreationTime;
  PdfDocument.Info.ModDate := CreationTime;
  PdfDocument.Info.Author := Author;
  PdfDocument.Info.Subject := Subject;
  PdfDocument.Info.Keywords := Keywords;
  PdfDocument.Info.Creator := Creator;

  vPdfViewerPreferences := [];
  if FitWindow then Include(vPdfViewerPreferences, vpFitWindow);
  if HideMenubar then Include(vPdfViewerPreferences, vpHideMenubar);
  if CenterWindow then Include(vPdfViewerPreferences, vpCenterWindow);
  if HideWindowUI then Include(vPdfViewerPreferences, vpHideWindowUI);
  if HideToolbar then Include(vPdfViewerPreferences, vpHideToolbar);
  if vPdfViewerPreferences <> PdfDocument.Root.ViewerPreference then
    PdfDocument.Root.ViewerPreference := vPdfViewerPreferences;

  if Compressed then
    PdfDocument.CompressionMethod := cmFlateDecode
  else
    PdfDocument.CompressionMethod := cmNone;

  PdfDocument.UseOutlines := Outline;
  PdfDocument.EmbeddedTTF := EmbeddedFonts;
end;

procedure TfrxSynPDFExport.StartPage(Page: TfrxReportPage; Index: Integer);
begin
  inherited;

  case Page.PaperSize of
    DMPAPER_LETTER,
    DMPAPER_LETTERSMALL:  PdfDocument.DefaultPaperSize := psLetter;
    DMPAPER_LEGAL:        PdfDocument.DefaultPaperSize := psLegal;
    DMPAPER_A3:           PdfDocument.DefaultPaperSize := psA3;
    DMPAPER_A4,
    DMPAPER_A4SMALL:      PdfDocument.DefaultPaperSize := psA4;
    DMPAPER_A5:           PdfDocument.DefaultPaperSize := psA5;
  else
    PdfDocument.DefaultPaperSize := psUserDefined;
    PdfDocument.DefaultPageWidth := Round((Page.PaperWidth / 25.4) * 72.0);
    PdfDocument.DefaultPageHeight := Round((Page.PaperHeight / 25.4) * 72.0);
  end;

  PdfDocument.DefaultPageLandscape := (Page.Orientation = poLandscape);
  PdfDocument.AddPage;
end;

procedure TfrxSynPDFExport.ExportObject(Obj: TfrxComponent);
var
  z: Integer;
begin
  if (Obj is TfrxView) and (ExportNotPrintable or TfrxView(Obj).Printable) then
  begin
    if Background or not (Obj.Name = '_pagebackground') then
    begin
      z := Round(Obj.AbsLeft * FDiv);
      if z < FMinX then
        FMinX := z;
      z := FYOffset + Round(Obj.AbsTop * FDiv);
      if z < FMinY then
        FMinY := z;
      z := Round((Obj.AbsLeft + Obj.Width) * FDiv) + 1;
      if z > FMaxX then
        FMaxX := z;
      z := FYOffset + Round((Obj.AbsTop + Obj.Height) * FDiv) + 1;
      if z > FMaxY then
        FMaxY := z;
      TfrxView(Obj).Draw(PdfDocument.VCLCanvas , FDiv, FDiv, 0, FYOffset);
    end;
  end;
end;

procedure TfrxExportSynPdf.FormCreate(Sender: TObject);
begin
  Caption := frxGet(8700);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  GroupPageRange.Caption := frxGet(7);
  AllRB.Caption := frxGet(3);
  CurPageRB.Caption := frxGet(4);
  PageNumbersRB.Caption := frxGet(5);
  DescrL.Caption := frxGet(9);
  GroupQuality.Caption := frxGet(8);
  CompressedCB.Caption := frxGet(8709);
  EmbeddedCB.Caption := frxGet(8702);
  OutlineCB.Caption := frxGet(8704);
  BackgrCB.Caption := frxGet(8705);
  OpenCB.Caption := frxGet(8706);
  SaveDialog1.Filter := frxGet(8707);
  SaveDialog1.DefaultExt := frxGet(8708);

  ExportPage.Caption := frxGet(107);
  DocInfoGB.Caption := frxGet(8971);
  InfoPage.Caption := frxGet(8972);
  TitleL.Caption := frxGet(8973);
  AuthorL.Caption := frxGet(8974);
  SubjectL.Caption := frxGet(8975);
  KeywordsL.Caption := frxGet(8976);
  CreatorL.Caption := frxGet(8977);

  ViewerPage.Caption := frxGet(8981);
  ViewerGB.Caption := frxGet(8982);
  HideToolbarCB.Caption := frxGet(8983);
  HideMenubarCB.Caption := frxGet(8984);
  HideWindowUICB.Caption := frxGet(8985);
  FitWindowCB.Caption := frxGet(8986);
  CenterWindowCB.Caption := frxGet(8987);

  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxExportSynPdf.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxExportSynPdf.PageNumbersEChange(Sender: TObject);
begin
  PageNumbersRB.Checked := True;
end;

procedure TfrxExportSynPdf.PageNumbersEKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9':;
    #8, '-', ',':;
  else
    key := #0;
  end;
end;

end.