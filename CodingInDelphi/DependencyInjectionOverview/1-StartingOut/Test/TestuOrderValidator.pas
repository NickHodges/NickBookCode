unit TestuOrderValidator;

interface

uses
  TestFramework,
  uOrderValidator;

type
  TestTOrderValidator = class(TTestCase)
  strict private
    FOrderValidator: TOrderValidator;
  public
    procedure SetUp; override;
    procedure TearDown; override;
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

procedure TestTOrderValidator.TearDown;
begin
  FOrderValidator.Free;
  FOrderValidator := nil;
end;

procedure TestTOrderValidator.TestValidateOrder;
var
  Order: TOrder;
  ReturnValue: Boolean;
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
