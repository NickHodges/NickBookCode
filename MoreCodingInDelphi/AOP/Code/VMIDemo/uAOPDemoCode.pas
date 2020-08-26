unit uAOPDemoCode;

interface

implementation

uses
      System.SysUtils
    ;

procedure StartTransaction;
begin

end;

procedure RollbackTransaction;
begin

end;

procedure CommitTransaction;
begin

end;

type
  TUser = class
    class function GetUserByID(aID: Integer): TUser; static;
    class procedure UpdateEmail(aNewEmail: string); static;
  end;

  EUserNotFoundException = class(Exception);

function ChangeEmailAddress(aUserID: Integer; aNewEmail: string): Boolean;
var
  LUser: TUser;
begin
  Result := False;
  StartTransaction;
  try
    LUser := TUser.GetUserByID(aUserId);
    if LUser <> nil then
    begin
      TUser.UpdateEmail(aNewEmail);
    end else
    begin
      raise EUserNotFoundException.CreateFmt('User with id of %d not found.', [aUserId]);
    end;
    CommitTransaction;
  except
    RollbackTransaction;
    raise;
  end;
end;

{ TUser }

function TUser.GetUserByID(aID: Integer): TUser;
begin

end;

end.
