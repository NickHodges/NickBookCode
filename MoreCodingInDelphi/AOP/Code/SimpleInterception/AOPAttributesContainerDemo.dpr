program AOPAttributesContainerDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uAOPAttributes in 'uAOPAttributes.pas';

begin
  try
    DoIt;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
