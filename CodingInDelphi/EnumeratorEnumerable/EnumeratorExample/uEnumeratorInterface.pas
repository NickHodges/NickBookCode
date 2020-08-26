unit uEnumeratorInterface;

interface

type
  IEnumerator<T> = interface
    function GetCurrent: T;
    function MoveNext: Boolean;
    property Current: T read GetCurrent;
  end;

  IEnumerable<T> = interface
    function GetEnumerator: IEnumerator<T>;
  end;

  TIndexedStringStorage = class(TInterfacedObject)
  private
    FString: string;
    FIndex: Integer;
  strict protected
    function GetCurrent: Char; virtual;
  public
    constructor Create(const aString: string);
    destructor Destroy(); override;
    property Current: Char read GetCurrent;
  end;

  ICharEnumerator = IEnumerator<Char>;

  TStringEnumerator = class(TIndexedStringStorage, ICharEnumerator)
  public
    constructor Create(const aString: string);
    function MoveNext: Boolean; virtual;
  end;

  TForInDemoClassReverseEnumerator = class(TIndexedStringStorage, ICharEnumerator)
  public
    constructor Create(const aString: string);
    function MoveNext(): Boolean; virtual;
  end;

  TEnumerationType = (Forward, Backwards);

  TInterfaceEnumeratorDemo = class(TInterfacedObject, IEnumerable<Char>)
  private
    FTheString: string;
    FDirection: TEnumerationType;
    procedure SetTheString(const Value: string);
    procedure SetDirection(const Value: TEnumerationType);
  public
    constructor Create(const aString: string);
    function GetEnumerator: ICharEnumerator;
    property Direction: TEnumerationType read FDirection write SetDirection;
    property TheString: string read FTheString write SetTheString;
  end;

  procedure DoInterfaceStuff;

implementation

procedure DoInterfaceStuff;
var
  InterfacedEnumerator: TInterfaceEnumeratorDemo;
  c: Char;
begin
  InterfacedEnumerator := TInterfaceEnumeratorDemo.Create('GoodbyeWorld');
  try
    for c in InterfacedEnumerator do
    begin
      Write(C, ',');
    end;
    WriteLn;

    InterfacedEnumerator.Direction := TEnumerationType.Backwards;
    for c in InterfacedEnumerator do
    begin
      Write(C, ',');
    end;
    WriteLn;

  finally
    InterfacedEnumerator.Free;
  end;
end;

{ TInterfaceEnumerator }

constructor TInterfaceEnumeratorDemo.Create(const aString: string);
begin
  inherited Create();
  FTheString := aString;
  FDirection := TEnumerationType.Forward;
end;

function TInterfaceEnumeratorDemo.GetEnumerator: IEnumerator<Char>;
begin
  case Direction of
    Forward:   Result := TStringEnumerator.Create(TheString);
    Backwards: Result := TForInDemoClassReverseEnumerator.Create(TheString);
  end;
end;

procedure TInterfaceEnumeratorDemo.SetDirection(const Value: TEnumerationType);
begin
  FDirection := Value;
end;

procedure TInterfaceEnumeratorDemo.SetTheString(const Value: string);
begin
  FTheString := Value;
end;

{ TForInDemoClassReverseEnumerator }

constructor TForInDemoClassReverseEnumerator.Create(const aString: string);
begin
  inherited Create(aString);
  FIndex := Length(aString) + 1;
end;

function TForInDemoClassReverseEnumerator.MoveNext(): Boolean;
begin
  Dec(FIndex);
  Result := FIndex > 0;
end;

{ TStringEnumerator }

constructor TStringEnumerator.Create(const aString: string);
begin
  inherited Create(aString);
  FIndex := 0;
end;

function TStringEnumerator.MoveNext: Boolean;
begin
  Result := FIndex < Length(FString);
  if Result then
  begin
    Inc(FIndex);
  end;
end;

{ TIndexedStringStorage }

constructor TIndexedStringStorage.Create(const aString: string);
begin
  Writeln(ClassName, '.Create();');
  inherited Create();
  FString := aString;
end;

destructor TIndexedStringStorage.Destroy();
begin
  inherited;
  Writeln;
  Writeln(ClassName, '.Destroy();');
end;

function TIndexedStringStorage.GetCurrent: Char;
begin
  Result := FString[FIndex];
end;

end.
