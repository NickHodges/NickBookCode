unit nxAttributes;

interface

type

  TDisplayTextAttribute = class(TCustomAttribute)
  private
    FDisplayText: string;
  public
    constructor Create(aDisplayText: string);
    property DisplayText: string read FDisplayText write FDisplayText;
  end;

implementation

constructor TDisplayTextAttribute.Create(aDisplayText: string);
begin
  FDisplayText := aDisplayText;
end;



end.
