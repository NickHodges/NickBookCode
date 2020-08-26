unit uSimpleAttributes;

interface

type

// Defines a simple attribute
TSimpleAttribute = class(TCustomAttribute)
private
  FNumber: integer;
public
  constructor Create(aNumber: integer);
  property Number: integer read FNumber;
end;


[TSimpleAttribute(42)] //Attribute on a class
TSimpleClass = class

end;

TAttributeOnProperty = class
private
  function GetBottlesOfBeer: string;
  function GetPropertyAttribute: string;
public
  [TSimple(99)] // Attribute on a property
  property BottlesOfBeer: string read GetBottlesOfBeer ;
end;

TAttributeOnMethod = class
public
  [TSimpleAttribute(2)]  // Attribute on a method
  function AddToAttribute(aInteger: integer): integer;
end;

TAttributeOnField = class
private
  [TSimpleAttribute(2)]
  FField: integer;
public
  constructor Create(aInteger: integer);
end;

TAttributeOnParameter = class
public
  function TimesAttribute([TSimpleAttribute(42)] aInteger: integer): integer;
end;


procedure ShowSimpleClassAttribute;
procedure ShowPropertyAttribute;
procedure ShowMethodAttribute;
procedure ShowFieldAttribute;
procedure ShowParameterAttribute;


implementation

uses
      RTTI
    , SysUtils
    ;

procedure ShowSimpleClassAttribute;
var
  TempContext: TRTTIContext;
  TempType: TRTTIType;
  TempAttributes: TArray<TCustomAttribute>;
  Attribute: TCustomAttribute;
begin
  TempType := TempContext.GetType(TSimpleClass);
  TempAttributes := TempType.GetAttributes;
  for Attribute in TempAttributes do
  begin
    if Attribute is TSimpleAttribute then
    begin
      WriteLn('Class Attribute is: ', TSimpleAttribute(Attribute).Number);
    end;
  end;
end;

{ TSimpleAttribute }

constructor TSimpleAttribute.Create(aNumber: integer);
begin
  inherited Create;
  FNumber := aNumber;
end;

{ TPropertyClass }

function TAttributeOnProperty.GetPropertyAttribute: string;
var
  Context: TRttiContext;
  TempType: TRttiType;
  TempProperty: TRttiProperty;
  TempAttributes: TArray<TCustomAttribute>;
  TempValue: TValue;
  Attribute: TCustomAttribute;
begin
  Result := '';
  TempType := Context.GetType(Self.ClassType);
  TempProperty := TempType.GetProperty('BottlesOfBeer');
  TempAttributes := TempProperty.GetAttributes;
  for Attribute in TempAttributes do
  begin
    if Attribute is TSimpleAttribute then
    begin
      TempValue := TSimpleAttribute(Attribute).Number;
    end;
  end;
  Result := TempValue.ToString;
end;

function TAttributeOnProperty.GetBottlesOfBeer: string;
begin
  Result := GetPropertyAttribute + ' bottles of beer on the wall.';
end;

procedure ShowPropertyAttribute;
var
  PC: TAttributeOnProperty;
begin
  PC := TAttributeOnProperty.Create;
  try
    WriteLn(PC.BottlesOfBeer);
  finally
    PC.Free;
  end;
end;

{ TAttributeOnMethod }

function TAttributeOnMethod.AddToAttribute(aInteger: integer): integer;
var
  TempContext: TRttiContext;
  TempType: TRttiType;
  Temp: integer;
  TempMethod: TRTTIMethod;
  TempAttributes: TArray<TCustomAttribute>;
  Attribute: TCustomAttribute;
begin
  Temp := 0;
  TempType := TempContext.GetType(Self.ClassType);
  TempMethod := TempType.GetMethod('AddToAttribute');
  TempAttributes:= TempMethod.GetAttributes;
  for Attribute in TempAttributes do
  begin
    if Attribute is TSimpleAttribute then
    begin
      Temp := aInteger + TSimpleAttribute(Attribute).Number;
    end;
  end;
  Result := Temp;
end;

procedure ShowMethodAttribute;
var
  AttributeOnMethod: TAttributeOnMethod;
begin
  AttributeOnMethod := TAttributeOnMethod.Create;
  try
    WriteLn('Attribute + 42 = ', AttributeOnMethod.AddToAttribute(42));
  finally
    AttributeOnMethod.Free;
  end;
end;

procedure ShowFieldAttribute;
var
  AttributeOnField: TAttributeOnField;
  TempContext: TRttiContext;
  TempTypes: TRttiType;
  TempField: TRttiField;
  TempValue: TValue;
  TempAttributes: TArray<TCustomAttribute>;
  TempAttribute: TObject;
begin
  AttributeOnField := TAttributeOnField.Create(66);
  try
    TempTypes := TempContext.GetType(TAttributeOnField);
    TempField := TempTypes.GetField('FField');
    TempAttributes := TempField.GetAttributes;
    for TempAttribute in TempAttributes  do
    begin
      if TempAttribute is TSimpleAttribute then
      begin
        TempValue := TSimpleAttribute(TempAttribute).Number;
      end;
    end;
    WriteLn('FField Attribute is ', TempValue.ToString);
  finally
    AttributeOnField.Free;
  end;
end;


{ TAttributeOnField }

constructor TAttributeOnField.Create(aInteger: integer);
begin
  FField := aInteger;
end;

{ TAttributeOnParameter }

function TAttributeOnParameter.TimesAttribute(aInteger: integer): integer;
var
  TempContext: TRttiContext;
  TempType: TRttiType;
  TempMethod: TRttiMethod;
  TempParams: TArray<TRttiParameter>;
  TempParam: TRttiParameter;
  TempAttribute: TCustomAttribute;
begin
  Result := aInteger;
  TempType := TempContext.GetType(Self.ClassType);
  TempMethod := TempType.GetMethod('TimesAttribute');
  TempParams := TempMethod.GetParameters;
  for TempParam in TempParams do
  begin
    if TempParam.Name = 'aInteger' then
    begin
      for TempAttribute in  TempParam.GetAttributes do
      begin
        if TempAttribute is TSimpleAttribute then
        begin
          Result := TSimpleAttribute(TempAttribute).Number * Result;
        end;
      end;
    end;
  end;
end;

procedure ShowParameterAttribute;
var
  AttributeOnParameter: TAttributeOnParameter;
begin
  AttributeOnParameter := TAttributeOnParameter.Create;
  try
    WriteLn('Attribute on Parameter gives: ', AttributeOnParameter.TimesAttribute(2));
  finally
    AttributeOnParameter.Free;
  end;
end;

end.
