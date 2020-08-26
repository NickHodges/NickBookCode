program CustomerAdapter;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uCustomerAdapter in 'uCustomerAdapter.pas';

var
  OldCustomer: IOldCustomer;
  NewCustomerAdapter: INewCustomer;

procedure OutputNewCustomer(aCustomer: INewCustomer);
begin
  WriteLn('First Name: ', aCustomer.FirstName);
  WriteLn('Last Name: ', aCustomer.LastName);
  WriteLn('DOB: ', DateToStr(aCustomer.DateOfBirth));
end;

begin
  try
    OldCustomer := TOldCustomer.Create('Marvin Martian', 1945, 12, 25);

    NewCustomerAdapter := TCustomerAdapter.Create(OldCustomer);

    OutputNewCustomer(NewCustomerAdapter);

    ReadLn;


  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
