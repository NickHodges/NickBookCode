unit uPrimitiveRegistration;

interface

uses
      Spring.Container.Common
    ;

type
  TPerson = class
  private
    FName: string;
    [Inject('age')]
    FAge: integer;
    function GetName: string;
    function GetAge: integer;
  public
    [Inject('name')]
    constructor Create(aName: string);
    property Name: string read GetName;
    property Age: integer read GetAge;
  end;

procedure Main1;

implementation

uses
       Spring.Container
     , System.SysUtils
     , WinAPI.Windows
     ;

procedure Main1;
var
  TempName: TPerson;
begin
  TempName := GlobalContainer.Resolve<TPerson>;
  WriteLn(TempName.Name, ' is ', TempName.Age, ' years old');
  Readln;
end;

{ TName }

constructor TPerson.Create(aName: string);
begin
  inherited Create;
  FName := aName;
end;

function TPerson.GetAge: integer;
begin
  Result := FAge;
end;

function TPerson.GetName: string;
begin
  Result := FName;
end;

end.
