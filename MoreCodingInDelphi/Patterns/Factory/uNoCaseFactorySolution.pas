unit uNoCaseFactorySolution;

interface

uses
      uSmartPhone
    , Spring.Collections
    ;

type

  TSmartPhoneFunction = reference to function: TBaseSmartPhone;

  TSmartPhoneFactory = class
  private
    class var FDictionary: IDictionary<TSmartPhoneType, TSmartPhoneFunction>;
  public
    class constructor Create;
    class procedure AddPhone(aType: TSmartPhoneType; aFunction: TSmartPhoneFunction);
    class function GetPhone(aType: TSmartPhoneType): TBaseSmartPhone;
  end;

procedure DoIt;

implementation

procedure DoIt;
var
  SmartPhone: TBaseSmartPhone;
  SmartPhoneType: TSmartPhoneType;
begin

  for SmartPhoneType := Low(TSmartPhoneType) to High(TSmartPhoneType) do
  begin
    SmartPhone := TSmartPhoneFactory.GetPhone(SmartPhoneType);
    WriteLn('About to assemble ', SmartPhone.Name);
    SmartPhone.GatherParts;
    SmartPhone.Assemble;
    WriteLn;
  end;
end;

{ TSmartPhoneFactory }

class procedure TSmartPhoneFactory.AddPhone(aType: TSmartPhoneType; aFunction: TSmartPhoneFunction);
begin
  FDictionary.AddOrSetValue(aType, aFunction);
end;

class constructor TSmartPhoneFactory.Create;
begin
  FDictionary := TCollections.CreateDictionary<TSmartPhoneType, TSmartPhoneFunction>;
end;

class function TSmartPhoneFactory.GetPhone(aType: TSmartPhoneType): TBaseSmartPhone;
begin
  Result := FDictionary.Items[aType]();
end;

var
  SPF: TSmartPhoneFunction;

initialization

  SPF := function: TBaseSmartPhone
         begin
           Result := TCheapCrappySmartPhone.Create;
         end;

  TSmartPhoneFactory.AddPhone(CheapCrappy, SPF);

  SPF := function: TBaseSmartPhone
         begin
           Result := TBasicSmartPhone.Create;
         end;

  TSmartPhoneFactory.AddPhone(Basic, SPF);

  SPF := function: TBaseSmartPhone
         begin
           Result := TDeluxeSmartPhone.Create;
         end;

  TSmartPhoneFactory.AddPhone(Deluxe, SPF);

  SPF := function: TBaseSmartPhone
         begin
           Result := TSuperDuperSmartPhone.Create;
         end;

  TSmartPhoneFactory.AddPhone(SuperDuper, SPF);


end.
