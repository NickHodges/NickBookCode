  program ObserverDesignPattern;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uBaseballGame in 'uBaseballGame.pas',
  uObserverPatternInterfaces in 'uObserverPatternInterfaces.pas',
  uBaseballGameDisplays in 'uBaseballGameDisplays.pas',
  uGameInfo in 'uGameInfo.pas';

procedure DoBaseballGame;
var
  BaseballGame: TBaseballGame;
  // Displays
  FullDisplay: IDisplay;
  ScoreDisplay: IDisplay;
  HTMLDisplay: IDisplay;
begin
  BaseballGame := TBaseballGame.Create('Bisons', 'Gazelles');
  try
    FullDisplay := TFullGameDisplay.Create(BaseballGame);
    ScoreDisplay := TGameScore.Create(BaseballGame);
    HTMLDisplay := THTMLOutput.Create(BaseballGame);

    BaseballGame.SetRuns(TRuns.Create(1, 0));
    BaseballGame.SetHits(THits.Create(2, 0));
    BaseballGame.SetInning(1, TInning.Create(0, 1));
    ReadLn;

    BaseballGame.SetRuns(TRuns.Create(1, 4));
    BaseballGame.SetHits(THits.Create(2, 5));
    BaseballGame.SetErrors(TErrors.Create(0, 1));
    BaseballGame.SetInning(4, TInning.Create(4, 0));
    ReadLn;
  finally
    BaseballGame.Free;
  end;
end;

begin
  try
    DoBaseballGame;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
