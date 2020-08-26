unit uSimpleStubDemo;

interface

type
  ILogger = interface(IInvokable)
  ['{B571A28D-A576-4C83-A0D3-CB211435CDEA}']
    procedure Log(aString: string);
  end;

  TDollarToGalleonsConverter = class
  private
    FLogger: ILogger;
  public
    constructor Create(aLogger: ILogger);
    function ConvertDollarsToGalleons(aDollars: Double; aExchangeRate: Double): Double;
  end;

implementation

uses
   SysUtils;


{ TDollarToGalleonsConverter }

function TDollarToGalleonsConverter.ConvertDollarsToGalleons(aDollars, aExchangeRate: Double): Double;
var
  LogMessage: string;
begin
  Result := aDollars * aExchangeRate;
  LogMessage := Format('Converted %f dollars to %f Galleons', [aDollars, Result]);
  FLogger.Log(LogMessage);
end;

constructor TDollarToGalleonsConverter.Create(aLogger: ILogger);
begin
  inherited Create;
  FLogger := aLogger;
end;

end.
