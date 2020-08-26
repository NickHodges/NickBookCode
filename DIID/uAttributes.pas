unit uAttributes;

interface

uses
      Spring
    , Spring.Container
    , Spring.Container.Common
    ;

type

  IHorse = interface
  ['{BDBB0FE7-D369-4EC7-B2A0-FC012136B87E}']
    procedure Ride;
  end;

  ICowboy = interface
  ['{337002BB-2219-46A2-BF28-5CFD8A6873AD}']
    procedure SetHorse(aValue: IHorse);
    function GetHorse: IHorse;
    procedure DoCowboyStuff;
    property Horse: IHorse read GetHorse write SetHorse;
  end;

  THorse = class(TInterfacedObject, IHorse)
  public
    procedure Ride;
  end;

  TCowboy = class(TInterfacedObject, ICowboy)
  private
    FHorse: IHorse;
    procedure SetHorse(aValue: IHorse);
    function GetHorse: IHorse;
  public
    procedure DoCowboyStuff;
    [Inject]
    property Horse: IHorse read GetHorse write SetHorse;

  end;

procedure BeACowboy;


implementation

procedure BeACowboy;
var
  Cowboy: ICowboy;
begin
  Cowboy := GlobalContainer.Resolve<ICowboy>;
  Cowboy.DoCowboyStuff;
end;

{ TCowboy }

procedure TCowboy.DoCowboyStuff;
begin
  Writeln('Yippee Kay Yay!');
  Horse.Ride;
end;

function TCowboy.GetHorse: IHorse;
begin
  Result := FHorse;
end;

procedure TCowboy.SetHorse(aValue: IHorse);
begin
  FHorse := aValue;
end;

{ THorse }

procedure THorse.Ride;
begin
  Writeln('Gallop along the prairie!');
end;

end.
