unit uExpensiveProcess;

interface

uses
      Spring
    , Spring.Container
    , Spring.Container.Common
    ;

type
  IDatabaseConnector = interface
  ['{8E00247F-F910-41C1-9122-523F2CB6E5CB}']
    procedure Connect(aName: string);
  end;

  TDatabaseConnector = class(TInterfacedObject, IDatabaseConnector)
  private
    FConnected: Boolean;
  public
    constructor Create;
    procedure Connect(aName: string);
    property Connected: Boolean read FConnected write FConnected;
  end;

  TDatabaseConnectionManager = class
  private
    FDatabaseConnector: IDatabaseConnector;
  public
    constructor Create(aDatabaseConnector: IDatabaseConnector);
  end;

  TDatabaseConnectionManagerLazy = class
  private
    FDatabaseConnector: Lazy<IDatabaseConnector>;
  public
    constructor Create(aDatabaseConnector: Lazy<IDatabaseConnector>);
    procedure ConnectToDatabase;
  end;

  procedure Main;

implementation

uses
      Windows
    ;

procedure Main;
var
  DatabaseConnectionManager: TDatabaseConnectionManager;
  DatabaseConnectionManagerLazy: TDatabaseConnectionManagerLazy;
begin
  GlobalContainer.RegisterType<IDatabaseConnector, TDatabaseConnector>;
  GlobalContainer.RegisterType<TDatabaseConnectionManager>;
  GlobalContainer.RegisterType<TDatabaseConnectionManagerLazy>;
  GlobalContainer.Build;

  WriteLn('Everything is registered');
  ReadLn;

  WriteLn('About to create DatabaseConnectionManager');
  DatabaseConnectionManager := GlobalContainer.Resolve<TDatabaseConnectionManager>;

  Writeln('Note that Connection is made without anything done on your part.');
  Writeln('The connection occurs as part of the magic of the Container.');
  WriteLn('All Done');
  WriteLn;
  ReadLn;

  WriteLn('About to create DatabaseConnectionManagerLazy');
  DatabaseConnectionManagerLazy := GlobalContainer.Resolve<TDatabaseConnectionManagerLazy>;

  WriteLn('Note that connection is not made until specifically asked for by you hitting Return.');
  WriteLn('Wait at least five seconds just to prove it to yourself');
  ReadLn;
  Writeln('Okay, now you have asked for the connection, and it will be made');
  DatabaseConnectionManagerLazy.ConnectToDatabase;

  WriteLn;
  WriteLn('All Done');
  WriteLn;
end;


constructor TDatabaseConnector.Create;
begin
  inherited Create;
  FConnected := False;
  Connect(Self.ClassName);
end;

procedure TDatabaseConnector.Connect(aName: string);
begin
  if not Connected then
  begin
    WriteLn('Now connecting with ', aName);
    Sleep(3000);
    WriteLn('Connected!  Sorry I took so long!');
    Connected := True;
  end;
end;

constructor TDatabaseConnectionManagerLazy.Create(aDatabaseConnector: Lazy<IDatabaseConnector>);
begin
  FDatabaseConnector := aDatabaseConnector;
end;

procedure TDatabaseConnectionManagerLazy.ConnectToDatabase;
begin
  FDatabaseConnector.Value.Connect(Self.ClassName);
end;

constructor TDatabaseConnectionManager.Create(aDatabaseConnector: IDatabaseConnector);
begin
  FDatabaseConnector := aDatabaseConnector;
end;

end.
