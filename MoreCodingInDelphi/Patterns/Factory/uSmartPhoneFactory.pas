unit uSmartPhoneFactory;

interface

uses
      uSmartPhone
    ;

type
  TBaseSmartPhoneFactory = class abstract
  public
    function GetSmartPhone: TBaseSmartPhone; virtual; abstract;
  end;

  TCheapCrappyPhoneFactory = class(TBaseSmartPhoneFactory)
  public
    function GetSmartPhone: TBaseSmartPhone; override;
  end;

  TBasicSmartPhoneFactory = class(TBaseSmartPhoneFactory)
  public
    function GetSmartPhone: TBaseSmartPhone; override;
  end;

  TDeluxeSmartPhoneFactory = class(TBaseSmartPhoneFactory)
  public
    function GetSmartPhone: TBaseSmartPhone; override;
  end;

  TSuperDuperSmartPhoneFactory = class(TBaseSmartPhoneFactory)
  public
    function GetSmartPhone: TBaseSmartPhone; override;
  end;

  TSmartPhoneFactory = class(TBaseSmartPhoneFactory)
  private
    FSmartPhoneType: TSmartPhoneType;
  public
    function GetSmartPhone: TBaseSmartPhone; override;
    constructor CreateByType(aType: TSmartPhoneType);
  end;


implementation

uses
      System.SysUtils
    ;

{ TBasicSmartPhoneFactory }

function TBasicSmartPhoneFactory.GetSmartPhone: TBaseSmartPhone;
begin
  Result := TBasicSmartPhone.Create;
end;

{ TDeluxeSmartPhoneFactory }

function TDeluxeSmartPhoneFactory.GetSmartPhone: TBaseSmartPhone;
begin
  Result := TDeluxeSmartPhone.Create;
end;

{ TSmartPhoneFactory }

constructor TSmartPhoneFactory.CreateByType(aType: TSmartPhoneType);
begin
  inherited Create;
  FSmartPhoneType := aType;
end;

function TSmartPhoneFactory.GetSmartPhone: TBaseSmartPhone;
begin
  case FSmartPhoneType of
    Basic: Result := TBasicSmartPhone.Create;
    CheapCrappy: Result := TCheapCrappySmartPhone.Create;
    Deluxe: Result := TDeluxeSmartPhone.Create;
    SuperDuper: Result := TSuperDuperSmartPhone.Create;
  else
    raise Exception.Create('An impossiblility occurred -- a value for TSmartPhoneType was passed that doesn''t exist');
  end;
end;

{ TSuperDuperSmartPhoneFactory }

function TSuperDuperSmartPhoneFactory.GetSmartPhone: TBaseSmartPhone;
begin
  Result := TSuperDuperSmartPhone.Create;
end;

{ TCheapCrappyPhoneFactory }

function TCheapCrappyPhoneFactory.GetSmartPhone: TBaseSmartPhone;
begin
  Result := TCheapCrappySmartPhone.Create;
end;

end.
