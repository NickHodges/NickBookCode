unit uRTTIDemo;

interface

procedure GatherAndDisplayRTTI;

implementation

uses
      RTTI
    , uRTTIDemoClass
    , System.TypInfo
    ;

procedure GatherAndDisplayRTTI;
var
  Context: TRTTIContext;
  TempType: TRttiType;
  TempField: TRttiField;
  TempMethod: TRttiMethod;
  TempParam: TRttiParameter;
  TempProperty: TRttiProperty;
  TempIdxProperty: TRttiIndexedProperty;
  TempParams: TArray<TRttiParameter>;
begin
  TempType := Context.GetType(TRTTIDemoClass);
  // Fields
  WriteLn(TempType.Name, ' has the following fields: ');
  for TempField in TempType.GetFields do
  begin
    WriteLn('  ', TempField.Name, ' with visiblility: ', GetEnumName(TypeInfo(TMemberVisibility), Integer(TempField.Visibility)));
  end;
  WriteLn;
  // Properties
  WriteLn(TempType.Name, ' has the following properties:');
  for TempProperty in TempType.GetProperties do
  begin
    WriteLn('  ', TempProperty.ToString, ' with the visibility: ', GetEnumName(TypeInfo(TMemberVisibility), Integer(TempProperty.Visibility)));
  end;
  WriteLn;
//
  // IndexedProperties
  WriteLn(TempType.Name, ' has the following indexed properties:');
  for TempIdxProperty in TempType.GetIndexedProperties do
  begin
    WriteLn('  ', TempIdxProperty.ToString, ' with the visibility: ', GetEnumName(TypeInfo(TMemberVisibility), Integer(TempProperty.Visibility)));
  end;

  // Methods
  WriteLn(TempType.Name, ' has the following methods:');
  for TempMethod in TempType.GetDeclaredMethods do
  begin
    WriteLn('  ', TempMethod.Name);
    TempParams := TempMethod.GetParameters;
    if Length(TempParams) > 0 then
    begin
      for TempParam in TempParams do
      begin
        WriteLn('    ', TempParam.ToString);
      end;
    end else
    begin
      WriteLn('    ', 'No Parameters');
    end;
  end;
end;


end.
