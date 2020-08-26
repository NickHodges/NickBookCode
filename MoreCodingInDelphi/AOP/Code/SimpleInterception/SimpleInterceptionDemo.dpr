program SimpleInterceptionDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uSimpleInterception in 'uSimpleInterception.pas';

begin
  try
    Main;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
