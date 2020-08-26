unit uSimpleConstructorInjection;

interface


type

  TBankingServices = class

  end;

  TPayrollSystem = class
  private
    FBankingServices: TBankingServices;
  public
    constructor Create(aBankingServices: TBankingServices);
    procedure DoPayroll;
  end;

procedure PassNilToPayroll;

implementation

uses
      Spring
    ;

procedure PassNilToPayroll;
var
  PayrollSystem: TPayrollSystem;
begin
  PayrollSystem := TPayrollSystem.Create(nil);
  try
    PayrollSystem.DoPayroll;
  finally
    PayrollSystem.Free;
  end;
end;

constructor TPayrollSystem.Create(aBankingServices: TBankingServices);
begin
  Guard.CheckNotNull(aBankingServices, 'aBankingServices');
  FBankingServices := aBankingServices;
end;

procedure TPayrollSystem.DoPayroll;
begin
  Writeln('Doing Payroll');
end;

end.
