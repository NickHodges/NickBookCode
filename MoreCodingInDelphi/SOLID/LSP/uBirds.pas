unit uBirds;

interface



type
  IBird = interface
    procedure Fly;
    procedure Eat;
  end;

  IFlyable = interface
    procedure Fly;
  end;

  IEater = interface
    procedure Eat;
  end;

  TCrow = class(TInterfacedObject, IFlyable, IEater)
    procedure Fly;
    procedure Eat;
  end;

  TPenguin = class(TInterfacedObject, IEater)
    procedure Fly;
  end;

  procedure BirdStuff;


implementation

uses
      System.SysUtils
    , Spring.Collections
    ;

procedure BirdStuff;
var
  LBird: IBird;
  BirdList: IList<IFlyable>;
begin
  BirdList := TCollections.CreateList<IBird>;
  BirdList.Add(TCrow.Create);

  for LBird in BirdList do
  begin
    LBird.Eat;
    LBird.Fly;  // will raise exception because sub-type is not replaceable for supertype
  end;

end;

{ TCrow }

procedure TCrow.Eat;
begin
  WriteLn('Land on road and pick at roadkill');
end;

procedure TCrow.Fly;
begin
  WriteLn('Fly away slowly');
end;

{ TOstrich }

procedure TOstrich.Eat;
begin
  WriteLn('Peck at the ground looking for food');
end;


end.
