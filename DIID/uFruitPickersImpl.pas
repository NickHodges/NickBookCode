unit uFruitPickersImpl;

interface

uses
      uFruitPickerIntf
    ;

type
  THumanFruitPicker = class(TInterfacedObject, IFruitPicker)
    procedure PickFruit;
  end;

  TMechanicalFruitPicker = class(TInterfacedObject, IFruitPicker)
    procedure PickFruit;
  end;

  TRobotFruitPicker = class(TInterfacedObject, IFruitPicker)
    procedure PickFruit;
  end;

implementation

{ THumanFruitPicker }

procedure THumanFruitPicker.PickFruit;
begin
  Writeln('Carefully hand-pick the fruit.....');
end;

{ TMechanicalFruitPicker }

procedure TMechanicalFruitPicker.PickFruit;
begin
  WriteLn('Pick the fruit with a mechanical device....');
end;

{ TRobotFruitPicker }

procedure TRobotFruitPicker.PickFruit;
begin
  WriteLn('Pick the fruit with an android-like robots....');
end;

end.
