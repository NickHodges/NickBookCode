unit uPizzaShackPizza;

interface

type
  TPizza = class
  private
    FDescription: string;
  protected
    function GetDescription: string;  virtual;
    procedure SetDescription(const Value: string);
  public
    function Cost: Currency; virtual; abstract;
    property Description: string read GetDescription write SetDescription;
  end;

  TPizzaDecorator = class(TPizza)
  private
    FPizza: TPizza;
  public
    constructor Create(aPizza: TPizza);
    destructor Destroy; override;
  end;

  TParmesanCheesePizza = class(TPizza)
    constructor Create;
    function Cost: Currency; override;
  end;

  TMozarellaCheesePizza = class(TPizza)
    constructor Create;
    function Cost: Currency; override;
  end;

  TPepperoni = class(TPizzaDecorator)
  protected
    function GetDescription: string; override;
  public
    function Cost: Currency; override;
  end;

  TSausage = class(TPizzaDecorator)
  protected
    function GetDescription: string; override;
  public
    function Cost: Currency; override;
  end;

  TBlackOlives = class(TPizzaDecorator)
  protected
    function GetDescription: string; override;
  public
    function Cost: Currency; override;
  end;

  TOnions = class(TPizzaDecorator)
  protected
    function GetDescription: string; override;
  public
    function Cost: Currency; override;
  end;


implementation

{ TPizza }

function TPizza.GetDescription: string;
begin
  Result := FDescription;
end;

procedure TPizza.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

{ TParmesanCheesePizza }

function TParmesanCheesePizza.Cost: Currency;
begin
  Result := 7.99
end;

constructor TParmesanCheesePizza.Create;
begin
  inherited Create;
  FDescription := 'Parmesan Cheese Pizza';
end;

{ TMozarellaCheesePizza }

function TMozarellaCheesePizza.Cost: Currency;
begin
  Result := 6.99;
end;

constructor TMozarellaCheesePizza.Create;
begin
  inherited Create;
  FDescription := 'Mozarella Cheese Pizza';
end;

{ TPepperoni }

function TPepperoni.Cost: Currency  ;
begin
  Result := 1.20 + FPizza.Cost;
end;

function TPepperoni.GetDescription: string;
begin
  Result := FPizza.GetDescription + ', Pepperoni';
end;


{ TSausage }

function TSausage.Cost: Currency;
begin
  Result := 0.95 + FPizza.Cost;
end;

function TSausage.GetDescription: string;
begin
  Result := FPizza.GetDescription + ', Sausage';
end;

{ TPizzaDecorator }

constructor TPizzaDecorator.Create(aPizza: TPizza);
begin
  inherited Create;
  FPizza := aPizza;
end;

destructor TPizzaDecorator.Destroy;
begin
  FPizza.Free;
  inherited;
end;

{ TBlackOlives }

function TBlackOlives.Cost: Currency;
begin
  Result := FPizza.Cost + 0.85;
end;

function TBlackOlives.GetDescription: string;
begin
  Result := FPizza.GetDescription + ', Black Olives';
end;

{ TOnions }

function TOnions.Cost: Currency;
begin
  Result := FPizza.Cost + 0.50;
end;

function TOnions.GetDescription: string;
begin
  Result := FPizza.GetDescription + ', Onions';
end;

end.
