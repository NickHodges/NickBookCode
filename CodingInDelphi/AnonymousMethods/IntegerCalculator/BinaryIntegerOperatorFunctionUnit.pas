{ Copyright (c) 2013 Nick Hodges for CodingInDelphi and Jeroen Wiert Pluimers
for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit BinaryIntegerOperatorFunctionUnit;

interface

uses
  System.SysUtils;

type
{$ifdef useReferenceToFunction}
  TBinaryIntegerOperatorFunction = reference to function(const Left, Right: Integer): Integer;
{$else}
  TBinaryIntegerOperatorFunction = TFunc<Integer, Integer, Integer>;
{$endif useReferenceToFunction}

implementation

end.
