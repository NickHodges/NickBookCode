program uRegisterFactoryDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  uCoffeeMaker in 'uCoffeeMaker.pas';

type
  {$M+}
  TCoffeeMakerFactory = reference to function(const aCoffeeBrand: string; const aBrewingMinutes: integer): ICoffeeMaker;
  TCupCoffeeMakerFactory = reference to function(const aCupType: string): ICoffeeMaker;
  {$M-}

var
  CoffeeName: string;
  CupName: string;
  BrewingMinutes: integer;
  CoffeeMakerFactory: TCoffeeMakerFactory;
  CupCoffeeMakerFactory: TCupCoffeeMakerFactory;
  CoffeeMaker: ICoffeeMaker;
begin
  try
    GlobalContainer.RegisterType<ICoffeeMaker, TCoffeeMaker>('regular');
    GlobalContainer.RegisterType<ICoffeeMaker, TCupCoffeeMaker>('cup');

    GlobalContainer.RegisterFactory<TCoffeeMakerFactory>.AsFactory('regular');
    GlobalContainer.RegisterFactory<TCupCoffeeMakerFactory>.AsFactory('cup');
    GlobalContainer.Build;

    Write('What kind of coffee do you want to make? ');
    ReadLn(CoffeeName);

    Write('How many minutes? ');
    ReadLn(BrewingMinutes);

    CoffeeMakerFactory := GlobalContainer.Resolve<TCoffeeMakerFactory>();
    CoffeeMaker := CoffeeMakerFactory(CoffeeName, BrewingMinutes);
    CoffeeMaker.MakeCoffee;

    Writeln;

    Write('What kind of cup do you want to make?');
    Readln(CupName);
    CupCoffeeMakerFactory := GlobalContainer.Resolve<TCupCoffeeMakerFactory>();
    CoffeeMaker := CupCoffeeMakerFactory(CupName);
    CoffeeMaker.MakeCoffee;







  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;
end.
