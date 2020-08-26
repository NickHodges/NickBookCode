unit uDisplayNameAttributes;

interface

uses
      RTTI
    , Classes
    ;


type

  TDisplayTextAttribute = class(TCustomAttribute)
  private
    FDisplayText: string;
  public
    constructor Create(aDisplayText: string);
    property DisplayText: string read FDisplayText write FDisplayText;
  end;


type
  TCustomer = Class(TObject)
  private
    FFirstName: string;
    FLastName: string;
    FStreetAddress: string;
    FZIP: string;
    FState: string;
    FCity: string;
    FPhone: string;
  public
    [TDisplayTextAttribute('First Name')]
    property FirstName: string read FFirstName write FFirstName;
    [TDisplayText('Last Name')]
    property LastName: string read FLastName write FLastName;
    [TDisplayText('Street Address')]
    property StreetAddress: string read FStreetAddress write FStreetAddress;
    [TDisplayText('City')]
    property City: string read FCity write FCity;
    [TDisplayText('State')]
    property State: string read FState write FState;
    [TDisplayText('ZIP Code')]
    property ZIP: string read FZIP write FZIP;
    [TDisplayText('Phone #')]
    property Phone: string read FPhone write FPhone;
  end;

procedure GetAllDisplayTextsForClass(aType: TClass; const aStringList: TStrings);

procedure ShowDisplayAttributes;

implementation

constructor TDisplayTextAttribute.Create(aDisplayText: string);
begin
  FDisplayText := aDisplayText;
end;

procedure GetAllDisplayTextsForClass(aType: TClass; const aStringList: TStrings);

    function GetDisplayTextForProperty(aProp: TRTTIProperty; aPropName: string): string;
    var
      TempAttribute: TCustomAttribute;
    begin
      Result := '';
      if aProp <> nil then
      begin
        for TempAttribute in aProp.GetAttributes do
        begin
          if TempAttribute is TDisplayTextAttribute then
          begin
            Result := TDisplayTextAttribute(TempAttribute).DisplayText;
          end;
        end;
      end;
    end;

var
  TempContext: TRttiContext;
  TempProp: TRTTIProperty;
  TempType: TRttiType;
  TempName, TempValue: string;
begin
  if aStringList = nil then
    Exit;
  aStringList.Clear;
  TempContext := TRttiContext.Create;
  try
    TempType := TempContext.GetType(aType);
    for TempProp in TempType.GetProperties do
    begin
      TempName := TempProp.Name;
      TempValue := GetDisplayTextForProperty(TempProp, TempName);
      aStringList.Values[TempName] := TempValue;
    end;
  finally
    TempContext.Free;
  end;
end;

procedure ShowDisplayAttributes;
var
  SL: TStringList;
  S: String;
begin
  SL := TStringList.Create;
  try
    GetAllDisplayTextsForClass(TCustomer, SL);
    for S in SL do
    begin
      WriteLn(S);
    end;
  finally
    SL.Free;
  end;
end;


end.
