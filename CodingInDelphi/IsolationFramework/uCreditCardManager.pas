unit uCreditCardManager;

interface

uses
      uCreditCardValidator
    , SysUtils
    ;

type
  TCreditCardManager = class
  private
    FCCValidator: ICreditCardValidator;
  public
    constructor Create(aCCValidator: ICreditCardValidator);
    function CreditCardIsValid(aCCString: string): Boolean;
    function ProcessCreditCard(aCCString: string; aAmount: Double): Double;
  end;

  EBadCreditCard = class(Exception);

implementation

function TCreditCardManager.CreditCardIsValid(aCCString: string): Boolean;
begin
  inherited;
  Result := FCCValidator.IsCreditCardValid(aCCString);
end;

function TCreditCardManager.ProcessCreditCard(aCCString: string; aAmount: Double): Double;
begin
  if CreditCardIsValid(aCCString) then
  begin
    // Charge the card
    Result := aAmount;
  end else
  begin
    Result := 0.0;
  end;
end;

constructor TCreditCardManager.Create(aCCValidator: ICreditCardValidator);
begin
  inherited Create;
  FCCValidator := aCCValidator;
end;

end.
