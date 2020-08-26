unit uCreditCardValidator;

interface

uses
      SysUtils;

type

  ICreditCardValidator = interface(IInvokable)
  ['{68553321-248C-4FD4-9881-C6B6B92B95AD}']
    function IsCreditCardValid(aCreditCardNumber: string): Boolean;
    procedure DoNotCallThisEver;
  end;

  TCreditCardValidator = class(TInterfacedObject, ICreditCardValidator)
    function IsCreditCardValid(aCreditCardNumber: string): Boolean;
    procedure DoNotCallThisEver;
  end;

  ECreditCardValidatorException = class(Exception);

implementation

uses
     Dialogs;


function TCreditCardValidator.IsCreditCardValid(aCreditCardNumber: string): Boolean;
begin
  // Let's pretend this calls a SOAP server that charges $0.25 everytime
  // you use it.

  // For Demo purposes, we'll have the card be invalid if it the number 7 in it
  Result := Pos('7', aCreditCardNumber) <= 0;
  WriteLn('Ka-Ching! You were just charged $0.25');
  if not Result then
  begin
    raise ECreditCardValidatorException.Create('Bad Credit Card!  Do not accept!');
  end;
end;

procedure TCreditCardValidator.DoNotCallThisEver;
begin
  // This one will charge the company $500!  We should never
  // call this!
end;

end.
