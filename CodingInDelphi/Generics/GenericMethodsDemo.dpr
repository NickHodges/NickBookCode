program GenericMethodsDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  TypInfo;

type
  TEnum = record
  public
    class function AsString<T>(aEnum: T): string; static;
    class function AsInteger<T>(aEnum: T): Integer; static;
  end;

{ TEnum }

class function TEnum.AsString<T>(aEnum: T): string;
begin
  Result := GetEnumName(TypeInfo(T), AsInteger(aEnum));
end;

class function TEnum.AsInteger<T>(aEnum: T): Integer;
begin
  case Sizeof(T) of
    1: Result := pByte(@aEnum)^;
    2: Result := pWord(@aEnum)^;
    4: Result := pCardinal(@aEnum)^;
  end;
end;

type
  TStoplight = (Red, Yellow, Green);

begin
  try
    WriteLn(TEnum.AsString<TStopLight>(Yellow));
    WriteLn(TEnum.AsInteger<TStopLight>(Red));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
