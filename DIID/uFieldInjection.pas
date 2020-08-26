unit uFieldInjection;

interface

uses
      Spring.Container.Common
    ;

type
  IBrake = interface
  ['{74DBE39C-F52F-42C4-B7CB-8009F7EDF1E1}']
    procedure StopVehicle;
  end;

  IEngine = interface
  ['{0BC34CC8-DE81-4073-9CA4-A160CFB9A64A}']
    procedure PropelVehicle;
  end;

  ICar = interface
  ['{B2C1C9FB-E388-4F0B-9197-2BCAB5A2A396}']
    procedure Drive;
  end;

  TBrakes = class(TInterfacedObject, IBrake)
    procedure StopVehicle;
  end;

  TEngine = class(TInterfacedObject, IEngine)
    procedure PropelVehicle;
  end;


  TCar = class(TInterfacedObject, ICar)
  private
    FBrakes: IBrake;
    [Inject]
    FEngine: IEngine;
  public
    procedure Drive;
  end;


procedure MakeCarGo;

implementation

uses
      Spring.Container
    ;

procedure MakeCarGo;
var
  Car: ICar;
begin
  Car := GlobalContainer.Resolve<ICar>;
  Car.Drive;
end;

{ TBrakes }

procedure TBrakes.StopVehicle;
begin
  WriteLn('Step on the brake pedal and make the car stop');
end;

{ TEngine }

procedure TEngine.PropelVehicle;
begin
  Writeln('Burn gas and make the car go');
end;

{ TCar }

procedure TCar.Drive;
begin
  FEngine.PropelVehicle;
  FBrakes.StopVehicle;
end;


end.
