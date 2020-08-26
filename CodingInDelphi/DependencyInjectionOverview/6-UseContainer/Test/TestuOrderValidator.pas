unit TestuOrderValidator;

interface

uses
  TestFramework,
  uOrderInterfaces;

type
  TestTOrderValidator = class(TTestCase)
  public
    procedure SetUp; override;
  published
    procedure TestOrderValidatorIsMock_ServiceLocator_TOrderValidatorMockServiceName();
    procedure TestOrderValidatorIsRegular_ServiceLocator();
    procedure TestValidateOrder;
  end;

implementation

uses
  uOrder,
  Spring.Services,
  Spring.Container,
  uSpringTestCaseHelper,
  uOrderValidatorMock,
  uRegisterMocks;

const
  SOrderValidator = 'OrderValidator';

procedure TestTOrderValidator.SetUp;
begin
  GlobalContainer.Build();
end;

procedure TestTOrderValidator.TestOrderValidatorIsMock_ServiceLocator_TOrderValidatorMockServiceName();
var
  OrderValidator: IOrderValidator;
begin
// Retrieving the instances with the unique service names gives back the Mock classes:
  OrderValidator := ServiceLocator.GetService<IOrderValidator>(RegisterMocks.TOrderValidatorMockServiceName);
  TestInterfaceImplementedByClass(OrderValidator, TOrderValidatorMock, SOrderValidator);
end;

procedure TestTOrderValidator.TestOrderValidatorIsRegular_ServiceLocator();
var
  OrderValidator: IOrderValidator;
begin
// Note that going through the ServiceLocator without the names will give you the regular implementations,
// which you want for the normal business code still to work:
  OrderValidator := ServiceLocator.GetService<IOrderValidator>();
  TestInterfaceNotImplementedByClass(OrderValidator, TOrderValidatorMock, SOrderValidator);
end;

procedure TestTOrderValidator.TestValidateOrder;
var
  Order: TOrder;
  OrderValidator: IOrderValidator;
  ReturnValue: Boolean;
begin
  Order := TOrder.Create();
  try
    OrderValidator := ServiceLocator.GetService<IOrderValidator>();
    ReturnValue := OrderValidator.ValidateOrder(Order);
    Check(ReturnValue);
  finally
    Order.Free;
  end;
end;

initialization
  RegisterTest(TestTOrderValidator.Suite);
end.
