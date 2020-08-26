program SalaryChangerDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uSalaryChanger in 'uSalaryChanger.pas';

begin
  try
    TryToChangeSalary(20000);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
