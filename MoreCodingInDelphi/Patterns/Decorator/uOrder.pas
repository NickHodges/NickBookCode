unit uOrder;

interface

type

  TOrder = class
  private
    FID: integer;
  public
    constructor Create(aID: integer);
    property ID: integer read FID;
  end;

implementation

{ TOrder }

constructor TOrder.Create(aID: integer);
begin
  inherited Create;
  FID := aID;
end;

end.
