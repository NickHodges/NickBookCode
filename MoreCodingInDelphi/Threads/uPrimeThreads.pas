unit uPrimeThreads;

interface

uses
      System.Classes
    , VCL.StdCtrls
    ;

type
  TPrimeThread = class(TThread)
  strict private
    FMemo: TMemo;
    FSleepTime: integer;
  public
    constructor Create(aMemo: TMemo; aSleepTime: integer);
    procedure Execute; override;
  end;

implementation

uses
      uSlowCode
    ;

{ TSlowPrimeThread }

constructor TPrimeThread.Create(aMemo: TMemo; aSleepTime: integer);
begin
  inherited Create(False);
  FMemo := aMemo;
  FSleepTime := aSleepTime;
  FreeOnTerminate := True;
end;

procedure TPrimeThread.Execute;
begin
  PrimeBelowReportToMemo(FMemo, 2000, FSleepTime); // Fast
end;

end.
