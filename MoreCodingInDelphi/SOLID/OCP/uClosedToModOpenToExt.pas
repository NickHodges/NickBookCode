unit uClosedToModOpenToExt;

interface

uses
     Spring.Collections
   ;

type
  IItemPricer = interface;

  TItem = record
    SKU: string;
    Price: double;
    Quantity: integer;
    Rule: IItemPricer;
    constructor Create(aSKU: string; aPrice: Double; aQuantity: integer; aRule: IItemPricer);
  end;

  IItemPricer = interface
    function CalculatePrice(aItem: TItem): Double;
  end;

  TNormalPricer = class(TInterfacedObject, IItemPricer)
    function CalculatePrice(aItem: TItem): Double;
  end;

  TTenPercentOffPricer = class(TInterfacedObject, IItemPricer)
    function CalculatePrice(aItem: TItem): Double;
  end;

  TBOGOFreePricer = class(TInterfacedObject, IItemPricer)
    function CalculatePrice(aItem: TItem): Double;
  end;

  TTwentyPercentOffPricer = class(TInterfacedObject, IItemPricer)
    function CalculatePrice(aItem: TItem): Double;
  end;

  TOrder = class
  private
    FListOfItems: IList<TItem>;
    function GetListOfItems: IEnumerable<TItem>;
  public
    procedure Add(aItem: TItem);
    function TotalAmount: Double;
    property Items: IEnumerable<TItem> read GetListOfItems;
    constructor Create;
  end;

implementation

{ TOrder }

procedure TOrder.Add(aItem: TItem);
begin
  FListOfItems.Add(aItem)
end;

constructor TOrder.Create;
begin
  inherited Create;
  FListOfItems := TCollections.CreateList<TItem>;
end;

function TOrder.GetListOfItems: IEnumerable<TItem>;
begin
  Result := FListOfItems;
end;

function TOrder.TotalAmount: Double;
var
  Item: TItem;
begin
  Result := 0.0;
  for Item in Items do
  begin
    Result := Result + Item.Rule.CalculatePrice(Item);
  end;
end;

{ TTenPercentOffPricer }

function TTenPercentOffPricer.CalculatePrice(aItem: TItem): Double;
begin
  Result := aItem.Quantity * aItem.Price * 0.90;
end;

{ TBOGOFreePricer }

function TBOGOFreePricer.CalculatePrice(aItem: TItem): Double;
begin
  Result := aItem.Price * 0.50 * aItem.Quantity;
end;

{ TNormalPricer }

function TNormalPricer.CalculatePrice(aItem: TItem): Double;
begin
  Result := aItem.Price * aItem.Quantity;
end;

{ TItem }

constructor TItem.Create(aSKU: string; aPrice: Double; aQuantity: integer; aRule: IItemPricer);
begin
  SKU := aSKU;
  Price := aPrice;
  Quantity := aQuantity;
  Rule := aRule;
end;

{ TTwentyPercentOffPricer }

function TTwentyPercentOffPricer.CalculatePrice(aItem: TItem): Double;
begin
  Result := aItem.Price * 0.8;
end;

end.
