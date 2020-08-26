{ Copyright (c) 2013 Jeroen Wiert Pluimers for BeSharp.net and Coding In Delphi.
Full BSD License is available at http://BeSharp.codeplex.com/license }

program AnimalVCLProject;

uses
  Vcl.Forms,
  AnimalFormUnit in 'AnimalFormUnit.pas' {AnimalForm},
  LocomotionInterfacesUnit in 'LocomotionInterfacesUnit.pas',
  AnimalClassesUnit in 'AnimalClassesUnit.pas',
  LogEventUnit in 'LogEventUnit.pas',
  RttiHelpers in '..\..\RunTimeTypingInformation\RttiHelpers.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAnimalForm, AnimalForm);
  Application.Run;
end.
