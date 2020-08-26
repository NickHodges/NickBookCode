unit uGameInfo;

interface

type
  TInningHalf = (Top, Bottom);
  TTeam = (Home, Away);

  TInning = record
    Top: integer;
    Bottom: integer;
    constructor Create(aTop, aBottom: integer);
  end;

  TRuns = record
    Home: integer;
    Away: integer;
    constructor Create(aHome, aAway: integer);
  end;

  THits = record
    Home: integer;
    Away: integer;
    constructor Create(aHome, aAway: integer);
  end;

  TErrors = record
    Home: integer;
    Away: integer;
    constructor Create(aHome, aAway: integer);
  end;

  TInningNumber = 1..9;

  TGameInfo = record
    Innings: array[TInningNumber] of TInning;
    Runs: TRuns;
    Hits: THits;
    Errors: TErrors;
    procedure SetInning(aInningNumber: integer; aInningHalf: TInningHalf; aValue: integer);
  end;

implementation

{ TInning }

constructor TInning.Create(aTop, aBottom: integer);
begin
  Top := aTop;
  Bottom := aBottom;
end;

{ TRuns }

constructor TRuns.Create(aHome, aAway: integer);
begin
  Home := aHome;
  Away := aAway;
end;

{ THits }

constructor THits.Create(aHome, aAway: integer);
begin
  Home := aHome;
  Away := aAway;
end;

{ TErrors }

constructor TErrors.Create(aHome, aAway: integer);
begin
  Home := aHome;
  Away := aAway;
end;

{ TGameInfo }

procedure TGameInfo.SetInning(aInningNumber: integer; aInningHalf: TInningHalf; aValue: integer);
begin
  case aInningHalf of
    Top: Innings[aInningNumber].Top := aValue;
    Bottom: Innings[aInningNumber].Bottom := aValue;
  end;
end;

end.
