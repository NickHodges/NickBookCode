program PropertyInjectionDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uPropertyInjection in 'uPropertyInjection.pas';

begin
  try
    Main;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
