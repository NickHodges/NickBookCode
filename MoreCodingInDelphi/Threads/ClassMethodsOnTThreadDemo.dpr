program ClassMethodsOnTThreadDemo;

uses
  Vcl.Forms,
  frmClassMethodsOnTThread in 'frmClassMethodsOnTThread.pas' {Form50},
  uSlowCode in 'uSlowCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm50, Form50);
  Application.Run;
end.
