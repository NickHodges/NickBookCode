unit uSingletonDemo;

interface


  uses
        Spring.Container.Common
      ;

type
  ICarPartManager = interface
  ['{E7B0C9D7-A8F8-4057-80C1-34EAF8DB31C5}']
    procedure ProcessCarParts;
    procedure EnterPartInDatabase;
  end;

  ILogger = interface
  ['{ABB67626-7044-4129-AFCF-0FD03B5725B7}']
    procedure Log(aString: string);
  end;

  [Singleton]
  TConsoleLogger = class(TInterfacedObject, ILogger)
    constructor Create;
    procedure Log(aString: string);
  end;

  TCarPartManager = class(TInterfacedObject, ICarPartManager)
  private
    FLogger: ILogger;
  public
    constructor Create(aLogger: ILogger);
    procedure ProcessCarParts;
    procedure EnterPartInDatabase;
  end;

  procedure ProcessCarPart;

implementation

uses
      Spring.Container
    ;

procedure ProcessCarPart;
var
  CarPartManager: ICarPartManager;
begin
  CarPartManager := GlobalContainer.Resolve<ICarPartManager>;
  CarPartManager.ProcessCarParts;
  WriteLn;
  CarPartManager.EnterPartInDatabase;
end;

{ TCarPartManager }

constructor TCarPartManager.Create(aLogger: ILogger);
begin
  inherited Create;
  FLogger := aLogger;
end;

procedure TCarPartManager.EnterPartInDatabase;
begin
  FLogger.Log('About to enter part in database');
  WriteLn('Entering part in database');
  FLogger.Log('Done entering part in database');
end;

procedure TCarPartManager.ProcessCarParts;
begin
  FLogger.Log('About to process car part');
  WriteLn('Processed a car part');
  FLogger.Log('Done processing car part');
end;

{ TLogger }

constructor TConsoleLogger.Create;
begin
  inherited;
end;

procedure TConsoleLogger.Log(aString: string);
begin
  WriteLn(aString);
end;


end.
