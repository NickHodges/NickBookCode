unit uVehicles;

interface

uses
      System.SysUtils
    ;

type

  TVehicle = class abstract
    procedure Go; virtual; abstract;
  end;

{$REGION 'GasVehicle'}
  TGasVehicle = class abstract(TVehicle)
     procedure FillWithGas; virtual; abstract;
  end;
{$ENDREGION}

  TCar = class(TGasVehicle )
    procedure Go; override;
    procedure FillWithGas; override;
  end;

  TTruck = class(TGasVehicle)
    procedure Go; override;
    procedure FillWithGas; override;
  end;

  TBicycle = class(TVehicle)
    procedure Go; override;
  end;

  procedure FillVehiclesWithGas;

implementation

uses
      Spring.Collections
    ;

procedure FillVehiclesWithGas;
var
  LVehicle: TVehicle;
  LVehicles: IList<TVehicle>;
begin
  LVehicles := TCollections.CreateList<TVehicle>;
  LVehicles.Add(TCar.Create);
  LVehicles.Add(TTruck.Create);
  LVehicles.Add(TBicycle.Create);

  for LVehicle in LVehicles do
  begin
    LVehicle.FillWithGas;
    LVehicle.Free;
  end;


end;


     {$REGION 'BigIf'}
  //procedure FillWithGas(aVehicle: TVehicle);
  //begin
  //  if (aVehicle is TCar)then
  //  begin
  //    TCar(aVehicle).FillWithGas;
  //  end else
  //  begin
  //    if (aVehicle is TTruck) then
  //    begin
  //      TTruck(aVehicle).FillWithGas;
  //    end else
  //    begin
  //      raise Exception.Create('Can''t fill this vehicle with gas.');
  //    end;
  //  end
  //end;
{$ENDREGION}

{ TCar }

procedure TCar.FillWithGas;
begin
  WriteLn('Fill with unleaded');
end;

procedure TCar.Go;
begin
  WriteLn('Step on accelerator and steer');
end;

{ TBicycle }

procedure TBicycle.Go;
begin
  WriteLn('Start pedaling and steer');
end;

{ TTruck }

procedure TTruck.FillWithGas;
begin
  Writeln('Fill with diesel');
end;

procedure TTruck.Go;
begin
  WriteLn('Put in gear, press accellerator and steer');
end;

end.
