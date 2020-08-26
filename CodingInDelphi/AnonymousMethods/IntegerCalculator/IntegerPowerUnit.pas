{ Copyright (c) 2013 Nick Hodges for CodingInDelphi and Jeroen Wiert Pluimers
for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit IntegerPowerUnit;

interface

function IntegerPower(Left, Right: Integer): Integer;

implementation

function IntegerPower(Left, Right: Integer): Integer;
begin
  if Right = 0 then
  begin
    Result := 1;
  end
  else
  begin
    Result := Left * IntegerPower(Left, Right - 1);
  end;
end;

end.
