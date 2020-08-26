program SimpleTaskDemo;

uses
  Vcl.Forms,
  frmSimpleTaskDemo in 'frmSimpleTaskDemo.pas' {SimpleTaskForm},
  uSlowCode in 'uSlowCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSimpleTaskForm, SimpleTaskForm);
  Application.Run;
end.
