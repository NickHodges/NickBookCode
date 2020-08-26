unit uAttributesEverywhere;

interface

type
  SampleAttribute = class(TCustomAttribute);

  [Sample]
  TStopLight = (Red, Yellow, Green);

  [Sample]
  TAttributesEverywhere = class
  private
    [Sample]
    FSomeProperty: Extended;
    procedure SetSomeProperty(const Value: Extended);
  public
    [Sample]
    procedure DoThis([Sample]aString: string);
    [Sample]
    function DoThat([Sample]aObject: TObject): integer;
    [Sample]
    property SomeProperty: Extended read FSomeProperty write SetSomeProperty;
  end;

procedure DoAttributesEverywhere;

type
  FirstAttribute = class(TCustomAttribute);

  SecondAttribute = class(TCustomAttribute);

  ThirdAttribute = class(TCustomAttribute);

  [First] [Second]
  [Third]
  TMultipleAttributes = class(TObject);


procedure DoMultipleAttributes;

implementation

uses
       RTTI
     ;

procedure DoAttributesEverywhere;
var
  Context: TRTTIContext;
  TempClassType: TRttiType;
  TempEnumType: TRttiOrdinalType;
  TempAttribute: TCustomAttribute;
  TempAttribute1: TCustomAttribute;
  TempField: TRttiField;
  TempMethod: TRttiMethod;
  TempParam: TRttiParameter;
  TempProperty: TRttiProperty;
begin
  // Enum
  TempEnumType := Context.GetType(TypeInfo(TStopLight)).AsOrdinal;
  for TempAttribute in TempEnumType.GetAttributes do
  begin
    WriteLn(TempEnumType.Name, ' has the following attributes: ');
    Write('  ', TempAttribute.ToString);
  end;
  WriteLn;
  WriteLn;



  // Class
  TempClassType := Context.GetType(TAttributesEverywhere);
  WriteLn('TAttributesEverywhere has the following attributes:');

  for TempAttribute in TempClassType.GetAttributes do
  begin
    WriteLn('  Class Attribute: ', TempAttribute.ToString);
  end;
  WriteLn;
  for TempField in TempClassType.GetFields do
  begin
    WriteLn('The ', TempField.Name, ' has the following attributes:');
    for TempAttribute in TempField.GetAttributes do
    begin
      WriteLn(' ', TempAttribute.ToString);
    end;
  end;
  WriteLn;
  for TempMethod in TempClassType.GetMethods do
  begin
    for TempAttribute in TempMethod.GetAttributes do
    begin
      WriteLn('The ', TempMethod.Name, 'method has the ', TempAttribute.ToString, ' attribute.');
      for TempParam in TempMethod.GetParameters do
      begin
        for TempAttribute1 in TempParam.GetAttributes do
        begin
          WriteLn('  The ', TempParam.Name, ' parameter has the ', TempAttribute1.ToString, ' attribute.');
        end;
        if TempMethod.ReturnType <> nil then
        begin
          Writeln('  The ', TempMethod.Name, ' method is a function that returns a ', TempMethod.ReturnType.Name, '.');
        end else
        begin
          WriteLn('  The ', TempMethod.Name, ' method is a procedure.');
        end;
      end;
    end;
  end;
  WriteLn;
  for TempProperty in TempClassType.GetProperties do
  begin
    for TempAttribute in TempProperty.GetAttributes do
    begin
      WriteLn('The ', TempProperty.Name, ' has the ', TempAttribute.ToString, ' property.');
    end;
  end;
end;

procedure DoMultipleAttributes;
var
  Context: TRTTIContext;
  TempType: TRttiType;
  TempAttribute: TCustomAttribute;
begin
  TempType := Context.GetType(TMultipleAttributes);
  WriteLn(TMultipleAttributes.ClassName, ' has the following attributes: ');
  for TempAttribute in TempType.GetAttributes do
  begin
    WriteLn('  ', TempAttribute.ToString);
  end;
end;



{ TAttributesEverywhere }

function TAttributesEverywhere.DoThat(aObject: TObject): integer;
begin
  Result := aObject.GetHashCode;
end;

procedure TAttributesEverywhere.DoThis(aString: string);
begin
  WriteLn(aString);
end;

procedure TAttributesEverywhere.SetSomeProperty(const Value: Extended);
begin
  FSomeProperty := Value;
end;

end.
