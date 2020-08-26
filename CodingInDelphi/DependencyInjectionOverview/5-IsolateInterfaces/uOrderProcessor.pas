unit uOrderProcessor;

interface

uses
  uOrder,
  uOrderInterfaces;

type
  TOrderProcessor = class(TInterfacedObject, IOrderProcessor)
  strict private
    FOrderValidator: IOrderValidator;
    FOrderEntry: IOrderEntry;
  public
    constructor Create(const aOrderValidator: IOrderValidator; const aOrderEntry: IOrderEntry);
    function ProcessOrder(const aOrder: TOrder): Boolean;
  end;

implementation

constructor TOrderProcessor.Create(const aOrderValidator: IOrderValidator; const aOrderEntry: IOrderEntry);
begin
  FOrderValidator := aOrderValidator;
  FOrderEntry := aOrderEntry;
end;

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

end.
