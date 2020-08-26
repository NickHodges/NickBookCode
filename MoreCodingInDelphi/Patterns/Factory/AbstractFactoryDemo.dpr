program AbstractFactoryDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uAbstractFactory in 'uAbstractFactory.pas',
  uGetInterfaceDemo in 'uGetInterfaceDemo.pas';

begin
  try
    DoIt;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
