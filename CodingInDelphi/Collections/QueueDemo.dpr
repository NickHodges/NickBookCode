program QueueDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uQueueDemo in 'uQueueDemo.pas';

begin
  try
    DoRepairs;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
