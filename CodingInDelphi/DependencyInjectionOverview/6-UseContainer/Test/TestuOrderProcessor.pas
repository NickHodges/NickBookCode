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
    procedure TestProcessOrder();
  end;

implementation

uses
  SysUtils,
  uOrder,
  uOrderEntryMock,
  uOrderValidatorMock,
  uOrderProcessor,
  Spring,
  Spring.Container,
  Spring.Services;

procedure TestTOrderProcessor.SetUp();
var
  OrderValidator: IOrderValidator;
  OrderEntry: IOrderEntry;
begin
  GlobalContainer.Build();

// Two ways of getting the Mock objects

// 1. Constructing them by hand.
  OrderValidator :=  TOrderValidatorMock.Create();
  OrderEntry := TOrderEntryMock.Create();

// 2. Going throug the ServiceLocator with their unique names.
// Note that going through the ServiceLocator without the names will give you the regular implementations,
// which you want for the normal business code still to work:
//  OrderValidator := ServiceLocator.GetService<IOrderValidator>();
//  OrderEntry := ServiceLocator.GetService<IOrderEntry>();
// But retrieving them with their unique names gives back the Mock classes:
//  OrderValidator := ServiceLocator.GetService<IOrderValidator>(TOrderValidatorMockServiceName);
//  OrderEntry := ServiceLocator.GetService<IOrderEntry>(TOrderEntryMockServiceName);

  FOrderProcessor := TOrderProcessor.Create(OrderValidator, OrderEntry);
end;

procedure TestTOrderProcessor.TestProcessOrder();
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
