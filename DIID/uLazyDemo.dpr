program uLazyDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uExpensiveProcess in 'uExpensiveProcess.pas';

begin
  try
    Main;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
