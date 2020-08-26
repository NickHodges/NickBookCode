program DDDVCLApp;

uses
  Vcl.Forms,
  uDDDMainForm in 'uDDDMainForm.pas' {Form49};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm49, Form49);
  Application.Run;
end.
