unit uRTTIGetSetValues;

interface


uses
      uRTTIDemoClass
    , RTTI
    ;

procedure GetAndSetFieldValues;


implementation

procedure GetAndSetFieldValues;
var
  RDC: TRTTIDemoClass;
  Context: TRttiContext;
  TempType: TRttiType;
  TempField: TRttiField;
  NewValue: TValue;
  TempProperty: TRttiProperty;
  TempIdxProperty: TRttiIndexedProperty;
begin

  RDC := TRTTIDemoClass.Create;
  try
    // Fields
    WriteLn('Getting and setting a private field....');
    TempType := Context.GetType(TRTTIDemoClass.ClassInfo);
    TempField := TempType.GetField('FPrivateField');
    NewValue := 'This is a new value for PublicProperty held by a TValue';
    TempField.SetValue(RDC, NewValue);
    WriteLn('You can get the value using RTTI: ', TempField.GetValue(RDC).ToString);
    WriteLn('---');

    // Properties
    WriteLn('Getting and setting a property...');
    TempProperty := TempType.GetProperty('PublicProperty');
    NewValue := 'NewValue for PublicProperty';
    TempProperty.SetValue(RDC, NewValue);
    WriteLn('PublicProperty is now set to: ', RDC.PublicProperty);
    WriteLn('You can also get the value using RTTI: ', TempProperty.GetValue(RDC).ToString);
    WriteLn('---');

    // IndexedProperties
    TempIdxProperty := TempType.GetIndexedProperty('IndexedProperty');
    NewValue := 'This is index 0';
    TempIdxProperty.SetValue(RDC, [0], NewValue);
    NewValue := 'This is index 1';
    TempIdxProperty.SetValue(RDC, [1], NewValue);
    WriteLn('IndexedProperty[0] retrieved via RTTI: ', TempIdxProperty.GetValue(RDC, [0]).ToString);
    WriteLn('IndexedProperty[1] retrieved right from the instance: ', RDC.IndexedProperty[1]);
    WriteLn('---');

  finally
    RDC.Free;
  end;
end;


end.
