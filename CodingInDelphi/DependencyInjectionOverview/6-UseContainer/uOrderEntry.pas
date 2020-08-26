unit uOrderEntry;

interface

implementation

uses
  uOrder,
  uOrderInterfaces,
  Spring.Container;

type
  // Moving the `TOrderEntry` to the `implementation` section might sound like a smart idea, but it is not:
  // The only way to ever reach `TOrderEntry` reach is through the `GlobalContainer` (using `ServiceLocator`).
  // So you now are coupled to the DI framework which contradicts what we want to do: decoupling.
  // Moving it to the `implementation` section makes writing test cases a lot harder as you have to go through the DI framework.
  TOrderEntry = class(TInterfacedObject, IOrderEntry)
  public
    function EnterOrderIntoDatabase(const aOrder: TOrder): Boolean;
  end;

function TOrderEntry.EnterOrderIntoDatabase(const aOrder: TOrder): Boolean;
begin
  Result := Assigned(aOrder);
  {$IFDEF CONSOLEAPP}
  Writeln('Entering order into the database, at a cost of $1....');
  {$ENDIF}
end;

initialization
  GlobalContainer.RegisterType<TOrderEntry>();
end.