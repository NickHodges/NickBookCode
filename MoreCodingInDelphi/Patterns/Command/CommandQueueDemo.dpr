program CommandQueueDemo;

uses
  Vcl.Forms,
  frmQueueDemo in 'frmQueueDemo.pas' {Form49};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm49, Form49);
  Application.Run;
end.
