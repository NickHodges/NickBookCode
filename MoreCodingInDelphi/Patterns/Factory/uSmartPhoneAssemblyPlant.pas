unit uSmartPhoneAssemblyPlant;

interface

uses
      uSmartPhone
    , uSmartPhoneFactory
    ;

type
  TSmartPhoneAssemblyPlant = class
  public
    procedure AssemblePhone(const aSmartPhoneFactory: TBaseSmartPhoneFactory);
  end;

implementation

uses
     System.SysUtils
    ;

{ TSmartPhoneStore }

procedure TSmartPhoneAssemblyPlant.AssemblePhone(const aSmartPhoneFactory: TBaseSmartPhoneFactory);
var
  LSmartPhone: TBaseSmartPhone;
begin
  LSmartPhone := aSmartPhoneFactory.GetSmartPhone;
  try
    WriteLn(Format('About to build a %s smartphone.', [LSmartPhone.Name]));
    LSmartPhone.GatherParts;
    LSmartPhone.Assemble;
  finally
    LSmartPhone.Free;
  end;
end;

end.
