unit uRestaurantInterfaces;

interface

// Poorly segregated interface

type
  IRestaurant = interface
  ['{35280CAD-7C1A-4DB7-814C-0412DBD8B2EE}']
    procedure SellFood;
    procedure PayStaff;
    procedure OrderIngredients;
  end;

  // Properly segregated interfaces

  IFoodSeller = interface
  ['{924856A4-D5EF-4BF0-B0FB-22DFE82C14E5}']
    procedure SellFood;
  end;

  IStaffPayer = interface
  ['{39271E04-2B52-4FE3-AE57-0A5AC5DDA905}']
    procedure PayStaff;
  end;

  IIngredientOrderer = interface
  ['{8623B05B-E5CE-4DCC-B0DF-633D4196B23D}']
    procedure OrderIngredients;
  end;


implementation

end.
