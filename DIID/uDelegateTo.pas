unit uDelegateTo;

interface

type
  IWindowsUser = interface
  ['{432973CE-CDDF-45CC-9BA0-EC089F23EAF4}']
    function GetUserName: string;
    property UserName: string read GetUserName;
  end;

  TWindowsUser = class(TInterfacedObject, IWindowsUser)
  private
    FUserName: string;
    function GetUserName: string;
  public
    constructor Create(const aUserName: string);
    property Username: string read GetUsername;
  end;

procedure OutputName;
function GetLocalUserName: string;

implementation

uses
      Spring.Container
    , Windows
    , System.SysUtils
    ;

procedure OutputName;
var
  WindowsUser: IWindowsUser;
begin
  WindowsUser := GlobalContainer.Resolve<IWindowsUser>;
  WriteLn('Current Windows User is: ', WindowsUser.UserName);
end;

function GetLocalUserName: string;
var
  aLength: DWORD;
  aUserName: array [0 .. Max_Path - 1] of Char;
begin
  aLength := Max_Path;
  if not GetUserName(aUserName, aLength) then
  begin
    raise Exception.CreateFmt('Win32 Error %d: %s', [GetLastError, SysErrorMessage(GetLastError)]);
  end;
  Result := string(aUserName);
end;


{ TWindowsUser }

constructor TWindowsUser.Create(const aUserName: string);
begin
  inherited Create;
  FUsername := aUserName;
end;

function TWindowsUser.GetUserName: string;
begin
  Result := FUsername;
end;

end.
