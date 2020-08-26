unit uOrderValidator;

interface

implementation

uses
  uOrder,
  uOrderInterfaces,
  Spring.Container;

type
  // Moving the `TOrderValidator` to the `implementation` section might sound like a smart idea, but it is not:
  // The only way to ever reach `TOrderValidator` reach is through the `GlobalContainer` (using `ServiceLocator`).
  // So you now are coupled to the DI framework which contradicts what we want to do: decoupling.
  // Moving it to the `implementation` section makes writing test cases a lot harder as you have to go through the DI framework.
  TOrderValidator = class(TInterfacedObject, IOrderValidator)
  public
    function ValidateOrder(const aOrder: TOrder): Boolean;
  end;

function TOrderValidator.ValidateOrder(const aOrder: TOrder): Boolean;
begin
  Result := Assigned(aOrder);
  {$IFDEF CONSOLEAPP}
  Writeln('Validating Order....');
  {$ENDIF}
end;

initialization
  GlobalContainer.RegisterType<TOrderValidator>();
end.
