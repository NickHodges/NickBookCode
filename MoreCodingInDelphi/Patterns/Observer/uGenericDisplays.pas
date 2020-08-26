unit uGenericDisplays;

interface

uses
      uGameInfo
    ;

type

  IDisplay = interface
  ['{E118BD99-37BD-461C-AF69-770FD8E18702}']
    procedure Update(aGameInfo: TGameInfo);
  end;

  TConsoleDisplay = class(TInterfacedObject, IDisplay)
    procedure Update(aGameInfo: TGameInfo);
  end;

implementation

{ TDisplay }

procedure TConsoleDisplay.Update(aGameInfo: TGameInfo);
var
  i: Integer;
begin
  WriteLn('1 2 3 4 5 6 7 8 9  R H E');
  WriteLn('------------------------');
  for i := Low(TInningNumber) to High(TInningNumber) do
  begin
    Write(aGameInfo.Innings[i].Top, ' ');
  end;
  WriteLn(' ', aGameInfo.Runs.Away, ' ', aGameInfo.Hits.Away, ' ', aGameInfo.Errors.Away);

  for i := Low(TInningNumber) to High(TInningNumber) do
  begin
    Write(aGameInfo.Innings[i].Bottom, ' ');
  end;
  WriteLn(' ', aGameInfo.Runs.Home, ' ', aGameInfo.Hits.Home, ' ', aGameInfo.Errors.Home);

end;

end.
