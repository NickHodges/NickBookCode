program NoParallelization;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Diagnostics,
  System.TimeSpan,
  uSlowCode in 'uSlowCode.pas';

  var
    Stopwatch: TStopWatch;
    Total: integer;
    ElapsedSeconds: Double;

begin
  try
    Stopwatch := TStopwatch.StartNew;
    Total := PrimesBelow(200000);
    ElapsedSeconds := StopWatch.Elapsed.TotalSeconds;
    WriteLn('There are ', Total, ' primes under 200,000');
    WriteLn('It took ', ElapsedSeconds, ' seconds to calcluate that') ;
    ReadLn;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
