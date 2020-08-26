unit uSimpleUnitTests;

interface

uses
      System.SysUtils
    ;

type
  TestSuiteAttribute = class(TCustomAttribute);
  TestAttribute = class(TCustomAttribute);

type

  TTestHarness = class(TObject);

  [TestSuite]
  TMyTestHarness = class(TTestHarness)
    [Test]
    procedure TestSomething;
    [Test]
    procedure TestAnotherThing;
    procedure NotaTest;
  end;

 TTestRunner = class
   class procedure RunTests(aTestHarness: TTestHarness); static;
 end;

 procedure RunTheTests;

implementation

uses
       RTTI
     ;


procedure RunTheTests;
var
  TempHarness: TMyTestHarness;
begin
  TempHarness := TMyTestHarness.Create;
  try
    TTestRunner.RunTests(TempHarness);
  finally
    TempHarness.Free;
  end;
end;

{ TMyTestHarness }

procedure TMyTestHarness.NotaTest;
begin
  WriteLn('This is not a test and so you shouldn''t be reading this');
end;

procedure TMyTestHarness.TestAnotherThing;
begin
  WriteLn('TestAnotherThing passed');
end;

procedure TMyTestHarness.TestSomething;
begin
  WriteLn('TestSomething passed');
end;

{ TTestRunner }

class procedure TTestRunner.RunTests(aTestHarness: TTestHarness);
var
  Context: TRttiContext;
  TempType: TRttiType;
  TempAttribute: TCustomAttribute;
  TempMethod: TRttiMethod;
  TempTestAttribute: TObject;
begin
  TempType := Context.GetType(aTestHarness.ClassInfo);
  for TempAttribute in TempType.GetAttributes do
  begin
    if TempAttribute is TestSuiteAttribute then
    begin
      for TempMethod in TempType.GetMethods do
      begin
        for TempTestAttribute in TempMethod.GetAttributes do
        begin
          if TempTestAttribute is TestAttribute then
          begin
            TempMethod.Invoke(aTestHarness, []);
          end;
        end;
      end;
    end;
  end;
end;

end.

