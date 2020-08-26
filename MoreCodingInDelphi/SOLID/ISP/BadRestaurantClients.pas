unit BadRestaurantClients;

interface

uses
      uRestaurantInterfaces
    ;

type
  TRestaurantManager = class
  private
    FRestaurant: IRestaurant;
  public
    constructor Create(aRestaurant: IRestaurant);
    procedure DoPayroll;
    procedure SellFood;
    procedure BuySupplies;
  end;

  TFoodSeller = class
  private
    FRestaurant: IRestaurant;
  public
    constructor Create(aRestaurant: IRestaurant);
    procedure SellFood;
  end;


implementation


{ TRestaurantManager }

procedure TRestaurantManager.BuySupplies;
begin
  FRestaurant.OrderIngredients;
end;

constructor TRestaurantManager.Create(aRestaurant: IRestaurant);
begin
  inherited Create;
  FRestaurant := aRestaurant;
end;

procedure TRestaurantManager.DoPayroll;
begin
  FRestaurant.PayStaff;
end;

procedure TRestaurantManager.SellFood;
begin
  FRestaurant.SellFood;
end;

{ TFoodOrderingManager }

constructor TFoodSeller.Create(aRestaurant: IRestaurant);
begin
  inherited Create;
  FRestaurant  := aRestaurant
end;

procedure TFoodSeller.SellFood;
begin
  FRestaurant.SellFood;
end;

end.
