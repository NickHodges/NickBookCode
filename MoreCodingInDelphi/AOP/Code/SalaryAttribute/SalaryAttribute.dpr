program SalaryAttribute;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uSalaryChangerAttributeDemo in 'uSalaryChangerAttributeDemo.pas',
  uRegister in 'uRegister.pas';

begin
  try
    Main;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
