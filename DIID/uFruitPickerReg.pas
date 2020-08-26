unit uFruitPickerReg;

interface

procedure RegisterFruitPickers;

implementation

uses
      Spring.Container
    , uFruitPickerIntf
    , uFruitPickersImpl
    ;

procedure RegisterFruitPickers;
begin
  GlobalContainer.RegisterType<IFruitPicker, THumanFruitPicker>('human').AsDefault;
  GlobalContainer.RegisterType<IFruitPicker, TMechanicalFruitPicker>('mechanical');
  GlobalContainer.RegisterType<IFruitPicker, TRobotFruitPicker>('robot');
  GlobalContainer.Build;
end;

end.
