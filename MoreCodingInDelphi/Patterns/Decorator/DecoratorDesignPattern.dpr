program DecoratorDesignPattern;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uPizzaShackPizza in 'uPizzaShackPizza.pas';

procedure OutputPizza(aPizza: TPizza);
begin
  WriteLn('A ', aPizza.Description, ' costs ', '$', Format('%2f', [aPizza.Cost]));
  WriteLn;
end;

procedure OrderPizza;
var
  Pizza1: TPizza;
  Pizza2: TPizza;
  Pizza3: TPizza;
  Pizza4: TPizza;
begin
  Pizza1 := TMozarellaCheesePizza.Create;
  try
    Pizza1 := TPepperoni.Create(Pizza1);
    Pizza1 := TSausage.Create(Pizza1);
    OutputPizza(Pizza1);
  finally
    Pizza1.Free;
  end;

  Pizza2 := TParmesanCheesePizza.Create;
  try
    Pizza2 := TPepperoni.Create(Pizza2);
    Pizza2 := TOnions.Create(Pizza2);
    Pizza2 := TBlackOlives.Create(Pizza2);
    OutputPizza(Pizza2);
  finally
    Pizza2.Free;
  end;

  // Alternate way to call the same thing as above....
  Pizza3 := TBlackOlives.Create(TPepperoni.Create(TPepperoni.Create(TParmesanCheesePizza.Create)));
  try
    OutputPizza(Pizza3);
  finally
    Pizza3.Free;
  end;

  Pizza4 := TMozarellaCheesePizza.Create;
  try
    Pizza4 := TSausage.Create(Pizza4);
    Pizza4 := TPepperoni.Create(Pizza4);
    Pizza4 := TOnions.Create(Pizza4);
    OutputPizza(Pizza4);
  finally
    Pizza4.Free;
  end;
end;

begin
  try
    OrderPizza;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
