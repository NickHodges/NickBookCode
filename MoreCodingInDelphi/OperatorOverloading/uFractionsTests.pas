  unit uFractionsTests;

interface
uses
    DUnitX.TestFramework
  , uFractions
  ;

type

  [TestFixture]
  TFractionTests = class(TObject)
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestSimpleAddition;
    [Test]
    procedure TestWhereResultBiggerThanOne;
    [Test]
    procedure TestSimpleSubtraction;
    [Test]
    procedure TestSubtractionResultLessThanZero;
    [Test]
    procedure TestSimpleMultiplication;
    [Test]
    procedure TestSimpleDivision;
    [Test]
    procedure TestSimpleNegation;
    [Test]
    procedure TestEquals;
    [Test]
    procedure TestNotEquals;
    [Test]
    procedure TestLessThanOrEqualsWhenEqual;
    [Test]
    procedure TestGreaterThanOrEqualsWhenEqual;
    [Test]
    procedure TestLessThanOrEqualsWhenLessThan;
    [Test]
    procedure TestGreaterThanOrEqualsWhenGreaterThan;
    [Test]
    procedure TestImplicitAssignement;
    [Test]
    procedure TestImplicitFromInteger;
    [Test]
    procedure TestAddDouble;
    [Test]
    procedure TestImplicitAssignmentDouble;
    [Test]
    procedure TestLessThan;
    [Test]
    procedure TestGreaterThan;
    [Test]
    procedure TestBothAreNegativeMeansAPositive;
    [Test]
    procedure TestNumeratorIsNegativeAndResultIsNegative;
    [Test]
    procedure TestDenominatorNegativeMeansANegative;
    [Test]
    procedure TestNegativeGetsMovedToNumerator;
    [Test]
    procedure TestNegativeWithNegativeDenominator;
    [Test]
    procedure TestNegativeWithNegativeNumerator;
    [Test]
    procedure TestNegativeWithBothNegative;
  end;

implementation

procedure TFractionTests.Setup;
begin
end;

procedure TFractionTests.TearDown;
begin
end;


procedure TFractionTests.TestSimpleMultiplication;
var
  a, b, c: TFraction;
begin
  a := TFraction.CreateFrom(5, 2);
  b := TFraction.CreateFrom(1, 3);
  c := a * b;
  Assert.AreEqual(5, c.Numerator);
  Assert.AreEqual(6, c.Denominator);
end;

procedure TFractionTests.TestSimpleNegation;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 2);
  b := -a;
  Assert.AreEqual(-1, b.Numerator);
  Assert.AreEqual(2, b.Denominator);
end;


procedure TFractionTests.TestAddDouble;
var
  a: TFraction;
  Actual: Double;
  Expected: Double;
begin
  a := TFraction.CreateFrom(1, 3);
  Actual := a + 0.5;
  Expected := 5/6;
  Assert.AreEqual(Expected, Actual);
end;

procedure TFractionTests.TestBothAreNegativeMeansAPositive;
var
  a: TFraction;
begin
  a := TFraction.CreateFrom(-1, -2);
  Assert.Istrue(a > 0);
  Assert.AreEqual(a.Numerator, 1);
  Assert.AreEqual(a.Denominator, 2);
end;

procedure TFractionTests.TestDenominatorNegativeMeansANegative;
var
  a: TFraction;
begin
  a := TFraction.CreateFrom(1, -2);
  Assert.Istrue(a < 0);
end;

procedure TFractionTests.TestEquals;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 2);
  b := TFraction.CreateFrom(2, 4);
  Assert.Istrue(a = b);
end;

procedure TFractionTests.TestGreaterThan;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(24, 25);
  b := TFraction.CreateFrom(2, 5);
  Assert.Istrue(a > b);
end;

procedure TFractionTests.TestGreaterThanOrEqualsWhenEqual;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 2);
  b := TFraction.CreateFrom(2, 4);
  Assert.Istrue(a >= b);
end;

procedure TFractionTests.TestGreaterThanOrEqualsWhenGreaterThan;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 2);
  b := TFraction.CreateFrom(2, 9);
  Assert.Istrue(a >= b);
end;

procedure TFractionTests.TestImplicitAssignement;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 2);
  b := a;
  Assert.IsTrue(a = b);
