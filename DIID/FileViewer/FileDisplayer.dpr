program FileDisplayer;

uses
  Vcl.Forms,
  Spring.Container,
  frmMain in 'frmMain.pas' {FileDisplayerForm},
  uFileDisplayer in 'uFileDisplayer.pas',
  uFileDisplayerInterfaces in 'uFileDisplayerInterfaces.pas',
  uFileDisplayerRegistry in 'uFileDisplayerRegistry.pas',
  uFilenameExtensionGetter in 'uFilenameExtensionGetter.pas',
  uFilenameGetter in 'uFilenameGetter.pas',
  uTextFileDisplayer in 'uTextFileDisplayer.pas',
  uRegistration in 'uRegistration.pas',
  uPictureDisplayer in 'uPictureDisplayer.pas',
  uDefaultDisplayer in 'uDefaultDisplayer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFileDisplayerForm, FileDisplayerForm);
  Application.Run;
end.
