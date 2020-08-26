program MultipleImplementationsAtRuntime;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  TypInfo,
  Spring,
  Spring.Container,
  uFruitPickerIntf in 'uFruitPickerIntf.pas',
  uFruitPickersImpl in 'uFruitPickersImpl.pas',
  uFruitPickerReg in 'uFruitPickerReg.pas';

type
  TPickerType = (human, mechanical, robot);

var
  Name: string;
  Selection: integer;
  FruitPicker: IFruitPicker;
begin
  try
    RegisterFruitPickers;

    WriteLn('Enter in the fruit picker to use: ');
    WriteLn('Pick 1 for a human, 2 for a machine, and 3 for an android robot.');
    ReadLn(Selection);

    Name := GetEnumName(TypeInfo(TPickerType), Selection - 1);
    FruitPicker := GlobalContainer.Resolve<IFruitPicker>(Name);
    FruitPicker.PickFruit;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
