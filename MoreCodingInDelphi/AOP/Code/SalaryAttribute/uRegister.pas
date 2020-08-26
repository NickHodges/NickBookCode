unit uRegister;

interface

uses
      Spring.Container
    ;

procedure RegisterWithContainer(aContainer: TContainer);

implementation

uses
      Spring.Interception
    , uSalaryChangerAttributeDemo
    ;

procedure RegisterWithContainer(aContainer: TContainer);
begin
  aContainer.RegisterType<IInterceptor, TSalaryChangerInterceptor>('SalaryChangerInterface');
  aContainer.RegisterType<TSalaryChanger>;//.InterceptedBy('SalaryChangerInterface');
end;

end.
