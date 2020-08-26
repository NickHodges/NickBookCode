program StartingOutTests;

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  uOrder in '..\uOrder.pas',
  uOrderEntry in '..\uOrderEntry.pas',
  TestuOrderEntry in 'TestuOrderEntry.pas',
  uOrderValidator in '..\uOrderValidator.pas',
  TestuOrderValidator in 'TestuOrderValidator.pas',
  uOrderProcessor in '..\uOrderProcessor.pas',
  TestuOrderProcessor in 'TestuOrderProcessor.pas';

{R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.
