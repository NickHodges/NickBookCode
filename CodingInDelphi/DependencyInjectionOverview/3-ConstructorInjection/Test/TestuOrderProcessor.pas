unit TestuOrderProcessor;

interface

uses
  TestFramework,
  uOrderProcessor;

type
  TestTOrderProcessor = class(TTestCase)
  strict private
    FOrderProcessor: IOrderProcessor;
  public
    procedure SetUp(); override;
  published
    procedure TestProcessOrder;
  end;

implementation

uses
  uOrder,
  uOrderEntry,
  uOrderValidator;

procedure TestTOrderProcessor.SetUp();
var
  OrderEntry: IOrderEntry;
  OrderValidator: IOrderValidator;
begin
  OrderValidator := TOrderValidator.Create();
  OrderEntry := TOrderEntry.Create();
  FOrderProcessor := TOrderProcessor.Create(OrderValidator, OrderEntry);
end;

procedure TestTOrderProcessor.TestProcessOrder;
var
  Order: TOrder;
  ResultValue: Boolean;
begin
  Order := TOrder.Create();
  try
    // We can check success, but...
    ResultValue := FOrderProcessor.ProcessOrder(Order);
    Check(ResultValue);
    // how do we check that the order really made it to the database?
    // Or do we even want to....?
  finally
    Order.Free;
  end;
end;

initialization
  RegisterTest(TestTOrderProcessor.Suite);
end.

