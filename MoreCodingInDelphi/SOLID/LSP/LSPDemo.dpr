program LSPDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Collections,
  uVehicles in 'uVehicles.pas',
  uBirds in 'uBirds.pas',
  uSquare in 'uSquare.pas';

begin
  try
     FillVehiclesWithGas;
     //BirdStuff;
     //DoRectangleStuff
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
