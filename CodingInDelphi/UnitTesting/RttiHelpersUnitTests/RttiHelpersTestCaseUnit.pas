{ Copyright (c) 2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit RttiHelpersTestCaseUnit;

interface

uses
  TestFramework, System.Rtti;

type
  TRttiHelpersTestCase = class(TTestCase)
  strict protected
    procedure CheckRttiClassTypes(const RttiContext: TRttiContext; const TheClass:
        TClass); virtual;
    procedure CheckRttiInterfaceTypeConsistency(const RttiType_ByGUID, RttiType_ByInterfaceTypeInfo: TRttiInterfaceType); virtual;
    procedure CheckRttiInterfaceTypes(const RttiContext: TRttiContext; const
        InterfaceTypeInfo: Pointer; const InterfaceGUID: TGUID); virtual;
    function GetRttiInterfaceType(const RttiContext: TRttiContext; const ATypeInfo: Pointer):
        TRttiInterfaceType; virtual;
  public
    procedure CheckEquals(expected, actual: TGUID; msg: string = ''); overload;
        virtual;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure Test_TObjectHelper_ClassHierarchyDepth();
    procedure Test_TRttiContextHelper_FindType();
    procedure Test_TRttiContextHelper_FindTypes();
    procedure Test_TRttiContextHelper_FindType_TGUID();
    procedure Test_TRttiContextHelper_GetType_TObject();
    procedure Test_TRttiTypeHelper_GetBestName();
    procedure Test_TRttiTypeHelper_GetUnitName();
  end;

  IPublicInterface = interface(IInterface)
  ['{18599D60-E4E1-47D5-B7E9-A1B55C0097D8}']
  end;

  TPublicClass = class(TObject)
  end;

implementation

uses
  RttiHelpers,
  System.SysUtils;

type
  IPrivateInterface = interface(IInterface)
  ['{39F45E68-4E07-4329-976D-441AA54EB1B8}']
  end;

  TPrivateClass = class(TObject)
  end;

procedure TRttiHelpersTestCase.CheckRttiClassTypes(const RttiContext:
    TRttiContext; const TheClass: TClass);
var
  RttiType_ByClass: TRttiType;
  RttiType_ByName: TRttiType;
begin
  RttiType_ByClass := RttiContext.GetType(TheClass);
  RttiType_ByName := RttiContext.FindType(TheClass.QualifiedClassName);
  if RttiType_ByClass.IsPublicType then
    CheckEqualsString(RttiType_ByName.QualifiedName, RttiType_ByClass.QualifiedName)
  else
    if Assigned(RttiType_ByName) then // non-public types cannot be found by QualifiedClassName
      CheckEqualsString(RttiType_ByName.Name, RttiType_ByClass.Name);
end;

procedure TRttiHelpersTestCase.CheckRttiInterfaceTypeConsistency(const RttiType_ByGUID, RttiType_ByInterfaceTypeInfo: TRttiInterfaceType);
begin
  Self.Check(nil <> RttiType_ByInterfaceTypeInfo);
  // when IsPublicType, you:
  // - have a QualifiedName, and
  // - can find it through RttiContext.GetTypes (by GUID goes through RttiContext.GetTypes).
  if RttiType_ByInterfaceTypeInfo.IsPublicType then
  begin
    Self.Check(nil <> RttiType_ByGUID);
    Self.CheckEqualsString(RttiType_ByGUID.QualifiedName, RttiType_ByInterfaceTypeInfo.QualifiedName);
    Self.CheckEquals(RttiType_ByGUID.GUID, RttiType_ByInterfaceTypeInfo.GUID);
  end
  else
    Self.Check(nil = RttiType_ByGUID);
end;

procedure TRttiHelpersTestCase.CheckRttiInterfaceTypes(const RttiContext:
    TRttiContext; const InterfaceTypeInfo: Pointer; const InterfaceGUID: TGUID);
var
  RttiType_ByInterfaceTypeInfo: TRttiInterfaceType;
  RttiType_ByGUID: TRttiInterfaceType;
begin
  RttiType_ByInterfaceTypeInfo := GetRttiInterfaceType(RttiContext, InterfaceTypeInfo);
  RttiType_ByGUID := RttiContext.FindType(InterfaceGUID);
  CheckRttiInterfaceTypeConsistency(RttiType_ByGUID, RttiType_ByInterfaceTypeInfo);
end;

function TRttiHelpersTestCase.GetRttiInterfaceType(const RttiContext: TRttiContext; const
    ATypeInfo: Pointer): TRttiInterfaceType;
begin
  Result := RttiContext.GetType(ATypeInfo) as TRttiInterfaceType;
end;

procedure TRttiHelpersTestCase.CheckEquals(expected, actual: TGUID; msg: string
    = '');
begin
  FCheckCalled := True;
  if (expected <> actual) then
    FailNotEquals(expected.ToString(), actual.ToString(), msg, ReturnAddress);
end;

procedure TRttiHelpersTestCase.SetUp;
begin
end;

procedure TRttiHelpersTestCase.TearDown;
begin
end;

procedure TRttiHelpersTestCase.Test_TObjectHelper_ClassHierarchyDepth();
var
  Depth: Integer;
begin
  Depth := TObject.ClassHierarchyDepth();
  Self.CheckEquals(1, Depth);
  Depth := TMarshal.ClassHierarchyDepth();
  Self.CheckEquals(2, Depth);
end;

procedure TRttiHelpersTestCase.Test_TRttiContextHelper_FindType();
var
  RttiContext: TRttiContext;
begin
  RttiContext := TRttiContext.Create();
  try
    CheckRttiClassTypes(RttiContext, Self.ClassType);
    CheckRttiClassTypes(RttiContext, TPublicClass);
    CheckRttiClassTypes(RttiContext, TPrivateClass);
  finally
    RttiContext.Free;
  end;
end;

procedure TRttiHelpersTestCase.Test_TRttiContextHelper_FindTypes();
const
  NumberOfPublicTypesInThisUnit = 3;
var
  Predicate: TPredicate<TRttiType>;
  RttiContext: TRttiContext;
  RttiTypes: TArray<TRttiType>;
  RttiType: TRttiType;
begin
  Predicate := function(ARttiType: TRttiType): Boolean
  begin
    Result := ARttiType.GetUnitName = Self.ClassType.UnitName;
  end;

  RttiContext := TRttiContext.Create();
  try
    RttiTypes := RttiContext.FindTypes(Predicate);

    Self.CheckEquals(NumberOfPublicTypesInThisUnit, Length(RttiTypes));

    RttiType := RttiTypes[0];
    Self.CheckEqualsString(Self.QualifiedClassName, RttiType.QualifiedName);
  finally
    RttiContext.Free;
  end;
end;

procedure TRttiHelpersTestCase.Test_TRttiContextHelper_FindType_TGUID();
var
  RttiContext: TRttiContext;
  RttiType_ByGeneric: TRttiType;
begin
  RttiContext := TRttiContext.Create();
  try
    CheckRttiInterfaceTypes(RttiContext, TypeInfo(ITest), ITest);
    CheckRttiInterfaceTypes(RttiContext, TypeInfo(IInterface), IInterface);
    CheckRttiInterfaceTypes(RttiContext, TypeInfo(IPublicInterface), IPublicInterface);
    // IPrivateInterface should generate interface RTTI by TypeInfo
    // IPrivateInterface should not generate interface RTTI by GUID
    CheckRttiInterfaceTypes(RttiContext, TypeInfo(IPrivateInterface), IPrivateInterface);

    RttiType_ByGeneric := RttiContext.GetType<ITest>();
    (*
    Need to check these:
    - Public/Private interface/class with/without TypeInfo (8 permutations)
    *)
  finally
    RttiContext.Free;
  end;
end;

procedure TRttiHelpersTestCase.Test_TRttiContextHelper_GetType_TObject();
var
  RttiContext: TRttiContext;
  RttiType_ByInstance: TRttiInstanceType;
  RttiType_ByClass: TRttiType;
begin
  RttiContext := TRttiContext.Create();
  try
    RttiType_ByClass := RttiContext.GetType(Self.ClassType);
    RttiType_ByInstance := RttiContext.GetType(Self);

    Self.CheckEqualsString(RttiType_ByInstance.QualifiedName, RttiType_ByClass.QualifiedName);
  finally
    RttiContext.Free;
  end;
end;

procedure TRttiHelpersTestCase.Test_TRttiTypeHelper_GetBestName();
var
  BestName: string;
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  TypeName: string;
  UnitName: string;
  QualifiedName: string;
begin
  RttiContext := TRttiContext.Create();
  try
    RttiType := RttiContext.GetType<TPublicClass>();
    BestName := RttiType.GetBestName();
    CheckEqualsString(TPublicClass.QualifiedClassName, BestName);

    RttiType := RttiContext.GetType<IPublicInterface>();
    BestName := RttiType.GetBestName();
    CheckEqualsString(Self.ClassType.UnitName + '.' + RttiType.Name, BestName);

    RttiType := RttiContext.GetType<TPrivateClass>();
    BestName := RttiType.GetBestName();
    CheckEqualsString(TPrivateClass.ClassName, BestName); // no unit prefix: private type

    RttiType := RttiContext.GetType<IPrivateInterface>();
    BestName := RttiType.GetBestName();
    CheckEqualsString(RttiType.Name, BestName); // no unit prefix: private type
  finally
    RttiContext.Free;
  end;
end;

procedure TRttiHelpersTestCase.Test_TRttiTypeHelper_GetUnitName();
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  TypeName: string;
  UnitName: string;
  QualifiedName: string;
begin
  RttiContext := TRttiContext.Create();
  try
    // do not pass only Self, because that will call the TRttiContext.GetType(ATypeInfo: Pointer) overload
    RttiType := RttiContext.GetType(Self.ClassType);
    UnitName := RttiType.GetUnitName();
    CheckEqualsString(Self.ClassType.UnitName, UnitName);

    TypeName := Self.ClassName;
    QualifiedName := Format('%s.%s', [UnitName, TypeName]);
    CheckEqualsString(QualifiedName, RttiType.QualifiedName);
  finally
    RttiContext.Free;
  end;
end;

initialization
  RegisterTest(TRttiHelpersTestCase.Suite);
end.
