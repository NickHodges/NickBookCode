unit RttiContext_GetTypes_vs_GetType_on_Interfaces_ConsoleReportUnit;

interface

uses
  System.Rtti;

procedure ReportRttiTypes(const RttiContext: TRttiContext; const AInterfaceGUID: TGUID; const InterfaceName: string;
    const InterfaceTypeInfo: Pointer);

procedure ReportImplementedInterfacesByClass(const RttiContext: TRttiContext; const ClassReference: TClass);

procedure ReportGetTypes(const RttiContext: TRttiContext);

implementation

uses
  System.SysUtils,
  System.TypInfo,
  RttiHelpers;

procedure Log(const RttiInterfaceType: TRttiInterfaceType);
begin
  Writeln(Format('Found GUID "%s" with best %s name "%s"', [
    RttiInterfaceType.GUID.ToString(), RttiInterfaceType.GetProtectionString(), RttiInterfaceType.GetMostQualifiedName()]));
end;

function GetRttiInterfaceType(const RttiContext: TRttiContext; const ATypeInfo: Pointer): TRttiInterfaceType; overload;
begin
  Result := RttiContext.GetType(ATypeInfo) as TRttiInterfaceType;
//  if Assigned(Result) then
//    Log(Result);
end;

procedure ReportRttiTypesComparison(const RttiType_ByGUID, RttiType_ByInterfaceTypeInfo: TRttiInterfaceType; const InterfaceName: string);
var
  GUIDbyGUID: string;
begin
  if Assigned(RttiType_ByGUID) then
  begin
    GUIDbyGUID := GUIDToString(RttiType_ByGUID.GUID);
    if Assigned(RttiType_ByInterfaceTypeInfo) then
    begin
      Write('RTTI by GUID and RTTI by TypeInfo have ');
      if (RttiType_ByGUID.GUID = RttiType_ByInterfaceTypeInfo.GUID) then
        Writeln('the same GUID: ', GUIDbyGUID)
      else
        Writeln(Format('different GUIDs; by GUID: %s, byte TypeInfo: %s', [GUIDbyGUID, GUIDToString(RttiType_ByInterfaceTypeInfo.GUID)]));
    end
    else
      Writeln('RTTI by TypeInfo is nil, but RTTI by GUID has a GUID: ', GUIDbyGUID);
  end
  else
  begin
    if Assigned(RttiType_ByInterfaceTypeInfo) then
      Writeln('RTTI by GUID is nil, but RTTI by TypeInfo has a GUID: ', GUIDToString(RttiType_ByInterfaceTypeInfo.GUID))
    else
      Writeln('RTTI by GUID and RTTI by TypeInfo are both nil.');
  end;
end;

procedure ReportRttiTypes(const RttiContext: TRttiContext; const AInterfaceGUID: TGUID; const InterfaceName: string;
    const InterfaceTypeInfo: Pointer);
var
  RttiType_ByInterfaceTypeInfo: TRttiInterfaceType;
  RttiType_ByGUID: TRttiInterfaceType;
  NameFromTypeInfo: string;
  NameFromGuid: string;
begin
  Writeln(Format('TRttiType occurances for interface "%s" with GUID "%s"', [InterfaceName, AInterfaceGUID.ToString()]));

  if Assigned(InterfaceTypeInfo) then
  begin
    RttiType_ByInterfaceTypeInfo := GetRttiInterfaceType(RttiContext, InterfaceTypeInfo);
    if (nil = RttiType_ByInterfaceTypeInfo) then
      Writeln('  no RttiInterfaceType from InterfaceTypeInfo')
    else
      Writeln('  GUID from InterfaceTypeInfo: ', RttiType_ByInterfaceTypeInfo.GUID.ToString());
  end
  else
  begin
    Writeln('  no InterfaceTypeInfo');
    RttiType_ByInterfaceTypeInfo := nil;
  end;

  RttiType_ByGUID := RttiContext.FindType(AInterfaceGUID);
  if (nil = RttiType_ByGUID) then
    Writeln(Format('  RttiInterfaceType not found through GUID "%s"', [GUIDToString(AInterfaceGUID)]))
  else
  begin
    if (nil <> RttiType_ByInterfaceTypeInfo) then
    begin
      if (RttiType_ByGUID.GUID <> RttiType_ByInterfaceTypeInfo.GUID) then
        Writeln('  GUID mismatch: ', RttiType_ByGUID.GUID.ToString());

      NameFromGuid := RttiType_ByGUID.GetMostQualifiedName();
      NameFromTypeInfo := RttiType_ByInterfaceTypeInfo.GetMostQualifiedName();
      if (NameFromGuid <> NameFromTypeInfo) then
        Writeln('  name mismatch: ', NameFromGuid, ' <> ', NameFromTypeInfo);
      Writeln('  RttiInterfaceType found by TypeInfo:');
      Write('    ');
      Log(RttiType_ByInterfaceTypeInfo);
    end;
    Writeln('  RttiInterfaceType found by GUID:');
    Write('    ');
    Log(RttiType_ByGUID);
  end;

  ReportRttiTypesComparison(RttiType_ByGUID, RttiType_ByInterfaceTypeInfo, InterfaceName);

  Writeln;
