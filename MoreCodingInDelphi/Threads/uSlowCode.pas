unit uSlowCode;

interface

uses
      VCL.StdCtrls
    , System.Classes
    ;

function SlowIsPrime(aInteger: integer): Boolean;
function PrimesBelow(aInteger: integer): integer;

procedure  PrimeBelowReportToMemo(aMemo: TMemo; aInteger: integer; aSleepTime: integer);

function PrimesBelowParallel(aInteger: integer): integer;

implementation

uses
      System.Threading
    , System.SyncObjs
    , System.SysUtils
    ;

// An incredibly inefficient way to calculate primes
// And it gets slower the bigger the input is.
function SlowIsPrime(aInteger: integer): Boolean;
var
  i: Integer;
begin
  Assert (aInteger > 0);
  // Remember, 1 is not prime.
  if aInteger = 1 then
  begin
    Result := False;
    Exit;
  end;
  Result := True;
  for i := 2 to aInteger - 1 do
  begin
    if aInteger mod i = 0 then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

function PrimesBelow(aInteger: integer): integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to aInteger do
  begin
    if SlowIsPrime(i) then
    begin
      Result := Result + 1;
    end;
  end;
end;

function PrimesBelowParallel(aInteger: integer): integer;
var
  Temp: integer;
begin
  Temp := 0;
  TParallel.For(1, aInteger, procedure(aIndex: integer)
                           begin
                             if SlowIsPrime(aIndex) then
                             begin
                               TInterlocked.Increment(Temp);
                             end;
                           end);
  Result := Temp;

end;

procedure  PrimeBelowReportToMemo(aMemo: TMemo; aInteger: integer; aSleepTime: integer);
var
  i: Integer;
begin
  for i := 1 to aInteger do
  begin
    if SlowIsPrime(i) then
    begin
      Sleep(aSleepTime);
      TThread.Synchronize(TThread.CurrentThread, procedure
                                                 begin
                                                   aMemo.Lines.Add(i.ToString);
                                                 end);
    end;
  end;
end;


end.
