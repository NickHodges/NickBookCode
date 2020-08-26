      unit uRTTIDemoClass;

interface

type
  TRTTIDemoClass = class
  private
    FPrivateField: string;
    FPublicProperty: string;
    FIndexedProperty: array of string;
    procedure PrivateMethod;
    procedure SetPublicProperty(const Value: string);
    function GetIndexedProperty(aIndex: integer): string;
    procedure SetIndexedProperty(aIndex: integer; const Value: string);
  protected
    procedure ProtectedMethod;
  public
    PublicField: Double;
    constructor Create;
    procedure PublicMethod;
    function SomeFunction: string;
    procedure PublicMethodWithParams(aString: string; aExtended: Extended);
    property PublicProperty: string read FPublicProperty write SetPublicProperty;
    property IndexedProperty[aIndex: integer]: string read GetIndexedProperty write SetIndexedProperty;
  end;

type
  {$M-}
  {$RTTI EXPLICIT METHODS([vcPublic]) PROPERTIES([vcPublic]) FIELDS([vcPublic])}
  TPublicStuffOnly = class(TObject)
  private
    PrivateField: double;
    FPublicPropertyField: string;
    FPublishedPropertyField: string;
    procedure PrivateMethod;
  protected
    ProtectedField: string;
    procedure ProtectedMethod;
  public
    PublicField: integer;
    procedure PublicMethod;
    property PublicProperty: string read FPublicPropertyField write FPublicPropertyField;
  published
    {$M-}
    PublishedField: TObject;
    function PublishedMethod(aParam: string): integer;
    property PublishedProperty: string read FPublishedPropertyField write FPublishedPropertyField;
    {$M+}
  end;





implementation

{ TRTTIDemoClass }

constructor TRTTIDemoClass.Create;
begin
  SetLength(FIndexedProperty, 2);
end;

function TRTTIDemoClass.GetIndexedProperty(aIndex: integer): string;
begin
  Result := FIndexedProperty[aIndex];
  WriteLn('Value of ', Result, ' retrieved from GetIndexedProperty');
end;

procedure TRTTIDemoClass.PrivateMethod;
begin
  WriteLn('This is a private method');
end;

procedure TRTTIDemoClass.ProtectedMethod;
begin
  WriteLn('This is a protected method');
end;

procedure TRTTIDemoClass.PublicMethod;
begin
  WriteLn('This is a public method called "PublicMethod"');
end;

procedure TRTTIDemoClass.PublicMethodWithParams(aString: string; aExtended: Extended);
begin
  WriteLn('You passed in "', aString, '" and "', aExtended, '"');
end;

procedure TRTTIDemoClass.SetIndexedProperty(aIndex: integer; const Value: string);
begin
  FIndexedProperty[aIndex] := Value;
//  WriteLn('Index ', aIndex, ' set to ', Value);
end;

procedure TRTTIDemoClass.SetPublicProperty(const Value: string);
begin
//  WriteLn('Value of PublicProperty set to ', Value);
  FPublicProperty := Value;
end;

function TRTTIDemoClass.SomeFunction: string;
begin
  Result := 'This is the result of the SomeFunction method';
end;

{ TPublicStuffOnly }

procedure TPublicStuffOnly.PrivateMethod;
begin

end;

procedure TPublicStuffOnly.ProtectedMethod;
begin

end;

procedure TPublicStuffOnly.PublicMethod;
begin

end;

function TPublicStuffOnly.PublishedMethod(aParam: string): integer;
begin

end;

end.
