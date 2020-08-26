unit uRefactoredDrinks;

interface

type
   TCaffeineBeverage = class abstract(TObject)
   protected
     procedure Brew; virtual; abstract;
     procedure AddCondiments; virtual; abstract;
     procedure BoilWater;
     procedure PourInCup;
   public
     procedure PrepareRecipe; virtual; final;
   end;

   TTea = class(TCaffeineBeverage)
   protected
     procedure Brew; override;
     procedure AddCondiments; override;
   end;

   TCoffee = class(TCaffeineBeverage)
   protected
     procedure Brew; override;
     procedure AddCondiments; override;
   end;


implementation

{ TCaffeineBeverage }

procedure TCaffeineBeverage.BoilWater;
begin
  WriteLn('Boiling water...');
end;

procedure TCaffeineBeverage.PourInCup;
begin
  WriteLn('Pouring in cup...');
end;

procedure TCaffeineBeverage.PrepareRecipe;
begin
  BoilWater;
  Brew;
  PourInCup;
  AddCondiments;
end;

{ TTea }

procedure TTea.AddCondiments;
begin
  WriteLn('Adding lemon...');
end;

procedure TTea.Brew;
begin
  WriteLn('Steeping the tea...');
end;

{ TCoffee }

procedure TCoffee.AddCondiments;
begin
  WriteLn('Adding sugar and milk...');
end;

procedure TCoffee.Brew;
begin
  WriteLn('Dripping coffee through filter...');
end;


end.
