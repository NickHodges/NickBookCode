{ Copyright (c) 2013 Nick Hodges for CodingInDelphi and Jeroen Wiert Pluimers
for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit IntegerCalculatorUnit;

interface

uses
  System.Generics.Collections,
  BinaryIntegerOperatorFunctionUnit;

type
  TIntegerCalculator = class
  strict private
//    FBinaryIntegerOperatorFunctions: IDictionary<string, TBinaryIntegerOperatorFunction>;
    FBinaryIntegerOperatorFunctions: TDictionary<string,
        TBinaryIntegerOperatorFunction>;
  strict protected
    procedure RegisterCalculations(); virtual;
  public
    constructor Create();
    procedure RegisterIntegerOperatorFunction(aName: string; aCalculation: TBinaryIntegerOperatorFunction); virtual;
    function Calculate(aName: string; x, y: Integer): Integer; virtual;
    function BinaryIntegerOperatorNames(): string; virtual;
  end;

implementation

uses
  System.Classes;

function TIntegerCalculator.Calculate(aName: string; x, y: Integer): Integer;
begin
  Result := FBinaryIntegerOperatorFunctions[aName](x, y);
end;

constructor TintegerCalculator.Create();
begin
  inherited Create();
//  FBinaryIntegerOperatorFunctions := TCollections.CreateDictionary<string, TBinaryIntegerOperatorFunction>;
  FBinaryIntegerOperatorFunctions := TDictionary<string, TBinaryIntegerOperatorFunction>.Create();
  RegisterCalculations;
end;

function TIntegerCalculator.BinaryIntegerOperatorNames(): string;
var
  OperatorNames: TStrings;
  BinaryIntegerOperatorFunction: TPair<string, TBinaryIntegerOperatorFunction>;
begin
  OperatorNames := TStringList.Create();
  try
    for BinaryIntegerOperatorFunction in FBinaryIntegerOperatorFunctions do
    begin
      OperatorNames.Add(BinaryIntegerOperatorFunction.Key);
    end;
    Result := OperatorNames.CommaText;
  finally
    OperatorNames.Free;
  end;
end;

procedure TIntegerCalculator.RegisterCalculations();
begin
  RegisterIntegerOperatorFunction('Add', function(x, y: Integer): Integer
    begin
      Result := x + y;
    end);

  RegisterIntegerOperatorFunction('Subtract', function(x, y: Integer): Integer
    begin
      Result := x - y;
    end);

  RegisterIntegerOperatorFunction('Multiply', function(x, y: Integer): Integer
    begin
      Result := x * y;
    end);
end;

procedure TIntegerCalculator.RegisterIntegerOperatorFunction(aName: string;  aCalculation: TBinaryIntegerOperatorFunction);
begin
  FBinaryIntegerOperatorFunctions.Add(aName, aCalculation);
end;

end.

