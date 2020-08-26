unit uSimpleStubDemoTests;

interface

uses
      DUnitX.TestFramework
    , uSimpleStubDemo
    ;

type
  [TestFixture]
  TDollarToGalleonConverterTest = class
  public
    [Test]
    procedure TestPointFiveCutsDollarsinHalf;
    [Test]
    procedure TestThatLoggerIsProperlyCalled;
  end;

implementation

uses
      Delphi.Mocks
    , SysUtils
    ;

{ TDollarToGalleonConverterTest }


procedure TDollarToGalleonConverterTest.TestPointFiveCutsDollarsinHalf;
var
  Expected: Double;
  Actual: Double;
  TempConverter: TDollarToGalleonsConverter;
  TempLogger: TMock<ILogger>;
begin
  //Arrange
  TempLogger := TMock<ILogger>.Create;
  TempConverter := TDollarToGalleonsConverter.Create(TempLogger);
  try
    Expected := 1.0;
    //Act
    Actual := TempConverter.ConvertDollarsToGalleons(2, 0.5);
    //Assert
    Assert.AreEqual(Expected, Actual, 'Converter failed to convert 2 dollars to 1 galleon');
  finally
    TempConverter.Free;
  end;
end;

procedure TDollarToGalleonConverterTest.TestThatLoggerIsProperlyCalled;
var
  Expected: Double;
  Actual: Double;
  TempConverter: TDollarToGalleonsConverter;
  TempLogger: TMock<ILogger>;
  Input: Double;
  TempMessage: string;
begin
  //Arrange
  TempLogger := TMock<ILogger>.Create;
  Input := 2.0;
  Expected := 1.0;
  TempMessage := Format('Converted %f dollars to %f Galleons', [Input, Expected]);
  TempLogger.Setup.Expect.Once.When.Log(TempMessage);
  TempConverter := TDollarToGalleonsConverter.Create(TempLogger);
  try
    //Act
    Actual := TempConverter.ConvertDollarsToGalleons(Input, 0.5);
    //Assert
    TempLogger.Verify();
  finally
    TempConverter.Free;
  end;

end;

initialization
  TDUnitX.RegisterTestFixture(TDollarToGalleonConverterTest);

end.
