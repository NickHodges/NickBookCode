program Project54;

uses
  Vcl.Forms,
  Unit46 in 'Unit46.pas' {Form46},
  uCursorInterceptor in 'uCursorInterceptor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm46, Form46);
  Application.Run;
end.
