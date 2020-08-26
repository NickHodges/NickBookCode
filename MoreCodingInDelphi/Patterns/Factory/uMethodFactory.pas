unit uMethodFactory;

interface

uses
      uSmartPhone
    ;

type
  TSmartPhoneFactory = class of TBaseSmartPhone;

  TSmartPhoneAssemblyPlant = class
    class function MakeUnAssembledSmartPhone(aSmartPhoneFactory: TSmartPhoneFactory): TBaseSmartPhone;
    class function MakeAssembledSmartPhone(aSmartPhoneFactory: TSmartPhoneFactory): TBaseSmartPhone;
  end;

procedure DoItAgain;

implementation

procedure DoItAgain;
var
  SmartPhone: TBaseSmartPhone;
begin
  SmartPhone := TSmartPhoneAssemblyPlant.MakeUnAssembledSmartPhone(TDeluxeSmartPhone);
  SmartPhone.GatherParts;
  SmartPhone.Assemble;
  WriteLn(SmartPhone.Name, ' is completely assembled');
  WriteLn;
  SmartPhone := TSmartPhoneAssemblyPlant.MakeAssembledSmartPhone(TCheapCrappySmartPhone);
  // Phone is already assembled.
  WriteLn(SmartPhone.Name, ' is completely assembled');
end;

{ TSmartPhoneAssemblyPlant }

class function TSmartPhoneAssemblyPlant.MakeAssembledSmartPhone(aSmartPhoneFactory: TSmartPhoneFactory): TBaseSmartPhone;
begin
  Result := aSmartPhoneFactory.Create;
  Result.GatherParts;
  Result.Assemble;
end;

class function TSmartPhoneAssemblyPlant.MakeUnAssembledSmartPhone(aSmartPhoneFactory: TSmartPhoneFactory): TBaseSmartPhone;
begin
  Result := aSmartPhoneFactory.Create;
end;

end.
