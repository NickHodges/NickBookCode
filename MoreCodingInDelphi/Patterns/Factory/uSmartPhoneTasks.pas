unit uSmartPhoneTasks;

interface

uses
      uSmartPhoneFactory
    , uSmartPhone
    ;

procedure BuildPhone(aPhoneType: TSmartPhoneType);

implementation

uses
      uSmartPhoneAssemblyPlant
    , uBetterSmartPhoneFactory
    ;

procedure BuildASmartPhone(aFactory: TBaseSmartPhoneFactory);
var
  SmartPhonePlant: TSmartPhoneAssemblyPlant;
begin
  SmartPhonePlant := TSmartPhoneAssemblyPlant.Create;
  try
    SmartPhonePlant.AssemblePhone(aFactory);
  finally
    SmartPhonePlant.Free;
  end;
end;

procedure BuildPhone(aPhoneType: TSmartPhoneType);
var
  SmartPhoneFactory: TBaseSmartPhoneFactory;
begin
  SmartPhoneFactory := TBetterSmartPhoneFactory.Create(aPhoneType);
  try
    BuildASmartPhone(SmartPhoneFactory);
  finally
    SmartPhoneFactory.Free;
  end;
end;

end.
