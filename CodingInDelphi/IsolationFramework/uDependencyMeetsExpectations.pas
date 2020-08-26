unit uDependencyMeetsExpectations;

interface

uses
      Classes
    ;

type
  IEmailSender = interface(IInvokable)
    procedure SendMail(aEmailAddress: string; aMessage: string);
    procedure SendBulkEmail;
  end;

  TEMailSender = class(TInterfacedObject, IEmailSender)
    procedure SendMail(aEmailAddress: string; aMessage: string);
    procedure SendBulkEmail;
  end;

  TEmailListManager = class
  private
    FEmailSender: IEmailSender;
  public
    constructor Create(aEmailSender: IEmailSender);
    procedure RegisterNeWPerson(aName: string; aEmailAddress: string);
  end;

const
  TestMessage = 'Thanks for signing up!';
  TestEmail = 'marvinmartian@outerspace.com';

implementation

uses
      SysUtils
    ;

{ TEMailSender }

procedure TEMailSender.SendBulkEmail;
begin
  WriteLn('I send a whole bunch-a-many of emails');
end;

procedure TEMailSender.SendMail(aEmailAddress, aMessage: string);
begin
  WriteLn(Format('I sent an email to %s with the following message: %s', [aEmailAddress, aMessage]));
end;

{ TEmailListManager }

constructor TEmailListManager.Create(aEmailSender: IEmailSender);
begin
  inherited Create;
  FEmailSender := aEmailSender;
end;

procedure TEmailListManager.RegisterNewPerson(aName, aEmailAddress: string);
begin
  // Insert person and email address into database
  FEmailSender.SendMail(aEmailAddress, TestMessage);
  FEmailSender.SendBulkEmail;
end;

end.
