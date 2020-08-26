{ Copyright (c) 2013 Nick Hodges for CodingInDelphi and Jeroen Wiert Pluimers
for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

program IntegerCalculatorVCLProject;

uses
  Vcl.Forms,
  IntegerCalculatorFormUnit in 'IntegerCalculatorFormUnit.pas' {IntegerCalculatorForm},
  IntegerCalculatorUnit in 'IntegerCalculatorUnit.pas',
  BinaryIntegerOperatorFunctionUnit in 'BinaryIntegerOperatorFunctionUnit.pas',
  IntegerPowerUnit in 'IntegerPowerUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TIntegerCalculatorForm, IntegerCalculatorForm);
  Application.Run;
end.
