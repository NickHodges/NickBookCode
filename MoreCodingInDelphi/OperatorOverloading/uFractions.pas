unit uFractions;

interface

uses
  System.SysUtils;

type
  TFraction = record
  strict private
    FNumerator: Integer;
    FDenominator: Integer;
    class function GCD(a, b: Integer): Integer; static;
    function Reduced: TFraction;
  public
    class function CreateFrom(aNumerator: Integer; aDenominator: Integer): TFraction; static;
    function ToString: string;

    property Numerator: Integer read FNumerator;
    property Denominator: Integer read FDenominator;

    class operator Add(const Left, Right: TFraction): TFraction;
    class operator Add(const Left: TFraction; const Right: double): double;

    class operator Subtract(const Left, Right: TFraction): TFraction;
    class operator Subtract(const Left: TFraction; const Right: Integer): TFraction;
    class operator Subtract(const Left: Integer; const Right: TFraction): TFraction;
    class operator Multiply(const Left, Right: TFraction): TFraction;
    class operator Multiply(const Left: TFraction; const Right: Integer): TFraction;
    class operator Multiply(const Left: Integer; const Right: TFraction): TFraction;
    class operator Divide(const Left, Right: TFraction): TFraction;
    class operator Divide(const Left: TFraction; const Right: Integer): TFraction;
    class operator Divide(const Left: Integer; const Right: TFraction): TFraction;
    class operator Positive(const AValue: TFraction): TFraction;
    class operator Negative(const AValue: TFraction): TFraction;

    class operator Equal(const Left, Right: TFraction): Boolean;
    class operator NotEqual(const Left, Right: TFraction): Boolean;

    class operator LessThan(const Left, Right: TFraction): Boolean;
    class operator GreaterThan(const Left, Right: TFraction): Boolean;

    class operator LessThanOrEqual(const Left, Right: TFraction): Boolean;
    class operator GreaterThanOrEqual(const Left, Right: TFraction): Boolean;

    class operator Implicit(const aValue: Integer): TFraction;
    class operator Implicit(const aValue: TFraction): Double;
    class operator Explicit(const aValue: TFraction): string;
  end;

implementation

{ TFraction }

class function TFraction.GCD(a, b: Integer): Integer;
var
  rem: Integer;
begin
  rem := a mod b;
  if rem <> 0 then
    Result := GCD(b, rem)
  else
    Result := b;
end;

function TFraction.Reduced: TFraction;
var
  LGCD: Integer;
begin
  LGCD := GCD(Numerator, Denominator);
  Result := CreateFrom(Numerator div LGCD, Denominator div LGCD);
end;

class operator TFraction.Add(const Left: TFraction; const Right: double): double;
var
  LDouble: Double;
begin
  LDouble := Left;
  Result := LDouble + Right;
end;

class function TFraction.CreateFrom(aNumerator, aDenominator: Integer): TFraction;
begin
  if aDenominator = 0 then
  begin
    raise EZeroDivide.CreateFmt('Invalid fraction %d/%d, numerator cannot be zero', [aNumerator, aDenominator]);
  end;

  if (aDenominator < 0) then
  begin
    Result.FNumerator := -aNumerator;
    Result.FDenominator := -aDenominator;
  end else
  begin
    Result.FNumerator := aNumerator;
    Result.FDenominator := aDenominator;
  end;

  Assert(Result.Denominator > 0); // needed for comparisons
end;

function TFraction.ToString: string;
begin
  Result := Format('%d/%d', [Numerator, Denominator]);
end;

class operator TFraction.Add(const Left, Right: TFraction): TFraction;
begin
  Result := CreateFrom(Left.Numerator * Right.Denominator + Left.Denominator * Right.Numerator, Left.Denominator * Right.Denominator).Reduced;
end;

class operator TFraction.Subtract(const Left, Right: TFraction): TFraction;
begin
  Result := Left + (-Right);
end;

class operator TFraction.Subtract(const Left: TFraction; const Right: Integer): TFraction;
begin

  // Needed because the implicit Double coversion    won't allow: Result := Left + (-Right);
  Result := Left + TFraction.CreateFrom(-Right, 1);
end;

class operator TFraction.Subtract(const Left: Integer; const Right: TFraction): TFraction;
begin
  Result := Left + (-Right);
end;

class operator TFraction.Multiply(const Left, Right: TFraction): TFraction;
begin
  Result := CreateFrom(Left.Numerator * Right.Numerator, Left.Denominator*Right.Denominator).Reduced;
end;

class operator TFraction.Multiply(const Left: TFraction; const Right: Integer): TFraction;
begin
  Result := CreateFrom(Left.Numerator * Right, Left.Denominator).Reduced;
end;

class operator TFraction.Multiply(const Left: Integer; const Right: TFraction): TFraction;
begin
  Result := CreateFrom(Left * Right.Numerator, Right.Denominator).Reduced;
end;

class operator TFraction.Divide(const Left, Right: TFraction): TFraction;
begin
  Result := CreateFrom(Left.Numerator * Right.Denominator, Left.Denominator*Right.Numerator).Reduced;
end;

class operator TFraction.Divide(const Left: TFraction; const Right: Integer): TFraction;
begin
  Result := CreateFrom(Left.Numerator, Left.Denominator * Right).Reduced;
end;

class operator TFraction.Divide(const Left: Integer; const Right: TFraction): TFraction;
begin
  Result := CreateFrom(Left * Right.Denominator, Right.Numerator).Reduced;
end;

class operator TFraction.Positive(const AValue: TFraction): TFraction;
begin
  Result := AValue;
end;

class operator TFraction.Negative(const AValue: TFraction): TFraction;
begin
  Result := CreateFrom(-aValue.Numerator, AValue.Denominator);
end;

class operator TFraction.Equal(const Left, Right: TFraction): Boolean;
begin
  Result := Left.Numerator * Right.Denominator = Right.Numerator * Left.Denominator;
end;

class operator TFraction.Explicit(const aValue: TFraction): string;
begin
  Result := aValue.ToString;
end;

class operator TFraction.NotEqual(const Left, Right: TFraction): Boolean;
begin
  Result := not (Left = Right);
end;

class operator TFraction.LessThan(const Left, Right: TFraction): Boolean;
begin
  Result := Left.Numerator * Right.Denominator < Right.Numerator * Left.Denominator;
end;

class operator TFraction.GreaterThan(const Left, Right: TFraction): Boolean;
begin
  Result := Left.Numerator*Right.Denominator > Right.Numerator*Left.Denominator;
end;

class operator TFraction.LessThanOrEqual(const Left, Right: TFraction): Boolean;
begin
  Result := (Left < Right) or (Left = Right);
end;

class operator TFraction.GreaterThanOrEqual(const Left, Right: TFraction): Boolean;
begin
  Result := (Left = Right) or (Left > Right);
end;

class operator TFraction.Implicit(const AValue: Integer): TFraction;
begin
  Result := TFraction.CreateFrom(aValue, 1);
end;

class operator TFraction.Implicit(const aValue: TFraction): Double;
begin
  Result := aValue.Numerator/aValue.Denominator;
end;

end.
