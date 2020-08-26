unit TestuOrderEntry;

interface

uses
  TestFramework,
  uOrderInterfaces;

type
  TestTOrderEntry = class(TTestCase)
  public
    procedure SetUp; override;
  published
    procedure TestEnterOrderIntoDatabase;
    procedure TestOrderEntryIsMock_ServiceLocator_TOrderEntryMockServiceName();
    procedure TestOrderEntryIsRegular_ServiceLocator();
  end;

implementation

uses
  uOrder,
  Spring.Services,
  Spring.Container,
  uSpringTestCaseHelper,
  uOrderEntryMock,
  uRegisterMocks;

const
  SOrderEntry = 'OrderEntry';

procedure TestTOrderEntry.SetUp;
begin
  GlobalContainer.Build();
end;

procedure TestTOrderEntry.TestEnterOrderIntoDatabase;
var
  Order: TOrder;
  OrderEntry: IOrderEntry;
  ResultValue: Boolean;
begin
  Order := TOrder.Create();
  try
    OrderEntry := ServiceLocator.GetService<IOrderEntry>();
    ResultValue := OrderEntry.EnterOrderIntoDatabase(Order);
    Check(ResultValue);
  finally
    Order.Free;
  end;
end;

procedure TestTOrderEntry.TestOrderEntryIsMock_ServiceLocator_TOrderEntryMockServiceName();
var
  OrderEntry: IOrderEntry;
begin
// Retrieving the instances with the unique service names gives back the Mock classes:
  OrderEntry := ServiceLocator.GetService<IOrderEntry>(RegisterMocks.TOrderEntryMockServiceName);
  TestInterfaceImplementedByClass(OrderEntry, TOrderEntryMock, SOrderEntry);
end;

procedure TestTOrderEntry.TestOrderEntryIsRegular_ServiceLocator();
var
  OrderEntry: IOrderEntry;
begin
// Note that going through the ServiceLocator without the names will give you the regular implementations,
// which you want for the normal business code still to work:
  OrderEntry := ServiceLocator.GetService<IOrderEntry>();
  TestInterfaceNotImplementedByClass(OrderEntry, TOrderEntryMock, SOrderEntry);
end;

initialization
  RegisterTest(TestTOrderEntry.Suite);
end.