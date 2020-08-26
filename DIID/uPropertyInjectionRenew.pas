unit uPropertyInjectionRenew;

interface

uses
      VCL.Graphics
    ;

type

  IPaintGunTip = interface
    procedure SprayCar(aColor: TColor);
  end;

  TPaintGunTip = class(TInterfacedObject, IPaintGunTip)
    procedure SprayCar(aColor: TColor);
  end;

  TCarPaintingRobot = class
  public
    procedure PaintCar(aColor: TColor; aPaintGunTip: IPaintGunTip);
  end;

implementation

uses
      Spring
    ;

procedure TCarPaintingRobot.PaintCar(aColor: TColor; aPaintGunTip: IPaintGunTip);
begin
  aPaintGunTip.SprayCar(aColor);
end;

procedure TPaintGunTip.SprayCar(aColor: TColor);
begin
  Writeln('Spray the car with ', ColorToString(aColor));
end;

end.
