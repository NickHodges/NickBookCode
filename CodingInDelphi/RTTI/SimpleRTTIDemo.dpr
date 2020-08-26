program SimpleRTTIDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uRTTIDemoClass in 'uRTTIDemoClass.pas',
  uRTTIDemo in 'uRTTIDemo.pas',
  uTValueDemo in 'uTValueDemo.pas',
  uSimpleUnitTests in 'uSimpleUnitTests.pas',
  uRTTIGetSetValues in 'uRTTIGetSetValues.pas',
  uCallMethods in 'uCallMethods.pas',
  RTTIForMiscTypes in 'RTTIForMiscTypes.pas',
  uLimitedRTTI in 'uLimitedRTTI.pas';

begin
  try
    GatherAndDisplayRTTI;
    //DoStuffWithTValue;
    //RunTheTests;
    //GetAndSetFieldValues;
    //CallMethodsWithRTTI;
    //GetRTTIforMiscTypes;
    //DisplayLimitedRTTI;
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
