program FutureDemo;

uses
  Vcl.Forms,
  frmFutureDemo in 'frmFutureDemo.pas' {FuturesDemoForm},
  uSlowCode in 'uSlowCode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFuturesDemoForm, FuturesDemoForm);
  Application.Run;
end.
