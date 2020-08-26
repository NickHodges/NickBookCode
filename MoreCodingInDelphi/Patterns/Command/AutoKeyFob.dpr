program AutoKeyFob;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uAutoKeyFob in 'uAutoKeyFob.pas',
  uAutoKeyFobCommands in 'uAutoKeyFobCommands.pas',
  uAutoKeyFobInterfaces in 'uAutoKeyFobInterfaces.pas';

procedure DoIt;
var
  AutoKeyFob: TAutoKeyFob;
begin
  // Local Fob
  AutoKeyFob := TAutoKeyFob.Create(TLocalCarLocker.Create, TLocalCarUnlocker.Create, TLocalEmergencyHorn.Create);
  try
    AutoKeyFob.PressLockButton;
    AutoKeyFob.PressUnlockButton;
    AutoKeyFob.PressEmergencyButton;
  finally
    AutoKeyFob.Free;
  end;

  WriteLn;

  // Satellite Fob
  AutoKeyFob := TAutoKeyFob.Create(TSatelliteCarLocker.Create, TSatelliteCarUnlocker.Create, TSatelliteEmergencyHorn.Create);
  try
    AutoKeyFob.PressLockButton;
    AutoKeyFob.PressUnlockButton;
    AutoKeyFob.PressEmergencyButton;
  finally
    AutoKeyFob.Free;
  end;
end;


begin
  try
    DoIt;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
