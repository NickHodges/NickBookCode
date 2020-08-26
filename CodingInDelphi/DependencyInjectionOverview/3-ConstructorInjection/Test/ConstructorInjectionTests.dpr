program ConstructorInjectionTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  uOrderValidator in '..\uOrderValidator.pas',
  TestuOrderEntry in 'TestuOrderEntry.pas',
  TestuOrderValidator in 'TestuOrderValidator.pas',
  uOrder in '..\uOrder.pas',
  uOrderEntry in '..\uOrderEntry.pas',
  TestuOrderProcessor in 'TestuOrderProcessor.pas',
  uOrderProcessor in '..\uOrderProcessor.pas';

{R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.

