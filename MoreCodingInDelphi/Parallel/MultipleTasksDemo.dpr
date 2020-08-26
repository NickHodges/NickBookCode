program MultipleTasksDemo;

uses
  Vcl.Forms,
  frmMultipleTasks in 'frmMultipleTasks.pas' {MultipleTasksDemoForm},
  uSlowCode in 'uSlowCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMultipleTasksDemoForm, MultipleTasksDemoForm);
  Application.Run;
end.
