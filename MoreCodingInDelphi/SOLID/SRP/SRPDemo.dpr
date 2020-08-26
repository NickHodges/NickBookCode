program SRPDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uTooManyResponsibilities in 'uTooManyResponsibilities.pas',
  uSortOfSingleResponsibility in 'uSortOfSingleResponsibility.pas',
  uJustRightResponsibilities in 'uJustRightResponsibilities.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
