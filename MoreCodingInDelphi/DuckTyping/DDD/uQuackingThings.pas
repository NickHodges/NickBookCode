unit uQuackingThings;

interface

type
  TDuck = class
    procedure Quack;
  end;

  TRubberDuck = class
    procedure Quack;
  end;

  TWAVFileOfADuck = class
    procedure Quack;
  end;

implementation

{ TWAVFileOfADuck }

procedure TWAVFileOfADuck.Quack;
begin
  WriteLn('<sound>Quack!</sound>');
end;

{ TRubberDuck }

procedure TRubberDuck.Quack;
begin
  WriteLn('Squeaky Quack!');
end;

{ TDuck }

procedure TDuck.Quack;
begin
  WriteLn('Quack');
end;

end.
