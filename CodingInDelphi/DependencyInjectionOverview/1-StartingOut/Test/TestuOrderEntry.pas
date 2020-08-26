unit TestuOrderEntry;

interface

uses
  TestFramework,
  uOrderEntry;

type
  TestTOrderEntry = class(TTestCase)
  strict private
    FOrderEntry: TOrderEntry;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEnterOrderIntoDatabase;
  end;

implementation

uses
  uOrder;

procedure TestTOrderEntry.SetUp;
begin
  FOrderEntry := TOrderEntry.Create();
end;

procedure TestTOrderEntry.TearDown;
begin
  FOrderEntry.Free;
  FOrderEntry := nil;
end;

procedure TestTOrderEntry.TestEnterOrderIntoDatabase;
var
  Order: TOrder;
  ReturnValue: Boolean;
begin
  Order := TOrder.Create();
  try
    ReturnValue := FOrderEntry.EnterOrderIntoDatabase(Order);
    Check(ReturnValue);
  finally
    Order.Free;
  end;
end;

initialization
  RegisterTest(TestTOrderEntry.Suite);
end.