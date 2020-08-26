unit uOrderValidator;

interface

uses
  uOrder;

type
  IOrderValidator = interface
    function ValidateOrder(const aOrder: TOrder): Boolean;
  end;

  TOrderValidator = class(TInterfacedObject, IOrderValidator)
  public
    function ValidateOrder(const aOrder: TOrder): Boolean;
  end;

implementation

function TOrderValidator.ValidateOrder(const aOrder: TOrder): Boolean;
begin
  Result := Assigned(aOrder);
  {$IFDEF CONSOLEAPP}
  Writeln('Validating Order....');
  {$ENDIF}
end;

end.
