unit uBadInjection;

interface

uses
      VCL.Graphics
    , Spring
    ;




type

  IPaintGunTip = interface
    procedure SprayCar(aColor: TColor);
  end;

  TPaintGunTip = class(TInterfacedObject, IPaintGunTip)
    procedure SprayCar(aColor: TColor);
  end;

  TCarPaintingRobot = class
  private
    FPaintGunTip: IPaintGunTip;
  public
    constructor Create(aPaintGunTip: IPaintGunTip);
    procedure PaintCar(aColor: TColor);
  end;

implementation

constructor TCarPaintingRobot.Create(aPaintGunTip: IPaintGunTip);
begin
  Guard.CheckNotNull(aPaintGunTip, 'aPaintGunTip');
  FPaintGunTip := aPaintGunTip;
end;

procedure TCarPaintingRobot.PaintCar(aColor: TColor);
begin
  FPaintGunTip.SprayCar(aColor);

  // Uh oh -- what to do now?  How do we free the tip?
  // and even if we could, what then?
  // How would we get a new one?

end;

procedure TPaintGunTip.SprayCar(aColor: TColor);
begin
  Writeln('Spray the car with ', ColorToString(aColor));
end;


end.
