unit uAutoKeyFobCommands;

interface

uses
  uAutoKeyFobInterfaces;

type

 // Local Radio for Fob Key
  TLocalCarLocker = class(TInterfacedObject, ISimpleCommand)
    procedure Execute;
  end;

  TLocalCarUnlocker = class(TInterfacedObject, ISimpleCommand)
    procedure Execute;
  end;

  TLocalEmergencyHorn = class(TInterfacedObject, ISimpleCommand)
    procedure Execute;
  end;

  // Satellite radio for Key Fob
  TSatelliteCarLocker = class(TInterfacedObject, ISimpleCommand)
    procedure Execute;
  end;

  TSatelliteCarUnlocker = class(TInterfacedObject, ISimpleCommand)
    procedure Execute;
  end;

  TSatelliteEmergencyHorn = class(TInterfacedObject, ISimpleCommand)
    procedure Execute;
  end;



implementation

procedure TLocalEmergencyHorn.Execute;
begin
  WriteLn('HONK, HONK, HONK, HONK!!!');
end;

procedure TLocalCarUnlocker.Execute;
begin
  WriteLn('The car is now unlocked');
end;

procedure TLocalCarLocker.Execute;
begin
  WriteLn('The car is now locked');
end;

procedure TSatelliteCarLocker.Execute;
begin
  WriteLn('The car is locked via satellite');
end;

procedure TSatelliteCarUnlocker.Execute;
begin
  WriteLn('The car is unlocked via satellite');
end;

procedure TSatelliteEmergencyHorn.Execute;
begin
   WriteLn('The car goes "HONK" via satellite');
end;

end.
