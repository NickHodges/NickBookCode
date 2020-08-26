program SpringObserver;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.DesignPatterns,
  uGenericObserver in 'uGenericObserver.pas',
  uGameInfo in 'uGameInfo.pas',
  uGenericDisplays in 'uGenericDisplays.pas';

var
  BaseballGame: TBaseballGame;

begin
  BaseballGame := TBaseballGame.Create;
  BaseballGame.Attach(TConsoleDisplay.Create);


  BaseballGame.SetRuns(TRuns.Create(1, 0));
  BaseballGame.SetHits(THits.Create(2, 0));
  BaseballGame.SetInning(1, TInning.Create(0, 1));
  ReadLn;

  BaseballGame.SetRuns(TRuns.Create(1, 4));
  BaseballGame.SetHits(THits.Create(2, 5));
  BaseballGame.SetErrors(TErrors.Create(0, 1));
  BaseballGame.SetInning(4, TInning.Create(4, 0));
  ReadLn;

end.
