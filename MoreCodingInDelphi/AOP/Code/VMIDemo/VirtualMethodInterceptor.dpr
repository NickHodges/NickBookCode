program VirtualMethodInterceptor;

{$APPTYPE CONSOLE}

uses
  Rtti,
  SysUtils,
  uVMIDemo in 'uVMIDemo.pas';

begin
  try
    Main;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
