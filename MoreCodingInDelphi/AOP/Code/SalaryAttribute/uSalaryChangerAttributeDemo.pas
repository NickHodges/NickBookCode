unit uSalaryChangerAttributeDemo;



interface

uses
      Spring.Interception
    , Spring.Container
    , Spring.Container.Common
    , Spring.Services
    ;

type

  ISalaryChanger = interface(IInvokable)
  ['{9BD8D6E6-EC69-4FBA-9BD3-13BD958CDBC2}']
    procedure ChangeSalary(const aNewSalary: Integer);
  end;

  TSalaryChangerInterceptor = class(TInterfacedObject, IInterceptor)
    procedure Intercept(const Invoker: IInvocation);
  end;

  [Interceptor('SalaryChangerInterface')]
  TSalaryChanger = class(TInterfacedObject, ISalaryChanger)
     procedure ChangeSalary(const aNewSalary: Integer); virtual;
  end;

  procedure Main;

implementation

uses
      System.SysUtils
    , uRegister
    ;

procedure Main;
var
  SalaryChanger: ISalaryChanger;
  LContainer: TContainer;
begin
  LContainer := TContainer.Create;
  try
    RegisterWithContainer(LContainer);
    LContainer.Build;
    SalaryChanger := LContainer.Resolve<ISalaryChanger>;
    SalaryChanger.ChangeSalary(75000);
  finally
    LContainer.Free;
  end;
end;

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

end.
