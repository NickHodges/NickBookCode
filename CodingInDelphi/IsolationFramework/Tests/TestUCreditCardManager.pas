unit TestUCreditCardManager;

interface

uses
        DUnitX.TestFramework
      , uCreditCardValidator
      , uCreditCardManager
      ;

type

  TestTCCValidator = class
  public
    [Test]
    procedure TestCardChargeReturnsProperAmountWhenCardIsGood;
    [Test]
    procedure TestCardChargeReturnsZeroWhenCCIsBad;
  end;

implementation

uses
      Delphi.Mocks
    ;


procedure TestTCCValidator.TestCardChargeReturnsProperAmountWhenCardIsGood;
var
  CCManager: TCreditCardManager;
  CCValidator: TMock<ICreditCardValidator>;
  GoodCard: String;
  Input: Double;
  Expected, Actual: Double;
begin
  //Arrange
  GoodCard := '123456';
  Input := 49.95;
  Expected := Input;
  CCValidator := TMock<ICreditCardValidator>.Create;
  CCValidator.Setup.WillReturn(True).When.IsCreditCardValid(GoodCard);

  CCManager := TCreditCardManager.Create(CCValidator);
  try
    //Act
    Actual := CCManager.ProcessCreditCard(GoodCard, Input)
  finally
    CCManager.Free;
  end;
  // Assert
  Assert.AreEqual(Expected, Actual);
end;

procedure TestTCCValidator.TestCardChargeReturnsZeroWhenCCIsBad;
var
  CCManager: TCreditCardManager;
  CCValidator: TMock<ICreditCardValidator>;
  GoodCard: String;
  Input: Double;
  Expected, Actual: Double;
begin
  //Arrange
  GoodCard := '777777';  // 7 in a card makes it bad.....
  Input := 49.95;
  Expected := 0;
  CCValidator := TMock<ICreditCardValidator>.Create;
  CCValidator.Setup.WillReturn(False).When.IsCreditCardValid(GoodCard);

  CCManager := TCreditCardManager.Create(CCValidator);
  try
    //Act
    Actual := CCManager.ProcessCreditCard(GoodCard, Input)
  finally
    CCManager.Free;
  end;
  // Assert
  Assert.AreEqual(Expected, Actual);
end;


initialization
  TDUnitX.RegisterTestFixture(TestTCCValidator);
end.


