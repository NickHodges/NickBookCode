program MethodInjectionDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uBadInjection in 'uBadInjection.pas',
  uGoodMethodInjection in 'uGoodMethodInjection.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
