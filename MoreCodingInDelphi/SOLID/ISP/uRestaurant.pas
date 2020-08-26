unit uRestaurant;

interface

uses
      uRestaurantInterfaces
    ;

type
  TRestaurant = class(TInterfacedObject, IRestaurant)
  public
    procedure OrderIngredients;
    procedure PayStaff;
    procedure SellFood;
  end;

  TISPRestaurant = class(TInterfacedObject, IFoodSeller, IStaffPayer, IIngredientOrderer)
  public
    procedure OrderIngredients;
    procedure PayStaff;
    procedure SellFood;
  end;

implementation

procedure TRestaurant.OrderIngredients;
begin
  WriteLn('Order ingredients from the supplier');
end;

procedure TRestaurant.PayStaff;
begin
  WriteLn('Do Payroll and pay staff');
end;

procedure TRestaurant.SellFood;
begin
  WriteLn('Sell food to customers');
end;

{ TISPRestaurant }

procedure TISPRestaurant.OrderIngredients;
begin
  WriteLn('Order ingredients from the supplier');
end;

procedure TISPRestaurant.PayStaff;
begin
  WriteLn('Do Payroll and pay staff');
end;

procedure TISPRestaurant.SellFood;
begin
  WriteLn('Sell food to customers');
end;

end.
