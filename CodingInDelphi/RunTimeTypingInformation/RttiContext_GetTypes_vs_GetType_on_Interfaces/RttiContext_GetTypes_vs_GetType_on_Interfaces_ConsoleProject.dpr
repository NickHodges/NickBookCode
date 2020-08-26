program RttiContext_GetTypes_vs_GetType_on_Interfaces_ConsoleProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  RttiContext_GetTypes_vs_GetType_on_Interfaces_MainUnit in 'RttiContext_GetTypes_vs_GetType_on_Interfaces_MainUnit.pas',
  System.SysUtils,
  RttiHelpers in '..\RttiHelpers.pas',
  RttiContext_GetTypes_vs_GetType_on_Interfaces_ConsoleReportUnit in 'RttiContext_GetTypes_vs_GetType_on_Interfaces_ConsoleReportUnit.pas';

begin
  try
    Main();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
