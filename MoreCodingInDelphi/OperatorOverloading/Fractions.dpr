program Fractions;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uFractions in 'uFractions.pas';

procedure Main;
var
  A, B, C, D: TFraction;
  S: string;
  Dub: Double;
begin
  A := TFraction.CreateFrom(2, 6);
  B := TFraction.CreateFrom(4, 18);
  C := A + B;
  S := C.ToString;
  WriteLn(S);

  C := TFraction.CreateFrom(7, 12);
  D := -C;
  S := string(D);
  WriteLn(S);

  A := TFraction.CreateFrom(-2, -6);
  B := TFraction.CreateFrom(-4, -18);
  C := A + B;
  S := C.ToString;
  WriteLn(S);

  A := TFraction.CreateFrom(1, 2);
  B := TFraction.CreateFrom(2, 4);
  if A = B then
  begin
    WriteLn('Equal');
  end else
  begin
    WriteLn('Equality check failed');
  end;

  A := TFraction.CreateFrom(1, 2);
  B := TFraction.CreateFrom(2, 5);
  if A <> B then
  begin
    WriteLn('Not Equal');
  end else
  begin
    WriteLn('Inequality check failed');
  end;

  A := TFraction.CreateFrom(1, 3);
  B := TFraction.CreateFrom(1, 2);
  if A < B then
  begin
    WriteLn('Less Than');
  end else
  begin
    WriteLn('Less than check failed');
  end;

  A := TFraction.CreateFrom(1, 3);
  B := TFraction.CreateFrom(1, 100);
  if A > B then
  begin
    WriteLn('Greater Than');
  end else
  begin
    WriteLn('Greater than check failed');
  end;

  A := TFraction.CreateFrom(1, 2);
  B := TFraction.CreateFrom(1, 2);
  if A <= B then
  begin
    WriteLn('Less than or equal to when equal');
  end else
  begin
    WriteLn('Less than or equal to check failed when equal');
  end;

  A := TFraction.CreateFrom(1, 2);
  B := TFraction.CreateFrom(1, 2);
  if A >= B then
  begin
    WriteLn('Greater than or equal to when equal');
  end else
  begin
    WriteLn('Greater than or equal to check failed when equal');
  end;

  A := TFraction.CreateFrom(1, 3);
  B := TFraction.CreateFrom(1, 2);
  if A <= B then
  begin
    WriteLn('Less than or equal to when not equal');
  end else
  begin
    WriteLn('Less than or equal to check failed when not equal');
  end;

  A := TFraction.CreateFrom(1, 2);
  B := TFraction.CreateFrom(1, 3);
  if A >= B then
  begin
    WriteLn('Greater than or equal to when not equal');
  end else
  begin
    WriteLn('Greater than or equal to check failed when not equal');
  end;

  A := TFraction.CreateFrom(1, 2);
  Dub := A;
  if Dub = 0.5 then
  begin
    WriteLn('Double conversion');
  end else
  begin
    WriteLn('Double conversion failed');
  end;
end;

begin
  try
    Main;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
