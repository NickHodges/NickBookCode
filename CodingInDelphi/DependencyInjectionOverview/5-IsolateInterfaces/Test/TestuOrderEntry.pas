unit TestuOrderEntry;

interface

uses
  TestFramework,
  uOrderInterfaces;

type
  TestTOrderEntry = class(TTestCase)
  strict private
    FOrderEntry: IOrderEntry;
  public
    procedure SetUp; override;
  published
    procedure TestEnterOrderIntoDatabase;
  end;

implementation

uses
  uOrder,
  uOrderEntry;

procedure TestTOrderEntry.SetUp;
begin
  FOrderEntry := TOrderEntry.Create();
end;

procedure TestTOrderEntry.TestEnterOrderIntoDatabase;
var
  Order: TOrder;
  ResultValue: Boolean;
begin
  Order := TOrder.Create();
  try
    ResultValue := FOrderEntry.EnterOrderIntoDatabase(Order);
    Check(ResultValue);
  finally
    Order.Free;
  end;
end;

initialization
  RegisterTest(TestTOrderEntry.Suite);
end.