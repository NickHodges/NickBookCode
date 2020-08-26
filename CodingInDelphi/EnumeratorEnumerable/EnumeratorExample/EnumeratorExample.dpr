program EnumeratorExample;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  uEnumeratorExample in 'uEnumeratorExample.pas',
  uMoreEnumerators in 'uMoreEnumerators.pas',
  uEnumeratorInterface in 'uEnumeratorInterface.pas';

begin
  try
    Writeln('----------------------');
    DoStuff();
    Writeln('----------------------');
    DoMoreStuff();
    Writeln('----------------------');
    DoInterfaceStuff();
    Writeln('----------------------');
    Write('Press <Enter>...');
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
