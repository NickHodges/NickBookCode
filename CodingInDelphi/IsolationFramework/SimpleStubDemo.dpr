program SimpleStubDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Windows.Console,
  uSimpleStubDemo in 'uSimpleStubDemo.pas',
  uSimpleStubDemoTests in 'Tests\uSimpleStubDemoTests.pas';

var
  Runner: ITestRunner;
  Logger: ITestLogger;
  Results: ITestResults;

begin
  try
    //Create the runner
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    //tell the runner how we will log things
    Logger := TDUnitXConsoleLogger.Create;
    Runner.AddLogger(Logger);
    //Run tests
    Results := Runner.Execute;
    // All done
    System.Write('Done.. press the <Enter> key to quit.');
    System.Readln;

  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.


