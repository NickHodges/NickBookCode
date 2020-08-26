unit uDuckDuckDelphi;

interface

uses
      Duck
    , uQuackingThings
    , System.Classes
    ;

type

  TGoose = class
  strict private
    FName: string;
  public
    procedure Honk;
    property Name: string read FName write FName;
  end;

  TAddSix = class
    procedure AddSix(aInteger: integer);
  end;

procedure DoIt;

implementation

procedure DoQuack(obj: TObject);
begin
  obj.duck.call('Quack');
end;

procedure DoAddSix(aObj: TObject; aInteger: integer);
begin
  aObj.duck.call('AddSix', [aInteger]);
end;

procedure ProtectedQuack(obj: TObject);
begin
  if obj.duck.can('Quack') then
  begin
    obj.duck.call('Quack')
  end else
  begin
    Writeln('Sorry, I can''t quack!');
  end;
end;

procedure ChangeName(obj: TObject; aName: string);
begin
  obj.duck.setTo('Name', aName);
end;

procedure DoIt;
var
  LDuck: TObject;
  LRubberDuck: TRubberDuck;
  LWaveFileDuck: TWAVFileOfADuck;
  LGoose: TGoose;
  LComponent: TComponent;
  LAdd6: TAddSix;
begin
  LDuck := TDuck.Create;
  LRubberDuck := TRubberDuck.Create;
  LWaveFileDuck := TWAVFileOfADuck.Create;
  LGoose := TGoose.Create;

  try
    DoQuack(LDuck);
    DoQuack(LRubberDuck);
    DoQuack(LWaveFileDuck);
    DoQuack(LGoose);

    WriteLn;

    ProtectedQuack(LDuck);
    ProtectedQuack(LRubberDuck);
    ProtectedQuack(LWaveFileDuck);
    ProtectedQuack(LGoose);

    ChangeName(LGoose, 'Marvin');
    WriteLn('The goose''s name is ', LGoose.Duck.get('Name').ToString);

    LComponent := TComponent.Create(nil);
    try
      ChangeName(LComponent, 'Jennifer');
      WriteLn('The component''s name is ', LComponent.Duck.get('name').ToString);
    finally
      LComponent.Free;
    end;

    WriteLn;

    LAdd6 := TAddSix.Create;
    try
      DoAddSix(LAdd6, 7);
    finally
      LAdd6.Free;
    end;

  finally
    LDuck.Free;
    LRubberDuck.Free;
    LWaveFileDuck.Free;
    LGoose.Free;
  end;

  ReadLn;
end;


{ TGoose }

procedure TGoose.Honk;
begin
  WriteLn('Honk!');
end;

{ TAddition }

procedure TAddSix.AddSix(aInteger: integer);
begin
  WriteLn('If you add six to ', aInteger, ' you get ', aInteger + 6);
end;

end.
