program Project1;

{$R 'InlineLexiconResource.res' 'InlineLexiconResource.rc'}
{$R *.dres}

uses
  Forms,
  Unit4 in 'Unit4.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'LangMan DEMO';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
