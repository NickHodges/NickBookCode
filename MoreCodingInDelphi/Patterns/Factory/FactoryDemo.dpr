program FactoryDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uSmartPhone in 'uSmartPhone.pas',
  uSmartPhoneFactory in 'uSmartPhoneFactory.pas',
  uSmartPhoneTasks in 'uSmartPhoneTasks.pas',
  uBadSmartPhoneAssemblyPlant in 'uBadSmartPhoneAssemblyPlant.pas',
  uSmartPhoneAssemblyPlant in 'uSmartPhoneAssemblyPlant.pas',
  uBetterSmartPhoneFactory in 'uBetterSmartPhoneFactory.pas';

begin
  try
    BuildPhone(CheapCrappy);
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
