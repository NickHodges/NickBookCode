program AttributesEverywhere;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uAttributesEverywhere in 'uAttributesEverywhere.pas';

begin
  try
    DoAttributesEverywhere;
    WriteLn;
    WriteLn;
    DoMultipleAttributes;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
