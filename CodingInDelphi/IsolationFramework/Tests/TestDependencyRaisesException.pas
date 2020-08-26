unit TestDependencyRaisesException;

interface

uses
       DUnitX.TestFramework
     ;

type
  [TestFixture]
  TTestWidgetProcessor = class
  public
    [Test]
    procedure TestBadWidgetRaisedException;
  end;

implementation

uses
          uDependencyRaisesObjection
        , Delphi.Mocks
        ;

{ TTestWidgetProcessor }

procedure TTestWidgetProcessor.TestBadWidgetRaisedException;
var
  CUT: IWidgetProcessor;
  MockWidget: TMock<IWidget>;
begin
  // Arrange
  MockWidget := TMock<IWidget>.Create;
  MockWidget.Setup.WillRaise(EInvalidWidgetException).When.IsValid;
  MockWidget.Setup.Expect.Once.When.IsValid;
  CUT := TWidgetProcessor.Create;
  // Act
  CUT.ProcessWidget(MockWidget);
  // Assert
  MockWidget.Verify();
end;

initialization
  TDUnitX.RegisterTestFixture(TTestWidgetProcessor);


end.
