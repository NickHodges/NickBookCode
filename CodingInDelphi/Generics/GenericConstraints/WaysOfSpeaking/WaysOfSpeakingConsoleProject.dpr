program WaysOfSpeakingConsoleProject;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  WaysOfSpeakingUnit in 'WaysOfSpeakingUnit.pas';

procedure Main;
var
  Speaker: ISpeak;
begin
  Writeln('Using ISpeakFactory:');
  Speaker := ISpeakFactory<TSay>.Produce();
  Writeln(Speaker.Speak);
  Speaker := ISpeakFactory<TShout>.Produce();
  Writeln(Speaker.Speak);
  Speaker := ISpeakFactory<TMumble>.Produce();
  Writeln(Speaker.Speak);

  Writeln;

  Writeln('Using TSpeakFactory:');
  Speaker := TSpeakFactory<TSay>.Produce();
  Writeln(Speaker.Speak);
  Speaker := TSpeakFactory<TShout>.Produce();
  Writeln(Speaker.Speak);
  // the TSpeakerFactory cannot produce a TMumble as TMuble does not descend from TSpeak, it just implements ISpeak
//  Speaker := TSpeakFactory<TMumble>.Produce();
//  Writeln(Speaker.Speak);

  Writeln;
end;

begin
  try
    try
      Main(); // demonstrates the `constructor` constraints
    finally
      Write('Press <Enter>...');
      Readln;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
