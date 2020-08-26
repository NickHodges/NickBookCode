program DelegateToDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Spring.Container,
  System.SysUtils,
  uDelegateTo in 'uDelegateTo.pas',
  uDelegateToRegistration in 'uDelegateToRegistration.pas';

begin
  try
    GlobalContainer.Build;
    OutputName;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
