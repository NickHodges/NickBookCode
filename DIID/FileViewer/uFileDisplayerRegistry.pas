unit uFileDisplayerRegistry;

interface

uses
      uFileDisplayerInterfaces
    , Spring.Collections
    ;

type
  TFileDisplayerRegistry = class(TInterfacedObject, IFileDisplayerRegistry)
  private
    FDictionary: IDictionary<string, IDisplayFile>;
    FDefaultDisplayer: IDisplayFile;
  public
    constructor Create;
    procedure AddDisplayer(const aExt: string; aDisplayer: IDisplayFile);
    function GetDisplayer(const aExt: string): IDisplayFile;
    function GetExtensions: TArray<string>;
    // Property Injection:  We have a default displayer, but you can provide your own if
    // you want to.
    property DefaultDisplayer: IDisplayFile read FDefaultDisplayer write FDefaultDisplayer;
  end;

  function FileDisplayerRegistry: IFileDisplayerRegistry;

implementation

uses
      System.SysUtils
    , Spring.Container
    , uDefaultDisplayer
    ;

 var
   FDR: IFileDisplayerRegistry;

function FileDisplayerRegistry: IFileDisplayerRegistry;
begin
  if FDR = nil then
  begin
    FDR := TFileDisplayerRegistry.Create;
  end;
  Result := FDR;
end;

procedure TFileDisplayerRegistry.AddDisplayer(const aExt: string; aDisplayer: IDisplayFile);
begin
  FDictionary.Add(aExt.ToUpper, aDisplayer);
end;

constructor TFileDisplayerRegistry.Create;
begin
  FDictionary := TCollections.CreateDictionary<string, IDisplayFile>;
  FDefaultDisplayer := TDefaultFileDisplayer.Create;
end;

function TFileDisplayerRegistry.GetDisplayer(const aExt: string): IDisplayFile;
begin
  // never return nil.  If a Displayer is not found, then return the default one.
  FDictionary.TryGetValue(aExt.ToUpper, Result);
  if Result = nil then
  begin
    Result := FDefaultDisplayer;
  end;
end;

function TFileDisplayerRegistry.GetExtensions: TArray<string>;
var
  Extension: string;
  i: Integer;
begin
  SetLength(Result, FDictionary.Count);
  i := 0;
  for Extension in FDictionary.Keys do
  begin
    Result[i] := FDictionary.Keys.ElementAt(i);
    Inc(i);
  end;
  
end;

end.
