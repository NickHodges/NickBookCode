unit uCoffeeMaker;

interface

type
  ICoffeeMaker = interface
  ['{73436E03-EF65-44F5-9606-F706156CBEB5}']
    procedure MakeCoffee;
  end;

  TCoffeeMaker = class(TInterfacedObject, ICoffeeMaker)
  strict private
    FCoffeeBrand: string;
    FBrewingMinutes: integer;
  public
    constructor Create(const aCoffeeBrand: string; aBrewingMinutes: integer);
    procedure MakeCoffee;
  end;

  TCupCoffeeMaker = class(TInterfacedObject, ICoffeeMaker)
  strict private
    FCupType: string;
  public
    constructor Create(const aCupType: string);
    procedure MakeCoffee;
  end;

implementation

{ TIcedTeaMaker }

constructor TCoffeeMaker.Create(const aCoffeeBrand: string; aBrewingMinutes: integer);
begin
  inherited Create;
  FCoffeeBrand := aCoffeeBrand;
  FBrewingMinutes := aBrewingMinutes;
end;

procedure TCoffeeMaker.MakeCoffee;
begin
  WriteLn('Pour hot water over the ', FCoffeeBrand, ' so that it brews for ', FBrewingMinutes, ' minutes.');
end;

{ TCupCoffeeMaker }

constructor TCupCoffeeMaker.Create(const aCupType: string);
begin
  inherited Create;
  FCupType := aCupType;
end;

procedure TCupCoffeeMaker.MakeCoffee;
begin
  Writeln('Put the ' + FCupType + ' cup in the coffee maker and press the "Brew" button');
end;

end.
