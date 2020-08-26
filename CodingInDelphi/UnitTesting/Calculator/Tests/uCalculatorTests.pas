unit uCalculatorTests;

interface

uses
      uCalculator
    , DUnitX.TestFramework
    ;

type
  [TestFixture]
  TCalculatorTests = class
  private
    Expected, Actual: integer;
    Calculator: TCalculator;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestSimpleAddition;
    [Test]
    procedure TestAddingZero;
    [Test]
    procedure TestAddingTwoNegativeNumbers;
  end;

implementation

{ TCalculatorTests }

procedure TCalculatorTests.Setup;
begin
  Calculator := TCalculator.Create;
end;

procedure TCalculatorTests.TearDown;
begin
   Calculator.Free;
end;

procedure TCalculatorTests.TestSimpleAddition;
begin
  Expected := 4;
  Actual := Calculator.Add(2, 2);
  Assert.AreEqual(Expected, Actual, 'The calculator thinks that 2 + 2 is not 4!');
end;

procedure TCalculatorTests.TestAddingTwoNegativeNumbers;
begin
  Expected := -4;
  Actual := Calculator.Add(-2, -2);
  Assert.AreEqual(Expected, Actual, 'The Add function failed to realize that -2 + -2 is -4');
end;

procedure TCalculatorTests.TestAddingZero;
begin
  Expected := 4;
  Actual := Calculator.Add(4, 0);
  Assert.AreEqual(Expected, Actual, 'The calculator thinks that 4 + 0 is not 4!');
end;



initialization
  TDUnitX.RegisterTestFixture(TCalculatorTests);

end.
