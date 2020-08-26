program AssignAnyProcToAnonMethods;

{$APPTYPE CONSOLE}

{$R *.res}

uses
     System.SysUtils
   ;

type
  TMethodReference = procedure(aString: string) of object;
  TAnonMethod = reference to procedure(aString: string);
  TProcReference = procedure(aString: string);

var
  AM: TAnonMethod;
  PR: TProcReference;

  procedure ProcReference(aString: string);
  begin
    WriteLn('I am a Procedure Reference: ' + aString);
  end;

type
  TSomeClass = class
  private
    FEvent: TAnonMethod;

  public
    procedure MethodReference(aString: string);
    procedure SetMethodReference(aAnonReference: TAnonMethod);
    constructor Create;
    procedure FireEvent;
    property OnEvent: TAnonMethod read FEvent write FEvent;
  end;

var
  SomeClass: TSomeClass;

{ TSomeClass }

constructor TSomeClass.Create;
begin
  inherited;
  FEvent := MethodReference;
end;

procedure TSomeClass.FireEvent;
begin
  if Assigned(FEvent) then
    FEvent('Firing Event');
end;

procedure TSomeClass.MethodReference(aString: string);
begin
  WriteLn('I am a Method Reference: ' + aString);
end;

procedure TSomeClass.SetMethodReference(aAnonReference: TAnonMethod);
begin
  FEvent := aAnonReference;
end;

begin
  try
    PR := ProcReference;

    AM := procedure(aString: string)
          begin
            WriteLn('I am an Anonymous Method: ' + aString);
          end;

    SomeClass := TSomeClass.Create;
    try
      SomeClass.SetMethodReference(AM);
      SomeClass.FireEvent;
      SomeClass.SetMethodReference(PR);
      SomeClass.FireEvent;
      SomeClass.SetMethodReference(SomeClass.MethodReference);
      SomeClass.FireEvent;
    finally
      SomeClass.Free;
    end;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
