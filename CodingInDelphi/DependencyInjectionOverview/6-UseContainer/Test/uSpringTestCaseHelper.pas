unit uSpringTestCaseHelper;

interface

uses
  TestFramework;

type
  TSpringTestCaseHelper = class helper for TTestCase
  protected // note this cannot be strict protected, as a TTestCase descendant cannot use it
    procedure TestInterfaceImplementedByClass(const FInterface: IInterface;
      const ClassType: TClass; const InstanceDescription: string); virtual;
    procedure TestInterfaceNotImplementedByClass(const FInterface: IInterface; const ClassType: TClass; const
        InstanceDescription: string); virtual;
  end;

implementation

uses
  SysUtils,
  Spring;

procedure TSpringTestCaseHelper.TestInterfaceImplementedByClass(const FInterface
  : IInterface; const ClassType: TClass; const InstanceDescription: string);
var
  Instance: TObject;
begin
  // as of Delphi 2010, you can cast back from an interface to the implementing class;
  // see http://stackoverflow.com/questions/4138211/how-to-cast-a-interface-to-a-object-in-delphi/11167316#11167316
  Instance := FInterface as TObject;
  Check(Instance.InheritsFrom(ClassType),
    Format('%s class "%s" does not inherit from "%s".', [InstanceDescription,
      GetQualifiedClassName(Instance), GetQualifiedClassName(ClassType)]));
end;

procedure TSpringTestCaseHelper.TestInterfaceNotImplementedByClass(const FInterface: IInterface; const ClassType:
    TClass; const InstanceDescription: string);
var
  Instance: TObject;
begin
  // as of Delphi 2010, you can cast back from an interface to the implementing class;
  // see http://stackoverflow.com/questions/4138211/how-to-cast-a-interface-to-a-object-in-delphi/11167316#11167316
  Instance := FInterface as TObject;
  Check(Instance.InheritsFrom(ClassType),
    Format('%s class "%s" does inherit from "%s", but should not.', [InstanceDescription,
      GetQualifiedClassName(Instance), GetQualifiedClassName(ClassType)]));
end;

end.
