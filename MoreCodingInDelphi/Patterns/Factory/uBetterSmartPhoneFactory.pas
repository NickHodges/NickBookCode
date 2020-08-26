unit uBetterSmartPhoneFactory;

interface

uses
      uSmartPhoneFactory
    , uSmartPhone
    ;

type
  TBetterSmartPhoneFactory = class(TBaseSmartPhoneFactory)
  private
    FSmartPhoneType: TSmartPhoneType;
  public
    constructor Create(aPhoneType: TSmartPhoneType);
    function GetSmartPhone: TBaseSmartPhone; override;
  end;

implementation

uses
      System.SysUtils
    ;

{ TBetterSmartPhoneFactory }

constructor TBetterSmartPhoneFactory.Create(aPhoneType: TSmartPhoneType);
begin
  inherited Create;
  FSmartPhoneType := aPhoneType;
end;

function TBetterSmartPhoneFactory.GetSmartPhone: TBaseSmartPhone;
begin
  case FSmartPhoneType of
    CheapCrappy: Result := TCheapCrappySmartPhone.Create;
    Basic: Result := TBasicSmartPhone.Create;
    Deluxe: Result := TDeluxeSmartPhone.Create;
    SuperDuper: Result := TSuperDuperSmartPhone.Create;
  else
    raise ENotImplemented.Create('An impossible thing happened: FSmartPhoneType wasn''t defined.');
  end;;
end;

end.