end;

procedure TFractionTests.TestImplicitAssignmentDouble;
var
  a: TFraction;
  D: Double;
begin
  a := TFraction.CreateFrom(1, 2);
  D := a;
  Assert.IsTrue(D = 0.5);
end;

procedure TFractionTests.TestImplicitFromInteger;
var
  a: TFraction;
begin
  a := 4;
  Assert.AreEqual(4, a.Numerator);
  Assert.AreEqual(1, a.Denominator);
end;

procedure TFractionTests.TestLessThan;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 200);
  b := TFraction.CreateFrom(2, 4);
  Assert.Istrue(a < b);
end;

procedure TFractionTests.TestLessThanOrEqualsWhenEqual;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 2);
  b := TFraction.CreateFrom(2, 4);
  Assert.Istrue(a <= b);
end;

procedure TFractionTests.TestLessThanOrEqualsWhenLessThan;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 100);
  b := TFraction.CreateFrom(2, 9);
  Assert.Istrue(a <= b);
end;

procedure TFractionTests.TestNegativeWithBothNegative;
var
  a: TFraction;
begin
  a := TFraction.CreateFrom(-1, -2);
  a := -a;
  Assert.IsTrue(a < 0);
end;
procedure TFractionTests.TestNegativeWithNegativeDenominator;
var
  a: TFraction;
begin
  a := TFraction.CreateFrom(1, -2);
  a := -a;
  Assert.IsTrue(a > 0);
end;

procedure TFractionTests.TestNegativeWithNegativeNumerator;
var
  a: TFraction;
begin
  a := TFraction.CreateFrom(-1, 2);
  a := -a;
  Assert.IsTrue(a > 0);
end;

procedure TFractionTests.TestNegativeGetsMovedToNumerator;
var
  a: TFraction;
begin
  a := TFraction.CreateFrom(1, -2);
  Assert.AreEqual(a.Numerator, -1);
  Assert.AreEqual(a.Denominator, 2);
end;


procedure TFractionTests.TestNotEquals;
var
  a, b: TFraction;
begin
  a := TFraction.CreateFrom(1, 2);
  b := TFraction.CreateFrom(37, 992);
  Assert.Istrue(a <> b);
end;

procedure TFractionTests.TestNumeratorIsNegativeAndResultIsNegative;
var
  a: TFraction;
begin
  a := TFraction.CreateFrom(-1, 2);
  Assert.Istrue(a < 0);
end;

procedure TFractionTests.TestSimpleAddition;
var
  a, b, c: TFraction;
begin
  a := TFraction.CreateFrom(1, 2);
  b := TFraction.CreateFrom(1, 3);
  c := a + b;
  Assert.AreEqual(5, c.Numerator);
  Assert.AreEqual(6, c.Denominator);
end;

procedure TFractionTests.TestSimpleDivision;
var
  a, b, c: TFraction;
begin
  a := TFraction.CreateFrom(5, 6);
  b := TFraction.CreateFrom(1, 3);
  c := a / b;
  Assert.AreEqual(5, c.Numerator);
  Assert.AreEqual(2, c.Denominator);
end;

procedure TFractionTests.TestSimpleSubtraction;
var
  a, b, c: TFraction;
begin
  a := TFraction.CreateFrom(5, 6);
  b := TFraction.CreateFrom(1, 3);
  c := a - b;
  Assert.AreEqual(1, c.Numerator);
  Assert.AreEqual(2, c.Denominator);
end;

procedure TFractionTests.TestSubtractionResultLessThanZero;
var
  a, b, c: TFraction;
begin
  a := TFraction.CreateFrom(1, 3);
  b := TFraction.CreateFrom(5, 6);
  c := a - b;
  Assert.AreEqual(-1, c.Numerator);
  Assert.AreEqual(2, c.Denominator);
end;

procedure TFractionTests.TestWhereResultBiggerThanOne;
var
  a, b, c: TFraction;
begin
  a := TFraction.CreateFrom(5, 6);
  b := TFraction.CreateFrom(1, 3);
  c := a + b;
  Assert.AreEqual(7, c.Numerator);
  Assert.AreEqual(6, c.Denominator);
end;

initialization
  TDUnitX.RegisterTestFixture(TFractionTests);
end.
