{ Copyright (c) 2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

unit LocomotionInterfacesUnit;

// after http://en.wikipedia.org/wiki/Animal_locomotion
// running, swimming, jumping, flying
// not all animals can do all, but some can do more than one.

// Note this is a model of the real world. Models are always a simplification.

interface

type
  IRunning = interface(IInterface)
  ['{8459D191-5301-4850-809B-606A9060239D}']
    procedure Run;
  end;

  ISwimming = interface(IInterface)
  ['{EB521F97-48A1-45DA-815B-DFCC8E4E39F1}']
    procedure Swim;
  end;

  IJumping = interface(IInterface)
  ['{0D38D12C-8AD7-4347-A90D-F8F3444AF9A2}']
    procedure Jump;
  end;

  IFlying = interface(IInterface)
  ['{CD70991B-10AE-4F78-9993-3EAB75BA8B15}']
    procedure Fly;
  end;

implementation

end.
