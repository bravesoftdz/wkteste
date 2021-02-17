unit uOrderItem;

interface

type
  TOrderItem = class
  private
    FProductName: string;
    FPrice: Double;
    FTotal: Double;
    FQuantity: Integer;
    FProductId: Integer;
    function GetTotal: Double;
  public
    property ProductId: Integer read FProductId write FProductId;
    property ProductName: string read FProductName write FProductName;
    property Quantity: Integer read FQuantity write FQuantity;
    property Price: Double read FPrice write FPrice;
    property Total: Double read GetTotal;
  end;

implementation

{ OrderItem }

function TOrderItem.GetTotal: Double;
begin
  result := FQuantity * FPrice;
end;

end.
