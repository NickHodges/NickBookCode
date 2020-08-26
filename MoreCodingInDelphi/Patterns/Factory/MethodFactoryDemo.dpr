program MethodFactoryDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uPublicPerformance in 'uPublicPerformance.pas',
  uMethodFactory in 'uMethodFactory.pas';

begin
  try
    DoIt;
    WriteLn;
    DoItAgain;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
