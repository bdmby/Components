unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxExportSynPDF, frxRich, StdCtrls;

type
  TForm1 = class(TForm)
    frxReport1: TfrxReport;
    frxRichObject1: TfrxRichObject;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  frxSynPDFExport: TfrxSynPDFExport;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  frxSynPDFExport := TfrxSynPDFExport.Create(Form1);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  frxReport1.PreviewPages.LoadFromFile('test.fp3');
  frxReport1.ShowPreparedReport;
end;

end.
