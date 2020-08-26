unit TestuOrderProcessor;

interface

uses
  TestFramework,
  uOrderInterfaces;

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
  Spring.Container,
  Spring.Services;

procedure TestTOrderProcessor.SetUp();
begin
  GlobalContainer.Build();
  FOrderProcessor := ServiceLocator.GetService<IOrderProcessor>();
end;

procedure TestTOrderProcessor.TestProcessOrder;
var
  Order: TOrder;
  ResultValue: Boolean;
begin
  Order := TOrder.Create();
  try
    ResultValue := FOrderProcessor.ProcessOrder(Order);
    Check(ResultValue);
  finally
    Order.Free;
  end;
end;

initialization
  RegisterTest(TestTOrderProcessor.Suite);
end.
