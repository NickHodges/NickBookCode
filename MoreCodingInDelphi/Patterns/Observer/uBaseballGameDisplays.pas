unit uBaseballGameDisplays;

interface

uses
      uObserverPatternInterfaces
    , uBaseballGame
    , uGameInfo
    ;

type

  TBaseballGameDisplay = class(TInterfacedObject, IObserver, IDisplay)
  private
    FSubject: TBaseballGame;
  public
    constructor Create(aBaseballGame: TBaseballGame);
    destructor Destroy; override;
    procedure Update(aGameInfo: TGameInfo); virtual;
    procedure Display; virtual; abstract;
  end;

  TFullGameDisplay = class(TBaseballGameDisplay)
    procedure Display; override;
  end;

  TGameScore = class(TBaseballGameDisplay)
    procedure Display; override;
  end;

  THTMLOutput = class(TBaseballGameDisplay)
    procedure Display; override;
  end;


implementation

uses
      System.SysUtils
    ;

{ TFullGameDisplay }

procedure TFullGameDisplay.Display;
var
  i: Integer;
begin
  WriteLn('1 2 3 4 5 6 7 8 9  R H E');
  WriteLn('------------------------');
  for i := Low(TInningNumber) to High(TInningNumber) do
  begin
    Write(FSubject.GameInfo.Innings[i].Top, ' ');
  end;
  WriteLn(' ', FSubject.GameInfo.Runs.Away, ' ', FSubject.GameInfo.Hits.Away, ' ', FSubject.GameInfo.Errors.Away);

  for i := Low(TInningNumber) to High(TInningNumber) do
  begin
    Write(FSubject.GameInfo.Innings[i].Bottom, ' ');
  end;
  WriteLn(' ', FSubject.GameInfo.Runs.Home, ' ', FSubject.GameInfo.Hits.Home, ' ', FSubject.GameInfo.Errors.Home);

end;

{ TBaseballGameDisplay }

constructor TBaseballGameDisplay.Create(aBaseballGame: TBaseballGame);
begin
  inherited Create;
  if aBaseballGame = nil  then
  begin
    raise Exception.Create('You cannot pass a nil baseball game');
  end;
  FSubject := aBaseballGame;
  FSubject.RegisterObserver(Self);
end;

destructor TBaseballGameDisplay.Destroy;
begin
  FSubject.RemoveObserver(Self);
  inherited;
end;

procedure TBaseballGameDisplay.Update(aGameInfo: TGameInfo);
begin
  FSubject.GameInfo := aGameInfo;
  Display;
end;

{ TGameScore }

procedure TGameScore.Display;
begin
  WriteLn;
  WriteLn(FSubject.AwayTeam, ': ', FSubject.GameInfo.Runs.Away);
  WriteLn(FSubject.HomeTeam, ': ', FSubject.GameInfo.Runs.Home);
  WriteLn;
end;

{ THTMLOutput }

procedure THTMLOutput.Display;
begin
  Writeln('An HTML output here is beyond the scope of the demo, but you can imagine it, right?');
end;

end.
