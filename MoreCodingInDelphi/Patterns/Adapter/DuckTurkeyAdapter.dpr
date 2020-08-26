program DuckTurkeyAdapter;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uDuckTurkey in 'uDuckTurkey.pas';

var
  Turkey: ITurkey;
  Duck: IDuck;
  TurkeyAdapter: IDuck;


procedure TestTheDuck(aDuck: IDuck);
begin
  aDuck.Quack;
  aDuck.Fly;
end;

begin
  try
    Duck := TMallardDuck.Create;
    Turkey := TWildTurkey.Create;

    // Wrap the turkey in a TurkeyAdapter to make it look like a duck
    TurkeyAdapter := TTurkeyAdapter.Create(Turkey);

    WriteLn('The turkey says....');
    Turkey.Gobble;
    Turkey.Fly;

    WriteLn('The duck says.....');
    TestTheDuck(Duck);
    // TestTheDuck has no idea that it really has a turkey
    TestTheDuck(TurkeyAdapter);


    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
