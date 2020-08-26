unit uLimitedRTTI;

interface

procedure DisplayLimitedRTTI;

implementation

uses   uRTTIDemoClass
     , RTTI
     ;

procedure DisplayLimitedRTTI;
var
  Context: TRttiContext;
  TempType: TRttiType;
  TempMethod: TRttiMethod;
  TempProperty: TRttiProperty;
  TempField: TRttiField;
begin
  WriteLn('There should only be public fields listed below for ', TPublicStuffOnly.ClassName);
  TempType := Context.GetType(TPublicStuffOnly);
  WriteLn('Fields:');
  for TempField in TempType.GetDeclaredFields do
  begin
    WriteLn('  ', TempField.Name);
  end;

  WriteLn('Properties:');
  for TempProperty in TempType.GetDeclaredProperties do
  begin
    WriteLn('  ', TempProperty.Name);
  end;

  WriteLn('Methods:');
  for TempMethod in TempType.GetDeclaredMethods do
  begin
    WriteLn('  ', TempMethod.Name);
  end;
end;

end.
