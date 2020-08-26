unit uSalaryChangerIntf;

interface

uses
       Spring.Interception
    ;


type

  ISalaryChanger = interface(IInvokable)
    procedure ChangeSalary(const aNewSalary: Integer);
  end;

  TSalaryChanger = class(TInterfacedObject, ISalaryChanger)
    procedure ChangeSalary(const aNewSalary: Integer);
  end;

  TSalaryChangerInterceptor = class(TInterfacedObject, IInterceptor)
    procedure Intercept(const Invoker: IInvocation);
  end;

procedure TryToChangeSalary(aNewSalary: integer);

implementation

uses
      System.SysUtils
    ;


{ TSalaryChangerInterceptor }

procedure TSalaryChangerInterceptor.Intercept(const Invoker: IInvocation);
var
  LPassword: string;
begin
  if SameText(Invoker.Method.Name, 'ChangeSalary') then
  begin
    Write('Please enter the password to change the salary: ');
    ReadLn(LPassword);

    if LPassword = 'mcid' then
    begin
      Invoker.Proceed;
    end else
    begin
      Writeln('Sorry, you are not authorized to change salaries');
    end;
  end;
end;

procedure TSalaryChanger.ChangeSalary(const aNewSalary: Integer);
begin
  WriteLn('You changed the salary to ', aNewSalary);
end;

procedure TryToChangeSalary(aNewSalary: integer);
var
  SalaryInterceptor: IInterceptor;
  Proxy: ISalaryChanger;
  SalaryChanger: ISalaryChanger;
begin
  SalaryInterceptor := TSalaryChangerInterceptor.Create;
  SalaryChanger := TSalaryChanger.Create;
  Proxy := TProxyGenerator.CreateInterfaceProxyWithTarget<ISalaryChanger>(SalaryChanger, [SalaryInterceptor]);
  Proxy.ChangeSalary(aNewSalary);
end;

end.
