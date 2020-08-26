program ExceptionInThreadDemo;

uses
  Vcl.Forms,
  frmExceptionInThread in 'frmExceptionInThread.pas' {Form52},
  uExceptionInThread in 'uExceptionInThread.pas',
  uSlowCode in 'uSlowCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm52, Form52);
  Application.Run;
end.
