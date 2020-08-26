unit uNoServiceLocatorDemo;

interface

uses
      Spring.Container
    , Spring.Services
    , Spring.Collections
    , Spring.Container.Common
    ;

type
  IWeapon = interface
  ['{0F63DF32-F65F-4708-958E-E1931814EC33}']
    procedure Wield;
  end;

  IFighter = interface
  ['{0C926753-A70D-40E3-8C35-85CA2C4B18CA}']
    procedure SetWeapon(aWeapon: IWeapon);
    function GetWeapon: IWeapon;
    procedure Fight;
    property Weapon: IWeapon read GetWeapon write SetWeapon;
  end;

  TServiceLocatorBattleField = class
  private
    FFighter: IFighter;
  public
    procedure AddFighter(aFighter: IFighter);
    procedure Battle;
  end;

  TBattleField = class
  private
    FFighter: IFighter;
  public
    [Inject]
    procedure AddFighter(aFighter: IFighter);
    procedure Battle;
  end;

  [Singleton]
  TSword = class(TInterfacedObject, IWeapon)
    procedure Wield;
  end;

  TSpear = class(TInterfacedObject, IWeapon)
    procedure Wield;
  end;

  TKnight = class(TInterfacedObject, IFighter)
  private
    FWeapon: IWeapon;
    procedure SetWeapon(aWeapon: IWeapon);
    function GetWeapon: IWeapon;
 public
    [Inject('spear')]
    constructor Create(aWeapon: IWeapon);
    procedure Fight;
    property Weapon: IWeapon read GetWeapon write SetWeapon;
  end;

implementation

{ TBattleField }

procedure TBattleField.AddFighter(aFighter: IFighter);
begin
  FFighter := aFighter;
end;

procedure TBattleField.Battle;
begin
  WriteLn('The Battle is on!');
  FFighter.Fight;
end;

{ TKnight }

constructor TKnight.Create(aWeapon: IWeapon);
begin
  inherited Create;
  FWeapon := aWeapon;
end;

procedure TKnight.Fight;
begin
  WriteLn('The knight swings into action!');
  FWeapon.Wield;
end;

function TKnight.GetWeapon: IWeapon;
begin
  Result := FWeapon;
end;

procedure TKnight.SetWeapon(aWeapon: IWeapon);
begin
  FWeapon := aWeapon;
end;

procedure TSword.Wield;
begin
  WriteLn('"Swoosh" goes the sword!');
end;

procedure TServiceLocatorBattleField.AddFighter(aFighter: IFighter);
begin
  FFighter := aFighter;
end;

procedure TServiceLocatorBattleField.Battle;
begin
  WriteLn('The Battle is on via ServiceLocator!');
  FFighter.Fight;
end;

{ TSpear }

procedure TSpear.Wield;
begin
  WriteLn('Jab with the spear');
end;




end.
