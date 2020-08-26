program MultipleThreadsDemo;

uses
  Vcl.Forms,
  frmMultipleThreads in 'frmMultipleThreads.pas' {Form53},
  uSlowCode in 'uSlowCode.pas',
  uPrimeThreads in 'uPrimeThreads.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm53, Form53);
  Application.Run;
end.
