program StrideDemo;

uses
  Vcl.Forms,
  frmStrideDemo in 'frmStrideDemo.pas' {StrideDemoForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TStrideDemoForm, StrideDemoForm);
  Application.Run;
end.
