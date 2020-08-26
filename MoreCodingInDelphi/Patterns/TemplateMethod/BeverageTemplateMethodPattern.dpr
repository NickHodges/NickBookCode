program BeverageTemplateMethodPattern;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uRefactoredDrinks in 'uRefactoredDrinks.pas',
  uOriginalDrinks in 'uOriginalDrinks.pas',
  uHookedDrinks in 'uHookedDrinks.pas';


procedure MakeRegularBeverages;
var
  Tea: uRefactoredDrinks.TTea;
  Coffee: uRefactoredDrinks.TCoffee;
begin
  Tea := uRefactoredDrinks.TTea.Create;
  try
    Tea.PrepareRecipe;
  finally
    Tea.Free;
  end;
  WriteLn;
  Coffee := uRefactoredDrinks.TCoffee.Create;
  try
    Coffee.PrepareRecipe;
  finally
    Coffee.Free;
  end;
end;

procedure MakeBeveragesWithHook;
var
  Coffee: TCoffeeWithHook;
  Tea: TTeaWithHook;
begin
  Coffee := TCoffeeWithHook.Create;
  try
    WriteLn('Making Coffee...');
    Coffee.PrepareRecipe;
  finally
    Coffee.Free;
  end;

  WriteLn;

  Tea := TTeaWithHook.Create;
  try
    WriteLn('Making tea...');
    Tea.PrepareRecipe;
  finally
    Tea.Free;
  end;
end;

begin
  try
//    MakeRegularBeverages;
  MakeBeveragesWithHook;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
