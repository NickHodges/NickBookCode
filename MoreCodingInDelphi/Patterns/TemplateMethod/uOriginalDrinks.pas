unit uOriginalDrinks;

interface

type
  TCoffee = class
  public
    procedure PrepareCoffee;

    procedure BoilWater;
    procedure BrewCoffeeGrinds;
    procedure PourInCup;
    procedure AddSugarAndMilk;
  end;

  TTea = class
  public
    procedure PrepareRecipe;

    procedure BoilWater;
    procedure SteepTeaBag;
    procedure AddLemon;
    procedure PourInCup;
  end;

implementation

{ TOriginalCoffee }

procedure TCoffee.AddSugarAndMilk;
begin
  WriteLn('Adding sugar and milk...');
end;

procedure TCoffee.BoilWater;
begin
  WriteLn('Boiling water...');
end;

procedure TCoffee.BrewCoffeeGrinds;
begin
  WriteLn('Brewing coffee grinds...');
end;

procedure TCoffee.PourInCup;
begin
  WriteLn('Pouring in Cup...');
end;

procedure TCoffee.PrepareCoffee;
begin
  BoilWater;
  BrewCoffeeGrinds;
  PourInCup;
  AddSugarAndMilk;
end;


{ TTea }

procedure TTea.AddLemon;
begin
  WriteLn('Adding Lemon...');
end;

procedure TTea.BoilWater;
begin
  WriteLn('Boiling water...');
end;

procedure TTea.PourInCup;
begin
  WriteLn('Pouring in cup...');
end;

procedure TTea.PrepareRecipe;
begin
  BoilWater;
  SteepTeaBag;
  PourInCup;
  AddLemon;
end;

procedure TTea.SteepTeaBag;
begin
  WriteLn('Steeping tea bag...');
end;

end.
