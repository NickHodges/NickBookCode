unit uOrderValidator;

interface

uses
  uOrder,
  uOrderInterfaces;

type
  TOrderValidator = class(TInterfacedObject, IOrderValidator)
  public
    function ValidateOrder(const aOrder: TOrder): Boolean;
  end;

implementation

uses
  Spring.Container;

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
