unit TestuOrderValidator;

interface

uses
  TestFramework,
  uOrderValidator;

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
  uOrder;

procedure TestTOrderValidator.SetUp;
begin
  FOrderValidator := TOrderValidator.Create();
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
