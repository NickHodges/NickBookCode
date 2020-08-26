program NoCaseFactoryDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uNoCaseFactorySolution in 'uNoCaseFactorySolution.pas';

begin
  try
    DoIt;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
