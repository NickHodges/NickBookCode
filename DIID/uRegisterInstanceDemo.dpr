program uRegisterInstanceDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uWorkersAndTools in 'uWorkersAndTools.pas';

begin
  try
    Main;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
