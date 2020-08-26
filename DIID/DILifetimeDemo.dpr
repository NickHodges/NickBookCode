program DILifetimeDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uSingletonDemo in 'uSingletonDemo.pas',
  uLifetimeRegistration in 'uLifetimeRegistration.pas';

begin
  try
    ProcessCarPart;
    ProcessCarPart;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
