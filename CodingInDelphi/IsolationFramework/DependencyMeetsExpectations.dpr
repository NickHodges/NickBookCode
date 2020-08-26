program DependencyMeetsExpectations;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Windows.Console,
  uDependencyMeetsExpectations in 'uDependencyMeetsExpectations.pas',
  TestDependencyMeetsExpectation in 'Tests\TestDependencyMeetsExpectation.pas';

var
  Runner: ITestRunner;
  Logger: ITestLogger;
  Results: ITestResults;

begin
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

end.
