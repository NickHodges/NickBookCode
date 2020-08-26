unit uHookedDrinks;

interface

type
  TCaffeineBeverageWithHook = class abstract
    procedure PrepareRecipe; virtual; final;
    procedure Brew; virtual; abstract;
    procedure AddCondiments; virtual; abstract;
    procedure BoilWater;
    procedure PourInCup;
    function CustomerWantsCondiments: Boolean; virtual;
  end;

  TCoffeeWithHook = class(TCaffeineBeverageWithHook)
  private
    procedure Brew; override;
    procedure AddCondiments; override;
    function GetUserInput: string;
  public
    function CustomerWantsCondiments: Boolean; override;
  end;

  TTeaWithHook = class(TCaffeineBeverageWithHook)
  private
    procedure Brew; override;
    procedure AddCondiments; override;
    function GetUserInput: string;
  public
    function CustomerWantsCondiments: Boolean; override;
  end;

implementation

uses
      System.SysUtils
    ;

{ TCaffeineBeverageWithHook }

procedure TCaffeineBeverageWithHook.BoilWater;
begin
  WriteLn('Boiling water...');
end;

function TCaffeineBeverageWithHook.CustomerWantsCondiments: Boolean;
begin
  Result := True;
end;

procedure TCaffeineBeverageWithHook.PourInCup;
begin
  WriteLn('Pouring into cup...');
end;

procedure TCaffeineBeverageWithHook.PrepareRecipe;
begin
  BoilWater;
  Brew;
  PourInCup;
  if CustomerWantsCondiments then
  begin
    AddCondiments;
  end;
end;

{ TCoffeeWithHook }

procedure TCoffeeWithHook.AddCondiments;
begin
  WriteLn('Adding sugar and milk...');
end;

procedure TCoffeeWithHook.Brew;
begin
  WriteLn('Dripping water into the coffee/filter...');
end;

function TCoffeeWithHook.CustomerWantsCondiments: Boolean;
var
  Answer: string;
begin
  Answer := GetUserInput;
  Result := Answer.LowerCase(Answer).StartsWith('y');
end;

function TCoffeeWithHook.GetUserInput: string;
begin
  Write('Would you like milk and sugar with your coffee? (Y/N)');
  ReadLn(Result);
end;

{ TTeaWithHook }

procedure TTeaWithHook.AddCondiments;
begin
  WriteLn('Adding lemon...');
end;

procedure TTeaWithHook.Brew;
begin
  WriteLn('Steeping tea bag...');
end;

function TTeaWithHook.CustomerWantsCondiments: Boolean;
var
  Answer: string;
begin
  Answer := GetUserInput;
  Result := Answer.LowerCase(Answer).StartsWith('y');
end;

function TTeaWithHook.GetUserInput: string;
begin
  Write('Would you like lemon with your tea? (Y/N)');
  ReadLn(Result);
end;

end.
