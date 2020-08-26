unit uBadSmartPhoneAssemblyPlant;

interface

uses
      uSmartPhone
    , uSmartPhoneFactory
    ;

type
  TBadSmartPhoneAssemblyPlant = class
    procedure AssembleSmartPhone(aFactory: TSmartPhoneFactory);
  end;

implementation

uses
      System.SysUtils
    ;

{ TBadSmartPhoneStore }

procedure TBadSmartPhoneAssemblyPlant.AssembleSmartPhone(aFactory: TSmartPhoneFactory);
var
  SmartPhone: TBaseSmartPhone;
begin
  SmartPhone := aFactory.GetSmartPhone;
  try
    WriteLn(Format('Assemble a %s', [SmartPhone.Name]));
    SmartPhone.GatherParts;
    SmartPhone.Assemble
  finally
    SmartPhone.Free;
  end;
end;

end.
