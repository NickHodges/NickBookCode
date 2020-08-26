program UndoDemo;

uses
  Vcl.Forms,
  frmUndoExample in 'frmUndoExample.pas' {UndoExampleForm},
  uPointCommand in 'uPointCommand.pas',
  uPointInterfaces in 'uPointInterfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TUndoExampleForm, UndoExampleForm);
  Application.Run;
end.
