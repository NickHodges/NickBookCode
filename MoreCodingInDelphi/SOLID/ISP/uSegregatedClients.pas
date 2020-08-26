unit uSegregatedClients;

interface

uses
      uRestaurantInterfaces
    ;

type
  TFoodSeller = class(TInterfacedObject, IFoodSeller)
  public
    procedure SellFood;
  end;

  TStaffPayer = class(TInterfacedObject, IStaffPayer)
  public
    procedure PayStaff;
  end;

  TIngredientOrderer = class(TInterfacedObject, IIngredientOrderer)
  public
    procedure OrderIngredients;
  end;

implementation

{ TFoodSeller }

procedure TFoodSeller.SellFood;
begin
  WriteLn('Selling food to customers');
end;

{ TStaffPayer }

procedure TStaffPayer.PayStaff;
begin
  WriteLn('Do payroll and pay staff');
end;

{ TIngredientOrderer }

procedure TIngredientOrderer.OrderIngredients;
begin
  WriteLn('Order ingredients for our fine menu');
end;

end.
