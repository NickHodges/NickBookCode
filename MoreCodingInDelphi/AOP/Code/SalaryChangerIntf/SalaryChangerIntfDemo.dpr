program SalaryChangerIntfDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uSalaryChangerIntf in 'uSalaryChangerIntf.pas';

begin
  try
    TryToChangeSalary(100000);
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
