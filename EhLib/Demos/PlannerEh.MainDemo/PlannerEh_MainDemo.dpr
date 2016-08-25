program PlannerEh_MainDemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FrameOne in 'FrameOne.pas' {frFrameOne: TFrame},
  CustomPlannerItemDialog in 'CustomPlannerItemDialog.pas' {CustomPlannerItemForm},
  FrameFour in 'FrameFour.pas' {frFrameFour: TFrame},
  FrameThree in 'FrameThree.pas' {frFrameThree: TFrame},
  FrameTwo in 'FrameTwo.pas' {frFrameTwo: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Test Demo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
