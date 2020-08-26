unit uDecoratorInterface;

interface

uses
      uLogger
    , uOrder
    , uAuthentication
    ;

type

  IOrderProcessor = interface
  ['{193966C6-BD40-487F-8A2F-E36BC707CA7D}']
    procedure ProcessOrder(aOrder: TOrder);
  end;

  TOrderProcessor = class(TInterfacedObject, IOrderProcessor)
    procedure ProcessOrder(aOrder: TOrder);
  end;

  // Decorated Order Processor

  TOrderProcessorDecorator = class abstract(TInterfacedObject, IOrderProcessor)
  private
    FInnerOrderProcessor: IOrderProcessor;
  public
    constructor Create(aOrderProcessor: IOrderProcessor);
    procedure ProcessOrder(aOrder: TOrder); virtual; abstract;
  end;

  TLoggingOrderProcessor = class(TOrderProcessorDecorator)
  private
    FLogger: ILogger;
  public
    constructor Create(aOrderProcessor: IOrderProcessor; aLogger: ILogger);
    procedure ProcessOrder(aOrder: TOrder); override;
  end;

  TAuthenticationOrderProcessor = class(TOrderProcessorDecorator)
  private
    FAuthentication: IAuthentication;
  public
    constructor Create(aOrderProcessor: IOrderProcessor; aAuthentication: IAuthentication);
    procedure ProcessOrder(aOrder: TOrder); override;
  end;

procedure DoIt;

implementation

uses
      System.SysUtils
    ;

procedure DoIt;
var
  OrderProcessor: IOrderProcessor;
  Order: TOrder;
begin
  Order := TOrder.Create(42);
  try
    OrderProcessor := TOrderProcessor.Create;
    OrderProcessor := TLoggingOrderProcessor.Create(OrderProcessor, TLogger.Create);
    OrderProcessor.ProcessOrder(Order);

    WriteLn;

    OrderProcessor := TAuthenticationOrderProcessor.Create(OrderProcessor, TAuthentication.Create);
    OrderProcessor.ProcessOrder(Order);

  finally
    Order.Free;
  end;
end;

{ TOrderProcessor }

  procedure TOrderProcessor.ProcessOrder(aOrder: TOrder);
  begin
    WriteLn('Processed order for Order #', aOrder.ID);
  end;

{ TLoggingOrderProcessor }

constructor TLoggingOrderProcessor.Create(aOrderProcessor: IOrderProcessor; aLogger: ILogger);
begin
  inherited Create(aOrderProcessor);
  FLogger := aLogger;
end;

procedure TLoggingOrderProcessor.ProcessOrder(aOrder: TOrder);
begin
  FLogger.Log('Logging: About to process Order #' + aOrder.ID.ToString);
  FInnerOrderProcessor.ProcessOrder(aOrder);
  FLogger.Log('Logging: Finished processing Order #' + aOrder.ID.ToString);
end;

{ TOrderProcessorAdapter }

constructor TOrderProcessorDecorator.Create(aOrderProcessor: IOrderProcessor);
begin
  inherited Create;
  FInnerOrderProcessor := aOrderProcessor;
end;

{ TAuthenticationOrderProcessor }

constructor TAuthenticationOrderProcessor.Create(aOrderProcessor: IOrderProcessor; aAuthentication: IAuthentication);
begin
  inherited Create(aOrderProcessor);
  FAuthentication := aAuthentication;
end;

procedure TAuthenticationOrderProcessor.ProcessOrder(aOrder: TOrder);
begin
  if FAuthentication.Authenticate('mcid') then
  begin
    FInnerOrderProcessor.ProcessOrder(aOrder);
  end else
  begin
    WriteLn('You failed authentication!');
  end;
end;

end.
