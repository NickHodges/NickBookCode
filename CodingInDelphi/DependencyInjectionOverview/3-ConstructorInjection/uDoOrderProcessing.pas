unit uDoOrderProcessing;

interface

procedure DoOrderProcessing;

implementation

uses
  uOrder,
  uOrderProcessor,
  uOrderValidator,
  uOrderEntry;

procedure DoOrderProcessing;
var
  Order: TOrder;
  OrderProcessor: IOrderProcessor;
  OrderValidator: IOrderValidator;
  OrderEntry: IOrderEntry;
begin
  Order := TOrder.Create();
  OrderValidator := TOrderValidator.Create();
  OrderEntry := TOrderEntry.Create();
  try
    OrderProcessor := TOrderProcessor.Create(OrderValidator, OrderEntry);
    if OrderProcessor.ProcessOrder(Order) then
    begin
      {$IFDEF CONSOLEAPP}
      Writeln('Order successfully processed....');
      {$ENDIF}
    end;
  finally
    Order.Free;
  end;
end;

end.
