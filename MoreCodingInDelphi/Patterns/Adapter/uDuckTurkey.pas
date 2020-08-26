unit uDuckTurkey;

interface

type
  IDuck = interface
  ['{0A1D56E4-A771-4541-804C-67A58182738D}']
    procedure Quack;
    procedure Fly;
  end;

  TMallardDuck = class(TInterfacedObject, IDuck)
    procedure Quack;
    procedure Fly;
  end;

  ITurkey = interface
  ['{28F40116-3E73-414A-AF11-A11257E3FF25}']
    procedure Gobble;
    procedure Fly;
  end;

  TWildTurkey = class(TInterfacedObject, ITurkey)
    procedure Gobble;
    procedure Fly;
  end;


  TTurkeyAdapter = class(TInterfacedObject, IDuck)
  private
    FTurkey: ITurkey;
  public
    constructor Create(aTurkey: ITurkey);
    procedure Quack;
    procedure Fly;
  end;

implementation

{ TMallardDuck }

procedure TMallardDuck.Fly;
begin
  WriteLn('Flap, flap, flap!  I''m flying!');
end;

procedure TMallardDuck.Quack;
begin
  WriteLn('Quack, Quack!');
end;

{ TWildTurkey }

procedure TWildTurkey.Fly;
begin
  WriteLn('Flap, flap, flap!  I''m flying just a short distance!');
end;

procedure TWildTurkey.Gobble;
begin
 WriteLn('Gobble, gobble, gobble!');
end;

{ TTurkeyAdapter }

constructor TTurkeyAdapter.Create(aTurkey: ITurkey);
begin
  inherited Create;
  FTurkey := aTurkey;
end;

procedure TTurkeyAdapter.Fly;
var
  i: Integer;
begin
  // Fly five times to get as far as a duck does in one
  for i := 1 to 5 do
  begin
    FTurkey.Fly;
  end;
end;

procedure TTurkeyAdapter.Quack;
begin
  FTurkey.Gobble;
end;

end.
