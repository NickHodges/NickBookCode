unit uOverInjection;

interface

type
  IBankingServices = interface
  ['{E367001A-94D1-4694-A0B9-FB0B3FD822ED}']
    procedure DoBankingStuff;
  end;

  ISnailMailingServices = interface
  ['{ED17BB98-CC8C-4DBF-9466-C20F6BBC4AE2}']
    procedure SnailMailPayrollInfo;
  end;

  IEmailingServices = interface
  ['{44F1C185-66FB-4103-A498-58BA4BF589DF}']
    procedure EmailPayrollInfo;
  end;

  TEmployee = class(TObject)
  private
    FLastName: string;
    FFirstName: string;
    FWantsMail: Boolean;
  public
    property WantsMail: Boolean read FWantsMail write FWantsMail;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
  end;

  TSnailMailingServices = class(TInterfacedObject, ISnailMailingServices)
    procedure SnailMailPayrollInfo;
  end;

  TEmailingServices = class(TInterfacedObject, IEmailingServices)
    procedure EmailPayrollInfo;
  end;

  TBankingServices = class(TInterfacedObject, IBankingServices)
    procedure DoBankingStuff;
  end;

  TPayrollSystem = class
  private
    FBankingServices: IBankingServices;
    FSnailMailingServices: ISnailMailingServices;
    FEmailingServices: IEmailingServices;
  public
    constructor Create(aBankingServices: IBankingServices; aSnailMailingServices: ISnailMailingServices; aEmailingServices: IEmailingServices);
    procedure DoPayroll(aEmployee: TEmployee);
  end;

implementation

constructor TPayrollSystem.Create(aBankingServices: IBankingServices; aSnailMailingServices: ISnailMailingServices; aEmailingServices: IEmailingServices);
begin
  FBankingServices := aBankingServices;
  FSnailMailingServices := aSnailMailingServices;
  FEmailingServices := aEmailingServices;
end;

procedure TPayrollSystem.DoPayroll(aEmployee: TEmployee);
begin
  Writeln('Doing Payroll');
  if aEmployee.WantsMail then
  begin
    FSnailMailingServices.SnailMailPayrollInfo;
  end else
  begin
    FEmailingServices.EmailPayrollInfo;
  end;
end;

procedure TBankingServices.DoBankingStuff;
begin
  Writeln('Doing banking stuff');
end;

procedure TSnailMailingServices.SnailMailPayrollInfo;
begin
  Writeln('Mail out payroll information');
end;

procedure TEmailingServices.EmailPayrollInfo;
begin
  Writeln('Emailing Payroll Info');
end;

end.

