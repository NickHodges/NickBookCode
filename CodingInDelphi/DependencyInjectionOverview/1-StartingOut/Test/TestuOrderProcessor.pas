unit TestuOrderProcessor;

interface

uses
  TestFramework,
  uOrderProcessor;

type
  TestTOrderProcessor = class(TTestCase)
  strict private
    FOrderProcessor: TOrderProcessor;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestProcessOrder;
  end;

implementation

uses
  uOrder;

procedure TestTOrderProcessor.SetUp;
begin
  FOrderProcessor := TOrderProcessor.Create();
end;

procedure TestTOrderProcessor.TearDown;
begin
  FOrderProcessor.Free;
  FOrderProcessor := nil;
end;

procedure TestTOrderProcessor.TestProcessOrder;
var
  Order: TOrder;
  ReturnValue: Boolean;
begin
  Order := TOrder.Create();
  try
    ReturnValue := FOrderProcessor.ProcessOrder(Order);
    Check(ReturnValue);
  finally
    Order.Free;
  end;
end;

initialization
  RegisterTest(TestTOrderProcessor.Suite);
end.
