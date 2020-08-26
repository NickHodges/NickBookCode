{ Copyright (c) 2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit AnimalClassesUnit;

// modeled after http://en.wikipedia.org/wiki/Animal_locomotion#Swimming
// and based on http://en.wikipedia.org/wiki/Class_(biology)#An_example_from_zoology,
// http://simple.wikipedia.org/wiki/Vertebrate and http://simple.wikipedia.org/wiki/List_of_animal_phyla

// it is a simplification of the real world...

// some special animals (there are many many more, like fish that cannot swim, or mammals laying eggs):
// emu: bird that cannot fly
// whale: a mammal that can swim, but not run
// bat: not a bird, but can fly
// duck: bird that can swim
// human: mammal that can swim and run

interface

uses
  LocomotionInterfacesUnit, LogEventUnit;

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Base class for all the animal classes.
  ///	</summary>
  ///	<remarks>
  ///	  <para>
  ///	    Implements <see cref="System|IInterface" /> as all descendants can
  ///	    implement interfaces from <see cref="LocomotionInterfacesUnit" />.
  ///	  </para>
  ///	  <para>
  ///	    Needs to descend from <see cref="System|TInterfacedObject" />  for
  ///	    the <see cref="System|IInterface" /> to work.
  ///	  </para>
  ///	  <para>
  ///	    Implements <see cref="OnLog" /> to allow for logging.
  ///	  </para>
  ///	</remarks>
  {$ENDREGION}
  TAnimal = class(TInterfacedObject, IInterface)
  strict private
    FOnLog: TLogEvent;
  strict protected
    procedure Log(const Line: string); virtual;
    procedure LogMethod(const MethodName: string); virtual;
  public
    constructor Create(const LogEvent: TLogEvent = nil); virtual;
    property OnLog: TLogEvent read FOnLog write FOnLog;
  end;

  {$REGION 'Documentation'}
  ///	<summary>
  ///	  For factory creation of <see cref="TAnimal" /> and descendants.
  ///	  Requires a virtual <see cref="TAnimal.Create">Create</see> constructor.
  ///	</summary>
  {$ENDREGION}
  TAnimalClass = class of TAnimal;

  {$REGION 'Documentation'}
  ///	<remarks>
  ///	  Not all birds can fly, so no implementation of
  ///	  <see cref="LocomotionInterfacesUnit|IFlying" />
  ///	</remarks>
  {$ENDREGION}
  TBird = class(TAnimal)
  end;

  TDuck = class(TBird, IFlying, ISwimming, IRunning)
  public
    procedure Fly;
    procedure Run;
    procedure Swim;
  end;

  TEmu = class(TBird, IRunning)
  public
    procedure Run();
  end;

  TPigeon = class(TBird, IFlying, IRunning)
  public
    procedure Fly();
    procedure Run();
  end;

  TFish = class(TAnimal, ISwimming)
  public
    procedure Swim();
  end;

  THerring = class(TFish)
  end;

  TSalmon = class(TFish)
  end;

  TShark = class(TFish)
  end;

  TInsect = class(TAnimal, IRunning)
  public
    procedure Run();
  end;

  TAnt = class(TInsect)
  end;

  TButterfly = class(TInsect, IFlying)
  public
    procedure Fly();
  end;

  TMammal = class(TAnimal)
  end;

  TBat = class(TMammal, IFlying)
  public
    procedure Fly();
  end;

  TCat = class(TMammal, IRunning)
  public
    procedure Run();
  end;

  TDog = class(TMammal, ISwimming, IRunning)
  public
    procedure Run();
    procedure Swim();
  end;

  THuman = class(TMammal, ISwimming, IRunning)
  public
    procedure Run();
    procedure Swim();
  end;

  TWhale = class(TMammal, ISwimming)
  public
    procedure Swim();
  end;

implementation

uses
  System.SysUtils;

constructor TAnimal.Create(const LogEvent: TLogEvent = nil);
begin
  inherited Create();
  OnLog := LogEvent;
end;

procedure TAnimal.Log(const Line: string);
var
  LogEvent: TLogEvent;
begin
  LogEvent := OnLog; // make this more thread safe
  if Assigned(LogEvent) then
    LogEvent(Line);
end;

procedure TAnimal.LogMethod(const MethodName: string);
var
  Line: string;
begin
  Line := Format('%s.%s', [ClassName, MethodName]);
  Log(Line);
end;

procedure TDuck.Fly;
begin
  LogMethod('Fly');
end;

procedure TDuck.Run;
begin
  LogMethod('Run duckwalk style...');
end;

procedure TDuck.Swim;
begin
  LogMethod('Swim');
end;

procedure TEmu.Run();
begin
  LogMethod('Run');
end;

procedure TPigeon.Fly();
begin
  LogMethod('Fly');
end;

procedure TPigeon.Run();
begin
  LogMethod('Run');
end;

procedure TFish.Swim();
begin
  LogMethod('Swim');
end;

procedure TInsect.Run();
begin
  LogMethod('Run');
end;

procedure TButterfly.Fly();
begin
  LogMethod('Fly when in butterfly stage');
end;

procedure TBat.Fly();
begin
  LogMethod('Fly');
end;

procedure TCat.Run();
begin
  LogMethod('Run');
end;

procedure TDog.Run();
begin
  LogMethod('Run');
end;

procedure TDog.Swim();
begin
  LogMethod('Swim');
end;

procedure THuman.Run();
begin
  LogMethod('Run');
end;

procedure THuman.Swim();
begin
  LogMethod('Swim');
end;

procedure TWhale.Swim();
begin
  LogMethod('Swim');
end;

end.
