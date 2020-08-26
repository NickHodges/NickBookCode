unit uLogger;

interface

type

  ILogger = interface
  ['{955784CD-D867-4B41-A8F2-3D31B4593F39}']
    procedure Log(const aString: string);
  end;

  TLogger = class(TInterfacedObject, ILogger)
    procedure Log(const aString: string);
  end;


implementation

{ TLogger }

procedure TLogger.Log(const aString: string);
begin
  WriteLn(aString);
end;


end.
