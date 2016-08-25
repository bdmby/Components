unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdActns, ActnList, LangManCtrls, ComCtrls, LangManSys, LangManComp,
  TeeProcs, TeEngine, Chart, StdCtrls, ExtCtrls, Menus, ToolWin, ImgList,
  LangManCore, System.Actions;

type
  TMainForm = class(TForm)
    ActionList1: TActionList;
    FileOpen1: TFileOpen;
    FileSaveAs1: TFileSaveAs;
    FileExit1: TFileExit;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Language1: TMenuItem;
    Open1: TMenuItem;
    SaveAs1: TMenuItem;
    Exit1: TMenuItem;
    StatusBar: TStatusBar;
    LangManEngine: TLangManEngine;
    LangManClient: TLangManClient;
    DesignedLexicon: TDesignedLexicon;
    Pages: TPageControl;
    BasicsTab: TTabSheet;
    GridPanel1: TGridPanel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    LangFlagsCombo1: TLangFlagsCombo;
    ValuedLabel1: TValuedLabel;
    ValuedLabel2: TValuedLabel;
    Chart1: TChart;
    RichTab: TTabSheet;
    Memo1: TMemo;
    Rich: TLangManRichEdit;
    ReportBtn: TButton;
    GDBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ReportBtnClick(Sender: TObject);
    procedure GDBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  Memo: TLangManStrings;

implementation

{$R *.dfm}

const
  BOLD_RED = 0;
  HEADING = 1;
  NOTE = 2;

procedure TMainForm.ReportBtnClick(Sender: TObject);
begin
  // Generate DEMO Report to TLangManRichEdit
  Rich.WriteLn(DesignedLexicon.Link[2], HEADING);
  Rich.WriteLn('');  // OR Rich.NextLine
  Rich.Write(DesignedLexicon.Link[3] + ' ');
  Rich.Writeln(DateToStr(Date), BOLD_RED);
  Rich.NextLine;     // OR Rich.Writeln('')
  Rich.WriteLn(DesignedLexicon.Link[4] + ' (' + Rich.Format(DesignedLexicon.Link[5], NOTE) + ')');
  Rich.NextLine;
  // Generate DEMO Report to TMemo via TLangManStrings
  Memo.Add(DesignedLexicon.Link[2]);
  Memo.Add('');
  Memo.Add(DesignedLexicon.Link[3] + ' ' + DateToStr(Date));
  Memo.Add('');
  Memo.Add(DesignedLexicon.Link[4] + ' (' + DesignedLexicon.Link[5] + ')');
  Memo.Add('');
  //
  GDBtn.Visible := true;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  // LangMan for Memo1
  Memo := TLangManStrings.Create(Memo1.Lines, DesignedLexicon);
  // Rich: TLangManRichEdit - define styles
  Rich.SetStyle([fsBold], 0, clRed);                             // BOLD_RED
  Rich.SetStyle([fsBold, fsItalic, fsUnderLine], 12, clBlue);    // HEADING
  Rich.SetStyle([fsItalic]);                                     // NOTE
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Memo.Free;
end;

procedure TMainForm.GDBtnClick(Sender: TObject);
begin
  Rich.SetStyle([fsBold], 0, clGreen,'',DEFAULT_CHARSET,fpDefault, BOLD_RED);
  // OR (same effect:)
  // Rich.GetStyles[BOLD_RED].Color := clGreen;
  // Rich.Translate;
end;

end.
