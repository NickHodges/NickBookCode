unit uDoBattle;

interface

procedure FightBattleWithServiceLocators;
procedure FightBattleWithOneResolveCall;


implementation

uses
      uNoServiceLocatorDemo
    , Spring.Container
    , Spring.Services
    ;

procedure FightBattleWithServiceLocators;
var
  Battlefield: TServiceLocatorBattleField;
  TempKnight: IFighter;
begin
  Battlefield := TServiceLocatorBattleField.Create;
  try
    TempKnight := ServiceLocator.GetService<IFighter>;
    TempKnight.Weapon := ServiceLocator.GetService<IWeapon>;
    Battlefield.AddFighter(TempKnight);
    Battlefield.Battle;
  finally
    Battlefield.Free;
  end;
end;

procedure FightBattleWithOneResolveCall;
var
  Battlefield: TBattleField;
begin
  Battlefield := ServiceLocator.GetService<TBattlefield>;
  try
    Battlefield.Battle;
  finally
    Battlefield.Free;
  end;
end;

end.
