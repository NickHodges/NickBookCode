unit uAbstractFactory;

interface

uses
      Spring.Collections
    ;

type

  IBattery = interface
  ['{AE55BF10-3945-43BC-886D-AC8556334D55}']
    function GetType: string;
  end;

  IElectricalDevice = interface
  ['{14655F2F-8B5A-4A45-BC7F-459FEB99F8B6}']
    function GetName: string;
    procedure UseBattery(aBattery: IBattery);
  end;

  IElectricalDeviceFactory = interface
  ['{EFB88733-99B0-4E3C-B626-19D6C6CDA111}']
    function CreateBattery: IBattery;
    function CreateElectricalDevice: IElectricalDevice;
  end;


  TLitiumIonBattery = class(TInterfacedOBject, IBattery)
    function GetType: string;
  end;

  TCellPhone = class(TInterfacedObject, IElectricalDevice)
    function GetName: string;
    procedure UseBattery(aBattery: IBattery);
  end;

  TAABatteries = class(TInterfacedObject, IBattery)
    function GetType: string;
  end;

  TToyRaceCar = class(TInterfacedObject, IElectricalDevice)
    function GetName: string;
    procedure UseBattery(aBattery: IBattery);
  end;

  // Concrete Factories
  TCellPhoneFactory = class(TInterfacedObject, IElectricalDeviceFactory)
    function CreateBattery: IBattery;
    function CreateElectricalDevice: IElectricalDevice;
  end;

  TToyRaceCarFactory = class(TInterfacedObject, IElectricalDeviceFactory)
    function CreateBattery: IBattery;
    function CreateElectricalDevice: IElectricalDevice;
  end;

  // Client class
  TElectrical = class
  private
    FBattery: IBattery;
    FElectricalDevice: IElectricalDevice;
  public
    constructor Create(aElectricalDeviceFactory: IElectricalDeviceFactory);
    procedure TurnOnDevice;
  end;

procedure DoIt;


implementation

procedure DoIt;
var
  CellPhoneFactory: IElectricalDeviceFactory;
  ToyCarFactory: IElectricalDeviceFactory;
  Electrical: TElectrical;
begin
  CellPhoneFactory := TCellPhoneFactory.Create;
  Electrical := TElectrical.Create(CellPhoneFactory);
  try
    Electrical.TurnOnDevice;
  finally
    Electrical.Free;
  end;

  ToyCarFactory := TToyRaceCarFactory.Create;
  Electrical := TElectrical.Create(ToyCarFactory);
  try
    Electrical.TurnOnDevice;
  finally
    Electrical.Free;
  end;
end;

function TCellPhoneFactory.CreateElectricalDevice: IElectricalDevice;
begin
  Result := TCellPhone.Create;
end;

function TCellPhoneFactory.CreateBattery: IBattery;
begin
  Result := TLitiumIonBattery.Create;
end;

function TToyRaceCarFactory.CreateElectricalDevice: IElectricalDevice;
begin
  Result := TToyRaceCar.Create;
end;

function TToyRaceCarFactory.CreateBattery: IBattery;
begin
  Result := TAABatteries.Create;
end;

constructor TElectrical.Create(aElectricalDeviceFactory: IElectricalDeviceFactory);
begin
  inherited Create;
  FBattery := aElectricalDeviceFactory.CreateBattery;
  FElectricalDevice := aElectricalDeviceFactory.CreateElectricalDevice;
end;

procedure TElectrical.TurnOnDevice;
begin
  FElectricalDevice.UseBattery(FBattery);
end;

{ TLitiumIonBattery }

function TLitiumIonBattery.GetType: string;
begin
  Result := 'Lithium Ion Battery';
end;

{ TCellPhone }

function TCellPhone.GetName: string;
begin
  Result := 'Cell Phone';
end;

procedure TCellPhone.UseBattery(aBattery: IBattery);
begin
  WriteLn(Self.GetName, ' is powered by a ', aBattery.GetType);
end;

{ TAABatteries }

function TAABatteries.GetType: string;
begin
  Result := 'AA Batteries';
end;

{ TToyRaceCar }

function TToyRaceCar.GetName: string;
begin
  Result := 'Toy Race Car';
end;

procedure TToyRaceCar.UseBattery(aBattery: IBattery);
begin
  WriteLn(Self.GetName, ' is powered by a ', aBattery.GetType);
end;

end.
