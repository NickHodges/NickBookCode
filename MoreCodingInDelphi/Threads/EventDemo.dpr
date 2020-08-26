program EventDemo;

uses
  Vcl.Forms,
  frmEvents in 'frmEvents.pas' {Form61},
  uEventThread in 'uEventThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm61, Form61);
  Application.Run;
end.
