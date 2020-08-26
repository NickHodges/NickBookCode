{ Copyright (c) 2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit RttiHelpers;

interface

uses
  System.Rtti,
  System.SysUtils;

type
  TRttiTypeHelper = class helper for TRttiType
    function GetMostQualifiedName(): string; virtual;
    function GetProtectionString(): string;
    function GetUnitName(): string; virtual;
  end;

  /// Find versus Get: Find* might return nil or empty lists, Get* won't.
  TRttiContextHelper = record helper for TRttiContext
    function FindType(const AInterfaceGUID: TGUID): TRttiInterfaceType; overload;
    function FindTypes(const Predicate: TPredicate<TRttiType>): TArray<TRttiType>;
        overload;
    function GetMostQualifiedName<TClass: class; TInterface: IInterface>(): string; overload;
    function GetMostQualifiedName(const ClassRttiType, InterfaceRttiType: TRttiType): string; overload;
    function GetType(const AnInstance: TObject): TRttiInstanceType; overload;
    function GetType<T>(): TRttiType; overload;
  end;

  TObjectHelper = class helper for TObject
    {$REGION 'Documentation'}
    ///	<summary>
    ///	  <para>
    ///	    The way to write a `helper for class` is by creating a `helper for
    ///	    object`, then implement a class method.
    ///	  </para>
    ///	  <para>
    ///	    A `class` method in an `object` helper for TObject can be called
    ///	    from a TClass too.
    ///	  </para>
    ///	</summary>
    {$ENDREGION}
    class function ClassHierarchyDepth(): Integer;
  end;

implementation

uses
{$ifdef StrictGetType}
  System.SysConst,
{$endif StrictGetType}
  System.Generics.Collections;

function TRttiTypeHelper.GetMostQualifiedName(): string;
begin
  // you cannot ask for QualifiedName on a non-public RttiType
  if Self.IsPublicType then
    Result := Self.QualifiedName
  else
    Result := Self.Name;
end;

function TRttiTypeHelper.GetProtectionString(): string;
begin
  if IsPublicType then
    Result := 'public'
  else
    Result := 'private';
end;

function TRttiTypeHelper.GetUnitName(): string;
begin
  Result := Copy(QualifiedName, 1, Length(QualifiedName) - Length(Name) - 1);
end;

function TRttiContextHelper.FindType(const AInterfaceGUID: TGUID):
    TRttiInterfaceType;
var
  InterfaceGUID: TGUID;
  Predicate: TPredicate<TRttiType>;
  RttiInterfaceType: TRttiInterfaceType;
  RttiType: TRttiType;
  RttiTypes: TArray<TRttiType>;
  RttiTypesCount: Integer;
begin
  InterfaceGUID := AInterfaceGUID; // to cicrumvent "E2555 Cannot capture symbol 'AInterfaceGUID'"
  Predicate := function(ARttiType: TRttiType): Boolean
  begin
    if ARttiType is TRttiInterfaceType then
    begin
      RttiInterfaceType := TRttiInterfaceType(ARttiType);
      Result := RttiInterfaceType.GUID = InterfaceGUID;
    end
    else
      Result := False;
  end;

  RttiTypes := FindTypes(Predicate);
  RttiTypesCount := Length(RttiTypes);
  if RttiTypesCount = 1 then
  begin
    RttiType := RttiTypes[0];
    if RttiType is TRttiInterfaceType then
      Result := TRttiInterfaceType(RttiType)
    else
    begin
{$ifdef StrictGetType}
      raise ENotSupportedException.CreateFmt('Class %s not supported as interface RTTI', [RttiType.ClassName]);
{$else}
      Result := nil; // the System.Rtti is not strict, returns nil upon failures.
{$endif StrictGetType}
    end;
  end
  else
  begin
{$ifdef StrictGetType}
    raise ERangeError.CreateFmt('%s, Expected 1 result, got %d', [SRangeError, RttiTypesCount]);
{$else}
    Result := nil; // the System.Rtti is not strict, returns nil upon failures.
{$endif StrictGetType}
  end;
end;

function TRttiContextHelper.FindTypes(const Predicate: TPredicate<TRttiType>):
    TArray<TRttiType>;
var
  AllRttiTypes: TArray<TRttiType>;
  FilteredRttiTypes: TList<TRttiType>;
  RttiType: TRttiType;
begin
  AllRttiTypes := GetTypes();
  FilteredRttiTypes := TList<TRttiType>.Create();
  try
    for RttiType in AllRttiTypes do
    begin
      if Predicate(RttiType) then
        FilteredRttiTypes.Add(RttiType);
    end;
    Result := FilteredRttiTypes.ToArray();
  finally
    FilteredRttiTypes.Free;
  end;
end;

function TRttiContextHelper.GetMostQualifiedName(const ClassRttiType, InterfaceRttiType: TRttiType): string;
var
  TClassName: string;
  TInterfaceName: string;
begin
  TClassName := ClassRttiType.GetMostQualifiedName();
  TInterfaceName := InterfaceRttiType.GetMostQualifiedName();
  Result := TClassName + '.' + TInterfaceName;
end;

function TRttiContextHelper.GetMostQualifiedName<TClass, TInterface>(): string;
var
  ClassRttiType: TRttiType;
  InterfaceRttiType: TRttiType;
begin
  ClassRttiType := GetType<TClass>();
  InterfaceRttiType := GetType<TInterface>();
  Result := GetMostQualifiedName(ClassRttiType, InterfaceRttiType);
end;

function TRttiContextHelper.GetType(const AnInstance: TObject):
    TRttiInstanceType;
begin
  Result := GetType(AnInstance.ClassType).AsInstance;
end;

function TRttiContextHelper.GetType<T>(): TRttiType;
begin
  Result := GetType(TypeInfo(T));
end;

class function TObjectHelper.ClassHierarchyDepth(): Integer;
var
  Parent: TClass;
begin
  Result := 0;
  Parent := Self;
  while Parent <> nil do
  begin
    Inc(Result);
    Parent := Parent.ClassParent;
  end;
end;

end.

