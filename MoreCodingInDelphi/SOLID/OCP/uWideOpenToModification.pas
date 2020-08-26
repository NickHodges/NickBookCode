unit uWideOpenToModification;

interface

uses
     Spring.Collections
   ;

type

  TItemType = (Normal, TenPercentOff, BOGO, TwentyPercentOFf);

  TItem = record
    SKU: string;
    Quantity: integer;
    Price: double;
    ItemType: TItemType;
  end;

  TOrder = class
  private
    FListOfItems: IList<TItem>;
    function GetListOfItems: IEnumerable<TItem>;
  public
    procedure Add(aItem: TItem);
    function TotalAmount: Double;
    property Items: IEnumerable<TItem> read GetListOfItems;
  end;

implementation

{ TOrder }

procedure TOrder.Add(aItem: TItem);
begin
  FListOfItems.Add(aItem);
end;

function TOrder.GetListOfItems: IEnumerable<TItem>;
begin
  Result := FListOfItems;
end;

function TOrder.TotalAmount: Double;
var
  Item: TItem;
  LQuantity: integer;
begin
  for Item in FListOfItems do
  begin
    case Item.ItemType of
      Normal:        begin
                       Result := (Item.Price * Item.Quantity);
                     end;
      TenPercentOff: begin
                       Result :=(Item.Price * 0.90 * Item.Quantity);
                     end;
      BOGO:          begin
                       LQuantity := Item.Quantity * 2;
                       Result :=  Item.Price * LQuantity;
                     end;

      // More things coming!

    end;
  end;
end;

end.
