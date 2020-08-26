  unit uBaseballGame;

interface

uses    uObserverPatternInterfaces
      , Generics.Collections
      , uGameInfo
      ;

type
  TBaseballGame = class(TInterfacedObject, ISubject)
  private
    FHomeTeam: string;
    FAwayTeam: string;
    FGameInfo: TGameInfo;
    FObserverList: TList<IObserver>;
    procedure NotifyObservers;
    procedure GameChanged;
  public
    constructor Create(aHomeTeam: string; aAwayTeam: string);
    destructor Destroy; override;
    procedure RegisterObserver(aObserver: IObserver);
    procedure RemoveObserver(aObserver: IObserver);
    procedure SetInning(aInningNumber: TInningNumber; aInning: TInning);
    procedure SetRuns(aRuns: TRuns);
    procedure SetHits(aHits: THits);
    procedure SetErrors(aErrors: TErrors);

    property GameInfo: TGameInfo read FGameInfo write FGameInfo;
    property HomeTeam: string read FHomeTeam;
    property AwayTeam: string read FAwayTeam;
  end;

implementation

{ TBaseballGame }

constructor TBaseballGame.Create(aHomeTeam: string; aAwayTeam: string);
begin
  inherited Create;
  FObserverList := TList<IObserver>.Create;
  FHomeTeam := aHomeTeam;
  FAwayTeam := aAwayTeam;
end;

destructor TBaseballGame.Destroy;
begin
  FObserverList.Free;
  inherited;
end;

procedure TBaseballGame.GameChanged;
begin
  NotifyObservers;
end;

procedure TBaseballGame.NotifyObservers;
var
  Observer: IObserver;
begin
  for Observer in FObserverList do
  begin
    Observer.Update(GameInfo);
  end;
end;

procedure TBaseballGame.RegisterObserver(aObserver: IObserver);
begin
  FObserverList.Add(aObserver);
end;

procedure TBaseballGame.RemoveObserver(aObserver: IObserver);
begin
  FObserverList.Remove(aObserver);
end;

procedure TBaseballGame.SetErrors(aErrors: TErrors);
begin
  FGameInfo.Errors.Home := aErrors.Home;
  FGameInfo.Errors.Away := aErrors.Away;
end;

procedure TBaseballGame.SetHits(aHits: THits);
begin
  FGameInfo.Hits.Home := aHits.Home;
  FGameInfo.Hits.Away := aHits.Away;
end;

procedure TBaseballGame.SetInning(aInningNumber: TInningNumber; aInning: TInning);
begin
  FGameInfo.Innings[aInningNumber].Top := aInning.Top;
  FGameInfo.Innings[aInningNumber].Bottom := aInning.Bottom;
  GameChanged;
end;

procedure TBaseballGame.SetRuns(aRuns: TRuns);
begin
  FGameInfo.Runs.Home := aRuns.Home;
  FGameInfo.Runs.Away := aRuns.Away;
end;

end.
