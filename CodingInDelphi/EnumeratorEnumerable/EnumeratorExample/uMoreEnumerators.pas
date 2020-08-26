unit uMoreEnumerators;

interface

uses
      uEnumeratorExample
    ;

type

  TForInDemoClassReverseEnumerator = class
    private
    FString: string;
    FIndex: integer;
  protected
    function GetCurrent: Char; virtual;
  public
    constructor Create(aString: string);
    function MoveNext: Boolean;
    property Current: Char read GetCurrent;
  end;

  TForInDemoClassUpperCaseEnumerator = class(TForInDemoClassEnumerator)
  protected
    function GetCurrent: Char; override;
  end;

  TReverseEnumeratorProxy = class
  private
    FOwner: TForInDemo;
  public
    constructor Create(aOwner: TForInDemo);
    function GetEnumerator: TForInDemoClassReverseEnumerator;
  end;

  TUpperCaseEnumeratorProxy = class
  private
    FOwner: TForInDemo;
  public
    constructor Create(aOwner: TForInDemo);
    function GetEnumerator: TForInDemoClassUpperCaseEnumerator;
  end;

  TForInDemoExtraIterators = class(TForInDemo)
  private
    FUpper: TUpperCaseEnumeratorProxy;
    FReverse: TReverseEnumeratorProxy;
  public
    constructor Create(aString: string);
    property AsUpperCase: TUpperCaseEnumeratorProxy read FUpper;
    property AsReversed: TReverseEnumeratorProxy read FReverse;
  end;

  procedure DoMoreStuff;

implementation

procedure DoMoreStuff;
var
  C: Char;
  ForInExtraDemo: TForInDemoExtraIterators;
begin

  ForInExtraDemo := TForInDemoExtraIterators.Create('Greetings');
  try
    for C in ForInExtraDemo.AsUpperCase do
    begin
      Write(C, ',');
    end;
    WriteLn;

    for C in ForInExtraDemo.AsReversed do
    begin
      Write(c, ',');
    end;
    WriteLn;
  finally
    ForInExtraDemo.Free;
  end;
end;

{ TForInDemoExtraIteratorsClass }

constructor TForInDemoExtraIterators.Create(aString: string);
begin
  inherited Create(aString);
  FUpper := TUpperCaseEnumeratorProxy.Create(Self);
  FReverse := TReverseEnumeratorProxy.Create(Self);
end;

{ TForInDemoClassCapitalEnumerator }

function TForInDemoClassUpperCaseEnumerator.GetCurrent: Char;
begin
  Result := UpCase(inherited GetCurrent);
end;

{ TUpperCaseEnumeratorProxy }

constructor TUpperCaseEnumeratorProxy.Create(aOwner: TForInDemo);
begin
  inherited Create;
  FOwner := aOwner
end;

function TUpperCaseEnumeratorProxy.GetEnumerator: TForInDemoClassUpperCaseEnumerator;
begin
  Result := TForInDemoClassUpperCaseEnumerator.Create(FOwner.TheString);
end;

{ TForInDemoClassReverseEnumerator }

constructor TForInDemoClassReverseEnumerator.Create(aString: string);
begin
  inherited Create;
  FString := aString;
  FIndex := Length(aString) + 1;
end;

function TForInDemoClassReverseEnumerator.GetCurrent: Char;
begin
  Result := FString[FIndex];
end;

function TForInDemoClassReverseEnumerator.MoveNext: Boolean;
begin
  Dec(FIndex);
  Result := FIndex > 0;
end;

{ TReverseEnumeratorProxy }

constructor TReverseEnumeratorProxy.Create(aOwner: TForInDemo);
begin
  inherited Create;
  FOwner := aOwner;
end;

function TReverseEnumeratorProxy.GetEnumerator: TForInDemoClassReverseEnumerator;
begin
  Result := TForInDemoClassReverseEnumerator.Create(FOwner.TheString);
end;


end.
