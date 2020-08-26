{ Copyright (c) 2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
  Full BSD License is available at http://BeSharp.codeplex.com/license }

program RttiHelpersUnitTestsProject;
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
  RttiHelpersTestCaseUnit in 'RttiHelpersTestCaseUnit.pas',
  RttiHelpers in '..\..\RunTimeTypingInformation\RttiHelpers.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.
