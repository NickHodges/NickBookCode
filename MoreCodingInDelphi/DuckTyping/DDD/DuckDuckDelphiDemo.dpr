program DuckDuckDelphiDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uDuckDuckDelphi in 'uDuckDuckDelphi.pas',
  uQuackingThings in 'uQuackingThings.pas';

begin
  try
    DoIt;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
