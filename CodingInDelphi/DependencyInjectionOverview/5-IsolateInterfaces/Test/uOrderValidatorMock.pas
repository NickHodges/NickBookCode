unit uOrderValidatorMock;

interface

uses
  uOrder,
  uOrderInterfaces;

type
  TOrderValidatorMock = class(TInterfacedObject, IOrderValidator)
  public
    function ValidateOrder(const aOrder: TOrder): Boolean;
  end;

implementation

function TOrderValidatorMock.ValidateOrder(const aOrder: TOrder): Boolean;
begin
  Result := True;
  {$IFDEF CONSOLEAPP}
  Writeln('TOrderValidatorMock.ValidateOrder called');
  {$ENDIF}
end;

end.