end;

procedure ReportImplementedInterfacesByClass(const RttiContext: TRttiContext; const ClassReference: TClass);
type
  PIntfs = ^TIntfs;
  TIntfs = array[0..9999{EntryCount - 1}] of PPTypeInfo;
  // From the System unit; Intfs is right after the TInterfaceEntry.Entries table
  //    {Intfs: array[0..EntryCount - 1] of PPTypeInfo;}
var
  ClassQualifiedClassName: string;
  ClassRttiType: TRttiType;
  CurrentClassReference: TClass;
  EntryCount: Integer;
  Index : integer;
  InterfaceTable: PInterfaceTable;
  InterfaceTable_Intfs: PIntfs;
  InterfaceEntry: PInterfaceEntry;
  InterfaceGUID: TGUID;
  RttiType_ByGUID: TRttiInterfaceType;
begin
  CurrentClassReference := ClassReference;
  while Assigned(CurrentClassReference) do
  begin
    ClassRttiType := RttiContext.GetType(CurrentClassReference);
    Write(ClassRttiType.GetProtectionString());
    ClassQualifiedClassName := CurrentClassReference.QualifiedClassName;
    Write(Format(' "%s"', [ClassQualifiedClassName]));
    InterfaceTable := CurrentClassReference.GetInterfaceTable;
    if Assigned(InterfaceTable) then
    begin
      Writeln(Format(' with RTTI name "%s"', [ClassRttiType.GetMostQualifiedName()]));
      EntryCount := InterfaceTable.EntryCount;
      Writeln(Format(' implements %d interfaces:', [EntryCount]));
      InterfaceTable_Intfs := @InterfaceTable.Entries[EntryCount]; // right after the final Entries entry.
      for Index := 0 to EntryCount-1 do
      begin
        InterfaceEntry := @InterfaceTable.Entries[Index];
        InterfaceGUID := InterfaceEntry.IID;
        Writeln(Format('  Interface at index %d has GUID "%s"', [Index, GUIDToString(InterfaceGUID)]));

        RttiType_ByGUID := RttiContext.FindType(InterfaceGUID);
        if (nil = RttiType_ByGUID) then
          Writeln(Format('  interface RTTI not found through GUID "%s"', [GUIDToString(InterfaceGUID)]))
        else
        begin
          Write('  ');
          Log(RttiType_ByGUID);
          Writeln('    ', RttiContext.GetMostQualifiedName(ClassRttiType, RttiType_ByGUID));
        end;
      end;
    end
    else
      Writeln(' implements no interfaces');
    CurrentClassReference := CurrentClassReference.ClassParent;
  end;
  Writeln;
end;

procedure ReportGetTypes(const RttiContext: TRttiContext);
var
  RttiTypes: TArray<TRttiType>;
  RttiType: TRttiType;
begin
  RttiTypes := RttiContext.GetTypes();
  for RttiType in RttiTypes do
  begin
    Write(Format('%s best name "%s"', [RttiType.GetProtectionString(), RttiType.GetMostQualifiedName()]));
    if RttiType.IsInstance then
      Writeln(Format(' with QualifiedClassName "%s"', [TRttiInstanceType(RttiType).MetaclassType.QualifiedClassName]))
    else
      Writeln;
  end;
end;

end.
