unit uOrderValidator;

interface

uses
  uOrder;

type
  TOrderValidator = class
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
