unit uTValueDemo;

interface

uses
       RTTI
     , SysUtils
     ;


procedure DoStuffWithTValue;

implementation

type
  TExampleRecord = record
    SomeInt: integer;
    SomeBytes: array[0..5] of Char;
  end;


procedure DoStuffWithTValue;
var
  V, V2: TValue;
  i: integer;
  ERIn, EROut: TExampleRecord;
  C: Char;
  s: String;
begin
  V := 42;
  WriteLn('V is equal to ', V.AsInteger);
  WriteLn('V can also be a string: ', V.ToString);
  WriteLn('V can even be an extended: ', V.AsExtended);

  WriteLn;
  if V.IsType<string> then
  begin
    WriteLn('V is a string');
  end else
  begin
    WriteLn('V is not a string');
  end;
//
  if V.IsType<integer> then
  begin
    WriteLn('V is an integer');
  end else
  begin
    WriteLn('V is not an integer');
  end;
//
//  try
//    Write('V is an integer, so casting it to an object will raise this exception: ');
//    V.AsObject;
//  except
//    on E: Exception do
//    begin
//      WriteLn(E.Message);
//    end;
//  end;
  //
  // This will not compile
 // i := V;
//  // but this will
//    i := v.AsInteger;
//  // and this will not
//    s := V.AsString;
  //
  // However, you can cast it to a new TValue, and then get the new
  // type that way, as long as they are both type compatible:
  V2 := V.Cast<Byte>;
  WriteLn('V2 is now a Byte: ', V2.ToString);
//
  if V.IsType<Byte> then
  begin
    WriteLn('Yes it is true, V is a Byte');
  end else
  begin
    WriteLn('Oops, V is not a Byte');
  end;
//
  ERIn.SomeInt := 99;
  ERIn.SomeBytes[0] := 'a';
  ERIn.SomeBytes[1] := 'b';
  ERIn.SomeBytes[2] := 'c';
  ERIn.SomeBytes[3] := 'd';
  ERIn.SomeBytes[4] := 'e';
  ERIn.SomeBytes[5] := 'f';
//
//  // We can create our very own type and make it a TValue
  TValue.Make(@ERIn, TypeInfo(TExampleRecord), V2);
//
  if V2.IsType<TExampleRecord> then
  begin
    WriteLn('V2 is a TExampleRecord');
  end else
  begin
    WriteLn('V2 is NOT a TExampleRecord');
  end;

  EROut := V2.AsType<TExampleRecord>;

  WriteLn('EROut.SomeInt = ', EROut.SomeInt);
  Write('And this ought to be the first six letters in the alphabet: ');
  for C in EROut.SomeBytes do
  begin
    Write(C);
  end;
  WriteLn;
end;






end.
