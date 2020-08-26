unit uPublicPerformance;

interface

uses
      Spring.Collections
    ;

type
  TEvent = class abstract;
    // Circus
    TParade = class(TEvent);
    TTrapezeAct = class(TEvent);
    THighWireAct = class(TEvent);
    TClownAct = class(TEvent);
    // Stage Play
    TFirstAct = class(TEvent);
    TIntermission = class(TEvent);
    TSecondAct = class(TEvent);
    TClimax = class(TEvent);
    TCurtainCall = class(TEvent);

  TPublicPerformance = class abstract
  private
    FEvents: IList<TEvent>;
  public
    constructor Create;
    destructor Destroy; override;
    // Factory Method
    procedure CreateEvents; virtual; abstract;
    property Events: IList<TEvent> read FEvents;
  end;

  TCircus = class(TPublicPerformance)
  public
    procedure CreateEvents; override;
  end;

  TStagePlay = class(TPublicPerformance)
  public
    procedure CreateEvents; override;
  end;

procedure DoIt;

implementation

procedure DoIt;
var
  Event: TEvent;
  PublicPerformance: TPublicPerformance;
  PublicPerformances: array[0..1] of TPublicPerformance;
begin
  PublicPerformances[0] := TCircus.Create;
  PublicPerformances[1] := TStagePlay.Create;
  try
    for PublicPerformance in PublicPerformances do
    begin
      WriteLn(PublicPerformance.ClassName, '----');
      for Event in PublicPerformance.Events do
      begin
        WriteLn('  ', Event.ClassName);
      end;
      WriteLn;
    end;
  finally
    PublicPerformances[0].Free;
    PublicPerformances[1].Free;
  end;

end;

constructor TPublicPerformance.Create;
begin
  inherited Create;
  FEvents := TCollections.CreateList<TEvent>;
  CreateEvents;
end;

procedure TCircus.CreateEvents;
begin
  FEvents.Add(TParade.Create);
  FEvents.Add(TTrapezeAct.Create);
  FEvents.Add(THighWireAct.Create);
  FEvents.Add(TClownAct.Create);
end;

procedure TStagePlay.CreateEvents;
begin
  FEvents.Add(TFirstAct.Create);
  FEvents.Add(TIntermission.Create);
  FEvents.Add(TSecondAct.Create);
  FEvents.Add(TClimax.Create);
  FEvents.Add(TCurtainCall.Create);
end;

destructor TPublicPerformance.Destroy;
var
  Event: TEvent;
begin
  for Event in FEvents do
  begin
    Event.Free;
  end;

  inherited;
end;

end.
