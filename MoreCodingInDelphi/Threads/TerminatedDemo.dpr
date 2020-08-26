program TerminatedDemo;

uses
  Vcl.Forms,
  frmTerminatedDemo in 'frmTerminatedDemo.pas' {Form49},
  uTerminatedDemoThread in 'uTerminatedDemoThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm49, Form49);
  Application.Run;
end.
