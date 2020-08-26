unit TestDependencyMeetsExpectation;

interface

uses
      uDependencyMeetsExpectations
    , DUnitX.TestFramework
    ;

type
  [TestFixture]
  TEmailManagerTester = class
  public
    [Test]
    procedure TestAddingPersonSendingOneEmail;
  end;

implementation

uses
      Delphi.Mocks
    , Classes
    ;

{ TEmailManagerTester }

procedure TEmailManagerTester.TestAddingPersonSendingOneEmail;
var
  CUT: TEmailListManager;
  MockSender: TMock<IEmailSender>;
  StubSL: TMock<TStringList>;
begin
  // Arrange

  MockSender := TMock<IEmailSender>.Create;
  MockSender.Setup.Expect.Once.When.SendMail(TestEmail, TestMessage);
  MockSender.Setup. Expect.Never.When.SendBulkEmail;

  CUT := TEmailListManager.Create(MockSender);
  try
    // Act
    CUT.RegisterNewPerson('Marvin Martian', TestEmail);
  finally
    CUT.Free;
  end;

  // Assert
  MockSender.Verify();

end;

initialization
  TDUnitX.RegisterTestFixture(TEmailManagerTester);

end.
