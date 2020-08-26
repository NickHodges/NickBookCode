unit uSimpleExample;

interface

type
  // How would you make this class open for extension?
  TVehicle = class
    procedure Go; virtual;
    procedure Stop; virtual;
    procedure Refuel; virtual;
  end;

implementation

{ TVehicle }

procedure TVehicle.Go;
begin
  WriteLn('Go');
end;

procedure TVehicle.Refuel;
begin
  WriteLn('Refuel');
end;

procedure TVehicle.Stop;
begin
  WriteLn('Stop');
end;

end.
