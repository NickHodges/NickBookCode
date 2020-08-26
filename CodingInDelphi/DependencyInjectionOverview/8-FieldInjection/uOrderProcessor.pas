unit uOrderProcessor;

interface

uses
  uOrder,
  uOrderInterfaces,
  Spring.Services;

type
  TOrderProcessor = class(TInterfacedObject, IOrderProcessor)
  strict private
    [Inject]
    FOrderValidator: IOrderValidator;
    [Inject]
    FOrderEntry: IOrderEntry;
  public
    function ProcessOrder(const aOrder: TOrder): Boolean;
  end;

implementation

uses
  Spring.Container;

function TOrderProcessor.ProcessOrder(const aOrder: TOrder): Boolean;
var
  OrderIsValid: Boolean;
begin
  Result := False;
  OrderIsValid := FOrderValidator.ValidateOrder(aOrder);
  if OrderIsValid then
  begin
    Result := FOrderEntry.EnterOrderIntoDatabase(aOrder);
  end;

  {$IFDEF CONSOLEAPP}
  Writeln('Order has been processed....');
  {$ENDIF}
end;

initialization
  GlobalContainer.RegisterType<TOrderProcessor>();
end.
