unit uOrderProcessor;

interface

uses
   uOrder,
   uOrderEntry,
   uOrderValidator;

type
  IOrderProcessor = interface
    function ProcessOrder(const aOrder: TOrder): Boolean;
  end;

  TOrderProcessor = class(TInterfacedObject, IOrderProcessor)
  strict private
    FOrderValidator: IOrderValidator;
    FOrderEntry: IOrderEntry;
  public
    constructor Create;
    function ProcessOrder(const aOrder: TOrder): Boolean;
  end;

implementation

constructor TOrderProcessor.Create();
begin
  FOrderValidator := TOrderValidator.Create();
  FOrderEntry := TOrderEntry.Create();
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
