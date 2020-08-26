unit uCalculator;

interface

type
  TCalculator = class
    function Add(x, y: integer): integer;
  end;

implementation

{ TCalculator }

function TCalculator.Add(x, y: integer): integer;
begin
  Result := x + y;
end;

end.
