program PrimitiveRegistrationDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uPrimitiveConstructorInjection in 'uPrimitiveConstructorInjection.pas';

begin
  try
    Main;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
