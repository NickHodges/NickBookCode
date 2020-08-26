unit uPropertyInjectionMultiple;

interface

type

  TRecipe = class
  private
    FText: string;
  public
    property Text: string read FText write FText;
  end;

  IFoodPreparer = interface
  ['{3900BE64-B0EC-4281-9D92-96B191FDE5BC}']
    procedure PrepareFood(aRecipe: TRecipe);
  end;

  TBaker = class(TInterfacedObject, IFoodPreparer)
    procedure PrepareFood(aRecipe: TRecipe);
  end;

  TShortOrderCook = class(TInterfacedObject, IFoodPreparer)
    procedure PrepareFood(aRecipe: TRecipe);
  end;

  TChef = class(TInterfacedObject, IFoodPreparer)
    procedure PrepareFood(aRecipe: TRecipe);
  end;

  TRestaurant = class
  private
    FName: string;
  public
    constructor Create(const aName: string);
    procedure PrepareFood(aRecipe: TRecipe; aPreparer: IFoodPreparer);
    property name: string read FName;
  end;

implementation

constructor TRestaurant.Create(const aName: string);
begin
  FName := aName;
end;

procedure TRestaurant.PrepareFood(aRecipe: TRecipe; aPreparer: IFoodPreparer);
begin
  aPreparer.PrepareFood(aRecipe)
end;

procedure TBaker.PrepareFood(aRecipe: TRecipe);
begin
  Writeln('Use baking skills to do the following: ' + aRecipe.Text);
end;

procedure TShortOrderCook.PrepareFood(aRecipe: TRecipe);
begin
  Writeln('Use the grill to do the following: ' + aRecipe.Text);
end;

procedure TChef.PrepareFood(aRecipe: TRecipe);
begin
  Writeln('Use well-trained culinary skills to prepare the following: ' + aRecipe.Text);
end;

end.
