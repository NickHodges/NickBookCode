unit uSalaryChanger;

interface

uses
       Spring.Interception
    ;

type

  TSalaryChanger = class
    procedure ChangeSalary(const aNewSalary: Integer); virtual;
  end;

  TMinSalaryChangerInterceptor = class(TInterfacedObject, IInterceptor)
    procedure Intercept(const Invoker: IInvocation);
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
  MinSalaryInterceptor: IInterceptor;
  Proxy: TSalaryChanger;
begin
    SalaryInterceptor := TSalaryChangerInterceptor.Create;
    MinSalaryInterceptor := TMinSalaryChangerInterceptor.Create;
    Proxy := TProxyGenerator.CreateClassProxy<TSalaryChanger>([SalaryInterceptor, MinSalaryInterceptor]);
    Proxy.ChangeSalary(aNewSalary);
end;

{ TMinSalaryChangerInterceptor }

procedure TMinSalaryChangerInterceptor.Intercept(const Invoker: IInvocation);
begin
  if Invoker.Arguments[0].AsInteger < 25000 then
  begin
    WriteLn('No one should earn so little!');
  end else
  begin
    Invoker.Proceed;
  end;
end;

end.
