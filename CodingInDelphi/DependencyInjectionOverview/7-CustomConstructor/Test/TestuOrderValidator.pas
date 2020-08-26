unit TestuOrderValidator;

interface

uses
  TestFramework,
  uOrderInterfaces;

type
  TestTOrderValidator = class(TTestCase)
  strict private
    FOrderValidator: IOrderValidator;
  public
    procedure SetUp; override;
  published
    procedure TestValidateOrder;
  end;

implementation

uses
  uOrder,
  Spring.Container,
  Spring.Services;

procedure TestTOrderValidator.SetUp;
begin
  GlobalContainer.Build();
  FOrderValidator := ServiceLocator.GetService<IOrderValidator>();
end;

procedure TestTOrderValidator.TestValidateOrder;
var
  ReturnValue: Boolean;
  Order: TOrder;
begin
  Order := TOrder.Create();
  try
    ReturnValue := FOrderValidator.ValidateOrder(Order);
    Check(ReturnValue);
  finally
    Order.Free;
  end;
end;

initialization
  RegisterTest(TestTOrderValidator.Suite);
end.
