program ParallelForDemo;

uses
  Vcl.Forms,
  frmParallelForDemo in 'frmParallelForDemo.pas' {ParallelForDemoForm},
  uSlowCode in 'uSlowCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TParallelForDemoForm, ParallelForDemoForm);
  Application.Run;
end.
