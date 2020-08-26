program InjectionTypesDemo;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Spring.Container,
  Spring.Container.Common,
  Spring.Services,
  uNoServiceLocatorDemo in 'uNoServiceLocatorDemo.pas',
  uMethodInjection in 'uMethodInjection.pas',
  uPropertyInjectionRenew in 'uPropertyInjectionRenew.pas',
  uDoBattle in 'uDoBattle.pas',
  uFieldInjection in 'uFieldInjection.pas',
  uAttributes in 'uAttributes.pas',
  uSimpleConstructorInjection in 'uSimpleConstructorInjection.pas',
  uOverInjection in 'uOverInjection.pas',
  uPropertyInjectionMultiple in 'uPropertyInjectionMultiple.pas',
  uRegistrationStuff in 'uRegistrationStuff.pas';

begin
  try
    GlobalContainer.Build;

    FightBattleWithServiceLocators;

    WriteLn;

    FightBattleWithOneResolveCall;

    Writeln;

    MakeCarGo;

   // Note, the routine below will raise an exception (as designed)
   // PassNilToPayroll;

    Writeln;

    BeACowboy;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  ReadLn;
end.
