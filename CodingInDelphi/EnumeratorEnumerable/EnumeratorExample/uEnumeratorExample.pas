unit uEnumeratorExample;

interface

uses
     SysUtils;

type

  TForInDemo = class;

  TForInDemoClassEnumerator = class
  private
    FString: string;
    FIndex: Integer;
  protected
    function GetCurrent: Char; virtual;
  public
    constructor Create(aString: string);
    destructor Destroy(); override;
    function MoveNext: Boolean;
    property Current: Char read GetCurrent;
  end;

  TForInDemo = class
  private
    FTheString: string;
    procedure SetTheString(const Value: string);
  public
    constructor Create(aString: string);
    destructor Destroy(); override;
    function GetEnumerator: TForInDemoClassEnumerator;
    property TheString: string read FTheString write SetTheString;
  end;

  procedure DoStuff;

implementation

procedure DoStuff;
var
  ForInDemo: TForInDemo;
  C: Char;
begin
  WriteLn('Start of DoStuff();');
  ForInDemo := TForInDemo.Create('HelloWorld');
  try
    WriteLn('Before the for...in');
    for C in ForInDemo do
    begin
      Write(C, ',');
    end;
    WriteLn('After the for...in');

  finally
    ForInDemo.Free;
  end;
  WriteLn('End of DoStuff();');
end;

{ TForInDemoClass }


constructor TForInDemo.Create(aString: string);
begin
  Writeln(ClassName, '.Create()');
  inherited Create;
  FTheString := aString;
end;

destructor TForInDemo.Destroy();
begin
  inherited;
  Writeln(ClassName, '.Destroy()');
end;

function TForInDemo.GetEnumerator: TForInDemoClassEnumerator;
begin
  Result := TForInDemoClassEnumerator.Create(FTheString);
end;

procedure TForInDemo.SetTheString(const Value: string);
begin
  FTheString := Value;
end;

{ TForInDemoClassEnumerator }

constructor TForInDemoClassEnumerator.Create(aString: string);
begin
  Writeln(ClassName, '.Create()');
  inherited Create;
  FString := aString;
  FIndex := 0;
end;

destructor TForInDemoClassEnumerator.Destroy();
begin
  inherited;
  Writeln;
  Writeln(ClassName, '.Destroy()');
end;

function TForInDemoClassEnumerator.GetCurrent: Char;
begin
  Result := FString[FIndex];
end;

function TForInDemoClassEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < Length(FString);
  if Result then
  begin
    Inc(FIndex);
  end;
end;


end.
