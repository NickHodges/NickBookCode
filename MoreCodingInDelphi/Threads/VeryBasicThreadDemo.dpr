program VeryBasicThreadDemo;

uses
  Vcl.Forms,
  frmThreads in 'frmThreads.pas' {ThreadsDemoForm},
  uVerySimpleThread in 'uVerySimpleThread.pas',
  uSlowCode in 'uSlowCode.pas',
  uMemoMessageThread in 'uMemoMessageThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TThreadsDemoForm, ThreadsDemoForm);
  Application.Run;
end.
