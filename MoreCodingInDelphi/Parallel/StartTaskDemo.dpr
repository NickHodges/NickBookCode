program StartTaskDemo;

uses
  Vcl.Forms,
  frmStartTaskDemo in 'frmStartTaskDemo.pas' {StartTaskDemoForm},
  uSlowCode in 'uSlowCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TStartTaskDemoForm, StartTaskDemoForm);
  Application.Run;
end.
