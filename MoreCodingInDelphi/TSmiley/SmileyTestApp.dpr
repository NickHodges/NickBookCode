program SmileyTestApp;



uses
  Forms,
  SmileyTestAppMainForm in 'SmileyTestAppMainForm.pas' {SmileyTestForm},
  frmChoose in 'frmChoose.pas' {ChooseDlg};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSmileyTestForm, SmileyTestForm);
  Application.CreateForm(TChooseDlg, ChooseDlg);
  Application.Run;
end.
