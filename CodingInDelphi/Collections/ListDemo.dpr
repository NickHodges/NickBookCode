program ListDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uListDemo in 'uListDemo.pas';

begin
  try
    DemoList;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
