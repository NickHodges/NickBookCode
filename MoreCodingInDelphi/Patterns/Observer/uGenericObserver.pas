unit uGenericObserver;


interface

uses
      Spring.DesignPatterns
    , uGameInfo
    , uGenericDisplays
    , System.SysUtils
    ;

type
  TBaseballGame = class(TObservable<IDisplay>)
  private
    FGameInfo: TGameInfo;
  protected
    procedure DoNotify(const observer: IDisplay); override;
  public
    procedure SetInning(aInningNumber: TInningNumber; aInning: TInning);
    procedure SetRuns(aRuns: TRuns);
    procedure SetHits(aHits: THits);
    procedure SetErrors(aErrors: TErrors);
    property GameInfo: TGameInfo read FGameInfo;
  end;



implementation

{ TBaseballGame }

procedure TBaseballGame.DoNotify(const observer: IDisplay);
begin
  observer.Update(Self.GameInfo);
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
  Notify;
end;


procedure TBaseballGame.SetRuns(aRuns: TRuns);
begin
  FGameInfo.Runs.Home := aRuns.Home;
  FGameInfo.Runs.Away := aRuns.Away;
end;

end.
