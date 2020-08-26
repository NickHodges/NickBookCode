program DecoratorInterfaces;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uDecoratorInterface in 'uDecoratorInterface.pas',
  uLogger in 'uLogger.pas',
  uOrder in 'uOrder.pas',
  uAuthentication in 'uAuthentication.pas';

begin
  try
    DoIt;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
