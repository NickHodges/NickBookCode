program CancelTaskDemo;

uses
  Vcl.Forms,
  frmCancelTask in 'frmCancelTask.pas' {Form62};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm62, Form62);
  Application.Run;
end.
