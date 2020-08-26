unit RTTIForMiscTypes;

interface

procedure GetRTTIforMiscTypes;

type
  TDemoRecord = record
  private
    PrivateField: Extended;
  public
    SomeString: string;
    SomeInteger: integer;
    procedure DoSomething;
  end;

type
  TThreeStringArray = array[0..2] of string;

implementation

uses
     RTTI
   , TypInfo
   ;

type
  TStopLight = (Red, Yellow, Green);

procedure GetRTTIforMiscTypes;
var
  Context: TRttiContext;
  TempType: TRttiType;
  TempOrd: TRTTIOrdinalType;
  TempRecord: TRttiRecordType;
  TempMethod: TRttiMethod;
  TempField: TRttiField;
  TempArrayType: TRttiArrayType;
begin
  // Ordinal
  TempType := Context.GetType(TypeInfo(Byte));
  if TempType.IsOrdinal then
  begin
    TempOrd := TempType as TRTTIOrdinalType;
    WriteLn('The minimum value for ', TempOrd.Name, ' is: ', TempOrd.MinValue);
    WriteLn('The maximum value for ', TempOrd.Name, ' is: ', TempOrd.MaxValue);
  end;
  WriteLn;

  // Record
  TempType := Context.GetType(TypeInfo(TDemoRecord));
  if TempType.IsRecord then
  begin
    TempRecord := TempType.AsRecord;
    WriteLn(TempRecord.Name, ' has the following methods: ');
    for TempMethod in TempRecord.GetMethods do
    begin
      WriteLn('  ', TempMethod.Name);
    end;
    WriteLn('... and the following fields:');
    for TempField in TempRecord.GetFields do
    begin
      WriteLn('  ', TempField.Name);
    end;
    WriteLn;
  end;

    // Arrays

  TempType := Context.GetType(TypeInfo(TThreeStringArray));
  if TempType.TypeKind = tkArray then
  begin
    TempArrayType := TempType as TRttiArrayType;
    WriteLn(TempArrayType.Name, ' is a ', TempArrayType.DimensionCount, ' dimension array with a total of ');
    WriteLn(TempArrayType.TotalElementCount, ' elements of type ', TempArrayType.ElementType.Name);
  end;


end;

{ TDemoRecord }

procedure TDemoRecord.DoSomething;
begin
  WriteLn('TDemoRecord.DoSomething');
end;

end.
