unit uCustomerAdapter;

interface

type

  TDateOfBirth = record
    Month: integer;
    Day: integer;
    Year: integer;
  end;

  IOldCustomer = interface
  ['{14C3F1DB-0901-4AB7-8F6E-346C4BBA2E43}']
    function GetName: string;
    procedure SetName(aName: string);
    function GetDateOfBirth: TDateOfBirth;
    procedure SetDateOfBirth(aDateOfBirth: TDateOfBirth);

    property Name: string read GetName write SetName;
    property DateOfBirth: TDateOfBirth read GetDateOfBirth write SetDateOfBirth;
  end;

  INewCustomer = interface
  ['{BDACD6A1-C181-4A06-978F-6CAB72CD229B}']
    function GetFirstName: string;
    procedure SetFirstName(aFirstName: string);
    function GetLastName: string;
    procedure SetLastName(aLastName: string);
    function GetDateOfBirth: TDate;
    procedure SetDateOfBirth(aDOB: TDate);

    property FirstName: string read GetFirstName write SetFirstName;
    property LastName: string read GetLastName write SetLastName;
    property DateOfBirth: TDate read GetDateOfBirth write SetDateOfBirth;
  end;


  TOldCustomer = class(TInterfacedObject, IOldCustomer)
  strict private
    FName: string;
    FDOB: TDateOfBirth;
    function GetName: string;
    procedure SetName(aName: string);
    function GetDateOfBirth: TDateOfBirth;
    procedure SetDateOfBirth(aDateOfBirth: TDateOfBirth);
  public
    constructor Create(aName: string; aYear, aMonth, aDay: integer);
    property Name: string read GetName write SetName;
    property DateOfBirth: TDateOfBirth read GetDateOfBirth write SetDateOfBirth;
  end;

  TNewCustomer = class(TInterfacedObject, INewCustomer)
  strict private
    FFirstName: string;
    FLastName: string;
    FDOB: TDate;
    function GetFirstName: string;
    procedure SetFirstName(aFirstName: string);
    function GetLastName: string;
    procedure SetLastName(aLastName: string);
    function GetDateOfBirth: TDate;
    procedure SetDateOfBirth(aDOB: TDate);
  public
    property FirstName: string read GetFirstName write SetFirstName;
    property LastName: string read GetLastName write SetLastName;
    property DateOfBirth: TDate read GetDateOfBirth write SetDateOfBirth;
  end;

  TCustomerAdapter = class(TInterfacedObject, INewCustomer)
  strict private
    FFirstName: string;
    FLastName: string;
    FDOB: TDate;
    function GetFirstName: string;
    procedure SetFirstName(aFirstName: string);
    function GetLastName: string;
    procedure SetLastName(aLastName: string);
    function GetDateOfBirth: TDate;
    procedure SetDateOfBirth(aDOB: TDate);
    function ParseFirstName(aName: string): string;
    function ParseLastName(aName: string): string;
  public
    constructor Create(aOldCustomer: IOldCustomer);
    property FirstName: string read GetFirstName write SetFirstName;
    property LastName: string read GetLastName write SetLastName;
    property DateOfBirth: TDate read GetDateOfBirth write SetDateOfBirth;
  end;

implementation

uses
       System.SysUtils
     ;

{ TOldCustomer }

constructor TOldCustomer.Create(aName: string; aYear, aMonth, aDay: integer);
begin
  inherited Create;
  FName := aName;
  FDOB.Year := aYear;
  FDOB.Month := aMonth;
  FDOB.Day := aDay;
end;

function TOldCustomer.GetDateOfBirth: TDateOfBirth;
begin
  Result := FDOB;
end;

function TOldCustomer.GetName: string;
begin
  Result := FName;
end;

procedure TOldCustomer.SetDateOfBirth(aDateOfBirth: TDateOfBirth);
begin
  FDOB.Month := aDateOfBirth.Month;
  FDOB.Day := aDateOfBirth.Day;
  FDOB.Year := aDateOfBirth.Year;
end;

procedure TOldCustomer.SetName(aName: string);
begin
  FName := aName;
end;

{ TNewCustomer }

function TNewCustomer.GetDateOfBirth: TDate;
begin
  Result := FDOB;
end;

function TNewCustomer.GetFirstName: string;
begin
  Result := FFirstName;
end;

function TNewCustomer.GetLastName: string;
begin
  Result := FLastName;
end;

procedure TNewCustomer.SetDateOfBirth(aDOB: TDate);
begin
  FDOB := aDOB;
end;

procedure TNewCustomer.SetFirstName(aFirstName: string);
begin
  FFirstName := aFirstName;
end;

procedure TNewCustomer.SetLastName(aLastName: string);
begin
  FLastName := aLastName;
end;

{ TCustomerAdapter }

constructor TCustomerAdapter.Create(aOldCustomer: IOldCustomer);
begin
  inherited Create;
  FFirstName := ParseFirstName(aOldCustomer.Name);
  FLastName := ParseLastName(aOldCustomer.Name);
  FDOB := EncodeDate(aOldCustomer.DateOfBirth.Year, aOldCustomer.DateOfBirth.Month, aOldCustomer.DateOfBirth.Day);
end;

function TCustomerAdapter.GetDateOfBirth: TDate;
begin
  Result := FDOB;
end;

function TCustomerAdapter.GetFirstName: string;
begin
  Result := FFirstName;
end;

function TCustomerAdapter.GetLastName: string;
begin
  Result := FLastName;
end;

function TCustomerAdapter.ParseFirstName(aName: string): string;
var
  i: Integer;
  LStr: string;
begin
  Result := '';
  LStr := Trim(aName);
  for i := 1 to Length(LStr) do
  begin
    if LStr[i] <> ' ' then
    begin
     Result := Result + LStr[i];
    end else
    begin
      Exit;
    end;
  end;
end;

function TCustomerAdapter.ParseLastName(aName: string): string;
var
  LPos: Integer;
begin
  LPos := Pos(' ', aName);
  Result := Copy(aName, LPos, Length(aName));
end;

procedure TCustomerAdapter.SetDateOfBirth(aDOB: TDate);
begin
  FDOB := aDOB;
end;

procedure TCustomerAdapter.SetFirstName(aFirstName: string);
begin
  FFirstName := aFirstName;
end;

procedure TCustomerAdapter.SetLastName(aLastName: string);
begin
  FLastName := aLastName;
end;

end.
