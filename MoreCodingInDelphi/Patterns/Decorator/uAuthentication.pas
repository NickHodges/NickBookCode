unit uAuthentication;

interface

type

  IAuthentication = interface
  ['{10793CD1-B1C4-4A59-9C5B-A48B64B4AC2A}']
    function Authenticate(const aPassword: string): Boolean;
  end;

  TAuthentication = class(TInterfacedObject, IAuthentication)
  private
    function Authenticate(const aPassword: string): Boolean;
  end;

implementation

{ TAuthentication }

function TAuthentication.Authenticate(const aPassword: string): Boolean;
var
  S: string;
begin
  Write('Enter the Password: ');
  ReadLn(S);
  Result := S = aPassword;
end;

end.
