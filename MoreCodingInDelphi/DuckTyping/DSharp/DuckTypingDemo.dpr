program DuckTypingDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
      DSharp.Core.DuckTyping
    , System.SysUtils
    ;

type

  IPressable = interface(IInvokable)
    procedure Press;
  end;

  TButton = class(TInterfacedObject, IPressable)
    procedure Press;
  end;

  TPants = class
    procedure Press;
  end;

  TNotPressable = class
    procedure Pull;
  end;

procedure PressTheThing(aPressable: IPressable);
begin
  aPressable.Press;
end;

{ TButton }

procedure TButton.Press;
begin
  WriteLn('The button was pressed');
end;

{ TPants }

procedure TPants.Press;
begin
  Writeln('Take your pants to the dry cleaners and have them pressed');
end;

{ TNotPressable }

procedure TNotPressable.Pull;
begin
  WriteLn('Pulling on something');
end;


var
  Button: IPressable;
  Pants: TPants;
  NotPressable: TNotPressable;
begin
  try
    Button := TButton.Create;
    Pants := TPants.Create;
    NotPressable := TNotPressable.Create;

    PressTheThing(Button);
    PressTheThing(Duck<IPressable>(Pants));
    PressTheThing(Duck<IPressable>(NotPressable));

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
