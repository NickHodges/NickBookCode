unit uOrderEntryMock;

interface

uses
  uOrder,
  uOrderInterfaces;

type
  TOrderEntryMock = class(TInterfacedObject, IOrderEntry)
  public
    function EnterOrderIntoDatabase(const aOrder: TOrder): Boolean;
  end;

implementation

function TOrderEntryMock.EnterOrderIntoDatabase(const aOrder: TOrder): Boolean;
begin
  Result := True;
  {$IFDEF CONSOLEAPP}
  Writeln('TOrderEntryMock.EnterOrderIntoDatabase called');
  {$ENDIF}
end;

end.
