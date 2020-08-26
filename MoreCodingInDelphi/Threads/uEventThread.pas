unit uEventThread;

interface

uses
      System.Classes
    , System.SyncObjs
    , uSlowCode
    ;

type
  TEventThread = class(TThread)
  private
    FEvent: TEvent;
    FPrimes: integer;
  protected
    procedure Execute; override;
  public
    constructor Create(aEvent: TEvent);
    property Primes: integer read FPrimes;
  end;

implementation

{ TEventThread }

constructor TEventThread.Create(aEvent: TEvent);
begin
  inherited Create(False);
  FEvent := aEvent;
end;

procedure TEventThread.Execute;
var
  UnderNumber: integer;
begin
  UnderNumber := (Random(10) + 15) * 10000;
  FPrimes := PrimesBelow(UnderNumber);
  FEvent.SetEvent;
end;

end.
