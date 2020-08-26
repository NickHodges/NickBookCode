program DictionaryDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uDictionaryDemo in 'uDictionaryDemo.pas';

begin
  try
    ProcessStudents;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
